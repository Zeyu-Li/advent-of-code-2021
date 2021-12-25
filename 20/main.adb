-- run with `gnat make 20.adb && ./20`
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;
use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Ada.Strings;
use Ada.Strings.Fixed;


procedure Main is
    Fp         : File_Type;
    File_Name : constant String := "20.in";
    Dark : constant String := "#";
    Lookup : constant String := "#.#....########.......##..##.#.#####...#..#..##.###.##.#..##.....#.#....#...####.#...#.##.#.#.#....###...#.##.#...#.#....#...#.#..#....###.##.....#.######.#.##.#..####..#...#.##.##...#....###..#.##..###..#..#.....#.###.##....##...#....###.#.......#.#####...#.##..###....##.#.##..##.######...##..##.#..###.###.....###...##.##.#..#...##..#.###..#..###..##...#...#.#..#..#..##....###...........###.#....#######...#####.#..##...#..#....##.##.#.###...####...#.#..#...#.##.#.#..#.###.#.#####.#.##.###.##..#..#...###.#.";
    Map : array(1..100) of String(1..100);
    count : Positive;
    counter : Integer := 0;
    size : Positive := 100;
begin
    -- get file
    count := 1;
    Open (Fp, In_File, File_Name);
    while not End_Of_File (Fp) loop
        -- Put_Line (Get_Line(Fp));
        Map(count) := Get_Line(Fp)(1..100);
        count := count + 1;
        -- Put_Line (Integer'Image( Integer'Value("16#" & Get_Line(Fp) & "#") ));
    end loop;
    Close (Fp);

    -- calculate
    for i in 1 .. 2 loop
        -- for each cell
        -- will flip twice so keep dark
        for i in 1 .. size loop
            counter := counter + Ada.Strings.Fixed.Count (Source => Map(i), Pattern => Dark);
            -- Put_Line (Map(i));
        end loop;
        Put (i);
    end loop;

    -- count
    for i in 1 .. size loop
        counter := counter + Ada.Strings.Fixed.Count (Source => Map(i), Pattern => Dark);
        -- Put_Line (Map(i));
    end loop;
    Put ("Answer: ");
    Put (counter);
end Main;
