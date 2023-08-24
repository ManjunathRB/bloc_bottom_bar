import 'package:bloc_bottom_bar/cubit/settings_cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Tap below button to change theme"),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<SettingsCubit>().toggleTheme();
                  },
                  child: themeButton(state)),
            ],
          );
        },
      )),
    );
  }

  Icon themeButton(SettingsState state) {
    if (state is DarkTheme) {
      return const Icon(Icons.sunny);
    } else {
      return const Icon(Icons.nightlight_round);
    }
  }
}
