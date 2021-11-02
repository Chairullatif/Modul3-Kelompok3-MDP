import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.cyan[300],
          title: const Text('Detail Kelompok 03')),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              children: [
                const Text(
                  "Kelompok 03",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      const Card(
                        child: ListTile(
                            title: Text('Alberto Mathew Christopher'),
                            subtitle: Text('21120118170002')),
                      ),
                      const Card(
                        child: ListTile(
                            title: Text('Chairullatif Aji Sadewa'),
                            subtitle: Text('21120119120015')),
                      ),
                      Card(
                        child: ListTile(
                            title: Text('Erlin Sofia Sitohang'),
                            subtitle: Text('21120119120014')),
                      ),
                      Card(
                        child: ListTile(
                            title: Text('Mohammad Rifqi Satriamas'),
                            subtitle: Text('21120119130115')),
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
