import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Plan>> fetchPlans(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://app-challenge-api.herokuapp.com/plans'));

  // Use the compute function to run parsePlans in a separate isolate.
  return compute(parsePlans, response.body);
}

// A function that converts a response body into a List<Plan>.
List<Plan> parsePlans(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Plan>((json) => Plan.fromJson(json)).toList();
}

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