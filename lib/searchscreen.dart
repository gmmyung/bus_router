import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      myFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  late FocusNode myFocusNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                // flightShuttleBuilder: (flightContext, animation,
                //     flightDirection, fromHeroContext, toHeroContext) {
                //   void statusListener(status) {
                //     if (status == AnimationStatus.completed) {
                //       print("Request focus");
                //       myFocusNode.requestFocus();
                //       animation.removeStatusListener(statusListener);
                //       print("Remove status listener");
                //     }
                //   }

                //   print("Add status listener");
                //   animation.addStatusListener(statusListener);
                //   return const SearchBar();
                // },
                tag: "SearchBar",
                child: SearchBar(
                  focusNode: myFocusNode,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ),
            for (var i = 0; i < 10; i++) ...[
              const SizedBox(child: Text("Hello"))
            ],
          ],
        ),
      ),
    );
  }
}
