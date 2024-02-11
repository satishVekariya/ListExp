//
//  SelectionCells.swift
//
//
//  Created by Satish Vekariya on 27/01/2024.
//

import SwiftUI
import ExpandableList
import Utils

struct SelectionCells: View {
    @ObservedObject var model: SectionModel

    var body: some View {
        ForEach(model.items, id: \.id) { item in
            cellView(sectionItem: item, isShowDivider: model.items.last?.id != item.id || !model.disableShowAll )
        }
    }
    
    func cellView(sectionItem: Line, isShowDivider: Bool) -> some View {
        LineView(line: sectionItem, selectedIds: model.selectedIds, onSelect: { line, lineItem in
            if model.selectedIds.contains(lineItem.id) {
                model.selectedIds.remove(lineItem.id)
            } else {
                model.selectedIds.insert(lineItem.id)
            }
        })
        .overlay(alignment: .bottom) {
            Color.divider.frame(height: 1)
                .opacity(isShowDivider ? 1 : 0)
        }
        .overlay(alignment: .leading) {
            Color.divider.frame(width: 1)
                .opacity(isShowDivider ? 1 : 0)
        }
        .overlay(alignment: .trailing) {
            Color.divider.frame(width: 1)
                .opacity(isShowDivider ? 1 : 0)
        }
        .if(isShowDivider == false) { view in
            view
                .clipShape(UShape())
                .overlay {
                    UShape()
                        .stroke(lineWidth: 1)
                        .foregroundStyle(Color.divider)
                }
        }
    }
}

#Preview {
    SelectionCells(model: .previewMock())
}
