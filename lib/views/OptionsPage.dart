import 'dart:async';
import 'package:flutter/material.dart';
import 'OrderPage.dart';

class OptionsPage extends StatefulWidget {
  final String? selectedService;

  OptionsPage({this.selectedService});

  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _bucket = [];
  final List<String> _suggestedServices = [
    'Electric Fixing',
    'Labour Support',
    'Tuition Teacher',
    'Cleaning Service',
    'Plumber',
    'Rider Support'
  ];

  late Timer _timer;
  int _currentSuggestionIndex = 0;

  @override
  void initState() {
    super.initState();
    // Add selected service to the bucket if passed from HomePage
    if (widget.selectedService != null) {
      _bucket.add(widget.selectedService!);
    }
    // Start the timer to update the search bar placeholder text
    _timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      setState(() {
        _currentSuggestionIndex =
            (_currentSuggestionIndex + 1) % _suggestedServices.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _addServiceToBucket() {
    String service = _searchController.text.trim();
    if (service.isNotEmpty && !_bucket.contains(service)) {
      setState(() {
        _bucket.add(service);
        _searchController.clear();
      });
    }
  }

  void _removeServiceFromBucket(String service) {
    setState(() {
      _bucket.remove(service);
    });
  }

  void _goToOrderPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderPage(selectedServices: _bucket),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display selected items in the bucket as chips with delete icons
            Wrap(
              spacing: 8.0,
              children: _bucket.map((service) {
                return Chip(
                  label: Text(service),
                  deleteIcon: Icon(Icons.close, color: Colors.red),
                  onDeleted: () => _removeServiceFromBucket(service),
                  backgroundColor: Colors.blue[50],
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Centered and styled search bar with animated placeholder
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: _suggestedServices[_currentSuggestionIndex],
                    hintStyle: TextStyle(color: Colors.blueAccent),
                    prefixIcon: Icon(Icons.search, color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add, color: Colors.blue),
                      onPressed: _addServiceToBucket,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    filled: true,
                    fillColor: Colors.blue[50],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  onSubmitted: (_) => _addServiceToBucket(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bucket.isEmpty ? null : _goToOrderPage,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.shopping_bag),
            if (_bucket.isNotEmpty)
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    _bucket.length.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
