import 'package:flutter/material.dart';

import '../widgets/study_card.dart';

class FlexPage extends StatefulWidget {
  const FlexPage({super.key});

  @override
  State<FlexPage> createState() => _FlexPageState();
}

class _FlexPageState extends State<FlexPage> {
  bool _longText = false;
  bool _ellipsis = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: StudyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '三栏比例 2 : 1 : 1',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  '三个 Expanded 分配整行可用宽度；文字变长时，比例保持不变。',
                  style: TextStyle(fontSize: 13),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  key: const Key('long-text-switch'),
                  title: const Text(
                    '第一栏使用超长文字',
                    style: TextStyle(fontSize: 14),
                  ),
                  value: _longText,
                  onChanged: (value) => setState(() => _longText = value),
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('换行'),
                      selected: !_ellipsis,
                      onSelected: (_) => setState(() => _ellipsis = false),
                    ),
                    ChoiceChip(
                      label: const Text('省略'),
                      selected: _ellipsis,
                      onSelected: (_) => setState(() => _ellipsis = true),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '可分配宽度 ${width.toStringAsFixed(1)} dp → ${(width / 2).toStringAsFixed(1)} / ${(width / 4).toStringAsFixed(1)} / ${(width / 4).toStringAsFixed(1)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var index = 0; index < 3; index++)
                              Expanded(
                                flex: index == 0 ? 2 : 1,
                                child: Container(
                                  key: Key('flex-$index'),
                                  constraints: const BoxConstraints(
                                    minHeight: 88,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  color: const [
                                    Color(0xFFB2DFDB),
                                    Color(0xFFDCEDC8),
                                    Color(0xFFFFECB3),
                                  ][index],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'flex ${index == 0 ? 2 : 1}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        index == 0 && _longText
                                            ? '这是一段用于验证布局的超长内容。它变长以后，第一栏仍然只能使用分配到的空间，不会把另外两栏挤走。'
                                            : ['第一栏', '第二栏', '第三栏'][index],
                                        key: Key('flex-label-$index'),
                                        maxLines: _ellipsis ? 1 : null,
                                        softWrap: !_ellipsis,
                                        overflow: _ellipsis
                                            ? TextOverflow.ellipsis
                                            : TextOverflow.clip,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  _ellipsis
                      ? '当前策略：单行显示，超出部分用省略号表示。'
                      : '当前策略：允许换行，内容变长时第一栏高度增加。',
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
