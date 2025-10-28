import type { Note } from '@/types/note';
import { useCallback, useEffect, useState } from 'react';
import { uuid } from '@/lib/uuid';
import { saveNotes } from '@/lib/storage';

export function useNotes() {
  const [notes, setNotes] = useState<Note[]>([]);

  useEffect(() => {
    setNotes(loadNotes());
  }, []);

  function loadNotes(): Note[] {
    const notesJson = localStorage.getItem('notes_app_storage_key_v1');
    if (notesJson) {
      try {
        return JSON.parse(notesJson) as Note[];
      } catch {
        return [];
      }
    }
    return [];
  }

  function createNote(title: string, content: string) {
    const newNote: Note = {
      id: uuid(),
      title,
      content,
      updatedAt: Date.now(),
    };

    const next = [newNote, ...notes];
    setNotes(next);
    saveNotes(next);
    return newNote.id;
  }

  function updateNote(id: string, title: string, content: string) {
    const next = notes.map(n =>
      n.id === id ? { ...n, title, content, updatedAt: Date.now() } : n
    );
    setNotes(next);
    saveNotes(next);
  }

  function deleteNote(id: string) {
    const next = notes.filter(n => n.id !== id);
    setNotes(next);
    saveNotes(next);
  }

  const getNoteById = useCallback(
    (id: string) => {
      return notes.find(n => n.id === id);
    },
    [notes]
  );

  const sortedNotes = [...notes].sort((a, b) => b.updatedAt - a.updatedAt);

  return {
    notes: sortedNotes,
    createNote,
    updateNote,
    deleteNote,
    getNoteById,
  };
}
