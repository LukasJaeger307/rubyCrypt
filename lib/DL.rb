require 'Mod.rb'
require 'Euclid.rb'
require 'Phi.rb'
require 'PrimeNumbers.rb'

module DL
    def DL.shanks(number, base, n)
        #Inverting base
        euclidSet = Euclid.euclidAlgorithm(n, base)
        base_inv = euclidSet.t
        m = Math.sqrt(n).ceil
        b = Hash.new(-1)
        bRange = 0..m-1
        bRange.each do |r|
            entry = Mod.mul(number, Mod.exp(base_inv, r, n),n)
            if entry == 1 then
                return r
            else
                b[entry]= r
            end
        end
        delta = Mod.exp(base, m, 2017)
        check = -1
        q = 0
        index = 1
        while check == -1 do
            q += 1
            index = Mod.exp(delta, q, n)
            check = b[index]
        end
        x = Mod.add(Mod.mul(q,m, n),check,n)
    end
    
    ##BUGGY! In cases of doubt rely on shanks. (See number = 33, base = 2, n = 53. Should be 23, but is 0    
    def DL.pollardRho(number, base, n)
        divider = n / 3
        g1 = 0..divider
        g2 = divider+1..2*divider
        g3 = 2*divider..n-1
        left = 3
        right = 5
        phi = Phi.getPhi(n)
        euclidSet = Euclid.euclidAlgorithm(phi,left)
        while right % euclidSet.gcd != 0 do
            xOld = Random.rand(n-1) + 1
            yOld = 0
            indexOld = 0
            betaOld = Mod.exp(base,xOld, n)
            x = DL.pollardXi(xOld, betaOld, g1, g2, g3, phi)
            y = DL.pollardYi(yOld, betaOld, g1, g2, g3, phi)
            index = 1
            beta = Mod.mul(Mod.exp(base,x,n),Mod.exp(number, y, n),n)
            while beta != betaOld do
                if index >= indexOld * 2 then
                    indexOld = index
                    betaOld = beta
                    xOld = x
                    yOld = y
                end
                x = DL.pollardXi(x, beta, g1, g2, g3, phi)
                y = DL.pollardYi(y, beta, g1, g2, g3, phi)
                beta = Mod.mul(Mod.exp(base,x,n),Mod.exp(number, y, n),n)
                index +=1
                    
            end
            right = Mod.sub(xOld, x, phi)
            left = Mod.sub(y, yOld, phi)
            euclidSet = Euclid.euclidAlgorithm(phi, left)
        end
        smallerLeft = left / euclidSet.gcd
        smallerRight = right / euclidSet.gcd
        smallerMod = n / euclidSet.gcd
        zRange = 0..smallerMod
        z = 0
        zRange.each do |x|
            if Mod.mul(smallerLeft, x,smallerMod) == smallerRight && z == 0 then 
                z = x
                break
            end
        end
        puts z
        xRange = 0..euclidSet.gcd-1
        xRange.each do |k|
            candidate = Mod.add(z, Mod.mul(k, smallerMod,n),n)
            if Mod.exp(base, candidate,n) == number then
                return candidate
            end
        end
        return 0
    end
    
    def DL.pollardXi(x,beta, g1, g2, g3,n)
        if g1 === beta then
            return Mod.add(x,1,n)
        elsif g2 === beta then
            return Mod.mul(x, 2, n)
        elsif g3 === beta then
            return x
        else return 0
        end
    end
    
    def DL.pollardYi(y,beta, g1, g2, g3,n)
        if g1 === beta then
            return y
        elsif g2 === beta then
            return Mod.mul(y, 2, n)
        elsif g3 === beta then
            return Mod.add(y,1,n)
        else return 0
        end
    end
    
    def DL.pohligHellman(number, base, n)
        phi = Phi.getPhi(n)
        factors = PrimeNumbers.factorizeWithExponents(phi)
        mods = Hash.new(0)
        factors.keys.each do |p|
            ep = factors[p]
            np = phi / p**ep
            baseP = Mod.exp(base, np, n)
            numberP = Mod.exp(number, np, n)
            xp = getXP(numberP, baseP, p, ep, n)
            mods[p**factors[p]] = xp
        end
        return Euclid.chineseRemainderTheorem(mods)
    end
    
    def DL.getXP(numberP, baseP, p, ep, n)
        baseExp = Mod.exp(p, ep-1, n)
        numberExp = baseExp
        invBase = Euclid.euclidAlgorithm(n,baseP).t
        localNumber = numberP
        localBase = Mod.exp(baseP, baseExp, n)
        numberIExp = 0
        x = Hash.new
        iRange = 0..ep-1
        iRange.each do|i|
            numberExp = Mod.exp(p,ep-i-1,n)
            shanksNum = Mod.exp(localNumber, numberExp, n)
            localLog = shanks(shanksNum,localBase, n)
            x[i] = localLog
            numberIExp += Mod.mul(Mod.exp(p,i,n), localLog, n)
            localNumber = Mod.mul(numberP, Mod.exp(invBase,numberIExp,n),n)
        end
        result = 0
        x.keys.each do |i|
            result += Mod.mul(x[i],Mod.exp(p,i,n),n)
        end
        return result
    end
    
    def DL.primeExp(number, base, n)
        phi = Phi.getPhi(n)
        factors = PrimeNumbers.factorizeWithExponents(phi)
        mods = Hash.new(0)
        factors.keys.each do |p|
            ep = factors[p]
            np = phi / p**ep
            baseP = Mod.exp(base, np, n)
            numberP = Mod.exp(number, np, n)
            xp = shanks(numberP, baseP, n)
            mods[p**factors[p]] = xp
        end
        return Euclid.chineseRemainderTheorem(mods)
    end
end
