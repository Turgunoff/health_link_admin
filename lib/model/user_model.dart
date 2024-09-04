class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  // final String password;
  // ... boshqa kerakli maydonlar (ixtisoslik, tajriba, shifoxona va h.k.)

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    // required this.password,
    // ... boshqa maydonlar uchun konstruktor parametrlari
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()), // id turini to'g'ri aylantirish
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      // password: json['password'],
      // ... boshqa maydonlar uchun qiymatlarni olish
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
