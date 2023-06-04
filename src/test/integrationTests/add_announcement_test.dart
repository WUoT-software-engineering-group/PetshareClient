import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:pet_share/main.dart';
import 'package:pet_share/views/petPage/pet_tile.dart';

import 'extension_methods.dart';

void main() {
  patrolTest(
    'user logs in and, creates new announcement and finally logs out',
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
      await $.native.enterTextByIndex('nipawuzu_shelter@test.pl', index: 0);
      await $.native.enterTextByIndex('Test_2137', index: 1);
      await $.native.tap(Selector(text: 'Continue'));
      await $.pumpAndSettle();

      // navigates to pets page
      await $.tap(find.byIcon(Icons.pets), andSettle: true);

      // taps the add pet button
      await $.tap(find.byIcon(Icons.add), andSettle: true);

      // fills out the form and adds pet
      final name = 'Pimpek tester ${Random().nextInt(1000)}';

      await $.enterText(find.bySemanticsLabel('Name'), name, andSettle: true);
      await $.enterText(find.bySemanticsLabel('Species'), 'pies',
          andSettle: true);
      await $.enterText(find.bySemanticsLabel('Breed'), 'samojed',
          andSettle: true);
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
        find.byType(MasonryGridView),
        const Offset(0, 300),
        1000,
      );
      await $.pumpAndSettle();

      // finds the pet tile and taps it
      await $.dragUntilExists(
        finder: find.byWidgetPredicate(
            (widget) => widget is PetTile && widget.pet?.name == name),
        view: find.byType(MasonryGridView),
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

      // find the announcement tile and taps it
      // await $.tester.scrollUntilVisible(
      //   find.byWidgetPredicate((widget) =>
      //       widget is AnnouncementTile && widget.announcement.pet.name == name),
      //   500,
      //   scrollable: find.byType(PagedListView),
      // );
      // $.pumpAndSettle();

      // await $.tester.tap(find
      //     .byWidgetPredicate((widget) =>
      //         widget is AnnouncementTile &&
      //         widget.announcement.pet.name == name)
      //     .last);
      // await $.pumpAndSettle();

      // finds logout button and taps it
      await $.tap(find.byIcon(Icons.logout));
    },
  );
}
