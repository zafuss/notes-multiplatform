//
//  ApiStorageImpl.swift
//  ios-notes
//
//  Created by zafus on 29/10/2025.
//

import SwiftUI
import Combine

class ApiStorageImpl : Api {
    private let filename = "notes.json"
    
    private var fileURL: URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return directory.appendingPathComponent(filename)
    }
   
    var notes: [Note] = []
    
    func loadNotes() async throws -> [Note] {
        do {
             let data = try Data(contentsOf: fileURL)
             return try JSONDecoder().decode([Note].self, from: data)
         } catch {
             print("Load error:", error)
             return []
         }
    }
    
    func addNote(title: String, content: String) async {
        let note = Note(id: UUID(), title: title, content: content, updatedAt: Int64(Date().timeIntervalSince1970))
        notes.append(note)
        
        do {
            let data = try JSONEncoder().encode(notes)
            try data.write(to: fileURL)
        } catch {
            print("Save error:", error)
        }
    }
    
    func editNote(id: UUID, title: String, content: String) async {
        do {
            for (index, note) in notes.enumerated() {
                if note.id == id {
                    notes[index] = Note(id: note.id, title: title, content: content, updatedAt: Int64(Date().timeIntervalSince1970))
                    
                    break
                }
            }
            let data = try JSONEncoder().encode(notes)
            try data.write(to: fileURL)
        } catch {
            print("Edit save error:", error)
        }
    }
    
    func deleteNote(id: UUID) async throws {
        do {
            notes.removeAll(where: { $0.id == id })
            let data = try JSONEncoder().encode(notes)
            try data.write(to: fileURL)
        } catch {
            print("Delete error:", error)
        }
    }
}
