// Learn more about F# at http://fsharp.org

open System
open System.IO
open System.Collections.Generic

let rec transpose = function
    | (_::_)::char as M -> 
        List.map List.head M :: transpose (List.map List.tail M)
    | _ -> []
// let transpose2 (mtx : _ [,]) = Array2D.init (mtx.GetLength 1) (mtx.GetLength 0) (fun x y -> mtx.[y,x])

let inline charToInt c: int = int c - int '0'

type Data(fp: string) =
    member x.Read() =
        // Read in a file with StreamReader.
        use stream = new StreamReader (fp)
        let length = String.length "101000001100"
        let fileLength = 1000
        let dataArray = new List<string>(length)

        // Continue reading while valid lines.
        let mutable valid = true
        while (valid) do
            let line = stream.ReadLine()
            if (line = null) then
                valid <- false
            else
                dataArray.Add(line)
                // printfn "%A" line

        // accumulator for item at line[i]
        let newArray = transpose(dataArray |> Seq.map (fun line -> Seq.toList line |> Seq.map (charToInt) |> Seq.toList) |> Seq.toList )
        /// map for Lists
        // has type : ('a -> 'b) -> 'a list -> 'b list
        let counterArray = newArray |> Seq.map (fun line -> Seq.toList line |> List.fold (+) 0) |> Seq.rev
        // let counterArray = dataArray |> Seq.sumBy int |> List.toSeq
        // counterArray |> Seq.iter (printf "%d ")
        let gamma = counterArray |> Seq.mapi(fun index item -> if item > 500 then 1 * (pown 2 index) else 0) |>  Seq.reduce(fun acc item -> acc + item)
        let epsilon = counterArray |> Seq.mapi(fun index item -> if item > 500 then 0 else 1 * (pown 2 index) ) |>  Seq.reduce(fun acc item -> acc + item)
        printf "%d " (gamma * epsilon)

[<EntryPoint>]
let main argv =
    printfn "Calculating"
    let filePath = "3.in"
    let data = Data(filePath)
    data.Read()
    0 // return an integer exit code
