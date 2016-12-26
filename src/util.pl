:- module(util, [concat_list_to_string/2]).

concat_list_to_string([], "").
concat_list_to_string([Head|Tail], String) :- string_concat(Head, S1, String), concat_list_to_string(Tail, S1).