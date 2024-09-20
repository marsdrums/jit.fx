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
    mesh.freepeer();
    node_vor.freepeer();
    node_del.freepeer();
    uvMat_vor.freepeer();
    uvMat_del.freepeer();
    shader_vor.freepeer();
    shader_del.freepeer();
    salb_resolve.freepeer();
    slab_combine.freepeer();
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


var _threshold = 0.5;
var _radius = 0.3;
var _randomness = 0.05;
var _num_edges = 25;
var _line_width = 1;
var _start_angle = 0;
var _complete = 1;
var _draw_mode = 0;
var _line_growth = 0;
var _line_fade = 1;
var _outdim = [1920, 1080];

var inTex = new JitterObject("jit.gl.texture", drawto);
inTex.type = "float32";

var node_vor = new JitterObject("jit.gl.node", drawto);
node_vor.adapt = 0;
node_vor.capture = 1;
node_vor.erase_color = [0,0,0,0];
node_vor.dim = [1920, 1080];
node_vor.type = "float32";

var node_del = new JitterObject("jit.gl.node", drawto);
node_del.adapt = 0;
node_del.capture = 1;
node_del.erase_color = [0,0,0,0];
node_del.dim = [1920, 1080];
node_del.type = "float32";

var shader_vor = new JitterObject("jit.gl.shader", node_vor.name);
shader_vor.file = "jit.fx.pattern_voronoi.jxs";

var shader_del = new JitterObject("jit.gl.shader", drawto);
shader_del.file = "jit.fx.pattern_delaunay.jxs";

var uvMat_vor = new JitterMatrix(3, "float32", 100, 100);
uvMat_vor.exprfill(0, "norm[0]");
uvMat_vor.exprfill(1, "norm[1]");

var uvMat_del = new JitterMatrix(3, "float32", node_del.dim);
uvMat_del.exprfill(0, "norm[0]");
uvMat_del.exprfill(1, "norm[1]");

var mesh = new JitterObject("jit.gl.mesh", node_vor.name);
mesh.draw_mode = "points";
mesh.blend_enable = 0;
mesh.depth_enable = 1;
mesh.texture = inTex.name;
mesh.shader = shader_vor.name;
mesh.jit_matrix(uvMat_vor.name);

var mesh_del = new JitterObject("jit.gl.mesh", node_del.name);
mesh_del.draw_mode = "points";
mesh_del.blend_enable = 0;
mesh_del.depth_enable = 1;
mesh_del.texture = node_vor.out_name;
mesh_del.shader = shader_del.name;
mesh_del.jit_matrix(uvMat_del.name);

var salb_resolve = new JitterObject("jit.gl.slab", drawto);
salb_resolve.file = "jit.fx.pattern_resolve.jxs";
salb_resolve.inputs = 1;
salb_resolve.type = "float32";

var slab_combine = new JitterObject("jit.gl.slab", drawto);
slab_combine.file = "jit.fx.pattern_combine.jxs";
slab_combine.inputs = 2;
slab_combine.type = "float32";


function threshold(){
	_threshold = Math.max(0.01, arguments[0]);
	shader_vor.param("threshold", _threshold);
}

function radius(){
	_radius = Math.min(2.8284271247, arguments[0]); //limit < 2*sqrt(2)
	shader_vor.param("radius", _radius);
}

function randomness(){
	_randomness = arguments[0];
	shader_vor.param("randomness", _randomness);
}

function num_edges(){
	_num_edges = Math.max(3, arguments[0]);
	shader_vor.param("num_edges", _num_edges);
}

function line_width(){
	_line_width = arguments[0];
	salb_resolve.param("line_width", _line_width);
	shader_del.param("line_width", _line_width*2);
}

function start_angle(){
	_start_angle = arguments[0];
	shader_vor.param("start_angle", _start_angle);
}

function complete(){
	_complete = Math.max(0, Math.min(1, arguments[0]));
	shader_vor.param("complete", _complete);
}

function draw_mode(){
	_draw_mode = arguments[0];
}

function line_growth(){
	_line_growth = arguments[0];
	salb_resolve.param("line_growth", _line_growth);
}

function line_fade(){
	_line_fade = arguments[0];
	salb_resolve.param("line_fade", _line_fade);
	shader_del.param("line_fade", _line_fade);
}

function update_dim(dim){
	if(uvMat_vor.dim[0] != dim[0] || uvMat_vor.dim[1] != dim[1]){
		uvMat_vor.dim = [ dim[0], dim[1] ];
		uvMat_vor.exprfill(0, "norm[0]");
		uvMat_vor.exprfill(1, "norm[1]");
		mesh.jit_matrix(uvMat_vor.name);
	}
}

function outdim(){
	_outdim = [ arguments[0], arguments[1] ];
	node_vor.dim = _outdim;
	node_del.dim = _outdim;
	shader_vor.param("outdim", _outdim);
	uvMat_del.dim = _outdim;
	uvMat_del.exprfill(0, "norm[0]");
	uvMat_del.exprfill(1, "norm[1]");
	mesh_del.jit_matrix(uvMat_del.name);
}

function jit_gl_texture(inname){

	inTex.jit_gl_texture(inname);

	update_dim(inTex.dim);

	node_vor.draw();

	switch(_draw_mode) {
	  case 0:
		salb_resolve.jit_gl_texture(node_vor.out_name);
		salb_resolve.draw();
		outlet(0, "jit_gl_texture", salb_resolve.out_name);	
	    break;
	  case 1:
		node_del.draw();
		outlet(0, "jit_gl_texture", node_del.out_name);	
	    break;
	  case 2:
	  	salb_resolve.jit_gl_texture(node_vor.out_name);
		salb_resolve.draw();
		node_del.draw();
		slab_combine.activeinput = 1;
		slab_combine.jit_gl_texture(node_del.out_name);
		slab_combine.activeinput = 0;
		slab_combine.jit_gl_texture(salb_resolve.out_name);
		slab_combine.draw();
		outlet(0, "jit_gl_texture", slab_combine.out_name);	
	    break;
	  case 3:
		outlet(0, "jit_gl_texture", node_vor.out_name);	
	    break;
	}

}