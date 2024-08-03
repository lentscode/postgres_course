library models;

import "dart:convert";

import "package:uuid/v4.dart";

part "expense.dart";
part "user.dart";

sealed class _BaseSqlObject {
  const _BaseSqlObject({required this.id});

  final String id;

  Map<String, dynamic> toMap();

  String toJson() => jsonEncode(toMap());
}
