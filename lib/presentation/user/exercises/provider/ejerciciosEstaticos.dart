//CONECTAR CON EL PRESENTE
import 'package:hablemos/model/ejercicio.dart';

List<String> primerPasoConectarPresente = [
  "Pon una mano en lugar donde sientas tensión y la otra donde nace tu cuello",
  "Has de cuenta que tu respiración es una bolita y que esa bolita empieza a moverse de una mano a la otra",
  "Respira profundamente imaginando que la bolita pasa a una mano y exhala cuando pase a la otra",
  "hazlo por 5 minutos",
];

List<String> segundoPasoConectarPresente = [
  "Ponte dos manos sobre la panza (nuestro cerebro emocional)",
  "Respira como si inhalaras desde la punta de tus pies hasta la punta de tu cabeza",
  "Repite durante 5 minutos"
];

//ANSIEDAD

//DORMIR
List<String> dormirMejorInstrucciones = [
  "Siéntate en una posición cómoda. Inhala y exhala profundamente",
  "Ahora quiero que pienses en tres cosas por las que sientes gratitud de tu día desde lo personal. Piensa en la sonrisa de un ser querido, en lo bien que se sienten tus cobijas, en algo rico que comiste hoy. Permítete recrear en tu mente lo que sentiste, lo que oliste, lo que tocaste.",
  "Ahora piensa en tres cosas por las que sientas gratitud en tu vida laboral o académica: la ayuda de un colega, una felicitación por algo que dijiste. Permítete recrear ese momento como lo recuerdas: con sus emociones, sus olores, sus colores, sus sensaciones.",
  "Ahora piensa en tres partes de tu cuerpo o de tu personalidad por las que sientas gratitud: tu creatividad, tu cabello, tu estilo, tu voz, tus manos, tus gustos, lo que quieras. Piensa en esto que es tuyo y siente compasión y gratitud por ser el ser humano maravilloso que eres.",
  "Disfruta de más inhalaciones y apaga el celular. Es hora de dormir.",
];

//MINDFULNESS (1 EJERCICIO)

List<String> titulos = ["Gratitud a los pies", "Proximamente"];

List<String> mindfulnessInstrucciones = [
  "Para esta meditación vas a necesitar un poco de crema o aceite para el cuerpo, lo que sea de tu preferencia. (vas a tocar tus pies, así que asegúrate de estar en un lugar cómodo y regalarte el tiempo que dure el ejercicio)",
  "Ya que tienes todo listo vamos a conectar con la respiración ubícate en un lugar cómodo para ti, y toma una postura que te permita estar alerta. ",
  "Observa este círculo, imagina que se expande y se contrae,  vas a inhalar cuando se expanda y luego sostener el aire unos segundos (no muchos), luego exhala cuando se contraiga y a sostener, vamos a repetir esto 5 veces. Comencemos…",
  "Ahora que estás más en el presente vas a retirarte los zapatos y las medias, comienza observándolos, nota su temperatura, observa si hay alguna tensión en ellos.",
  "Toma algo de crema o aceite en tus manos, caliéntalo un poco frotando una mano con otra y luego llévalas a tus pies, vas a tocarlos con mucha dulzura, conectando con la excelente labor que hacen, y vamos a dar inicio a la gratitud… (pon música de tu gusto)",
  "Ve diciendo en voz alta o repitiendo en la mente (como prefieras), todas las cosas por las que agradeces a tus pies, toca cada dedo, cada uña, el tobillo, y expresa la gratitud que sientes por la labor que desempeñan para ti día a día, aprovecha este momento para masajearlos y liberarlos con tus cariños de algunas tensiones que probablemente acumulan en el día ",
  "Para finalizar date gracias a ti por permitirte este momento.",
];

List<String> mindfulnessAcom1 = [
  "assets/imagesExc/primera.png",
  "assets/imagesExc/segunda.jpg",
  "assets/imagesExc/tercera.png",
  "assets/imagesExc/cuarta.jpg",
  "assets/imagesExc/quinto.jpg",
  "assets/imagesExc/sexta.jpg",
  "assets/imagesExc/septima.jpg",
];

Ejercicio mindfulness = Ejercicio(
    titulo: "Gratitud a los pies",
    descripcion:
        "Para esta meditación vas a necesitar un poco de crema o aceite para el cuerpo, lo que sea de tu preferencia. (vas a tocar tus pies, así que asegúrate de estar en un lugar cómodo y regalarte el tiempo que dure el ejercicio)",
    pasos: mindfulnessInstrucciones);

List<Ejercicio> listaDeMindfulness = [mindfulness];
//CADA NUMERO TIENE UNA IMAGEN RELACIONADA

//MEDITACIÓN (3 EJERCICIOS)
