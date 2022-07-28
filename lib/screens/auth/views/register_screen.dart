import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketitik/screens/auth/controller/login_controller.dart';
import 'package:ketitik/utility/application_utils.dart';

import '../../../utility/colorss.dart';
import '../../../utility/custom_textfield.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final String? name;
  final String? emailID;
  final String? socialID;
  //final int? contactNumber;
  RegisterScreen({
    Key? key,
    this.name,
    this.emailID,
    this.socialID,
    //this.contactNumber,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _controller = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController? _nameController;

  TextEditingController? _emailController;

  TextEditingController? _socialController;

  //TextEditingController? _contactController;

  bool isTapped = false;

  @override
  void initState() {
    if (widget.name != null &&
        widget.emailID != null &&
        widget.socialID != null) {
      _nameController = TextEditingController(text: widget.name);
      _emailController = TextEditingController(text: widget.emailID);
      _socialController = TextEditingController(text: widget.socialID);
      //_contactController = TextEditingController();
    } else {
      _nameController = TextEditingController();
      _emailController = TextEditingController();
      _socialController = TextEditingController();
      //_contactController = TextEditingController();
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController!.dispose();
    _emailController!.dispose();
    _socialController!.dispose();
    // _contactController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Name :${widget.name}");
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: height,
              width: width,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.3,
                      child: Image.asset(
                        "assets/images/ketsquarezoom.png",
                        width: 180,
                        height: 180,
                      ),
                    ),
                    CustomTextField(
                      hintText: 'Name',
                      controller: _nameController,
                      icon: const Icon(Icons.person),
                      keyboardType: TextInputType.name,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return "This Field is Required";
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      hintText: 'Email',
                      controller: _emailController,
                      icon: const Icon(Icons.email),
                      keyboardType: TextInputType.emailAddress,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return "This Field is Required";
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      hintText: 'Social ID',
                      controller: _socialController,
                      icon: const Icon(Icons.privacy_tip_outlined),
                      keyboardType: TextInputType.number,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return "This Field is Required";
                        }
                        return null;
                      },
                    ),
                    /*CustomTextField(
                      hintText: 'Contact Number',
                      controller: _contactController,
                      icon: const Icon(Icons.phone),
                      keyboardType: TextInputType.number,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return "This Field is Required";
                        }
                        return null;
                      },
                    ),*/
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: const Text('Register'),
                      style: ElevatedButton.styleFrom(
                        elevation: 6.0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 50),
                        onPrimary: MyColors.themeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        primary: Colors.black87,
                      ),
                      onPressed: onSubmit,
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  onSubmit() async {
    print("Type Email ${_emailController!.text}");

    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      ApplicationUtils.openDialog();
      var userData = await _controller.registerToDB(
        _emailController!.text,
        _socialController!.text,
        _nameController!.text,
        'deviceID',
        "",
      );
      print("Response Register :: $userData");
      ApplicationUtils.closeDialog();
      var status = userData["status"];
      var message = userData["message"];
      // var contact = message["contact"];
      //["contact"];
      String statusStr = status.toString();
      if (userData == null) {
        Get.snackbar('Error occured!', "Some Fields are missing",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black54,
            colorText: Colors.white);
      } else if (statusStr == "false") {
        Get.snackbar('Error occured!', message.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black54,
            colorText: Colors.white);
      } else if (statusStr == "true") {
        Get.snackbar('Congrats', message.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black54,
            colorText: Colors.white);
        Get.to(() => LoginScreen());
      }
    }
  }
}

class TopBar extends StatelessWidget {
  String title;

  TopBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const LoginScreen(),
                )),
            child: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }
}
