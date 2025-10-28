import { useEffect, useState } from 'react';
import { Button } from '@/components/ui/button';

interface NoteEditorProps {
  initialTitle?: string;
  initialContent?: string;
  onSave: (title: string, content: string) => void;
  onDelete?: () => void;
}

export function NoteEditor({
  initialTitle = '',
  initialContent = '',
  onSave,
  onDelete,
}: NoteEditorProps) {
  const [title, setTitle] = useState(initialTitle);
  const [content, setContent] = useState(initialContent);

  useEffect(() => {
    setTitle(initialTitle);
  }, [initialTitle]);

  useEffect(() => {
    setContent(initialContent);
  }, [initialContent]);

  return (
    <div className="grid gap-3">
      <input
        className="border border-gray-300 rounded px-3 py-2 font-medium"
        placeholder="Title"
        value={title}
        onChange={e => setTitle(e.target.value)}
      />

      <textarea
        className="border border-gray-300 rounded px-3 py-2 min-h-32 text-sm leading-relaxed"
        placeholder="Content..."
        value={content}
        onChange={e => setContent(e.target.value)}
      />

      <div className="flex gap-2">
        <Button onClick={() => onSave(title, content)}>Save</Button>

        {onDelete && (
          <Button variant="destructive" onClick={onDelete}>
            Delete
          </Button>
        )}
      </div>
    </div>
  );
}
