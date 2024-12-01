import 'package:flutter/material.dart';
import 'package:quiz_clone_app/dummy_db.dart';
import 'package:quiz_clone_app/utils/color_constants.dart';
import 'package:quiz_clone_app/utils/image_constants.dart';
import 'package:quiz_clone_app/view/question_screen/question_screen.dart';



class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: Text(
            "Hello, Mathew",
            style: TextStyle(
                color: ColorConstants.starColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 20),
            child: CircleAvatar(
              backgroundImage: NetworkImage(ImageConstants.sports),
              radius: 25,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's play",
                style: TextStyle(
                    color: ColorConstants.starColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 250,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    if (index == 0) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionScreen(
                                question: MathsDb.questionLis,
                                options: MathsDb.questionLis,
                                answer: MathsDb.questionLis),
                          ));
                    } else if (index == 1) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionScreen(
                                question: GeographyDb.questionLis,
                                options: GeographyDb.questionLis,
                                answer: GeographyDb.questionLis),
                          ));
                    } else if (index == 2) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionScreen(
                                question: SportsDb.questionLis,
                                options: SportsDb.questionLis,
                                answer: SportsDb.questionLis),
                          ));
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionScreen(
                                question: CountriesDb.questionLis,
                                options: CountriesDb.questionLis,
                                answer: CountriesDb.questionLis),
                          ));
                    }
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage(CategoryData.Data[index]["imageUrl"]),
                          radius: 60,
                        ),
                        Text(
                          CategoryData.Data[index]["category"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.starColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
