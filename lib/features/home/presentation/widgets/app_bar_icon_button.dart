import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {

  final IconData icon;
  final VoidCallback onTap;

  const AppBarIconButton({
    super.key,
    required this.icon,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(50)
          ),
          child: Icon(icon, size: 18, color: Colors.grey,)
      ),
    );
  }
}