import 'package:flutter/material.dart';

@immutable
final class User {
  final String? image;
  final String? userName;

  const User({
    this.image,
    this.userName,
  });

  User copyWith({
    String? image,
    String? userName,
  }) {
    return User(
      image: image ?? this.image,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'userName': userName,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      image: json['image'] as String?,
      userName: json['userName'] as String?,
    );
  }

  @override
  String toString() => "User(image: $image,userName: $userName)";

  @override
  int get hashCode => Object.hash(image, userName);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          image == other.image &&
          userName == other.userName;
}
