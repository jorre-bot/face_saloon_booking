import 'package:flutter/material.dart';
import 'review_page.dart';

class PaymentPage extends StatefulWidget {
  final String packageName;
  final int packagePrice;
  

  PaymentPage({required this.packageName, required this.packagePrice});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _discountController = TextEditingController();
  final _guestCountController = TextEditingController();
  double totalPrice = 0.0;
  int guestCount = 1; // Default to 1 guest

  // Store used discount codes
  final Set<String> usedDiscountCodes = {};

  @override
  void initState() {
    super.initState();
    // Initial total price based on the package price for one guest
    totalPrice = widget.packagePrice.toDouble();
  }

  void applyDiscount() {
    // Define a map of discount codes and their respective values
    final discountCodes = {
      'DISCOUNT10': 10,
      'DISCOUNT20': 20,
      'SAVE15': 15,
      'SPECIAL30': 30,
    };

    // Get the entered discount code
    final enteredCode = _discountController.text;

    // Check if the code has already been used
    if (usedDiscountCodes.contains(enteredCode)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('This discount code has already been used.')),
      );
      return;
    }

    // Check if the entered code exists in the map
    if (discountCodes.containsKey(enteredCode)) {
      setState(() {
        // Apply the discount
        totalPrice -= discountCodes[enteredCode]!;

        // Mark the code as used
        usedDiscountCodes.add(enteredCode);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Discount applied!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid discount code.')),
      );
    }
  }

  void calculateTotal() {
    setState(() {
      // Ensure the guest count is at least 1 (can't have zero guests)
      guestCount = int.tryParse(_guestCountController.text) ?? 1;
      // Calculate the total price based on the number of guests
      totalPrice = widget.packagePrice * guestCount.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selected Package: ${widget.packageName}', style: TextStyle(fontSize: 18)),
            Text('Price per Guest: \$${widget.packagePrice}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            
            // Input for the number of guests
            TextFormField(
              controller: _guestCountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Number of Guests',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => calculateTotal(), // Recalculate when input changes
            ),
            SizedBox(height: 20),

            // Discount code input
            TextFormField(
              controller: _discountController,
              decoration: InputDecoration(labelText: 'Enter Discount Code'),
            ),
            ElevatedButton(
              child: Text('Apply Discount'),
              onPressed: applyDiscount,
            ),
            SizedBox(height: 20),

            // Display the total price after calculation
            Text('Total Price: \$${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
            Spacer(),

            // Next button to navigate to the review page
            Center(
              child: ElevatedButton(
                child: Text('Next'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReviewPage()), // Replace with your ReviewPage route
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
