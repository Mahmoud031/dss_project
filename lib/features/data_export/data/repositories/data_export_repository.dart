import '../services/google_sheets_service.dart';

class DataExportRepository {
  final GoogleSheetsService _sheetsService;

  DataExportRepository(this._sheetsService);

  Future<void> exportData(Map<String, dynamic> data) async {
    // Only append the values (not the headers)
    final List<List<dynamic>> sheetData = [
      data.values.toList(), // Only values
    ];
    await _sheetsService.appendData(sheetData);
  }

  Future<List<Map<String, dynamic>>> getExportedData() async {
    final List<List<dynamic>> sheetData = await _sheetsService.getData();
    
    if (sheetData.isEmpty) {
      return [];
    }

    final headers = sheetData[0];
    final List<Map<String, dynamic>> result = [];

    for (var i = 1; i < sheetData.length; i++) {
      final row = sheetData[i];
      final Map<String, dynamic> rowData = {};
      
      for (var j = 0; j < headers.length; j++) {
        if (j < row.length) {
          rowData[headers[j].toString()] = row[j];
        }
      }
      
      result.add(rowData);
    }

    return result;
  }
} 