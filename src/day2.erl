-module(day2).
-export([occurence_map/1, boolean_to_int/1, find_twos_and_threes/1, 
         part1/1, input/0, remove_character/2, find_similar_ids/1,
         find_similar_ids/4, part2/1]).

occurence_map(Input) ->
    lists:foldl(
      fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end,
      maps:new(),
      Input).

boolean_to_int(Bool) ->
    case Bool of
        true -> 1;
        false -> 0
    end.

find_twos_and_threes(OccMap) ->
    {boolean_to_int(lists:member(2, maps:values(OccMap))),
     boolean_to_int(lists:member(3, maps:values(OccMap)))
    }.


remove_character(String, Idx) ->
    string:concat(
      string:sub_string(String, 1, Idx - 1),
      string:sub_string(String, Idx + 1)).



part1(Inputs) ->
    Twos_and_threes = lists:map(fun(Input) -> find_twos_and_threes(occurence_map(Input)) end, Inputs),
    {Twos, Threes} = lists:foldl(fun({X,Y}, {Acc1, Acc2}) -> {Acc1 + X, Acc2 + Y} end, {0, 0}, Twos_and_threes),
    Twos * Threes.

part2(Inputs) -> find_similar_ids(Inputs).


find_similar_ids(Ids) ->    
    find_similar_ids(Ids, Ids, 1, maps:new()).

find_similar_ids([], OriginalIds, Idx, _) ->
    find_similar_ids(OriginalIds, OriginalIds, Idx + 1, maps:new());
find_similar_ids([Id|Ids], OriginalIds, Idx, NewIdMap) ->
    NewId = remove_character(Id, Idx),
    case maps:is_key(NewId, NewIdMap) of
        true -> {Id, maps:get(NewId, NewIdMap)};
        false -> find_similar_ids(
                   Ids,
                   OriginalIds,
                   Idx,
                   maps:put(NewId, Id, NewIdMap))
    end.
            
    
                               


input() ->
    string:tokens(
      "naosmkcwtdbfivxuphzweraljq
nvssmicltdbfiyxuphzgeraljq
nvosmkcwwdbfiyxuphzeeraljx
nvosmkcqtdbfiyxupkzgeraljw
qvosmkcwtdbhiyxuphzgeraljh
nvocqkcktdbfiyxuphzgeraljq
nvosmhcwtdbfiyxmphzgekaljq
nvosmkcwtdbfuyxwpszgeraljq
nvosmocwtcbfiyxupfzgeraljq
nvosmkcwtdbfiyxubczgeraljv
nvosmkswtdbfiyxuphzgeruejq
nlosmkcwtqbfiyxuphzgyraljq
nvosmkcwtdbficxuphzgwraljk
nvosmkkwtdbfiyxxphzgeralcq
vvosmkcetdbfiyxumhzgeraljq
evosmkcdtdbfiyxuphkgeraljq
nvosmkvwtdbkiyxuphzgeraejq
nvoszkcwtdbfimxuphzgeraljb
nvozmkcwtdbfiyxuphzgrrcljq
nvosvacwtdbfiyxuphzgeralzq
nvosmkcwgdofiyxuthzgeraljq
nvosmkcwasbfiyxuphzgeradjq
nvosmkcatobfiyxtphzgeraljq
nvosmkewtdsfiyxuphzgekaljq
tvormkcwtdbfiyxuphzieraljq
nvosgkcwtdbfiyxuuhzgeraqjq
nvosmkcwtdbqiwxuphzgeralvq
nvosmkcwtybfiydcphzgeraljq
nvosnkcwtdbfiyxuphzulraljq
nvosmkcwtdbbiyuupnzgeraljq
nvosmwcwtdbfiyxuphzneraojq
nvohlkcwtdbftyxuphzgeraljq
nvasmkcwbdbfiyiuphzgeraljq
nvosmkujtdbfiyxuphzgeraljz
nvosmgcstdbfiyxuphzgeraljd
nvoswkcwtsbziyxuphzgeraljq
nvosmmcwtdbfiyxupbzzeraljq
nvosmkcwtdbfifxulhzgeralji
nvolmkcwtdbmiyxuphzgeraljv
lvnsmkcwtdbfiyxuphzzeraljq
nvqsmkcwtdbfiyxuphageralfq
nvosmkcwtdmfiyluphzgeralzq
nvommvcwtdbfiyxupjzgeraljq
naosmkcwtdbfsyxuphzgsraljq
avosmkcwtdbfiyxuphzgebafjq
ndozmkcwtdbfiyxuhhzgeraljq
nvosmkcwtubfiyxuphooeraljq
nvosmkcwtdbliyxuphzgmraljx
nvosmkcuddbfimxuphzgeraljq
wvosmkzwrdbfiyxuphzgeraljq
nvosmkcqtdbfiyxupjzgeraijq
nvosbkcwtdbfiyduphzgeruljq
yzosmkcntdbfiyxuphzgeraljq
nvolmkcwtdbfiyxuphugeralfq
nvrsmkcwtdbjiyxuphzgejaljq
nvgsmkcwtdbfiyxuphoglraljq
nvosmkcwtdbfioxuphzgezalhq
nvosjkcwtdbfipxuphzgekaljq
nvosmkcwtabfiyxlpazgeraljq
nvosmkfwtpnfiyxuphzgeraljq
nvokmbcwtdbeiyxuphzgeraljq
nvosmkcwtdbfiyxupmzgmlaljq
nvosmkcwtdhfiykurhzgeraljq
nvosmkcwwdbfiyxumhzgiraljq
cvosmscwtdbfikxuphzgeraljq
nvosmkcwtdnzirxuphzgeraljq
nvosmscwtdbfiyxuuhbgeraljq
nvosmkcwtdbfidxpphzgeraajq
nvosmkcwtdbfiyxuqhzgurcljq
nvosmkcwtekfiyxrphzgeraljq
ntosmkcwtpqfiyxuphzgeraljq
nvosmkcdtdbfhyxsphzgrraljq
nvolmkkwtdbfiyxuphzgeralgq
nvosmrcwtdbfiyxuphzgefkljq
nvoxmkcwtdbfiysuphzeeraljq
nvjsmkswtdbfiyxuphzqeraljq
nvosmkcetdbfiyfuphdgeraljq
nvosmkkwtpbfsyxuphzgeraljq
nvosdgcwtdbfiyxupyzgeraljq
nvosmkcwudbfiyzvphzgeraljq
nvosmkcwtlbfiyxupkzgerzljq
nvosmkcwtdbfiywuphyzeraljq
nvocmkcwtdufiyxukhzgeraljq
nvosmkcwtdqfiyxuphzgevaxjq
nvosvkcwtdbgiyxuphzgeralzq
nqosmkcwtdbfiyxuphzeeraljr
nvosmkcetdbfiyxuphzgeroljo
nvosmkcwtdvfiyxuphzceraliq
nvosmkcwtnxfiyxuphzgyraljq
nvosmkfwtdefiyxupxzgeraljq
nvosmacwtdbfiyxuphzseragjq
nvpsmkcwtdbfzyxuvhzgeraljq
nvormkcwtdbfiyxuphzairaljq
rvysmkcwtdbfmyxuphzgeraljq
nvosmscwzdbfiyxuphzgerbljq
nvosmkcwtdufmyxuphzqeraljq
nvosmkcwtxbfiyxxphzgeralxq
nvosmkcwtdbsiyxupsfgeraljq
nvosmccwtdbfiqxuthzgeraljq
nvosmtcwtqbuiyxuphzgeraljq
nvosmkcwtdbfiysurbzgeraljq
nvowmkcwtdbfiyxuywzgeraljq
xvosmkcktdbfiyxuhhzgeraljq
nvosmkgwsdbfiyxmphzgeraljq
jvofmkcwtdbfiyxupyzgeraljq
nvozakcwtdbfiexuphzgeraljq
nvosmkcptdbfiyxuphzgepaljn
nvosmkcwtdbpiyxuphzgeraxjw
nvoszkcwtdbfiyjuphzeeraljq
nvosmkcwtdbfiyxuppzoeraejq
nvosmkiytdbfiyhuphzgeraljq
nvosmkcwtdvfiywupyzgeraljq
nvosmecwtdofiyxuphzgeralja
nvosmkqwtdbfixxuphzgeraojq
nvosmkwwtdbfiyxfpdzgeraljq
nvosmkgwtdbfiyzupwzgeraljq
nmosmucwtdvfiyxuphzgeraljq
nvosmdcwtdbmiyxuphzveraljq
wvosmkcwtpbfiyxuphzgetaljq
nvosmmcwtdlfbyxuphzgeraljq
nvosmkcwtabmiexuphzgeraljq
nvosqpcwtdbfiyxuphzgqraljq
nvosmecwjdbfiyxuphzgeraljk
nyohmkcwtdbfiyxuphzgzraljq
nlosmkcwtkbfiyxuphzgeraejq
nvosmkcwrdbliyxuphzgerpljq
nvusmkzwtdbfxyxuphzgeraljq
nvosmkcwtdbfiyxuhizgerazjq
nvosmkhptdbfbyxuphzgeraljq
nvosmfcwtdbgiyxupdzgeraljq
nvosmkmwtdbfiyxuphzgevalpq
nvosmkcwtdwfiyxuphzherjljq
nvosmkcwjwbfiyxuphzgeualjq
nvosmkcwxdbflymuphzgeraljq
nvosmkcwpdbriyxuphzoeraljq
nvoshkcwcdbfiyxuphzgeravjq
nvosmkcetcbfiyxgphzgeraljq
nvosmkcwtdyfiyxuphzgerwqjq
nuosmkcwedbfiyxurhzgeraljq
nvosmkcwtdbfiixuphzctraljq
nvoszkcwtdbfwyxuphzgerpljq
nvormkcwtdbfiyxuphzgeralzn
nvosmkyttdbfiywuphzgeraljq
nvosmkcwtdbhiyxupazgeralhq
nvotmkcwtdbfiyxuphzgevalbq
nvosmkcwedbfiyxuphzguraljr
nvssmkcwtdbfiyxushzgeralbq
nvosmkcwtdeziyxuphzgeralhq
nvogmkcwtdbfiyxuphzgerrxjq
ncormkcwtdbfiyxuphzgeraloq
nvosmkcwbdbfiyeuphzgerqljq
nvosxkcwtdbfsyxupfzgeraljq
nvohmkcwtdbfiyxuphzseraajq
nvoscdcwtdbfiyxuphzgeralqq
neosmkcwtdbfiyxuchzgeralgq
njosmvcwpdbfiyxuphzgeraljq
nvosmkcwtwbfiyxuphzgehamjq
nvosmkcwtdbfiyxushzgejaljv
nvosmkcwodbfiyxuphzgeryqjq
nvoymqcwtdbfiyxuphzgeralbq
nvosmkcwtdjfiyxuphzgesaljb
nvjsmdcwedbfiyxuphzgeraljq
nvosmkcwydbfiyxuihzmeraljq
nvrsmkcwtdifiyxuphzgqraljq
nposmkcwtdbfiyxiohzgeraljq
dvosmkcwtdbfiyxuphzrvraljq
pvosmkcwudbfsyxuphzgeraljq
noosmkcwtdbfiyxuphtgexaljq
nvosmkcwtdbfiaxuphyferaljq
nvhsmlcwtdbfiyxuphzgeualjq
nvosekcwtdbbiyxuphzgerabjq
nvosvkcitdbfiyxuphzgerarjq
nvotmkkwtdbfiyxuphzgeraljj
nvosmecwtdbfiyxuphzgyralwq
hvosmkcwtdbfiyxuphzysraljq
nvosmkcvtdbfiyxlphzgeraljb
nvosmkcwttbfiyxuphngtraljq
nvoslkcwtdbfiyxuphzqeraljr
nxosmkcwtdbfibxuphzgrraljq
nvokmkhwtdbfiyxuphzgwraljq
nvosmkfwtdbfiyxuphzgdraljo
nvcsmkcwtdbfibxuphzgeraljl
nvosmkcwtdcfiaxuphzeeraljq
wvosmkcwtdbyiyxjphzgeraljq
nyosmbcwtjbfiyxuphzgeraljq
nvosmkcwtdbiiyxuahzieraljq
nqosmkcwtdbfiyxuyhzgerapjq
nvosmkcwtdbfiyxuwhzzetaljq
nvosmkcwfgbfiyxuphzgerrljq
nvosmbcwtdbfipxuphzderaljq
nvosmkcwtdgfiyxupdzgerjljq
noosmkcwtdcfiyxuphlgeraljq
nvonmkcutdbfiyxuphzieraljq
nvocmkcwtdbfiyyuphageraljq
nvosmkcwtdbfoyxuphzneraqjq
nvoskkcwtdbtiyxuphzgevaljq
ocosmkswtdbfiyxuphzgeraljq
nvosmkcqtdbfiyxfvhzgeraljq
noosmkcwtdbfiyquphzberaljq
nvosmkcwttbfijxuchzgeraljq
nvogmkcwtdbfiyxupazgeralaq
nvqsmkcwtdbfikxuphzgeraliq
nvosmkuwtdbfiyxuphzjwraljq
nyosmhcwtdbfiyxuphzgereljq
nvosmncwtdbfietuphzgeraljq
gvpsmkcwtdbfiyxuyhzgeraljq
nvozmkewtlbfiyxuphzgeraljq
nvostkcltpbfiyxuphzgeraljq
nvosmkcwtdbdiyxuphzgehaljz
nvosmkcwtjbziyxuphzgexaljq
nvosmkcwtdbfiyptphzggraljq
nvosmkcwtdbliyxupjzgebaljq
nvosmkawtdbfiyxupxzgtraljq
vvosmkcwtdbfiyxfphzperaljq
nvosmkawtdbfiyxutczgeraljq
nvosmkcbtdbuiyxrphzgeraljq
nvbsmkcwtdbfiyxdphzgerasjq
nvosnkcwqdsfiyxuphzgeraljq
nvosmkcwtdbfiyxwphzgzzaljq
nvosmkcwtdbffyquphzgeralcq
nvosmkcwtzbfiyxdphzgzraljq
nvysmkcwtdbfiycvphzgeraljq
nvowmkcwtdbfiycuyhzgeraljq
nvosbkcwtdbfiyiuphzgeraqjq
nvosmecwtdbfiyxupqzmeraljq
nvosmkcdtdbfhyxsphzgeraljq
nmosmkcwtdbziyxuphzgercljq
nvosmkcwtdbfiyxupfmgersljq
nvosmkcvtdbpyyxuphzgeraljq
nvosmkcwtkbfiyaupxzgeraljq
nvosmkcwtzbiiyxuphzgerazjq
nvoxmkcwtdbfiyxuphztegaljq
nvonmkcwtdafiyxuphzgerkljq
rvommkcwtdbfiyxzphzgeraljq
nvosmkcwthbfiysuphzgeraxjq
nvosmkcwtdbfnyxuphzgerccjq
nrosmzcwtdbfiyxuphkgeraljq
nvolmkcdtdbfiyxuphtgeraljq
nvosfkcwtdbfiyeuphcgeraljq
nvowmkcwtdbfhyxuphzgerafjq
gvosmkcwtdbfiyxupbpgeraljq
nvosmkcwtdbkiyxuphegebaljq
nvommufwtdbfiyxuphzgeraljq
uvksmkcwtdbfiysuphzgeraljq
nvosmkcwevbfiyxuphtgeraljq
nvosmkcmtdbfiycuphzgeraxjq
nvcsxkcwtdbfiyxuphzgeraljn
nvosmkcwtdbtiymuphzgeraltq
nvosmfcwtdlfjyxuphzgeraljq
svosmkcitdbfiyxuphzgsraljq", "\n").
