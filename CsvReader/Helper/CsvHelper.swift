import Foundation

final class CsvHelper {
    var hrCounts = [HrCount]()
    
    init() {
        convertCSVIntoArray()
    }
    
    func convertCSVIntoArray() {
        
        guard let filepath = Bundle.main.path(forResource: "exampleCSV", ofType: "csv") else {
            return
        }
        
        var data = ""
        
        do {
            data = try String(contentsOfFile: filepath)
        } catch {
            print(error)
            return
        }
        
        var rows = data.components(separatedBy: "\n")
        rows.removeFirst()
        
        for row in rows {
            let columns = row.components(separatedBy: ",")
            if columns.count == 2 {
                
                let time = columns[0]
                var countString = columns[1]
                
                if !countString.isEmpty && rows.last != row {
                    countString.removeLast()
                }
                
                let count = Int(countString) ?? 0
                let hrCount = HrCount(date: time, count: count)
                hrCounts.append(hrCount)
            }
        }
    }
}
