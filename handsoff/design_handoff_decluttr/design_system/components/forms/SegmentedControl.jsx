import React from 'react';

export function SegmentedControl({ options, value, onChange }) {
  return (
    <div style={{ display: 'flex', gap: 4, background: 'var(--surface-card)', borderRadius: 'var(--radius-sm)', padding: 3, fontFamily: 'var(--font-sans)' }}>
      {options.map((opt) => {
        const active = opt === value;
        return (
          <button
            key={opt}
            onClick={() => onChange && onChange(opt)}
            style={{ border: 'none', borderRadius: 11, padding: '6px 10px', fontFamily: 'inherit', fontSize: 12.5, fontWeight: 700, cursor: 'pointer', background: active ? 'var(--text-primary)' : 'transparent', color: active ? '#fff' : 'var(--text-primary)' }}
          >
            {opt}
          </button>
        );
      })}
    </div>
  );
}
