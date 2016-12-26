:- module(verbe, [conjug/3,
		irr_conjug/3,
		word_conjugation/3,
		utr_prefix/1,
		tr_prefix/1,
		infinitive_ending/1,
		verb_base/2,
		untrennbar/1,
		trennbar/2,
		partizip2/2]).

:- use_module(lex).
:- use_module(util).

conjug(pres, s1, "e").
conjug(pres, s2, "st").
conjug(pres, s3, "t").
conjug(pres, p1, "en").
conjug(pres, p2, "t").
conjug(pres, p3, "en").

irr_conjug("koennen", s1, "kann").
irr_conjug("koennen", s2, "kannst").
irr_conjug("koennen", s3, "kann").
irr_conjug("koennen", p1, "koennen").
irr_conjug("koennen", p2, "koennt").
irr_conjug("koennen", p3, "koennen").

irr_conjug("haben", s1, "habe").
irr_conjug("haben", s2, "hast").
irr_conjug("haben", s3, "hat").
irr_conjug("haben", p1, "haben").
irr_conjug("haben", p2, "habt").
irr_conjug("haben", p3, "haben").

word_conjugation(Infinitive, Person, Word) :- lex(Infinitive, v, _, reg), verb_base(Infinitive, Word_base), conjug(_, Person, Ending), string_concat(Word_base, Ending, Word).
word_conjugation(Infinitive, Person, Word) :- lex(Infinitive, v, _, irr), irr_conjug(Infinitive, Person, Word).
word_conjugation(Infinitive, Person, Word) :- lex(Infinitive, mv, _, irr), irr_conjug(Infinitive, Person, Word).

utr_prefix("be").
utr_prefix("ge").
utr_prefix("er").
utr_prefix("zer").
utr_prefix("ver").
utr_prefix("miss").

tr_prefix("auf").
tr_prefix("ein").
tr_prefix("aus").

infinitive_ending("en").
infinitive_ending("n").

verb_base(Infinitive, Verb_base) :- infinitive_ending(Ending), string_concat(Verb_base, Ending, Infinitive).
verb_base(Infinitive, Verb_base) :- tr_prefix(Prefix), infinitive_ending(Ending), concat_list_to_string([Prefix, Verb_base, Ending], Infinitive).

untrennbar(Infinitiv) :- string_concat(Prefix, _, Infinitiv), utr_prefix(Prefix).
trennbar(Infinitiv, Prefix) :- string_concat(Prefix, _, Infinitiv), tr_prefix(Prefix).

partizip2(Infinitive, Partizip2) :- lex(Infinitive, v, _, _), verb_base(Infinitive, Verb_base), concat_list_to_string(["ge", Verb_base, "t"], Partizip2).
partizip2(Infinitive, Partizip2) :- untrennbar(Infinitive), lex(Infinitive, v, _, _), verb_base(Infinitive, Verb_base), concat_list_to_string([Verb_base, "t"], Partizip2).
partizip2(Infinitive, Partizip2) :- trennbar(Infinitive, Prefix), lex(Infinitive, v, _, _), verb_base(Infinitive, Verb_base), concat_list_to_string([Prefix, "ge", Verb_base, "t"], Partizip2).