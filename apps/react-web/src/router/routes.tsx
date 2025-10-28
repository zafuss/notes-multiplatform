import { EditNotePage } from '@/components/EditNotePage';
import { NotesPage } from '@/components/NotesPage';
import { createBrowserRouter } from 'react-router-dom';

export const router = createBrowserRouter([
  { path: '/', element: <NotesPage /> },
  { path: '/new', element: <EditNotePage mode="new" /> },
  { path: '/edit/:id', element: <EditNotePage mode="edit" /> },
]);
