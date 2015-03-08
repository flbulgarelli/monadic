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

-define(OK(V), {_, V}).

ok(V) -> {ok, V}.

is_ok(?OK(_)) -> true;
is_ok(_) -> false.

is_error(Maybe) -> not is_ok(Maybe).

get(?OK(V)) -> V.

get_or_else(_, ?OK(V)) -> V;
get_or_else(V, _) -> V.

or_else(_, ?OK(V)) -> ok(V);
or_else(V, _) -> ok(V).

map(Fun, ?OK(V)) -> ok(Fun(V));
map(_, _) -> error.

filter(Fun, ?OK(V)) ->
  case Fun(V) of
    true -> ok(V);
    false -> error
  end;
filter(_, _) -> error.


flatten(?OK(?OK(V))) -> ok(V);
flatten(_) -> error.

flat_map(Fun, ?OK(V)) -> Fun(V);
flat_map(_, _) -> error.