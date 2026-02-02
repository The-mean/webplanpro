# Smart Status v2.0 — Project Context & Technical Specification

## 1) PRODUCT OVERVIEW
**Product name:** Smart Status v2.0  
**Vision:** Smart Status v2.0 is a futuristic phone intelligence companion that visualizes device aging, performance age, and predictive stability signals through a calm, premium HUD interface. It helps users understand system health trends at a glance without sounding like a cleaner/booster.  
**Target audience:** Global, non-technical users who want a beautiful, trustworthy system health overview.  
**Monetization model:** Subscription (monthly / yearly). No backend required initially.

---

## 2) DESIGN PHILOSOPHY (VERY IMPORTANT)
- **Dark mode only.**
- **Futuristic HUD / system intelligence feel.**
- **Calm, analytical, premium** (not aggressive, not “booster/cleaner”).
- **Single accent color**: neon cyan.
- **Minimal text, wide spacing.**
- **Uppercase system labels** with tracking.
- **Screens feel like modules, not buttons.**
- **Glows are subtle and controlled.**

---

## 3) SCREEN INVENTORY (WITH PURPOSE)

### 1) Home Screen — “Smart Status v2.0”
- **Purpose:** Core system dashboard for free users.
- **Access:** Free.
- **Key components:** TopBar, StatusOrb, Score, StatusText, MetricGrid (Battery/Storage/Memory/CPU Temp), Bottom HUD nav.
- **Files:** `lib/features/home/home_screen.dart` + `lib/features/home/widgets/*`

### 2) Insights Screen — “SYSTEM INSIGHTS // V.4.0”
- **Purpose:** Pro-level system intelligence report.
- **Access:** Pro.
- **Key components:** TopBar, Phone Aging Meter, Digital DNA Profile, Predictive Insights, Footer system info.
- **Files:** `lib/features/insights/insights_screen.dart` + `widgets/*`

### 3) Time Capsule Screen — “TEMPORAL SCAN”
- **Purpose:** Time-based health coherence view (Pro).
- **Access:** Pro.
- **Key components:** Segmented time range, Health Coherence Orb map, Aging Vector, Trend chart, Footer status.
- **Files:** `lib/features/temporal_scan/temporal_scan_screen.dart` + `widgets/*`

### 4) Onboarding (3-step PageView)
- **Purpose:** Introduce value and set expectations before paywall.
- **Access:** Free.
- **Key components:** Orb/mini HUD card/trend card, PageIndicator, Continue/Get Started CTA, Skip.
- **Files:** `lib/features/onboarding/onboarding_screen.dart` + `widgets/*`

### 5) Main Paywall — “UNLOCK PRO INTELLIGENCE”
- **Purpose:** Primary conversion screen (monthly / yearly).
- **Access:** Free users only.
- **Key components:** Feature list, plan selection, CTA, footer links & disclaimer.
- **Files:** `lib/features/paywall/paywall_screen.dart` + `widgets/*`

### 6) Contextual Gate — “AUTHORIZE ADVANCED TEMPORAL INTELLIGENCE”
- **Purpose:** Locked-content gate shown when non-pro tries to access pro areas.
- **Access:** Free users only.
- **Key components:** Locked modules, protocol selection, CTA to paywall, footer links.
- **Files:** `lib/features/contextual_paywall/contextual_paywall_screen.dart` + `widgets/*`

---

## 4) CURRENT IMPLEMENTATION STATUS
All screens are **implemented UI-only** with **mock/static data** and **no backend**.

- **Home:** Implemented (UI-only).  
  - Notes: No routing connection yet; mock values only.
- **Insights:** Implemented (UI-only).  
  - Notes: Gating not enforced yet.
- **Time Capsule:** Implemented (UI-only).  
  - Notes: Folder name is `temporal_scan`, not `time_capsule`.
- **Onboarding:** Implemented (UI-only).  
  - Notes: onFinish/onSkip TODO.
- **Main Paywall:** Implemented (UI-only).  
  - Notes: No purchase wiring.
- **Contextual Gate:** Implemented (UI-only).  
  - Notes: CTA navigation TODO.

---

## 5) DESIGN SYSTEM & WIDGET KIT
There **MUST** be a **single design system** used everywhere.

### Theme tokens (single source of truth)
- **AppColors**
- **AppText**
- **AppSpacing**
- **AppShadows**

### Widget Kit Philosophy
Reusable UI components **must** live in a shared kit and **must not** be reimplemented per screen.

**Required shared components:**
- PrimaryActionButton
- SegmentedToggle
- StatusChip
- PlanSelectionCard
- LockedModuleCard
- SystemDivider (including dotted)
- PageIndicator
- DataUnitCard
- SubtleGridBackground

**Rule:**  
If a widget exists in the kit, feature screens **MUST NOT** reimplement it locally.

---

## 6) ROUTING & FEATURE GATING (CRITICAL)
**Routes (must exist):**
- `/home`
- `/insights` (PRO)
- `/timecapsule` (PRO)
- `/gate`
- `/paywall`
- `/onboarding`

**Gating logic:**
1. **Non-PRO** navigating to `/insights` or `/timecapsule` → redirect to `/gate`.  
2. `/gate` **INITIATE ACCESS** → `/paywall`.  
3. After successful purchase, return to the **original target** route.

**Single source of truth:**  
`EntitlementState` (isPro) must be centralized and used for routing decisions.

**Target preservation:**  
Gating must keep the intended target and return there after purchase success.

---

## 7) MONETIZATION FLOW
- **Contextual Gate** is an authorization layer, not a store page. It appears when locked content is accessed.
- **Main Paywall** is conversion-focused and should host plan selection + primary CTA.
- **Plans:** Monthly / Yearly.
- **Billing:** `in_app_purchase` (Android subscriptions).  
- **Backend:** Not required for initial launch.

---

## 8) NON-GOALS (IMPORTANT)
Do **NOT** do these yet:
- Real device stats integration (native channels)
- Backend services
- Heavy analytics or behavioral tracking
- New feature screens beyond the defined list
- Feature creep (cleaner/booster functionality)

---

## 9) NEXT DEVELOPMENT PHASES
**Phase 1 (P0): Routing + Feature Gating**  
- Add all required routes and target preservation.

**Phase 2 (P0/P1): Theme & Widget Kit consolidation**  
- Merge duplicate tokens and remove per-screen reimplementations.

**Phase 3: Subscription wiring**  
- Hook `in_app_purchase` to paywall and entitlement state.

**Phase 4: Store release polish**  
- QA for pixel alignment, localization, and performance.

---

## 10) AI AGENT INSTRUCTIONS
- This document is the **single source of truth**.
- **Do not redesign the UI.**
- **Do not introduce new widgets casually.**
- If deviation is required, **ask first**.
- Prioritize maintainability and MRR.
- Keep the HUD tone calm, premium, and analytical.
