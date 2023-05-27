import 'package:bus_router/bus.dart';
import 'package:flutter/material.dart';

class BusLineDetail extends StatefulWidget {
  final BusRoute busRoute;
  const BusLineDetail({super.key, required this.busRoute});

  @override
  State<BusLineDetail> createState() => _BusLineDetailState();
}

class _BusLineDetailState extends State<BusLineDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
          child: Text(widget.busRoute.lineName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: widget.busRoute.color)),
        ),
        TextButton.icon(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  Theme.of(context).textTheme.bodySmall!),
              iconSize: MaterialStateProperty.all<double>(16),
            ),
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Schedule")),
        for (int i = 0; i < widget.busRoute.busNodes.length; i++) ...[
          BusNodeWidget(
            busNode: widget.busRoute.busNodes[i],
            busRoute: widget.busRoute,
            index: i,
          ),
        ],
      ],
    );
  }
}

class BusNodeWidget extends StatelessWidget {
  final BusNode busNode;
  final BusRoute busRoute;
  final int index;
  final void Function()? onTap;
  const BusNodeWidget({
    super.key,
    required this.busNode,
    required this.busRoute,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          children: [
            SizedBox(
              width: 32,
              height: 50,
              child: Builder(
                builder: (context) {
                  if (index == 0) {
                    return Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Container(
                            width: 3,
                            height: 25,
                            color: busRoute.color,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: busRoute.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (index == busRoute.busNodes.length - 1) {
                    return Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            width: 3,
                            height: 25,
                            color: busRoute.color,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: busRoute.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          width: 3,
                          color: busRoute.color,
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: busRoute.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(busNode.busStop),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${busNode.arrivalTime.inMinutes} min"),
            ),
          ],
        ),
      ),
    );
  }
}
