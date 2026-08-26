Colored rounded-square (or circular) tile holding an icon or initials — the leading visual on nearly every row and card.

```jsx
<IconTile size={52} background="rgba(255,255,255,0.55)" icon={<PersonIcon />} />
<IconTile size={120} shape="circle" background="var(--accent-blue)" icon={<span style={{fontSize:40,fontWeight:800}}>MC</span>} />
```

Background is usually a flat accent color or `rgba(255,255,255,0.5–0.55)` sitting on top of an already-colored parent card. Use `shape="circle"` for avatars/streak numerals; `shape="square"` (default) for everything else.
