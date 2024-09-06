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
    slab_ver.freepeer();
    slab_hor.freepeer();
    fdbkTex.freepeer();
    maskTex.freepeer();
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


var slab_ver = new JitterObject("jit.gl.slab", drawto);
slab_ver.file = "jit.fx.blur.mask_vertical.jxs";
slab_ver.inputs = 1;

var slab_hor = new JitterObject("jit.gl.slab", drawto);
slab_hor.file = "jit.fx.blur.mask_horizontal.jxs";
slab_hor.inputs = 1;

var fdbkTex = new JitterObject("jit_gl_texture", drawto);
fdbkTex.adapt = 1;

var maskTex = new JitterObject("jit_gl_texture", drawto);
maskTex.rectangle = 0;

var _blur_amount = 0;
slab_ver.param("blur_amount", _blur_amount);
slab_hor.param("blur_amount", _blur_amount);

function blur_amount(){ 
	_blur_amount = arguments[0];

}

var tile = new Array(2);
var amt;

function jit_matrix(inname){

	if(inlet == 1){
		maskTex.jit_matrix(inname);
		slab_ver.activeinput = 1;
		slab_hor.activeinput = 1;
		slab_ver.jit_gl_texture(maskTex.name);
		slab_hor.jit_gl_texture(maskTex.name);
	}
}

function jit_gl_texture(inname){

	if(inlet == 1){
		maskTex.jit_gl_texture(inname);
		slab_ver.activeinput = 1;
		slab_hor.activeinput = 1;
		slab_ver.jit_gl_texture(maskTex.name);
		slab_hor.jit_gl_texture(maskTex.name);

	} else {

		fdbkTex.jit_gl_texture(inname);
		
		amt = _blur_amount; 
		slab_ver.activeinput = 0;
		slab_hor.activeinput = 0;

		for(var i = 0; i < 6; i++){

			tile[0] = 128 * (i % 8);
			tile[1] = 128 * Math.floor(i / 8);
			slab_ver.param("tile", tile);
			slab_hor.param("tile", tile);
			slab_ver.param("blur_amount", amt);
			slab_hor.param("blur_amount", amt);

			slab_ver.jit_gl_texture(fdbkTex.name);
			slab_ver.draw();

			slab_hor.jit_gl_texture(slab_ver.out_name);
			slab_hor.draw();

			fdbkTex.jit_gl_texture(slab_hor.out_name);	
			amt *= 1.3333333333;	
		}		
	}



	outlet(0, "jit_gl_texture", fdbkTex.name);
}