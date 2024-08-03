part of "routes.dart";

Future<Response> createExpense(Request req) async {
  final (
    String? userId,
    double? amount,
    String? category,
    DateTime? createdOn,
    String? description,
  ) = await RequestUtils(req).getExpense();

  if (userId == null || amount == null || category == null || createdOn == null || description == null) {
    return Response.badRequest(body: "Missing data");
  }

  final ExpenseWithUserId expense = ExpenseWithUserId.create(
    amount: amount,
    category: category,
    createdOn: createdOn,
    description: description,
    userId: userId,
  );

  await getIt.get<ExpenseRepo>().insertItem(expense);

  return Response.ok(expense.toJson());
}
