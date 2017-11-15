//
//  MyCityesController.swift
//  Погода
//
//  Created by Артем Сулейманов on 15.11.17.
//  Copyright © 2017 Артем Сулейманов. All rights reserved.
//

import UIKit

class MyCityesController: UITableViewController {

    var cityes = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCityesCell", for: indexPath) as! MyCityesCell
        // получаем город для конкретной строки
        let city = cityes [indexPath.row]
        
        // устанавливаем город в надпись ячейки
        cell.myCityName.text = city
        
        return cell
    }
 
    @IBAction func addCity (segue: UIStoryboardSegue) {
        
        // проверяем идентификатор перехода, чтобы убедиться, что это нужный переход
        if segue.identifier == "addCity" {
            // получаем ссылку на контроллер, с которого осуществлен переход
            let allCityesController = segue.source as! AllCityesController
            
            // получаем индекс выделенной ячейки
            if let indexPath = allCityesController.tableView.indexPathForSelectedRow {
                // получаем город по  индексу
                let city = allCityesController.cityes [indexPath.row]
                
                // проверяем что такого города нет в списке
                if !cityes.contains(city) {
                // добавляем город в список выбранных городов
                cityes.append(city)
                // обновляем таблицу
                tableView.reloadData()
            }
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // если была нажата кнопка удалить
        if editingStyle == .delete {
            // мы удаляем город из массива
            cityes.remove(at: indexPath.row)
            // и удаляем строку из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
