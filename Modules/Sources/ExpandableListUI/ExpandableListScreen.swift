//
//  ExpandableListScreen.swift
//  ListExp
//
//  Created by Satish Vekariya on 27/01/2024.
//

import SwiftUI
import ExpandableList

public struct ExpandableListScreen: View {
    static let SECTION_SPACING: CGFloat = 10
    @StateObject private var screenModel = ExpandableListScreenModel()

    public init() {}
    
    public var body: some View {
        List {
            switch screenModel.state {
            case .unknown, .error:
                EmptyView()
            case .loading:
                PlaceholderShimmerCell.buildCells(count: 10)
            case .finished:
                ForEach(screenModel.sections) { sectionModel in
                    Section {
                        ShowAllHeader(model: sectionModel)
                        SelectionCells(model: sectionModel)
                        ShowAllFooter(model: sectionModel)
                        Spacer(minLength: Self.SECTION_SPACING)
                    }
                    .task { await screenModel.fetchNextIfNeeded(for: sectionModel) }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .listRowBackground(EmptyView())
                
                if case .loading = screenModel.batchState {
                    PlaceholderShimmerCell.buildCells(count: 3)
                }
            }
            
        }
        .listStyle(.plain)
        .listRowSpacing(0)
        .environment(\.defaultMinListRowHeight, Self.SECTION_SPACING)
        .background { Color.white.ignoresSafeArea() }
        .navigationTitle("Expandable List")
        .navigationBarTitleDisplayMode(.automatic)
        .task { await screenModel.fetch() }
    }
}

#Preview {
    ExpandableListScreen()
}
