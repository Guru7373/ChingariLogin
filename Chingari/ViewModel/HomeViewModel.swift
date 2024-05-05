//
//  HomeViewModel.swift
//  Chingari
//
//  Created by Guru on 05/05/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    
    init() {
        let post1 = Post(title: "Batman", subtitle: "Why do we fall, Bruce? So we can learn to pick ourselves up.", imageUrl: URL(string: "https://media.cnn.com/api/v1/images/stellar/prod/211227135008-02-the-batman-trailer.jpg?c=16x9&q=h_653,w_1160,c_fill/f_webp")!, videoUrl: nil)
        let post2 = Post(title: "Earth", subtitle: "Happy environment day, save our earth", imageUrl: nil,
                         videoUrl: URL(string: "https://cdn.pixabay.com/video/2021/10/05/90877-629483574_large.mp4"))
        let post3 = Post(title: "Superman", subtitle: "Jor-El and Lara, on the planet Krypton is Kal-El.", imageUrl: URL(string: "https://cdn.britannica.com/61/177761-050-F38C22B1/Christopher-Reeve-Superman-Richard-Donner.jpg")!, videoUrl: nil)
        let post4 = Post(title: "Interstellar", subtitle: "Cooper encounters the Tesseract", imageUrl: URL(string: "https://www.indiewire.com/wp-content/uploads/2014/12/interstellar-tesseract.jpg")!, videoUrl: nil)
        
        posts = [post1, post2, post3, post4]
    }
}
