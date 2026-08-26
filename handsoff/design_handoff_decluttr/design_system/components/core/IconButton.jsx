import React from 'react';

export function IconButton({ icon, size = 36, background = 'var(--surface-white)', color = 'var(--text-primary)', shadow = 'var(--shadow-xs)', onClick }) {
  return (
    <button
      onClick={onClick}
      style={{
        width: size,
        height: size,
        borderRadius: '50%',
        border: 'none',
        background,
        color,
        boxShadow: shadow,
        cursor: 'pointer',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        flexShrink: 0,
      }}
    >
      {icon}
    </button>
  );
}
