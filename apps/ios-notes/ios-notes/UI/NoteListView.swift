//
//  NoteListView.swift
//  ios-notes
//
//  Created by zafus on 30/10/2025.
//

import SwiftUI

struct NoteListView : View {
    @EnvironmentObject var vm : NoteViewModel
    
    var body: some View {
        List {
            // If Note does not conform to Identifiable, change to: ForEach(vm.notes, id: \.id)
            ForEach(vm.notes) { item in
                VStack(alignment: .leading) {
                    HStack {
                        Text(item.title).bold()
                        Text("(\(item.updatedAt))")
                        Spacer()
                    }
                    Text(item.content)
                }
                .onTapGesture {
                    vm.selectedNote = item
                }
            }.onDelete { idx in
                let ids = idx.map { vm.notes[$0].id }
                Task {
                    for id in ids {
                        await vm.deleteNote(id: id)
                    }
                }
            }
        }
        .sheet(item: $vm.selectedNote) { note in
            NavigationStack {
                AddOrEditNoteView(existingTitle: note.title, existingContent: note.content) { title, content in
                    Task {
                        await vm.editNote(id: note.id, title: title, content: content)
                        await vm.loadList()
                    }
                }
            }
        }
    }
}
