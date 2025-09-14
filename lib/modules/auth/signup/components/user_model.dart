enum UserRole {
  petOwner,
  petSitter,
  veterinarian,
  petShop;

  String get displayName {
    switch (this) {
      case UserRole.petOwner:
        return 'Pet Owner';
      case UserRole.petSitter:
        return 'Pet Sitter';
      case UserRole.veterinarian:
        return 'Veterinarian';
      case UserRole.petShop:
        return 'Pet Shop';
    }
  }

  String get description {
    switch (this) {
      case UserRole.petOwner:
        return 'I own pets and need services';
      case UserRole.petSitter:
        return 'I provide pet sitting services';
      case UserRole.veterinarian:
        return 'I am a licensed veterinarian';
      case UserRole.petShop:
        return 'I own/manage a pet shop';
    }
  }
}

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final UserRole role;
  final DateTime createdAt;
  final String? profileImageUrl;
  final bool isVerified;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.createdAt,
    this.profileImageUrl,
    this.isVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      role: UserRole.values.firstWhere(
            (role) => role.name == json['role'],
        orElse: () => UserRole.petOwner,
      ),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      profileImageUrl: json['profileImageUrl'],
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'role': role.name,
      'createdAt': createdAt.toIso8601String(),
      'profileImageUrl': profileImageUrl,
      'isVerified': isVerified,
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    UserRole? role,
    DateTime? createdAt,
    String? profileImageUrl,
    bool? isVerified,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}