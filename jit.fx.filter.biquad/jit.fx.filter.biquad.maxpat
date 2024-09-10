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
		"rect" : [ 461.0, 116.0, 857.0, 881.0 ],
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
					"id" : "obj-19",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 238.0, 126.0, 212.0, 20.0 ],
					"text" : "1) set cutoff, Q, and filter type"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-18",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 464.0, 70.0, 255.0, 20.0 ],
					"text" : "2) or you can send the filter coeficients directly"
				}

			}
, 			{
				"box" : 				{
					"attr" : "edit_mode",
					"id" : "obj-16",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 464.0, 100.0, 214.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 464.0, 332.0, 116.0, 22.0 ],
					"text" : "prepend coefficients"
				}

			}
, 			{
				"box" : 				{
					"autoout" : 1,
					"domain" : [ 0.0, 22050.0 ],
					"fontface" : 0,
					"fontsize" : 8.998901,
					"id" : "obj-81",
					"linmarkers" : [ 0.0, 11025.0, 16537.5 ],
					"logmarkers" : [ 0.0, 100.0, 1000.0, 10000.0 ],
					"maxclass" : "filtergraph~",
					"nfilters" : 1,
					"numinlets" : 8,
					"numoutlets" : 7,
					"outlettype" : [ "list", "float", "float", "float", "float", "list", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 464.0, 155.0, 305.0, 132.0 ],
					"setfilter" : [ 0, 1, 0, 0, 0, 1275.989501953125, 1.0, 0.5, 0.000099999997474, 22050.0, 0.000099999997474, 16.0, 0.5, 25.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-13",
					"items" : [ "lowpass", ",", "highpass", ",", "bandpass", ",", "bandstop" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 339.0, 202.0, 100.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 82.0, 210.0, 70.0, 22.0 ],
					"text" : "loadmess 2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-11",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 232.0, 164.0, 80.0, 22.0 ],
					"text" : "loadmess 0.2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 339.0, 164.0, 70.0, 22.0 ],
					"text" : "loadmess 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-4",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 339.0, 238.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-2",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 339.0, 281.0, 101.0, 22.0 ],
					"text" : "prepend filtertype"
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-36",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 82.0, 245.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-30",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 232.0, 238.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-24",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 82.0, 281.0, 85.0, 22.0 ],
					"text" : "prepend cutoff"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-15",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 232.0, 281.0, 63.0, 22.0 ],
					"text" : "prepend q"
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
					"patching_rect" : [ 82.0, 399.0, 80.0, 35.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-73",
					"maxclass" : "jit.pwindow",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "jit_matrix", "" ],
					"patching_rect" : [ 40.0, 456.0, 383.0, 261.0 ],
					"sync" : 1
				}

			}
, 			{
				"box" : 				{
					"filename" : "jit.fx.filter.biquad.js",
					"id" : "obj-72",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 40.0, 343.0, 123.0, 22.0 ],
					"saved_object_attributes" : 					{
						"parameter_enable" : 0
					}
,
					"text" : "v8 jit.fx.filter.biquad.js",
					"textfile" : 					{
						"text" : "autowhatch = 1; inlets = 1; outlets = 1;\n\n\n//______ GRAB CONTEXT ______________________________________________________________________\n\nvar drawto = \"\";\ndeclareattribute(\"drawto\", null, \"dosetdrawto\", 0);\n\nvar implicitdrawto = \"\";\nvar swaplisten = null; // The listener for the jit.world\nvar explicitdrawto = false;\nvar proxy = null;\nvar swapListener = null;\n\nif(max.version >= 820) {\n    proxy = new JitterObject(\"jit.proxy\");\n}\n\nvar implicit_tracker = new JitterObject(\"jit_gl_implicit\"); // dummy oggetto gl\nvar implicit_lstnr = new JitterListener(implicit_tracker.name, implicit_callback);\n\nfunction implicit_callback(event) { \n\t// se non stai mettendo ctx a mano e se implicitdrawto != dal nome di implicit\n\tif(!explicitdrawto && implicitdrawto != implicit_tracker.drawto[0]) {\n\t\t// important! drawto is an array so get first element\n\t\timplicitdrawto = implicit_tracker.drawto[0];\n        //FF_Utils.Print(\"IMPLICIT CLL\", implicitdrawto);\n\t\tdosetdrawto(implicitdrawto);\n\t}\n}\nimplicit_callback.local = 1;\n\nfunction setDrawto(val) {\n\texplicitdrawto = true;\n\tdosetdrawto(val);\n};\n\nfunction dosetdrawto(newdrawto) {\n\tif(newdrawto == drawto || !newdrawto) {\n\t\t// bounce\n        //FF_Utils.Print(\"bouncer\");\n\t\treturn;\n\t}\n\tif(proxy !== undefined) {\n\t\tproxy.name = newdrawto;\n        // viene chiamato quando abbiamo classe\n        if(proxy.class !== undefined && proxy.class != \"\") {\n\t\t\t// drawto may be root render or sub-node\n\t\t\t// if root the class will return jit_gl_context_view\n\t\t\tif(proxy.class != \"jit_gl_context_view\") { // jit_gl_context_view = node dentro world\n\t\t\t\t// class is a sub-node, get the drawto on that\n\t\t\t\tproxydrawto = proxy.send(\"getdrawto\"); // prendi drawto di world che sarebbe nome del node\n\t\t\t\t// recurse until we get root\n\t\t\t\t// important! drawto is an array so get first element\n                //FF_Utils.Print(\"proxy class\", proxy.class);\n                //FF_Utils.Print(\"DIVERSo da contxt_view\", implicitdrawto);\n\n\t\t\t\treturn dosetdrawto(proxydrawto[0]);\n\t\t\t}\n\t\t}\n\t\telse {\n            // viene chiamato se non abbiamo classe\n\t\t\tproxydrawto = proxy.send(\"getdrawto\");\n\t\t\tif(proxydrawto !== null && proxydrawto !== undefined) {\n                //FF_Utils.Print(\"SE E NODE??\", proxydrawto[0]);\n\n\t\t\t\treturn dosetdrawto(proxydrawto[0]);  // name of the internal node\n\t\t\t}\n\t\t}\n\t}\n    //FF_Utils.Print(\"ASSEGNA drawto\", newdrawto);\n    drawto = newdrawto;\n    // chiama cose che vanno inizializzate quando c'è il drawto\n    // assegna listener per ctx\n    swapListener = new JitterListener(drawto, swapCallback);\n}\ndosetdrawto.local = 1;\n\nfunction destroyFindCTX() {\n\timplicit_lstnr.subjectname = \"\"\n\timplicit_tracker.freepeer();\n}\ndestroyFindCTX.local = 1;\n\nfunction notifydeleted() {\n    destroyFindCTX();\n    slab.freepeer();\n    texIn1.freepeer();\n    texIn2.freepeer();\n    texIn3.freepeer();\n    texIn4.freepeer();\n}\n/*\n// ___ GRAB JIT.WORLD BANG____________________________________________\nvar swapCallback = function(event) {\n    switch (event.eventname) {\n        case (\"swap\" || \"draw\"):\n        \t//bang();\n            // FF_Utils.Print(\"BANG\")\n            break;\n        //case \"mouse\": case \"mouseidle\": \n        //    FF_Utils.Print(\"MOUSE\", event.args)\n        //    break;\n        case \"willfree\":\n            //FF_Utils.Print(\"DESTROY\")\n            break;\n        default: \n            break;\n    }\n}\n*/\n\nvar texIn1 = new JitterObject(\"jit.gl.texture\", drawto); texIn1.defaultimage = \"black\";\nvar texIn2 = new JitterObject(\"jit.gl.texture\", drawto); texIn2.defaultimage = \"black\";\nvar texIn3 = new JitterObject(\"jit.gl.texture\", drawto); texIn3.defaultimage = \"black\";\nvar texIn4 = new JitterObject(\"jit.gl.texture\", drawto); texIn4.defaultimage = \"black\";\n\nvar slab = new JitterObject(\"jit.gl.slab\", drawto);\nslab.file = \"jit.fx.filter.biquad.jxs\";\nslab.inputs = 5;\nslab.outputs = 4;\n\nvar a0, a1, a2, b1, b2;\n\nvar _cutoff = 2.0;\nvar _q = 0.2;\nvar _filtertype = 0;\nvar samplerate = 30;\nlowpass();\n\nfunction coefficients(){\n\n\tslab.param(\"a0\", arguments[0]);\n\tslab.param(\"a1\", arguments[1]);\n\tslab.param(\"a2\", arguments[2]);\n\tslab.param(\"b1\", arguments[3]);\n\tslab.param(\"b2\", arguments[4]);\n}\n\nfunction lowpass(){\n\n\tvar omega = _cutoff * Math.PI*2 / samplerate;\n\tvar sn = Math.sin(omega);\n\tvar cs = Math.cos(omega);\n\tvar igain = 1.0;///gain; \n\tvar one_over_Q = 1./_q;\n\tvar alpha = sn * 0.5 * one_over_Q;\n\n\tb0 = 1./(1. + alpha);\n\ta2 = ((1 - cs) * 0.5) * b0;\n\ta0 = a2;\n\ta1 = (1. - cs) * b0;\n\tb1 = (-2. * cs) * b0;\n\tb2 = (1. - alpha) * b0;\n\n\tslab.param(\"a0\", a0);\n\tslab.param(\"a1\", a1);\n\tslab.param(\"a2\", a2);\n\tslab.param(\"b1\", b1);\n\tslab.param(\"b2\", b2);\n}\n\nfunction hipass(){\n\n\tvar omega = _cutoff * Math.PI*2 / samplerate;\n\tvar sn = Math.sin(omega);\n\tvar cs = Math.cos(omega);\n\tvar alpha = sn * 0.5/_q;\n\t\n\tb0 = 1./(1. + alpha);\n\ta2 = ((1. + cs) * 0.5) * b0;\n\ta0 = a2;\n\ta1 = -(1. + cs) * b0;\n\tb1 = (-2. * cs) * b0;\n\tb2 = (1. - alpha) * b0;\n\n\tslab.param(\"a0\", a0);\n\tslab.param(\"a1\", a1);\n\tslab.param(\"a2\", a2);\n\tslab.param(\"b1\", b1);\n\tslab.param(\"b2\", b2);\n}\n\nfunction bandpass(){\n\n\tvar omega = _cutoff * Math.PI*2 / samplerate;\n\tvar sn = Math.sin(omega);\n\tvar cs = Math.cos(omega);\n\tvar alpha = sn * 0.5/_q;\n\n\tb0 = 1./(1. + alpha);\n\ta0 = alpha * b0;\n\ta1 = 0.;\n\ta2 = -alpha * b0;\n\tb1 = -2. * cs * b0;\n\tb2 = (1. - alpha) * b0;\n\n\tslab.param(\"a0\", a0);\n\tslab.param(\"a1\", a1);\n\tslab.param(\"a2\", a2);\n\tslab.param(\"b1\", b1);\n\tslab.param(\"b2\", b2);\n}\n\nfunction bandstop(){\n\n\tvar omega = _cutoff * Math.PI*2 / samplerate;\n\tvar sn = Math.sin(omega);\n\tvar cs = Math.cos(omega);\n\tvar alpha = sn * 0.5/_q;\n\n\tb0 = 1./(1. + alpha);\t\t\t\n\tb1 = (-2. * cs) * b0;\n\ta1 = b1;\n\tb2 = (1. - alpha) * b0;\n\ta0 = b0;\n\ta2 = b0;\n\n\tslab.param(\"a0\", a0);\n\tslab.param(\"a1\", a1);\n\tslab.param(\"a2\", a2);\n\tslab.param(\"b1\", b1);\n\tslab.param(\"b2\", b2);\n}\n\nfunction cutoff(){\n\t_cutoff = arguments[0];\n\tupdate_coefficients();\n}\n\nfunction q(){\n\t_q = Math.max(0.02, arguments[0]);\n\tupdate_coefficients();\n}\n\nfunction filtertype(){\n\t_filtertype = arguments[0];\n\tupdate_coefficients();\n}\n\nfunction update_coefficients(){\n\tswitch(_filtertype) {\n\t  case 0:\n\t    lowpass();\n\t    break;\n\t  case 1:\n\t    hipass();\n\t    break;\n\t  case 2:\n\t  \tbandpass();\n\t  \tbreak;\n\t  case 3:\n\t  \tbandstop();\n\t  \tbreak;\n\t  default:\n\t    return;\n\t}\n}\n\nfunction jit_gl_texture(inname){\n\n\tslab.activeinput = 4;\tslab.jit_gl_texture(texIn4.name);\n\tslab.activeinput = 3;\tslab.jit_gl_texture(texIn3.name);\n\tslab.activeinput = 2;\tslab.jit_gl_texture(texIn2.name);\n\tslab.activeinput = 1;\tslab.jit_gl_texture(texIn1.name);\n\tslab.activeinput = 0;\tslab.jit_gl_texture(inname);\n\n\tslab.draw();\n\n\ttexIn1.jit_gl_texture(slab.out_name[0]);\n\ttexIn2.jit_gl_texture(slab.out_name[1]);\n\ttexIn3.jit_gl_texture(slab.out_name[2]);\n\ttexIn4.jit_gl_texture(slab.out_name[3]);\n\n\toutlet(0, \"jit_gl_texture\", slab.out_name[2]);\n}",
						"filename" : "jit.fx.filter.biquad.js",
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
					"patching_rect" : [ 40.0, 75.0, 58.0, 22.0 ],
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
					"patching_rect" : [ 40.0, 119.0, 183.0, 22.0 ],
					"text" : "output_texture 1, loop 1, vol 0., 1"
				}

			}
, 			{
				"box" : 				{
					"data" : 					{
						"clips" : [ 							{
								"absolutepath" : "Tennis-ball.mp4",
								"filename" : "Tennis-ball.mp4",
								"filekind" : "moviefile",
								"id" : "u703007368",
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
					"patching_rect" : [ 40.0, 164.0, 150.0, 30.0 ],
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
					"patching_rect" : [ 40.0, 37.0, 111.0, 22.0 ],
					"text" : "jit.world @enable 1"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-9", 0 ],
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-30", 0 ],
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-36", 0 ],
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-4", 0 ],
					"source" : [ "obj-13", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-72", 0 ],
					"source" : [ "obj-14", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-72", 0 ],
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-81", 0 ],
					"source" : [ "obj-16", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-72", 0 ],
					"source" : [ "obj-2", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-72", 0 ],
					"source" : [ "obj-24", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-15", 0 ],
					"source" : [ "obj-30", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"source" : [ "obj-36", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-2", 0 ],
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-13", 0 ],
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
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"source" : [ "obj-81", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-7", 0 ],
					"source" : [ "obj-9", 0 ]
				}

			}
 ],
		"originid" : "pat-15",
		"dependency_cache" : [ 			{
				"name" : "Tennis-ball.mp4",
				"bootpath" : "~/Documents/Max 9/Packages/cv.jit/media",
				"patcherrelativepath" : "../../../Max 9/Packages/cv.jit/media",
				"type" : "mpg4",
				"implicit" : 1
			}
, 			{
				"name" : "jit.fx.filter.biquad.js",
				"bootpath" : "~/Documents/GitHub/jit.fx/jit.fx.filter.biquad",
				"patcherrelativepath" : ".",
				"type" : "TEXT",
				"implicit" : 1
			}
 ],
		"autosave" : 0
	}

}
