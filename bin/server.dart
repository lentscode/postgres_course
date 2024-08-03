import "dart:io";

import "package:postgres_course/config/set_up.dart";
import "package:postgres_course/routes/get_expenses.dart";
import "package:postgres_course/routes/routes.dart";
import "package:shelf/shelf.dart";
import "package:shelf/shelf_io.dart";
import "package:shelf_router/shelf_router.dart";

// Configure routes.
final Router _router = Router()
  ..post("/register", register)
  ..post("/createExpense", createExpense)
  ..get("/getExpenses/<userId>", getExpenses);

void main(List<String> args) async {
  await setUp();
  // Use any available host or container IP (usually `0.0.0.0`).
  final InternetAddress ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final Handler handler = Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final int port = int.parse(Platform.environment["PORT"] ?? "8080");
  final HttpServer server = await serve(handler, ip, port);
  print("Server listening on port ${server.port}");
}
