import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
class UpDownLoad extends StatefulWidget {
  @override
  _UpDownLoadState createState() => _UpDownLoadState();
}

class _UpDownLoadState extends State<UpDownLoad> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  String path;
  String name;
  FileType pickType = FileType.custom;
  List<StorageUploadTask> tasks = <StorageUploadTask>[];
  String _extension ;
  PlatformFile file;
  String url;
  var dio = Dio();

  openFileExplorer() async {
    try {
      FilePickerResult files = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["pdf","jpg","png"]
      ));

      file = files.files.first;
      path = file.path;
      name=file.name;
      print("-------------------------------------------------" + name);
    } on PlatformException catch (e) {
      print("failed ---------------------------------------- " + e.toString());
    }
    if (!mounted) {
      return;
    }
    setState(() {
      var one = 1;
    });
  }

  uploadToFirebase(fileName, filePath) async {
    _extension=fileName.toString().split('.').last;
    StorageReference storageReference = FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask = storageReference.putFile(File(filePath),StorageMetadata(
      contentType: '$pickType/$_extension'
    ));
    setState(() {
     tasks.add(uploadTask);
    });
    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = dowurl.toString();

  }

  downloadFile(String url) async {

    final http.Response downloadData = await http.get(url);

    var bodyBytes = downloadData.bodyBytes;

    final String ex = name.split('.').last;

    _scaffoldkey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: ex=='pdf' ? Text(name,style: TextStyle(color: Colors.blue),) : Image.memory(
          bodyBytes,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(title: Text("try")),
      body: ListView(
        shrinkWrap: true,
        children: [
          FlatButton(
              child: Text("pick"),
              onPressed: () async {
                openFileExplorer();
              }),
          FlatButton(
            child: Text("upload"),
            onPressed: () {
              uploadToFirebase(name, path);
            },
          ),
          //Builder(builder: (context) => Container(height:40,width: 200,child: ListView.separated(itemBuilder: (context, index) => path!=null ?  Text(path):Text("hahaha"), separatorBuilder: (context, index) => SizedBox(height: 10,), itemCount: 2)),),
          FlatButton(
            child: Text("download"),
            onPressed: () {
              downloadFile(url);
            },
          ),

          FlatButton(
            child: Text("download to device"),
            onPressed: () async{
             final exDirectory =await ExtStorage.getExternalStoragePublicDirectory(
                 ExtStorage.DIRECTORY_DOWNLOADS);
             final status =  await Permission.storage.request();
   try{
      Response response = await dio.get(url , options: Options(
        responseType: ResponseType.bytes
      ));
      File file = File("$exDirectory/$name");
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

    }
    catch(e){
     print (e);
     //snackbar;
    }


            },
          ),
        ],
      ),
    );
  }
}
