import 'package:flutter/material.dart';

import '../widgets/study_card.dart';

// 课堂六张任务卡原题未提供；这里实现六种标准主轴对齐，等待对照原题。
const alignmentCases = <(String, MainAxisAlignment)>[
  ('start', MainAxisAlignment.start),
  ('end', MainAxisAlignment.end),
  ('center', MainAxisAlignment.center),
  ('spaceBetween', MainAxisAlignment.spaceBetween),
  ('spaceAround', MainAxisAlignment.spaceAround),
  ('spaceEvenly', MainAxisAlignment.spaceEvenly),
];

class AlignmentPage extends StatelessWidget {
  const AlignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '六种主轴对齐',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Row · 左到右 · 横向占满可用宽度 · 三个色块各宽 36',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              for (final (name, alignment) in alignmentCases) ...[
                StudyCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'mainAxisAlignment: $name',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ColoredBox(
                        color: const Color(0xFFF0F5F4),
                        child: Row(
                          key: Key('alignment-$name'),
                          textDirection: TextDirection.ltr,
                          mainAxisAlignment: alignment,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (var index = 0; index < 3; index++)
                              Container(
                                key: Key('$name-$index'),
                                width: 36,
                                height: 36,
                                alignment: Alignment.center,
                                color: const [
                                  Color(0xFF00796B),
                                  Color(0xFF42A5A0),
                                  Color(0xFFA2D4CD),
                                ][index],
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
