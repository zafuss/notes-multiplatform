//
//  NoteListScreen.swift
//  ios-notes
//
//  Created by zafus on 30/10/2025.
//

import SwiftUI

struct NoteListScreen : View {
    @EnvironmentObject var apiEnv : ApiEnv
    @StateObject var vm = NoteViewModel()
    @State var deleting = false
    @State var isShowAdd = false
    
    var body : some View {
        VStack {
            if vm.loadStatus == .loading {
                ProgressView()
            } else {
                NoteListView()
                    .environmentObject(vm)
            }
        }.environmentObject(vm)
            .navigationBarBackButtonHidden()
            .navigationTitle("Note Manager")
            .onAppear() {
                vm.api = apiEnv.api
                Task {
                    await vm.loadList()
                }
            }
            .navigationBarItems(trailing: Image(systemName: "plus").onTapGesture {
                isShowAdd = true
            })
            .sheet(isPresented: $isShowAdd) {
                NavigationStack {
                    AddOrEditNoteView { title, content in
                        // Call into the view model to add a note, then refresh
                        Task {
                            await vm.addNote(title: title, content: content)
                            await vm.loadList()
                        }
                    }
                }
            }
          
    }
}
