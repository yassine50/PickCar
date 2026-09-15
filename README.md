# PickCar 🚗

**PickCar** is a modern and intuitive peer-to-peer car rental and sharing application built with Flutter. It seamlessly connects car owners with users who need a vehicle, providing a smooth and secure experience for both renting and listing cars.

<div align="center">
  <img src="assets/1.png" width="30%" />
  <img src="https://github.com/user-attachments/assets/cf28af28-2fb2-4e88-9942-c01c97224fb4" width="30%" />
</div>

## ✨ Features

- **User Authentication:** Secure login and sign-up with phone number verification.
- **Interactive Maps:** Discover and locate available cars nearby using integrated maps.
- **Car Rental:** Browse cars, view detailed specifications, check ratings, and send rental requests.
- **Host Your Car:** Car owners can easily list their vehicles, manage incoming requests, and track active rentals.
- **Profile & License Management:** Manage personal information, upload, and verify driving licenses.
- **Notifications:** Keep track of your booking statuses and requests.
- **Offline Capabilities:** Fast and secure on-device caching using Hive.

## 🛠 Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **State Management:** [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Local Storage:** [Hive](https://pub.dev/packages/hive)
- **Maps:** [flutter_map](https://pub.dev/packages/flutter_map)
- **Networking:** [http](https://pub.dev/packages/http)
- **UI Components:** `google_nav_bar`, `carousel_slider`, `shimmer`, `animated_rating_stars`, `easy_stepper`

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your local machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>=3.3.4`)
- Android Studio / VS Code / Xcode (for iOS)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/PickCar.git
   ```

2. **Navigate to the project directory:**
   ```bash
   cd PickCar
   ```

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

## 📂 Project Structure

- `lib/view/`: Contains all the UI screens (Home, Login, Map, Profile, etc.).
- `lib/DataClass/`: Data models and entities used throughout the application.
- `lib/Tools/`: Utility functions, constants, and helpers.
- `lib/widgets/`: Reusable custom UI components.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/yourusername/PickCar/issues).

## 📄 License

This project is licensed under the MIT License.
