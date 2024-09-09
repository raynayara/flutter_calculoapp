import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Define a classe principal que estende StatefulWidget, permitindo o gerenciamento de estado
class GraphRoute extends StatefulWidget {
  const GraphRoute({super.key});

  @override
  State<GraphRoute> createState() => _GraphRouteState();
}

// A classe de estado associada à GraphRoute
class _GraphRouteState extends State<GraphRoute> {
  // Declaração do controlador WebView, que será usado para controlar a WebView
  late WebViewController controller;

  // O initState é chamado uma vez quando o widget é inserido na árvore de widgets
  @override
  void initState() {
    super.initState();
    
    // Inicializa o controlador da WebView
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Permite a execução de JavaScript na WebView
      ..setNavigationDelegate(
        // Define as regras de navegação e eventos dentro da WebView
        NavigationDelegate(
          onProgress: (int progress) {
            // Aqui você pode adicionar lógica para atualizar uma barra de progresso enquanto a página carrega
          },
          onPageStarted: (String url) {
            // Chamado quando o carregamento de uma nova página começa
          },
          onPageFinished: (String url) {
            // Chamado quando o carregamento de uma página é concluído
          },
          onHttpError: (HttpResponseError error) {
            // Chamado quando há um erro HTTP na solicitação
          },
          onWebResourceError: (WebResourceError error) {
            // Chamado quando há um erro ao carregar recursos na web
          },
          onNavigationRequest: (NavigationRequest request) {
            // Controla as requisições de navegação. Aqui está bloqueando navegações para o YouTube
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent; // Bloqueia a navegação para o YouTube
            }
            return NavigationDecision.navigate; // Permite a navegação em outras URLs
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev')); // Carrega a URL inicial da WebView
  }

  // Método build, onde é definida a interface do usuário
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
      body: WebViewWidget(controller: controller), // Exibe a WebView dentro do body do Scaffold
    );
  }
}
