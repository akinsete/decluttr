/**
 * Full-width dismissable row for nudges and inline notices (resume-session,
 * duplicates found, restore-window warning, save-progress prompt).
 */
export interface BannerProps {
  /** dark = black (resume session). gradient = colored (duplicates nudge). warning = yellow (restore window). neutral = card fill (save-progress nudge). */
  tone?: 'dark' | 'gradient' | 'warning' | 'neutral';
  icon?: React.ReactNode;
  title: string;
  subtitle?: string;
  onClick?: () => void;
  onDismiss?: () => void;
}
