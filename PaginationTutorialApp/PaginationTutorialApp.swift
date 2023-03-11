//
//  PaginationTutorialAppApp.swift
//  PaginationTutorialApp
//
//  Created by wonki on 2023/03/05.
//

import SwiftUI

@main
struct PaginationTutorialApp: App {
    @StateObject private var model: ItemModel
    
    init() {
        _model = StateObject(
            wrappedValue: ItemModel(webService: MockingWebService()))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
