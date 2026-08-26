import React from 'react';

export function TextField({ label, value, onChange, placeholder, type = 'text', error }) {
  return (
    <div>
      <p style={{ margin: '0 0 6px', fontSize: 13, fontWeight: 700, color: 'var(--text-secondary-60)', fontFamily: 'var(--font-sans)' }}>{label}</p>
      <input
        type={type}
        value={value}
        onChange={(e) => onChange && onChange(e.target.value)}
        placeholder={placeholder}
        style={{
          width: '100%', boxSizing: 'border-box', padding: '14px 16px', borderRadius: 'var(--radius-sm)',
          border: `1.5px solid ${error ? 'var(--destructive)' : 'rgba(26,26,26,0.12)'}`, background: '#fff',
          fontFamily: 'var(--font-sans)', fontSize: 15, color: 'var(--text-primary)', outline: 'none',
        }}
      />
      {error && <p style={{ margin: '6px 0 0', fontSize: 12, fontWeight: 600, color: 'var(--destructive)' }}>{error}</p>}
    </div>
  );
}
