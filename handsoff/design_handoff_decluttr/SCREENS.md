# Decluttr — Screen Specs

Per-screen build reference. Fidelity: **high** — the prototype (`/prototype/Declutter.dc.html`) has final colors, type, spacing, and interactions. Recreate pixel-faithfully in Flutter using the tokens in `DESIGN_SYSTEM.md`. Canvas ≈ 402 × 874 pt (iPhone). Backgrounds are `#FAF7F2` unless noted.

The prototype is a state machine keyed on a single `screen` value; each `<sc-if>` below is one route/screen. To preview any screen in the prototype, set the `startScreen` prop (Tweaks panel) — values noted per screen.

---

## 01 · Splash  `startScreen: splash`
- Full-screen `#FAF7F2`. Centered animated logo **cluster** (`assets/splash-cluster.png`) with sparks; runs ~2.2s then auto-advances to Welcome. A progress hint fills during the animation.
- Group fades/translates in (opacity + 12px rise). In production this is the launch screen.

## 02 · Welcome  `startScreen: welcome`
- Padding `124 26 40`. Headline stack: **Decluttr logo wordmark** (`assets/declutter-logo.svg`, ~150px wide) above "your digital life." (h1, 28px/800, ink).
- Supporting line + a primary **Get started** capsule → Walkthrough.
- A small "Replay" pill (top-right) re-runs the splash — review affordance; hide in production.

## Walkthrough · "How it works"  `startScreen: walkthrough`
- Padding `60 26 40`, centered. Title "How it works" (26/800).
- **Demo card** (190×236, radius 26) that continuously animates: swipes right showing a green **KEEP** stamp, returns, then swipes left showing a red **DELETE** stamp (`@keyframes walkDemo`/`walkKeepShow`/`walkDelShow`; ~ a 5s loop). A faded second card peeks behind it.
- Three centered **hint rows** (transparent — icon + text, NOT buttons): keep (swipe right) · delete (swipe left) · tap for detail.
- Primary button advances to Home; a skip/"Do it later" also finishes onboarding. Sentence-case button labels.

## Permission — Contacts  `startScreen: permContacts`
## Permission — Photos  `startScreen: permPhotos`
- Padding `92 30 40`, centered. Title "Allow access to your Contacts/Photos" (28/800).
- Floating illustration (`assets/perm-contacts.png` 320w / `perm-photos.png` 280w) with a gentle `declutterFloat` bob.
- Bulleted rationale rows (5px dot + 14px/600 ink text).
- Primary **Allow access** → the corresponding batch picker + sets `contactsGranted`/`photosGranted`. Secondary **Not now / Maybe later** → Home.
- Requested **lazily** the first time a Home card is opened, not during onboarding. Map "Allow access" to each platform's native permission prompt (iOS system dialog / Android runtime request); denied/limited → Error state (contacts→`errContacts`, photos→`errPermission`).

## 03 · Home  `startScreen: home` (returning) — first-time via onboarding
- Scroll, padding `78 24 128` (128 bottom clears the dock), `gap 18`.
- Eyebrow greeting (12/700, `pinkHot`): "Welcome 👋" (first) / "Welcome back 👋" (returning).
- Hero h1 (32/700, -0.6 tracking): "Ready for a quick **cleanup?**" (accent on "cleanup?").
- Sub (12/500, ink .43): "Swipe through photos and contacts in minutes."
- **Streak card** (returning only): `#FFF6FA` fill, `#F6DCEA` border, radius 18 — fire art + "4 Day Streak" + "Keep your momentum going!" + chevron → Streak.
- **Contacts card**: gradient `#E9F3FF→#CFE6FF`, radius 22, `card-contacts.png` leading, title "Contacts", sub ("Tap to get started" / "11 waiting for you"), white circle chevron. → opens Contacts (permission if not granted).
- **Photos card**: gradient `#FFF0F6→#FBD3E4`, "Photos & Videos", sub ("Tap to get started" / "95 waiting for you"). → opens Photos.
- **Progress card** (returning only): white, radius 24, soft shadow — "Your progress" + ring/bar + stats.
- **Bottom dock** (all screens with nav): frosted glass, Home · Trash · Settings, animated pill (`dockPillOffset = index*62`), active icon white / inactive `#B7ADA4`, press `scale(0.92)`.

## Batch picker — Photos  `startScreen: emptyPhotos` shows the empty variant
## Batch picker — Contacts  `startScreen: emptyContacts` shows the empty variant
- Scroll, padding `74 22 128`, `gap 20`. Header title + back.
- **Photos**: months as stacked pastel cards ("May 2026 · 7"), each `batchColors[i]` gradient, overlap `-28px` after the first, tap → swipe session for that month. Sample months in the prototype (`photoMonths`) — replace with real device data.
- **Contacts**: smart groups (`contactBatches`): Recently Added 18 · No Phone Number 12 · No Email 9 · **Duplicates 7** · Old Contacts 24 · Unknown Names 5 · Work Contacts 16 · Family & Friends 21. Tapping a normal group → swipe session; tapping **Duplicates** → the merge flow (`dupContacts`).
- When all batches in a tab are cleared → the tab's **empty state** (illustration + "all caught up" copy).

## Swipe session  `startScreen: swipe`
- Padding `64 22 30`, column. Header: exit (← back to picker), progress bar, "N/total" counter.
- **Card stack**: up to 3 cards visible. Top card draggable (pointer events → `dx/dy`). Transform `translate(dx,dy) rotate(dx/18deg)`; while dragging no transition, on release `transform .34s Cubic(.2,.8,.2,1)`.
  - **KEEP** stamp opacity = `clamp(dx/110)`, **DELETE** = `clamp(-dx/110)`.
  - Release `dx > 110` → keep; `dx < -110` → delete; small movement → open **detail sheet**. Commit flies the card to ±620px over 260ms, then pops the deck.
- Sample item deck (`photoDeck`): IMG_0142…0147 with title/sub/gradient. Real build: bind to the selected batch's assets.
- Bottom controls: circular **Delete** (left, `destructive`), **Keep** (right, `success`), and **Undo** (restores last card + decrements counts).
- **Tutorial overlay** first session only (`tutorialSeen`) — dismissible hint.
- **Detail sheet**: tap a card → sheet with the item enlarged + explicit Keep / Delete.
- Deck empties → **Session summary**.

## Session summary (deck empty in `swipe`)
- Full-screen celebration: animated **checkmark**, **confetti rain** (`assets/confetti/c1..c8.png`, `confettiFall`) + **burst** around the checkmark (`confettiPop`), kept/deleted counts.
- Primary → back to batch picker; the finished batch is marked cleared (`clearedPhotos`/`clearedContacts[id]=true`) and removed from the list.

## Duplicate contacts — merge review  `startScreen: dupContacts`
- Scroll, padding `64 22 40`, `gap 18`. Progress "N of M" + bar.
- **Header identity**: gradient avatar w/ initial, name, reason chip ("Same phone number" / "Same email address" / "Similar name").
- **Two source records** side by side, each labeled by source (iPhone / iCloud / Google / Work) with phone + email.
- **"After merge" preview** card: union — merged phone (first non-empty) + deduped emails list.
- Three actions: **Merge** · **Keep both** · **Delete one** — each advances to the next duplicate (`dupIndex++`) and increments `dupMerged`/`dupKept`/`dupDeleted`.
- Sample groups in `dupContactGroups` (Emily Carter, Marcus Bell, Sofia Nguyen, David Park). Completion → summary "X merged · Y kept · Z removed" → back to contacts picker with Duplicates cleared.
- **Merge semantics to confirm** with product: exact field-union rules + how/whether merges are written back to and reversible in the platform address book.

## 10 · Trash  `startScreen: trash` · empty via `startScreen: emptyTrash`
- Column, header count + reclaimable storage (photos: `photosCount`, ~2.1 MB/item estimate — replace with real sizes).
- **Segmented control**: Photos | Contacts (`trashTab`).
- **Photos tab**: grid grouped by month; video items show a badge + duration (e.g. 0:18). **Contacts tab**: list rows (avatar initial, name, detail).
- **Select mode**: first tap enters select mode; multi-select with a green check ring on selected tiles. Actions: **Restore** (opens confirm sheet → removes from trash) and **Delete forever** (clears selection, or whole tab if none selected).
- Every item: "purges in N days" (30-day window). Empty per-tab state: "Trash is empty".

## 12 · Streak  `startScreen: streak`
- Scroll, padding `52 26 34`. Top bar (back).
- **Week strip** hero (current streak, days of week with completed markers).
- **"Last 5 weeks"** momentum heatmap card: cells shaded by activity, **Less → More** legend, **today ringed**.

## 13 · Settings  `startScreen: settings`
- Scroll, padding `64 22 128`, `gap 22`.
- **Go Premium** upsell card (gradient).
- **Preferences** group: Appearance → Light; **Haptic feedback** toggle (`hapticOn`); **Notifications** toggle (`notifOn`). Value labels 13px, row labels 13px/600.
- **Account** group: Sign in (→ Sign In screen); danger-zone **Delete account** (`destructiveStrong`).
- Rate Decluttr · Share Decluttr rows.

## Sign In  `startScreen: signIn`
- Padding `56 28 34`. Back (circular white). Title + rounded text fields (email/password) + primary **Sign in** (sets `signedIn`, returns to Settings). Sentence-case labels.

## Error states  `startScreen: errPhotos | errContacts | errGeneric | errPermission`
Single screen, four variants. Centered: 100px circle `#FFEDE7` with a `#FF7A59` line icon (photos/contacts/generic/permission), title (25/800), message, primary + secondary buttons.
- **errPhotos** — "Unable to load photos" / photos icon / "We couldn't load your photo library. Check your connection and try again." · Try again · Go home.
- **errContacts** — "Unable to access contacts" / contacts icon / "Decluttr doesn't have permission to read your contacts. Enable access in Settings to continue." · Open Settings (→ Settings) · Not now.
- **errGeneric** — "Something went wrong" / triangle icon / "An unexpected error occurred. Please try again in a moment." · Try again · Go home.
- **errPermission** — "Permission changed" / shield icon / "Photo access was changed in Settings. Reconnect to keep decluttering." · Reconnect · Go home.

---

## Navigation summary

```
splash → welcome → walkthrough → home
home ─┬─ contacts card → [permContacts if !granted] → batchContacts ─┬─ group → swipe → summary → batchContacts
      ├─ photos card   → [permPhotos if !granted]   → batchPhotos   ─┴─ month → swipe → summary → batchPhotos
      │                                              (Duplicates group → dupContacts → summary → batchContacts)
      ├─ streak card → streak
      └─ dock → {home, trash, settings}
settings → signIn ; settings → (delete account)
any load failure → error (errPhotos|errContacts|errGeneric|errPermission)
```
