

import SwiftUI

struct ContentView: View {
    private var posts: meal?
    @State var mealArray = [categories]()
    @State var isLoading = false
    @State private var index = 0
    init() {
        
        UINavigationBar.appearance().backgroundColor = .clear
        
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font : UIFont(name:"Helvetica Neue", size: 15)!]
        
        
    }
    var body: some View {
        NavigationView {
            ZStack{
                Image("bg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .navigationBarTitle("Home", displayMode: .inline)
                    .navigationBarHidden(false)
                    .navigationBarBackButtonHidden(true)
                    .edgesIgnoringSafeArea(.all)
                    
                VStack {
                    if !mealArray.isEmpty {
                        List{
                                ForEach(mealArray) { item in
                                    TaskRow(title: item.strCategory,imageUrl: item.strCategoryThumb, description: item.strCategoryDescription)
                                }
                            }.padding(.top,0)
                        }
                    }
                }
        }
        
            .onAppear {
                getHomeDatawithCallBack()
            }
            
        }
    private func getHomeDatawithCallBack(){
        Connection().getData(API.Meal_API, meal.self) { data in
            mealArray = data.categories
        }
    }
}

struct TaskRow: View {
    @State var title: String
    @State var imageUrl: String
    @State var description: String
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .center){
                CustomImageView(withURL: imageUrl)
                Text(title)
                
            }
            Text(description)
                .padding(.leading,10)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Sequence {
    func limit(_ max: Int) -> [Element] {
        return self.enumerated()
            .filter { $0.offset < max }
            .map { $0.element }
    }
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
