import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Adjust the height as needed
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images_portfolio/hero.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Peter Henskens",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 300), // Set a maximum width
              child: TypewriterAnimatedTextKit(
                text: const [
                  "I'm data engineer,",
                  "app developer,",
                  "family man",
                ],
                textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                speed: const Duration(milliseconds: 60),
                totalRepeatCount: 1,
                displayFullTextOnTap: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildFontAwesomeIcon(FontAwesomeIcons.facebook,
                    'https://www.facebook.com/peter.henskens'),
                _buildFontAwesomeIcon(FontAwesomeIcons.instagram,
                    'https://www.instagram.com/peterhenskens87'),
                _buildFontAwesomeIcon(FontAwesomeIcons.linkedin,
                    'https://www.linkedin.com/in/ph87'),
                // Add more social icons with links as needed
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildFontAwesomeIcon(IconData icon, String link) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(link)) {
          await launch(link);
        } else {
          throw 'Could not launch $link';
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, size: 32, color: Colors.white),
      ),
    );
  }
}
