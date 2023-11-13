import 'package:flutter/material.dart';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/settings_bloc.dart';
import 'constants/constants.dart';
import 'home_page/home_page.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsBloc(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) =>
          BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          ColorScheme lightCustomColorScheme =
              ColorScheme.fromSeed(seedColor: state.accentColor).harmonized();
          ColorScheme darkCustomColorScheme = ColorScheme.fromSeed(
            seedColor: state.accentColor,
            brightness: Brightness.dark,
          ).harmonized();

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppWideConstants.appTitle,
            theme: ThemeData(
              colorScheme:
                  state.accentColorSource != AccentColorSource.material3
                      ? lightCustomColorScheme
                      : lightDynamic?.harmonized() ?? lightCustomColorScheme,
              iconTheme: const IconThemeData(
                size: kdefaultIconSize,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme:
                  state.accentColorSource != AccentColorSource.material3
                      ? darkCustomColorScheme.harmonized()
                      : darkDynamic?.harmonized() ??
                          darkCustomColorScheme.harmonized(),
              iconTheme: const IconThemeData(
                size: kdefaultIconSize,
              ),
              useMaterial3: true,
            ),
            themeMode: state.themeMode,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
