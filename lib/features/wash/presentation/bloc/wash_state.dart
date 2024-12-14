import 'package:equatable/equatable.dart';
import '../../data/models/service_model.dart';
import '../../data/models/car_body_model.dart';
import '../../data/models/payment_method_model.dart';
import '../../data/models/employee_model.dart';
import '../../data/models/client_model.dart';

abstract class WashState extends Equatable {
  const WashState();

  @override
  List<Object?> get props => [];
}

class WashInitial extends WashState {}

class WashLoading extends WashState {}

class WashFormLoaded extends WashState {
  final List<WashService> availableServices;
  final List<CarBody> availableCarBodies;
  final List<PaymentMethod> availablePaymentMethods;
  final List<Employee> availableEmployees;
  final List<Client> availableClients;

  const WashFormLoaded({
    required this.availableServices,
    required this.availableCarBodies,
    required this.availablePaymentMethods,
    required this.availableEmployees,
    required this.availableClients,
  });

  @override
  List<Object?> get props => [
    availableServices,
    availableCarBodies,
    availablePaymentMethods,
    availableEmployees,
    availableClients,
  ];
}

class WashSuccess extends WashState {}

class WashError extends WashState {
  final String message;

  const WashError(this.message);

  @override
  List<Object?> get props => [message];
}
