import 'dart:convert';

import 'package:responsi1/helpers/api.dart';
import 'package:responsi1/helpers/api_url.dart';
import 'package:responsi1/model/manajemen_stress.dart';

class ManajemenStressBloc {
  static Future<List<ManajemenStress>> getStress() async {
    String apiUrl = ApiUrl.listStress;
    var response = await Api().get(apiUrl);
    print(response);
    var jsonObj = json.decode(response.body);
    print(jsonObj);

    return ManajemenStress.fromJsonList(jsonObj);
  }

  static Future addStress({ManajemenStress? stress}) async {
    String apiUrl = ApiUrl.createStress;
    var body = {
      "stress_factor": stress!.stress_factor,
      "coping_strategy": stress.coping_strategy,
      "stress_level": stress.stress_level.toString()
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateStress({required ManajemenStress stress}) async {
    String apiUrl = ApiUrl.updateStress(stress.id!);
    print(apiUrl);
    var body = {
      "stress_factor": stress.stress_factor,
      "coping_strategy": stress.coping_strategy,
      "stress_level": stress.stress_level.toString()
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    print(response);
    var jsonObj = json.decode(response.body);
    print(jsonObj);
    return jsonObj['status'];
  }

  static Future<bool> deleteStress({int? id}) async {
    String apiUrl = ApiUrl.deleteStress(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
