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

require 'primeNumber.rb'
require 'mod.rb'
require 'Euclid.rb'

# Contains functions for RSA encryption and decryption
module RSA
    
    def RSA.encrypt(m, e, n)
        Mod.exp(m, e, n)
    end
    
    def RSA.decrypt(m, d, n)
        Mod.exp(m, d, n)
    end
    
    def RSA.decrypt_perf(c,d, p, q)
        if q > p then
            p_tmp = p
            p = q
            q = p_tmp
        end
        mp = Mod.exp(c,d,p)
        mq = Mod.exp(c,d,q)
        euclidSet = Euclid.euclidAlgorithm(p,q)
        yp = euclidSet.s
        yq = euclidSet.t
        m = (mp * yq * q + mq * yp * p) % (p * q)
    end
end

class RSAKeySet
    attr_reader :p, :q, :n, :d, :e, :phi
     
    def initialize(p, q, e)
       updateValues(p,q,e)
    end
        
    def p= (p)
        updateValues(p, @q, @e)
    end
        
    def q= (q)
        updateValues(@p, q, @e)
    end
    
    def e= (e)
        updateValues(@p, @q, @e)
    end
        
    private
    def updateValues(p, q, e)
        if (PrimeNumber.isPrime(p) && PrimeNumber.isPrime(q)) then
            @p = p
            @q = q
            @n = p * q
            @phi = (p-1) * (q-1)
            euclidSet = Euclid.euclidAlgorithm(@phi, e)
            if euclidSet.gcd == 1 then
                @e = e
                @d = euclidSet.t % phi
            else
                @e = (2**16 - 1) % n
            end
        else 
            @p = 0
            @q = 0
            @n = 0
            @d = 0
            @phi = 0
            @e = 0
        end
    end
end
