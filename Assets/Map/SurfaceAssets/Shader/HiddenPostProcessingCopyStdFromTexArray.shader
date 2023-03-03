Shader "Hidden/PostProcessing/CopyStdFromTexArray" {
	Properties {
		_MainTex ("", 2DArray) = "white" {}
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 25054
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
						float _DepthSlice;
					};
					in  vec3 in_POSITION0;
					out vec3 vs_TEXCOORD0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
					    vs_TEXCOORD0.z = _DepthSlice;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!GL3x
					#ifdef VERTEX
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					
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
					uniform 	float _DepthSlice;
					in  vec3 in_POSITION0;
					out vec3 vs_TEXCOORD0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    vs_TEXCOORD0.z = _DepthSlice;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform  sampler2DArray _MainTex;
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = texture(_MainTex, vs_TEXCOORD0.xyz);
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 58
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %33 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD0 Location 33 
					                                             OpMemberDecorate %44 0 Offset 44 
					                                             OpDecorate %44 Block 
					                                             OpDecorate %46 DescriptorSet 46 
					                                             OpDecorate %46 Binding 46 
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
					                                     %16 = OpTypeVector %6 3 
					                                     %17 = OpTypePointer Input %16 
					                        Input f32_3* %18 = OpVariable Input 
					                                     %19 = OpTypeVector %6 2 
					                                     %22 = OpTypePointer Output %7 
					                                 f32 %26 = OpConstant 3,674022E-40 
					                                 f32 %27 = OpConstant 3,674022E-40 
					                               f32_2 %28 = OpConstantComposite %26 %27 
					                                     %32 = OpTypePointer Output %16 
					              Output f32_3* vs_TEXCOORD0 = OpVariable Output 
					                                 f32 %36 = OpConstant 3,674022E-40 
					                                 f32 %37 = OpConstant 3,674022E-40 
					                               f32_2 %38 = OpConstantComposite %36 %37 
					                               f32_2 %40 = OpConstantComposite %36 %36 
					                                     %44 = OpTypeStruct %6 
					                                     %45 = OpTypePointer Uniform %44 
					              Uniform struct {f32;}* %46 = OpVariable Uniform 
					                                     %47 = OpTypePointer Uniform %6 
					                                 u32 %50 = OpConstant 2 
					                                     %51 = OpTypePointer Output %6 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                               f32_3 %20 = OpLoad %18 
					                               f32_2 %21 = OpVectorShuffle %20 %20 0 1 
					                       Output f32_4* %23 = OpAccessChain %13 %15 
					                               f32_4 %24 = OpLoad %23 
					                               f32_4 %25 = OpVectorShuffle %24 %21 4 5 2 3 
					                                             OpStore %23 %25 
					                       Output f32_4* %29 = OpAccessChain %13 %15 
					                               f32_4 %30 = OpLoad %29 
					                               f32_4 %31 = OpVectorShuffle %30 %28 0 1 4 5 
					                                             OpStore %29 %31 
					                               f32_3 %34 = OpLoad %18 
					                               f32_2 %35 = OpVectorShuffle %34 %34 0 1 
					                               f32_2 %39 = OpFMul %35 %38 
					                               f32_2 %41 = OpFAdd %39 %40 
					                               f32_3 %42 = OpLoad vs_TEXCOORD0 
					                               f32_3 %43 = OpVectorShuffle %42 %41 3 4 2 
					                                             OpStore vs_TEXCOORD0 %43 
					                        Uniform f32* %48 = OpAccessChain %46 %15 
					                                 f32 %49 = OpLoad %48 
					                         Output f32* %52 = OpAccessChain vs_TEXCOORD0 %50 
					                                             OpStore %52 %49 
					                         Output f32* %53 = OpAccessChain %13 %15 %9 
					                                 f32 %54 = OpLoad %53 
					                                 f32 %55 = OpFNegate %54 
					                         Output f32* %56 = OpAccessChain %13 %15 %9 
					                                             OpStore %56 %55 
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
					                                          %10 = OpTypeImage %6 Dim2D 0 1 0 1 Unknown 
					                                          %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2DArray* %12 = OpVariable UniformConstant 
					                                          %14 = OpTypeSampler 
					                                          %15 = OpTypePointer UniformConstant %14 
					                 UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                          %18 = OpTypeSampledImage %10 
					                                          %20 = OpTypeVector %6 3 
					                                          %21 = OpTypePointer Input %20 
					                    Input f32_3* vs_TEXCOORD0 = OpVariable Input 
					                                      void %4 = OpFunction None %3 
					                                           %5 = OpLabel 
					                 read_only Texture2DArray %13 = OpLoad %12 
					                                  sampler %17 = OpLoad %16 
					          read_only Texture2DArraySampled %19 = OpSampledImage %13 %17 
					                                    f32_3 %23 = OpLoad vs_TEXCOORD0 
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
					uniform  sampler2DArray _MainTex;
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = texture(_MainTex, vs_TEXCOORD0.xyz);
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
			GpuProgramID 129899
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
						float _DepthSlice;
					};
					in  vec3 in_POSITION0;
					out vec3 vs_TEXCOORD0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
					    vs_TEXCOORD0.z = _DepthSlice;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!GL3x
					#ifdef VERTEX
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					
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
					uniform 	float _DepthSlice;
					in  vec3 in_POSITION0;
					out vec3 vs_TEXCOORD0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    vs_TEXCOORD0.z = _DepthSlice;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform  sampler2DArray _MainTex;
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec4 u_xlati1;
					bvec4 u_xlatb1;
					bvec4 u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xyz);
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
					; Bound: 58
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %33 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD0 Location 33 
					                                             OpMemberDecorate %44 0 Offset 44 
					                                             OpDecorate %44 Block 
					                                             OpDecorate %46 DescriptorSet 46 
					                                             OpDecorate %46 Binding 46 
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
					                                     %16 = OpTypeVector %6 3 
					                                     %17 = OpTypePointer Input %16 
					                        Input f32_3* %18 = OpVariable Input 
					                                     %19 = OpTypeVector %6 2 
					                                     %22 = OpTypePointer Output %7 
					                                 f32 %26 = OpConstant 3,674022E-40 
					                                 f32 %27 = OpConstant 3,674022E-40 
					                               f32_2 %28 = OpConstantComposite %26 %27 
					                                     %32 = OpTypePointer Output %16 
					              Output f32_3* vs_TEXCOORD0 = OpVariable Output 
					                                 f32 %36 = OpConstant 3,674022E-40 
					                                 f32 %37 = OpConstant 3,674022E-40 
					                               f32_2 %38 = OpConstantComposite %36 %37 
					                               f32_2 %40 = OpConstantComposite %36 %36 
					                                     %44 = OpTypeStruct %6 
					                                     %45 = OpTypePointer Uniform %44 
					              Uniform struct {f32;}* %46 = OpVariable Uniform 
					                                     %47 = OpTypePointer Uniform %6 
					                                 u32 %50 = OpConstant 2 
					                                     %51 = OpTypePointer Output %6 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                               f32_3 %20 = OpLoad %18 
					                               f32_2 %21 = OpVectorShuffle %20 %20 0 1 
					                       Output f32_4* %23 = OpAccessChain %13 %15 
					                               f32_4 %24 = OpLoad %23 
					                               f32_4 %25 = OpVectorShuffle %24 %21 4 5 2 3 
					                                             OpStore %23 %25 
					                       Output f32_4* %29 = OpAccessChain %13 %15 
					                               f32_4 %30 = OpLoad %29 
					                               f32_4 %31 = OpVectorShuffle %30 %28 0 1 4 5 
					                                             OpStore %29 %31 
					                               f32_3 %34 = OpLoad %18 
					                               f32_2 %35 = OpVectorShuffle %34 %34 0 1 
					                               f32_2 %39 = OpFMul %35 %38 
					                               f32_2 %41 = OpFAdd %39 %40 
					                               f32_3 %42 = OpLoad vs_TEXCOORD0 
					                               f32_3 %43 = OpVectorShuffle %42 %41 3 4 2 
					                                             OpStore vs_TEXCOORD0 %43 
					                        Uniform f32* %48 = OpAccessChain %46 %15 
					                                 f32 %49 = OpLoad %48 
					                         Output f32* %52 = OpAccessChain vs_TEXCOORD0 %50 
					                                             OpStore %52 %49 
					                         Output f32* %53 = OpAccessChain %13 %15 %9 
					                                 f32 %54 = OpLoad %53 
					                                 f32 %55 = OpFNegate %54 
					                         Output f32* %56 = OpAccessChain %13 %15 %9 
					                                             OpStore %56 %55 
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
					                                          %10 = OpTypeImage %6 Dim2D 0 1 0 1 Unknown 
					                                          %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2DArray* %12 = OpVariable UniformConstant 
					                                          %14 = OpTypeSampler 
					                                          %15 = OpTypePointer UniformConstant %14 
					                 UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                          %18 = OpTypeSampledImage %10 
					                                          %20 = OpTypeVector %6 3 
					                                          %21 = OpTypePointer Input %20 
					                    Input f32_3* vs_TEXCOORD0 = OpVariable Input 
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
					                 read_only Texture2DArray %13 = OpLoad %12 
					                                  sampler %17 = OpLoad %16 
					          read_only Texture2DArraySampled %19 = OpSampledImage %13 %17 
					                                    f32_3 %23 = OpLoad vs_TEXCOORD0 
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
					uniform  sampler2DArray _MainTex;
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec4 u_xlati1;
					bvec4 u_xlatb1;
					bvec4 u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xyz);
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