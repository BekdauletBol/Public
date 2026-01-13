import SwiftUI
import PhotosUI

struct ProfileView: View {
	@StateObject private var viewModel = ProfileViewModel()
	@State private var showEditProfile = false
	@State private var selectedItem: PhotosPickerItem?
	
	var body: some View {
		NavigationStack {
			
			ZStack {
				Color(.systemGroupedBackground).ignoresSafeArea()
				
				ScrollView {
					VStack(spacing: 24) {
						//(Telegram Style)
						VStack(spacing: 12) {
							let studentAvatarUrl = viewModel.student?.avatar_url
							
							PhotosPicker(selection: $selectedItem, matching: .images) {
								if let avatarUrl = studentAvatarUrl, let url = URL(string: avatarUrl) {
									AsyncImage(url: url) { image in
										image.resizable()
											.scaledToFill()
									} placeholder: {
										ProgressView()
									}
									.frame(width: 100, height: 100)
									.clipShape(Circle())
									.overlay(Circle().stroke(Color.white, lineWidth: 2))
									.shadow(radius: 3)
								} else {
									Image(systemName: "person.circle.fill")
										.resizable()
										.scaledToFill()
										.frame(width: 100, height: 100)
										.foregroundColor(.secondary)
										.background(Circle().fill(Color(.systemGray5)))
								}
							}
							.padding(.top, 20)
							// iOS 16 Compatible onChange
							.onChange(of: selectedItem) { newItem in
								Task {
									if let data = try? await newItem?.loadTransferable(type: Data.self),
									   let uiImage = UIImage(data: data) {
										try? await AuthService.shared.uploadAvatar(image: uiImage)
									}
								}
							}
							
							Text(viewModel.student?.fullName.lowercased() ?? "loading...")
								.font(.system(size: 28, weight: .semibold, design: .rounded))
							
							Text("\(viewModel.student?.phone_number ?? "") • @\(viewModel.student?.telegram_handle ?? "no_handle")")
								.font(.subheadline)
								.foregroundColor(.secondary)
						}
						
						// Action Button
						Button {
							showEditProfile.toggle()
						} label: {
							HStack {
								Image(systemName: "pencil.line")
								Text("Edit Profile Settings")
							}
							.fontWeight(.semibold)
							.frame(maxWidth: .infinity)
							.padding(.vertical, 14)
							.background(Color.uniPrimary)
							.foregroundColor(.white)
							.clipShape(Capsule())
							.padding(.horizontal, 32)
						}
						
						VStack(spacing: 0) {
							ProfileMenuRow(icon: "graduationcap.fill", color: .blue, title: "University", value: viewModel.student?.university ?? "---")
							Divider().padding(.leading, 50)
							ProfileMenuRow(icon: "person.2.fill", color: .purple, title: "Group", value: viewModel.student?.class_group ?? "---")
							Divider().padding(.leading, 50)
							ProfileMenuRow(icon: "envelope.fill", color: .orange, title: "Email", value: viewModel.student?.email ?? "---")
						}
						.background(Color(.secondarySystemGroupedBackground))
						.cornerRadius(12)
						.padding(.horizontal)
						
						//Sign Out Button
						Button(role: .destructive) {
							viewModel.signOut()
						} label: {
							Text("Sign Out")
								.fontWeight(.semibold)
								.foregroundColor(.red)
								.frame(maxWidth: .infinity)
								.padding(.vertical, 14)
								.background(Color(.secondarySystemGroupedBackground))
								.cornerRadius(12)
						}
						.padding(.horizontal)
					}
					.padding(.bottom, 30)
				}
			}
			.navigationTitle("Settings")
			.navigationBarTitleDisplayMode(.inline)
			.sheet(isPresented: $showEditProfile) {
				EditProfileView(viewModel: viewModel)
			}
		}
	}
}


struct ProfileMenuRow: View {
	let icon: String
	let color: Color
	let title: String
	let value: String
	
	var body: some View {
		HStack(spacing: 16) {
			Image(systemName: icon)
				.foregroundColor(.white)
				.frame(width: 30, height: 30)
				.background(RoundedRectangle(cornerRadius: 8).fill(color))
			
			VStack(alignment: .leading) {
				Text(title)
					.font(.footnote)
					.foregroundColor(.secondary)
				Text(value)
					.font(.body)
			}
			Spacer()
		}
		.padding(.vertical, 10)
		.padding(.horizontal)
	}
}
