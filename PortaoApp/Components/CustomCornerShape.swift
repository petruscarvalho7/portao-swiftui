//
//  CustomCornerShape.swift
//  PortaoApp
//
//  Created by Petrus Carvalho on 11/08/23.
//

import SwiftUI

struct CustomCornerShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
