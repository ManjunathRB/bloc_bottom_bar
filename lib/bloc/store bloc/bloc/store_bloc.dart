import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_bottom_bar/data/models/product.dart';
import 'package:bloc_bottom_bar/data/repositories/store_repositories.dart';
import 'package:flutter/material.dart';
part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepositories api = StoreRepositories();
  StoreBloc() : super(StoreState()) {
    on<StoreProductsRequested>(_storeProductsRequested);
    on<StoreProductAddedToCart>(_storeProductAddedToCart);
    on<StoreProductRemovedFromCart>(_storeProductRemovedFromCart);
  }

  FutureOr<void> _storeProductsRequested(
      StoreProductsRequested event, Emitter<StoreState> emit) async {
    try {
      emit(state.copyWith(
        productStatus: StoreRequest.requestInProgress,
      ));
      final response = await api.getProducts();
      emit(state.copyWith(
        productStatus: StoreRequest.requestSuccess,
        products: response,
      ));
    } catch (e) {
      emit(state.copyWith(
        productStatus: StoreRequest.requestFailure,
      ));
    }
  }

  FutureOr<void> _storeProductAddedToCart(
      StoreProductAddedToCart event, Emitter<StoreState> emit) async {
    emit(state.copyWith(cartIds: {...state.cartIds, event.cartId}));
  }

  FutureOr<void> _storeProductRemovedFromCart(
      StoreProductRemovedFromCart event, Emitter<StoreState> emit) {
    emit(state.copyWith(cartIds: {...state.cartIds}..remove(event.cartId)));
  }
}
