import 'package:flutter/material.dart';


@immutable
class Message {
  final String title;
  final String body;

  const Message({
    @required this.body,
    @required this.title,
  });
}