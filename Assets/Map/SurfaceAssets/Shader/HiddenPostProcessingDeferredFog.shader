Shader "Hidden/PostProcessing/DeferredFog" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 50059
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[3];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
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
					uniform 	float _RenderViewportScaleFactor;
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 _FogColor;
					uniform 	vec3 _FogParams;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat3 = u_xlat1.x * _ZBufferParams.x;
					    u_xlat0 = u_xlat0 * u_xlat3 + _ZBufferParams.y;
					    u_xlat3 = (-unity_OrthoParams.w) * u_xlat3 + 1.0;
					    u_xlat0 = u_xlat3 / u_xlat0;
					    u_xlat0 = u_xlat0 * _ProjectionParams.z + (-_ProjectionParams.y);
					    u_xlat0 = u_xlat0 * _FogParams.x;
					    u_xlat0 = u_xlat0 * (-u_xlat0);
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + 1.0;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2 = (-u_xlat1) + _FogColor;
					    SV_Target0 = vec4(u_xlat0) * u_xlat2 + u_xlat1;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 67
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %45 %55 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD1 Location 45 
					                                             OpMemberDecorate %47 0 Offset 47 
					                                             OpDecorate %47 Block 
					                                             OpDecorate %49 DescriptorSet 49 
					                                             OpDecorate %49 Binding 49 
					                                             OpDecorate vs_TEXCOORD0 Location 55 
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
					                                     %32 = OpTypePointer Private %19 
					                      Private f32_2* %33 = OpVariable Private 
					                               f32_2 %36 = OpConstantComposite %27 %27 
					                                 f32 %39 = OpConstant 3,674022E-40 
					                                 f32 %40 = OpConstant 3,674022E-40 
					                               f32_2 %41 = OpConstantComposite %39 %40 
					                                     %44 = OpTypePointer Output %19 
					              Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                     %47 = OpTypeStruct %6 
					                                     %48 = OpTypePointer Uniform %47 
					              Uniform struct {f32;}* %49 = OpVariable Uniform 
					                                     %50 = OpTypePointer Uniform %6 
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                               f32_2 %59 = OpConstantComposite %39 %39 
					                                     %61 = OpTypePointer Output %6 
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
					                               f32_2 %37 = OpFAdd %35 %36 
					                                             OpStore %33 %37 
					                               f32_2 %38 = OpLoad %33 
					                               f32_2 %42 = OpFMul %38 %41 
					                               f32_2 %43 = OpFAdd %42 %28 
					                                             OpStore %33 %43 
					                               f32_2 %46 = OpLoad %33 
					                        Uniform f32* %51 = OpAccessChain %49 %15 
					                                 f32 %52 = OpLoad %51 
					                               f32_2 %53 = OpCompositeConstruct %52 %52 
					                               f32_2 %54 = OpFMul %46 %53 
					                                             OpStore vs_TEXCOORD1 %54 
					                               f32_3 %56 = OpLoad %18 
					                               f32_2 %57 = OpVectorShuffle %56 %56 0 1 
					                               f32_2 %58 = OpFMul %57 %41 
					                               f32_2 %60 = OpFAdd %58 %59 
					                                             OpStore vs_TEXCOORD0 %60 
					                         Output f32* %62 = OpAccessChain %13 %15 %9 
					                                 f32 %63 = OpLoad %62 
					                                 f32 %64 = OpFNegate %63 
					                         Output f32* %65 = OpAccessChain %13 %15 %9 
					                                             OpStore %65 %64 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 113
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %37 %105 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpMemberDecorate %11 0 Offset 11 
					                                                      OpMemberDecorate %11 1 Offset 11 
					                                                      OpMemberDecorate %11 2 Offset 11 
					                                                      OpMemberDecorate %11 3 Offset 11 
					                                                      OpMemberDecorate %11 4 Offset 11 
					                                                      OpDecorate %11 Block 
					                                                      OpDecorate %13 DescriptorSet 13 
					                                                      OpDecorate %13 Binding 13 
					                                                      OpDecorate %27 DescriptorSet 27 
					                                                      OpDecorate %27 Binding 27 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpDecorate vs_TEXCOORD1 Location 37 
					                                                      OpDecorate %89 DescriptorSet 89 
					                                                      OpDecorate %89 Binding 89 
					                                                      OpDecorate %91 DescriptorSet 91 
					                                                      OpDecorate %91 Binding 91 
					                                                      OpDecorate %105 Location 105 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypePointer Private %6 
					                                  Private f32* %8 = OpVariable Private 
					                                               %9 = OpTypeVector %6 4 
					                                              %10 = OpTypeVector %6 3 
					                                              %11 = OpTypeStruct %9 %9 %9 %9 %10 
					                                              %12 = OpTypePointer Uniform %11 
					Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_3;}* %13 = OpVariable Uniform 
					                                              %14 = OpTypeInt 32 1 
					                                          i32 %15 = OpConstant 1 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 3 
					                                              %18 = OpTypePointer Uniform %6 
					                                          f32 %22 = OpConstant 3,674022E-40 
					                                 Private f32* %24 = OpVariable Private 
					                                              %25 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %26 = OpTypePointer UniformConstant %25 
					         UniformConstant read_only Texture2D* %27 = OpVariable UniformConstant 
					                                              %29 = OpTypeSampler 
					                                              %30 = OpTypePointer UniformConstant %29 
					                     UniformConstant sampler* %31 = OpVariable UniformConstant 
					                                              %33 = OpTypeSampledImage %25 
					                                              %35 = OpTypeVector %6 2 
					                                              %36 = OpTypePointer Input %35 
					                        Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                          u32 %40 = OpConstant 0 
					                                          i32 %43 = OpConstant 2 
					                                          u32 %50 = OpConstant 1 
					                                          i32 %64 = OpConstant 0 
					                                          u32 %65 = OpConstant 2 
					                                          i32 %74 = OpConstant 4 
					                                              %87 = OpTypePointer Private %9 
					                               Private f32_4* %88 = OpVariable Private 
					         UniformConstant read_only Texture2D* %89 = OpVariable UniformConstant 
					                     UniformConstant sampler* %91 = OpVariable UniformConstant 
					                               Private f32_4* %96 = OpVariable Private 
					                                          i32 %99 = OpConstant 3 
					                                             %100 = OpTypePointer Uniform %9 
					                                             %104 = OpTypePointer Output %9 
					                               Output f32_4* %105 = OpVariable Output 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                 Uniform f32* %19 = OpAccessChain %13 %15 %17 
					                                          f32 %20 = OpLoad %19 
					                                          f32 %21 = OpFNegate %20 
					                                          f32 %23 = OpFAdd %21 %22 
					                                                      OpStore %8 %23 
					                          read_only Texture2D %28 = OpLoad %27 
					                                      sampler %32 = OpLoad %31 
					                   read_only Texture2DSampled %34 = OpSampledImage %28 %32 
					                                        f32_2 %38 = OpLoad vs_TEXCOORD1 
					                                        f32_4 %39 = OpImageSampleImplicitLod %34 %38 
					                                          f32 %41 = OpCompositeExtract %39 0 
					                                                      OpStore %24 %41 
					                                          f32 %42 = OpLoad %24 
					                                 Uniform f32* %44 = OpAccessChain %13 %43 %40 
					                                          f32 %45 = OpLoad %44 
					                                          f32 %46 = OpFMul %42 %45 
					                                                      OpStore %24 %46 
					                                          f32 %47 = OpLoad %8 
					                                          f32 %48 = OpLoad %24 
					                                          f32 %49 = OpFMul %47 %48 
					                                 Uniform f32* %51 = OpAccessChain %13 %43 %50 
					                                          f32 %52 = OpLoad %51 
					                                          f32 %53 = OpFAdd %49 %52 
					                                                      OpStore %8 %53 
					                                 Uniform f32* %54 = OpAccessChain %13 %15 %17 
					                                          f32 %55 = OpLoad %54 
					                                          f32 %56 = OpFNegate %55 
					                                          f32 %57 = OpLoad %24 
					                                          f32 %58 = OpFMul %56 %57 
					                                          f32 %59 = OpFAdd %58 %22 
					                                                      OpStore %24 %59 
					                                          f32 %60 = OpLoad %24 
					                                          f32 %61 = OpLoad %8 
					                                          f32 %62 = OpFDiv %60 %61 
					                                                      OpStore %8 %62 
					                                          f32 %63 = OpLoad %8 
					                                 Uniform f32* %66 = OpAccessChain %13 %64 %65 
					                                          f32 %67 = OpLoad %66 
					                                          f32 %68 = OpFMul %63 %67 
					                                 Uniform f32* %69 = OpAccessChain %13 %64 %50 
					                                          f32 %70 = OpLoad %69 
					                                          f32 %71 = OpFNegate %70 
					                                          f32 %72 = OpFAdd %68 %71 
					                                                      OpStore %8 %72 
					                                          f32 %73 = OpLoad %8 
					                                 Uniform f32* %75 = OpAccessChain %13 %74 %40 
					                                          f32 %76 = OpLoad %75 
					                                          f32 %77 = OpFMul %73 %76 
					                                                      OpStore %8 %77 
					                                          f32 %78 = OpLoad %8 
					                                          f32 %79 = OpLoad %8 
					                                          f32 %80 = OpFNegate %79 
					                                          f32 %81 = OpFMul %78 %80 
					                                                      OpStore %8 %81 
					                                          f32 %82 = OpLoad %8 
					                                          f32 %83 = OpExtInst %1 29 %82 
					                                                      OpStore %8 %83 
					                                          f32 %84 = OpLoad %8 
					                                          f32 %85 = OpFNegate %84 
					                                          f32 %86 = OpFAdd %85 %22 
					                                                      OpStore %8 %86 
					                          read_only Texture2D %90 = OpLoad %89 
					                                      sampler %92 = OpLoad %91 
					                   read_only Texture2DSampled %93 = OpSampledImage %90 %92 
					                                        f32_2 %94 = OpLoad vs_TEXCOORD1 
					                                        f32_4 %95 = OpImageSampleImplicitLod %93 %94 
					                                                      OpStore %88 %95 
					                                        f32_4 %97 = OpLoad %88 
					                                        f32_4 %98 = OpFNegate %97 
					                              Uniform f32_4* %101 = OpAccessChain %13 %99 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpFAdd %98 %102 
					                                                      OpStore %96 %103 
					                                         f32 %106 = OpLoad %8 
					                                       f32_4 %107 = OpCompositeConstruct %106 %106 %106 %106 
					                                       f32_4 %108 = OpLoad %96 
					                                       f32_4 %109 = OpFMul %107 %108 
					                                       f32_4 %110 = OpLoad %88 
					                                       f32_4 %111 = OpFAdd %109 %110 
					                                                      OpStore %105 %111 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" }
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[3];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
					    return;
					}"
				}
				SubProgram "glcore " {
					Keywords { "FOG_LINEAR" }
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
					uniform 	float _RenderViewportScaleFactor;
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 _FogColor;
					uniform 	vec3 _FogParams;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat3 = u_xlat1.x * _ZBufferParams.x;
					    u_xlat0 = u_xlat0 * u_xlat3 + _ZBufferParams.y;
					    u_xlat3 = (-unity_OrthoParams.w) * u_xlat3 + 1.0;
					    u_xlat0 = u_xlat3 / u_xlat0;
					    u_xlat0 = u_xlat0 * _ProjectionParams.z + (-_ProjectionParams.y);
					    u_xlat0 = (-u_xlat0) + _FogParams.z;
					    u_xlat3 = (-_FogParams.y) + _FogParams.z;
					    u_xlat0 = u_xlat0 / u_xlat3;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = (-u_xlat0) + 1.0;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2 = (-u_xlat1) + _FogColor;
					    SV_Target0 = vec4(u_xlat0) * u_xlat2 + u_xlat1;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "FOG_LINEAR" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 67
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %45 %55 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD1 Location 45 
					                                             OpMemberDecorate %47 0 Offset 47 
					                                             OpDecorate %47 Block 
					                                             OpDecorate %49 DescriptorSet 49 
					                                             OpDecorate %49 Binding 49 
					                                             OpDecorate vs_TEXCOORD0 Location 55 
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
					                                     %32 = OpTypePointer Private %19 
					                      Private f32_2* %33 = OpVariable Private 
					                               f32_2 %36 = OpConstantComposite %27 %27 
					                                 f32 %39 = OpConstant 3,674022E-40 
					                                 f32 %40 = OpConstant 3,674022E-40 
					                               f32_2 %41 = OpConstantComposite %39 %40 
					                                     %44 = OpTypePointer Output %19 
					              Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                     %47 = OpTypeStruct %6 
					                                     %48 = OpTypePointer Uniform %47 
					              Uniform struct {f32;}* %49 = OpVariable Uniform 
					                                     %50 = OpTypePointer Uniform %6 
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                               f32_2 %59 = OpConstantComposite %39 %39 
					                                     %61 = OpTypePointer Output %6 
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
					                               f32_2 %37 = OpFAdd %35 %36 
					                                             OpStore %33 %37 
					                               f32_2 %38 = OpLoad %33 
					                               f32_2 %42 = OpFMul %38 %41 
					                               f32_2 %43 = OpFAdd %42 %28 
					                                             OpStore %33 %43 
					                               f32_2 %46 = OpLoad %33 
					                        Uniform f32* %51 = OpAccessChain %49 %15 
					                                 f32 %52 = OpLoad %51 
					                               f32_2 %53 = OpCompositeConstruct %52 %52 
					                               f32_2 %54 = OpFMul %46 %53 
					                                             OpStore vs_TEXCOORD1 %54 
					                               f32_3 %56 = OpLoad %18 
					                               f32_2 %57 = OpVectorShuffle %56 %56 0 1 
					                               f32_2 %58 = OpFMul %57 %41 
					                               f32_2 %60 = OpFAdd %58 %59 
					                                             OpStore vs_TEXCOORD0 %60 
					                         Output f32* %62 = OpAccessChain %13 %15 %9 
					                                 f32 %63 = OpLoad %62 
					                                 f32 %64 = OpFNegate %63 
					                         Output f32* %65 = OpAccessChain %13 %15 %9 
					                                             OpStore %65 %64 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 120
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %37 %112 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpMemberDecorate %11 0 Offset 11 
					                                                      OpMemberDecorate %11 1 Offset 11 
					                                                      OpMemberDecorate %11 2 Offset 11 
					                                                      OpMemberDecorate %11 3 Offset 11 
					                                                      OpMemberDecorate %11 4 Offset 11 
					                                                      OpDecorate %11 Block 
					                                                      OpDecorate %13 DescriptorSet 13 
					                                                      OpDecorate %13 Binding 13 
					                                                      OpDecorate %27 DescriptorSet 27 
					                                                      OpDecorate %27 Binding 27 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpDecorate vs_TEXCOORD1 Location 37 
					                                                      OpDecorate %96 DescriptorSet 96 
					                                                      OpDecorate %96 Binding 96 
					                                                      OpDecorate %98 DescriptorSet 98 
					                                                      OpDecorate %98 Binding 98 
					                                                      OpDecorate %112 Location 112 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypePointer Private %6 
					                                  Private f32* %8 = OpVariable Private 
					                                               %9 = OpTypeVector %6 4 
					                                              %10 = OpTypeVector %6 3 
					                                              %11 = OpTypeStruct %9 %9 %9 %9 %10 
					                                              %12 = OpTypePointer Uniform %11 
					Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_3;}* %13 = OpVariable Uniform 
					                                              %14 = OpTypeInt 32 1 
					                                          i32 %15 = OpConstant 1 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 3 
					                                              %18 = OpTypePointer Uniform %6 
					                                          f32 %22 = OpConstant 3,674022E-40 
					                                 Private f32* %24 = OpVariable Private 
					                                              %25 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %26 = OpTypePointer UniformConstant %25 
					         UniformConstant read_only Texture2D* %27 = OpVariable UniformConstant 
					                                              %29 = OpTypeSampler 
					                                              %30 = OpTypePointer UniformConstant %29 
					                     UniformConstant sampler* %31 = OpVariable UniformConstant 
					                                              %33 = OpTypeSampledImage %25 
					                                              %35 = OpTypeVector %6 2 
					                                              %36 = OpTypePointer Input %35 
					                        Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                          u32 %40 = OpConstant 0 
					                                          i32 %43 = OpConstant 2 
					                                          u32 %50 = OpConstant 1 
					                                          i32 %64 = OpConstant 0 
					                                          u32 %65 = OpConstant 2 
					                                          i32 %75 = OpConstant 4 
					                                          f32 %89 = OpConstant 3,674022E-40 
					                                              %94 = OpTypePointer Private %9 
					                               Private f32_4* %95 = OpVariable Private 
					         UniformConstant read_only Texture2D* %96 = OpVariable UniformConstant 
					                     UniformConstant sampler* %98 = OpVariable UniformConstant 
					                              Private f32_4* %103 = OpVariable Private 
					                                         i32 %106 = OpConstant 3 
					                                             %107 = OpTypePointer Uniform %9 
					                                             %111 = OpTypePointer Output %9 
					                               Output f32_4* %112 = OpVariable Output 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                 Uniform f32* %19 = OpAccessChain %13 %15 %17 
					                                          f32 %20 = OpLoad %19 
					                                          f32 %21 = OpFNegate %20 
					                                          f32 %23 = OpFAdd %21 %22 
					                                                      OpStore %8 %23 
					                          read_only Texture2D %28 = OpLoad %27 
					                                      sampler %32 = OpLoad %31 
					                   read_only Texture2DSampled %34 = OpSampledImage %28 %32 
					                                        f32_2 %38 = OpLoad vs_TEXCOORD1 
					                                        f32_4 %39 = OpImageSampleImplicitLod %34 %38 
					                                          f32 %41 = OpCompositeExtract %39 0 
					                                                      OpStore %24 %41 
					                                          f32 %42 = OpLoad %24 
					                                 Uniform f32* %44 = OpAccessChain %13 %43 %40 
					                                          f32 %45 = OpLoad %44 
					                                          f32 %46 = OpFMul %42 %45 
					                                                      OpStore %24 %46 
					                                          f32 %47 = OpLoad %8 
					                                          f32 %48 = OpLoad %24 
					                                          f32 %49 = OpFMul %47 %48 
					                                 Uniform f32* %51 = OpAccessChain %13 %43 %50 
					                                          f32 %52 = OpLoad %51 
					                                          f32 %53 = OpFAdd %49 %52 
					                                                      OpStore %8 %53 
					                                 Uniform f32* %54 = OpAccessChain %13 %15 %17 
					                                          f32 %55 = OpLoad %54 
					                                          f32 %56 = OpFNegate %55 
					                                          f32 %57 = OpLoad %24 
					                                          f32 %58 = OpFMul %56 %57 
					                                          f32 %59 = OpFAdd %58 %22 
					                                                      OpStore %24 %59 
					                                          f32 %60 = OpLoad %24 
					                                          f32 %61 = OpLoad %8 
					                                          f32 %62 = OpFDiv %60 %61 
					                                                      OpStore %8 %62 
					                                          f32 %63 = OpLoad %8 
					                                 Uniform f32* %66 = OpAccessChain %13 %64 %65 
					                                          f32 %67 = OpLoad %66 
					                                          f32 %68 = OpFMul %63 %67 
					                                 Uniform f32* %69 = OpAccessChain %13 %64 %50 
					                                          f32 %70 = OpLoad %69 
					                                          f32 %71 = OpFNegate %70 
					                                          f32 %72 = OpFAdd %68 %71 
					                                                      OpStore %8 %72 
					                                          f32 %73 = OpLoad %8 
					                                          f32 %74 = OpFNegate %73 
					                                 Uniform f32* %76 = OpAccessChain %13 %75 %65 
					                                          f32 %77 = OpLoad %76 
					                                          f32 %78 = OpFAdd %74 %77 
					                                                      OpStore %8 %78 
					                                 Uniform f32* %79 = OpAccessChain %13 %75 %50 
					                                          f32 %80 = OpLoad %79 
					                                          f32 %81 = OpFNegate %80 
					                                 Uniform f32* %82 = OpAccessChain %13 %75 %65 
					                                          f32 %83 = OpLoad %82 
					                                          f32 %84 = OpFAdd %81 %83 
					                                                      OpStore %24 %84 
					                                          f32 %85 = OpLoad %8 
					                                          f32 %86 = OpLoad %24 
					                                          f32 %87 = OpFDiv %85 %86 
					                                                      OpStore %8 %87 
					                                          f32 %88 = OpLoad %8 
					                                          f32 %90 = OpExtInst %1 43 %88 %89 %22 
					                                                      OpStore %8 %90 
					                                          f32 %91 = OpLoad %8 
					                                          f32 %92 = OpFNegate %91 
					                                          f32 %93 = OpFAdd %92 %22 
					                                                      OpStore %8 %93 
					                          read_only Texture2D %97 = OpLoad %96 
					                                      sampler %99 = OpLoad %98 
					                  read_only Texture2DSampled %100 = OpSampledImage %97 %99 
					                                       f32_2 %101 = OpLoad vs_TEXCOORD1 
					                                       f32_4 %102 = OpImageSampleImplicitLod %100 %101 
					                                                      OpStore %95 %102 
					                                       f32_4 %104 = OpLoad %95 
					                                       f32_4 %105 = OpFNegate %104 
					                              Uniform f32_4* %108 = OpAccessChain %13 %106 
					                                       f32_4 %109 = OpLoad %108 
					                                       f32_4 %110 = OpFAdd %105 %109 
					                                                      OpStore %103 %110 
					                                         f32 %113 = OpLoad %8 
					                                       f32_4 %114 = OpCompositeConstruct %113 %113 %113 %113 
					                                       f32_4 %115 = OpLoad %103 
					                                       f32_4 %116 = OpFMul %114 %115 
					                                       f32_4 %117 = OpLoad %95 
					                                       f32_4 %118 = OpFAdd %116 %117 
					                                                      OpStore %112 %118 
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
						vec4 unused_0_0[17];
						vec4 _ProjectionParams;
						vec4 unused_0_2[2];
						vec4 unity_OrthoParams;
						vec4 _ZBufferParams;
						vec4 unused_0_5[6];
						vec4 _FogColor;
						vec3 _FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat3 = u_xlat1.x * _ZBufferParams.x;
					    u_xlat0 = u_xlat0 * u_xlat3 + _ZBufferParams.y;
					    u_xlat3 = (-unity_OrthoParams.w) * u_xlat3 + 1.0;
					    u_xlat0 = u_xlat3 / u_xlat0;
					    u_xlat0 = u_xlat0 * _ProjectionParams.z + (-_ProjectionParams.y);
					    u_xlat0 = u_xlat0 * _FogParams.x;
					    u_xlat0 = u_xlat0 * (-u_xlat0);
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + 1.0;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2 = (-u_xlat1) + _FogColor;
					    SV_Target0 = vec4(u_xlat0) * u_xlat2 + u_xlat1;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!GL3x"
				}
				SubProgram "vulkan " {
					"spirv"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" }
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
						vec4 unused_0_0[17];
						vec4 _ProjectionParams;
						vec4 unused_0_2[2];
						vec4 unity_OrthoParams;
						vec4 _ZBufferParams;
						vec4 unused_0_5[6];
						vec4 _FogColor;
						vec3 _FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat3 = u_xlat1.x * _ZBufferParams.x;
					    u_xlat0 = u_xlat0 * u_xlat3 + _ZBufferParams.y;
					    u_xlat3 = (-unity_OrthoParams.w) * u_xlat3 + 1.0;
					    u_xlat0 = u_xlat3 / u_xlat0;
					    u_xlat0 = u_xlat0 * _ProjectionParams.z + (-_ProjectionParams.y);
					    u_xlat0 = (-u_xlat0) + _FogParams.z;
					    u_xlat3 = (-_FogParams.y) + _FogParams.z;
					    u_xlat0 = u_xlat0 / u_xlat3;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = (-u_xlat0) + 1.0;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2 = (-u_xlat1) + _FogColor;
					    SV_Target0 = vec4(u_xlat0) * u_xlat2 + u_xlat1;
					    return;
					}"
				}
				SubProgram "glcore " {
					Keywords { "FOG_LINEAR" }
					"!!GL3x"
				}
				SubProgram "vulkan " {
					Keywords { "FOG_LINEAR" }
					"spirv"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 108772
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[3];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
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
					uniform 	float _RenderViewportScaleFactor;
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 _FogColor;
					uniform 	vec3 _FogParams;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat3 = u_xlat1.x * _ZBufferParams.x;
					    u_xlat0 = u_xlat0 * u_xlat3 + _ZBufferParams.y;
					    u_xlat3 = (-unity_OrthoParams.w) * u_xlat3 + 1.0;
					    u_xlat0 = u_xlat3 / u_xlat0;
					    u_xlat3 = u_xlat0 * _ProjectionParams.z + (-_ProjectionParams.y);
					    u_xlatb0 = u_xlat0<0.999899983;
					    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat3 = u_xlat3 * _FogParams.x;
					    u_xlat3 = u_xlat3 * (-u_xlat3);
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat3 = (-u_xlat3) + 1.0;
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2 = (-u_xlat1) + _FogColor;
					    SV_Target0 = vec4(u_xlat0) * u_xlat2 + u_xlat1;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 67
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %45 %55 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD1 Location 45 
					                                             OpMemberDecorate %47 0 Offset 47 
					                                             OpDecorate %47 Block 
					                                             OpDecorate %49 DescriptorSet 49 
					                                             OpDecorate %49 Binding 49 
					                                             OpDecorate vs_TEXCOORD0 Location 55 
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
					                                     %32 = OpTypePointer Private %19 
					                      Private f32_2* %33 = OpVariable Private 
					                               f32_2 %36 = OpConstantComposite %27 %27 
					                                 f32 %39 = OpConstant 3,674022E-40 
					                                 f32 %40 = OpConstant 3,674022E-40 
					                               f32_2 %41 = OpConstantComposite %39 %40 
					                                     %44 = OpTypePointer Output %19 
					              Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                     %47 = OpTypeStruct %6 
					                                     %48 = OpTypePointer Uniform %47 
					              Uniform struct {f32;}* %49 = OpVariable Uniform 
					                                     %50 = OpTypePointer Uniform %6 
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                               f32_2 %59 = OpConstantComposite %39 %39 
					                                     %61 = OpTypePointer Output %6 
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
					                               f32_2 %37 = OpFAdd %35 %36 
					                                             OpStore %33 %37 
					                               f32_2 %38 = OpLoad %33 
					                               f32_2 %42 = OpFMul %38 %41 
					                               f32_2 %43 = OpFAdd %42 %28 
					                                             OpStore %33 %43 
					                               f32_2 %46 = OpLoad %33 
					                        Uniform f32* %51 = OpAccessChain %49 %15 
					                                 f32 %52 = OpLoad %51 
					                               f32_2 %53 = OpCompositeConstruct %52 %52 
					                               f32_2 %54 = OpFMul %46 %53 
					                                             OpStore vs_TEXCOORD1 %54 
					                               f32_3 %56 = OpLoad %18 
					                               f32_2 %57 = OpVectorShuffle %56 %56 0 1 
					                               f32_2 %58 = OpFMul %57 %41 
					                               f32_2 %60 = OpFAdd %58 %59 
					                                             OpStore vs_TEXCOORD0 %60 
					                         Output f32* %62 = OpAccessChain %13 %15 %9 
					                                 f32 %63 = OpLoad %62 
					                                 f32 %64 = OpFNegate %63 
					                         Output f32* %65 = OpAccessChain %13 %15 %9 
					                                             OpStore %65 %64 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 125
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %37 %117 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpMemberDecorate %11 0 Offset 11 
					                                                      OpMemberDecorate %11 1 Offset 11 
					                                                      OpMemberDecorate %11 2 Offset 11 
					                                                      OpMemberDecorate %11 3 Offset 11 
					                                                      OpMemberDecorate %11 4 Offset 11 
					                                                      OpDecorate %11 Block 
					                                                      OpDecorate %13 DescriptorSet 13 
					                                                      OpDecorate %13 Binding 13 
					                                                      OpDecorate %27 DescriptorSet 27 
					                                                      OpDecorate %27 Binding 27 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpDecorate vs_TEXCOORD1 Location 37 
					                                                      OpDecorate %101 DescriptorSet 101 
					                                                      OpDecorate %101 Binding 101 
					                                                      OpDecorate %103 DescriptorSet 103 
					                                                      OpDecorate %103 Binding 103 
					                                                      OpDecorate %117 Location 117 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypePointer Private %6 
					                                  Private f32* %8 = OpVariable Private 
					                                               %9 = OpTypeVector %6 4 
					                                              %10 = OpTypeVector %6 3 
					                                              %11 = OpTypeStruct %9 %9 %9 %9 %10 
					                                              %12 = OpTypePointer Uniform %11 
					Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_3;}* %13 = OpVariable Uniform 
					                                              %14 = OpTypeInt 32 1 
					                                          i32 %15 = OpConstant 1 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 3 
					                                              %18 = OpTypePointer Uniform %6 
					                                          f32 %22 = OpConstant 3,674022E-40 
					                                 Private f32* %24 = OpVariable Private 
					                                              %25 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %26 = OpTypePointer UniformConstant %25 
					         UniformConstant read_only Texture2D* %27 = OpVariable UniformConstant 
					                                              %29 = OpTypeSampler 
					                                              %30 = OpTypePointer UniformConstant %29 
					                     UniformConstant sampler* %31 = OpVariable UniformConstant 
					                                              %33 = OpTypeSampledImage %25 
					                                              %35 = OpTypeVector %6 2 
					                                              %36 = OpTypePointer Input %35 
					                        Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                          u32 %40 = OpConstant 0 
					                                          i32 %43 = OpConstant 2 
					                                          u32 %50 = OpConstant 1 
					                                          i32 %64 = OpConstant 0 
					                                          u32 %65 = OpConstant 2 
					                                              %73 = OpTypeBool 
					                                              %74 = OpTypePointer Private %73 
					                                Private bool* %75 = OpVariable Private 
					                                          f32 %77 = OpConstant 3,674022E-40 
					                                          f32 %80 = OpConstant 3,674022E-40 
					                                          i32 %83 = OpConstant 4 
					                                              %99 = OpTypePointer Private %9 
					                              Private f32_4* %100 = OpVariable Private 
					        UniformConstant read_only Texture2D* %101 = OpVariable UniformConstant 
					                    UniformConstant sampler* %103 = OpVariable UniformConstant 
					                              Private f32_4* %108 = OpVariable Private 
					                                         i32 %111 = OpConstant 3 
					                                             %112 = OpTypePointer Uniform %9 
					                                             %116 = OpTypePointer Output %9 
					                               Output f32_4* %117 = OpVariable Output 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                 Uniform f32* %19 = OpAccessChain %13 %15 %17 
					                                          f32 %20 = OpLoad %19 
					                                          f32 %21 = OpFNegate %20 
					                                          f32 %23 = OpFAdd %21 %22 
					                                                      OpStore %8 %23 
					                          read_only Texture2D %28 = OpLoad %27 
					                                      sampler %32 = OpLoad %31 
					                   read_only Texture2DSampled %34 = OpSampledImage %28 %32 
					                                        f32_2 %38 = OpLoad vs_TEXCOORD1 
					                                        f32_4 %39 = OpImageSampleImplicitLod %34 %38 
					                                          f32 %41 = OpCompositeExtract %39 0 
					                                                      OpStore %24 %41 
					                                          f32 %42 = OpLoad %24 
					                                 Uniform f32* %44 = OpAccessChain %13 %43 %40 
					                                          f32 %45 = OpLoad %44 
					                                          f32 %46 = OpFMul %42 %45 
					                                                      OpStore %24 %46 
					                                          f32 %47 = OpLoad %8 
					                                          f32 %48 = OpLoad %24 
					                                          f32 %49 = OpFMul %47 %48 
					                                 Uniform f32* %51 = OpAccessChain %13 %43 %50 
					                                          f32 %52 = OpLoad %51 
					                                          f32 %53 = OpFAdd %49 %52 
					                                                      OpStore %8 %53 
					                                 Uniform f32* %54 = OpAccessChain %13 %15 %17 
					                                          f32 %55 = OpLoad %54 
					                                          f32 %56 = OpFNegate %55 
					                                          f32 %57 = OpLoad %24 
					                                          f32 %58 = OpFMul %56 %57 
					                                          f32 %59 = OpFAdd %58 %22 
					                                                      OpStore %24 %59 
					                                          f32 %60 = OpLoad %24 
					                                          f32 %61 = OpLoad %8 
					                                          f32 %62 = OpFDiv %60 %61 
					                                                      OpStore %8 %62 
					                                          f32 %63 = OpLoad %8 
					                                 Uniform f32* %66 = OpAccessChain %13 %64 %65 
					                                          f32 %67 = OpLoad %66 
					                                          f32 %68 = OpFMul %63 %67 
					                                 Uniform f32* %69 = OpAccessChain %13 %64 %50 
					                                          f32 %70 = OpLoad %69 
					                                          f32 %71 = OpFNegate %70 
					                                          f32 %72 = OpFAdd %68 %71 
					                                                      OpStore %24 %72 
					                                          f32 %76 = OpLoad %8 
					                                         bool %78 = OpFOrdLessThan %76 %77 
					                                                      OpStore %75 %78 
					                                         bool %79 = OpLoad %75 
					                                          f32 %81 = OpSelect %79 %22 %80 
					                                                      OpStore %8 %81 
					                                          f32 %82 = OpLoad %24 
					                                 Uniform f32* %84 = OpAccessChain %13 %83 %40 
					                                          f32 %85 = OpLoad %84 
					                                          f32 %86 = OpFMul %82 %85 
					                                                      OpStore %24 %86 
					                                          f32 %87 = OpLoad %24 
					                                          f32 %88 = OpLoad %24 
					                                          f32 %89 = OpFNegate %88 
					                                          f32 %90 = OpFMul %87 %89 
					                                                      OpStore %24 %90 
					                                          f32 %91 = OpLoad %24 
					                                          f32 %92 = OpExtInst %1 29 %91 
					                                                      OpStore %24 %92 
					                                          f32 %93 = OpLoad %24 
					                                          f32 %94 = OpFNegate %93 
					                                          f32 %95 = OpFAdd %94 %22 
					                                                      OpStore %24 %95 
					                                          f32 %96 = OpLoad %8 
					                                          f32 %97 = OpLoad %24 
					                                          f32 %98 = OpFMul %96 %97 
					                                                      OpStore %8 %98 
					                         read_only Texture2D %102 = OpLoad %101 
					                                     sampler %104 = OpLoad %103 
					                  read_only Texture2DSampled %105 = OpSampledImage %102 %104 
					                                       f32_2 %106 = OpLoad vs_TEXCOORD1 
					                                       f32_4 %107 = OpImageSampleImplicitLod %105 %106 
					                                                      OpStore %100 %107 
					                                       f32_4 %109 = OpLoad %100 
					                                       f32_4 %110 = OpFNegate %109 
					                              Uniform f32_4* %113 = OpAccessChain %13 %111 
					                                       f32_4 %114 = OpLoad %113 
					                                       f32_4 %115 = OpFAdd %110 %114 
					                                                      OpStore %108 %115 
					                                         f32 %118 = OpLoad %8 
					                                       f32_4 %119 = OpCompositeConstruct %118 %118 %118 %118 
					                                       f32_4 %120 = OpLoad %108 
					                                       f32_4 %121 = OpFMul %119 %120 
					                                       f32_4 %122 = OpLoad %100 
					                                       f32_4 %123 = OpFAdd %121 %122 
					                                                      OpStore %117 %123 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" }
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[3];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
					    return;
					}"
				}
				SubProgram "glcore " {
					Keywords { "FOG_LINEAR" }
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
					uniform 	float _RenderViewportScaleFactor;
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 _FogColor;
					uniform 	vec3 _FogParams;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat3 = u_xlat1.x * _ZBufferParams.x;
					    u_xlat0 = u_xlat0 * u_xlat3 + _ZBufferParams.y;
					    u_xlat3 = (-unity_OrthoParams.w) * u_xlat3 + 1.0;
					    u_xlat0 = u_xlat3 / u_xlat0;
					    u_xlat3 = u_xlat0 * _ProjectionParams.z + (-_ProjectionParams.y);
					    u_xlatb0 = u_xlat0<0.999899983;
					    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat3 = (-u_xlat3) + _FogParams.z;
					    u_xlat6 = (-_FogParams.y) + _FogParams.z;
					    u_xlat3 = u_xlat3 / u_xlat6;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat3 = (-u_xlat3) + 1.0;
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2 = (-u_xlat1) + _FogColor;
					    SV_Target0 = vec4(u_xlat0) * u_xlat2 + u_xlat1;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "FOG_LINEAR" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 67
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %45 %55 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD1 Location 45 
					                                             OpMemberDecorate %47 0 Offset 47 
					                                             OpDecorate %47 Block 
					                                             OpDecorate %49 DescriptorSet 49 
					                                             OpDecorate %49 Binding 49 
					                                             OpDecorate vs_TEXCOORD0 Location 55 
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
					                                     %32 = OpTypePointer Private %19 
					                      Private f32_2* %33 = OpVariable Private 
					                               f32_2 %36 = OpConstantComposite %27 %27 
					                                 f32 %39 = OpConstant 3,674022E-40 
					                                 f32 %40 = OpConstant 3,674022E-40 
					                               f32_2 %41 = OpConstantComposite %39 %40 
					                                     %44 = OpTypePointer Output %19 
					              Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                     %47 = OpTypeStruct %6 
					                                     %48 = OpTypePointer Uniform %47 
					              Uniform struct {f32;}* %49 = OpVariable Uniform 
					                                     %50 = OpTypePointer Uniform %6 
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                               f32_2 %59 = OpConstantComposite %39 %39 
					                                     %61 = OpTypePointer Output %6 
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
					                               f32_2 %37 = OpFAdd %35 %36 
					                                             OpStore %33 %37 
					                               f32_2 %38 = OpLoad %33 
					                               f32_2 %42 = OpFMul %38 %41 
					                               f32_2 %43 = OpFAdd %42 %28 
					                                             OpStore %33 %43 
					                               f32_2 %46 = OpLoad %33 
					                        Uniform f32* %51 = OpAccessChain %49 %15 
					                                 f32 %52 = OpLoad %51 
					                               f32_2 %53 = OpCompositeConstruct %52 %52 
					                               f32_2 %54 = OpFMul %46 %53 
					                                             OpStore vs_TEXCOORD1 %54 
					                               f32_3 %56 = OpLoad %18 
					                               f32_2 %57 = OpVectorShuffle %56 %56 0 1 
					                               f32_2 %58 = OpFMul %57 %41 
					                               f32_2 %60 = OpFAdd %58 %59 
					                                             OpStore vs_TEXCOORD0 %60 
					                         Output f32* %62 = OpAccessChain %13 %15 %9 
					                                 f32 %63 = OpLoad %62 
					                                 f32 %64 = OpFNegate %63 
					                         Output f32* %65 = OpAccessChain %13 %15 %9 
					                                             OpStore %65 %64 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 132
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %37 %124 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpMemberDecorate %11 0 Offset 11 
					                                                      OpMemberDecorate %11 1 Offset 11 
					                                                      OpMemberDecorate %11 2 Offset 11 
					                                                      OpMemberDecorate %11 3 Offset 11 
					                                                      OpMemberDecorate %11 4 Offset 11 
					                                                      OpDecorate %11 Block 
					                                                      OpDecorate %13 DescriptorSet 13 
					                                                      OpDecorate %13 Binding 13 
					                                                      OpDecorate %27 DescriptorSet 27 
					                                                      OpDecorate %27 Binding 27 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpDecorate vs_TEXCOORD1 Location 37 
					                                                      OpDecorate %108 DescriptorSet 108 
					                                                      OpDecorate %108 Binding 108 
					                                                      OpDecorate %110 DescriptorSet 110 
					                                                      OpDecorate %110 Binding 110 
					                                                      OpDecorate %124 Location 124 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypePointer Private %6 
					                                  Private f32* %8 = OpVariable Private 
					                                               %9 = OpTypeVector %6 4 
					                                              %10 = OpTypeVector %6 3 
					                                              %11 = OpTypeStruct %9 %9 %9 %9 %10 
					                                              %12 = OpTypePointer Uniform %11 
					Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_3;}* %13 = OpVariable Uniform 
					                                              %14 = OpTypeInt 32 1 
					                                          i32 %15 = OpConstant 1 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 3 
					                                              %18 = OpTypePointer Uniform %6 
					                                          f32 %22 = OpConstant 3,674022E-40 
					                                 Private f32* %24 = OpVariable Private 
					                                              %25 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %26 = OpTypePointer UniformConstant %25 
					         UniformConstant read_only Texture2D* %27 = OpVariable UniformConstant 
					                                              %29 = OpTypeSampler 
					                                              %30 = OpTypePointer UniformConstant %29 
					                     UniformConstant sampler* %31 = OpVariable UniformConstant 
					                                              %33 = OpTypeSampledImage %25 
					                                              %35 = OpTypeVector %6 2 
					                                              %36 = OpTypePointer Input %35 
					                        Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                          u32 %40 = OpConstant 0 
					                                          i32 %43 = OpConstant 2 
					                                          u32 %50 = OpConstant 1 
					                                          i32 %64 = OpConstant 0 
					                                          u32 %65 = OpConstant 2 
					                                              %73 = OpTypeBool 
					                                              %74 = OpTypePointer Private %73 
					                                Private bool* %75 = OpVariable Private 
					                                          f32 %77 = OpConstant 3,674022E-40 
					                                          f32 %80 = OpConstant 3,674022E-40 
					                                          i32 %84 = OpConstant 4 
					                                 Private f32* %88 = OpVariable Private 
					                                             %106 = OpTypePointer Private %9 
					                              Private f32_4* %107 = OpVariable Private 
					        UniformConstant read_only Texture2D* %108 = OpVariable UniformConstant 
					                    UniformConstant sampler* %110 = OpVariable UniformConstant 
					                              Private f32_4* %115 = OpVariable Private 
					                                         i32 %118 = OpConstant 3 
					                                             %119 = OpTypePointer Uniform %9 
					                                             %123 = OpTypePointer Output %9 
					                               Output f32_4* %124 = OpVariable Output 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                 Uniform f32* %19 = OpAccessChain %13 %15 %17 
					                                          f32 %20 = OpLoad %19 
					                                          f32 %21 = OpFNegate %20 
					                                          f32 %23 = OpFAdd %21 %22 
					                                                      OpStore %8 %23 
					                          read_only Texture2D %28 = OpLoad %27 
					                                      sampler %32 = OpLoad %31 
					                   read_only Texture2DSampled %34 = OpSampledImage %28 %32 
					                                        f32_2 %38 = OpLoad vs_TEXCOORD1 
					                                        f32_4 %39 = OpImageSampleImplicitLod %34 %38 
					                                          f32 %41 = OpCompositeExtract %39 0 
					                                                      OpStore %24 %41 
					                                          f32 %42 = OpLoad %24 
					                                 Uniform f32* %44 = OpAccessChain %13 %43 %40 
					                                          f32 %45 = OpLoad %44 
					                                          f32 %46 = OpFMul %42 %45 
					                                                      OpStore %24 %46 
					                                          f32 %47 = OpLoad %8 
					                                          f32 %48 = OpLoad %24 
					                                          f32 %49 = OpFMul %47 %48 
					                                 Uniform f32* %51 = OpAccessChain %13 %43 %50 
					                                          f32 %52 = OpLoad %51 
					                                          f32 %53 = OpFAdd %49 %52 
					                                                      OpStore %8 %53 
					                                 Uniform f32* %54 = OpAccessChain %13 %15 %17 
					                                          f32 %55 = OpLoad %54 
					                                          f32 %56 = OpFNegate %55 
					                                          f32 %57 = OpLoad %24 
					                                          f32 %58 = OpFMul %56 %57 
					                                          f32 %59 = OpFAdd %58 %22 
					                                                      OpStore %24 %59 
					                                          f32 %60 = OpLoad %24 
					                                          f32 %61 = OpLoad %8 
					                                          f32 %62 = OpFDiv %60 %61 
					                                                      OpStore %8 %62 
					                                          f32 %63 = OpLoad %8 
					                                 Uniform f32* %66 = OpAccessChain %13 %64 %65 
					                                          f32 %67 = OpLoad %66 
					                                          f32 %68 = OpFMul %63 %67 
					                                 Uniform f32* %69 = OpAccessChain %13 %64 %50 
					                                          f32 %70 = OpLoad %69 
					                                          f32 %71 = OpFNegate %70 
					                                          f32 %72 = OpFAdd %68 %71 
					                                                      OpStore %24 %72 
					                                          f32 %76 = OpLoad %8 
					                                         bool %78 = OpFOrdLessThan %76 %77 
					                                                      OpStore %75 %78 
					                                         bool %79 = OpLoad %75 
					                                          f32 %81 = OpSelect %79 %22 %80 
					                                                      OpStore %8 %81 
					                                          f32 %82 = OpLoad %24 
					                                          f32 %83 = OpFNegate %82 
					                                 Uniform f32* %85 = OpAccessChain %13 %84 %65 
					                                          f32 %86 = OpLoad %85 
					                                          f32 %87 = OpFAdd %83 %86 
					                                                      OpStore %24 %87 
					                                 Uniform f32* %89 = OpAccessChain %13 %84 %50 
					                                          f32 %90 = OpLoad %89 
					                                          f32 %91 = OpFNegate %90 
					                                 Uniform f32* %92 = OpAccessChain %13 %84 %65 
					                                          f32 %93 = OpLoad %92 
					                                          f32 %94 = OpFAdd %91 %93 
					                                                      OpStore %88 %94 
					                                          f32 %95 = OpLoad %24 
					                                          f32 %96 = OpLoad %88 
					                                          f32 %97 = OpFDiv %95 %96 
					                                                      OpStore %24 %97 
					                                          f32 %98 = OpLoad %24 
					                                          f32 %99 = OpExtInst %1 43 %98 %80 %22 
					                                                      OpStore %24 %99 
					                                         f32 %100 = OpLoad %24 
					                                         f32 %101 = OpFNegate %100 
					                                         f32 %102 = OpFAdd %101 %22 
					                                                      OpStore %24 %102 
					                                         f32 %103 = OpLoad %8 
					                                         f32 %104 = OpLoad %24 
					                                         f32 %105 = OpFMul %103 %104 
					                                                      OpStore %8 %105 
					                         read_only Texture2D %109 = OpLoad %108 
					                                     sampler %111 = OpLoad %110 
					                  read_only Texture2DSampled %112 = OpSampledImage %109 %111 
					                                       f32_2 %113 = OpLoad vs_TEXCOORD1 
					                                       f32_4 %114 = OpImageSampleImplicitLod %112 %113 
					                                                      OpStore %107 %114 
					                                       f32_4 %116 = OpLoad %107 
					                                       f32_4 %117 = OpFNegate %116 
					                              Uniform f32_4* %120 = OpAccessChain %13 %118 
					                                       f32_4 %121 = OpLoad %120 
					                                       f32_4 %122 = OpFAdd %117 %121 
					                                                      OpStore %115 %122 
					                                         f32 %125 = OpLoad %8 
					                                       f32_4 %126 = OpCompositeConstruct %125 %125 %125 %125 
					                                       f32_4 %127 = OpLoad %115 
					                                       f32_4 %128 = OpFMul %126 %127 
					                                       f32_4 %129 = OpLoad %107 
					                                       f32_4 %130 = OpFAdd %128 %129 
					                                                      OpStore %124 %130 
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
						vec4 unused_0_0[17];
						vec4 _ProjectionParams;
						vec4 unused_0_2[2];
						vec4 unity_OrthoParams;
						vec4 _ZBufferParams;
						vec4 unused_0_5[6];
						vec4 _FogColor;
						vec3 _FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat3 = u_xlat1.x * _ZBufferParams.x;
					    u_xlat0 = u_xlat0 * u_xlat3 + _ZBufferParams.y;
					    u_xlat3 = (-unity_OrthoParams.w) * u_xlat3 + 1.0;
					    u_xlat0 = u_xlat3 / u_xlat0;
					    u_xlat3 = u_xlat0 * _ProjectionParams.z + (-_ProjectionParams.y);
					    u_xlatb0 = u_xlat0<0.999899983;
					    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat3 = u_xlat3 * _FogParams.x;
					    u_xlat3 = u_xlat3 * (-u_xlat3);
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat3 = (-u_xlat3) + 1.0;
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2 = (-u_xlat1) + _FogColor;
					    SV_Target0 = vec4(u_xlat0) * u_xlat2 + u_xlat1;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!GL3x"
				}
				SubProgram "vulkan " {
					"spirv"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" }
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
						vec4 unused_0_0[17];
						vec4 _ProjectionParams;
						vec4 unused_0_2[2];
						vec4 unity_OrthoParams;
						vec4 _ZBufferParams;
						vec4 unused_0_5[6];
						vec4 _FogColor;
						vec3 _FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat3 = u_xlat1.x * _ZBufferParams.x;
					    u_xlat0 = u_xlat0 * u_xlat3 + _ZBufferParams.y;
					    u_xlat3 = (-unity_OrthoParams.w) * u_xlat3 + 1.0;
					    u_xlat0 = u_xlat3 / u_xlat0;
					    u_xlat3 = u_xlat0 * _ProjectionParams.z + (-_ProjectionParams.y);
					    u_xlatb0 = u_xlat0<0.999899983;
					    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat3 = (-u_xlat3) + _FogParams.z;
					    u_xlat6 = (-_FogParams.y) + _FogParams.z;
					    u_xlat3 = u_xlat3 / u_xlat6;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat3 = (-u_xlat3) + 1.0;
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2 = (-u_xlat1) + _FogColor;
					    SV_Target0 = vec4(u_xlat0) * u_xlat2 + u_xlat1;
					    return;
					}"
				}
				SubProgram "glcore " {
					Keywords { "FOG_LINEAR" }
					"!!GL3x"
				}
				SubProgram "vulkan " {
					Keywords { "FOG_LINEAR" }
					"spirv"
				}
			}
		}
	}
}