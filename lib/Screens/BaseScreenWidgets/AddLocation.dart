import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Models/models.dart';

class AddLocation extends StatefulWidget {
  final List<LocationList> locationList;
  const AddLocation({super.key, required this.locationList});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
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
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Column(
          children: [
            Container(
              // color: Colors.green,
              height: 60 * widget.locationList.length.toDouble(),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.locationList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0, right: 25),
                        child: Container(
                          height: 60,
                          // color: Colors.red[200],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.locationList[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0,
                                        color:
                                            Color.fromARGB(255, 138, 138, 138)),
                                  ),
                                  index != 0 &&
                                          index !=
                                              widget.locationList.length - 1
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget.locationList.remove(
                                                  widget.locationList[index]);
                                            });
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            color: Colors.white,
                                            child: Icon(
                                              FontAwesomeIcons.xmark,
                                              size: 20.0,
                                              color: Color.fromARGB(
                                                  255, 138, 138, 138),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Container(
                          height: 0.5,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  LocationList lastLocation = widget.locationList.last;
                  widget.locationList.remove(widget.locationList.last);
                  widget.locationList.add(
                      LocationList(name: 'Mid-stop location', location: ''));
                  widget.locationList.add(lastLocation);
                });
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      // ignore: prefer_const_constructors
                      Icon(
                        FontAwesomeIcons.plus,
                        size: 22.0,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      // ignore: prefer_const_constructors
                      Text(
                        'Add Stoppage',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
