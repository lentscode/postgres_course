part of "utils.dart";

class RequestUtils {
  const RequestUtils(this.req);
  final Request req;

  Future<Map<String, dynamic>> getBody() async {
    final String payload = await req.readAsString();

    return jsonDecode(payload);
  }

  Map<String, String> getParams() => req.params;

  Future<(String? email, String? password)> getEmailAndPassword() async {
    final Map<String, dynamic> body = await getBody();

    return (body["email"] as String?, body["password"] as String?);
  }

  Future<(String? userId, double? amount, String? category, DateTime? createdOn, String? description)>
      getExpense() async {
    final Map<String, dynamic> body = await getBody();

    return (
      body["userId"] as String?,
      body["amount"] as double?,
      body["category"] as String?,
      _getDate(body["createdOn"] as String?),
      body["description"] as String?
    );
  }

  String? getUserId() {
    final Map<String, dynamic> params = getParams();

    return params["userId"];
  }

  DateTime? _getDate(String? utc) {
    if (utc == null) {
      return null;
    }

    final List<int> parts = utc.split("-").map(int.parse).toList();

    return DateTime.utc(parts[2], parts[1], parts[0]);
  }
}
