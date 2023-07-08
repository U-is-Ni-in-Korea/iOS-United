//
//  HomeView.swift
//  Uni
//
//  Created by 박익범 on 2023/07/05.
//

import Foundation
import UIKit

final class HomeView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
        self.setLayout()
    }
    
    private func setLayout() {
        self.backgroundColor = .systemPink
    }
    
}
