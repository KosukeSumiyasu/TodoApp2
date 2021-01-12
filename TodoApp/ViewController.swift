//
//  ViewController.swift
//  TodoApp
//
//  Created by Kousuke Sumiyasu on 2021/01/08.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var tasks : [Task] = []

    

    @IBOutlet weak var tableView: UITableView!
    
    //基本的な初期化
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //画面に表示される直前に呼ばれる。
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        getData()
        tableView.reloadData()
    }
    //数の指定　今回では、tasks[]に含まれる個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    //tableに表示するcellを定義　今回では、cell.textLabel.textを変更
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.name!
        
        if task.isImportant{
            cell.textLabel?.text = "[重要]  " + task.name!
        }else{
            cell.textLabel?.text = task.name!
        }
        
        return cell
    }
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            tasks = try context.fetch(Task.fetchRequest())
        }
        catch{
            print("can`t read")
        }
    }
    
    //delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath:IndexPath){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
        if editingStyle == .delete{
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do{
                tasks = try context.fetch(Task.fetchRequest())
            }
            catch{
                print("can't read")
            }
            tableView.reloadData()
        }
    }

}

