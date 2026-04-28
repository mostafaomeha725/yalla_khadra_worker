🚫 Forbidden:

* Text
* ElevatedButton
* TextButton
* OutlinedButton
* Image.asset
* Image.network
* TextFormField
* ScaffoldMessenger
* Navigator.push
* Navigator.pop
* MaterialPageRoute
* setState for business logic or shared state

---

✅ Required:

* AppText
* AppButton
* AppImage
* AppAsset
* AppSVG
* AppFormField
* CustomSnackBar
* CustomLoading
* BounceIt

---

♻️ Reusability Rules:

* ALWAYS check lib/core/widgets before creating anything new
* Reuse existing widgets first
* If similar widget exists → extend it instead of duplicating it
* Never duplicate UI logic

---

🧠 Core Widgets:

* AppText
* AppButton
* AppAsset
* AppImage
* AppSVG
* AppFormField
* CustomSearch
* CustomSnackBar
* CustomLoading
* BounceIt
* CustomNavBar
* CustomBottomNavBar
* NavBarItem
* GovernorateDropdown
* SwitchOpen
* AppbarSubscriptionWidget
* BouncingSocialButton

---

🧰 Core Helpers:

* ALL helpers must be in:
  lib/core/helpers/helpers.dart

* NEVER create new helper files

* NEVER duplicate helper logic

* NEVER place helper logic inside UI

Use helpers for:

* image picking
* sharing
* timers
* url launching
* whatsapp
* phone calls
* emails
* pdf handling

---

⚙️ Core Utils:

Use ONLY from:
lib/core/utils

Available:

* app_bloc_observer.dart
* app_date_time.dart
* easy_loading.dart
* safe_print.dart
* spacing.dart
* url_launcher_util.dart
* validators.dart

Rules:

* NEVER rewrite utils
* NEVER duplicate formatting logic

---

🧱 Clean Architecture:

* presentation → domain → data
* UI must NEVER access repositories directly
* Cubits call UseCases ONLY
* Business logic only in domain layer
* No Flutter imports in domain

---

🧠 State Management:

* Use Cubit / Bloc ONLY

Allowed:

* BlocBuilder
* BlocListener
* BlocConsumer

Forbidden:

* setState for logic
* business logic in UI

---

🧭 Navigation:

Use GoRouter ONLY:

* context.push()
* context.go()
* context.pop()

Forbidden:

* Navigator
* MaterialPageRoute

---

🧱 Screen Structure:

Each screen must have:

1. Screen file:

   * Scaffold ONLY

2. sreenBody file:

   * contains UI

Example:

login_screen.dart → Scaffold only
login_screen_body.dart → full UI

---

📂 File Splitting (CRITICAL):

* Max 120 lines per file
* If exceeded → split automatically

Return in this order:

1. Folder structure
2. Then files one by one

---

🧩 Large UI:

* Split into widgets folder

Examples:

* header
* form
* section
* card
* list
* dialog

---

🧩 Widget Rule:

❌ No private widgets inside same file
❌ No _WidgetName

✅ Each widget in separate file

------

🎨 UI Rules:

* Follow design system
* Responsive using ScreenUtil
* Clean UI
* No random styles

---

🤖 Generation Rules:

* If code is large:
  → Return folder structure FIRST
  → Then generate files
START.
