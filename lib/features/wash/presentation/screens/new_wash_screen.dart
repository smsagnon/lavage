import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/wash_bloc.dart';
import '../bloc/wash_event.dart';
import '../bloc/wash_state.dart';
import '../../data/models/service_model.dart';
import '../../data/models/car_body_model.dart';
import '../../data/models/payment_method_model.dart';
import '../widgets/service_item.dart';
import '../../../shared/presentation/widgets/app_layout.dart';
import '../../../auth/data/models/user_model.dart';

class NewWashScreen extends StatefulWidget {
  final User user;

  const NewWashScreen({
    super.key,
    required this.user,
  });

  @override
  State<NewWashScreen> createState() => _NewWashScreenState();
}

class _NewWashScreenState extends State<NewWashScreen> {
  final List<WashService> _selectedServices = [];
  PaymentMethod? _selectedPaymentMethod;
  CarBody? _selectedCarBody;
  double _totalNormalPrice = 0;
  double _totalNegotiatedPrice = 0;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    context.read<WashBloc>().add(LoadWashFormData());
  }

  void _updateTotalPrices() {
    setState(() {
      _totalNormalPrice = _selectedServices.fold(
        0,
        (sum, service) => sum + service.normalPrice,
      );
      _totalNegotiatedPrice = _selectedServices.fold(
        0,
        (sum, service) => sum + service.negotiatedPrice,
      );
    });
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  void _handleNegotiatedPriceChanged(WashService service, double newPrice) {
    final index = _selectedServices.indexOf(service);
    if (index != -1) {
      setState(() {
        _selectedServices[index] = WashService(
          id: service.id,
          name: service.name,
          normalPrice: service.normalPrice,
          negotiatedPrice: newPrice,
          description: service.description,
          isActive: service.isActive,
        );
        _updateTotalPrices();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Nouveau Lavage',
      user: widget.user,
      child: BlocBuilder<WashBloc, WashState>(
        builder: (context, state) {
          if (state is WashLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WashFormLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Services',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...state.availableServices.map((service) {
                            final selectedService = _selectedServices.firstWhere(
                              (s) => s.id == service.id,
                              orElse: () => service,
                            );
                            return ServiceItem(
                              service: selectedService,
                              isSelected: _selectedServices.any((s) => s.id == service.id),
                              onSelectionChanged: (selected) {
                                setState(() {
                                  if (selected ?? false) {
                                    _selectedServices.add(service);
                                  } else {
                                    _selectedServices.removeWhere((s) => s.id == service.id);
                                  }
                                  _updateTotalPrices();
                                });
                              },
                              onNegotiatedPriceChanged: (newPrice) {
                                _handleNegotiatedPriceChanged(selectedService, newPrice);
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Type de véhicule',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<CarBody>(
                            value: _selectedCarBody,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Sélectionner le type',
                            ),
                            items: state.availableCarBodies.map((carBody) {
                              return DropdownMenuItem(
                                value: carBody,
                                child: Text(carBody.name),
                              );
                            }).toList(),
                            onChanged: (CarBody? value) {
                              setState(() {
                                _selectedCarBody = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mode de paiement',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<PaymentMethod>(
                            value: _selectedPaymentMethod,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Sélectionner le mode',
                            ),
                            items: state.availablePaymentMethods.map((method) {
                              return DropdownMenuItem(
                                value: method,
                                child: Text(method.name),
                              );
                            }).toList(),
                            onChanged: (PaymentMethod? value) {
                              setState(() {
                                _selectedPaymentMethod = value;
                                if (!(_selectedPaymentMethod?.requiresDueDate ?? false)) {
                                  _dueDate = null;
                                }
                              });
                            },
                          ),
                          if (_selectedPaymentMethod?.requiresDueDate ?? false) ...[
                            const SizedBox(height: 16),
                            InkWell(
                              onTap: () => _selectDueDate(context),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Date d\'échéance',
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _dueDate != null
                                          ? '${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}'
                                          : 'Sélectionner une date',
                                    ),
                                    const Icon(Icons.calendar_today),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Prix',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ListTile(
                            title: const Text('Prix normal'),
                            trailing: Text(
                              '$_totalNormalPrice FCFA',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text('Prix négocié'),
                            trailing: Text(
                              '$_totalNegotiatedPrice FCFA',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          if (_totalNormalPrice > _totalNegotiatedPrice)
                            ListTile(
                              title: const Text('Économie totale'),
                              trailing: Text(
                                '${_totalNormalPrice - _totalNegotiatedPrice} FCFA',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: Text('Une erreur s\'est produite'),
          );
        },
      ),
    );
  }
}
