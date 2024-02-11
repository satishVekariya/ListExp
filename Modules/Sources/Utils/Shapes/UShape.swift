//
//  UShape.swift
//
//
//  Created by Satish Vekariya on 11/02/2024.
//

import SwiftUI

public struct UShape: Shape {
    var radius: CGFloat
    var inset: CGFloat
    
    public init(radius: CGFloat = 8, inset: CGFloat = 1/2) {
        self.radius = radius
        self.inset = inset
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rect = rect.inset(by: .init(top: 0, left: inset, bottom: inset, right: inset))
        let width = rect.maxX
        let height = rect.maxY
        
        // Drawing the "U" shape
        path.move(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height - radius))
        path.addQuadCurve(to: CGPoint(x: width - radius, y: height), control: .init(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + radius, y: height))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: height - radius), control: .init(x: rect.minX, y: rect.maxY))
        path.addLine(to: rect.origin)
        return path
    }
}

#Preview {
    UShape()
        .stroke(Color.black, lineWidth: 5)
        .frame(width: 200, height: 200)
        .scaleEffect(x: 1, y: -1)
}
