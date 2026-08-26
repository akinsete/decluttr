/**
 * Pill-shaped action button — the app's only button shape (radius = height/2).
 */
export interface ButtonProps {
  /** Visual treatment. primary = solid ink pill (default CTA). secondary = white outline. danger = red fill (destructive). ghost = text-only link. */
  variant?: 'primary' | 'secondary' | 'danger' | 'ghost';
  /** Height preset: lg 56px (primary screen CTA), md 54px (secondary CTA), sm 44px (min touch target). */
  size?: 'lg' | 'md' | 'sm';
  fullWidth?: boolean;
  disabled?: boolean;
  onClick?: () => void;
  children?: React.ReactNode;
  style?: React.CSSProperties;
}
