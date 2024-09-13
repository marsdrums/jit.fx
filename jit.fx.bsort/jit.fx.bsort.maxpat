{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 9,
			"minor" : 0,
			"revision" : 0,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 506.0, 165.0, 1210.0, 795.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"assistshowspatchername" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-20",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 228.0, 108.0, 70.0, 22.0 ],
					"text" : "loadmess 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-19",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 228.0, 146.0, 24.0, 24.0 ],
					"svg" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-17",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 228.0, 185.0, 105.0, 22.0 ],
					"text" : "prepend dimmode"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-13",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 40.0, 24.0, 58.0, 22.0 ],
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 40.0, 64.0, 183.0, 22.0 ],
					"text" : "output_texture 1, loop 1, vol 0., 1"
				}

			}
, 			{
				"box" : 				{
					"data" : 					{
						"clips" : [ 							{
								"absolutepath" : "blading.mov",
								"filename" : "blading.mov",
								"filekind" : "moviefile",
								"id" : "u706003754",
								"loop" : 1,
								"content_state" : 								{
									"loop" : 1,
									"vol" : 0.0
								}

							}
 ]
					}
,
					"drawto" : "",
					"id" : "obj-10",
					"loop" : 1,
					"maxclass" : "jit.playlist",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "jit_gl_texture", "", "dictionary" ],
					"output_texture" : 1,
					"parameter_enable" : 0,
					"patching_rect" : [ 40.0, 108.0, 150.0, 30.0 ],
					"saved_attribute_attributes" : 					{
						"candicane2" : 						{
							"expression" : ""
						}
,
						"candicane3" : 						{
							"expression" : ""
						}
,
						"candicane4" : 						{
							"expression" : ""
						}
,
						"candicane5" : 						{
							"expression" : ""
						}
,
						"candicane6" : 						{
							"expression" : ""
						}
,
						"candicane7" : 						{
							"expression" : ""
						}
,
						"candicane8" : 						{
							"expression" : ""
						}

					}

				}

			}
, 			{
				"box" : 				{
					"filename" : "jit.fx.bsort.js",
					"id" : "obj-2",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 40.0, 212.0, 88.0, 22.0 ],
					"saved_object_attributes" : 					{
						"parameter_enable" : 0
					}
,
					"text" : "v8 jit.fx.bsort.js",
					"textfile" : 					{
						"text" : "autowhatch = 1; inlets = 1; outlets = 1;\n\n\n//______ GRAB CONTEXT ______________________________________________________________________\n\nvar drawto = \"\";\ndeclareattribute(\"drawto\", null, \"dosetdrawto\", 0);\n\nvar implicitdrawto = \"\";\nvar swaplisten = null; // The listener for the jit.world\nvar explicitdrawto = false;\nvar proxy = null;\nvar swapListener = null;\n\nif(max.version >= 820) {\n    proxy = new JitterObject(\"jit.proxy\");\n}\n\nvar implicit_tracker = new JitterObject(\"jit_gl_implicit\"); // dummy oggetto gl\nvar implicit_lstnr = new JitterListener(implicit_tracker.name, implicit_callback);\n\nfunction implicit_callback(event) { \n\t// se non stai mettendo ctx a mano e se implicitdrawto != dal nome di implicit\n\tif(!explicitdrawto && implicitdrawto != implicit_tracker.drawto[0]) {\n\t\t// important! drawto is an array so get first element\n\t\timplicitdrawto = implicit_tracker.drawto[0];\n        //FF_Utils.Print(\"IMPLICIT CLL\", implicitdrawto);\n\t\tdosetdrawto(implicitdrawto);\n\t}\n}\nimplicit_callback.local = 1;\n\nfunction setDrawto(val) {\n\texplicitdrawto = true;\n\tdosetdrawto(val);\n};\n\nfunction dosetdrawto(newdrawto) {\n\tif(newdrawto == drawto || !newdrawto) {\n\t\t// bounce\n        //FF_Utils.Print(\"bouncer\");\n\t\treturn;\n\t}\n\tif(proxy !== undefined) {\n\t\tproxy.name = newdrawto;\n        // viene chiamato quando abbiamo classe\n        if(proxy.class !== undefined && proxy.class != \"\") {\n\t\t\t// drawto may be root render or sub-node\n\t\t\t// if root the class will return jit_gl_context_view\n\t\t\tif(proxy.class != \"jit_gl_context_view\") { // jit_gl_context_view = node dentro world\n\t\t\t\t// class is a sub-node, get the drawto on that\n\t\t\t\tproxydrawto = proxy.send(\"getdrawto\"); // prendi drawto di world che sarebbe nome del node\n\t\t\t\t// recurse until we get root\n\t\t\t\t// important! drawto is an array so get first element\n                //FF_Utils.Print(\"proxy class\", proxy.class);\n                //FF_Utils.Print(\"DIVERSo da contxt_view\", implicitdrawto);\n\n\t\t\t\treturn dosetdrawto(proxydrawto[0]);\n\t\t\t}\n\t\t}\n\t\telse {\n            // viene chiamato se non abbiamo classe\n\t\t\tproxydrawto = proxy.send(\"getdrawto\");\n\t\t\tif(proxydrawto !== null && proxydrawto !== undefined) {\n                //FF_Utils.Print(\"SE E NODE??\", proxydrawto[0]);\n\n\t\t\t\treturn dosetdrawto(proxydrawto[0]);  // name of the internal node\n\t\t\t}\n\t\t}\n\t}\n    //FF_Utils.Print(\"ASSEGNA drawto\", newdrawto);\n    drawto = newdrawto;\n    // chiama cose che vanno inizializzate quando c'è il drawto\n    // assegna listener per ctx\n    swapListener = new JitterListener(drawto, swapCallback);\n}\ndosetdrawto.local = 1;\n\nfunction destroyFindCTX() {\n\timplicit_lstnr.subjectname = \"\"\n\timplicit_tracker.freepeer();\n}\ndestroyFindCTX.local = 1;\n\nfunction notifydeleted() {\n    destroyFindCTX();\n    slab.freepeer();\n    //slab_hor.freepeer();\n    fdbkTex.freepeer();\n}\n/*\n// ___ GRAB JIT.WORLD BANG____________________________________________\nvar swapCallback = function(event) {\n    switch (event.eventname) {\n        case (\"swap\" || \"draw\"):\n        \t//bang();\n            // FF_Utils.Print(\"BANG\")\n            break;\n        //case \"mouse\": case \"mouseidle\": \n        //    FF_Utils.Print(\"MOUSE\", event.args)\n        //    break;\n        case \"willfree\":\n            //FF_Utils.Print(\"DESTROY\")\n            break;\n        default: \n            break;\n    }\n}\n*/\n\n\nvar slab = new JitterObject(\"jit.gl.slab\", drawto);\nslab.file = \"jit.fx.bsort.jxs\";\nslab.inputs = 1;\n\nvar fdbkTex = new JitterObject(\"jit_gl_texture\", drawto);\nfdbkTex.adapt = 1;\n\nvar _dimmode = 0;\n\nfunction dimmode(){ \n\t_dimmode = arguments[0];\n\tslab.param(\"dimmode\", _dimmode);\n}\n\nfunction jit_gl_texture(inname){\n\n\tfdbkTex.jit_gl_texture(inname);\n\n\t\n\tfor(var i = 0; i < fdbkTex.dim[_dimmode]; i++){\n\n\t\tslab.param(\"off\", i);\n\t\tslab.jit_gl_texture(fdbkTex.name);\n\t\tslab.draw();\n\n\t\tfdbkTex.jit_gl_texture(slab.out_name);\t\n\t}\n\n\toutlet(0, \"jit_gl_texture\", fdbkTex.name);\n}",
						"filename" : "jit.fx.bsort.js",
						"flags" : 0,
						"embed" : 0,
						"autowatch" : 1
					}

				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"maxclass" : "jit.pwindow",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "jit_matrix", "" ],
					"patching_rect" : [ 40.0, 297.0, 650.0, 430.0 ],
					"sync" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-4",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "jit_matrix", "bang", "" ],
					"patching_rect" : [ 76.0, 257.0, 111.0, 22.0 ],
					"text" : "jit.world @enable 1"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-2", 0 ],
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-12", 0 ],
					"source" : [ "obj-13", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-2", 0 ],
					"source" : [ "obj-17", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-17", 0 ],
					"source" : [ "obj-19", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"order" : 1,
					"source" : [ "obj-2", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-4", 0 ],
					"order" : 0,
					"source" : [ "obj-2", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-19", 0 ],
					"source" : [ "obj-20", 0 ]
				}

			}
 ],
		"originid" : "pat-2",
		"dependency_cache" : [ 			{
				"name" : "blading.mov",
				"bootpath" : "C74:/media/jitter",
				"type" : "MooV",
				"implicit" : 1
			}
, 			{
				"name" : "jit.fx.bsort.js",
				"bootpath" : "~/Documents/GitHub/jit.fx/jit.fx.bsort",
				"patcherrelativepath" : ".",
				"type" : "TEXT",
				"implicit" : 1
			}
 ],
		"autosave" : 0
	}

}
