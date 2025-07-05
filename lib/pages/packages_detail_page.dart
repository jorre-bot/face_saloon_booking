import 'package:flutter/material.dart';
import 'payment_page.dart'; // Adjust import as per your project structure

class PackageDetailsPage extends StatelessWidget {
  final String packageName;
  final int packagePrice;
  final String packageDescription;
  final List<String> additionalPackages;

  PackageDetailsPage({
    required this.packageName,
    required this.packagePrice,
    required this.packageDescription,
    required this.additionalPackages,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(packageName)),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper2.jpg'), // Background image
            fit: BoxFit.cover, // Ensure the image covers the entire screen
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description section
              Text(
                'Description: $packageDescription',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // Price section
              Text(
                'Price: \$${packagePrice}',  // Display price as int
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 218, 18)),
              ),
              SizedBox(height: 20),
              // Additional packages section
              Text(
                'Additional Packages:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,  // Make the ListView take as much space as it needs
                itemCount: additionalPackages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(additionalPackages[index]),
                  );
                },
              ),
              Spacer(), // Ensures the button stays at the bottom of the screen
              // Proceed to payment button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        packageName: packageName,
                        packagePrice: packagePrice,  // Passed as int
                      ),
                    ),
                  );
                },
                child: Text('Proceed to Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
