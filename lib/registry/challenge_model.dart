import 'package:flutter/material.dart';
import 'package:flutter_ui_challenges/challenges/challenge_one.dart';
import 'package:flutter_ui_challenges/challenges/challenge_two.dart';

class Challenge {
  final String title;
  final String category;
  final String description;
  final bool isMobile;
  final WidgetBuilder builder;

  const Challenge({required this.title, required this.category, required this.builder, required this.description, this.isMobile = true});
}

final List<Challenge> registry = [
  Challenge(title: 'Challenge One', category: '100 Days', builder: (_) => const ChallengeOne(), description: ''),
  Challenge(title: 'Challenge Two', category: '100 Days', builder: (_) => const ChallengeTwo(), description: ''),
];
