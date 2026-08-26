/**
 * Small capsule badge for a status word — permission state, trash counts, etc.
 */
export interface StatusPillProps {
  label: string;
  /** success = green (e.g. "Allowed"). neutral = gray (e.g. "Not enabled"). danger = red. */
  tone?: 'success' | 'neutral' | 'danger';
}
