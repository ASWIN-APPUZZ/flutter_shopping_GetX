import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RecentContests extends StatefulWidget {
  const RecentContests({super.key});

  @override
  State<RecentContests> createState() => _RecentContestsState();
}

class _RecentContestsState extends State<RecentContests> {
  List info = [];
  _readData() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/detail.json')
        .then((s) {
      setState(() {
        info = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    _readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 20,top: 100, right: 10),
            child: Column(children: [
      Expanded(
          child: SingleChildScrollView(
              child: Column(children: [
        for (int i = 0; i < info.length; i++)
          Container(
              height: 300,
              margin: EdgeInsets.only(bottom: 30),
              child: GestureDetector(
                  onTap: () {
                    Get.toNamed("/detail/", arguments: {
                      'title': info[i]['title'].toString(),
                      'text': info[i]['text'].toString(),
                      'name': info[i]['name'].toString(),
                      'img': info[i]['img'].toString(),
                      'time': info[i]['time'].toString(),
                      'prize': info[i]['prize'].toString()
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      // height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width - 20,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color:
                              i.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc)),
                      child: Column(children: [
                        Container(
                            child: Row(
                          children: [
                            Text(info[i]["title"],
                                // Text("Text",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Expanded(child: Container())
                          ],
                        )),
                        SizedBox(height: 10),
                        Container(
                            width: MediaQuery.of(context).size.width - 20,
                            child: Text(info[i]['text'],
                                // Text("text",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xFFb8eefc)))),
                        SizedBox(height: 5),
                        Divider(thickness: 1.0),
                        Row(children: [
                          for (int i = 0; i < 4; i++)
                            Container(
                                width: 50,
                                height: 50,
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        image: DecorationImage(
                                            image: AssetImage(info[i]['img']),
                                            // 'img/background.jpg'),
                                            fit: BoxFit.cover))))
                        ])
                      ]))))
      ])))
    ])));
  }
}
