import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String texto;
  final String textoLink;
  final String ruta;

  const Labels({
    Key? key,
    required this.texto,
    required this.textoLink,
    required this.ruta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          texto,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          child: Text(
            textoLink,
            style: TextStyle(
              color: Colors.blue[600],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(ruta);
          },
        )
      ],
    );
  }
}
