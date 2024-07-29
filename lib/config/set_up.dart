import 'package:get_it/get_it.dart';
import 'package:postgres/postgres.dart';

import '../utils/utils.dart';

final getIt = GetIt.instance;

Future<void> setUp() async {
  final db = await Connection.open(
    Endpoint(
      host: "localhost",
      database: "test_db",
      username: "user",
      password: "password",
    ),
  );

  final eventRepo = EventRepo(db);

  getIt.registerSingleton<EventRepo>(eventRepo);
}
