Home screen's top-level entry point into a module — big, colorful, fully tappable, ~120px tall.

```jsx
<DashboardCard
  background="var(--accent-blue)"
  icon={<PersonIcon />}
  title="Contacts"
  subtitle="128 left to review"
  onClick={openContacts}
/>
```

Stack 2–3 of these with `gap: 14px` on the Home screen. Subtitle should always reflect live state ("Tap to get started" / "N left to review" / "All caught up ✓").
