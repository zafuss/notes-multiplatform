import { useNotes } from '@/hooks/useNotes';
import { useNavigate, useParams } from 'react-router-dom';
import { Button } from './ui/button';
import { NoteEditor } from './NoteEditor';

interface EditNotePageProps {
  mode: 'new' | 'edit';
}

export function EditNotePage({ mode }: EditNotePageProps) {
  const { id } = useParams();
  const navigate = useNavigate();
  const { getNoteById, createNote, updateNote, deleteNote } = useNotes();

  const existing = mode === 'edit' && id ? getNoteById(id) : undefined;

  function handleSave(title: string, content: string) {
    if (mode === 'new') {
      createNote(title, content);
      navigate('/');
    } else if (existing) {
      updateNote(existing.id, title, content);
      navigate('/');
    }
  }

  function handleDelete() {
    if (!existing) return;
    else {
      deleteNote(existing.id);
      navigate('/');
    }
  }

  return (
    <main className="max-w-xl mx-auto p-4 font-sans">
      <header className="flex items-center justify-between mb-4">
        <Button variant="outline" onClick={() => navigate('/')}>
          ← Back
        </Button>
        <div className="text-base font-semibold">{mode === 'new' ? 'New Note' : 'Edit Note'}</div>
        <div className="w-16" /> {/* spacer cho cân header */}
      </header>

      <NoteEditor
        initialTitle={existing?.title}
        initialContent={existing?.content}
        onSave={handleSave}
        onDelete={mode === 'edit' ? handleDelete : undefined}
      />
    </main>
  );
}
