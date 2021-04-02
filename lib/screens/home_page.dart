import 'package:flutter/material.dart';
import 'file:///D:/projects/print_house/lib/screens/customer/files.dart';
import 'file:///D:/projects/print_house/lib/screens/customer/sheilds.dart';
import 'file:///D:/projects/print_house/lib/screens/customer/t_shirts.dart';
import 'package:print_house/components/card.dart';
import 'package:print_house/components/constants.dart';
import 'file:///D:/projects/print_house/lib/screens/customer/chat_screen.dart';
import 'file:///D:/projects/print_house/lib/screens/customer/gifts.dart';
import 'admin/orders_data.dart';

class HomePage extends StatelessWidget {
  HomePage({this.isAdmin});
  final bool isAdmin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        // leading:
        actions: [(!isAdmin)
          ? GestureDetector(
        child: Icon(
          Icons.chat,
          color: Colors.white,
          size: 30,
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(),
              ));
        },
      )
          : Container()],
        flexibleSpace: kAppBarDecoration,
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: ChoiceCard(
                      imagePath: 'images/files.jpeg',
                      name: 'Files',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return (!isAdmin)
                                ? Files()
                                : OrdersData(
                                    collectionName: 'files',
                                  );
                          },
                        ));
                      },
                    ),
                  ),
                  Expanded(
                    child: ChoiceCard(
                      imagePath: 'images/gifts.jpeg',
                      name: 'Gifts',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return (!isAdmin)
                                ? Gifts()
                                : OrdersData(
                                    collectionName: 'gifts',
                                  );
                          },
                        ));
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            //---------------------------------------
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: ChoiceCard(
                      imagePath: 'images/tshirts.jpeg',
                      name: 'T-Shirts',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return (!isAdmin)
                                ? Tshirts()
                                : OrdersData(
                                    collectionName: 'tshirts',
                                  );
                          },
                        ));
                      },
                    ),
                  ),
                  Expanded(
                    child: ChoiceCard(
                      imagePath: 'images/sheilds.jpeg',
                      name: 'Shields',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return (!isAdmin)
                                ? Shields()
                                : OrdersData(
                                    collectionName: 'shields',
                                  );
                          },
                        ));
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            //------------------------------------------
          ],
        ),
      ),
    );
  }
}

// SafeArea(
// child: ListView(
// padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
// shrinkWrap: true,
// children: [
// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// GridView.count(
// shrinkWrap: true,
// crossAxisCount: 2,
// children: [
// GestureDetector(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) {
// return Gifts();
// },
// ),
// );
// },
// child: ChoiceCard(
// imagePath: 'images/gifts.jpeg',
// name: 'Gifts',
// ),
// ),
// GestureDetector(
// onTap: () {
// Navigator.push(context, MaterialPageRoute(
// builder: (context) {
// return Files();
// },
// ));
// },
// child: ChoiceCard(
// imagePath: 'images/files.jpeg',
// name: 'Files',
// ),
// ),
// GestureDetector(
// onTap: () {
// Navigator.push(context, MaterialPageRoute(
// builder: (context) {
// return Tshirts();
// },
// ));
// },
// child: ChoiceCard(
// imagePath: 'images/tshirts.jpeg',
// name: 'T-shirts',
// ),
// ),
// GestureDetector(
// onTap: () {
// Navigator.push(context, MaterialPageRoute(
// builder: (context) {
// return Shields();
// },
// ));
// },
// child: ChoiceCard(
// imagePath: 'images/sheilds.jpeg',
// name: 'Sheilds',
// ),
// ),
// ],
// padding: EdgeInsets.all(15),
// crossAxisSpacing: 10,
// mainAxisSpacing: 70,
// childAspectRatio: 0.7,
// ),
// SizedBox(
// height: 40,
// ),
// ],
// ),
// ],
// ),
// // child: ListView(
// //   shrinkWrap: true,
// //   children: getList(),
// // ),
// ),
