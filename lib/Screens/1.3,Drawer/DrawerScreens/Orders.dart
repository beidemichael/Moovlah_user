// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../Models/OrderModel.dart';
import '../../../Models/models.dart';
import 'OrdersWidget/OrdesCard.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<OrdersModel>>(context);
    final dartMode = Provider.of<Order>(context).dartMode;
    // ignore: prefer_const_constructors
    var upperTab = TabBar(
        indicatorColor: Color.fromARGB(255, 235, 227, 0),
        indicatorWeight: 6,
        // indicator: BoxDecoration(
        //   color: Color.fromARGB(255, 255, 250, 119),
        //   borderRadius: BorderRadius.all(
        //     const Radius.circular(55.0),
        //   ),
        // ),
        tabs: <Tab>[
          Tab(
            child: Text('InProgress',
                style: TextStyle(
                    fontSize: 18.0,
                    color: dartMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500)),
          ),
          Tab(
            child: Text('Concluded',
                style: TextStyle(
                    fontSize: 18.0,
                    color: dartMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500)),
          ),
          Tab(
            child: Text('Dropped',
                style: TextStyle(
                    fontSize: 18.0,
                    color: dartMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500)),
          ),
        ]);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: dartMode ? Colors.grey[800] : Colors.grey[50],
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: dartMode ? Colors.grey[800] : Colors.grey[50],
            // foregroundColor: Colors.red,
            elevation: 0,
            surfaceTintColor: Color(0xFFFFF600),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Text('Orders',
                    style: TextStyle(
                        fontSize: 21.0,
                        color: dartMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            bottom: upperTab,
            iconTheme: const IconThemeData(color: Colors.black)),
        body: TabBarView(
          children: [
            Container(
              color: dartMode ? Colors.grey[600] : Colors.grey[200],
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    if (orders[index].isTaken == true &&
                        orders[index].isCanceled == false &&
                        orders[index].isDelivered == false) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius:
                                    2.0, //effect of softening the shadow
                                spreadRadius:
                                    0.2, //effecet of extending the shadow
                                offset: const Offset(
                                    0.0, //horizontal
                                    2.0 //vertical
                                    ),
                              ),
                            ],
                            color: Colors.white,
                            // ignore: prefer_const_constructors
                            borderRadius: BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          child: OrdersCard(order: orders[index]),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
            Container(
              color: dartMode ? Colors.grey[600] : Colors.grey[200],
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    if (orders[index].isTaken == true &&
                        orders[index].isCanceled == false &&
                        orders[index].isDelivered == true) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius:
                                    2.0, //effect of softening the shadow
                                spreadRadius:
                                    0.2, //effecet of extending the shadow
                                offset: const Offset(
                                    0.0, //horizontal
                                    2.0 //vertical
                                    ),
                              ),
                            ],
                            color: Colors.white,
                            // ignore: prefer_const_constructors
                            borderRadius: BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          child: OrdersCard(order: orders[index]),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
            Container(
              color: dartMode ? Colors.grey[600] : Colors.grey[200],
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    if (orders[index].isCanceled == true ) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius:
                                    2.0, //effect of softening the shadow
                                spreadRadius:
                                    0.2, //effecet of extending the shadow
                                offset: const Offset(
                                    0.0, //horizontal
                                    2.0 //vertical
                                    ),
                              ),
                            ],
                            color: Colors.white,
                            // ignore: prefer_const_constructors
                            borderRadius: BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          child: OrdersCard(order: orders[index]),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
