Circular kept/deleted progress ring shown on Home once the user has reviewed anything. Hide entirely if nothing's been reviewed yet.

```jsx
<ProgressCard keptCount={42} deletedCount={18} itemsRemaining={64} pct={0.62} />
```

Ring gradient is fixed (`--gradient-progress-ring`, blue → pink) regardless of module. Animate `pct` from 0 on first mount for the "fills in" load animation.
