import 'package:bloc_bottom_bar/bloc/landing_page_bloc/landing_page_bloc.dart';
import 'package:bloc_bottom_bar/bloc/store%20bloc/bloc/store_bloc.dart';
// import 'package:bloc_bottom_bar/presentation/screens/cart_screen.dart';
import 'package:bloc_bottom_bar/presentation/widgets/fade_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class StoreApp extends StatefulWidget {
  const StoreApp({super.key});

  @override
  State<StoreApp> createState() => _StoreAppState();
}

class _StoreAppState extends State<StoreApp> {
  void addToCart(int cartId) {
    context.read<StoreBloc>().add(StoreProductAddedToCart(cartId));
  }

  void removeFromCart(int cartId) {
    context.read<StoreBloc>().add(StoreProductRemovedFromCart(cartId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Stack(
          clipBehavior: Clip.none,
          children: [
            FloatingActionButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     PageRouteBuilder(
                //       transitionsBuilder: (_, animation, __, child) {
                //         return SlideTransition(
                //           position:
                //               Tween(begin: const Offset(0, 1), end: Offset.zero)
                //                   .animate(animation),
                //           child: BlocProvider.value(
                //             value: context.read<StoreBloc>(),
                //             child: child,
                //           ),
                //         );
                //       },
                //       pageBuilder: (_, __, ___) => const CartScreen(),
                //     ));
                BlocProvider.of<LandingPageBloc>(context)
                    .add(TabChange(tabIndex: 4));
              },
              tooltip: 'View Cart',
              child: const Icon(Icons.shopping_cart),
            ),
            BlocConsumer<StoreBloc, StoreState>(
              listenWhen: (previous, current) =>
                  previous.cartIds.length != current.cartIds.length,
              listener: (context, state) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(milliseconds: 600),
                    content: Text("Shopping cart updated")));
              },
              builder: (context, state) {
                if (state.cartIds.isEmpty) {
                  return Positioned(right: -4, bottom: 40, child: Container());
                }
                return Positioned(
                  right: -4,
                  bottom: 40,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 12,
                    child: Text(
                      state.cartIds.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            )
          ],
        ),
        body: Center(
          child: BlocBuilder<StoreBloc, StoreState>(builder: (context, state) {
            if (state.productStatus == StoreRequest.requestInProgress) {
              return const CircularProgressIndicator();
            }
            if (state.productStatus == StoreRequest.requestFailure) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Problem Loading Products"),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        context.read<StoreBloc>().add(StoreProductsRequested());
                      },
                      child: const Text("Try again"))
                ],
              );
            }
            if (state.productStatus == StoreRequest.unknown) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No products to view"),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        context.read<StoreBloc>().add(StoreProductsRequested());
                      },
                      child: const Text("Load products"))
                ],
              );
            }

            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  childAspectRatio: .65,
                  crossAxisCount: 2),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                final inCart = state.cartIds.contains(product.id);
                return FadeAnimation(
                    (1.0 + index) / 4,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Card(
                        key: ValueKey(product.id),
                        child: Column(
                          children: [
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: SizedBox(
                                  width: Size.infinite.width,
                                  height: Size.infinite.height,
                                  child: CachedNetworkImage(
                                    imageUrl: product.image,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.green,
                                      highlightColor: Colors.red,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                product.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: OutlinedButton(
                                  onPressed: inCart
                                      ? () => removeFromCart(product.id)
                                      : () => addToCart(product.id),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: inCart
                                          ? Colors.red.withOpacity(0.1)
                                          : Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: inCart
                                        ? const [
                                            Icon(Icons.remove_shopping_cart),
                                            SizedBox(width: 10),
                                            Text("Remove ")
                                          ]
                                        : const [
                                            Icon(Icons.add_shopping_cart),
                                            SizedBox(width: 10),
                                            Text("Add to cart")
                                          ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            );
          }),
        ));
  }
}
