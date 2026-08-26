/**
 * Large colored entry card for a top-level module (Contacts, Photos & Videos) —
 * icon tile, title, status subtitle, and a trailing chevron. Whole card is tappable.
 */
export interface DashboardCardProps {
  icon?: React.ReactNode;
  title: string;
  subtitle: string;
  /** Flat accent fill — e.g. var(--accent-blue) for Contacts, var(--accent-pink) for Photos. */
  background?: string;
  iconBackground?: string;
  onClick?: () => void;
}
