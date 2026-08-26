# Handoff: Decluttr — Flutter mobile app

## Overview
**Decluttr** is a mobile app for cleaning up a phone's Contacts and Photos libraries with a Tinder-style swipe (right = keep, left = delete), with a safe 30-day Trash, a duplicate-contacts merge flow, streaks, and stats. This bundle is a complete handoff for building it in **Flutter** (iOS + Android, launching together from one codebase).

## About the design files
The files in `/prototype` are a **design reference created in HTML** — a high-fidelity, fully-interactive prototype that shows the intended look and behavior. **They are not production code to copy.** Your task is to **recreate these designs natively in Flutter**, using idiomatic Flutter patterns (widgets, `ThemeData`, a state-management solution, and the real platform Contacts/Photos APIs). Treat the HTML as the source of truth for pixels and interactions; treat this project's real device data as the source of truth for content.

## Fidelity
**High-fidelity.** Colors, typography, spacing, radii, shadows, and interactions are final. Rebuild the UI faithfully using the tokens in `DESIGN_SYSTEM.md`. Where the prototype uses placeholder/sample data (photo months, contact groups, duplicate pairs, trash items), replace it with live device data.

## What's in this bundle
```
flutter_handoff_decluttr/
├── README.md            ← you are here (start here)
├── PRD.md               ← product requirements: goals, features, state model, metrics
├── DESIGN_SYSTEM.md     ← Flutter-mapped design system (AppColors/AppText/etc + widget map)
├── SCREENS.md           ← per-screen build spec (layout, copy, interactions, routes)
├── assets/              ← production image assets (logo svg, illustrations, confetti, art)
├── design_system/       ← the source design system this was built from
│   ├── README.md        ← full design-system rationale, voice, visual foundations
│   ├── styles.css       ← root stylesheet importing all tokens
│   ├── tokens/          ← colors / typography / spacing / radius / shadows / motion (CSS vars = ground truth)
│   ├── components/      ← 13 primitives, each with .jsx reference + .d.ts prop types + .prompt.md spec
│   └── guidelines/      ← 12 foundation specimen cards (color/type/spacing/etc)
└── prototype/           ← the interactive HTML prototype (open Declutter.dc.html in a browser)
    ├── Declutter.dc.html
    ├── app/assets/…     ← the images the prototype loads
    └── (support.js, ios-frame.jsx, image-slot.js — runtime for the prototype)
```

### How to run the prototype
Open `prototype/Declutter.dc.html` in a modern browser (Chrome/Safari). The **Tweaks** panel exposes a `startScreen` prop — set it to jump straight to any screen (values are listed per screen in `SCREENS.md`, e.g. `swipe`, `trash`, `dupContacts`, `errContacts`, `emptyTrash`). This is the fastest way to inspect exact spacing/colors/behavior of each state.

## Recommended Flutter setup
- **Min targets:** iOS 15+ and Android 8+ shipped together (confirm exact versions with product). Build platform-agnostic; use `Platform.isIOS` only where a native affordance genuinely differs (permission prompts, switch styling).
- **State management:** `riverpod` (or `bloc` if the team prefers) — the app is a clean state machine (see PRD §7).
- **Font:** `google_fonts` → Plus Jakarta Sans (400/500/600/700/800).
- **Platform data:**
  - Contacts: `flutter_contacts` (read, merge/write-back, delete).
  - Photos: `photo_manager` (asset listing by month, thumbnails, delete → OS trash) + `permission_handler`.
  - Haptics: `HapticFeedback` (gated by the Settings toggle).
- **Icons:** `lucide_icons` or `phosphor_flutter` restroked to ~2.4 (see DESIGN_SYSTEM §8) — flagged substitution for the prototype's hand-drawn line icons.
- **Motion:** `animations` package (container transform for card→fullscreen), custom `Cubic` curves from DESIGN_SYSTEM §6.

### Suggested project structure
```
lib/
├── main.dart
├── theme/           # app_colors.dart, app_text.dart, app_radius.dart, app_shadows.dart, app_motion.dart, insets.dart
├── widgets/         # the 13 primitives → PrimaryButton, ModuleCard, SwipeCard, AppDock, EmptyState, …
├── screens/         # splash, welcome, walkthrough, permissions, home, batch_picker, swipe, summary,
│                    #   duplicates, trash, streak, settings, sign_in, error
├── state/           # providers + repositories (contacts, photos, trash, streak, prefs)
└── models/          # PhotoAsset, ContactRecord, DuplicateGroup, TrashItem, Batch
```

## Suggested build order
1. **Theme package** (`theme/`) from `DESIGN_SYSTEM.md` + `design_system/tokens/`. Verify against a couple of screens before going further.
2. **Primitives** (`widgets/`) from the design-system component specs.
3. **Core loop**: Home → Batch picker → Swipe session → Summary → Trash. This is the product's spine.
4. **Duplicate merge** flow (contacts). Confirm merge/write-back semantics first (PRD §9).
5. **Onboarding** (splash → welcome → walkthrough) + **lazy permissions**.
6. **Streak/stats**, **Settings**, **Sign in**, **Error states**.
7. Wire **real device data** everywhere sample data currently sits.

## Interactions & behavior (highlights — full detail in SCREENS.md)
- **Swipe:** drag threshold ±110px; live KEEP/DELETE stamp opacity = `clamp(|dx|/110)`; commit animates card off-screen (±620px, 260ms) then advances the deck; **undo** restores the last card.
- **Motion:** spring curves only (never linear); tapped cards **grow into** their destination (container transform), not cross-fade.
- **Reversibility:** deletes go to a 30-day **Trash**; restore + delete-forever with confirm; "purges in N days" copy on every trashed item.
- **Permissions are lazy:** requested on first use of a Home card, not during onboarding. Denials route to the matching **error state**.

## State management
See **PRD §7** for the full state model (navigation, permissions, swipe deck + undo history, cleared-batch maps, duplicate counters, trash selection, prefs). Model these as repositories/providers backed by the platform APIs.

## Design tokens
Exact values live in **DESIGN_SYSTEM.md** (Dart-ready) and **`design_system/tokens/*.css`** (ground-truth CSS variables). Colors, type scale, 8pt spacing, radius scale, shadow scale, and motion curves are all enumerated there.

## Assets
`/assets` contains the production images: `declutter-logo.svg` (wordmark), `card-contacts.png` / `card-photos.png` (Home module art), `perm-contacts.png` / `perm-photos.png` (permission illustrations), `streak-fire.png` / `streak-badge.png`, `spark-1..3.png`, `splash-cluster.png`, `empty-*.png` / `trash-empty.png` / `welcome-trash.png` (empty-state art), and `confetti/c1..c8.png` (summary celebration). These were authored for the prototype — confirm final production art with design (per PRD §9). Add them to `pubspec.yaml` under `flutter: assets:`.

## Files to reference
- `prototype/Declutter.dc.html` — the complete interactive prototype (all screens + logic). This is the ground-truth reference.
- `design_system/components/**/*.prompt.md` — per-component specs.
- `design_system/README.md` — voice, content rules, and visual foundations.

## Notes & open questions
- **Brand assets** are original to this project — no third-party brand system involved.
- Auth, Premium/billing, exact contact-merge write-back rules, and real per-photo storage sizes are **open** — see PRD §9. Confirm before implementing those paths.
- Token values match the **shipped prototype**, which is slightly more precise than the original written brief — see the fidelity note in `design_system/README.md`.

*A developer who wasn't in the original conversation should be able to build the app from this bundle alone: start with the PRD, then DESIGN_SYSTEM, then SCREENS, referencing the prototype for anything ambiguous.*
