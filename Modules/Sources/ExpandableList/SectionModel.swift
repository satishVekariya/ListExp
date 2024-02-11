//
//  SectionModel.swift
//
//
//  Created by Satish Vekariya on 27/01/2024.
//

import Foundation

@MainActor public final class SectionModel: ObservableObject, Identifiable {
    public let name: String
    private let __items: [Line]
    private let initialVisibleCount: Int
    
    @Published public private(set) var isExpanded = false
    @Published public private(set) var isShowAll = false
    @Published public private(set) var items: [Line] = []
    @Published public var selectedIds = Set<String>()
    public let disableShowAll: Bool
    
    public init(_ name: String, items: [Line], isExpanded: Bool = false) {
        self.name = name
        self.__items = items
        self.isExpanded = isExpanded
        
        self.initialVisibleCount = [1, 1, 1, 2, 2, 3, 4].randomElement()!
        self.disableShowAll = initialVisibleCount == items.count
        
        setItems()
    }
    
    public func toggleExpanded() {
        isExpanded.toggle()
        setItems()
    }
    
    public func toggleShowAll() {
        isShowAll.toggle()
        setItems()
    }
    
    private func setItems() {
        switch (isExpanded, isShowAll) {
        case (true, true):
            items = __items
        case (true, false):
            items = Array(__items.prefix(initialVisibleCount))
        case (false, _):
            items.removeAll()
        }
    }
}

public extension SectionModel {
    static func previewMock() -> SectionModel {
        SectionModel(
            [
                "Cars",
                "Mobiles",
                "Vegetables",
            ].randomElement()!,
            items: (0..<3).map({
                .init(
                    name: "Item: \($0)",
                    info: nil,
                    items: [
                        LineItem(id: UUID().uuidString, label: "Label1", value: "+123"),
                        LineItem(id: UUID().uuidString, label: "Label2", value: "+1"),
                        LineItem(id: UUID().uuidString, label: "Label3", value: "+12")
                    ]
                )
            })
        )
    }
}
