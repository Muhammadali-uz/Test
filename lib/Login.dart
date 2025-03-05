import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:testp/Saqlash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_sahifasi extends StatefulWidget {
  const Login_sahifasi({super.key});

  @override
  State<Login_sahifasi> createState() => _Login_sahifasiState();
}

class _Login_sahifasiState extends State<Login_sahifasi> {
  Color rang = Colors.black;
  String f = "";
  String i = "";
  String l = "";
  String p = "";


  bool _isPasswordVisible =
      false; // Parolni ko'rsatish yoki yashirish uchun o'zgaruvchi

  @override
  void dispose() {
    input1.dispose();
    input2.dispose();
    input3.dispose();
    input4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Ro'yxatdan o'tish",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purple.shade700],
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Lottie.asset("lottie/dollar.json"),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              child: Column(
                children: [
                  inputField(input1, "Familya", f),
                  inputField(input2, "Ism", i),
                  inputField(input3, "Login", l),
                  passwordField(input4, "Parol", p),
                  SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                      if (input1.text.isNotEmpty &&
                          input2.text.isNotEmpty &&
                          input3.text.isNotEmpty &&
                          input4.text.isNotEmpty) {
                        funksiya2();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Saqlash_sahifasi(),
                          ),
                          
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snack);
                      } else {
                        setState(() {
                          rang = Colors.red;
                          f = "Familya ni kiriting";
                          i = "Ism ni kiriting";
                          l = "Login ni kiriting";
                          p = "Parol ni kiriting";
                          ScaffoldMessenger.of(context).showSnackBar(snack1);
                        });
                      }
                    },
                    child: Container(
                      width: 70,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Saqlash",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Parolni ko'rsatish va yashirish qismi
  Widget passwordField(
      TextEditingController controller, String label, String errorText) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(8),
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  obscureText:
                      !_isPasswordVisible, // Parolni ko'rsatish yoki yashirish
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    label: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(label, style: TextStyle(color: Colors.black)),
                    ),
                    suffixIcon: IconButton(
                      icon: Text(
                        _isPasswordVisible ? "🙉" : "🙈",
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                if (errorText.isNotEmpty)
                  Text(errorText, style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Oddiy input qismi
  Widget inputField(
      TextEditingController controller, String label, String errorText) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(8),
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    label: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(label, style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
                if (errorText.isNotEmpty)
                  Text(errorText, style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void funksiya2() async {
    final saqlash = await SharedPreferences.getInstance();
    await saqlash.setString("key1", input1.text);
    await saqlash.setString("key2", input2.text);
    await saqlash.setString("key3", input3.text);
    await saqlash.setString("key4", input4.text);
  }
}

final snack = SnackBar(
  content: Text("Ma`lumot muvafaqiyatli saqlandi"),
  duration: Duration(seconds: 3),
);

final snack1 = SnackBar(
  content: Text("Iltimos, barch xududlarni to'ldiring!"),
  duration: Duration(seconds: 3),
);
  TextEditingController input1 = TextEditingController();
  TextEditingController input2 = TextEditingController();
  TextEditingController input3 = TextEditingController();
  TextEditingController input4 = TextEditingController();

