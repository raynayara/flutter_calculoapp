import 'package:flutter/material.dart';
import 'package:flutter_calculoapp/services/send.dart';

class DerivadaImplicitaPage extends StatefulWidget {
  @override
  State<DerivadaImplicitaPage> createState() => _DerivadaImplicitaPageState();
}

class _DerivadaImplicitaPageState extends State<DerivadaImplicitaPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController funcController = TextEditingController();
  String selectedVariable = 'x'; // Variável selecionada
  String result = ''; // Armazena o resultado da API

  // Função para chamar a API
  Future<void> fetchDerivadaImplicita(String func, String variable) async {
    final sendFunctionData = SendFunctionData(
      params: {
        'function': funcController.text,
        'variable': variable, // Envia a variável selecionada
      },
      resultKey: 'derivada_implicita',
    );

    try {
      final response = await sendFunctionData.sendData('derivada_implicita');
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

              // Dropdown para selecionar a variável
              DropdownButtonFormField<String>(
                value: selectedVariable,
                decoration: const InputDecoration(
                  labelText: 'Selecione a incógnita',
                  border: OutlineInputBorder(),
                ),
                items: ['x', 'y'].map((String variable) {
                  return DropdownMenuItem<String>(
                    value: variable,
                    child: Text(variable),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedVariable = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Botão para enviar os dados
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    fetchDerivadaImplicita(funcController.text, selectedVariable);
                  }
                },
                child: const Text('Calcular Derivada Implícita'),
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
