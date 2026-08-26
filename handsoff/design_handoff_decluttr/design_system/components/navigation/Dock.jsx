import React from 'react';

export function Dock({ active = 'home', onNavigate, showLabels = true }) {
  const items = [
    { id: 'home', label: 'Home', icon: <path d="M4 11.5L12 4l8 7.5M6 10v9a1 1 0 0 0 1 1h4v-5h2v5h4a1 1 0 0 0 1-1v-9" /> },
    { id: 'trash', label: 'Trash', icon: <path d="M5 7h14M9 7V5a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2M7 7l1 12a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1l1-12M10 11v6M14 11v6" /> },
    { id: 'settings', label: 'Settings', icon: <path d="M12 3v2M12 19v2M4.2 4.2l1.4 1.4M18.4 18.4l1.4 1.4M3 12h2M19 12h2M4.2 19.8l1.4-1.4M18.4 5.6l1.4-1.4M12 12m-3 0a3 3 0 1 0 6 0a3 3 0 1 0 -6 0" /> },
  ];
  const itemWidth = showLabels ? 80 : 56;
  const activeIndex = items.findIndex((i) => i.id === active);

  return (
    <div style={{
      display: 'inline-flex', padding: 6, borderRadius: 32, background: 'rgba(255,255,255,0.6)',
      backdropFilter: 'blur(20px) saturate(180%)', WebkitBackdropFilter: 'blur(20px) saturate(180%)',
      border: '1px solid rgba(255,255,255,0.6)', boxShadow: 'var(--shadow-dock)', fontFamily: 'var(--font-sans)',
    }}>
      <div style={{ position: 'relative', display: 'flex' }}>
        <div style={{
          position: 'absolute', top: showLabels ? 0 : 2, left: 0, width: itemWidth,
          height: showLabels ? '100%' : itemWidth - 4, borderRadius: showLabels ? 24 : (itemWidth - 4) / 2,
          background: 'rgba(26,26,26,0.08)', transform: `translateX(${activeIndex * itemWidth}px)`,
          transition: 'transform 0.38s var(--ease-spring-bouncy)',
        }} />
        {items.map((item) => {
          const isActive = item.id === active;
          const color = isActive ? 'var(--text-primary)' : 'rgba(26,26,26,0.4)';
          return (
            <button
              key={item.id}
              onClick={() => onNavigate && onNavigate(item.id)}
              style={{ all: 'unset', boxSizing: 'border-box', position: 'relative', width: itemWidth, padding: showLabels ? '9px 6px 8px' : '13px 6px', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 3, cursor: 'pointer' }}
            >
              <span style={{ display: 'flex', opacity: isActive ? 1 : 0.55, color }}>
                <svg width={showLabels ? 19 : 22} height={showLabels ? 19 : 22} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">{item.icon}</svg>
              </span>
              {showLabels && <span style={{ fontSize: 10.5, fontWeight: 700, color }}>{item.label}</span>}
            </button>
          );
        })}
      </div>
    </div>
  );
}
