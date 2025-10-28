import { useNotes } from '@/hooks/useNotes';
import { useNavigate } from 'react-router-dom';
import { Button } from './ui/button';
import { EmptyState } from './EmptyState';
import { NoteList } from './NoteList';

export function NotesPage() {
  const { notes } = useNotes();
  const navigate = useNavigate();

  return (
    <main className="max-w-xl mx-auto p-4 font-sans">
      <header className="flex items-center justify-between mb-4">
        <h1 className="text-lg font-semibold">My Notes</h1>
        <Button onClick={() => navigate('/new')}>New Note</Button>
      </header>

      {notes.length === 0 ? (
        <EmptyState />
      ) : (
        <NoteList notes={notes} onSelect={id => navigate(`/edit/${id}`)} />
      )}
    </main>
  );
}
