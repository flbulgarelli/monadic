-module(maybe).

-export([
  ok/1,
  is_ok/1,
  is_error/1,
  get/1,
  get_or_else/2,
  or_else/2,
  map/2,
  filter/2,
  flatten/1,
  flat_map/2]).

ok(V) -> {ok, V}.

is_ok({ok, _}) -> true;
is_ok(_) -> false.

is_error(error) -> true;
is_error(_) -> false.

get({ok, V}) -> V.

get_or_else(_, {ok, V}) -> V;
get_or_else(V, _) -> V.

or_else(_, {ok, V}) -> ok(V);
or_else(V, _) -> ok(V).

map(Fun, {ok, V}) -> ok(Fun(V));
map(_, _) -> error.

filter(Fun, {ok, V}) ->
  case Fun(V) of
    true -> ok(V);
    false -> error
  end;
filter(_, _) -> error.


flatten({ok, {ok, V}}) -> ok(V);
flatten(_) -> error.

flat_map(Fun, {ok, V}) -> Fun(V);
flat_map(_, _) -> error.