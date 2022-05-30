import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Installer>> fetchInstallers(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://app-challenge-api.herokuapp.com/installers'));

  // Use the compute function to run parseInstallers in a separate isolate.
  return compute(parseInstallers, response.body);
}

// A function that converts a response body into a List<Installer>.
List<Installer> parseInstallers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Installer>((json) => Installer.fromJson(json)).toList();
}
class Installer {
  final name;
  final rating;
  final pricePerKm;
  final lat;
  final lng;

  const Installer({
    required this.name,
    required this.rating,
    required this.pricePerKm,
    required this.lat,
    required this.lng,
  });

  factory Installer.fromJson(Map<String, dynamic> json) {
    return Installer(
      name: json['name'],
      rating: json['rating'],
      pricePerKm: json['price_per_km'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
