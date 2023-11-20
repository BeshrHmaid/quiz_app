import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

PageController controller = PageController();
double pscore = 0;
double nscore = 0;
num timer = 0;

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<bool> userAnswered = List.filled(questions.length, false);

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        timer++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      controller: controller,
      itemCount: questions.length,
      itemBuilder: (context, index) => Scaffold(
        body: Stack(children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                color: Color.fromRGBO(164, 47, 193, 1),
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  iconSize: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 40,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 250),
            child: Center(
              child: Container(
                width: 280,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    '${pscore.toInt()}',
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 15),
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  width: 0 + (15 * pscore),
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: AnimatedContainer(
                                    duration: Duration(seconds: 1),
                                    width: 0 + (15 * nscore),
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                Text(
                                  '${nscore.toInt()}',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text('Question '+(index+1).toString()+'/'+questions.length.toString()),
                      Text(questions[index].question),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 150),
              child: SizedBox(
                height: 300,
                width: 250,
                child: ListView.builder(
                  itemCount: questions[index].answers.length,
                  itemBuilder: (context, ind) => InkWell(
                    onTap: () {
                      if (!userAnswered[index]) {
                        checkAnswer(
                          isCorrect: questions[index].answers[ind].isCorrect,
                          context: context,
                          answerTime: timer,
                          availableTime: questions[index].availableTime,
                          index: index,
                        );
                        timer = 0;
                      }

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Color.fromRGBO(164, 47, 193, 1),
                          ),
                        ),
                        child: ListTile(
                          title: Text(questions[index].answers[ind].answer),
                          trailing: userAnswered[index]
                              ? CircleAvatar(
                                  child: Icon(
                                    questions[index].answers[ind].isCorrect
                                        ? Icons.check
                                        : Icons.close,
                                  ),
                                )
                              : SizedBox(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 350),
            child: Center(
                child: CircleAvatar(
              radius: 30,
              child: timer == 0
                  ? Icon(Icons.check, color: Colors.white)
                  : CircularProgressIndicator(
                      value: timer /
                          20, // Adjust maxTime based on your requirements
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
            )),
          ),
        ]),
      ),
    ));
  }
  
  checkAnswer({
    required bool isCorrect,
    required BuildContext context,
    required num availableTime,
    required num answerTime,
    required int index,
  }) {
    setState(() {
      userAnswered[index] = true;
    });

    if (availableTime > answerTime) {
      if (isCorrect) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Success'),
            backgroundColor: Colors.green,
          ),
        );

        controller.nextPage(
          duration: Duration(seconds: 2),
          curve: Curves.ease,
        );
        pscore++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed'),
            backgroundColor: Colors.red,
          ),
        );
        controller.nextPage(
          duration: Duration(seconds: 2),
          curve: Curves.ease,
        );
        nscore++;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Time out'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }
}
