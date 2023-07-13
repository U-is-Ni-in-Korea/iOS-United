//
//  LoginView.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/14.
//

import Foundation
import UIKit
import SDSKit
import Then

final class LoginView: UIView {
    
    // MARK: - UI Property

    
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
