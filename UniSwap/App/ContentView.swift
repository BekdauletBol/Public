import SwiftUI
import Supabase

struct ContentView: View {
	@State private var isAuthenticated = false
	
	var body: some View {
		Group {
			if isAuthenticated {
				MainTabView()
			} else {
				LoginView()
			}
		}
		.task {
			await checkSession()
			for await _ in SupabaseConfig.client.auth.authStateChanges {
				await checkSession()
			}
		}
	}
	
	@MainActor
	private func checkSession() async {
		let session = try? await SupabaseConfig.client.auth.session
		self.isAuthenticated = (session != nil)
		
		// NEW: If we are logged in, fetch the actual profile data (name, phone, etc.)
		if isAuthenticated {
			do {
				try await AuthService.shared.fetchCurrentUser()
				print("✅ Profile loaded for: \(AuthService.shared.currentUser?.first_name ?? "Unknown")")
			} catch {
				print("❌ Failed to fetch profile: \(error)")
			}
		}
	}
}
