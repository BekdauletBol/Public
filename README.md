Public. 🎓🛒
A Localized Community Marketplace for University Students.
Public is a modern iOS application designed to bridge the gap between traditional e-commerce and university community support. Built with a "Student-First" philosophy, it allows users to sell items (books, electronics, clothes) and request favors (borrowing tools, finding study partners) within their trusted university ecosystem.
🚀 Key Features
Student Identity: Secure registration and profile management tailored to university groups and classes.
Dynamic Marketplace: Browse a real-time feed of items for sale or community requests.
Telegram-Inspired Profiles: A sleek, modern user interface for managing personal data and profile avatars.
Instagram-Style Engagement: Double-tap images to save them to a dedicated Favorites hub.
Direct Communication: One-tap deep linking to WhatsApp and Telegram for instant negotiation and coordination.
Smart Search: Filter the marketplace by item name or description to find exactly what you need.
🛠 Tech Stack (2026 Standards)
Language: Swift 6 (Strict Concurrency & Thread Safety)
UI Framework: SwiftUI
Architecture: MVVM + Service-Oriented Architecture (SOA)
Backend: Supabase (I can't work w firebase due to region)
Auth: Secure email/password authentication.
PostgreSQL: Relational database for profiles, posts, and favorites.
Storage: Cloud storage for compressed product images and user avatars.
📱 Architecture Overview
UniSwap follows a clean, decoupled architecture to ensure scalability:
Models: Decodable/Encodable structs matching Supabase schemas.
Views: Declarative SwiftUI views following Apple's Human Interface Guidelines.
ViewModels: MainActor-isolated logic managing state and user interaction.
Services: Singleton-based engine room handling network requests and external API integrations.
🛠 Setup & Installation
Clone the repository.
Open UniSwap.xcodeproj in Xcode 17+.
Ensure the Supabase SDK is installed via Swift Package Manager.
Update SupabaseConfig.swift with your specific Project URL and Anon Public Key.
Run the "Master SQL" script (found in project documentation) in your Supabase SQL Editor to initialize tables and RLS policies.
