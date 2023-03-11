//
//  MockingWebService.swift
//  PaginationTutorialApp
//
//  Created by wonki on 2023/03/11.
//

import Foundation

class MockingWebService {
    func loadData(page: Int, pageSize: Int)
    async throws -> [Item] {
        try await Task.sleep(nanoseconds: 500_000_000)
        var items: [Item] = []
        for idx in 1 ... pageSize {
            let id = (page - 1) * pageSize + idx
            items.append(Item(id: "\(id)", content: "Item\(id)"))
        }
        return items
    }
}
