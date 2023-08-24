import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum Props { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<Props>()
      ..add(
        Props.opacity,
        Tween(begin: 0.0, end: 1.0),
        const Duration(milliseconds: 500),
      )
      ..add(Props.translateY, Tween(begin: -30.0, end: 0.0),
          const Duration(milliseconds: 0), Curves.easeOut);

    return PlayAnimation(
      delay: Duration(milliseconds: (20 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(Props.opacity),
        child: Transform.translate(
            offset: Offset(0, animation.get(Props.translateY)), child: child),
      ),
    );
  }
}
