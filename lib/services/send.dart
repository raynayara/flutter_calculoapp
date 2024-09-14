import 'package:http/http.dart' as http;
import 'dart:convert';

class SendFunctionData {
  final Map<String, String>? params;
  final String resultKey;

  const SendFunctionData({
    this.params,
    required this.resultKey,
  });

 Future<String> sendData(String endpoint) async {
    final url = Uri.parse('https://3d7d8b0c-4e24-47a6-8778-aa1b83fd2932-00-3mctl2qlxcx1v.picard.replit.dev/$endpoint');

    try {
      final response = await http.get(url.replace(queryParameters: params));
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          // Corrige possíveis problemas de aspas simples
          String responseBody = response.body;

          // Corrige aspas simples para aspas duplas
          if (responseBody.contains("'")) {
            responseBody = responseBody.replaceAll("'", '"');
          }

          final data = json.decode(responseBody);

          if (data is Map<String, dynamic> && data.containsKey(resultKey)) {
            // Obtém o valor do resultado e remove chaves e aspas
            String resultValue = data[resultKey].toString();
            return resultValue
                .replaceAll(RegExp(r'[\{\}\"]'), ''); 
          } else {
            return 'Resultado não encontrado';
          }
        } catch (e) {
         
          return response.body
              .replaceAll(RegExp(r'[\{\}\"]'), ''); 
        }
      } else {
        return 'Erro ao acessar o endpoint: ${response.statusCode}';
      }
    } catch (e) {
      return 'Erro: $e';
    }
  }
}