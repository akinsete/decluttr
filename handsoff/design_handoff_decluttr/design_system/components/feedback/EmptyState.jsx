import React from 'react';

export function EmptyState({ icon, title, description, actionLabel, onAction }) {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 14, padding: '56px 20px', fontFamily: 'var(--font-sans)', textAlign: 'center' }}>
      <div style={{ width: 56, height: 56, borderRadius: 'var(--radius-xl)', background: 'var(--surface-card)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
        {icon}
      </div>
      <p style={{ margin: 0, fontSize: 14, fontWeight: 600, color: 'var(--text-secondary-40)', lineHeight: 1.5 }}>
        <strong style={{ display: 'block', fontSize: 15, fontWeight: 800, color: 'var(--text-primary)', marginBottom: 4 }}>{title}</strong>
        {description}
      </p>
      {actionLabel && (
        <button onClick={onAction} style={{ all: 'unset', boxSizing: 'border-box', marginTop: 4, cursor: 'pointer', padding: '10px 18px', borderRadius: 'var(--radius-full)', background: 'var(--text-primary)', color: '#fff', fontFamily: 'inherit', fontSize: 13.5, fontWeight: 700 }}>
          {actionLabel}
        </button>
      )}
    </div>
  );
}
