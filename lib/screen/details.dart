import 'dart:io';

import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final int id;
  final String photo;
  final String name;
  final String gender;
  final String domain;
  final String dob;
  final String mobile;
  final String email;

  const DetailsPage({
    Key? key,
    required this.id,
    required this.photo,
    required this.name,
    required this.gender,
    required this.domain,
    required this.dob,
    required this.mobile,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: FileImage(File(photo)),
              ),
              title: Text(name),
              subtitle: Text(domain),
            ),
            SizedBox(height: 20),
            Text('Gender: $gender'),
            Text('Date of Birth: $dob'),
            Text('Mobile: $mobile'),
            Text('Email: $email'),
            SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}
