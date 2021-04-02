import 'dart:io' as io; //"i" also can be another char or word, is just an example
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'components/constants.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _fireStoreVar = FirebaseFirestore.instance;

  PlatformFile _path;
  FileType _pickingType = FileType.any;
  var path;
  String name ;



  void _openFileExplorer() async {
    try {
      _path = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: false,
      ))
          ?.files as PlatformFile;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {

    });
  }
  String copiesNum;
  String address;

  @override
  Widget build(BuildContext context) {
    _pickingType=FileType.image;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
        flexibleSpace: kAppBarDecoration,
        centerTitle: true,
        title: Text(
        'Gifts',
        style: TextStyle(color: Colors.white70, fontSize: 35),
    ),
    ),
    body:SafeArea(
      child: Builder(
        builder: (BuildContext context) => Container(
          padding: const EdgeInsets.only(top: 10.0),
          height:240,
          child: Scrollbar(
              child: ListView.separated(
                itemCount:1,
                itemBuilder:
                    (BuildContext context, int index) {


                  return Column(
                    children: [
                      Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              (_path!=null) ?
                              Image.file(io.File(_path.toString()) , height: 150, width: 400,) : Image.asset('images/gifts.jpeg'),
                              GestureDetector(
                                onTap: (){
                                  _openFileExplorer();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Add Photo',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          decoration: TextDecoration.underline),
                                    ),
                                    SizedBox(width: 5,),
                                    CircleAvatar(
                                        radius: 7,
                                        backgroundColor: Colors.red,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 13,
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Icon(Icons.image , size: 25,),
                                    (_path!=null) ? Text(_path.name,style: TextStyle(fontSize: 20),):Text('file name',style: TextStyle(fontSize: 20),) ,
                                    SizedBox(width: 15,),
                                    GestureDetector(onTap: (){
                                      setState(() {
                                        _path=null;
                                        name='';
                                        path='';
                                      });
                                    },child: Icon(Icons.delete , size: 25,)),
                                  ],),
                              )
                            ],
                          )),
                    ],
                  ) ;
                },
                separatorBuilder:
                    (BuildContext context, int index) =>
                const Divider(height: 1,),
              )),
        )
      ),
    ) ,
    );
  }
}




///////////////////////////////////////////////////////////////////////////////

// class FilePickerDemo extends StatefulWidget {
//   @override
//   _FilePickerDemoState createState() => _FilePickerDemoState();
// }
//
// class _FilePickerDemoState extends State<FilePickerDemo> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   String _fileName;
//   List<PlatformFile> _paths;
//   List<String> _extension;
//   bool _loadingPath = false;
//   bool _multiPick = false;
//   FileType _pickingType = FileType.any;
//   TextEditingController _controller = TextEditingController();
//   var path;
//   String name ;
//
//   @override
//   void initState() {
//     super.initState();
//     //_controller.addListener(() => _extension = _controller.text);
//   }
//
//   void _openFileExplorer() async {
//     setState(() => _loadingPath = true);
//     try {
//       _paths = (await FilePicker.platform.pickFiles(
//         type: _pickingType,
//         allowMultiple: _multiPick,
//         allowedExtensions: (_extension)
//       ))
//           ?.files;
//     } on PlatformException catch (e) {
//       print("Unsupported operation" + e.toString());
//     } catch (ex) {
//       print(ex);
//     }
//     if (!mounted) return;
//     setState(() {
//       _loadingPath = false;
//       _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
//      // // name =  _fileName ??'....';
//      // //  path = _paths != null ? _paths
//      //                                .map((e) => e.path)
//      //                                .toList()[0]
//      //                                .toString() : '...';
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _pickingType=FileType.custom;
//     _extension=['pdf','png','jpg'];
//     _multiPick=false;
//     return MaterialApp(
//       home: Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           title: const Text('File Picker example app'),
//         ),
//         body: Center(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     //picking type  _pickingType=FileType.custom / image
//                     // allowed extentions  (pdf , png , jpg , jpeg)
//                     //_multiPick=true;
//
//
//                     Padding(
//                       padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
//                       child: Column(
//                         children: <Widget>[
//                           RaisedButton(
//                             onPressed: () => _openFileExplorer(),
//                             child: Text("Open file picker"),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Builder(
//                       builder: (BuildContext context) => _loadingPath
//                           ? Padding(
//                         padding: const EdgeInsets.only(bottom: 10.0),
//                         child: const CircularProgressIndicator(),
//                       )
//                           : _paths != null
//                           ? Container(
//                         padding: const EdgeInsets.only(bottom: 30.0),
//                         height:
//                         MediaQuery.of(context).size.height * 0.50,
//                         child: Scrollbar(
//                             child: ListView.separated(
//                               itemCount:
//                               _paths != null && _paths.isNotEmpty
//                                   ? _paths.length
//                                   : 1,
//                               itemBuilder:
//                                   (BuildContext context, int index) {
//                                 final bool isMultiPath =
//                                     _paths != null && _paths.isNotEmpty;
//                                 final String name = 'File name:' +
//                                     (isMultiPath
//                                         ? _paths
//                                         .map((e) => e.name)
//                                         .toList()[index]
//                                         : _fileName ?? '...');
//                                  path = _paths
//                                     .map((e) => e.path)
//                                     .toList()[index]
//                                     .toString();
//
//                                 return Column(
//                                   children: [
//                                     Text(name),
//                                     SizedBox(height: 20,),
//                                     Image.file(io.File(path) , height: 200, width: 400,)
//                                   ],
//                                 );
//                               },
//                               separatorBuilder:
//                                   (BuildContext context, int index) =>
//                               const Divider(),
//                             )),
//                       ): SizedBox(),
//                     ),
//
//                   ],
//                 ),
//               ),
//             )),
//       ),
//     );
//   }
// }

///////////////////////////////////////////////////////////////////////////////////////////////////

//import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:file_picker/file_picker.dart';
//
// class FilePickerDemo extends StatefulWidget {
//   @override
//   _FilePickerDemoState createState() => _FilePickerDemoState();
// }
//
// class _FilePickerDemoState extends State<FilePickerDemo> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   String _fileName;
//   List<PlatformFile> _paths;
//   String _directoryPath;
//   String _extension;
//   bool _loadingPath = false;
//   bool _multiPick = false;
//   FileType _pickingType = FileType.any;
//   TextEditingController _controller = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() => _extension = _controller.text);
//   }
//
//   void _openFileExplorer() async {
//     setState(() => _loadingPath = true);
//     try {
//       _directoryPath = null;
//       _paths = (await FilePicker.platform.pickFiles(
//         type: _pickingType,
//         allowMultiple: _multiPick,
//         allowedExtensions: (_extension?.isNotEmpty ?? false)
//             ? _extension?.replaceAll(' ', '')?.split(',')
//             : null,
//       ))
//           ?.files;
//     } on PlatformException catch (e) {
//       print("Unsupported operation" + e.toString());
//     } catch (ex) {
//       print(ex);
//     }
//     if (!mounted) return;
//     setState(() {
//       _loadingPath = false;
//       _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
//     });
//   }
//
//   void _clearCachedFiles() {
//     FilePicker.platform.clearTemporaryFiles().then((result) {
//       _scaffoldKey.currentState.showSnackBar(
//         SnackBar(
//           backgroundColor: result ? Colors.green : Colors.red,
//           content: Text((result
//               ? 'Temporary files removed with success.'
//               : 'Failed to clean temporary files')),
//         ),
//       );
//     });
//   }
//
//   void _selectFolder() {
//     FilePicker.platform.getDirectoryPath().then((value) {
//       setState(() => _directoryPath = value);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           title: const Text('File Picker example app'),
//         ),
//         body: Center(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20.0),
//                       child: DropdownButton(
//                           hint: Text('LOAD PATH FROM'),
//                           value: _pickingType,
//                           items: <DropdownMenuItem>[
//                             DropdownMenuItem(
//                               child: Text('FROM AUDIO'),
//                               value: FileType.audio,
//                             ),
//                             DropdownMenuItem(
//                               child: Text('FROM IMAGE'),
//                               value: FileType.image,
//                             ),
//                             DropdownMenuItem(
//                               child: Text('FROM VIDEO'),
//                               value: FileType.video,
//                             ),
//                             DropdownMenuItem(
//                               child: Text('FROM MEDIA'),
//                               value: FileType.media,
//                             ),
//                             DropdownMenuItem(
//                               child: Text('FROM ANY'),
//                               value: FileType.any,
//                             ),
//                             DropdownMenuItem(
//                               child: Text('CUSTOM FORMAT'),
//                               value: FileType.custom,
//                             ),
//                           ],
//                           onChanged: (value) => setState(() {
//                             _pickingType = value;
//                             if (_pickingType != FileType.custom) {
//                               _controller.text = _extension = '';
//                             }
//                           })),
//                     ),
//                     ConstrainedBox(
//                       constraints: const BoxConstraints.tightFor(width: 100.0),
//                       child: _pickingType == FileType.custom
//                           ? TextFormField(
//                         maxLength: 15,
//                         autovalidate: true,
//                         controller: _controller,
//                         decoration:
//                         InputDecoration(labelText: 'File extension'),
//                         keyboardType: TextInputType.text,
//                         textCapitalization: TextCapitalization.none,
//                       )
//                           : const SizedBox(),
//                     ),
//                     ConstrainedBox(
//                       constraints: const BoxConstraints.tightFor(width: 200.0),
//                       child: SwitchListTile.adaptive(
//                         title:
//                         Text('Pick multiple files', textAlign: TextAlign.right),
//                         onChanged: (bool value) =>
//                             setState(() => _multiPick = value),
//                         value: _multiPick,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
//                       child: Column(
//                         children: <Widget>[
//                           RaisedButton(
//                             onPressed: () => _openFileExplorer(),
//                             child: Text("Open file picker"),
//                           ),
//                           RaisedButton(
//                             onPressed: () => _selectFolder(),
//                             child: Text("Pick folder"),
//                           ),
//                           RaisedButton(
//                             onPressed: () => _clearCachedFiles(),
//                             child: Text("Clear temporary files"),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Builder(
//                       builder: (BuildContext context) => _loadingPath
//                           ? Padding(
//                         padding: const EdgeInsets.only(bottom: 10.0),
//                         child: const CircularProgressIndicator(),
//                       )
//                           : _directoryPath != null
//                           ? ListTile(
//                         title: Text('Directory path'),
//                         subtitle: Text(_directoryPath),
//                       )
//                           : _paths != null
//                           ? Container(
//                         padding: const EdgeInsets.only(bottom: 30.0),
//                         height:
//                         MediaQuery.of(context).size.height * 0.50,
//                         child: Scrollbar(
//                             child: ListView.separated(
//                               itemCount:
//                               _paths != null && _paths.isNotEmpty
//                                   ? _paths.length
//                                   : 1,
//                               itemBuilder:
//                                   (BuildContext context, int index) {
//                                 final bool isMultiPath =
//                                     _paths != null && _paths.isNotEmpty;
//                                 final String name = 'File $index: ' +
//                                     (isMultiPath
//                                         ? _paths
//                                         .map((e) => e.name)
//                                         .toList()[index]
//                                         : _fileName ?? '...');
//                                 final path = _paths
//                                     .map((e) => e.path)
//                                     .toList()[index]
//                                     .toString();
//
//                                 return ListTile(
//                                   title: Text(
//                                     name,
//                                   ),
//                                   subtitle: Text(path),
//                                 );
//                               },
//                               separatorBuilder:
//                                   (BuildContext context, int index) =>
//                               const Divider(),
//                             )),
//                       )
//                           : const SizedBox(),
//                     ),
//                   ],
//                 ),
//               ),
//             )),
//       ),
//     );
//   }
// }