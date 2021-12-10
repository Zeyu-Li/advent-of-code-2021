import std.stdio;
import std.math;
import std.file;
import std.string;

void main() {
    auto fileName = "10.in";
    int total = 0;
    int[char] valueMap;
    valueMap[')'] = 3;
    valueMap[']'] = 57;
    valueMap['}'] = 1197;
    valueMap['>'] = 25137;
    char[char] map;
    map[')'] = '(';
    map[']'] = '[';
    map['}'] = '{';
    map['>'] = '<';

    // read from file
    File file = File(fileName, "r"); 
    while (!file.eof()) { 
        string line = chomp(file.readln()); 
        char[] Stack;
        for (int i = 0; i < line.length - 1; i+=1) {
            // writeln(Stack);
            if (line[i] == '(' || line[i] == '{' || line[i] == '[' || line[i] == '<') Stack ~= line[i];
            else {
                if (Stack.length > 0 && map[line[i]] == Stack[Stack.length-1]) {
                    // pop from stack
                    // writeln("-----");
                    // writeln(Stack.length);
                    Stack = Stack[0..Stack.length-1];
                    // writeln(Stack.length);
                } else {
                    // add to total
                    total += valueMap[line[i]];
                    break;
                }
            }
            // write(line[i]);
        }
    }
    file.close();

    write("Total: "); 
    writeln(total); 
}
