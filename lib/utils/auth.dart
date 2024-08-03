part of "utils.dart";

class Auth {
  const Auth(this.db);
  final Connection db;

  Future<UserAuth> createUser(String email, String password) async {
    final String passwordHash = hashPassword(password);

    UserAuth user = UserAuth.create(email: email, passwordHash: passwordHash);

    user = await getIt.get<UserRepo>().insertItem(user);

    return user;
  }

  Future<User?> getUserByEmail(String email) async {
    final Result result = await db.execute(
      Sql.named("""
      SELECT id, email FROM users
      WHERE email=@email
      """),
      parameters: <String, String>{
        "email": email,
      },
    );

    final ResultRow? item = result.firstOrNull;

    if (item == null) {
      return null;
    }

    return UserImpl(
      id: item[0] as String,
      email: item[1] as String,
    );
  }

  static String hashPassword(String password) {
    final Uint8List bytes = utf8.encode(password);

    final Digest digest = sha256.convert(bytes);

    return digest.toString();
  }
}
