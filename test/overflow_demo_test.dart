import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecture6/overflow_demo.dart';

void main() {
  testWidgets('diagnostic entry reproduces 120px overflow then fixes widths', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: OverflowDemo(initialFixed: false)),
    );
    final failure = tester.takeException();
    expect(failure, isA<FlutterError>());
    expect(failure.toString(), contains('overflowed by 120 pixels'));
    expect(tester.getSize(find.byKey(const Key('debug-row'))).width, 240);
    expect(tester.getSize(find.byKey(const Key('debug-block-0'))).width, 120);
    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    for (var index = 0; index < 3; index++) {
      expect(tester.getSize(find.byKey(Key('debug-block-$index'))).width, 80);
    }
    expect(tester.takeException(), isNull);
  });
}
