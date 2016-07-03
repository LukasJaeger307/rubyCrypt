require 'Mod.rb'
require 'Phi.rb'
require 'PrimeNumbers.rb'

module ElGamal
end

class ElGamalKeySet
    def initialize(prime, primeRoot, a)
        if PrimeNumbers.isPrime(prime) && Phi.isPrimeRoot(primeRoot, prime) then
            @A = Mod.exp(primeRoot, a, prime)
        else
            return nil;
        end
    end
    
        
end
