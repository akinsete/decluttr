import React from 'react';

const TONES = {
  dark: { background: 'var(--text-primary)', color: '#fff', sub: 'rgba(255,255,255,0.65)', iconBg: 'rgba(255,255,255,0.14)' },
  gradient: { background: 'var(--gradient-blue-lavender)', color: 'var(--text-primary)', sub: 'rgba(26,26,26,0.6)', iconBg: 'rgba(255,255,255,0.5)' },
  warning: { background: 'var(--warning-bg)', color: 'var(--warning-text)', sub: 'var(--warning-text)', iconBg: 'transparent' },
  neutral: { background: 'var(--surface-card)', color: 'var(--text-primary)', sub: 'var(--text-secondary-50)', iconBg: 'var(--gradient-blue-lavender)' },
};

export function Banner({ tone = 'dark', icon, title, subtitle, onClick, onDismiss }) {
  const t = TONES[tone] || TONES.dark;
  return (
    <div
      onClick={onClick}
      style={{
        cursor: onClick ? 'pointer' : 'default', boxSizing: 'border-box', width: '100%',
        background: t.background, borderRadius: 'var(--radius-xl)', padding: '15px 16px',
        display: 'flex', alignItems: 'center', gap: 14, fontFamily: 'var(--font-sans)',
      }}
    >
      {icon && (
        <div style={{ width: 44, height: 44, borderRadius: 'var(--radius-md)', background: t.iconBg, flexShrink: 0, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
          {icon}
        </div>
      )}
      <div style={{ flex: 1, minWidth: 0 }}>
        <p style={{ margin: '0 0 2px', fontSize: 15, fontWeight: 800, color: t.color }}>{title}</p>
        {subtitle && <p style={{ margin: 0, fontSize: 12.5, fontWeight: 600, color: t.sub }}>{subtitle}</p>}
      </div>
      {onDismiss && (
        <button onClick={(e) => { e.stopPropagation(); onDismiss(); }} style={{ all: 'unset', boxSizing: 'border-box', width: 28, height: 28, borderRadius: '50%', background: t.iconBg || 'rgba(0,0,0,0.06)', display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer', flexShrink: 0 }}>
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none"><path d="M5 5l14 14M19 5L5 19" stroke={t.color} strokeWidth="2.4" strokeLinecap="round" /></svg>
        </button>
      )}
    </div>
  );
}
