:- module(lex, [lex/2, lex/3, lex/4]).

lex("Mutter", n, fem).
lex("Vater", n, masc).
lex("Fenster", n, neu).

lex("dumm", adj).
lex("neu", adj).

lex("haben", v, vt, irr).
lex("koennen", mv, m, irr).
lex("heissen", v, vt, reg).
lex("achten", v, aufA, reg).
lex("bedanken", v, dat, reg).
lex("aergern", v, uberA, reg).
lex("aussteigen", v, vi, reg).
lex("einsteigen", v, vi, reg).
