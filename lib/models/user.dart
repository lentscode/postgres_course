import 'dart:convert';

class User {
  User({
    required this.first,
    required this.last,
    required this.email,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      first: map['first'] as String,
      last: map['last'] as String,
      email: map['email'] as String,
    );
  }

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  final String first;
  final String last;
  final String email;

  User copyWith({
    String? first,
    String? last,
    String? email,
  }) {
    return User(
      first: first ?? this.first,
      last: last ?? this.last,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first': first,
      'last': last,
      'email': email,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'User(first: $first, last: $last, email: $email)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.first == first && other.last == last && other.email == email;
  }

  @override
  int get hashCode => first.hashCode ^ last.hashCode ^ email.hashCode;
}
