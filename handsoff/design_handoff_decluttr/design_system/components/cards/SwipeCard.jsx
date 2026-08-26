import React, { useRef, useState } from 'react';

export function SwipeCard({ type = 'photo', contact, photo, onSwipe, interactive = true }) {
  const [drag, setDrag] = useState({ x: 0, y: 0, dragging: false, animatingOut: null });
  const start = useRef({ x: 0, y: 0 });

  const onPointerDown = (e) => {
    if (!interactive) return;
    start.current = { x: e.clientX - drag.x, y: e.clientY - drag.y };
    setDrag((d) => ({ ...d, dragging: true }));
  };
  const onPointerMove = (e) => {
    if (!drag.dragging) return;
    setDrag((d) => ({ ...d, x: e.clientX - start.current.x, y: e.clientY - start.current.y }));
  };
  const onPointerUp = () => {
    if (!drag.dragging) return;
    if (Math.abs(drag.x) > 100) {
      const dir = drag.x > 0 ? 'right' : 'left';
      setDrag((d) => ({ ...d, dragging: false, x: dir === 'right' ? 700 : -700, animatingOut: dir }));
      setTimeout(() => onSwipe && onSwipe(dir), 260);
    } else {
      setDrag({ x: 0, y: 0, dragging: false, animatingOut: null });
    }
  };

  const transform = `translate(${drag.x}px, ${drag.y * 0.4}px) rotate(${drag.x / 14}deg)`;
  const transition = drag.dragging ? 'none' : 'transform 0.32s cubic-bezier(.2,.8,.2,1)';
  const keepOpacity = Math.min(Math.max(drag.x / 100, 0), 1);
  const deleteOpacity = Math.min(Math.max(-drag.x / 100, 0), 1);

  return (
    <div
      onPointerDown={onPointerDown}
      onPointerMove={onPointerMove}
      onPointerUp={onPointerUp}
      onPointerCancel={onPointerUp}
      style={{
        position: 'absolute',
        inset: 0,
        borderRadius: 'var(--radius-2xl)',
        overflow: 'hidden',
        boxShadow: 'var(--shadow-card-active)',
        cursor: interactive ? 'grab' : 'default',
        touchAction: 'none',
        transform,
        transition,
        fontFamily: 'var(--font-sans)',
      }}
    >
      {type === 'contact' && contact && (
        <div style={{ height: '100%', background: '#fff', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: 18, padding: 30, boxSizing: 'border-box' }}>
          <div style={{ width: 120, height: 120, borderRadius: '50%', background: contact.color || 'var(--accent-blue)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <span style={{ fontSize: 40, fontWeight: 800, color: 'var(--text-primary)' }}>{contact.initials}</span>
          </div>
          <div style={{ textAlign: 'center' }}>
            <p style={{ margin: '0 0 4px', fontSize: 22, fontWeight: 800, color: 'var(--text-primary)' }}>{contact.name}</p>
            <p style={{ margin: 0, fontSize: 14.5, fontWeight: 600, color: 'var(--text-secondary-50)' }}>{contact.phone}</p>
          </div>
        </div>
      )}
      {type === 'photo' && photo && (
        <div style={{ height: '100%', background: photo.gradient || 'var(--gradient-yellow-pink-160)', position: 'relative', display: 'flex', alignItems: 'flex-end' }}>
          <div style={{ width: '100%', padding: 18, boxSizing: 'border-box', background: 'var(--gradient-dark-scrim)' }}>
            <p style={{ margin: 0, fontSize: 15, fontWeight: 700, color: '#fff' }}>{photo.tag}</p>
            <p style={{ margin: 0, fontSize: 12.5, fontWeight: 600, color: 'rgba(255,255,255,0.8)' }}>{photo.batchLabel}</p>
          </div>
        </div>
      )}
      <div style={{ position: 'absolute', top: 22, left: 22, padding: '8px 14px', borderRadius: 12, border: '3px solid var(--success)', color: 'var(--success)', fontWeight: 800, fontSize: 16, letterSpacing: 1, transform: 'rotate(-12deg)', opacity: keepOpacity }}>KEEP</div>
      <div style={{ position: 'absolute', top: 22, right: 22, padding: '8px 14px', borderRadius: 12, border: '3px solid var(--destructive)', color: 'var(--destructive)', fontWeight: 800, fontSize: 16, letterSpacing: 1, transform: 'rotate(12deg)', opacity: deleteOpacity }}>DELETE</div>
    </div>
  );
}
