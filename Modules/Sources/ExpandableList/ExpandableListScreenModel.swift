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
                items: (0..<11).map({ "Item: \($0)" })
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
                items: (0..<11).map({ "Item: \($0)" })
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
}

public enum DataLoadingState {
    public static let `default` = Self.unknown

    case unknown
    case loading
    case finished
    case error
}
