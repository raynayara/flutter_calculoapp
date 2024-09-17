import 'package:flutter/material.dart';
import 'package:flutter_calculoapp/services/send.dart';

class MaximosMinimosPage extends StatefulWidget {
  const MaximosMinimosPage({super.key});

  @override
  State<MaximosMinimosPage> createState() => _MaximosMinimosPageState();
}

class _MaximosMinimosPageState extends State<MaximosMinimosPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController funcController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  String result = ''; // Armazena o resultado da API

  // Função para chamar a API de máximos e mínimos
  Future<void> fetchMaximosMinimos(String func, String points) async {
    final sendFunctionData = SendFunctionData(
      params: {
        'function': funcController.text,
        'x': pointController.text.isNotEmpty ? pointController.text.split(',')[0] : '',
        'y': pointController.text.isNotEmpty ? pointController.text.split(',')[1] : '',
      },
      resultKey: 'maximos_minimos',
    );

    try {
      final response = await sendFunctionData.sendData('maximos_minimos');
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
              'MÁXIMOS E MÍNIMOS',
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

              // Campo opcional para os pontos
              TextFormField(
                controller: pointController,
                decoration: const InputDecoration(
                  labelText: 'Digite os pontos (opcional, ex: x=1, y=2)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Botão para calcular máximos e mínimos
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    fetchMaximosMinimos(funcController.text, pointController.text);
                  }
                },
                child: const Text('Calcular Máximos e Mínimos'),
              ),

              const SizedBox(height: 16),

              // Exibir o resultado
              if (result.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
