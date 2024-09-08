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
		"rect" : [ 175.0, 116.0, 886.0, 881.0 ],
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
					"id" : "obj-122",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 108.0, 95.0, 58.0, 22.0 ],
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-121",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 108.0, 141.0, 183.0, 22.0 ],
					"text" : "output_texture 1, loop 1, vol 0., 1"
				}

			}
, 			{
				"box" : 				{
					"data" : 					{
						"clips" : [ 							{
								"absolutepath" : "bball.mov",
								"filename" : "bball.mov",
								"filekind" : "moviefile",
								"id" : "u583011031",
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
					"id" : "obj-119",
					"loop" : 1,
					"maxclass" : "jit.playlist",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "jit_gl_texture", "", "dictionary" ],
					"output_texture" : 1,
					"parameter_enable" : 0,
					"patching_rect" : [ 108.0, 187.0, 150.0, 30.0 ],
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
					"data" : 					{
						"clips" : [ 							{
								"absolutepath" : "blading.mov",
								"filename" : "blading.mov",
								"filekind" : "moviefile",
								"id" : "u554011069",
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
					"id" : "obj-117",
					"loop" : 1,
					"maxclass" : "jit.playlist",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "jit_gl_texture", "", "dictionary" ],
					"output_texture" : 1,
					"parameter_enable" : 0,
					"patching_rect" : [ 271.0, 187.0, 150.0, 30.0 ],
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
					"id" : "obj-115",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 12.0, 210.0, 24.0, 24.0 ],
					"svg" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-113",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 12.0, 253.0, 80.0, 22.0 ],
					"text" : "concatdim $1"
				}

			}
, 			{
				"box" : 				{
					"fontface" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-86",
					"maxclass" : "jit.fpsgui",
					"mode" : 3,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 136.0, 369.0, 80.0, 35.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-73",
					"maxclass" : "jit.pwindow",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "jit_matrix", "" ],
					"patching_rect" : [ 108.0, 433.0, 702.0, 271.0 ],
					"sync" : 1
				}

			}
, 			{
				"box" : 				{
					"filename" : "jit.fx.concat.js",
					"id" : "obj-72",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 108.0, 322.0, 97.0, 22.0 ],
					"saved_object_attributes" : 					{
						"parameter_enable" : 0
					}
,
					"text" : "v8 jit.fx.concat.js",
					"textfile" : 					{
						"text" : "autowhatch = 1; inlets = 2; outlets = 1;\n\n\n//______ GRAB CONTEXT ______________________________________________________________________\n\nvar drawto = \"\";\ndeclareattribute(\"drawto\", null, \"dosetdrawto\", 0);\n\nvar implicitdrawto = \"\";\nvar swaplisten = null; // The listener for the jit.world\nvar explicitdrawto = false;\nvar proxy = null;\nvar swapListener = null;\n\nif(max.version >= 820) {\n    proxy = new JitterObject(\"jit.proxy\");\n}\n\nvar implicit_tracker = new JitterObject(\"jit_gl_implicit\"); // dummy oggetto gl\nvar implicit_lstnr = new JitterListener(implicit_tracker.name, implicit_callback);\n\nfunction implicit_callback(event) { \n\t// se non stai mettendo ctx a mano e se implicitdrawto != dal nome di implicit\n\tif(!explicitdrawto && implicitdrawto != implicit_tracker.drawto[0]) {\n\t\t// important! drawto is an array so get first element\n\t\timplicitdrawto = implicit_tracker.drawto[0];\n        //FF_Utils.Print(\"IMPLICIT CLL\", implicitdrawto);\n\t\tdosetdrawto(implicitdrawto);\n\t}\n}\nimplicit_callback.local = 1;\n\nfunction setDrawto(val) {\n\texplicitdrawto = true;\n\tdosetdrawto(val);\n};\n\nfunction dosetdrawto(newdrawto) {\n\tif(newdrawto == drawto || !newdrawto) {\n\t\t// bounce\n        //FF_Utils.Print(\"bouncer\");\n\t\treturn;\n\t}\n\tif(proxy !== undefined) {\n\t\tproxy.name = newdrawto;\n        // viene chiamato quando abbiamo classe\n        if(proxy.class !== undefined && proxy.class != \"\") {\n\t\t\t// drawto may be root render or sub-node\n\t\t\t// if root the class will return jit_gl_context_view\n\t\t\tif(proxy.class != \"jit_gl_context_view\") { // jit_gl_context_view = node dentro world\n\t\t\t\t// class is a sub-node, get the drawto on that\n\t\t\t\tproxydrawto = proxy.send(\"getdrawto\"); // prendi drawto di world che sarebbe nome del node\n\t\t\t\t// recurse until we get root\n\t\t\t\t// important! drawto is an array so get first element\n                //FF_Utils.Print(\"proxy class\", proxy.class);\n                //FF_Utils.Print(\"DIVERSo da contxt_view\", implicitdrawto);\n\n\t\t\t\treturn dosetdrawto(proxydrawto[0]);\n\t\t\t}\n\t\t}\n\t\telse {\n            // viene chiamato se non abbiamo classe\n\t\t\tproxydrawto = proxy.send(\"getdrawto\");\n\t\t\tif(proxydrawto !== null && proxydrawto !== undefined) {\n                //FF_Utils.Print(\"SE E NODE??\", proxydrawto[0]);\n\n\t\t\t\treturn dosetdrawto(proxydrawto[0]);  // name of the internal node\n\t\t\t}\n\t\t}\n\t}\n    //FF_Utils.Print(\"ASSEGNA drawto\", newdrawto);\n    drawto = newdrawto;\n    // chiama cose che vanno inizializzate quando c'è il drawto\n    // assegna listener per ctx\n    swapListener = new JitterListener(drawto, swapCallback);\n}\ndosetdrawto.local = 1;\n\nfunction destroyFindCTX() {\n\timplicit_lstnr.subjectname = \"\"\n\timplicit_tracker.freepeer();\n}\ndestroyFindCTX.local = 1;\n\nfunction notifydeleted() {\n    destroyFindCTX();\n    texA.freepeer();\n    texB.freepeer();\n    texDummy.freepeer();\n    slab.freepeer();\n}\n/*\n// ___ GRAB JIT.WORLD BANG____________________________________________\nvar swapCallback = function(event) {\n    switch (event.eventname) {\n        case (\"swap\" || \"draw\"):\n        \t//bang();\n            // FF_Utils.Print(\"BANG\")\n            break;\n        //case \"mouse\": case \"mouseidle\": \n        //    FF_Utils.Print(\"MOUSE\", event.args)\n        //    break;\n        case \"willfree\":\n            //FF_Utils.Print(\"DESTROY\")\n            break;\n        default: \n            break;\n    }\n}\n*/\n\nvar texA = new JitterObject(\"jit.gl.texture\", drawto);\nvar texB = new JitterObject(\"jit.gl.texture\", drawto);\nvar texDummy = new JitterObject(\"jit.gl.texture\", drawto);\n\nvar slab = new JitterObject(\"jit.gl.slab\", drawto);\nslab.file = \"jit.fx.concat.jxs\";\nslab.inputs = 3;\n\nvar _concatdim = 0;\n\nfunction concatdim(){\n\tif(arguments[0] != 0 && arguments[0] != 1) return;\n\t_concatdim = arguments[0];\n}\n\nfunction jit_gl_texture(inname){\n\n\tif(inlet == 1){\n\t\tslab.activeinput = 2;\n\t\ttexB.jit_gl_texture(inname);\n\t\tslab.jit_gl_texture(inname);\n\n\t} else {\n\t\tslab.activeinput = 1;\n\t\ttexA.jit_gl_texture(inname);\n\t\tslab.jit_gl_texture(inname);\n\n\t\ttexDummy.dim = _concatdim == 0 ? [texA.dim[0] + texB.dim[0], Math.max(texA.dim[1], texB.dim[1])] :\n\t\t\t\t\t\t\t\t\t\t [Math.max(texA.dim[0], texB.dim[0]), texA.dim[1] + texB.dim[1]];\n\n\t\tslab.param(\"concatdim\", _concatdim);\n\t\tslab.activeinput = 0;\n\t\tslab.jit_gl_texture(texDummy.name);\n\t\tslab.draw();\n\t}\n\toutlet(0, \"jit_gl_texture\", slab.out_name);\n}",
						"filename" : "jit.fx.concat.js",
						"flags" : 0,
						"embed" : 0,
						"autowatch" : 1
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
					"patching_rect" : [ 38.0, 24.0, 111.0, 22.0 ],
					"text" : "jit.world @enable 1"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-72", 0 ],
					"source" : [ "obj-113", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-113", 0 ],
					"source" : [ "obj-115", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-72", 1 ],
					"source" : [ "obj-117", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-72", 0 ],
					"source" : [ "obj-119", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-117", 0 ],
					"order" : 0,
					"source" : [ "obj-121", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-119", 0 ],
					"order" : 1,
					"source" : [ "obj-121", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-121", 0 ],
					"source" : [ "obj-122", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 0 ],
					"order" : 1,
					"source" : [ "obj-72", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"order" : 0,
					"source" : [ "obj-72", 0 ]
				}

			}
 ],
		"originid" : "pat-866",
		"dependency_cache" : [ 			{
				"name" : "bball.mov",
				"bootpath" : "C74:/media/jitter",
				"type" : "MooV",
				"implicit" : 1
			}
, 			{
				"name" : "blading.mov",
				"bootpath" : "C74:/media/jitter",
				"type" : "MooV",
				"implicit" : 1
			}
, 			{
				"name" : "jit.fx.concat.js",
				"bootpath" : "~/Documents/GitHub/jit.fx/jit.fx.concat",
				"patcherrelativepath" : ".",
				"type" : "TEXT",
				"implicit" : 1
			}
 ],
		"autosave" : 0
	}

}
