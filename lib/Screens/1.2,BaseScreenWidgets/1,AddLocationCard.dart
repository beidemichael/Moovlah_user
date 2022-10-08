import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../Models/OrderModel.dart';
import '../../Models/models.dart';
import '1.1,LocationSearchScreen.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  @override
  Widget build(BuildContext context) {
    final locationList = Provider.of<Order>(context).locationListDisplay;
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
              height: 60 * locationList.length.toDouble(),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: locationList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      index == 0
                          ? const Positioned(
                              top: 24,
                              left: 18,
                              child: Icon(
                                FontAwesomeIcons.circleDot,
                                size: 15.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            )
                          : index == locationList.length - 1
                              ? const Positioned(
                                  top: 24,
                                  left: 18,
                                  child: Icon(
                                    FontAwesomeIcons.locationDot,
                                    size: 18.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                )
                              : const Positioned(
                                  top: 24,
                                  left: 21,
                                  child: Icon(
                                    FontAwesomeIcons.circle,
                                    size: 11.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LocationSearchScreen(
                                            location: locationList[index],
                                          )));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 50.0, right: 25),
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
                                        Expanded(
                                          child: Text(
                                            locationList[index].description ==
                                                    ''
                                                ? locationList[index].name
                                                : locationList[index]
                                                    .description,
                                            softWrap: false,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18.0,
                                                color: locationList[index]
                                                            .description ==
                                                        ''
                                                    ? const Color.fromARGB(
                                                        255, 160, 160, 160)
                                                    : const Color.fromARGB(
                                                        255, 0, 0, 0)),
                                          ),
                                        ),
                                        index != 0 &&
                                                index != locationList.length - 1
                                            ? GestureDetector(
                                                onTap: () {
                                                  Provider.of<Order>(context,
                                                          listen: false)
                                                      .removeLocation(index);
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  color: Colors.white,
                                                  child: const Icon(
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
                Provider.of<Order>(context, listen: false).addMidLocation();
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
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
