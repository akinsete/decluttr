/**
 * Friendly empty-state block — icon tile, title, description, optional primary
 * action. Every empty screen area must use this rather than being left blank.
 */
export interface EmptyStateProps {
  icon?: React.ReactNode;
  title: string;
  description: string;
  actionLabel?: string;
  onAction?: () => void;
}
