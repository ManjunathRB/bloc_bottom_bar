import 'package:bloc_bottom_bar/bloc/landing_page_bloc/landing_page_bloc.dart';
import 'package:bloc_bottom_bar/cubit/settings_cubit/settings_cubit.dart';
import 'package:bloc_bottom_bar/presentation/widgets/appbar_navbar_list.dart';
import 'package:bloc_bottom_bar/presentation/widgets/screens_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LandingPageBloc, LandingPageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: appBarTitles.elementAt(state.tabIndex),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {
                context.read<SettingsCubit>().toggleTheme();
              }, icon: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return themeButton(state);
                },
              ))
            ],
          ),
          body: Center(child: bottomNavScreen.elementAt(state.tabIndex)),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavItems,
            currentIndex: state.tabIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              BlocProvider.of<LandingPageBloc>(context)
                  .add(TabChange(tabIndex: index));
            },
          ),
        );
      },
    );
  }

  Icon themeButton(SettingsState state) {
    if (state is DarkTheme) {
      return const Icon(Icons.sunny);
    } else {
      return const Icon(Icons.nightlight_round_outlined);
    }
  }
}
