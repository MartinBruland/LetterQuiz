import Foundation

//GET RANDOM ELEMENT FROM LIST.
func getRandomElementFromList(array: [String]) -> String {
    
    let index = Int(arc4random_uniform(UInt32(array.count - 1)))
    let element = array[index]
    
    return element
}


//GET ELEMENT X STEPS FROM ELEMENT IN LIST.
func getElementAccordingToElementInList(array: [String], steps: Int, element: String) -> String? {
    
    if let indexOfOldElement = array.firstIndex(of: element) {
        
        //print("Element exists in Array!")
        
        let indexOfNewElement = indexOfOldElement + steps
        
        if indexOfNewElement >= array.startIndex && indexOfNewElement <= array.index(before: array.count) {
            
           //print("Element is returned!")
            return array[indexOfNewElement]
            
        } else {
            
            //print("Element is out of bounds in Array!")
            return nil
            
        }
        
    } else {
        
        //print("Element does not exist in Array!")
        return nil
        
    }
}


//GET ELEMENTS IN RANGE FROM LIST.
func getElementsInRangeFromList(array: [String], rangeStart: Int, rangeEnd: Int) -> [String] {
    
    var arrayOfElements = [String]()
    
    for index in rangeStart ... rangeEnd {
        
        if index >= array.startIndex && index <= array.index(before: array.count) {
            
            //print("Element exists in Array!")
            arrayOfElements.append(array[index])
           
        } else {
            
            //print("Element is out of bounds in Array, and does not exist!")
            
        }
    }
    
    return arrayOfElements
}


/*FIND THE INDEX OF ITEM IN ARRAY.
func findItemIndexInArray(item: String, array: [String]) -> Int {
    
    for (index, i) in array.enumerated() {
        
        if i == item {
            
            return index
            
        }
    }
}
 */
