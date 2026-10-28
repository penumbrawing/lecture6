import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: const ProfileCard(),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('profile-card'),
      width: 340,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              OnlineAvatar(),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  key: Key('profile-name'),
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '胡矿',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2428),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '移动应用开发教师',
                      style: TextStyle(fontSize: 12, color: Color(0xFF5F666D)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEDF0F2)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              children: [
                for (final (index, item) in const [
                  ('12', '讲义'),
                  ('50', '题库'),
                  ('3', '阶段'),
                ].indexed)
                  Expanded(
                    child: Column(
                      key: Key('stat-$index'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item.$1,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item.$2,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF5F666D),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEDF0F2)),
          const SizedBox(height: 15),
          Wrap(
            key: const Key('profile-tags'),
            spacing: 8,
            runSpacing: 6,
            children: [
              for (final (label, width) in const [
                ('Flutter', 60.0),
                ('Dart', 52.0),
                ('TraeWork', 76.0),
                ('TraeCode', 76.0),
              ])
                SizedBox(
                  width: width,
                  height: 24,
                  child: Chip(
                    label: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF37474F),
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    backgroundColor: const Color(0xFFE0F2F1),
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnlineAvatar extends StatelessWidget {
  const OnlineAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const Key('profile-avatar'),
      width: 56,
      height: 56,
      child: Stack(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xFF00897B),
            child: Text(
              '胡',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              key: const Key('online-dot'),
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2E9E5B),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
