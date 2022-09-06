import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../bloc/branch_bloc/branch_bloc.dart';
import '../../../main.dart';
import '../../../models/branchDetail.dart';
import '../../../models/branch_request.dart';
import '../../widgets/textformfield.dart';

class Branches extends StatefulWidget {
  const Branches({Key? key}) : super(key: key);
  static String routeName = '/branches';

  @override
  State<Branches> createState() => _BranchesState();
}

class _BranchesState extends State<Branches> {
  TextEditingController itemController = TextEditingController();
  late BranchBloc branchBloc;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    branchBloc = BlocProvider.of<BranchBloc>(context);
    branchBloc.stream.listen((state) {
      if (state is CreateBranchDone) {
        showToast(message: "Branch created successfully");
        branchBloc.add(FetchBranch());
      } else if (state is CreateBranchError) {
        showToast(message: "Branch not created", isError: true);
      } else if (state is UpdateBranchDone) {
        showToast(message: "Branch updated successfully");
        setState(() {
          id = 0;
        });
        branchBloc.add(FetchBranch());
      } else if (state is UpdateBranchError) {
        showToast(message: "Branch not updated", isError: true);
      } else if (state is DeleteBranchDone) {
        showToast(message: "Branch deleted successfully");
        branchBloc.add(FetchBranch());
      } else if (state is DeleteBranchError) {
        showToast(message: "Branch not deleted", isError: true);
      }
    });
    branchBloc.add(FetchBranch());

    super.initState();
  }

  List<BranchDetail> branches = [];

  int id = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*   appBar: AppBar(
        title: const Text("Branches"),
        backgroundColor: Colors.deepPurple,
      ), */
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
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Image.asset(
                    'images/pngegg.png',
                    width: 350,
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.15,
                    right: MediaQuery.of(context).size.width * 0.5,
                    child: SizedBox(
                      width: 250.0,
                      child: DefaultTextStyle(
                        style: GoogleFonts.acme(
                            fontSize: 50, color: Colors.white.withOpacity(0.6)),
                        child: AnimatedTextKit(
                          isRepeatingAnimation: false,
                          animatedTexts: [
                            TyperAnimatedText('Create\n       Branches'),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                    )),
                Positioned(
                  top: 35,
                  right: 40,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldWidget(
                          controller: itemController,
                          title: "Branch",
                          color: Colors.white,
                          validator: (value) {
                            if (itemController.text == null ||
                                itemController.text == "") {
                              return "Please enter Branch name";
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      backgroundColor:
                                          Theme.of(context).primaryColor),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      id == 0
                                          ? context.read<BranchBloc>().add(
                                              CreateBranch(BranchRequest(
                                                  Branchname:
                                                      itemController.text)))
                                          : context.read<BranchBloc>().add(
                                              UpdateBranchEvent(
                                                  id,
                                                  BranchRequest(
                                                      Branchname: itemController
                                                          .text)));
                                      itemController.clear();
                                    }
                                  },
                                  label: id == 0
                                      ? const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Create",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("Update",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                  icon: id == 0
                                      ? const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.update,
                                          color: Colors.white,
                                        ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<BranchBloc, BranchState>(
              builder: (context, state) {
                if (state is BranchDone) {
                  branches = state.branchList;
                  return Expanded(
                    child: ListView.builder(
                       padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      itemCount: branches.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            if (index == 0)
                              ListTile(
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
                                        "Branch Name",
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
                                        "Created At",
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
                                    if (branches[index].ID != id)
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
                            if (index == 0) Divider(),
                            ListTile(
                              selected: id == branches[index].ID,
                              selectedTileColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.4),
                              title: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      "#" + branches[index].ID.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: id == branches[index].ID
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      branches[index].branchName,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: id == branches[index].ID
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
                                      DateFormat('dd/MM/yyyy').format(
                                          DateTime.parse(
                                              branches[index].CreatedAt)),
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: id == branches[index].ID
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
                                  if (branches[index].ID != id)
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          color: Colors.deepPurple
                                              .withOpacity(0.1)),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: Colors.deepPurple,
                                        ),
                                        onPressed: () async {
                                          id = branches[index].ID;
                                          itemController.text =
                                              branches[index].branchName;

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
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onTap: () async {
                                        branchBloc.add(DeleteBranchEvent(
                                            branches[index].ID));
                                      },
                                    ),
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
