import Foundation

struct Student: Codable, Identifiable, Hashable, Sendable {
	let id: String
	let first_name: String
	let last_name: String
	let university: String
	let class_group: String
	let phone_number: String
	let avatar_url: String? // --> Feature User avatar
	let telegram_handle: String?// --> Ramazan Гусь
	let email: String
	
	enum CodingKeys: String, CodingKey {
		case id, university, email
		case first_name, last_name, class_group, phone_number, telegram_handle
		case avatar_url // ADD THIS
	}
	
	var fullName: String {
		return "\(first_name) \(last_name)"
	}
}
	
//	enum CodingKeys: String, CodingKey {
//		case id
//		case firstName = "first_name"
//		case lastName = "last_name"
//		case university
//		case group = "class_group"
//		case phoneNumber = "phone_number"
//		case email
//	}

