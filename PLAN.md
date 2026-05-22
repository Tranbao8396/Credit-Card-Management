# 📋 Credit Management App - Implementation Plan

## 📊 PHÂN TÍCH HIỆN TRẠNG

### ✅ Đã Hoàn Thành:
- ✔️ Firebase Integration (Core, Auth, Firestore)
- ✔️ AuthenticationService với Singleton pattern
- ✔️ Sign up (email/password + lưu Firestore)
- ✔️ Sign in / Sign out
- ✔️ Cơ sở Folder Structure (Pages, Routes, Services, Models)

### ❌ Chưa Triển Khai:
1. **Data Models** - CreditCard, PromotionalProgram, UserProfile
2. **Navigation/Routing** - guest_route.dart, user_route.dart còn trống
3. **UI Components** - Login Form, Home Page chỉ là placeholder
4. **State Management** - Chưa có (cần thêm Provider, Riverpod hoặc BLoC)
5. **Credit Card Management** - CRUD operations
6. **Promotional Programs** - Link với từng card
7. **User Profile** - View/Edit profile
8. **Local Storage** - Offline support
9. **Search & Filter**
10. **Error Handling & Validation** - Toàn diện

---

## 🎯 CHI TIẾT IMPLEMENTATION PLAN

### **PHASE 1: Foundation (1 tuần)**

#### 1.1 Cấu hình State Management
**Công việc:**
- [ ] Thêm `provider: ^6.0.0` vào pubspec.yaml
- [ ] Tạo providers cho: Auth, CreditCard, User
- [ ] Setup Provider config

**Files cần tạo:**
```
lib/
  providers/
    auth_provider.dart
    credit_card_provider.dart
    user_provider.dart
```

#### 1.2 Tạo Data Models
**Công việc:**
- [ ] CreditCard model (cardNumber, cardName, bank, expiryDate, balance)
- [ ] PromotionalProgram model (title, description, discount, expiryDate, cardId)
- [ ] UserProfile model (uid, email, name, createdAt, updatedAt)

**Files cần tạo:**
```
lib/models/
  credit_card.dart
  promotional_program.dart
  user_profile.dart
```

#### 1.3 Setup Navigation/Routing
**Công việc:**
- [ ] Tạo app_router.dart cho Go Router hoặc Navigation logic
- [ ] Implement guest routes (Login, Signup)
- [ ] Implement user routes (Home, Profile, CardDetails)
- [ ] Auth state monitoring để điều hướng

**Files cần tạo/sửa:**
```
lib/routes/
  app_router.dart
  guest_route.dart (update)
  user_route.dart (update)
```

#### 1.4 Error Handling & Validation
**Công việc:**
- [ ] Tạo custom exceptions
- [ ] Validation utilities (email, password, card number)
- [ ] Error handling interceptors

**Files cần tạo:**
```
lib/
  exceptions/
    auth_exceptions.dart
    app_exceptions.dart
  utils/
    validators.dart
```

---

### **PHASE 2: Authentication UI (1.5 tuần)**

#### 2.1 Hoàn thành Login Form
**Công việc:**
- [ ] Email input field với validation
- [ ] Password input field
- [ ] Login button
- [ ] Error messages display
- [ ] Loading state
- [ ] Link "Don't have account" → SignUp

**File sửa:`lib/pages/loginPage/widgets/login_form.dart`**

#### 2.2 Tạo Signup Form
**Công việc:**
- [ ] Email field + validation
- [ ] Password field + strength indicator
- [ ] Confirm password field
- [ ] Name field
- [ ] Signup button
- [ ] Link "Already have account" → Login

**Files cần tạo:**
```
lib/pages/signupPage/
  signup_page.dart
  signup_form.dart
```

#### 2.3 Password Recovery (Optional)
**Công việc:**
- [ ] Forgot password link
- [ ] Email input
- [ ] Reset password form

#### 2.4 Auth Transitions
**Công việc:**
- [ ] Smooth transitions giữa Login/Signup
- [ ] Loading screens
- [ ] Success notifications

---

### **PHASE 3: Core Features - Credit Card Management (2 tuần)**

#### 3.1 Home Page UI
**Công việc:**
- [ ] Header với user greeting
- [ ] Credit Cards list view
- [ ] "Add New Card" button
- [ ] User menu/logout

**File sửa: `lib/pages/homePage/home_page.dart`**

#### 3.2 Add Credit Card Feature
**Công việc:**
- [ ] Form để nhập card details:
  - Card name (ví dụ: "VISA Gold")
  - Card number
  - Bank name
  - Expiry date
  - Card type (Visa, Mastercard, etc)
- [ ] Validation card number (Luhn algorithm)
- [ ] Save to Firestore
- [ ] Success/Error notifications

**Files cần tạo:**
```
lib/pages/addCardPage/
  add_card_page.dart
  add_card_form.dart
```

#### 3.3 View Credit Card Details
**Công việc:**
- [ ] Display card info (masked card number)
- [ ] Show card balance
- [ ] Show promotional programs của card này
- [ ] Edit button (navigate to edit form)
- [ ] Delete button (confirm dialog)

**Files cần tạo:**
```
lib/pages/cardDetailsPage/
  card_details_page.dart
```

#### 3.4 Edit Credit Card
**Công việc:**
- [ ] Pre-fill form với current card data
- [ ] Update Firestore
- [ ] Validation

**Files cần tạo:**
```
lib/pages/editCardPage/
  edit_card_page.dart
```

#### 3.5 Promotional Programs (cho từng Card)
**Công việc:**
- [ ] List view promotions của card
- [ ] Add promotion form
- [ ] View promotion details
- [ ] Edit/Delete promotion

**Files cần tạo:**
```
lib/pages/promotionPage/
  promotion_list.dart
  add_promotion_page.dart
  promotion_details_page.dart
```

---

### **PHASE 4: User Management & Advanced Features (1.5 tuần)**

#### 4.1 User Profile Page
**Công việc:**
- [ ] View user info (name, email, member since)
- [ ] Edit profile form
- [ ] Change password
- [ ] Logout button

**Files cần tạo:**
```
lib/pages/profilePage/
  profile_page.dart
  edit_profile_form.dart
```

#### 4.2 Local Storage / Offline Support
**Công việc:**
- [ ] Thêm `hive` hoặc `sqflite` package
- [ ] Cache credit cards locally
- [ ] Sync khi có internet
- [ ] Offline indicators

**Files cần tạo:**
```
lib/services/
  local_storage_service.dart
  sync_service.dart
```

#### 4.3 Search & Filter
**Công việc:**
- [ ] Search credit cards by name
- [ ] Filter promotions by category/discount
- [ ] Sort by date/discount percentage

**Files cần tạo:**
```
lib/utils/
  search_utils.dart
  filter_utils.dart
```

#### 4.4 Analytics & Notifications
**Công việc:**
- [ ] Track card usage statistics
- [ ] Promo expiry notifications
- [ ] Firebase Cloud Messaging (FCM)

---

### **PHASE 5: Polish & Deployment (1 tuần)**

#### 5.1 UI/UX Enhancement
**Công việc:**
- [ ] Responsive design (mobile, tablet)
- [ ] Dark theme support
- [ ] Animations & transitions
- [ ] Better error messages
- [ ] Loading skeletons

#### 5.2 Testing
**Công việc:**
- [ ] Unit tests cho models & utilities
- [ ] Widget tests cho UI components
- [ ] Integration tests cho auth flow

**Folder:**
```
test/
  unit/
  widget/
  integration/
```

#### 5.3 Build & Deployment
**Công việc:**
- [ ] Build APK for Android
- [ ] Build IPA for iOS
- [ ] Firebase Hosting setup (optional)
- [ ] App signing & versioning
- [ ] Release notes
- [ ] Google Play Store / App Store submission

---

## 📦 DEPENDENCIES CẦN THÊM

```yaml
# State Management
provider: ^6.0.0

# Navigation
go_router: ^13.0.0

# Local Storage
hive: ^2.2.3
hive_flutter: ^1.1.0

# Validation & Utilities
intl: ^0.19.0

# Notifications
firebase_messaging: ^14.7.0

# Offline Support (Optional)
connectivity_plus: ^5.0.0

# Testing
flutter_test:
  sdk: flutter
```

---

## 🚀 HÀNH ĐỘNG CÓ THỨ TỰ

### Ngày 1-2: Foundation
- [ ] Thêm dependencies
- [ ] Tạo models
- [ ] Setup providers

### Ngày 3-4: Auth UI
- [ ] Hoàn thành login form
- [ ] Tạo signup page
- [ ] Setup routing

### Ngày 5-7: Core Features
- [ ] Home page
- [ ] Add/View/Edit card
- [ ] Promotional programs

### Ngày 8-9: User Management
- [ ] Profile page
- [ ] Local storage
- [ ] Search & filter

### Ngày 10: Polish
- [ ] UI improvements
- [ ] Testing
- [ ] Deployment prep

---

## 📝 GHI CHÚ

- **Database**: Firestore
- **Authentication**: Firebase Auth
- **State**: Provider package
- **Target Platforms**: Android & iOS
- **Min SDK**: 21 (Android), 12.0 (iOS)

---

**Last Updated**: April 6, 2026
