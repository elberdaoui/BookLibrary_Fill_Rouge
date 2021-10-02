import 'package:flutter/material.dart';

class Book {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Book({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
}

// Our demo Products

List<Book> demoProducts = [
  Book(
    id: 1,
    images: [
      "assets/images/BillySummers.jpg",
      // "assets/images/ps4_console_white_2.png",
      // "assets/images/ps4_console_white_3.png",
      // "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    // title: "Wireless Controller for PS4™",
    title: 'Billy Summers',
    price: 64.99,
    description:
        'From legendary storyteller and #1 bestseller Stephen King, whose "restless imagination is a power that cannot be contained," ( The New York Times Book Review) comes a thrilling new novel about a good guy in a bad job.',
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Book(
    id: 2,
    images: [
      "assets/images/greenlights.webp",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Greenlights",
    price: 50.5,
    description:
        'From the Academy Award®-winning actor, an unconventional memoir filled with raucous stories, outlaw wisdom, and lessons learned the hard way about living with greater satisfaction',
    rating: 4.1,
    isPopular: true,
  ),
  Book(
    id: 3,
    images: [
      "assets/images/blindTiger.webp",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "blind Tiger",
    price: 36.55,
    description:
        'The year 1920 comes in with a roar in this rousing and suspenseful novel by #1 New York Times bestselling author Sandra Brown.',
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Book(
    id: 4,
    images: [
      "assets/images/sepiens.webp",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Sapiens : A Brief History of Humankind",
    price: 20.20,
    description: 'No description is available.',
    rating: 4.1,
    isFavourite: true,
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
