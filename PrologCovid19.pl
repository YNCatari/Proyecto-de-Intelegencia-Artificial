:- use_module(library(pce)).
:- use_module(library(pce_style_item)).

main:-
	new(Menu, dialog('Universidad Privada de Tacna', size(500,500))),
	new(L, label(nombre, 'Escuela Profesional de Ingenieria de Sistemas')),
	new(@texto, label(nombre, 'Conteste con responsabilidad las preguntas que acontinuacion se le brindara para descartar cualquier caso de COVID-19 que pueda presentar ud. ó algun familiar suyo
Segun la Respuestas dadas tendra su Resultado:')),
	new(@respl, label(nombre, '')),
	new(Salir, button('Salir', and(message(Menu,destroy), message(Menu, free)))),
	new(@boton, button('Realizar test Covid19', message(@prolog, botones))),
	send(Menu, append(L)), new(@btncarrera, button('¿Diagnostico?')),
	send(Menu,display,L,point(100,20)),
	send(Menu,display,@boton,point(130,150)),
	send(Menu,display,@texto,point(50,100)),
	send(Menu,display,Salir,point(20,400)),
	send(Menu,display,@respl,point(20,130)),
	send(Menu,open_centered).


enfermedades(ebola):-ebola,!.
enfermedades(gastritis):-gastritis,!.
enfermedades(neumonia):-neumonia,!.

enfermedades('No estoy entrenado para darte ese diagnostico').




ebola :-
	tiene_ebola,
	pregunta('¿Presenta dolores musculares?'),
	pregunta('¿Tiene vómito y diarrea?'),
	pregunta('¿Presenta erupciones cutaneas?'),
	pregunta('¿Siente debilidad intensa?'),
	pregunta('¿Tiene dolor de garganta?').

gastritis :-
	tiene_gastritits,
	pregunta('¿Tiene acidez estomacal?'),
	pregunta('¿Presenta aerofagia?'),
	pregunta('¿Tiene ausencia de hambre que en ocasiones puede producir perdida de peso?'),
	pregunta('¿Presenta heces de color negro o con sangrado?'),
	pregunta('¿Tiene náuseas?').

neumonia :-
	tiene_neumonia,
	pregunta('¿Tiene dolores articulares?'),
	pregunta('¿Ha tenido tos constate los ultimos dos dias?'),
	pregunta('¿Presenta dificultad para respirar?').




%desconocido :- se_desconoce_enfermedad.


tiene_ebola:-		pregunta('¿Tiene fiebre?').
tiene_gastritits:-	pregunta('¿Tiene dificultad de Respiratoria?').
tiene_neumonia:-	pregunta('¿Tiene fiebre Dolor Estomacal ?').


:-dynamic si/1,no/1.


preguntar(Problema):-new(Di, dialog('Examen Medico')),
	new(L2, label(texto,'Responde las siguientes preguntas')),
	new(La, label(prob,Problema)),

	new(B1,button(si,and(message(Di,return,si)))),
	new(B2,button(no,and(message(Di,return,no)))),

	send(Di,append(L2)),
	send(Di,append(La)),
	send(Di,append(B1)),
	send(Di,append(B2)),

	send(Di,default_button,si),
	send(Di,open_centered),
	get(Di,confirm,Answer),
	write(Answer),send(Di,destroy),


	((Answer==si)->assert(si(Problema)); assert(no(Problema)),fail).

pregunta(S):- (si(S)->true; (no(S)->fail;preguntar(S))).
limpiar:- retract(si(_)),fail.
limpiar:- retract(no(_)),fail.
limpiar.


botones :-lim,
	send(@boton,free),
	send(@btncarrera,free),
	enfermedades(Enter),
	send(@texto, selection('De acuerdo con sus respuestas,usted padece de:')),
	send(@respl, selection(Enter)),
	new(@boton, button('Iniciar su evaluación', message(@prolog, botones))),
	send(Menu,display,@boton,point(40,50)),
	send(Menu,display,@btncarrera,point(20,50)),
	limpiar.

lim:- send(@respl, selection('')).

limpiar2:-
	send(@texto,free),
	send(@respl,free),
*	%send(@btncarrera,free),
	send(@boton,free).

