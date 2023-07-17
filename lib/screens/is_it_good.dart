import 'package:flutter/material.dart';

class IsItGoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OlmuşMu'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'OlmuşMu Page',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
