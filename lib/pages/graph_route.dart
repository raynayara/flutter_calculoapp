import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GraphRoute extends StatefulWidget {
  const GraphRoute({super.key});

  @override
  State<GraphRoute> createState() => _GraphRouteState();
}

class _GraphRouteState extends State<GraphRoute> {
  late WebViewController controller;

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

    // Carregar arquivo HTML local
    controller.loadFlutterAsset('assets/index.html'); // Carregar arquivo HTML local
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
      body: WebViewWidget(controller: controller), // Exibe a WebView com o arquivo local
    );
  }
}
