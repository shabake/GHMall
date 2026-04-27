import 'package:flutter/material.dart';

class GHButton extends StatelessWidget {
  final Color backGroudColor;
  final String title;
  final VoidCallback? tapAction;

  const GHButton(
    this.title, {
    Key? key,
    this.tapAction,
    this.backGroudColor = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.red,
      ),
      height: 50,
      child: TextButton(
        onPressed: tapAction,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
