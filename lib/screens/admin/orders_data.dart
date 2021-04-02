import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:print_house/components/constants.dart';
import 'package:print_house/components/files-card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:print_house/components/gift_card.dart';
import 'package:print_house/components/shield_card.dart';
import 'package:print_house/components/tshirt_card.dart';

final _firestoreVar = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class OrdersData extends StatefulWidget {
  OrdersData({this.collectionName});
  final String collectionName;

  @override
  _OrdersDataState createState() => _OrdersDataState();
}

class _OrdersDataState extends State<OrdersData> {
  int listLength;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: kAppBarDecoration,
        title: Text(widget.collectionName),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestoreVar.collection(widget.collectionName).snapshots(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlue,
                ),
              );
            }

            switch (widget.collectionName) {
              case 'files':
                {
                  final data =
                      snapshot.data.docs.reversed; //gets the last orders
                  List<FilesCard> filesData = [];
                  for (var orders in data) {
                    final copies = orders.data()['copies'];
                    final type = orders.data()['type'];
                    final size = orders.data()['size'];
                    final address = orders.data()['address'];
                    final url = orders.data()['url'];
                    final user = orders.data()['uid'];
                    final name = orders.data()['name'];

                    final fileCard = FilesCard(
                        size: size,
                        address: address,
                        url: url,
                        num: copies,
                        type: type,
                        userEmail: user,
                        name: name,
                        id: orders.id);

                    filesData.add(fileCard);
                  }
                  listLength = filesData.length;
                  return (listLength == 0)
                      ? Center(child: Text('no orders yet ..'))
                      : ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          children: filesData,
                        );
                }
                break;
              case 'tshirts':
                {
                  final data =
                      snapshot.data.docs.reversed; //gets the last orders
                  List<TShirtsCard> tshirtsData = [];
                  for (var orders in data) {
                    final copies = orders.data()['copies'];
                    final address = orders.data()['address'];
                    final url = orders.data()['url'];
                    final user = orders.data()['uid'];
                    final name = orders.data()['name'];
                    final extension = orders.data()['extension'];

                    final tshirtCard = TShirtsCard(
                        userEmail: user,
                        num: copies,
                        url: url,
                        address: address,
                        name: name,
                        extension: extension,
                        id: orders.id);

                    tshirtsData.add(tshirtCard);
                  }
                  listLength = tshirtsData.length;
                  return (listLength == 0)
                      ? Center(child: Text('no orders yet ..'))
                      : ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          children: tshirtsData,
                        );
                }
                break;
              case 'gifts':
                {
                  final data =
                      snapshot.data.docs.reversed; //gets the last orders
                  List<GiftCard> giftsData = [];
                  for (var orders in data) {
                    final copies = orders.data()['copies'];
                    final address = orders.data()['address'];
                    final url = orders.data()['url'];
                    final user = orders.data()['uid'];
                    final fileName = orders.data()['filename'];

                    final giftCard = GiftCard(
                      userEmail: user,
                      num: copies,
                      url: url,
                      address: address,
                      name: fileName,
                      id: orders.id,
                    );

                    giftsData.add(giftCard);
                  }
                  listLength = giftsData.length;
                  return (listLength == 0)
                      ? Center(child: Text('no orders yet ..'))
                      : ListView(
                          shrinkWrap: true, //to scroll to the new orders
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          children: giftsData,
                        );
                }
                break;
              case 'shields':
                {
                  final data =
                      snapshot.data.docs.reversed; //gets the last orders
                  List<ShieldsCard> shieldsData = [];
                  for (var orders in data) {
                    final script = orders.data()['script'];
                    final address = orders.data()['address'];
                    final model = orders.data()['model'];
                    final user = orders.data()['uid'];

                    final shieldCard = ShieldsCard(
                        address: address,
                        userEmail: user,
                        model: model,
                        script: script,
                        id: orders.id);

                    shieldsData.add(shieldCard);
                  }
                  listLength = shieldsData.length;
                  return (listLength == 0)
                      ? Center(child: Text('no orders yet ..'))
                      : ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          children: shieldsData,
                        );
                }
                break;
            }
            //fluutter async snapshot //builder rebuilds the ui with info we provide
          }),
    );
  }
}
