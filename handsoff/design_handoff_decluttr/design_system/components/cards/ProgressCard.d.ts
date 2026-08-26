/**
 * Home-screen summary card: circular gradient progress ring plus Kept/Deleted counts.
 * Animate the ring's stroke-dasharray on mount.
 */
export interface ProgressCardProps {
  keptCount: number;
  deletedCount: number;
  itemsRemaining: number;
  /** 0–1 fraction of the ring to fill (remaining / original total). */
  pct?: number;
}
