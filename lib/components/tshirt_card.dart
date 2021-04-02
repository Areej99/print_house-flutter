import 'package:flutter/material.dart';
import 'package:print_house/components/repeatitive_operations.dart';

class TShirtsCard extends StatefulWidget {
  TShirtsCard(
      {this.address,
      this.num,
      this.url,
      this.userEmail,
      this.extension,
      this.name,
      this.id});
  final String userEmail;
  final String address;
  final String url;
  final String extension;
  final String name;
  final String id;
  final int num;

  @override
  _TShirtsCardState createState() => _TShirtsCardState();
}

class _TShirtsCardState extends State<TShirtsCard> {
  // var showSpinner = false;
  // var bodyBytes;
  // downloadFile() async {
  //   final http.Response downloadData = await http.get(widget.url);
  //   setState(() {
  //     bodyBytes = downloadData.bodyBytes;
  //     showSpinner = false;
  //   });
  // }
  //
  // @override
  // void initState() {
  //   if (widget.extension != 'pdf') {
  //     setState(() {
  //       showSpinner = true;
  //     });
  //   //  downloadFile();
  //   }
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.userEmail,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.pink.shade900),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Number of copies:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.num.toString(),
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      "Address:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.address,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                    ),
                  ],
                ),
              ),

              (widget.extension == 'pdf')
                  ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      "File name:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15),
                    ),
                  ],
                ),
              )
                  : Column(
                    children: [
                SizedBox(
                height: 20,
              ),
                      Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Image.network(widget.url,height: 200,width: 270,)
                              ],
                            ),
                    ],
                  ),

              SizedBox(
                height: 20,
              ),
              RepeatitiveOperations(
                name: widget.name,
                collectionName: 'tshirts',
                url: widget.url,
                id: widget.id,
                email: widget.userEmail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
