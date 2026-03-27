import 'package:flutter/material.dart';

import '../../domain/ai_message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(this.message, {super.key});

  final AiMessage message;

  @override
  Widget build(BuildContext context) {
    final alignment = message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor = message.isUser ? Theme.of(context).colorScheme.primaryContainer : Colors.white;

    return Column(
      crossAxisAlignment: alignment,
      children: <Widget>[
        Container(
          constraints: const BoxConstraints(maxWidth: 320),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(message.text),
        ),
      ],
    );
  }
}
