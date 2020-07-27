//
//  Array+Extension.swift
//  Memorize
//
//  Created by Izzy on 26/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//
import Foundation

extension Array where Element: Identifiable {
    
    func index(of element: Element) -> Int? {
//        self.firstIndex { $0 == element }
        
        // implementation without Equatable because it breaks the reactive UI :(
        var selectedIndex: Int?
        for index in indices {
            if self[index].id == element.id {
                selectedIndex = index
                break
            }
        }
        return selectedIndex
    }
}
