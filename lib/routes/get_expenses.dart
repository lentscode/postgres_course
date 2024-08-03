import "package:shelf/shelf.dart";

import "../config/set_up.dart";
import "../models/models.dart";
import "../utils/utils.dart";

Future<Response> getExpenses(Request req) async {
  final String? userId = RequestUtils(req).getUserId();

  if (userId == null) {
    return Response.badRequest(body: "User ID missing");
  }

  final List<Expense> expenses = await getIt.get<ExpenseRepo>().getExpensesOfUser(userId);

  return Response.ok(expenses.toJson());
}
