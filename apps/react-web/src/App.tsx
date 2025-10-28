import { useState } from 'react';

function App() {
  const [notes, setNotes] = useState<string[]>([]);
  const [draft, setDraft] = useState('');

  const addNote = () => {
    if (!draft.trim()) return;
    setNotes(prev => [draft.trim(), ...prev]);
    setDraft('');
  };

  return (
    <main style={{ maxWidth: 600, margin: '2rem auto', padding: '1rem', fontFamily: 'sans-serif' }}>
      <h1 style={{ fontSize: '1.5rem', fontWeight: 600, marginBottom: '1rem' }}>
        My Notes (React Web)
      </h1>

      <div style={{ display: 'flex', gap: '0.5rem', marginBottom: '1rem' }}>
        <input
          style={{ flex: 1, padding: '0.5rem', border: '1px solid #ccc', borderRadius: 4 }}
          placeholder="Nhập ghi chú..."
          value={draft}
          onChange={e => setDraft(e.target.value)}
        />
        <button
          style={{
            padding: '0.5rem 0.75rem',
            borderRadius: 4,
            border: '1px solid #333',
            background: '#111',
            color: 'white',
            fontWeight: 500,
            cursor: 'pointer',
          }}
          onClick={addNote}
        >
          Add
        </button>
      </div>

      {notes.length === 0 ? (
        <p style={{ color: '#666' }}>Chưa có ghi chú nào.</p>
      ) : (
        <ul style={{ listStyle: 'none', padding: 0, display: 'grid', gap: '0.5rem' }}>
          {notes.map((note, idx) => (
            <li
              key={idx}
              style={{
                border: '1px solid #ddd',
                borderRadius: 6,
                padding: '0.75rem',
                background: 'white',
              }}
            >
              {note}
            </li>
          ))}
        </ul>
      )}
    </main>
  );
}

export default App;
