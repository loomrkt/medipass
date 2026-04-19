import 'package:flutter/foundation.dart';

enum TicketStatus { enCours, resolu }
enum PlaceType { center, laboratory }

class ChatMessage {
  final String id;
  final String content;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.content,
    required this.isMe,
    required this.timestamp,
  });
}

class Ticket {
  final String id;
  final String title;
  final TicketStatus status;
  final String location;
  final DateTime lastUpdated;
  final List<ChatMessage> messages;

  Ticket({
    required this.id,
    required this.title,
    required this.status,
    required this.location,
    required this.lastUpdated,
    required this.messages,
  });
}

class IADiscussion {
  final String id;
  final String title;
  final String subtitle;
  final DateTime lastUpdated;
  final List<ChatMessage> messages;

  IADiscussion({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.lastUpdated,
    required this.messages,
  });
}

class Place {
  final String id;
  final String name;
  final String description;
  final String address;
  final String timeInfo;
  final PlaceType type;
  final String imagePath; // Local asset or placeholder

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.timeInfo,
    required this.type,
    this.imagePath = '',
  });
}

class MockDataRepository extends ChangeNotifier {
  static final MockDataRepository _instance = MockDataRepository._internal();
  factory MockDataRepository() => _instance;
  MockDataRepository._internal() {
    _initData();
  }

  final List<Ticket> tickets = [];
  final List<IADiscussion> iaDiscussions = [];
  final List<Place> places = [];

  void _initData() {
    tickets.addAll([
      Ticket(
        id: '1',
        title: 'Mal au ventre',
        status: TicketStatus.enCours,
        location: 'Hospital',
        lastUpdated: DateTime.now().subtract(const Duration(hours: 2)),
        messages: [
          ChatMessage(id: 'm1', content: 'Bonjour docteur, j\'ai très mal au ventre.', isMe: true, timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 10))),
          ChatMessage(id: 'm2', content: 'Bonjour. Depuis combien de temps ?', isMe: false, timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 5))),
        ],
      ),
      Ticket(
        id: '2',
        title: 'Infection buccale',
        status: TicketStatus.resolu,
        location: 'Hospital',
        lastUpdated: DateTime.now().subtract(const Duration(days: 60)),
        messages: [
          ChatMessage(id: 'm1', content: 'J\'ai une infection de la gencive.', isMe: true, timestamp: DateTime.now().subtract(const Duration(days: 60, minutes: 10))),
          ChatMessage(id: 'm2', content: 'Voici l\'ordonnance pour votre infection.', isMe: false, timestamp: DateTime.now().subtract(const Duration(days: 60))),
        ],
      )
    ]);

    iaDiscussions.addAll([
      IADiscussion(
        id: '1',
        title: 'Mal au ventre',
        subtitle: 'Mis à jour il y a 2h',
        lastUpdated: DateTime.now().subtract(const Duration(hours: 2)),
        messages: [
          ChatMessage(id: 'm1', content: 'J\'ai très mal au ventre, que faire ?', isMe: true, timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 10))),
          ChatMessage(id: 'm2', content: 'Si la douleur est aiguë et persistante, veuillez consulter immédiatement un médecin. Avez-vous de la fièvre ?', isMe: false, timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 9))),
        ],
      ),
      IADiscussion(
        id: '2',
        title: 'Infection buccale',
        subtitle: 'Mis à jour il y a 2 mois',
        lastUpdated: DateTime.now().subtract(const Duration(days: 60)),
        messages: [
          ChatMessage(id: 'm1', content: 'Comment calmer une rage de dent ?', isMe: true, timestamp: DateTime.now().subtract(const Duration(days: 60, minutes: 10))),
          ChatMessage(id: 'm2', content: 'Vous pouvez prendre un antalgique léger, mais prenez rendez-vous chez votre dentiste le plus tôt possible.', isMe: false, timestamp: DateTime.now().subtract(const Duration(days: 60, minutes: 9))),
        ],
      )
    ]);

    places.addAll([
      Place(
        id: '1',
        name: 'Salfa Andohalo',
        description: 'Izahay mitsabo, jesosy manasitrana',
        address: 'Andohalo',
        timeInfo: '10:30am - 5:30pm',
        type: PlaceType.center,
      ),
      Place(
        id: '2',
        name: 'HJRA Ampefiloha',
        description: 'Hôpital général',
        address: 'Ampefiloha',
        timeInfo: '24h/24',
        type: PlaceType.center,
      ),
      Place(
        id: '3',
        name: 'Laboratoire d\'Analyses Institut Pasteur',
        description: 'Analyses médicales de référence',
        address: 'Ambatofotsy',
        timeInfo: '08:00am - 04:00pm',
        type: PlaceType.laboratory,
      ),
      Place(
        id: '4',
        name: 'Labo Ravo',
        description: 'Labo généraliste rapide',
        address: 'Analakely',
        timeInfo: '07:30am - 06:00pm',
        type: PlaceType.laboratory,
      )
    ]);
  }

  // Actions AI
  String createNewIADiscussion(String title) {
    final String newId = DateTime.now().millisecondsSinceEpoch.toString();
    final discussion = IADiscussion(
      id: newId,
      title: title,
      subtitle: 'Nouveau',
      lastUpdated: DateTime.now(),
      messages: [],
    );
    iaDiscussions.insert(0, discussion);
    notifyListeners();
    return newId;
  }

  void addMessageToIADiscussion(String id, String content) {
    final idx = iaDiscussions.indexWhere((d) => d.id == id);
    if (idx != -1) {
      final discussion = iaDiscussions[idx];
      discussion.messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: content,
          isMe: true,
          timestamp: DateTime.now(),
        )
      );
      notifyListeners();

      // Simulate AI reply
      Future.delayed(const Duration(seconds: 2), () {
        discussion.messages.add(
          ChatMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            content: "Ceci est une réponse automatique de simulation IA concernant : \"$content\".",
            isMe: false,
            timestamp: DateTime.now(),
          )
        );
        notifyListeners();
      });
    }
  }

  // Actions Tickets
  void addMessageToTicket(String id, String content) {
    final idx = tickets.indexWhere((t) => t.id == id);
    if (idx != -1 && tickets[idx].status == TicketStatus.enCours) {
      tickets[idx].messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: content,
          isMe: true,
          timestamp: DateTime.now(),
        )
      );
      notifyListeners();
    }
  }
}
