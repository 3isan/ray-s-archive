// Playground - noun: a place where people can play

import UIKit



extension Array {

  func indexOfObject<T:Equatable>(object: T) -> Int {
    var searchIndex = NSNotFound
    for (counter, item) in enumerate(self) {
      if item as! T == object {
        searchIndex = counter
        break
      }
    }
    return searchIndex
  }
  
  mutating func removeObject<T:Equatable>(object: T) -> T {
    for (counter, item) in enumerate(self) {
      if item as! T == object {
        self.removeAtIndex(counter)
      }
    }
    return object
  }

  
}
var letters = ["A", "B", "C"]
if letters.indexOfObject("Z") != NSNotFound {
    letters.indexOfObject("Z")
}
if letters.indexOfObject("A") != NSNotFound {
    letters.indexOfObject("A")
}
if letters.indexOfObject("B") != NSNotFound {
    letters.indexOfObject("B")
}
if letters.indexOfObject("C") != NSNotFound {
    letters.indexOfObject("C")
}

// prints 0
// prints 1
// prints 2

//var letters = ["A", "B", "C"]
var letter = "A"
letters.removeObject(letter)
letters // prints B, C


