import 'package:flutter/material.dart';
import 'package:postbot/util/constants.dart';
import 'package:postbot/util/dropdown.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('A simple tool to generate posts for social media platforms using AI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
              ),),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                height: screenHeight * 0.34,
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black54,
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DropDownSelector(
                        'Social Media Platform',
                        ['Instagram', 'LinkedIn', 'Facebook', 'Twitter', 'Youtube'],
                        'Instagram'),
                    const SizedBox(height: 20.0),
                    const Text('Topic of Post', style: TextStyle(fontSize: 18.0),),
                    const SizedBox(height: 20.0),
                    const TextField(
                      decoration: kTopicInputDecoration
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  Material(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10.0),
                    child: MaterialButton(
                      onPressed: null,
                      minWidth: screenWidth,
                      child: const Text(
                        'Go',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
          Container(
            padding: const EdgeInsets.all(20),
            height: screenHeight * 0.36,
            width: screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black54,
                )
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
