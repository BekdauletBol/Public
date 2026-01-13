import Foundation

enum PostType: String, Codable, Sendable, CaseIterable {
	case sell
	case request
}

struct Post: Codable, Identifiable, Hashable, Sendable {
	let id: String
	let ownerId: String
	let title: String
	let description: String
	let type: PostType
	let price: Double?
	let imageUrl: String?
	
	let phoneNumber: String?
	let telegramHandle: String? // NEW: Added Telegram Handle
	let timestamp: Date
	
	enum CodingKeys: String, CodingKey {
		case id, title, description, type, price
		case ownerId = "owner_id"
		case imageUrl = "image_url"
		case phoneNumber = "phone_number"
		case telegramHandle = "telegram_handle" // Maps to SQL snake_case
		case timestamp = "created_at"
	}
	
	var formattedPrice: String {
		if let price = price, price > 0 {
			return String(format: "%.2f₸", price)
		} else {
			return "Free / Favor"
		}
	}
}
