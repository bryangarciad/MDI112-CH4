import Foundation
import Combine
import SwiftUI

enum EntryType: String, Codable, CaseIterable {
    case calories = "calories"
    case water = "water"
    
    var icon: String {
        switch self {
        case .calories: "flame.fill"
        case .water: "drop.fill"
        }
    }
    
    var unit: String {
        switch self {
        case .calories: "kcal"
        case .water: "ml"
        }
    }
    
    var color: Color {
        switch self {
        case .calories: .orange
        case .water: .cyan
        }
    }
}

struct DiaryEntry: Codable, Identifiable {
    let id: UUID
    let type: EntryType
    let value: Double
    let timestamp: Date
    
    
    init(id: UUID = UUID(), type: EntryType, value: Double, timestamp: Date = Date()) {
        self.id = id
        self.type = type
        self.value = value
        self.timestamp = timestamp
    }
}
