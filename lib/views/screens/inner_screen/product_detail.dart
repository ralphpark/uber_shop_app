import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uber_shop_app/provider/cart_provider.dart';
import 'package:uber_shop_app/provider/select_size_provider.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final dynamic productData;

  const ProductDetailScreen({super.key, required this.productData});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedSize = ref.watch(selectedSizeProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    final cartItem = ref.watch(cartProvider);
    final isInCart = cartItem.containsKey(widget.productData['productID']);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
            letterSpacing: 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 300,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Image.network(
                      widget.productData['productImages'][_imageIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 50,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['productImages'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _imageIndex = index;
                              });
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.pink.shade900,
                                ),
                              ),
                              child: Image.network(
                                widget.productData['productImages'][index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.productData['productName'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\$' +
                        widget.productData['productPrice'].toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      color: Colors.pink,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Description',
                        style: TextStyle(
                          color: Colors.pink,
                        ),
                      ),
                      Text(
                        'View More',
                        style: TextStyle(color: Colors.pink),
                      ),
                    ],
                  ),
                  children: [
                    Text(
                      widget.productData['description'],
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Variations',
                        style: TextStyle(
                          color: Colors.pink,
                        ),
                      ),
                      Text(
                        'View More',
                        style: TextStyle(color: Colors.pink),
                      ),
                    ],
                  ),
                  children: [
                    Container(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productData['sizeList'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                                onPressed: () {
                                  final newSelected = widget.productData['sizeList'][index];
                                  ref.read(selectedSizeProvider.notifier).setSelectedSize(newSelected);
                                },
                                child: Text(
                                  widget.productData['sizeList'][index],
                                  style: TextStyle(
                                    color: Colors.pink,
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      widget.productData['storeImage'],
                    ),
                  ),
                  title: Text(
                    widget.productData['businessName'],
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  subtitle: Text(
                    "SEE PROFILE",
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: isInCart ? null : () {
                _cartProvider.addProductToCart(
                    widget.productData['productName'],
                    widget.productData['productID'],
                    widget.productData['productImages'],
                    1,
                    widget.productData['productQuantity'],
                    widget.productData['productPrice'],
                    widget.productData['vendorID'],
                    selectedSize
                );
                print(_cartProvider.getCartItems.values.first.productName);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isInCart ? Colors.grey :  Colors.pink.shade900,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.shopping_cart,
                        color: Colors.white,
                      ),
                      Text(isInCart ? "In Cart" : 'Add to Cart',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 5,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.chat_bubble,
                color: Colors.pink.shade900,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.phone,
                color: Colors.pink.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
