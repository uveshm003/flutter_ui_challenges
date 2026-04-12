import 'package:flutter/material.dart';
import 'package:flutter_ui_challenges/challenges/challenge_one.dart';

class Challenge {
  final String title;
  final String category;
  final String description;
  final bool isMobile;
  final WidgetBuilder builder;

  const Challenge({required this.title, required this.category, required this.builder, required this.description, this.isMobile = true});
}

final List<Challenge> registry = [
  Challenge(title: 'Bottom Nav', category: 'Navigation', builder: (_) => const BottomNavChallenge(), description: ''),
];
