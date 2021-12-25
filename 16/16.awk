#!/usr/bin/awk -f
# run with `./16.awk 16.in`
# stolen from https://github.com/phillbush/aoc/blob/master/2021/day16a because the 
# handling case count is too damn high

BEGIN {
	FS = OFS = ""
    # hash table for reverting back and forth
	HTOB["0"] = "0000"
	HTOB["1"] = "0001"
	HTOB["2"] = "0010"
	HTOB["3"] = "0011"
	HTOB["4"] = "0100"
	HTOB["5"] = "0101"
	HTOB["6"] = "0110"
	HTOB["7"] = "0111"
	HTOB["8"] = "1000"
	HTOB["9"] = "1001"
	HTOB["A"] = "1010"
	HTOB["B"] = "1011"
	HTOB["C"] = "1100"
	HTOB["D"] = "1101"
	HTOB["E"] = "1110"
	HTOB["F"] = "1111"
	BTOD["0000"] = 0
	BTOD["0001"] = 1
	BTOD["0010"] = 2
	BTOD["0011"] = 3
	BTOD["0100"] = 4
	BTOD["0101"] = 5
	BTOD["0110"] = 6
	BTOD["0111"] = 7
	BTOD["1000"] = 8
	BTOD["1001"] = 9
	BTOD["1010"] = 10
	BTOD["1011"] = 11
	BTOD["1100"] = 12
	BTOD["1101"] = 13
	BTOD["1110"] = 14
	BTOD["1111"] = 15
}

function btod(s, n) {
	while (s) {
		n = n * 16 + BTOD[substr(s, 1, 4)]
		s = substr(s, 5)
	}
	return n
}

function parse() {
    # get version and type
	versionSum += BTOD["0" substr(input, 1, 3)]
	type = BTOD["0" substr(input, 4, 3)]
    # only take that after 7 ie input := input [7:]
	input = substr(input, 7)
    # literal: 4, sub-packets immediate: 1, subpacket bits: 0
	if (type == "4") {
		return literal()
	}
    # remove padding
	lentype = substr(input, 1, 1)
	input = substr(input, 2)
	if (lentype == "0")
		return operator0(type)
	return operator1(type)
}

function literal(start, group, val) {
	for (;;) {
		start = substr(input, 1, 1)
		group = substr(input, 2, 4)
		input = substr(input, 6)
		val = val * 16 + BTOD[group]
		if (!start || start == "0") {
			break
		}
	}
	return val
}

function operator0(type, len, save) {
	len = btod("0" substr(input, 1, 15))
	save = substr(input, len + 16)
	input = substr(input, 16, len)
	while (input) {
        # recursive call
		parse()
	}
	input = save
}

function operator1(type, lenbits, len, save) {
	len = btod("0" substr(input, 1, 11))
	input = substr(input, 12)
	while (len--) {
        # recursive call
		parse()
	}
}


{
    # get input (concate)
	for (i = 1; i <= NF; i++) {
		input = input HTOB[$i]
	}
}

END {
	parse()
	print versionSum
}