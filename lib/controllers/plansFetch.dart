// ignore: file_names
import 'package:provider_helper/model/plans.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

Future<List<Plan>> fetchPlans(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://app-challenge-api.herokuapp.com/plans'));

  // Use the compute function to run parsePlans in a separate isolate.
  return compute(parsePlans, response.body);
}

Future<List<Plan>> fetchPlansByState(http.Client client, String state) async {
  final response = await client.get(
      Uri.parse('https://app-challenge-api.herokuapp.com/plans?state=$state'));

  // Use the compute function to run parsePlans in a separate isolate.
  return parsePlans(response.body).toList();
}

// A function that converts a response body into a List<Plan>.
List<Plan> parsePlans(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Plan>((json) => Plan.fromJson(json)).toList();
}
