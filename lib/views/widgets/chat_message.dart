import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({Key? key, required this.text, required this.sender})
      : super(key: key);

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          child: CircleAvatar(
            backgroundImage: sender == "Você"
                ? const NetworkImage(
                    'https://img.favpng.com/12/18/7/avatar-clip-art-png-favpng-L8838LhmwHRqHzDmZeFgYha0L.jpg')
                : const NetworkImage(
                    'https://akamai.sscdn.co/uploadfile/letras/fotos/5/2/e/c/52ec003bc1c39e5da0d339219fe3cadc-tb.jpg'),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(1),
                child: Elevation95(
                  type: Elevation95Type.up,
                  child: Text(
                    sender,
                    style: Flutter95.textStyle,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: Flutter95.textStyle,
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ],
    );
  }
}
