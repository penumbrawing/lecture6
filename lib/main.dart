import 'package:flutter/material.dart';

import 'pages/alignment_page.dart';
import 'pages/flex_page.dart';
import 'pages/profile_page.dart';
import 'pages/stack_page.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第六课 · 布局实验',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: const Color(0xFFF2F5F7),
      ),
      home: const LayoutHome(),
    );
  }
}

class LayoutHome extends StatefulWidget {
  const LayoutHome({super.key});

  @override
  State<LayoutHome> createState() => _LayoutHomeState();
}

class _LayoutHomeState extends State<LayoutHome> {
  int _index = 0;
  static const _titles = ['个人名片', '对齐实验', '弹性分配', '层叠与装饰'];
  static const _pages = [
    ProfilePage(),
    AlignmentPage(),
    FlexPage(),
    StackPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_index])),
      body: SafeArea(child: _pages[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() => _index = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.person_outline), label: '名片'),
          NavigationDestination(
            icon: Icon(Icons.align_horizontal_left),
            label: '对齐',
          ),
          NavigationDestination(
            icon: Icon(Icons.view_column_outlined),
            label: '弹性',
          ),
          NavigationDestination(icon: Icon(Icons.layers_outlined), label: '层叠'),
        ],
      ),
    );
  }
}
