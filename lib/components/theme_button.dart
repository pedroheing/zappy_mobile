import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zappy/theme/theme_provider.dart';

class ThemeButton extends ConsumerWidget {
  const ThemeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeProvider);
    return IconButton(
        onPressed: () => ref.read(themeProvider.notifier).toggle(),
        icon: Icon(ref.read(themeProvider.notifier).isDarkMode
            ? Icons.light_mode
            : Icons.dark_mode));
  }
}
