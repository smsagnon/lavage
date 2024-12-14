import 'package:flutter/material.dart';
import 'dart:io';
import '../../data/models/client_list_model.dart';
import '../../../shared/presentation/widgets/app_layout.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../wash/data/models/car_wash_model.dart';
import '../../../wash/data/models/payment_method_model.dart';
import '../../../wash/data/models/car_body_model.dart';

class ClientWashHistoryScreen extends StatelessWidget {
  final ClientList client;
  final User user;

  const ClientWashHistoryScreen({
    super.key,
    required this.client,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual data from API
    final mockWashHistory = [
      CarWash(
        id: '1',
        services: [],
        paymentMethod: const PaymentMethod(
          id: '1',
          name: 'Cash',
        ),
        carBody: const CarBody(
          id: '1',
          name: 'Sedan',
        ),
        normalPrice: 100.0,
        negotiatedPrice: 90.0,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      CarWash(
        id: '2',
        services: [],
        paymentMethod: const PaymentMethod(
          id: '2',
          name: 'Credit',
        ),
        carBody: const CarBody(
          id: '2',
          name: 'SUV',
        ),
        normalPrice: 150.0,
        negotiatedPrice: 130.0,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];

    return AppLayout(
      title: 'Historique de ${client.fullName}',
      user: user,
      child: ListView.builder(
        itemCount: mockWashHistory.length,
        itemBuilder: (context, index) {
          final wash = mockWashHistory[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                'Lavage du ${wash.createdAt.day}/${wash.createdAt.month}/${wash.createdAt.year}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Type de véhicule: ${wash.carBody.name}'),
                  Text('Mode de paiement: ${wash.paymentMethod.name}'),
                  Text('Prix normal: ${wash.normalPrice} FCFA'),
                  Text('Prix négocié: ${wash.negotiatedPrice} FCFA'),
                  if (wash.normalPrice > wash.negotiatedPrice)
                    Text(
                      'Économie: ${wash.normalPrice - wash.negotiatedPrice} FCFA',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
