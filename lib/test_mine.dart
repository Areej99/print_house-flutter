// Builder(
// builder: (BuildContext context) => _paths != null
// ? Container(
// padding: const EdgeInsets.only(top: 10.0),
// height: MediaQuery.of(context).size.height * 0.50,
// child: Scrollbar(
// child: ListView.separated(
// itemCount: 1,
// itemBuilder: (BuildContext context, int index) {
// fileName =
// (_paths.map((e) => e.name).toList()[0]);
// // path =
// //     _paths.map((e) => e.path).toList()[0].toString();
// return Column(
// children: [
// Center(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// GestureDetector(
// onTap: () {
// _openFileExplorer();
// },
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.center,
// children: [
// Text(
// 'Add File',
// style: TextStyle(
// color: Colors.red,
// fontSize: 20,
// decoration:
// TextDecoration.underline),
// ),
// SizedBox(
// width: 5,
// ),
// CircleAvatar(
// radius: 7,
// backgroundColor: Colors.red,
// child: Icon(
// Icons.add,
// color: Colors.white,
// size: 13,
// ))
// ],
// ),
// ),
// SizedBox(
// height: 10,
// ),
// Row(
// children: [
// Icon(
// Icons.image,
// size: 25,
// ),
// Text(
// fileName,
// style: TextStyle(fontSize: 12),
// ),
// SizedBox(
// width: 15,
// ),
// GestureDetector(
// onTap: () {
// setState(() {
// _paths = null;
// fileName = '';
// // path = '';
// });
// },
// child: Icon(
// Icons.delete,
// size: 25,
// )),
// ],
// )
// ],
// )),
// ],
// );
// },
// separatorBuilder: (BuildContext context, int index) =>
// const Divider(
// height: 1,
// ),
// )),
// )
// : Container(
// child: Column(
// children: [
// Center(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Image.asset(
// 'images/files.jpeg',
// width: 100,
// height: 100,
// ),
// GestureDetector(
// onTap: () {
// _openFileExplorer();
// },
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text(
// 'Add File',
// style: TextStyle(
// color: Colors.red,
// fontSize: 20,
// decoration: TextDecoration.underline),
// ),
// SizedBox(
// width: 5,
// ),
// CircleAvatar(
// radius: 7,
// backgroundColor: Colors.red,
// child: Icon(
// Icons.add,
// color: Colors.white,
// size: 13,
// ))
// ],
// ),
// ),
// SizedBox(
// height: 10,
// ),
// Row(
// children: [
// Icon(
// Icons.image,
// size: 25,
// ),
// Text(
// 'file name',
// style: TextStyle(fontSize: 20),
// ),
// SizedBox(
// width: 15,
// ),
// Icon(
// Icons.delete,
// size: 25,
// ),
// ],
// )
// ],
// )),
// ],
// ),
// ),
// ),