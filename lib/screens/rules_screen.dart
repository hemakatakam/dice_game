import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? const _CupertinoRulesView() : const _MaterialRulesView();
  }
}

class _MaterialRulesView extends StatelessWidget {
  const _MaterialRulesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Rules')),
      body: const _RulesContent(),
    );
  }
}

class _CupertinoRulesView extends StatelessWidget {
  const _CupertinoRulesView();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Game Rules')),
      child: const SafeArea(child: _RulesContent()),
    );
  }
}

class _RulesContent extends StatelessWidget {
  const _RulesContent();

  static const List<String> _rules = [
    'Each round, both player and computer roll two dice.',
    'The product of the two dice numbers determines the winner.',
    'The player with the higher product wins the round.',
    'Use the bet slider to increase your potential points.',
    'First to reach 20 points wins the game!',
  ];

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How to Play',
              style: isIOS
                  ? const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: '.SF Pro Display',
                      color: CupertinoColors.label,
                    )
                  : theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
            ),
            const SizedBox(height: 20),
            ...List.generate(
              _rules.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  '${index + 1}. ${_rules[index]}',
                  style: isIOS
                      ? const TextStyle(
                          fontSize: 17,
                          height: 1.35,
                          fontFamily: '.SF Pro Text',
                          color: CupertinoColors.label,
                        )
                      : theme.textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
