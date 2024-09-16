import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DerivadaDirecionalPage extends StatefulWidget {
  const DerivadaDirecionalPage({super.key});

  @override
  State<DerivadaDirecionalPage> createState() => _DerivadaDirecionalPageState();
}

class _DerivadaDirecionalPageState extends State<DerivadaDirecionalPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController funcController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  TextEditingController vectorController = TextEditingController(); // Controlador para o vetor
  String result = ''; // Armazena o resultado da API

  // Função para chamar a API
  Future<void> fetchDerivadaDirecional(String func, String points, String vector) async {
    try {
      // Divide os pontos e verifica se existem exatamente 2 ou 3 pontos
      final pointsList = points.split(',');
      if (pointsList.length != 2 && pointsList.length != 3) {
        throw Exception('Por favor, insira exatamente dois ou três pontos.');
      }

      // Divide o vetor de direção e verifica se possui o mesmo número de dimensões que os pontos
      final vectorList = vector.split(',');
      if (vectorList.length != pointsList.length) {
        throw Exception('O vetor de direção deve ter o mesmo número de dimensões que os pontos.');
      }

      // Verifica se os pontos e vetores podem ser convertidos para números
      final parsedPoints = pointsList.map((point) => double.tryParse(point)).toList();
      final parsedVector = vectorList.map((vec) => double.tryParse(vec)).toList();

      if (parsedPoints.contains(null) || parsedVector.contains(null)) {
        throw Exception('Pontos ou vetor inválidos. Certifique-se de inserir números válidos.');
      }

      // URL da API
      final url = Uri.parse('https://sua-api.com/derivada-direcional');
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "func": func,
          "points": points,   // Enviar os pontos
          "vector": vector    // Enviar o vetor de direção
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          result = data['result']; // Assume que o resultado vem no campo 'result'
        });
      } else {
        setState(() {
          result = 'Erro ao calcular a derivada direcional.';
        });
      }
    } catch (e) {
      setState(() {
        result = 'Erro: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 40),
          child: Center(
            child: Text(
              'DERIVADA DIRECIONAL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
        ),
        flexibleSpace: Container(
          width: 360,
          height: 100,
          decoration: const BoxDecoration(
            color: Color(0xFF03465E),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo para a função
              TextFormField(
                controller: funcController,
                decoration: const InputDecoration(
                  labelText: 'Digite a função',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite a função';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Campo para os pontos
              TextFormField(
                controller: pointsController,
                decoration: const InputDecoration(
                  labelText: 'Digite os pontos (ex: 1,2,3)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite os pontos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo para o vetor de direção
              TextFormField(
                controller: vectorController,
                decoration: const InputDecoration(
                  labelText: 'Digite o vetor de direção (ex: 1,0,0)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite o vetor de direção';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Botão para enviar os dados
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    fetchDerivadaDirecional(funcController.text, pointsController.text, vectorController.text);
                  }
                },
                child: const Text('Calcular Derivada Direcional'),
              ),

              const SizedBox(height: 16),

              // Exibir o resultado
              Text(
                result,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
