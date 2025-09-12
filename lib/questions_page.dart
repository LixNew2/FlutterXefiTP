import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class Questions extends StatefulWidget {
  const Questions({super.key, required this.title, required this.questions});

  final String title;
  final List questions;

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  List currentOption = [];
  List correctAnswers = [];
  List allAnswers = [];
  List displayCorrectAnswer = [];
  List colors = [];
  HtmlUnescape htmlu = HtmlUnescape();
  String score = '';

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.questions.length; i++) {
      currentOption.add('');
      displayCorrectAnswer.add('');
      colors.add(Color.fromARGB(255, 150, 150, 150));
      correctAnswers.add(widget.questions[i]['correct_answer']);

      List thisAnswers = widget.questions[i]['incorrect_answers'].map((item) {
        return htmlu.convert(item);
      }).toList();

      thisAnswers.add(htmlu.convert(widget.questions[i]['correct_answer']));
      thisAnswers.shuffle();
      allAnswers.add(thisAnswers);
    }
  }

  void onChange(int index, String value) {
    setState(() {
      currentOption[index] = value;
    });
  }

  void checkAnswers() {
    setState(() {
      int finalScore = 0;
      for (int i = 0; i < widget.questions.length; i++) {
        if (currentOption[i] == correctAnswers[i]) {
          colors[i] = Color.fromARGB(255, 0, 196, 10);
          finalScore++;
        } else {
          colors[i] = Color.fromARGB(255, 192, 6, 0);
        }
        displayCorrectAnswer[i] = 'Correct answer : ${correctAnswers[i]}';
        score =
            'Score : $finalScore / ${widget.questions.length} | ${(finalScore * 100) / widget.questions.length}%';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        children: [
          Text(score),
          Expanded(
            child: ListView.builder(
              itemCount: widget.questions.length,
              itemBuilder: (context, index) {
                return Card(
                  color: colors[index],
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                htmlu.convert(
                                    widget.questions[index]['question']),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                          Spacer(flex: 1),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, top: 30.0),
                            child: Text(displayCorrectAnswer[index],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255))),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          ...allAnswers[index]
                              .map<Widget>(
                                (item) => Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                    children: [
                                      Radio(
                                        activeColor: const Color.fromARGB(
                                            255, 0, 119, 255),
                                        value: item,
                                        groupValue: currentOption[index],
                                        onChanged: (value) {
                                          onChange(index, value);
                                        },
                                      ),
                                      Text(item,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)))
                                    ],
                                  ),
                                ),
                              )
                              .toList()
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          OutlinedButton(
              onPressed: () {
                checkAnswers();
              },
              child: const Text('Submit')),
        ],
      )),
    );
  }
}
