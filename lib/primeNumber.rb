# The MIT License (MIT)
#
# Copyright (c) 2016 LukasJaeger307
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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
    
        
