class Usuario {
  final bool online;
  final String email;
  final String nombre;
  final String uid;

  Usuario({
    required this.online,
    required this.email,
    required this.nombre,
    required this.uid,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json['online'],
        email: json['email'],
        nombre: json['nombre'],
        uid: json['uid'],
      );

  Map<String, dynamic> toJson() => {
        'online': online,
        'email': email,
        'nombre': nombre,
        'uid': uid,
      };
}
