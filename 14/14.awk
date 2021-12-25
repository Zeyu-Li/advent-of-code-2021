#!/usr/bin/awk -f
# run with `awk 14.awk 14.in`

{
    if (NR == 1) {
        POLY = $0;
        FS = " -> ";
        # print $0
    } else if (NF == 2) {
        rules[$1] = $2;
        # print $1 $2
    }
}

END {
	OFS = FS = ""
	$0 = POLY
    # chars = POLY
    # print NR
	for (i = 0; i < 10; i++) {
        count = split(POLY, chars, "")
        print "Start: " POLY
        print count
        POLY = ""
		for (j = 1; j < count - 1; j++) {
			insert = rules[chars[j] chars[j+1]]
			POLY = POLY chars[j] insert
            # print POLY
		}
        POLY = POLY chars[count - 1]
        print "Final: " POLY
	}
    print length(chars)
    # print "Answer: " max - min
}