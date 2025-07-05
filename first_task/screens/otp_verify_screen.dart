import 'package:flutter/material.dart';

class OtpVerifyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String phoneNumber =
    ModalRoute.of(context)!.settings.arguments as String;

    final List<TextEditingController> otpControllers =
    List.generate(6, (_) => TextEditingController());
    final List<FocusNode> focusNodes =
    List.generate(6, (_) => FocusNode());

    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/phone.png', height: 200),
            SizedBox(height: 20),
            Text("Enter code sent to $phoneNumber"),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 40,
                  child: TextField(
                    controller: otpControllers[index],
                    focusNode: focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: const InputDecoration(counterText: ""),
                    onChanged: (value) {
                      if (value.length == 1 && index < 5) {
                        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                      }
                      if (value.isEmpty && index > 0) {
                        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                      }
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final otp = otpControllers.map((c) => c.text).join();

                if (otp.length == 6) {
                  Navigator.pushReplacementNamed(context, '/download');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a 6-digit OTP')),
                  );
                }
              },
              child: Text("Verify Phone Number"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.green,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Edit Phone Number?"),
            ),
          ],
        ),
      ),
    );
  }
}
