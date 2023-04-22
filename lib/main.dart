import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postbot/util/constants.dart';
import 'package:postbot/util/dropdown.dart';
import 'package:postbot/util/networking.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<PostData>(
          create: (BuildContext context) => PostData(),
          child: const HomeScreen()),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool topicInput = false, isCopied = false, buttonEnable = true;
  String postResponse = '';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.01, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'A simple tool to generate post captions for social media platforms using AI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenHeight * 0.022,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.035,
              ),
              Container(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.023, left: 20.0, right: 20.0),
                height: screenHeight * 0.36,
                width: screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.046),
                    border: Border.all(
                      color: Colors.black54,
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DropDownSelector(
                      'Social Media Platform',
                      [
                        'Instagram',
                        'LinkedIn',
                        'Facebook',
                        'Twitter',
                        'Youtube'
                      ],
                      'Instagram',
                    ),
                    SizedBox(height: screenHeight * 0.021),
                    Text(
                      'Topic of Post',
                      style: TextStyle(fontSize: screenHeight * 0.019),
                    ),
                    SizedBox(height: screenHeight * 0.021),
                    TextField(
                      maxLength: 100,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: kTopicInputDecoration,
                      onChanged: (String newTopic) {
                        Provider.of<PostData>(context, listen: false)
                            .setTopic(newTopic);
                        topicInput = true;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.021),
                    Material(
                      color: buttonEnable ? Colors.blueGrey : Colors.redAccent,
                      borderRadius: BorderRadius.circular(10.0),
                      child: MaterialButton(
                        onPressed: () async {
                          isCopied = false;
                          if (topicInput) {
                            print("Request Sent");
                            String newPlatform =
                                Provider.of<PostData>(context, listen: false)
                                    .platform;
                            String newTopic =
                                Provider.of<PostData>(context, listen: false)
                                    .topic;
                            if (newPlatform == "") newPlatform = 'Instagram';
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 5,
                                  ));
                                });
                            final response = await http.post(
                              Uri.parse(
                                  'https://gptchatserver.onrender.com/generate'),
                              body: {
                                "topic": newTopic,
                                "platform": newPlatform
                              },
                            );
                            postResponse = jsonDecode(response.body);
                            setState(() {});
                            Navigator.pop(context);
                          }
                        },
                        minWidth: screenWidth,
                        child: const Text(
                          'Go',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.021),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                height: screenHeight * 0.36,
                width: screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black54,
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        postResponse,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: screenHeight * 0.018,
                        ),
                      ),
                      if (postResponse != '')
                        SizedBox(
                          width: 100.0,
                          child: OutlinedButton(
                              onPressed: () async {
                                isCopied = true;
                                await Clipboard.setData(
                                    ClipboardData(text: postResponse));
                                setState((){});
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if(isCopied == false)
                                  const Text(
                                    'Copy',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 16),
                                  ),
                                  if(isCopied == true)
                                    const Text(
                                      'Copied!',
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 16),
                                    ),
                                  if(isCopied == false)
                                    const Icon(
                                    Icons.copy,
                                    size: 20,
                                    color: Colors.black54,
                                  ),
                                ],
                              )),
                        )
                    ],
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

