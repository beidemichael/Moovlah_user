// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/OrderModel.dart';
import '../../../Models/models.dart';

class ExtraServices extends StatefulWidget {
  final Vehicles vehicle;
  const ExtraServices({super.key, required this.vehicle});

  @override
  State<ExtraServices> createState() => _ExtraServicesState();
}

class _ExtraServicesState extends State<ExtraServices> {
  @override
  Widget build(BuildContext context) {
    final vehicleService = Provider.of<Order>(context).vehicleServiceDisplay;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Extra Services',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  color: Colors.black),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.vehicle.extraService.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Provider.of<Order>(context, listen: false).addExtraService(
                        widget.vehicle.extraService[index],
                        widget.vehicle.extraServicePrice[index].toDouble());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: vehicleService
                                .contains(widget.vehicle.extraService[index])
                            ? Colors.yellow.shade200
                            : Colors.white,
                        border:
                            Border.all(width: 1, color: Colors.grey.shade500),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.vehicle.extraService[index],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                  color: Colors.black),
                            ),
                            Text(
                              r'S$' +
                                  widget.vehicle.extraServicePrice[index]
                                      .toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
