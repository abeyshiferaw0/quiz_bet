import 'dart:async';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class AppCarousel extends StatefulWidget {
  const AppCarousel(
      {Key? key,
      required this.children,
      required this.dotColor,
      required this.selectedDotColor})
      : super(key: key);

  final List<Widget> children;
  final Color dotColor;
  final Color selectedDotColor;

  @override
  _AppCarouselState createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {


  //NOTIFIER FOR DOTED INDICATOR
  late ValueNotifier<int> pageNotifier;
  //CONTROLLER FOR PAGE VIEW
  late PageController controller;
  //TIMER FOR CAROUSEL
  late Timer timer;
  //PAGER CURRENT PAGE
  int currentPage = 0;

  @override
  void initState() {
    ///PAGE VIEW CONTROLLER INIT
    controller =   PageController(initialPage: 0, viewportFraction: 0.9);

    ///INDICATOR CONTROLLER INIT
    pageNotifier = ValueNotifier<int>(0);

    ///CAROUSEL TIMER INIT
    timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      if (currentPage < (widget.children.length-1)) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      controller.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExpandablePageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              pageNotifier.value = index;
              currentPage = index;
            });
          },
          children: widget.children,
        ),
        SizedBox(
          height: AppSizes.mp_v_2,
        ),
        CirclePageIndicator(
          dotColor: widget.dotColor,
          selectedDotColor: widget.selectedDotColor,
          currentPageNotifier: pageNotifier,
          size: AppSizes.icon_size_4*0.6,
          selectedSize: AppSizes.icon_size_4*0.7,
          itemCount: widget.children.length,
        ),
      ],
    );
  }
}
