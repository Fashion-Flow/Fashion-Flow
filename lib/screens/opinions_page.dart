import 'package:flutter/material.dart';

class OpinionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('#SizceHangisi'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                '#SizceHangisi Page',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
