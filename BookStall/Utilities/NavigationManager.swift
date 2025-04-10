//
//  NavigationManager.swift
//  BookStall
//
//  Created by Aiysha on 09/04/25.
//

import Foundation
import SwiftUI

class NavigationManager : ObservableObject {
    
    @Published var path = NavigationPath()
    
    
    func pushView<V>(view : V.Type) where V : View {
        path.append(String(describing: V.self))
    }
    
    
    func popView(){
        path.removeLast(path.count)
    }
}
