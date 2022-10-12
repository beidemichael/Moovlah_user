// ignore_for_file: unrelated_type_equality_checks, file_names, unused_import

import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovlah_user/Models/models.dart';
import 'package:moovlah_user/Screens/1.2,BaseScreenWidgets/1,AddLocationCard.dart';
import 'package:moovlah_user/Screens/1.2,BaseScreenWidgets/2,VehiclesListCard.dart';
import 'package:moovlah_user/Shared/YellowButton.dart';
import 'package:provider/provider.dart';
import '../Shared/MeasureHeight.dart';
import '../Models/OrderModel.dart';
import '1.3,Drawer/DrawerContent.dart';
import '2, AddMoreDetail.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  ScrollController? scrollController;
  int checkedindex = 10000;
  var myChildSize = Size.zero;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final vehicles = Provider.of<List<Vehicles>>(context);
    final vehicleName = Provider.of<Order>(context).vehicleNameDisplay;
    final vehicleAndLocationComplete =
        Provider.of<Order>(context).checkLocationInputIsAllFilled();
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
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                const AddLocation(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   checkedindex = index;
                        // });
                        Provider.of<Order>(context, listen: false).addVehicle(
                            vehicles[index].type, vehicles[index].price);
                      },
                      child: Stack(
                        children: [
                          VehiclesList(
                            vehicle: vehicles[index],
                            index: index,
                          ),
                          vehicleName == vehicles[index].type
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
                              : Container(
                                  height: 1, width: 1, color: Colors.red)
                        ],
                      ),
                    );
                  },
                ),
                vehicleAndLocationComplete == true
                    ? Container(
                        height: myChildSize.height + 20,
                      )
                    : Container()
              ],
            ),
            vehicleAndLocationComplete == true
                ? Positioned(
                    bottom: 0,
                    child: MeasureSize(
                      onChange: (size) {
                        setState(() {
                          myChildSize = size;
                        });
                      },
                      child: Container(
                        // height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius:
                                  1055.0, //effect of softening the shadow
                              spreadRadius:
                                  1.7, //effecet of extending the shadow
                              offset: const Offset(
                                  0.0, //horizontal
                                  -40.0 //vertical
                                  ),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60.0, bottom: 40),
                          child: Center(
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => 
                                        const AddMoreDetail()
                                      ),
                                    );
                                  },
                                  child: YellowButton(text: 'Next'))),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
