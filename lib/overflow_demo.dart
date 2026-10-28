import 'package:flutter/material.dart';

// Separate diagnostic entry point. The normal application does not overflow.
void main() => runApp(const MaterialApp(home: OverflowDemo()));

class OverflowDemo extends StatefulWidget {
  const OverflowDemo({super.key, this.initialFixed = true});
  final bool initialFixed;

  @override
  State<OverflowDemo> createState() => _OverflowDemoState();
}

class _OverflowDemoState extends State<OverflowDemo> {
  late bool _fixed = widget.initialFixed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('溢出定位练习')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('父级宽 240，三个子项各请求 120。关闭开关会故意触发溢出。'),
            SwitchListTile(
              title: const Text('使用 Expanded 修复'),
              value: _fixed,
              onChanged: (value) => setState(() => _fixed = value),
            ),
            const SizedBox(height: 16),
            SizedBox(
              key: const Key('debug-parent'),
              width: 240,
              child: Row(
                key: const Key('debug-row'),
                children: List.generate(3, (index) {
                  final block = Container(
                    key: Key('debug-block-$index'),
                    width: 120,
                    height: 64,
                    color: [Colors.teal, Colors.orange, Colors.blue][index],
                    alignment: Alignment.center,
                    child: Text('块 ${index + 1}'),
                  );
                  return _fixed ? Expanded(child: block) : block;
                }),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _fixed
                  ? '修后：每块实际宽 80，父约束覆盖子项请求的 120。'
                  : '修前：120 × 3 = 360，比 240 多 120，出现黄黑警告。',
            ),
            const Text('在 Inspector 中分别选中 Row 和三个子项，记录 constraints 与 size。'),
          ],
        ),
      ),
    );
  }
}
