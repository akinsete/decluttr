# Decluttr — Design System (Flutter)

This maps the shipped prototype's visual language to a Flutter implementation targeting **iOS and Android together** (one codebase, simultaneous launch). **Ground-truth values** are the exact hex/px/easing used in the prototype (`/prototype/Declutter.dc.html`) and mirrored in `/design_system/tokens/*.css`. Build a central `theme/` package and reference tokens everywhere — never hard-code colors/sizes in widgets.

**Font:** Plus Jakarta Sans (weights 400/500/600/700/800). Add via `google_fonts` (`GoogleFonts.plusJakartaSans...`) or bundle the TTFs. It is the single family for the whole app.

---

## 1. Colors → `AppColors`

```dart
class AppColors {
  // Backgrounds & surfaces
  static const canvas       = Color(0xFFFBF6ED); // app background, warm off-white
  static const canvasAlt    = Color(0xFFFAF7F2); // most screen backgrounds in the prototype
  static const surfaceCard  = Color(0xFFF4EEE2); // neutral card fill
  static const white        = Color(0xFFFFFFFF);
  static const divider      = Color(0x141A1A1A); // rgba(26,26,26,.08)

  // Ink (secondary text = ink at fractional opacity — never a separate gray)
  static const ink          = Color(0xFF1A1A1A);
  static Color inkA(double a) => ink.withOpacity(a); // use .65 / .55 / .45 / .35

  // Pastel accents — each carries product meaning
  static const blue     = Color(0xFF8FD0FF); // Contacts
  static const pink     = Color(0xFFFF9EC0); // Photos & Videos
  static const pinkHot  = Color(0xFFF84F93); // active pink used across the app UI
  static const lavender = Color(0xFFCBB8FF);
  static const yellow   = Color(0xFFFFD666);
  static const mint     = Color(0xFFA9E4B8);

  // Semantic
  static const success       = Color(0xFF4CAF6B);
  static const successText    = Color(0xFF2E8B4F);
  static const destructive   = Color(0xFFE85B4D); // buttons, KEEP/DELETE stamp
  static const destructiveStrong = Color(0xFFC0392B); // danger-zone
  static const destructiveText   = Color(0xFFA83A2E); // inline errors
  static const iosSystemBlue = Color(0xFF0B84FF); // native alert "OK" only
}
```

> Note: the prototype's card/UI code uses `pinkHot #F84F93` for interactive pink (chevrons, accents, streak) while the softer `pink #FF9EC0` is a gradient stop. Keep both.

### Gradients → `AppGradients`
Big/floating cards use a 135–160° two-stop pastel gradient; small tiles/pills stay flat.

```dart
LinearGradient hero() => const LinearGradient(
  begin: Alignment.topLeft, end: Alignment.bottomRight, // ~145deg
  colors: [Color(0xFFFFD666), Color(0xFFFF9EC0), Color(0xFFCBB8FF)],
  stops: [0, .48, 1]);
// Home cards: contacts = [#E9F3FF,#CFE6FF]; photos = [#FFF0F6,#FBD3E4]
// Progress ring: [#5C9BFF,#FF6FA8]
```
Batch/trash tiles cycle a palette of soft two-stop gradients — see `tokens/colors.css` and the `batchColors`/`trashGrads` arrays in the prototype for the exact list.

---

## 2. Typography → `AppText` (TextTheme)

Compact scale for a ~402pt canvas. Line-heights are ratios; letter-spacing in logical px.

| Role | Size | Weight | Line | Tracking | Use |
|---|---|---|---|---|---|
| display | 28 | 800 | 1.18 | -0.4 | splash / big moments |
| h1 | 25–34 | 800 | 1.12–1.15 | -0.5 | screen titles (Home hero uses 32) |
| h2 | 20 | 800 | 1.2 | — | section titles |
| title | 17 | 700 | 1.3 | — | card titles, list headers |
| bodyStrong | 15 | 700 | 1.4 | — | emphasized body |
| body | 14.5 | 600 | 1.5 | — | default body |
| secondary | 13 | 600 | 1.5 | — | supporting text |
| caption | 12 | 700 | +0.4 | eyebrows (often UPPERCASE) |
| micro | 10.5 | 700 | — | badges, meta |

Secondary text = `AppColors.inkA(.45..65)`, not a gray. Casing: **sentence case** everywhere except tracked uppercase eyebrows and the KEEP/DELETE stamps.

---

## 3. Spacing → 8pt system

`4, 8, 12, 16, 20, 24, 32, 40, 48, 64`. Expose as `Insets.x1..x16` or a `Gap(n)` widget. Screen horizontal padding is typically 22–30; list rows padded 14–16. Use `Column/Row` + `SizedBox`/`Gap` for spacing (the CSS uses flex `gap`), never scattered margins.

---

## 4. Radius → `AppRadius`

```
xs 12 (small icon tiles) · sm 14 (inputs/chips) · md 16 · lg 18–20 (cards)
xl 22–24 (big cards) · 2xl 28 (pill buttons) · 3xl 32 (hero) · full 999 (avatars/dock/badges)
```
Rounded everywhere — **no sharp corners**. Primary buttons are true capsules (`BorderRadius.circular(height/2)`).

---

## 5. Elevation / shadows → `AppShadows`

Interface is mostly flat. Shadows are soft, low-contrast, and only for things that **float or are mid-interaction**. Static list rows and settings cards get **no shadow** — separation comes from the flat surface fill or a hairline divider.

```dart
// xs  back buttons      : 0 2 8   rgba(0,0,0,.06)
// sm  undo button       : 0 4 12  rgba(0,0,0,.08)
// md  swipe circ btns   : 0 6 16  rgba(0,0,0,.10)
// stack 2nd swipe card  : 0 10 20 rgba(0,0,0,.05)
// hero welcome card     : 0 18 40 rgba(0,0,0,.14)
// card-active top card  : 0 20 44 rgba(0,0,0,.18)
// dock                  : 0 10 28 rgba(0,0,0,.10)
// sheet                 : 0 -10 40 rgba(0,0,0,.20)
```

---

## 6. Motion → `AppMotion`

Spring-flavored easing throughout; **never linear**.

```dart
// standard (swipe-card spring-back): Cubic(.2,.8,.2,1)   ~ 0.32s
// bouncy   (dock pill indicator)   : Cubic(.34,1.4,.64,1) ~ 0.28s (slight overshoot)
// swift    (card→full-screen morph): Cubic(.25,1,.4,1)    ~ 0.38s
// durations: fast .20 · standard .28 · card .32 · morph .38
```
A tapped card should visually **grow into** its destination (shared-axis / container transform), not cross-fade. Press feedback: `scale(0.92)` on dock items; otherwise instant.

---

## 7. Blur / transparency
Reserved for exactly one place: the frosted-glass **bottom dock** — `BackdropFilter(blur ~20)` over `white.withOpacity(0.6)`. Not used for modals/overlays.

---

## 8. Iconography
All icons in the prototype are hand-drawn inline line icons: **2–2.6px stroke, rounded caps/joins**, no fills except small solid glyphs (streak flame, KEEP/DELETE stamps). For Flutter, use a lightly-rounded outline set restroked to ~2.4 (e.g. **Lucide** / **Phosphor "regular"** via `flutter_lucide` / `phosphor_flutter`) — flag as a substitution. No icon font mixing, **no emoji in UI** (a single ✓ glyph inline in status strings is the only exception).

---

## 9. Component → Widget map

The `/design_system/components/` folder documents 13 primitives (each has a `.jsx` reference, `.d.ts` prop types, and `.prompt.md` spec). Build each as a Flutter widget:

| DS component | Flutter widget | Notes |
|---|---|---|
| Button | `PrimaryButton` / `SecondaryButton` | Capsule; primary = ink or accent fill, secondary = surface/outline. Full-width on action screens. |
| IconButton | `AppIconButton` | Circular, white bg, `shadow-xs`, 40–48pt. |
| IconTile | `IconTile` | Rounded-square gradient/flat tile holding a line icon (list-row leading). |
| StatusPill | `StatusPill` | Small capsule badge (counts / "All caught up ✓"). |
| DashboardCard | `ModuleCard` | Home Contacts/Photos cards — gradient, leading art, title + status sub, chevron. |
| StreakCard | `StreakCard` | Fire art + "N Day Streak" + subtitle, tappable. |
| ProgressCard | `ProgressCard` | White card, progress ring/bar + stats. |
| SwipeCard | `SwipeCard` | Draggable card w/ KEEP/DELETE overlays; the core of the session. |
| Dock | `AppDock` | Frosted floating bottom nav, animated pill, 3 tabs. |
| EmptyState | `EmptyState` | Centered illustration + title + subtitle + optional action. |
| Banner | `Banner` | Dismissible nudge row. |
| Toggle | `AppToggle` | iOS-style switch (settings). |
| SegmentedControl | `SegmentedControl` | Trash Photos/Contacts tabs. |
| TextField | `AppTextField` | Rounded input (sign-in). |

Suggested widget tree: a `theme/` (colors, text, radius, shadows, motion) + `widgets/` (the primitives above) + `screens/` + `state/` (providers/repositories). See README.md for build order.

---

## 10. Voice & content
Short, warm, plain-spoken, second person. Reassure on every destructive action ("Purges in N days", "Restore", "nothing leaves your phone"). Prefer concrete counts over adjectives. See PRD §4 and `/design_system/README.md` "Content fundamentals".

---

## 11. Fidelity note
Token values here match the **shipped prototype**, which is slightly more precise than the original written brief (e.g. blue `#8FD0FF` vs brief `#8CCBFF`; font Plus Jakarta Sans vs brief SF Pro/Inter). Build to these values; flag if you'd rather realign to the original brief numbers.
