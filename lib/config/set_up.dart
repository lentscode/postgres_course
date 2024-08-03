import "package:get_it/get_it.dart";
import "package:postgres/postgres.dart";

import "../utils/utils.dart";

final GetIt getIt = GetIt.instance;

Future<void> setUp() async {
  final Connection connection = await Connection.open(
      Endpoint(
        host: "localhost",
        database: "postgres",
        username: "antonio",
        password: "pass",
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable));

  final UserRepo userRepo = UserRepo(connection);
  final ExpenseRepo expenseRepo = ExpenseRepo(connection);
  final Auth auth = Auth(connection);

  getIt.registerSingleton<UserRepo>(userRepo);
  getIt.registerSingleton<ExpenseRepo>(expenseRepo);
  getIt.registerSingleton<Auth>(auth);

}
