import UIKit

// Roman Kolosov
// Preparation for interview course home work 4

// Task 1
//  Create a singly linked list with a loop
//  Detect a loop in the list and its begin value
//  Remove the loop from the list

// MARK: - Public collections

enum LoopReport {
    case loopCheck(loopFound: Bool, withBeginValue: Int?)
}

enum PushNodeError: Error {
    case noMemoryAllocated
}

// MARK: - Public classes

final class Node {
    let value: Int
    var nextNode: Node?

    init(value: Int, nextNode: Node? = nil) {
        self.value = value
        self.nextNode = nextNode
    }
}

final class SinglyLinkedList {
    var firstNode: Node?

    init(firstNode: Node? = nil) {
        self.firstNode = firstNode
    }
}

// MARK: - Major public functions

// MARK: Working with stack functions

// Push a node in the singly linked list in a stack way.
func pushNode(value: Int, list: SinglyLinkedList) throws {
    guard let currentNode = list.firstNode else {
        let firstNode = Node(value: value)
        list.firstNode = firstNode
        return
    }
    let newNode = Node(value: value, nextNode: currentNode)
    list.firstNode = newNode
}

// Pop a node in the singly linked list in a stack way.
func popNode(list: SinglyLinkedList) -> Int? {
    guard let currentNode = list.firstNode else {
        print("Stack is empty")
        return nil
    }
    list.firstNode = currentNode.nextNode

    return currentNode.value
}

// Print nodes in the singly linked list in a stack way.
func printNodes(list: SinglyLinkedList) {
    guard var entity = list.firstNode else {
        print("Stack is empty")
        return
    }
    var isContinue = true

    repeat {
        print("\(entity.value)", terminator: "<-")
        guard let newEntity = entity.nextNode else {
            isContinue = false
            print("\n")
            return
        }
        entity = newEntity

    } while isContinue
}

// MARK: Working with loop functions

func detectLoopAndFindBegin(head: Node ) -> LoopReport {
    var slowPtr: Node? = head
    var fastPtr: Node? = head.nextNode
    var loopExists: Bool = false
    var loopBeginValue: Int? = nil

    while (slowPtr != nil) {
        while (fastPtr != nil) {
//             print("slow pointer: ", (slowPtr?.value) ?? 0,
//                 "fast pointer: ", (fastPtr?.value) ?? 0)

            guard (slowPtr?.value == fastPtr?.value) else {
                fastPtr = fastPtr?.nextNode
                continue
            }
            loopExists = true
            loopBeginValue = slowPtr?.value

            print("Loop found")
            print("Loop starts at the node added lately in the stack described as\n",
                  slowPtr?.description ?? "")
            print("Loop ends at the node added earlier in the stack described as\n",
                  fastPtr?.description ?? "")
            fastPtr = fastPtr?.nextNode
        }
        slowPtr = slowPtr?.nextNode
        fastPtr = slowPtr?.nextNode
    }
    return .loopCheck(loopFound: loopExists, withBeginValue: loopBeginValue)
}

func resolveLoop(in list: SinglyLinkedList, with loopBeginValue: Int) {
    var valueArr: Array<Int> = [Int]()

    repeat {
        guard let currentNode = list.firstNode else {
            print("\nThe stack checked for the loop resolving. No loops found")
            break
        }
        guard currentNode.value != loopBeginValue else {
            popNode(list: list)
            print("\nLoop resolved")
            break
        }
        valueArr.append(currentNode.value)
        popNode(list: list)

    } while (true)

    valueArr.reversed().forEach {
        do {
            try pushNode(value: $0, list: list)
        } catch {
            print(PushNodeError.noMemoryAllocated)
        }
    }
}

// MARK: - Extensions

// Decribe Node type object.
extension Node: CustomStringConvertible {
    var description: String {
        // The address of allocated memory of the Node.
        let message = "Node \(Unmanaged.passUnretained(self).toOpaque()) has value \(value) with "

        guard let nextNode = nextNode else {
            return message + "no next node"
        }
        return message + "next node value \(nextNode.value)"
    }
}

// Describe SinglyLinkedList type object.
extension SinglyLinkedList: CustomStringConvertible {
    var description: String {
        // The address of allocated memory of the SinglyLinkedList.
        var description = "List \(Unmanaged.passUnretained(self).toOpaque()) has "

        guard var node = firstNode else {
            return description + "no nodes"
        }
        description += "nodes:\n"
        var isContinue = true

        repeat {
            description += (node.description + "\n")
            guard let nextNode = node.nextNode else {
                isContinue = false
                return description
            }
            node = nextNode
            
        } while isContinue
        return description
    }
}

// MARK: - Implementation of the home work tasks

print("Stack creation on the base of the singly linked list\n")

// Create SinglyLinkedList type instance.
let singlyLinkedlist = SinglyLinkedList()

// Create a stack: 1->2->3->4->5->2->10->11->12.
(1...5).map {
    do {
        try pushNode(value: $0, list: singlyLinkedlist)
    } catch {
        print(PushNodeError.noMemoryAllocated)
    }
}
// Add a loop to a value of 2 which is already in the stack.
do {
    try pushNode(value: 2, list: singlyLinkedlist)
} catch {
    print(PushNodeError.noMemoryAllocated)
}
// Add more nodes after the loop.
(10...12).map {
    do {
        try pushNode(value: $0, list: singlyLinkedlist)
    } catch {
        print(PushNodeError.noMemoryAllocated)
    }
}

print("Singly linked list stack")
printNodes(list: singlyLinkedlist)
print(String(describing:singlyLinkedlist))

// Find a loop in the singlyLinkedlist.
let loopReport = detectLoopAndFindBegin(head: singlyLinkedlist.firstNode!)
var loopBeginValue: Int = 0

switch loopReport {
case let .loopCheck(loopFound: loopFound, withBeginValue: begiiValue):
    if loopFound {
        loopBeginValue = begiiValue ?? 0
        print("\nLoop found with begin value ", begiiValue ?? 0)
    } else {
        print("Loop is not found")
    }
}

// Resolve a loop in the singlyLinkedlist.
resolveLoop(in: singlyLinkedlist, with: loopBeginValue)

printNodes(list: singlyLinkedlist)
print(singlyLinkedlist.description)

// Check for a loop in the singlyLinkedlist after its resolving.
let loopReport2 = detectLoopAndFindBegin(head: singlyLinkedlist.firstNode!)

switch loopReport2 {
case let .loopCheck(loopFound: loopFound, withBeginValue: begiiValue):
    if loopFound {
        loopBeginValue = begiiValue ?? 0
        print("\nLoop found with begin value ", begiiValue ?? 0)
    } else {
        print("Loop is not found")
    }
}


// Tast 2, about eight coins.
// Среди восьми млонет одна фальшивая отличного веса. Найти ее при помощи минимального количества всзвешиваний.

/*
 Задача решается путем динамического программирования.
 Монеты разбиваются на три кучи 2 + 3 + 3.
 Далее всзвешиваются две кучки по 3 монеты. Если они уроавновешены то фальшивая монета в куче где две монеты.
 Мы не знаем фальшивая монета тяжелее или легче подлинной. Поэтому берем одну монету из кучи где гарантированно подлинные монеты и взвешиваем ее с каждой монетой из кучи где одна фальшивая.
 Подлинные уроановесятся а фальшивая отклонится от чаши весов с подлинной монетой.
 
 Если весы отклонились при взвешивании кучек по 3 монеты, то их надо тоже разбить на 3 кучи и дальше применить алгоритм описанный выше.
 
 Таким образом, при решении этой задачи наблюдается рекурсивная последовательность.
 Следовательно, задачу можно решить, используя рекурсивные функции.
*/
 
