//
//  LoadStatus.swift
//  ios-notes
//
//  Created by zafus on 29/10/2025.
//

enum LoadStatus : Equatable {
    case initial, loading, error(msg: String), done
}
