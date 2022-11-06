// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/OrderModel.dart';
import '../../../Models/models.dart';

class Specifications extends StatefulWidget {
  final Vehicles vehicle;

  const Specifications({super.key, required this.vehicle});

  @override
  State<Specifications> createState() => _SpecificationsState();
}

class _SpecificationsState extends State<Specifications> {
  @override
  Widget build(BuildContext context) {
    final vehicleSpecification =
        Provider.of<Order>(context).vehicleSpecificationDisplay;
        final dartMode = Provider.of<Order>(context).dartMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              
              'Specifications',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  color: dartMode ? Colors.white : Colors.black,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.vehicle.specification.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Provider.of<Order>(context, listen: false).addSpecification(
                        widget.vehicle.specification[index],
                        widget.vehicle.specificationPrice[index].toDouble());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: vehicleSpecification
                                .contains(widget.vehicle.specification[index])
                            ? Colors.yellow.shade200
                            : dartMode
                                ? Colors.grey[700]
                                : Colors.white,
                        border: Border.all(width: 1, color: Colors.grey.shade500),
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
                              widget.vehicle.specification[index],
                              style:  TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                  color: dartMode ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              r'S$' +
                                  widget.vehicle.specificationPrice[index]
                                      .toString(),
                              style:  TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                  color: dartMode ? Colors.white : Colors.black,
                              ),
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
