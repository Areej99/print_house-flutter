import 'package:flutter/material.dart';
import 'package:print_house/components/repeatitive_operations.dart';

class GiftCard extends StatefulWidget {
  GiftCard(
      {this.address, this.num, this.url, this.userEmail, this.name, this.id});
  final String userEmail;
  final String address;
  final String name;
  final String url;
  final int num;
  final String id;
  @override
  _GiftCardState createState() => _GiftCardState();
}

class _GiftCardState extends State<GiftCard> {
  // var showSpinner = false;
  // var bodyBytes;
  // downloadFile() async {
  //   setState(() {
  //     showSpinner = true;
  //   });
  //   final http.Response downloadData = await http.get(widget.url);
  //   setState(() {
  //     bodyBytes = downloadData.bodyBytes;
  //   });
  //   if (bodyBytes != null) {
  //     setState(() {
  //       showSpinner = false;
  //     });
  //   }
  // }
  //
  // @override
  // void initState() {
  //   downloadFile();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(40),
       ),
      child: Card(
        margin: EdgeInsets.all(15.0),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Image.network(src),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.userEmail,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.pink.shade900),
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

              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Image.network(
                    widget.url,
                    height: 200,
                    width: 250,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              RepeatitiveOperations(
                name: widget.name,
                collectionName: 'gifts',
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
