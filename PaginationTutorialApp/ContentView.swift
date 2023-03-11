//
//  ContentView.swift
//  PaginationTutorialApp
//
//  Created by wonki on 2023/03/05.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ItemModel

    @State private var isLoading: Bool = false
    @State private var page: Int = 1

    private var LOAD_OFFSET = 15
    private var PAGE_SIZE = 30

    var body: some View {
        NavigationView {
            VStack {
                List(model.items) { item in
                    Text(item.content)
                        .frame(height: 50)
                        .onAppear {
                            if !isLoading,
                               model.items.isThresholdItem(
                                   offset: LOAD_OFFSET, item: item)
                            {
                                loadMore()
                            }
                        }
                }
                .listStyle(.plain)
                .refreshable {
                    refreshItems()
                }

                if isLoading {
                    ProgressView()
                }
            }
            .padding(10)
            .navigationTitle("List of Items")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Text("Page: \(page) Size: \(model.items.count)"))
            .onAppear {
                refreshItems()
            }
        }
    }
}

extension ContentView {
    func refreshItems() {
        page = 1
        load()
    }

    func loadMore() {
        page += 1
        load()
    }

    func load() {
        isLoading = true

        Task {
            do {
                try await model.load(page: page, pageSize: PAGE_SIZE)
            } catch {
                if page == 1 { page = 1 }
                else { page -= 1 }
            }
            isLoading = false
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(
                ItemModel(webService: MockingWebService()))
    }
}
#endif
