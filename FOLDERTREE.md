# 📁 Credit Management App - Folder Tree Structure

## 🔴 CURRENT STATE (Hiện Tại)

```
credit_management/
├── analysis_options.yaml
├── PLAN.md                          # 📋 Implementation plan
├── README.md
├── credit_management.iml
├── firebase.json
├── pubspec.yaml                     # Dependencies config
│
├── android/                         # Android native code
│   ├── build.gradle.kts
│   ├── credit_management_android.iml
│   ├── gradle.properties
│   ├── gradlew
│   ├── gradlew.bat
│   ├── local.properties
│   ├── settings.gradle.kts
│   ├── app/
│   │   ├── build.gradle.kts
│   │   ├── google-services.json
│   │   └── src/
│   └── gradle/
│       └── wrapper/
│
├── ios/                             # iOS native code
│   ├── Flutter/
│   ├── Runner/
│   ├── Runner.xcodeproj/
│   ├── Runner.xcworkspace/
│   └── RunnerTests/
│
├── lib/                             # 📱 Main Dart code
│   ├── main.dart                    # App entry point
│   ├── firebase_options.dart        # Firebase config
│   │
│   ├── models/                      # ❌ EMPTY (Phase 1)
│   │   └── (models to be created)
│   │
│   ├── pages/
│   │   ├── loginPage/
│   │   │   ├── login_page.dart
│   │   │   ├── login_page_logic.dart
│   │   │   └── widgets/
│   │   │       └── login_form.dart
│   │   │
│   │   └── homePage/
│   │       ├── home_page.dart
│   │       └── home_page_logic.dart
│   │
│   ├── routes/
│   │   ├── guest_route.dart         # ❌ EMPTY (Phase 1)
│   │   └── user_route.dart          # ❌ EMPTY (Phase 1)
│   │
│   └── services/
│       └── authentication_service.dart
│
├── build/                           # Build output (auto-generated)
│   ├── ab265087200ee5938982ca8fe828b67c/
│   ├── app/
│   ├── cloud_firestore/
│   ├── firebase_auth/
│   ├── firebase_core/
│   ├── native_assets/
│   ├── native_hooks/
│   └── reports/
│
├── linux/                           # Linux platform code
├── macos/                           # macOS platform code
├── web/                             # Web platform code
├── windows/                         # Windows platform code
└── test/
    └── widget_test.dart
```

---

## 🟢 FUTURE STATE (Công Việc Sắp Triển Khai)

### **PHASE 1: Foundation**
```
lib/
├── main.dart                        # ✏️ Update with routing & provider
├── firebase_options.dart
│
├── models/                          # 🆕 CREATE
│   ├── credit_card.dart
│   ├── promotional_program.dart
│   └── user_profile.dart
│
├── providers/                       # 🆕 CREATE
│   ├── auth_provider.dart
│   ├── credit_card_provider.dart
│   ├── user_provider.dart
│   └── app_state.dart
│
├── exceptions/                      # 🆕 CREATE
│   ├── auth_exceptions.dart
│   └── app_exceptions.dart
│
├── utils/                           # 🆕 CREATE
│   ├── validators.dart
│   ├── constants.dart
│   └── extensions.dart
│
├── routes/
│   ├── app_router.dart              # 🆕 CREATE
│   ├── guest_route.dart             # ✏️ Update
│   └── user_route.dart              # ✏️ Update
│
├── pages/
│   ├── loginPage/
│   │   ├── login_page.dart          # ✏️ Update
│   │   ├── login_page_logic.dart    # ✏️ Update
│   │   └── widgets/
│   │       └── login_form.dart      # ✏️ Update
│   │
│   ├── signupPage/                  # 🆕 CREATE
│   │   ├── signup_page.dart
│   │   ├── signup_page_logic.dart
│   │   └── widgets/
│   │       └── signup_form.dart
│   │
│   └── homePage/
│       ├── home_page.dart           # ✏️ Update
│       └── home_page_logic.dart     # ✏️ Update
│
└── services/
    └── authentication_service.dart  # ✏️ Update
```

### **PHASE 2: Authentication UI (Enhancement)**
```
lib/
├── pages/
│   ├── loginPage/
│   │   └── widgets/
│   │       └── login_form.dart      # ✏️ Complete form with validation
│   │
│   ├── signupPage/
│   │   └── widgets/
│   │       ├── signup_form.dart     # ✏️ Full signup form
│   │       └── password_strength.dart # 🆕 Password strength indicator
│   │
│   └── forgotPasswordPage/          # 🆕 CREATE (Optional)
│       ├── forgot_password_page.dart
│       └── reset_password_form.dart
│
├── widgets/                         # 🆕 SHARED WIDGETS
│   ├── common/
│   │   ├── custom_text_field.dart
│   │   ├── custom_button.dart
│   │   ├── loading_indicator.dart
│   │   └── error_dialog.dart
│   │
│   └── auth/
│       ├── auth_header.dart
│       └── password_field.dart
│
└── theme/                           # 🆕 CREATE
    ├── app_theme.dart
    ├── colors.dart
    └── text_styles.dart
```

### **PHASE 3: Core Features - Credit Card Management**
```
lib/
├── pages/
│   ├── homePage/
│   │   ├── home_page.dart           # ✏️ Complete with card list
│   │   ├── home_page_logic.dart
│   │   └── widgets/
│   │       ├── credit_card_item.dart # 🆕 Card list item widget
│   │       ├── card_stats.dart       # 🆕 Show stats
│   │       └── add_card_button.dart  # 🆕
│   │
│   ├── addCardPage/                 # 🆕 CREATE
│   │   ├── add_card_page.dart
│   │   ├── add_card_logic.dart
│   │   └── widgets/
│   │       └── card_form.dart
│   │
│   ├── editCardPage/                # 🆕 CREATE
│   │   ├── edit_card_page.dart
│   │   ├── edit_card_logic.dart
│   │   └── widgets/
│   │       └── card_form.dart
│   │
│   ├── cardDetailsPage/             # 🆕 CREATE
│   │   ├── card_details_page.dart
│   │   ├── card_details_logic.dart
│   │   └── widgets/
│   │       ├── card_info_header.dart
│   │       ├── card_actions.dart
│   │       └── promotion_list.dart
│   │
│   ├── promotionPage/               # 🆕 CREATE
│   │   ├── promotion_list_page.dart
│   │   ├── add_promotion_page.dart
│   │   ├── edit_promotion_page.dart
│   │   ├── promotion_details_page.dart
│   │   └── widgets/
│   │       ├── promotion_item.dart
│   │       ├── promotion_form.dart
│   │       └── discount_badge.dart
│   │
├── services/
│   ├── authentication_service.dart  # ✔️ Existing
│   ├── credit_card_service.dart     # 🆕 CREATE - Firestore operations
│   ├── promotion_service.dart       # 🆕 CREATE - Firestore operations
│   └── firebase_service.dart        # 🆕 CREATE - Base Firebase service
│
└── providers/
    ├── auth_provider.dart           # Existing
    ├── credit_card_provider.dart    # ✏️ Expand with CRUD ops
    └── promotion_provider.dart      # 🆕 CREATE
```

### **PHASE 4: User Management & Advanced Features**
```
lib/
├── pages/
│   ├── profilePage/                 # 🆕 CREATE
│   │   ├── profile_page.dart
│   │   ├── profile_logic.dart
│   │   └── widgets/
│   │       ├── user_info_card.dart
│   │       ├── user_stats.dart
│   │       ├── edit_profile_form.dart
│   │       └── security_section.dart
│   │
│   ├── settingsPage/                # 🆕 CREATE
│   │   ├── settings_page.dart
│   │   └── widgets/
│   │       ├── notification_settings.dart
│   │       ├── theme_selector.dart
│   │       └── about_app.dart
│   │
│   └── searchPage/                  # 🆕 CREATE (Optional)
│       ├── search_page.dart
│       └── widgets/
│           ├── search_bar.dart
│           └── filter_options.dart
│
├── services/
│   ├── local_storage_service.dart   # 🆕 CREATE - Hive/SQLite
│   ├── sync_service.dart            # 🆕 CREATE - Offline sync
│   ├── notification_service.dart    # 🆕 CREATE - FCM
│   └── analytics_service.dart       # 🆕 CREATE - Tracking
│
├── providers/
│   ├── user_provider.dart           # ✏️ Expand with profile ops
│   ├── settings_provider.dart       # 🆕 CREATE
│   └── notification_provider.dart   # 🆕 CREATE
│
└── utils/
    ├── search_utils.dart            # 🆕 CREATE
    ├── filter_utils.dart            # 🆕 CREATE
    └── formatters.dart              # 🆕 CREATE
```

### **PHASE 5: Polish & Testing**
```
lib/
├── theme/
│   ├── app_theme.dart               # ✏️ Complete with dark mode
│   ├── colors.dart
│   ├── text_styles.dart
│   └── spacing.dart                 # 🆕 Design tokens
│
├── widgets/
│   └── animations/                  # 🆕 CREATE
│       ├── fade_transition.dart
│       ├── slide_transition.dart
│       └── bounce_animation.dart
│

test/                                # 🆕 Complete test suite
├── unit/
│   ├── models/
│   │   ├── credit_card_test.dart
│   │   ├── promotional_program_test.dart
│   │   └── user_profile_test.dart
│   │
│   ├── services/
│   │   ├── authentication_service_test.dart
│   │   └── validators_test.dart
│   │
│   └── utils/
│       └── validators_test.dart
│
├── widget/
│   ├── pages/
│   │   ├── login_page_test.dart
│   │   ├── home_page_test.dart
│   │   └── card_details_page_test.dart
│   │
│   └── widgets/
│       ├── custom_text_field_test.dart
│       └── credit_card_item_test.dart
│
└── integration/
    ├── auth_flow_test.dart
    ├── card_management_flow_test.dart
    └── full_app_test.dart
```

---

## 📊 COMPLETE FUTURE STRUCTURE (After All Phases)

```
credit_management/
├── PLAN.md
├── FOLDERTREE.md                    # This file
├── pubspec.yaml                     # Updated with all dependencies
├── analysis_options.yaml
├── README.md
│
├── lib/
│   ├── main.dart
│   ├── firebase_options.dart
│   │
│   ├── models/
│   │   ├── credit_card.dart
│   │   ├── promotional_program.dart
│   │   └── user_profile.dart
│   │
│   ├── providers/
│   │   ├── app_state.dart
│   │   ├── auth_provider.dart
│   │   ├── credit_card_provider.dart
│   │   ├── promotion_provider.dart
│   │   ├── user_provider.dart
│   │   ├── settings_provider.dart
│   │   └── notification_provider.dart
│   │
│   ├── services/
│   │   ├── firebase_service.dart
│   │   ├── authentication_service.dart
│   │   ├── credit_card_service.dart
│   │   ├── promotion_service.dart
│   │   ├── local_storage_service.dart
│   │   ├── sync_service.dart
│   │   ├── notification_service.dart
│   │   └── analytics_service.dart
│   │
│   ├── pages/
│   │   ├── loginPage/
│   │   │   ├── login_page.dart
│   │   │   ├── login_page_logic.dart
│   │   │   └── widgets/
│   │   │       └── login_form.dart
│   │   ├── signupPage/
│   │   │   ├── signup_page.dart
│   │   │   ├── signup_page_logic.dart
│   │   │   └── widgets/
│   │   │       ├── signup_form.dart
│   │   │       └── password_strength.dart
│   │   ├── forgotPasswordPage/
│   │   │   ├── forgot_password_page.dart
│   │   │   └── reset_password_form.dart
│   │   ├── homePage/
│   │   │   ├── home_page.dart
│   │   │   ├── home_page_logic.dart
│   │   │   └── widgets/
│   │   │       ├── credit_card_item.dart
│   │   │       ├── card_stats.dart
│   │   │       └── add_card_button.dart
│   │   ├── addCardPage/
│   │   │   ├── add_card_page.dart
│   │   │   ├── add_card_logic.dart
│   │   │   └── widgets/
│   │   │       └── card_form.dart
│   │   ├── editCardPage/
│   │   │   ├── edit_card_page.dart
│   │   │   ├── edit_card_logic.dart
│   │   │   └── widgets/
│   │   │       └── card_form.dart
│   │   ├── cardDetailsPage/
│   │   │   ├── card_details_page.dart
│   │   │   ├── card_details_logic.dart
│   │   │   └── widgets/
│   │   │       ├── card_info_header.dart
│   │   │       ├── card_actions.dart
│   │   │       └── promotion_list.dart
│   │   ├── promotionPage/
│   │   │   ├── promotion_list_page.dart
│   │   │   ├── add_promotion_page.dart
│   │   │   ├── edit_promotion_page.dart
│   │   │   ├── promotion_details_page.dart
│   │   │   └── widgets/
│   │   │       ├── promotion_item.dart
│   │   │       ├── promotion_form.dart
│   │   │       └── discount_badge.dart
│   │   ├── profilePage/
│   │   │   ├── profile_page.dart
│   │   │   ├── profile_logic.dart
│   │   │   └── widgets/
│   │   │       ├── user_info_card.dart
│   │   │       ├── user_stats.dart
│   │   │       ├── edit_profile_form.dart
│   │   │       └── security_section.dart
│   │   ├── settingsPage/
│   │   │   ├── settings_page.dart
│   │   │   └── widgets/
│   │   │       ├── notification_settings.dart
│   │   │       ├── theme_selector.dart
│   │   │       └── about_app.dart
│   │   └── searchPage/
│   │       ├── search_page.dart
│   │       └── widgets/
│   │           ├── search_bar.dart
│   │           └── filter_options.dart
│   │
│   ├── widgets/
│   │   ├── common/
│   │   │   ├── custom_text_field.dart
│   │   │   ├── custom_button.dart
│   │   │   ├── loading_indicator.dart
│   │   │   ├── error_dialog.dart
│   │   │   └── confirmation_dialog.dart
│   │   ├── auth/
│   │   │   ├── auth_header.dart
│   │   │   ├── password_field.dart
│   │   │   └── email_field.dart
│   │   └── animations/
│   │       ├── fade_transition.dart
│   │       ├── slide_transition.dart
│   │       └── bounce_animation.dart
│   │
│   ├── routes/
│   │   ├── app_router.dart
│   │   ├── guest_route.dart
│   │   └── user_route.dart
│   │
│   ├── exceptions/
│   │   ├── auth_exceptions.dart
│   │   └── app_exceptions.dart
│   │
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── formatters.dart
│   │   ├── search_utils.dart
│   │   ├── filter_utils.dart
│   │   ├── constants.dart
│   │   └── extensions.dart
│   │
│   └── theme/
│       ├── app_theme.dart
│       ├── colors.dart
│       ├── text_styles.dart
│       └── spacing.dart
│
├── test/
│   ├── unit/
│   │   ├── models/
│   │   │   ├── credit_card_test.dart
│   │   │   ├── promotional_program_test.dart
│   │   │   └── user_profile_test.dart
│   │   ├── services/
│   │   │   ├── authentication_service_test.dart
│   │   │   └── credit_card_service_test.dart
│   │   └── utils/
│   │       └── validators_test.dart
│   ├── widget/
│   │   ├── pages/
│   │   │   ├── login_page_test.dart
│   │   │   ├── home_page_test.dart
│   │   │   └── card_details_page_test.dart
│   │   └── widgets/
│   │       ├── custom_text_field_test.dart
│   │       └── credit_card_item_test.dart
│   └── integration/
│       ├── auth_flow_test.dart
│       ├── card_management_flow_test.dart
│       └── full_app_test.dart
│
├── android/                         # (unchanged)
├── ios/                             # (unchanged)
├── linux/                           # (unchanged)
├── macos/                           # (unchanged)
├── web/                             # (unchanged)
├── windows/                         # (unchanged)
└── build/                           # (auto-generated)
```

---

## 🔑 LEGEND

| Symbol | Meaning |
|--------|---------|
| ✔️ | Existing - Keep as is |
| ✏️ | Modify - Update current |
| 🆕 | Create - New file |
| 🔴 | Red - Current state |
| 🟢 | Green - Future state (after Phase) |
| ❌ | Empty - To be filled |

---

## 🎯 IMPLEMENTATION ORDER

```
Phase 1 (Days 1-2): Foundation
├── Create: models/*
├── Create: providers/*
├── Create: exceptions/*
├── Create: utils/*
├── Update: routes/*
└── Update: services/authentication_service.dart

Phase 2 (Days 3-4): Authentication UI
├── Update: pages/loginPage/*
├── Create: pages/signupPage/*
├── Update: main.dart (routing)
└── Create: widgets/common/*

Phase 3 (Days 5-7): Core Features
├── Update: pages/homePage/*
├── Create: pages/addCardPage/*
├── Create: pages/editCardPage/*
├── Create: pages/cardDetailsPage/*
├── Create: pages/promotionPage/*
└── Create: services/{credit_card,promotion}_service.dart

Phase 4 (Days 8-9): Advanced Features
├── Create: pages/profilePage/*
├── Create: pages/settingsPage/*
├── Create: services/{local_storage,sync,notification}*.dart
└── Create: utils/{search,filter}*.dart

Phase 5 (Day 10): Polish & Testing
├── Create: test/* (all test files)
├── Update: theme/* (complete design)
└── Update: widgets/animations/*
```

---

**Last Updated**: April 6, 2026
**Status**: Planning Phase (Ready to Execute)
