/**
 * Rounded-square (or circular) color tile that carries an icon or initials —
 * the app's basic "leading visual" unit, reused at every size from list rows
 * up to the permission-ask hero.
 */
export interface IconTileProps {
  icon?: React.ReactNode;
  /** Tile side in px: 28/36 (list rows), 44/48/52 (cards), 56/64 (streak/summary), 88/120 (hero/avatar). */
  size?: number;
  /** Explicit corner radius; defaults to ~30% of size when shape="square". */
  radius?: number;
  background?: string;
  shape?: 'square' | 'circle';
}
