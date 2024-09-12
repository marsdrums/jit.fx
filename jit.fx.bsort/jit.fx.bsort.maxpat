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
		"rect" : [ 59.0, 203.0, 1210.0, 795.0 ],
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
					"id" : "obj-16",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 543.0, 289.0, 106.0, 22.0 ],
					"text" : "prepend param off"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-15",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 4,
					"outlettype" : [ "int", "", "", "int" ],
					"patching_rect" : [ 572.0, 230.0, 69.0, 22.0 ],
					"text" : "counter 0 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"maxclass" : "jit.pwindow",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "jit_matrix", "" ],
					"patching_rect" : [ 727.0, 104.0, 673.0, 592.0 ],
					"sync" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-13",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 529.0, 111.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"autofit" : 1,
					"forceaspect" : 1,
					"id" : "obj-11",
					"maxclass" : "fpic",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "jit_matrix" ],
					"patching_rect" : [ 508.0, 166.0, 100.0, 35.526315789473685 ],
					"pic" : "usnm_93379-100k-2048-occlusion.jpg"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-9",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 409.0, 193.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"filename" : "jit.fx.bsort.jxs",
					"id" : "obj-7",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "jit_gl_texture", "" ],
					"patching_rect" : [ 365.0, 393.0, 216.0, 22.0 ],
					"text" : "jit.gl.slab @file jit.fx.bsort.jxs @inputs 1",
					"textfile" : 					{
						"text" : "<jittershader name=\"default\">\n\t<description>Default Slab </description>\n\t<param name=\"tex0\" type=\"int\" default=\"0\" />\n\t<param name=\"textureMatrix0\" type=\"mat4\" state=\"TEXTURE0_MATRIX\" />\n\t<param name=\"texcoord\" type=\"vec2\" state=\"TEXCOORD\" />\n\t<param name=\"off\" type=\"float\" default=\"0.0\" />\n\t<language name=\"glsl\" version=\"1.5\">\n\t\t<bind param=\"tex0\" program=\"fp\" />\n\t\t<bind param=\"textureMatrix0\" program=\"vp\" />\n\t\t<bind param=\"texcoord\" program=\"vp\" />\n\t\t<bind param=\"off\" program=\"fp\" />\n\t\t<program name=\"vp\" type=\"vertex\"  >\n<![CDATA[\n#version 330 core\n\nin vec2 texcoord;\nout jit_PerVertex {\n\tvec2 texcoord;\n} jit_out;\nuniform mat4 textureMatrix0;\n\nvoid main(void) {\n\tgl_Position = vec4(texcoord*2 - 1, 0., 1.);\n\tjit_out.texcoord = vec2(textureMatrix0*vec4(texcoord, 0., 1.));\n\n}\n]]>\n</program>\n\n<program name=\"fp\" type=\"fragment\"  >\n<![CDATA[\n#version 330 core\n\nin jit_PerVertex {\n\tvec2 texcoord;\n} jit_in;\nlayout (location = 0) out vec4 outColor;\n\nuniform samplerJit0 tex0;\nuniform float off;\n\n\nvec4 sample_neighbor(){\n\n\treturn \tfloor(mod(jit_in.texcoord.x, 2) + off) == 0 ? \t\n\t\t\ttexelFetch(tex0, ivec2(jit_in.texcoord + vec2(1,0))) : \n\t\t\ttexelFetch(tex0, ivec2(jit_in.texcoord - vec2(1,0)));\n}\n\nvoid main(void) {\n\n\tvec4 this_sample = texelFetch(tex0, ivec2(jit_in.texcoord));\n\tvec4 nei_sample = sample_neighbor();\n\n\tif(floor(mod(jit_in.texcoord.x, 2) + 1) == 0){\n\t\toutColor = \t(this_sample.r + this_sample.g + this_sample.b) >= (nei_sample.r + nei_sample.g + nei_sample.b) ?\n\t\t\t\t\tthis_sample : nei_sample;\t\n\t} else {\n\t\toutColor = \t(this_sample.r + this_sample.g + this_sample.b) <= (nei_sample.r + nei_sample.g + nei_sample.b) ?\n\t\t\t\t\tthis_sample : nei_sample;\n\t}\n\n}\n]]>\n</program>\n</language>\n</jittershader>\n",
						"filename" : "jit.fx.bsort.jxs",
						"flags" : 0,
						"embed" : 0,
						"autowatch" : 1
					}

				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 290.0, 126.0, 24.0, 24.0 ],
					"svg" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-4",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "jit_matrix", "bang", "" ],
					"patching_rect" : [ 290.0, 180.0, 49.0, 22.0 ],
					"text" : "jit.world"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-3",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "jit_gl_texture", "" ],
					"patching_rect" : [ 325.0, 287.0, 116.0, 22.0 ],
					"text" : "jit.gl.texture @thru 0"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-11", 0 ],
					"source" : [ "obj-13", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-16", 0 ],
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-7", 0 ],
					"source" : [ "obj-16", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-7", 0 ],
					"source" : [ "obj-3", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-9", 0 ],
					"source" : [ "obj-4", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-4", 0 ],
					"source" : [ "obj-6", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"order" : 0,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"order" : 1,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-4", 0 ],
					"order" : 2,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-15", 0 ],
					"order" : 0,
					"source" : [ "obj-9", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"order" : 1,
					"source" : [ "obj-9", 0 ]
				}

			}
 ],
		"originid" : "pat-152",
		"dependency_cache" : [ 			{
				"name" : "usnm_93379-100k-2048-occlusion.jpg",
				"bootpath" : "C74:/media/jitter/models/smithsonian-gltf/pocillopora-damicornis",
				"type" : "JPEG",
				"implicit" : 1
			}
 ],
		"autosave" : 0
	}

}
