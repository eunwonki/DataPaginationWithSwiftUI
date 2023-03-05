//
//  ContentView.swift
//  PaginationTutorialApp
//
//  Created by wonki on 2023/03/05.
//

import SwiftUI

private let limit = 50

// 출처: https://github.com/crelies/List-Pagination-SwiftUI/blob/master/Shared/Views/ListPaginationExampleView.swift

struct ContentView: View {
    @State private var items: [String]
        = Array(0 ... (limit - 1)).map { "Item \($0)" }

    @State private var isLoading: Bool = false
    @State private var page: Int = 0

    private var offset = 0

    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    Text(item)
                        .onAppear {
                            if items.isLastItem(item) {
                                // TODO: offset만큼 볼 데이터가 남았을때로 로직 수정
                                loadMoreItem(item)
                            }
                        }
                }

                if isLoading {
                    ProgressView()
                }
            }
            .listStyle(.plain)
            .padding(10)
            .navigationTitle("List of Items")
            // TODO: NavigationBarItem이 동작하지 않는 이유 확인하기.
            //            .navigationBarItems(trailing: {
            //                Text("Page index: \(page)")
            //            })
        }
    }
}

private extension ContentView {
    func loadMoreItem<Item: Identifiable>(_ item: Item) {
        if isLoading { return }
        isLoading = true

        // TODO: Web에서 데이터를 더 가져오는다는 가정으로 함수 수정.
        Task {
            try await Task.sleep(nanoseconds: 3_000_000_000)
            await MainActor.run {
                page += 1
                let moreItems = getMoreItems(forPage: page, pageSize: limit)
                items.append(contentsOf: moreItems)
                isLoading = false
            }
        }
    }
}

private extension ContentView {
    // TODO: Web에서 데이터를 더 가져오는다는 가정으로 함수 수정.
    func getMoreItems(forPage page: Int,
                      pageSize: Int) -> [String]
    {
        let maximum = ((page * pageSize) + pageSize) - 1
        let moreItems: [String]
            = Array(items.count ... maximum).map { "Item \($0)" }
        return moreItems
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
