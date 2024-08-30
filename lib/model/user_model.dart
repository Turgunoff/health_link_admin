class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String passwordHash;
  // ... boshqa kerakli maydonlar (ixtisoslik, tajriba, shifoxona va h.k.)

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.passwordHash,
    // ... boshqa maydonlar uchun konstruktor parametrlari
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      passwordHash: json['password_hash'],
      // ... boshqa maydonlar uchun qiymatlarni olish
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password':
          passwordHash, // yoki shifrlanmagan parolni yuborish (agar kerak bo'lsa)
      // ... boshqa maydonlar uchun qiymatlarni qo'shish
    };
  }
}
