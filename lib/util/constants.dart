import 'package:flutter/material.dart';

const InputDecoration kTopicInputDecoration = InputDecoration(
  hintText: 'Enter the topic of post here...',
  hintStyle: TextStyle(
      fontSize: 16,
      color: Colors.black38
  ),
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.black26, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.black26, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);