//
//  PlaceholderShimmerCell.swift
//
//
//  Created by Satish Vekariya on 27/01/2024.
//

import SwiftUI
import ExpandableList

struct PlaceholderShimmerCell: View {
    var body: some View {
        VStack(spacing: 0) {
            ShowAllHeader(model: .previewMock())
        }
    }
    
    static func buildCells(count: Int = 3) -> some View {
        ForEach(0..<count, id: \.self) { _ in
            PlaceholderShimmerCell()
                .padding(.bottom, 10)
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
        .listRowBackground(EmptyView())
        .redacted(reason: .placeholder)
        .shimmer()
        .disabled(true)
    }
}

#Preview {
    List {
        PlaceholderShimmerCell.buildCells()
    }
    .listStyle(.plain)
    .listRowSpacing(0)
}
