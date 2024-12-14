import 'package:flutter/material.dart';
import '../../data/models/service_model.dart';

class ServiceItem extends StatefulWidget {
  final WashService service;
  final bool isSelected;
  final Function(bool?) onSelectionChanged;
  final Function(double) onNegotiatedPriceChanged;

  const ServiceItem({
    super.key,
    required this.service,
    required this.isSelected,
    required this.onSelectionChanged,
    required this.onNegotiatedPriceChanged,
  });

  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  bool _showNegotiationInput = false;
  bool _hasNegotiated = false;
  final _negotiatedPriceController = TextEditingController();

  @override
  void dispose() {
    _negotiatedPriceController.dispose();
    super.dispose();
  }

  void _submitNegotiatedPrice() {
    if (_negotiatedPriceController.text.isNotEmpty) {
      final newPrice = double.tryParse(_negotiatedPriceController.text);
      if (newPrice != null) {
        widget.onNegotiatedPriceChanged(newPrice);
        setState(() {
          _showNegotiationInput = false;
          _hasNegotiated = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final priceDifference = widget.service.normalPrice - widget.service.negotiatedPrice;

    return Column(
      children: [
        CheckboxListTile(
          title: Text(widget.service.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Prix: ${widget.service.normalPrice} FCFA'),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showNegotiationInput = !_showNegotiationInput;
                      });
                    },
                    child: const Text(
                      'Négocié',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  if (_hasNegotiated && priceDifference > 0) ...[
                    const SizedBox(width: 8),
                    Text(
                      '(Économie: $priceDifference FCFA)',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          value: widget.isSelected,
          onChanged: widget.onSelectionChanged,
        ),
        if (_showNegotiationInput)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _negotiatedPriceController,
                    decoration: const InputDecoration(
                      labelText: 'Prix négocié',
                      hintText: 'Entrer le nouveau prix',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: _submitNegotiatedPrice,
                  color: Colors.green,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
