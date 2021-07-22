import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

final textController = TextEditingController();
final focusNode = FocusNode();

final List<ChatMessage> _messages = [];

bool _estaEscribiendo = false;

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Column(
          children: [
            CircleAvatar(
              maxRadius: 14,
              child: Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue[100],
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Emmanuel Chargoy',
              style: TextStyle(color: Colors.black87, fontSize: 12),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                reverse: true,
                itemBuilder: (ctx, index) {
                  return _messages[index];
                },
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: _inputChat(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: textController,
                onSubmitted: _handleSubmit,
                onChanged: (texto) {
                  setState(() {
                    if (texto.trim().length > 0) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje',
                ),
                focusNode: focusNode,
              ),
            ),

            // Botón enviar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: _estaEscribiendo
                          ? () => _handleSubmit(textController.text)
                          : null,
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: IconButton(
                        icon: Icon(Icons.send),
                        color: Colors.blue[400],
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: _estaEscribiendo
                            ? () => _handleSubmit(textController.text)
                            : null,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmit(String texto) {
    if (texto.length == 0) return;
    focusNode.requestFocus();
    textController.clear();

    final chatMessage = ChatMessage(
      texto: texto.trim(),
      uid: '123',
      animationController: AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 200,
        ),
      ),
    );
    _messages.insert(0, chatMessage);
    chatMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }
}
