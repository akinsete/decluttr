/**
 * Full-bleed draggable decision card — the core swipe-session interaction.
 * Only the top card in a stack should render with interactive=true.
 */
export interface SwipeCardProps {
  type?: 'contact' | 'photo';
  contact?: { name: string; phone: string; initials: string; color?: string };
  photo?: { tag: string; batchLabel: string; gradient?: string };
  /** Called with 'left' | 'right' once a drag commits past the 100px threshold. */
  onSwipe?: (direction: 'left' | 'right') => void;
  interactive?: boolean;
}
