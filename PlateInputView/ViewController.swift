//
//  ViewController.swift
//  PlateInputView
//
//  Created by dong on 2021/1/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "One"
        
        let textField = UITextField(frame: CGRect(x: 50, y: 150, width: 150, height: 50))
        textField.backgroundColor = .systemPink
        
        let inputView = CarKeyboardView(frame: .zero, inputViewStyle: .default)
        inputView.allowsSelfSizing = true
        inputView.keyInput = textField
        textField.inputAccessoryView = nil
        textField.inputView = inputView
        view.addSubview(textField)
        
        // 每次可刷新 inputView 回到初始状态
        let carField = CarTextField(frame: CGRect(x: 50, y: 250, width: 150, height: 50))
        carField.backgroundColor = .yellow
        view.addSubview(carField)
    }


}

