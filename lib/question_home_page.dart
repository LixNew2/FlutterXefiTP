import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'questions_page.dart';
import 'package:numberpicker/numberpicker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dio = Dio();
  Map<int, String> categories = {};
  Map<String, String> difficulties = {
    'easy': 'Easy',
    'medium': 'Medium',
    'hard': 'Hard'
  };
  List questions = [];
  int categoriesCurrentValue = 0;
  String difficultiesCurrentValue = 'easy';
  int questionAmount = 1;

  void getCategories() async {
    Response response = await dio.get('https://opentdb.com/api_category.php');

    setState(() {
      categories = {
        for (var item in response.data['trivia_categories'])
          item['id'] as int: item['name'] as String
      };
    });

    categoriesCurrentValue = categories.keys.first;
    difficultiesCurrentValue = difficulties.keys.first;
  }

  Future getQuestion() async {
    Response response = await dio.get(
        'https://opentdb.com/api.php?amount=${questionAmount}&category=${categoriesCurrentValue}&difficulty=${difficultiesCurrentValue}');

    setState(() {
      questions = response.data['results'];
    });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
            child: SizedBox(
          width: 400,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text('Choose a categorie',
                    style: TextStyle(
                        color: Color.fromARGB(255, 139, 139, 139),
                        fontSize: 20)),
              ),
              DropdownButton(
                value: categoriesCurrentValue,
                icon: const Icon(Icons.menu),
                items: categories.entries.map((entry) {
                  return DropdownMenuItem(
                      value: entry.key, child: Text(entry.value));
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    categoriesCurrentValue = newValue!;
                  });
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text('Choose a difficulty',
                    style: TextStyle(
                        color: Color.fromARGB(255, 139, 139, 139),
                        fontSize: 20)),
              ),
              DropdownButton(
                value: difficultiesCurrentValue,
                icon: const Icon(Icons.menu),
                items: difficulties.entries.map((item) {
                  return DropdownMenuItem(
                      value: item.key, child: Text(item.value));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    difficultiesCurrentValue = newValue!;
                  });
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text('Number of questions',
                    style: TextStyle(
                        color: Color.fromARGB(255, 139, 139, 139),
                        fontSize: 20)),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: NumberPicker(
                    minValue: 1,
                    maxValue: 50,
                    value: questionAmount,
                    onChanged: (value) =>
                        setState(() => questionAmount = value),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 90.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () => setState(() {
                              final newValue = questionAmount - 1;
                              questionAmount = newValue.clamp(1, 50);
                            }),
                        icon: const Icon(Icons.remove)),
                    Text('Number of questions : $questionAmount'),
                    IconButton(
                        onPressed: () => setState(() {
                              final newValue = questionAmount + 1;
                              questionAmount = newValue.clamp(1, 50);
                            }),
                        icon: const Icon(Icons.add))
                  ],
                ),
              ),
              OutlinedButton(
                  onPressed: () async {
                    await getQuestion();

                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (context) => Questions(
                                title: 'Questions pages',
                                questions: questions)));
                  },
                  child: const Text('Start')),
            ],
          ),
        )));
  }
}
