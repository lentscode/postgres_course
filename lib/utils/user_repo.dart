part of "utils.dart";

class UserRepo extends Repo<User> {
  UserRepo(super.db);

  @override
  String get tableName => "users";

  @override
  Future<User?> getItemById(String id) async {
    final Result result = await db.execute(
      Sql.named("""
      SELECT id, username FROM $tableName
      WHERE id=@id
      """),
    );

    final ResultRow? item = result.firstOrNull;

    if (item == null) {
      return null;
    }

    final UserImpl user = UserImpl(
      id: item[0] as String,
      email: item[1] as String,
    );

    return user;
  }

  @override
  Future<UserAuth> insertItem(covariant UserAuth item) async {
    await db.execute(
      Sql.named("""
      INSERT INTO $tableName (id, email, password_hash) 
      VALUES (@id, @email, @password_hash)
      """),
      parameters: <String, String>{
        "id": item.id,
        "email": item.email,
        "password_hash": item.passwordHash,
      },
    );

    return item;
  }
}
