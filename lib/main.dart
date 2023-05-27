import 'dart:convert';

import 'package:bus_router/attributions.dart';
import 'package:bus_router/bus.dart';
import 'package:bus_router/bus_line_detail.dart';
import 'package:bus_router/map.dart';
import 'package:bus_router/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  // load bus info from assets/bus_info.json
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  BusRoute? focusBusRoute;
  late final Future<BusInfo> busInfo;

  @override
  void initState() {
    super.initState();
    busInfo = rootBundle
        .loadString('assets/bus_info.json')
        .then((value) => jsonDecode(value))
        .then((value) => BusInfo.fromJson(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
          color: Theme.of(context).colorScheme.inversePrimary,
          height: double.infinity,
          width: 200,
          child: const Text("WIP")),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: busInfo,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final busInfo = snapshot.data!;
              return Stack(
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
                  SafeArea(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Hero(
                            tag: "SearchBar",
                            child: SearchBar(
                                onTap: () => Navigator.of(context).push(
                                    PageRouteBuilder(
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                        pageBuilder: (context, animation,
                                                secondartAnimation) =>
                                            const SearchScreen())),
                                controller: _searchController,
                                hintText: 'Search',
                                trailing: const [Icon(Icons.search)]),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (final busRoute in busInfo.busRoutes) ...[
                              IconButton(
                                  padding: const EdgeInsets.all(8.0),
                                  onPressed: () => setState(() {
                                        if (focusBusRoute == null) {
                                          focusBusRoute = busRoute;
                                        } else if (focusBusRoute!.lineName ==
                                            busRoute.lineName) {
                                          focusBusRoute = null;
                                        } else {
                                          focusBusRoute = busRoute;
                                        }
                                      }),
                                  icon: Icon(
                                    Icons.directions_bus,
                                    color: focusBusRoute == null
                                        ? busRoute.color
                                        : focusBusRoute == busRoute
                                            ? busRoute.color
                                            : busRoute.color.withOpacity(0.3),
                                  ))
                            ]
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.my_location)),
                            ),
                          ),
                        ),
                        const Attribution(),
                      ],
                    ),
                  ),
                  if (focusBusRoute != null) ...[
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
                              if (focusBusRoute != null) ...[
                                BusLineDetail(
                                  busRoute: focusBusRoute!,
                                )
                              ]
                            ],
                          ),
                        );
                      },
                    )
                  ]
                ],
              );
            } else {
              return const Center(child: Text("Error"));
            }
          }),
    );
  }
}
