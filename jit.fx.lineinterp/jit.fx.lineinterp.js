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
    inTex.freepeer();
    inTex2.freepeer();
    slab_threshold.freepeer();
    slab_transitions.freepeer();
    node_startend.freepeer();
    shader_startend.freepeer();
    mesh_startend.freepeer();
    node_makeline.freepeer();
    slab_combine.freepeer();
    shader_makeline.freepeer();
    mesh_makeline.freepeer();
    slab_composite.freepeer();
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

var _lo = 0.0;
var _hi = 0.5;
var _dimmode = 0; 
var _colormode = 0; 

var inTex = new JitterObject("jit.gl.texture", drawto);
inTex.rectangle = 1;
inTex.type = "float32";
inTex.filter = "nearest";

var inTex2 = new JitterObject("jit.gl.texture", drawto);
inTex2.rectangle = 1;
inTex2.type = "float32";
inTex2.filter = "nearest";

var fdbkTex = new JitterObject("jit.gl.texture", drawto);
fdbkTex.rectangle = 1;
fdbkTex.type = "float32";
fdbkTex.filter = "nearest";

var slab_threshold = new JitterObject("jit.gl.slab", drawto);
slab_threshold.file = "jit.fx.lineinterp_threshold.jxs";
slab_threshold.inputs = 1;
slab_threshold.type = "float32";
slab_threshold.rectangle = 1;
slab_threshold.automatic = 0;

var slab_transitions = new JitterObject("jit.gl.slab", drawto);
slab_transitions.file = "jit.fx.lineinterp_find_transitions.jxs";
slab_transitions.inputs = 1;
slab_transitions.type = "float32";
slab_transitions.rectangle = 1;
slab_transitions.automatic = 0;

var inMat = new JitterMatrix(3, "float32", 1, 1);

var node_startend = new JitterObject("jit.gl.node", drawto);
node_startend.adapt = 0;
node_startend.type = "float32";
node_startend.dim = [1, 1];
node_startend.erase_color = [0,0,0,0];
node_startend.capture = 1;
node_startend.rectangle = 1;
node_startend.automatic = 0;

var shader_startend = new JitterObject("jit.gl.shader", drawto);
shader_startend.file = "jit.fx.lineinterp_find_start_end.jxs";

var mesh_startend = new JitterObject("jit.gl.mesh", node_startend.name);
mesh_startend.draw_mode = "points";
mesh_startend.texture = slab_transitions.out_name;
mesh_startend.shader = shader_startend.name;
mesh_startend.blend_enable = 0;
mesh_startend.depth_enable = 1;

var slab_combine = new JitterObject("jit.gl.slab", drawto);
slab_combine.file = "jit.fx.lineinterp_combine_start_stop.jxs";
slab_combine.inputs = 2;
slab_combine.type = "float32";
slab_combine.rectangle = 1;
slab_combine.automatic = 0;

var node_makeline = new JitterObject("jit.gl.node", drawto);
node_makeline.adapt = 0;
node_makeline.type = "float32";
node_makeline.dim = [1, 1];
node_makeline.erase_color = [0,0,0,0];
node_makeline.capture = 1;
node_makeline.rectangle = 1;
node_makeline.automatic = 0;

var shader_makeline = new JitterObject("jit.gl.shader", drawto);
shader_makeline.file = "jit.fx.lineinterp_make_line.jxs";

var mesh_makeline = new JitterObject("jit.gl.mesh", node_makeline.name);
mesh_makeline.draw_mode = "points";
mesh_makeline.texture = [	inTex.name, 
							inTex2.name
						];
mesh_makeline.shader = shader_makeline.name;

var slab_composite = new JitterObject("jit.gl.slab", drawto);
slab_composite.file = "jit.fx.lineinterp_composite.jxs";
slab_composite.inputs = 2;
slab_composite.type = "float32";
slab_composite.automatic = 0;
//slab_composite.rectangle = 1;

function dimmode(){
	_dimmode = arguments[0];
	slab_transitions.param("dimmode", _dimmode);
	shader_startend.param("dimmode", _dimmode);
}

function colormode(){
	_colormode = arguments[0];
	shader_makeline.param("colormode", _colormode);

}

function lo() {
	_lo = arguments[0];
	slab_threshold.param("lo", _lo);
}

function hi() {
	_hi = arguments[0];
	slab_threshold.param("hi", _hi);
}

function update_dim(){

	if(inMat.dim[0] != inTex.dim[0] || inMat.dim[1] != inTex.dim[1]){
		inMat.dim = inTex.dim.slice(0, 2);
		node_startend.dim = inMat.dim;
		node_makeline.dim = inMat.dim;
		inMat.exprfill(0, "norm[0]");
		inMat.exprfill(1, "norm[1]");
		mesh_startend.jit_matrix(inMat.name);
		mesh_makeline.jit_matrix(inMat.name);
	}
}

function jit_gl_texture(inname){

	inTex.jit_gl_texture(inname);

	update_dim();

	slab_threshold.jit_gl_texture(inTex.name);
	slab_threshold.draw();

	slab_transitions.jit_gl_texture(slab_threshold.out_name);
	slab_transitions.draw();

	node_startend.draw();

	slab_combine.activeinput = 1;
	slab_combine.jit_gl_texture(node_startend.out_name);
	slab_combine.activeinput = 0;
	slab_combine.jit_gl_texture(slab_transitions.out_name);
	slab_combine.draw();

	inTex2.jit_gl_texture(slab_combine.out_name);

	node_makeline.draw();

	slab_composite.activeinput = 1;
	slab_composite.jit_gl_texture(node_makeline.out_name);
	slab_composite.activeinput = 0;
	slab_composite.jit_gl_texture(fdbkTex.name);
	slab_composite.draw();

	outlet(0, "jit_gl_texture", slab_composite.out_name);

	fdbkTex.jit_gl_texture(inTex.name);
}