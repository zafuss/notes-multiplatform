//
//  NoteViewModel.swift
//  ios-notes
//
//  Created by zafus on 30/10/2025.
//

import SwiftUI
import Combine

@MainActor
class NoteViewModel : ObservableObject {
    var api: Api?
    @Published var loadStatus = LoadStatus.initial
    @Published var notes = [Note]()
    @Published var selectedNote: Note? = nil // note
    
    init() {
        print("Init Note VM")
    }
    
    deinit{
        print("Deinit Note VM")
    }
    
    func loadList() async {
        loadStatus = .loading
        do {
            notes = (try await api?.loadNotes()) ?? []
            loadStatus = .done
        } catch {
            loadStatus = .error(msg: "An error occured when loading notes")
        }
    }
    
    func addNote(title: String, content: String) async {
        loadStatus = .loading
        do {
            try await api?.addNote(title: title, content: content)
            await loadList()
        } catch {
            loadStatus = .error(msg: "An error occured when adding note")
        }
    }
    
    func editNote(id: UUID, title: String, content: String) async {
        loadStatus = .loading
        do {
            try await api?.editNote(id: id, title: title, content: content)
            await loadList()
        } catch {
            loadStatus = .error(msg: "An error occured when editing note")
        }
    }
    
    func deleteNote(id: UUID) async {
        loadStatus = .loading
        do {
            try await api?.deleteNote(id: id)
            await loadList()
        } catch {
            loadStatus = .error(msg: "An error occured when deleting note")
        }
    }
 }
