open Format
module M = Map.Make(String)
let file = "8.in"
let line_count = 200
let counter = ref 0
(* let lines = [] *)


let next_val = 
    fun (addition) ->
        (* printf "%d\n" addition; *)
        counter := (!counter) + addition;
        !counter

(* let string_rev str =
    let rec aux  idx = match idx with
        0 -> Char.escaped (str.[0])
    | _ -> (Char.escaped str.[idx]) ^ (aux (idx-1)) in
    aux ((String.length str)-1) *)
let reverse list =
    let rec reverse_aux acc = function
    | [] -> acc
    | h::t -> reverse_aux (h::acc) t
    in
    reverse_aux [] list

let rec sum = function
    | [] -> 0
    | (h::t) -> (if List.mem (String.length h) [2;3;4;7] then 1 else 0) + (sum t)

(* let rec sumInts (l : int list) : int =
    match l with
        [] -> 0
    | x :: xs -> x + (sumInts xs) *)
(* let rec sumInts l = match l with
    [] -> 0
    | h::t -> h + . (sumInts t) *)
(* let sum_l l = 
   let (r,_) = List.fold_left 
      (fun (a_l, a_i) x -> ((a_i + x) :: a_l , a_i+x))
      ([],0) l in
   List.rev r *)

let append l i = l @ [i]

let () =
    (* Read to file *)
    let ic = open_in file in
    try 
        for i = 1 to line_count do 
            let line = input_line ic in (* read line, discard \n *)
                (* line |> String.split_on_char '|' |> List.rev |> List.hd |> String.split_on_char ' ' |> List.filter (fun s -> s <> "") |> String.concat " "  |> print_endline; *)
                line |> String.split_on_char '|' |> List.rev |> List.hd |> String.trim |> String.split_on_char ' ' |> List.filter (fun s -> s <> "") |> List.fold_left (fun acc x -> acc + (if List.mem (String.length x) [2;3;4;7] then 1 else 0)) 0 |> next_val;
            
            (* write the result to stdout *)
            (* line::lines;
            print_endline line; *)
            (* line |> String.split_on_char '|' |> reverse |> List.hd |> String.split_on_char ' ' |> List.filter (fun s -> s <> "") |> List.length |> printf "%d\n" *)
        done;
        (* lines |> String.split_on_char '|' |> List.tl |> String.split_on_char ' '; *)
        (* for i = 1 to line_count do 
        done; *)
        printf "%d\n" !counter;
        (* printf "%d\n" (String.length "123"); *)
        flush stdout;             (* write on the underlying device now *)
        close_in ic               (* close the input channel *) 
    with e ->                     (* some unexpected exception occurs *)
        close_in_noerr ic;          (* emergency closing *)
        raise e                     (* exit with error: files are closed but
                                    channels are not flushed *)
