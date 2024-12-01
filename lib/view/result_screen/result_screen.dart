import 'package:flutter/material.dart';

import 'package:quiz_clone_app/utils/color_constants.dart';
import 'package:quiz_clone_app/view/category_screen/category_screen.dart';
import 'package:quiz_clone_app/view/question_screen/question_screen.dart';

class ResultScreen extends StatefulWidget {
  final int lenght;
  final int answercount;
  final List question;
  final List answer;
  final List options;

  const ResultScreen(
      {super.key,
      required this.answercount,
      required this.lenght,
      required this.question,
      required this.answer,
      required this.options});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  var starcount = 0;
  double percentage = 0.0; // New variable to hold percentage

  @override
  void initState() {
    super.initState();
    calculatePercentage();
  }

  calculatePercentage() {
    percentage = (widget.answercount / widget.lenght); // Store as a decimal
    if (percentage >= 0.8) {
      starcount = 3;
    } else if (percentage >= 0.5) {
      starcount = 2;
    } else if (percentage >= 0.3) {
      starcount = 1;
    } else {
      starcount = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add the percentage indicator
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: percentage,
                    backgroundColor: Colors.grey[300],
                    color: ColorConstants.starColor,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${(percentage * 100).toStringAsFixed(0)}%", // Display percentage
                    style: TextStyle(
                      color: ColorConstants.starColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: index == 1 ? 50 : 20,
                  ),
                  child: Icon(Icons.star,
                      size: index == 1 ? 80 : 50,
                      color: index < starcount
                          ? ColorConstants.starColor
                          : Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Congratulations",
              style: TextStyle(
                  fontSize: 26,
                  color: ColorConstants.starColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25),
            Text("Your score",
                style: TextStyle(
                  color: ColorConstants.primarywhite,
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              "${widget.answercount} / ${widget.lenght}",
              style: TextStyle(
                  color: ColorConstants.starColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 20),
                          Text("Do you want to"),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ColorConstants.starColor),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                QuestionScreen(
                                              question: widget.question,
                                              options: widget.options,
                                              answer: widget.answer,
                                            ),
                                          ));
                                    },
                                    child: Text("Retry")),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ColorConstants.starColor),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryScreen(),
                                          ));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Home"),
                                        SizedBox(width: 8),
                                        Icon(Icons.home)
                                      ],
                                    )),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.primarywhite,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorConstants.primaryblack,
                      radius: 15,
                      child: Icon(
                        Icons.replay,
                        color: ColorConstants.primarywhite,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Retry",
                      style: TextStyle(
                          color: ColorConstants.primaryblack,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    )
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
