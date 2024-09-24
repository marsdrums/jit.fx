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
    node.freepeer();
    mesh.freepeer();
    shader.freepeer();
    slab_vectors.freepeer();
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

var _rotation = 1.0;
var _outdim = [1920, 1080];
var _step = 1;
var _filter = 0.0;
var _randomness = 0.0;

var inTex = new JitterObject("jit.gl.texture", drawto);
inTex.rectangle = 1;
inTex.type = "float32";


var slab_vectors = new JitterObject("jit.gl.slab", drawto);
slab_vectors.file = "jit.fx.flowfield_make_vectors.jxs";
slab_vectors.inputs = 1;
slab_vectors.type = "float32";
slab_vectors.filter = "linear";

var node = new JitterObject("jit.gl.node", drawto);
node.capture = 1;
node.type = "float32";
node.adapt = 0;
node.erase_color = [0,0,0,0];
node.dim = [1920,1080];

var shader = new JitterObject("jit.gl.shader", drawto);
shader.file = "jit.fx.flowfield_draw_lines.jxs";

var mesh = new JitterObject("jit.gl.mesh", node.name);
mesh.draw_mode = "points";
mesh.blend_enable = 1;
mesh.depth_enable = 0;
mesh.texture = inTex.name;
mesh.shader = shader.name;
mesh.blend = "alphaadd";

var inMat = new JitterMatrix(3, "float32", 1, 1);

function rotation(){
	_rotation = arguments[0];
	slab_vectors.param("rotation", _rotation);
	shader.param("rotation", _rotation*Math.PI*2);
}

function step(){
	_step = arguments[0];
	shader.param("step", _step);
}

function outdim(){
	_outdim = [arguments[0], arguments[1]];
	node.dim = _outdim;
}

function filter(){
	_filter = Math.max(0.0, Math.min(1.0, arguments[0]));
	shader.param("smoothness", _filter);
}

function randomness(){
	_randomness = arguments[0];
	shader.param("randomness", _randomness);
}

function updateDim(){
	if(inMat.dim[0] != inTex.dim[0] || inMat.dim[1] != inTex.dim[1]){
		inMat.dim = inTex.dim.slice(0, 2);
		inMat.exprfill(0, "norm[0]");
		inMat.exprfill(1, "norm[1]");
		mesh.jit_matrix(inMat.name);
	}
}


function jit_gl_texture(inname){

	inTex.jit_gl_texture(inname);

	updateDim();

	slab_vectors.jit_gl_texture(inTex.name);
	slab_vectors.draw();

	inTex.jit_gl_texture(slab_vectors.out_name);

	node.draw();

	outlet(0, "jit_gl_texture", node.out_name);
}