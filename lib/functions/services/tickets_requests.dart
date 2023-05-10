import 'dart:convert';

import 'package:event_brite_app/models/order_model.dart';
import 'package:event_brite_app/models/returned_order_model/returned_order_model.dart';
import 'package:event_brite_app/models/ticket_model.dart';

import '../../helper/api.dart';

class Tickets {
  Future<List<TicketModel>> getTicketClasses() async {
    List<dynamic> dataUnFiltered = await Api().get(
        url: 'https://event-us.me:8000/booking/events/1854/ticket-classes/',
        token:
            'CustomToken 6cf8d331b4ec9aaba7d5d4ae8a9330e4eb0e1cc52b9173a2a53c111f507b69ad');
    List<TicketModel> tickets = [];
    for (int i = 0; i < dataUnFiltered.length; i++) {
      tickets.add(TicketModel.fromJson(dataUnFiltered[i]));
    }
    return tickets;
  }

  Future<bool> checkPromocode(String promocode) async {
    Map<String, dynamic> promocodeValidationUnjsoned = await Api().get(
        url:
            'https://event-us.me:8000/booking/events/4234/promocode/?promocode=$promocode',
        token:
            'CustomToken 3743b5ecba1461fcbf9ba874653ea8dc6792bd1a58ef656133dc71321f148332');
    bool promocodeValidation = promocodeValidationUnjsoned['is_promocode'];
    return promocodeValidation;
  }

  Future<List<ReturnedOrderModel>> postOrderRequest(
      List<Map<String, dynamic>> order_items) async {
    Map results = await Api().post(
        url:
            'https://event-us.me:8000/booking/event/4234/orders/?ticket_class_id',
        body: {'order_items': order_items},
        token:
            'CustomToken 3743b5ecba1461fcbf9ba874653ea8dc6792bd1a58ef656133dc71321f148332');
    List<ReturnedOrderModel> ret = (results["tickets"] as List).map((e) {
      return ReturnedOrderModel.fromJson(e);
    }).toList();
    print("ord");
    // await Future.delayed(const Duration(seconds: 5));
    print(ret);
    return ret;
  }

  Future<Map<String, dynamic>> getOrderDetails(int orderId) async {
    Future<Map<String, dynamic>> orderSummary = await Api().get(
        url: 'https://event-us.me:8000/booking/order$orderId/order_items/',
        token:
            'CustomToken 3743b5ecba1461fcbf9ba874653ea8dc6792bd1a58ef656133dc71321f148332');
    return orderSummary;
  }
}
