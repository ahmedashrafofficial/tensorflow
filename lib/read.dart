import 'package:flutter/material.dart';
import '../utils.dart';



class read extends StatefulWidget {
  const read({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _read createState() => _read();
}

class _read extends State<read> {
  @override
  Widget build(BuildContext context) {
return Container(
width: 375,
height: 812,
color: Colors.white,
child: Column(
mainAxisSize: MainAxisSize.min,
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.center,
children:[
Container(
width: 375,
height: 100,
child: Row(
mainAxisSize: MainAxisSize.min,
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children:[
Container(
width: 375,
height: 100,
padding: const EdgeInsets.only(top: 60, ),
child: Row(
mainAxisSize: MainAxisSize.min,
mainAxisAlignment: MainAxisAlignment.end,
crossAxisAlignment: CrossAxisAlignment.end,
children:[
Container(
width: 40,
height: 40,
child: Row(
mainAxisSize: MainAxisSize.min,
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children:[
Container(
width: 40,
height: 40,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10),
),
padding: const EdgeInsets.all(8),
child: Row(
mainAxisSize: MainAxisSize.min,
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children:[
Container(
width: 24,
height: 24,
child: Row(
mainAxisSize: MainAxisSize.min,
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children:[
Container(
width: 24,
height: 24,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(8),
),
child: FlutterLogo(size: 24),
),
],
),
),
],
),
),
],
),
),
SizedBox(width: 283),
Container(
width: 4,
height: 16,
child: Column(
mainAxisSize: MainAxisSize.min,
mainAxisAlignment: MainAxisAlignment.end,
crossAxisAlignment: CrossAxisAlignment.center,
children:[
Container(
width: 4,
height: 4,
decoration: BoxDecoration(
shape: BoxShape.circle,
color: Color(0xff101623),
),
),
SizedBox(height: 2),
Container(
width: 4,
height: 4,
decoration: BoxDecoration(
shape: BoxShape.circle,
color: Color(0xff101623),
),
),
SizedBox(height: 2),
Container(
width: 4,
height: 4,
decoration: BoxDecoration(
shape: BoxShape.circle,
color: Color(0xff101623),
),
),
],
),
),
],
),
),
],
),
),
SizedBox(height: 307.50),
SizedBox(
width: 255,
height: 18,
child: Text(
"Description of our model and how it works",
style: TextStyle(
color: Colors.black,
fontSize: 12,
fontFamily: "Inter",
fontWeight: FontWeight.w600,
),
),
),
SizedBox(height: 307.50),
Container(
width: 375,
height: 79,
child: Row(
mainAxisSize: MainAxisSize.min,
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children:[
Container(
width: 375,
height: 79,
color: Colors.white,
padding: const EdgeInsets.only(left: 258, right: 93, top: 28, bottom: 27, ),
child: Row(
mainAxisSize: MainAxisSize.min,
mainAxisAlignment: MainAxisAlignment.end,
crossAxisAlignment: CrossAxisAlignment.center,
children:[
Container(
width: 24,
height: 24,
child: Stack(
children:[

],
),
),
],
),
),
],
),
),
],
),
);
}
}