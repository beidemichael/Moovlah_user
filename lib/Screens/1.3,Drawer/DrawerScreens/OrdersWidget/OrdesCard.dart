import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../Models/models.dart';

class OrdersCard extends StatefulWidget {
  OrdersModel order;
  OrdersCard({super.key, required this.order});

  @override
  State<OrdersCard> createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              DateFormat('E,dd MMM,').add_jm().format(
                  DateTime.parse(widget.order.time.toDate().toString())),
              style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.order.ordersModelLocationSub
                  .locationListdescription.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    index == 0
                        ? const Positioned(
                             top: 12,
                            left: 9,
                            child: Icon(
                              FontAwesomeIcons.circleDot,
                              size: 10.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          )
                        : index == widget.order.ordersModelLocationSub
                                        .locationListdescription.length - 1
                            ? const Positioned(
                                top: 12,
                                left: 9,
                                child: Icon(
                                  FontAwesomeIcons.locationDot,
                                  size: 12.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              )
                            : const Positioned(
                                 top: 12,
                                left: 9,
                                child: Icon(
                                  FontAwesomeIcons.circle,
                                  size: 10.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                            widget.order.ordersModelLocationSub
                                .locationListdescription[index],
                            style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                );
              }),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.order.vehicleName,
                  style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400)),
              // ignore: prefer_interpolation_to_compose_strings
              Text('S\$' + widget.order.totalPrice.toString(),
                  style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ],
    );
  }
}
