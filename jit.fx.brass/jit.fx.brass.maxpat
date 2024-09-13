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
		"rect" : [ 646.0, 100.0, 600.0, 881.0 ],
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
					"format" : 6,
					"id" : "obj-17",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 457.0, 158.0, 53.0, 22.0 ],
					"triscale" : 0.9
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-16",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 396.0, 158.0, 53.0, 22.0 ],
					"triscale" : 0.9
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-15",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 335.0, 158.0, 53.0, 22.0 ],
					"triscale" : 0.9
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-11",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 308.0, 101.0, 80.0, 22.0 ],
					"text" : "loadmess 0.5"
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-13",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 274.0, 158.0, 53.0, 22.0 ],
					"triscale" : 0.9
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-8",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 133.0, 127.0, 73.0, 22.0 ],
					"text" : "loadmess 2."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 251.0, 197.0, 87.0, 22.0 ],
					"text" : "pak offset f f f f"
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-1",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 133.0, 158.0, 53.0, 22.0 ],
					"triscale" : 0.9
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-3",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 133.0, 197.0, 84.0, 22.0 ],
					"text" : "prepend width"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"maxclass" : "jit.pwindow",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "jit_matrix", "" ],
					"patching_rect" : [ 54.0, 343.0, 469.0, 345.0 ],
					"sync" : 1
				}

			}
, 			{
				"box" : 				{
					"filename" : "jit.fx.brass.js",
					"id" : "obj-72",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 54.0, 252.0, 91.0, 22.0 ],
					"saved_object_attributes" : 					{
						"parameter_enable" : 0
					}
,
					"text" : "v8 jit.fx.brass.js",
					"textfile" : 					{
						"text" : "autowhatch = 1; inlets = 1; outlets = 1;\n\n\n//______ GRAB CONTEXT ______________________________________________________________________\n\nvar drawto = \"\";\ndeclareattribute(\"drawto\", null, \"dosetdrawto\", 0);\n\nvar implicitdrawto = \"\";\nvar swaplisten = null; // The listener for the jit.world\nvar explicitdrawto = false;\nvar proxy = null;\nvar swapListener = null;\n\nif(max.version >= 820) {\n    proxy = new JitterObject(\"jit.proxy\");\n}\n\nvar implicit_tracker = new JitterObject(\"jit_gl_implicit\"); // dummy oggetto gl\nvar implicit_lstnr = new JitterListener(implicit_tracker.name, implicit_callback);\n\nfunction implicit_callback(event) { \n\t// se non stai mettendo ctx a mano e se implicitdrawto != dal nome di implicit\n\tif(!explicitdrawto && implicitdrawto != implicit_tracker.drawto[0]) {\n\t\t// important! drawto is an array so get first element\n\t\timplicitdrawto = implicit_tracker.drawto[0];\n        //FF_Utils.Print(\"IMPLICIT CLL\", implicitdrawto);\n\t\tdosetdrawto(implicitdrawto);\n\t}\n}\nimplicit_callback.local = 1;\n\nfunction setDrawto(val) {\n\texplicitdrawto = true;\n\tdosetdrawto(val);\n};\n\nfunction dosetdrawto(newdrawto) {\n\tif(newdrawto == drawto || !newdrawto) {\n\t\t// bounce\n        //FF_Utils.Print(\"bouncer\");\n\t\treturn;\n\t}\n\tif(proxy !== undefined) {\n\t\tproxy.name = newdrawto;\n        // viene chiamato quando abbiamo classe\n        if(proxy.class !== undefined && proxy.class != \"\") {\n\t\t\t// drawto may be root render or sub-node\n\t\t\t// if root the class will return jit_gl_context_view\n\t\t\tif(proxy.class != \"jit_gl_context_view\") { // jit_gl_context_view = node dentro world\n\t\t\t\t// class is a sub-node, get the drawto on that\n\t\t\t\tproxydrawto = proxy.send(\"getdrawto\"); // prendi drawto di world che sarebbe nome del node\n\t\t\t\t// recurse until we get root\n\t\t\t\t// important! drawto is an array so get first element\n                //FF_Utils.Print(\"proxy class\", proxy.class);\n                //FF_Utils.Print(\"DIVERSo da contxt_view\", implicitdrawto);\n\n\t\t\t\treturn dosetdrawto(proxydrawto[0]);\n\t\t\t}\n\t\t}\n\t\telse {\n            // viene chiamato se non abbiamo classe\n\t\t\tproxydrawto = proxy.send(\"getdrawto\");\n\t\t\tif(proxydrawto !== null && proxydrawto !== undefined) {\n                //FF_Utils.Print(\"SE E NODE??\", proxydrawto[0]);\n\n\t\t\t\treturn dosetdrawto(proxydrawto[0]);  // name of the internal node\n\t\t\t}\n\t\t}\n\t}\n    //FF_Utils.Print(\"ASSEGNA drawto\", newdrawto);\n    drawto = newdrawto;\n    // chiama cose che vanno inizializzate quando c'è il drawto\n    // assegna listener per ctx\n    swapListener = new JitterListener(drawto, swapCallback);\n}\ndosetdrawto.local = 1;\n\nfunction destroyFindCTX() {\n\timplicit_lstnr.subjectname = \"\"\n\timplicit_tracker.freepeer();\n}\ndestroyFindCTX.local = 1;\n\nfunction notifydeleted() {\n    destroyFindCTX();\n    slab.freepeer();\n}\n/*\n// ___ GRAB JIT.WORLD BANG____________________________________________\nvar swapCallback = function(event) {\n    switch (event.eventname) {\n        case (\"swap\" || \"draw\"):\n        \t//bang();\n            // FF_Utils.Print(\"BANG\")\n            break;\n        //case \"mouse\": case \"mouseidle\": \n        //    FF_Utils.Print(\"MOUSE\", event.args)\n        //    break;\n        case \"willfree\":\n            //FF_Utils.Print(\"DESTROY\")\n            break;\n        default: \n            break;\n    }\n}\n*/\n\nvar slab = new JitterObject(\"jit.gl.slab\", drawto);\nslab.file = \"jit.fx.brass.jxs\";\nslab.inputs = 1;\n\nvar _width = 2.0;\nvar _offset = [0.5, 0.5, 0.5, 0.5];\n\nfunction width(){\n\t_width = arguments[0];\n\tslab.param(\"width\", _width);\n}\nfunction offset(){\n\t_offset = arguments[0];\n\tslab.param(\"offset\", _offset);\n}\n\nfunction jit_gl_texture(inname){\n\n\tslab.jit_gl_texture(inname);\n\tslab.draw();\n\n\toutlet(0, \"jit_gl_texture\", slab.out_name);\n}",
						"filename" : "jit.fx.brass.js",
						"flags" : 0,
						"embed" : 0,
						"autowatch" : 1
					}

				}

			}
, 			{
				"box" : 				{
					"id" : "obj-10",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 54.0, 12.0, 58.0, 22.0 ],
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-9",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 54.0, 51.0, 183.0, 22.0 ],
					"text" : "output_texture 1, loop 1, vol 0., 1"
				}

			}
, 			{
				"box" : 				{
					"data" : 					{
						"clips" : [ 							{
								"absolutepath" : "chickens.mp4",
								"filename" : "chickens.mp4",
								"filekind" : "moviefile",
								"id" : "u196009576",
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
					"id" : "obj-7",
					"loop" : 1,
					"maxclass" : "jit.playlist",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "jit_gl_texture", "", "dictionary" ],
					"output_texture" : 1,
					"parameter_enable" : 0,
					"patching_rect" : [ 54.0, 89.0, 150.0, 30.0 ],
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
					"id" : "obj-5",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "jit_matrix", "bang", "" ],
					"patching_rect" : [ 112.0, 297.0, 111.0, 22.0 ],
					"text" : "jit.world @enable 1"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-9", 0 ],
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-13", 0 ],
					"order" : 3,
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-15", 0 ],
					"order" : 2,
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-16", 0 ],
					"order" : 1,
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-17", 0 ],
					"order" : 0,
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 1 ],
					"source" : [ "obj-13", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 2 ],
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 3 ],
					"source" : [ "obj-16", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 4 ],
					"source" : [ "obj-17", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-72", 0 ],
					"source" : [ "obj-3", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-72", 0 ],
					"source" : [ "obj-6", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-72", 0 ],
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"order" : 1,
					"source" : [ "obj-72", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-5", 0 ],
					"order" : 0,
					"source" : [ "obj-72", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 0 ],
					"source" : [ "obj-8", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-7", 0 ],
					"source" : [ "obj-9", 0 ]
				}

			}
 ],
		"originid" : "pat-315",
		"dependency_cache" : [ 			{
				"name" : "chickens.mp4",
				"bootpath" : "C74:/media/jitter",
				"type" : "mpg4",
				"implicit" : 1
			}
, 			{
				"name" : "jit.fx.brass.js",
				"bootpath" : "~/Documents/GitHub/jit.fx/jit.fx.brass",
				"patcherrelativepath" : ".",
				"type" : "TEXT",
				"implicit" : 1
			}
 ],
		"autosave" : 0
	}

}
