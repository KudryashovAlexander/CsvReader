import Charts
import SwiftUI

struct CounterDetailView: View {
    
    @ObservedObject var viewModel: HrViewModel
    @State private var selectedDateValue: HrCount?
    @State private var chartColor: Color = .green
    @State private var chartName: String = "График 1"
    @State private var medianHrIsShow = true
    @State private var showPoints = true
    
    private enum Constants {
        static let yScaleDomain = 10
    }
    
    var body: some View {
        if let minDate = viewModel.minDate,
           let maxDate = viewModel.maxDate,
           let minCount = viewModel.minCount,
           let maxCount = viewModel.maxCount {
            VStack {
                Chart(viewModel.counterData) { data in
            
                    if showPoints {
                        Plot {
                            LineMark(x: .value("time", data.time),
                                     y: .value("count", data.count))
                            .symbol(by: .value("Count", chartName))
                            .foregroundStyle(by: .value("Count", chartName))
                        }
                    } else {
                        Plot {
                            LineMark(x: .value("time", data.time),
                                     y: .value("count", data.count))
                            .foregroundStyle(by: .value("Count", chartName))
                        }
                    }
                    
                    if let selectedDateValue, selectedDateValue.id == data.id {
                        RuleMark(x: .value("Selected Date", selectedDateValue.time))
                            .foregroundStyle(Color.gray.opacity(0.3))
                            .zIndex(-1)
                            .annotation(position: .top,
                                        spacing: 10,
                                        overflowResolution: .init(x:.fit(to: .chart),
                                                                  y: .disabled)) {
                                selectionPopOver
                            }
                    }
                    if medianHrIsShow {
                        if let medianCount = viewModel.medianCount {
                            RuleMark(y:.value("median", medianCount))
                                .annotation(position: .top, alignment: .trailing) {
                                    Text("Median: \(String(format:"%.2f", medianCount))")
                                        .font(.body.bold())
                                        .foregroundStyle(.indigo)
                                }
                        }
                        
                    }
                }
                .aspectRatio(1, contentMode: .fit)
                .chartForegroundStyleScale([chartName: chartColor])
                .chartXScale(domain: minDate...maxDate)
                .chartYScale(domain: (minCount-Constants.yScaleDomain)...(maxCount+Constants.yScaleDomain))
                .chartOverlay(content: { proxy in
                    GeometryReader { innerProxy in
                        Rectangle()
                            .fill(.clear).contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        let location = value.location
                                        if let date: Date = proxy.value(atX: location.x) {
                                                                                        
                                            let calendar = Calendar.current
                                            let year = calendar.component(.year, from: date)
                                            let month = calendar.component(.month, from: date)
                                            let day = calendar.component(.day, from: date)
                                            let hour = calendar.component(.hour, from: date)
                                            let minute = calendar.component(.minute, from: date)
                                            let second = calendar.component(.second, from: date)
                                            
                                            if let currentItem = viewModel.counterData.first(where: { item in
                                                calendar.component(.year, from: item.time) == year &&
                                                calendar.component(.month, from: item.time) == month &&
                                                calendar.component(.day, from: item.time) == day &&
                                                calendar.component(.hour, from: item.time) == hour &&
                                                calendar.component(.minute, from: item.time) == minute &&
                                                calendar.component(.second, from: item.time) == second
                                            }) {
                                                selectedDateValue = currentItem
                                            }
                                        }
                                    }.onEnded { value in
                                        self.selectedDateValue = nil
                                    }
                            )
                    }
                })
                
                Toggle(medianHrIsShow ? "Скрыть медиану" : "Показать медиану" ,
                       isOn: $medianHrIsShow.animation())
                Toggle(showPoints ? "Скрыть контрольные точки" : "Показать контрольные точки",
                       isOn: $showPoints.animation())
                
                HStack {
                    Text("Выберите цвет")
                    Spacer()
                    ForEach(ChartsColor.allCases) { color in
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 30, height: 30)
                            .foregroundColor(color.color)
                            .onTapGesture {
                                chartColor = color.color
                            }
                    }
                }

                HStack {
                    Text("Название графика")
                    Spacer()
                    TextField("Наименование", text: $chartName)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
    }
    
    @ViewBuilder
    var selectionPopOver: some View {
        if let selectedDateValue {
            VStack{
                Text("\(selectedDateValue.time.formatted(.dateTime.day().month().hour().minute().second()))")
                Text("\(selectedDateValue.count)")
                    .bold()
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .shadow(color: chartColor, radius: 2)
            }
        }
    }
}

#Preview {
    CounterDetailView(viewModel: .prewiew)
        .padding()
}
