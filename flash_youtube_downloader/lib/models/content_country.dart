import 'package:equatable/equatable.dart';

class ContentCountry extends Equatable {
  final String countryName;
  final String countryCode;

  const ContentCountry({required this.countryName, required this.countryCode});

  Map<String, String> toMap() {
    return {
      "name": countryName,
      "code": countryCode,
    };
  }

  factory ContentCountry.fromJson(Map<String, String> map) {
    return ContentCountry(
      countryName: map['name']!,
      countryCode: map['code']!,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        countryCode,
        countryName,
      ];
}
