module DnDstats
using DataFrames 

export compare

weaponlist = DataFrame(
name = ["Club", "Dagger", "Great-Club", "Hand-Axe", "Javelin", "Light Hammer", "Mace", "Quarterstaff", "Sickle", "Spear", "Crossbow, light", "Dart", "Shortbow", "Sling", "Battleaxe", "Flail", "Glaive", "Greataxe", "Great-Sword", "Halberd", "Lance", "Long-sword", "Maul", "Morning-star", "Pike", "Rapier", "Scimitar", "Short-sword", "Trident", "War pick", "War-hammer", "Whip", "Blowgun", "Crossbow, hand", "Crossbow, heavy", "Longbow", "Net"],
cost = [0.1, 2, 0.2, 5, 0.5, 2, 5, 0.2, 1, 1, 25, 0.05, 25, 0.1, 10, 10, 20, 30, 50, 20, 10, 15, 10, 15, 5, 25, 25, 10, 5, 5, 15, 2, 10, 75, 50, 50, 1],
damagedicenumber = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
damagedicetype = [4, 4, 8, 6, 6, 4, 6, 6, 4, 6, 8, 4, 6, 4, 8, 8, 10, 12, 6, 10, 12, 8, 6, 8, 10, 8, 6, 6, 6, 8, 8, 4, 1, 6, 10, 8, 0],
damagetype = ["Bludgeoning", "Piercing", "Bludgeoning", "Slashing", "Piercing", "Bludgeoning", "Bludgeoning", "Bludgeoning", "Slashing", "Piercing", "Piercing", "Piercing", "Piercing", "Piercing", "Slashing", "Bludgeoning", "Slashing", "Slashing", "Slashing", "Slashing", "Piercing", "Slashing", "Bludgeoning", "Piercing", "Piercing", "Piercing", "Slashing", "Piercing", "Piercing", "Piercing", "Bludgeoning", "Slashing", "Piercing", "Piercing", "Piercing", "Piercing", "None"],
weight = [2, 1, 10, 2, 2, 2, 4, 4, 2, 3, 5, .25, 2, 0, 4, 2, 6, 7, 6, 6, 6, 3, 10, 4, 18, 2, 3, 2, 4, 2, 2, 3, 1, 3, 18, 2, 3],
complexity = ["simple", "simple", "simple", "simple", "simple", "simple", "simple", "simple","simple", "simple", "simple", "simple", "simple", "simple", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial", "martial"],
range = ["melee", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "ranged", "ranged", "ranged", "ranged", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "melee", "ranged", "ranged", "ranged", "ranged", "ranged"],
shortrange = [5, 20, 5, 20, 30, 20, 5, 5, 5, 20, 80, 20, 80, 30, 5, 5, 10, 5, 5, 10, 10, 5, 5, 5, 10, 5, 5, 5, 20, 5, 5, 10, 25, 30, 100, 150, 5],
longrange = [5, 60, 5, 60, 120, 60, 5, 5, 5, 60, 320, 60, 320, 120, 5, 5, 10, 5, 5, 10, 10, 5, 5, 5, 10, 5, 5, 5, 60, 5, 5, 10, 100, 120, 400, 600, 15],
ammunition = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0],
finesse = [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0],
heavy = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0],
light = [1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0],
loading = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0],
reach = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
special = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
thrown = [0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1],
twohanded = [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0],
versatile = [0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0]
), false

function chancetohit(attackbonus,ac)
    if attackbonus == "auto"
        return 1
    end
    hits = 1
    for roll in 2:19
        if roll + attackbonus >= ac
            hits = hits + 1
        end
    end
    return hits/20
end

function damage(dice,type,modifier)
    dicetypes = length(dice)
    dicedamage = 0
    for x in 1:dicetypes
        dicedamage = dicedamage + (((type[x]+1)/2)*dice[x])
    end
    return dicedamage + modifier
end

function avgdamage(attackbonus,ac,dice,type,modifier, crit = true)
    percenthit = chancetohit(attackbonus,ac)
    damageperhit = damage(dice,type,modifier)
    if crit == true
        crit = damage(2*dice,type,modifier)
        return damageperhit*(percenthit-0.05)+(crit*0.05)
    else 
        return damageperhit*percenthit    
    end
end

function damageperattack(weapon1, acrange = 8:20)
    totaldamage1 = 0
    for ac in acrange
        damage1 = avgdamage(weapon1[2], ac, weapon1[3], weapon1[4], weapon1[5], weapon1[6])
    totaldamage1 = totaldamage1 + damage1
    end
    avgdamage1 = totaldamage1/length(acrange)
    return avgdamage1
end

function compare(weapon1, weapon2, weapon1attacks, weapon2attacks, acrange = 8:20) #each weapon should be a length 6 vector [name, attackbonus, dice, type, modifier, crit]
    name1 = weapon1[1]
    name2 = weapon2[1]
    avgdamage1 = damageperattack(weapon1, acrange)*weapon1attacks
    avgdamage2 = damageperattack(weapon2, acrange)*weapon2attacks
    if avgdamage1 > avgdamage2
        println("The $name1 is more powerful than the $name2.")
        println("The $name1 deals $avgdamage1 and the $name2 deals $avgdamage2")
        return weapon1[1]
    elseif avgdamage1 < avgdamage2
        println("The $name2 is more powerful than the $name1.")
        println("The $name2 deals $avgdamage2 and the $name1 deals $avgdamage1")
        return weapon2[1]
    else
        println("The $name1 does as much damage as the $name2.")
        println("The $name1 deals $avgdamage1 and the $name2 deals $avgdamage2")
        return "Neither"        
    end 
end

end
