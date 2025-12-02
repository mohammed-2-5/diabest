## DiiaBest (Diabest) – Comprehensive Documentation

### Executive summary
- **App name**: DiiaBest (Diabest)
- **Purpose**: Health companion for diabetic patients and doctors:
  - Authentication, onboarding, localization
  - Patient registration (medical profile)
  - Doctor registration and profile management
  - Doctors directory and details
  - Medication reminders with local notifications
  - Organ-specific AI checks (eyes, foot, heart) via image upload
  - Bluetooth device integration to read health metrics
  - Persistent bottom navigation with multiple features
- **Tech**: Flutter, BLoC (`bloc`, `flutter_bloc`), HTTP (`http`), DI (`get_it`), storage (`shared_preferences`), notifications (`flutter_local_notifications`), localization (JSON loader), navigation (`persistent_bottom_nav_bar`), BLE (`flutter_blue_plus`). `go_router` exists but is not wired.

### How to run
```bash
flutter pub get
flutter run
```
- Requires Flutter SDK >= 3.2.6
- Android minSdk 21 (notifications configured)
- Assets folders registered in `pubspec.yaml`

### Architecture overview
- **Entry**: `lib/main.dart`
  - Initializes SharedPreferences (`CacheHelper`), DI via `get_it`, BLoC observer
  - Provides `AuthCubit`, `CalenderCubit`, `TimeCubit`
  - Uses `ScreenUtilInit` and `AppThemes.lightTheme`
  - Home = `SplashView` (feature Splash2)
- **Dependency Injection**: `core/services/service_locator.dart`
- **Networking**: `core/services/http_helper.dart`
- **Storage**: `core/Database/cache/cache_helper.dart`
- **State management**: BLoC/Cubit per feature under `feature/`
- **UI system**: centralized colors, typography, strings, assets, theme
- **Navigation**: `persistent_bottom_nav_bar` + `Navigator.push*`. `GoRouter` file present but routes commented out

### Folder layout (key)
- `lib/core/` foundational services/utilities
  - `classes/` status/CRUD helpers
  - `Database/` local storage helpers
  - `functions/` small helpers (internet, navigation, data handling)
  - `Routers/` `GoRouter` (currently commented)
  - `services/` `HttpHelper`, `service_locator`
  - `Utils/` colors, text styles, strings, assets, theme
  - `Widgets/` shared widgets (bottom nav, buttons, text fields)
- `lib/feature/` user-facing modules
  - `auth/`, `doctor/`, `doctors_patient/`, `profile/`, `reminder_medicins/`, `organs/`, `On-Boarding/`, `Home/`, `my_watch/`, `language/`, `Register_your_information/`, etc.
- `lib/models/` DTO models (`user`, `doctor`, `patient`, `specialization`)
- `lib/Localizations/` JSON loader + simple language BLoC
- `lib/generated/assets.dart` generated asset constants

### Dependencies (pubspec.yaml, highlights)
- `bloc`, `flutter_bloc`, `get_it`, `http`, `shared_preferences`, `flutter_local_notifications`, `timezone`, `image_picker`, `flutter_blue_plus`, `persistent_bottom_nav_bar`, `flutter_screenutil`, `lottie`
- Note: `Api_links.dart` contains a legacy base URL; active base is in `HttpHelper`

---

## Core modules

### Entry and composition – `lib/main.dart`
- Initializes:
  - `SharedPreferences` (also used via `CacheHelper`)
  - DI: `setupServiceLocator()` registers `CacheHelper`
  - BLoC observer: `SimpleBlocObServer`
- Provides `AuthCubit`, `CalenderCubit`, `TimeCubit`
- Theme: `AppThemes.lightTheme`
- Start screen: `SplashView`

### Dependency Injection – `core/services/service_locator.dart`
- `getIt.registerSingleton<CacheHelper>(CacheHelper())`

### Local storage – `core/Database/cache/cache_helper.dart`
- `init()`: initialize `SharedPreferences`
- `saveData({key, value})`: stores String/Bool/Int/Double
- `getData({key})`, `getDataString({key})`, `containsKey({key})`
- `removeData({key})`, `clearData()`, `put({key, value})`

### Networking – `core/services/http_helper.dart`
- Base URL: `https://graduation-project-sigma.vercel.app/`
- `get(String url)` → Map
- `post(String url, Map data, {String? token})` → Map (JSON body + optional Bearer auth)
- `put(String url, Map data, {required String token})` → Map
- `putfile(String url, Map data, {required String token})`: sends map (image bytes). Consider switching to multipart

### Status and helpers
- `core/classes/status_request.dart`: `loading`, `none`, `sucess`, `failure`, `serverFailure`, `serverException`, `offlineFailure`, `dataNotCompleted`
- `core/functions/check_internet.dart`: DNS lookup of `google.com`
- `core/functions/handle_data.dart`: maps non-StatusRequest to `StatusRequest.sucess`
- `core/classes/crud.dart`: alternative POST helper using `Either<StatusRequest, Map>`

### Navigation
- Bottom nav: `core/Widgets/custom_bottom_navigation.dart` using `persistent_bottom_nav_bar`
- `core/Routers/App_Routers.dart`: `GoRouter` scaffold with commented routes (not used)
- `core/functions/Navigation.dart`: thin `go_router` wrappers (unused)

### Localization
- Loader: `Localizations/applocalizations.dart`
  - Loads `Assets/Language/{en|ar}.json` and exposes `translatetext(key)`
  - `delegate` implements `load`
- Language BLoC: `Localizations/logic/bloc/applanguage_*`
  - Events: `InitialLanguage`, `ArabicLanguageEvent`, `EnglishLanguageEvent`
  - States: `ApplanguageInitial`, `AppChangeLanguage(languageCode)`
  - Reads/writes `lang` in `SharedPreferences`

### UI system
- Colors: `core/Utils/App-colors.dart`
- Typography: `core/Utils/App-TextStyles.dart` (ScreenUtil-based)
- Strings: `core/Utils/App-String.dart`
- Theme: `core/Utils/app_them.dart` (`AppThemes.lightTheme`)
- Assets: `core/Utils/App-Assets.dart`, `generated/assets.dart`

### Shared widgets
- `CustomBtnNavigation`: 5 tabs (Home, Doctor, Watch, Contact Us, Profile). Chooses patient vs doctor profile based on role
- `CustomBtn`: full-width rounded action button
- `CustomTextFormField`: labeled input with validation hooks

---

## Features

### Authentication – `feature/auth/`
- States: `autch_state.dart`
  - `AuthInitial`, `ShowOnBoard`, `UnShowOnBoard`, `UserFound(role)`, `UserNotFound`
  - `SignupLoadingState`, `SignUpSuccess(currentUser)`, `SignUpFailure(errMessage)`
  - `SigninLoadingState`, `SigninSuccessState(currentUser)`, `SigninFailureState(errorMessage)`
  - `SendCodeSuccess/Failure`, `VerifyEmailSuccess/Failure`, `ResetPasswordSuccess/Failure`
  - `TermsAndConditionUpdateState`, `ObscurePasswordTextUpdateState`
- Cubit: `auth_cubit.dart`
  - Form controllers for signup/signin
  - Local storage helpers: `saveUserData`, `getUserLocalStorage`
  - Session checks: `checkShowOnBoard()`, `checkIsLogin()`, `getUserData()`
  - Auth actions:
    - `signUpWithEmailAndPassword()` → POST `Register/signup`, saves `token`, `id`, `role`, emits success/failure
    - `loginWithEmailAndPassword({email, password})` → POST `Register/login`, saves session, emits success/failure
    - `forgetPassword({email})` → POST `Register/forgetPassword`, stores `resetToken`
    - `verifyEmailCode({code})` → POST `Register/verifyResetPasswordCode` (Bearer)
    - `resetPassword({password, comfirmPassword})` → PUT `Register/resetPassword` (Bearer)
  - UI helpers: `updateTermsAndConditionCheckBox`, `obscurePasswordText`
- UI: `SignInView`, `CustomSignInForm`, `ForgotPasswordViews`, `CreateNewPassword`

### Onboarding & Language
- Onboarding: `feature/On-Boarding/presentation/views/on-boarding-view.dart`
  - PageView flow; on skip/finish sets `onBording` and navigates to Sign In
- Language chooser: `feature/language/presentation/language.dart`
  - Blue gradient UI with 2 options; calls `AuthCubit.checkShowOnBoard()` 

### Home & Doctors (patient-facing)
- Home wrapper: `HomeViews` → `CustomHome`
- `CustomHome`:
  - Header branding
  - Quick grid shortcuts: Organs, Reminder, Eating, Sports
  - “Popular Doctors” list from `DoctorPatientCubit` (horizontal, top 6)
- `DoctorPatientCubit`:
  - `getAllDoctor()` → GET `Doctor/getAllDoctors`, then resolves specialization names via GET `specialization`
  - `searchDoctor()` filters by `fullName`
  - `getDoctorImage()` maps specialization to local image
- States: `DoctorPatientInitial`, `GetAllDoctorSuccess(doctors)`, `GetAllDoctorFailure(errorMessage)`

### Doctor registration & profile – `feature/doctor/`
- Cubit: `doctor_cubit.dart`
  - Form fields: address, phone, facebook/whatsapp links, start/end times
  - `seletSpecialization(index)` maps UI index to backend IDs
  - `getDoctorData()` → GET `Register/getUser/:id`, builds `DoctorsModel`
  - `getDoctorSpecialization({id})` → GET `specialization`, lookup by id
  - `registerDoctor()` → POST `Doctor/doctorRegisteration` (Bearer)
  - `updateDoctor(...)` → PUT `Doctor/editProfile/:id` (Bearer)
  - `signOut()` clears token and id
- States: `GetProfileSuccess/Failure`, `RegisterDoctorSuccess/Failure`, `UpdateDoctorSuccess/Failure`, `SignOut`
- UI: `DoctorView` (registration), `EditProfileDoctor` (editing)

### Patient registration (medical profile) – `feature/Register_your_information/`
- Cubit: `register_patient_cubit.dart`
  - Fields: age, height, weight, status, comorbidity flags
  - `registerPatient({gender})` builds male/female payload and POSTs to `Patient/patientRegisteration` (Bearer)
- States: `RegisterPatientInitial`, `RegisterPatientLoading`, `RegisterPatientSuccess`, `RegisterPatientFailure(errorMessage)`
- UI: `RegisterPatientInformation` → `RegisterPationBody`

### Profile (Patient) – `feature/profile/`
- Cubit: `profile_cubit.dart`
  - `getPatientData()` → GET `Register/getUser/:id` and emits `GetProfileSuccess(user)`
  - `changePassword(...)` → PUT `Register/editProfile/:id/changePassword` (Bearer)
  - `updateProfile()` → PUT `Patient/editProfile/:id` (Bearer)
  - `uploadImage()` → PUT `Register/uploadUserImage` (sends bytes)
  - `signOut()` clears token/id
- States: `GetProfileSuccess/Failure`, `UpdateProfileSuccess/Failure`, `RestPasswordSuccess/Failure`, `UploadImageFailure`, `SignOut`
- UI: `ProfileView` shows personal + medical history cards and navigates to `EditProfileView`

### Reminders & notifications – `feature/reminder_medicins/`
- `CalenderCubit.showCalenderPicker(context)`: picks a date; emits picked date and Y/M/D
- `TimeCubit.showTimerPicker(context, title, description)`: picks a time; stores hour/minute and appends reminder entry; emits state with `reminderAddedList`
- `LocalNotificationService`:
  - `init()` initializes plugin (Android config present)
  - `showBasicNotification()`, `showRepeatedNotification()`
  - `showScheduledNotification({title, reminder, year, month, day, hour, minute})`: schedules with timezone (`Africa/Cairo`)
- UI: `ReminderMedicinsView` with FAB to open time screen (details not included here)
- Tip: Ensure `LocalNotificationService.init()` is called on startup (currently commented in `main.dart`)

### Organs AI checks – `feature/organs/`
- `HeartView` + `HeartForm`:
  - Image picker UI to capture/select an image; preview shown
  - Embedded `FootView` uploader:
    - Uploads to `https://dfumodel.onrender.com/dfu` as multipart under field `file`
    - Awaits a JSON `{ predicted_class: string }` and displays result
- `EyesView`:
  - Similar image upload flow to the same endpoint, with backdrop UI and diagnosis text

### Bluetooth watch – `feature/my_watch/`
- `BluetoothApp`:
  - Listens to adapter state via `FlutterBluePlus`
  - `SelectDevicePage`: scan and pick a device (5s timeout)
  - `_startConnection()` connects to selected device, discovers services, subscribes to the first characteristic that supports `notify`
  - Incoming notification is parsed as comma-separated values into `_value1`, `_value2` (e.g., sugar and heart rate)
  - UI shows data containers and a simple sugar classification (Low/Normal/High) from `_value1`
- Notes:
  - For robustness, filter by known Service/Characteristic UUIDs from your device
  - Add disconnect/cleanup handling as needed

---

## Models
- `models/user_model.dart`: user fields (`fullName`, `email`, `gender`, `role`, `profileImage`, etc.), `fromJson`, `toJson`
- `models/doctor_model.dart`: `DoctorsModel` with contact, timings, clinic address, socials, specialization, `fullName`
- `models/patiant_model.dart`: `PatientModel` with personal and health flags (strings). Consider normalizing booleans
- `models/specialization_model.dart`: `SpecializationModel` with `id`, `specialization`, `imageUrl`

---

## Bottom navigation and tabs
- `CustomBtnNavigation` (persistent):
  - Tabs: Home (`HomeViews`), Doctor (`DoctorPatientView`), Diabest Watch (`BluetoothApp`), Contact Us, Profile (doctor vs patient view based on role)
  - Listens to `AuthCubit` sign-in/out to show/hide nav and redirect to SignIn on logout

---

## API reference (as used)
- Base (HttpHelper): `https://graduation-project-sigma.vercel.app/`
- Auth:
  - `Register/signup` (POST)
  - `Register/login` (POST)
  - `Register/getUser/:id` (GET)
  - `Register/forgetPassword` (POST)
  - `Register/verifyResetPasswordCode` (POST, Bearer)
  - `Register/resetPassword` (PUT, Bearer)
  - `Register/editProfile/:id/changePassword` (PUT, Bearer)
  - `Register/uploadUserImage` (PUT, Bearer; bytes)
- Patient:
  - `Patient/patientRegisteration` (POST, Bearer)
  - `Patient/editProfile/:id` (PUT, Bearer)
- Doctor:
  - `Doctor/doctorRegisteration` (POST, Bearer)
  - `Doctor/editProfile/:id` (PUT, Bearer)
  - `Doctor/getAllDoctors` (GET)
- Specialization:
  - `specialization` (GET)
- AI model:
  - `https://dfumodel.onrender.com/dfu` (POST multipart `file`)
- Note: `core/Utils/Api_links.dart` contains another base (`https://long-rose-goose-gown.cyclic.app`). Unify bases to avoid confusion

---

## Typical user flows
- First launch:
  - Language selection (optional)
  - Onboarding pages (flag stored as `onBording`)
  - Sign In or Sign Up
- Sign Up / Sign In:
  - Patient or Doctor role
  - After login, app routes to role-appropriate area (doctor profile vs patient tabs)
- Patient:
  - Complete medical registration
  - Use Home shortcuts (Organs, Reminder, Eating, Sports)
  - View/edit Profile
- Doctor:
  - Register professional details and availability
  - View/edit profile
- Reminders:
  - Pick date/time and (optionally) schedule notification
- Organs AI:
  - Take/upload image → get a predicted class
- Watch:
  - Scan, select, and connect to BLE device → stream readings

---

## Implementation notes and suggestions
- **Routing**:
  - `GoRouter` present but unused; consider migrating navigation to it for consistency
- **Notifications**:
  - Call `LocalNotificationService.init()` at startup to enable notifications
- **File upload**:
  - Replace `putfile` with `http.MultipartRequest` (proper `multipart/form-data`)
- **API base URL**:
  - Consolidate to a single base (prefer `HttpHelper`), remove outdated constants
- **Theme file**:
  - `app_them.dart` contains a demo `main()`; remove or move to examples
- **Models**:
  - Normalize boolean flags (store as `bool`) instead of strings in `PatientModel`
- **Bluetooth**:
  - Filter specific Service/Characteristic UUIDs and add disconnect cleanup
- **Localization wiring**:
  - Ensure `MaterialApp` includes `localizationsDelegates` and `supportedLocales` using the custom loader

---

## Class/method reference (key)
- `CacheHelper`: `init`, `saveData`, `getData`, `getDataString`, `containsKey`, `removeData`, `clearData`, `put`
- `HttpHelper`: `get`, `post`, `put`, `putfile`
- `CRUD`: `postData`
- `AuthCubit`:
  - Session: `checkShowOnBoard`, `checkIsLogin`, `getUserData`, `getUserLocalStorage`, `saveUserData`
  - Actions: `signUpWithEmailAndPassword`, `loginWithEmailAndPassword`, `forgetPassword`, `verifyEmailCode`, `resetPassword`
  - UI: `updateTermsAndConditionCheckBox`, `obscurePasswordText`
- `DoctorCubit`:
  - `seletSpecialization`, `getDoctorData`, `getDoctorSpecialization`
  - `registerDoctor`, `updateDoctor`, `signOut`, `killToken`
- `RegisterPatientCubit`: `registerPatient`, `getUserFromLocalStorage`
- `ProfileCubit`:
  - `getPatientData`, `changePassword`, `updateProfile`, `uploadImage`, `signOut`, `killToken`
- `CalenderCubit`: `showCalenderPicker`
- `TimeCubit`: `showTimerPicker`
- `LocalNotificationService`: `init`, `showBasicNotification`, `showRepeatedNotification`, `showScheduledNotification`
- `BluetoothApp`: device scan/selection/connect, notify subscription, CSV parsing of values

---

## Extending the app
- Add a new feature: create under `feature/{name}`, add Cubit + UI, expose via bottom nav or router
- Add a new API call: create method in `HttpHelper`, call from a Cubit, render with `BlocBuilder`
- Add localization: add keys to `Assets/Language/{en,ar}.json` and use `Applocalizations.of(context)?.translatetext(key)`
- Improve robustness: centralize constants (API base, pref keys), unify error handling, instrument logs

---

## Generating API docs
- Generate HTML docs from code comments:
```bash
dart pub global activate dartdoc
dart doc
```
- Consider adding concise dartdoc comments to public classes and methods for quality output

---

## Next steps (optional)
- Wire `GoRouter`, re-enable notifications `init()`
- Unify API base and convert file uploads to multipart
- Normalize boolean fields in models
- Add `localizationsDelegates`/`supportedLocales` to `MaterialApp`
- Filter BLE by known UUIDs and add cleanup
- Add tests (unit/widget) for core flows; enable CI (format, analyze, test)
- Remove demo code and unused files

---

© DiiaBest – Project documentation