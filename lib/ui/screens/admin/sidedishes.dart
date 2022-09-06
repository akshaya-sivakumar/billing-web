import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bloc/sidedish_bloc/sidedish_bloc.dart';
import '../../../main.dart';
import '../../../models/createSidedish_request.dart';
import '../../../models/sidedish_detail.dart';
import '../../widgets/textformfield.dart';

class SideDishes extends StatefulWidget {
  const SideDishes({Key? key}) : super(key: key);
  static String routeName = '/sidedishes';

  @override
  State<SideDishes> createState() => _BranchesState();
}

class _BranchesState extends State<SideDishes> {
  TextEditingController itemController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  late SidedishBloc sidedishBloc;
  @override
  void initState() {
    sidedishBloc = BlocProvider.of<SidedishBloc>(context);
    sidedishBloc.add(FetchSidedish());
    sidedishBloc.stream.listen((state) {
      if (state is CreateSidedishDone) {
        showToast(message: "Created successfully");
        itemController.clear();
        quantityController.clear();
        unitController.clear();
        sidedishBloc.add(FetchSidedish());
      } else if (state is CreateSidedishError) {
        showToast(message: "Not Created successfully", isError: true);
        sidedishBloc.add(FetchSidedish());
      } else if (state is UpdateSidedishDone) {
        showToast(message: "Updated successfully");
        itemController.clear();
        quantityController.clear();
        unitController.clear();
        setState(() {
          id = 0;
        });
        sidedishBloc.add(FetchSidedish());
      } else if (state is UpdateSidedishError) {
        showToast(message: "Not Updated successfully", isError: true);
        sidedishBloc.add(FetchSidedish());
      } else if (state is DeleteSidedishDone) {
        showToast(message: "Deleted successfully");
        sidedishBloc.add(FetchSidedish());
      } else if (state is DeleteSidedishError) {
        showToast(message: "not deleted");
      }
    });
    super.initState();
  }

  List<SidedishDetail> sidedishes = [];
  final formKey = GlobalKey<FormState>();
  int id = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("SideDishes")),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                RotatedBox(
                  quarterTurns: 2,
                  child: Image.network(
                    "https://devexperts.com/blog/wp-content/uploads/2012/11/Post-inner-banner-2336x1314-1-1752x986.png",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.43,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 50,
                  child: Image.asset(
                    'images/sidedish_image.png',
                    width: 350,
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                  ),
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.15,
                    right: MediaQuery.of(context).size.width * 0.55,
                    child: SizedBox(
                      width: 250.0,
                      child: DefaultTextStyle(
                        style: GoogleFonts.acme(
                            fontSize: 50, color: Colors.white.withOpacity(0.6)),
                        child: AnimatedTextKit(
                          isRepeatingAnimation: false,
                          animatedTexts: [
                            TyperAnimatedText('Create\n       Sidedish'),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                    )),
                Positioned(
                  top: 50,
                  right: 50,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        TextFieldWidget(
                          controller: itemController,
                          title: "Side dish",
                          color: Colors.white,
                          validator: (value) {
                            if (itemController.text == null ||
                                itemController.text == "") {
                              return "Please enter dish name";
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.185,
                              child: TextFieldWidget(
                                controller: quantityController,
                                color: Colors.white,
                                title: "Quantity",
                                validator: (value) {
                                  if (quantityController.text == null ||
                                      quantityController.text == "") {
                                    return "Please enter Quantity";
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.185,
                              child: TextFieldWidget(
                                controller: unitController,
                                color: Colors.white,
                                title: "Unit",
                                validator: (value) {
                                  if (unitController.text == null ||
                                      unitController.text == "") {
                                    return "Please enter Unit";
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        backgroundColor:
                                            Theme.of(context).primaryColor),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        id == 0
                                            ? context.read<SidedishBloc>().add(
                                                CreateSidedish(
                                                    CreateSidedishRequest(
                                                        Item:
                                                            itemController.text,
                                                        Quantity:
                                                            quantityController
                                                                .text,
                                                        Unit: unitController
                                                            .text)))
                                            : context.read<SidedishBloc>().add(
                                                UpdateSidedishEvent(
                                                    id,
                                                    CreateSidedishRequest(
                                                        Item:
                                                            itemController.text,
                                                        Quantity:
                                                            quantityController
                                                                .text,
                                                        Unit: unitController
                                                            .text)));
                                      }
                                    },
                                    label: id == 0
                                        ? const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Create",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Update",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                    icon: id == 0
                                        ? const Icon(Icons.add,
                                            color: Colors.white)
                                        : const Icon(Icons.update,
                                            color: Colors.white)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<SidedishBloc, SidedishState>(
              builder: (context, state) {
                if (state is SidedishDone) {
                  sidedishes = state.sidedishList;
                  return Expanded(
                    child: ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      itemCount: sidedishes.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            if (index == 0)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          "ID",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.deepPurple),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          "Sidedish Name",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.deepPurple),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 7),
                                        width: 150,
                                        child: Text(
                                          "Quantity",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (sidedishes[index].ID != id)
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: InkWell(
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.deepPurple,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        "Delete",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.deepPurple,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (index == 0) Divider(),
                            ListTile(
                              selected: id == sidedishes[index].ID,
                              selectedTileColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.4),
                              title: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      "#" + sidedishes[index].ID.toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: id == sidedishes[index].ID
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      sidedishes[index].item.toCapitalized(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: id == sidedishes[index].ID
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                  ),
                                  Container(
                                    width: 150,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color:
                                            Colors.deepPurple.withOpacity(0.1)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 7),
                                    child: Text(
                                      (sidedishes[index].quantity == ""
                                              ? "-"
                                              : sidedishes[index].quantity) +
                                          " " +
                                          (sidedishes[index].unit == ""
                                              ? "-"
                                              : sidedishes[index].unit),
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: id == sidedishes[index].ID
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (sidedishes[index].ID != id)
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          color: Colors.deepPurple
                                              .withOpacity(0.1)),
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        child: const Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: Colors.deepPurple,
                                        ),
                                        onTap: () async {
                                          id = sidedishes[index].ID;
                                          itemController.text =
                                              sidedishes[index].item;
                                          quantityController.text =
                                              sidedishes[index].quantity;
                                          unitController.text =
                                              sidedishes[index].unit;
                                          setState(() {});
                                        },
                                      ),
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
                                  SizedBox(
                                    width: 50,
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      sidedishBloc.add(DeleteSidedishEvent(
                                          sidedishes[index].ID));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }

                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
