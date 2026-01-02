import Foundation

func checkNumber(_ number: Int) -> String {
   let mapping: [(Int, String)] = [
       (3, "fizz"),
       (5, "buzz"),
       (7, "rizz"),
   ]

   var firstWord = false
   var result = ""

   for (denominator, text) in mapping {
       if number % denominator == 0 {
          if !firstWord {
             result += " "
          }

          result += text
          firstWord = false
       }
   }

   return result
}

guard
    CommandLine.arguments.count == 2,
    let number = Int(CommandLine.arguments[1])
else {
    print("Usage: program <number>")
    exit(1)
}

print(checkNumber(number))
