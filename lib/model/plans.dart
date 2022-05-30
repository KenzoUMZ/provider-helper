import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Plan {
  final isp;
  final downloadSpeed;
  final uploadSpeed;
  final typeOfInternet;
  final description;
  final pricePerMonth;
  final dataCapacity;

  const Plan(
      {required this.isp,
      required this.downloadSpeed,
      required this.uploadSpeed,
      required this.typeOfInternet,
      required this.description,
      required this.pricePerMonth,
      required this.dataCapacity});

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      isp: json['isp'],
      downloadSpeed: json['download_speed'],
      uploadSpeed: json['upload_speed'],
      typeOfInternet: json['type_of_internet'],
      description: json['data_capacity'],
      pricePerMonth: json['price_per_month'],
      dataCapacity: json['data_capacity'],
    );
  }

}
