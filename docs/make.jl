using Documenter, SciMLIterators

makedocs(
    sitename = "SciMLIterators.jl",
    modules = [SciMLIterators],
    pages = [
        "Home" => "index.md",
    ],
)

deploydocs(
    repo = "github.com/SciML/SciMLIterators.jl.git",
)
