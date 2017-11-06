//
//  Leon_TagsViewController.swift
//  LeonCommonFunctionsDemo
//
//  Created by Leon on 2017/8/16.
//  Copyright © 2017年 Leon_. All rights reserved.
//

import UIKit

class Leon_TagsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view.
        
        self.view.addSubview(self.tableView)
        
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        
        let tagsView: Leon_TagsView = Leon_TagsView(frame: CGRect(x: 100, y: 200, width: self.view.frame.size.width - 200, height: 200))
        
        tagsView.ReturnSelectedTagTitlesArrayMethod { (array: [String]) in
            for text in array {
                print("调用喽\(text)")
            }
        }
        tagsView.leonTagsViewStyle = .LeonTagsViewStyle_MultiSelection
        
        //tagsView.setTagsArray(tagsArray: ["123", "456", "789", "adfsfsdadsfafdsa", "fdsasfdafdasasfdsfda", "4567498", "7984564321"], selectedTags: ["123", "456"])
        
        tagsView.setTagsArray(array: ["123", "456", "789", "adfsfsdadsfafdsa", "fdsasfdafdasasfdsfda", "4567498", "7984564321"], selectedTagsArray: ["789"], defaultArray: ["123", "456"])
        
        tagsView.backgroundColor = UIColor.yellow
        print("tagsView.totalHeight =\(tagsView.totalHeight)")
        /*
        tagsView.ReturnSelectedTagTitlesArrayMethod { (array:[String]) in
            for text in array {
                print("调用喽\(text)")
            }
        }
        tagsView.leonTagsViewStyle = .LeonTagsViewStyle_MultiSelection
        tagsView.setTagsArray(array: ["123", "456", "789", "adfsfsdadsfafdsa", "fdsasfdafdasasfdsfda", "4567498", "7984564321"])
        */
        self.view.addSubview(tagsView)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableView的DataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "123456789"
        return cell
    }
    //tableView的Delegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
