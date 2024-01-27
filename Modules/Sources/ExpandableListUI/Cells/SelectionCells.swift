//
//  SelectionCells.swift
//
//
//  Created by Satish Vekariya on 27/01/2024.
//

import SwiftUI
import ExpandableList

struct SelectionCells: View {
    @ObservedObject var model: SectionModel

    var body: some View {
        ForEach(model.items, id: \.self) { item in
            cellView(name: item, isShowDivider: model.items.last != item)
        }
    }
    
    func cellView(name: String, isShowDivider: Bool) -> some View {
        HStack {
            Spacer()
                .frame(width: 8)
            Text(name)
            Spacer()
        }
        .padding(.vertical, 12)
        .background {
            HStack {
                Color.white.frame(width: 70)
                Color.gray5
            }
        }
        .overlay(alignment: .leading) {
            Color.divider.frame(width: 1)
        }
        .overlay(alignment: .trailing) {
            Color.divider.frame(width: 1)
        }
        .overlay(alignment: .bottom) {
            Color.divider.frame(height: 1)
                .opacity(isShowDivider ? 1 : 0)
        }
    }
}

#Preview {
    SelectionCells(model: .previewMock())
}
