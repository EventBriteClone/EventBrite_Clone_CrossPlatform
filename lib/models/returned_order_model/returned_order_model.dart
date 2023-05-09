import 'package:equatable/equatable.dart';

import 'ticket.dart';

class ReturnedOrderModel extends Equatable {
	final List<Ticket>? tickets;
	final int? fullPrice;
	final int? amountOff;
	final int? fee;
	final int? total;

	const ReturnedOrderModel({
		this.tickets, 
		this.fullPrice, 
		this.amountOff, 
		this.fee, 
		this.total, 
	});

	factory ReturnedOrderModel.fromJson(Map<String, dynamic> json) {
		return ReturnedOrderModel(
			tickets: (json['tickets'] as List<dynamic>?)
						?.map((e) => Ticket.fromJson(e as Map<String, dynamic>))
						.toList(),
			fullPrice: json['full_price'] as int?,
			amountOff: json['amount_off'] as int?,
			fee: json['fee'] as int?,
			total: json['total'] as int?,
		);
	}



	Map<String, dynamic> toJson() => {
				'tickets': tickets?.map((e) => e.toJson()).toList(),
				'full_price': fullPrice,
				'amount_off': amountOff,
				'fee': fee,
				'total': total,
			};

	@override
	List<Object?> get props => [tickets, fullPrice, amountOff, fee, total];
}
