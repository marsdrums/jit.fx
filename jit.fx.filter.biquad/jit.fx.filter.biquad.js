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
    texIn0.freepeer();
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

var texIn0 = new JitterObject("jit.gl.texture", drawto);
var texIn1 = new JitterObject("jit.gl.texture", drawto);
var texIn2 = new JitterObject("jit.gl.texture", drawto);
var texIn3 = new JitterObject("jit.gl.texture", drawto);
var texIn4 = new JitterObject("jit.gl.texture", drawto);

var slab = new JitterObject("jit.gl.slab", drawto);
slab.file = "jit.fx.filter.biquad.jxs";
slab.inputs = 5;
slab.outputs = 4;

var _theta = 0;
var _anchor_x = 0;
var _anchor_y = 0;
var _offset_x = 0;
var _offset_y = 0;
var _zoom_x = 1;
var _zoom_y = 1;
var _boundmode = 0;

slab.param("theta", _theta);
slab.param("anchor_x", _anchor_x);
slab.param("anchor_y", _anchor_y);
slab.param("offset_x", _offset_x);
slab.param("offset_y", _offset_y);
slab.param("zoom_x", _zoom_x);
slab.param("zoom_y", _zoom_y);
slab.param("boundmode", _boundmode);

function theta(){ _theta = arguments[0]; slab.param("theta", _theta); }
function anchor_x(){ _anchor_x = arguments[0]; slab.param("anchor_x", _anchor_x); }
function anchor_y(){ _anchor_y = arguments[0]; slab.param("anchor_y", _anchor_y); }
function offset_x(){ _offset_x = arguments[0]; slab.param("offset_x", _offset_x); }
function offset_y(){ _offset_y = arguments[0]; slab.param("offset_y", _offset_y); }
function zoom_x(){ _zoom_x = arguments[0]; slab.param("zoom_x", _zoom_x); }
function zoom_y(){ _zoom_y = arguments[0]; slab.param("zoom_y", _zoom_y); }
function boundmode(){ _boundmode = arguments[0]; slab.param("boundmode", _boundmode); }

function jit_gl_texture(inname){

	if(_boundmode == 0){
		slab.activeinput = 1;
		slab.jit_gl_texture(fdbkTex.name);
		slab.activeinput = 0;
		slab.jit_gl_texture(inname);
		slab.draw();
		fdbkTex.jit_gl_texture(slab.out_name);
	} else {
		slab.activeinput = 0;
		slab.jit_gl_texture(inname);	
		slab.draw();	
	}

	

	outlet(0, "jit_gl_texture", slab.out_name);
}