# Decluttr — Product Requirements Document

**Version:** 1.0 · **Platform:** Flutter — iOS + Android (launching together) · **Status:** Ready for build

---

## 1. Summary

Decluttr is a mobile app for cleaning up a phone's **Contacts** and **Photos** libraries using a Tinder-style swipe gesture: **swipe right to keep, swipe left to delete**. The experience is fast, playful, and reassuring — nothing is ever deleted permanently on the first pass; everything routes through a 30-day Trash the user can restore from.

The product's core promise: *"Clean up your contacts and photos, one swipe at a time — nothing leaves your phone."*

**One product, one job.** Reduce the friction of tidying a phone from an hours-long chore to a series of 30-second sessions the user can do while waiting in line.

---

## 2. Goals & non-goals

### Goals
- Make decluttering **fast and satisfying** — a swipe deck, streaks, progress rings, and a confetti payoff on session completion.
- Make destructive actions **safe and reversible** — a 30-day Trash for both photos and contacts, undo on every swipe, and explicit "purges in N days" copy.
- **Privacy-first framing** — reinforce that processing happens on-device ("nothing leaves your phone").
- Handle **duplicate contacts** with a proper merge flow, not just keep/delete.
- Cover the **full lifecycle**: onboarding, permissions, the core swipe loop, batch organization, trash management, streaks/stats, settings, and error states.

### Non-goals (v1)
- No cloud backup / cross-device sync.
- No real account system beyond an optional sign-in stub (Premium upsell exists but billing is out of scope for this build).
- No desktop/web/tablet layouts — this is a phone app on a ~402pt-wide canvas.
- No social sharing of decluttering activity.

---

## 3. Target user

Anyone whose phone has drifted into chaos — thousands of photos, hundreds of stale or duplicate contacts — who has been putting off cleanup because the built-in tools feel like work. The app meets them with a low-commitment, game-like loop and constant reassurance that mistakes are recoverable.

---

## 4. Design principles

1. **Reversible by default.** Every delete goes to Trash first. Every swipe can be undone. Never present deletion as final without saying how to get it back.
2. **Numbers over adjectives.** Status copy prefers concrete counts ("11 waiting for you", "128 left to review") over vague phrasing.
3. **Calm, playful, pastel.** Warm off-white canvas, soft pastel accents, rounded everything, spring-based motion. Never harsh, never salesy.
4. **One primary action per screen.** Generous whitespace; the next step is always obvious.
5. **Touch-first.** No hover states; press states are a subtle `scale(0.92)`. Hit targets ≥ 44pt.
6. **Sentence case everywhere** except small tracked uppercase eyebrows and the KEEP/DELETE swipe stamps.

---

## 5. Core loop (the "one swipe at a time" experience)

```
Home → pick a batch (a photo month or a contact group)
     → Swipe session (right = keep, left = delete, tap = detail, undo available)
     → Session summary (confetti + kept/deleted counts)
     → back to batch picker (cleared batch disappears)
```

Deleted items land in **Trash**, where they can be restored or purged. Completing sessions builds a **streak** and feeds the **progress** stats on Home.

---

## 6. Feature list & requirements

### 6.1 Onboarding
- **Splash** (~2.2s animated logo cluster) → **Welcome** → **Get started** → **Walkthrough** (single "How it works" screen with a continuously animating demo card that swipes right=KEEP then left=DELETE, plus three hint rows: keep / delete / tap for detail) → **Home**.
- Permissions are **lazy**: the app does NOT ask for Contacts/Photos access up front. Access is requested the first time the user opens the corresponding Home card.
- Welcome screen shows the Decluttr logo wordmark. A small "Replay" affordance re-triggers the splash (review convenience; can be hidden in production).

### 6.2 Home
- Warm greeting that changes for first-time vs returning users ("Welcome 👋" / "Welcome back 👋").
- Hero heading: "Ready for a quick cleanup?"
- **Two module cards**: Contacts (blue) and Photos & Videos (pink). Each shows a status subtitle ("Tap to get started" first time, "N waiting for you" when there's activity).
- **Returning users** additionally see a **streak card** (tappable → Streak screen) and a **progress card**.
- Persistent frosted-glass **bottom dock**: Home · Trash · Settings, with an animated pill indicator.

### 6.3 Permissions
- Two dedicated permission screens (Contacts, Photos) with a floating illustration, a bulleted rationale, an "Allow access" primary button, and a "Not now" / "Maybe later" secondary.
- Granting proceeds to that library's batch picker; declining returns Home.
- "Allow access" maps to the native permission prompt on each platform (iOS's system dialog / Android's runtime permission request); a denied/limited state routes to the relevant **error state** (see 6.9).

### 6.4 Batch picker (organize)
- Photos are grouped by **month** (e.g. "May 2026 · 7"); contacts by **smart group** (Recently Added, No Phone Number, No Email, **Duplicates**, Old Contacts, Unknown Names, Work Contacts, Family & Friends).
- Each batch is a stacked pastel card showing a label + count; tapping starts a swipe session for that batch (except **Duplicates**, which opens the merge flow — see 6.7).
- When every batch in a tab is cleared, show the tab's **empty state**.

### 6.5 Swipe session
- Card deck of items. **Swipe right = keep, left = delete.** Live KEEP/DELETE stamps fade in as the card is dragged; release past a threshold commits, otherwise it springs back.
- **Tap a card** to open a detail sheet with explicit Keep / Delete buttons.
- Bottom controls: circular **Delete** (left) and **Keep** (right) buttons, plus **Undo**.
- Header: exit (back to batch picker), a progress bar, and an "N/total" counter.
- When the deck empties → **Session summary**.

### 6.6 Session summary
- Full-screen celebration: animated checkmark, **confetti** (rain + burst), and kept/deleted counts.
- Primary action returns to the batch picker; the just-finished batch is now removed from the list.

### 6.7 Duplicate contacts — merge review (important)
- Distinct from keep/delete. Each detected duplicate shows the **two source records** side by side (e.g. iPhone vs iCloud/Google/Work) with their phone/email, a reason chip ("Same phone number", "Same email address", "Similar name"), and an **"After merge" preview** of the combined record (union of phone + emails).
- Three actions per duplicate: **Merge** (combine into one), **Keep both** (not a duplicate), **Delete one** (remove the redundant copy).
- Progress indicator "N of M"; a completion state summarizes "X merged · Y kept · Z removed", then returns to the contacts batch picker with the Duplicates group cleared.

### 6.8 Trash
- Two tabs: **Photos** and **Contacts**. Photos shown as a grid grouped by month (with video badges + durations); contacts as list rows.
- Header shows count + reclaimable storage estimate for photos.
- **Select mode**: tap to multi-select, then **Restore** (with a confirm) or **Delete forever**. Long-press / first tap enters select mode.
- Every item notes it "purges in N days" (30-day window). Empty states for each tab ("Trash is empty").

### 6.9 Error states
A single error screen renders four variants (icon + title + message + primary/secondary actions):
- **Unable to load photos** — "Try again" / "Go home".
- **Unable to access contacts** — "Open Settings" / "Not now" (permission denied).
- **Something went wrong** — generic; "Try again" / "Go home".
- **Permission changed** — photo access changed in Settings; "Reconnect" / "Go home".

### 6.10 Streak & stats
- Streak screen: current streak (days), a week strip (hero), and a compact "Last 5 weeks" momentum heatmap (Less→More legend, today ringed).

### 6.11 Settings
- **Go Premium** upsell card.
- **Preferences**: Appearance (Light), **Haptic feedback** toggle, **Notifications** toggle (both functional).
- **Account**: sign in (opens a sign-in screen), and a danger-zone **Delete account**.
- Rate Decluttr / Share Decluttr rows.

---

## 7. State model (from the prototype)

The prototype is a single state machine keyed on `screen`. Key states and data:

- **Navigation:** `screen` ∈ splash, welcome, walkthrough, permContacts, permPhotos, batchPhotos, batchContacts, swipe, dupContacts, trash, streak, settings, signIn, error, plus the summary/empty sub-states.
- **Permissions:** `contactsGranted`, `photosGranted` (lazy).
- **Swipe:** `deck`, `total`, `kept`, `deleted`, drag `dx/dy`, `tutorialSeen`, undo `_history`, `swipeType`/`swipeBatchId`/`swipeOrigin`.
- **Batches:** `clearedPhotos`, `clearedContacts` maps mark completed batches; the Duplicates card uses key `dup`.
- **Duplicates:** `dupIndex`, `dupMerged`, `dupKept`, `dupDeleted`.
- **Trash:** `trashPhotos`, `trashContacts`, `photosCount`, `contactsCount`, `trashTab`, `selectMode`, `selected`, `showRestore`.
- **Prefs:** `hapticOn`, `notifOn`, `signedIn`.
- **Activity:** `hasActivity` drives first-time vs returning affordances.

> The Flutter build should model these as proper repositories/providers (see DESIGN_SYSTEM.md and README.md), backed by the platform's real Contacts/Photos APIs. The prototype's in-memory sample data (photo months, contact batches, duplicate groups, trash items) is illustrative — replace with live device data.

---

## 8. Success metrics (suggested)
- **Activation:** % of new users who complete ≥1 swipe session in the first sitting.
- **Depth:** median items reviewed per session; batches cleared per week.
- **Retention:** streak length distribution; D1/D7 return rate.
- **Safety:** restore rate from Trash (a proxy for "did we make deletion feel safe enough to use").

---

## 9. Open questions / assumptions
- **Auth & Premium:** sign-in and Premium are stubbed. Confirm the real auth provider and billing model before wiring.
- **Contacts merge semantics:** confirm exact field-union rules and how merges write back to the platform address book (and whether merges are themselves reversible).
- **Storage estimate:** the photos "reclaimable MB" is currently an estimate (~2.1 MB/item); replace with real per-asset sizes.
- **Assets:** brand wordmark ships as `assets/declutter-logo.svg`. Illustration/spark/confetti PNGs are included but were authored for the prototype — confirm final production art.

---

*This document describes intended product behavior. The bundled HTML prototype in `/prototype` is the ground-truth reference for exact look and interaction. See `SCREENS.md` for per-screen build specs and `DESIGN_SYSTEM.md` for the Flutter design system.*
