part of 'store_bloc.dart';

@immutable
abstract class StoreEvent {
  const StoreEvent();
}

class StoreProductsRequested extends StoreEvent {}

class StoreProductAddedToCart extends StoreEvent {
  final int cartId;

  const StoreProductAddedToCart(this.cartId);
}

class StoreProductRemovedFromCart extends StoreEvent {
  final int cartId;

  const StoreProductRemovedFromCart(this.cartId);
}
