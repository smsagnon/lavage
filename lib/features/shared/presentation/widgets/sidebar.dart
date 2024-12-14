import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onClose;

  const Sidebar({
    super.key,
    required this.isOpen,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: 0,
      bottom: 0,
      right: isOpen ? 0 : -300,
      width: 300,
      child: Material(
        elevation: 8,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: onClose,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Settings'),
                      onTap: () {
                        // Handle settings navigation
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Profile'),
                      onTap: () {
                        // Handle profile navigation
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.help),
                      title: const Text('Help'),
                      onTap: () {
                        // Handle help navigation
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () {
                        // Handle logout
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
