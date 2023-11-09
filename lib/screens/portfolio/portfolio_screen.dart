import 'package:flutter/material.dart';
import '../../apis/experience_api.dart';
import '../shares/bottomNavigation.dart';
import 'aboutMe.dart';
import 'header.dart';
import '../login/login_screen.dart';
import 'experience.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  int _selectedIndex = 0;
  List<ExperienceCard> experienceCards = [];

  @override
  void initState() {
    super.initState();
    // Fetch experience data from the API and populate experienceCards.
    ExperienceApiProvider().fetchExperience().then((experiences) {
      setState(() {
        experienceCards = experiences.map((experience) {
          return ExperienceCard(
            title: experience.title,
            imagePath: 'assets/images_portfolio/card.jpg', // Specify the asset path
            description: experience.description,
            published: experience.published ?? 'Unknown',
            projectUrl: experience.projectUrl ?? 'Unknown',
          );
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // Include the Header widget
          Header(),
          // About Me Section
          const AboutMe(),
          ...experienceCards,
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
      ),
    );
  }
}
