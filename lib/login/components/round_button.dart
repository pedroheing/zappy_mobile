import 'package:flutter/material.dart';
import 'package:zappy/constants.dart';

class ElevatedRoundButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;

  const ElevatedRoundButton(
      {Key? key, this.onPressed, required this.child, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.symmetric(vertical: 13);
    return ElevatedButton(
        style: style != null
            ? style!.copyWith(
                padding:
                    ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(edgeInsets),
                shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
                    roundedRectangleBorder))
            : ElevatedButton.styleFrom(
                padding: edgeInsets, shape: roundedRectangleBorder),
        onPressed: onPressed,
        child: child);
  }
}
