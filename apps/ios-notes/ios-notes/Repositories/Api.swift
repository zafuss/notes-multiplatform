//
//  Api.swift
//  ios-notes
//
//  Created by zafus on 29/10/2025.
//

import SwiftUI
import Combine // Phải có trong toolchain mới (26)

class ApiEnv: ObservableObject {
    var api: Api
    
    init(api: Api) {
        self.api = api
    }
}


protocol Api {
    func loadNotes() async throws -> [Note]
    func addNote(title: String, content: String) async throws
    func editNote(id: UUID, title: String, content: String) async throws
    func deleteNote(id: UUID) async throws
}
