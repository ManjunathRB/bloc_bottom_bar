import 'package:bloc_bottom_bar/presentation/widgets/fade_animation.dart';
import 'package:flutter/material.dart';

class ScrollAnimationTest extends StatefulWidget {
  const ScrollAnimationTest({super.key});

  @override
  State<ScrollAnimationTest> createState() => _ScrollAnimationTestState();
}

class _ScrollAnimationTestState extends State<ScrollAnimationTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: 100,
            itemBuilder: (context, index) {
              return FadeAnimation(
                  (1.0 + index) / 4,
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ]),
                  ));
            }));
  }
}
