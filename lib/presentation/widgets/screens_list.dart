import 'package:bloc_bottom_bar/presentation/screens/cart_screen.dart';
import 'package:bloc_bottom_bar/presentation/screens/scroll_anim_test.dart';
import 'package:bloc_bottom_bar/presentation/screens/settings_page.dart';
import 'package:bloc_bottom_bar/presentation/screens/store_app.dart';
import 'package:flutter/material.dart';

const List<Widget> bottomNavScreen = <Widget>[
  StoreApp(),
  Text("Category"),
  Text("Search"),
  ScrollAnimationTest(),
  CartScreen(),
  SettingPage()
];
