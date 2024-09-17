import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_calculoapp/services/send.dart';


class GraphRoute extends StatefulWidget {
  const GraphRoute({super.key});

  @override
  State<GraphRoute> createState() => _GraphRouteState();
}

class _GraphRouteState extends State<GraphRoute> {
  late WebViewController controller;
  TextEditingController functionController = TextEditingController(); // Controlador para a função

  @override
  void initState() {
    super.initState();

    // Inicializa o controlador da WebView
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Permite JavaScript
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Atualizar barra de progresso
          },
          onPageStarted: (String url) {
            // Quando a página começar a carregar
          },
          onPageFinished: (String url) {
            // Quando a página terminar de carregar
          },
          onHttpError: (HttpResponseError error) {
            // Tratar erro HTTP
          },
          onWebResourceError: (WebResourceError error) {
            // Tratar erro ao carregar recursos
          },
          onNavigationRequest: (NavigationRequest request) {
            // Controla a navegação entre URLs
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent; // Bloqueia YouTube
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    // Carregar o arquivo HTML local inicial
    controller.loadFlutterAsset('assets/index.html');
  }

  // Função para gerar o gráfico com base na função inserida
  void generateGraph() async {
  String function = functionController.text.trim();

  if (function.isNotEmpty) {

    // Cria uma instância de SendFunctionData
    final sendFunctionData = SendFunctionData(
      params: {'function': functionController.text},
      resultKey: 'grafico' // Substitua pelo nome da chave esperada na resposta
    );

    // Envia os dados para o endpoint
    final result = await sendFunctionData.sendData('grafico');

    print('Resultado obtido: $result');

    if (result.isNotEmpty && !result.contains('Erro')) {
      // Carrega o HTML na WebView
      controller.loadHtmlString(result);
    } else {
      print('Erro ao gerar gráfico: $result');
    }
  } else {
    print('Nenhuma função foi fornecida.');
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
              'GRÁFICO',
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
      body: Column(
        children: [
          // Campo de texto para o usuário inserir a função
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: functionController,
              decoration: const InputDecoration(
                labelText: 'Digite a função (ex: sin(x), x^2)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Botão para gerar o gráfico
          ElevatedButton(
            onPressed: generateGraph,
            child: const Text('Gerar Gráfico'),
          ),
          const SizedBox(height: 16),

          // Exibe a WebView com o arquivo local
          Expanded(
            child: WebViewWidget(controller: controller),
          ),
        ],
      ),
    );
  }
}
