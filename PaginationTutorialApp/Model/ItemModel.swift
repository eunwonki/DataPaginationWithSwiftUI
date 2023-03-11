//
//  ItemModel.swift
//  PaginationTutorialApp
//
//  Created by wonki on 2023/03/11.
//

import Foundation

@MainActor
class ItemModel: ObservableObject {
    var webService: MockingWebService
    @Published var items: [Item] = []

    init(webService: MockingWebService) {
        self.webService = webService
    }

    func load(page: Int, pageSize: Int) async throws {
        let newElements = try await webService.loadData(page: page, pageSize: pageSize)
        if page == 1 { items = newElements }
        else { items.append(contentsOf: newElements) }
    }
}
