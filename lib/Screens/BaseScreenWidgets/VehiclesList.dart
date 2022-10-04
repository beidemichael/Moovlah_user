import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moovlah_user/Models/models.dart';

import 'VehiclesListWidgets/ExtraServices.dart';

class VehiclesList extends StatefulWidget {
  final Vehicles vehicle;
  final int index;
  int checkedindex;
  VehiclesList(
      {super.key,
      required this.vehicle,
      required this.index,
      required this.checkedindex});

  @override
  State<VehiclesList> createState() => _VehiclesListState();
}

class _VehiclesListState extends State<VehiclesList> {
  @override
  Widget build(BuildContext context) {
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
                    color: Colors.grey.shade400,
                    blurRadius: 5.0, //effect of softening the shadow
                    spreadRadius: 0.5, //effecet of extending the shadow
                    offset: const Offset(
                        0.0, //horizontal
                        5.0 //vertical
                        ),
                  ),
                ],
                color: Colors.white,
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
                                      child: Container(
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
                              color: Colors.grey.shade400,
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22.0,
                                  color: Colors.black),
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
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15.0,
                                          color: Color.fromARGB(
                                              255, 126, 126, 126)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(widget.vehicle.dimension + 'Meter',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0,
                                        color: Color.fromARGB(
                                            255, 126, 126, 126))),
                                Text(
                                    ', Up to ' + widget.vehicle.capacity + 'KG',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0,
                                        color: Color.fromARGB(
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
        widget.checkedindex == widget.index
            ? ExtraServices(
                vehicle: widget.vehicle,
              )
            : Container()
      ],
    );
  }
}
