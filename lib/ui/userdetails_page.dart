import 'package:flutter/material.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';
import 'package:onlineshop_provider/ui/profilepage.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "User Details",
          style: appstyle(25, Colors.black, FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: height * 0.4,
                  width: width * 0.8,
                  child: Image.asset(
                    'assets/images/details.png',
                    fit: BoxFit.cover,
                  )),
              Text(
                "Enter the following details",
                style: appstyle(15, Colors.black, FontWeight.w600),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                margin: EdgeInsets.only(bottom: height * 0.02),
                height: height * 0.06,
                width: width * 0.85,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: InputBorder.none,
                    hintText: "Enter your name",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: height * 0.02),
                height: height * 0.12,
                width: width * 0.85,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  minLines: 2,
                  maxLines: 5,
                  controller: _addressController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    border: InputBorder.none,
                    hintText: "Enter your address",
                  ),
                ),
              ),
              MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ),
                    );
                  },
                  color: const Color(0XFFFFFF8282),
                  minWidth: width * 0.3,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
