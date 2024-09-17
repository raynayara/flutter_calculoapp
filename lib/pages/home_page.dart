import 'package:flutter/material.dart';
import 'package:flutter_calculoapp/pages/derivada_direcional.dart';
import 'package:flutter_calculoapp/pages/derivada_implicita.dart';
import 'package:flutter_calculoapp/pages/graph_route.dart';
import 'package:flutter_calculoapp/pages/plano_tangente.dart';
import 'package:flutter_calculoapp/pages/reta_normal.dart';
import 'package:flutter_calculoapp/pages/maximos_minimos.dart'; // Import da página de máximos e mínimos

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 238, 251),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(66.0),
        child: AppBar(
          title: const Center(
            child: Text(
              'CALCULADORA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          flexibleSpace: Container(
            width: 350,
            height: 100,
            decoration: const BoxDecoration(
              color: Color(0xFF03465E),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          // Primeira linha: Derivada Direcional e Derivada Implícita
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtonWithLabel(
                context,
                'Derivada Direcional',
                Icons.directions,
                DerivadaDirecionalPage(),
              ),
              _buildButtonWithLabel(
                context,
                'Derivada Implícita',
                Icons.integration_instructions,
                DerivadaImplicitaPage(),
              ),
            ],
          ),
          const SizedBox(height: 50),

          // Segunda linha: Plano Tangente e Reta Normal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtonWithLabel(
                context,
                'Plano Tangente',
                Icons.square_foot,
                PlanoTangente(),
              ),
              _buildButtonWithLabel(
                context,
                'Reta Normal',
                Icons.linear_scale,
                RetaNormalPage(),
              ),
            ],
          ),
          const SizedBox(height: 50),

          // Terceira linha: Máximos e Mínimos
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButtonWithLabel(
                context,
                'Máximos e Mínimos',
                Icons.trending_up, // Ícone representando máximos e mínimos
                MaximosMinimosPage(), // Navegar para a página de máximos e mínimos
                width: MediaQuery.of(context).size.width * 0.7, // Botão mais largo para centralizar
              ),
            ],
          ),
          const Spacer(),

          // Botão para plotar gráfico centralizado
          _buildButtonWithLabel(
            context,
            'PLOTAR GRÁFICO',
            Icons.insert_chart_outlined,
            const GraphRoute(),
            width: MediaQuery.of(context).size.width * 0.7, // Responsividade
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildButtonWithLabel(BuildContext context, String label, IconData icon, Widget page, {double width = 90}) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            navigateToPage(context, page);
          },
          child: Container(
            width: width,
            height: 80,
            decoration: ShapeDecoration(
              color: const Color(0xFF03465E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
