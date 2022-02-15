//
//  RoundedCornes.swift
//  Filmes Populares
//
//  Created by Matheus Curticeiro on 10/02/22.
//

import SwiftUI

struct RoundedCornes: Shape {
    var coners: UIRectCorner = .allCorners
    var radius: CGFloat = .infinity
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: coners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }

}

