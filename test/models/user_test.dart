import "dart:convert";

import "package:postgres_course/models/models.dart";
import "package:test/test.dart";

void main() {
  group("User", () {
    final String email = "email@example.com";
    group("UserAuth", () {
      final String passwordHash = "passwordHash";
      test("create()", () {
        final UserAuth user = UserAuth.create(email: email, passwordHash: passwordHash);

        expect(user.id, isA<String>());
        expect(user.email, email);
        expect(user.passwordHash, passwordHash);
      });

      test("toMap()", () {
        final UserAuth user = UserAuth.create(email: email, passwordHash: passwordHash);

        final Map<String, String> mapValidate = <String, String>{
          "id": user.id,
          "email": email,
        };

        final Map<String, dynamic> map = user.toMap();

        expect(map, mapValidate);
      });

      test("toJson()", () {
        final UserAuth user = UserAuth.create(email: email, passwordHash: passwordHash);

        final String jsonValidate = jsonEncode(<String, String>{
          "id": user.id,
          "email": email,
        });

        final String json = user.toJson();

        expect(json, jsonValidate);
      });
    });

    group("UserImpl", () {
      final String id = "id";
      test("Default constructor", () {
        final UserImpl user = UserImpl(id: id, email: email);

        expect(user.id, id);
        expect(user.email, email);
      });

      test("fromMap()", () {
        final UserImpl user = UserImpl.fromMap(<String, String>{"id": id, "email": email});

        expect(user.id, id);
        expect(user.email, email);
      });

      test("toMap()", () {
        final UserImpl user = UserImpl(id: id, email: email);

        final Map<String, String> mapValidate = <String, String>{
          "id": user.id,
          "email": email,
        };

        final Map<String, dynamic> map = user.toMap();

        expect(map, mapValidate);
      });

      test("toJson()", () {
        final UserImpl user = UserImpl(id: id, email: email);

        final String jsonValidate = jsonEncode(<String, String>{
          "id": user.id,
          "email": email,
        });

        final String json = user.toJson();

        expect(json, jsonValidate);
      });
    });
  });
}
