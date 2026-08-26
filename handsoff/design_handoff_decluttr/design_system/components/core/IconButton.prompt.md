Circular icon-only button. Used for nav back/close chevrons and the swipe-session action row (undo, delete, keep).

```jsx
<IconButton size={36} icon={<ChevronLeftIcon />} onClick={goBack} />
<IconButton size={64} icon={<XIcon />} color="var(--destructive)" shadow="var(--shadow-md)" onClick={swipeLeft} />
<IconButton size={64} icon={<CheckIcon />} background="var(--text-primary)" color="#fff" shadow="var(--shadow-md)" onClick={swipeRight} />
```

Never go below 44px — the app's accessibility floor for touch targets.
