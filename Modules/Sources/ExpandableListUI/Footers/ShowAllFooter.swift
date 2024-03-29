//
//  ShowAllFooter.swift
//
//
//  Created by Satish Vekariya on 27/01/2024.
//

import SwiftUI
import ExpandableList
import Utils

struct ShowAllFooter: View {
    @ObservedObject var model: SectionModel
    
    var body: some View {
        if !model.disableShowAll && model.isExpanded {
            Button(action: {
                withAnimation(.easeInOut) {
                    model.toggleShowAll()
                }
            }, label: {
                HStack {
                    Spacer()
                    Text(model.isShowAll ? "Hide" : "Show All")
                    Image(systemName: "chevron.up")
                        .rotationEffect( model.isShowAll ? .zero : .degrees(180), anchor: .center)
                        .animation(.easeInOut, value: model.isShowAll)
                    Spacer()
                }
                .foregroundStyle(Color.primaryRed1)
            })
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
            .background {
                Color.white
                    .clipShape(UShape())
                    .overlay {
                        UShape()
                            .stroke(lineWidth: 1)
                            .foregroundStyle(Color.divider)
                    }
            }
        }
    }
}

#Preview {
    ShowAllFooter(model: .previewMock())
        .padding()
        .background(Color.yellow)
}

