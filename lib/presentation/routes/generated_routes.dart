import 'package:bloc_bottom_bar/bloc/landing_page_bloc/landing_page_bloc.dart';
import 'package:bloc_bottom_bar/presentation/screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoouteGenerator {
  LandingPageBloc landingPageBloc = LandingPageBloc();
  Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider<LandingPageBloc>.value(
                  value: landingPageBloc,
                  child: const LandingPage(),
                ));
      // case '/cart':
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider<LandingPageBloc>(
      //       create: (context) => LandingPageBloc(),
      //       child: const CartScreen(),
      //     ),
      //   );
      default:
        return _errorRoute();
    }
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Error"),
          ),
          body: const Center(
            child: Text("ERROR"),
          ),
        );
      },
    );
  }
}
