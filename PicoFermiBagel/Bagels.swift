//
//  Bagels.swift
//  PicoFermiBagel
//
//  Created by Fnu Frangky on 10/13/17.
//  Copyright © 2017 Fnu Frangky. All rights reserved.
//

import Foundation

public class Bagels {
 
    var first:Int
    var second:Int
    var third:Int
    var guess:String // user's guess
    var isPlaying:Bool
    var firstString, secondString, thirdString: String // to convert the secret number from int to string
    var secretNum:String
    var fermiScore = 0;
    var picoScore = 0;
    var numOfGuess = 0;
    var play = "" // to check if the user wants to play again or not
    
    init() {
        self.first = 0
        second = 0
        third = 0
        self.guess = ""
        isPlaying = true
        firstString = ""
        secondString = ""
        thirdString = ""
        secretNum = ""
    }
    

    public func playGame() {
        repeat {
            // generate 3 digit numbers
            generateSecretNumber()
            while isPlaying == true {
                // get user input and check the guess
                evaluateGuess()
            }
            // ask the user if the want to play again or quit
            playAgain()
        } while true // can only get out of the loop if the user quits
        
    }

    // this function generates 3 digit random numbers and convert it to string to be checked later
    private func generateSecretNumber() {
        
        print("Hello, I have a number on mind, Guess that number")
        // generate 3 random numbers
        first = Int(arc4random_uniform(9)+1)
        second = Int(arc4random_uniform(9)+1)
        third = Int(arc4random_uniform(9)+1)
        
        print ("the numbers are: \(first)\(second)\(third)")
        
        // all digits must be different and the first number cannot be 0
        while (first == second || first == third || second == third || first == 0) {
            first = Int(arc4random_uniform(9)+1)
            second = Int(arc4random_uniform(10))
            third = Int(arc4random_uniform(10))
            print ("the numbers are in side while: \(first)\(second)\(third)")
        }
        
        // turn the secret number to be a string so its easy to compare it with user's guess which is also a string
        firstString = String(first)
        secondString = String(second)
        thirdString = String(third)
        
        secretNum = firstString+secondString+thirdString
        
        //secretNum = "482"
        
        // test the secret number
        print("Secret number is \(secretNum)")
        
    }
    
    // this function evaluates the user's input
    private func evaluateGuess() {
        
        print("\nguess = ", terminator: "")
        self.guess = readLine()!;
        
        // check if the user enters more than 3 digit
        while (guess.characters.count != 3) {
            print("3 digit numbers only please")
            print("\nguess = ", terminator: "")
            self.guess = readLine()!;
        }
        
        // here means the user has tried to guess once
        numOfGuess += 1
        //check if the guess is the same as secretNum
        if guess == secretNum {
            isPlaying = false; // stop the game
            print("Good job!, you win!")
            print("You guessed \(numOfGuess) time(s)!")
            return // get out of evaluateGuess
        }
        
        
        //check for fermi
        for i in 0..<guess.count {
            if guess[guess.index(guess.startIndex, offsetBy: i)] == secretNum[secretNum.index(secretNum.startIndex, offsetBy: i)]
            {
                print("Fermi ",terminator: "")
                fermiScore += 1; //update fermi score
            }
            
            //check for Pico
            for j in 0..<guess.count {
                if guess[guess.index(guess.startIndex, offsetBy: i)] == secretNum[secretNum.index(secretNum.startIndex, offsetBy: j)]
                {
                    picoScore += 1 //update pico score
                }
            } // enf for pico
         
        } //end for fermi
        
        //make sure the program does not recognize a Fermi as Peco
        if picoScore > fermiScore {
            var diff = picoScore - fermiScore
            for _ in 1...diff {
                print("Pico ", terminator: "")
            }
        }
        
        // if there is no pico or fermi, it means bagel
        if (picoScore == 0 && fermiScore == 0)
        {
            print("Bagels ",terminator: "");
        }
        
        //reset the score each loop
        fermiScore = 0
        picoScore = 0
    }
    
    //This function checks if the user wants to play or quit the game after they win
    private func playAgain() {
        
        print("Do you want to play again? Y/N ")
        play = (readLine()?.uppercased())!
        
        //make sure the user only enters Y/N
        while (play != "Y" && play != "N") {
            print("Please answer Y or N ")
            play = (readLine()?.uppercased())!
        }
        
        if play == "Y" {
            isPlaying = true;
            numOfGuess = 0 // reset the guess counter
        } else { // if the user enters "N" exit the program
            print ("Thanks for playing!")
            exit(0)
        }
    }
}
