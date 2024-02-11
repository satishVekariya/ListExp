//
//  LineView.swift
//
//
//  Created by Satish Vekariya on 03/02/2024.
//

import SwiftUI
import ExpandableList

struct LineView<Line: LineRepresentable>: View {
    let line: Line
    let selectedIds: Set<String>
    let verticalDivider: Color = Color(red: 0.76, green: 0.74, blue: 0.82)
    let nameBackground: Color = Color(red: 0.96, green: 0.93, blue: 0.92)
    let selectedBg: Color = .black
    let normalBg: Color = .white
    let onSelect: (Line, Line.Item) -> Void
    
    var body: some View {
        HStack(spacing: .zero) {
            NameAndInfoView(
                name: line.name,
                info: line.info,
                minWidth: 80,
                maxWidth: line.name == nil ? 80 : .infinity
            )
            .background(nameBackground)
            ForEach(line.items, id: \.id) { item in
                SelectableButton(
                    label: item.label,
                    value: item.value,
                    isSelected: selectedIds.contains(item.id),
                    selectedBg: selectedBg,
                    normalBg: normalBg,
                    minWidth: 70,
                    maxWidth: line.name == nil ? .infinity : nil,
                    action: {
                        onSelect(line, item)
                    }
                )
                .overlay(alignment: .trailing) {
                    verticalDivider
                        .frame(width: 1)
                        .opacity(item.id == line.items.last?.id ? 0 : 1)
                }
            }
        }
    }
}

#Preview {
    let items = (0..<Int.random(in: 1...3)).map({
        LineItem(id: "\($0)", label: "Label \($0)", value: "+\($0)")
    })
    let lineItem1 = Line(
        name: "Line Name",
        info: "INFO",
        items: items
    )
    
    let lineItem2 = Line(
        name: "Line Name",
        info: "INFO",
        items: items
    )
    
    let lineItem3 = Line(
        name: nil,
        info: "INFO",
        items: items
    )
    
    let lineItem4 = Line(
        name: nil,
        info: nil,
        items: items
    )
    
    let lineItem5 = Line(
        name: nil,
        info: nil,
        items: items
    )
    
    return VStack(spacing: .zero) {
        
        LineView(
            line: lineItem1,
            selectedIds: ["1"],
            onSelect: { _,_  in }
        )
        LineView(
            line: lineItem2,
            selectedIds: ["0"],
            onSelect: { _,_  in }
        )
        LineView(
            line: lineItem3,
            selectedIds: ["2"],
            onSelect: { _,_  in }
        )
        LineView(
            line: lineItem4,
            selectedIds: ["2"],
            onSelect: { _,_  in }
        )
        LineView(
            line: lineItem5,
            selectedIds: ["2"],
            onSelect: { _,_  in }
        )
    }
}


fileprivate struct NameAndInfoView: View {
    let name: String?
    let info: String?
    let minWidth: CGFloat?
    let maxWidth: CGFloat?
    let minHeight: CGFloat = 48
    
    var body: some View {
        if name != nil || info != nil {
            HStack(spacing: .zero) {
                if let name {
                    Text(name)
                }
                Spacer(minLength: .zero)
                if let info {
                    Text(info)
                        .fontWeight(.semibold)
                }
                if name == nil {
                    Spacer(minLength: .zero)
                }
            }
            .padding(.horizontal, 8)
            .font(.system(size: 14))
            .frame(minWidth: minWidth)
            .frame(maxWidth: maxWidth)
            .frame(minHeight: minHeight)
        } else {
            EmptyView()
        }
    }
}

fileprivate struct SelectableButton: View {
    let label: String?
    let value: String
    let isSelected: Bool
    let selectedBg: Color
    let normalBg: Color
    let minHeight: CGFloat = 48
    let minWidth: CGFloat?
    let maxWidth: CGFloat?
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                VStack(spacing: .zero) {
                    if let label {
                        Text(label)
                            .fontWeight(.semibold)
                    }
                    Text(value)
                }
                .font(.system(size: 11))
                .foregroundStyle(!isSelected ? selectedBg : normalBg)
            }
            .frame(minWidth: minWidth)
            .frame(maxWidth: maxWidth)
            .frame(minHeight: minHeight)
            .background {
                Rectangle()
                    .fill(isSelected ? selectedBg : normalBg)
            }
        })
        .buttonStyle(.borderless)
    }
}


