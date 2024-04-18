import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _bannerList = [];

  //파이어스토어에서 배너 가자오기
  getBanners() {
    return _firestore.collection('banners').get().then(
          (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach(
            (doc) {
              setState(
                () {
                  _bannerList.add(doc['images']);
                },
              );
            },
          ),
        );
  }

  @override
  initState() {
    super.initState();
    getBanners();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: _bannerList.map(
        (item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  item,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        },
      ).toList(),
      // pub.dev에서 carousel_slider 검색해서 사용법 확인
      options: CarouselOptions(
        height: 200,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
