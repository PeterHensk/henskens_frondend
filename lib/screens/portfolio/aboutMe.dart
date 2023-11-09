import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apis/username_api.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          // About Me Text
          SectionTitle(title: 'Welcome ', data: fetchData()),
          const AboutText(),

          // Small Centered Image
          const Center(
            child: AboutImage(),
          ),

          // Additional Information
          const AboutContent(),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final Future<String> data;

  const SectionTitle({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          return Text(title, // Display only the title when there's an error or no data.
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ));
        } else {
          return Text(
            '$title${snapshot.data}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          );
        }
      },
    );
  }
}

Future<String> fetchData() async {
  final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('user_email') ?? '';
  final apiProvider = ApiProvider();
  final response = await apiProvider.fetchData(email);

  if (response.statusCode == 200) {
    final parsedData = json.decode(response.body); // Parse the JSON response.
    final firstName = parsedData['firstName']; // Extract the 'firstName' field.
    return firstName;
  } else {
    throw Exception('Failed to load data');
  }
}

class AboutText extends StatelessWidget {
  const AboutText({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AboutParagraph(
            'Hi, my name is Peter, I live in a small village named Dessel in Belgium.'),
        AboutParagraph(
            "I’m passionate about everything that has something to do with data."),
        AboutParagraph(
            "This could be data analysis, data engineering where you gather all data together and try to make something meaningful with it."),
        AboutParagraph(
            "I'm an experienced data engineer, working with Matillion as an ETL tool and Snowflake as a data warehouse."),
        AboutParagraph(
            "Working with API endpoints is one of my favorite ways to capture data. Because there are so many variations and options to use (if it's programmed)."),
        AboutParagraph(
            "That brings me to programming. I like making back-ends for applications or endpoints on a database. This can be both in C# (.NET) or Java (JPA)."),
      ],
    );
  }
}

class AboutParagraph extends StatelessWidget {
  final String text;

  const AboutParagraph(this.text, {Key? key});

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: const TextStyle(
        fontStyle: FontStyle.italic, // Set the fontStyle to italic
      ),
    );
  }
}

class AboutImage extends StatelessWidget {
  const AboutImage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images_portfolio/profile-img.jpg',
      width: 100, // Adjust the width as needed
      height: 100, // Adjust the height as needed
      fit: BoxFit.contain, // Adjust the fit as needed
    );
  }
}

class AboutContent extends StatelessWidget {
  const AboutContent({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AboutHeader('Data engineer & Web Developer.'),
        AboutParagraph(
            "Professionally I’m a data engineer, but I love programming for a hobby and maybe one day I can combine it with being a data engineer."),
        SizedBox(height: 20),
        AboutDetails(label: 'Birthday', value: '2 September 1987'),
        AboutDetails(label: 'Website', value: 'henskens.tech'),
        AboutDetails(label: 'City', value: 'Dessel Belgium'),
        AboutDetails(label: 'Degree', value: 'Bachelor'),
        AboutDetails(label: 'Email', value: 'peter.henskens@gmail.com'),
        AboutDetails(label: 'Freelance', value: 'Available'),
        AboutParagraph(
            "Freelance is just a hobby. I develop apps for fun for friends or assist people in creating databases."),
      ],
    );
  }
}

class AboutHeader extends StatelessWidget {
  final String text;

  const AboutHeader(this.text, {Key? key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        color: Colors.blueAccent,
      ),
    );
  }
}

class AboutDetails extends StatelessWidget {
  final String label;
  final String value;

  const AboutDetails({Key? key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.arrow_right,
            color: Colors.black, // Change the color as needed
            size: 18.0, // Change the size as needed
          ),
          const SizedBox(width: 5.0),
          // Add some space between the icon and text
          Text(
            '$label: $value',
            style: const TextStyle(
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
