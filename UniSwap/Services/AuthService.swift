import SwiftUI
import Combine
import Supabase

@MainActor
final class AuthService: ObservableObject {
	static let shared = AuthService()
	private let client = SupabaseConfig.client
	
	@Published var currentUser: Student?
	
	private init() {}
	
	func registerUser(email: String, password: String, firstName: String, lastName: String, university: String, group: String, phoneNumber: String, telegramHandle: String) async throws {
		let response = try await client.auth.signUp(email: email, password: password)
		let userId = response.user.id
		
		let student = Student(
			id: userId.uuidString,
			first_name: firstName,
			last_name: lastName,
			university: university,
			class_group: group,
			phone_number: phoneNumber,
			avatar_url: nil,
			telegram_handle: telegramHandle,
			email: email
		)
		
		
		try await client.from("profiles").insert(student).execute()
		self.currentUser = student
	}
	
	// profile info (names, uni, etc.)
	func updateUserInfo(firstName: String, lastName: String, university: String, group: String, phone: String, telegram: String) async throws {
		guard let uid = currentUser?.id else { return }

		let updatedData: [String: String] = [
			"first_name": firstName,
			"last_name": lastName,
			"university": university,
			"class_group": group,
			"phone_number": phone,
			"telegram_handle": telegram
		]
		
		try await client.from("profiles")
			.update(updatedData)
			.eq("id", value: uid)
			.execute()
		
		try await fetchCurrentUser()
	}

	func loginUser(email: String, password: String) async throws {
		try await client.auth.signIn(email: email, password: password)
		try await fetchCurrentUser()
	}

	func fetchCurrentUser() async throws {
		guard let userId = try? await client.auth.session.user.id else { return }
		
		let student: Student = try await client
			.from("profiles")
			.select()
			.eq("id", value: userId)
			.single()
			.execute()
			.value
			
		self.currentUser = student
	}
	
	func signOut() async {
		try? await client.auth.signOut()
		self.currentUser = nil
	}
	
	// Function to upload the Avatar image
	func uploadAvatar(image: UIImage) async throws {
		guard let uid = currentUser?.id else { return }
		
		// 1. Compress image
		guard let data = image.jpegData(compressionQuality: 0.2) else { return }
		let fileName = "avatar_\(uid).jpg"
		
		// 2. Upload to avatars bucket (using upsert so it overwrites old ones)
		try await client.storage
			.from("avatars")
			.upload(fileName, data: data, options: FileOptions(contentType: "image/jpeg", upsert: true))
			
		// 3. Get Public URL
		let url = try client.storage.from("avatars").getPublicURL(path: fileName)
		
		// 4. Update the profiles table with the new link
		try await client.from("profiles")
			.update(["avatar_url": url.absoluteString])
			.eq("id", value: uid)
			.execute()
			
		// 5. Refresh local user data so UI updates immediately
		try await fetchCurrentUser()
	}
}
