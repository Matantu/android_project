import 'package:flutter/material.dart';

class PhoneInputScreen extends StatefulWidget {
  @override
  _PhoneInputScreenState createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String? _errorText;

  void _goToOtpScreen() {
    final rawNumber = _phoneController.text.trim();

    if (rawNumber.isEmpty || rawNumber.length < 9|| !RegExp(r'^0?\d{9}$').hasMatch(rawNumber) ) {
      setState(() {
        _errorText = "Please enter a valid Israeli phone number (e.g. 501234567)";
      });
      return;
    }

    setState(() {
      _errorText = null;
    });

    final formattedPhone = '+972${rawNumber.startsWith('0') ? rawNumber.substring(1) : rawNumber}';

    Navigator.pushNamed(context, '/otp', arguments: formattedPhone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/phone.png', height: 200),
            SizedBox(height: 20),
            Text("Phone Verification", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("We need to register your phone before getting started!"),
            SizedBox(height: 30),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixText: '+972 ',
                border: OutlineInputBorder(),
                labelText: "Phone",
                errorText: _errorText,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _goToOtpScreen,
              child: Text("Send the code"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}