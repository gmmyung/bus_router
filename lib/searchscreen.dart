import 'package:bus_router/bus.dart';
import 'package:bus_router/overpass.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final BusInfo busInfo;
  final BuildingQuery buildingQuery;
  final NodeQuery nodeQuery;
  const SearchScreen(
      {super.key,
      required this.busInfo,
      required this.buildingQuery,
      required this.nodeQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
                tag: "SearchBar",
                child: SearchBar(
                  onChanged: (string) {
                    setState(() {
                      searchQuery = string;
                    });
                  },
                  focusNode: myFocusNode,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  for (final busStop in widget.busInfo.busStops)
                    if (busStop.name
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                      BusStopSearchResult(
                        busStop: busStop,
                        busInfo: widget.busInfo,
                        buildingQuery: widget.buildingQuery,
                        nodeQuery: widget.nodeQuery,
                      ),
                  for (final building in widget.buildingQuery.elements) ...[
                    if (building.tags.name != null) ...[
                      if (building.tags.name!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase())) ...[
                        BuildingSearchResult(
                          building: building,
                          busInfo: widget.busInfo,
                          buildingQuery: widget.buildingQuery,
                          nodeQuery: widget.nodeQuery,
                        )
                      ]
                    ] else if (building.tags.amenity != null) ...[
                      if (building.tags.amenity!.toLowerCase() ==
                          searchQuery.toLowerCase()) ...[
                        BuildingSearchResult(
                          building: building,
                          busInfo: widget.busInfo,
                          buildingQuery: widget.buildingQuery,
                          nodeQuery: widget.nodeQuery,
                        )
                      ]
                    ] else if (building.tags.houseNumber != null) ...[
                      if (building.tags.houseNumber!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase())) ...[
                        BuildingSearchResult(
                          building: building,
                          busInfo: widget.busInfo,
                          buildingQuery: widget.buildingQuery,
                          nodeQuery: widget.nodeQuery,
                        )
                      ]
                    ]
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BusStopSearchResult extends StatelessWidget {
  final BusStop busStop;
  final BusInfo busInfo;
  final BuildingQuery buildingQuery;
  final NodeQuery nodeQuery;
  const BusStopSearchResult(
      {super.key,
      required this.busStop,
      required this.busInfo,
      required this.buildingQuery,
      required this.nodeQuery});

  @override
  Widget build(BuildContext context) {
    String direction = "";
    if (busStop.direction != null) {
      direction =
          busStop.direction == Direction.forward ? ", Forward" : ", Reverse";
    }
    return ListTile(
      onTap: () {
        Navigator.of(context).pop(busStop);
      },
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(busStop.name),
              Text(
                "Bus Stop$direction",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              )
            ],
          ),
          Expanded(child: Container()),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.directions_bus),
          ),
        ],
      ),
    );
  }
}

class BuildingSearchResult extends StatelessWidget {
  final Building building;
  final BusInfo busInfo;
  final BuildingQuery buildingQuery;
  final NodeQuery nodeQuery;
  const BuildingSearchResult(
      {super.key,
      required this.building,
      required this.busInfo,
      required this.buildingQuery,
      required this.nodeQuery});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pop(building);
      },
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  building.tags.name == null
                      ? building.tags.houseNumber == null
                          ? "Building"
                          : "P${building.tags.houseNumber}"
                      : building.tags.name!,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  maxLines: 1,
                ),
                Text(
                  "Building${building.tags.houseNumber != null ? ", ${building.tags.houseNumber}" : ""}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: () {
              if (building.tags.amenity != null) {
                if (building.tags.amenity! == "restaurant") {
                  return const Icon(Icons.restaurant);
                } else if (building.tags.amenity! == "place_of_worship") {
                  return const Icon(Icons.church);
                } else if (building.tags.amenity! == "school") {
                  return const Icon(Icons.school);
                } else if (building.tags.amenity! == "cinema") {
                  return const Icon(Icons.theaters);
                } else if (building.tags.amenity! == "post_office") {
                  return const Icon(Icons.local_post_office);
                } else {
                  return const Icon(Icons.apartment);
                }
              } else {
                return const Icon(Icons.apartment);
              }
            }(),
          ),
        ],
      ),
    );
  }
}
