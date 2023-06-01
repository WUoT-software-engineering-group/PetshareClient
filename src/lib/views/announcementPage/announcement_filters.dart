import 'package:flutter/material.dart';

class AnnouncementFilters extends StatelessWidget {
  const AnnouncementFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text('Filters')),
      body: Center(
          child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Go Back'),
      )),
    );
  }
}
