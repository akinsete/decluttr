import React from 'react';

export function Toggle({ checked, onChange }) {
  return (
    <button
      onClick={() => onChange && onChange(!checked)}
      style={{ all: 'unset', boxSizing: 'border-box', width: 44, height: 26, borderRadius: 13, background: checked ? 'var(--success)' : 'rgba(26,26,26,0.15)', position: 'relative', flexShrink: 0, cursor: 'pointer' }}
    >
      <div style={{ width: 22, height: 22, borderRadius: '50%', background: '#fff', position: 'absolute', top: 2, left: checked ? 20 : 2, boxShadow: '0 1px 3px rgba(0,0,0,0.2)', transition: 'left 0.2s ease' }} />
    </button>
  );
}
