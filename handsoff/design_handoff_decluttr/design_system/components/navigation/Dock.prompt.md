Floating pill bottom nav — three items, frosted glass, spring-animated active indicator.

```jsx
<Dock active="home" onNavigate={(id) => setScreen(id)} showLabels={true} />
```

Position it `position: absolute; left: 50%; bottom: 24px; transform: translateX(-50%)` inside the device frame. Omit/hide entirely on Welcome, Signup, Permission, Swipe session, Summary, and Delete-account screens.
