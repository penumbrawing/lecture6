import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecture6/main.dart';

void main() {
  testWidgets('profile follows 340 / 16 / 56 / 12 geometry and equal stats', (
    tester,
  ) async {
    await tester.pumpWidget(const MainApp());
    final card = find.byKey(const Key('profile-card'));
    expect(card, findsOneWidget);
    expect(tester.getSize(card).width, 340);
    final avatar = tester.getRect(find.byKey(const Key('profile-avatar')));
    final name = tester.getRect(find.byKey(const Key('profile-name')));
    expect(avatar.width, 56);
    expect(avatar.left - tester.getRect(card).left, 16);
    expect(name.left - avatar.right, 12);
    expect(name.width, 240);
    for (var index = 0; index < 3; index++) {
      expect(
        tester.getSize(find.byKey(Key('stat-$index'))).width,
        closeTo(308 / 3, 0.1),
      );
    }
    expect(
      tester.getSize(find.byKey(const Key('online-dot'))),
      const Size(12, 12),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('six alignment cards position their three blocks correctly', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1000, 1500);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MainApp());
    await tester.tap(find.text('对齐'));
    await tester.pumpAndSettle();
    const names = [
      'start',
      'end',
      'center',
      'spaceBetween',
      'spaceAround',
      'spaceEvenly',
    ];
    for (final name in names) {
      final row = tester.getRect(find.byKey(Key('alignment-$name')));
      final free = row.width - 3 * 36;
      final expected = switch (name) {
        'start' => [0.0, 36.0, 72.0],
        'end' => [free, free + 36, free + 72],
        'center' => [free / 2, free / 2 + 36, free / 2 + 72],
        'spaceBetween' => [0.0, 36 + free / 2, 72 + free],
        'spaceAround' => [free / 6, 36 + free / 2, 72 + free * 5 / 6],
        _ => [free / 4, 36 + free / 2, 72 + free * 3 / 4],
      };
      for (var index = 0; index < 3; index++) {
        final box = tester.getRect(find.byKey(Key('$name-$index')));
        expect(
          box.left - row.left,
          closeTo(expected[index], 0.1),
          reason: '$name block $index',
        );
      }
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('2:1:1 remains fixed when content is long', (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.tap(find.text('弹性'));
    await tester.pumpAndSettle();
    final width0 = tester.getSize(find.byKey(const Key('flex-0'))).width;
    final width1 = tester.getSize(find.byKey(const Key('flex-1'))).width;
    final width2 = tester.getSize(find.byKey(const Key('flex-2'))).width;
    expect(width0, closeTo(width1 * 2, 0.1));
    expect(width1, closeTo(width2, 0.1));
    await tester.tap(find.byKey(const Key('long-text-switch')));
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byKey(const Key('flex-0'))).width, width0);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('省略'));
    await tester.pumpAndSettle();
    final label = tester.widget<Text>(find.byKey(const Key('flex-label-0')));
    expect(label.maxLines, 1);
    expect(label.overflow, TextOverflow.ellipsis);
  });

  testWidgets('stack image loads and overlay stays inside its image', (
    tester,
  ) async {
    await tester.pumpWidget(const MainApp());
    await tester.tap(find.text('层叠'));
    await tester.pumpAndSettle();
    final image = tester.widget<Image>(find.byKey(const Key('overlay-image')));
    await tester.runAsync(
      () => precacheImage(
        image.image,
        tester.element(find.byKey(const Key('overlay-image'))),
      ),
    );
    await tester.pumpAndSettle();
    final frame = tester.getRect(find.byKey(const Key('image-stack')));
    final overlay = tester.getRect(find.byKey(const Key('image-overlay')));
    expect(overlay.left, closeTo(frame.left, 0.1));
    expect(overlay.bottom, closeTo(frame.bottom, 0.1));
    expect(overlay.width, closeTo(frame.width, 0.1));
    expect(tester.takeException(), isNull);
  });

  testWidgets('all pages fit narrow 320px viewport', (tester) async {
    tester.view.physicalSize = const Size(320, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MainApp());
    expect(tester.getSize(find.byKey(const Key('profile-card'))).width, 288);
    for (final title in ['对齐', '弹性', '层叠', '名片']) {
      await tester.tap(find.text(title));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: title);
    }
  });
}
