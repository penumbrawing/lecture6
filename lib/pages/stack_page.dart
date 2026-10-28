import 'package:flutter/material.dart';

import '../widgets/study_card.dart';
import 'profile_page.dart';

class StackPage extends StatelessWidget {
  const StackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Column(
            children: [
              const StudyCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '头像与在线徽标',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(child: OnlineAvatar()),
                    SizedBox(height: 12),
                    Text(
                      'Stack：头像在底层，徽标在上层。\nPositioned(right: 0, bottom: 0)',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              StudyCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '图片与浮层文字',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Stack(
                          key: const Key('image-stack'),
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              'assets/images/course-avatar.png',
                              key: const Key('overlay-image'),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.none,
                              semanticLabel: '教师仓库提供的示例图片',
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                key: const Key('image-overlay'),
                                padding: const EdgeInsets.all(14),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0x99000000),
                                      Color(0xE6000000),
                                    ],
                                  ),
                                ),
                                child: const Text(
                                  '把文字放在图片上\n本地资源 · Stack + Positioned',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '课程原图为 16×16 像素，放大后保留像素效果；外层 ClipRRect 负责实际剪裁。',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
