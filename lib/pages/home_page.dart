import 'package:flutter/material.dart';
import 'package:flutter_calculoapp/pages/derivada_direcional.dart';
import 'package:flutter_calculoapp/pages/derivada_implicita.dart';
import 'package:flutter_calculoapp/pages/graph_route.dart';
import 'package:flutter_calculoapp/pages/plano_tangente.dart';
import 'package:flutter_calculoapp/pages/reta_normal.dart';

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
      body: Stack(
        children: [
          Positioned(
            left: 50,
            top: 170,
            child: Column(
              children: [
                const Text(
                  'Derivada Direcional',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    navigateToPage(context, DerivadaDirecionalPage());
                  },
                  child: Container(
                    width: 90,
                    height: 80,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF03465E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.directions, // Ícone para Derivada Direcional
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 50,
            top: 380,
            child: Column(
              children: [
                const Text(
                  'Derivada Implícita',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    navigateToPage(context, DerivadaImplicitaPage());
                  },
                  child: Container(
                    width: 90,
                    height: 80,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF03465E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons
                            .integration_instructions, // Ícone para Derivada Implícita
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 240,
            top: 380,
            child: Column(
              children: [
                const Text(
                  'Plano Tangente',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    navigateToPage(context, PlanoTangente());
                  },
                  child: Container(
                    width: 90,
                    height: 80,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF03465E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.square_foot, // Ícone para Plano Tangente
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 250,
            top: 170,
            child: Column(
              children: [
                const Text(
                  'Reta Normal',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    navigateToPage(context, RetaNormalPage());
                  },
                  child: Container(
                    width: 90,
                    height: 80,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF03465E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.linear_scale, // Ícone para Reta Normal
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            left: 23,
            top: 100,
            child: Text(
              'VISÃO GERAL',
              style: TextStyle(
                color: Color.fromARGB(255, 7, 7, 7),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          // Novo Container Adicionado
          Positioned(
            left: 50,
            top: 600,
            child: Column(
              children: [
                const Text(
                  'PLOTAR GRÁFICO',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    navigateToPage(context, const GraphRoute());
                  },
                  child: Container(
                    width: 300,
                    height: 80,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF03465E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons
                            .insert_chart_outlined, // Ícone para Plotar Gráfico
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}
