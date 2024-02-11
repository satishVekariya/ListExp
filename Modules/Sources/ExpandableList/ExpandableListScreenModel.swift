//
//  ExpandableListScreenModel.swift
//  ListExp
//
//  Created by Satish Vekariya on 27/01/2024.
//

import Foundation
import SwiftUI

@MainActor final public class ExpandableListScreenModel: ObservableObject {
    static let BATCH_SIZE = 20

    @Published public private(set) var sections = [SectionModel]()
    @Published public private(set) var state: DataLoadingState = .default
    @Published public private(set) var batchState: DataLoadingState = .default
    
    private var isInitialFetch = true

    public init(){
        
    }

    public func fetch() async {
        state = .loading
        try? await Task.sleep(for: .seconds(2))
        let limit = max(Self.BATCH_SIZE, sections.count)
        sections = (0..<limit).map { sectionCount in
            SectionModel(
                "Section: \(sectionCount)",
                items: getSectionItems(name: ["Fruits", nil].randomElement()!, info: ["₹₹", "₹₹₹", nil].randomElement()!)
            )
        }
        state = .finished
        await autoExpandFirstCellIfNeeded()
    }

    public func fetchNext() async {
        guard batchState != .loading else {
            return
        }
        batchState = .loading
        try? await Task.sleep(for: .seconds(2))
        let lowerLimit = max(Self.BATCH_SIZE, sections.count)
        let newSections = (lowerLimit..<(lowerLimit + Self.BATCH_SIZE)).map { sectionCount in
            SectionModel(
                "Section: \(sectionCount)",
                items: getSectionItems(name: ["Fruits", nil].randomElement()!, info: ["₹₹", "₹₹₹", nil].randomElement()!)
            )
        }
        
        sections.append(contentsOf: newSections)
        batchState = .finished
    }

    public func fetchNextIfNeeded(for model: SectionModel) async {
        if sections.last?.id == model.id {
            await fetchNext()
        }
    }
    
    private func autoExpandFirstCellIfNeeded() async {
        if isInitialFetch, let firstModel = sections.first, !firstModel.isExpanded {
            isInitialFetch = false
            try? await Task.sleep(for: .seconds(0.25))
            await MainActor.run {
                withAnimation(.easeInOut) {
                    firstModel.toggleExpanded()
                }
            }
        }
    }
    
    private func getSectionItems(name: String? = nil, info: String? = nil) -> [Line] {
        (0..<Int.random(in: 1..<11))
            .map {
                Line(
                    name: name,
                    info: info,
                    items: getRandomLines(number: $0)
                )
            }
    }
    
    private func getRandomLines(number: Int) -> [LineItem] {
        let lines = [
            LineItem(id: UUID().uuidString, label: "Apple \(number)", value: "🍎"),
            LineItem(id: UUID().uuidString, label: "Apple \(number)", value: "🍎"),
            LineItem(id: UUID().uuidString, label: "Banana \(number)", value: "🍌"),
            LineItem(id: UUID().uuidString, label: "Orange \(number)", value: "🍊"),
            LineItem(id: UUID().uuidString, label: "Grapes \(number)", value: "🍇"),
            LineItem(id: UUID().uuidString, label: "Strawberry \(number)", value: "🍓"),
            LineItem(id: UUID().uuidString, label: "Pineapple \(number)", value: "🍍"),
            LineItem(id: UUID().uuidString, label: "Kiwi \(number)", value: "🥝"),
            LineItem(id: UUID().uuidString, label: "Peach \(number)", value: "🍑"),
            LineItem(id: UUID().uuidString, label: "Cherry \(number)", value: "🍒"),
            LineItem(id: UUID().uuidString, label: "Mango \(number)", value: "🥭"),
            LineItem(id: UUID().uuidString, label: "Watermelon \(number)", value: "🍉"),
            LineItem(id: UUID().uuidString, label: "Cantaloupe \(number)", value: "🍈"),
            LineItem(id: UUID().uuidString, label: "Lemon \(number)", value: "🍋"),
            LineItem(id: UUID().uuidString, label: "Pear \(number)", value: "🍐"),
            LineItem(id: UUID().uuidString, label: "Green Apple \(number)", value: "🍏"),
            LineItem(id: UUID().uuidString, label: "Coconut \(number)", value: "🥥"),
            LineItem(id: UUID().uuidString, label: "Avocado \(number)", value: "🥑"),
            LineItem(id: UUID().uuidString, label: "Cucumber \(number)", value: "🥒")
        ]
        
        return randomSubarray(from: lines, minLength: 1, maxLength: 3)
    }
    
    func randomSubarray<T>(from array: [T], minLength: Int, maxLength: Int) -> [T] {
        guard !array.isEmpty else { return [] }
        let length = Int.random(in: minLength...maxLength)
        let startIndex = Int.random(in: 0...(array.count - length))
        let endIndex = startIndex + length
        return Array(array[startIndex..<endIndex])
    }
}

public enum DataLoadingState {
    public static let `default` = Self.unknown

    case unknown
    case loading
    case finished
    case error
}
