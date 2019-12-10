(
Server.default= s=Server.internal;
s.boot;
)

(
SynthDef(\impulse, {

Out.ar(0, Pan2.ar(Saw.ar(440, Decay2.ar(Impulse.ar(1), 0.001, 0.1 ,0.5)), 0.0));

}).add;
)

(
SynthDef(\blow, {
	var env = Env.new([0, 0.1, 0], [1,1], loopNode: 0, releaseNode: 2);

	Out.ar(0, Pan2.ar(WhiteNoise.ar(EnvGen.ar(env), 0.0)));
}).add;
)

(
SynthDef(\combdelay, { arg maxtime = 1.0, delaytime = 0.1, decaytime = 1.0;

var input, effect;

input = In.ar(0, 2); //get two channels of input starting (and ending) on bus 0

effect = CombC.ar(input, maxtime, MouseX.kr(0,1), decaytime);

Out.ar(0, effect); //adds to bus 0

}).add;
)

(
SynthDef(\delay, { arg delaytime = 0.1;

var input, effect;

input = In.ar(0, 2); //get two channels of input starting (and ending) on bus 0

effect = DelayC.ar(input, delaytime + 10, delaytime);

Out.ar(0, effect); //adds to bus 0

}).add;
)

x = Synth.head(a, \blow);
x.free;

y = Synth.tail(a, \combdelay, [\maxtime, 1, \delaytime, 0.1]);
y.free;

