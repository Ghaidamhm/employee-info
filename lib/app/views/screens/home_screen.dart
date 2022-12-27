import 'package:employee_info/main.dart';
import 'package:employee_info/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Text(
          'Employee Information',
          style: TextStyle(color: mainColor),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: mainColor,
            ),
            onPressed: () {
              _buildAddEditEmployeeView(text: 'ADD', addEditFlag: 1, docId: '');
            },
          )
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.employees.length,
          itemBuilder: (context, index) => Card(
            color: mainColor,
            child: ListTile(
              title: Text(controller.employees[index].name!),
              subtitle: Text(controller.employees[index].address!),
              leading: CircleAvatar(
                child: Text(
                  controller.employees[index].name!.substring(0, 1).capitalize!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: backgroundColor,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  color: trashColor,
                ),
                onPressed: () {
                  displayDeleteDialog(controller.employees[index].docId!);
                },
              ),
              onTap: () {
                controller.nameController.text =
                    controller.employees[index].name!;
                controller.addressController.text =
                    controller.employees[index].address!;
                _buildAddEditEmployeeView(
                    text: 'UPDATE',
                    addEditFlag: 2,
                    docId: controller.employees[index].docId!);
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildAddEditEmployeeView({String? text, int? addEditFlag, String? docId}) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: backgroundColor,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${text} Employee',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    style: TextStyle(color: mainColor),
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(color: mainColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.nameController,
                    validator: (value) {
                      return controller.validateName(value!);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: TextStyle(color: mainColor),
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      hintStyle: TextStyle(color: mainColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.addressController,
                    validator: (value) {
                      return controller.validateAddress(value!);
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: Get.context!.width, height: 45),
                    child: ElevatedButton(
                      child: Text(
                        text!,
                        style: TextStyle(color: backgroundColor, fontSize: 16),
                      ),
                      onPressed: () {
                        controller.saveUpdateEmployee(
                            controller.nameController.text,
                            controller.addressController.text,
                            docId!,
                            addEditFlag!);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  displayDeleteDialog(String docId) {
    Get.defaultDialog(
      title: "Delete Employee",
      titleStyle: TextStyle(fontSize: 20),
      middleText: 'Are you sure to delete employee ?',
      textCancel: "Cancel",
      textConfirm: "Confirm",
      confirmTextColor: mainColor,
      onCancel: () {},
      onConfirm: () {
        controller.deleteData(docId);
      },
    );
  }
}
