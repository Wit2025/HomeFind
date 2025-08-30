import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';
import 'auth/first_start_app/splashscreen.dart';

void main() {
  runApp(const HomeFind());
}

class HomeFind extends StatefulWidget {
  const HomeFind({super.key});

  @override
  State<HomeFind> createState() => _HomeFindState();

  static _HomeFindState? of(BuildContext context) =>
      context.findAncestorStateOfType<_HomeFindState>();
}

class _HomeFindState extends State<HomeFind> {
  Locale _locale = const Locale('lo');

  @override
  void initState() {
    super.initState();
    _loadSavedLocale();
  }

  // โหลดภาษาที่บันทึกไว้
  _loadSavedLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('selected_language');
    if (savedLanguage != null) {
      setState(() {
        _locale = Locale(savedLanguage);
      });
    }
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Find',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'NotoSansLao',
      ),
      locale: _locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SplashScreen(),
    );
  }
}
