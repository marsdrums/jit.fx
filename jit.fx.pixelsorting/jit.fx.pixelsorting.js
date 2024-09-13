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
    //slab_hor.freepeer();
    fdbkTex.freepeer();
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


var slab = new JitterObject("jit.gl.slab", drawto);
slab.file = "jit.fx.pixelsorting.jxs";
slab.inputs = 1;

var slab_rot = new JitterObject("jit.gl.slab", drawto);
slab_rot.file = "jit.fx.pixelsorting_rot.jxs";
slab_rot.inputs = 1;

var fdbkTex = new JitterObject("jit_gl_texture", drawto);
fdbkTex.adapt = 1;

var _dimmode = 0;
var _sortmode = 0;
var _sortmode = 0;
var _threshold = 0.4;
var _sortdir = 0;
var _angle = 0;

function dimmode(){ 
	_dimmode = arguments[0];
	slab.param("dimmode", _dimmode);
}

function sortmode(){
	_sortmode = arguments[0];
	slab.param("sortmode", _sortmode);
}

function threshold(){
	_threshold = arguments[0];
	slab.param("threshold", _threshold);
}

function sortmode(){
	_sortmode = arguments[0];
	slab.param("sortmode", _sortmode);
}

function sortdir(){
	_sortdir = arguments[0];
	slab.param("sortdir", _sortdir);
}

function angle(){
	_angle = Math.PI*arguments[0]/180;
}

function jit_gl_texture(inname){

	slab_rot.param("sinAngle", Math.sin(_angle));
	slab_rot.param("cosAngle", Math.cos(_angle));
	slab_rot.jit_gl_texture(inname);
	slab_rot.draw();

	fdbkTex.jit_gl_texture(slab_rot.out_name);
	
	for(var i = 0; i < fdbkTex.dim[_dimmode]; i++){

		slab.param("off", i);
		slab.jit_gl_texture(fdbkTex.name);
		slab.draw();

		fdbkTex.jit_gl_texture(slab.out_name);	
	}

	slab_rot.param("sinAngle", Math.sin(-_angle));
	slab_rot.param("cosAngle", Math.cos(-_angle));
	slab_rot.jit_gl_texture(fdbkTex.name);
	slab_rot.draw();

	outlet(0, "jit_gl_texture", slab_rot.out_name);
}