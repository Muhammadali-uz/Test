import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testp/Dollar.dart';
import 'dart:ui';

class Saqlash_sahifasi extends StatefulWidget {
  const Saqlash_sahifasi({super.key});

  @override
  State<Saqlash_sahifasi> createState() => _Saqlash_sahifasiState();
}

class _Saqlash_sahifasiState extends State<Saqlash_sahifasi> {
  TextEditingController input3 = TextEditingController();
  TextEditingController input4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      funksiya4(); 
    });
  }

  @override
  void dispose() {
    input3.dispose();
    input4.dispose();
    super.dispose();
  }

  
  void login() async {
    final saqlash = await SharedPreferences.getInstance();
    String savedLogin = saqlash.getString("key3") ?? "";
    String savedPassword = saqlash.getString("key4") ?? "";

    if (input3.text == savedLogin && input4.text == savedPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dollar(),
        ),
      );
    } else {
      setState(() {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(snack2);
      });
    }
  }
void funksiya4() async {
    setState(() {
      input3.text = "";
      input4.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputField(input3, "Login"),
            inputField(input4, "Parol"),
            SizedBox(height: 20),
            InkWell(
              onTap: login,
              child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(child: Text("Kirish"))),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputField(TextEditingController controller, String label) {
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
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                label: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(label),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final snack2 = SnackBar(
  content: Text("Parol yoki login xato!"),
  duration: Duration(seconds: 3),
);
