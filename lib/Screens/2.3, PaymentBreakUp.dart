import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:moovlah_user/Service/PaymentController.dart';
import 'package:moovlah_user/Shared/YellowButton.dart';
import 'package:provider/provider.dart';

import '../Models/OrderModel.dart';

class PaymentBreakUp extends StatefulWidget {
  const PaymentBreakUp({super.key});

  @override
  State<PaymentBreakUp> createState() => _PaymentBreakUpState();
}

class _PaymentBreakUpState extends State<PaymentBreakUp> {
  bool paymentLoading = false;

  @override
  Widget build(BuildContext context) {
    final cash = Provider.of<Order>(context).cashDisplay;
    final locationList = Provider.of<Order>(context).locationList;
    final PaymentController controller = Get.put(PaymentController());
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        // ignore: prefer_const_constructors
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Payment Method',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25.0,
                color: Color.fromARGB(255, 0, 0, 0)),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 28,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            paymentLoading = true;
                          });
                          Provider.of<Order>(context, listen: false)
                              .selectCash();
                          controller.makePayment(amount: '5', currency: 'USD');
                          
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1.5,
                                color:
                                    const Color.fromARGB(255, 214, 214, 214)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.solidCreditCard,
                                      shadows: [
                                        BoxShadow(
                                          color: Colors.grey.shade900,
                                          blurRadius:
                                              4.0, //effect of softening the shadow
                                          spreadRadius:
                                              5, //effecet of extending the shadow
                                          offset: const Offset(
                                              0.0, //horizontal
                                              0.0 //vertical
                                              ),
                                        ),
                                      ],
                                      size: 20.0,
                                      color: const Color(0xFFFFF600),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const Text(
                                      'Creditcard/Debitcard',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    
                                  ],
                                ),
                                paymentLoading==true ? const SpinKitCircle(
                                  color: Colors.black,
                                  size: 20.0,
                                ): Container()
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            paymentLoading = false;
                          });
                          Provider.of<Order>(context, listen: false)
                              .selectCash();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: cash ? Colors.yellow.shade200 : Colors.white,
                            border: Border.all(
                                width: 1.5,
                                color:
                                    const Color.fromARGB(255, 214, 214, 214)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.moneyBill,
                                      shadows: [
                                        BoxShadow(
                                          color: Colors.grey.shade900,
                                          blurRadius:
                                              4.0, //effect of softening the shadow
                                          spreadRadius:
                                              5, //effecet of extending the shadow
                                          offset: const Offset(
                                              0.0, //horizontal
                                              0.0 //vertical
                                              ),
                                        ),
                                      ],
                                      size: 20.0,
                                      color: const Color(0xFFFFF600),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Cash',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.0,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                        ),
                                        const Text(
                                          'Select who is paying',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15.0,
                                              color: Color.fromARGB(
                                                  255, 131, 131, 131)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                cash
                                    ? const Icon(
                                        FontAwesomeIcons.angleUp,
                                        size: 20.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )
                                    : const Icon(
                                        FontAwesomeIcons.angleDown,
                                        size: 20.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      cash
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Provider.of<Order>(context, listen: false)
                                      //     .selectFavouriteDriverFirst();
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.5,
                                            color: const Color.fromARGB(
                                                255, 214, 214, 214)),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0, vertical: 13),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.circleDot,
                                              shadows: [
                                                BoxShadow(
                                                  color: Colors.grey.shade900,
                                                  blurRadius:
                                                      4.0, //effect of softening the shadow
                                                  spreadRadius:
                                                      5, //effecet of extending the shadow
                                                  offset: const Offset(
                                                      0.0, //horizontal
                                                      0.0 //vertical
                                                      ),
                                                ),
                                              ],
                                              size: 20.0,
                                              color: const Color(0xFFFFF600),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Sender',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18.0,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0)),
                                                  ),
                                                  Text(
                                                    locationList
                                                        .first.description,
                                                    softWrap: false,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15.0,
                                                        color: Color.fromARGB(
                                                            255,
                                                            131,
                                                            131,
                                                            131)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Provider.of<Order>(context, listen: false)
                                      //     .selectFavouriteDriverFirst();
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.5,
                                            color: const Color.fromARGB(
                                                255, 214, 214, 214)),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0, vertical: 13),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.locationDot,
                                              shadows: [
                                                BoxShadow(
                                                  color: Colors.grey.shade900,
                                                  blurRadius:
                                                      4.0, //effect of softening the shadow
                                                  spreadRadius:
                                                      5, //effecet of extending the shadow
                                                  offset: const Offset(
                                                      0.0, //horizontal
                                                      0.0 //vertical
                                                      ),
                                                ),
                                              ],
                                              size: 20.0,
                                              color: const Color(0xFFFFF600),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Recipient',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18.0,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0)),
                                                  ),
                                                  Text(
                                                    locationList
                                                        .last.description,
                                                    softWrap: false,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15.0,
                                                        color: Color.fromARGB(
                                                            255,
                                                            131,
                                                            131,
                                                            131)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: GestureDetector(
              onTap: () {
                //  Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (_) => CardPaymentScreen()));
              },
              child: YellowButton(text: 'Place Order'),
            ),
          ),
        ],
      ),
    );
  }
}