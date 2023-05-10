import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
	final int? ticketClassId;
	final int? quantity;

	const OrderModel({this.ticketClassId, this.quantity});

	factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
				ticketClassId: json['ticket_class_id'] as int?,
				quantity: json['quantity'] as int?,
			);

	Map<String, dynamic> toJson(order_item) => {
				'ticket_class_id': ticketClassId,
				'quantity': quantity,
			};

	@override
	List<Object?> get props => [ticketClassId, quantity];
}
