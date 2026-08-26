Full-width (or inline) pill button — the only button shape in the app; radius is always height/2.

```jsx
<Button variant="primary" onClick={submit}>Create account</Button>
<Button variant="secondary" onClick={cancel}>Cancel</Button>
<Button variant="danger" size="lg" onClick={confirmDelete}>Delete my account</Button>
<Button variant="ghost" fullWidth={false} onClick={showMore}>Preview error states ›</Button>
```

- `variant="primary"` is the default screen CTA (black fill, white text).
- `variant="secondary"` pairs with primary as a "Cancel"/"Back to Home" option (white, thin border).
- `variant="danger"` only in the danger-zone / delete-account flow.
- `variant="ghost"` is a plain-text link, e.g. dev-only "Preview error states" affordances.
- Set `fullWidth={false}` for inline buttons like a "Save" chip inside a nudge card.
