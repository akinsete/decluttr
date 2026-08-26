import React from 'react';

export function StatusPill({ label, tone = 'neutral' }) {
  const tones = {
    success: { color: 'var(--success-text)', background: 'var(--success-bg)' },
    neutral: { color: 'var(--text-secondary-45)', background: 'rgba(26,26,26,0.06)' },
    danger: { color: 'var(--destructive-text)', background: 'var(--destructive-bg)' },
  };
  const t = tones[tone] || tones.neutral;
  return (
    <span
      style={{
        fontSize: 12,
        fontWeight: 700,
        padding: '5px 11px',
        borderRadius: 'var(--radius-full)',
        color: t.color,
        background: t.background,
        fontFamily: 'var(--font-sans)',
        whiteSpace: 'nowrap',
      }}
    >
      {label}
    </span>
  );
}
