//
//  Constants.swift
//  WyyKToDo
//
//  Created by Wykee Njenga on 5/2/22.
//

import Foundation
import SwiftUI



//MARK: - formatter
let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//MARK: - UI

var backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]),
                          startPoint: .topLeading, endPoint: .bottomTrailing)
}
