#!/bin/bash
curl https://pokeapi.co/api/v2/type/ground > pokeGround.json
echo "NAME, URL" > twoslotgroundpokemons.csv
jq '.pokemon[] | .slot = 2 | [.pokemon[]] | @csv'  < pokeGround.json >> twoslotgroundpokemons.csv
sed -i 's@\\\"@@g' twoslotgroundpokemons.csv
sed -i 's@\"@@g' twoslotgroundpokemons.csv
