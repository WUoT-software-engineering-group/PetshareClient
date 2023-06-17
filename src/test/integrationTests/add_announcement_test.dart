import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:patrol/patrol.dart';
import 'package:pet_share/main.dart';
import 'package:pet_share/views/authPage/hello_page.dart';
import 'package:pet_share/views/petPage/pet_tile.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'extension_methods.dart';

void main() {
  patrolTest(
    'user logs in and, creates new announcement and finally logs out',
    nativeAutomation: true,
    config: const PatrolTesterConfig(andSettle: false),
    ($) async {
      // pumps the MainPoint widget
      await dotenv.load(fileName: 'envs/android_config.env');
      await $.pumpWidget(const MainPoint());
      await $.pumpUntilFound(find.byType(MainPoint));

      // taps the login button
      expect($('Pet Share - We are for you'), findsOneWidget);
      await $(OutlinedButton).tap();

      await Future.delayed(const Duration(seconds: 2));
      await $.pumpAndSettle();

      //Provide credentials
      await $.native.enterText(
        Selector(text: 'Email address'),
        text: 'nipawuzu_shelter@test.pl',
      );
      await $.native.enterText(
        Selector(text: 'Password'),
        text: 'Test_2137',
      );
      await $.native.tap(Selector(text: 'Continue'));

      await Future.delayed(const Duration(seconds: 2));
      await $.pumpAndSettle();

      // navigates to pets page
      await $.scrollUntilVisible(finder: find.byIcon(Icons.pets));
      await $.tap(find.byIcon(Icons.pets), andSettle: true);

      // taps the add pet button
      await $.scrollUntilVisible(finder: find.byIcon(Icons.add));
      await $.tap(find.byIcon(Icons.add), andSettle: true);

      // fills out the form and adds pet
      final name = 'Pimpek tester ${Random().nextInt(1000)}';

      await $.enterText(find.bySemanticsLabel('Name'), name, andSettle: true);
      await $.enterText(find.bySemanticsLabel('Species'), 'pies',
          andSettle: true);
      await $.enterText(find.bySemanticsLabel('Breed'), 'samojed',
          andSettle: true);
      await $.scrollUntilVisible(finder: find.text('Description'));
      await $.enterText(find.bySemanticsLabel('Description'),
          'najlepszy testowy pies na świecie, serio',
          andSettle: true);

      await $('CONTINUE').scrollTo(andSettle: true);
      await $('CONTINUE').tap(andSettle: true);

      await $('Add photo').tap(andSettle: true);

      await $.native.tap(Selector(contentDescriptionContains: 'samoyed.jpg'));
      await $.pumpAndSettle();

      await $('CONTINUE').tap(andSettle: true);

      await $('CONFIRM').tap(andSettle: true);

      // refreshes the pets list
      await $.tester.fling(
        find.byType(LiquidPullToRefresh),
        const Offset(0, 300),
        1000,
      );
      await $.pumpAndSettle();

      // finds the pet tile and taps it
      await $.dragUntilExists(
        finder: find.byWidgetPredicate(
            (widget) => widget is PetTile && widget.pet?.name == name),
        view: find.byType(LiquidPullToRefresh),
        moveStep: const Offset(0, -300),
        andSettle: true,
      );

      await $.tester.tap(find
          .byWidgetPredicate(
              (widget) => widget is PetTile && widget.pet?.name == name)
          .last);
      await $.pumpAndSettle();

      // taps the add announcement button
      await $('Add announcement').tap(andSettle: true);

      // fills out the form and adds announcement
      await $.enterText(find.bySemanticsLabel('Title').first,
          'Testowe ogłoszenie testowego pimpka',
          andSettle: true);
      await $.enterText(find.bySemanticsLabel('Title').last,
          'Ten testowy pimpek jest najlepszym testowym pimpkiem!',
          andSettle: true);
      await $('CONTINUE').tap(andSettle: true);
      await $('CONFIRM').tap(andSettle: true);

      // navigates to announcements page
      await $.tap(find.byIcon(Icons.home), andSettle: true);

      // finds logout button and taps it
      await $.tap(find.byIcon(Icons.logout));

      await Future.delayed(const Duration(seconds: 2));
      await $.pumpUntilFound(find.byType(HelloPage));

      await Future.delayed(const Duration(seconds: 5));
    },
  );
}
