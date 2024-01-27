//
//  RoundedCorner.swift
//
//
//  Created by Satish Vekariya on 27/01/2024.
//

import SwiftUI

public struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    var inset: UIEdgeInsets
    
    public init(
        radius: CGFloat = 8,
        corners: UIRectCorner = .allCorners,
        inset: UIEdgeInsets = .zero
    ) {
        self.radius = radius
        self.corners = corners
        self.inset = inset
    }

    public func path(in rect: CGRect) -> Path {
        let rect = rect.inset(by: inset)
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

public extension View {
    /// Set corner radius for specific corners
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
