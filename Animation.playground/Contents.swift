import SwiftUI
import PlaygroundSupport

struct MyView: View {
    
    @State var show = false
    
    var body: some View {
        VStack{
            Text("Animation with SwiftUI")
                .font(.headline)
                .color(.red)
                .scaleEffect(show ? 2 : 1)
                .padding(4)
            
            ZStack {
                Color.gray
                Text("ABC")
                }.frame(width: show ? 300 : 200, height: show ? 300 : 200)
                .clipped()
                .cornerRadius(show ? 0 : 30)
                .shadow(radius: 30)
            
            Button(action: {
                withAnimation {
                    self.show.toggle()
                }
            }) {
                Text("Animate")
            }
        }
    }
}

let viewController = UIHostingController(rootView: MyView())
PlaygroundPage.current.liveView = viewController
