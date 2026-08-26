# Swipe Declutter — Design System

**Swipe Declutter** is a mobile app for cleaning up a phone's Contacts and Photos libraries with a Tinder-style swipe gesture (right = keep, left = delete). One product for iOS and Android (built in Flutter, launching together), with a calm, playful, pastel visual language, with the warmth of a lifestyle app (think Apple Photos' craftsmanship, Things 3's simplicity, Gentler Streak's polish, Tinder's fluid card interactions).

## Sources this system was built from
- **The original written design brief** (pasted into chat — colors, type scale, spacing, radii, component list, motion principles). Not attached as a file; captured here as prose in "Content fundamentals" / "Visual foundations" below.
- **`Swipe Declutter.dc.html`** (project root) — the shipped, high-fidelity interactive prototype implementing that brief across all 12 screens. This is the **ground-truth source of exact values** (hex codes, px sizes, easing curves) used throughout this design system — see "A note on fidelity" below.
- **`design_handoff_swipe_declutter/`** (project root) — a companion hand-off bundle (`README.md`, screenshots, `assets/bucket.png`) written for an engineering team porting the prototype to Flutter. Useful background on every screen's behavior and state model.
- **`ios-frame.jsx`** (project root) — a decorative iPhone bezel/status-bar starter component used to present screens; copied into `ui_kits/swipe-declutter/` for this system's UI kit.

## A note on fidelity
The original brief specified a slightly different palette (e.g. blue `#8CCBFF`, pink `#F7A2C8`) and font (SF Pro Display / Inter) than what actually shipped in `Swipe Declutter.dc.html` (blue `#8FD0FF`, pink `#FF9EC0`, Plus Jakarta Sans). The shipped prototype is the more precise, realized version of the brief — this design system's tokens match the **shipped implementation**, not the original brief text. Flagged explicitly here per instructions; ask if you'd rather realign to the original brief numbers.

## Index
- `styles.css` — root stylesheet; `@import`s everything below. Link this one file to use the system.
- `tokens/` — `colors.css`, `typography.css`, `spacing.css`, `radius.css`, `shadows.css`, `motion.css`.
- `guidelines/` — 12 foundation specimen cards (colors, type, spacing, radius, shadow, motion, brand mark) shown in the Design System tab.
- `components/` — 13 reusable primitives in 5 groups:
  - `core/` — Button, IconButton, IconTile, StatusPill
  - `cards/` — DashboardCard, StreakCard, ProgressCard, SwipeCard *(all four named explicitly in the original brief's "Components" section)*
  - `navigation/` — Dock *(the brief's floating bottom nav)*
  - `feedback/` — EmptyState *(brief-named)*, Banner
  - `forms/` — Toggle, SegmentedControl, TextField
- `ui_kits/swipe-declutter/` — interactive recreation of 5 core screens (Home, Filter/batch picker, Swipe session, Session summary, Settings) built from the components above. See its own README for scope vs. the full prototype.
- `assets/bucket.png` — Home hero illustration (placeholder quality; ask for a final asset before shipping).
- `SKILL.md` — Claude Code-compatible skill wrapper for this system.

## Intentional additions
The brief explicitly names Dashboard Card, Streak Card, Progress Card, Swipe Card, the bottom Dock, and Empty States as components. Button, IconButton, IconTile, StatusPill, Toggle, SegmentedControl, TextField, and Banner aren't named directly but are the necessary primitives the named components and screens are built from (buttons, list-row icon tiles, status badges, form controls, dismissable nudge rows) — added so the system is actually usable, not just documented.

## Content fundamentals
- **Voice**: short, warm, plain-spoken. "Clean up your contacts and photos, one swipe at a time." / "Nothing leaves your phone." — reassuring about privacy and reversibility, never salesy.
- **Casing**: sentence case everywhere (buttons, headings, labels) — never title case or all-caps, except small uppercase eyebrows (section labels like "PERMISSIONS", tracked +0.4px) and the KEEP/DELETE swipe stamps.
- **Person**: second person ("your contacts and photos"), first person plural implied ("we need access…").
- **No emoji** in copy — a single ✓ checkmark glyph appears inline in status strings ("All caught up ✓"), that's the extent of it.
- **Reassurance pattern**: destructive actions are always paired with a reversibility note ("Purges in N days", "Restore", "nothing leaves your phone", 30-day trash window) — never present delete as irreversible without saying so.
- **Numbers over adjectives**: status subtext prefers concrete counts ("128 left to review") over vague copy ("Some contacts need review").

## Visual foundations
- **Palette**: warm off-white canvas (`#FBF6ED`) + near-black ink (`#1A1A1A`) + five pastel accents (blue/pink/yellow/mint/lavender), each carrying product meaning (blue=Contacts, pink=Photos) rather than being decorative. Secondary text is never a separate gray hex — always ink at a fractional alpha (35–65%).
- **Gradients over flat fills**: any "big" card (hero, streak tile, permission icon, summary checkmark) uses a 145°/160° two-stop pastel gradient rather than a solid color; small tiles/pills stay flat.
- **Corners**: rounded everywhere, no sharp corners at all. Buttons are always a true capsule (radius = height/2). Cards run 16–32px. Avatars/dock/badges are full circles/capsules.
- **Shadows**: soft and low-contrast only, reserved for things that float or are mid-interaction (the active swipe card, circular buttons, the dock, a modal/sheet). Static list rows and settings cards carry **no shadow** — separation comes from a flat surface-card fill or a hairline divider instead.
- **Motion**: spring/cubic-bezier easing only, never linear or default ease. Three named curves: standard (swipe-card release), bouncy (dock indicator, slight overshoot), swift (card→full-screen morph). A tapped card should visually grow into its destination screen rather than the destination fading in over it.
- **Backgrounds**: no photography, no textures/patterns. Imagery is either a CSS gradient placeholder (photo cards) or a single soft illustration (`bucket.png` on Home).
- **Hover/press**: this is a touch-first app — no hover states designed; press states are a slight `scale(0.92)` on dock items, otherwise instant.
- **Density**: generous whitespace, one primary action per screen, list rows padded 14–16px. Nothing feels cramped even on a 402px-wide canvas.
- **Blur/transparency**: reserved for exactly one place — the frosted-glass bottom dock (`blur(20px) saturate(180%)` over `rgba(255,255,255,0.6)`). Not used elsewhere (no blurred modals/overlays).

## Iconography
All icons are hand-drawn inline SVG line icons (2–2.6px stroke, rounded caps/joins, no fills except small solid glyphs like the streak flame or KEEP/DELETE stamps) — there is no icon font or sprite sheet in the source material. No emoji in the interface. When building with this system, keep new icons at the same stroke weight; if you need a bigger set than what's here, the closest CDN match would be a lightly-rounded outline set (Phosphor "regular" or Lucide) restroked to ~2.4px — flagged as a substitution if you go that route, not yet done here.

## Caveats / ask
- No real logo file was supplied — `guidelines/brand-mark.html` uses a plain "SD" monogram tile; swap in a real mark if one exists.
- `assets/bucket.png` is placeholder-quality per the original hand-off notes; ask for a final illustration/vector.
- Color/type values here match the **shipped prototype**, not the original written brief numbers — flag if you'd rather realign.
- The UI kit covers 5 of the prototype's 12 screens (the "core loop"); say the word if you want Welcome/Signup/Permission/Trash/Delete-account added too.
