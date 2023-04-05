import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
	final String? id;
	final String? userId;
	final String? title;
	final String? organizer;
	final String? description;
	final String? type;
	final String? category;
	final String? subCategory;
	final String? venueName;
	final String? categoryId;
	final String? subCategoryId;
	final String? stDate;
	final String? endDate;
	final String? stTime;
	final String? endTime;
	final String? online;
	final String? capacity;
	final String? password;
	final String? locationId;
	final String? status;

	const EventModel({
		this.id, 
		this.userId, 
		this.title, 
		this.organizer, 
		this.description, 
		this.type, 
		this.category, 
		this.subCategory, 
		this.venueName, 
		this.categoryId, 
		this.subCategoryId, 
		this.stDate, 
		this.endDate, 
		this.stTime, 
		this.endTime, 
		this.online, 
		this.capacity, 
		this.password, 
		this.locationId, 
		this.status, 
	});

	factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
				id: json['id'] as String?,
				userId: json['User_id'] as String?,
				title: json['Title'] as String?,
				organizer: json['organizer'] as String?,
				description: json['Description'] as String?,
				type: json['type'] as String?,
				category: json['Category'] as String?,
				subCategory: json['sub_Category'] as String?,
				venueName: json['venue_name'] as String?,
				categoryId: json['CATEGORY_ID'] as String?,
				subCategoryId: json['SUB_CATEGORY_ID'] as String?,
				stDate: json['ST_DATE'] as String?,
				endDate: json['END_DATE'] as String?,
				stTime: json['ST_TIME'] as String?,
				endTime: json['END_TIME'] as String?,
				online: json['online'] as String?,
				capacity: json['CAPACITY'] as String?,
				password: json['PASSWORD'] as String?,
				locationId: json['locationـid'] as String?,
				status: json['STATUS'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'User_id': userId,
				'Title': title,
				'organizer': organizer,
				'Description': description,
				'type': type,
				'Category': category,
				'sub_Category': subCategory,
				'venue_name': venueName,
				'CATEGORY_ID': categoryId,
				'SUB_CATEGORY_ID': subCategoryId,
				'ST_DATE': stDate,
				'END_DATE': endDate,
				'ST_TIME': stTime,
				'END_TIME': endTime,
				'online': online,
				'CAPACITY': capacity,
				'PASSWORD': password,
				'locationـid': locationId,
				'STATUS': status,
			};

	@override
	List<Object?> get props {
		return [
				id,
				userId,
				title,
				organizer,
				description,
				type,
				category,
				subCategory,
				venueName,
				categoryId,
				subCategoryId,
				stDate,
				endDate,
				stTime,
				endTime,
				online,
				capacity,
				password,
				locationId,
				status,
		];
	}
}
