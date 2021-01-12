//
//  AddTaskViewController.swift
//  TodoApp
//
//  Created by Kousuke Sumiyasu on 2021/01/08.
//

import UIKit
import CoreData


class AddTaskViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var isImportant: UISwitch!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle("確定",for: .normal)
//        isImportant.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    let value:String? = nil
    
    @IBAction func btnTapped(_ sender: Any) {
        
        let alert_notitle = UIAlertController(title:"忠告",message:"タイトルが入力されていません",preferredStyle: .alert)
        let alert_confirm = UIAlertController(title:"アラート",message:"タイトルを確定しますか？",preferredStyle: .alert)
        
        guard let value = textField.text,
              value != "" else{
            let notitle = UIAlertAction(title:"確認",style: .default){(action) in self.dismiss(animated: true,completion: nil)}
            alert_notitle.addAction(notitle)
            present(alert_notitle,animated: true,completion: nil)
            
            return
        }
        
        let ok = UIAlertAction(title:"OK",style: .default,handler:{ [weak self] _ in
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

            let task = Task(context: context)
            task.name = self?.textField.text!
            task.isImportant = self?.isImportant.isOn ?? true
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            self?.navigationController!.popViewController(animated: true)
        })
        
        let cancel = UIAlertAction(title:"キャンセル",style: .default){(action) in self.dismiss(animated: true,completion: nil)}
        
        alert_confirm.addAction(ok)
        alert_confirm.addAction(cancel)
        present(alert_confirm,animated: true,completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
