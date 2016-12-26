:- module(main, [
		possessive_pronoun/4,
		pronoun/4,
		noun/3,
		adjective/5,
		verb/5,
		undet_article/4,
		det_article/4,
		question_word/2,
		other_verbs/4,
		noun_phrase/4,
		noun_pronoun_phrase/4,
		subject/3,
		object/3,
		negation_place/2,
		simple_sentence/6,
		frage/2,
		sentence/2,
		s/1		
	]).
	
:- use_module(lex).
:- use_module(verbe).

:- [util].
:- [adjectiven].
:- [article].
:- [pronomen].
:- [frageworte].

possessive_pronoun(Gender, Case) --> [Word], {pp(Word_base), string_concat(Word_base, Ending, Word), pn_dekl(Gender, Case, Ending)}.
pronoun(Person, Case) --> [Word], {pn(Word, Person, Case)}.
noun(Gender) --> [Word], {lex(Word, n, Gender)}.
adjective(Gender, Case, Dekl_type) --> [Word], {lex(Word_base, adj), string_concat(Word_base, Ending, Word), adj_dekl(Gender, Case, Dekl_type, Ending)}.

verb(prasens, Person, Object_type) --> [Word], {lex(Infinitive, v, Object_type, _), word_conjugation(Infinitive, Person, Word)}.
verb(perfekt, Person, _) --> [Word], {word_conjugation("haben", Person, Word)}.
verb(modal_verb, Person, _) --> [Word], {lex(Infinitive, mv, _, _), word_conjugation(Infinitive, Person, Word)}.

undet_article(Gender, Case) --> [Word], {uart(Word_base), string_concat(Word_base, Ending, Word), uart_dekl(Gender, Case, Ending)}.
det_article(Gender, Case) --> [Word], {dart(Gender, Case, Word)}.

question_word --> [Word], {qw(Word)}.

other_verbs(prasens, _) --> [].
other_verbs(perfekt, Object_type) --> [Word], {lex(Infinitive, v, Object_type, _), partizip2(Infinitive, Word)}.
other_verbs(modal_verb, Object_type) --> [Infinitive], {lex(Infinitive, v, Object_type, _)}.

noun_phrase(Gender, Case) --> adjective(Gender, Case, strong_type), noun(Gender).
noun_phrase(Gender, Case) --> possessive_pronoun(Gender, Case), noun(Gender).
noun_phrase(Gender, Case) --> possessive_pronoun(Gender, Case), adjective(Gender, Case, mixed_type), noun(Gender).
noun_phrase(Gender, Case) --> undet_article(Gender, Case), noun(Gender).
noun_phrase(Gender, Case) --> undet_article(Gender, Case), adjective(Gender, Case, mixed_type), noun(Gender).
noun_phrase(Gender, Case) --> det_article(Gender, Case), noun(Gender).
noun_phrase(Gender, Case) --> det_article(Gender, Case), adjective(Gender, Case, weak_type), noun(Gender).

noun_pronoun_phrase(s3, Case) --> noun_phrase(_, Case).
noun_pronoun_phrase(Person, Case) --> pronoun(Person, Case).

subject(Person) --> noun_pronoun_phrase(Person, nom).

object(vt) --> noun_pronoun_phrase(_, akk).

object(anD) --> ["an"] , noun_pronoun_phrase(_, dat).
object(vonD) --> ["von"] , noun_pronoun_phrase(_, dat).
object(ausD) --> ["aus"] , noun_pronoun_phrase(_, dat).

object(aufA) --> ["auf"] , noun_pronoun_phrase(_, akk).
object(uberA) --> ["uber"] , noun_pronoun_phrase(_, akk).
object(vi) --> [].

negation_place --> [].
negation_place --> ["nicht"].

simple_sentence(direct_word_order, Tense, Person, Object_type) --> subject(Person), verb(Tense, Person, Object_type), object(Object_type), negation_place, other_verbs(Tense, Object_type).
simple_sentence(reversed_word_order, Tense, Person, Object_type) --> verb(Tense, Person, Object_type), subject(Person), object(Object_type), negation_place, other_verbs(Tense, Object_type).
simple_sentence(nebensatz_word_order, Tense, Person, Object_type) --> subject(Person), object(Object_type), negation_place, other_verbs(Tense, Object_type), verb(Tense, Person, Object_type).

frage --> simple_sentence(reversed_word_order, _, _, _).
frage --> question_word, simple_sentence(reversed_word_order, _, _, _).

sentence --> simple_sentence(direct_word_order, _, _, _).
sentence --> frage.

s(Str) :- split_string(Str, ' ', ' ', Word_list), sentence(Word_list, []).