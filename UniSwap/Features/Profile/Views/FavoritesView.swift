import SwiftUI

struct FavoritesView: View {
	@StateObject var viewModel = FavoritesViewModel()
	
	var body: some View {
		NavigationStack {
			ScrollView {
				LazyVStack(spacing: 16) {
					if viewModel.isLoading && viewModel.favoritePosts.isEmpty {
						ProgressView().padding(.top, 50)
					} else if viewModel.favoritePosts.isEmpty {
						ContentUnavailableView("No Favorites", systemImage: "heart.slash", description: Text("Double-tap photos in the feed to save them here."))
							.padding(.top, 100)
					} else {
						ForEach(viewModel.favoritePosts) { post in
							VStack {
								PostCard(post: post)
								
								// NEW: Remove from Favorites button
								Button(role: .destructive) {
									Task {
										try? await PostService.unfavoritePost(postId: post.id)
										await viewModel.fetchFavorites()
									}
								} label: {
									Label("Remove from Favorites", systemImage: "heart.slash")
										.font(.subheadline)
								}
								.padding(.bottom, 10)
							}
						}
					}
				}
				.padding()
			}
			.navigationTitle("Favorites")
			.task { await viewModel.fetchFavorites() }
			.refreshable { await viewModel.fetchFavorites() }
		}
	}
}
