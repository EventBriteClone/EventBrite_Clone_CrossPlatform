import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
	final int? id;
	final String? image;
	final int? ID;
	final int? userId;
	final String? title;
	final String? organizer;
	final String? summery;
	final String? description;
	final String? type;
	final String? categoryName;
	final String? subCategory;
	final String? venueName;
	final String? stDate;
	final String? endDate;
	final String? stTime;
	final String? endTime;
	final String? online;
	final int? capacity;
	final String? password;
	final String? status;
  final dynamic? ticketPrice;

	const EventModel({
		this.id, 
		this.image, 
		this.ID, 
		this.userId, 
		this.title, 
		this.organizer, 
		this.summery, 
		this.description, 
		this.type, 
		this.categoryName, 
		this.subCategory, 
		this.venueName, 
		this.stDate, 
		this.endDate, 
		this.stTime, 
		this.endTime, 
		this.online, 
		this.capacity, 
		this.password, 
		this.status, 
    this.ticketPrice,
	});

	factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
				id: json['id'] as int?,
				image: json['image'] as String?,
				ID: json['ID'] as int?,
				userId: json['User_id'] as int?,
				title: json['Title'] as String?,
				organizer: json['organizer'] as String?,
				summery: json['Summery'] as String?,
				description: json['Description'] as String?,
				type: json['type'] as String?,
				categoryName: json['category_name'] as String?,
				subCategory: json['sub_Category'] as String?,
				venueName: json['venue_name'] as String?,
				stDate: json['ST_DATE'] as String?,
				endDate: json['END_DATE'] as String?,
				stTime: json['ST_TIME'] as String?,
				endTime: json['END_TIME'] as String?,
				online: json['online'] as String?,
				capacity: json['CAPACITY'] as int?,
				password: json['PASSWORD'] as String?,
				status: json['STATUS'] as String?,
        ticketPrice: json['ticket_price'] as double?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'image': image,
				'ID': ID,
				'User_id': userId,
				'Title': title,
				'organizer': organizer,
				'Summery': summery,
				'Description': description,
				'type': type,
				'category_name': categoryName,
				'sub_Category': subCategory,
				'venue_name': venueName,
				'ST_DATE': stDate,
				'END_DATE': endDate,
				'ST_TIME': stTime,
				'END_TIME': endTime,
				'online': online,
				'CAPACITY': capacity,
				'PASSWORD': password,
				'STATUS': status,
			};

	@override
	List<Object?> get props {
		return [
				id,
				image,
				id,
				userId,
				title,
				organizer,
				summery,
				description,
				type,
				categoryName,
				subCategory,
				venueName,
				stDate,
				endDate,
				stTime,
				endTime,
				online,
				capacity,
				password,
				status,
        ticketPrice,
		];
	}
}
