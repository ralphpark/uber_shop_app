import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber_shop_app/views/screens/category_screen.dart';
import 'package:uber_shop_app/views/screens/inner_screen/category_product.dart';

class CategoryTextWidget extends StatefulWidget {
  const CategoryTextWidget({super.key});

  @override
  State<CategoryTextWidget> createState() => _CategoryTextWidgetState();
}

class _CategoryTextWidgetState extends State<CategoryTextWidget> {
  final Stream<QuerySnapshot> _categoryStream =
      FirebaseFirestore.instance.collection('categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 20,
              )),
          StreamBuilder<QuerySnapshot>(
            stream: _categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading categories...");
              }

              return Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          final categoryData = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ActionChip(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CategoryProductScreen(
                                        categoryData: categoryData,
                                      );
                                    },
                                  ),
                                );
                              },
                              backgroundColor: Colors.pink.shade900,
                              label: Center(
                                child: Text(
                                  categoryData['categoryName'].toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.to(() => CategoryScreen());
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
