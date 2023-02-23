import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:zepalestrinha_gpt/services/openai_token.dart';

import 'widgets/chat_message.dart';

// Created by Coutinho 2023 - 4fun

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<ChatMessage> _messages = [];
  OpenAI? chatGPT;

  final streamController = StreamController<CTResponse?>.broadcast();

  @override
  void initState() {
    super.initState();
    chatGPT = OpenAI.instance.build(
        token: token,
        baseOption: HttpSetup(receiveTimeout: 6000),
        isLogger: true);
  }

  @override
  void dispose() {
    chatGPT?.close();
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold95(
      title: 'Ze Palestrinha',
      toolbar: Toolbar95(actions: [
        Item95(
          label: 'Arquivo',
          menu: _buildMenu(),
        ),
        const Item95(
          label: 'Editar',
          // onTap: (context) {},
        ),
        const Item95(
          label: 'Salvar',
        ),
      ]),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const Text(
                'Faça qualquer pergunta pro Zé palestrinha',
                style: Flutter95.textStyle,
              ),
              _buildListView(),
              _buildTextComposer(),
            ],
          ),
        ),
      ),
    );
  }

  Menu95 _buildMenu() {
    return Menu95(
      items: [
        MenuItem95(
          value: 1,
          label: 'Novo',
        ),
        MenuItem95(
          value: 2,
          label: 'Abrir',
        ),
        MenuItem95(
          value: 3,
          label: 'Sair',
        ),
      ],
      onItemSelected: (item) {},
    );
  }

  Widget _buildListView() {
    return Column(
      children: [
        Elevation95(
          type: Elevation95Type.down,
          child: SizedBox(
            height: 220,
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.zero,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField95(
            controller: _textEditingController,
          ),
        ),
        Button95(
          onTap: () => _sendMessage(),
          child: const Text('Enviar'),
        ),
      ],
    );
  }

  void _sendMessage() async {
    if (_textEditingController.text.isEmpty) return;
    ChatMessage message =
        ChatMessage(text: _textEditingController.text, sender: "Você");

    setState(() {
      _messages.insert(0, message);
    });

    _textEditingController.clear();

    final request = CompleteText(
      prompt: message.text,
      model: kTranslateModelV3,
    );

    final response = await chatGPT!.onCompleteText(request: request);

    debugPrint(response!.choices[0].text);

    insertNewData(response.choices[0].text);
  }

  void insertNewData(String response) {
    ChatMessage botMessage = ChatMessage(
      text: response,
      sender: "Ze Palestrinha",
    );

    setState(() {
      _messages.insert(0, botMessage);
    });
  }
}
