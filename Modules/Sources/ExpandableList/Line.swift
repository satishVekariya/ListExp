//
//  Line.swift
//  
//
//  Created by Satish Vekariya on 11/02/2024.
//

import Foundation

public struct Line: LineRepresentable {
    public var id: String = UUID().uuidString
    public var name: String?
    public var info: String?
    public var items: [Item]
    
    public init(
        name: String? = nil,
        info: String? = nil,
        items: [Line.Item]
    ) {
        self.name = name
        self.info = info
        self.items = items
    }

}

public struct LineItem: LineItemRepresentable {
    public var id: String
    public var label: String?
    public var value: String
    
    public init(
        id: String,
        label: String? = nil,
        value: String
    ) {
        self.id = id
        self.label = label
        self.value = value
    }
}
