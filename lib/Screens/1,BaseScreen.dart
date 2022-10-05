import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovlah_user/Models/models.dart';
import 'package:moovlah_user/Screens/1.2,BaseScreenWidgets/1,AddLocationCard.dart';
import 'package:moovlah_user/Screens/1.2,BaseScreenWidgets/2,VehiclesListCard.dart';
import 'package:provider/provider.dart';

import '1.3,Drawer/DrawerContent.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  ScrollController? scrollController;
  List<LocationList> locationList = [
    LocationList(name: 'Pick-up location', location: LatLng(0.0, 0.0),description: '' ),
    LocationList(name: 'Drop-off location', location: LatLng(0.0, 0.0), description: '')
  ];
  int checkedindex = 10000;
   @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    
  }
  @override
  Widget build(BuildContext context) {
    final vehicles = Provider.of<List<Vehicles>>(context);
    return Scaffold(
      drawer: const DrawerContent(),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/moovlah_logo_Singapore2022_5.png', width: 60),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.black)),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            AddLocation(
              locationList: locationList,
            ),
            ListView.builder(
              shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      checkedindex = index;
                    });
                  },
                  child: Stack(
                    children: [
                      VehiclesList(
                          vehicle: vehicles[index],
                          index: index,
                          checkedindex: checkedindex),
                      checkedindex == index
                          ? index % 2 == 0
                              ? const Positioned(
                                  top: 5,
                                  left: 15,
                                  child: Icon(
                                    FontAwesomeIcons.solidCircleCheck,
                                    size: 25.0,
                                    color: Colors.black,
                                  ),
                                )
                              : const Positioned(
                                  top: 5,
                                  right: 15,
                                  child: Icon(
                                    FontAwesomeIcons.solidCircleCheck,
                                    size: 25.0,
                                    color: Colors.black,
                                  ),
                                )
                          : Container(height: 1, width: 1, color: Colors.red)
                    ],
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
