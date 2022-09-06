import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:billing_web/ui/screens/admin/sidedishes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bloc/newItem_bloc/new_item_bloc.dart';
import '../../../bloc/sidedish_bloc/sidedish_bloc.dart';
import '../../../main.dart';
import '../../../models/newItem_request.dart';
import '../../../models/sidedish_detail.dart';
import '../../widgets/textformfield.dart';

class NewItemCreatePage extends StatefulWidget {
  static String routeName = '/newItem';
  const NewItemCreatePage({Key? key}) : super(key: key);

  @override
  State<NewItemCreatePage> createState() => _NewItemCreatePageState();
}

class _NewItemCreatePageState extends State<NewItemCreatePage> {
  TextEditingController itemController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  String unit = '';
  late SidedishBloc sidedishBloc;
  late NewItemBloc newItemBloc;
  int id = 0;
  List<SidedishDetail> sidedishList = [];

  List selectedSidedish = [];

  @override
  void initState() {
    sidedishBloc = BlocProvider.of<SidedishBloc>(context);
    sidedishBloc.add(FetchSidedish());
    newItemBloc = BlocProvider.of<NewItemBloc>(context);
    newItemBloc.stream.listen((state) {
      if (state is NewItemDone) {
        showToast(message: "New item created succesfully");
      } else if (state is NewItemError) {
        showToast(message: "Somnething went wrong", isError: true);
      }
    });
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: const Text("Create New Item"),
      ), */
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: TextButton.icon(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Theme.of(context).primaryColor),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              log(selectedSidedish.join(","));
              context.read<NewItemBloc>().add(createNewitem(NewitemRequest(
                  Itemname: itemController.text,
                  Itemprice: "100",
                  Sidedishes: selectedSidedish.join(","),
                  Itemquantity: quantityController.text,
                  Itemstatus: true)));
              itemController.clear();
              quantityController.clear();
              unitController.clear();
              setState(() {
                selectedSidedish.clear();
              });
            }
          },
          label: Padding(
            padding: const EdgeInsets.all(10),
            child: Text("Create",
                style: GoogleFonts.aclonica(
                    color: Colors.white, fontWeight: FontWeight.bold)
                // TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
          ),
          icon: const Icon(
            Icons.add,
            size: 20,
            color: Colors.white,
          )),
      body: Form(
        key: formKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //    crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  RotatedBox(
                    quarterTurns: 0,
                    child: Image.network(
                      "https://devexperts.com/blog/wp-content/uploads/2012/11/Post-inner-banner-2336x1314-1-1752x986.png",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.43,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 20,
                    child: Image.asset(
                      'images/chefmenu.png',
                      width: 450,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.15,
                      left: MediaQuery.of(context).size.width * 0.50,
                      child: SizedBox(
                        width: 250.0,
                        child: DefaultTextStyle(
                          style: GoogleFonts.acme(
                              fontSize: 50,
                              color: Colors.white.withOpacity(0.6)),
                          child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            animatedTexts: [
                              TyperAnimatedText('Create\n     MenuItem'),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                      )),
                  Positioned(
                    top: 60,
                    left: 10,
                    child: Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.3),
                      ),
                      width: MediaQuery.of(context).size.width * 0.4,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Column(
                        children: [
                          TextFieldWidget(
                            controller: itemController,
                            title: "Name",
                            color: Colors.white,
                            validator: (value) {
                              if (itemController.text == "") {
                                return "Please enter Item Name";
                              }
                            },
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.185,
                                child: TextFieldWidget(
                                  controller: quantityController,
                                  title: "Quantity",
                                  color: Colors.white,
                                  validator: (value) {
                                    if (quantityController.text == "") {
                                      return "Please enter Item Name";
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.185,
                                child: TextFieldWidget(
                                  controller: unitController,
                                  color: Colors.white,
                                  title: "Unit",
                                  validator: (value) {
                                    if (unitController.text == "") {
                                      return "Please enter Item Name";
                                    }
                                  },
                                ),
                              ),
                              /*  Container(
                                width: MediaQuery.of(context).size.width * 0.6 - 10,
                                padding: const EdgeInsets.only(top: 10, right: 10),
                                child: DropdownSearch<String>(
                                  popupProps: const PopupProps.menu(
                                    showSelectedItems: true,
                                  ),
                                  items: const ["Piece", "Weight(in grams)"],
                                  onChanged: (value) {
                                    setState(() {
                                      unit = value ?? "";
                                    });
                                  },
                                  selectedItem: unit,
                                ),
                              ), */
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Side Dishes",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(SideDishes.routeName)
                              .then(
                                  (value) => sidedishBloc.add(FetchSidedish()));
                        },
                        child: const Icon(Icons.add_box_rounded,
                            size: 30, color: Colors.white))
                  ],
                ),
              ),
              BlocBuilder<SidedishBloc, SidedishState>(
                builder: (context, state) {
                  if (state is SidedishDone) {
                    sidedishList = state.sidedishList;
                    return Expanded(
                      child: ListView.builder(
                          itemCount: sidedishList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              selected: id == sidedishList[index].ID,
                              selectedTileColor: Theme.of(context).primaryColor,
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      child: Text(
                                        sidedishList[index]
                                            .item
                                            .toCapitalized(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 80,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.deepPurple
                                              .withOpacity(0.1)),
                                      child: Text(
                                        sidedishList[index].quantity +
                                            " " +
                                            sidedishList[index].unit,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                        activeColor: Colors.deepPurple,
                                        value: selectedSidedish
                                            .contains(sidedishList[index].ID),
                                        onChanged: (value) {
                                          if (value == true) {
                                            setState(() {
                                              selectedSidedish
                                                  .add(sidedishList[index].ID);
                                            });
                                          } else {
                                            setState(() {
                                              selectedSidedish.remove(
                                                  sidedishList[index].ID);
                                            });
                                          }
                                        })
                                    /*   if (sidedishList[index].ID != id)
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () async {
                                          id = sidedishList[index].ID;
                                          itemController.text =
                                              sidedishList[index].item;
                                          setState(() {});
                                        },
                                      )
                                    else
                                      IconButton(
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Colors.black,
                                        ),
                                        onPressed: () async {
                                          id = 0;
                                          itemController.clear();
                                          setState(() {});
                                        },
                                      ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        /*   sidedishBloc.add(DeleteBranchEvent(
                                            branches[index].ID)); */
                                      },
                                    ), */
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
