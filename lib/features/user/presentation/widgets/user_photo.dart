import 'dart:typed_data';
import 'package:flutter/material.dart';

class UserProfilePhoto extends StatelessWidget {
  final Uint8List? photo;
  final double radius;

  const UserProfilePhoto({super.key, this.photo, this.radius = 50.0});

  @override
  Widget build(BuildContext context) {
    final double size = radius * 5;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child:
            photo != null
                ? Image.memory(
                  photo!,
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                )
                : Image.asset(
                  'assets/icons/user.png',
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                ),
      ),
    );
  }
}
