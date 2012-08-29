g="ekc";o="h y";h="u";"r#{g}a#{o}b#{h}r".reverse


->{x="ekc";y="h yb";"r#{x}a#{y}ur".reverse}[]


->(g){m="\syb";"r#{g}ah#{m}ur".reverse}["ekc"]


->(r,a){"r#{r}a#{a}ur".reverse}["ekc","h yb"]


(->(r){a="h yb";"r#{r}a#{a}ur"}["ekc"]).reverse
