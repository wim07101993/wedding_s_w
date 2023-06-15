import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Column(
        children: [
          Text('De quiz'),
        ],
      ),
    );
  }
}
