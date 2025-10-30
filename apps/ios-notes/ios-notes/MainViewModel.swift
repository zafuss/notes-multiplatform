//
//  MainViewModel.swift
//  ios-notes
//
//  Created by zafus on 30/10/2025.
//

import SwiftUI
import Combine

@MainActor
class MainViewModel : ObservableObject {
    @Published var msg: String = "";
    @Published var isShowError = false
    
    func checkShowError(msg: String) {
        if isShowError == false && msg.isEmpty == false {
            self.msg = msg
            self.isShowError = true
        }
    }
}
