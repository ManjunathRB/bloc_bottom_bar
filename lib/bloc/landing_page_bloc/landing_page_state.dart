part of 'landing_page_bloc.dart';

@immutable
abstract class LandingPageState {
  final int tabIndex;

  const LandingPageState(this.tabIndex);
}

class LandingPageInitial extends LandingPageState {
  const LandingPageInitial(super.tabIndex);
}
