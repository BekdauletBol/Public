import Foundation
import Supabase

struct PostService: Sendable {
	private static let client = SupabaseConfig.client
	
	static func uploadPost(_ post: Post) async throws {
		try await client.from("posts").insert(post).execute()
	}
	
	static func deletePost(postId: String) async throws {
		print("DEBUG: Attempting to delete post with ID: \(postId)")
		
		let response = try await client
			.from("posts")
			.delete()
		
			.eq("id", value: postId)
			.execute()
		
		if response.status == 204 || response.status == 200 {
			print(" DEBUG: Post successfully deleted from Supabase")
		} else {
			print("DEBUG: Server returned status \(response.status)")
		}
	}

	// MARK: - Favorites Logic

	static func favoritePost(postId: String) async throws {
		guard let uid = AuthService.shared.currentUser?.id else { return }
		let data: [String: String] = ["user_id": uid, "post_id": postId]
		
		try await client
			.from("favorites")
			.insert(data)
			.execute()
	}

	static func unfavoritePost(postId: String) async throws {
		guard let uid = AuthService.shared.currentUser?.id else { return }
		
		try await client
			.from("favorites")
			.delete()
			.eq("user_id", value: uid)
			.eq("post_id", value: postId)
			.execute()
	}

	static func fetchFavoritePosts() async throws -> [Post] {
		guard let uid = AuthService.shared.currentUser?.id else { return [] }
		
		let response = try await client
			.from("favorites")
			.select("posts(*)")
			.eq("user_id", value: uid)
			.execute()
		
		let data = response.data
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		
		struct FavoriteRow: Decodable { let posts: Post }
		let rows = try decoder.decode([FavoriteRow].self, from: data)
		
		return rows.map { $0.posts }
	}
}
