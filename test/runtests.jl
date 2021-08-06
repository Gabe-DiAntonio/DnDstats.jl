using DnDstats
using Test

@testset "DnDstats.jl" begin
    # Write your tests here.
    # Write your tests here.
    shortsword = ["shortsword",5,1,6,3,true]
    greataxe = ["greataxe",5,1,12,3,true]
    flail = ["flail",5,1,8,3,true]
    magicmissile = ["Magic Missile", "auto", 1, 4, 1, false]
    chromaticorb = ["Chromatic Orb", 5, 3, 8, 0, false]
    @test compare(shortsword,greataxe, 1, 1) == "greataxe"
    @test compare(shortsword,flail, 1, 1) == "flail"
    @test compare(shortsword,shortsword, 1, 1) == "Neither"
    @test compare(magicmissile, chromaticorb, 3, 1, 12) == "Magic Missile"
end
