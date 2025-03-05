import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Kutish_sahifasi extends StatefulWidget {
  const Kutish_sahifasi({super.key});

  @override
  State<Kutish_sahifasi> createState() => _Kutish_sahifasiState();
}

class _Kutish_sahifasiState extends State<Kutish_sahifasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: 200, height: 200, child: Lottie.asset("lottie/dollar.json")),
      ),
    );
  }
}
