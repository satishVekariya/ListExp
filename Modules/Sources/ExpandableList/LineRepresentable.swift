//
//  LineRepresentable.swift
//  
//
//  Created by Satish Vekariya on 11/02/2024.
//

import Foundation

public protocol LineRepresentable {
    typealias Item = LineItemRepresentable
    var id: String { get }
    var name: String? { get }
    var info: String? { get }
    var items: [Item] { get }
}

public protocol LineItemRepresentable {
    var id: String { get }
    var label: String? { get }
    var value: String { get }
}
