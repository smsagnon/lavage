import 'package:flutter/material.dart';

class SidebarOverlay extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onTap;

  const SidebarOverlay({
    super.key,
    required this.isOpen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isOpen ? 1.0 : 0.0,
      child: IgnorePointer(
        ignoring: !isOpen,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
