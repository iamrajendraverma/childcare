import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';

class HomeRepository {
  final http.Client _client;

  HomeRepository({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> uploadRecording({
    required String filePath,
    required String token,
  }) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return {'success': false, 'message': 'File does not exist'};
      }

      final fileName = file.uri.pathSegments.last;
      final fileSize = await file.length();
      final uploadedAt = DateTime.now().millisecondsSinceEpoch.toString();

      final request = http.MultipartRequest('POST', Uri.parse(ApiConstants.uploadUrl));
      
      // Headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Fields
      request.fields['fileName'] = fileName;
      request.fields['fileSize'] = fileSize.toString();
      request.fields['uploadedAt'] = uploadedAt;

      // File
      request.files.add(await http.MultipartFile.fromPath(
        'file', // Assuming 'file' is the key the server expects
        filePath,
      ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Upload successful',
          'data': responseData['data'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Upload failed with status: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }

  void dispose() {
    _client.close();
  }
}
