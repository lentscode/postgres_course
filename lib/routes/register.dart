part of "routes.dart";

Future<Response> register(Request req) async {
  final (String? email, String? password) = await RequestUtils(req).getEmailAndPassword();

  if (email == null || password == null) {
    return Response.badRequest(body: "Email or password missing");
  }

  final User? userWithEmail = await getIt.get<Auth>().getUserByEmail(email);

  if (userWithEmail != null) {
    return Response.forbidden("Invalid credentials");
  }

  final UserAuth user = await getIt.get<Auth>().createUser(email, password);

  return Response.ok(user.toJson());
}
