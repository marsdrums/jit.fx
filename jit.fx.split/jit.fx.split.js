autowhatch = 1; inlets = 1; outlets = 2;


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
    inTex.freepeer();
    slabLeft.freepeer();
    slabRight.freepeer();

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

var _splitpoiint = 1;
var _splitdim = 0;
var ratio;
var dimscale;

var inTex = new JitterObject("jit.gl.texture", drawto);

var slabLeft = new JitterObject("jit.gl.slab", drawto);
slabLeft.file = "jit.fx.split_left.jxs";

var slabRight = new JitterObject("jit.gl.slab", drawto);
slabRight.file = "jit.fx.split_right.jxs";


function splitpoint(){
	_splitpoint = arguments[0];
}

function splitdim(){
	if(arguments[0] != 0 && arguments[0] != 1) return;
	_splitdim = arguments[0];
}


function jit_gl_texture(inname){

	inTex.jit_gl_texture(inname);

	_splitpoint = Math.max(_splitpoint, 0);
	_splitpoint = Math.min(_splitpoint, inTex.dim[_splitdim] - 1);

	ratio = _splitpoint / inTex.dim[_splitdim];
	dimscale = _splitdim == 0 ? [ratio, 1] : [1, ratio];

	slabLeft.param("ratio", ratio);
	slabLeft.param("splitdim", _splitdim);
	slabLeft.dimscale = dimscale; 
	slabLeft.jit_gl_texture(inname);
	slabLeft.draw();

	ratio = 1 - ratio;
	slabRight.param("ratio", ratio);
	slabRight.param("splitdim", _splitdim);
	dimscale = _splitdim == 0 ? [ratio, 1] : [1, ratio];
	slabRight.dimscale = dimscale; 
	slabRight.jit_gl_texture(inname);
	slabRight.draw();

	outlet(1 - _splitdim, "jit_gl_texture", slabRight.out_name);
	outlet(_splitdim, "jit_gl_texture", slabLeft.out_name);


}
