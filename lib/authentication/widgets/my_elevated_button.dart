import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Function onTap;

  const MyElevatedButton(
      {super.key,
      required this.width,
      required this.height,
      required this.child,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(2)),
          minimumSize: WidgetStateProperty.all<Size>(Size(width, height)),
          foregroundColor: WidgetStatePropertyAll<Color>(
              Theme.of(context).colorScheme.inverseSurface),
          backgroundColor: WidgetStatePropertyAll<Color>(
              Theme.of(context).colorScheme.surface)),
      child: child,
    );
  }
}
