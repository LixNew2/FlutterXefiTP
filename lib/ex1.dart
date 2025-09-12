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
      body: Center(
          child: SizedBox(
        width: 310,
        height: 80,
        child: Container(
          padding: const EdgeInsets.only(left: 30.0),
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 199, 199, 199))),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(right: 50.0),
                    child: Text('BOTTON Gaël',
                        style: TextStyle(
                            color: Color.fromARGB(255, 33, 0, 124),
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Développeur Backend',
                      style: TextStyle(
                        color: Color.fromARGB(255, 138, 138, 138),
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Soumis',
                        style:
                            TextStyle(color: Color.fromARGB(255, 255, 196, 2))),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 250, 242, 169),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
