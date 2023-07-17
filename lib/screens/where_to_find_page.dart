import 'package:flutter/material.dart';

class WhereToFindPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('#NerdeBulurum'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                '#NerdeBulurum Page',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
