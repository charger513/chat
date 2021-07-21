import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;

  const BotonAzul({
    Key? key,
    required this.texto,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shape: StadiumBorder(),
      ),
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            texto,
            style: TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }
}
