import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/employee_list_model.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeList employee;
  final VoidCallback onTap;

  const EmployeeCard({
    super.key,
    required this.employee,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          backgroundImage: employee.photoPath != null
              ? NetworkImage(employee.photoPath!)
              : null,
          child: employee.photoPath == null
              ? Text(
                  employee.firstname[0] + employee.lastname[0],
                  style: const TextStyle(color: Colors.white),
                )
              : null,
        ),
        title: Text(
          employee.fullName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(employee.phone),
            if (employee.contractStartDate != null)
              Text('Début: ${dateFormat.format(employee.contractStartDate!)}'),
            if (employee.contractEndDate != null)
              Text('Fin: ${dateFormat.format(employee.contractEndDate!)}'),
          ],
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
