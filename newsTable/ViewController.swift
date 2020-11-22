//
//  ViewController.swift
//  newsTable
//
//  Created by 김준섭 on 2020/11/22.
//
// 52c2335578f0436ebeaedab62a8d8e07
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var TableViewMain: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 데이터 몇개인지
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 데이터 무엇인지
        // 2가지 방법
        // 1번 - 임의의 셀 만들기
        
        // let cell = UITableViewCell.init(style: .default, reuseIdentifier: "TableCellType1")
        // cell.textLabel?.text = "\(indexPath.item + 1)"
        // return cell
        
        // 2번 - 스토리보드 + id -> 대부분 2번방법 사용
        
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        // as? as! -> 부모 자식 친자확인
        cell.LabelText.text = "\(indexPath.row)"
        
        return cell
    }
    
    // 클릭
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICK : \(indexPath.row)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
    }
    
    // tableView
    // 1. 데이터가 무엇인지
    // 2. 데이터가 몇개인지
    // 3. 데이터 행 눌렀을 때 ( 옵션 ) - 클릭


}

