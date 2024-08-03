part of "utils.dart";

class ExpenseRepo extends Repo<Expense> {
  const ExpenseRepo(super.db);

  @override
  String get tableName => "expenses";

  @override
  Future<Expense?> getItemById(String id) async {
    final Result result = await db.execute(
      Sql.named(
        """
        SELECT id, amount, category, created_on, description
        FROM $tableName
        WHERE id=@id
        """,
      ),
      parameters: <String, String>{
        "id": id,
      },
    );

    final ResultRow? item = result.firstOrNull;

    if (item == null) {
      return null;
    }

    final ExpenseImpl expense = ExpenseImpl(
      id: item[0] as String,
      amount: item[1] as double,
      category: item[2] as String,
      createdOn: item[3] as DateTime,
      description: item[4] as String,
    );

    return expense;
  }

  @override
  Future<Expense> insertItem(covariant ExpenseWithUserId item) async {
    await db.execute(
      Sql.named(
        """
        INSERT INTO $tableName (id, amount, category, created_on, description, user_id)
        VALUES (@id, @amount, @category, @created_on, @description, @user_id)
        """,
      ),
      parameters: <String, Object>{
        "id": item.id,
        "amount": item.amount,
        "category": item.category,
        "created_on": item.createdOn,
        "description": item.description,
        "user_id": item.userId,
      },
    );

    return item;
  }

  Future<List<Expense>> getExpensesOfUser(String userId) async {
    final Result result = await db.execute(
      Sql.named(
        """
        SELECT id, amount, category, created_on, description
        FROM $tableName
        WHERE user_id=@user_id
        """,
      ),
      parameters: <String, String>{"user_id": userId},
    );

    final List<ExpenseImpl> expenses = result
        .map((ResultRow e) => ExpenseImpl(
              id: e[0] as String,
              amount: e[1] as double,
              category: e[2] as String,
              createdOn: e[3] as DateTime,
              description: e[4] as String,
            ))
        .toList();

    return expenses;
  }
}
