import SwiftUI
import Supabase
import Combine

struct FeedView: View {
	@StateObject var viewModel = FeedViewModel()
	
	var body: some View {
		NavigationStack {
			ScrollView {
				LazyVStack(spacing: 16) {
					if viewModel.isLoading && viewModel.posts.isEmpty {
						ProgressView("Searching...")
							.padding(.top, 50)
					} else if viewModel.filteredPosts.isEmpty {
						ContentUnavailableView.search(text: viewModel.searchText)
					} else {
						ForEach(viewModel.filteredPosts) { post in
							PostCard(post: post) {
								Task {
									await viewModel.fetchPosts()
								}
							}
							
						}
					}
				}
				.padding()
			}
			.navigationTitle("Public.")
			.searchable(text: $viewModel.searchText, prompt: "Search for books, electronics...")
			.refreshable {
				await viewModel.fetchPosts()
			}
			.task {
				await viewModel.fetchPosts()
			}
		}
	}
}
