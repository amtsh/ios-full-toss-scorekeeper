import SwiftUI

struct ToBeDeleted: View {
  @State private var isSheetPresented = false

  var body: some View {
    VStack {
      Button("Open Bottom Sheet") {
        isSheetPresented.toggle()
      }
      .padding()

      Spacer()
    }
    .sheet(isPresented: $isSheetPresented) {
      BottomSheetView()
        .presentationDetents([.fraction(0.75), .large])
        .presentationDragIndicator(.visible)
    }
  }
}

struct BottomSheetView: View {
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    VStack {
      Text("Bottom Sheet Content")
        .font(.headline)
        .padding()

      Button("Close") {
        dismiss()
      }
      .foregroundColor(.white)
      .cornerRadius(10)
      .padding(.horizontal)
    }
    .background(Color.white)
//    .ignoresSafeArea()
  }
}

struct ToBeDeleted_Previews: PreviewProvider {

static var previews: some View {
  ToBeDeleted()
  }
}
