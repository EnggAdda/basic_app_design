import 'package:flutter/material.dart';
import '../models/service.dart';
import 'OptionsPage.dart';

class HomePage extends StatelessWidget {
  final List<Service> services = [
    Service(
      name: 'Electric Fixing',
      imageUrl: 'https://via.placeholder.com/150',
      price: 75.0,
      deliveryTime: '2 hours',
    ),
    Service(
      name: 'Labour Support',
      imageUrl: 'https://via.placeholder.com/150',
      price: 100.0,
      deliveryTime: '4 hours',
    ),
    Service(
      name: 'Tuition Teacher',
      imageUrl: 'https://via.placeholder.com/150',
      price: 50.0,
      deliveryTime: 'Next Day',
    ),
    // Add more services as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: Image.network(service.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(service.name),
              subtitle: Text('Price: \$${service.price}\nDelivery Time: ${service.deliveryTime}'),
              isThreeLine: true,
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to OptionsPage and add service to the bucket
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OptionsPage(selectedService: service.name),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
