//
//  ZMTextField.swift
//  test01
//
//  Created by dong on 2021/1/25.
//

import UIKit

class CarTextField: UITextField {

    private let input: CarKeyboardView = {
        let board = CarKeyboardView(frame: .zero, inputViewStyle: .default)
        board.allowsSelfSizing = true
        return board
    }()
    
    
    override func reloadInputViews() {
        input.resetInput()
        input.keyInput = self
        self.inputView = input
        
        super.reloadInputViews()
    }

}
