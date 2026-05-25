import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';

class FloatingAddButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String tooltip;

  const FloatingAddButton({
    Key? key,
    required this.onPressed,
    this.icon = Icons.add_rounded,
    this.tooltip = 'Add task',
  }) : super(key: key);

  @override
  State<FloatingAddButton> createState() => _FloatingAddButtonState();
}

class _FloatingAddButtonState extends State<FloatingAddButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPressDown() {
    _controller.forward();
  }

  void _onPressUp() {
    _controller.reverse();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _onPressDown(),
      onTapUp: (_) => _onPressUp(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 8,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          tooltip: widget.tooltip,
          shape: const CircleBorder(),
          child: Icon(
            widget.icon,
            size: 28,
          ),
        ),
      ),
    );
  }
}
