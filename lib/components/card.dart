import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoiceCard extends StatelessWidget {
  ChoiceCard({this.name, this.imagePath,this.onTap});
  final String imagePath;
  final String name;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Card(
          elevation: 15.0,
          child: Column(
            children: [
              Image.asset(imagePath),
              SizedBox(
                height: 15,
              ),
              Text(
                name,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
