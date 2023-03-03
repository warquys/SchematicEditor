Shader "Custom/MaskedUIBlur" {
	Properties {
		_Size ("Blur", Range(0, 30)) = 1
		[HideInInspector] _MainTex ("Masking Texture", 2D) = "white" {}
		_AdditiveColor ("Additive Tint color", Vector) = (0,0,0,0)
		_MultiplyColor ("Multiply Tint color", Vector) = (1,1,1,1)
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
		GrabPass {
			"_HBlur"
		}
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 35468
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 unused_0_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!GL3x
					#ifdef VERTEX
					#version 150
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_shader_bit_encoding
					#extension GL_ARB_shader_bit_encoding : enable
					#endif
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 150
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_shader_bit_encoding
					#extension GL_ARB_shader_bit_encoding : enable
					#endif
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _HBlur_TexelSize;
					uniform 	float _Size;
					uniform 	vec4 _AdditiveColor;
					uniform 	vec4 _MultiplyColor;
					UNITY_LOCATION(0) uniform  sampler2D _HBlur;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat6;
					void main()
					{
					    u_xlat0.yw = vs_TEXCOORD0.yy;
					    u_xlat1.x = _HBlur_TexelSize.x * _Size;
					    u_xlat2 = u_xlat1.xxxx * vec4(3.0, -4.0, -3.0, -2.0) + vs_TEXCOORD0.xxxx;
					    u_xlat0.xz = u_xlat2.yz;
					    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
					    u_xlat3 = texture(_HBlur, u_xlat0.zw);
					    u_xlat0 = texture(_HBlur, u_xlat0.xy);
					    u_xlat6.xyz = u_xlat3.xyz * vec3(0.0900000036, 0.0900000036, 0.0900000036);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.0500000007, 0.0500000007, 0.0500000007) + u_xlat6.xyz;
					    u_xlat3.x = u_xlat2.w;
					    u_xlat3.yw = vs_TEXCOORD0.yy;
					    u_xlat6.xy = u_xlat3.xy / vs_TEXCOORD0.ww;
					    u_xlat4 = texture(_HBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.119999997, 0.119999997, 0.119999997) + u_xlat0.xyz;
					    u_xlat3.z = (-_HBlur_TexelSize.x) * _Size + vs_TEXCOORD0.x;
					    u_xlat6.xy = u_xlat3.zw / vs_TEXCOORD0.ww;
					    u_xlat3 = texture(_HBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.150000006, 0.150000006, 0.150000006) + u_xlat0.xyz;
					    u_xlat6.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
					    u_xlat3 = texture(_HBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.180000007, 0.180000007, 0.180000007) + u_xlat0.xyz;
					    u_xlat3.x = _HBlur_TexelSize.x * _Size + vs_TEXCOORD0.x;
					    u_xlat3.yw = vs_TEXCOORD0.yy;
					    u_xlat6.xy = u_xlat3.xy / vs_TEXCOORD0.ww;
					    u_xlat4 = texture(_HBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.150000006, 0.150000006, 0.150000006) + u_xlat0.xyz;
					    u_xlat3.z = u_xlat1.x * 2.0 + vs_TEXCOORD0.x;
					    u_xlat2.z = u_xlat1.x * 4.0 + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.zw / vs_TEXCOORD0.ww;
					    u_xlat1 = texture(_HBlur, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.119999997, 0.119999997, 0.119999997) + u_xlat0.xyz;
					    u_xlat2.yw = vs_TEXCOORD0.yy;
					    u_xlat1 = u_xlat2 / vs_TEXCOORD0.wwww;
					    u_xlat2 = texture(_HBlur, u_xlat1.zw);
					    u_xlat1 = texture(_HBlur, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * _MultiplyColor.xyz + _AdditiveColor.xyz;
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.w = u_xlat0.w;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 126
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %11 %79 %95 %108 %110 
					                                                     OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                     OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                     OpDecorate %11 Location 11 
					                                                     OpDecorate %16 ArrayStride 16 
					                                                     OpDecorate %17 ArrayStride 17 
					                                                     OpMemberDecorate %18 0 Offset 18 
					                                                     OpMemberDecorate %18 1 Offset 18 
					                                                     OpMemberDecorate %18 2 Offset 18 
					                                                     OpDecorate %18 Block 
					                                                     OpDecorate %20 DescriptorSet 20 
					                                                     OpDecorate %20 Binding 20 
					                                                     OpMemberDecorate %77 0 BuiltIn 77 
					                                                     OpMemberDecorate %77 1 BuiltIn 77 
					                                                     OpMemberDecorate %77 2 BuiltIn 77 
					                                                     OpDecorate %77 Block 
					                                                     OpDecorate vs_TEXCOORD0 Location 95 
					                                                     OpDecorate vs_TEXCOORD1 Location 108 
					                                                     OpDecorate %110 Location 110 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 4 
					                                              %8 = OpTypePointer Private %7 
					                               Private f32_4* %9 = OpVariable Private 
					                                             %10 = OpTypePointer Input %7 
					                                Input f32_4* %11 = OpVariable Input 
					                                             %14 = OpTypeInt 32 0 
					                                         u32 %15 = OpConstant 4 
					                                             %16 = OpTypeArray %7 %15 
					                                             %17 = OpTypeArray %7 %15 
					                                             %18 = OpTypeStruct %16 %17 %7 
					                                             %19 = OpTypePointer Uniform %18 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %20 = OpVariable Uniform 
					                                             %21 = OpTypeInt 32 1 
					                                         i32 %22 = OpConstant 0 
					                                         i32 %23 = OpConstant 1 
					                                             %24 = OpTypePointer Uniform %7 
					                                         i32 %35 = OpConstant 2 
					                                         i32 %44 = OpConstant 3 
					                              Private f32_4* %48 = OpVariable Private 
					                                         u32 %75 = OpConstant 1 
					                                             %76 = OpTypeArray %6 %75 
					                                             %77 = OpTypeStruct %7 %6 %76 
					                                             %78 = OpTypePointer Output %77 
					        Output struct {f32_4; f32; f32[1];}* %79 = OpVariable Output 
					                                             %81 = OpTypePointer Output %7 
					                                             %83 = OpTypeVector %6 2 
					                                         f32 %86 = OpConstant 3,674022E-40 
					                                         f32 %87 = OpConstant 3,674022E-40 
					                                       f32_2 %88 = OpConstantComposite %86 %87 
					                      Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                                        f32 %102 = OpConstant 3,674022E-40 
					                                      f32_2 %103 = OpConstantComposite %102 %102 
					                                            %107 = OpTypePointer Output %83 
					                      Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                            %109 = OpTypePointer Input %83 
					                               Input f32_2* %110 = OpVariable Input 
					                                            %120 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                                       f32_4 %12 = OpLoad %11 
					                                       f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
					                              Uniform f32_4* %25 = OpAccessChain %20 %22 %23 
					                                       f32_4 %26 = OpLoad %25 
					                                       f32_4 %27 = OpFMul %13 %26 
					                                                     OpStore %9 %27 
					                              Uniform f32_4* %28 = OpAccessChain %20 %22 %22 
					                                       f32_4 %29 = OpLoad %28 
					                                       f32_4 %30 = OpLoad %11 
					                                       f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
					                                       f32_4 %32 = OpFMul %29 %31 
					                                       f32_4 %33 = OpLoad %9 
					                                       f32_4 %34 = OpFAdd %32 %33 
					                                                     OpStore %9 %34 
					                              Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
					                                       f32_4 %37 = OpLoad %36 
					                                       f32_4 %38 = OpLoad %11 
					                                       f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
					                                       f32_4 %40 = OpFMul %37 %39 
					                                       f32_4 %41 = OpLoad %9 
					                                       f32_4 %42 = OpFAdd %40 %41 
					                                                     OpStore %9 %42 
					                                       f32_4 %43 = OpLoad %9 
					                              Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
					                                       f32_4 %46 = OpLoad %45 
					                                       f32_4 %47 = OpFAdd %43 %46 
					                                                     OpStore %9 %47 
					                                       f32_4 %49 = OpLoad %9 
					                                       f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
					                              Uniform f32_4* %51 = OpAccessChain %20 %23 %23 
					                                       f32_4 %52 = OpLoad %51 
					                                       f32_4 %53 = OpFMul %50 %52 
					                                                     OpStore %48 %53 
					                              Uniform f32_4* %54 = OpAccessChain %20 %23 %22 
					                                       f32_4 %55 = OpLoad %54 
					                                       f32_4 %56 = OpLoad %9 
					                                       f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
					                                       f32_4 %58 = OpFMul %55 %57 
					                                       f32_4 %59 = OpLoad %48 
					                                       f32_4 %60 = OpFAdd %58 %59 
					                                                     OpStore %48 %60 
					                              Uniform f32_4* %61 = OpAccessChain %20 %23 %35 
					                                       f32_4 %62 = OpLoad %61 
					                                       f32_4 %63 = OpLoad %9 
					                                       f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
					                                       f32_4 %65 = OpFMul %62 %64 
					                                       f32_4 %66 = OpLoad %48 
					                                       f32_4 %67 = OpFAdd %65 %66 
					                                                     OpStore %48 %67 
					                              Uniform f32_4* %68 = OpAccessChain %20 %23 %44 
					                                       f32_4 %69 = OpLoad %68 
					                                       f32_4 %70 = OpLoad %9 
					                                       f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
					                                       f32_4 %72 = OpFMul %69 %71 
					                                       f32_4 %73 = OpLoad %48 
					                                       f32_4 %74 = OpFAdd %72 %73 
					                                                     OpStore %9 %74 
					                                       f32_4 %80 = OpLoad %9 
					                               Output f32_4* %82 = OpAccessChain %79 %22 
					                                                     OpStore %82 %80 
					                                       f32_4 %84 = OpLoad %9 
					                                       f32_2 %85 = OpVectorShuffle %84 %84 0 1 
					                                       f32_2 %89 = OpFMul %85 %88 
					                                       f32_4 %90 = OpLoad %9 
					                                       f32_2 %91 = OpVectorShuffle %90 %90 3 3 
					                                       f32_2 %92 = OpFAdd %89 %91 
					                                       f32_4 %93 = OpLoad %9 
					                                       f32_4 %94 = OpVectorShuffle %93 %92 4 5 2 3 
					                                                     OpStore %9 %94 
					                                       f32_4 %96 = OpLoad %9 
					                                       f32_2 %97 = OpVectorShuffle %96 %96 2 3 
					                                       f32_4 %98 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %99 = OpVectorShuffle %98 %97 0 1 4 5 
					                                                     OpStore vs_TEXCOORD0 %99 
					                                      f32_4 %100 = OpLoad %9 
					                                      f32_2 %101 = OpVectorShuffle %100 %100 0 1 
					                                      f32_2 %104 = OpFMul %101 %103 
					                                      f32_4 %105 = OpLoad vs_TEXCOORD0 
					                                      f32_4 %106 = OpVectorShuffle %105 %104 4 5 2 3 
					                                                     OpStore vs_TEXCOORD0 %106 
					                                      f32_2 %111 = OpLoad %110 
					                             Uniform f32_4* %112 = OpAccessChain %20 %35 
					                                      f32_4 %113 = OpLoad %112 
					                                      f32_2 %114 = OpVectorShuffle %113 %113 0 1 
					                                      f32_2 %115 = OpFMul %111 %114 
					                             Uniform f32_4* %116 = OpAccessChain %20 %35 
					                                      f32_4 %117 = OpLoad %116 
					                                      f32_2 %118 = OpVectorShuffle %117 %117 2 3 
					                                      f32_2 %119 = OpFAdd %115 %118 
					                                                     OpStore vs_TEXCOORD1 %119 
					                                Output f32* %121 = OpAccessChain %79 %22 %75 
					                                        f32 %122 = OpLoad %121 
					                                        f32 %123 = OpFNegate %122 
					                                Output f32* %124 = OpAccessChain %79 %22 %75 
					                                                     OpStore %124 %123 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 332
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %11 %300 %322 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                    OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                    OpDecorate vs_TEXCOORD0 Location 11 
					                                                    OpMemberDecorate %18 0 Offset 18 
					                                                    OpMemberDecorate %18 1 Offset 18 
					                                                    OpMemberDecorate %18 2 Offset 18 
					                                                    OpMemberDecorate %18 3 Offset 18 
					                                                    OpDecorate %18 Block 
					                                                    OpDecorate %20 DescriptorSet 20 
					                                                    OpDecorate %20 Binding 20 
					                                                    OpDecorate %59 DescriptorSet 59 
					                                                    OpDecorate %59 Binding 59 
					                                                    OpDecorate %63 DescriptorSet 63 
					                                                    OpDecorate %63 Binding 63 
					                                                    OpDecorate %300 Location 300 
					                                                    OpDecorate %316 DescriptorSet 316 
					                                                    OpDecorate %316 Binding 316 
					                                                    OpDecorate %318 DescriptorSet 318 
					                                                    OpDecorate %318 Binding 318 
					                                                    OpDecorate vs_TEXCOORD1 Location 322 
					                                             %2 = OpTypeVoid 
					                                             %3 = OpTypeFunction %2 
					                                             %6 = OpTypeFloat 32 
					                                             %7 = OpTypeVector %6 4 
					                                             %8 = OpTypePointer Private %7 
					                              Private f32_4* %9 = OpVariable Private 
					                                            %10 = OpTypePointer Input %7 
					                      Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                            %12 = OpTypeVector %6 2 
					                             Private f32_4* %17 = OpVariable Private 
					                                            %18 = OpTypeStruct %7 %6 %7 %7 
					                                            %19 = OpTypePointer Uniform %18 
					Uniform struct {f32_4; f32; f32_4; f32_4;}* %20 = OpVariable Uniform 
					                                            %21 = OpTypeInt 32 1 
					                                        i32 %22 = OpConstant 0 
					                                            %23 = OpTypeInt 32 0 
					                                        u32 %24 = OpConstant 0 
					                                            %25 = OpTypePointer Uniform %6 
					                                        i32 %28 = OpConstant 1 
					                                            %32 = OpTypePointer Private %6 
					                             Private f32_4* %34 = OpVariable Private 
					                                        f32 %37 = OpConstant 3,674022E-40 
					                                        f32 %38 = OpConstant 3,674022E-40 
					                                        f32 %39 = OpConstant 3,674022E-40 
					                                        f32 %40 = OpConstant 3,674022E-40 
					                                      f32_4 %41 = OpConstantComposite %37 %38 %39 %40 
					                                            %54 = OpTypeVector %6 3 
					                                            %55 = OpTypePointer Private %54 
					                             Private f32_3* %56 = OpVariable Private 
					                                            %57 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                            %58 = OpTypePointer UniformConstant %57 
					       UniformConstant read_only Texture2D* %59 = OpVariable UniformConstant 
					                                            %61 = OpTypeSampler 
					                                            %62 = OpTypePointer UniformConstant %61 
					                   UniformConstant sampler* %63 = OpVariable UniformConstant 
					                                            %65 = OpTypeSampledImage %57 
					                                        f32 %81 = OpConstant 3,674022E-40 
					                                      f32_3 %82 = OpConstantComposite %81 %81 %81 
					                                        f32 %86 = OpConstant 3,674022E-40 
					                                      f32_3 %87 = OpConstantComposite %86 %86 %86 
					                             Private f32_4* %93 = OpVariable Private 
					                                        u32 %94 = OpConstant 3 
					                                       f32 %117 = OpConstant 3,674022E-40 
					                                     f32_3 %118 = OpConstantComposite %117 %117 %117 
					                                           %131 = OpTypePointer Input %6 
					                                       u32 %135 = OpConstant 2 
					                                       f32 %152 = OpConstant 3,674022E-40 
					                                     f32_3 %153 = OpConstantComposite %152 %152 %152 
					                                       f32 %175 = OpConstant 3,674022E-40 
					                                     f32_3 %176 = OpConstantComposite %175 %175 %175 
					                                       f32 %219 = OpConstant 3,674022E-40 
					                                       f32 %227 = OpConstant 3,674022E-40 
					                                           %299 = OpTypePointer Output %7 
					                             Output f32_4* %300 = OpVariable Output 
					                                       i32 %303 = OpConstant 3 
					                                           %304 = OpTypePointer Uniform %7 
					                                       i32 %309 = OpConstant 2 
					      UniformConstant read_only Texture2D* %316 = OpVariable UniformConstant 
					                  UniformConstant sampler* %318 = OpVariable UniformConstant 
					                                           %321 = OpTypePointer Input %12 
					                      Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                           %329 = OpTypePointer Output %6 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                                      f32_4 %13 = OpLoad vs_TEXCOORD0 
					                                      f32_2 %14 = OpVectorShuffle %13 %13 1 1 
					                                      f32_4 %15 = OpLoad %9 
					                                      f32_4 %16 = OpVectorShuffle %15 %14 0 4 2 5 
					                                                    OpStore %9 %16 
					                               Uniform f32* %26 = OpAccessChain %20 %22 %24 
					                                        f32 %27 = OpLoad %26 
					                               Uniform f32* %29 = OpAccessChain %20 %28 
					                                        f32 %30 = OpLoad %29 
					                                        f32 %31 = OpFMul %27 %30 
					                               Private f32* %33 = OpAccessChain %17 %24 
					                                                    OpStore %33 %31 
					                                      f32_4 %35 = OpLoad %17 
					                                      f32_4 %36 = OpVectorShuffle %35 %35 0 0 0 0 
					                                      f32_4 %42 = OpFMul %36 %41 
					                                      f32_4 %43 = OpLoad vs_TEXCOORD0 
					                                      f32_4 %44 = OpVectorShuffle %43 %43 0 0 0 0 
					                                      f32_4 %45 = OpFAdd %42 %44 
					                                                    OpStore %34 %45 
					                                      f32_4 %46 = OpLoad %34 
					                                      f32_2 %47 = OpVectorShuffle %46 %46 1 2 
					                                      f32_4 %48 = OpLoad %9 
					                                      f32_4 %49 = OpVectorShuffle %48 %47 4 1 5 3 
					                                                    OpStore %9 %49 
					                                      f32_4 %50 = OpLoad %9 
					                                      f32_4 %51 = OpLoad vs_TEXCOORD0 
					                                      f32_4 %52 = OpVectorShuffle %51 %51 3 3 3 3 
					                                      f32_4 %53 = OpFDiv %50 %52 
					                                                    OpStore %9 %53 
					                        read_only Texture2D %60 = OpLoad %59 
					                                    sampler %64 = OpLoad %63 
					                 read_only Texture2DSampled %66 = OpSampledImage %60 %64 
					                                      f32_4 %67 = OpLoad %9 
					                                      f32_2 %68 = OpVectorShuffle %67 %67 2 3 
					                                      f32_4 %69 = OpImageSampleImplicitLod %66 %68 
					                                      f32_3 %70 = OpVectorShuffle %69 %69 0 1 2 
					                                                    OpStore %56 %70 
					                        read_only Texture2D %71 = OpLoad %59 
					                                    sampler %72 = OpLoad %63 
					                 read_only Texture2DSampled %73 = OpSampledImage %71 %72 
					                                      f32_4 %74 = OpLoad %9 
					                                      f32_2 %75 = OpVectorShuffle %74 %74 0 1 
					                                      f32_4 %76 = OpImageSampleImplicitLod %73 %75 
					                                      f32_3 %77 = OpVectorShuffle %76 %76 0 1 2 
					                                      f32_4 %78 = OpLoad %9 
					                                      f32_4 %79 = OpVectorShuffle %78 %77 4 5 6 3 
					                                                    OpStore %9 %79 
					                                      f32_3 %80 = OpLoad %56 
					                                      f32_3 %83 = OpFMul %80 %82 
					                                                    OpStore %56 %83 
					                                      f32_4 %84 = OpLoad %9 
					                                      f32_3 %85 = OpVectorShuffle %84 %84 0 1 2 
					                                      f32_3 %88 = OpFMul %85 %87 
					                                      f32_3 %89 = OpLoad %56 
					                                      f32_3 %90 = OpFAdd %88 %89 
					                                      f32_4 %91 = OpLoad %9 
					                                      f32_4 %92 = OpVectorShuffle %91 %90 4 5 6 3 
					                                                    OpStore %9 %92 
					                               Private f32* %95 = OpAccessChain %34 %94 
					                                        f32 %96 = OpLoad %95 
					                               Private f32* %97 = OpAccessChain %93 %24 
					                                                    OpStore %97 %96 
					                                      f32_4 %98 = OpLoad vs_TEXCOORD0 
					                                      f32_2 %99 = OpVectorShuffle %98 %98 1 1 
					                                     f32_4 %100 = OpLoad %93 
					                                     f32_4 %101 = OpVectorShuffle %100 %99 0 4 2 5 
					                                                    OpStore %93 %101 
					                                     f32_4 %102 = OpLoad %93 
					                                     f32_2 %103 = OpVectorShuffle %102 %102 0 1 
					                                     f32_4 %104 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %105 = OpVectorShuffle %104 %104 3 3 
					                                     f32_2 %106 = OpFDiv %103 %105 
					                                     f32_3 %107 = OpLoad %56 
					                                     f32_3 %108 = OpVectorShuffle %107 %106 3 4 2 
					                                                    OpStore %56 %108 
					                       read_only Texture2D %109 = OpLoad %59 
					                                   sampler %110 = OpLoad %63 
					                read_only Texture2DSampled %111 = OpSampledImage %109 %110 
					                                     f32_3 %112 = OpLoad %56 
					                                     f32_2 %113 = OpVectorShuffle %112 %112 0 1 
					                                     f32_4 %114 = OpImageSampleImplicitLod %111 %113 
					                                     f32_3 %115 = OpVectorShuffle %114 %114 0 1 2 
					                                                    OpStore %56 %115 
					                                     f32_3 %116 = OpLoad %56 
					                                     f32_3 %119 = OpFMul %116 %118 
					                                     f32_4 %120 = OpLoad %9 
					                                     f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                                     f32_3 %122 = OpFAdd %119 %121 
					                                     f32_4 %123 = OpLoad %9 
					                                     f32_4 %124 = OpVectorShuffle %123 %122 4 5 6 3 
					                                                    OpStore %9 %124 
					                              Uniform f32* %125 = OpAccessChain %20 %22 %24 
					                                       f32 %126 = OpLoad %125 
					                                       f32 %127 = OpFNegate %126 
					                              Uniform f32* %128 = OpAccessChain %20 %28 
					                                       f32 %129 = OpLoad %128 
					                                       f32 %130 = OpFMul %127 %129 
					                                Input f32* %132 = OpAccessChain vs_TEXCOORD0 %24 
					                                       f32 %133 = OpLoad %132 
					                                       f32 %134 = OpFAdd %130 %133 
					                              Private f32* %136 = OpAccessChain %93 %135 
					                                                    OpStore %136 %134 
					                                     f32_4 %137 = OpLoad %93 
					                                     f32_2 %138 = OpVectorShuffle %137 %137 2 3 
					                                     f32_4 %139 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %140 = OpVectorShuffle %139 %139 3 3 
					                                     f32_2 %141 = OpFDiv %138 %140 
					                                     f32_3 %142 = OpLoad %56 
					                                     f32_3 %143 = OpVectorShuffle %142 %141 3 4 2 
					                                                    OpStore %56 %143 
					                       read_only Texture2D %144 = OpLoad %59 
					                                   sampler %145 = OpLoad %63 
					                read_only Texture2DSampled %146 = OpSampledImage %144 %145 
					                                     f32_3 %147 = OpLoad %56 
					                                     f32_2 %148 = OpVectorShuffle %147 %147 0 1 
					                                     f32_4 %149 = OpImageSampleImplicitLod %146 %148 
					                                     f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                                    OpStore %56 %150 
					                                     f32_3 %151 = OpLoad %56 
					                                     f32_3 %154 = OpFMul %151 %153 
					                                     f32_4 %155 = OpLoad %9 
					                                     f32_3 %156 = OpVectorShuffle %155 %155 0 1 2 
					                                     f32_3 %157 = OpFAdd %154 %156 
					                                     f32_4 %158 = OpLoad %9 
					                                     f32_4 %159 = OpVectorShuffle %158 %157 4 5 6 3 
					                                                    OpStore %9 %159 
					                                     f32_4 %160 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %161 = OpVectorShuffle %160 %160 0 1 
					                                     f32_4 %162 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %163 = OpVectorShuffle %162 %162 3 3 
					                                     f32_2 %164 = OpFDiv %161 %163 
					                                     f32_3 %165 = OpLoad %56 
					                                     f32_3 %166 = OpVectorShuffle %165 %164 3 4 2 
					                                                    OpStore %56 %166 
					                       read_only Texture2D %167 = OpLoad %59 
					                                   sampler %168 = OpLoad %63 
					                read_only Texture2DSampled %169 = OpSampledImage %167 %168 
					                                     f32_3 %170 = OpLoad %56 
					                                     f32_2 %171 = OpVectorShuffle %170 %170 0 1 
					                                     f32_4 %172 = OpImageSampleImplicitLod %169 %171 
					                                     f32_3 %173 = OpVectorShuffle %172 %172 0 1 2 
					                                                    OpStore %56 %173 
					                                     f32_3 %174 = OpLoad %56 
					                                     f32_3 %177 = OpFMul %174 %176 
					                                     f32_4 %178 = OpLoad %9 
					                                     f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                     f32_3 %180 = OpFAdd %177 %179 
					                                     f32_4 %181 = OpLoad %9 
					                                     f32_4 %182 = OpVectorShuffle %181 %180 4 5 6 3 
					                                                    OpStore %9 %182 
					                              Uniform f32* %183 = OpAccessChain %20 %22 %24 
					                                       f32 %184 = OpLoad %183 
					                              Uniform f32* %185 = OpAccessChain %20 %28 
					                                       f32 %186 = OpLoad %185 
					                                       f32 %187 = OpFMul %184 %186 
					                                Input f32* %188 = OpAccessChain vs_TEXCOORD0 %24 
					                                       f32 %189 = OpLoad %188 
					                                       f32 %190 = OpFAdd %187 %189 
					                              Private f32* %191 = OpAccessChain %93 %24 
					                                                    OpStore %191 %190 
					                                     f32_4 %192 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %193 = OpVectorShuffle %192 %192 1 1 
					                                     f32_4 %194 = OpLoad %93 
					                                     f32_4 %195 = OpVectorShuffle %194 %193 0 4 2 5 
					                                                    OpStore %93 %195 
					                                     f32_4 %196 = OpLoad %93 
					                                     f32_2 %197 = OpVectorShuffle %196 %196 0 1 
					                                     f32_4 %198 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %199 = OpVectorShuffle %198 %198 3 3 
					                                     f32_2 %200 = OpFDiv %197 %199 
					                                     f32_3 %201 = OpLoad %56 
					                                     f32_3 %202 = OpVectorShuffle %201 %200 3 4 2 
					                                                    OpStore %56 %202 
					                       read_only Texture2D %203 = OpLoad %59 
					                                   sampler %204 = OpLoad %63 
					                read_only Texture2DSampled %205 = OpSampledImage %203 %204 
					                                     f32_3 %206 = OpLoad %56 
					                                     f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                                     f32_4 %208 = OpImageSampleImplicitLod %205 %207 
					                                     f32_3 %209 = OpVectorShuffle %208 %208 0 1 2 
					                                                    OpStore %56 %209 
					                                     f32_3 %210 = OpLoad %56 
					                                     f32_3 %211 = OpFMul %210 %153 
					                                     f32_4 %212 = OpLoad %9 
					                                     f32_3 %213 = OpVectorShuffle %212 %212 0 1 2 
					                                     f32_3 %214 = OpFAdd %211 %213 
					                                     f32_4 %215 = OpLoad %9 
					                                     f32_4 %216 = OpVectorShuffle %215 %214 4 5 6 3 
					                                                    OpStore %9 %216 
					                              Private f32* %217 = OpAccessChain %17 %24 
					                                       f32 %218 = OpLoad %217 
					                                       f32 %220 = OpFMul %218 %219 
					                                Input f32* %221 = OpAccessChain vs_TEXCOORD0 %24 
					                                       f32 %222 = OpLoad %221 
					                                       f32 %223 = OpFAdd %220 %222 
					                              Private f32* %224 = OpAccessChain %93 %135 
					                                                    OpStore %224 %223 
					                              Private f32* %225 = OpAccessChain %17 %24 
					                                       f32 %226 = OpLoad %225 
					                                       f32 %228 = OpFMul %226 %227 
					                                Input f32* %229 = OpAccessChain vs_TEXCOORD0 %24 
					                                       f32 %230 = OpLoad %229 
					                                       f32 %231 = OpFAdd %228 %230 
					                              Private f32* %232 = OpAccessChain %34 %135 
					                                                    OpStore %232 %231 
					                                     f32_4 %233 = OpLoad %93 
					                                     f32_2 %234 = OpVectorShuffle %233 %233 2 3 
					                                     f32_4 %235 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %236 = OpVectorShuffle %235 %235 3 3 
					                                     f32_2 %237 = OpFDiv %234 %236 
					                                     f32_4 %238 = OpLoad %17 
					                                     f32_4 %239 = OpVectorShuffle %238 %237 4 5 2 3 
					                                                    OpStore %17 %239 
					                       read_only Texture2D %240 = OpLoad %59 
					                                   sampler %241 = OpLoad %63 
					                read_only Texture2DSampled %242 = OpSampledImage %240 %241 
					                                     f32_4 %243 = OpLoad %17 
					                                     f32_2 %244 = OpVectorShuffle %243 %243 0 1 
					                                     f32_4 %245 = OpImageSampleImplicitLod %242 %244 
					                                     f32_3 %246 = OpVectorShuffle %245 %245 0 1 2 
					                                     f32_4 %247 = OpLoad %17 
					                                     f32_4 %248 = OpVectorShuffle %247 %246 4 5 6 3 
					                                                    OpStore %17 %248 
					                                     f32_4 %249 = OpLoad %17 
					                                     f32_3 %250 = OpVectorShuffle %249 %249 0 1 2 
					                                     f32_3 %251 = OpFMul %250 %118 
					                                     f32_4 %252 = OpLoad %9 
					                                     f32_3 %253 = OpVectorShuffle %252 %252 0 1 2 
					                                     f32_3 %254 = OpFAdd %251 %253 
					                                     f32_4 %255 = OpLoad %9 
					                                     f32_4 %256 = OpVectorShuffle %255 %254 4 5 6 3 
					                                                    OpStore %9 %256 
					                                     f32_4 %257 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %258 = OpVectorShuffle %257 %257 1 1 
					                                     f32_4 %259 = OpLoad %34 
					                                     f32_4 %260 = OpVectorShuffle %259 %258 0 4 2 5 
					                                                    OpStore %34 %260 
					                                     f32_4 %261 = OpLoad %34 
					                                     f32_4 %262 = OpLoad vs_TEXCOORD0 
					                                     f32_4 %263 = OpVectorShuffle %262 %262 3 3 3 3 
					                                     f32_4 %264 = OpFDiv %261 %263 
					                                                    OpStore %17 %264 
					                       read_only Texture2D %265 = OpLoad %59 
					                                   sampler %266 = OpLoad %63 
					                read_only Texture2DSampled %267 = OpSampledImage %265 %266 
					                                     f32_4 %268 = OpLoad %17 
					                                     f32_2 %269 = OpVectorShuffle %268 %268 2 3 
					                                     f32_4 %270 = OpImageSampleImplicitLod %267 %269 
					                                     f32_3 %271 = OpVectorShuffle %270 %270 0 1 2 
					                                     f32_4 %272 = OpLoad %34 
					                                     f32_4 %273 = OpVectorShuffle %272 %271 4 5 6 3 
					                                                    OpStore %34 %273 
					                       read_only Texture2D %274 = OpLoad %59 
					                                   sampler %275 = OpLoad %63 
					                read_only Texture2DSampled %276 = OpSampledImage %274 %275 
					                                     f32_4 %277 = OpLoad %17 
					                                     f32_2 %278 = OpVectorShuffle %277 %277 0 1 
					                                     f32_4 %279 = OpImageSampleImplicitLod %276 %278 
					                                     f32_3 %280 = OpVectorShuffle %279 %279 0 1 2 
					                                     f32_4 %281 = OpLoad %17 
					                                     f32_4 %282 = OpVectorShuffle %281 %280 4 5 6 3 
					                                                    OpStore %17 %282 
					                                     f32_4 %283 = OpLoad %17 
					                                     f32_3 %284 = OpVectorShuffle %283 %283 0 1 2 
					                                     f32_3 %285 = OpFMul %284 %82 
					                                     f32_4 %286 = OpLoad %9 
					                                     f32_3 %287 = OpVectorShuffle %286 %286 0 1 2 
					                                     f32_3 %288 = OpFAdd %285 %287 
					                                     f32_4 %289 = OpLoad %9 
					                                     f32_4 %290 = OpVectorShuffle %289 %288 4 5 6 3 
					                                                    OpStore %9 %290 
					                                     f32_4 %291 = OpLoad %34 
					                                     f32_3 %292 = OpVectorShuffle %291 %291 0 1 2 
					                                     f32_3 %293 = OpFMul %292 %87 
					                                     f32_4 %294 = OpLoad %9 
					                                     f32_3 %295 = OpVectorShuffle %294 %294 0 1 2 
					                                     f32_3 %296 = OpFAdd %293 %295 
					                                     f32_4 %297 = OpLoad %9 
					                                     f32_4 %298 = OpVectorShuffle %297 %296 4 5 6 3 
					                                                    OpStore %9 %298 
					                                     f32_4 %301 = OpLoad %9 
					                                     f32_3 %302 = OpVectorShuffle %301 %301 0 1 2 
					                            Uniform f32_4* %305 = OpAccessChain %20 %303 
					                                     f32_4 %306 = OpLoad %305 
					                                     f32_3 %307 = OpVectorShuffle %306 %306 0 1 2 
					                                     f32_3 %308 = OpFMul %302 %307 
					                            Uniform f32_4* %310 = OpAccessChain %20 %309 
					                                     f32_4 %311 = OpLoad %310 
					                                     f32_3 %312 = OpVectorShuffle %311 %311 0 1 2 
					                                     f32_3 %313 = OpFAdd %308 %312 
					                                     f32_4 %314 = OpLoad %300 
					                                     f32_4 %315 = OpVectorShuffle %314 %313 4 5 6 3 
					                                                    OpStore %300 %315 
					                       read_only Texture2D %317 = OpLoad %316 
					                                   sampler %319 = OpLoad %318 
					                read_only Texture2DSampled %320 = OpSampledImage %317 %319 
					                                     f32_2 %323 = OpLoad vs_TEXCOORD1 
					                                     f32_4 %324 = OpImageSampleImplicitLod %320 %323 
					                                       f32 %325 = OpCompositeExtract %324 3 
					                              Private f32* %326 = OpAccessChain %9 %24 
					                                                    OpStore %326 %325 
					                              Private f32* %327 = OpAccessChain %9 %24 
					                                       f32 %328 = OpLoad %327 
					                               Output f32* %330 = OpAccessChain %300 %94 
					                                                    OpStore %330 %328 
					                                                    OpReturn
					                                                    OpFunctionEnd"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[3];
						vec4 _HBlur_TexelSize;
						float _Size;
						vec4 _AdditiveColor;
						vec4 _MultiplyColor;
					};
					uniform  sampler2D _HBlur;
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat6;
					void main()
					{
					    u_xlat0.yw = vs_TEXCOORD0.yy;
					    u_xlat1.x = _HBlur_TexelSize.x * _Size;
					    u_xlat2 = u_xlat1.xxxx * vec4(3.0, -4.0, -3.0, -2.0) + vs_TEXCOORD0.xxxx;
					    u_xlat0.xz = u_xlat2.yz;
					    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
					    u_xlat3 = texture(_HBlur, u_xlat0.zw);
					    u_xlat0 = texture(_HBlur, u_xlat0.xy);
					    u_xlat6.xyz = u_xlat3.xyz * vec3(0.0900000036, 0.0900000036, 0.0900000036);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.0500000007, 0.0500000007, 0.0500000007) + u_xlat6.xyz;
					    u_xlat3.x = u_xlat2.w;
					    u_xlat3.yw = vs_TEXCOORD0.yy;
					    u_xlat6.xy = u_xlat3.xy / vs_TEXCOORD0.ww;
					    u_xlat4 = texture(_HBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.119999997, 0.119999997, 0.119999997) + u_xlat0.xyz;
					    u_xlat3.z = (-_HBlur_TexelSize.x) * _Size + vs_TEXCOORD0.x;
					    u_xlat6.xy = u_xlat3.zw / vs_TEXCOORD0.ww;
					    u_xlat3 = texture(_HBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.150000006, 0.150000006, 0.150000006) + u_xlat0.xyz;
					    u_xlat6.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
					    u_xlat3 = texture(_HBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.180000007, 0.180000007, 0.180000007) + u_xlat0.xyz;
					    u_xlat3.x = _HBlur_TexelSize.x * _Size + vs_TEXCOORD0.x;
					    u_xlat3.yw = vs_TEXCOORD0.yy;
					    u_xlat6.xy = u_xlat3.xy / vs_TEXCOORD0.ww;
					    u_xlat4 = texture(_HBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.150000006, 0.150000006, 0.150000006) + u_xlat0.xyz;
					    u_xlat3.z = u_xlat1.x * 2.0 + vs_TEXCOORD0.x;
					    u_xlat2.z = u_xlat1.x * 4.0 + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.zw / vs_TEXCOORD0.ww;
					    u_xlat1 = texture(_HBlur, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.119999997, 0.119999997, 0.119999997) + u_xlat0.xyz;
					    u_xlat2.yw = vs_TEXCOORD0.yy;
					    u_xlat1 = u_xlat2 / vs_TEXCOORD0.wwww;
					    u_xlat2 = texture(_HBlur, u_xlat1.zw);
					    u_xlat1 = texture(_HBlur, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * _MultiplyColor.xyz + _AdditiveColor.xyz;
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!GL3x"
				}
				SubProgram "vulkan " {
					"spirv"
				}
			}
		}
		GrabPass {
			"_VBlur"
		}
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 78183
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 unused_0_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!GL3x
					#ifdef VERTEX
					#version 150
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_shader_bit_encoding
					#extension GL_ARB_shader_bit_encoding : enable
					#endif
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 150
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_shader_bit_encoding
					#extension GL_ARB_shader_bit_encoding : enable
					#endif
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _VBlur_TexelSize;
					uniform 	float _Size;
					uniform 	vec4 _AdditiveColor;
					uniform 	vec4 _MultiplyColor;
					UNITY_LOCATION(0) uniform  sampler2D _VBlur;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat6;
					void main()
					{
					    u_xlat0.xz = vs_TEXCOORD0.xx;
					    u_xlat1.x = _VBlur_TexelSize.y * _Size;
					    u_xlat2 = u_xlat1.xxxx * vec4(-4.0, 3.0, -3.0, -2.0) + vs_TEXCOORD0.yyyy;
					    u_xlat0.yw = u_xlat2.xz;
					    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
					    u_xlat3 = texture(_VBlur, u_xlat0.zw);
					    u_xlat0 = texture(_VBlur, u_xlat0.xy);
					    u_xlat6.xyz = u_xlat3.xyz * vec3(0.0900000036, 0.0900000036, 0.0900000036);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.0500000007, 0.0500000007, 0.0500000007) + u_xlat6.xyz;
					    u_xlat3.y = u_xlat2.w;
					    u_xlat3.xz = vs_TEXCOORD0.xx;
					    u_xlat6.xy = u_xlat3.xy / vs_TEXCOORD0.ww;
					    u_xlat4 = texture(_VBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.119999997, 0.119999997, 0.119999997) + u_xlat0.xyz;
					    u_xlat3.w = (-_VBlur_TexelSize.y) * _Size + vs_TEXCOORD0.y;
					    u_xlat6.xy = u_xlat3.zw / vs_TEXCOORD0.ww;
					    u_xlat3 = texture(_VBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.150000006, 0.150000006, 0.150000006) + u_xlat0.xyz;
					    u_xlat6.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
					    u_xlat3 = texture(_VBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.180000007, 0.180000007, 0.180000007) + u_xlat0.xyz;
					    u_xlat3.y = _VBlur_TexelSize.y * _Size + vs_TEXCOORD0.y;
					    u_xlat3.xz = vs_TEXCOORD0.xx;
					    u_xlat6.xy = u_xlat3.xy / vs_TEXCOORD0.ww;
					    u_xlat4 = texture(_VBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.150000006, 0.150000006, 0.150000006) + u_xlat0.xyz;
					    u_xlat3.w = u_xlat1.x * 2.0 + vs_TEXCOORD0.y;
					    u_xlat2.w = u_xlat1.x * 4.0 + vs_TEXCOORD0.y;
					    u_xlat1.xy = u_xlat3.zw / vs_TEXCOORD0.ww;
					    u_xlat1 = texture(_VBlur, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.119999997, 0.119999997, 0.119999997) + u_xlat0.xyz;
					    u_xlat2.xz = vs_TEXCOORD0.xx;
					    u_xlat1 = u_xlat2 / vs_TEXCOORD0.wwww;
					    u_xlat2 = texture(_VBlur, u_xlat1.zw);
					    u_xlat1 = texture(_VBlur, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * _MultiplyColor.xyz + _AdditiveColor.xyz;
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.w = u_xlat0.w;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 126
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %11 %79 %95 %108 %110 
					                                                     OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                     OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                     OpDecorate %11 Location 11 
					                                                     OpDecorate %16 ArrayStride 16 
					                                                     OpDecorate %17 ArrayStride 17 
					                                                     OpMemberDecorate %18 0 Offset 18 
					                                                     OpMemberDecorate %18 1 Offset 18 
					                                                     OpMemberDecorate %18 2 Offset 18 
					                                                     OpDecorate %18 Block 
					                                                     OpDecorate %20 DescriptorSet 20 
					                                                     OpDecorate %20 Binding 20 
					                                                     OpMemberDecorate %77 0 BuiltIn 77 
					                                                     OpMemberDecorate %77 1 BuiltIn 77 
					                                                     OpMemberDecorate %77 2 BuiltIn 77 
					                                                     OpDecorate %77 Block 
					                                                     OpDecorate vs_TEXCOORD0 Location 95 
					                                                     OpDecorate vs_TEXCOORD1 Location 108 
					                                                     OpDecorate %110 Location 110 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 4 
					                                              %8 = OpTypePointer Private %7 
					                               Private f32_4* %9 = OpVariable Private 
					                                             %10 = OpTypePointer Input %7 
					                                Input f32_4* %11 = OpVariable Input 
					                                             %14 = OpTypeInt 32 0 
					                                         u32 %15 = OpConstant 4 
					                                             %16 = OpTypeArray %7 %15 
					                                             %17 = OpTypeArray %7 %15 
					                                             %18 = OpTypeStruct %16 %17 %7 
					                                             %19 = OpTypePointer Uniform %18 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %20 = OpVariable Uniform 
					                                             %21 = OpTypeInt 32 1 
					                                         i32 %22 = OpConstant 0 
					                                         i32 %23 = OpConstant 1 
					                                             %24 = OpTypePointer Uniform %7 
					                                         i32 %35 = OpConstant 2 
					                                         i32 %44 = OpConstant 3 
					                              Private f32_4* %48 = OpVariable Private 
					                                         u32 %75 = OpConstant 1 
					                                             %76 = OpTypeArray %6 %75 
					                                             %77 = OpTypeStruct %7 %6 %76 
					                                             %78 = OpTypePointer Output %77 
					        Output struct {f32_4; f32; f32[1];}* %79 = OpVariable Output 
					                                             %81 = OpTypePointer Output %7 
					                                             %83 = OpTypeVector %6 2 
					                                         f32 %86 = OpConstant 3,674022E-40 
					                                         f32 %87 = OpConstant 3,674022E-40 
					                                       f32_2 %88 = OpConstantComposite %86 %87 
					                      Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                                        f32 %102 = OpConstant 3,674022E-40 
					                                      f32_2 %103 = OpConstantComposite %102 %102 
					                                            %107 = OpTypePointer Output %83 
					                      Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                            %109 = OpTypePointer Input %83 
					                               Input f32_2* %110 = OpVariable Input 
					                                            %120 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                                       f32_4 %12 = OpLoad %11 
					                                       f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
					                              Uniform f32_4* %25 = OpAccessChain %20 %22 %23 
					                                       f32_4 %26 = OpLoad %25 
					                                       f32_4 %27 = OpFMul %13 %26 
					                                                     OpStore %9 %27 
					                              Uniform f32_4* %28 = OpAccessChain %20 %22 %22 
					                                       f32_4 %29 = OpLoad %28 
					                                       f32_4 %30 = OpLoad %11 
					                                       f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
					                                       f32_4 %32 = OpFMul %29 %31 
					                                       f32_4 %33 = OpLoad %9 
					                                       f32_4 %34 = OpFAdd %32 %33 
					                                                     OpStore %9 %34 
					                              Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
					                                       f32_4 %37 = OpLoad %36 
					                                       f32_4 %38 = OpLoad %11 
					                                       f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
					                                       f32_4 %40 = OpFMul %37 %39 
					                                       f32_4 %41 = OpLoad %9 
					                                       f32_4 %42 = OpFAdd %40 %41 
					                                                     OpStore %9 %42 
					                                       f32_4 %43 = OpLoad %9 
					                              Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
					                                       f32_4 %46 = OpLoad %45 
					                                       f32_4 %47 = OpFAdd %43 %46 
					                                                     OpStore %9 %47 
					                                       f32_4 %49 = OpLoad %9 
					                                       f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
					                              Uniform f32_4* %51 = OpAccessChain %20 %23 %23 
					                                       f32_4 %52 = OpLoad %51 
					                                       f32_4 %53 = OpFMul %50 %52 
					                                                     OpStore %48 %53 
					                              Uniform f32_4* %54 = OpAccessChain %20 %23 %22 
					                                       f32_4 %55 = OpLoad %54 
					                                       f32_4 %56 = OpLoad %9 
					                                       f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
					                                       f32_4 %58 = OpFMul %55 %57 
					                                       f32_4 %59 = OpLoad %48 
					                                       f32_4 %60 = OpFAdd %58 %59 
					                                                     OpStore %48 %60 
					                              Uniform f32_4* %61 = OpAccessChain %20 %23 %35 
					                                       f32_4 %62 = OpLoad %61 
					                                       f32_4 %63 = OpLoad %9 
					                                       f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
					                                       f32_4 %65 = OpFMul %62 %64 
					                                       f32_4 %66 = OpLoad %48 
					                                       f32_4 %67 = OpFAdd %65 %66 
					                                                     OpStore %48 %67 
					                              Uniform f32_4* %68 = OpAccessChain %20 %23 %44 
					                                       f32_4 %69 = OpLoad %68 
					                                       f32_4 %70 = OpLoad %9 
					                                       f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
					                                       f32_4 %72 = OpFMul %69 %71 
					                                       f32_4 %73 = OpLoad %48 
					                                       f32_4 %74 = OpFAdd %72 %73 
					                                                     OpStore %9 %74 
					                                       f32_4 %80 = OpLoad %9 
					                               Output f32_4* %82 = OpAccessChain %79 %22 
					                                                     OpStore %82 %80 
					                                       f32_4 %84 = OpLoad %9 
					                                       f32_2 %85 = OpVectorShuffle %84 %84 0 1 
					                                       f32_2 %89 = OpFMul %85 %88 
					                                       f32_4 %90 = OpLoad %9 
					                                       f32_2 %91 = OpVectorShuffle %90 %90 3 3 
					                                       f32_2 %92 = OpFAdd %89 %91 
					                                       f32_4 %93 = OpLoad %9 
					                                       f32_4 %94 = OpVectorShuffle %93 %92 4 5 2 3 
					                                                     OpStore %9 %94 
					                                       f32_4 %96 = OpLoad %9 
					                                       f32_2 %97 = OpVectorShuffle %96 %96 2 3 
					                                       f32_4 %98 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %99 = OpVectorShuffle %98 %97 0 1 4 5 
					                                                     OpStore vs_TEXCOORD0 %99 
					                                      f32_4 %100 = OpLoad %9 
					                                      f32_2 %101 = OpVectorShuffle %100 %100 0 1 
					                                      f32_2 %104 = OpFMul %101 %103 
					                                      f32_4 %105 = OpLoad vs_TEXCOORD0 
					                                      f32_4 %106 = OpVectorShuffle %105 %104 4 5 2 3 
					                                                     OpStore vs_TEXCOORD0 %106 
					                                      f32_2 %111 = OpLoad %110 
					                             Uniform f32_4* %112 = OpAccessChain %20 %35 
					                                      f32_4 %113 = OpLoad %112 
					                                      f32_2 %114 = OpVectorShuffle %113 %113 0 1 
					                                      f32_2 %115 = OpFMul %111 %114 
					                             Uniform f32_4* %116 = OpAccessChain %20 %35 
					                                      f32_4 %117 = OpLoad %116 
					                                      f32_2 %118 = OpVectorShuffle %117 %117 2 3 
					                                      f32_2 %119 = OpFAdd %115 %118 
					                                                     OpStore vs_TEXCOORD1 %119 
					                                Output f32* %121 = OpAccessChain %79 %22 %75 
					                                        f32 %122 = OpLoad %121 
					                                        f32 %123 = OpFNegate %122 
					                                Output f32* %124 = OpAccessChain %79 %22 %75 
					                                                     OpStore %124 %123 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 332
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %11 %300 %322 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                    OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                    OpDecorate vs_TEXCOORD0 Location 11 
					                                                    OpMemberDecorate %18 0 Offset 18 
					                                                    OpMemberDecorate %18 1 Offset 18 
					                                                    OpMemberDecorate %18 2 Offset 18 
					                                                    OpMemberDecorate %18 3 Offset 18 
					                                                    OpDecorate %18 Block 
					                                                    OpDecorate %20 DescriptorSet 20 
					                                                    OpDecorate %20 Binding 20 
					                                                    OpDecorate %60 DescriptorSet 60 
					                                                    OpDecorate %60 Binding 60 
					                                                    OpDecorate %64 DescriptorSet 64 
					                                                    OpDecorate %64 Binding 64 
					                                                    OpDecorate %300 Location 300 
					                                                    OpDecorate %316 DescriptorSet 316 
					                                                    OpDecorate %316 Binding 316 
					                                                    OpDecorate %318 DescriptorSet 318 
					                                                    OpDecorate %318 Binding 318 
					                                                    OpDecorate vs_TEXCOORD1 Location 322 
					                                             %2 = OpTypeVoid 
					                                             %3 = OpTypeFunction %2 
					                                             %6 = OpTypeFloat 32 
					                                             %7 = OpTypeVector %6 4 
					                                             %8 = OpTypePointer Private %7 
					                              Private f32_4* %9 = OpVariable Private 
					                                            %10 = OpTypePointer Input %7 
					                      Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                            %12 = OpTypeVector %6 2 
					                             Private f32_4* %17 = OpVariable Private 
					                                            %18 = OpTypeStruct %7 %6 %7 %7 
					                                            %19 = OpTypePointer Uniform %18 
					Uniform struct {f32_4; f32; f32_4; f32_4;}* %20 = OpVariable Uniform 
					                                            %21 = OpTypeInt 32 1 
					                                        i32 %22 = OpConstant 0 
					                                            %23 = OpTypeInt 32 0 
					                                        u32 %24 = OpConstant 1 
					                                            %25 = OpTypePointer Uniform %6 
					                                        i32 %28 = OpConstant 1 
					                                        u32 %32 = OpConstant 0 
					                                            %33 = OpTypePointer Private %6 
					                             Private f32_4* %35 = OpVariable Private 
					                                        f32 %38 = OpConstant 3,674022E-40 
					                                        f32 %39 = OpConstant 3,674022E-40 
					                                        f32 %40 = OpConstant 3,674022E-40 
					                                        f32 %41 = OpConstant 3,674022E-40 
					                                      f32_4 %42 = OpConstantComposite %38 %39 %40 %41 
					                                            %55 = OpTypeVector %6 3 
					                                            %56 = OpTypePointer Private %55 
					                             Private f32_3* %57 = OpVariable Private 
					                                            %58 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                            %59 = OpTypePointer UniformConstant %58 
					       UniformConstant read_only Texture2D* %60 = OpVariable UniformConstant 
					                                            %62 = OpTypeSampler 
					                                            %63 = OpTypePointer UniformConstant %62 
					                   UniformConstant sampler* %64 = OpVariable UniformConstant 
					                                            %66 = OpTypeSampledImage %58 
					                                        f32 %82 = OpConstant 3,674022E-40 
					                                      f32_3 %83 = OpConstantComposite %82 %82 %82 
					                                        f32 %87 = OpConstant 3,674022E-40 
					                                      f32_3 %88 = OpConstantComposite %87 %87 %87 
					                             Private f32_4* %94 = OpVariable Private 
					                                        u32 %95 = OpConstant 3 
					                                       f32 %118 = OpConstant 3,674022E-40 
					                                     f32_3 %119 = OpConstantComposite %118 %118 %118 
					                                           %132 = OpTypePointer Input %6 
					                                       f32 %152 = OpConstant 3,674022E-40 
					                                     f32_3 %153 = OpConstantComposite %152 %152 %152 
					                                       f32 %175 = OpConstant 3,674022E-40 
					                                     f32_3 %176 = OpConstantComposite %175 %175 %175 
					                                       f32 %219 = OpConstant 3,674022E-40 
					                                       f32 %227 = OpConstant 3,674022E-40 
					                                           %299 = OpTypePointer Output %7 
					                             Output f32_4* %300 = OpVariable Output 
					                                       i32 %303 = OpConstant 3 
					                                           %304 = OpTypePointer Uniform %7 
					                                       i32 %309 = OpConstant 2 
					      UniformConstant read_only Texture2D* %316 = OpVariable UniformConstant 
					                  UniformConstant sampler* %318 = OpVariable UniformConstant 
					                                           %321 = OpTypePointer Input %12 
					                      Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                           %329 = OpTypePointer Output %6 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                                      f32_4 %13 = OpLoad vs_TEXCOORD0 
					                                      f32_2 %14 = OpVectorShuffle %13 %13 0 0 
					                                      f32_4 %15 = OpLoad %9 
					                                      f32_4 %16 = OpVectorShuffle %15 %14 4 1 5 3 
					                                                    OpStore %9 %16 
					                               Uniform f32* %26 = OpAccessChain %20 %22 %24 
					                                        f32 %27 = OpLoad %26 
					                               Uniform f32* %29 = OpAccessChain %20 %28 
					                                        f32 %30 = OpLoad %29 
					                                        f32 %31 = OpFMul %27 %30 
					                               Private f32* %34 = OpAccessChain %17 %32 
					                                                    OpStore %34 %31 
					                                      f32_4 %36 = OpLoad %17 
					                                      f32_4 %37 = OpVectorShuffle %36 %36 0 0 0 0 
					                                      f32_4 %43 = OpFMul %37 %42 
					                                      f32_4 %44 = OpLoad vs_TEXCOORD0 
					                                      f32_4 %45 = OpVectorShuffle %44 %44 1 1 1 1 
					                                      f32_4 %46 = OpFAdd %43 %45 
					                                                    OpStore %35 %46 
					                                      f32_4 %47 = OpLoad %35 
					                                      f32_2 %48 = OpVectorShuffle %47 %47 0 2 
					                                      f32_4 %49 = OpLoad %9 
					                                      f32_4 %50 = OpVectorShuffle %49 %48 0 4 2 5 
					                                                    OpStore %9 %50 
					                                      f32_4 %51 = OpLoad %9 
					                                      f32_4 %52 = OpLoad vs_TEXCOORD0 
					                                      f32_4 %53 = OpVectorShuffle %52 %52 3 3 3 3 
					                                      f32_4 %54 = OpFDiv %51 %53 
					                                                    OpStore %9 %54 
					                        read_only Texture2D %61 = OpLoad %60 
					                                    sampler %65 = OpLoad %64 
					                 read_only Texture2DSampled %67 = OpSampledImage %61 %65 
					                                      f32_4 %68 = OpLoad %9 
					                                      f32_2 %69 = OpVectorShuffle %68 %68 2 3 
					                                      f32_4 %70 = OpImageSampleImplicitLod %67 %69 
					                                      f32_3 %71 = OpVectorShuffle %70 %70 0 1 2 
					                                                    OpStore %57 %71 
					                        read_only Texture2D %72 = OpLoad %60 
					                                    sampler %73 = OpLoad %64 
					                 read_only Texture2DSampled %74 = OpSampledImage %72 %73 
					                                      f32_4 %75 = OpLoad %9 
					                                      f32_2 %76 = OpVectorShuffle %75 %75 0 1 
					                                      f32_4 %77 = OpImageSampleImplicitLod %74 %76 
					                                      f32_3 %78 = OpVectorShuffle %77 %77 0 1 2 
					                                      f32_4 %79 = OpLoad %9 
					                                      f32_4 %80 = OpVectorShuffle %79 %78 4 5 6 3 
					                                                    OpStore %9 %80 
					                                      f32_3 %81 = OpLoad %57 
					                                      f32_3 %84 = OpFMul %81 %83 
					                                                    OpStore %57 %84 
					                                      f32_4 %85 = OpLoad %9 
					                                      f32_3 %86 = OpVectorShuffle %85 %85 0 1 2 
					                                      f32_3 %89 = OpFMul %86 %88 
					                                      f32_3 %90 = OpLoad %57 
					                                      f32_3 %91 = OpFAdd %89 %90 
					                                      f32_4 %92 = OpLoad %9 
					                                      f32_4 %93 = OpVectorShuffle %92 %91 4 5 6 3 
					                                                    OpStore %9 %93 
					                               Private f32* %96 = OpAccessChain %35 %95 
					                                        f32 %97 = OpLoad %96 
					                               Private f32* %98 = OpAccessChain %94 %24 
					                                                    OpStore %98 %97 
					                                      f32_4 %99 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %100 = OpVectorShuffle %99 %99 0 0 
					                                     f32_4 %101 = OpLoad %94 
					                                     f32_4 %102 = OpVectorShuffle %101 %100 4 1 5 3 
					                                                    OpStore %94 %102 
					                                     f32_4 %103 = OpLoad %94 
					                                     f32_2 %104 = OpVectorShuffle %103 %103 0 1 
					                                     f32_4 %105 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %106 = OpVectorShuffle %105 %105 3 3 
					                                     f32_2 %107 = OpFDiv %104 %106 
					                                     f32_3 %108 = OpLoad %57 
					                                     f32_3 %109 = OpVectorShuffle %108 %107 3 4 2 
					                                                    OpStore %57 %109 
					                       read_only Texture2D %110 = OpLoad %60 
					                                   sampler %111 = OpLoad %64 
					                read_only Texture2DSampled %112 = OpSampledImage %110 %111 
					                                     f32_3 %113 = OpLoad %57 
					                                     f32_2 %114 = OpVectorShuffle %113 %113 0 1 
					                                     f32_4 %115 = OpImageSampleImplicitLod %112 %114 
					                                     f32_3 %116 = OpVectorShuffle %115 %115 0 1 2 
					                                                    OpStore %57 %116 
					                                     f32_3 %117 = OpLoad %57 
					                                     f32_3 %120 = OpFMul %117 %119 
					                                     f32_4 %121 = OpLoad %9 
					                                     f32_3 %122 = OpVectorShuffle %121 %121 0 1 2 
					                                     f32_3 %123 = OpFAdd %120 %122 
					                                     f32_4 %124 = OpLoad %9 
					                                     f32_4 %125 = OpVectorShuffle %124 %123 4 5 6 3 
					                                                    OpStore %9 %125 
					                              Uniform f32* %126 = OpAccessChain %20 %22 %24 
					                                       f32 %127 = OpLoad %126 
					                                       f32 %128 = OpFNegate %127 
					                              Uniform f32* %129 = OpAccessChain %20 %28 
					                                       f32 %130 = OpLoad %129 
					                                       f32 %131 = OpFMul %128 %130 
					                                Input f32* %133 = OpAccessChain vs_TEXCOORD0 %24 
					                                       f32 %134 = OpLoad %133 
					                                       f32 %135 = OpFAdd %131 %134 
					                              Private f32* %136 = OpAccessChain %94 %95 
					                                                    OpStore %136 %135 
					                                     f32_4 %137 = OpLoad %94 
					                                     f32_2 %138 = OpVectorShuffle %137 %137 2 3 
					                                     f32_4 %139 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %140 = OpVectorShuffle %139 %139 3 3 
					                                     f32_2 %141 = OpFDiv %138 %140 
					                                     f32_3 %142 = OpLoad %57 
					                                     f32_3 %143 = OpVectorShuffle %142 %141 3 4 2 
					                                                    OpStore %57 %143 
					                       read_only Texture2D %144 = OpLoad %60 
					                                   sampler %145 = OpLoad %64 
					                read_only Texture2DSampled %146 = OpSampledImage %144 %145 
					                                     f32_3 %147 = OpLoad %57 
					                                     f32_2 %148 = OpVectorShuffle %147 %147 0 1 
					                                     f32_4 %149 = OpImageSampleImplicitLod %146 %148 
					                                     f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                                    OpStore %57 %150 
					                                     f32_3 %151 = OpLoad %57 
					                                     f32_3 %154 = OpFMul %151 %153 
					                                     f32_4 %155 = OpLoad %9 
					                                     f32_3 %156 = OpVectorShuffle %155 %155 0 1 2 
					                                     f32_3 %157 = OpFAdd %154 %156 
					                                     f32_4 %158 = OpLoad %9 
					                                     f32_4 %159 = OpVectorShuffle %158 %157 4 5 6 3 
					                                                    OpStore %9 %159 
					                                     f32_4 %160 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %161 = OpVectorShuffle %160 %160 0 1 
					                                     f32_4 %162 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %163 = OpVectorShuffle %162 %162 3 3 
					                                     f32_2 %164 = OpFDiv %161 %163 
					                                     f32_3 %165 = OpLoad %57 
					                                     f32_3 %166 = OpVectorShuffle %165 %164 3 4 2 
					                                                    OpStore %57 %166 
					                       read_only Texture2D %167 = OpLoad %60 
					                                   sampler %168 = OpLoad %64 
					                read_only Texture2DSampled %169 = OpSampledImage %167 %168 
					                                     f32_3 %170 = OpLoad %57 
					                                     f32_2 %171 = OpVectorShuffle %170 %170 0 1 
					                                     f32_4 %172 = OpImageSampleImplicitLod %169 %171 
					                                     f32_3 %173 = OpVectorShuffle %172 %172 0 1 2 
					                                                    OpStore %57 %173 
					                                     f32_3 %174 = OpLoad %57 
					                                     f32_3 %177 = OpFMul %174 %176 
					                                     f32_4 %178 = OpLoad %9 
					                                     f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                     f32_3 %180 = OpFAdd %177 %179 
					                                     f32_4 %181 = OpLoad %9 
					                                     f32_4 %182 = OpVectorShuffle %181 %180 4 5 6 3 
					                                                    OpStore %9 %182 
					                              Uniform f32* %183 = OpAccessChain %20 %22 %24 
					                                       f32 %184 = OpLoad %183 
					                              Uniform f32* %185 = OpAccessChain %20 %28 
					                                       f32 %186 = OpLoad %185 
					                                       f32 %187 = OpFMul %184 %186 
					                                Input f32* %188 = OpAccessChain vs_TEXCOORD0 %24 
					                                       f32 %189 = OpLoad %188 
					                                       f32 %190 = OpFAdd %187 %189 
					                              Private f32* %191 = OpAccessChain %94 %24 
					                                                    OpStore %191 %190 
					                                     f32_4 %192 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %193 = OpVectorShuffle %192 %192 0 0 
					                                     f32_4 %194 = OpLoad %94 
					                                     f32_4 %195 = OpVectorShuffle %194 %193 4 1 5 3 
					                                                    OpStore %94 %195 
					                                     f32_4 %196 = OpLoad %94 
					                                     f32_2 %197 = OpVectorShuffle %196 %196 0 1 
					                                     f32_4 %198 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %199 = OpVectorShuffle %198 %198 3 3 
					                                     f32_2 %200 = OpFDiv %197 %199 
					                                     f32_3 %201 = OpLoad %57 
					                                     f32_3 %202 = OpVectorShuffle %201 %200 3 4 2 
					                                                    OpStore %57 %202 
					                       read_only Texture2D %203 = OpLoad %60 
					                                   sampler %204 = OpLoad %64 
					                read_only Texture2DSampled %205 = OpSampledImage %203 %204 
					                                     f32_3 %206 = OpLoad %57 
					                                     f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                                     f32_4 %208 = OpImageSampleImplicitLod %205 %207 
					                                     f32_3 %209 = OpVectorShuffle %208 %208 0 1 2 
					                                                    OpStore %57 %209 
					                                     f32_3 %210 = OpLoad %57 
					                                     f32_3 %211 = OpFMul %210 %153 
					                                     f32_4 %212 = OpLoad %9 
					                                     f32_3 %213 = OpVectorShuffle %212 %212 0 1 2 
					                                     f32_3 %214 = OpFAdd %211 %213 
					                                     f32_4 %215 = OpLoad %9 
					                                     f32_4 %216 = OpVectorShuffle %215 %214 4 5 6 3 
					                                                    OpStore %9 %216 
					                              Private f32* %217 = OpAccessChain %17 %32 
					                                       f32 %218 = OpLoad %217 
					                                       f32 %220 = OpFMul %218 %219 
					                                Input f32* %221 = OpAccessChain vs_TEXCOORD0 %24 
					                                       f32 %222 = OpLoad %221 
					                                       f32 %223 = OpFAdd %220 %222 
					                              Private f32* %224 = OpAccessChain %94 %95 
					                                                    OpStore %224 %223 
					                              Private f32* %225 = OpAccessChain %17 %32 
					                                       f32 %226 = OpLoad %225 
					                                       f32 %228 = OpFMul %226 %227 
					                                Input f32* %229 = OpAccessChain vs_TEXCOORD0 %24 
					                                       f32 %230 = OpLoad %229 
					                                       f32 %231 = OpFAdd %228 %230 
					                              Private f32* %232 = OpAccessChain %35 %95 
					                                                    OpStore %232 %231 
					                                     f32_4 %233 = OpLoad %94 
					                                     f32_2 %234 = OpVectorShuffle %233 %233 2 3 
					                                     f32_4 %235 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %236 = OpVectorShuffle %235 %235 3 3 
					                                     f32_2 %237 = OpFDiv %234 %236 
					                                     f32_4 %238 = OpLoad %17 
					                                     f32_4 %239 = OpVectorShuffle %238 %237 4 5 2 3 
					                                                    OpStore %17 %239 
					                       read_only Texture2D %240 = OpLoad %60 
					                                   sampler %241 = OpLoad %64 
					                read_only Texture2DSampled %242 = OpSampledImage %240 %241 
					                                     f32_4 %243 = OpLoad %17 
					                                     f32_2 %244 = OpVectorShuffle %243 %243 0 1 
					                                     f32_4 %245 = OpImageSampleImplicitLod %242 %244 
					                                     f32_3 %246 = OpVectorShuffle %245 %245 0 1 2 
					                                     f32_4 %247 = OpLoad %17 
					                                     f32_4 %248 = OpVectorShuffle %247 %246 4 5 6 3 
					                                                    OpStore %17 %248 
					                                     f32_4 %249 = OpLoad %17 
					                                     f32_3 %250 = OpVectorShuffle %249 %249 0 1 2 
					                                     f32_3 %251 = OpFMul %250 %119 
					                                     f32_4 %252 = OpLoad %9 
					                                     f32_3 %253 = OpVectorShuffle %252 %252 0 1 2 
					                                     f32_3 %254 = OpFAdd %251 %253 
					                                     f32_4 %255 = OpLoad %9 
					                                     f32_4 %256 = OpVectorShuffle %255 %254 4 5 6 3 
					                                                    OpStore %9 %256 
					                                     f32_4 %257 = OpLoad vs_TEXCOORD0 
					                                     f32_2 %258 = OpVectorShuffle %257 %257 0 0 
					                                     f32_4 %259 = OpLoad %35 
					                                     f32_4 %260 = OpVectorShuffle %259 %258 4 1 5 3 
					                                                    OpStore %35 %260 
					                                     f32_4 %261 = OpLoad %35 
					                                     f32_4 %262 = OpLoad vs_TEXCOORD0 
					                                     f32_4 %263 = OpVectorShuffle %262 %262 3 3 3 3 
					                                     f32_4 %264 = OpFDiv %261 %263 
					                                                    OpStore %17 %264 
					                       read_only Texture2D %265 = OpLoad %60 
					                                   sampler %266 = OpLoad %64 
					                read_only Texture2DSampled %267 = OpSampledImage %265 %266 
					                                     f32_4 %268 = OpLoad %17 
					                                     f32_2 %269 = OpVectorShuffle %268 %268 2 3 
					                                     f32_4 %270 = OpImageSampleImplicitLod %267 %269 
					                                     f32_3 %271 = OpVectorShuffle %270 %270 0 1 2 
					                                     f32_4 %272 = OpLoad %35 
					                                     f32_4 %273 = OpVectorShuffle %272 %271 4 5 6 3 
					                                                    OpStore %35 %273 
					                       read_only Texture2D %274 = OpLoad %60 
					                                   sampler %275 = OpLoad %64 
					                read_only Texture2DSampled %276 = OpSampledImage %274 %275 
					                                     f32_4 %277 = OpLoad %17 
					                                     f32_2 %278 = OpVectorShuffle %277 %277 0 1 
					                                     f32_4 %279 = OpImageSampleImplicitLod %276 %278 
					                                     f32_3 %280 = OpVectorShuffle %279 %279 0 1 2 
					                                     f32_4 %281 = OpLoad %17 
					                                     f32_4 %282 = OpVectorShuffle %281 %280 4 5 6 3 
					                                                    OpStore %17 %282 
					                                     f32_4 %283 = OpLoad %17 
					                                     f32_3 %284 = OpVectorShuffle %283 %283 0 1 2 
					                                     f32_3 %285 = OpFMul %284 %83 
					                                     f32_4 %286 = OpLoad %9 
					                                     f32_3 %287 = OpVectorShuffle %286 %286 0 1 2 
					                                     f32_3 %288 = OpFAdd %285 %287 
					                                     f32_4 %289 = OpLoad %9 
					                                     f32_4 %290 = OpVectorShuffle %289 %288 4 5 6 3 
					                                                    OpStore %9 %290 
					                                     f32_4 %291 = OpLoad %35 
					                                     f32_3 %292 = OpVectorShuffle %291 %291 0 1 2 
					                                     f32_3 %293 = OpFMul %292 %88 
					                                     f32_4 %294 = OpLoad %9 
					                                     f32_3 %295 = OpVectorShuffle %294 %294 0 1 2 
					                                     f32_3 %296 = OpFAdd %293 %295 
					                                     f32_4 %297 = OpLoad %9 
					                                     f32_4 %298 = OpVectorShuffle %297 %296 4 5 6 3 
					                                                    OpStore %9 %298 
					                                     f32_4 %301 = OpLoad %9 
					                                     f32_3 %302 = OpVectorShuffle %301 %301 0 1 2 
					                            Uniform f32_4* %305 = OpAccessChain %20 %303 
					                                     f32_4 %306 = OpLoad %305 
					                                     f32_3 %307 = OpVectorShuffle %306 %306 0 1 2 
					                                     f32_3 %308 = OpFMul %302 %307 
					                            Uniform f32_4* %310 = OpAccessChain %20 %309 
					                                     f32_4 %311 = OpLoad %310 
					                                     f32_3 %312 = OpVectorShuffle %311 %311 0 1 2 
					                                     f32_3 %313 = OpFAdd %308 %312 
					                                     f32_4 %314 = OpLoad %300 
					                                     f32_4 %315 = OpVectorShuffle %314 %313 4 5 6 3 
					                                                    OpStore %300 %315 
					                       read_only Texture2D %317 = OpLoad %316 
					                                   sampler %319 = OpLoad %318 
					                read_only Texture2DSampled %320 = OpSampledImage %317 %319 
					                                     f32_2 %323 = OpLoad vs_TEXCOORD1 
					                                     f32_4 %324 = OpImageSampleImplicitLod %320 %323 
					                                       f32 %325 = OpCompositeExtract %324 3 
					                              Private f32* %326 = OpAccessChain %9 %32 
					                                                    OpStore %326 %325 
					                              Private f32* %327 = OpAccessChain %9 %32 
					                                       f32 %328 = OpLoad %327 
					                               Output f32* %330 = OpAccessChain %300 %95 
					                                                    OpStore %330 %328 
					                                                    OpReturn
					                                                    OpFunctionEnd"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[3];
						vec4 _VBlur_TexelSize;
						float _Size;
						vec4 _AdditiveColor;
						vec4 _MultiplyColor;
					};
					uniform  sampler2D _VBlur;
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat6;
					void main()
					{
					    u_xlat0.xz = vs_TEXCOORD0.xx;
					    u_xlat1.x = _VBlur_TexelSize.y * _Size;
					    u_xlat2 = u_xlat1.xxxx * vec4(-4.0, 3.0, -3.0, -2.0) + vs_TEXCOORD0.yyyy;
					    u_xlat0.yw = u_xlat2.xz;
					    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
					    u_xlat3 = texture(_VBlur, u_xlat0.zw);
					    u_xlat0 = texture(_VBlur, u_xlat0.xy);
					    u_xlat6.xyz = u_xlat3.xyz * vec3(0.0900000036, 0.0900000036, 0.0900000036);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.0500000007, 0.0500000007, 0.0500000007) + u_xlat6.xyz;
					    u_xlat3.y = u_xlat2.w;
					    u_xlat3.xz = vs_TEXCOORD0.xx;
					    u_xlat6.xy = u_xlat3.xy / vs_TEXCOORD0.ww;
					    u_xlat4 = texture(_VBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.119999997, 0.119999997, 0.119999997) + u_xlat0.xyz;
					    u_xlat3.w = (-_VBlur_TexelSize.y) * _Size + vs_TEXCOORD0.y;
					    u_xlat6.xy = u_xlat3.zw / vs_TEXCOORD0.ww;
					    u_xlat3 = texture(_VBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.150000006, 0.150000006, 0.150000006) + u_xlat0.xyz;
					    u_xlat6.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
					    u_xlat3 = texture(_VBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.180000007, 0.180000007, 0.180000007) + u_xlat0.xyz;
					    u_xlat3.y = _VBlur_TexelSize.y * _Size + vs_TEXCOORD0.y;
					    u_xlat3.xz = vs_TEXCOORD0.xx;
					    u_xlat6.xy = u_xlat3.xy / vs_TEXCOORD0.ww;
					    u_xlat4 = texture(_VBlur, u_xlat6.xy);
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.150000006, 0.150000006, 0.150000006) + u_xlat0.xyz;
					    u_xlat3.w = u_xlat1.x * 2.0 + vs_TEXCOORD0.y;
					    u_xlat2.w = u_xlat1.x * 4.0 + vs_TEXCOORD0.y;
					    u_xlat1.xy = u_xlat3.zw / vs_TEXCOORD0.ww;
					    u_xlat1 = texture(_VBlur, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.119999997, 0.119999997, 0.119999997) + u_xlat0.xyz;
					    u_xlat2.xz = vs_TEXCOORD0.xx;
					    u_xlat1 = u_xlat2 / vs_TEXCOORD0.wwww;
					    u_xlat2 = texture(_VBlur, u_xlat1.zw);
					    u_xlat1 = texture(_VBlur, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * _MultiplyColor.xyz + _AdditiveColor.xyz;
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!GL3x"
				}
				SubProgram "vulkan " {
					"spirv"
				}
			}
		}
	}
}