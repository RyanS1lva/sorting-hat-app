import 'package:flutter/material.dart';
import 'package:sorting_hat/core/colors.dart';

final class Options extends StatelessWidget {
  final int questionSelected;
  final List<Map<String, Object>> questions;
  final void Function(String) onRespond;

  const Options({
    super.key,
    required this.questionSelected,
    required this.questions,
    required this.onRespond,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> optionsSelected =
        questions[questionSelected].cast()['options'];

    return Column(
      children: optionsSelected
          .map(
            (o) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 350,
                height: 70,
                child: ElevatedButton(
                  onPressed: () => onRespond(o['house'] as String),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.white,
                    textStyle: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  child: Text(
                    o['text'] as String,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
