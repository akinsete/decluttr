import React from 'react';

const VARIANTS = {
  primary: { background: 'var(--text-primary)', color: '#fff', border: 'none' },
  secondary: { background: 'var(--surface-white)', color: 'var(--text-primary)', border: '1.5px solid rgba(26,26,26,0.15)' },
  danger: { background: 'var(--destructive-strong)', color: '#fff', border: 'none' },
  ghost: { background: 'transparent', color: 'var(--text-secondary-55)', border: 'none' },
};

const SIZES = {
  lg: { height: 56, fontSize: 17 },
  md: { height: 54, fontSize: 16 },
  sm: { height: 44, fontSize: 14 },
};

export function Button({ variant = 'primary', size = 'lg', fullWidth = true, disabled = false, onClick, children, style }) {
  const v = VARIANTS[variant] || VARIANTS.primary;
  const sz = SIZES[size] || SIZES.lg;
  return (
    <button
      onClick={disabled ? undefined : onClick}
      disabled={disabled}
      style={{
        width: fullWidth ? '100%' : 'auto',
        height: sz.height,
        padding: fullWidth ? 0 : '0 22px',
        border: v.border,
        borderRadius: sz.height / 2,
        background: v.background,
        color: v.color,
        fontFamily: 'var(--font-sans)',
        fontSize: sz.fontSize,
        fontWeight: 700,
        cursor: disabled ? 'default' : 'pointer',
        opacity: disabled ? 0.45 : 1,
        boxSizing: 'border-box',
        ...style,
      }}
    >
      {children}
    </button>
  );
}
