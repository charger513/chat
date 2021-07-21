import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarios = [
    Usuario(uid: '1', nombre: 'Mariana', email: 'test1@tet.com', online: true),
    Usuario(uid: '2', nombre: 'Emmanuel', email: 'test2@tet.com', online: true),
    Usuario(uid: '3', nombre: 'Albert', email: 'test3@tet.com', online: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi Nombre',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.black87,
          ),
          onPressed: () {},
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.offline_bolt,
              color: Colors.red[400],
            ),
            // Icon(
            //   Icons.check_circle,
            //   color: Colors.blue[400],
            // ),
          )
        ],
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: usuarios.length,
        itemBuilder: (ctx, index) {
          final usuario = usuarios[index];
          return ListTile(
            title: Text(usuario.nombre),
            leading: CircleAvatar(
              child: Center(
                child: Text(
                  usuario.nombre.substring(0, 2),
                ),
              ),
            ),
            trailing: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: usuario.online ? Colors.green[300] : Colors.red,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          );
        },
        separatorBuilder: (ctx, index) => Divider(),
      ),
    );
  }
}
