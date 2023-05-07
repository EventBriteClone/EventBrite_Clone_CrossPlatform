import 'package:equatable/equatable.dart';

class TicketModel extends Equatable {
	final int? id;
	final int? eventId;
	final int? userId;
	final String? name;
	final double? price;
	final int? capacity;
	final int? quantitySold;
	final dynamic ticketType;
	final String? salesStart;
	final String? salesEnd;
	final String? startTime;
	final String? endTime;
	final String? absorbFees;

	const TicketModel({
		this.id, 
		this.eventId, 
		this.userId, 
		this.name, 
		this.price, 
		this.capacity, 
		this.quantitySold, 
		this.ticketType, 
		this.salesStart, 
		this.salesEnd, 
		this.startTime, 
		this.endTime, 
		this.absorbFees, 
	});

	factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
				id: json['ID'] as int?,
				eventId: json['event_id'] as int?,
				userId: json['User_id'] as int?,
				name: json['NAME'] as String?,
				price: json['PRICE'] as double?,
				capacity: json['capacity'] as int?,
				quantitySold: json['quantity_sold'] as int?,
				ticketType: json['TICKET_TYPE'] as dynamic,
				salesStart: json['Sales_start'] as String?,
				salesEnd: json['Sales_end'] as String?,
				startTime: json['Start_time'] as String?,
				endTime: json['End_time'] as String?,
				absorbFees: json['Absorb_fees'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'ID': id,
				'event_id': eventId,
				'User_id': userId,
				'NAME': name,
				'PRICE': price,
				'capacity': capacity,
				'quantity_sold': quantitySold,
				'TICKET_TYPE': ticketType,
				'Sales_start': salesStart,
				'Sales_end': salesEnd,
				'Start_time': startTime,
				'End_time': endTime,
				'Absorb_fees': absorbFees,
			};

	@override
	List<Object?> get props {
		return [
				id,
				eventId,
				userId,
				name,
				price,
				capacity,
				quantitySold,
				ticketType,
				salesStart,
				salesEnd,
				startTime,
				endTime,
				absorbFees,
		];
	}
}
