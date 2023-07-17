import 'package:flutter/material.dart';

class GotItPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('#BunuAldım'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                '#BunuAldım Page',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
