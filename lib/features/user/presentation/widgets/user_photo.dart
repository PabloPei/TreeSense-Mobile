import 'dart:typed_data';
import 'package:flutter/material.dart';

class UserProfilePhoto extends StatelessWidget {
  final Uint8List? photo;
  final double radius;

  const UserProfilePhoto({super.key, this.photo, this.radius = 50.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 5,
      height: radius * 5,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
      child: ClipOval(
        child:
            photo != null
                ? Image.memory(
                  photo!,
                  fit: BoxFit.cover,
                  width: radius * 5,
                  height: radius * 5,
                )
                : Container(
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: Icon(Icons.person, size: radius, color: Colors.grey),
                ),
      ),
    );
  }
}
