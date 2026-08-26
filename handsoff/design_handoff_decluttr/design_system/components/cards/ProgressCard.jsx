import React from 'react';

export function ProgressCard({ keptCount, deletedCount, itemsRemaining, pct = 0.5 }) {
  const c = 2 * Math.PI * 42;
  const dasharray = `${(c * pct).toFixed(1)} ${c.toFixed(1)}`;
  return (
    <div style={{ background: 'var(--surface-card)', borderRadius: 'var(--radius-xl)', padding: '16px 18px', boxSizing: 'border-box', display: 'flex', flexDirection: 'column', gap: 6, fontFamily: 'var(--font-sans)' }}>
      <span style={{ fontSize: 12, fontWeight: 700, color: 'var(--text-secondary-45)' }}>Your progress</span>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 20 }}>
        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 5 }}>
          <div style={{ width: 28, height: 28, borderRadius: '50%', background: '#DCEBFF', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none"><path d="M4 12.5l5.5 5.5L20 6.5" stroke="#2E7BDB" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round" /></svg>
          </div>
          <span style={{ fontSize: 13, fontWeight: 800, color: 'var(--text-primary)' }}>{keptCount}</span>
          <span style={{ fontSize: 10, fontWeight: 700, color: '#2E7BDB' }}>Kept</span>
        </div>
        <div style={{ position: 'relative', width: 82, height: 82, flexShrink: 0 }}>
          <svg width="82" height="82" viewBox="0 0 100 100" style={{ transform: 'rotate(-90deg)' }}>
            <circle cx="50" cy="50" r="42" fill="none" stroke="rgba(26,26,26,0.08)" strokeWidth="8" />
            <circle cx="50" cy="50" r="42" fill="none" stroke="url(#progressCardGrad)" strokeWidth="8" strokeLinecap="round" strokeDasharray={dasharray} />
            <defs>
              <linearGradient id="progressCardGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stopColor="#5C9BFF" />
                <stop offset="100%" stopColor="#FF6FA8" />
              </linearGradient>
            </defs>
          </svg>
          <div style={{ position: 'absolute', inset: 0, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
            <span style={{ fontSize: 19, fontWeight: 800, color: 'var(--text-primary)', lineHeight: 1 }}>{itemsRemaining}</span>
            <span style={{ fontSize: 8.5, fontWeight: 600, color: 'var(--text-secondary-50)', marginTop: 2, textAlign: 'center', lineHeight: 1.2 }}>items<br />remaining</span>
          </div>
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 5 }}>
          <div style={{ width: 28, height: 28, borderRadius: '50%', background: '#FBDCE4', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none"><path d="M5 7h14M9 7V5a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2M7 7l1 12a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1l1-12" stroke="#D63C6B" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" /></svg>
          </div>
          <span style={{ fontSize: 13, fontWeight: 800, color: 'var(--text-primary)' }}>{deletedCount}</span>
          <span style={{ fontSize: 10, fontWeight: 700, color: '#D63C6B' }}>Deleted</span>
        </div>
      </div>
    </div>
  );
}
