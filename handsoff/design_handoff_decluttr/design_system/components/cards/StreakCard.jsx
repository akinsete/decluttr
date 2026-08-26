import React from 'react';

export function StreakCard({ streakDays, supportingText = 'Tap to see your calendar', onClick }) {
  return (
    <button
      onClick={onClick}
      style={{
        all: 'unset',
        boxSizing: 'border-box',
        cursor: 'pointer',
        width: '100%',
        background: 'var(--surface-white)',
        borderRadius: 'var(--radius-xl)',
        padding: 16,
        display: 'flex',
        alignItems: 'center',
        gap: 14,
        fontFamily: 'var(--font-sans)',
      }}
    >
      <div style={{ width: 48, height: 48, borderRadius: 'var(--radius-md)', background: 'var(--gradient-yellow-pink-160)', flexShrink: 0, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none"><path d="M12 2c1 4-3 5-3 9a5 5 0 0 0 10 0c0-2-1-3-2-4 .3 2-1 3-2 2 1-3-1-4-3-7z" fill="#fff" /></svg>
      </div>
      <div style={{ flex: 1, minWidth: 0, textAlign: 'left' }}>
        <p style={{ margin: '0 0 2px', fontSize: 15, fontWeight: 800, color: 'var(--text-primary)' }}>{streakDays}-day streak</p>
        <p style={{ margin: 0, fontSize: 12.5, fontWeight: 600, color: 'var(--text-secondary-50)' }}>{supportingText}</p>
      </div>
      <span style={{ fontSize: 18, color: 'var(--text-secondary-40)' }}>&rsaquo;</span>
    </button>
  );
}
