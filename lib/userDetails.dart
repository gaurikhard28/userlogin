class userDetails {
  final String Authorization;
  final String name;
  final String address;
  final String email ;
  final String phone;


  userDetails( { required this.Authorization, required this.name, required this.address, required this.email, required this.phone });

  factory userDetails.fromJson(Map<String, dynamic> json) {
    return userDetails(

      Authorization: json['Authorization'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );
  }

  @override
  String toString() {
    return 'userDetails{ email: $email, name: $name, phone: $phone, Authorization: $Authorization  }';
  }
}