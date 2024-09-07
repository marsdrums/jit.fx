autowhatch = 1; inlets = 1; outlets = 1;


//______ GRAB CONTEXT ______________________________________________________________________

var drawto = "";
declareattribute("drawto", null, "dosetdrawto", 0);

var implicitdrawto = "";
var swaplisten = null; // The listener for the jit.world
var explicitdrawto = false;
var proxy = null;
var swapListener = null;

if(max.version >= 820) {
    proxy = new JitterObject("jit.proxy");
}

var implicit_tracker = new JitterObject("jit_gl_implicit"); // dummy oggetto gl
var implicit_lstnr = new JitterListener(implicit_tracker.name, implicit_callback);

function implicit_callback(event) { 
	// se non stai mettendo ctx a mano e se implicitdrawto != dal nome di implicit
	if(!explicitdrawto && implicitdrawto != implicit_tracker.drawto[0]) {
		// important! drawto is an array so get first element
		implicitdrawto = implicit_tracker.drawto[0];
        //FF_Utils.Print("IMPLICIT CLL", implicitdrawto);
		dosetdrawto(implicitdrawto);
	}
}
implicit_callback.local = 1;

function setDrawto(val) {
	explicitdrawto = true;
	dosetdrawto(val);
};

function dosetdrawto(newdrawto) {
	if(newdrawto == drawto || !newdrawto) {
		// bounce
        //FF_Utils.Print("bouncer");
		return;
	}
	if(proxy !== undefined) {
		proxy.name = newdrawto;
        // viene chiamato quando abbiamo classe
        if(proxy.class !== undefined && proxy.class != "") {
			// drawto may be root render or sub-node
			// if root the class will return jit_gl_context_view
			if(proxy.class != "jit_gl_context_view") { // jit_gl_context_view = node dentro world
				// class is a sub-node, get the drawto on that
				proxydrawto = proxy.send("getdrawto"); // prendi drawto di world che sarebbe nome del node
				// recurse until we get root
				// important! drawto is an array so get first element
                //FF_Utils.Print("proxy class", proxy.class);
                //FF_Utils.Print("DIVERSo da contxt_view", implicitdrawto);

				return dosetdrawto(proxydrawto[0]);
			}
		}
		else {
            // viene chiamato se non abbiamo classe
			proxydrawto = proxy.send("getdrawto");
			if(proxydrawto !== null && proxydrawto !== undefined) {
                //FF_Utils.Print("SE E NODE??", proxydrawto[0]);

				return dosetdrawto(proxydrawto[0]);  // name of the internal node
			}
		}
	}
    //FF_Utils.Print("ASSEGNA drawto", newdrawto);
    drawto = newdrawto;
    // chiama cose che vanno inizializzate quando c'è il drawto
    // assegna listener per ctx
    swapListener = new JitterListener(drawto, swapCallback);
}
dosetdrawto.local = 1;

function destroyFindCTX() {
	implicit_lstnr.subjectname = ""
	implicit_tracker.freepeer();
}
destroyFindCTX.local = 1;

function notifydeleted() {
    destroyFindCTX();
    slab.freepeer();
    texIn1.freepeer();
    texIn2.freepeer();
    texIn3.freepeer();
    texIn4.freepeer();
}
/*
// ___ GRAB JIT.WORLD BANG____________________________________________
var swapCallback = function(event) {
    switch (event.eventname) {
        case ("swap" || "draw"):
        	//bang();
            // FF_Utils.Print("BANG")
            break;
        //case "mouse": case "mouseidle": 
        //    FF_Utils.Print("MOUSE", event.args)
        //    break;
        case "willfree":
            //FF_Utils.Print("DESTROY")
            break;
        default: 
            break;
    }
}
*/

var texIn1 = new JitterObject("jit.gl.texture", drawto); texIn1.defaultimage = "black";
var texIn2 = new JitterObject("jit.gl.texture", drawto); texIn2.defaultimage = "black";
var texIn3 = new JitterObject("jit.gl.texture", drawto); texIn3.defaultimage = "black";
var texIn4 = new JitterObject("jit.gl.texture", drawto); texIn4.defaultimage = "black";

var slab = new JitterObject("jit.gl.slab", drawto);
slab.file = "jit.fx.filter.biquad.jxs";
slab.inputs = 5;
slab.outputs = 4;

var a0, a1, a2, b1, b2;

var _cutoff = 2.0;
var _q = 0.2;
var _filtertype = 0;
var samplerate = 30;
lowpass();

function coefficients(){

	slab.param("a0", arguments[0]);
	slab.param("a1", arguments[1]);
	slab.param("a2", arguments[2]);
	slab.param("b1", arguments[3]);
	slab.param("b2", arguments[4]);
}


function lowpass(){

	var omega = _cutoff * Math.PI*2 / samplerate;
	var sn = Math.sin(omega);
	var cs = Math.cos(omega);
	var igain = 1.0;///gain; 
	var one_over_Q = 1./_q;
	var alpha = sn * 0.5 * one_over_Q;

	b0 = 1./(1. + alpha);
	a2 = ((1 - cs) * 0.5) * b0;
	a0 = a2;
	a1 = (1. - cs) * b0;
	b1 = (-2. * cs) * b0;
	b2 = (1. - alpha) * b0;

	slab.param("a0", a0);
	slab.param("a1", a1);
	slab.param("a2", a2);
	slab.param("b1", b1);
	slab.param("b2", b2);

}

function hipass(){

	var omega = _cutoff * Math.PI*2 / samplerate;
	var sn = Math.sin(omega);
	var cs = Math.cos(omega);
	var alpha = sn * 0.5/_q;
	
	b0 = 1./(1. + alpha);
	a2 = ((1. + cs) * 0.5) * b0;
	a0 = a2;
	a1 = -(1. + cs) * b0;
	b1 = (-2. * cs) * b0;
	b2 = (1. - alpha) * b0;

	slab.param("a0", a0);
	slab.param("a1", a1);
	slab.param("a2", a2);
	slab.param("b1", b1);
	slab.param("b2", b2);

}

function bandpass(){

	var omega = _cutoff * Math.PI*2 / samplerate;
	var sn = Math.sin(omega);
	var cs = Math.cos(omega);
	var alpha = sn * 0.5/_q;

	b0 = 1./(1. + alpha);
	a0 = alpha * b0;
	a1 = 0.;
	a2 = -alpha * b0;
	b1 = -2. * cs * b0;
	b2 = (1. - alpha) * b0;

	slab.param("a0", a0);
	slab.param("a1", a1);
	slab.param("a2", a2);
	slab.param("b1", b1);
	slab.param("b2", b2);
}

function bandstop(){

	var omega = _cutoff * Math.PI*2 / samplerate;
	var sn = Math.sin(omega);
	var cs = Math.cos(omega);
	var alpha = sn * 0.5/_q;

	b0 = 1./(1. + alpha);			
	b1 = (-2. * cs) * b0;
	a1 = b1;
	b2 = (1. - alpha) * b0;
	a0 = b0;
	a2 = b0;

	slab.param("a0", a0);
	slab.param("a1", a1);
	slab.param("a2", a2);
	slab.param("b1", b1);
	slab.param("b2", b2);
}


function cutoff(){
	_cutoff = arguments[0];
	update_coefficients();
}

function q(){
	_q = Math.max(0.02, arguments[0]);
	update_coefficients();
}

function filtertype(){
	_filtertype = arguments[0];
	update_coefficients();
}

function update_coefficients(){
	switch(_filtertype) {
	  case 0:
	    lowpass();
	    break;
	  case 1:
	    hipass();
	    break;
	  case 2:
	  	bandpass();
	  	break;
	  case 3:
	  	bandstop();
	  	break;
	  default:
	    return;
	}
}


function jit_gl_texture(inname){

	slab.activeinput = 4;	slab.jit_gl_texture(texIn4.name);
	slab.activeinput = 3;	slab.jit_gl_texture(texIn3.name);
	slab.activeinput = 2;	slab.jit_gl_texture(texIn2.name);
	slab.activeinput = 1;	slab.jit_gl_texture(texIn1.name);
	slab.activeinput = 0;	slab.jit_gl_texture(inname);

	slab.draw();

	texIn1.jit_gl_texture(slab.out_name[0]);
	texIn2.jit_gl_texture(slab.out_name[1]);
	texIn3.jit_gl_texture(slab.out_name[2]);
	texIn4.jit_gl_texture(slab.out_name[3]);

	outlet(0, "jit_gl_texture", slab.out_name[2]);
}