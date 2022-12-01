mutable struct Elf
    snacks::Vector{Int}
end

Elf() = Elf(Vector{Int}())

function init!(elf::Elf, snacks::Vector{Int})
    elf.snacks = snacks
end

function total_calories(elf::Elf)
    sum(elf.snacks)
end

function Base.read(fpath::String, ::Type{Vector{Elf}})
    file = read(fpath, String)
    str_array = split.(file, '\n'; keepempty=true)
    str_array = replace.(str_array, "\r" => "")
    elfs = Vector{Elf}()
    elf = Elf()
    foreach(str -> (
        if str != ""
            push!(elf.snacks, parse(Int, str))
        else
            push!(elfs, elf)
            elf = Elf()
        end
    ), str_array)
    elfs
end

function get_max()
    elfs = read("calories.txt", Vector{Elf})
    max_cals = map(elf -> total_calories(elf), elfs)
    println(max_cals)
end

function get_three_highest()
    elfs = read("calories.txt", Vector{Elf})
    max_cals = map(elf -> total_calories(elf), elfs)
    sort!(max_cals)
    println(sum(max_cals[end-2:end]))
end