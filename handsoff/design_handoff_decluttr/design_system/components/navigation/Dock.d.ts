/**
 * Floating frosted-glass bottom tab bar with a spring-animated active pill.
 * Hidden on Welcome/Signup/Permission/Swipe/Summary/Delete-account — only
 * shown on screens reachable via tab nav (Home/Filter/Settings/Trash).
 */
export interface DockProps {
  active: 'home' | 'trash' | 'settings';
  onNavigate?: (id: 'home' | 'trash' | 'settings') => void;
  /** Toggle text labels under icons (a Settings tweak in the source app). */
  showLabels?: boolean;
}
