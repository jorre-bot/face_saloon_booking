import 'package:flutter/material.dart';
import 'packages_detail_page.dart';

class PackagesPage extends StatelessWidget {
  final List<Map<String, dynamic>> packages = [
    {
      'name': 'Basic Head Treatment',
      'price': 25, // Price as int
      'image': 'assets/images/head.png',
      'description': 'A basic head treatment for refreshing your head after a long day at work!',
      'additionalPackages': ['Head Massage']
    },
    {
      'name': 'Premium Face Treatment',
      'price': 50, // Price as int
      'image': 'assets/images/face1.png',
      'description': 'An advanced hair treatment with head massage and face treatment that give you sensational feelings!',
      'additionalPackages': ['Hair Treatment','Head Massage','Face Treatment']
    },
    {
      'name': 'Luxury Body Treatment',
      'price': 150, // Price as int
      'image': 'assets/images/22.jpg',
      'description': 'A luxurious body massage including hair treatment and Nail care that use premium product.',
      'additionalPackages': ['Hair Treatment', 'Body Massage', 'Nail Care']
    },
    {
      'name': 'Ultimate Face & Body Treatment',
      'price': 200, // Price as int
      'image': 'assets/images/premium.jpg',
      'description': 'Full body spa with refreshing Body massage including hair treatment that give you life back!.',
      'additionalPackages': ['Hair Treatment', 'Body Massage', 'Nail Care', 'Spa']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Beauty Packages')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper.jpg'), // Background image
            fit: BoxFit.cover, // Cover the entire screen
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10), // Add padding for better spacing
            child: GridView.builder(
              shrinkWrap: true, // Make the GridView only as tall as its content
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final package = packages[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to the details page for the selected package
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PackageDetailsPage(
                          packageName: package['name'],
                          packagePrice: package['price'],
                          packageDescription: package['description'],
                          additionalPackages: package['additionalPackages'],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        // Ensure the image fits within its space and has rounded corners
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.asset(
                            package['image'],
                            width: double.infinity,
                            height: 108, // Adjust height as needed
                            fit: BoxFit.cover, // Ensure the image covers the space proportionally
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                package['name'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 1),
                              Text(
                                '\$${package['price']}',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
