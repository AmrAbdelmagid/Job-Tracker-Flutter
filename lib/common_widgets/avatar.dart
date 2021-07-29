import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({this.url, required this.radius});
  final String? url;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black54, width: 3.0),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.black12,
        backgroundImage: url != null ? NetworkImage(url!) : null,
        child: url == null ? Icon(Icons.camera) : null,
      ),
    );
  }
}
