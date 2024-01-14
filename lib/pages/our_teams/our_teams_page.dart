import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:flutter/material.dart';

class OurTeamsPage extends StatelessWidget {
  OurTeamsPage({super.key});
  final List listTeams = [
    [
      "assets/images/member1.jpg",
      "Full-Stack Developer",
      "221110518",
      "Ripat Al Safar"
    ],
    [
      "assets/images/member2.jpg",
      "Backend Developer",
      "221112968",
      "Iqbal Syahbandi Lubis"
    ],
    [
      "assets/images/member3.jpg",
      "Backend Developer",
      "Faqih Fiddin",
      "Faqih Fiddin"
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        const SizedBox(height: 50),
        Container(
          width: double.infinity,
          height: 700,
          margin: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 20,
          ),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Our Team Working On This Project",
                style: TextStyle(
                  color: darkBlueColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 50,
                runSpacing: 30,
                children: listTeams.map((data) {
                  return Container(
                    width: 300,
                    height: 300,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: darkBlueColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            data[0],
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data[1],
                          style: TextStyle(
                            color: yellowColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          data[2],
                          style: TextStyle(
                            color: blueWhiteColor,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          data[3],
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
