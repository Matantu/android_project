import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("👋 Welcome back, Matan!",
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 4),
            const Text("Let's help you find the right service today."),
            const SizedBox(height: 20),

            // Quick Access
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _quickButton(Icons.book_online, 'Book Now'),
                _quickButton(Icons.list_alt, 'My Requests'),
                _quickButton(Icons.local_offer, 'Offers'),
              ],
            ),

            const SizedBox(height: 30),

            // Recommended Services
            const Text("Recommended Services",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _serviceCard(Icons.cleaning_services, 'Cleaning'),
                  _serviceCard(Icons.plumbing, 'Plumber'),
                  _serviceCard(Icons.electrical_services, 'Electrician'),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Upcoming
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.calendar_today, color: Colors.blue),
                title: const Text("No upcoming bookings"),
                subtitle: const Text("Tap 'Book Now' to get started."),
              ),
            ),

            const SizedBox(height: 20),

            // Tip
            Card(
              color: Colors.blue.shade50,
              child: ListTile(
                leading: const Icon(Icons.lightbulb, color: Colors.amber),
                title: const Text("Tip"),
                subtitle: const Text(
                    "Booking a service 24h in advance helps secure your time!"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _quickButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: Colors.blue),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _serviceCard(IconData icon, String title) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue, size: 30),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

}