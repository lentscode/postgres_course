part of "utils.dart";

sealed class Repo<T> {
  const Repo(this.db);

  String get tableName;

  final Connection db;

  Future<T> insertItem(T item);

  Future<T?> getItemById(String id);
}
