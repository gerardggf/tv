import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'generated/translations.g.dart';
import 'inject_repositories.dart';
import 'presentation/global/controllers/theme_controller.dart';
import 'presentation/global/theme.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/routes/router.dart';

//TODO: flutter_gen not working, so I deactivated it

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.initialRoute,
    this.appRoutes,
  });
  final String initialRoute;
  final Map<String, WidgetBuilder>? appRoutes;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with WidgetsBindingObserver, RouterMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    if (locales?.isNotEmpty ?? false) {
      final locale = locales!.first;
      Repositories.language.setLanguageCode(
        locale.languageCode,
      );
      Intl.defaultLocale = locale.toLanguageTag();
      LocaleSettings.setLocaleRaw(
        locale.languageCode,
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = context.watch();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        initialRoute: widget.initialRoute,
        routes: widget.appRoutes ?? appRoutes,
        theme: getTheme(themeController.darkMode),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: LocaleSettings.supportedLocales,
        locale: TranslationProvider.of(context).flutterLocale,
        onUnknownRoute: (_) => MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Error 404') //Assets.svgs.error404.svg(),
                ),
          ),
        ),
      ),
    );
  }
}
