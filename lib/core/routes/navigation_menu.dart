import 'package:flutter/material.dart';
import 'package:donezo/pages/calendar_page.dart';
import 'package:donezo/pages/home_page.dart';
import 'package:donezo/pages/kanban_page.dart';
import 'package:donezo/pages/profile_page.dart';
import 'package:donezo/features/task_management/presentation/pages/task_page.dart';
import 'package:donezo/core/theme/app_color.dart';
import 'package:unicons/unicons.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> with TickerProviderStateMixin {
  final _pageController = PageController();
  var _selectedTab = SelectedTab.home;
  List<Widget> pages = [
    const HomePage(),
    const CalendarPage(),
    const TaskPage(),
    const KanbanPage(),
    const ProfilePage(),
  ];

  Widget getPage(SelectedTab tab) {
    switch (tab) {
      case SelectedTab.home:
        return pages[0];
      case SelectedTab.calendar:
        return pages[1];
      case SelectedTab.task:
        return pages[2];
      case SelectedTab.kanban:
        return pages[3];
      case SelectedTab.profile:
        return pages[4];
      default:
        return pages[0];
    }
  }

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = SelectedTab.values[i];
    });
  }

  void animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(microseconds: 500),
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_selectedTab);
    AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 500),
    );
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        children: pages,
        onPageChanged: (index) {
          _handleIndexChanged(index);
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
          left: 20,
          right: 20,
        ),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 60,
            maxHeight: 60,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: AppColor.primary,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 4.5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linearToEaseOut,
                    height: 5,
                    width: 30,
                    decoration: BoxDecoration(
                      color: _selectedTab == SelectedTab.home ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      animateToPage(0);
                    },
                    icon: Icon(
                      UniconsLine.home,
                      color: _selectedTab == SelectedTab.home ? Colors.white : AppColor.dark,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linearToEaseOut,
                    height: 5,
                    width: 30,
                    decoration: BoxDecoration(
                      color: _selectedTab == SelectedTab.calendar ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      animateToPage(1);
                    },
                    icon: Icon(
                      UniconsLine.calendar_alt,
                      color: _selectedTab == SelectedTab.calendar ? Colors.white : AppColor.dark,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linearToEaseOut,
                    height: 5,
                    width: 30,
                    decoration: BoxDecoration(
                      color: _selectedTab == SelectedTab.task ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      animateToPage(2);
                    },
                    icon: Icon(
                      UniconsLine.plus_circle,
                      color: _selectedTab == SelectedTab.task ? Colors.white : AppColor.dark,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linearToEaseOut,
                    height: 5,
                    width: 30,
                    decoration: BoxDecoration(
                      color: _selectedTab == SelectedTab.kanban ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      animateToPage(3);
                    },
                    icon: Icon(
                      UniconsLine.layers_alt,
                      color: _selectedTab == SelectedTab.kanban ? Colors.white : AppColor.dark,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linearToEaseOut,
                    height: 5,
                    width: 30,
                    decoration: BoxDecoration(
                      color: _selectedTab == SelectedTab.profile ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      animateToPage(4);
                    },
                    icon: Icon(
                      UniconsLine.user,
                      color: _selectedTab == SelectedTab.profile ? Colors.white : AppColor.dark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum SelectedTab {
  home,
  calendar,
  task,
  kanban,
  profile,
}

class PageControllerView {}
