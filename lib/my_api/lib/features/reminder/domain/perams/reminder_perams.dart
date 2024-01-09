import 'package:equatable/equatable.dart';

class ReminderParams extends Equatable {
  final int? page;
  final String? name;
  final String? birthDate;
  final String? mobile;
  final String? email;
  final String? anniversaryDate;
  final String? eventDate;

  const ReminderParams({
    this.page,
    this.name,
    this.birthDate,
    this.mobile,
    this.email,
    this.anniversaryDate,
    this.eventDate,
  });
  @override
  List<Object?> get props => [
        page,
        name,
        birthDate,
        mobile,
        email,
        anniversaryDate,
        eventDate,
      ];
}
