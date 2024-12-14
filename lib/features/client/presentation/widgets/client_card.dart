import 'package:flutter/material.dart';
import 'dart:io';
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            leading: CircleAvatar(
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
            title: Text(
              client.fullName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
          const Divider(height: 1),
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
    );
  }
}
