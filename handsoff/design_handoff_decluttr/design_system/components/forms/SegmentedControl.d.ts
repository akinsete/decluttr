/** Inline segmented picker, e.g. default batch size (10/20/30/50). */
export interface SegmentedControlProps {
  options: string[];
  value: string;
  onChange?: (value: string) => void;
}
