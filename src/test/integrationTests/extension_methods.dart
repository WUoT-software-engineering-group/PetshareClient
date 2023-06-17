import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

extension PumpUntilFound on PatrolTester {
  Future<void> pumpUntilFound(
    Finder finder, {
    Duration duration = const Duration(milliseconds: 100),
    int tries = 10,
  }) async {
    for (var i = 0; i < tries; i++) {
      await pump(duration);

      final result = finder.precache();

      if (result) {
        finder.evaluate();

        break;
      }
    }
  }
}
