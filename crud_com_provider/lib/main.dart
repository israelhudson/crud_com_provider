import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/People.dart';
import 'HomeScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (context) => PeopleModel(),
      child: MaterialApp(home: HomeScreen()),
    ),
  );
}
