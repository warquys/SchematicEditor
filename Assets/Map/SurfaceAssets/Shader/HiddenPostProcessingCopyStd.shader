Shader "Hidden/PostProcessing/CopyStd" {
	Properties {
		_MainTex ("", 2D) = "white" {}
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 9122
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
						vec4 _MainTex_ST;
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
					uniform 	vec4 _MainTex_ST;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 150
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_shader_bit_encoding
					#extension GL_ARB_shader_bit_encoding : enable
					#endif
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 66
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %17 %40 %46 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %17 Location 17 
					                                             OpDecorate %40 Location 40 
					                                             OpDecorate vs_TEXCOORD0 Location 46 
					                                             OpMemberDecorate %48 0 Offset 48 
					                                             OpDecorate %48 Block 
					                                             OpDecorate %50 DescriptorSet 50 
					                                             OpDecorate %50 Binding 50 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypeInt 32 0 
					                                  u32 %9 = OpConstant 1 
					                                     %10 = OpTypeArray %6 %9 
					                                     %11 = OpTypeStruct %7 %6 %10 
					                                     %12 = OpTypePointer Output %11 
					Output struct {f32_4; f32; f32[1];}* %13 = OpVariable Output 
					                                     %14 = OpTypeInt 32 1 
					                                 i32 %15 = OpConstant 0 
					                                     %16 = OpTypePointer Input %7 
					                        Input f32_4* %17 = OpVariable Input 
					                                     %18 = OpTypeVector %6 2 
					                                 f32 %21 = OpConstant 3,674022E-40 
					                               f32_2 %22 = OpConstantComposite %21 %21 
					                                 f32 %24 = OpConstant 3,674022E-40 
					                               f32_2 %25 = OpConstantComposite %24 %24 
					                                     %27 = OpTypePointer Output %7 
					                                 f32 %31 = OpConstant 3,674022E-40 
					                                 f32 %32 = OpConstant 3,674022E-40 
					                               f32_2 %33 = OpConstantComposite %31 %32 
					                                     %37 = OpTypePointer Private %18 
					                      Private f32_2* %38 = OpVariable Private 
					                                     %39 = OpTypePointer Input %18 
					                        Input f32_2* %40 = OpVariable Input 
					                               f32_2 %42 = OpConstantComposite %32 %24 
					                                     %45 = OpTypePointer Output %18 
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                     %48 = OpTypeStruct %7 
					                                     %49 = OpTypePointer Uniform %48 
					            Uniform struct {f32_4;}* %50 = OpVariable Uniform 
					                                     %51 = OpTypePointer Uniform %7 
					                                     %60 = OpTypePointer Output %6 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                               f32_4 %19 = OpLoad %17 
					                               f32_2 %20 = OpVectorShuffle %19 %19 0 1 
					                               f32_2 %23 = OpFMul %20 %22 
					                               f32_2 %26 = OpFAdd %23 %25 
					                       Output f32_4* %28 = OpAccessChain %13 %15 
					                               f32_4 %29 = OpLoad %28 
					                               f32_4 %30 = OpVectorShuffle %29 %26 4 5 2 3 
					                                             OpStore %28 %30 
					                       Output f32_4* %34 = OpAccessChain %13 %15 
					                               f32_4 %35 = OpLoad %34 
					                               f32_4 %36 = OpVectorShuffle %35 %33 0 1 4 5 
					                                             OpStore %34 %36 
					                               f32_2 %41 = OpLoad %40 
					                               f32_2 %43 = OpFMul %41 %42 
					                               f32_2 %44 = OpFAdd %43 %33 
					                                             OpStore %38 %44 
					                               f32_2 %47 = OpLoad %38 
					                      Uniform f32_4* %52 = OpAccessChain %50 %15 
					                               f32_4 %53 = OpLoad %52 
					                               f32_2 %54 = OpVectorShuffle %53 %53 0 1 
					                               f32_2 %55 = OpFMul %47 %54 
					                      Uniform f32_4* %56 = OpAccessChain %50 %15 
					                               f32_4 %57 = OpLoad %56 
					                               f32_2 %58 = OpVectorShuffle %57 %57 2 3 
					                               f32_2 %59 = OpFAdd %55 %58 
					                                             OpStore vs_TEXCOORD0 %59 
					                         Output f32* %61 = OpAccessChain %13 %15 %9 
					                                 f32 %62 = OpLoad %61 
					                                 f32 %63 = OpFNegate %62 
					                         Output f32* %64 = OpAccessChain %13 %15 %9 
					                                             OpStore %64 %63 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 26
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %9 %22 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %9 Location 9 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Output %7 
					                        Output f32_4* %9 = OpVariable Output 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                             OpStore %9 %24 
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
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = texture(_MainTex, vs_TEXCOORD0.xy);
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
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 81398
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
						vec4 _MainTex_ST;
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
					uniform 	vec4 _MainTex_ST;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 150
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_shader_bit_encoding
					#extension GL_ARB_shader_bit_encoding : enable
					#endif
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec4 u_xlati1;
					bvec4 u_xlatb1;
					bvec4 u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb1 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlatb2 = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0);
					    u_xlati1 = ivec4((uvec4(u_xlatb1) * 0xffffffffu) | (uvec4(u_xlatb2) * 0xffffffffu));
					    u_xlatb2 = equal(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlati1 = ivec4(uvec4(u_xlati1) | (uvec4(u_xlatb2) * 0xffffffffu));
					    u_xlatb1 = equal(u_xlati1, ivec4(0, 0, 0, 0));
					    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
					    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
					    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
					    SV_Target0 = (u_xlatb1.x) ? vec4(0.0, 0.0, 0.0, 0.0) : u_xlat0;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 66
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %17 %40 %46 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %17 Location 17 
					                                             OpDecorate %40 Location 40 
					                                             OpDecorate vs_TEXCOORD0 Location 46 
					                                             OpMemberDecorate %48 0 Offset 48 
					                                             OpDecorate %48 Block 
					                                             OpDecorate %50 DescriptorSet 50 
					                                             OpDecorate %50 Binding 50 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypeInt 32 0 
					                                  u32 %9 = OpConstant 1 
					                                     %10 = OpTypeArray %6 %9 
					                                     %11 = OpTypeStruct %7 %6 %10 
					                                     %12 = OpTypePointer Output %11 
					Output struct {f32_4; f32; f32[1];}* %13 = OpVariable Output 
					                                     %14 = OpTypeInt 32 1 
					                                 i32 %15 = OpConstant 0 
					                                     %16 = OpTypePointer Input %7 
					                        Input f32_4* %17 = OpVariable Input 
					                                     %18 = OpTypeVector %6 2 
					                                 f32 %21 = OpConstant 3,674022E-40 
					                               f32_2 %22 = OpConstantComposite %21 %21 
					                                 f32 %24 = OpConstant 3,674022E-40 
					                               f32_2 %25 = OpConstantComposite %24 %24 
					                                     %27 = OpTypePointer Output %7 
					                                 f32 %31 = OpConstant 3,674022E-40 
					                                 f32 %32 = OpConstant 3,674022E-40 
					                               f32_2 %33 = OpConstantComposite %31 %32 
					                                     %37 = OpTypePointer Private %18 
					                      Private f32_2* %38 = OpVariable Private 
					                                     %39 = OpTypePointer Input %18 
					                        Input f32_2* %40 = OpVariable Input 
					                               f32_2 %42 = OpConstantComposite %32 %24 
					                                     %45 = OpTypePointer Output %18 
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                     %48 = OpTypeStruct %7 
					                                     %49 = OpTypePointer Uniform %48 
					            Uniform struct {f32_4;}* %50 = OpVariable Uniform 
					                                     %51 = OpTypePointer Uniform %7 
					                                     %60 = OpTypePointer Output %6 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                               f32_4 %19 = OpLoad %17 
					                               f32_2 %20 = OpVectorShuffle %19 %19 0 1 
					                               f32_2 %23 = OpFMul %20 %22 
					                               f32_2 %26 = OpFAdd %23 %25 
					                       Output f32_4* %28 = OpAccessChain %13 %15 
					                               f32_4 %29 = OpLoad %28 
					                               f32_4 %30 = OpVectorShuffle %29 %26 4 5 2 3 
					                                             OpStore %28 %30 
					                       Output f32_4* %34 = OpAccessChain %13 %15 
					                               f32_4 %35 = OpLoad %34 
					                               f32_4 %36 = OpVectorShuffle %35 %33 0 1 4 5 
					                                             OpStore %34 %36 
					                               f32_2 %41 = OpLoad %40 
					                               f32_2 %43 = OpFMul %41 %42 
					                               f32_2 %44 = OpFAdd %43 %33 
					                                             OpStore %38 %44 
					                               f32_2 %47 = OpLoad %38 
					                      Uniform f32_4* %52 = OpAccessChain %50 %15 
					                               f32_4 %53 = OpLoad %52 
					                               f32_2 %54 = OpVectorShuffle %53 %53 0 1 
					                               f32_2 %55 = OpFMul %47 %54 
					                      Uniform f32_4* %56 = OpAccessChain %50 %15 
					                               f32_4 %57 = OpLoad %56 
					                               f32_2 %58 = OpVectorShuffle %57 %57 2 3 
					                               f32_2 %59 = OpFAdd %55 %58 
					                                             OpStore vs_TEXCOORD0 %59 
					                         Output f32* %61 = OpAccessChain %13 %15 %9 
					                                 f32 %62 = OpLoad %61 
					                                 f32 %63 = OpFNegate %62 
					                         Output f32* %64 = OpAccessChain %13 %15 %9 
					                                             OpStore %64 %63 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 100
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %93 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %93 Location 93 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %25 = OpTypeBool 
					                                     %26 = OpTypeVector %25 4 
					                                     %27 = OpTypePointer Private %26 
					                     Private bool_4* %28 = OpVariable Private 
					                                 f32 %30 = OpConstant 3,674022E-40 
					                               f32_4 %31 = OpConstantComposite %30 %30 %30 %30 
					                     Private bool_4* %33 = OpVariable Private 
					                                     %36 = OpTypeInt 32 1 
					                                     %37 = OpTypeVector %36 4 
					                                     %38 = OpTypePointer Private %37 
					                      Private i32_4* %39 = OpVariable Private 
					                                     %41 = OpTypeInt 32 0 
					                                     %42 = OpTypeVector %41 4 
					                                 u32 %43 = OpConstant 0 
					                                 u32 %44 = OpConstant 1 
					                               u32_4 %45 = OpConstantComposite %43 %43 %43 %43 
					                               u32_4 %46 = OpConstantComposite %44 %44 %44 %44 
					                                 u32 %48 = OpConstant 4294967295 
					                                 i32 %68 = OpConstant 0 
					                               i32_4 %69 = OpConstantComposite %68 %68 %68 %68 
					                                     %71 = OpTypePointer Private %25 
					                                 u32 %78 = OpConstant 2 
					                                 u32 %85 = OpConstant 3 
					                                     %92 = OpTypePointer Output %7 
					                       Output f32_4* %93 = OpVariable Output 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                             OpStore %9 %24 
					                               f32_4 %29 = OpLoad %9 
					                              bool_4 %32 = OpFOrdLessThan %29 %31 
					                                             OpStore %28 %32 
					                               f32_4 %34 = OpLoad %9 
					                              bool_4 %35 = OpFOrdLessThan %31 %34 
					                                             OpStore %33 %35 
					                              bool_4 %40 = OpLoad %28 
					                               u32_4 %47 = OpSelect %40 %46 %45 
					                               u32_4 %49 = OpCompositeConstruct %48 %48 %48 %48 
					                               u32_4 %50 = OpIMul %47 %49 
					                              bool_4 %51 = OpLoad %33 
					                               u32_4 %52 = OpSelect %51 %46 %45 
					                               u32_4 %53 = OpCompositeConstruct %48 %48 %48 %48 
					                               u32_4 %54 = OpIMul %52 %53 
					                               u32_4 %55 = OpBitwiseOr %50 %54 
					                               i32_4 %56 = OpBitcast %55 
					                                             OpStore %39 %56 
					                               f32_4 %57 = OpLoad %9 
					                              bool_4 %58 = OpFOrdEqual %57 %31 
					                                             OpStore %33 %58 
					                               i32_4 %59 = OpLoad %39 
					                               u32_4 %60 = OpBitcast %59 
					                              bool_4 %61 = OpLoad %33 
					                               u32_4 %62 = OpSelect %61 %46 %45 
					                               u32_4 %63 = OpCompositeConstruct %48 %48 %48 %48 
					                               u32_4 %64 = OpIMul %62 %63 
					                               u32_4 %65 = OpBitwiseOr %60 %64 
					                               i32_4 %66 = OpBitcast %65 
					                                             OpStore %39 %66 
					                               i32_4 %67 = OpLoad %39 
					                              bool_4 %70 = OpIEqual %67 %69 
					                                             OpStore %28 %70 
					                       Private bool* %72 = OpAccessChain %28 %44 
					                                bool %73 = OpLoad %72 
					                       Private bool* %74 = OpAccessChain %28 %43 
					                                bool %75 = OpLoad %74 
					                                bool %76 = OpLogicalOr %73 %75 
					                       Private bool* %77 = OpAccessChain %28 %43 
					                                             OpStore %77 %76 
					                       Private bool* %79 = OpAccessChain %28 %78 
					                                bool %80 = OpLoad %79 
					                       Private bool* %81 = OpAccessChain %28 %43 
					                                bool %82 = OpLoad %81 
					                                bool %83 = OpLogicalOr %80 %82 
					                       Private bool* %84 = OpAccessChain %28 %43 
					                                             OpStore %84 %83 
					                       Private bool* %86 = OpAccessChain %28 %85 
					                                bool %87 = OpLoad %86 
					                       Private bool* %88 = OpAccessChain %28 %43 
					                                bool %89 = OpLoad %88 
					                                bool %90 = OpLogicalOr %87 %89 
					                       Private bool* %91 = OpAccessChain %28 %43 
					                                             OpStore %91 %90 
					                       Private bool* %94 = OpAccessChain %28 %43 
					                                bool %95 = OpLoad %94 
					                               f32_4 %96 = OpLoad %9 
					                              bool_4 %97 = OpCompositeConstruct %95 %95 %95 %95 
					                               f32_4 %98 = OpSelect %97 %31 %96 
					                                             OpStore %93 %98 
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
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec4 u_xlati1;
					bvec4 u_xlatb1;
					bvec4 u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb1 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlatb2 = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0);
					    u_xlati1 = ivec4((uvec4(u_xlatb1) * 0xffffffffu) | (uvec4(u_xlatb2) * 0xffffffffu));
					    u_xlatb2 = equal(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlati1 = ivec4(uvec4(u_xlati1) | (uvec4(u_xlatb2) * 0xffffffffu));
					    u_xlatb1 = equal(u_xlati1, ivec4(0, 0, 0, 0));
					    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
					    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
					    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
					    SV_Target0 = (u_xlatb1.x) ? vec4(0.0, 0.0, 0.0, 0.0) : u_xlat0;
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