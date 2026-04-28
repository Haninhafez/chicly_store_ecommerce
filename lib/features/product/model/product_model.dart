import 'package:flutter/material.dart';

class ProductModel {
  final int id;
  final String title;
  final int price;
  final List<ImageModel> images;
  final String description;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.images,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
    title: json['title'],
    price: json['price'],
   images: (json['images'] as List? ?? [])
    .map((e) => ImageModel.fromJson(e))
    .toList(),
    description: json['description'],
  );
}

class ImageModel {
  final String url;
  ImageModel({required this.url});

  factory ImageModel.fromJson(dynamic json) {
    return ImageModel(url: json.toString());
  }
}
