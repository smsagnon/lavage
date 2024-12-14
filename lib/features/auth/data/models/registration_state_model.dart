import 'package:equatable/equatable.dart';
import 'station_model.dart';
import 'user_model.dart';

class RegistrationState extends Equatable {
  final CarWashStation? station;
  final User? user;
  final int currentStep;

  const RegistrationState({
    this.station,
    this.user,
    this.currentStep = 0,
  });

  RegistrationState copyWith({
    CarWashStation? station,
    User? user,
    int? currentStep,
  }) {
    return RegistrationState(
      station: station ?? this.station,
      user: user ?? this.user,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  @override
  List<Object?> get props => [station, user, currentStep];
}
