import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:print_house/screens/admin/orders_data.dart';
import 'package:print_house/screens/login_page.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LoginScreen(),
    );
  }
}
