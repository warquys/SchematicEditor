Shader "Hidden/IES/IESToSpotlightCookie" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_SpotHeight ("Spot height", Float) = 0
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 44939
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "FULL_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "glcore " {
					Keywords { "FULL_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
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
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
					uniform 	float _SpotHeight;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					bool u_xlatb2;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					bool u_xlatb5;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat4 = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4 = float(1.0) / u_xlat4;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4 = u_xlat4 * u_xlat6;
					    u_xlat6 = u_xlat4 * u_xlat4;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4 = u_xlat4 * u_xlat6 + u_xlat1.x;
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4 = u_xlat6 + u_xlat4;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
					    u_xlatb2 = u_xlatb2 && u_xlatb6;
					    u_xlat2 = (u_xlatb2) ? (-u_xlat4) : u_xlat4;
					    u_xlat2 = u_xlat2 + 3.14159012;
					    u_xlat1.x = u_xlat2 * 0.159155071;
					    u_xlat2 = max(u_xlat0.x, abs(_SpotHeight));
					    u_xlat2 = float(1.0) / u_xlat2;
					    u_xlat4 = min(u_xlat0.x, abs(_SpotHeight));
					    u_xlat2 = u_xlat2 * u_xlat4;
					    u_xlat4 = u_xlat2 * u_xlat2;
					    u_xlat6 = u_xlat4 * 0.0208350997 + -0.0851330012;
					    u_xlat6 = u_xlat4 * u_xlat6 + 0.180141002;
					    u_xlat6 = u_xlat4 * u_xlat6 + -0.330299497;
					    u_xlat4 = u_xlat4 * u_xlat6 + 0.999866009;
					    u_xlat6 = u_xlat4 * u_xlat2;
					    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
					    u_xlatb5 = u_xlat0.x<abs(_SpotHeight);
					    u_xlat6 = u_xlatb5 ? u_xlat6 : float(0.0);
					    u_xlat2 = u_xlat2 * u_xlat4 + u_xlat6;
					    u_xlat4 = min(u_xlat0.x, _SpotHeight);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlatb4 = u_xlat4<(-u_xlat4);
					    u_xlat2 = (u_xlatb4) ? (-u_xlat2) : u_xlat2;
					    u_xlat1.y = (-u_xlat2) * 0.636620283 + 1.0;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    SV_Target0 = u_xlat0.xxxx * (-u_xlat1.xyzx) + u_xlat1.xyzx;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "FULL_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 94
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Vertex %4 "main" %9 %11 %17 %78 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpDecorate vs_TEXCOORD0 Location 9 
					                                              OpDecorate %11 Location 11 
					                                              OpDecorate %17 Location 17 
					                                              OpDecorate %22 ArrayStride 22 
					                                              OpDecorate %23 ArrayStride 23 
					                                              OpMemberDecorate %24 0 Offset 24 
					                                              OpMemberDecorate %24 1 Offset 24 
					                                              OpDecorate %24 Block 
					                                              OpDecorate %26 DescriptorSet 26 
					                                              OpDecorate %26 Binding 26 
					                                              OpMemberDecorate %76 0 BuiltIn 76 
					                                              OpMemberDecorate %76 1 BuiltIn 76 
					                                              OpMemberDecorate %76 2 BuiltIn 76 
					                                              OpDecorate %76 Block 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 2 
					                                       %8 = OpTypePointer Output %7 
					               Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                      %10 = OpTypePointer Input %7 
					                         Input f32_2* %11 = OpVariable Input 
					                                      %13 = OpTypeVector %6 4 
					                                      %14 = OpTypePointer Private %13 
					                       Private f32_4* %15 = OpVariable Private 
					                                      %16 = OpTypePointer Input %13 
					                         Input f32_4* %17 = OpVariable Input 
					                                      %20 = OpTypeInt 32 0 
					                                  u32 %21 = OpConstant 4 
					                                      %22 = OpTypeArray %13 %21 
					                                      %23 = OpTypeArray %13 %21 
					                                      %24 = OpTypeStruct %22 %23 
					                                      %25 = OpTypePointer Uniform %24 
					Uniform struct {f32_4[4]; f32_4[4];}* %26 = OpVariable Uniform 
					                                      %27 = OpTypeInt 32 1 
					                                  i32 %28 = OpConstant 0 
					                                  i32 %29 = OpConstant 1 
					                                      %30 = OpTypePointer Uniform %13 
					                                  i32 %41 = OpConstant 2 
					                                  i32 %50 = OpConstant 3 
					                       Private f32_4* %54 = OpVariable Private 
					                                  u32 %74 = OpConstant 1 
					                                      %75 = OpTypeArray %6 %74 
					                                      %76 = OpTypeStruct %13 %6 %75 
					                                      %77 = OpTypePointer Output %76 
					 Output struct {f32_4; f32; f32[1];}* %78 = OpVariable Output 
					                                      %86 = OpTypePointer Output %13 
					                                      %88 = OpTypePointer Output %6 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                                f32_2 %12 = OpLoad %11 
					                                              OpStore vs_TEXCOORD0 %12 
					                                f32_4 %18 = OpLoad %17 
					                                f32_4 %19 = OpVectorShuffle %18 %18 1 1 1 1 
					                       Uniform f32_4* %31 = OpAccessChain %26 %28 %29 
					                                f32_4 %32 = OpLoad %31 
					                                f32_4 %33 = OpFMul %19 %32 
					                                              OpStore %15 %33 
					                       Uniform f32_4* %34 = OpAccessChain %26 %28 %28 
					                                f32_4 %35 = OpLoad %34 
					                                f32_4 %36 = OpLoad %17 
					                                f32_4 %37 = OpVectorShuffle %36 %36 0 0 0 0 
					                                f32_4 %38 = OpFMul %35 %37 
					                                f32_4 %39 = OpLoad %15 
					                                f32_4 %40 = OpFAdd %38 %39 
					                                              OpStore %15 %40 
					                       Uniform f32_4* %42 = OpAccessChain %26 %28 %41 
					                                f32_4 %43 = OpLoad %42 
					                                f32_4 %44 = OpLoad %17 
					                                f32_4 %45 = OpVectorShuffle %44 %44 2 2 2 2 
					                                f32_4 %46 = OpFMul %43 %45 
					                                f32_4 %47 = OpLoad %15 
					                                f32_4 %48 = OpFAdd %46 %47 
					                                              OpStore %15 %48 
					                                f32_4 %49 = OpLoad %15 
					                       Uniform f32_4* %51 = OpAccessChain %26 %28 %50 
					                                f32_4 %52 = OpLoad %51 
					                                f32_4 %53 = OpFAdd %49 %52 
					                                              OpStore %15 %53 
					                                f32_4 %55 = OpLoad %15 
					                                f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                       Uniform f32_4* %57 = OpAccessChain %26 %29 %29 
					                                f32_4 %58 = OpLoad %57 
					                                f32_4 %59 = OpFMul %56 %58 
					                                              OpStore %54 %59 
					                       Uniform f32_4* %60 = OpAccessChain %26 %29 %28 
					                                f32_4 %61 = OpLoad %60 
					                                f32_4 %62 = OpLoad %15 
					                                f32_4 %63 = OpVectorShuffle %62 %62 0 0 0 0 
					                                f32_4 %64 = OpFMul %61 %63 
					                                f32_4 %65 = OpLoad %54 
					                                f32_4 %66 = OpFAdd %64 %65 
					                                              OpStore %54 %66 
					                       Uniform f32_4* %67 = OpAccessChain %26 %29 %41 
					                                f32_4 %68 = OpLoad %67 
					                                f32_4 %69 = OpLoad %15 
					                                f32_4 %70 = OpVectorShuffle %69 %69 2 2 2 2 
					                                f32_4 %71 = OpFMul %68 %70 
					                                f32_4 %72 = OpLoad %54 
					                                f32_4 %73 = OpFAdd %71 %72 
					                                              OpStore %54 %73 
					                       Uniform f32_4* %79 = OpAccessChain %26 %29 %50 
					                                f32_4 %80 = OpLoad %79 
					                                f32_4 %81 = OpLoad %15 
					                                f32_4 %82 = OpVectorShuffle %81 %81 3 3 3 3 
					                                f32_4 %83 = OpFMul %80 %82 
					                                f32_4 %84 = OpLoad %54 
					                                f32_4 %85 = OpFAdd %83 %84 
					                        Output f32_4* %87 = OpAccessChain %78 %28 
					                                              OpStore %87 %85 
					                          Output f32* %89 = OpAccessChain %78 %28 %74 
					                                  f32 %90 = OpLoad %89 
					                                  f32 %91 = OpFNegate %90 
					                          Output f32* %92 = OpAccessChain %78 %28 %74 
					                                              OpStore %92 %91 
					                                              OpReturn
					                                              OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 324
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %11 %313 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpDecorate vs_TEXCOORD0 Location 11 
					                                              OpMemberDecorate %181 0 Offset 181 
					                                              OpDecorate %181 Block 
					                                              OpDecorate %183 DescriptorSet 183 
					                                              OpDecorate %183 Binding 183 
					                                              OpDecorate %300 DescriptorSet 300 
					                                              OpDecorate %300 Binding 300 
					                                              OpDecorate %304 DescriptorSet 304 
					                                              OpDecorate %304 Binding 304 
					                                              OpDecorate %313 Location 313 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 2 
					                                       %8 = OpTypePointer Private %7 
					                        Private f32_2* %9 = OpVariable Private 
					                                      %10 = OpTypePointer Input %7 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                  f32 %13 = OpConstant 3,674022E-40 
					                                f32_2 %14 = OpConstantComposite %13 %13 
					                                      %16 = OpTypePointer Private %6 
					                         Private f32* %17 = OpVariable Private 
					                                      %18 = OpTypeInt 32 0 
					                                  u32 %19 = OpConstant 0 
					                                  u32 %23 = OpConstant 1 
					                                  f32 %28 = OpConstant 3,674022E-40 
					                         Private f32* %31 = OpVariable Private 
					                       Private f32_2* %45 = OpVariable Private 
					                                  f32 %47 = OpConstant 3,674022E-40 
					                                  f32 %49 = OpConstant 3,674022E-40 
					                                  f32 %56 = OpConstant 3,674022E-40 
					                                  f32 %63 = OpConstant 3,674022E-40 
					                                  f32 %70 = OpConstant 3,674022E-40 
					                                  f32 %78 = OpConstant 3,674022E-40 
					                                  f32 %80 = OpConstant 3,674022E-40 
					                                      %83 = OpTypeBool 
					                                      %84 = OpTypePointer Private %83 
					                        Private bool* %85 = OpVariable Private 
					                                      %94 = OpTypePointer Function %6 
					                                 f32 %101 = OpConstant 3,674022E-40 
					                       Private bool* %110 = OpVariable Private 
					                                 f32 %118 = OpConstant 3,674022E-40 
					                       Private bool* %146 = OpVariable Private 
					                                     %156 = OpTypeVector %6 3 
					                                     %157 = OpTypePointer Private %156 
					                      Private f32_3* %158 = OpVariable Private 
					                                 f32 %171 = OpConstant 3,674022E-40 
					                                 f32 %176 = OpConstant 3,674022E-40 
					                                     %181 = OpTypeStruct %6 
					                                     %182 = OpTypePointer Uniform %181 
					              Uniform struct {f32;}* %183 = OpVariable Uniform 
					                                     %184 = OpTypeInt 32 1 
					                                 i32 %185 = OpConstant 0 
					                                     %186 = OpTypePointer Uniform %6 
					                       Private bool* %234 = OpVariable Private 
					                       Private bool* %274 = OpVariable Private 
					                                 f32 %294 = OpConstant 3,674022E-40 
					                                     %298 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %299 = OpTypePointer UniformConstant %298 
					UniformConstant read_only Texture2D* %300 = OpVariable UniformConstant 
					                                     %302 = OpTypeSampler 
					                                     %303 = OpTypePointer UniformConstant %302 
					            UniformConstant sampler* %304 = OpVariable UniformConstant 
					                                     %306 = OpTypeSampledImage %298 
					                                     %309 = OpTypeVector %6 4 
					                                     %312 = OpTypePointer Output %309 
					                       Output f32_4* %313 = OpVariable Output 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                        Function f32* %95 = OpVariable Function 
					                       Function f32* %160 = OpVariable Function 
					                       Function f32* %280 = OpVariable Function 
					                                f32_2 %12 = OpLoad vs_TEXCOORD0 
					                                f32_2 %15 = OpFAdd %12 %14 
					                                              OpStore %9 %15 
					                         Private f32* %20 = OpAccessChain %9 %19 
					                                  f32 %21 = OpLoad %20 
					                                  f32 %22 = OpExtInst %1 4 %21 
					                         Private f32* %24 = OpAccessChain %9 %23 
					                                  f32 %25 = OpLoad %24 
					                                  f32 %26 = OpExtInst %1 4 %25 
					                                  f32 %27 = OpExtInst %1 40 %22 %26 
					                                              OpStore %17 %27 
					                                  f32 %29 = OpLoad %17 
					                                  f32 %30 = OpFDiv %28 %29 
					                                              OpStore %17 %30 
					                         Private f32* %32 = OpAccessChain %9 %19 
					                                  f32 %33 = OpLoad %32 
					                                  f32 %34 = OpExtInst %1 4 %33 
					                         Private f32* %35 = OpAccessChain %9 %23 
					                                  f32 %36 = OpLoad %35 
					                                  f32 %37 = OpExtInst %1 4 %36 
					                                  f32 %38 = OpExtInst %1 37 %34 %37 
					                                              OpStore %31 %38 
					                                  f32 %39 = OpLoad %17 
					                                  f32 %40 = OpLoad %31 
					                                  f32 %41 = OpFMul %39 %40 
					                                              OpStore %17 %41 
					                                  f32 %42 = OpLoad %17 
					                                  f32 %43 = OpLoad %17 
					                                  f32 %44 = OpFMul %42 %43 
					                                              OpStore %31 %44 
					                                  f32 %46 = OpLoad %31 
					                                  f32 %48 = OpFMul %46 %47 
					                                  f32 %50 = OpFAdd %48 %49 
					                         Private f32* %51 = OpAccessChain %45 %19 
					                                              OpStore %51 %50 
					                                  f32 %52 = OpLoad %31 
					                         Private f32* %53 = OpAccessChain %45 %19 
					                                  f32 %54 = OpLoad %53 
					                                  f32 %55 = OpFMul %52 %54 
					                                  f32 %57 = OpFAdd %55 %56 
					                         Private f32* %58 = OpAccessChain %45 %19 
					                                              OpStore %58 %57 
					                                  f32 %59 = OpLoad %31 
					                         Private f32* %60 = OpAccessChain %45 %19 
					                                  f32 %61 = OpLoad %60 
					                                  f32 %62 = OpFMul %59 %61 
					                                  f32 %64 = OpFAdd %62 %63 
					                         Private f32* %65 = OpAccessChain %45 %19 
					                                              OpStore %65 %64 
					                                  f32 %66 = OpLoad %31 
					                         Private f32* %67 = OpAccessChain %45 %19 
					                                  f32 %68 = OpLoad %67 
					                                  f32 %69 = OpFMul %66 %68 
					                                  f32 %71 = OpFAdd %69 %70 
					                                              OpStore %31 %71 
					                                  f32 %72 = OpLoad %31 
					                                  f32 %73 = OpLoad %17 
					                                  f32 %74 = OpFMul %72 %73 
					                         Private f32* %75 = OpAccessChain %45 %19 
					                                              OpStore %75 %74 
					                         Private f32* %76 = OpAccessChain %45 %19 
					                                  f32 %77 = OpLoad %76 
					                                  f32 %79 = OpFMul %77 %78 
					                                  f32 %81 = OpFAdd %79 %80 
					                         Private f32* %82 = OpAccessChain %45 %19 
					                                              OpStore %82 %81 
					                         Private f32* %86 = OpAccessChain %9 %19 
					                                  f32 %87 = OpLoad %86 
					                                  f32 %88 = OpExtInst %1 4 %87 
					                         Private f32* %89 = OpAccessChain %9 %23 
					                                  f32 %90 = OpLoad %89 
					                                  f32 %91 = OpExtInst %1 4 %90 
					                                 bool %92 = OpFOrdLessThan %88 %91 
					                                              OpStore %85 %92 
					                                 bool %93 = OpLoad %85 
					                                              OpSelectionMerge %97 None 
					                                              OpBranchConditional %93 %96 %100 
					                                      %96 = OpLabel 
					                         Private f32* %98 = OpAccessChain %45 %19 
					                                  f32 %99 = OpLoad %98 
					                                              OpStore %95 %99 
					                                              OpBranch %97 
					                                     %100 = OpLabel 
					                                              OpStore %95 %101 
					                                              OpBranch %97 
					                                      %97 = OpLabel 
					                                 f32 %102 = OpLoad %95 
					                        Private f32* %103 = OpAccessChain %45 %19 
					                                              OpStore %103 %102 
					                                 f32 %104 = OpLoad %17 
					                                 f32 %105 = OpLoad %31 
					                                 f32 %106 = OpFMul %104 %105 
					                        Private f32* %107 = OpAccessChain %45 %19 
					                                 f32 %108 = OpLoad %107 
					                                 f32 %109 = OpFAdd %106 %108 
					                                              OpStore %17 %109 
					                        Private f32* %111 = OpAccessChain %9 %19 
					                                 f32 %112 = OpLoad %111 
					                        Private f32* %113 = OpAccessChain %9 %19 
					                                 f32 %114 = OpLoad %113 
					                                 f32 %115 = OpFNegate %114 
					                                bool %116 = OpFOrdLessThan %112 %115 
					                                              OpStore %110 %116 
					                                bool %117 = OpLoad %110 
					                                 f32 %119 = OpSelect %117 %118 %101 
					                                              OpStore %31 %119 
					                                 f32 %120 = OpLoad %31 
					                                 f32 %121 = OpLoad %17 
					                                 f32 %122 = OpFAdd %120 %121 
					                                              OpStore %17 %122 
					                        Private f32* %123 = OpAccessChain %9 %19 
					                                 f32 %124 = OpLoad %123 
					                        Private f32* %125 = OpAccessChain %9 %23 
					                                 f32 %126 = OpLoad %125 
					                                 f32 %127 = OpExtInst %1 37 %124 %126 
					                                              OpStore %31 %127 
					                                 f32 %128 = OpLoad %31 
					                                 f32 %129 = OpLoad %31 
					                                 f32 %130 = OpFNegate %129 
					                                bool %131 = OpFOrdLessThan %128 %130 
					                                              OpStore %110 %131 
					                        Private f32* %132 = OpAccessChain %9 %19 
					                                 f32 %133 = OpLoad %132 
					                        Private f32* %134 = OpAccessChain %9 %23 
					                                 f32 %135 = OpLoad %134 
					                                 f32 %136 = OpExtInst %1 40 %133 %135 
					                        Private f32* %137 = OpAccessChain %45 %19 
					                                              OpStore %137 %136 
					                               f32_2 %138 = OpLoad %9 
					                               f32_2 %139 = OpLoad %9 
					                                 f32 %140 = OpDot %138 %139 
					                        Private f32* %141 = OpAccessChain %9 %19 
					                                              OpStore %141 %140 
					                        Private f32* %142 = OpAccessChain %9 %19 
					                                 f32 %143 = OpLoad %142 
					                                 f32 %144 = OpExtInst %1 31 %143 
					                        Private f32* %145 = OpAccessChain %9 %19 
					                                              OpStore %145 %144 
					                        Private f32* %147 = OpAccessChain %45 %19 
					                                 f32 %148 = OpLoad %147 
					                        Private f32* %149 = OpAccessChain %45 %19 
					                                 f32 %150 = OpLoad %149 
					                                 f32 %151 = OpFNegate %150 
					                                bool %152 = OpFOrdGreaterThanEqual %148 %151 
					                                              OpStore %146 %152 
					                                bool %153 = OpLoad %146 
					                                bool %154 = OpLoad %110 
					                                bool %155 = OpLogicalAnd %153 %154 
					                                              OpStore %146 %155 
					                                bool %159 = OpLoad %146 
					                                              OpSelectionMerge %162 None 
					                                              OpBranchConditional %159 %161 %165 
					                                     %161 = OpLabel 
					                                 f32 %163 = OpLoad %17 
					                                 f32 %164 = OpFNegate %163 
					                                              OpStore %160 %164 
					                                              OpBranch %162 
					                                     %165 = OpLabel 
					                                 f32 %166 = OpLoad %17 
					                                              OpStore %160 %166 
					                                              OpBranch %162 
					                                     %162 = OpLabel 
					                                 f32 %167 = OpLoad %160 
					                        Private f32* %168 = OpAccessChain %158 %19 
					                                              OpStore %168 %167 
					                        Private f32* %169 = OpAccessChain %158 %19 
					                                 f32 %170 = OpLoad %169 
					                                 f32 %172 = OpFAdd %170 %171 
					                        Private f32* %173 = OpAccessChain %158 %19 
					                                              OpStore %173 %172 
					                        Private f32* %174 = OpAccessChain %158 %19 
					                                 f32 %175 = OpLoad %174 
					                                 f32 %177 = OpFMul %175 %176 
					                        Private f32* %178 = OpAccessChain %45 %19 
					                                              OpStore %178 %177 
					                        Private f32* %179 = OpAccessChain %9 %19 
					                                 f32 %180 = OpLoad %179 
					                        Uniform f32* %187 = OpAccessChain %183 %185 
					                                 f32 %188 = OpLoad %187 
					                                 f32 %189 = OpExtInst %1 4 %188 
					                                 f32 %190 = OpExtInst %1 40 %180 %189 
					                        Private f32* %191 = OpAccessChain %158 %19 
					                                              OpStore %191 %190 
					                        Private f32* %192 = OpAccessChain %158 %19 
					                                 f32 %193 = OpLoad %192 
					                                 f32 %194 = OpFDiv %28 %193 
					                        Private f32* %195 = OpAccessChain %158 %19 
					                                              OpStore %195 %194 
					                        Private f32* %196 = OpAccessChain %9 %19 
					                                 f32 %197 = OpLoad %196 
					                        Uniform f32* %198 = OpAccessChain %183 %185 
					                                 f32 %199 = OpLoad %198 
					                                 f32 %200 = OpExtInst %1 4 %199 
					                                 f32 %201 = OpExtInst %1 37 %197 %200 
					                                              OpStore %17 %201 
					                        Private f32* %202 = OpAccessChain %158 %19 
					                                 f32 %203 = OpLoad %202 
					                                 f32 %204 = OpLoad %17 
					                                 f32 %205 = OpFMul %203 %204 
					                        Private f32* %206 = OpAccessChain %158 %19 
					                                              OpStore %206 %205 
					                        Private f32* %207 = OpAccessChain %158 %19 
					                                 f32 %208 = OpLoad %207 
					                        Private f32* %209 = OpAccessChain %158 %19 
					                                 f32 %210 = OpLoad %209 
					                                 f32 %211 = OpFMul %208 %210 
					                                              OpStore %17 %211 
					                                 f32 %212 = OpLoad %17 
					                                 f32 %213 = OpFMul %212 %47 
					                                 f32 %214 = OpFAdd %213 %49 
					                                              OpStore %31 %214 
					                                 f32 %215 = OpLoad %17 
					                                 f32 %216 = OpLoad %31 
					                                 f32 %217 = OpFMul %215 %216 
					                                 f32 %218 = OpFAdd %217 %56 
					                                              OpStore %31 %218 
					                                 f32 %219 = OpLoad %17 
					                                 f32 %220 = OpLoad %31 
					                                 f32 %221 = OpFMul %219 %220 
					                                 f32 %222 = OpFAdd %221 %63 
					                                              OpStore %31 %222 
					                                 f32 %223 = OpLoad %17 
					                                 f32 %224 = OpLoad %31 
					                                 f32 %225 = OpFMul %223 %224 
					                                 f32 %226 = OpFAdd %225 %70 
					                                              OpStore %17 %226 
					                                 f32 %227 = OpLoad %17 
					                        Private f32* %228 = OpAccessChain %158 %19 
					                                 f32 %229 = OpLoad %228 
					                                 f32 %230 = OpFMul %227 %229 
					                                              OpStore %31 %230 
					                                 f32 %231 = OpLoad %31 
					                                 f32 %232 = OpFMul %231 %78 
					                                 f32 %233 = OpFAdd %232 %80 
					                                              OpStore %31 %233 
					                        Private f32* %235 = OpAccessChain %9 %19 
					                                 f32 %236 = OpLoad %235 
					                        Uniform f32* %237 = OpAccessChain %183 %185 
					                                 f32 %238 = OpLoad %237 
					                                 f32 %239 = OpExtInst %1 4 %238 
					                                bool %240 = OpFOrdLessThan %236 %239 
					                                              OpStore %234 %240 
					                                bool %241 = OpLoad %234 
					                                 f32 %242 = OpLoad %31 
					                                 f32 %243 = OpSelect %241 %242 %101 
					                                              OpStore %31 %243 
					                        Private f32* %244 = OpAccessChain %158 %19 
					                                 f32 %245 = OpLoad %244 
					                                 f32 %246 = OpLoad %17 
					                                 f32 %247 = OpFMul %245 %246 
					                                 f32 %248 = OpLoad %31 
					                                 f32 %249 = OpFAdd %247 %248 
					                        Private f32* %250 = OpAccessChain %158 %19 
					                                              OpStore %250 %249 
					                        Private f32* %251 = OpAccessChain %9 %19 
					                                 f32 %252 = OpLoad %251 
					                        Uniform f32* %253 = OpAccessChain %183 %185 
					                                 f32 %254 = OpLoad %253 
					                                 f32 %255 = OpExtInst %1 37 %252 %254 
					                                              OpStore %17 %255 
					                        Private f32* %256 = OpAccessChain %9 %19 
					                                 f32 %257 = OpLoad %256 
					                        Private f32* %258 = OpAccessChain %9 %19 
					                                 f32 %259 = OpLoad %258 
					                                 f32 %260 = OpFAdd %257 %259 
					                        Private f32* %261 = OpAccessChain %9 %19 
					                                              OpStore %261 %260 
					                        Private f32* %262 = OpAccessChain %9 %19 
					                                 f32 %263 = OpLoad %262 
					                        Private f32* %264 = OpAccessChain %9 %19 
					                                 f32 %265 = OpLoad %264 
					                                 f32 %266 = OpFMul %263 %265 
					                        Private f32* %267 = OpAccessChain %9 %19 
					                                              OpStore %267 %266 
					                        Private f32* %268 = OpAccessChain %9 %19 
					                                 f32 %269 = OpLoad %268 
					                        Private f32* %270 = OpAccessChain %9 %19 
					                                 f32 %271 = OpLoad %270 
					                                 f32 %272 = OpFMul %269 %271 
					                        Private f32* %273 = OpAccessChain %9 %19 
					                                              OpStore %273 %272 
					                                 f32 %275 = OpLoad %17 
					                                 f32 %276 = OpLoad %17 
					                                 f32 %277 = OpFNegate %276 
					                                bool %278 = OpFOrdLessThan %275 %277 
					                                              OpStore %274 %278 
					                                bool %279 = OpLoad %274 
					                                              OpSelectionMerge %282 None 
					                                              OpBranchConditional %279 %281 %286 
					                                     %281 = OpLabel 
					                        Private f32* %283 = OpAccessChain %158 %19 
					                                 f32 %284 = OpLoad %283 
					                                 f32 %285 = OpFNegate %284 
					                                              OpStore %280 %285 
					                                              OpBranch %282 
					                                     %286 = OpLabel 
					                        Private f32* %287 = OpAccessChain %158 %19 
					                                 f32 %288 = OpLoad %287 
					                                              OpStore %280 %288 
					                                              OpBranch %282 
					                                     %282 = OpLabel 
					                                 f32 %289 = OpLoad %280 
					                        Private f32* %290 = OpAccessChain %158 %19 
					                                              OpStore %290 %289 
					                        Private f32* %291 = OpAccessChain %158 %19 
					                                 f32 %292 = OpLoad %291 
					                                 f32 %293 = OpFNegate %292 
					                                 f32 %295 = OpFMul %293 %294 
					                                 f32 %296 = OpFAdd %295 %28 
					                        Private f32* %297 = OpAccessChain %45 %23 
					                                              OpStore %297 %296 
					                 read_only Texture2D %301 = OpLoad %300 
					                             sampler %305 = OpLoad %304 
					          read_only Texture2DSampled %307 = OpSampledImage %301 %305 
					                               f32_2 %308 = OpLoad %45 
					                               f32_4 %310 = OpImageSampleImplicitLod %307 %308 
					                               f32_3 %311 = OpVectorShuffle %310 %310 0 1 2 
					                                              OpStore %158 %311 
					                               f32_2 %314 = OpLoad %9 
					                               f32_4 %315 = OpVectorShuffle %314 %314 0 0 0 0 
					                               f32_3 %316 = OpLoad %158 
					                               f32_4 %317 = OpVectorShuffle %316 %316 0 1 2 0 
					                               f32_4 %318 = OpFNegate %317 
					                               f32_4 %319 = OpFMul %315 %318 
					                               f32_3 %320 = OpLoad %158 
					                               f32_4 %321 = OpVectorShuffle %320 %320 0 1 2 0 
					                               f32_4 %322 = OpFAdd %319 %321 
					                                              OpStore %313 %322 
					                                              OpReturn
					                                              OpFunctionEnd"
				}
				SubProgram "d3d11 " {
					Keywords { "HALF_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "glcore " {
					Keywords { "HALF_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
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
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
					uniform 	float _SpotHeight;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					bool u_xlatb2;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					bool u_xlatb5;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat4 = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4 = float(1.0) / u_xlat4;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4 = u_xlat4 * u_xlat6;
					    u_xlat6 = u_xlat4 * u_xlat4;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4 = u_xlat4 * u_xlat6 + u_xlat1.x;
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4 = u_xlat6 + u_xlat4;
					    u_xlat6 = min(u_xlat0.x, abs(u_xlat0.y));
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlatb2 = u_xlat6<(-u_xlat6);
					    u_xlat2 = (u_xlatb2) ? (-u_xlat4) : u_xlat4;
					    u_xlat1.x = u_xlat2 * 0.318310142;
					    u_xlat2 = max(u_xlat0.x, abs(_SpotHeight));
					    u_xlat2 = float(1.0) / u_xlat2;
					    u_xlat4 = min(u_xlat0.x, abs(_SpotHeight));
					    u_xlat2 = u_xlat2 * u_xlat4;
					    u_xlat4 = u_xlat2 * u_xlat2;
					    u_xlat6 = u_xlat4 * 0.0208350997 + -0.0851330012;
					    u_xlat6 = u_xlat4 * u_xlat6 + 0.180141002;
					    u_xlat6 = u_xlat4 * u_xlat6 + -0.330299497;
					    u_xlat4 = u_xlat4 * u_xlat6 + 0.999866009;
					    u_xlat6 = u_xlat4 * u_xlat2;
					    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
					    u_xlatb5 = u_xlat0.x<abs(_SpotHeight);
					    u_xlat6 = u_xlatb5 ? u_xlat6 : float(0.0);
					    u_xlat2 = u_xlat2 * u_xlat4 + u_xlat6;
					    u_xlat4 = min(u_xlat0.x, _SpotHeight);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlatb4 = u_xlat4<(-u_xlat4);
					    u_xlat2 = (u_xlatb4) ? (-u_xlat2) : u_xlat2;
					    u_xlat1.y = (-u_xlat2) * 0.636620283 + 1.0;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    SV_Target0 = u_xlat0.xxxx * (-u_xlat1.xyzx) + u_xlat1.xyzx;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "HALF_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 94
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Vertex %4 "main" %9 %11 %17 %78 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpDecorate vs_TEXCOORD0 Location 9 
					                                              OpDecorate %11 Location 11 
					                                              OpDecorate %17 Location 17 
					                                              OpDecorate %22 ArrayStride 22 
					                                              OpDecorate %23 ArrayStride 23 
					                                              OpMemberDecorate %24 0 Offset 24 
					                                              OpMemberDecorate %24 1 Offset 24 
					                                              OpDecorate %24 Block 
					                                              OpDecorate %26 DescriptorSet 26 
					                                              OpDecorate %26 Binding 26 
					                                              OpMemberDecorate %76 0 BuiltIn 76 
					                                              OpMemberDecorate %76 1 BuiltIn 76 
					                                              OpMemberDecorate %76 2 BuiltIn 76 
					                                              OpDecorate %76 Block 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 2 
					                                       %8 = OpTypePointer Output %7 
					               Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                      %10 = OpTypePointer Input %7 
					                         Input f32_2* %11 = OpVariable Input 
					                                      %13 = OpTypeVector %6 4 
					                                      %14 = OpTypePointer Private %13 
					                       Private f32_4* %15 = OpVariable Private 
					                                      %16 = OpTypePointer Input %13 
					                         Input f32_4* %17 = OpVariable Input 
					                                      %20 = OpTypeInt 32 0 
					                                  u32 %21 = OpConstant 4 
					                                      %22 = OpTypeArray %13 %21 
					                                      %23 = OpTypeArray %13 %21 
					                                      %24 = OpTypeStruct %22 %23 
					                                      %25 = OpTypePointer Uniform %24 
					Uniform struct {f32_4[4]; f32_4[4];}* %26 = OpVariable Uniform 
					                                      %27 = OpTypeInt 32 1 
					                                  i32 %28 = OpConstant 0 
					                                  i32 %29 = OpConstant 1 
					                                      %30 = OpTypePointer Uniform %13 
					                                  i32 %41 = OpConstant 2 
					                                  i32 %50 = OpConstant 3 
					                       Private f32_4* %54 = OpVariable Private 
					                                  u32 %74 = OpConstant 1 
					                                      %75 = OpTypeArray %6 %74 
					                                      %76 = OpTypeStruct %13 %6 %75 
					                                      %77 = OpTypePointer Output %76 
					 Output struct {f32_4; f32; f32[1];}* %78 = OpVariable Output 
					                                      %86 = OpTypePointer Output %13 
					                                      %88 = OpTypePointer Output %6 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                                f32_2 %12 = OpLoad %11 
					                                              OpStore vs_TEXCOORD0 %12 
					                                f32_4 %18 = OpLoad %17 
					                                f32_4 %19 = OpVectorShuffle %18 %18 1 1 1 1 
					                       Uniform f32_4* %31 = OpAccessChain %26 %28 %29 
					                                f32_4 %32 = OpLoad %31 
					                                f32_4 %33 = OpFMul %19 %32 
					                                              OpStore %15 %33 
					                       Uniform f32_4* %34 = OpAccessChain %26 %28 %28 
					                                f32_4 %35 = OpLoad %34 
					                                f32_4 %36 = OpLoad %17 
					                                f32_4 %37 = OpVectorShuffle %36 %36 0 0 0 0 
					                                f32_4 %38 = OpFMul %35 %37 
					                                f32_4 %39 = OpLoad %15 
					                                f32_4 %40 = OpFAdd %38 %39 
					                                              OpStore %15 %40 
					                       Uniform f32_4* %42 = OpAccessChain %26 %28 %41 
					                                f32_4 %43 = OpLoad %42 
					                                f32_4 %44 = OpLoad %17 
					                                f32_4 %45 = OpVectorShuffle %44 %44 2 2 2 2 
					                                f32_4 %46 = OpFMul %43 %45 
					                                f32_4 %47 = OpLoad %15 
					                                f32_4 %48 = OpFAdd %46 %47 
					                                              OpStore %15 %48 
					                                f32_4 %49 = OpLoad %15 
					                       Uniform f32_4* %51 = OpAccessChain %26 %28 %50 
					                                f32_4 %52 = OpLoad %51 
					                                f32_4 %53 = OpFAdd %49 %52 
					                                              OpStore %15 %53 
					                                f32_4 %55 = OpLoad %15 
					                                f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                       Uniform f32_4* %57 = OpAccessChain %26 %29 %29 
					                                f32_4 %58 = OpLoad %57 
					                                f32_4 %59 = OpFMul %56 %58 
					                                              OpStore %54 %59 
					                       Uniform f32_4* %60 = OpAccessChain %26 %29 %28 
					                                f32_4 %61 = OpLoad %60 
					                                f32_4 %62 = OpLoad %15 
					                                f32_4 %63 = OpVectorShuffle %62 %62 0 0 0 0 
					                                f32_4 %64 = OpFMul %61 %63 
					                                f32_4 %65 = OpLoad %54 
					                                f32_4 %66 = OpFAdd %64 %65 
					                                              OpStore %54 %66 
					                       Uniform f32_4* %67 = OpAccessChain %26 %29 %41 
					                                f32_4 %68 = OpLoad %67 
					                                f32_4 %69 = OpLoad %15 
					                                f32_4 %70 = OpVectorShuffle %69 %69 2 2 2 2 
					                                f32_4 %71 = OpFMul %68 %70 
					                                f32_4 %72 = OpLoad %54 
					                                f32_4 %73 = OpFAdd %71 %72 
					                                              OpStore %54 %73 
					                       Uniform f32_4* %79 = OpAccessChain %26 %29 %50 
					                                f32_4 %80 = OpLoad %79 
					                                f32_4 %81 = OpLoad %15 
					                                f32_4 %82 = OpVectorShuffle %81 %81 3 3 3 3 
					                                f32_4 %83 = OpFMul %80 %82 
					                                f32_4 %84 = OpLoad %54 
					                                f32_4 %85 = OpFAdd %83 %84 
					                        Output f32_4* %87 = OpAccessChain %78 %28 
					                                              OpStore %87 %85 
					                          Output f32* %89 = OpAccessChain %78 %28 %74 
					                                  f32 %90 = OpLoad %89 
					                                  f32 %91 = OpFNegate %90 
					                          Output f32* %92 = OpAccessChain %78 %28 %74 
					                                              OpStore %92 %91 
					                                              OpReturn
					                                              OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 305
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %11 %294 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpDecorate vs_TEXCOORD0 Location 11 
					                                              OpMemberDecorate %162 0 Offset 162 
					                                              OpDecorate %162 Block 
					                                              OpDecorate %164 DescriptorSet 164 
					                                              OpDecorate %164 Binding 164 
					                                              OpDecorate %281 DescriptorSet 281 
					                                              OpDecorate %281 Binding 281 
					                                              OpDecorate %285 DescriptorSet 285 
					                                              OpDecorate %285 Binding 285 
					                                              OpDecorate %294 Location 294 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 2 
					                                       %8 = OpTypePointer Private %7 
					                        Private f32_2* %9 = OpVariable Private 
					                                      %10 = OpTypePointer Input %7 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                  f32 %13 = OpConstant 3,674022E-40 
					                                f32_2 %14 = OpConstantComposite %13 %13 
					                                      %16 = OpTypePointer Private %6 
					                         Private f32* %17 = OpVariable Private 
					                                      %18 = OpTypeInt 32 0 
					                                  u32 %19 = OpConstant 0 
					                                  u32 %23 = OpConstant 1 
					                                  f32 %28 = OpConstant 3,674022E-40 
					                         Private f32* %31 = OpVariable Private 
					                       Private f32_2* %45 = OpVariable Private 
					                                  f32 %47 = OpConstant 3,674022E-40 
					                                  f32 %49 = OpConstant 3,674022E-40 
					                                  f32 %56 = OpConstant 3,674022E-40 
					                                  f32 %63 = OpConstant 3,674022E-40 
					                                  f32 %70 = OpConstant 3,674022E-40 
					                                  f32 %78 = OpConstant 3,674022E-40 
					                                  f32 %80 = OpConstant 3,674022E-40 
					                                      %83 = OpTypeBool 
					                                      %84 = OpTypePointer Private %83 
					                        Private bool* %85 = OpVariable Private 
					                                      %94 = OpTypePointer Function %6 
					                                 f32 %101 = OpConstant 3,674022E-40 
					                       Private bool* %110 = OpVariable Private 
					                                 f32 %118 = OpConstant 3,674022E-40 
					                       Private bool* %137 = OpVariable Private 
					                                     %142 = OpTypeVector %6 3 
					                                     %143 = OpTypePointer Private %142 
					                      Private f32_3* %144 = OpVariable Private 
					                                 f32 %157 = OpConstant 3,674022E-40 
					                                     %162 = OpTypeStruct %6 
					                                     %163 = OpTypePointer Uniform %162 
					              Uniform struct {f32;}* %164 = OpVariable Uniform 
					                                     %165 = OpTypeInt 32 1 
					                                 i32 %166 = OpConstant 0 
					                                     %167 = OpTypePointer Uniform %6 
					                       Private bool* %215 = OpVariable Private 
					                       Private bool* %255 = OpVariable Private 
					                                 f32 %275 = OpConstant 3,674022E-40 
					                                     %279 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %280 = OpTypePointer UniformConstant %279 
					UniformConstant read_only Texture2D* %281 = OpVariable UniformConstant 
					                                     %283 = OpTypeSampler 
					                                     %284 = OpTypePointer UniformConstant %283 
					            UniformConstant sampler* %285 = OpVariable UniformConstant 
					                                     %287 = OpTypeSampledImage %279 
					                                     %290 = OpTypeVector %6 4 
					                                     %293 = OpTypePointer Output %290 
					                       Output f32_4* %294 = OpVariable Output 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                        Function f32* %95 = OpVariable Function 
					                       Function f32* %146 = OpVariable Function 
					                       Function f32* %261 = OpVariable Function 
					                                f32_2 %12 = OpLoad vs_TEXCOORD0 
					                                f32_2 %15 = OpFAdd %12 %14 
					                                              OpStore %9 %15 
					                         Private f32* %20 = OpAccessChain %9 %19 
					                                  f32 %21 = OpLoad %20 
					                                  f32 %22 = OpExtInst %1 4 %21 
					                         Private f32* %24 = OpAccessChain %9 %23 
					                                  f32 %25 = OpLoad %24 
					                                  f32 %26 = OpExtInst %1 4 %25 
					                                  f32 %27 = OpExtInst %1 40 %22 %26 
					                                              OpStore %17 %27 
					                                  f32 %29 = OpLoad %17 
					                                  f32 %30 = OpFDiv %28 %29 
					                                              OpStore %17 %30 
					                         Private f32* %32 = OpAccessChain %9 %19 
					                                  f32 %33 = OpLoad %32 
					                                  f32 %34 = OpExtInst %1 4 %33 
					                         Private f32* %35 = OpAccessChain %9 %23 
					                                  f32 %36 = OpLoad %35 
					                                  f32 %37 = OpExtInst %1 4 %36 
					                                  f32 %38 = OpExtInst %1 37 %34 %37 
					                                              OpStore %31 %38 
					                                  f32 %39 = OpLoad %17 
					                                  f32 %40 = OpLoad %31 
					                                  f32 %41 = OpFMul %39 %40 
					                                              OpStore %17 %41 
					                                  f32 %42 = OpLoad %17 
					                                  f32 %43 = OpLoad %17 
					                                  f32 %44 = OpFMul %42 %43 
					                                              OpStore %31 %44 
					                                  f32 %46 = OpLoad %31 
					                                  f32 %48 = OpFMul %46 %47 
					                                  f32 %50 = OpFAdd %48 %49 
					                         Private f32* %51 = OpAccessChain %45 %19 
					                                              OpStore %51 %50 
					                                  f32 %52 = OpLoad %31 
					                         Private f32* %53 = OpAccessChain %45 %19 
					                                  f32 %54 = OpLoad %53 
					                                  f32 %55 = OpFMul %52 %54 
					                                  f32 %57 = OpFAdd %55 %56 
					                         Private f32* %58 = OpAccessChain %45 %19 
					                                              OpStore %58 %57 
					                                  f32 %59 = OpLoad %31 
					                         Private f32* %60 = OpAccessChain %45 %19 
					                                  f32 %61 = OpLoad %60 
					                                  f32 %62 = OpFMul %59 %61 
					                                  f32 %64 = OpFAdd %62 %63 
					                         Private f32* %65 = OpAccessChain %45 %19 
					                                              OpStore %65 %64 
					                                  f32 %66 = OpLoad %31 
					                         Private f32* %67 = OpAccessChain %45 %19 
					                                  f32 %68 = OpLoad %67 
					                                  f32 %69 = OpFMul %66 %68 
					                                  f32 %71 = OpFAdd %69 %70 
					                                              OpStore %31 %71 
					                                  f32 %72 = OpLoad %31 
					                                  f32 %73 = OpLoad %17 
					                                  f32 %74 = OpFMul %72 %73 
					                         Private f32* %75 = OpAccessChain %45 %19 
					                                              OpStore %75 %74 
					                         Private f32* %76 = OpAccessChain %45 %19 
					                                  f32 %77 = OpLoad %76 
					                                  f32 %79 = OpFMul %77 %78 
					                                  f32 %81 = OpFAdd %79 %80 
					                         Private f32* %82 = OpAccessChain %45 %19 
					                                              OpStore %82 %81 
					                         Private f32* %86 = OpAccessChain %9 %19 
					                                  f32 %87 = OpLoad %86 
					                                  f32 %88 = OpExtInst %1 4 %87 
					                         Private f32* %89 = OpAccessChain %9 %23 
					                                  f32 %90 = OpLoad %89 
					                                  f32 %91 = OpExtInst %1 4 %90 
					                                 bool %92 = OpFOrdLessThan %88 %91 
					                                              OpStore %85 %92 
					                                 bool %93 = OpLoad %85 
					                                              OpSelectionMerge %97 None 
					                                              OpBranchConditional %93 %96 %100 
					                                      %96 = OpLabel 
					                         Private f32* %98 = OpAccessChain %45 %19 
					                                  f32 %99 = OpLoad %98 
					                                              OpStore %95 %99 
					                                              OpBranch %97 
					                                     %100 = OpLabel 
					                                              OpStore %95 %101 
					                                              OpBranch %97 
					                                      %97 = OpLabel 
					                                 f32 %102 = OpLoad %95 
					                        Private f32* %103 = OpAccessChain %45 %19 
					                                              OpStore %103 %102 
					                                 f32 %104 = OpLoad %17 
					                                 f32 %105 = OpLoad %31 
					                                 f32 %106 = OpFMul %104 %105 
					                        Private f32* %107 = OpAccessChain %45 %19 
					                                 f32 %108 = OpLoad %107 
					                                 f32 %109 = OpFAdd %106 %108 
					                                              OpStore %17 %109 
					                        Private f32* %111 = OpAccessChain %9 %19 
					                                 f32 %112 = OpLoad %111 
					                        Private f32* %113 = OpAccessChain %9 %19 
					                                 f32 %114 = OpLoad %113 
					                                 f32 %115 = OpFNegate %114 
					                                bool %116 = OpFOrdLessThan %112 %115 
					                                              OpStore %110 %116 
					                                bool %117 = OpLoad %110 
					                                 f32 %119 = OpSelect %117 %118 %101 
					                                              OpStore %31 %119 
					                                 f32 %120 = OpLoad %31 
					                                 f32 %121 = OpLoad %17 
					                                 f32 %122 = OpFAdd %120 %121 
					                                              OpStore %17 %122 
					                        Private f32* %123 = OpAccessChain %9 %19 
					                                 f32 %124 = OpLoad %123 
					                        Private f32* %125 = OpAccessChain %9 %23 
					                                 f32 %126 = OpLoad %125 
					                                 f32 %127 = OpExtInst %1 4 %126 
					                                 f32 %128 = OpExtInst %1 37 %124 %127 
					                                              OpStore %31 %128 
					                               f32_2 %129 = OpLoad %9 
					                               f32_2 %130 = OpLoad %9 
					                                 f32 %131 = OpDot %129 %130 
					                        Private f32* %132 = OpAccessChain %9 %19 
					                                              OpStore %132 %131 
					                        Private f32* %133 = OpAccessChain %9 %19 
					                                 f32 %134 = OpLoad %133 
					                                 f32 %135 = OpExtInst %1 31 %134 
					                        Private f32* %136 = OpAccessChain %9 %19 
					                                              OpStore %136 %135 
					                                 f32 %138 = OpLoad %31 
					                                 f32 %139 = OpLoad %31 
					                                 f32 %140 = OpFNegate %139 
					                                bool %141 = OpFOrdLessThan %138 %140 
					                                              OpStore %137 %141 
					                                bool %145 = OpLoad %137 
					                                              OpSelectionMerge %148 None 
					                                              OpBranchConditional %145 %147 %151 
					                                     %147 = OpLabel 
					                                 f32 %149 = OpLoad %17 
					                                 f32 %150 = OpFNegate %149 
					                                              OpStore %146 %150 
					                                              OpBranch %148 
					                                     %151 = OpLabel 
					                                 f32 %152 = OpLoad %17 
					                                              OpStore %146 %152 
					                                              OpBranch %148 
					                                     %148 = OpLabel 
					                                 f32 %153 = OpLoad %146 
					                        Private f32* %154 = OpAccessChain %144 %19 
					                                              OpStore %154 %153 
					                        Private f32* %155 = OpAccessChain %144 %19 
					                                 f32 %156 = OpLoad %155 
					                                 f32 %158 = OpFMul %156 %157 
					                        Private f32* %159 = OpAccessChain %45 %19 
					                                              OpStore %159 %158 
					                        Private f32* %160 = OpAccessChain %9 %19 
					                                 f32 %161 = OpLoad %160 
					                        Uniform f32* %168 = OpAccessChain %164 %166 
					                                 f32 %169 = OpLoad %168 
					                                 f32 %170 = OpExtInst %1 4 %169 
					                                 f32 %171 = OpExtInst %1 40 %161 %170 
					                        Private f32* %172 = OpAccessChain %144 %19 
					                                              OpStore %172 %171 
					                        Private f32* %173 = OpAccessChain %144 %19 
					                                 f32 %174 = OpLoad %173 
					                                 f32 %175 = OpFDiv %28 %174 
					                        Private f32* %176 = OpAccessChain %144 %19 
					                                              OpStore %176 %175 
					                        Private f32* %177 = OpAccessChain %9 %19 
					                                 f32 %178 = OpLoad %177 
					                        Uniform f32* %179 = OpAccessChain %164 %166 
					                                 f32 %180 = OpLoad %179 
					                                 f32 %181 = OpExtInst %1 4 %180 
					                                 f32 %182 = OpExtInst %1 37 %178 %181 
					                                              OpStore %17 %182 
					                        Private f32* %183 = OpAccessChain %144 %19 
					                                 f32 %184 = OpLoad %183 
					                                 f32 %185 = OpLoad %17 
					                                 f32 %186 = OpFMul %184 %185 
					                        Private f32* %187 = OpAccessChain %144 %19 
					                                              OpStore %187 %186 
					                        Private f32* %188 = OpAccessChain %144 %19 
					                                 f32 %189 = OpLoad %188 
					                        Private f32* %190 = OpAccessChain %144 %19 
					                                 f32 %191 = OpLoad %190 
					                                 f32 %192 = OpFMul %189 %191 
					                                              OpStore %17 %192 
					                                 f32 %193 = OpLoad %17 
					                                 f32 %194 = OpFMul %193 %47 
					                                 f32 %195 = OpFAdd %194 %49 
					                                              OpStore %31 %195 
					                                 f32 %196 = OpLoad %17 
					                                 f32 %197 = OpLoad %31 
					                                 f32 %198 = OpFMul %196 %197 
					                                 f32 %199 = OpFAdd %198 %56 
					                                              OpStore %31 %199 
					                                 f32 %200 = OpLoad %17 
					                                 f32 %201 = OpLoad %31 
					                                 f32 %202 = OpFMul %200 %201 
					                                 f32 %203 = OpFAdd %202 %63 
					                                              OpStore %31 %203 
					                                 f32 %204 = OpLoad %17 
					                                 f32 %205 = OpLoad %31 
					                                 f32 %206 = OpFMul %204 %205 
					                                 f32 %207 = OpFAdd %206 %70 
					                                              OpStore %17 %207 
					                                 f32 %208 = OpLoad %17 
					                        Private f32* %209 = OpAccessChain %144 %19 
					                                 f32 %210 = OpLoad %209 
					                                 f32 %211 = OpFMul %208 %210 
					                                              OpStore %31 %211 
					                                 f32 %212 = OpLoad %31 
					                                 f32 %213 = OpFMul %212 %78 
					                                 f32 %214 = OpFAdd %213 %80 
					                                              OpStore %31 %214 
					                        Private f32* %216 = OpAccessChain %9 %19 
					                                 f32 %217 = OpLoad %216 
					                        Uniform f32* %218 = OpAccessChain %164 %166 
					                                 f32 %219 = OpLoad %218 
					                                 f32 %220 = OpExtInst %1 4 %219 
					                                bool %221 = OpFOrdLessThan %217 %220 
					                                              OpStore %215 %221 
					                                bool %222 = OpLoad %215 
					                                 f32 %223 = OpLoad %31 
					                                 f32 %224 = OpSelect %222 %223 %101 
					                                              OpStore %31 %224 
					                        Private f32* %225 = OpAccessChain %144 %19 
					                                 f32 %226 = OpLoad %225 
					                                 f32 %227 = OpLoad %17 
					                                 f32 %228 = OpFMul %226 %227 
					                                 f32 %229 = OpLoad %31 
					                                 f32 %230 = OpFAdd %228 %229 
					                        Private f32* %231 = OpAccessChain %144 %19 
					                                              OpStore %231 %230 
					                        Private f32* %232 = OpAccessChain %9 %19 
					                                 f32 %233 = OpLoad %232 
					                        Uniform f32* %234 = OpAccessChain %164 %166 
					                                 f32 %235 = OpLoad %234 
					                                 f32 %236 = OpExtInst %1 37 %233 %235 
					                                              OpStore %17 %236 
					                        Private f32* %237 = OpAccessChain %9 %19 
					                                 f32 %238 = OpLoad %237 
					                        Private f32* %239 = OpAccessChain %9 %19 
					                                 f32 %240 = OpLoad %239 
					                                 f32 %241 = OpFAdd %238 %240 
					                        Private f32* %242 = OpAccessChain %9 %19 
					                                              OpStore %242 %241 
					                        Private f32* %243 = OpAccessChain %9 %19 
					                                 f32 %244 = OpLoad %243 
					                        Private f32* %245 = OpAccessChain %9 %19 
					                                 f32 %246 = OpLoad %245 
					                                 f32 %247 = OpFMul %244 %246 
					                        Private f32* %248 = OpAccessChain %9 %19 
					                                              OpStore %248 %247 
					                        Private f32* %249 = OpAccessChain %9 %19 
					                                 f32 %250 = OpLoad %249 
					                        Private f32* %251 = OpAccessChain %9 %19 
					                                 f32 %252 = OpLoad %251 
					                                 f32 %253 = OpFMul %250 %252 
					                        Private f32* %254 = OpAccessChain %9 %19 
					                                              OpStore %254 %253 
					                                 f32 %256 = OpLoad %17 
					                                 f32 %257 = OpLoad %17 
					                                 f32 %258 = OpFNegate %257 
					                                bool %259 = OpFOrdLessThan %256 %258 
					                                              OpStore %255 %259 
					                                bool %260 = OpLoad %255 
					                                              OpSelectionMerge %263 None 
					                                              OpBranchConditional %260 %262 %267 
					                                     %262 = OpLabel 
					                        Private f32* %264 = OpAccessChain %144 %19 
					                                 f32 %265 = OpLoad %264 
					                                 f32 %266 = OpFNegate %265 
					                                              OpStore %261 %266 
					                                              OpBranch %263 
					                                     %267 = OpLabel 
					                        Private f32* %268 = OpAccessChain %144 %19 
					                                 f32 %269 = OpLoad %268 
					                                              OpStore %261 %269 
					                                              OpBranch %263 
					                                     %263 = OpLabel 
					                                 f32 %270 = OpLoad %261 
					                        Private f32* %271 = OpAccessChain %144 %19 
					                                              OpStore %271 %270 
					                        Private f32* %272 = OpAccessChain %144 %19 
					                                 f32 %273 = OpLoad %272 
					                                 f32 %274 = OpFNegate %273 
					                                 f32 %276 = OpFMul %274 %275 
					                                 f32 %277 = OpFAdd %276 %28 
					                        Private f32* %278 = OpAccessChain %45 %23 
					                                              OpStore %278 %277 
					                 read_only Texture2D %282 = OpLoad %281 
					                             sampler %286 = OpLoad %285 
					          read_only Texture2DSampled %288 = OpSampledImage %282 %286 
					                               f32_2 %289 = OpLoad %45 
					                               f32_4 %291 = OpImageSampleImplicitLod %288 %289 
					                               f32_3 %292 = OpVectorShuffle %291 %291 0 1 2 
					                                              OpStore %144 %292 
					                               f32_2 %295 = OpLoad %9 
					                               f32_4 %296 = OpVectorShuffle %295 %295 0 0 0 0 
					                               f32_3 %297 = OpLoad %144 
					                               f32_4 %298 = OpVectorShuffle %297 %297 0 1 2 0 
					                               f32_4 %299 = OpFNegate %298 
					                               f32_4 %300 = OpFMul %296 %299 
					                               f32_3 %301 = OpLoad %144 
					                               f32_4 %302 = OpVectorShuffle %301 %301 0 1 2 0 
					                               f32_4 %303 = OpFAdd %300 %302 
					                                              OpStore %294 %303 
					                                              OpReturn
					                                              OpFunctionEnd"
				}
				SubProgram "d3d11 " {
					Keywords { "QUAD_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "glcore " {
					Keywords { "QUAD_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
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
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
					uniform 	float _SpotHeight;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					bool u_xlatb5;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat4 = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4 = float(1.0) / u_xlat4;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4 = u_xlat4 * u_xlat6;
					    u_xlat6 = u_xlat4 * u_xlat4;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat2 = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat2 = u_xlat4 * u_xlat6 + u_xlat2;
					    u_xlat1.x = u_xlat2 * 0.636620283;
					    u_xlat2 = max(u_xlat0.x, abs(_SpotHeight));
					    u_xlat2 = float(1.0) / u_xlat2;
					    u_xlat4 = min(u_xlat0.x, abs(_SpotHeight));
					    u_xlat2 = u_xlat2 * u_xlat4;
					    u_xlat4 = u_xlat2 * u_xlat2;
					    u_xlat6 = u_xlat4 * 0.0208350997 + -0.0851330012;
					    u_xlat6 = u_xlat4 * u_xlat6 + 0.180141002;
					    u_xlat6 = u_xlat4 * u_xlat6 + -0.330299497;
					    u_xlat4 = u_xlat4 * u_xlat6 + 0.999866009;
					    u_xlat6 = u_xlat4 * u_xlat2;
					    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
					    u_xlatb5 = u_xlat0.x<abs(_SpotHeight);
					    u_xlat6 = u_xlatb5 ? u_xlat6 : float(0.0);
					    u_xlat2 = u_xlat2 * u_xlat4 + u_xlat6;
					    u_xlat4 = min(u_xlat0.x, _SpotHeight);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlatb4 = u_xlat4<(-u_xlat4);
					    u_xlat2 = (u_xlatb4) ? (-u_xlat2) : u_xlat2;
					    u_xlat1.y = (-u_xlat2) * 0.636620283 + 1.0;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    SV_Target0 = u_xlat0.xxxx * (-u_xlat1.xyzx) + u_xlat1.xyzx;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "QUAD_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 94
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Vertex %4 "main" %9 %11 %17 %78 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpDecorate vs_TEXCOORD0 Location 9 
					                                              OpDecorate %11 Location 11 
					                                              OpDecorate %17 Location 17 
					                                              OpDecorate %22 ArrayStride 22 
					                                              OpDecorate %23 ArrayStride 23 
					                                              OpMemberDecorate %24 0 Offset 24 
					                                              OpMemberDecorate %24 1 Offset 24 
					                                              OpDecorate %24 Block 
					                                              OpDecorate %26 DescriptorSet 26 
					                                              OpDecorate %26 Binding 26 
					                                              OpMemberDecorate %76 0 BuiltIn 76 
					                                              OpMemberDecorate %76 1 BuiltIn 76 
					                                              OpMemberDecorate %76 2 BuiltIn 76 
					                                              OpDecorate %76 Block 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 2 
					                                       %8 = OpTypePointer Output %7 
					               Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                      %10 = OpTypePointer Input %7 
					                         Input f32_2* %11 = OpVariable Input 
					                                      %13 = OpTypeVector %6 4 
					                                      %14 = OpTypePointer Private %13 
					                       Private f32_4* %15 = OpVariable Private 
					                                      %16 = OpTypePointer Input %13 
					                         Input f32_4* %17 = OpVariable Input 
					                                      %20 = OpTypeInt 32 0 
					                                  u32 %21 = OpConstant 4 
					                                      %22 = OpTypeArray %13 %21 
					                                      %23 = OpTypeArray %13 %21 
					                                      %24 = OpTypeStruct %22 %23 
					                                      %25 = OpTypePointer Uniform %24 
					Uniform struct {f32_4[4]; f32_4[4];}* %26 = OpVariable Uniform 
					                                      %27 = OpTypeInt 32 1 
					                                  i32 %28 = OpConstant 0 
					                                  i32 %29 = OpConstant 1 
					                                      %30 = OpTypePointer Uniform %13 
					                                  i32 %41 = OpConstant 2 
					                                  i32 %50 = OpConstant 3 
					                       Private f32_4* %54 = OpVariable Private 
					                                  u32 %74 = OpConstant 1 
					                                      %75 = OpTypeArray %6 %74 
					                                      %76 = OpTypeStruct %13 %6 %75 
					                                      %77 = OpTypePointer Output %76 
					 Output struct {f32_4; f32; f32[1];}* %78 = OpVariable Output 
					                                      %86 = OpTypePointer Output %13 
					                                      %88 = OpTypePointer Output %6 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                                f32_2 %12 = OpLoad %11 
					                                              OpStore vs_TEXCOORD0 %12 
					                                f32_4 %18 = OpLoad %17 
					                                f32_4 %19 = OpVectorShuffle %18 %18 1 1 1 1 
					                       Uniform f32_4* %31 = OpAccessChain %26 %28 %29 
					                                f32_4 %32 = OpLoad %31 
					                                f32_4 %33 = OpFMul %19 %32 
					                                              OpStore %15 %33 
					                       Uniform f32_4* %34 = OpAccessChain %26 %28 %28 
					                                f32_4 %35 = OpLoad %34 
					                                f32_4 %36 = OpLoad %17 
					                                f32_4 %37 = OpVectorShuffle %36 %36 0 0 0 0 
					                                f32_4 %38 = OpFMul %35 %37 
					                                f32_4 %39 = OpLoad %15 
					                                f32_4 %40 = OpFAdd %38 %39 
					                                              OpStore %15 %40 
					                       Uniform f32_4* %42 = OpAccessChain %26 %28 %41 
					                                f32_4 %43 = OpLoad %42 
					                                f32_4 %44 = OpLoad %17 
					                                f32_4 %45 = OpVectorShuffle %44 %44 2 2 2 2 
					                                f32_4 %46 = OpFMul %43 %45 
					                                f32_4 %47 = OpLoad %15 
					                                f32_4 %48 = OpFAdd %46 %47 
					                                              OpStore %15 %48 
					                                f32_4 %49 = OpLoad %15 
					                       Uniform f32_4* %51 = OpAccessChain %26 %28 %50 
					                                f32_4 %52 = OpLoad %51 
					                                f32_4 %53 = OpFAdd %49 %52 
					                                              OpStore %15 %53 
					                                f32_4 %55 = OpLoad %15 
					                                f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                       Uniform f32_4* %57 = OpAccessChain %26 %29 %29 
					                                f32_4 %58 = OpLoad %57 
					                                f32_4 %59 = OpFMul %56 %58 
					                                              OpStore %54 %59 
					                       Uniform f32_4* %60 = OpAccessChain %26 %29 %28 
					                                f32_4 %61 = OpLoad %60 
					                                f32_4 %62 = OpLoad %15 
					                                f32_4 %63 = OpVectorShuffle %62 %62 0 0 0 0 
					                                f32_4 %64 = OpFMul %61 %63 
					                                f32_4 %65 = OpLoad %54 
					                                f32_4 %66 = OpFAdd %64 %65 
					                                              OpStore %54 %66 
					                       Uniform f32_4* %67 = OpAccessChain %26 %29 %41 
					                                f32_4 %68 = OpLoad %67 
					                                f32_4 %69 = OpLoad %15 
					                                f32_4 %70 = OpVectorShuffle %69 %69 2 2 2 2 
					                                f32_4 %71 = OpFMul %68 %70 
					                                f32_4 %72 = OpLoad %54 
					                                f32_4 %73 = OpFAdd %71 %72 
					                                              OpStore %54 %73 
					                       Uniform f32_4* %79 = OpAccessChain %26 %29 %50 
					                                f32_4 %80 = OpLoad %79 
					                                f32_4 %81 = OpLoad %15 
					                                f32_4 %82 = OpVectorShuffle %81 %81 3 3 3 3 
					                                f32_4 %83 = OpFMul %80 %82 
					                                f32_4 %84 = OpLoad %54 
					                                f32_4 %85 = OpFAdd %83 %84 
					                        Output f32_4* %87 = OpAccessChain %78 %28 
					                                              OpStore %87 %85 
					                          Output f32* %89 = OpAccessChain %78 %28 %74 
					                                  f32 %90 = OpLoad %89 
					                                  f32 %91 = OpFNegate %90 
					                          Output f32* %92 = OpAccessChain %78 %28 %74 
					                                              OpStore %92 %91 
					                                              OpReturn
					                                              OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 271
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %11 %260 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpDecorate vs_TEXCOORD0 Location 11 
					                                              OpMemberDecorate %129 0 Offset 129 
					                                              OpDecorate %129 Block 
					                                              OpDecorate %131 DescriptorSet 131 
					                                              OpDecorate %131 Binding 131 
					                                              OpDecorate %247 DescriptorSet 247 
					                                              OpDecorate %247 Binding 247 
					                                              OpDecorate %251 DescriptorSet 251 
					                                              OpDecorate %251 Binding 251 
					                                              OpDecorate %260 Location 260 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 2 
					                                       %8 = OpTypePointer Private %7 
					                        Private f32_2* %9 = OpVariable Private 
					                                      %10 = OpTypePointer Input %7 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                  f32 %13 = OpConstant 3,674022E-40 
					                                f32_2 %14 = OpConstantComposite %13 %13 
					                                      %16 = OpTypePointer Private %6 
					                         Private f32* %17 = OpVariable Private 
					                                      %18 = OpTypeInt 32 0 
					                                  u32 %19 = OpConstant 0 
					                                  u32 %23 = OpConstant 1 
					                                  f32 %28 = OpConstant 3,674022E-40 
					                         Private f32* %31 = OpVariable Private 
					                       Private f32_2* %45 = OpVariable Private 
					                                  f32 %47 = OpConstant 3,674022E-40 
					                                  f32 %49 = OpConstant 3,674022E-40 
					                                  f32 %56 = OpConstant 3,674022E-40 
					                                  f32 %63 = OpConstant 3,674022E-40 
					                                  f32 %70 = OpConstant 3,674022E-40 
					                                  f32 %78 = OpConstant 3,674022E-40 
					                                  f32 %80 = OpConstant 3,674022E-40 
					                                      %83 = OpTypeBool 
					                                      %84 = OpTypePointer Private %83 
					                        Private bool* %85 = OpVariable Private 
					                                     %101 = OpTypeVector %6 3 
					                                     %102 = OpTypePointer Private %101 
					                      Private f32_3* %103 = OpVariable Private 
					                                     %105 = OpTypePointer Function %6 
					                                 f32 %112 = OpConstant 3,674022E-40 
					                                 f32 %124 = OpConstant 3,674022E-40 
					                                     %129 = OpTypeStruct %6 
					                                     %130 = OpTypePointer Uniform %129 
					              Uniform struct {f32;}* %131 = OpVariable Uniform 
					                                     %132 = OpTypeInt 32 1 
					                                 i32 %133 = OpConstant 0 
					                                     %134 = OpTypePointer Uniform %6 
					                       Private bool* %182 = OpVariable Private 
					                       Private bool* %222 = OpVariable Private 
					                                     %245 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %246 = OpTypePointer UniformConstant %245 
					UniformConstant read_only Texture2D* %247 = OpVariable UniformConstant 
					                                     %249 = OpTypeSampler 
					                                     %250 = OpTypePointer UniformConstant %249 
					            UniformConstant sampler* %251 = OpVariable UniformConstant 
					                                     %253 = OpTypeSampledImage %245 
					                                     %256 = OpTypeVector %6 4 
					                                     %259 = OpTypePointer Output %256 
					                       Output f32_4* %260 = OpVariable Output 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                       Function f32* %106 = OpVariable Function 
					                       Function f32* %228 = OpVariable Function 
					                                f32_2 %12 = OpLoad vs_TEXCOORD0 
					                                f32_2 %15 = OpFAdd %12 %14 
					                                              OpStore %9 %15 
					                         Private f32* %20 = OpAccessChain %9 %19 
					                                  f32 %21 = OpLoad %20 
					                                  f32 %22 = OpExtInst %1 4 %21 
					                         Private f32* %24 = OpAccessChain %9 %23 
					                                  f32 %25 = OpLoad %24 
					                                  f32 %26 = OpExtInst %1 4 %25 
					                                  f32 %27 = OpExtInst %1 40 %22 %26 
					                                              OpStore %17 %27 
					                                  f32 %29 = OpLoad %17 
					                                  f32 %30 = OpFDiv %28 %29 
					                                              OpStore %17 %30 
					                         Private f32* %32 = OpAccessChain %9 %19 
					                                  f32 %33 = OpLoad %32 
					                                  f32 %34 = OpExtInst %1 4 %33 
					                         Private f32* %35 = OpAccessChain %9 %23 
					                                  f32 %36 = OpLoad %35 
					                                  f32 %37 = OpExtInst %1 4 %36 
					                                  f32 %38 = OpExtInst %1 37 %34 %37 
					                                              OpStore %31 %38 
					                                  f32 %39 = OpLoad %17 
					                                  f32 %40 = OpLoad %31 
					                                  f32 %41 = OpFMul %39 %40 
					                                              OpStore %17 %41 
					                                  f32 %42 = OpLoad %17 
					                                  f32 %43 = OpLoad %17 
					                                  f32 %44 = OpFMul %42 %43 
					                                              OpStore %31 %44 
					                                  f32 %46 = OpLoad %31 
					                                  f32 %48 = OpFMul %46 %47 
					                                  f32 %50 = OpFAdd %48 %49 
					                         Private f32* %51 = OpAccessChain %45 %19 
					                                              OpStore %51 %50 
					                                  f32 %52 = OpLoad %31 
					                         Private f32* %53 = OpAccessChain %45 %19 
					                                  f32 %54 = OpLoad %53 
					                                  f32 %55 = OpFMul %52 %54 
					                                  f32 %57 = OpFAdd %55 %56 
					                         Private f32* %58 = OpAccessChain %45 %19 
					                                              OpStore %58 %57 
					                                  f32 %59 = OpLoad %31 
					                         Private f32* %60 = OpAccessChain %45 %19 
					                                  f32 %61 = OpLoad %60 
					                                  f32 %62 = OpFMul %59 %61 
					                                  f32 %64 = OpFAdd %62 %63 
					                         Private f32* %65 = OpAccessChain %45 %19 
					                                              OpStore %65 %64 
					                                  f32 %66 = OpLoad %31 
					                         Private f32* %67 = OpAccessChain %45 %19 
					                                  f32 %68 = OpLoad %67 
					                                  f32 %69 = OpFMul %66 %68 
					                                  f32 %71 = OpFAdd %69 %70 
					                                              OpStore %31 %71 
					                                  f32 %72 = OpLoad %31 
					                                  f32 %73 = OpLoad %17 
					                                  f32 %74 = OpFMul %72 %73 
					                         Private f32* %75 = OpAccessChain %45 %19 
					                                              OpStore %75 %74 
					                         Private f32* %76 = OpAccessChain %45 %19 
					                                  f32 %77 = OpLoad %76 
					                                  f32 %79 = OpFMul %77 %78 
					                                  f32 %81 = OpFAdd %79 %80 
					                         Private f32* %82 = OpAccessChain %45 %19 
					                                              OpStore %82 %81 
					                         Private f32* %86 = OpAccessChain %9 %19 
					                                  f32 %87 = OpLoad %86 
					                                  f32 %88 = OpExtInst %1 4 %87 
					                         Private f32* %89 = OpAccessChain %9 %23 
					                                  f32 %90 = OpLoad %89 
					                                  f32 %91 = OpExtInst %1 4 %90 
					                                 bool %92 = OpFOrdLessThan %88 %91 
					                                              OpStore %85 %92 
					                                f32_2 %93 = OpLoad %9 
					                                f32_2 %94 = OpLoad %9 
					                                  f32 %95 = OpDot %93 %94 
					                         Private f32* %96 = OpAccessChain %9 %19 
					                                              OpStore %96 %95 
					                         Private f32* %97 = OpAccessChain %9 %19 
					                                  f32 %98 = OpLoad %97 
					                                  f32 %99 = OpExtInst %1 31 %98 
					                        Private f32* %100 = OpAccessChain %9 %19 
					                                              OpStore %100 %99 
					                                bool %104 = OpLoad %85 
					                                              OpSelectionMerge %108 None 
					                                              OpBranchConditional %104 %107 %111 
					                                     %107 = OpLabel 
					                        Private f32* %109 = OpAccessChain %45 %19 
					                                 f32 %110 = OpLoad %109 
					                                              OpStore %106 %110 
					                                              OpBranch %108 
					                                     %111 = OpLabel 
					                                              OpStore %106 %112 
					                                              OpBranch %108 
					                                     %108 = OpLabel 
					                                 f32 %113 = OpLoad %106 
					                        Private f32* %114 = OpAccessChain %103 %19 
					                                              OpStore %114 %113 
					                                 f32 %115 = OpLoad %17 
					                                 f32 %116 = OpLoad %31 
					                                 f32 %117 = OpFMul %115 %116 
					                        Private f32* %118 = OpAccessChain %103 %19 
					                                 f32 %119 = OpLoad %118 
					                                 f32 %120 = OpFAdd %117 %119 
					                        Private f32* %121 = OpAccessChain %103 %19 
					                                              OpStore %121 %120 
					                        Private f32* %122 = OpAccessChain %103 %19 
					                                 f32 %123 = OpLoad %122 
					                                 f32 %125 = OpFMul %123 %124 
					                        Private f32* %126 = OpAccessChain %45 %19 
					                                              OpStore %126 %125 
					                        Private f32* %127 = OpAccessChain %9 %19 
					                                 f32 %128 = OpLoad %127 
					                        Uniform f32* %135 = OpAccessChain %131 %133 
					                                 f32 %136 = OpLoad %135 
					                                 f32 %137 = OpExtInst %1 4 %136 
					                                 f32 %138 = OpExtInst %1 40 %128 %137 
					                        Private f32* %139 = OpAccessChain %103 %19 
					                                              OpStore %139 %138 
					                        Private f32* %140 = OpAccessChain %103 %19 
					                                 f32 %141 = OpLoad %140 
					                                 f32 %142 = OpFDiv %28 %141 
					                        Private f32* %143 = OpAccessChain %103 %19 
					                                              OpStore %143 %142 
					                        Private f32* %144 = OpAccessChain %9 %19 
					                                 f32 %145 = OpLoad %144 
					                        Uniform f32* %146 = OpAccessChain %131 %133 
					                                 f32 %147 = OpLoad %146 
					                                 f32 %148 = OpExtInst %1 4 %147 
					                                 f32 %149 = OpExtInst %1 37 %145 %148 
					                                              OpStore %17 %149 
					                        Private f32* %150 = OpAccessChain %103 %19 
					                                 f32 %151 = OpLoad %150 
					                                 f32 %152 = OpLoad %17 
					                                 f32 %153 = OpFMul %151 %152 
					                        Private f32* %154 = OpAccessChain %103 %19 
					                                              OpStore %154 %153 
					                        Private f32* %155 = OpAccessChain %103 %19 
					                                 f32 %156 = OpLoad %155 
					                        Private f32* %157 = OpAccessChain %103 %19 
					                                 f32 %158 = OpLoad %157 
					                                 f32 %159 = OpFMul %156 %158 
					                                              OpStore %17 %159 
					                                 f32 %160 = OpLoad %17 
					                                 f32 %161 = OpFMul %160 %47 
					                                 f32 %162 = OpFAdd %161 %49 
					                                              OpStore %31 %162 
					                                 f32 %163 = OpLoad %17 
					                                 f32 %164 = OpLoad %31 
					                                 f32 %165 = OpFMul %163 %164 
					                                 f32 %166 = OpFAdd %165 %56 
					                                              OpStore %31 %166 
					                                 f32 %167 = OpLoad %17 
					                                 f32 %168 = OpLoad %31 
					                                 f32 %169 = OpFMul %167 %168 
					                                 f32 %170 = OpFAdd %169 %63 
					                                              OpStore %31 %170 
					                                 f32 %171 = OpLoad %17 
					                                 f32 %172 = OpLoad %31 
					                                 f32 %173 = OpFMul %171 %172 
					                                 f32 %174 = OpFAdd %173 %70 
					                                              OpStore %17 %174 
					                                 f32 %175 = OpLoad %17 
					                        Private f32* %176 = OpAccessChain %103 %19 
					                                 f32 %177 = OpLoad %176 
					                                 f32 %178 = OpFMul %175 %177 
					                                              OpStore %31 %178 
					                                 f32 %179 = OpLoad %31 
					                                 f32 %180 = OpFMul %179 %78 
					                                 f32 %181 = OpFAdd %180 %80 
					                                              OpStore %31 %181 
					                        Private f32* %183 = OpAccessChain %9 %19 
					                                 f32 %184 = OpLoad %183 
					                        Uniform f32* %185 = OpAccessChain %131 %133 
					                                 f32 %186 = OpLoad %185 
					                                 f32 %187 = OpExtInst %1 4 %186 
					                                bool %188 = OpFOrdLessThan %184 %187 
					                                              OpStore %182 %188 
					                                bool %189 = OpLoad %182 
					                                 f32 %190 = OpLoad %31 
					                                 f32 %191 = OpSelect %189 %190 %112 
					                                              OpStore %31 %191 
					                        Private f32* %192 = OpAccessChain %103 %19 
					                                 f32 %193 = OpLoad %192 
					                                 f32 %194 = OpLoad %17 
					                                 f32 %195 = OpFMul %193 %194 
					                                 f32 %196 = OpLoad %31 
					                                 f32 %197 = OpFAdd %195 %196 
					                        Private f32* %198 = OpAccessChain %103 %19 
					                                              OpStore %198 %197 
					                        Private f32* %199 = OpAccessChain %9 %19 
					                                 f32 %200 = OpLoad %199 
					                        Uniform f32* %201 = OpAccessChain %131 %133 
					                                 f32 %202 = OpLoad %201 
					                                 f32 %203 = OpExtInst %1 37 %200 %202 
					                                              OpStore %17 %203 
					                        Private f32* %204 = OpAccessChain %9 %19 
					                                 f32 %205 = OpLoad %204 
					                        Private f32* %206 = OpAccessChain %9 %19 
					                                 f32 %207 = OpLoad %206 
					                                 f32 %208 = OpFAdd %205 %207 
					                        Private f32* %209 = OpAccessChain %9 %19 
					                                              OpStore %209 %208 
					                        Private f32* %210 = OpAccessChain %9 %19 
					                                 f32 %211 = OpLoad %210 
					                        Private f32* %212 = OpAccessChain %9 %19 
					                                 f32 %213 = OpLoad %212 
					                                 f32 %214 = OpFMul %211 %213 
					                        Private f32* %215 = OpAccessChain %9 %19 
					                                              OpStore %215 %214 
					                        Private f32* %216 = OpAccessChain %9 %19 
					                                 f32 %217 = OpLoad %216 
					                        Private f32* %218 = OpAccessChain %9 %19 
					                                 f32 %219 = OpLoad %218 
					                                 f32 %220 = OpFMul %217 %219 
					                        Private f32* %221 = OpAccessChain %9 %19 
					                                              OpStore %221 %220 
					                                 f32 %223 = OpLoad %17 
					                                 f32 %224 = OpLoad %17 
					                                 f32 %225 = OpFNegate %224 
					                                bool %226 = OpFOrdLessThan %223 %225 
					                                              OpStore %222 %226 
					                                bool %227 = OpLoad %222 
					                                              OpSelectionMerge %230 None 
					                                              OpBranchConditional %227 %229 %234 
					                                     %229 = OpLabel 
					                        Private f32* %231 = OpAccessChain %103 %19 
					                                 f32 %232 = OpLoad %231 
					                                 f32 %233 = OpFNegate %232 
					                                              OpStore %228 %233 
					                                              OpBranch %230 
					                                     %234 = OpLabel 
					                        Private f32* %235 = OpAccessChain %103 %19 
					                                 f32 %236 = OpLoad %235 
					                                              OpStore %228 %236 
					                                              OpBranch %230 
					                                     %230 = OpLabel 
					                                 f32 %237 = OpLoad %228 
					                        Private f32* %238 = OpAccessChain %103 %19 
					                                              OpStore %238 %237 
					                        Private f32* %239 = OpAccessChain %103 %19 
					                                 f32 %240 = OpLoad %239 
					                                 f32 %241 = OpFNegate %240 
					                                 f32 %242 = OpFMul %241 %124 
					                                 f32 %243 = OpFAdd %242 %28 
					                        Private f32* %244 = OpAccessChain %45 %23 
					                                              OpStore %244 %243 
					                 read_only Texture2D %248 = OpLoad %247 
					                             sampler %252 = OpLoad %251 
					          read_only Texture2DSampled %254 = OpSampledImage %248 %252 
					                               f32_2 %255 = OpLoad %45 
					                               f32_4 %257 = OpImageSampleImplicitLod %254 %255 
					                               f32_3 %258 = OpVectorShuffle %257 %257 0 1 2 
					                                              OpStore %103 %258 
					                               f32_2 %261 = OpLoad %9 
					                               f32_4 %262 = OpVectorShuffle %261 %261 0 0 0 0 
					                               f32_3 %263 = OpLoad %103 
					                               f32_4 %264 = OpVectorShuffle %263 %263 0 1 2 0 
					                               f32_4 %265 = OpFNegate %264 
					                               f32_4 %266 = OpFMul %262 %265 
					                               f32_3 %267 = OpLoad %103 
					                               f32_4 %268 = OpVectorShuffle %267 %267 0 1 2 0 
					                               f32_4 %269 = OpFAdd %266 %268 
					                                              OpStore %260 %269 
					                                              OpReturn
					                                              OpFunctionEnd"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "FULL_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
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
						vec4 unused_0_0[2];
						float _SpotHeight;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					bool u_xlatb2;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					bool u_xlatb5;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat4 = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4 = float(1.0) / u_xlat4;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4 = u_xlat4 * u_xlat6;
					    u_xlat6 = u_xlat4 * u_xlat4;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4 = u_xlat4 * u_xlat6 + u_xlat1.x;
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4 = u_xlat6 + u_xlat4;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
					    u_xlatb2 = u_xlatb2 && u_xlatb6;
					    u_xlat2 = (u_xlatb2) ? (-u_xlat4) : u_xlat4;
					    u_xlat2 = u_xlat2 + 3.14159012;
					    u_xlat1.x = u_xlat2 * 0.159155071;
					    u_xlat2 = max(u_xlat0.x, abs(_SpotHeight));
					    u_xlat2 = float(1.0) / u_xlat2;
					    u_xlat4 = min(u_xlat0.x, abs(_SpotHeight));
					    u_xlat2 = u_xlat2 * u_xlat4;
					    u_xlat4 = u_xlat2 * u_xlat2;
					    u_xlat6 = u_xlat4 * 0.0208350997 + -0.0851330012;
					    u_xlat6 = u_xlat4 * u_xlat6 + 0.180141002;
					    u_xlat6 = u_xlat4 * u_xlat6 + -0.330299497;
					    u_xlat4 = u_xlat4 * u_xlat6 + 0.999866009;
					    u_xlat6 = u_xlat4 * u_xlat2;
					    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
					    u_xlatb5 = u_xlat0.x<abs(_SpotHeight);
					    u_xlat6 = u_xlatb5 ? u_xlat6 : float(0.0);
					    u_xlat2 = u_xlat2 * u_xlat4 + u_xlat6;
					    u_xlat4 = min(u_xlat0.x, _SpotHeight);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlatb4 = u_xlat4<(-u_xlat4);
					    u_xlat2 = (u_xlatb4) ? (-u_xlat2) : u_xlat2;
					    u_xlat1.y = (-u_xlat2) * 0.636620283 + 1.0;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    SV_Target0 = u_xlat0.xxxx * (-u_xlat1.xyzx) + u_xlat1.xyzx;
					    return;
					}"
				}
				SubProgram "glcore " {
					Keywords { "FULL_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
					"!!GL3x"
				}
				SubProgram "vulkan " {
					Keywords { "FULL_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
					"spirv"
				}
				SubProgram "d3d11 " {
					Keywords { "HALF_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
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
						vec4 unused_0_0[2];
						float _SpotHeight;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					bool u_xlatb2;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					bool u_xlatb5;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat4 = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4 = float(1.0) / u_xlat4;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4 = u_xlat4 * u_xlat6;
					    u_xlat6 = u_xlat4 * u_xlat4;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4 = u_xlat4 * u_xlat6 + u_xlat1.x;
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4 = u_xlat6 + u_xlat4;
					    u_xlat6 = min(u_xlat0.x, abs(u_xlat0.y));
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlatb2 = u_xlat6<(-u_xlat6);
					    u_xlat2 = (u_xlatb2) ? (-u_xlat4) : u_xlat4;
					    u_xlat1.x = u_xlat2 * 0.318310142;
					    u_xlat2 = max(u_xlat0.x, abs(_SpotHeight));
					    u_xlat2 = float(1.0) / u_xlat2;
					    u_xlat4 = min(u_xlat0.x, abs(_SpotHeight));
					    u_xlat2 = u_xlat2 * u_xlat4;
					    u_xlat4 = u_xlat2 * u_xlat2;
					    u_xlat6 = u_xlat4 * 0.0208350997 + -0.0851330012;
					    u_xlat6 = u_xlat4 * u_xlat6 + 0.180141002;
					    u_xlat6 = u_xlat4 * u_xlat6 + -0.330299497;
					    u_xlat4 = u_xlat4 * u_xlat6 + 0.999866009;
					    u_xlat6 = u_xlat4 * u_xlat2;
					    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
					    u_xlatb5 = u_xlat0.x<abs(_SpotHeight);
					    u_xlat6 = u_xlatb5 ? u_xlat6 : float(0.0);
					    u_xlat2 = u_xlat2 * u_xlat4 + u_xlat6;
					    u_xlat4 = min(u_xlat0.x, _SpotHeight);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlatb4 = u_xlat4<(-u_xlat4);
					    u_xlat2 = (u_xlatb4) ? (-u_xlat2) : u_xlat2;
					    u_xlat1.y = (-u_xlat2) * 0.636620283 + 1.0;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    SV_Target0 = u_xlat0.xxxx * (-u_xlat1.xyzx) + u_xlat1.xyzx;
					    return;
					}"
				}
				SubProgram "glcore " {
					Keywords { "HALF_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
					"!!GL3x"
				}
				SubProgram "vulkan " {
					Keywords { "HALF_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
					"spirv"
				}
				SubProgram "d3d11 " {
					Keywords { "QUAD_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
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
						vec4 unused_0_0[2];
						float _SpotHeight;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					bool u_xlatb5;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat4 = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4 = float(1.0) / u_xlat4;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4 = u_xlat4 * u_xlat6;
					    u_xlat6 = u_xlat4 * u_xlat4;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat2 = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat2 = u_xlat4 * u_xlat6 + u_xlat2;
					    u_xlat1.x = u_xlat2 * 0.636620283;
					    u_xlat2 = max(u_xlat0.x, abs(_SpotHeight));
					    u_xlat2 = float(1.0) / u_xlat2;
					    u_xlat4 = min(u_xlat0.x, abs(_SpotHeight));
					    u_xlat2 = u_xlat2 * u_xlat4;
					    u_xlat4 = u_xlat2 * u_xlat2;
					    u_xlat6 = u_xlat4 * 0.0208350997 + -0.0851330012;
					    u_xlat6 = u_xlat4 * u_xlat6 + 0.180141002;
					    u_xlat6 = u_xlat4 * u_xlat6 + -0.330299497;
					    u_xlat4 = u_xlat4 * u_xlat6 + 0.999866009;
					    u_xlat6 = u_xlat4 * u_xlat2;
					    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
					    u_xlatb5 = u_xlat0.x<abs(_SpotHeight);
					    u_xlat6 = u_xlatb5 ? u_xlat6 : float(0.0);
					    u_xlat2 = u_xlat2 * u_xlat4 + u_xlat6;
					    u_xlat4 = min(u_xlat0.x, _SpotHeight);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlatb4 = u_xlat4<(-u_xlat4);
					    u_xlat2 = (u_xlatb4) ? (-u_xlat2) : u_xlat2;
					    u_xlat1.y = (-u_xlat2) * 0.636620283 + 1.0;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    SV_Target0 = u_xlat0.xxxx * (-u_xlat1.xyzx) + u_xlat1.xyzx;
					    return;
					}"
				}
				SubProgram "glcore " {
					Keywords { "QUAD_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
					"!!GL3x"
				}
				SubProgram "vulkan " {
					Keywords { "QUAD_HORIZONTAL" "TOP_VERTICAL" "VIGNETTE" }
					"spirv"
				}
			}
		}
	}
}