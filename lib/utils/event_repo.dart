part of "utils.dart";

class EventRepo extends Repo {
  const EventRepo(super.db);

  Future<List<Event>> getAllEvents() async {
    final query = Sql.named(
      "SELECT id, name, start, participants"
      "FROM event;",
    );

    final result = await db.execute(query);

    final events = result
        .map((row) => Event(
              id: row[0] as String,
              name: row[1] as String,
              start: row[2] as DateTime,
              participants: row[3] as List<User>,
            ))
        .toList();

    return events;
  }

  Future<Event?> getEventById(String id) async {
    final query = Sql.named(
      "SELECT id, name, start, participants"
      "FROM event"
      "WHERE id = '@id';",
    );

    final parameters = {"id": id};

    final result = (await db.execute(query, parameters: parameters)).firstOrNull;

    if (result == null) {
      return null;
    }

    final event = Event(
      id: id,
      name: result[0] as String,
      start: result[1] as DateTime,
      participants: result[2] as List<User>,
    );

    return event;
  }

  Future<Event> addEvent(Event event) async {
    final query = Sql.named(
      "INSERT INTO event (id, name, start, participants)"
      "VALUES ('@id', '@name', '@start', @participants);",
    );

    final parameters = {
      "id": event.id,
      "name": event.name,
      "start": event.start,
      "participants": event.participants,
    };

    await db.execute(query, parameters: parameters);

    return event;
  }
}
