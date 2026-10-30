/*:
## Exercise - Optionals

 >Throughout the exercises in this playground, you will be printing optional values. The Swift compiler will display a warning: "Expression implicitly coerced from `Int?` to Any." For the purposes of these exercises, you can ignore this warning.

 Imagine you have an app that asks the user to enter his/her age using the keyboard. When your app allows a user to input text, what is captured for you is given as a `String`. However, you want to store this information as an `Int`. Is it possible for the user to make a mistake and for the input to not match the type you want to store?

 Declare a constant `userInputAge` of type `String` and assign it "34e" to simulate a typo while typing age. Then declare a constant `userAge` of type `Int` and set its value using the `Int` initializer that takes an instance of `String` as input. Pass in `userInputAge` as the argument for the initializer. What error do you get?
 */
let userInputAge: String = "34e"
let userAge: Int? = Int(userInputAge)
print(userAge as Any)


//:  Go back and change the type of `userAge` to `Int?`, and print the value of `userAge`. Why is `userAge`'s value `nil`? Provide your answer in a comment or print statement below.
print(userAge as Any)
print("userAge is nil because \(userInputAge) cannot be converted to an integer.")


/*:
 Now go back and fix the typo on the value of `userInputAge`. Is there anything about the value printed that seems off?

 Print `userAge` again, but this time unwrap `userAge` using the force unwrap operator.
 */
let userInputAgeFixed = "34"
let userAgeFixed: Int? = Int(userInputAgeFixed)
print(userAgeFixed as Any)
print(userAgeFixed!)


//:  Now use optional binding to unwrap `userAge`. If `userAge` has a value, print it to the console.
if let age = userAgeFixed {
    print(age)
}


/*:
page 1 of 6  |  [Next: App Exercise - Finding a Heart Rate](@next)
 */