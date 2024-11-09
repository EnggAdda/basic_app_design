import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final List<String> orderItems;

  SuccessPage({required this.orderItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Placed Successfully'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Thank you for your order!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 20),
            Text(
              'You have successfully placed the following services:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            // Display ordered items
            for (var item in orderItems)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  '- $item',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // You can navigate back to the HomePage or any other page
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: Text('Back to Home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
