-module(maybe_tests).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

map_ok_test() ->
  ?assertEqual(maybe:ok(3), maybe:map(fun(X) -> X + 1 end, maybe:ok(2))).

map_error_test() ->
  ?assertEqual(error, maybe:map(fun(X) -> X + 1 end, error)).

flat_map_error_test() ->
  ?assertEqual(error, maybe:flat_map(fun(X) -> mayber:ok(X + 1) end, error)).

flat_map_ok_ok_test() ->
  ?assertEqual(maybe:ok(3), maybe:flat_map(fun(X) -> maybe:ok(X + 1) end, maybe:ok(2))).

flat_map_ok_error_test() ->
  ?assertEqual(error, maybe:flat_map(fun(X) -> error end, maybe:ok(2))).

filter_ok_ok_test() ->
  ?assertEqual(maybe:ok(10), maybe:filter(fun(X) -> X > 2 end, maybe:ok(10))).
