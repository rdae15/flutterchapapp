// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textCtrl = TextEditingController();
  final _focusNode = FocusNode();
  final List<ChatMessage> _messages = [];
  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              maxRadius: 14,
              backgroundColor: Colors.blueAccent[100],
              child: const Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 3),
            Text('Elmer Rosado',
                style: TextStyle(color: Colors.blueAccent[100], fontSize: 12)),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            )),
            const Divider(height: 1),
            Container(
              color: Colors.white,
              height: 50,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  _inputChat() {
    return SafeArea(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _textCtrl,
                    onSubmitted: _handlerSubmit,
                    onChanged: (texto) {
                      setState(() {
                        if (texto.trim().isNotEmpty) {
                          _estaEscribiendo = true;
                        } else {
                          _estaEscribiendo = false;
                        }
                      });
                    },
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Envar mensaje'),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Platform.isIOS
                        ? CupertinoButton(
                            onPressed: _estaEscribiendo
                                ? () => _handlerSubmit(_textCtrl.text.trim())
                                : null,
                            child: const Text('Enviar'),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: IconTheme(
                              data: IconThemeData(color: Colors.blue[400]),
                              child: IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                icon: const Icon(Icons.send),
                                onPressed: _estaEscribiendo
                                    ? () =>
                                        _handlerSubmit(_textCtrl.text.trim())
                                    : null,
                              ),
                            ),
                          ))
              ],
            )));
  }

  _handlerSubmit(String texto) {
    if (texto.isEmpty) return;
    print(texto);
    _textCtrl.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: texto,
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaEscribiendo = false;
    });
  }
}
