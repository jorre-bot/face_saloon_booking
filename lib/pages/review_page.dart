import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final List<Map<String, dynamic>> reviews = [];
  final _reviewController = TextEditingController();
  double _rating = 0;

  void addReview() {
    if (_rating > 0 && _reviewController.text.isNotEmpty) {
      setState(() {
        reviews.add({
          'rating': _rating,
          'review': _reviewController.text,
        });
      });
      _rating = 0;
      _reviewController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide a rating and review')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ratings and Reviews'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/thankyou.jpg'), // Background image
            fit: BoxFit.cover, // Cover the entire screen
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rating Bar
              Text(
                'Rate Us:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 8),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              SizedBox(height: 16),
              // Review Input Field
              TextFormField(
                controller: _reviewController,
                decoration: InputDecoration(
                  labelText: 'Write a Review',
                  labelStyle: TextStyle(color: Colors.black87),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: addReview,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Submit', style: TextStyle(fontSize: 16)),
                ),
              ),
              Divider(thickness: 2, color: Colors.white70),
              // Reviews List
              Expanded(
                child: reviews.isEmpty
                    ? Center(
                        child: Text(
                          'No reviews yet. Be the first to rate us!',
                          style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight .bold, color: const Color.fromARGB(255, 253, 253, 253)),
                        ),
                      )
                    : ListView.builder(
                        itemCount: reviews.length,
                        itemBuilder: (context, index) {
                          final review = reviews[index];
                          return Card(
                            color: Colors.white70,
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: RatingBarIndicator(
                                rating: review['rating'],
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                              ),
                              title: Text('Rating: ${review['rating'].toStringAsFixed(1)}'),
                              subtitle: Text(review['review']),
                            ),
                          );
                        },
                      ),
              ),
              // Home Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/'); // Navigate to the home page
                  },
                  icon: Icon(Icons.home),
                  label: Text('Go to Home'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
