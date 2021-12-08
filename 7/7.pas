program Main;

uses SysUtils, StrUtils;

var file_content: AnsiString;
    fp: Text;
    items: TStringArray;
    i: Integer;
    guess: Integer;
    value: Integer;
    code: Integer;
    sum: LongInt;
    min: LongInt;

begin
    // read from file
    Assign(fp,'7.in');
    Reset(fp);
    readln(fp, file_content);
    // StrUtils.SplitString(file_content, ',');
    items := file_content.Split(',');
    // brute force
    min := 327660000;
    for guess := 0 to 500 do
        begin
        sum := 0;
        for i := 0 to length(items) - 1 do
            begin
            Val(items[i], value, code);
            sum := sum + Abs(guess - value);
            // writeln(value);
            end;
        if sum < min then
            // writeln('guess');
            // writeln(guess);
            min := sum;
        end;
    // writeln(length(items));
    writeln(min);
    // Readln;
end.
