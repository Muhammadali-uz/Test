import 'package:flutter/material.dart';

import 'package:testp/Kutish.dart';
import 'package:testp/Login.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
      home: oxirgi_imtihon(),
    ));

class oxirgi_imtihon extends StatefulWidget {
  const oxirgi_imtihon({super.key});

  @override
  State<oxirgi_imtihon> createState() => _oxirgi_imtihonState();
}

class _oxirgi_imtihonState extends State<oxirgi_imtihon> {
  funksiya1() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Login_sahifasi(),
            ));
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    funksiya1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Kutish_sahifasi(),
      ),
    );
  }
}
