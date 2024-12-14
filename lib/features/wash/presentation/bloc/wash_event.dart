import 'package:equatable/equatable.dart';
import '../../data/models/car_wash_model.dart';
import '../../data/models/service_model.dart';
import '../../data/models/car_body_model.dart';
import '../../data/models/payment_method_model.dart';
import '../../data/models/employee_model.dart';
import '../../data/models/client_model.dart';

abstract class WashEvent extends Equatable {
  const WashEvent();

  @override
  List<Object?> get props => [];
}

class LoadWashFormData extends WashEvent {}

class UpdateSelectedServices extends WashEvent {
  final List<WashService> services;

  const UpdateSelectedServices(this.services);

  @override
  List<Object?> get props => [services];
}

class UpdatePaymentMethod extends WashEvent {
  final PaymentMethod paymentMethod;

  const UpdatePaymentMethod(this.paymentMethod);

  @override
  List<Object?> get props => [paymentMethod];
}

class UpdateCarBody extends WashEvent {
  final CarBody carBody;

  const UpdateCarBody(this.carBody);

  @override
  List<Object?> get props => [carBody];
}

class UpdateEmployees extends WashEvent {
  final List<Employee> employees;

  const UpdateEmployees(this.employees);

  @override
  List<Object?> get props => [employees];
}

class UpdateClient extends WashEvent {
  final Client? client;

  const UpdateClient(this.client);

  @override
  List<Object?> get props => [client];
}

class UpdateAbout extends WashEvent {
  final String about;

  const UpdateAbout(this.about);

  @override
  List<Object?> get props => [about];
}

class SubmitCarWash extends WashEvent {
  final CarWash carWash;

  const SubmitCarWash(this.carWash);

  @override
  List<Object?> get props => [carWash];
}
