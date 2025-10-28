import type { Note } from '@/types/note';

interface NoteListItemProps {
  note: Note;
  onClick: () => void;
}

export function NoteListItem({ note, onClick }: NoteListItemProps) {
  return (
    <div
      onClick={onClick}
      className="rounded border border-gray-300 p-3 cursor-pointer hover:bg-gray-50"
    >
      <div className="font-semibold mb-1">{note.title || '(No title)'}</div>

      <div className="text-sm text-gray-600 line-clamp-2">{note.content || '(empty)'}</div>

      <div className="text-[11px] text-gray-400 mt-2">
        {new Date(note.updatedAt).toLocaleString()}
      </div>
    </div>
  );
}
