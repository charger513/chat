import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String? titulo;
  const Logo({
    Key? key,
    this.titulo = 'Messenger',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // margin: const EdgeInsets.only(top: 50),
        width: 170,
        child: Column(
          children: [
            Image.asset('assets/tag-logo.png'),
            SizedBox(
              height: 20,
            ),
            Text(
              titulo!,
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
