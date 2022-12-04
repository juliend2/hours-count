-module(hours).
-export([main/0]).



% Minutes calculation:

minutes(integers, {Hours, Minutes}) ->
  (Hours * 60) + Minutes;

minutes(string, Time) ->
  [H,M] = string:split(Time, "h"),
  {Hours,_} = string:to_integer(H),
  {Minutes,_} = string:to_integer(M),
  minutes(integers, {Hours, Minutes});

minutes(duration, {From, To}) ->
  FromMinutes = minutes(string, From),
  ToMinutes = minutes(string, To),
  ToMinutes - FromMinutes;

minutes(duration, Duration) ->
  [From, To] = string:split(Duration, "-"),
  minutes(duration, {string:trim(From), string:trim(To)}).

% Project grouping:
% {proj, "proj_name", mins}
% Example:
% {proj, "crc", 240}

proj([]) -> 0;
proj(Lines) ->
  [First|Rest] = Lines,
  minutes(duration, string:trim(First)) + proj(Rest).

% TotalMinutes = minutes(string, "3h04"),
% TotalMinutes = minutes(duration, "3h40 - 4h00"),
main() ->
  Hours = "1h00 - 01h01
  09h00 - 09h02
  09h00 - 09h10
  10h00 - 10h50",
  Lines = string:split(Hours, "\n", all),
  % [First|Rest] = Lines,
  TotalMinutes = proj(Lines),
  io:fwrite("~w ~n", [TotalMinutes]).

