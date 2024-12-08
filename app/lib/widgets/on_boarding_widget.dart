import 'package:app/models/OnBoardingItems.dart';
import 'package:app/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingWidget extends StatefulWidget {
  const OnBoardingWidget({super.key});

  @override
  State<OnBoardingWidget> createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState extends State<OnBoardingWidget> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/background.jpg'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.4,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (newIndex) {
                        setState(() {
                          currentIndex = newIndex;
                        });
                      },
                      itemCount: listOfItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Lottie.asset(
                              listOfItems[index].img,
                              width: 300,
                              height: 300,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                  textAlign: TextAlign.center,
                                  listOfItems[index].title,
                                  style: GoogleFonts.sigmarOne(
                                      textStyle: const TextStyle(
                                          color: Colors.lightGreenAccent,
                                          fontSize: 28))),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                  textAlign: TextAlign.center,
                                  listOfItems[index].subTitle,
                                  style: GoogleFonts.rumRaisin(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                          letterSpacing: 0.7))),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: listOfItems.length,
                    effect: const ExpandingDotsEffect(
                      spacing: 6.0,
                      radius: 10.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      expansionFactor: 3.8,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.green,
                    ),
                    onDotClicked: (newIndex) {
                      setState(() {
                        currentIndex = newIndex;
                        pageController.animateToPage(newIndex,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      });
                    },
                  ),
                ],
              ),
              currentIndex == 2
                  ? Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Authenticate(),
                                ));
                          },
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                            minimumSize: WidgetStateProperty.all<Size>(
                                const Size(250, 50)),
                          ),
                          child: Text(
                            'Bắt đầu',
                            style: GoogleFonts.sigmarOne(
                                textStyle: const TextStyle(
                                    color: Colors.green, fontSize: 22)),
                          ),
                        ),
                        const SizedBox(height: 40)
                      ],
                    )
                  : Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              pageController.animateToPage(2,
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.easeInOut);
                            });
                          },
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                            minimumSize: WidgetStateProperty.all<Size>(
                                const Size(250, 50)),
                          ),
                          child: Text(
                            'Bỏ qua',
                            style: GoogleFonts.sigmarOne(
                                textStyle: const TextStyle(
                                    color: Colors.green, fontSize: 22)),
                          ),
                        ),
                        const SizedBox(height: 40)
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
