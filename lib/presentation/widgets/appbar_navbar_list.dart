import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
  BottomNavigationBarItem(icon: Icon(Icons.grid_3x3), label: "Category"),
  BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: "Search"),
  BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline), label: "Favourite"),
  BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag_outlined), label: "Cart"),
  BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined), label: "Settings"),
];

List<Widget> appBarTitles = <Widget>[
  Text(
    "Port Caspian",
    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
  ),
  Text(
    "Category",
    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
  ),
  Text(
    "Search",
    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
  ),
  Text(
    "Favourite",
    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
  ),
  Text(
    "Cart",
    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
  ),
  Text(
    "Settings",
    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
  )
];
