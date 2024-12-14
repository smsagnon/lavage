import 'package:equatable/equatable.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object?> get props => [];
}

class LoadClients extends ClientEvent {}
