s = Server.default;

s.options.numAnalogInChannels = 2; // can only be 2, 4 or 8
s.options.numAnalogOutChannels = 2;
s.options.numDigitalChannels = 0;
s.options.maxLogins = 16;  	   // set max number of clients

s.options.blockSize = 16;
s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 2;

s.waitForBoot{
	"Server Booted".postln;
	(
	SynthDef("delay",{ arg out=0;
		var input = AnalogIn.ar(0);
		var slewtime = AnalogIn.ar(3);
		var delaytime = Lag.ar(AnalogIn.ar(1).unipolar(0.008).softRound(0.00001, 0, 1), slewtime);
		var delay = DelayC.ar(input, maxdelaytime: 2, delaytime: delaytime);
		AnalogOut.ar(0, delay);
	}).send(s);
	);

	s.sync;
	Synth.new("delay", target: s);
};