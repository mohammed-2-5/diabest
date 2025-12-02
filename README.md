# DiiaBest 🏥

> **Your Comprehensive Health & Diabetes Management Companion**

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Bloc](https://img.shields.io/badge/bloc-8B0000.svg?style=for-the-badge&logo=bloc&logoColor=white)

**DiiaBest** is a feature-rich mobile application built with Flutter, designed to empower users in managing their health effectively. With a focus on diabetes care, organ health monitoring, and direct doctor consultations, DiiaBest serves as a personal health assistant right in your pocket.

---

## ✨ Key Features

### 🩺 Health & Monitoring
*   **Organ Health Tracking**: Monitor vital statistics for key organs like the **Heart** and **Eyes**.
*   **Pregnancy Care**: Dedicated section for tracking pregnancy health and milestones.
*   **Sports & Activity**: Integrated activity tracking to keep you active and healthy.
*   **Diet & Nutrition**: Tools to manage eating habits and diet plans.
*   **Smart Watch Integration**: Connect with wearable devices for real-time health data.

### 👨‍⚕️ Medical Consultation
*   **Doctor Finder**: Browse and find specialist doctors.
*   **Doctor Profiles**: View detailed profiles and information about medical professionals.
*   **Patient Management**: Features for doctors to manage their patients effectively.

### ⏰ Reminders & Utilities
*   **Medication Reminders**: Never miss a dose with smart, customizable notifications.
*   **Smart Calendar**: Organize appointments and health schedules.
*   **Multi-language Support**: Accessible in multiple languages for a broader reach.

---

## 🛠️ Technology Stack

DiiaBest is built using a robust and modern tech stack to ensure performance, scalability, and a great user experience.

| Category | Technologies |
|----------|--------------|
| **Core** | ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white) ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white) |
| **State Management** | **Flutter Bloc** (Cubit) |
| **Architecture** | **Clean Architecture** principles with Feature-based folder structure |
| **Networking** | **Dio** (Http Client), **Internet Connection Checker** |
| **Local Storage** | **Hive** (NoSQL Database), **Shared Preferences** |
| **Navigation** | **Go Router** / Navigator |
| **UI & Styling** | **Flutter ScreenUtil** (Responsive Design), **Lottie** (Animations), **Google Fonts** (Poppins) |
| **Charts & Data** | **FL Chart** |
| **Notifications** | **Flutter Local Notifications** |
| **Dependency Injection** | **GetIt** |

---

## 🚀 Getting Started

Follow these steps to run the project locally.

### Prerequisites
*   [Flutter SDK](https://flutter.dev/docs/get-started/install) installed.
*   An IDE (VS Code or Android Studio) with Flutter extensions.

### Installation

1.  **Clone the repository**
    ```bash
    git clone https://github.com/yourusername/diiabest.git
    cd diiabest
    ```

2.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

3.  **Run the App**
    ```bash
    flutter run
    ```

---

## 📂 Project Structure

The project follows a **Feature-First** architecture for better scalability and maintainability.

```
lib/
├── core/             # Shared components, utilities, and services
├── feature/          # Feature-specific code (Auth, Doctor, Home, etc.)
│   ├── auth/
│   ├── doctor/
│   ├── home/
│   └── ...
├── models/           # Global data models
└── main.dart         # Application entry point
```

---

## 🤝 Contributing

Contributions are welcome! If you have suggestions or want to improve the app, please feel free to submit a Pull Request.

---

<p align="center">
  Made with ❤️ using Flutter
</p>
