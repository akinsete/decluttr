/**
 * Compact clickable row: fire icon, current streak, supporting text, chevron.
 * Entire row is tappable — opens the streak detail sheet.
 */
export interface StreakCardProps {
  streakDays: number;
  supportingText?: string;
  onClick?: () => void;
}
