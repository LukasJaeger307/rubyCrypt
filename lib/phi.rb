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

require 'mod.rb'
require 'primeNumber.rb'
require 'Euclid.rb'

module Phi
    def Phi.getPhi(x)
        if PrimeNumbers.isPrime(x) then
            return x - 1
        else
            factors = PrimeNumbers.factorize(x).uniq
            phi = 1
            factors.each{|x|
                         p = x * 1.0
                         phi *= ((p-1.0) / p)
                         }
            return (phi * x).to_i
        end
    end
    
    def Phi.findPrimeRestClasses(x)
        numRange = 1..x
        candidates = []
        numRange.each{|y|
            euclidSet = Euclid.euclidAlgorithm(x,y)
            if euclidSet.gcd == 1 then
                candidates << y
            end
        }
        return candidates
    end
    
    def Phi.getOrder(x, mod)
        if x < mod then
            groupOrder = getPhi(mod)
            factors = PrimeNumbers.factorize(groupOrder)
            dividers = factors.uniq
            fArray = Hash.new
            dividers.each do|p|
                exponent = getExponentToPrimeFactor(factors,p)
                fCandidates = 0..exponent
                f = 0
                fCandidates.each do|candidate|
                    exp = groupOrder / p**candidate
                    if Mod.exp(x, exp, mod) == 1 then
                        f = candidate
                    end
                end
                fArray[p] = f
            end
            order = 1
            fArray.each do |p,f|
                e = getExponentToPrimeFactor(factors, p)
                order = Mod.mul(order, Mod.exp(p, e-f, mod), mod)
            end
            return order
        else
            return 0
        end
    end
    
    def Phi.getExponentToPrimeFactor(factors, factor)
        result = 0
        factors.each{|x|
                    if x == factor then
                       result += 1
                    end
                     }
        return result
    end
end
