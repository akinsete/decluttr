import React from 'react';

export function DashboardCard({ icon, title, subtitle, background = 'var(--accent-blue)', iconBackground = 'rgba(255,255,255,0.55)', onClick }) {
  return (
    <button
      onClick={onClick}
      style={{
        all: 'unset',
        boxSizing: 'border-box',
        cursor: 'pointer',
        width: '100%',
        minHeight: 120,
        background,
        borderRadius: 'var(--radius-xl)',
        padding: 20,
        display: 'flex',
        alignItems: 'center',
        gap: 14,
        fontFamily: 'var(--font-sans)',
      }}
    >
      <div style={{ width: 52, height: 52, borderRadius: 'var(--radius-md)', background: iconBackground, flexShrink: 0, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
        {icon}
      </div>
      <div style={{ flex: 1, minWidth: 0, textAlign: 'left' }}>
        <p style={{ margin: '0 0 3px', fontSize: 17, fontWeight: 800, color: 'var(--text-primary)' }}>{title}</p>
        <p style={{ margin: 0, fontSize: 13.5, fontWeight: 600, color: 'var(--text-secondary-65)' }}>{subtitle}</p>
      </div>
      <span style={{ fontSize: 20, color: 'var(--text-secondary-40)' }}>&rsaquo;</span>
    </button>
  );
}
