// ignore_for_file: file_names, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, prefer_is_empty

import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moovlah_user/Models/models.dart';
import 'package:provider/provider.dart';

import '../../Models/OrderModel.dart';
import '2,VehiclesListWidgets/ExtraServices.dart';
import '2,VehiclesListWidgets/Specifications.dart';

class VehiclesList extends StatefulWidget {
  final Vehicles vehicle;
  final int index;
  VehiclesList({
    super.key,
    required this.vehicle,
    required this.index,
  });

  @override
  State<VehiclesList> createState() => _VehiclesListState();
}

class _VehiclesListState extends State<VehiclesList> {
  @override
  Widget build(BuildContext context) {
    final vehicleName = Provider.of<Order>(context).vehicleNameDisplay;
    final totalDistanceInt =
        Provider.of<Order>(context).totalDistanceIntDisplay;
    final dartMode = Provider.of<Order>(context).dartMode;
    return Column(
      children: [
        Padding(
          padding: widget.index % 2 == 0
              ? const EdgeInsets.only(top: 18.0, left: 25)
              : const EdgeInsets.only(top: 18.0, right: 25),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: dartMode ? Colors.black : Colors.grey.shade400,
                    blurRadius: 5.0, //effect of softening the shadow
                    spreadRadius: 0.5, //effecet of extending the shadow
                    offset: const Offset(
                        0.0, //horizontal
                        5.0 //vertical
                        ),
                  ),
                ],
                color: dartMode ? Colors.grey[800] : Colors.white,
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: widget.index % 2 == 0
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    widget.index % 2 != 0
                        ? const SizedBox(
                            width: 25,
                          )
                        : Container(),
                    Container(
                        height: 80,
                        width: 80,
                        // ignore: sort_child_properties_last
                        child: widget.vehicle.image != ''
                            ? Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    height: 60,
                                    width: 60,
                                    // fit: BoxFit.coer,
                                    imageUrl: widget.vehicle.image,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                    Color>(Colors.black),
                                            value: downloadProgress.progress),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              )
                            : const Center(
                                child: Icon(FontAwesomeIcons.car,
                                    size: 30, color: Color(0xFFFFF600)),
                              ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF600),
                          border: Border.all(width: 1, color: Colors.black),
                          boxShadow: [
                            BoxShadow(
                              color: dartMode
                                  ? Colors.black
                                  : Colors.grey.shade400,
                              blurRadius: 5.0, //effect of softening the shadow
                              spreadRadius:
                                  0.5, //effecet of extending the shadow
                              offset: const Offset(
                                  0.0, //horizontal
                                  5.0 //vertical
                                  ),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(100),
                        )),
                    const SizedBox(
                      width: 13,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.vehicle.type,
                              style:  TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22.0,
                                  color: dartMode ? Colors.white : Colors.black,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.vehicle.description,
                                      softWrap: false,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:  TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15.0,
                                          color: dartMode
                                              ? Color.fromARGB(255, 214, 214, 214)
                                              : Color.fromARGB(
                                                255, 126, 126, 126), ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(widget.vehicle.dimension + 'Meter',
                                    style:  TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0,
                                        color: dartMode
                                              ? Color.fromARGB(255, 187, 187, 187)
                                              : Color.fromARGB(
                                                255, 126, 126, 126))),
                                Text(
                                    ', Up to ' + widget.vehicle.capacity + 'KG',
                                    style:  TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0,
                                        color: dartMode
                                            ? Color.fromARGB(255, 187, 187, 187)
                                            : Color.fromARGB(
                                                255, 126, 126, 126))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        vehicleName == widget.vehicle.type
            ? ExtraServices(
                vehicle: widget.vehicle,
              )
            : Container(),
        vehicleName == widget.vehicle.type
            ? widget.vehicle.specification.length != 0
                ? Specifications(
                    vehicle: widget.vehicle,
                  )
                : Container()
            : Container(),
      ],
    );
  }
}
