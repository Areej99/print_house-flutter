import 'package:flutter/material.dart';
import 'package:print_house/components/repeatitive_operations.dart';

class FilesCard extends StatelessWidget {
  FilesCard(
      {this.address,
      this.num,
      this.url,
      this.size,
      this.userEmail,
      this.type,
      this.name,
      this.id});

  final String userEmail;
  final String address;
  final String type;
  final String size;
  final String url;
  final int num;
  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Card(
        elevation: 10.0,
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
                    userEmail,
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
                    num.toString(),
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Print type:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    type,
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Print size:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    size,
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
                      address,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      "File name:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RepeatitiveOperations(
                name: name,
                collectionName: 'files',
                url: url,
                id: id,
                email: userEmail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
