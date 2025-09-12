import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: const Center(
            child: Card(
                child: SizedBox(
          width: 350,
          height: 120,
          child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'NDF Octobre',
                        style: TextStyle(
                            color: Color.fromARGB(255, 33, 0, 124),
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Text(
                          '3 dépenses',
                          style: TextStyle(
                              color: Color.fromARGB(255, 151, 151, 151)),
                        ),
                      )
                    ],
                  ),
                  Spacer(flex: 1),
                  Column(
                    children: [
                      Text(
                        '78.53€',
                        style: TextStyle(
                            color: Color.fromARGB(255, 33, 0, 124),
                            fontWeight: FontWeight.bold),
                      ),
                      Chip(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        side: BorderSide.none,
                        label: const Text('Brouillon',
                            style: TextStyle(
                                color: Color.fromARGB(255, 148, 148, 148),
                                fontWeight: FontWeight.bold)),
                        backgroundColor: Color.fromARGB(255, 223, 222, 222),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 12.0, left: 10.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromARGB(255, 228, 14, 14),
                          size: 20.0,
                        ),
                      )
                    ],
                  )
                ],
              )),
        ))));
  }
}
