import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'landing_page_event.dart';
part 'landing_page_state.dart';

class LandingPageBloc extends Bloc<LandingPageEvent, LandingPageState> {
  LandingPageBloc() : super(const LandingPageInitial(0)) {
    on<LandingPageEvent>((event, emit) {
      if (event is TabChange) {
        emit(LandingPageInitial(event.tabIndex));
      }
    });
  }
}
