import 'package:flutter/material.dart';

class Attribution extends StatefulWidget {
  const Attribution({super.key});

  @override
  State<Attribution> createState() => _AttributionState();
}

class _AttributionState extends State<Attribution> {
  @override
  Widget build(BuildContext context) {
    // Should be opened by a URL Launcher
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            showModalBottomSheet(
                showDragHandle: true,
                context: context,
                builder: (context) {
                  return const SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("© Mapbox"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("© OpenStreetMap"),
                        )
                      ],
                    ),
                  );
                });
          },
        ),
        Expanded(child: Container()),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.map),
        ),
      ],
    );
  }
}
