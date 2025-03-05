import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testp/Login.dart';

class Dollar extends StatefulWidget {
  const Dollar({super.key});

  @override
  State<Dollar> createState() => _DollarState();
}

class _DollarState extends State<Dollar> {
  DateTime dt = DateTime.now();
  String d1 = "";
  List data = [];
  List date = [];
  TextEditingController iny = TextEditingController();
  double hisob = 0.0;

  void fu() {
    setState(() {
      dt = DateTime.now();
      d1 = DateFormat("HH:mm:ss").format(dt);
    });

    Future.delayed(Duration(seconds: 1), fu);
  }

  @override
  void initState() {
    super.initState();
    fu();
    fet();
  }

  void fet() async {
    try {
      final response = await http
          .get(Uri.parse("https://cbu.uz/uz/arkhiv-kursov-valyut/json/"));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          data = jsonData
              .map((item) => Map<String, dynamic>.from(item as Map))
              .toList();
          date = List.from(data);
        });
      } else {
        throw Exception("Ma'lumotlarni yuklashda xato!");
      }
    } catch (e) {
      print("Xato yuz berdi: $e");
    }
  }

  void hisoblash(String rate) {
    double y = double.tryParse(iny.text) ?? 0.0;
    double i = double.tryParse(rate) ?? 0.0;

    setState(() {
      hisob = y * i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Text("${input1.text} ${input2.text}"),
        actions: [
          Text(d1),
          SizedBox(width: 20),
          IconButton(
            onPressed: () {
              input1.text = "";
              input2.text = "";
              input3.text = "";
              input4.text = "";
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login_sahifasi(),
                  ));
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: ListView.builder(
        itemCount: date.length,
        itemBuilder: (context, index) {
          String apiu = date[index]["Diff"]?.toString() ?? "0";
          String rate = date[index]["Rate"]?.toString() ?? "0";
          double rq = double.tryParse(apiu) ?? 0.0;

          return Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setStateDialog) {
                      return SimpleDialog(
                        title: Text("${date[index]["Ccy"]} ma`lumotlari"),
                        children: [
                          Column(
                            children: [
                              Text("Qiymati: $rate"),
                              Text("Valyuta: ${date[index]["Ccy"]}"),
                              Text("Nomi: ${date[index]["CcyNm_UZ"]}"),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Miqdor kiriting",
                                  ),
                                  controller: iny,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setStateDialog(() {
                                    hisoblash(rate);
                                  });
                                },
                                child: Text("Hisoblash"),
                              ),
                              Text(
                                "So'm: ${hisob.toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Qaytish"))
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Yangilangan kun: ${date[index]["Date"]}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("1 ${date[index]["Ccy"]}"),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${date[index]["CcyNm_UZ"]} (${date[index]["Code"]})",
                              style: TextStyle(color: Colors.indigo),
                            ),
                            Text(
                              rate,
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                        Text(
                          (rq < 0) ? "- ${rq.abs()}" : "+ $rq",
                          style: TextStyle(
                            color: (rq < 0) ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      color: Colors.black,
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
