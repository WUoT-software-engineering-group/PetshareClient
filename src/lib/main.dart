import 'package:flutter/material.dart';
import 'package:pet_share/pageManager/page_manager.dart';

void main() {
  runApp(const MainPoint());
}

class MainPoint extends StatelessWidget {
  const MainPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PageManager());
  }
}
