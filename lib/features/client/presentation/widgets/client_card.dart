import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import '../../data/models/client_list_model.dart';
import '../screens/client_wash_history_screen.dart';
import '../../../auth/data/models/user_model.dart';

class ClientCard extends StatelessWidget {
  final ClientList client;
  final VoidCallback onTap;
  final User user;

  const ClientCard({
    super.key,
    required this.client,
    required this.onTap,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    // Placeholder data - Replace with actual data from your backend
    int washesThisMonth = 3;
    double totalMoneyThisMonth = 27000;
    int washesLastMonth = 2;
    double totalMoneyLastMonth = 18000;

    int washDifference = washesThisMonth - washesLastMonth;
    double moneyDifference = totalMoneyThisMonth - totalMoneyLastMonth;
    double washPercentageChange = washesLastMonth == 0 ? 100 : (washDifference / washesLastMonth) * 100;
    double moneyPercentageChange = totalMoneyLastMonth == 0 ? 100 : (moneyDifference / totalMoneyLastMonth) * 100;

    final numberFormat = NumberFormat("#,##0", "fr_FR");
    final percentageFormat = NumberFormat("#,##0.00", "fr_FR");

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    backgroundImage: client.photoPath != null
                        ? FileImage(File(client.photoPath!))
                        : null,
                    child: client.photoPath == null
                        ? Text(
                            client.firstname[0],
                            style: const TextStyle(color: Colors.white),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          client.fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          client.type.displayName,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(client.phone),
                        if (client.email != null && client.email!.isNotEmpty)
                          Text(client.email!),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 16),
              // Monthly Statistics
              _buildMonthStatSection(context, 'Ce mois', washesThisMonth, totalMoneyThisMonth),
              const SizedBox(height: 8),
              _buildMonthStatSection(context, 'Mois dernier', washesLastMonth, totalMoneyLastMonth),
              const SizedBox(height: 8),
              // Difference
              _buildDifferenceRow(context, washDifference, moneyDifference, washPercentageChange, moneyPercentageChange),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClientWashHistoryScreen(
                        client: client,
                        user: user,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Historique lavage',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthStatSection(BuildContext context, String title, int washes, double money) {
    final numberFormat = NumberFormat("#,##0", "fr_FR");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('${washes} lavages effectué'),
        Text('${numberFormat.format(money)} FCFA'),
      ],
    );
  }

  Widget _buildDifferenceRow(BuildContext context, int washDiff, double moneyDiff, double washPercentageChange, double moneyPercentageChange) {
    Color diffColor = moneyDiff >= 0 ? Colors.green : Colors.red;
    final numberFormat = NumberFormat("#,##0", "fr_FR");
    final percentageFormat = NumberFormat("#,##0.00", "fr_FR");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Différence',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${washDiff} lavage(s), ${numberFormat.format(moneyDiff)} FCFA',
              style: TextStyle(color: diffColor),
            ),
            Text(
              'Lavages: ${washDiff >= 0 ? '+' : ''}${percentageFormat.format(washPercentageChange)}%, '
              'Montant: ${moneyDiff >= 0 ? '+' : ''}${percentageFormat.format(moneyPercentageChange)}%',
              style: TextStyle(color: diffColor, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
