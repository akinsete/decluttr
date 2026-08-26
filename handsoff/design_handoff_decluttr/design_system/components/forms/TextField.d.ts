/** Labeled text input with an inline error state, used in the signup form. */
export interface TextFieldProps {
  label: string;
  value: string;
  onChange?: (value: string) => void;
  placeholder?: string;
  type?: 'text' | 'email' | 'password';
  error?: string;
}
