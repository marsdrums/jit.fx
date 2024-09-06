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
    slab_hor.freepeer();
    slab_ver.freepeer();
    texIn.freepeer();
    texDummy.freepeer();
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

var slab_hor = new JitterObject("jit.gl.slab", drawto);
slab_hor.file = "jit.fx.analysis.max_reduce_hor.jxs";
slab_hor.inputs = 2;

var slab_ver = new JitterObject("jit.gl.slab", drawto);
slab_ver.file = "jit.fx.analysis.max_reduce_ver.jxs";
slab_ver.inputs = 2;

var texIn = new JitterObject("jit.gl.texture", drawto);
texIn.rectangle = 1;

var texDummy = new JitterObject("jit.gl.texture", drawto);
texDummy.rectangle = 1;


function jit_gl_texture(inname){

	texIn.jit_gl_texture(inname);

	while(texIn.dim[0] > 1){

		texDummy.dim = [	Math.floor((texIn.dim[0] / 2)+0.5), 
							Math.floor((texIn.dim[1] / 2)+0.5)];

		slab_hor.activeinput = 1;
		slab_hor.jit_gl_texture(texIn.name);

		slab_hor.activeinput = 0;
		slab_hor.jit_gl_texture(texDummy.name);

		slab_hor.draw();

		texIn.jit_gl_texture(slab_hor.out_name);
	}

	while(texIn.dim[1] > 1){

		texDummy.dim = [	Math.floor((texIn.dim[0] / 2)+0.5), 
							Math.floor((texIn.dim[1] / 2)+0.5)];

		slab_ver.activeinput = 1;
		slab_ver.jit_gl_texture(texIn.name);

		slab_ver.activeinput = 0;
		slab_ver.jit_gl_texture(texDummy.name);

		slab_ver.draw();

		texIn.jit_gl_texture(slab_ver.out_name);
	}

	outlet(0, "jit_gl_texture", texIn.name);
}