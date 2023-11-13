import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widgets/widgets.dart';
import '../../constants/ui.dart';
import '../../constants/strings.dart';
import '../../bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(SettingsConstants.appBarTitle),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: kdefaultPadding * 2),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      ThemeMode? newTheme = await showDialog(
                        context: context,
                        builder: (context) => ChoiceDialog<ThemeMode>(
                          options: const [
                            ThemeMode.light,
                            ThemeMode.dark,
                            ThemeMode.system,
                          ],
                          optionNames: const [
                            SettingsConstants.lightThemeName,
                            SettingsConstants.darkThemeName,
                            SettingsConstants.systemThemeName,
                          ],
                          initiallySelectedOption: state.themeMode,
                        ),
                      );

                      if (newTheme == null) return;

                      // ignore: use_build_context_synchronously
                      context
                          .read<SettingsBloc>()
                          .add(SettingsEventThemeModeChangeRequested(newTheme));
                    },
                    child: ListTile(
                      leading: const SettingsIcon(
                        Icons.color_lens_outlined,
                      ),
                      title: const Text(SettingsConstants.themeHeading),
                      subtitle: Text(state.themeModeName),
                    ),
                  ),
                  if (Platform.isAndroid)
                    ListTile(
                      leading: const SettingsIcon(MdiIcons.materialDesign),
                      title: const Text(SettingsConstants.useMaterial3Heading),
                      subtitle:
                          const Text(SettingsConstants.useMaterial3Subheading),
                      trailing: Switch.adaptive(
                        onChanged: (bool value) {
                          context
                              .read<SettingsBloc>()
                              .add(SettingsEventAccentSourceChangeRequested(
                                value
                                    ? AccentColorSource.material3
                                    : AccentColorSource.custom,
                              ));
                        },
                        value: state.accentColorSource ==
                            AccentColorSource.material3,
                      ),
                    ),
                  const ThemeSeedColorTile(),
                  Divider(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const Padding(padding: EdgeInsets.only(top: kdefaultPadding)),
                  const MadeWithFooter(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
