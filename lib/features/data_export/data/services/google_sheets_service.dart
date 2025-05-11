import 'package:dss_project/core/config/sheets_config.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;


class GoogleSheetsService {
  static const _scopes = [SheetsApi.spreadsheetsScope];
  late final SheetsApi _sheetsApi;
  String? _spreadsheetId;

  Future<void> initialize() async {
    final credentials = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": SheetsConfig.projectId,
      "private_key_id": SheetsConfig.privateKeyId,
      "private_key": SheetsConfig.privateKey,
      "client_email": SheetsConfig.clientEmail,
      "client_id": SheetsConfig.clientId,
    });

    final client = await clientViaServiceAccount(credentials, _scopes);
    _sheetsApi = SheetsApi(client);
    _spreadsheetId = SheetsConfig.spreadsheetId;
  }

  Future<void> appendData(List<List<dynamic>> data) async {
    if (_spreadsheetId == null) {
      throw Exception('Google Sheets not initialized');
    }

    final valueRange = ValueRange(values: data);
    await _sheetsApi.spreadsheets.values.append(
      valueRange,
      _spreadsheetId!,
      'Sheet1!A1',
      valueInputOption: 'USER_ENTERED',
    );
  }

  Future<List<List<dynamic>>> getData() async {
    if (_spreadsheetId == null) {
      throw Exception('Google Sheets not initialized');
    }

    final response = await _sheetsApi.spreadsheets.values.get(
      _spreadsheetId!,
      'Sheet1!A1:Z',
    );

    return response.values ?? [];
  }
} 