autowhatch = 1; inlets = 2; outlets = 1;

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
    slab_blur.freepeer();
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
slab.file = "jit.fx.transition.slide.jxs";
slab.inputs = 2;

var slab_blur = new JitterObject("jit.gl.slab", drawto);
slab_blur.file = "jit.fx.filter.directional.jxs";
slab_blur.inputs = 1;
slab_blur.param("direction", [1,0]);

var fdbkTex = new JitterObject("jit_gl_texture", drawto);
fdbkTex.adapt = 1;

var _slide = 0.0;
var prevslide = 0.0;
var _motionblur = 1;
var _bluramount = 1;
var _slidedir = 0;
var amt;
var tile = new Array(2);

function slide(){
	_slide = arguments[0];
	slab.param("slide", _slide);
}

function slidedir(){
	_slidedir = arguments[0];
	slab.param("slidedir", _slidedir);
	slab_blur.param("direction", [1 - _slidedir, _slidedir]);
}

function motionblur(){
	_motionblur = arguments[0];
}

function bluramount(){
	_bluramount = arguments[0];
}

function jit_gl_texture(inname){

	if(inlet == 1){
		slab.activeinput = 1;
		slab.jit_gl_texture(inname);
	} else {
		slab.activeinput = 0;
		slab.jit_gl_texture(inname);
		slab.draw();

		amt = _slide - prevslide;

		if(_motionblur == 1 && amt != 0){

			amt = Math.abs(amt) * _bluramount;

			fdbkTex.jit_gl_texture(slab.out_name);
			slab_blur.param("center", [fdbkTex.dim[0]*0.5, fdbkTex.dim[1]*0.5]);

			amt *= 80*fdbkTex.dim[_slidedir]/fdbkTex.dim[1 - _slidedir]
			
			for(var i = 0; i < 5; i++){

				tile[0] = 128 * (i % 8);
				tile[1] = 128 * Math.floor(i / 8);
				slab_blur.param("tile", tile);
				slab_blur.param("blur_amount", amt);

				slab_blur.jit_gl_texture(fdbkTex.name);
				slab_blur.draw();

				fdbkTex.jit_gl_texture(slab_blur.out_name);	
				amt *= 1.3333333333333333;	
			}

			outlet(0, "jit_gl_texture", fdbkTex.name);	
			prevslide = _slide;
		} else {

			outlet(0, "jit_gl_texture", slab.out_name);	
		}
	}
}