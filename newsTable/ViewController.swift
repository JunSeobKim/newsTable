//
//  ViewController.swift
//  newsTable
//
//  Created by 김준섭 on 2020/11/22.
//
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TableViewMain: UITableView!
    
    var newsData: Array<Dictionary<String,Any>>?
    
    
    
    
    // 1. http 통신
    // 2. JSON 데이터 형태
    // 3. tableView 데이터 매칭
    // 4. 통보 getNews가 백그라운드에서 돌고있기 때문에 비동기로 Main에 reload 해줘야 함
    func getNews() {
        let task = URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/top-headlines?country=kr&apiKey=")!) { (data, response, error) in
            if let dataJson = data {
                do {
                    // json parsing
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                    
                    let articles = json["articles"] as! Array<Dictionary<String,Any>>
                    self.newsData = articles
                    
//                    for (idx, value) in articles.enumerated() {
//                        let v = value["title"] as! String
//                        print(v)
//                    }
                    // 4. 통보 getNews가 백그라운드에서 돌고있기 때문에 비동기로 Main에 reload 해줘야 함
                    DispatchQueue.main.async {
                        self.TableViewMain.reloadData()
                    }
                }
                catch {}
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 데이터 몇개인지
        if let dataNum = newsData {
            return dataNum.count
        }
        else {
            return 0
        }
        
    }
    
    // 위의 numberOfRowsInSection 수 만큼 반복
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
        if let news = newsData {
            if let newsTitle = news[indexPath.row]["title"] as? String {
                cell.LabelText.text = newsTitle
            }
        }
        
        
        
        return cell
    }
    
    
    
    // 클릭 2-1
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICK : \(indexPath.row)")
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let newsDetail = storyboard.instantiateViewController(identifier: "NewsDetailController") as! NewsDetailController
        
        if let news = newsData {
            if let newsImage = news[indexPath.row]["urlToImage"] as? String {
                newsDetail.imageUrl = newsImage
            }
            if let newsDesc = news[indexPath.row]["description"] as? String {
                newsDetail.desc = newsDesc
            }
        }
        
        // 이동 (수동)
//        showDetailViewController(newsDetail, sender: nil)
    }
    
    
    // 1. 디테일(상세) 화면 만들기
    // 2. 값 보내기
    // 2-1 tableview delegate / 2-2 storyboard (segue)
    // 3. 화면 이동 ( 이동하기 전에 값을 미리 세팅해야함 )
    
    // 2-2 segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "NewsDetailSegue" == id {
            if let newsDetail = segue.destination as? NewsDetailController {
                if let index = TableViewMain.indexPathForSelectedRow {
                    if let news = newsData {
                        if let newsImage = news[index.row]["urlToImage"] as? String {
                            newsDetail.imageUrl = newsImage
                        }
                        if let newsDesc = news[index.row]["description"] as? String {
                            newsDetail.desc = newsDesc
                        }
                    }
                }
            }
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
        
        getNews()
    }
    
    // tableView
    // 1. 데이터가 무엇인지
    // 2. 데이터가 몇개인지
    // 3. 데이터 행 눌렀을 때 ( 옵션 ) - 클릭


}

