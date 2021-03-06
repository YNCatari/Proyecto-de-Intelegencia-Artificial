:- use_module(library(pce)).
:- use_module(library(pce_style_item)).

main:-
	new(Menu, dialog('TEST COVID-19 UPT- YNCC,PYVC', size(500,500))),
	new(L, label(nombre, 'Escuela Profesional Ingenieria de Sistemas')),
	new(@texto, label(nombre, 'Conteste con responsabilidad las preguntas Segun
	 la Respuestas dadas Ud tendra sus Resultado:')),
	new(@respl, label(nombre, '')),
	new(Salir, button('Salir', and(message(Menu,destroy), message(Menu, free)))),
	new(@boton, button('Realizar test Covid-19', message(@prolog, botones))),
	send(Menu, append(L)), new(@btncarrera, button('¿Diagnostico?')),
	send(Menu,display,L,point(100,20)),
	send(Menu,display,@boton,point(130,150)),
	send(Menu,display,@texto,point(50,100)),
	send(Menu,display,Salir,point(20,400)),
	send(Menu,display,@respl,point(20,130)),
	send(Menu,open_centered).


enfermedades(gripe):-gripe,!.
enfermedades(covid19):-covid19,!.


enfermedades('No estoy entrenado para darte Resultados ').




gripe :-
	tiene_gripe,
	pregunta('¿Tiene Cansancio?'),
	pregunta('¿Tiene Tos?'),
	pregunta('¿Dolor de Garganta?'),
	pregunta('¿Congestion Nasal?').
	

covid19 :-
	tiene_covid19,
	pregunta('¿Tiene Obesidad,Diabetes,hipertencion?'),
	pregunta('¿Ud Tiene mas de 55 Years?'),
	pregunta('¿Ha tenido contacto con personas sospechosas o confirmadas de COVID-19?'),
	pregunta('¿Ha estado fuera del pais, la region o la ciudad en los ultimos 14 dias?').



%desconocido :- se_desconoce_enfermedad.
tiene_gripe:-		pregunta('¿Tienes Fiebre?').
tiene_covid19:-	pregunta('¿Tienes Dificultad Respiratoria?').



:-dynamic si/1,no/1.


preguntar(Problema):-new(Di, dialog('Test Covid-19 ')),
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
	new(@boton, button('Iniciar su 	Test Covid-19', message(@prolog, botones))),
	send(Menu,display,@boton,point(40,50)),
	send(Menu,display,@btncarrera,point(20,50)),
	limpiar.

lim:- send(@respl, selection('')).

limpiar2:-
	send(@texto,free),
	send(@respl,free),
*	%send(@btncarrera,free),
	send(@boton,free).

