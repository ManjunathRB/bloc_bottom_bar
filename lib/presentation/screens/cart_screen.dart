import 'package:bloc_bottom_bar/bloc/landing_page_bloc/landing_page_bloc.dart';
import 'package:bloc_bottom_bar/bloc/store%20bloc/bloc/store_bloc.dart';
import 'package:bloc_bottom_bar/data/models/product.dart';
import 'package:bloc_bottom_bar/presentation/widgets/fade_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hasEmptyCart =
        context.select<StoreBloc, bool>((value) => value.state.cartIds.isEmpty);
    final cartproducts = context.select<StoreBloc, List<Product>>((value) =>
        value.state.products
            .where((product) => value.state.cartIds.contains(product.id))
            .toList());
    return Scaffold(
      body: hasEmptyCart
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Your Cart is Empty"),
                  const SizedBox(height: 10),
                  OutlinedButton(
                      onPressed: () {
                        BlocProvider.of<LandingPageBloc>(context)
                            .add(TabChange(tabIndex: 0));
                      },
                      child: const Text('Add product'))
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            childAspectRatio: .65,
                            crossAxisCount: 2),
                    itemCount: cartproducts.length,
                    itemBuilder: (context, index) {
                      final product = cartproducts[index];

                      return FadeAnimation(
                          (1.0 + index) / 4, CartProductTile(product: product));
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        surfaceTintColor: Colors.red,
                        fixedSize:
                            Size(MediaQuery.of(context).size.width - 30, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text("Checkout")),
                const SizedBox(
                  height: 0,
                )
              ],
            ),
    );
  }
}

class CartProductTile extends StatelessWidget {
  const CartProductTile({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.green,
                      highlightColor: Colors.red,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16)),
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                product.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: OutlinedButton(
                  onPressed: () => context
                      .read<StoreBloc>()
                      .add(StoreProductRemovedFromCart(product.id)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.remove_shopping_cart),
                        SizedBox(width: 10),
                        Text("Remove ")
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}
