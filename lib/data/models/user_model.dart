class UserModel {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  // final String password;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    // required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] != null && json['id'].toString().isNotEmpty
          ? (json['id'] is int ? json['id'] : int.parse(json['id'].toString()))
          : null, // Or provide a default value
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      // password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      // 'password':
      //     password, // yoki shifrlanmagan parolni yuborish (agar kerak bo'lsa)
      // ... boshqa maydonlar uchun qiymatlarni qo'shish
    };
  }
}
