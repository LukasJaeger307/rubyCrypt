# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://www.wtfpl.net/ for more details.

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
        if (isPrime(p) && isPrime(q)) then
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
