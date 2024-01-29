import 'dart:convert';
import 'dart:developer';
import 'package:baro_project/models/report.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:baro_project/models/calendar.dart';

class CalendarService {
  final storage = const FlutterSecureStorage();

  Future<List<Calendar>?> getCalendars(int date) async {
    String? accessToken = await storage.read(key: 'accessToken');
    var response = await http.get(Uri.parse('${dotenv.get('SERVER_URL')}/analysis/summary?ym=${date.toString()}'),
        headers: {'accept': 'application/json', 'Authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body['data'] != null) {
        log('레포트 데이터 로드 성공');
        List<Calendar> calendars =
            (body['data'] as List).map((i) => Calendar.fromJson(i as Map<String, dynamic>)).toList();
        return calendars;
      } else {
        log('데이터가 존재하지 않습니다.');
      }
    } else {
      log('레포트 데이터 로드 실패: ${response.statusCode}');
      return null;
    }
    return null;
  }

  Future<Report?> getReport(int id) async {
    String? accessToken = await storage.read(key: 'accessToken');
    var response = await http.get(Uri.parse('${dotenv.get('SERVER_URL')}/analysis/$id'),
        headers: {'accept': 'application/json', 'Authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body['data'] != null) {
        log('레포트 세부 데이터 로드 성공');
        var report = Report.fromJson(body['data']);
        return report;
      } else {
        log('데이터가 존재하지 않습니다.');
      }
    } else {
      log('레포트 세부 데이터 로드 실패: ${response.statusCode}');
      return null;
    }
    return null;
  }
}
