//
//  HideKeyBoard.swift
//  WyyKToDo
//
//  Created by Wykee Njenga on 5/17/22.
//

import Foundation

import SwiftUI


#if canImport(UIKit)
extension View {
    func hideKeyBoard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
#endif
