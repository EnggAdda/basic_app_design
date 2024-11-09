import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Service {
  final String name;
  final String imageUrl;
  final double price;
  final String deliveryTime;

  Service({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.deliveryTime,
  });
}
