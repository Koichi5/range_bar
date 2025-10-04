import 'package:flutter/material.dart';
import '../widgets/animated_range_bar_customizer.dart';

/// Dedicated screen for AnimatedRangeBar customizer
class AnimationCustomizerScreen extends StatelessWidget {
  const AnimationCustomizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: const AnimatedRangeBarCustomizer(),
      ),
    );
  }
}
