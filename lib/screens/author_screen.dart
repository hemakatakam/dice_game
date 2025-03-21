import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class AuthorScreen extends StatelessWidget {
  const AuthorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? const _CupertinoAuthorView() : const _MaterialAuthorView();
  }
}

class _MaterialAuthorView extends StatelessWidget {
  const _MaterialAuthorView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Author')),
      body: const _AuthorContent(),
    );
  }
}

class _CupertinoAuthorView extends StatelessWidget {
  const _CupertinoAuthorView();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('About Author')),
      child: const SafeArea(child: _AuthorContent()),
    );
  }
}

class _AuthorContent extends StatelessWidget {
  const _AuthorContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
            CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/my_avatar.jpg'),
          ),
          SizedBox(height: 20),
          Text(
            'Dice Game',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Created by: Hema Katakam',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'CIS 651 - Mobile Application Programming',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
