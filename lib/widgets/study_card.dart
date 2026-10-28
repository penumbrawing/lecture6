import 'package:flutter/material.dart';

class StudyCard extends StatelessWidget {
  const StudyCard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      // Ink controls paint on this Material, above the card decoration.
      child: Material(type: MaterialType.transparency, child: child),
    );
  }
}
