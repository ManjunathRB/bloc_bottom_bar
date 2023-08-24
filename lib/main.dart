import 'package:bloc_bottom_bar/bloc/landing_page_bloc/landing_page_bloc.dart';
import 'package:bloc_bottom_bar/bloc/store%20bloc/bloc/store_bloc.dart';
import 'package:bloc_bottom_bar/cubit/settings_cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/routes/generated_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LandingPageBloc()),
        BlocProvider(create: (context) => SettingsCubit(context)),
        BlocProvider(
            create: (context) => StoreBloc()..add(StoreProductsRequested())),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Landing Page',
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            initialRoute: '/',
            onGenerateRoute: RoouteGenerator().generateRoute,
          );
        },
      ),
    );
  }
}
