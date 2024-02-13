//
//  ChartsColor.swift
//  CsvReader
//
//  Created by Александр Кудряшов on 12.02.2024.
//

import SwiftUI
import Foundation

enum ChartsColor: CaseIterable, Identifiable {
    case green
    case gray
    case red
    case blue
    case pink
    case orange
    
    var id: Self { return self }
    
    var color: Color {
        switch self {
        case .green:
            Color.green
        case .gray:
            Color.gray
        case .red:
            Color.red
        case .blue:
            Color.blue
        case .pink:
            Color.pink
        case .orange:
            Color.orange
        }
    }
    
}
