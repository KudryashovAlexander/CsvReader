import Foundation

final class HrViewModel: ObservableObject {
    
    @Published var counterData = [HrCount]()
    
    private var csvHelper = CsvHelper()
    
    var minDate: Date? {
        return counterData.first?.time
    }
    
    var maxDate: Date? {
        return counterData.last?.time
    }
    
    var maxCount: Int? {
        return counterData.max(by: { $0.count < $1.count } )?.count
    }
    
    var minCount: Int? {
        return counterData.min(by: { $0.count < $1.count } )?.count
    }
    
    var medianCount: Double? {
        Double(counterData.reduce(0) { $0 + $1.count}) / Double(counterData.count)
    }
    
    init() {
        counterData = csvHelper.hrCounts
    }
    
    static var prewiew: HrViewModel {
        let vm = HrViewModel()
        vm.counterData = HrCount.examples
        return vm
    }
}
