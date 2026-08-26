import React from 'react';

export function IconTile({ icon, size = 44, radius, background = 'var(--surface-card)', shape = 'square' }) {
  const r = shape === 'circle' ? '50%' : (radius ?? Math.max(12, Math.round(size * 0.3)));
  return (
    <div
      style={{
        width: size,
        height: size,
        borderRadius: r,
        background,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        flexShrink: 0,
      }}
    >
      {icon}
    </div>
  );
}
