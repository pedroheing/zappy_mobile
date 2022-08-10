import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zappy/initital/screens/initial_screen.dart';
import 'package:zappy/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zappy/theme/theme.dart';
import 'package:zappy/theme/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // delays the app initialization to prevent flutter bug 
  //where the first pages crashes when the apps opens
  // https://github.com/flutter/flutter/issues/101007
  Future.delayed(const Duration(milliseconds: 200), () {
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    setStatusBarColor(theme);
    return MaterialApp(
        home: const InitialScreen(),
        themeMode: theme,
        theme: CustomThemes.light,
        darkTheme: CustomThemes.dark,
        supportedLocales: L10n.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates);
  }

  setStatusBarColor(ThemeMode theme) {
    if (CustomThemes.dark.appBarTheme.systemOverlayStyle != null &&
        CustomThemes.light.appBarTheme.systemOverlayStyle != null) {
      // necessary because some pages don't have a appBar
      SystemChrome.setSystemUIOverlayStyle(theme == ThemeMode.dark
          ? CustomThemes.dark.appBarTheme.systemOverlayStyle!
          : CustomThemes.light.appBarTheme.systemOverlayStyle!);
    }
  }
}
