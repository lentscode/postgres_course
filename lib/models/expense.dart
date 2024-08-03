part of "models.dart";

sealed class Expense extends _BaseSqlObject {
  Expense({
    required super.id,
    required this.amount,
    required this.category,
    required this.createdOn,
    required this.description,
  });

  final double amount;
  final String category;
  final String description;
  final DateTime createdOn;
}

class ExpenseImpl extends Expense {
  ExpenseImpl({
    required super.id,
    required super.amount,
    required super.category,
    required super.createdOn,
    required super.description,
  });

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id,
        "amount": amount,
        "category": category,
        "createdOn": createdOn.toIso8601String(),
        "description": description,
      };
}

class ExpenseWithUserId extends Expense {
  ExpenseWithUserId({
    required super.id,
    required super.amount,
    required super.category,
    required super.createdOn,
    required super.description,
    required this.userId,
  });

  ExpenseWithUserId.create({
    required super.amount,
    required super.category,
    required super.createdOn,
    required super.description,
    required this.userId,
  }) : super(id: UuidV4().generate());

  final String userId;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id,
        "amount": amount,
        "category": category,
        "createdOn": createdOn.toIso8601String(),
        "description": description,
        "userId": userId,
      };
}

class ExpenseOfUser extends Expense {
  ExpenseOfUser({
    required super.id,
    required super.amount,
    required super.category,
    required super.createdOn,
    required super.description,
    required this.user,
  });

  final User user;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id,
        "amount": amount,
        "category": category,
        "createdOn": createdOn.toIso8601String(),
        "description": description,
        "user": user.toMap(),
      };
}

extension ExpenseListJson on List<Expense> {
  String toJson() => jsonEncode(map((Expense e) => e.toMap()).toList());
}
