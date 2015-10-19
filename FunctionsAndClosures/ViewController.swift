//
//  ViewController.swift
//  FunctionsAndClosures
//
//  Created by FrankLiu on 15/10/16.
//  Copyright © 2015年 刘大帅. All rights reserved.
//

import UIKit

// 省略外部参数名用"_"
func someFunction(firstParameterName: Int, _ secondParameterName: Int) {

    print("\(firstParameterName),\(secondParameterName)")
}

// 函数参数增加缺省值
func aFunction(paremeterWithDefault: Int = 12) {

    print("\(paremeterWithDefault)")
}

// 参数数量可变
func arithmeticMean(numbers: Double...) -> Double {

    var total: Double = 0
    
    for number in numbers {
    
        total += number
    }
    
    return total / Double(numbers.count)
}

// 形参作为变量
func aliginRight(var string: String, totalLength: Int, pad: Character) -> String {

    let amountToPad = totalLength - string.characters.count
    
    if amountToPad < 1 {
    
       return string
    }
    
    let padString = String(pad)
    
    for _ in 1 ... amountToPad {
    
        string = padString + string
    }
    
    return string
}

// 函数操作实参
func swapTwoInts(inout a: Int, inout b: Int) {

    let temporyA = a
    
    a = b
    
    b = temporyA
}

// 函数类型
func addTwoInts(a: Int, _ b: Int) -> Int {

    return a + b
}

func multiplyTwoInts(a: Int, b: Int) -> Int {

    return a * b
}

// 函数作为参数
func printMathResult(mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {

    print("Result: \(mathFunction(a, b))")
}

func stepForward(input: Int) -> Int {

    return input + 1
}

func stepBackward(input: Int) -> Int {

    return input - 1
}

// 函数作为返回值
func chooseStepFunction(backwards: Bool) -> (Int) -> Int {

    return backwards ? stepBackward : stepForward
}

// 嵌套函数
func anotherChooseStepFunction(backwards: Bool) -> (Int) -> Int {

    func stepForward(input: Int) -> Int {
    
        return input + 1
    }
    
    func stepBackward(input: Int) -> Int {
    
        return input - 1
    }
    
    return backwards ? stepBackward : stepForward
}

// 闭包
// 闭包形式
//    {(<#parameters#>) -> <#returen type#> in
//    
//        <#statements#>
//    }

func backwards(s1: String, s2: String) -> Bool {

    return s1 > s2
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* ------------------------------------------
        * 省略外部参数名
        * ------------------------------------------*/
        someFunction(1, 2)
        // 打印 "1,2"
        
        /* ------------------------------------------
        * 函数参数增加缺省值
        * ------------------------------------------*/
        aFunction()
        // 打印 "12"
        
        aFunction(22)
        // 打印 "22"
        
        /* ------------------------------------------
        * 参数数量可变
        * ------------------------------------------*/
        print("\(arithmeticMean(1, 2, 3, 4, 5))")
        // 打印 "3.0"
    
        /* ------------------------------------------
        * 形参作为变量
        * ------------------------------------------*/
        let aliginString = aliginRight("hello", totalLength: 10, pad: "*")
        
        print(aliginString)
       // 打印 "*****hello"
        
        /* ------------------------------------------
        * 函数操作实参
        * ------------------------------------------*/
        var someInt = 3
        
        var anotherInt = 10
        
        swapTwoInts(&someInt, b: &anotherInt)
        
        print(" now someInt is \(someInt),anotherInt is \(anotherInt) ")
        // 打印 " now someInt is 10,anotherInt is 3"
        
        /* ------------------------------------------
        * 函数作为数据类型
        * ------------------------------------------*/
        var mathFunction:(Int, Int) -> Int = addTwoInts
        
        print("Result: \(mathFunction(2, 3))")
        // 打印 "Result: 5"
        
        mathFunction = multiplyTwoInts
        print("Result: \(mathFunction(2, 3))")
        // 打印 "Result: 6"
        
        /* ------------------------------------------
        * 函数作为参数
        * ------------------------------------------*/
        printMathResult(addTwoInts, 3, 5)
        // 打印 "Result: 8"
        
        /* ------------------------------------------
        * 函数作为返回值
        * ------------------------------------------*/
        var currentValue = 3
        
        let moveNearerToZero = chooseStepFunction(currentValue > 0)
        
        while currentValue != 0 {
        
            print("\(currentValue)...")
            
            currentValue = moveNearerToZero(currentValue)
        }
        
        print("Zero!")
        
        /* ------------------------------------------
        * 闭包
        * ------------------------------------------*/
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        var reversed = names.sort(backwards)

        print(reversed)
        // 打印 "["Ewa", "Daniella", "Chris", "Barry", "Alex"]"
        
        // 闭包实现
        reversed = names.sort({
            
            (s1: String, s2: String) -> Bool in return s1 > s2
        })
        
        // 简化
        reversed = names.sort({
        
            s1, s2 in return s1 > s2
        })
        
        // 单行表达式可以进一步简化
        reversed = names.sort({
        
            s1, s2 in s1 > s2
        })
        
        // 再次简化
        reversed = names.sort({
        
            $0 > $1
        })
        
        // 最简
        reversed = names.sort(>)
        
        /* ------------------------------------------
        * 尾随闭包(Trailing Closure)
        * ------------------------------------------*/
        
        //拥有闭包的函数
        func someFunctionThatTakesAClosure(closure: () -> Void) {
        
            // 函数体
        }
        
        // 没有使用尾随
        someFunctionThatTakesAClosure({
        
            // 实现
        })
        
        // 使用尾随
        someFunctionThatTakesAClosure() {
        
            // 实现
        }
        
        // 尾随举例
        reversed = names.sort() {$0 > $1}
        
        // 如果闭包是函数的唯一参数,则函数的括号可省
        reversed = names.sort {$0 > $1}
        
        let digitNames = [
        
            0: "Zero",
            1: "One",
            2: "Two",
            3: "Three",
            4: "Four",
            5: "Five",
            6: "Six",
            7: "Seven",
            8: "Eight",
            9: "Nine"
        ]
        
        let numbers = [16, 58, 510]
        
        let stringNumbers = numbers.map {
        
            (var number) -> String in
            
            var output = ""
            
            while number > 0 {
            
                output = digitNames[number % 10]! + output
                
                number /= 10
            }
            
            return output
        }
        
        print(stringNumbers)
        
    // 函数和闭包是值类型,意味着它可以捕获并引用上下文变量的值
        
        var runningTotal = 0
        
        func makeIncreamenter(forIncrement amout: Int) -> () -> Int {
        
            
            
            func increment() -> Int {
            
                runningTotal += amout
                
                return runningTotal
            }
            
            return increment
        }
        
        let incrementByTen = makeIncreamenter(forIncrement: 10)
        
        print(incrementByTen())
        // 打印 "10"
        
        print(incrementByTen())
        // 打印 "20"
        
        print(runningTotal)
        // 打印 "20"
        
        runningTotal = 100
        
        print(incrementByTen())
        // 打印 "110"
        
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        func serveCustomer(customerProvider: () -> String) {
        
            print("Now serving \(customerProvider())!")
        }
        
        serveCustomer({ customersInLine.removeAtIndex(0) })
        
        // @autoclosure 改变上面的函数,可以省略{}
        func anoterServeCustomers(@autoclosure customerProvider: () -> String) {
        
            print("Now serving \(customerProvider())!")
        }
        
        anoterServeCustomers(customersInLine.removeAtIndex(0))
        
        // @autoclosure默认@noescape,即闭包不可让外部使用
        // 若让外部使用,则用@autoclosure(escaping)修饰
        var customerProviders: [() -> String] = []
        
        func collectCustmoerProviders(@autoclosure(escaping) customerProvider: () -> String) {
        
            customerProviders.append(customerProvider)
            
            print("Collected \(customerProviders.count) closure")
        }
        
        collectCustmoerProviders(customersInLine.removeAtIndex(0))
        
        collectCustmoerProviders(customersInLine.removeAtIndex(0))
        
        for customerProvider in customerProviders {
        
            print("Now serving \(customerProvider())!")
        }
        
        
    }


}

