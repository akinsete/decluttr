/**
 * Circular icon-only button — back chevrons, close/X, undo, swipe-left/right controls.
 */
export interface IconButtonProps {
  icon?: React.ReactNode;
  /** Diameter in px. 36 = nav back button, 44 = min touch target, 48 = undo, 64 = swipe-session left/right. */
  size?: number;
  background?: string;
  color?: string;
  shadow?: string;
  onClick?: () => void;
}
