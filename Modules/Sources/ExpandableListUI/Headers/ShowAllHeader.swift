//
//  ShowAllHeader.swift
//
//
//  Created by Satish Vekariya on 27/01/2024.
//

import SwiftUI
import ExpandableList
import Utils

struct ShowAllHeader: View {
    @ObservedObject var model: SectionModel
    
    var body: some View {
        HStack {
            Text(model.name)
                
            Spacer()
            Button(action: {
                withAnimation(.easeInOut) {
                    model.toggleExpanded()
                }
            }, label: {
                Image(systemName: "chevron.up")
                    .rotationEffect( model.isExpanded ? .zero : .degrees(180), anchor: .center)
                    .animation(.default, value: model.isExpanded)
            })
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background {
            RoundedCorner(
                radius: 8,
                corners: model.isExpanded ? [.topLeft, .topRight] : .allCorners,
                inset: .init(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
            )
            .stroke(lineWidth: 1)
            .foregroundStyle(Color.divider)
        }
    }
}

#Preview {
    ShowAllHeader(model: .previewMock())
}
