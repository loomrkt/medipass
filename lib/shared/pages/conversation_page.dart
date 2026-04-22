import 'package:flutter/material.dart';
import '../../../../core/enums/conversation_type.dart';
import 'package:go_router/go_router.dart';

class ConversationPage extends StatefulWidget {
  final ConversationType type;
  final String id;

  const ConversationPage({
    super.key,
    required this.type,
    required this.id,
  });

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _controller = TextEditingController();
  final Color primaryColor = const Color(0xFF2B88F0);
  final Color bgColor = const Color(0xFFF4F7FA);

  final List<Map<String, dynamic>> _messages = [
    {"text": "Bonjour, je suis votre assistant. Comment puis-je vous aider ?", "isMe": false, "time": "10:00"},
    {"text": "Bonjour, j'ai besoin de voir mes derniers résultats.", "isMe": true, "time": "10:02"},
    {"text": "Bien sûr, je prépare le récapitulatif pour vous.", "isMe": false, "time": "10:03"},
  ];

  @override
  Widget build(BuildContext context) {
    final bool isIA = widget.type == ConversationType.ia;

    return Scaffold(
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      appBar: _buildPremiumHeader(context, isIA),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 130, left: 20, right: 20, bottom: 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildCleanMessage(_messages[index]);
              },
            ),
          ),
          _buildMinimalInput(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildPremiumHeader(BuildContext context, bool isIA) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(32)),
          border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1))),
        ),
        child: Row(
          children: [
            // Bouton retour minimaliste
            IconButton(
              onPressed: () => GoRouter.of(context).go("/${isIA ? 'ia' : 'tickets'}"), // Redirection vers la page précédente
              icon: const Icon(Icons.close_rounded, color: Colors.black87, size: 28),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isIA ? "Assistant Intelligent" : "Support Medipass",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    isIA ? "Réponse instantanée" : "Ticket ID: ${widget.id}",
                    style: TextStyle(
                      fontSize: 13,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // Indicateur visuel
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(isIA ? Icons.bolt_rounded : Icons.support_agent_rounded, color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCleanMessage(Map<String, dynamic> msg) {
    bool isMe = msg['isMe'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
            decoration: BoxDecoration(
              color: isMe ? primaryColor : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isMe ? 20 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 20),
              ),
              boxShadow: [
                BoxShadow(
                  color: isMe ? primaryColor.withOpacity(0.2) : Colors.black.withOpacity(0.04),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Text(
              msg['text'],
              style: TextStyle(
                color: isMe ? Colors.white : const Color(0xFF475569),
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            msg['time'],
            style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildMinimalInput() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(fontSize: 15),
              decoration: const InputDecoration(
                hintText: "Demandez n'importe quoi...",
                hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_controller.text.isNotEmpty) {
                setState(() {
                  _messages.add({
                    "text": _controller.text, 
                    "isMe": true, 
                    "time": "Maintenant"
                  });
                  _controller.clear();
                });
              }
            },
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.arrow_upward_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}