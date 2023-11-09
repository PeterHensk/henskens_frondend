import 'package:flutter/material.dart';

class ExperienceCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String published;
  final String projectUrl;

  ExperienceCard(
      {required this.title,
      required this.imagePath,
      required this.description,
      required this.published,
      required this.projectUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the tap event to display the modal or perform any other action.
        _showModal(context, title, description, published, projectUrl);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            // Background image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            // Header
            ListTile(
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModal(BuildContext context, String title, String description,
      String published, String projectUrl) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0), // Add padding to the container.
          child: Column(
            children: [
              const SizedBox(height: 10), // Add padding top to the title.
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Center the text.
              ),
              const SizedBox(height: 10), // Add spacing below the title.
              Container(
                margin: const EdgeInsets.all(8.0),
                // Add margin to the description.
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center, // Center the text.
                ),
              ),
              const SizedBox(height: 10), // Add spacing below the description.

              // Add a list of attributes
              ListTile(
                title: Text("Published on $published"),
                subtitle: projectUrl != null
                    ? Text("Project URL is $projectUrl")
                    : const Text("Project URL is not available"),
              ),

              const SizedBox(height: 10), // Add spacing below the list.
            ],
          ),
        );
      },
    );
  }
}
