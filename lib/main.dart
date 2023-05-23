import 'package:bus_router/attributions.dart';
import 'package:bus_router/bus.dart';
import 'package:bus_router/map.dart';
import 'package:bus_router/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Router',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bus Router'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  BusKind? focusBusKind;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
          color: Theme.of(context).colorScheme.inversePrimary,
          height: double.infinity,
          width: 200,
          child: Text("WIP")),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          SizedBox(
            child: Stack(
              children: [
                MainMap(
                  mapController: MapController(),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Hero(
                  tag: "SearchBar",
                  child: SearchBar(
                      onTap: () => Navigator.of(context).push(PageRouteBuilder(
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          pageBuilder:
                              (context, animation, secondartAnimation) =>
                                  SearchScreen())),
                      controller: _searchController,
                      hintText: 'Search',
                      trailing: const [Icon(Icons.search)]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final busKind in humphreysBusKind) ...[
                    IconButton(
                        padding: const EdgeInsets.all(8.0),
                        onPressed: () => setState(() {
                              if (focusBusKind == busKind) {
                                focusBusKind = null;
                              } else {
                                focusBusKind = busKind;
                              }
                            }),
                        icon: Icon(
                          Icons.directions_bus,
                          color: focusBusKind == null
                              ? busKind.color
                              : focusBusKind == busKind
                                  ? busKind.color
                                  : busKind.color.withOpacity(0.3),
                        ))
                  ]
                ],
              ),
              const Expanded(child: SizedBox()),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.my_location)),
                  ),
                ),
              ),
              const Attribution(),
            ],
          ),
          if (focusBusKind != null) ...[
            DraggableScrollableSheet(
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).dialogBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      if (focusBusKind != null) ...[
                        Text(focusBusKind!.lineName)
                      ]
                    ],
                  ),
                );
              },
            )
          ]
        ],
      ),
    );
  }
}
