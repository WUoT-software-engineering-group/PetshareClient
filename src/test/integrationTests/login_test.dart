import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:pet_share/main.dart';

import 'extension_methods.dart';

void main() {
  patrolTest(
    'user logs in and then logs out',
    nativeAutomation: true,
    config: const PatrolTesterConfig(andSettle: false),
    ($) async {
      // pumps the MainPoint widget
      await $.pumpWidget(const MainPoint());
      await $.pumpUntilFound(find.byType(MainPoint));

      // taps the login button
      expect($('Pet Share - We are for you'), findsOneWidget);
      await $(OutlinedButton).tap();

      // fills out the form and logs in
      await $.native.enterTextByIndex('lsl@lsl.pl', index: 0);
      await $.native.enterTextByIndex('Dawid13!', index: 1);
      await $.native.tap(Selector(text: 'Continue'));

      // finds logout button and taps it
      await $.pumpUntilFound(find.byIcon(Icons.logout));
      await $.tap(find.byIcon(Icons.logout));
    },
  );
}
