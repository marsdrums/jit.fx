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
		"rect" : [ 198.0, 203.0, 1210.0, 795.0 ],
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
					"patching_rect" : [ 572.0, 305.0, 106.0, 22.0 ],
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
					"patching_rect" : [ 508.0, 113.0, 24.0, 24.0 ]
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
					"patching_rect" : [ 508.0, 166.0, 100.0, 100.0 ],
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
						"text" : "<jittershader name=\"default\">\n\t<description>Default Slab </description>\n\t<param name=\"tex0\" type=\"int\" default=\"0\" />\n\t<param name=\"textureMatrix0\" type=\"mat4\" state=\"TEXTURE0_MATRIX\" />\n\t<param name=\"texcoord\" type=\"vec2\" state=\"TEXCOORD\" />\n\t<param name=\"frame\" type=\"int\" state=\"FRAME\" />\n\t<param name=\"texDim\" type=\"vec2\" state=\"TEXDIM0\" />\n\t<language name=\"glsl\" version=\"1.5\">\n\t\t<bind param=\"tex0\" program=\"fp\" />\n\t\t<bind param=\"textureMatrix0\" program=\"vp\" />\n\t\t<bind param=\"texcoord\" program=\"vp\" />\n\t\t<bind param=\"frame\" program=\"fp\" />\n\t\t<bind param=\"texDim\" program=\"fp\" />\n\t\t<program name=\"vp\" type=\"vertex\"  >\n<![CDATA[\n#version 330 core\n\nin vec2 texcoord;\nout jit_PerVertex {\n\tvec2 texcoord;\n} jit_out;\nuniform mat4 textureMatrix0;\n\nvoid main(void) {\n\tgl_Position = vec4(texcoord*2 - 1, 0., 1.);\n\tjit_out.texcoord = vec2(textureMatrix0*vec4(texcoord, 0., 1.));\n\n}\n]]>\n</program>\n\n<program name=\"fp\" type=\"fragment\"  >\n<![CDATA[\n#version 330 core\n\nin jit_PerVertex {\n\tvec2 texcoord;\n} jit_in;\nlayout (location = 0) out vec4 outColor;\n\nuniform samplerJit0 tex0;\nuniform int frame;\nuniform vec2 texDim;\n\n\nvoid main(void) {\n\n    int i = int(jit_in.texcoord.x);\n    int j = i + ((i&1)==(frame&1) ?-1:1); \n                \n    vec4 N = texelFetch(tex0,ivec2(j, jit_in.texcoord.y));\n         outColor= texelFetch(tex0,ivec2(i, jit_in.texcoord.y));\n    if(  (length(N.rgb)< length(outColor.rgb) )!=(i>j) && min(j,i)>=0 && max(j,i)<int(texDim.x) ) outColor=N;\n        \n\n}\n]]>\n</program>\n</language>\n</jittershader>\n",
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
					"patching_rect" : [ 405.0, 305.0, 116.0, 22.0 ],
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
		"originid" : "pat-440",
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
