import UIKit

import UIKit

DispatchQueue.main.async {
    print("1")
    DispatchQueue.global().async {
        print("2")
        DispatchQueue.main.sync {
            print("3")
        }
    }
    print("4")

    DispatchQueue.global().sync {
        print("5")
        DispatchQueue.main.async {
            print("6")
        }
    }
    print("7")
}
