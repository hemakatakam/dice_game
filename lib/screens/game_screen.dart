import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' show Platform;
import '../blocs/game/game_bloc.dart';
import '../widgets/game_layout.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: Platform.isIOS 
          ? const _CupertinoGameScreen() 
          : const _MaterialGameScreen(),
    );
  }
}

class _MaterialGameScreen extends StatelessWidget {
  const _MaterialGameScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dice Game')),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: GameLayout(),
        ),
      ),
    );
  }
}

class _CupertinoGameScreen extends StatelessWidget {
  const _CupertinoGameScreen();

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Dice Game')),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: GameLayout(),
        ),
      ),
    );
  }
}
