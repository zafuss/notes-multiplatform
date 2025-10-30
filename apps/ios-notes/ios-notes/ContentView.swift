//
//  ContentView.swift
//  ios-notes
//
//  Created by zafus on 29/10/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var api = ApiEnv(api: ApiStorageImpl())
    @StateObject var mainVM = MainViewModel()
    
    var body: some View {
        VStack {
            NavigationStack {
                NoteListScreen()
            }
            .environmentObject(mainVM)
            .environmentObject(api)
        }

    }
}

#Preview {
    ContentView()
}
