import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moovlah_user/Models/OrderModel.dart';
import 'package:moovlah_user/Shared/YellowButton.dart';
import 'package:provider/provider.dart';

import '2.1, AddNotes.dart';
import '2.3, PaymentBreakUp.dart';

class AddMoreDetail extends StatefulWidget {
  const AddMoreDetail({super.key});

  @override
  State<AddMoreDetail> createState() => _AddMoreDetailState();
}

class _AddMoreDetailState extends State<AddMoreDetail> {
  File? imageFile;
  String newImage = '';
  Future getImage() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 300, maxWidth: 300);

    setState(() {
      imageFile = File(pickedFile!.path);
      Provider.of<Order>(context, listen: false)
          .addMoreDetailsImage(imageFile!);
    });
  }

  void paymentBreakUp() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: FractionallySizedBox(
              heightFactor: 0.6,
              child: Container(
                child: PaymentBreakUp(),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final favouriteDriverFirst =
        Provider.of<Order>(context).favouriteDriverFirstDisplay;
    final moreDetailsImage =
        Provider.of<Order>(context).moreDetailsImageDisplay;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[100],
          elevation: 0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/moovlah_logo_Singapore2022_5.png', width: 60),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddNotes()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 1.5,
                          color: const Color.fromARGB(255, 214, 214, 214)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidNoteSticky,
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
                            'Order Remarks',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<Order>(context, listen: false)
                        .selectFavouriteDriverFirst();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: favouriteDriverFirst
                          ? Colors.yellow.shade200
                          : Colors.white,
                      border: Border.all(
                          width: 1.5,
                          color: const Color.fromARGB(255, 214, 214, 214)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidHeart,
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
                            'Favourite Drivers First',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 1.5,
                          color: const Color.fromARGB(255, 214, 214, 214)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            // height: 90,
                            width: 90,
                            // ignore: sort_child_properties_last
                            child: moreDetailsImage != null
                                ? SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                      child: Image.file(
                                        moreDetailsImage,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  )
                                : const Icon(
                                    Icons.cloud_upload,
                                    color: Color.fromARGB(255, 202, 195, 0),
                                  ),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 252, 249, 157),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 22),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                FontAwesomeIcons.image,
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
                                'Add Image',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: GestureDetector(
                  onTap: () {
                    paymentBreakUp();
                  },
                  child: YellowButton(text: 'Next')),
            ),
          ],
        ),
      ),
    );
  }
}
