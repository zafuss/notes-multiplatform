import type { Note } from '@/types/note';
import { NoteListItem } from './NoteListItem';

interface NoteListProps {
  notes: Note[];
  onSelect: (id: string) => void;
}

export function NoteList({ notes, onSelect }: NoteListProps) {
  return (
    <div className="grid gap-2">
      {notes.map(n => (
        <NoteListItem key={n.id} note={n} onClick={() => onSelect(n.id)}></NoteListItem>
      ))}
    </div>
  );
}
