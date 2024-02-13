import SwiftUI
import Charts
import CoreData

struct ContentView: View {

    var body: some View {
        VStack {
            CounterDetailView(viewModel: HrViewModel())
        }
        .padding()
    }

}

#Preview {
    ContentView()
}
