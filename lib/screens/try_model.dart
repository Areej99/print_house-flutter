// import 'package:flutter/material.dart';
// import 'package:print_house/flutter_cube.dart';
// import 'package:vector_math/vector_math_64.dart' hide Colors;
// import 'package:print_house/components/constants.dart';
// class Model3D extends StatefulWidget {
//   Model3D({this.model});
//   final String model;
//   @override
//   _Model3DState createState() => _Model3DState();
// }
//
// class _Model3DState extends State<Model3D> {
//   Scene _scene;
//   Object _model;
//
//   void _onSceneCreated(Scene scene) {
//     _scene = scene;
//     scene.camera.position.z =12;
//     scene.camera.position.y =30;
//     scene.camera.position.x =0;
//
//     scene.light.position.setFrom(Vector3(-10, 18, 10));
//     scene.light.setColor(Colors.yellow.shade700, 1, 1, 1);
//     _model = Object(
//         position: Vector3(-7.0, -2.0, -2.0),
//         scale: Vector3(30.0, 30.0, 25.0),
//         lighting: true,
//         fileName: 'assets/${widget.model}.obj');
//     _model.mesh.material.shininess = 1.0;
//     scene.world.add(_model);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         flexibleSpace: kAppBarDecoration,
//         title: Text(widget.model),
//       ),
//       body: Stack(
//         children: <Widget>[
//           Cube(onSceneCreated: _onSceneCreated),
//         ],
//       ),
//     );
//   }
// }
