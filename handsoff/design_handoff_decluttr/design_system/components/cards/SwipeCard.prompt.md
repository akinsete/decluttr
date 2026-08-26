Full-bleed swipeable card: drag any direction, horizontal drag rotates + fades in KEEP/DELETE, release past 100px commits.

```jsx
<SwipeCard type="contact" contact={{ name: 'Maya Chen', phone: '(415) 555-0142', initials: 'MC', color: 'var(--accent-blue)' }} onSwipe={handleSwipe} />
<SwipeCard type="photo" photo={{ tag: 'Beach trip · IMG_0142', batchLabel: 'June 2026', gradient: 'var(--gradient-yellow-pink-160)' }} onSwipe={handleSwipe} />
```

Stack 2 more non-interactive placeholder cards behind it (scaled 0.96/0.92, translated down) to sell the deck. Only the top card gets `interactive`.
