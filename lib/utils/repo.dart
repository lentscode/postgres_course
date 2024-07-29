part of "utils.dart";

abstract class Repo {
  const Repo(this.db);

  final Connection db;
}
