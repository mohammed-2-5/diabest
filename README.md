# DiiaBest 🩺

> **AI-Powered Diabetes Diagnosis & Health Management System**

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![AI](https://img.shields.io/badge/AI-Powered-purple.svg?style=for-the-badge)
![Bloc](https://img.shields.io/badge/bloc-8B0000.svg?style=for-the-badge&logo=bloc&logoColor=white)

**DiiaBest** is an innovative Flutter-based mobile health application designed specifically for **diabetes diagnosis, monitoring, and management**. The app combines cutting-edge **AI-powered image analysis**, **Bluetooth infrared device integration**, and comprehensive health tracking to provide users with accurate diabetes screening and ongoing health management tools.

---

## 🌟 Key Features

### � AI-Powered Diabetes Diagnosis
*   **Multi-Modal AI Detection**: Upload images of your **tongue**, **eyes**, or **teeth** for AI-based diabetes screening
*   **Instant Analysis**: Machine learning models analyze uploaded images and provide diagnostic predictions
*   **Non-Invasive Screening**: Preliminary diabetes detection through visual biomarkers

### 📡 Smart Glucose Monitoring
*   **Infrared Device Integration**: Connect via **Bluetooth** to infrared-based glucose measurement devices
*   **Real-Time Data**: Stream blood sugar levels and heart rate data directly to the app
*   **Instant Classification**: Automatic categorization of glucose levels (Low/Normal/High)

### 🍎 Health & Lifestyle Management
*   **Personalized Diet Plans**: Custom nutrition programs tailored for diabetic patients
*   **Sports & Exercise Tracking**: Guided workout routines designed for cardiovascular health and diabetes management
*   **Activity Monitoring**: Track daily physical activity and health metrics

### 👨‍⚕️ Medical Network & Support
*   **Doctor Directory**: Browse and connect with diabetes specialists and healthcare professionals
*   **Doctor Profiles**: View detailed information including specializations, clinic locations, and availability
*   **Patient Management**: For healthcare providers to manage their diabetic patients

### 💊 Medication & Reminders
*   **Smart Medicine Reminders**: Never miss a dose with intelligent, scheduled notifications
*   **Calendar Integration**: Organize appointments and medication schedules
*   **Timezone-Aware Notifications**: Automated local notifications for medication adherence

### 👤 User Profiles & Authentication
*   **Role-Based Access**: Separate workflows for patients and doctors
*   **Medical History Tracking**: Store and manage personal health information
*   **Secure Authentication**: Email-based signup/login with password recovery

---

## 🛠️ Technology Stack

DiiaBest leverages a modern, robust tech stack for performance, scalability, and reliability.

| Category | Technologies |
|----------|--------------|
| **Framework** | ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white) ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white) |
| **State Management** | **Flutter Bloc** (Cubit pattern) |
| **Architecture** | **Clean Architecture** with feature-first folder structure |
| **AI/ML Integration** | External AI API for image-based diagnosis (`dfumodel.onrender.com`) |
| **IoT/Hardware** | **Flutter Blue Plus** (Bluetooth Low Energy for infrared devices) |
| **Networking** | **Dio**, **HTTP** (RESTful API client) |
| **Local Storage** | **Hive** (NoSQL), **Shared Preferences** (key-value storage) |
| **Dependency Injection** | **GetIt** (service locator pattern) |
| **UI & Responsiveness** | **Flutter ScreenUtil** (adaptive layouts), **Lottie** (animations) |
| **Notifications** | **Flutter Local Notifications** with timezone scheduling |
| **Navigation** | **Persistent Bottom Nav Bar**, Navigator 2.0 |
| **Charts & Visualization** | **FL Chart** (data visualization) |
| **Image Handling** | **Image Picker**, **Cached Network Image** |

---

## 🚀 Getting Started

Follow these steps to run DiiaBest locally.

### Prerequisites
*   [Flutter SDK](https://flutter.dev/docs/get-started/install) (>= 3.2.6)
*   Android Studio / VS Code with Flutter extensions
*   Physical device or emulator (Android minSdk 21+)

### Installation

1.  **Clone the repository**
    ```bash
    git clone https://github.com/yourusername/diiabest.git
    cd diiabest
    ```

2.  **Install dependencies**
    ```bash
    flutter pub get
    ```

3.  **Run the application**
    ```bash
    flutter run
    ```

---

## 📂 Project Architecture

The codebase follows a **Feature-First Clean Architecture** approach for maintainability and scalability.

```
lib/
├── core/                 # Shared infrastructure
│   ├── Database/         # Local storage (Hive, SharedPreferences)
│   ├── services/         # HTTP, DI (GetIt)
│   ├── Utils/            # Colors, themes, strings, assets
│   └── Widgets/          # Reusable UI components
├── feature/              # Feature modules
│   ├── auth/             # Authentication (signup, login, password reset)
│   ├── organs/           # AI diagnosis (eyes, tongue, teeth)
│   ├── my_watch/         # Bluetooth device integration
│   ├── doctor/           # Doctor registration & profiles
│   ├── doctors_patient/  # Patient-facing doctor directory
│   ├── Register_your_information/  # Patient medical intake
│   ├── reminder_medicins/  # Medication reminders & notifications
│   ├── Eating/           # Diet & nutrition plans
│   ├── sports/           # Exercise & activity tracking
│   ├── profile/          # User profile management
│   ├── Home/             # Dashboard & shortcuts
│   └── On-Boarding/      # Onboarding flow
├── models/               # Data models (User, Doctor, Patient)
├── Localizations/        # Multi-language support (EN/AR)
└── main.dart             # App entry point
```

---

## 🔗 API Integration

### Backend Services
*   **Base URL**: `https://graduation-project-sigma.vercel.app/`
*   **Endpoints**:
    *   Authentication: `/Register/signup`, `/Register/login`
    *   Patient: `/Patient/patientRegisteration`, `/Patient/editProfile/:id`
    *   Doctor: `/Doctor/doctorRegisteration`, `/Doctor/getAllDoctors`
    *   User Management: `/Register/getUser/:id`, `/Register/uploadUserImage`

### AI Diagnosis API
*   **Endpoint**: `https://dfumodel.onrender.com/dfu`
*   **Method**: `POST` (multipart/form-data)
*   **Field**: `file` (image upload)
*   **Response**: `{ predicted_class: "..." }`

---

## 🎯 User Flows

### For Patients
1.  **Onboarding** → Language selection → Sign up/Login
2.  **Complete medical profile** (age, weight, diabetes status, comorbidities)
3.  **AI Diagnosis**: Take/upload images for diabetes screening
4.  **Device Connection**: Connect Bluetooth infrared device for real-time glucose monitoring
5.  **Health Management**: Access diet plans, exercise routines, medication reminders
6.  **Find Doctors**: Browse specialists and view profiles

### For Doctors
1.  Sign up as a **Doctor** → Complete professional profile (specialization, clinic, hours)
2.  View and manage patient information
3.  Update availability and contact details

---

## 🧪 Testing

```bash
# Run tests
flutter test

# Analyze code
flutter analyze
```

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1.  Fork the repository
2.  Create a feature branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

---

## 📄 License

This project is for educational and research purposes.

---

## 📧 Contact

For inquiries or support, please contact the development team.

---

<p align="center">
  <strong>Built with ❤️ using Flutter & AI</strong><br>
  Empowering diabetes care through technology
</p>
