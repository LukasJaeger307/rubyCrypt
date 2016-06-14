# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://www.wtfpl.net/ for more details.

# Gets all prime numbers in the inclusive range between 2 and upperBound
def findPrimes(upperBound)
    primes = []
    numRange = 2..upperBound
    numRange.each{|x|
        isPrime = true
        primes.each{|y|
            if x % y == 0 then
                   isPrime = false
                   break
            end
        }
        if isPrime then
        primes << x
    end
    }
    primes
end

# Tests, whether or not x is a prime number
def isPrime(x)
    if x < 2 then 
        return false
    end
    upperBound = Math.sqrt(x)
    primes = findPrimes(upperBound)
    for prime in primes 
        if x % prime == 0 then
            return false
        end
    end
    return true
end

# Factorizes x and returns an array with the factors
def factorize (x)
    factors = [x]
    while isPrime(factors[-1]) == false do
        num = factors[-1]
        upperBound = Math.sqrt(num)
        primes = findPrimes(upperBound)
        for prime in primes
            if num % prime == 0
                factors[-1] = prime
                factors << num / prime
                break
            end
        end
    end
    factors
end
    
        
