import Foundation

struct HrCount: Identifiable, Equatable {
    
    let id: UUID = UUID()
    let time: Date
    let count: Int
    
    init(date: String, count: Int) {
        self.time = date.convertToDate() ?? Date()
        self.count = count
    }
    
    static let example = HrCount(date: "2023-11-15 11:40:19",count: 120)
    
    static let examples: [HrCount] = [HrCount(date: "2023-11-15 11:40:19",count: 120),
                                      HrCount(date: "2023-11-15 11:40:22",count: 119),
                                      HrCount(date: "2023-11-15 11:40:24",count: 117),
                                      HrCount(date: "2023-11-15 11:40:27",count: 118),
                                      HrCount(date: "2023-11-15 11:40:30",count: 117),
                                      HrCount(date: "2023-11-15 11:40:32",count: 116),
                                      HrCount(date: "2023-11-15 11:40:35",count: 114),
                                      HrCount(date: "2023-11-15 11:40:38",count: 111),
                                      HrCount(date: "2023-11-15 11:40:41",count: 109),
                                      HrCount(date: "2023-11-15 11:40:44",count: 109),
                                      HrCount(date: "2023-11-15 11:40:47",count: 110),
                                      HrCount(date: "2023-11-15 11:40:49",count: 113),
                                      HrCount(date: "2023-11-15 11:40:52",count: 113),
                                      HrCount(date: "2023-11-15 11:40:55",count: 115),
                                      HrCount(date: "2023-11-15 11:40:58",count: 114)]
    
}

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        dateFormatter.calendar = Calendar.current
        return dateFormatter.date(from: self)
    }
}
