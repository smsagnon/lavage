import 'package:equatable/equatable.dart';
import '../../data/models/employee_list_model.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object?> get props => [];
}

class LoadEmployees extends EmployeeEvent {}

class AddEmployee extends EmployeeEvent {
  final EmployeeList employee;

  const AddEmployee(this.employee);

  @override
  List<Object?> get props => [employee];
}

class UpdateEmployee extends EmployeeEvent {
  final EmployeeList employee;

  const UpdateEmployee(this.employee);

  @override
  List<Object?> get props => [employee];
}
