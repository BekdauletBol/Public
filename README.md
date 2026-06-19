# Public 🎓🛒

### A Localized Community Marketplace for University Students

**Public** is a modern iOS application designed to bridge the gap between traditional e-commerce and university community support.

Built with a **“Student-First”** philosophy, it allows users to:
- sell items (books, electronics, clothes)
- request favors (borrowing tools, finding study partners)

all within a **trusted university ecosystem**.

---

## 🚀 Key Features

- **Student Identity**  
  Secure registration and profile management tailored to university groups and classes.

- **Dynamic Marketplace**  
  Browse a real-time feed of items for sale or community requests.

- **Telegram-Inspired Profiles**  
  A sleek, modern user interface for managing personal data and profile avatars.

- **Instagram-Style Engagement**  
  Double-tap images to save them to a dedicated **Favorites** hub.

- **Direct Communication**  
  One-tap deep linking to **WhatsApp** and **Telegram** for instant negotiation and coordination.

- **Smart Search**  
  Filter the marketplace by item name or description to find exactly what you need.

---

## 🛠 Tech Stack (2026 Standards)

- **Language:** Swift 6 (Strict Concurrency & Thread Safety)
- **UI Framework:** SwiftUI
- **Architecture:** MVVM + Service-Oriented Architecture (SOA)
- **Backend:** Supabase *(I can not work w firebase due to region)*
- **Authentication:** Secure email/password authentication
- **Database:** PostgreSQL  
  Relational database for profiles, posts, and favorites
- **Storage:**  
  Cloud storage for compressed product images and user avatars

---

## 📱 Architecture Overview

**Public** follows a clean, decoupled architecture to ensure scalability and maintainability:

- **Models**  
  `Decodable / Encodable` structs matching Supabase schemas

- **Views**  
  Declarative SwiftUI views following Apple’s Human Interface Guidelines

- **ViewModels**  
  `@MainActor`-isolated logic managing state and user interaction

- **Services**  
  Singleton-based engine room handling network requests and external API integrations

---

## 🛠 Setup & Installation

1. Clone the repository  
2. Open `Public.xcodeproj` in **Xcode 17+**
3. Install the **Supabase SDK** via **Swift Package Manager**
4. Update `SupabaseConfig.swift` with:
   - Project URL  
   - Anon Public Key
5. Run the **Master SQL** script (found in project documentation) in the **Supabase SQL Editor** to initialize:
   - Tables  
   - RLS policies

---

<img width="590" height="1280" alt="photo_2026-06-19 8 35 46 AM" src="https://github.com/user-attachments/assets/b5c5aeb1-a035-44af-89cc-0d1564e6a42a" />
<img width="590" height="1280" alt="photo_2026-06-19 8 35 34 AM" src="https://github.com/user-attachments/assets/26feeaec-fb92-4a86-a25f-9fd7e2e653d4" />
<img width="590" height="1280" alt="photo_2026-06-19 8 35 53 AM" src="https://github.com/user-attachments/assets/338e9862-7762-4d1e-8255-aa3f60da6b54" />
<img width="590" height="1280" alt="photo_2026-06-19 8 35 55 AM" src="https://github.com/user-attachments/assets/9cd1e1c7-61ea-49ef-b825-12c7ac7a19fa" />
<img width="590" height="1280" alt="photo_2026-06-19 8 35 50 AM" src="https://github.com/user-attachments/assets/924b851d-7f44-44c7-9d00-e0836b8878ec" />


