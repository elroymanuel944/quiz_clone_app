import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:quiz_clone_app/view/result_screen/result_screen.dart';

import '../../utils/animations_constants.dart';
import '../../utils/color_constants.dart';
import '../category_screen/category_screen.dart';

class QuestionScreen extends StatefulWidget {
  final List question;
  final List options;
  final List answer;

  const QuestionScreen(
      {super.key,
      required this.question,
      required this.options,
      required this.answer});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int rightAnswerCount = 0;
  int currentIndex = 0;
  Timer? timer;
  int timerCount = 10; // Countdown time in seconds
  int totalTime = 10; // Total time for the question
  int? selectedAnswerIndex;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timerCount = totalTime; // Reset timer for new question
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerCount == 0) {
        nextQuestion();
      } else {
        setState(() {
          timerCount--;
        });
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void nextQuestion() {
    stopTimer(); // Stop the timer
    selectedAnswerIndex = null; // Reset selected index for the next question
    if (currentIndex < widget.options.length - 1) {
      currentIndex++;
      startTimer(); // Start timer for the next question
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              question: widget.question,
              answer: widget.answer,
              options: widget.options,
              answercount: rightAnswerCount,
              lenght: widget.question.length,
            ),
          ));
    }
    setState(() {});
  }

  @override
  void dispose() {
    stopTimer(); // Ensure timer is canceled when screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: ColorConstants.primaryblack,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                "${currentIndex + 1} / ${widget.options.length}",
                style: TextStyle(color: ColorConstants.primarywhite),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Stack(
                  children: [
                    // Question text
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        widget.question[currentIndex]["question"],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: ColorConstants.primarywhite),
                      ),
                    ),
                    // Timer UI
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Circular Progress Indicator
                          CircularProgressIndicator(
                            value: timerCount / totalTime,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                                ColorConstants.starColor),
                            strokeWidth:
                                5, // Thickness of the progress indicator
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                Colors.transparent, // Make it transparent
                            child: Center(
                              child: Text(
                                "$timerCount",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: ColorConstants.primarywhite),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Lottie animation for correct answer
                    if (selectedAnswerIndex ==
                        widget.answer[currentIndex]["answerindex"])
                      Lottie.asset(AnimationsConstants.rightansAnimation)
                  ],
                ),
                decoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
            Column(
                children: List.generate(
                    widget.options[currentIndex]["options"].length, (index) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () {
                    if (selectedAnswerIndex == null) {
                      selectedAnswerIndex = index;
                      stopTimer(); // Stop the timer when an option is selected
                      if (widget.answer[currentIndex]["answerindex"] ==
                          selectedAnswerIndex) {
                        rightAnswerCount++;
                      }
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: getColor(index)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.options[currentIndex]["options"][index],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: ColorConstants.primarywhite),
                        ),
                        Icon(
                          Icons.circle_outlined,
                          color: ColorConstants.primarygrey,
                        )
                      ],
                    ),
                  ),
                ),
              );
            })),
            SizedBox(
              height: 20,
            ),
            if (selectedAnswerIndex !=
                null) // Show the next button if an option is selected
              InkWell(
                onTap: nextQuestion,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorConstants.primaryred),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: ColorConstants.primarywhite),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  Color getColor(int currentOptionIndex) {
    if (selectedAnswerIndex != null &&
        currentOptionIndex == widget.answer[currentIndex]["answerindex"]) {
      return Colors.green;
    }

    if (selectedAnswerIndex == currentOptionIndex) {
      if (selectedAnswerIndex == widget.answer[currentIndex]["answerindex"]) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    } else {
      return Colors.grey;
    }
  }
}
