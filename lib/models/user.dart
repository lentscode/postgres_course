part of "models.dart";

sealed class User extends _BaseSqlObject {
  const User({required super.id, required this.email});
  final String email;
}

class UserAuth extends User {
  UserAuth.create({
    required super.email,
    required this.passwordHash,
  }) : super(id: UuidV4().generate());

  final String passwordHash;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id,
        "email": email,
      };
}

class UserImpl extends User {
  const UserImpl({required super.id, required super.email});

  factory UserImpl.fromMap(Map<String, dynamic> map) => UserImpl(
        id: map["id"],
        email: map["email"],
      );

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id,
        "email": email,
      };
}

class UserWithExpenses extends User {
  const UserWithExpenses({
    required super.id,
    required super.email,
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id,
        "email": email,
        "expenses": expenses.map((Expense e) => e.toMap()).toList(),
      };
}
