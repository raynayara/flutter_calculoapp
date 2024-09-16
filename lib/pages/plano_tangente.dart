import 'package:flutter/material.dart';
import 'package:flutter_calculoapp/services/send.dart';

class PlanoTangente extends StatefulWidget {
  @override
  State<PlanoTangente> createState() => _PlanoTangenteState();
}

class _PlanoTangenteState extends State<PlanoTangente> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController funcController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  String result = ''; // Armazena o resultado da API

 // Função para chamar a API
Future<void> _fetchPlanoTangente() async {
  try {
    // Divide os pontos e verifica se existem exatamente dois
    final points = pointController.text.split(',');
    if (points.length != 2) {
      throw Exception('Por favor, insira exatamente dois pontos (x e y).');
    }

    // Verifica se os pontos podem ser convertidos para números
    final x = double.tryParse(points[0]);
    final y = double.tryParse(points[1]);

    if (x == null || y == null) {
      throw Exception('Pontos inválidos. Certifique-se de inserir números válidos.');
    }

    final sendFunctionData = SendFunctionData(
      params: {
        'function': funcController.text,
        'x': x.toString(),
        'y': y.toString(),
      },
      resultKey: 'plano_tangente',
    );

    final response = await sendFunctionData.sendData('plano_tangente');
    setState(() {
      result = response;
    });
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
              'PLANO TANGENTE',
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
                controller: pointController,
                decoration: const InputDecoration(
                  labelText: 'Digite os pontos (ex: x=1, y=2)',
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

              // Botão para enviar os dados
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _fetchPlanoTangente();
                  }
                },
                child: const Text('Calcular Plano Tangente'),
              ),

              const SizedBox(height: 16),

              // Exibir o resultado
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Resultado',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        result,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}