//
//  PasswordTextFiledView.swift
//  NewApp5.11
//
//  Created by Макар Тюрморезов on 09.12.2022.
//

import UIKit

protocol PasswordTextFieldProtocol: AnyObject {

    func takeString(textField: UITextField, mainLabel: UILabel, errorLabel: UILabel)
    
}

class PasswordTextFiledView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var wrongPasswordLabel: UILabel!
    
    var tfDelegate: PasswordTextFieldProtocol?
    
// MARK: Init
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            
            Bundle.main.loadNibNamed("PasswordTextFieldView", owner: self, options: nil)
            addSubview(contentView)
                    contentView.frame = bounds
                    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            setupText()
            setupUI()
            passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
        }
            
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
            Bundle.main.loadNibNamed("PasswordTextFieldView", owner: self, options: nil)
            addSubview(contentView)
                    contentView.frame = bounds
                    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            setupUI()
            setupText()
            passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
       
        tfDelegate?.takeString(textField: textField, mainLabel: passwordLabel, errorLabel: wrongPasswordLabel)
       
    }
    @objc private func showTextButtonTapped(_ sender: UIButton) {
        sender.setImage((passwordTextField.isSecureTextEntry ? UIImage(systemName: "eye") : UIImage(systemName: "eye.slash.fill"))?.withRenderingMode(.alwaysTemplate), for: .normal)
            passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        }
    @objc func textFieldChanging(_ textField: UITextField) {
       
        if textField.text!.count >= 6 {
            wrongPasswordLabel.isHidden = true
        }else {
        wrongPasswordLabel.isHidden = false
        wrongPasswordLabel.text = "Поле должно содержать минимум 6 символов"
        }
    }
    
    private func configureShowTextButton() {
            let showTextButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        showTextButton.setImage((passwordTextField.isSecureTextEntry ? UIImage(systemName: "eye.slash.fill") : UIImage(systemName: "eye.slash.fill"))?.withRenderingMode(.alwaysTemplate), for: .normal)
        
            showTextButton.tintColor = .darkGray
            showTextButton.addTarget(self, action: #selector(showTextButtonTapped), for: .touchUpInside)
        passwordTextField.rightView = showTextButton
        passwordTextField.rightViewMode = .always
    
        
}
}
extension PasswordTextFiledView {
    
    func setupText() {
        wrongPasswordLabel.font = .systemFont(ofSize: 11, weight: .medium)
        wrongPasswordLabel.textColor = .red
    }
    
}

extension PasswordTextFiledView {
    func setupUI() {
        passwordTextField.isSecureTextEntry = true
        passwordLabel.text = "Password"
        passwordLabel.shadowColor = .gray
        wrongPasswordLabel.isHidden = true
        
        wrongPasswordLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
    }
}
