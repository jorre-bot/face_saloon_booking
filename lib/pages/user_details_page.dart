import 'package:flutter/material.dart';
import 'packages_page.dart';

class UserDetailsPage extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String address = '';
  String phone = '';
  String email = '';
  DateTime? bookingDate;
  String duration = '2 Hours';
  String request = 'Specific Consultant';
  int guests = 1;
  final _dateController = TextEditingController();
  
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Your Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) => value!.isEmpty ? 'Enter your address' : null,
                onSaved: (value) => address = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.length < 10 ? 'Invalid phone number' : null,
                onSaved: (value) => phone = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => !value!.contains('@') ? 'Invalid email' : null,
                onSaved: (value) => email = value!,
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Booking Date'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    _dateController.text =
                        '${date.year}-${date.month}-${date.day}';
                  }
                },
                validator: (value) =>
                    value!.isEmpty ? 'Please select a booking date' : null,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Service Duration'),
                value: duration,
                items: ['2 Hours', '3 Hours', '4 Hours']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => duration = value as String),
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Additional Requests'),
                value: request,
                items: ['Specific Consultant', 'Any Consultant']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => request = value as String),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Number of Guests'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (int.tryParse(value!) == null || int.parse(value) <= 0) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => guests = int.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Next'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PackagesPage()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
