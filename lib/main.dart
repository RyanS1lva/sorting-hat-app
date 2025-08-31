import 'package:flutter/material.dart';

import 'core/colors.dart';

import 'data.dart';
import 'houses.dart';
import 'options.dart';
import 'question.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int questionSelected = 0;
  List<String> choices = [];
  String houseResult = "";
  Map<String, Color?> housesColors = {
    Houses.gryffindor.name: AppColors.gryffindor,
    Houses.slytherin.name: AppColors.slytherin,
    Houses.ravenclaw.name: AppColors.ravenclaw,
    Houses.hufflepuff.name: AppColors.hufflepuff,
  };

  void respond(String house) {
    setState(() {
      choices.add(house);
      questionSelected++;
    });

    if (!haveQuestionSelected) {
      setState(() {
        houseResult = mostChosenHouse(choices).key;
      });
    }
  }

  void reset() {
    setState(() {
      choices.clear();
      questionSelected = 0;
      houseResult = "";
    });
  }

  MapEntry<String, int> mostChosenHouse(List<String> houses) {
    Map<String, int> housesCount = {
      Houses.gryffindor.name: 0,
      Houses.slytherin.name: 0,
      Houses.ravenclaw.name: 0,
      Houses.hufflepuff.name: 0,
    };

    for (int i = 0; i < houses.length; i++) {
      housesCount[houses[i]] = housesCount[houses[i]]! + 1;
    }

    MapEntry<String, int> houseResult = housesCount.entries.reduce(
      (a, b) => a.value > b.value ? a : b,
    );

    return houseResult;
  }

  bool get haveQuestionSelected {
    return questionSelected < questions.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Chapéu seletor',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          backgroundColor: housesColors[houseResult] ?? AppColors.primaryColor,
          centerTitle: true,
        ),
        body: haveQuestionSelected
            ? SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Question(
                      text: questions[questionSelected]['question'] as String,
                    ),
                    Options(
                      onRespond: respond,
                      questionSelected: questionSelected,
                      questions: questions,
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Sua casa é ',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                            color: AppColors.primaryColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: houseResult,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: housesColors[houseResult],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: reset,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: housesColors[houseResult],
                        foregroundColor: AppColors.white,
                        textStyle: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Fazer teste novamente',
                          ),
                          Icon(
                            Icons.refresh,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        backgroundColor: AppColors.white,
      ),
    );
  }
}
