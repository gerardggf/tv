import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

//si falla alguna ejecución del json serializable checkear bien este archio y el .g que no haya alguna variable mal pusta o mal leída

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    required this.username,
  });

  final int id;

  final String username;

  @override
  List<Object?> get props => [
        id,
        username,
      ];

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
