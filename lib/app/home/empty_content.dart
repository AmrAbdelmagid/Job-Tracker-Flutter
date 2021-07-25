import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent(
      {this.title = 'Nothing Here',
      this.message = 'Add new item to get started'});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 32.0, color: Colors.black54),
          ),
          Text(
            message,
            style: TextStyle(fontSize: 16.0, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
