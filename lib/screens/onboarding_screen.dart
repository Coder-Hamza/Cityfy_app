import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:cityguide_app/notifier/onbording_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  // Onboarding Data
  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/onboarding01.png',
      'title': 'Plan Your Trip',
      'desc': 'Save places and book your perfect trip with CityFy App',
      'buttonText': 'Next',
    },
    {
      'image': 'assets/images/onboarding02.png',
      'title': 'Begin The Adventure',
      'desc': 'Begin The CityFy App with Alone or your family & friends',
      'buttonText': 'Next',
    },
    {
      'image': 'assets/images/onboarding03.png',
      'title': 'Enjoy Your Trip',
      'desc': 'Enjoy your CityFy Travel Package and stay relax',
      'buttonText': 'Get Started',
    },
  ];

  void _nextPage() async {
    final onboardingProvider = Provider.of<OnboardingProvider>(
      context,
      listen: false,
    );

    if (currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      await onboardingProvider.setOnboardingSeen();
      Navigator.pushReplacementNamed(context, '/signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              // PageView Builder
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    final data = onboardingData[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(data['image']!, height: 250.h),
                        100.verticalSpace,
                        // Title
                        Text(
                          data['title']!,
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        25.verticalSpace,
                        // Description
                        Text(
                          data['desc']!,
                          style: TextStyle(
                            fontSize: 18,
                            color: Appcolors.secondaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Page Indicator Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(onboardingData.length, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    height: 8.h,
                    width: currentPage == index ? 20.w : 8.w,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? Colors.blue
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  );
                }),
              ),
              20.verticalSpace,

              // Next/Get Started Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    onboardingData[currentPage]['buttonText']!,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              35.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
