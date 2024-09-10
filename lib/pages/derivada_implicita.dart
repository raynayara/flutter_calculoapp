import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DerivadaImplicitaPage extends StatefulWidget {
  @override
  State<DerivadaImplicitaPage> createState() => _DerivadaImplicitaPageState();
}

class _DerivadaImplicitaPageState extends State<DerivadaImplicitaPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController funcController = TextEditingController();
  String result = ''; // Armazena o resultado da API

  // Função para chamar a API
  Future<void> fetchDerivadaImplicita(String func) async {
    final url = Uri.parse('https://sua-api.com/derivada-implicita');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "func": func,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          result = data['result']; // Assume que o resultado vem no campo 'result'
        });
      } else {
        setState(() {
          result = 'Erro ao calcular a derivada implícita.';
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
              'DERIVADA IMPLÍCITA',
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

              // Botão para enviar os dados
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    fetchDerivadaImplicita(funcController.text);
                  }
                },
                child: const Text('Calcular Derivada Implícita'),
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
