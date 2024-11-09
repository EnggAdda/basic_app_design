import 'package:flutter/material.dart';
import 'SuccessPage.dart';

class OrderPage extends StatefulWidget {
  final List<String> selectedServices;

  OrderPage({required this.selectedServices});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  // Payment mode dropdown value
  String _paymentMode = 'COD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order Summary', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text('Selected Services:', style: TextStyle(fontSize: 18)),
              for (var service in widget.selectedServices)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('- $service', style: TextStyle(fontSize: 16)),
                ),
              SizedBox(height: 20),

              // Address Fields
              Text('Delivery Address', style: TextStyle(fontSize: 18)),
              TextFormField(
                controller: _pinCodeController,
                decoration: InputDecoration(
                  labelText: 'Pin Code',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a pin code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _address1Controller,
                decoration: InputDecoration(
                  labelText: 'Address Line 1',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Address Line 1';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _address2Controller,
                decoration: InputDecoration(
                  labelText: 'Address Line 2',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 10) {
                    return 'Please enter a valid 10-digit contact number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Payment Mode Dropdown
              Text('Payment Mode', style: TextStyle(fontSize: 18)),
              DropdownButtonFormField<String>(
                value: _paymentMode,
                onChanged: (String? newValue) {
                  setState(() {
                    _paymentMode = newValue!;
                  });
                },
                items: ['COD', 'UPI']
                    .map((mode) => DropdownMenuItem(
                  value: mode,
                  child: Text(mode),
                ))
                    .toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a payment mode';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Place Order Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // If form is valid, proceed to SuccessPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuccessPage(orderItems: widget.selectedServices),
                        ),
                      );
                    }
                  },
                  child: Text('Place Order'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
