import 'package:flutter/material.dart';

class DerivadaImplicitaPage extends StatefulWidget {
  @override
  State<DerivadaImplicitaPage> createState() => _DerivadaImplicitaPageState();
}

class _DerivadaImplicitaPageState extends State<DerivadaImplicitaPage> {
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
    );
  }
}