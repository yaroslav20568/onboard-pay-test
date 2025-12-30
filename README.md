# OnboardPay

Flutter мобильное приложение с системой онбординга и подписок.

> ⚠️ **Тестовое задание**

---

## Архитектура

Простая архитектура с разделением ответственности:

- **Screens** — экраны приложения (UI слой)
- **Widgets** — переиспользуемые UI компоненты
- **Services** — бизнес-логика и работа с данными
- **Models** — модели данных
- **Constants** — константы (цвета, настройки)

**Управление состоянием:** `setState` для локального состояния, сервисы для глобального.

**Хранилище данных:** SharedPreferences для локального хранения на устройстве.

---

## Структура проекта

```
lib/
├── constants/          # Константы
│   ├── colors_const.dart
│   ├── subscription_const.dart
│   └── index.dart
├── models/             # Модели данных
│   ├── subscription.dart
│   └── index.dart
├── screens/            # Экраны приложения
│   ├── home_screen.dart
│   ├── onboarding_screen.dart
│   ├── paywall_screen.dart
│   └── index.dart
├── services/           # Сервисы
│   ├── subscription_service.dart
│   └── index.dart
└── widgets/            # Виджеты
    ├── home/           # Виджеты главного экрана
    ├── paywall/        # Виджеты экрана оплаты
    ├── ui/             # Базовые UI компоненты
    └── index.dart
```

---

# OnboardPay

Flutter mobile application with onboarding and subscription system.

> ⚠️ **Test Assignment**

---

## Architecture

Simple architecture with separation of concerns:

- **Screens** — application screens (UI layer)
- **Widgets** — reusable UI components
- **Services** — business logic and data operations
- **Models** — data models
- **Constants** — constants (colors, settings)

**State management:** `setState` for local state, services for global state.

**Data storage:** SharedPreferences for local storage on device.

---

## Project Structure

```
lib/
├── constants/          # Constants
│   ├── colors_const.dart
│   ├── subscription_const.dart
│   └── index.dart
├── models/             # Data models
│   ├── subscription.dart
│   └── index.dart
├── screens/            # Application screens
│   ├── home_screen.dart
│   ├── onboarding_screen.dart
│   ├── paywall_screen.dart
│   └── index.dart
├── services/           # Services
│   ├── subscription_service.dart
│   └── index.dart
└── widgets/            # Widgets
    ├── home/           # Home screen widgets
    ├── paywall/        # Paywall screen widgets
    ├── ui/             # Basic UI components
    └── index.dart
```
