import UIKit


//struct Food {
//    var name: String
//    var price: String
//    
//}

struct Item {
    var title: String

}
class ViewController: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableViwe: UITableView!
    
    var items: [Item] = []
    
    var tempElement = ""
    var tempTitle = ""
    //var tempPrice = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViwe.dataSource = self
        
        
        loadData()
    }
    
    func loadData() {
        if let url = NSURL(string: "https://developer.apple.com/news/rss/news.rss"), let parser = XMLParser.init(contentsOf: url as URL){
            
            parser.delegate = self
            if parser.parse(){
                tableViwe.reloadData()
            }else{
                print("Error")
            }
            
        }
        
        /*if let file = Bundle.main.path(forResource: "sample", ofType:"xml"){
            let url = NSURL(fileURLWithPath: file)
            if let parsre = XMLParser(contentsOf: url as URL){
                parsre.delegate = self
                if parsre.parse() {
                    tableViwe.reloadData()
                    
                }else{
                    print("Error")
                }
            }else{
                print("Error")
            }
            
        }
        
    */
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        tempElement = elementName
        
        if elementName == "item" {
            tempTitle = ""
            //tempPrice = ""
            
        }
        
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if tempElement == "title"{
            tempTitle.append(string)
            
            
        }
//        if tempElement == "price"{
//            tempPrice.append(string)
//        }
//        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            //let names = tempName.stringtrimmingCharacters(in: .whitespacesAndNewlines)
            let title = tempTitle.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //let price = tempPrice.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if   !title.isEmpty //&& !price.isEmpty{ {
            {
            items.append(Item(title: title))
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViwe.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
       // cell.textLabel?.text = item.title
        
        return cell
    }
    
}







