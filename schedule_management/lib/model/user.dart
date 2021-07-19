import 'dart:core';

class User {
  final String username;
  const User({
    required this.username

  });
  Map<String, Object?> toMap() {
    return {
      'username': username,
    };
  }
}