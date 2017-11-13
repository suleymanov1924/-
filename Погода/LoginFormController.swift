//
//  LoginFormController.swift
//  Погода
//
//  Created by Артем Сулейманов on 08.11.17.
//  Copyright © 2017 Артем Сулейманов. All rights reserved.
//

import UIKit

class LoginFormController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector (self.hideKeyboard))
        // присваиваем его UIScrollView
        scrollView?.addGestureRecognizer(hideKeyboardGesture)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        func shouldPerformSegue(withIdentifier: String, sender: Any?) -> Bool{
            // Проверяем данные
            let checkResult = checkUserData ()
            
            // Если данные неверны, покажем ошибку
            if !checkResult {
                showLoginError ()
            }
            
            // Вернём результат
            return checkResult
        }
        
        func checkUserData () -> Bool {
            let login = loginInput.text!
            let password = passwordInput.text!
        
        if login == "admin" && password == "123456" {
            return true
        } else {
            return false
            }
        }
        
        func showLoginError () {
            // Создаём контроллер
            let alter = UIAlertController (title: "Ошибка", message: "Введены неверные данные рользователя", preferredStyle: .alert)
            //Создаём кнопку для UIAlertController
            let action = UIAlertAction (title: "Ok", style: .cancel, handler: nil)
            // Добавляем кнопку на UIAlertController
            alter.addAction(action)
            // Показываем UIAlertController
            present (alter, animated: true, completion: nil)
        }
    }
    
// когда клавиатура появляется
    @objc func keyboardWasShown (notificotion: Notification) {
        
        // получаем размер клавиатуры
        let info = notificotion.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        
        // добавляем отступ внизу UIScrollView равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // когда клавиатура исчезает
    @objc func keyboardWillBeHidden (notification: Notification) {
        // устанавливаем отступ внизу UIScrollView равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // подписываемся на два уведомления, одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        // второе, когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc func hideKeyboard () {
        self.scrollView?.endEditing(true)
    }
    
}
