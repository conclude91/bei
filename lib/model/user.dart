class User {
  final int id;
  final String email;
  final String name;
  final String username;
  final String avatar;
  final String phone;
  final String address;
  final String city;
  final String birthday;
  final String gender;
  final String school;
  final int roleId;

  User({
    this.id,
    this.email,
    this.name,
    this.username,
    this.avatar,
    this.phone,
    this.address,
    this.city,
    this.birthday,
    this.gender,
    this.school,
    this.roleId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      username: json['username'],
      avatar: json['avatar'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      birthday: json['birthday'],
      gender: json['gender'],
      school: json['school'],
      roleId: json['role_id'],
    );
  }
}
