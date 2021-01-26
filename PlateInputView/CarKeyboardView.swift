//
//  CarKeyboardView.swift
//  test01
//
//  Created by dong on 2021/1/22.
//

import UIKit
import SnapKit

class CarKeyboardView: UIInputView, UIInputViewAudioFeedback {
    
    private let plateArray = ["京","沪","粤","苏","浙","鲁","冀","豫","渝","黑","闽","鄂","川","甘","津","晋","赣","湘","黔","青","蒙","辽","云","藏","宁","吉","皖","琼","陕","桂","新"]
    private let numArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    private let charArray = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M"]
    
    private let itemW: CGFloat = (UIScreen.main.bounds.size.width - 5*9 - 8) / 10.0
    private let itemH: CGFloat = scaleW(42.0)
    private let actionBtnSize = CGSize(width: scaleW(65.0), height: scaleW(34.0))
    
    private var plateContentView: UIView!
    private var charContentView: UIView!
    
    private var checkButton: UIButton!
    private var sureButton: UIButton!
    private var deleteButton: UIButton!
    
    weak var keyInput: UIKeyInput?


    override init(frame: CGRect, inputViewStyle: UIInputView.Style) {
        super.init(frame: frame, inputViewStyle: inputViewStyle)
        autoresizingMask = .flexibleHeight
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        createCommonViews()
        createContentSubViews(plateContentView, self.plateArray)
        createContentSubViews(charContentView, self.numArray + self.charArray)
    }
    
    private func createCommonViews() {
        plateContentView = UIView()
        plateContentView.backgroundColor = .clear
        plateContentView.isHidden = false
        addSubview(plateContentView)
        
        charContentView = UIView()
        charContentView.backgroundColor = .clear
        charContentView.isHidden = true
        addSubview(charContentView)
        
        checkButton = createActionButton("字符")
        checkButton.addTarget(self, action: #selector(checkTypeAction(_:)), for: .touchUpInside)
        sureButton = createActionButton("确定")
        sureButton.addTarget(self, action: #selector(sureInputAction(_:)), for: .touchUpInside)
        deleteButton = createActionButton("")
        deleteButton.setImage(UIImage(named: "keyboard_delete_icon"), for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteInputAction(_:)), for: .touchUpInside)
        addSubview(deleteButton)
        addSubview(checkButton)
        addSubview(sureButton)
        
        plateContentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(checkButton.snp.top).offset(-10)
        }
        
        charContentView.snp.makeConstraints {
            $0.edges.equalTo(plateContentView)
        }
        
        checkButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.size.equalTo(actionBtnSize)
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-2)
            } else {
                $0.bottom.equalToSuperview().offset(-2)
            }
        }
        
        sureButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-5)
            $0.size.equalTo(actionBtnSize)
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-2)
            } else {
                $0.bottom.equalToSuperview().offset(-2)
            }
        }
        
        deleteButton.snp.makeConstraints {
            $0.bottom.equalTo(plateContentView.snp.bottom).offset(scaleW(-2))
            $0.trailing.equalToSuperview().offset(-4)
            $0.size.equalTo(CGSize(width: scaleW(45), height: scaleW(38)))
        }
    }
    
    private func createActionButton(_ title: String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor(red: 173.0/255.0, green: 177.0/255.0, blue: 185.0/255.0, alpha: 1.0)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 4
        btn.layer.masksToBounds = true
        return btn
    }
    
    private func createContentSubViews(_ contentView: UIView, _ stringArray: [String]) {
        
        let (firstStack, secondStack, thirdStack, fourthStack) = createContentStackView(contentView)
        
        let itemSize = CGSize(width: itemW, height: itemH)

        firstStack.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(itemH)
        }
        
        secondStack.snp.makeConstraints {
            $0.top.equalTo(firstStack.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(itemH)
        }
        
        thirdStack.snp.makeConstraints {
            $0.top.equalTo(secondStack.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(itemH)
        }
        
        fourthStack.snp.makeConstraints {
            $0.top.equalTo(thirdStack.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(itemH)
            $0.bottom.equalToSuperview()
        }
        
        for (index, str) in stringArray.enumerated() {
            let btn = UIButton(type: .custom)
            btn.backgroundColor = .white
            btn.setTitleColor(.black, for: .normal)
            btn.setTitleColor(.gray, for: .highlighted)
            btn.setTitle(str, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: scaleW(15))
            btn.layer.cornerRadius = 4
            btn.layer.masksToBounds = true
            btn.addTarget(self, action: #selector(inputCharAction(_:)), for: .touchUpInside)
            if (0..<10).contains(index) {
                firstStack.addArrangedSubview(btn)
            }
            
            if (10..<20).contains(index) {
                secondStack.addArrangedSubview(btn)
            }
            let endIndex = stringArray.count == plateArray.count ? 28 : 29
            if (20..<endIndex).contains(index) {
                thirdStack.addArrangedSubview(btn)
            }
            
            if (endIndex..<stringArray.count).contains(index) {
                fourthStack.addArrangedSubview(btn)
            }
            
            btn.snp.makeConstraints {
                $0.size.equalTo(itemSize)
            }
        }
        
    }
    
    private func createContentStackView(_ contentView: UIView) -> (UIStackView, UIStackView, UIStackView, UIStackView) {
        var stackSet: (UIStackView?, UIStackView?, UIStackView?, UIStackView?) = (nil, nil, nil, nil)
        for i in 0..<4 {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.alignment = .center
            rowStackView.spacing = 5
            rowStackView.distribution = .equalSpacing
            contentView.addSubview(rowStackView)
            switch i {
            case 0:
                stackSet.0 = rowStackView
            case 1:
                stackSet.1 = rowStackView
            case 2:
                stackSet.2 = rowStackView
            default:
                stackSet.3 = rowStackView
            }
        }
        return (stackSet.0!, stackSet.1!, stackSet.2!, stackSet.3!)
    }
    
    
    var enableInputClicksWhenVisible: Bool {
        return true
    }
    
    func resetInput() {
        checkButton.setTitle("字符", for: .normal)
        plateContentView.isHidden = false
        charContentView.isHidden = true
    }
}

// MARK:- Action
extension CarKeyboardView {
    @objc private func checkTypeAction(_ btn: UIButton) {
        UIDevice.current.playInputClick()
        guard let btnText = btn.titleLabel?.text else { return }
        if btnText == "省" {
            btn.setTitle("字符", for: .normal)
            plateContentView.isHidden = false
            charContentView.isHidden = true
            
        } else {
            btn.setTitle("省", for: .normal)
            plateContentView.isHidden = true
            charContentView.isHidden = false
        }
    }
    
    @objc
    private func sureInputAction(_ btn: UIButton) {
        UIDevice.current.playInputClick()
        guard let input = self.keyInput else { return }
        (input as? UIResponder)?.resignFirstResponder()
    }
    
    @objc
    private func deleteInputAction(_ btn: UIButton) {
        UIDevice.current.playInputClick()
        self.keyInput?.deleteBackward()
    }
    
    @objc
    private func inputCharAction(_ btn: UIButton) {
        UIDevice.current.playInputClick()
        guard let btnText = btn.titleLabel?.text else { return }
        UIDevice.current.playInputClick()
        self.keyInput?.insertText(btnText)
    }
    
    
}


// 根据屏幕宽度缩放
func scaleW(_ width: CGFloat, fit:CGFloat = 375) -> CGFloat {
    return CGFloat(ceilf(Float(UIScreen.main.bounds.size.width / fit * width)))
}
