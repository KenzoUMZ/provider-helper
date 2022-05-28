import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Provider>> fetchProviders(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://app-challenge-api.herokuapp.com/plans'));

  // Use the compute function to run parseProviders in a separate isolate.
  return compute(parseProviders, response.body);
}

// A function that converts a response body into a List<Provider>.
List<Provider> parseProviders(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Provider>((json) => Provider.fromJson(json)).toList();
}

class Provider {
  final isp;
  final download_speed;
  final upload_speed;
  final type_of_internet;
  final description;
  final price_per_month;
  final data_capacity;

  const Provider(
      {required this.isp,
      required this.download_speed,
      required this.upload_speed,
      required this.type_of_internet,
      required this.description,
      required this.price_per_month,
      required this.data_capacity});

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      isp: json['isp'],
      download_speed: json['download_speed'],
      upload_speed: json['upload_speed'],
      type_of_internet: json['type_of_internet'],
      description: json['data_capacity'],
      price_per_month: json['price_per_month'],
      data_capacity: json['data_capacity'],
    );
  }
}