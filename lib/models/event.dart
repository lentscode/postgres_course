import 'dart:convert';

import 'user.dart';

class Event {
  Event({
    required this.id,
    required this.name,
    required this.start,
    required this.participants,
  });

  factory Event.fromMap(Map<String, dynamic> map) => Event(
        id: map["id"] as String,
        name: map['name'] as String,
        start: DateTime.fromMillisecondsSinceEpoch(map['start'] as int),
        participants: List<User>.from(
          (map['participants'] as List<int>).map<User>(
            (x) => User.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source) as Map<String, dynamic>);

  final String id;
  final String name;
  final DateTime start;
  final List<User> participants;

  Event copyWith({
    String? name,
    DateTime? start,
    List<User>? participants,
  }) =>
      Event(
        id: id,
        name: name ?? this.name,
        start: start ?? this.start,
        participants: participants ?? this.participants,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id,
        'name': name,
        'start': start.millisecondsSinceEpoch,
        'participants': participants.map((x) => x.toMap()).toList(),
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Event(id: $id, name: $name, start: $start, participants: $participants)';
}
