import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResponsiPage extends StatefulWidget {
  const ResponsiPage({Key? key}) : super(key: key);

  @override
  _ResponsiPageState createState() => _ResponsiPageState();
}

class _ResponsiPageState extends State<ResponsiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constranints) {
        return Container(
          child: Column(
            children: [
              Expanded(
                  flex: 4,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        color: Colors.cyanAccent,
                      ),
                      Image.asset()
                      const Padding(padding: EdgeInsets.all(10)),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Image.asset("res/boom.png"),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
        );
      }),
    );
  }
}
