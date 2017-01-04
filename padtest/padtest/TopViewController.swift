//
//  TopViewController.swift
//  padtest
//
//  Created by 中江洋史 on 2016/12/11.
//  Copyright © 2016年 中江洋史. All rights reserved.
//

import PagingMenuController
import UIKit

class TopViewController: BaseViewController {
    @IBOutlet weak var listView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBarAndStatusBarHidden(hidden: false, animated: false)
        self.navigationItem.hidesBackButton = true

        var controllers: [UIViewController] = []
        var menuItems:[MenuItemViewCustomizable] = []
        var menu:[String] = []
        menu.append("全て")
        menu.append("ア")
        menu.append("カ")
        menu.append("サ")
        menu.append("タ")
        menu.append("ナ")
        
        for title in menu {
            let pageViewController = PageViewController()
            menuItems.append(PagingMenuOptions.MenuItem(title:title))
            controllers.append(pageViewController)
        }

        // pagingMenuController create
        let options = PagingMenuOptions(itemsOptions:menuItems,pagingControllers: controllers)
        let pagingMenuController = PagingMenuController(options: options)
        
        self.addChildViewController(pagingMenuController)
        self.listView.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)

        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        let path = paths[0] + "/" + "test3.db"
        print(path)
        let db = FMDatabase(path: path)
//        db?.setKey("passphrase")
        
        
        let isopne = db?.open()
        print(isopne)
//        let key = ["BIGSecret", CFString];
        let key:String = "passphrase"
        
        let input = "passphrase"
        let data = input.data(using: .utf8)!
        let cString = input.cString(using: .utf8)!
        
        let iskey = db?.setKey("x'2DD29CA851E7B56E4697B0E1F08507293D761A05CE4D1B628663F411A8086D99'")
        print(iskey)
        
        
        let quiz_sql = "select * from test;"
        let quiz_results = db?.executeQuery(quiz_sql, withArgumentsIn: nil)
        
        print(quiz_results as Any)
        
        while (quiz_results?.next())! {
            let a = quiz_results?.string(forColumn: "a")
            let b = quiz_results?.string(forColumn: "b")
            let c = quiz_results?.string(forColumn: "c")
            
            print(a! + " " + b! + " " + c!)
        }
        
        db?.close()
        
        
        // ドキュメントディレクトリの「パス」（String型）
//        let documentDirPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        // ドキュメントディレクトリの「ファイルURL」（URL型）
        //let documentDirFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        
//        let users = Table("users")
//        let id = Expression<Int64>("id")
//        let name = Expression<String?>("name")
//        let email = Expression<String>("email")
//
//        let insert = users.insert(name <- "Alice", email <- "alice@mac.com")
//
//        do {
//            let db = try Connection(documentDirPath + "/db.sqlite3")
//            try db.key("Password")
//
//            try db.run(users.create { t in
//                t.column(id, primaryKey: true)
//                t.column(name)
//                t.column(email, unique: true)
//            })
//            let rowid = try db.run(insert)
//            for user in try db.prepare(users) {
//                print("id: \(user[id]), name: \(user[name]), email: \(user[email])")
//                // id: 1, name: Optional("Alice"), email: alice@mac.com
//            }
//            let alice = users.filter(id == rowid)
//            
//            try db.run(alice.update(email <- email.replace("mac.com", with: "me.com")))
//            
//            try db.run(alice.delete())
//            // DELETE FROM "users" WHERE ("id" = 1)
//        } catch {
//            
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private struct PagingMenuOptions: PagingMenuControllerCustomizable {
        var componentType: ComponentType {
            return .all(menuOptions: MenuOptions(itemsOptions:itemsOptions), pagingControllers: pagingControllers)
        }
        
        private var itemsOptions :[MenuItemViewCustomizable] = []
        private var pagingControllers: [UIViewController] = []
        
        init(itemsOptions:[MenuItemViewCustomizable],pagingControllers: [UIViewController]) {
            self.itemsOptions = itemsOptions
            self.pagingControllers = pagingControllers
        }
        
        struct MenuOptions: MenuViewCustomizable {
            var itemsOptions: [MenuItemViewCustomizable] {
                return self.itemOptions
            }
            
            private var itemOptions :[MenuItemViewCustomizable] = []
            
            init(itemsOptions:[MenuItemViewCustomizable]){
                self.itemOptions = itemsOptions
            }
            
            var displayMode: MenuDisplayMode {
                return .segmentedControl
            }

            var focusMode: MenuFocusMode {
                return .underline(height: 4.0, color: UIColor.black, horizontalPadding: 0.0, verticalPadding: 0.0)
            }
        }
        
        struct MenuItem: MenuItemViewCustomizable {
            private let title: String
            
            var displayMode: MenuItemDisplayMode {
                let title = MenuItemText(text: self.title)
                return .text(title: title)
            }
            
            init(title: String) {
                self.title = title
            }
        }
    }
}
