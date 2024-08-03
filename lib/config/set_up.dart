import "package:dotenv/dotenv.dart";
import "package:get_it/get_it.dart";
import "package:postgres/postgres.dart";

import "../logic/data/data.dart";
import "../logic/utils/utils.dart";

final GetIt getIt = GetIt.instance;

Future<void> setUp() async {
  final DotEnv env = DotEnv(includePlatformEnvironment: true)..load();
  final Connection connection = await Connection.open(
      Endpoint(
        host: env["DB_HOST"] ?? "localhost",
        database: env["DB_NAME"] ?? "postgres",
        username: env["DB_USERNAME"],
        password: env["DB_PASSWORD"],
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable));

  final UserRepo userRepo = UserRepo(connection);
  final ExpenseRepo expenseRepo = ExpenseRepo(connection);
  final Auth auth = Auth(connection);

  getIt.registerSingleton<UserRepo>(userRepo);
  getIt.registerSingleton<ExpenseRepo>(expenseRepo);
  getIt.registerSingleton<Auth>(auth);
}
