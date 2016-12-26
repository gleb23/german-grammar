%=======================================
%======         Util         ==========
%=======================================

:- begin_tests(util).
:- use_module(util).

test(concat_list_to_string) :- concat_list_to_string([], "").
test(concat_list_to_string) :- concat_list_to_string(["a"], "a").
test(concat_list_to_string) :- concat_list_to_string(["a", "b", "c"], "abc").

:- end_tests(util).

%=======================================
%======         Verbe         ==========
%=======================================

:- begin_tests(verbe).
:- use_module(verbe).

test(word_conjugation) :- word_conjugation("achten", s1, "achte").
test(word_conjugation) :- word_conjugation("aergern", s2, "aergerst").
test(word_conjugation) :- word_conjugation("haben", s3, "hat").   % <---- irr
test(word_conjugation) :- word_conjugation("bedanken", p1, "bedanken").
test(word_conjugation) :- word_conjugation("koennen", p2, "koennt").  % <--- modal
test(word_conjugation) :- word_conjugation("heissen", p3, "heissen").

test(verb_base) :- verb_base("achten", "acht").  % <- en ending
test(verb_base) :- verb_base("aergern", "aerger").  % <- n ending
test(verb_base) :- verb_base("aussteigen", "steig").  % <- trennbar

test(untrennbar) :-untrennbar("bedanken").

test(trennbar) :- trennbar("aussteigen", "aus").

test(partizip2) :- partizip2("bedanken", "bedankt"). % <- untrennbar
test(partizip2) :- partizip2("achten", "geachtt"). % <- ohne prefix 
test(partizip2) :- partizip2("einsteigen", "eingesteigt"). % <- trennbar

:- end_tests(verbe).

%=======================================
%======    End to end tests   ==========
%=======================================
:- begin_tests(main).
:- use_module(main).

test(possessive_pronoun) :- possessive_pronoun(masc, nom, ["mein"], []).
test(pronoun) :- pronoun(s1, nom, ["ich"], []).
test(noun) :- noun(fem, ["Mutter"], []).
test(adjective) :- adjective(masc, nom, mixed_type, ["dummer"], []).

test(verb) :- verb(prasens, s1, aufA, ["achte"], []).
test(verb) :- verb(perfekt, s2, aufA, ["hast"], []).
test(verb) :- verb(modal_verb, s3, aufA, ["kann"], []).

test(undet_article) :- undet_article(masc, nom, ["ein"], []).
test(det_article) :- det_article(masc, nom, ["der"], []).

test(question_word) :- question_word(["Wo"], []).

test(other_verbs) :- other_verbs(prasens, _, [], []).
test(other_verbs) :- other_verbs(perfekt, vi, ["ausgesteigt"], []).
test(other_verbs) :- other_verbs(modal_verb, vt, ["heissen"], []).

test(noun_phrase) :- noun_phrase(masc, dat, ["dummem", "Vater"], []).
test(noun_phrase) :- noun_phrase(fem, akk, ["meine", "Mutter"], []).
test(noun_phrase) :- noun_phrase(neu, gen, ["meines", "neuen", "Fenster"], []).
test(noun_phrase) :- noun_phrase(masc, gen, ["eines", "Vater"], []).
test(noun_phrase) :- noun_phrase(fem, dat, ["einer", "dummen", "Mutter"], []).
test(noun_phrase) :- noun_phrase(neu, nom, ["das", "neue", "Fenster"], []).
test(noun_phrase) :- noun_phrase(neu, akk, ["das", "Fenster"], []).

test(noun_pronoun_phrase) :- noun_pronoun_phrase(s3, gen, ["einer", "neuen", "Mutter"], []).
test(noun_pronoun_phrase) :- noun_pronoun_phrase(p1, nom, ["wir"], []).

test(subject) :- subject(p2, ["ihr"], []).

test(object) :- object(vt, ["deinen", "neuen", "Vater"], []).
test(object) :- object(anD, ["an", "deinem", "Vater"], []).
test(object) :- object(vonD, ["von", "einer", "Mutter"], []).
test(object) :- object(ausD, ["aus", "dem", "Fenster"], []).
test(object) :- object(aufA, ["auf", "eine", "neue", "Mutter"], []).
test(object) :- object(uberA, ["uber", "ein", "neues", "Fenster"], []).
test(object) - object(vi, [], []).

test(negation_place) :- negation_place([], []).
test(negation_place) :- negation_place(["nicht"], []).

test(simple_sentence) :- simple_sentence(direct_word_order, prasens, s1, vt, ["ich", "habe", "eine", "Mutter", "nicht"], []).
test(simple_sentence) :- simple_sentence(reversed_word_order, perfekt, p1, aufA, ["haben", "wir", "auf", "meine", "Mutter", "geachtet"], []).
test(simple_sentence) :- simple_sentence(nebensatz_word_order, perfekt, s3, uberA, ["er", "uber", "mich", "geaergert", "hat"], []).

test(frage) :- frage(["einsteigt", "ihr"], []).
test(frage) :- frage(["Wann", "habt", "ihr", "eingesteigt"], []).

test(s) :- s("du hast auf meine Mutter geachtet").

:- end_tests(main).