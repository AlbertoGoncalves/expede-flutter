import 'package:expede/src/model/customer_model.dart';
import 'package:flutter/material.dart';

class ListCustomers {
  final List<CustomerModel> customers;

  ListCustomers({required this.customers});

  @override
  ListCustomers.getListCustomers(this.customers) {

    List<CustomerModel> listCustomers = customers;
    listCustomers.map((e) => DropdownMenuItem<String>(
     value: e.name,
     child: Text(e.name),
     ));
   // return customers.map((e) {
    //   final CustomerModel(
    //     :id,
    //     :name,
    //   ) = e;

    //   return DropdownMenuItem(
    //     value: id,
    //     child: Text(name),
    //   );
    // }).toList();
  }
}
