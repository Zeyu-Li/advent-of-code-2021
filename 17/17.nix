# run with `nix-instantiate --eval 17.nix`

# source: dude just trust me this works
let
 # abs : int -> int
 abs = x: 
   if x < 0 then (-x)
            else x;

 min = -154;
in
 abs(min) * abs(min + 1) / 2
