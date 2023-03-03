Shader "Hidden/PostProcessing/DepthOfField" {
	Properties {
	}
	SubShader {
		Pass {
			Name "CoC Calculation"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 63364
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
						vec4 unused_0_2[5];
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
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Distance;
					uniform 	float _LensCoeff;
					uniform 	float _RcpMaxCoC;
					UNITY_LOCATION(0) uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat1;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat1 = u_xlat0.x + (-_Distance);
					    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
					    u_xlat1 = u_xlat1 * _LensCoeff;
					    u_xlat0.x = u_xlat1 / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.x * _RcpMaxCoC + 0.5;
					    SV_Target0 = u_xlat0.xxxx;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
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
					; Bound: 83
					; Schema: 0
					                                                OpCapability Shader 
					                                         %1 = OpExtInstImport "GLSL.std.450" 
					                                                OpMemoryModel Logical GLSL450 
					                                                OpEntryPoint Fragment %4 "main" %21 %74 
					                                                OpExecutionMode %4 OriginUpperLeft 
					                                                OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                OpDecorate %11 DescriptorSet 11 
					                                                OpDecorate %11 Binding 11 
					                                                OpDecorate %15 DescriptorSet 15 
					                                                OpDecorate %15 Binding 15 
					                                                OpDecorate vs_TEXCOORD1 Location 21 
					                                                OpMemberDecorate %28 0 Offset 28 
					                                                OpMemberDecorate %28 1 Offset 28 
					                                                OpMemberDecorate %28 2 Offset 28 
					                                                OpMemberDecorate %28 3 Offset 28 
					                                                OpDecorate %28 Block 
					                                                OpDecorate %30 DescriptorSet 30 
					                                                OpDecorate %30 Binding 30 
					                                                OpDecorate %74 Location 74 
					                                         %2 = OpTypeVoid 
					                                         %3 = OpTypeFunction %2 
					                                         %6 = OpTypeFloat 32 
					                                         %7 = OpTypePointer Private %6 
					                            Private f32* %8 = OpVariable Private 
					                                         %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                        %10 = OpTypePointer UniformConstant %9 
					   UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
					                                        %13 = OpTypeSampler 
					                                        %14 = OpTypePointer UniformConstant %13 
					               UniformConstant sampler* %15 = OpVariable UniformConstant 
					                                        %17 = OpTypeSampledImage %9 
					                                        %19 = OpTypeVector %6 2 
					                                        %20 = OpTypePointer Input %19 
					                  Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                        %23 = OpTypeVector %6 4 
					                                        %25 = OpTypeInt 32 0 
					                                    u32 %26 = OpConstant 0 
					                                        %28 = OpTypeStruct %23 %6 %6 %6 
					                                        %29 = OpTypePointer Uniform %28 
					Uniform struct {f32_4; f32; f32; f32;}* %30 = OpVariable Uniform 
					                                        %31 = OpTypeInt 32 1 
					                                    i32 %32 = OpConstant 0 
					                                    u32 %33 = OpConstant 2 
					                                        %34 = OpTypePointer Uniform %6 
					                                    u32 %39 = OpConstant 3 
					                                    f32 %43 = OpConstant 3,674022E-40 
					                           Private f32* %46 = OpVariable Private 
					                                    i32 %48 = OpConstant 1 
					                                    f32 %54 = OpConstant 3,674022E-40 
					                                    i32 %57 = OpConstant 2 
					                                    f32 %65 = OpConstant 3,674022E-40 
					                                    i32 %68 = OpConstant 3 
					                                        %73 = OpTypePointer Output %23 
					                          Output f32_4* %74 = OpVariable Output 
					                                    f32 %78 = OpConstant 3,674022E-40 
					                                    void %4 = OpFunction None %3 
					                                         %5 = OpLabel 
					                    read_only Texture2D %12 = OpLoad %11 
					                                sampler %16 = OpLoad %15 
					             read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                                  f32_2 %22 = OpLoad vs_TEXCOORD1 
					                                  f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                    f32 %27 = OpCompositeExtract %24 0 
					                                                OpStore %8 %27 
					                           Uniform f32* %35 = OpAccessChain %30 %32 %33 
					                                    f32 %36 = OpLoad %35 
					                                    f32 %37 = OpLoad %8 
					                                    f32 %38 = OpFMul %36 %37 
					                           Uniform f32* %40 = OpAccessChain %30 %32 %39 
					                                    f32 %41 = OpLoad %40 
					                                    f32 %42 = OpFAdd %38 %41 
					                                                OpStore %8 %42 
					                                    f32 %44 = OpLoad %8 
					                                    f32 %45 = OpFDiv %43 %44 
					                                                OpStore %8 %45 
					                                    f32 %47 = OpLoad %8 
					                           Uniform f32* %49 = OpAccessChain %30 %48 
					                                    f32 %50 = OpLoad %49 
					                                    f32 %51 = OpFNegate %50 
					                                    f32 %52 = OpFAdd %47 %51 
					                                                OpStore %46 %52 
					                                    f32 %53 = OpLoad %8 
					                                    f32 %55 = OpExtInst %1 40 %53 %54 
					                                                OpStore %8 %55 
					                                    f32 %56 = OpLoad %46 
					                           Uniform f32* %58 = OpAccessChain %30 %57 
					                                    f32 %59 = OpLoad %58 
					                                    f32 %60 = OpFMul %56 %59 
					                                                OpStore %46 %60 
					                                    f32 %61 = OpLoad %46 
					                                    f32 %62 = OpLoad %8 
					                                    f32 %63 = OpFDiv %61 %62 
					                                                OpStore %8 %63 
					                                    f32 %64 = OpLoad %8 
					                                    f32 %66 = OpFMul %64 %65 
					                                                OpStore %8 %66 
					                                    f32 %67 = OpLoad %8 
					                           Uniform f32* %69 = OpAccessChain %30 %68 
					                                    f32 %70 = OpLoad %69 
					                                    f32 %71 = OpFMul %67 %70 
					                                    f32 %72 = OpFAdd %71 %65 
					                                                OpStore %8 %72 
					                                    f32 %75 = OpLoad %8 
					                                  f32_4 %76 = OpCompositeConstruct %75 %75 %75 %75 
					                                                OpStore %74 %76 
					                                  f32_4 %77 = OpLoad %74 
					                                  f32_4 %79 = OpCompositeConstruct %78 %78 %78 %78 
					                                  f32_4 %80 = OpCompositeConstruct %43 %43 %43 %43 
					                                  f32_4 %81 = OpExtInst %1 43 %77 %79 %80 
					                                                OpStore %74 %81 
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
						vec4 unused_0_0[21];
						vec4 _ZBufferParams;
						vec4 unused_0_2[8];
						float _Distance;
						float _LensCoeff;
						float _RcpMaxCoC;
						vec4 unused_0_6;
					};
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat1;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat1 = u_xlat0.x + (-_Distance);
					    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
					    u_xlat1 = u_xlat1 * _LensCoeff;
					    u_xlat0.x = u_xlat1 / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.x * _RcpMaxCoC + 0.5;
					    SV_Target0 = u_xlat0.xxxx;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
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
			Name "CoC Temporal Filter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 82522
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform VGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[5];
					};
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD1;
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
					"!!GL4x
					#ifdef VERTEX
					#version 420
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_shading_language_420pack : require
					
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
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD1;
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
					#version 420
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_shading_language_420pack : require
					
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
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	vec3 _TaaParams;
					UNITY_LOCATION(0) uniform  sampler2D _CoCTex;
					UNITY_LOCATION(1) uniform  sampler2D _CameraMotionVectorsTexture;
					UNITY_LOCATION(2) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat5;
					bool u_xlatb5;
					bool u_xlatb6;
					float u_xlat8;
					bool u_xlatb9;
					vec2 u_xlat11;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
					    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat12 = texture(_CoCTex, u_xlat1.xy).x;
					    u_xlat0.z = texture(_CoCTex, u_xlat1.zw).x;
					    u_xlat1.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1.x = texture(_CoCTex, u_xlat1.xy).x;
					    u_xlatb5 = u_xlat12<u_xlat1.x;
					    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
					    u_xlat12 = max(u_xlat12, u_xlat1.x);
					    u_xlat12 = max(u_xlat0.z, u_xlat12);
					    u_xlatb9 = u_xlat0.z<u_xlat2.z;
					    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
					    u_xlat11.xy = (-u_xlat3.xy);
					    u_xlat2.xy = bool(u_xlatb5) ? u_xlat11.xy : vec2(0.0, 0.0);
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
					    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat5.z = texture(_CoCTex, u_xlat2.xy).x;
					    u_xlat2.x = texture(_CoCTex, u_xlat2.zw).x;
					    u_xlatb6 = u_xlat5.z<u_xlat0.z;
					    u_xlat5.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
					    u_xlat12 = max(u_xlat12, u_xlat5.z);
					    u_xlat12 = max(u_xlat2.x, u_xlat12);
					    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
					    u_xlatb5 = u_xlat2.x<u_xlat0.z;
					    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
					    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat0.xy = texture(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
					    u_xlat0.xy = (-u_xlat0.xy) + vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
					    u_xlat0.x = max(u_xlat8, u_xlat0.x);
					    u_xlat0.x = min(u_xlat12, u_xlat0.x);
					    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
					    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat1.xxxx;
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
					; Bound: 361
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %38 %344 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpMemberDecorate %11 0 Offset 11 
					                                              OpMemberDecorate %11 1 Offset 11 
					                                              OpMemberDecorate %11 2 Offset 11 
					                                              OpDecorate %11 Block 
					                                              OpDecorate %13 DescriptorSet 13 
					                                              OpDecorate %13 Binding 13 
					                                              OpDecorate vs_TEXCOORD0 Location 38 
					                                              OpDecorate %57 DescriptorSet 57 
					                                              OpDecorate %57 Binding 57 
					                                              OpDecorate %61 DescriptorSet 61 
					                                              OpDecorate %61 Binding 61 
					                                              OpDecorate %283 DescriptorSet 283 
					                                              OpDecorate %283 Binding 283 
					                                              OpDecorate %285 DescriptorSet 285 
					                                              OpDecorate %285 Binding 285 
					                                              OpDecorate %316 DescriptorSet 316 
					                                              OpDecorate %316 Binding 316 
					                                              OpDecorate %318 DescriptorSet 318 
					                                              OpDecorate %318 Binding 318 
					                                              OpDecorate %344 Location 344 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 3 
					                                       %8 = OpTypePointer Private %7 
					                        Private f32_3* %9 = OpVariable Private 
					                                      %10 = OpTypeVector %6 4 
					                                      %11 = OpTypeStruct %6 %10 %7 
					                                      %12 = OpTypePointer Uniform %11 
					 Uniform struct {f32; f32_4; f32_3;}* %13 = OpVariable Uniform 
					                                      %14 = OpTypeInt 32 1 
					                                  i32 %15 = OpConstant 1 
					                                      %16 = OpTypeVector %6 2 
					                                      %17 = OpTypePointer Uniform %10 
					                                  f32 %21 = OpConstant 3,674022E-40 
					                                  f32 %22 = OpConstant 3,674022E-40 
					                                f32_2 %23 = OpConstantComposite %21 %22 
					                                      %27 = OpTypePointer Private %10 
					                       Private f32_4* %28 = OpVariable Private 
					                                  f32 %33 = OpConstant 3,674022E-40 
					                                  f32 %34 = OpConstant 3,674022E-40 
					                                f32_4 %35 = OpConstantComposite %33 %34 %34 %33 
					                                      %37 = OpTypePointer Input %16 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                  i32 %47 = OpConstant 0 
					                                      %48 = OpTypePointer Uniform %6 
					                                      %53 = OpTypePointer Private %6 
					                         Private f32* %54 = OpVariable Private 
					                                      %55 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                      %56 = OpTypePointer UniformConstant %55 
					 UniformConstant read_only Texture2D* %57 = OpVariable UniformConstant 
					                                      %59 = OpTypeSampler 
					                                      %60 = OpTypePointer UniformConstant %59 
					             UniformConstant sampler* %61 = OpVariable UniformConstant 
					                                      %63 = OpTypeSampledImage %55 
					                                      %68 = OpTypeInt 32 0 
					                                  u32 %69 = OpConstant 0 
					                                  u32 %78 = OpConstant 2 
					                                  i32 %81 = OpConstant 2 
					                                      %82 = OpTypePointer Uniform %7 
					                                     %113 = OpTypeBool 
					                                     %114 = OpTypePointer Private %113 
					                       Private bool* %115 = OpVariable Private 
					                      Private f32_4* %120 = OpVariable Private 
					                                     %122 = OpTypePointer Function %6 
					                       Private bool* %140 = OpVariable Private 
					                                     %146 = OpTypePointer Private %16 
					                      Private f32_2* %147 = OpVariable Private 
					                               f32_2 %151 = OpConstantComposite %33 %34 
					                      Private f32_2* %153 = OpVariable Private 
					                                     %157 = OpTypePointer Function %16 
					                               f32_2 %163 = OpConstantComposite %34 %34 
					                                     %168 = OpTypePointer Function %7 
					                               f32_4 %180 = OpConstantComposite %34 %33 %33 %34 
					                      Private f32_3* %194 = OpVariable Private 
					                       Private bool* %211 = OpVariable Private 
					                               f32_2 %220 = OpConstantComposite %34 %33 
					                        Private f32* %245 = OpVariable Private 
					UniformConstant read_only Texture2D* %283 = OpVariable UniformConstant 
					            UniformConstant sampler* %285 = OpVariable UniformConstant 
					UniformConstant read_only Texture2D* %316 = OpVariable UniformConstant 
					            UniformConstant sampler* %318 = OpVariable UniformConstant 
					                                     %343 = OpTypePointer Output %10 
					                       Output f32_4* %344 = OpVariable Output 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                       Function f32* %123 = OpVariable Function 
					                     Function f32_2* %158 = OpVariable Function 
					                     Function f32_3* %169 = OpVariable Function 
					                     Function f32_3* %233 = OpVariable Function 
					                     Function f32_2* %252 = OpVariable Function 
					                       Uniform f32_4* %18 = OpAccessChain %13 %15 
					                                f32_4 %19 = OpLoad %18 
					                                f32_2 %20 = OpVectorShuffle %19 %19 1 1 
					                                f32_2 %24 = OpFMul %20 %23 
					                                f32_3 %25 = OpLoad %9 
					                                f32_3 %26 = OpVectorShuffle %25 %24 3 4 2 
					                                              OpStore %9 %26 
					                       Uniform f32_4* %29 = OpAccessChain %13 %15 
					                                f32_4 %30 = OpLoad %29 
					                                f32_4 %31 = OpVectorShuffle %30 %30 0 1 1 1 
					                                f32_4 %32 = OpFNegate %31 
					                                f32_4 %36 = OpFMul %32 %35 
					                                f32_2 %39 = OpLoad vs_TEXCOORD0 
					                                f32_4 %40 = OpVectorShuffle %39 %39 0 1 0 1 
					                                f32_4 %41 = OpFAdd %36 %40 
					                                              OpStore %28 %41 
					                                f32_4 %42 = OpLoad %28 
					                                f32_4 %43 = OpCompositeConstruct %34 %34 %34 %34 
					                                f32_4 %44 = OpCompositeConstruct %33 %33 %33 %33 
					                                f32_4 %45 = OpExtInst %1 43 %42 %43 %44 
					                                              OpStore %28 %45 
					                                f32_4 %46 = OpLoad %28 
					                         Uniform f32* %49 = OpAccessChain %13 %47 
					                                  f32 %50 = OpLoad %49 
					                                f32_4 %51 = OpCompositeConstruct %50 %50 %50 %50 
					                                f32_4 %52 = OpFMul %46 %51 
					                                              OpStore %28 %52 
					                  read_only Texture2D %58 = OpLoad %57 
					                              sampler %62 = OpLoad %61 
					           read_only Texture2DSampled %64 = OpSampledImage %58 %62 
					                                f32_4 %65 = OpLoad %28 
					                                f32_2 %66 = OpVectorShuffle %65 %65 0 1 
					                                f32_4 %67 = OpImageSampleImplicitLod %64 %66 
					                                  f32 %70 = OpCompositeExtract %67 0 
					                                              OpStore %54 %70 
					                  read_only Texture2D %71 = OpLoad %57 
					                              sampler %72 = OpLoad %61 
					           read_only Texture2DSampled %73 = OpSampledImage %71 %72 
					                                f32_4 %74 = OpLoad %28 
					                                f32_2 %75 = OpVectorShuffle %74 %74 2 3 
					                                f32_4 %76 = OpImageSampleImplicitLod %73 %75 
					                                  f32 %77 = OpCompositeExtract %76 0 
					                         Private f32* %79 = OpAccessChain %9 %78 
					                                              OpStore %79 %77 
					                                f32_2 %80 = OpLoad vs_TEXCOORD0 
					                       Uniform f32_3* %83 = OpAccessChain %13 %81 
					                                f32_3 %84 = OpLoad %83 
					                                f32_2 %85 = OpVectorShuffle %84 %84 0 1 
					                                f32_2 %86 = OpFNegate %85 
					                                f32_2 %87 = OpFAdd %80 %86 
					                                f32_4 %88 = OpLoad %28 
					                                f32_4 %89 = OpVectorShuffle %88 %87 4 5 2 3 
					                                              OpStore %28 %89 
					                                f32_4 %90 = OpLoad %28 
					                                f32_2 %91 = OpVectorShuffle %90 %90 0 1 
					                                f32_2 %92 = OpCompositeConstruct %34 %34 
					                                f32_2 %93 = OpCompositeConstruct %33 %33 
					                                f32_2 %94 = OpExtInst %1 43 %91 %92 %93 
					                                f32_4 %95 = OpLoad %28 
					                                f32_4 %96 = OpVectorShuffle %95 %94 4 5 2 3 
					                                              OpStore %28 %96 
					                                f32_4 %97 = OpLoad %28 
					                                f32_2 %98 = OpVectorShuffle %97 %97 0 1 
					                         Uniform f32* %99 = OpAccessChain %13 %47 
					                                 f32 %100 = OpLoad %99 
					                               f32_2 %101 = OpCompositeConstruct %100 %100 
					                               f32_2 %102 = OpFMul %98 %101 
					                               f32_4 %103 = OpLoad %28 
					                               f32_4 %104 = OpVectorShuffle %103 %102 4 5 2 3 
					                                              OpStore %28 %104 
					                 read_only Texture2D %105 = OpLoad %57 
					                             sampler %106 = OpLoad %61 
					          read_only Texture2DSampled %107 = OpSampledImage %105 %106 
					                               f32_4 %108 = OpLoad %28 
					                               f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                               f32_4 %110 = OpImageSampleImplicitLod %107 %109 
					                                 f32 %111 = OpCompositeExtract %110 0 
					                        Private f32* %112 = OpAccessChain %28 %69 
					                                              OpStore %112 %111 
					                                 f32 %116 = OpLoad %54 
					                        Private f32* %117 = OpAccessChain %28 %69 
					                                 f32 %118 = OpLoad %117 
					                                bool %119 = OpFOrdLessThan %116 %118 
					                                              OpStore %115 %119 
					                                bool %121 = OpLoad %115 
					                                              OpSelectionMerge %125 None 
					                                              OpBranchConditional %121 %124 %127 
					                                     %124 = OpLabel 
					                                 f32 %126 = OpLoad %54 
					                                              OpStore %123 %126 
					                                              OpBranch %125 
					                                     %127 = OpLabel 
					                        Private f32* %128 = OpAccessChain %28 %69 
					                                 f32 %129 = OpLoad %128 
					                                              OpStore %123 %129 
					                                              OpBranch %125 
					                                     %125 = OpLabel 
					                                 f32 %130 = OpLoad %123 
					                        Private f32* %131 = OpAccessChain %120 %78 
					                                              OpStore %131 %130 
					                                 f32 %132 = OpLoad %54 
					                        Private f32* %133 = OpAccessChain %28 %69 
					                                 f32 %134 = OpLoad %133 
					                                 f32 %135 = OpExtInst %1 40 %132 %134 
					                                              OpStore %54 %135 
					                        Private f32* %136 = OpAccessChain %9 %78 
					                                 f32 %137 = OpLoad %136 
					                                 f32 %138 = OpLoad %54 
					                                 f32 %139 = OpExtInst %1 40 %137 %138 
					                                              OpStore %54 %139 
					                        Private f32* %141 = OpAccessChain %9 %78 
					                                 f32 %142 = OpLoad %141 
					                        Private f32* %143 = OpAccessChain %120 %78 
					                                 f32 %144 = OpLoad %143 
					                                bool %145 = OpFOrdLessThan %142 %144 
					                                              OpStore %140 %145 
					                      Uniform f32_4* %148 = OpAccessChain %13 %15 
					                               f32_4 %149 = OpLoad %148 
					                               f32_2 %150 = OpVectorShuffle %149 %149 0 1 
					                               f32_2 %152 = OpFMul %150 %151 
					                                              OpStore %147 %152 
					                               f32_2 %154 = OpLoad %147 
					                               f32_2 %155 = OpFNegate %154 
					                                              OpStore %153 %155 
					                                bool %156 = OpLoad %115 
					                                              OpSelectionMerge %160 None 
					                                              OpBranchConditional %156 %159 %162 
					                                     %159 = OpLabel 
					                               f32_2 %161 = OpLoad %153 
					                                              OpStore %158 %161 
					                                              OpBranch %160 
					                                     %162 = OpLabel 
					                                              OpStore %158 %163 
					                                              OpBranch %160 
					                                     %160 = OpLabel 
					                               f32_2 %164 = OpLoad %158 
					                               f32_4 %165 = OpLoad %120 
					                               f32_4 %166 = OpVectorShuffle %165 %164 4 5 2 3 
					                                              OpStore %120 %166 
					                                bool %167 = OpLoad %140 
					                                              OpSelectionMerge %171 None 
					                                              OpBranchConditional %167 %170 %173 
					                                     %170 = OpLabel 
					                               f32_3 %172 = OpLoad %9 
					                                              OpStore %169 %172 
					                                              OpBranch %171 
					                                     %173 = OpLabel 
					                               f32_4 %174 = OpLoad %120 
					                               f32_3 %175 = OpVectorShuffle %174 %174 0 1 2 
					                                              OpStore %169 %175 
					                                              OpBranch %171 
					                                     %171 = OpLabel 
					                               f32_3 %176 = OpLoad %169 
					                                              OpStore %9 %176 
					                      Uniform f32_4* %177 = OpAccessChain %13 %15 
					                               f32_4 %178 = OpLoad %177 
					                               f32_4 %179 = OpVectorShuffle %178 %178 1 1 0 1 
					                               f32_4 %181 = OpFMul %179 %180 
					                               f32_2 %182 = OpLoad vs_TEXCOORD0 
					                               f32_4 %183 = OpVectorShuffle %182 %182 0 1 0 1 
					                               f32_4 %184 = OpFAdd %181 %183 
					                                              OpStore %120 %184 
					                               f32_4 %185 = OpLoad %120 
					                               f32_4 %186 = OpCompositeConstruct %34 %34 %34 %34 
					                               f32_4 %187 = OpCompositeConstruct %33 %33 %33 %33 
					                               f32_4 %188 = OpExtInst %1 43 %185 %186 %187 
					                                              OpStore %120 %188 
					                               f32_4 %189 = OpLoad %120 
					                        Uniform f32* %190 = OpAccessChain %13 %47 
					                                 f32 %191 = OpLoad %190 
					                               f32_4 %192 = OpCompositeConstruct %191 %191 %191 %191 
					                               f32_4 %193 = OpFMul %189 %192 
					                                              OpStore %120 %193 
					                 read_only Texture2D %195 = OpLoad %57 
					                             sampler %196 = OpLoad %61 
					          read_only Texture2DSampled %197 = OpSampledImage %195 %196 
					                               f32_4 %198 = OpLoad %120 
					                               f32_2 %199 = OpVectorShuffle %198 %198 0 1 
					                               f32_4 %200 = OpImageSampleImplicitLod %197 %199 
					                                 f32 %201 = OpCompositeExtract %200 0 
					                        Private f32* %202 = OpAccessChain %194 %78 
					                                              OpStore %202 %201 
					                 read_only Texture2D %203 = OpLoad %57 
					                             sampler %204 = OpLoad %61 
					          read_only Texture2DSampled %205 = OpSampledImage %203 %204 
					                               f32_4 %206 = OpLoad %120 
					                               f32_2 %207 = OpVectorShuffle %206 %206 2 3 
					                               f32_4 %208 = OpImageSampleImplicitLod %205 %207 
					                                 f32 %209 = OpCompositeExtract %208 0 
					                        Private f32* %210 = OpAccessChain %120 %69 
					                                              OpStore %210 %209 
					                        Private f32* %212 = OpAccessChain %194 %78 
					                                 f32 %213 = OpLoad %212 
					                        Private f32* %214 = OpAccessChain %9 %78 
					                                 f32 %215 = OpLoad %214 
					                                bool %216 = OpFOrdLessThan %213 %215 
					                                              OpStore %211 %216 
					                      Uniform f32_4* %217 = OpAccessChain %13 %15 
					                               f32_4 %218 = OpLoad %217 
					                               f32_2 %219 = OpVectorShuffle %218 %218 1 1 
					                               f32_2 %221 = OpFMul %219 %220 
					                               f32_3 %222 = OpLoad %194 
					                               f32_3 %223 = OpVectorShuffle %222 %221 3 4 2 
					                                              OpStore %194 %223 
					                                 f32 %224 = OpLoad %54 
					                        Private f32* %225 = OpAccessChain %194 %78 
					                                 f32 %226 = OpLoad %225 
					                                 f32 %227 = OpExtInst %1 40 %224 %226 
					                                              OpStore %54 %227 
					                        Private f32* %228 = OpAccessChain %120 %69 
					                                 f32 %229 = OpLoad %228 
					                                 f32 %230 = OpLoad %54 
					                                 f32 %231 = OpExtInst %1 40 %229 %230 
					                                              OpStore %54 %231 
					                                bool %232 = OpLoad %211 
					                                              OpSelectionMerge %235 None 
					                                              OpBranchConditional %232 %234 %237 
					                                     %234 = OpLabel 
					                               f32_3 %236 = OpLoad %194 
					                                              OpStore %233 %236 
					                                              OpBranch %235 
					                                     %237 = OpLabel 
					                               f32_3 %238 = OpLoad %9 
					                                              OpStore %233 %238 
					                                              OpBranch %235 
					                                     %235 = OpLabel 
					                               f32_3 %239 = OpLoad %233 
					                                              OpStore %9 %239 
					                        Private f32* %240 = OpAccessChain %120 %69 
					                                 f32 %241 = OpLoad %240 
					                        Private f32* %242 = OpAccessChain %9 %78 
					                                 f32 %243 = OpLoad %242 
					                                bool %244 = OpFOrdLessThan %241 %243 
					                                              OpStore %115 %244 
					                        Private f32* %246 = OpAccessChain %120 %69 
					                                 f32 %247 = OpLoad %246 
					                        Private f32* %248 = OpAccessChain %9 %78 
					                                 f32 %249 = OpLoad %248 
					                                 f32 %250 = OpExtInst %1 37 %247 %249 
					                                              OpStore %245 %250 
					                                bool %251 = OpLoad %115 
					                                              OpSelectionMerge %254 None 
					                                              OpBranchConditional %251 %253 %256 
					                                     %253 = OpLabel 
					                               f32_2 %255 = OpLoad %147 
					                                              OpStore %252 %255 
					                                              OpBranch %254 
					                                     %256 = OpLabel 
					                               f32_3 %257 = OpLoad %9 
					                               f32_2 %258 = OpVectorShuffle %257 %257 0 1 
					                                              OpStore %252 %258 
					                                              OpBranch %254 
					                                     %254 = OpLabel 
					                               f32_2 %259 = OpLoad %252 
					                               f32_3 %260 = OpLoad %9 
					                               f32_3 %261 = OpVectorShuffle %260 %259 3 4 2 
					                                              OpStore %9 %261 
					                               f32_3 %262 = OpLoad %9 
					                               f32_2 %263 = OpVectorShuffle %262 %262 0 1 
					                               f32_2 %264 = OpLoad vs_TEXCOORD0 
					                               f32_2 %265 = OpFAdd %263 %264 
					                               f32_3 %266 = OpLoad %9 
					                               f32_3 %267 = OpVectorShuffle %266 %265 3 4 2 
					                                              OpStore %9 %267 
					                               f32_3 %268 = OpLoad %9 
					                               f32_2 %269 = OpVectorShuffle %268 %268 0 1 
					                               f32_2 %270 = OpCompositeConstruct %34 %34 
					                               f32_2 %271 = OpCompositeConstruct %33 %33 
					                               f32_2 %272 = OpExtInst %1 43 %269 %270 %271 
					                               f32_3 %273 = OpLoad %9 
					                               f32_3 %274 = OpVectorShuffle %273 %272 3 4 2 
					                                              OpStore %9 %274 
					                               f32_3 %275 = OpLoad %9 
					                               f32_2 %276 = OpVectorShuffle %275 %275 0 1 
					                        Uniform f32* %277 = OpAccessChain %13 %47 
					                                 f32 %278 = OpLoad %277 
					                               f32_2 %279 = OpCompositeConstruct %278 %278 
					                               f32_2 %280 = OpFMul %276 %279 
					                               f32_3 %281 = OpLoad %9 
					                               f32_3 %282 = OpVectorShuffle %281 %280 3 4 2 
					                                              OpStore %9 %282 
					                 read_only Texture2D %284 = OpLoad %283 
					                             sampler %286 = OpLoad %285 
					          read_only Texture2DSampled %287 = OpSampledImage %284 %286 
					                               f32_3 %288 = OpLoad %9 
					                               f32_2 %289 = OpVectorShuffle %288 %288 0 1 
					                               f32_4 %290 = OpImageSampleImplicitLod %287 %289 
					                               f32_2 %291 = OpVectorShuffle %290 %290 0 1 
					                               f32_3 %292 = OpLoad %9 
					                               f32_3 %293 = OpVectorShuffle %292 %291 3 4 2 
					                                              OpStore %9 %293 
					                               f32_3 %294 = OpLoad %9 
					                               f32_2 %295 = OpVectorShuffle %294 %294 0 1 
					                               f32_2 %296 = OpFNegate %295 
					                               f32_2 %297 = OpLoad vs_TEXCOORD0 
					                               f32_2 %298 = OpFAdd %296 %297 
					                               f32_3 %299 = OpLoad %9 
					                               f32_3 %300 = OpVectorShuffle %299 %298 3 4 2 
					                                              OpStore %9 %300 
					                               f32_3 %301 = OpLoad %9 
					                               f32_2 %302 = OpVectorShuffle %301 %301 0 1 
					                               f32_2 %303 = OpCompositeConstruct %34 %34 
					                               f32_2 %304 = OpCompositeConstruct %33 %33 
					                               f32_2 %305 = OpExtInst %1 43 %302 %303 %304 
					                               f32_3 %306 = OpLoad %9 
					                               f32_3 %307 = OpVectorShuffle %306 %305 3 4 2 
					                                              OpStore %9 %307 
					                               f32_3 %308 = OpLoad %9 
					                               f32_2 %309 = OpVectorShuffle %308 %308 0 1 
					                        Uniform f32* %310 = OpAccessChain %13 %47 
					                                 f32 %311 = OpLoad %310 
					                               f32_2 %312 = OpCompositeConstruct %311 %311 
					                               f32_2 %313 = OpFMul %309 %312 
					                               f32_3 %314 = OpLoad %9 
					                               f32_3 %315 = OpVectorShuffle %314 %313 3 4 2 
					                                              OpStore %9 %315 
					                 read_only Texture2D %317 = OpLoad %316 
					                             sampler %319 = OpLoad %318 
					          read_only Texture2DSampled %320 = OpSampledImage %317 %319 
					                               f32_3 %321 = OpLoad %9 
					                               f32_2 %322 = OpVectorShuffle %321 %321 0 1 
					                               f32_4 %323 = OpImageSampleImplicitLod %320 %322 
					                                 f32 %324 = OpCompositeExtract %323 0 
					                        Private f32* %325 = OpAccessChain %9 %69 
					                                              OpStore %325 %324 
					                                 f32 %326 = OpLoad %245 
					                        Private f32* %327 = OpAccessChain %9 %69 
					                                 f32 %328 = OpLoad %327 
					                                 f32 %329 = OpExtInst %1 40 %326 %328 
					                        Private f32* %330 = OpAccessChain %9 %69 
					                                              OpStore %330 %329 
					                                 f32 %331 = OpLoad %54 
					                        Private f32* %332 = OpAccessChain %9 %69 
					                                 f32 %333 = OpLoad %332 
					                                 f32 %334 = OpExtInst %1 37 %331 %333 
					                        Private f32* %335 = OpAccessChain %9 %69 
					                                              OpStore %335 %334 
					                        Private f32* %336 = OpAccessChain %28 %69 
					                                 f32 %337 = OpLoad %336 
					                                 f32 %338 = OpFNegate %337 
					                        Private f32* %339 = OpAccessChain %9 %69 
					                                 f32 %340 = OpLoad %339 
					                                 f32 %341 = OpFAdd %338 %340 
					                        Private f32* %342 = OpAccessChain %9 %69 
					                                              OpStore %342 %341 
					                        Uniform f32* %345 = OpAccessChain %13 %81 %78 
					                                 f32 %346 = OpLoad %345 
					                        Uniform f32* %347 = OpAccessChain %13 %81 %78 
					                                 f32 %348 = OpLoad %347 
					                        Uniform f32* %349 = OpAccessChain %13 %81 %78 
					                                 f32 %350 = OpLoad %349 
					                        Uniform f32* %351 = OpAccessChain %13 %81 %78 
					                                 f32 %352 = OpLoad %351 
					                               f32_4 %353 = OpCompositeConstruct %346 %348 %350 %352 
					                               f32_3 %354 = OpLoad %9 
					                               f32_4 %355 = OpVectorShuffle %354 %354 0 0 0 0 
					                               f32_4 %356 = OpFMul %353 %355 
					                               f32_4 %357 = OpLoad %28 
					                               f32_4 %358 = OpVectorShuffle %357 %357 0 0 0 0 
					                               f32_4 %359 = OpFAdd %356 %358 
					                                              OpStore %344 %359 
					                                              OpReturn
					                                              OpFunctionEnd"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4[2];
						vec3 _TaaParams;
					};
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CameraMotionVectorsTexture;
					UNITY_LOCATION(2) uniform  sampler2D _CoCTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat5;
					bool u_xlatb5;
					bool u_xlatb6;
					float u_xlat8;
					bool u_xlatb9;
					vec2 u_xlat11;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
					    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat12 = texture(_CoCTex, u_xlat1.xy).x;
					    u_xlat0.z = texture(_CoCTex, u_xlat1.zw).x;
					    u_xlat1.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1.x = texture(_CoCTex, u_xlat1.xy).x;
					    u_xlatb5 = u_xlat12<u_xlat1.x;
					    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
					    u_xlat12 = max(u_xlat12, u_xlat1.x);
					    u_xlat12 = max(u_xlat0.z, u_xlat12);
					    u_xlatb9 = u_xlat0.z<u_xlat2.z;
					    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
					    u_xlat11.xy = (-u_xlat3.xy);
					    u_xlat2.xy = bool(u_xlatb5) ? u_xlat11.xy : vec2(0.0, 0.0);
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
					    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat5.z = texture(_CoCTex, u_xlat2.xy).x;
					    u_xlat2.x = texture(_CoCTex, u_xlat2.zw).x;
					    u_xlatb6 = u_xlat5.z<u_xlat0.z;
					    u_xlat5.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
					    u_xlat12 = max(u_xlat12, u_xlat5.z);
					    u_xlat12 = max(u_xlat2.x, u_xlat12);
					    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
					    u_xlatb5 = u_xlat2.x<u_xlat0.z;
					    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
					    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat0.xy = texture(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
					    u_xlat0.xy = (-u_xlat0.xy) + vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
					    u_xlat0.x = max(u_xlat8, u_xlat0.x);
					    u_xlat0.x = min(u_xlat12, u_xlat0.x);
					    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
					    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat1.xxxx;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!GL4x"
				}
				SubProgram "vulkan " {
					"spirv"
				}
			}
		}
		Pass {
			Name "Downsample and Prefilter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 131320
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform VGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[5];
					};
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD1;
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
					"!!GL4x
					#ifdef VERTEX
					#version 420
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_shading_language_420pack : require
					
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
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD1;
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
					#version 420
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_shading_language_420pack : require
					
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
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _MaxCoC;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CoCTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1.xyz = texture(_MainTex, u_xlat0.zw).xyz;
					    u_xlat13 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat13 = max(u_xlat1.z, u_xlat13);
					    u_xlat13 = u_xlat13 + 1.0;
					    u_xlat8 = texture(_CoCTex, u_xlat0.zw).x;
					    u_xlat8 = u_xlat8 * 2.0 + -1.0;
					    u_xlat12 = abs(u_xlat8) / u_xlat13;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
					    u_xlat0.x = texture(_CoCTex, u_xlat0.xy).x;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat4 = max(u_xlat2.y, u_xlat2.x);
					    u_xlat4 = max(u_xlat2.z, u_xlat4);
					    u_xlat4 = u_xlat4 + 1.0;
					    u_xlat4 = abs(u_xlat0.x) / u_xlat4;
					    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat4) + u_xlat1.xyz;
					    u_xlat4 = u_xlat12 + u_xlat4;
					    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat3.xyz = texture(_MainTex, u_xlat2.xy).xyz;
					    u_xlat12 = max(u_xlat3.y, u_xlat3.x);
					    u_xlat12 = max(u_xlat3.z, u_xlat12);
					    u_xlat12 = u_xlat12 + 1.0;
					    u_xlat13 = texture(_CoCTex, u_xlat2.xy).x;
					    u_xlat13 = u_xlat13 * 2.0 + -1.0;
					    u_xlat12 = abs(u_xlat13) / u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat4 = u_xlat12 + u_xlat4;
					    u_xlat3.xyz = texture(_MainTex, u_xlat2.zw).xyz;
					    u_xlat12 = texture(_CoCTex, u_xlat2.zw).x;
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat2.x = max(u_xlat3.y, u_xlat3.x);
					    u_xlat2.x = max(u_xlat3.z, u_xlat2.x);
					    u_xlat2.x = u_xlat2.x + 1.0;
					    u_xlat2.x = abs(u_xlat12) / u_xlat2.x;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat4 = u_xlat4 + u_xlat2.x;
					    u_xlat4 = max(u_xlat4, 9.99999975e-05);
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat4);
					    u_xlat4 = min(u_xlat8, u_xlat13);
					    u_xlat8 = max(u_xlat8, u_xlat13);
					    u_xlat8 = max(u_xlat12, u_xlat8);
					    u_xlat4 = min(u_xlat12, u_xlat4);
					    u_xlat4 = min(u_xlat4, u_xlat0.x);
					    u_xlat0.x = max(u_xlat8, u_xlat0.x);
					    u_xlatb8 = u_xlat0.x<(-u_xlat4);
					    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MaxCoC;
					    u_xlat4 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat4 = float(1.0) / u_xlat4;
					    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.x;
					    u_xlat0.x = u_xlat4 * -2.0 + 3.0;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat0.x = u_xlat4 * u_xlat0.x;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
					; Bound: 355
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %26 %328 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %10 0 Offset 10 
					                                             OpMemberDecorate %10 1 Offset 10 
					                                             OpMemberDecorate %10 2 Offset 10 
					                                             OpDecorate %10 Block 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate vs_TEXCOORD0 Location 26 
					                                             OpDecorate %48 DescriptorSet 48 
					                                             OpDecorate %48 Binding 48 
					                                             OpDecorate %52 DescriptorSet 52 
					                                             OpDecorate %52 Binding 52 
					                                             OpDecorate %78 DescriptorSet 78 
					                                             OpDecorate %78 Binding 78 
					                                             OpDecorate %80 DescriptorSet 80 
					                                             OpDecorate %80 Binding 80 
					                                             OpDecorate %328 Location 328 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeStruct %6 %7 %6 
					                                     %11 = OpTypePointer Uniform %10 
					  Uniform struct {f32; f32_4; f32;}* %12 = OpVariable Uniform 
					                                     %13 = OpTypeInt 32 1 
					                                 i32 %14 = OpConstant 1 
					                                     %15 = OpTypePointer Uniform %7 
					                                 f32 %20 = OpConstant 3,674022E-40 
					                                 f32 %21 = OpConstant 3,674022E-40 
					                               f32_4 %22 = OpConstantComposite %20 %20 %21 %20 
					                                     %24 = OpTypeVector %6 2 
					                                     %25 = OpTypePointer Input %24 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 f32 %31 = OpConstant 3,674022E-40 
					                                 f32 %32 = OpConstant 3,674022E-40 
					                                 i32 %37 = OpConstant 0 
					                                     %38 = OpTypePointer Uniform %6 
					                                     %43 = OpTypeVector %6 3 
					                                     %44 = OpTypePointer Private %43 
					                      Private f32_3* %45 = OpVariable Private 
					                                     %46 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %47 = OpTypePointer UniformConstant %46 
					UniformConstant read_only Texture2D* %48 = OpVariable UniformConstant 
					                                     %50 = OpTypeSampler 
					                                     %51 = OpTypePointer UniformConstant %50 
					            UniformConstant sampler* %52 = OpVariable UniformConstant 
					                                     %54 = OpTypeSampledImage %46 
					                                     %60 = OpTypePointer Private %6 
					                        Private f32* %61 = OpVariable Private 
					                                     %62 = OpTypeInt 32 0 
					                                 u32 %63 = OpConstant 1 
					                                 u32 %66 = OpConstant 0 
					                                 u32 %70 = OpConstant 2 
					                        Private f32* %77 = OpVariable Private 
					UniformConstant read_only Texture2D* %78 = OpVariable UniformConstant 
					            UniformConstant sampler* %80 = OpVariable UniformConstant 
					                                 f32 %88 = OpConstant 3,674022E-40 
					                                 f32 %90 = OpConstant 3,674022E-40 
					                        Private f32* %92 = OpVariable Private 
					                     Private f32_4* %101 = OpVariable Private 
					                       Private f32* %124 = OpVariable Private 
					                              f32_4 %154 = OpConstantComposite %21 %20 %20 %20 
					                     Private f32_3* %168 = OpVariable Private 
					                                f32 %260 = OpConstant 3,674022E-40 
					                                    %287 = OpTypeBool 
					                                    %288 = OpTypePointer Private %287 
					                      Private bool* %289 = OpVariable Private 
					                                    %296 = OpTypePointer Function %6 
					                                i32 %308 = OpConstant 2 
					                                    %327 = OpTypePointer Output %7 
					                      Output f32_4* %328 = OpVariable Output 
					                                u32 %331 = OpConstant 3 
					                                    %332 = OpTypePointer Output %6 
					                                f32 %335 = OpConstant 3,674022E-40 
					                                f32 %337 = OpConstant 3,674022E-40 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                      Function f32* %297 = OpVariable Function 
					                      Uniform f32_4* %16 = OpAccessChain %12 %14 
					                               f32_4 %17 = OpLoad %16 
					                               f32_4 %18 = OpVectorShuffle %17 %17 0 1 0 1 
					                               f32_4 %19 = OpFNegate %18 
					                               f32_4 %23 = OpFMul %19 %22 
					                               f32_2 %27 = OpLoad vs_TEXCOORD0 
					                               f32_4 %28 = OpVectorShuffle %27 %27 0 1 0 1 
					                               f32_4 %29 = OpFAdd %23 %28 
					                                             OpStore %9 %29 
					                               f32_4 %30 = OpLoad %9 
					                               f32_4 %33 = OpCompositeConstruct %31 %31 %31 %31 
					                               f32_4 %34 = OpCompositeConstruct %32 %32 %32 %32 
					                               f32_4 %35 = OpExtInst %1 43 %30 %33 %34 
					                                             OpStore %9 %35 
					                               f32_4 %36 = OpLoad %9 
					                        Uniform f32* %39 = OpAccessChain %12 %37 
					                                 f32 %40 = OpLoad %39 
					                               f32_4 %41 = OpCompositeConstruct %40 %40 %40 %40 
					                               f32_4 %42 = OpFMul %36 %41 
					                                             OpStore %9 %42 
					                 read_only Texture2D %49 = OpLoad %48 
					                             sampler %53 = OpLoad %52 
					          read_only Texture2DSampled %55 = OpSampledImage %49 %53 
					                               f32_4 %56 = OpLoad %9 
					                               f32_2 %57 = OpVectorShuffle %56 %56 2 3 
					                               f32_4 %58 = OpImageSampleImplicitLod %55 %57 
					                               f32_3 %59 = OpVectorShuffle %58 %58 0 1 2 
					                                             OpStore %45 %59 
					                        Private f32* %64 = OpAccessChain %45 %63 
					                                 f32 %65 = OpLoad %64 
					                        Private f32* %67 = OpAccessChain %45 %66 
					                                 f32 %68 = OpLoad %67 
					                                 f32 %69 = OpExtInst %1 40 %65 %68 
					                                             OpStore %61 %69 
					                        Private f32* %71 = OpAccessChain %45 %70 
					                                 f32 %72 = OpLoad %71 
					                                 f32 %73 = OpLoad %61 
					                                 f32 %74 = OpExtInst %1 40 %72 %73 
					                                             OpStore %61 %74 
					                                 f32 %75 = OpLoad %61 
					                                 f32 %76 = OpFAdd %75 %32 
					                                             OpStore %61 %76 
					                 read_only Texture2D %79 = OpLoad %78 
					                             sampler %81 = OpLoad %80 
					          read_only Texture2DSampled %82 = OpSampledImage %79 %81 
					                               f32_4 %83 = OpLoad %9 
					                               f32_2 %84 = OpVectorShuffle %83 %83 2 3 
					                               f32_4 %85 = OpImageSampleImplicitLod %82 %84 
					                                 f32 %86 = OpCompositeExtract %85 0 
					                                             OpStore %77 %86 
					                                 f32 %87 = OpLoad %77 
					                                 f32 %89 = OpFMul %87 %88 
					                                 f32 %91 = OpFAdd %89 %90 
					                                             OpStore %77 %91 
					                                 f32 %93 = OpLoad %77 
					                                 f32 %94 = OpExtInst %1 4 %93 
					                                 f32 %95 = OpLoad %61 
					                                 f32 %96 = OpFDiv %94 %95 
					                                             OpStore %92 %96 
					                                 f32 %97 = OpLoad %92 
					                               f32_3 %98 = OpCompositeConstruct %97 %97 %97 
					                               f32_3 %99 = OpLoad %45 
					                              f32_3 %100 = OpFMul %98 %99 
					                                             OpStore %45 %100 
					                read_only Texture2D %102 = OpLoad %48 
					                            sampler %103 = OpLoad %52 
					         read_only Texture2DSampled %104 = OpSampledImage %102 %103 
					                              f32_4 %105 = OpLoad %9 
					                              f32_2 %106 = OpVectorShuffle %105 %105 0 1 
					                              f32_4 %107 = OpImageSampleImplicitLod %104 %106 
					                              f32_3 %108 = OpVectorShuffle %107 %107 0 1 2 
					                              f32_4 %109 = OpLoad %101 
					                              f32_4 %110 = OpVectorShuffle %109 %108 4 5 6 3 
					                                             OpStore %101 %110 
					                read_only Texture2D %111 = OpLoad %78 
					                            sampler %112 = OpLoad %80 
					         read_only Texture2DSampled %113 = OpSampledImage %111 %112 
					                              f32_4 %114 = OpLoad %9 
					                              f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                              f32_4 %116 = OpImageSampleImplicitLod %113 %115 
					                                f32 %117 = OpCompositeExtract %116 0 
					                       Private f32* %118 = OpAccessChain %9 %66 
					                                             OpStore %118 %117 
					                       Private f32* %119 = OpAccessChain %9 %66 
					                                f32 %120 = OpLoad %119 
					                                f32 %121 = OpFMul %120 %88 
					                                f32 %122 = OpFAdd %121 %90 
					                       Private f32* %123 = OpAccessChain %9 %66 
					                                             OpStore %123 %122 
					                       Private f32* %125 = OpAccessChain %101 %63 
					                                f32 %126 = OpLoad %125 
					                       Private f32* %127 = OpAccessChain %101 %66 
					                                f32 %128 = OpLoad %127 
					                                f32 %129 = OpExtInst %1 40 %126 %128 
					                                             OpStore %124 %129 
					                       Private f32* %130 = OpAccessChain %101 %70 
					                                f32 %131 = OpLoad %130 
					                                f32 %132 = OpLoad %124 
					                                f32 %133 = OpExtInst %1 40 %131 %132 
					                                             OpStore %124 %133 
					                                f32 %134 = OpLoad %124 
					                                f32 %135 = OpFAdd %134 %32 
					                                             OpStore %124 %135 
					                       Private f32* %136 = OpAccessChain %9 %66 
					                                f32 %137 = OpLoad %136 
					                                f32 %138 = OpExtInst %1 4 %137 
					                                f32 %139 = OpLoad %124 
					                                f32 %140 = OpFDiv %138 %139 
					                                             OpStore %124 %140 
					                              f32_4 %141 = OpLoad %101 
					                              f32_3 %142 = OpVectorShuffle %141 %141 0 1 2 
					                                f32 %143 = OpLoad %124 
					                              f32_3 %144 = OpCompositeConstruct %143 %143 %143 
					                              f32_3 %145 = OpFMul %142 %144 
					                              f32_3 %146 = OpLoad %45 
					                              f32_3 %147 = OpFAdd %145 %146 
					                                             OpStore %45 %147 
					                                f32 %148 = OpLoad %92 
					                                f32 %149 = OpLoad %124 
					                                f32 %150 = OpFAdd %148 %149 
					                                             OpStore %124 %150 
					                     Uniform f32_4* %151 = OpAccessChain %12 %14 
					                              f32_4 %152 = OpLoad %151 
					                              f32_4 %153 = OpVectorShuffle %152 %152 0 1 0 1 
					                              f32_4 %155 = OpFMul %153 %154 
					                              f32_2 %156 = OpLoad vs_TEXCOORD0 
					                              f32_4 %157 = OpVectorShuffle %156 %156 0 1 0 1 
					                              f32_4 %158 = OpFAdd %155 %157 
					                                             OpStore %101 %158 
					                              f32_4 %159 = OpLoad %101 
					                              f32_4 %160 = OpCompositeConstruct %31 %31 %31 %31 
					                              f32_4 %161 = OpCompositeConstruct %32 %32 %32 %32 
					                              f32_4 %162 = OpExtInst %1 43 %159 %160 %161 
					                                             OpStore %101 %162 
					                              f32_4 %163 = OpLoad %101 
					                       Uniform f32* %164 = OpAccessChain %12 %37 
					                                f32 %165 = OpLoad %164 
					                              f32_4 %166 = OpCompositeConstruct %165 %165 %165 %165 
					                              f32_4 %167 = OpFMul %163 %166 
					                                             OpStore %101 %167 
					                read_only Texture2D %169 = OpLoad %48 
					                            sampler %170 = OpLoad %52 
					         read_only Texture2DSampled %171 = OpSampledImage %169 %170 
					                              f32_4 %172 = OpLoad %101 
					                              f32_2 %173 = OpVectorShuffle %172 %172 0 1 
					                              f32_4 %174 = OpImageSampleImplicitLod %171 %173 
					                              f32_3 %175 = OpVectorShuffle %174 %174 0 1 2 
					                                             OpStore %168 %175 
					                       Private f32* %176 = OpAccessChain %168 %63 
					                                f32 %177 = OpLoad %176 
					                       Private f32* %178 = OpAccessChain %168 %66 
					                                f32 %179 = OpLoad %178 
					                                f32 %180 = OpExtInst %1 40 %177 %179 
					                                             OpStore %92 %180 
					                       Private f32* %181 = OpAccessChain %168 %70 
					                                f32 %182 = OpLoad %181 
					                                f32 %183 = OpLoad %92 
					                                f32 %184 = OpExtInst %1 40 %182 %183 
					                                             OpStore %92 %184 
					                                f32 %185 = OpLoad %92 
					                                f32 %186 = OpFAdd %185 %32 
					                                             OpStore %92 %186 
					                read_only Texture2D %187 = OpLoad %78 
					                            sampler %188 = OpLoad %80 
					         read_only Texture2DSampled %189 = OpSampledImage %187 %188 
					                              f32_4 %190 = OpLoad %101 
					                              f32_2 %191 = OpVectorShuffle %190 %190 0 1 
					                              f32_4 %192 = OpImageSampleImplicitLod %189 %191 
					                                f32 %193 = OpCompositeExtract %192 0 
					                                             OpStore %61 %193 
					                                f32 %194 = OpLoad %61 
					                                f32 %195 = OpFMul %194 %88 
					                                f32 %196 = OpFAdd %195 %90 
					                                             OpStore %61 %196 
					                                f32 %197 = OpLoad %61 
					                                f32 %198 = OpExtInst %1 4 %197 
					                                f32 %199 = OpLoad %92 
					                                f32 %200 = OpFDiv %198 %199 
					                                             OpStore %92 %200 
					                              f32_3 %201 = OpLoad %168 
					                                f32 %202 = OpLoad %92 
					                              f32_3 %203 = OpCompositeConstruct %202 %202 %202 
					                              f32_3 %204 = OpFMul %201 %203 
					                              f32_3 %205 = OpLoad %45 
					                              f32_3 %206 = OpFAdd %204 %205 
					                                             OpStore %45 %206 
					                                f32 %207 = OpLoad %92 
					                                f32 %208 = OpLoad %124 
					                                f32 %209 = OpFAdd %207 %208 
					                                             OpStore %124 %209 
					                read_only Texture2D %210 = OpLoad %48 
					                            sampler %211 = OpLoad %52 
					         read_only Texture2DSampled %212 = OpSampledImage %210 %211 
					                              f32_4 %213 = OpLoad %101 
					                              f32_2 %214 = OpVectorShuffle %213 %213 2 3 
					                              f32_4 %215 = OpImageSampleImplicitLod %212 %214 
					                              f32_3 %216 = OpVectorShuffle %215 %215 0 1 2 
					                                             OpStore %168 %216 
					                read_only Texture2D %217 = OpLoad %78 
					                            sampler %218 = OpLoad %80 
					         read_only Texture2DSampled %219 = OpSampledImage %217 %218 
					                              f32_4 %220 = OpLoad %101 
					                              f32_2 %221 = OpVectorShuffle %220 %220 2 3 
					                              f32_4 %222 = OpImageSampleImplicitLod %219 %221 
					                                f32 %223 = OpCompositeExtract %222 0 
					                                             OpStore %92 %223 
					                                f32 %224 = OpLoad %92 
					                                f32 %225 = OpFMul %224 %88 
					                                f32 %226 = OpFAdd %225 %90 
					                                             OpStore %92 %226 
					                       Private f32* %227 = OpAccessChain %168 %63 
					                                f32 %228 = OpLoad %227 
					                       Private f32* %229 = OpAccessChain %168 %66 
					                                f32 %230 = OpLoad %229 
					                                f32 %231 = OpExtInst %1 40 %228 %230 
					                       Private f32* %232 = OpAccessChain %101 %66 
					                                             OpStore %232 %231 
					                       Private f32* %233 = OpAccessChain %168 %70 
					                                f32 %234 = OpLoad %233 
					                       Private f32* %235 = OpAccessChain %101 %66 
					                                f32 %236 = OpLoad %235 
					                                f32 %237 = OpExtInst %1 40 %234 %236 
					                       Private f32* %238 = OpAccessChain %101 %66 
					                                             OpStore %238 %237 
					                       Private f32* %239 = OpAccessChain %101 %66 
					                                f32 %240 = OpLoad %239 
					                                f32 %241 = OpFAdd %240 %32 
					                       Private f32* %242 = OpAccessChain %101 %66 
					                                             OpStore %242 %241 
					                                f32 %243 = OpLoad %92 
					                                f32 %244 = OpExtInst %1 4 %243 
					                       Private f32* %245 = OpAccessChain %101 %66 
					                                f32 %246 = OpLoad %245 
					                                f32 %247 = OpFDiv %244 %246 
					                       Private f32* %248 = OpAccessChain %101 %66 
					                                             OpStore %248 %247 
					                              f32_3 %249 = OpLoad %168 
					                              f32_4 %250 = OpLoad %101 
					                              f32_3 %251 = OpVectorShuffle %250 %250 0 0 0 
					                              f32_3 %252 = OpFMul %249 %251 
					                              f32_3 %253 = OpLoad %45 
					                              f32_3 %254 = OpFAdd %252 %253 
					                                             OpStore %45 %254 
					                                f32 %255 = OpLoad %124 
					                       Private f32* %256 = OpAccessChain %101 %66 
					                                f32 %257 = OpLoad %256 
					                                f32 %258 = OpFAdd %255 %257 
					                                             OpStore %124 %258 
					                                f32 %259 = OpLoad %124 
					                                f32 %261 = OpExtInst %1 40 %259 %260 
					                                             OpStore %124 %261 
					                              f32_3 %262 = OpLoad %45 
					                                f32 %263 = OpLoad %124 
					                              f32_3 %264 = OpCompositeConstruct %263 %263 %263 
					                              f32_3 %265 = OpFDiv %262 %264 
					                                             OpStore %45 %265 
					                                f32 %266 = OpLoad %77 
					                                f32 %267 = OpLoad %61 
					                                f32 %268 = OpExtInst %1 37 %266 %267 
					                                             OpStore %124 %268 
					                                f32 %269 = OpLoad %77 
					                                f32 %270 = OpLoad %61 
					                                f32 %271 = OpExtInst %1 40 %269 %270 
					                                             OpStore %77 %271 
					                                f32 %272 = OpLoad %92 
					                                f32 %273 = OpLoad %77 
					                                f32 %274 = OpExtInst %1 40 %272 %273 
					                                             OpStore %77 %274 
					                                f32 %275 = OpLoad %92 
					                                f32 %276 = OpLoad %124 
					                                f32 %277 = OpExtInst %1 37 %275 %276 
					                                             OpStore %124 %277 
					                                f32 %278 = OpLoad %124 
					                       Private f32* %279 = OpAccessChain %9 %66 
					                                f32 %280 = OpLoad %279 
					                                f32 %281 = OpExtInst %1 37 %278 %280 
					                                             OpStore %124 %281 
					                                f32 %282 = OpLoad %77 
					                       Private f32* %283 = OpAccessChain %9 %66 
					                                f32 %284 = OpLoad %283 
					                                f32 %285 = OpExtInst %1 40 %282 %284 
					                       Private f32* %286 = OpAccessChain %9 %66 
					                                             OpStore %286 %285 
					                       Private f32* %290 = OpAccessChain %9 %66 
					                                f32 %291 = OpLoad %290 
					                                f32 %292 = OpLoad %124 
					                                f32 %293 = OpFNegate %292 
					                               bool %294 = OpFOrdLessThan %291 %293 
					                                             OpStore %289 %294 
					                               bool %295 = OpLoad %289 
					                                             OpSelectionMerge %299 None 
					                                             OpBranchConditional %295 %298 %301 
					                                    %298 = OpLabel 
					                                f32 %300 = OpLoad %124 
					                                             OpStore %297 %300 
					                                             OpBranch %299 
					                                    %301 = OpLabel 
					                       Private f32* %302 = OpAccessChain %9 %66 
					                                f32 %303 = OpLoad %302 
					                                             OpStore %297 %303 
					                                             OpBranch %299 
					                                    %299 = OpLabel 
					                                f32 %304 = OpLoad %297 
					                       Private f32* %305 = OpAccessChain %9 %66 
					                                             OpStore %305 %304 
					                       Private f32* %306 = OpAccessChain %9 %66 
					                                f32 %307 = OpLoad %306 
					                       Uniform f32* %309 = OpAccessChain %12 %308 
					                                f32 %310 = OpLoad %309 
					                                f32 %311 = OpFMul %307 %310 
					                       Private f32* %312 = OpAccessChain %9 %66 
					                                             OpStore %312 %311 
					                       Uniform f32* %313 = OpAccessChain %12 %14 %63 
					                                f32 %314 = OpLoad %313 
					                       Uniform f32* %315 = OpAccessChain %12 %14 %63 
					                                f32 %316 = OpLoad %315 
					                                f32 %317 = OpFAdd %314 %316 
					                                             OpStore %124 %317 
					                                f32 %318 = OpLoad %124 
					                                f32 %319 = OpFDiv %32 %318 
					                                             OpStore %124 %319 
					                                f32 %320 = OpLoad %124 
					                       Private f32* %321 = OpAccessChain %9 %66 
					                                f32 %322 = OpLoad %321 
					                                f32 %323 = OpExtInst %1 4 %322 
					                                f32 %324 = OpFMul %320 %323 
					                                             OpStore %124 %324 
					                                f32 %325 = OpLoad %124 
					                                f32 %326 = OpExtInst %1 43 %325 %31 %32 
					                                             OpStore %124 %326 
					                       Private f32* %329 = OpAccessChain %9 %66 
					                                f32 %330 = OpLoad %329 
					                        Output f32* %333 = OpAccessChain %328 %331 
					                                             OpStore %333 %330 
					                                f32 %334 = OpLoad %124 
					                                f32 %336 = OpFMul %334 %335 
					                                f32 %338 = OpFAdd %336 %337 
					                       Private f32* %339 = OpAccessChain %9 %66 
					                                             OpStore %339 %338 
					                                f32 %340 = OpLoad %124 
					                                f32 %341 = OpLoad %124 
					                                f32 %342 = OpFMul %340 %341 
					                                             OpStore %124 %342 
					                                f32 %343 = OpLoad %124 
					                       Private f32* %344 = OpAccessChain %9 %66 
					                                f32 %345 = OpLoad %344 
					                                f32 %346 = OpFMul %343 %345 
					                       Private f32* %347 = OpAccessChain %9 %66 
					                                             OpStore %347 %346 
					                              f32_4 %348 = OpLoad %9 
					                              f32_3 %349 = OpVectorShuffle %348 %348 0 0 0 
					                              f32_3 %350 = OpLoad %45 
					                              f32_3 %351 = OpFMul %349 %350 
					                              f32_4 %352 = OpLoad %328 
					                              f32_4 %353 = OpVectorShuffle %352 %351 4 5 6 3 
					                                             OpStore %328 %353 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						vec4 unused_0_6;
					};
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CoCTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1.xyz = texture(_MainTex, u_xlat0.zw).xyz;
					    u_xlat13 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat13 = max(u_xlat1.z, u_xlat13);
					    u_xlat13 = u_xlat13 + 1.0;
					    u_xlat8 = texture(_CoCTex, u_xlat0.zw).x;
					    u_xlat8 = u_xlat8 * 2.0 + -1.0;
					    u_xlat12 = abs(u_xlat8) / u_xlat13;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
					    u_xlat0.x = texture(_CoCTex, u_xlat0.xy).x;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat4 = max(u_xlat2.y, u_xlat2.x);
					    u_xlat4 = max(u_xlat2.z, u_xlat4);
					    u_xlat4 = u_xlat4 + 1.0;
					    u_xlat4 = abs(u_xlat0.x) / u_xlat4;
					    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat4) + u_xlat1.xyz;
					    u_xlat4 = u_xlat12 + u_xlat4;
					    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat3.xyz = texture(_MainTex, u_xlat2.xy).xyz;
					    u_xlat12 = max(u_xlat3.y, u_xlat3.x);
					    u_xlat12 = max(u_xlat3.z, u_xlat12);
					    u_xlat12 = u_xlat12 + 1.0;
					    u_xlat13 = texture(_CoCTex, u_xlat2.xy).x;
					    u_xlat13 = u_xlat13 * 2.0 + -1.0;
					    u_xlat12 = abs(u_xlat13) / u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat4 = u_xlat12 + u_xlat4;
					    u_xlat3.xyz = texture(_MainTex, u_xlat2.zw).xyz;
					    u_xlat12 = texture(_CoCTex, u_xlat2.zw).x;
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat2.x = max(u_xlat3.y, u_xlat3.x);
					    u_xlat2.x = max(u_xlat3.z, u_xlat2.x);
					    u_xlat2.x = u_xlat2.x + 1.0;
					    u_xlat2.x = abs(u_xlat12) / u_xlat2.x;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat4 = u_xlat4 + u_xlat2.x;
					    u_xlat4 = max(u_xlat4, 9.99999975e-05);
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat4);
					    u_xlat4 = min(u_xlat8, u_xlat13);
					    u_xlat8 = max(u_xlat8, u_xlat13);
					    u_xlat8 = max(u_xlat12, u_xlat8);
					    u_xlat4 = min(u_xlat12, u_xlat4);
					    u_xlat4 = min(u_xlat4, u_xlat0.x);
					    u_xlat0.x = max(u_xlat8, u_xlat0.x);
					    u_xlatb8 = u_xlat0.x<(-u_xlat4);
					    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MaxCoC;
					    u_xlat4 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat4 = float(1.0) / u_xlat4;
					    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.x;
					    u_xlat0.x = u_xlat4 * -2.0 + 3.0;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat0.x = u_xlat4 * u_xlat0.x;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!GL4x"
				}
				SubProgram "vulkan " {
					"spirv"
				}
			}
		}
		Pass {
			Name "Bokeh Filter (small)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 218675
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[16];
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _MaxCoC;
					uniform 	float _RcpAspect;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
						ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
						ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
						ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
						ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
						ImmCB_0_0_0[6] = vec2(1.0, 0.0);
						ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
						ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
						ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
						ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
						ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
						ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
						ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
						ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.196349546;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
					; Bound: 321
					; Schema: 0
					                                                OpCapability Shader 
					                                         %1 = OpExtInstImport "GLSL.std.450" 
					                                                OpMemoryModel Logical GLSL450 
					                                                OpEntryPoint Fragment %4 "main" %22 %159 %305 
					                                                OpExecutionMode %4 OriginUpperLeft 
					                                                OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                OpDecorate %12 DescriptorSet 12 
					                                                OpDecorate %12 Binding 12 
					                                                OpDecorate %16 DescriptorSet 16 
					                                                OpDecorate %16 Binding 16 
					                                                OpDecorate vs_TEXCOORD1 Location 22 
					                                                OpMemberDecorate %33 0 Offset 33 
					                                                OpMemberDecorate %33 1 Offset 33 
					                                                OpMemberDecorate %33 2 Offset 33 
					                                                OpMemberDecorate %33 3 Offset 33 
					                                                OpDecorate %33 Block 
					                                                OpDecorate %35 DescriptorSet 35 
					                                                OpDecorate %35 Binding 35 
					                                                OpDecorate vs_TEXCOORD0 Location 159 
					                                                OpDecorate %305 Location 305 
					                                         %2 = OpTypeVoid 
					                                         %3 = OpTypeFunction %2 
					                                         %6 = OpTypeFloat 32 
					                                         %7 = OpTypeVector %6 3 
					                                         %8 = OpTypePointer Private %7 
					                          Private f32_3* %9 = OpVariable Private 
					                                        %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                        %11 = OpTypePointer UniformConstant %10 
					   UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                        %14 = OpTypeSampler 
					                                        %15 = OpTypePointer UniformConstant %14 
					               UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                        %18 = OpTypeSampledImage %10 
					                                        %20 = OpTypeVector %6 2 
					                                        %21 = OpTypePointer Input %20 
					                  Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                        %24 = OpTypeVector %6 4 
					                                        %26 = OpTypeInt 32 0 
					                                    u32 %27 = OpConstant 3 
					                                    u32 %29 = OpConstant 0 
					                                        %30 = OpTypePointer Private %6 
					                           Private f32* %32 = OpVariable Private 
					                                        %33 = OpTypeStruct %6 %24 %6 %6 
					                                        %34 = OpTypePointer Uniform %33 
					Uniform struct {f32; f32_4; f32; f32;}* %35 = OpVariable Uniform 
					                                        %36 = OpTypeInt 32 1 
					                                    i32 %37 = OpConstant 1 
					                                    u32 %38 = OpConstant 1 
					                                        %39 = OpTypePointer Uniform %6 
					                                        %45 = OpTypePointer Private %24 
					                         Private f32_4* %46 = OpVariable Private 
					                                    f32 %47 = OpConstant 3,674022E-40 
					                         Private f32_4* %49 = OpVariable Private 
					                                    f32 %50 = OpConstant 3,674022E-40 
					                                    u32 %53 = OpConstant 2 
					                         Private f32_4* %56 = OpVariable Private 
					                                        %61 = OpTypePointer Function %36 
					                                    i32 %63 = OpConstant 0 
					                                    i32 %70 = OpConstant 16 
					                                        %71 = OpTypeBool 
					                         Private f32_4* %73 = OpVariable Private 
					                                    i32 %74 = OpConstant 2 
					                                        %83 = OpTypeVector %26 4 
					                                    u32 %84 = OpConstant 16 
					                                        %85 = OpTypeArray %83 %84 
					                                  u32_4 %86 = OpConstantComposite %29 %29 %29 %29 
					                                    u32 %87 = OpConstant 1057727209 
					                                  u32_4 %88 = OpConstantComposite %87 %29 %29 %29 
					                                    u32 %89 = OpConstant 1043110300 
					                                    u32 %90 = OpConstant 1057279317 
					                                  u32_4 %91 = OpConstantComposite %89 %90 %29 %29 
					                                    u32 %92 = OpConstant 3202478008 
					                                    u32 %93 = OpConstant 1050945282 
					                                  u32_4 %94 = OpConstantComposite %92 %93 %29 %29 
					                                    u32 %95 = OpConstant 3202478006 
					                                    u32 %96 = OpConstant 3198428933 
					                                  u32_4 %97 = OpConstantComposite %95 %96 %29 %29 
					                                    u32 %98 = OpConstant 1043110305 
					                                    u32 %99 = OpConstant 3204762965 
					                                 u32_4 %100 = OpConstantComposite %98 %99 %29 %29 
					                                   u32 %101 = OpConstant 1065353216 
					                                 u32_4 %102 = OpConstantComposite %101 %29 %29 %29 
					                                   u32 %103 = OpConstant 1062149053 
					                                   u32 %104 = OpConstant 1058437400 
					                                 u32_4 %105 = OpConstantComposite %103 %104 %29 %29 
					                                   u32 %106 = OpConstant 1050556281 
					                                   u32 %107 = OpConstant 1064532081 
					                                 u32_4 %108 = OpConstantComposite %106 %107 %29 %29 
					                                   u32 %109 = OpConstant 3198039931 
					                                   u32 %110 = OpConstant 1064532080 
					                                 u32_4 %111 = OpConstantComposite %109 %110 %29 %29 
					                                   u32 %112 = OpConstant 3209632702 
					                                   u32 %113 = OpConstant 1058437399 
					                                 u32_4 %114 = OpConstantComposite %112 %113 %29 %29 
					                                   u32 %115 = OpConstant 3212836864 
					                                 u32_4 %116 = OpConstantComposite %115 %29 %29 %29 
					                                   u32 %117 = OpConstant 3209632700 
					                                   u32 %118 = OpConstant 3205921050 
					                                 u32_4 %119 = OpConstantComposite %117 %118 %29 %29 
					                                   u32 %120 = OpConstant 3198039918 
					                                   u32 %121 = OpConstant 3212015730 
					                                 u32_4 %122 = OpConstantComposite %120 %121 %29 %29 
					                                   u32 %123 = OpConstant 1050556286 
					                                   u32 %124 = OpConstant 3212015728 
					                                 u32_4 %125 = OpConstantComposite %123 %124 %29 %29 
					                                   u32 %126 = OpConstant 1062149052 
					                                   u32 %127 = OpConstant 3205921049 
					                                 u32_4 %128 = OpConstantComposite %126 %127 %29 %29 
					                             u32_4[16] %129 = OpConstantComposite %86 %88 %91 %94 %97 %100 %102 %105 %108 %111 %114 %116 %119 %122 %125 %128 
					                                       %131 = OpTypeVector %26 2 
					                                       %132 = OpTypePointer Function %85 
					                                       %134 = OpTypePointer Function %83 
					                          Private f32* %142 = OpVariable Private 
					                                   i32 %152 = OpConstant 3 
					                  Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                          Private f32* %185 = OpVariable Private 
					                                   f32 %199 = OpConstant 3,674022E-40 
					                                       %224 = OpTypePointer Private %71 
					                         Private bool* %225 = OpVariable Private 
					                          Private f32* %232 = OpVariable Private 
					                         Private bool* %256 = OpVariable Private 
					                         Private bool* %274 = OpVariable Private 
					                                   f32 %293 = OpConstant 3,674022E-40 
					                                       %304 = OpTypePointer Output %24 
					                         Output f32_4* %305 = OpVariable Output 
					                                       %316 = OpTypePointer Output %6 
					                                       %319 = OpTypePointer Private %36 
					                          Private i32* %320 = OpVariable Private 
					                                    void %4 = OpFunction None %3 
					                                         %5 = OpLabel 
					                          Function i32* %62 = OpVariable Function 
					                   Function u32_4[16]* %133 = OpVariable Function 
					                    read_only Texture2D %13 = OpLoad %12 
					                                sampler %17 = OpLoad %16 
					             read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                  f32_2 %23 = OpLoad vs_TEXCOORD1 
					                                  f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                                    f32 %28 = OpCompositeExtract %25 3 
					                           Private f32* %31 = OpAccessChain %9 %29 
					                                                OpStore %31 %28 
					                           Uniform f32* %40 = OpAccessChain %35 %37 %38 
					                                    f32 %41 = OpLoad %40 
					                           Uniform f32* %42 = OpAccessChain %35 %37 %38 
					                                    f32 %43 = OpLoad %42 
					                                    f32 %44 = OpFAdd %41 %43 
					                                                OpStore %32 %44 
					                           Private f32* %48 = OpAccessChain %46 %27 
					                                                OpStore %48 %47 
					                           Private f32* %51 = OpAccessChain %49 %29 
					                                                OpStore %51 %50 
					                           Private f32* %52 = OpAccessChain %49 %38 
					                                                OpStore %52 %50 
					                           Private f32* %54 = OpAccessChain %49 %53 
					                                                OpStore %54 %50 
					                           Private f32* %55 = OpAccessChain %49 %27 
					                                                OpStore %55 %50 
					                           Private f32* %57 = OpAccessChain %56 %29 
					                                                OpStore %57 %50 
					                           Private f32* %58 = OpAccessChain %56 %38 
					                                                OpStore %58 %50 
					                           Private f32* %59 = OpAccessChain %56 %53 
					                                                OpStore %59 %50 
					                           Private f32* %60 = OpAccessChain %56 %27 
					                                                OpStore %60 %50 
					                                                OpStore %62 %63 
					                                                OpBranch %64 
					                                        %64 = OpLabel 
					                                                OpLoopMerge %66 %67 None 
					                                                OpBranch %68 
					                                        %68 = OpLabel 
					                                    i32 %69 = OpLoad %62 
					                                   bool %72 = OpSLessThan %69 %70 
					                                                OpBranchConditional %72 %65 %66 
					                                        %65 = OpLabel 
					                           Uniform f32* %75 = OpAccessChain %35 %74 
					                                    f32 %76 = OpLoad %75 
					                           Uniform f32* %77 = OpAccessChain %35 %74 
					                                    f32 %78 = OpLoad %77 
					                                  f32_2 %79 = OpCompositeConstruct %76 %78 
					                                    f32 %80 = OpCompositeExtract %79 0 
					                                    f32 %81 = OpCompositeExtract %79 1 
					                                  f32_2 %82 = OpCompositeConstruct %80 %81 
					                                   i32 %130 = OpLoad %62 
					                                                OpStore %133 %129 
					                       Function u32_4* %135 = OpAccessChain %133 %130 
					                                 u32_4 %136 = OpLoad %135 
					                                 u32_2 %137 = OpVectorShuffle %136 %136 0 1 
					                                 f32_2 %138 = OpBitcast %137 
					                                 f32_2 %139 = OpFMul %82 %138 
					                                 f32_4 %140 = OpLoad %73 
					                                 f32_4 %141 = OpVectorShuffle %140 %139 0 4 5 3 
					                                                OpStore %73 %141 
					                                 f32_4 %143 = OpLoad %73 
					                                 f32_2 %144 = OpVectorShuffle %143 %143 1 2 
					                                 f32_4 %145 = OpLoad %73 
					                                 f32_2 %146 = OpVectorShuffle %145 %145 1 2 
					                                   f32 %147 = OpDot %144 %146 
					                                                OpStore %142 %147 
					                                   f32 %148 = OpLoad %142 
					                                   f32 %149 = OpExtInst %1 31 %148 
					                                                OpStore %142 %149 
					                          Private f32* %150 = OpAccessChain %73 %38 
					                                   f32 %151 = OpLoad %150 
					                          Uniform f32* %153 = OpAccessChain %35 %152 
					                                   f32 %154 = OpLoad %153 
					                                   f32 %155 = OpFMul %151 %154 
					                          Private f32* %156 = OpAccessChain %73 %29 
					                                                OpStore %156 %155 
					                                 f32_4 %157 = OpLoad %73 
					                                 f32_2 %158 = OpVectorShuffle %157 %157 0 2 
					                                 f32_2 %160 = OpLoad vs_TEXCOORD0 
					                                 f32_2 %161 = OpFAdd %158 %160 
					                                 f32_4 %162 = OpLoad %73 
					                                 f32_4 %163 = OpVectorShuffle %162 %161 4 5 2 3 
					                                                OpStore %73 %163 
					                                 f32_4 %164 = OpLoad %73 
					                                 f32_2 %165 = OpVectorShuffle %164 %164 0 1 
					                                 f32_2 %166 = OpCompositeConstruct %50 %50 
					                                 f32_2 %167 = OpCompositeConstruct %47 %47 
					                                 f32_2 %168 = OpExtInst %1 43 %165 %166 %167 
					                                 f32_4 %169 = OpLoad %73 
					                                 f32_4 %170 = OpVectorShuffle %169 %168 4 5 2 3 
					                                                OpStore %73 %170 
					                                 f32_4 %171 = OpLoad %73 
					                                 f32_2 %172 = OpVectorShuffle %171 %171 0 1 
					                          Uniform f32* %173 = OpAccessChain %35 %63 
					                                   f32 %174 = OpLoad %173 
					                                 f32_2 %175 = OpCompositeConstruct %174 %174 
					                                 f32_2 %176 = OpFMul %172 %175 
					                                 f32_4 %177 = OpLoad %73 
					                                 f32_4 %178 = OpVectorShuffle %177 %176 4 5 2 3 
					                                                OpStore %73 %178 
					                   read_only Texture2D %179 = OpLoad %12 
					                               sampler %180 = OpLoad %16 
					            read_only Texture2DSampled %181 = OpSampledImage %179 %180 
					                                 f32_4 %182 = OpLoad %73 
					                                 f32_2 %183 = OpVectorShuffle %182 %182 0 1 
					                                 f32_4 %184 = OpImageSampleImplicitLod %181 %183 
					                                                OpStore %73 %184 
					                          Private f32* %186 = OpAccessChain %9 %29 
					                                   f32 %187 = OpLoad %186 
					                          Private f32* %188 = OpAccessChain %73 %27 
					                                   f32 %189 = OpLoad %188 
					                                   f32 %190 = OpExtInst %1 37 %187 %189 
					                                                OpStore %185 %190 
					                                   f32 %191 = OpLoad %185 
					                                   f32 %192 = OpExtInst %1 40 %191 %50 
					                                                OpStore %185 %192 
					                                   f32 %193 = OpLoad %142 
					                                   f32 %194 = OpFNegate %193 
					                                   f32 %195 = OpLoad %185 
					                                   f32 %196 = OpFAdd %194 %195 
					                                                OpStore %185 %196 
					                          Uniform f32* %197 = OpAccessChain %35 %37 %38 
					                                   f32 %198 = OpLoad %197 
					                                   f32 %200 = OpFMul %198 %199 
					                                   f32 %201 = OpLoad %185 
					                                   f32 %202 = OpFAdd %200 %201 
					                                                OpStore %185 %202 
					                                   f32 %203 = OpLoad %185 
					                                   f32 %204 = OpLoad %32 
					                                   f32 %205 = OpFDiv %203 %204 
					                                                OpStore %185 %205 
					                                   f32 %206 = OpLoad %185 
					                                   f32 %207 = OpExtInst %1 43 %206 %50 %47 
					                                                OpStore %185 %207 
					                                   f32 %208 = OpLoad %142 
					                                   f32 %209 = OpFNegate %208 
					                          Private f32* %210 = OpAccessChain %73 %27 
					                                   f32 %211 = OpLoad %210 
					                                   f32 %212 = OpFNegate %211 
					                                   f32 %213 = OpFAdd %209 %212 
					                                                OpStore %142 %213 
					                          Uniform f32* %214 = OpAccessChain %35 %37 %38 
					                                   f32 %215 = OpLoad %214 
					                                   f32 %216 = OpFMul %215 %199 
					                                   f32 %217 = OpLoad %142 
					                                   f32 %218 = OpFAdd %216 %217 
					                                                OpStore %142 %218 
					                                   f32 %219 = OpLoad %142 
					                                   f32 %220 = OpLoad %32 
					                                   f32 %221 = OpFDiv %219 %220 
					                                                OpStore %142 %221 
					                                   f32 %222 = OpLoad %142 
					                                   f32 %223 = OpExtInst %1 43 %222 %50 %47 
					                                                OpStore %142 %223 
					                          Private f32* %226 = OpAccessChain %73 %27 
					                                   f32 %227 = OpLoad %226 
					                                   f32 %228 = OpFNegate %227 
					                          Uniform f32* %229 = OpAccessChain %35 %37 %38 
					                                   f32 %230 = OpLoad %229 
					                                  bool %231 = OpFOrdGreaterThanEqual %228 %230 
					                                                OpStore %225 %231 
					                                  bool %233 = OpLoad %225 
					                                   f32 %234 = OpSelect %233 %47 %50 
					                                                OpStore %232 %234 
					                                   f32 %235 = OpLoad %142 
					                                   f32 %236 = OpLoad %232 
					                                   f32 %237 = OpFMul %235 %236 
					                                                OpStore %142 %237 
					                                 f32_4 %238 = OpLoad %73 
					                                 f32_3 %239 = OpVectorShuffle %238 %238 0 1 2 
					                                 f32_4 %240 = OpLoad %46 
					                                 f32_4 %241 = OpVectorShuffle %240 %239 4 5 6 3 
					                                                OpStore %46 %241 
					                                 f32_4 %242 = OpLoad %46 
					                                   f32 %243 = OpLoad %185 
					                                 f32_4 %244 = OpCompositeConstruct %243 %243 %243 %243 
					                                 f32_4 %245 = OpFMul %242 %244 
					                                 f32_4 %246 = OpLoad %49 
					                                 f32_4 %247 = OpFAdd %245 %246 
					                                                OpStore %49 %247 
					                                 f32_4 %248 = OpLoad %46 
					                                   f32 %249 = OpLoad %142 
					                                 f32_4 %250 = OpCompositeConstruct %249 %249 %249 %249 
					                                 f32_4 %251 = OpFMul %248 %250 
					                                 f32_4 %252 = OpLoad %56 
					                                 f32_4 %253 = OpFAdd %251 %252 
					                                                OpStore %56 %253 
					                                                OpBranch %67 
					                                        %67 = OpLabel 
					                                   i32 %254 = OpLoad %62 
					                                   i32 %255 = OpIAdd %254 %37 
					                                                OpStore %62 %255 
					                                                OpBranch %64 
					                                        %66 = OpLabel 
					                          Private f32* %257 = OpAccessChain %49 %27 
					                                   f32 %258 = OpLoad %257 
					                                  bool %259 = OpFOrdEqual %258 %50 
					                                                OpStore %256 %259 
					                                  bool %260 = OpLoad %256 
					                                   f32 %261 = OpSelect %260 %47 %50 
					                          Private f32* %262 = OpAccessChain %9 %29 
					                                                OpStore %262 %261 
					                          Private f32* %263 = OpAccessChain %9 %29 
					                                   f32 %264 = OpLoad %263 
					                          Private f32* %265 = OpAccessChain %49 %27 
					                                   f32 %266 = OpLoad %265 
					                                   f32 %267 = OpFAdd %264 %266 
					                          Private f32* %268 = OpAccessChain %9 %29 
					                                                OpStore %268 %267 
					                                 f32_4 %269 = OpLoad %49 
					                                 f32_3 %270 = OpVectorShuffle %269 %269 0 1 2 
					                                 f32_3 %271 = OpLoad %9 
					                                 f32_3 %272 = OpVectorShuffle %271 %271 0 0 0 
					                                 f32_3 %273 = OpFDiv %270 %272 
					                                                OpStore %9 %273 
					                          Private f32* %275 = OpAccessChain %56 %27 
					                                   f32 %276 = OpLoad %275 
					                                  bool %277 = OpFOrdEqual %276 %50 
					                                                OpStore %274 %277 
					                                  bool %278 = OpLoad %274 
					                                   f32 %279 = OpSelect %278 %47 %50 
					                                                OpStore %142 %279 
					                                   f32 %280 = OpLoad %142 
					                          Private f32* %281 = OpAccessChain %56 %27 
					                                   f32 %282 = OpLoad %281 
					                                   f32 %283 = OpFAdd %280 %282 
					                                                OpStore %142 %283 
					                                 f32_4 %284 = OpLoad %56 
					                                 f32_3 %285 = OpVectorShuffle %284 %284 0 1 2 
					                                   f32 %286 = OpLoad %142 
					                                 f32_3 %287 = OpCompositeConstruct %286 %286 %286 
					                                 f32_3 %288 = OpFDiv %285 %287 
					                                 f32_4 %289 = OpLoad %46 
					                                 f32_4 %290 = OpVectorShuffle %289 %288 4 5 6 3 
					                                                OpStore %46 %290 
					                          Private f32* %291 = OpAccessChain %56 %27 
					                                   f32 %292 = OpLoad %291 
					                                   f32 %294 = OpFMul %292 %293 
					                                                OpStore %142 %294 
					                                   f32 %295 = OpLoad %142 
					                                   f32 %296 = OpExtInst %1 37 %295 %47 
					                                                OpStore %142 %296 
					                                 f32_3 %297 = OpLoad %9 
					                                 f32_3 %298 = OpFNegate %297 
					                                 f32_4 %299 = OpLoad %46 
					                                 f32_3 %300 = OpVectorShuffle %299 %299 0 1 2 
					                                 f32_3 %301 = OpFAdd %298 %300 
					                                 f32_4 %302 = OpLoad %46 
					                                 f32_4 %303 = OpVectorShuffle %302 %301 4 5 6 3 
					                                                OpStore %46 %303 
					                                   f32 %306 = OpLoad %142 
					                                 f32_3 %307 = OpCompositeConstruct %306 %306 %306 
					                                 f32_4 %308 = OpLoad %46 
					                                 f32_3 %309 = OpVectorShuffle %308 %308 0 1 2 
					                                 f32_3 %310 = OpFMul %307 %309 
					                                 f32_3 %311 = OpLoad %9 
					                                 f32_3 %312 = OpFAdd %310 %311 
					                                 f32_4 %313 = OpLoad %305 
					                                 f32_4 %314 = OpVectorShuffle %313 %312 4 5 6 3 
					                                                OpStore %305 %314 
					                                   f32 %315 = OpLoad %142 
					                           Output f32* %317 = OpAccessChain %305 %27 
					                                                OpStore %317 %315 
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
					vec2 ImmCB_0_0_0[16];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
						ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
						ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
						ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
						ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
						ImmCB_0_0_0[6] = vec2(1.0, 0.0);
						ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
						ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
						ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
						ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
						ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
						ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
						ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
						ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.196349546;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
			Name "Bokeh Filter (medium)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 322512
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[22];
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _MaxCoC;
					uniform 	float _RcpAspect;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
						ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
						ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
						ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
						ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
						ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
						ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
						ImmCB_0_0_0[8] = vec2(1.0, 0.0);
						ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
						ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
						ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
						ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
						ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
						ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
						ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.142799661;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
					; Bound: 333
					; Schema: 0
					                                                OpCapability Shader 
					                                         %1 = OpExtInstImport "GLSL.std.450" 
					                                                OpMemoryModel Logical GLSL450 
					                                                OpEntryPoint Fragment %4 "main" %22 %171 %317 
					                                                OpExecutionMode %4 OriginUpperLeft 
					                                                OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                OpDecorate %12 DescriptorSet 12 
					                                                OpDecorate %12 Binding 12 
					                                                OpDecorate %16 DescriptorSet 16 
					                                                OpDecorate %16 Binding 16 
					                                                OpDecorate vs_TEXCOORD1 Location 22 
					                                                OpMemberDecorate %33 0 Offset 33 
					                                                OpMemberDecorate %33 1 Offset 33 
					                                                OpMemberDecorate %33 2 Offset 33 
					                                                OpMemberDecorate %33 3 Offset 33 
					                                                OpDecorate %33 Block 
					                                                OpDecorate %35 DescriptorSet 35 
					                                                OpDecorate %35 Binding 35 
					                                                OpDecorate vs_TEXCOORD0 Location 171 
					                                                OpDecorate %317 Location 317 
					                                         %2 = OpTypeVoid 
					                                         %3 = OpTypeFunction %2 
					                                         %6 = OpTypeFloat 32 
					                                         %7 = OpTypeVector %6 3 
					                                         %8 = OpTypePointer Private %7 
					                          Private f32_3* %9 = OpVariable Private 
					                                        %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                        %11 = OpTypePointer UniformConstant %10 
					   UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                        %14 = OpTypeSampler 
					                                        %15 = OpTypePointer UniformConstant %14 
					               UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                        %18 = OpTypeSampledImage %10 
					                                        %20 = OpTypeVector %6 2 
					                                        %21 = OpTypePointer Input %20 
					                  Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                        %24 = OpTypeVector %6 4 
					                                        %26 = OpTypeInt 32 0 
					                                    u32 %27 = OpConstant 3 
					                                    u32 %29 = OpConstant 0 
					                                        %30 = OpTypePointer Private %6 
					                           Private f32* %32 = OpVariable Private 
					                                        %33 = OpTypeStruct %6 %24 %6 %6 
					                                        %34 = OpTypePointer Uniform %33 
					Uniform struct {f32; f32_4; f32; f32;}* %35 = OpVariable Uniform 
					                                        %36 = OpTypeInt 32 1 
					                                    i32 %37 = OpConstant 1 
					                                    u32 %38 = OpConstant 1 
					                                        %39 = OpTypePointer Uniform %6 
					                                        %45 = OpTypePointer Private %24 
					                         Private f32_4* %46 = OpVariable Private 
					                                    f32 %47 = OpConstant 3,674022E-40 
					                         Private f32_4* %49 = OpVariable Private 
					                                    f32 %50 = OpConstant 3,674022E-40 
					                                    u32 %53 = OpConstant 2 
					                         Private f32_4* %56 = OpVariable Private 
					                                        %61 = OpTypePointer Function %36 
					                                    i32 %63 = OpConstant 0 
					                                    i32 %70 = OpConstant 22 
					                                        %71 = OpTypeBool 
					                         Private f32_4* %73 = OpVariable Private 
					                                    i32 %74 = OpConstant 2 
					                                        %83 = OpTypeVector %26 4 
					                                    u32 %84 = OpConstant 22 
					                                        %85 = OpTypeArray %83 %84 
					                                  u32_4 %86 = OpConstantComposite %29 %29 %29 %29 
					                                    u32 %87 = OpConstant 1057523849 
					                                  u32_4 %88 = OpConstantComposite %87 %29 %29 %29 
					                                    u32 %89 = OpConstant 1051345177 
					                                    u32 %90 = OpConstant 1054178812 
					                                  u32_4 %91 = OpConstantComposite %89 %90 %29 %29 
					                                    u32 %92 = OpConstant 3186822495 
					                                    u32 %93 = OpConstant 1057299508 
					                                  u32_4 %94 = OpConstantComposite %92 %93 %29 %29 
					                                    u32 %95 = OpConstant 3203794506 
					                                    u32 %96 = OpConstant 1047328091 
					                                  u32_4 %97 = OpConstantComposite %95 %96 %29 %29 
					                                    u32 %98 = OpConstant 3194811737 
					                                  u32_4 %99 = OpConstantComposite %95 %98 %29 %29 
					                                   u32 %100 = OpConstant 3186822466 
					                                   u32 %101 = OpConstant 3204783157 
					                                 u32_4 %102 = OpConstantComposite %100 %101 %29 %29 
					                                   u32 %103 = OpConstant 1051345175 
					                                   u32 %104 = OpConstant 3201662463 
					                                 u32_4 %105 = OpConstantComposite %103 %104 %29 %29 
					                                   u32 %106 = OpConstant 1065353216 
					                                 u32_4 %107 = OpConstantComposite %106 %29 %29 %29 
					                                   u32 %108 = OpConstant 1063691749 
					                                   u32 %109 = OpConstant 1054746115 
					                                 u32_4 %110 = OpConstantComposite %108 %109 %29 %29 
					                                   u32 %111 = OpConstant 1059036423 
					                                   u32 %112 = OpConstant 1061692956 
					                                 u32_4 %113 = OpConstantComposite %111 %112 %29 %29 
					                                   u32 %114 = OpConstant 1046731914 
					                                   u32 %115 = OpConstant 1064932576 
					                                 u32_4 %116 = OpConstantComposite %114 %115 %29 %29 
					                                   u32 %117 = OpConstant 3194215560 
					                                 u32_4 %118 = OpConstantComposite %117 %115 %29 %29 
					                                   u32 %119 = OpConstant 3206520074 
					                                   u32 %120 = OpConstant 1061692954 
					                                 u32_4 %121 = OpConstantComposite %119 %120 %29 %29 
					                                   u32 %122 = OpConstant 3211175397 
					                                   u32 %123 = OpConstant 1054746117 
					                                 u32_4 %124 = OpConstantComposite %122 %123 %29 %29 
					                                   u32 %125 = OpConstant 3212836864 
					                                 u32_4 %126 = OpConstantComposite %125 %29 %29 %29 
					                                   u32 %127 = OpConstant 3202229763 
					                                 u32_4 %128 = OpConstantComposite %122 %127 %29 %29 
					                                   u32 %129 = OpConstant 3206520068 
					                                   u32 %130 = OpConstant 3209176606 
					                                 u32_4 %131 = OpConstantComposite %129 %130 %29 %29 
					                                   u32 %132 = OpConstant 3194215533 
					                                   u32 %133 = OpConstant 3212416226 
					                                 u32_4 %134 = OpConstantComposite %132 %133 %29 %29 
					                                   u32 %135 = OpConstant 1046731949 
					                                   u32 %136 = OpConstant 3212416222 
					                                 u32_4 %137 = OpConstantComposite %135 %136 %29 %29 
					                                   u32 %138 = OpConstant 1059036421 
					                                 u32_4 %139 = OpConstantComposite %138 %130 %29 %29 
					                                 u32_4 %140 = OpConstantComposite %108 %127 %29 %29 
					                             u32_4[22] %141 = OpConstantComposite %86 %88 %91 %94 %97 %99 %102 %105 %107 %110 %113 %116 %118 %121 %124 %126 %128 %131 %134 %137 %139 %140 
					                                       %143 = OpTypeVector %26 2 
					                                       %144 = OpTypePointer Function %85 
					                                       %146 = OpTypePointer Function %83 
					                          Private f32* %154 = OpVariable Private 
					                                   i32 %164 = OpConstant 3 
					                  Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                          Private f32* %197 = OpVariable Private 
					                                   f32 %211 = OpConstant 3,674022E-40 
					                                       %236 = OpTypePointer Private %71 
					                         Private bool* %237 = OpVariable Private 
					                          Private f32* %244 = OpVariable Private 
					                         Private bool* %268 = OpVariable Private 
					                         Private bool* %286 = OpVariable Private 
					                                   f32 %305 = OpConstant 3,674022E-40 
					                                       %316 = OpTypePointer Output %24 
					                         Output f32_4* %317 = OpVariable Output 
					                                       %328 = OpTypePointer Output %6 
					                                       %331 = OpTypePointer Private %36 
					                          Private i32* %332 = OpVariable Private 
					                                    void %4 = OpFunction None %3 
					                                         %5 = OpLabel 
					                          Function i32* %62 = OpVariable Function 
					                   Function u32_4[22]* %145 = OpVariable Function 
					                    read_only Texture2D %13 = OpLoad %12 
					                                sampler %17 = OpLoad %16 
					             read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                  f32_2 %23 = OpLoad vs_TEXCOORD1 
					                                  f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                                    f32 %28 = OpCompositeExtract %25 3 
					                           Private f32* %31 = OpAccessChain %9 %29 
					                                                OpStore %31 %28 
					                           Uniform f32* %40 = OpAccessChain %35 %37 %38 
					                                    f32 %41 = OpLoad %40 
					                           Uniform f32* %42 = OpAccessChain %35 %37 %38 
					                                    f32 %43 = OpLoad %42 
					                                    f32 %44 = OpFAdd %41 %43 
					                                                OpStore %32 %44 
					                           Private f32* %48 = OpAccessChain %46 %27 
					                                                OpStore %48 %47 
					                           Private f32* %51 = OpAccessChain %49 %29 
					                                                OpStore %51 %50 
					                           Private f32* %52 = OpAccessChain %49 %38 
					                                                OpStore %52 %50 
					                           Private f32* %54 = OpAccessChain %49 %53 
					                                                OpStore %54 %50 
					                           Private f32* %55 = OpAccessChain %49 %27 
					                                                OpStore %55 %50 
					                           Private f32* %57 = OpAccessChain %56 %29 
					                                                OpStore %57 %50 
					                           Private f32* %58 = OpAccessChain %56 %38 
					                                                OpStore %58 %50 
					                           Private f32* %59 = OpAccessChain %56 %53 
					                                                OpStore %59 %50 
					                           Private f32* %60 = OpAccessChain %56 %27 
					                                                OpStore %60 %50 
					                                                OpStore %62 %63 
					                                                OpBranch %64 
					                                        %64 = OpLabel 
					                                                OpLoopMerge %66 %67 None 
					                                                OpBranch %68 
					                                        %68 = OpLabel 
					                                    i32 %69 = OpLoad %62 
					                                   bool %72 = OpSLessThan %69 %70 
					                                                OpBranchConditional %72 %65 %66 
					                                        %65 = OpLabel 
					                           Uniform f32* %75 = OpAccessChain %35 %74 
					                                    f32 %76 = OpLoad %75 
					                           Uniform f32* %77 = OpAccessChain %35 %74 
					                                    f32 %78 = OpLoad %77 
					                                  f32_2 %79 = OpCompositeConstruct %76 %78 
					                                    f32 %80 = OpCompositeExtract %79 0 
					                                    f32 %81 = OpCompositeExtract %79 1 
					                                  f32_2 %82 = OpCompositeConstruct %80 %81 
					                                   i32 %142 = OpLoad %62 
					                                                OpStore %145 %141 
					                       Function u32_4* %147 = OpAccessChain %145 %142 
					                                 u32_4 %148 = OpLoad %147 
					                                 u32_2 %149 = OpVectorShuffle %148 %148 0 1 
					                                 f32_2 %150 = OpBitcast %149 
					                                 f32_2 %151 = OpFMul %82 %150 
					                                 f32_4 %152 = OpLoad %73 
					                                 f32_4 %153 = OpVectorShuffle %152 %151 0 4 5 3 
					                                                OpStore %73 %153 
					                                 f32_4 %155 = OpLoad %73 
					                                 f32_2 %156 = OpVectorShuffle %155 %155 1 2 
					                                 f32_4 %157 = OpLoad %73 
					                                 f32_2 %158 = OpVectorShuffle %157 %157 1 2 
					                                   f32 %159 = OpDot %156 %158 
					                                                OpStore %154 %159 
					                                   f32 %160 = OpLoad %154 
					                                   f32 %161 = OpExtInst %1 31 %160 
					                                                OpStore %154 %161 
					                          Private f32* %162 = OpAccessChain %73 %38 
					                                   f32 %163 = OpLoad %162 
					                          Uniform f32* %165 = OpAccessChain %35 %164 
					                                   f32 %166 = OpLoad %165 
					                                   f32 %167 = OpFMul %163 %166 
					                          Private f32* %168 = OpAccessChain %73 %29 
					                                                OpStore %168 %167 
					                                 f32_4 %169 = OpLoad %73 
					                                 f32_2 %170 = OpVectorShuffle %169 %169 0 2 
					                                 f32_2 %172 = OpLoad vs_TEXCOORD0 
					                                 f32_2 %173 = OpFAdd %170 %172 
					                                 f32_4 %174 = OpLoad %73 
					                                 f32_4 %175 = OpVectorShuffle %174 %173 4 5 2 3 
					                                                OpStore %73 %175 
					                                 f32_4 %176 = OpLoad %73 
					                                 f32_2 %177 = OpVectorShuffle %176 %176 0 1 
					                                 f32_2 %178 = OpCompositeConstruct %50 %50 
					                                 f32_2 %179 = OpCompositeConstruct %47 %47 
					                                 f32_2 %180 = OpExtInst %1 43 %177 %178 %179 
					                                 f32_4 %181 = OpLoad %73 
					                                 f32_4 %182 = OpVectorShuffle %181 %180 4 5 2 3 
					                                                OpStore %73 %182 
					                                 f32_4 %183 = OpLoad %73 
					                                 f32_2 %184 = OpVectorShuffle %183 %183 0 1 
					                          Uniform f32* %185 = OpAccessChain %35 %63 
					                                   f32 %186 = OpLoad %185 
					                                 f32_2 %187 = OpCompositeConstruct %186 %186 
					                                 f32_2 %188 = OpFMul %184 %187 
					                                 f32_4 %189 = OpLoad %73 
					                                 f32_4 %190 = OpVectorShuffle %189 %188 4 5 2 3 
					                                                OpStore %73 %190 
					                   read_only Texture2D %191 = OpLoad %12 
					                               sampler %192 = OpLoad %16 
					            read_only Texture2DSampled %193 = OpSampledImage %191 %192 
					                                 f32_4 %194 = OpLoad %73 
					                                 f32_2 %195 = OpVectorShuffle %194 %194 0 1 
					                                 f32_4 %196 = OpImageSampleImplicitLod %193 %195 
					                                                OpStore %73 %196 
					                          Private f32* %198 = OpAccessChain %9 %29 
					                                   f32 %199 = OpLoad %198 
					                          Private f32* %200 = OpAccessChain %73 %27 
					                                   f32 %201 = OpLoad %200 
					                                   f32 %202 = OpExtInst %1 37 %199 %201 
					                                                OpStore %197 %202 
					                                   f32 %203 = OpLoad %197 
					                                   f32 %204 = OpExtInst %1 40 %203 %50 
					                                                OpStore %197 %204 
					                                   f32 %205 = OpLoad %154 
					                                   f32 %206 = OpFNegate %205 
					                                   f32 %207 = OpLoad %197 
					                                   f32 %208 = OpFAdd %206 %207 
					                                                OpStore %197 %208 
					                          Uniform f32* %209 = OpAccessChain %35 %37 %38 
					                                   f32 %210 = OpLoad %209 
					                                   f32 %212 = OpFMul %210 %211 
					                                   f32 %213 = OpLoad %197 
					                                   f32 %214 = OpFAdd %212 %213 
					                                                OpStore %197 %214 
					                                   f32 %215 = OpLoad %197 
					                                   f32 %216 = OpLoad %32 
					                                   f32 %217 = OpFDiv %215 %216 
					                                                OpStore %197 %217 
					                                   f32 %218 = OpLoad %197 
					                                   f32 %219 = OpExtInst %1 43 %218 %50 %47 
					                                                OpStore %197 %219 
					                                   f32 %220 = OpLoad %154 
					                                   f32 %221 = OpFNegate %220 
					                          Private f32* %222 = OpAccessChain %73 %27 
					                                   f32 %223 = OpLoad %222 
					                                   f32 %224 = OpFNegate %223 
					                                   f32 %225 = OpFAdd %221 %224 
					                                                OpStore %154 %225 
					                          Uniform f32* %226 = OpAccessChain %35 %37 %38 
					                                   f32 %227 = OpLoad %226 
					                                   f32 %228 = OpFMul %227 %211 
					                                   f32 %229 = OpLoad %154 
					                                   f32 %230 = OpFAdd %228 %229 
					                                                OpStore %154 %230 
					                                   f32 %231 = OpLoad %154 
					                                   f32 %232 = OpLoad %32 
					                                   f32 %233 = OpFDiv %231 %232 
					                                                OpStore %154 %233 
					                                   f32 %234 = OpLoad %154 
					                                   f32 %235 = OpExtInst %1 43 %234 %50 %47 
					                                                OpStore %154 %235 
					                          Private f32* %238 = OpAccessChain %73 %27 
					                                   f32 %239 = OpLoad %238 
					                                   f32 %240 = OpFNegate %239 
					                          Uniform f32* %241 = OpAccessChain %35 %37 %38 
					                                   f32 %242 = OpLoad %241 
					                                  bool %243 = OpFOrdGreaterThanEqual %240 %242 
					                                                OpStore %237 %243 
					                                  bool %245 = OpLoad %237 
					                                   f32 %246 = OpSelect %245 %47 %50 
					                                                OpStore %244 %246 
					                                   f32 %247 = OpLoad %154 
					                                   f32 %248 = OpLoad %244 
					                                   f32 %249 = OpFMul %247 %248 
					                                                OpStore %154 %249 
					                                 f32_4 %250 = OpLoad %73 
					                                 f32_3 %251 = OpVectorShuffle %250 %250 0 1 2 
					                                 f32_4 %252 = OpLoad %46 
					                                 f32_4 %253 = OpVectorShuffle %252 %251 4 5 6 3 
					                                                OpStore %46 %253 
					                                 f32_4 %254 = OpLoad %46 
					                                   f32 %255 = OpLoad %197 
					                                 f32_4 %256 = OpCompositeConstruct %255 %255 %255 %255 
					                                 f32_4 %257 = OpFMul %254 %256 
					                                 f32_4 %258 = OpLoad %49 
					                                 f32_4 %259 = OpFAdd %257 %258 
					                                                OpStore %49 %259 
					                                 f32_4 %260 = OpLoad %46 
					                                   f32 %261 = OpLoad %154 
					                                 f32_4 %262 = OpCompositeConstruct %261 %261 %261 %261 
					                                 f32_4 %263 = OpFMul %260 %262 
					                                 f32_4 %264 = OpLoad %56 
					                                 f32_4 %265 = OpFAdd %263 %264 
					                                                OpStore %56 %265 
					                                                OpBranch %67 
					                                        %67 = OpLabel 
					                                   i32 %266 = OpLoad %62 
					                                   i32 %267 = OpIAdd %266 %37 
					                                                OpStore %62 %267 
					                                                OpBranch %64 
					                                        %66 = OpLabel 
					                          Private f32* %269 = OpAccessChain %49 %27 
					                                   f32 %270 = OpLoad %269 
					                                  bool %271 = OpFOrdEqual %270 %50 
					                                                OpStore %268 %271 
					                                  bool %272 = OpLoad %268 
					                                   f32 %273 = OpSelect %272 %47 %50 
					                          Private f32* %274 = OpAccessChain %9 %29 
					                                                OpStore %274 %273 
					                          Private f32* %275 = OpAccessChain %9 %29 
					                                   f32 %276 = OpLoad %275 
					                          Private f32* %277 = OpAccessChain %49 %27 
					                                   f32 %278 = OpLoad %277 
					                                   f32 %279 = OpFAdd %276 %278 
					                          Private f32* %280 = OpAccessChain %9 %29 
					                                                OpStore %280 %279 
					                                 f32_4 %281 = OpLoad %49 
					                                 f32_3 %282 = OpVectorShuffle %281 %281 0 1 2 
					                                 f32_3 %283 = OpLoad %9 
					                                 f32_3 %284 = OpVectorShuffle %283 %283 0 0 0 
					                                 f32_3 %285 = OpFDiv %282 %284 
					                                                OpStore %9 %285 
					                          Private f32* %287 = OpAccessChain %56 %27 
					                                   f32 %288 = OpLoad %287 
					                                  bool %289 = OpFOrdEqual %288 %50 
					                                                OpStore %286 %289 
					                                  bool %290 = OpLoad %286 
					                                   f32 %291 = OpSelect %290 %47 %50 
					                                                OpStore %154 %291 
					                                   f32 %292 = OpLoad %154 
					                          Private f32* %293 = OpAccessChain %56 %27 
					                                   f32 %294 = OpLoad %293 
					                                   f32 %295 = OpFAdd %292 %294 
					                                                OpStore %154 %295 
					                                 f32_4 %296 = OpLoad %56 
					                                 f32_3 %297 = OpVectorShuffle %296 %296 0 1 2 
					                                   f32 %298 = OpLoad %154 
					                                 f32_3 %299 = OpCompositeConstruct %298 %298 %298 
					                                 f32_3 %300 = OpFDiv %297 %299 
					                                 f32_4 %301 = OpLoad %46 
					                                 f32_4 %302 = OpVectorShuffle %301 %300 4 5 6 3 
					                                                OpStore %46 %302 
					                          Private f32* %303 = OpAccessChain %56 %27 
					                                   f32 %304 = OpLoad %303 
					                                   f32 %306 = OpFMul %304 %305 
					                                                OpStore %154 %306 
					                                   f32 %307 = OpLoad %154 
					                                   f32 %308 = OpExtInst %1 37 %307 %47 
					                                                OpStore %154 %308 
					                                 f32_3 %309 = OpLoad %9 
					                                 f32_3 %310 = OpFNegate %309 
					                                 f32_4 %311 = OpLoad %46 
					                                 f32_3 %312 = OpVectorShuffle %311 %311 0 1 2 
					                                 f32_3 %313 = OpFAdd %310 %312 
					                                 f32_4 %314 = OpLoad %46 
					                                 f32_4 %315 = OpVectorShuffle %314 %313 4 5 6 3 
					                                                OpStore %46 %315 
					                                   f32 %318 = OpLoad %154 
					                                 f32_3 %319 = OpCompositeConstruct %318 %318 %318 
					                                 f32_4 %320 = OpLoad %46 
					                                 f32_3 %321 = OpVectorShuffle %320 %320 0 1 2 
					                                 f32_3 %322 = OpFMul %319 %321 
					                                 f32_3 %323 = OpLoad %9 
					                                 f32_3 %324 = OpFAdd %322 %323 
					                                 f32_4 %325 = OpLoad %317 
					                                 f32_4 %326 = OpVectorShuffle %325 %324 4 5 6 3 
					                                                OpStore %317 %326 
					                                   f32 %327 = OpLoad %154 
					                           Output f32* %329 = OpAccessChain %317 %27 
					                                                OpStore %329 %327 
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
					vec2 ImmCB_0_0_0[22];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
						ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
						ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
						ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
						ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
						ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
						ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
						ImmCB_0_0_0[8] = vec2(1.0, 0.0);
						ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
						ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
						ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
						ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
						ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
						ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
						ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.142799661;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
			Name "Bokeh Filter (large)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 337594
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[43];
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _MaxCoC;
					uniform 	float _RcpAspect;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
						ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
						ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
						ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
						ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
						ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
						ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
						ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
						ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
						ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
						ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
						ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
						ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
						ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
						ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
						ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
						ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
						ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
						ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
						ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
						ImmCB_0_0_0[22] = vec2(1.0, 0.0);
						ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
						ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
						ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
						ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
						ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
						ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
						ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
						ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
						ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
						ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
						ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
						ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
						ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
						ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
						ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.0730602965;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
					; Bound: 394
					; Schema: 0
					                                                OpCapability Shader 
					                                         %1 = OpExtInstImport "GLSL.std.450" 
					                                                OpMemoryModel Logical GLSL450 
					                                                OpEntryPoint Fragment %4 "main" %22 %232 %378 
					                                                OpExecutionMode %4 OriginUpperLeft 
					                                                OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                OpDecorate %12 DescriptorSet 12 
					                                                OpDecorate %12 Binding 12 
					                                                OpDecorate %16 DescriptorSet 16 
					                                                OpDecorate %16 Binding 16 
					                                                OpDecorate vs_TEXCOORD1 Location 22 
					                                                OpMemberDecorate %33 0 Offset 33 
					                                                OpMemberDecorate %33 1 Offset 33 
					                                                OpMemberDecorate %33 2 Offset 33 
					                                                OpMemberDecorate %33 3 Offset 33 
					                                                OpDecorate %33 Block 
					                                                OpDecorate %35 DescriptorSet 35 
					                                                OpDecorate %35 Binding 35 
					                                                OpDecorate vs_TEXCOORD0 Location 232 
					                                                OpDecorate %378 Location 378 
					                                         %2 = OpTypeVoid 
					                                         %3 = OpTypeFunction %2 
					                                         %6 = OpTypeFloat 32 
					                                         %7 = OpTypeVector %6 3 
					                                         %8 = OpTypePointer Private %7 
					                          Private f32_3* %9 = OpVariable Private 
					                                        %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                        %11 = OpTypePointer UniformConstant %10 
					   UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                        %14 = OpTypeSampler 
					                                        %15 = OpTypePointer UniformConstant %14 
					               UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                        %18 = OpTypeSampledImage %10 
					                                        %20 = OpTypeVector %6 2 
					                                        %21 = OpTypePointer Input %20 
					                  Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                        %24 = OpTypeVector %6 4 
					                                        %26 = OpTypeInt 32 0 
					                                    u32 %27 = OpConstant 3 
					                                    u32 %29 = OpConstant 0 
					                                        %30 = OpTypePointer Private %6 
					                           Private f32* %32 = OpVariable Private 
					                                        %33 = OpTypeStruct %6 %24 %6 %6 
					                                        %34 = OpTypePointer Uniform %33 
					Uniform struct {f32; f32_4; f32; f32;}* %35 = OpVariable Uniform 
					                                        %36 = OpTypeInt 32 1 
					                                    i32 %37 = OpConstant 1 
					                                    u32 %38 = OpConstant 1 
					                                        %39 = OpTypePointer Uniform %6 
					                                        %45 = OpTypePointer Private %24 
					                         Private f32_4* %46 = OpVariable Private 
					                                    f32 %47 = OpConstant 3,674022E-40 
					                         Private f32_4* %49 = OpVariable Private 
					                                    f32 %50 = OpConstant 3,674022E-40 
					                                    u32 %53 = OpConstant 2 
					                         Private f32_4* %56 = OpVariable Private 
					                                        %61 = OpTypePointer Function %36 
					                                    i32 %63 = OpConstant 0 
					                                    i32 %70 = OpConstant 43 
					                                        %71 = OpTypeBool 
					                         Private f32_4* %73 = OpVariable Private 
					                                    i32 %74 = OpConstant 2 
					                                        %83 = OpTypeVector %26 4 
					                                    u32 %84 = OpConstant 43 
					                                        %85 = OpTypeArray %83 %84 
					                                  u32_4 %86 = OpConstantComposite %29 %29 %29 %29 
					                                    u32 %87 = OpConstant 1052389004 
					                                  u32_4 %88 = OpConstantComposite %87 %29 %29 %29 
					                                    u32 %89 = OpConstant 1047013945 
					                                    u32 %90 = OpConstant 1049726997 
					                                  u32_4 %91 = OpConstantComposite %89 %90 %29 %29 
					                                    u32 %92 = OpConstant 3181754281 
					                                    u32 %93 = OpConstant 1052083084 
					                                  u32_4 %94 = OpConstantComposite %92 %93 %29 %29 
					                                    u32 %95 = OpConstant 3198664312 
					                                    u32 %96 = OpConstant 1042386948 
					                                  u32_4 %97 = OpConstantComposite %95 %96 %29 %29 
					                                    u32 %98 = OpConstant 3189870594 
					                                  u32_4 %99 = OpConstantComposite %95 %98 %29 %29 
					                                   u32 %100 = OpConstant 3181754261 
					                                   u32 %101 = OpConstant 3199566733 
					                                 u32_4 %102 = OpConstantComposite %100 %101 %29 %29 
					                                   u32 %103 = OpConstant 1047013942 
					                                   u32 %104 = OpConstant 3197210646 
					                                 u32_4 %105 = OpConstantComposite %103 %104 %29 %29 
					                                   u32 %106 = OpConstant 1060015011 
					                                 u32_4 %107 = OpConstantComposite %106 %29 %29 %29 
					                                   u32 %108 = OpConstant 1058882193 
					                                   u32 %109 = OpConstant 1050113794 
					                                 u32_4 %110 = OpConstantComposite %108 %109 %29 %29 
					                                   u32 %111 = OpConstant 1054451605 
					                                   u32 %112 = OpConstant 1057519379 
					                                 u32_4 %113 = OpConstantComposite %111 %112 %29 %29 
					                                   u32 %114 = OpConstant 1041980464 
					                                   u32 %115 = OpConstant 1059728211 
					                                 u32_4 %116 = OpConstantComposite %114 %115 %29 %29 
					                                   u32 %117 = OpConstant 3189464110 
					                                 u32_4 %118 = OpConstantComposite %117 %115 %29 %29 
					                                   u32 %119 = OpConstant 3201935257 
					                                   u32 %120 = OpConstant 1057519378 
					                                 u32_4 %121 = OpConstantComposite %119 %120 %29 %29 
					                                   u32 %122 = OpConstant 3206365841 
					                                   u32 %123 = OpConstant 1050113795 
					                                 u32_4 %124 = OpConstantComposite %122 %123 %29 %29 
					                                   u32 %125 = OpConstant 3207498659 
					                                 u32_4 %126 = OpConstantComposite %125 %29 %29 %29 
					                                   u32 %127 = OpConstant 3197597442 
					                                 u32_4 %128 = OpConstantComposite %122 %127 %29 %29 
					                                   u32 %129 = OpConstant 3201935249 
					                                   u32 %130 = OpConstant 3205003029 
					                                 u32_4 %131 = OpConstantComposite %129 %130 %29 %29 
					                                   u32 %132 = OpConstant 3189464092 
					                                   u32 %133 = OpConstant 3207211860 
					                                 u32_4 %134 = OpConstantComposite %132 %133 %29 %29 
					                                   u32 %135 = OpConstant 1041980487 
					                                   u32 %136 = OpConstant 3207211858 
					                                 u32_4 %137 = OpConstantComposite %135 %136 %29 %29 
					                                   u32 %138 = OpConstant 1054451603 
					                                 u32_4 %139 = OpConstantComposite %138 %130 %29 %29 
					                                 u32_4 %140 = OpConstantComposite %108 %127 %29 %29 
					                                   u32 %141 = OpConstant 1065353216 
					                                 u32_4 %142 = OpConstantComposite %141 %29 %29 %29 
					                                   u32 %143 = OpConstant 1064607851 
					                                   u32 %144 = OpConstant 1050077735 
					                                 u32_4 %145 = OpConstantComposite %143 %144 %29 %29 
					                                   u32 %146 = OpConstant 1062437986 
					                                   u32 %147 = OpConstant 1058026943 
					                                 u32_4 %148 = OpConstantComposite %146 %147 %29 %29 
					                                   u32 %149 = OpConstant 1059036423 
					                                   u32 %150 = OpConstant 1061692956 
					                                 u32_4 %151 = OpConstantComposite %149 %150 %29 %29 
					                                   u32 %152 = OpConstant 1052446201 
					                                   u32 %153 = OpConstant 1064193470 
					                                 u32_4 %154 = OpConstantComposite %152 %153 %29 %29 
					                                   u32 %155 = OpConstant 1033440267 
					                                   u32 %156 = OpConstant 1065306304 
					                                 u32_4 %157 = OpConstantComposite %155 %156 %29 %29 
					                                   u32 %158 = OpConstant 3194215560 
					                                   u32 %159 = OpConstant 1064932576 
					                                 u32_4 %160 = OpConstantComposite %158 %159 %29 %29 
					                                   u32 %161 = OpConstant 3204448257 
					                                   u32 %162 = OpConstant 1063105495 
					                                 u32_4 %163 = OpConstantComposite %161 %162 %29 %29 
					                                   u32 %164 = OpConstant 3208358219 
					                                   u32 %165 = OpConstant 1059987404 
					                                 u32_4 %166 = OpConstantComposite %164 %165 %29 %29 
					                                   u32 %167 = OpConstant 3211175397 
					                                   u32 %168 = OpConstant 1054746117 
					                                 u32_4 %169 = OpConstantComposite %167 %168 %29 %29 
					                                   u32 %170 = OpConstant 3212649477 
					                                   u32 %171 = OpConstant 1041800829 
					                                 u32_4 %172 = OpConstantComposite %170 %171 %29 %29 
					                                   u32 %173 = OpConstant 3212649476 
					                                   u32 %174 = OpConstant 3189284504 
					                                 u32_4 %175 = OpConstantComposite %173 %174 %29 %29 
					                                   u32 %176 = OpConstant 3202229763 
					                                 u32_4 %177 = OpConstantComposite %167 %176 %29 %29 
					                                   u32 %178 = OpConstant 3208358217 
					                                   u32 %179 = OpConstant 3207471054 
					                                 u32_4 %180 = OpConstantComposite %178 %179 %29 %29 
					                                   u32 %181 = OpConstant 3204448253 
					                                   u32 %182 = OpConstant 3210589144 
					                                 u32_4 %183 = OpConstantComposite %181 %182 %29 %29 
					                                   u32 %184 = OpConstant 3194215564 
					                                   u32 %185 = OpConstant 3212416224 
					                                 u32_4 %186 = OpConstantComposite %184 %185 %29 %29 
					                                   u32 %187 = OpConstant 1033440306 
					                                   u32 %188 = OpConstant 3212789951 
					                                 u32_4 %189 = OpConstantComposite %187 %188 %29 %29 
					                                   u32 %190 = OpConstant 1052446218 
					                                   u32 %191 = OpConstant 3211677115 
					                                 u32_4 %192 = OpConstantComposite %190 %191 %29 %29 
					                                   u32 %193 = OpConstant 1059036421 
					                                   u32 %194 = OpConstant 3209176606 
					                                 u32_4 %195 = OpConstantComposite %193 %194 %29 %29 
					                                   u32 %196 = OpConstant 1062437987 
					                                   u32 %197 = OpConstant 3205510589 
					                                 u32_4 %198 = OpConstantComposite %196 %197 %29 %29 
					                                   u32 %199 = OpConstant 1064607853 
					                                   u32 %200 = OpConstant 3197561371 
					                                 u32_4 %201 = OpConstantComposite %199 %200 %29 %29 
					                             u32_4[43] %202 = OpConstantComposite %86 %88 %91 %94 %97 %99 %102 %105 %107 %110 %113 %116 %118 %121 %124 %126 %128 %131 %134 %137 %139 %140 %142 %145 %148 %151 %154 %157 %160 %163 %166 %169 %172 %175 %177 %180 %183 %186 %189 %192 %195 %198 %201 
					                                       %204 = OpTypeVector %26 2 
					                                       %205 = OpTypePointer Function %85 
					                                       %207 = OpTypePointer Function %83 
					                          Private f32* %215 = OpVariable Private 
					                                   i32 %225 = OpConstant 3 
					                  Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                          Private f32* %258 = OpVariable Private 
					                                   f32 %272 = OpConstant 3,674022E-40 
					                                       %297 = OpTypePointer Private %71 
					                         Private bool* %298 = OpVariable Private 
					                          Private f32* %305 = OpVariable Private 
					                         Private bool* %329 = OpVariable Private 
					                         Private bool* %347 = OpVariable Private 
					                                   f32 %366 = OpConstant 3,674022E-40 
					                                       %377 = OpTypePointer Output %24 
					                         Output f32_4* %378 = OpVariable Output 
					                                       %389 = OpTypePointer Output %6 
					                                       %392 = OpTypePointer Private %36 
					                          Private i32* %393 = OpVariable Private 
					                                    void %4 = OpFunction None %3 
					                                         %5 = OpLabel 
					                          Function i32* %62 = OpVariable Function 
					                   Function u32_4[43]* %206 = OpVariable Function 
					                    read_only Texture2D %13 = OpLoad %12 
					                                sampler %17 = OpLoad %16 
					             read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                  f32_2 %23 = OpLoad vs_TEXCOORD1 
					                                  f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                                    f32 %28 = OpCompositeExtract %25 3 
					                           Private f32* %31 = OpAccessChain %9 %29 
					                                                OpStore %31 %28 
					                           Uniform f32* %40 = OpAccessChain %35 %37 %38 
					                                    f32 %41 = OpLoad %40 
					                           Uniform f32* %42 = OpAccessChain %35 %37 %38 
					                                    f32 %43 = OpLoad %42 
					                                    f32 %44 = OpFAdd %41 %43 
					                                                OpStore %32 %44 
					                           Private f32* %48 = OpAccessChain %46 %27 
					                                                OpStore %48 %47 
					                           Private f32* %51 = OpAccessChain %49 %29 
					                                                OpStore %51 %50 
					                           Private f32* %52 = OpAccessChain %49 %38 
					                                                OpStore %52 %50 
					                           Private f32* %54 = OpAccessChain %49 %53 
					                                                OpStore %54 %50 
					                           Private f32* %55 = OpAccessChain %49 %27 
					                                                OpStore %55 %50 
					                           Private f32* %57 = OpAccessChain %56 %29 
					                                                OpStore %57 %50 
					                           Private f32* %58 = OpAccessChain %56 %38 
					                                                OpStore %58 %50 
					                           Private f32* %59 = OpAccessChain %56 %53 
					                                                OpStore %59 %50 
					                           Private f32* %60 = OpAccessChain %56 %27 
					                                                OpStore %60 %50 
					                                                OpStore %62 %63 
					                                                OpBranch %64 
					                                        %64 = OpLabel 
					                                                OpLoopMerge %66 %67 None 
					                                                OpBranch %68 
					                                        %68 = OpLabel 
					                                    i32 %69 = OpLoad %62 
					                                   bool %72 = OpSLessThan %69 %70 
					                                                OpBranchConditional %72 %65 %66 
					                                        %65 = OpLabel 
					                           Uniform f32* %75 = OpAccessChain %35 %74 
					                                    f32 %76 = OpLoad %75 
					                           Uniform f32* %77 = OpAccessChain %35 %74 
					                                    f32 %78 = OpLoad %77 
					                                  f32_2 %79 = OpCompositeConstruct %76 %78 
					                                    f32 %80 = OpCompositeExtract %79 0 
					                                    f32 %81 = OpCompositeExtract %79 1 
					                                  f32_2 %82 = OpCompositeConstruct %80 %81 
					                                   i32 %203 = OpLoad %62 
					                                                OpStore %206 %202 
					                       Function u32_4* %208 = OpAccessChain %206 %203 
					                                 u32_4 %209 = OpLoad %208 
					                                 u32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                 f32_2 %211 = OpBitcast %210 
					                                 f32_2 %212 = OpFMul %82 %211 
					                                 f32_4 %213 = OpLoad %73 
					                                 f32_4 %214 = OpVectorShuffle %213 %212 0 4 5 3 
					                                                OpStore %73 %214 
					                                 f32_4 %216 = OpLoad %73 
					                                 f32_2 %217 = OpVectorShuffle %216 %216 1 2 
					                                 f32_4 %218 = OpLoad %73 
					                                 f32_2 %219 = OpVectorShuffle %218 %218 1 2 
					                                   f32 %220 = OpDot %217 %219 
					                                                OpStore %215 %220 
					                                   f32 %221 = OpLoad %215 
					                                   f32 %222 = OpExtInst %1 31 %221 
					                                                OpStore %215 %222 
					                          Private f32* %223 = OpAccessChain %73 %38 
					                                   f32 %224 = OpLoad %223 
					                          Uniform f32* %226 = OpAccessChain %35 %225 
					                                   f32 %227 = OpLoad %226 
					                                   f32 %228 = OpFMul %224 %227 
					                          Private f32* %229 = OpAccessChain %73 %29 
					                                                OpStore %229 %228 
					                                 f32_4 %230 = OpLoad %73 
					                                 f32_2 %231 = OpVectorShuffle %230 %230 0 2 
					                                 f32_2 %233 = OpLoad vs_TEXCOORD0 
					                                 f32_2 %234 = OpFAdd %231 %233 
					                                 f32_4 %235 = OpLoad %73 
					                                 f32_4 %236 = OpVectorShuffle %235 %234 4 5 2 3 
					                                                OpStore %73 %236 
					                                 f32_4 %237 = OpLoad %73 
					                                 f32_2 %238 = OpVectorShuffle %237 %237 0 1 
					                                 f32_2 %239 = OpCompositeConstruct %50 %50 
					                                 f32_2 %240 = OpCompositeConstruct %47 %47 
					                                 f32_2 %241 = OpExtInst %1 43 %238 %239 %240 
					                                 f32_4 %242 = OpLoad %73 
					                                 f32_4 %243 = OpVectorShuffle %242 %241 4 5 2 3 
					                                                OpStore %73 %243 
					                                 f32_4 %244 = OpLoad %73 
					                                 f32_2 %245 = OpVectorShuffle %244 %244 0 1 
					                          Uniform f32* %246 = OpAccessChain %35 %63 
					                                   f32 %247 = OpLoad %246 
					                                 f32_2 %248 = OpCompositeConstruct %247 %247 
					                                 f32_2 %249 = OpFMul %245 %248 
					                                 f32_4 %250 = OpLoad %73 
					                                 f32_4 %251 = OpVectorShuffle %250 %249 4 5 2 3 
					                                                OpStore %73 %251 
					                   read_only Texture2D %252 = OpLoad %12 
					                               sampler %253 = OpLoad %16 
					            read_only Texture2DSampled %254 = OpSampledImage %252 %253 
					                                 f32_4 %255 = OpLoad %73 
					                                 f32_2 %256 = OpVectorShuffle %255 %255 0 1 
					                                 f32_4 %257 = OpImageSampleImplicitLod %254 %256 
					                                                OpStore %73 %257 
					                          Private f32* %259 = OpAccessChain %9 %29 
					                                   f32 %260 = OpLoad %259 
					                          Private f32* %261 = OpAccessChain %73 %27 
					                                   f32 %262 = OpLoad %261 
					                                   f32 %263 = OpExtInst %1 37 %260 %262 
					                                                OpStore %258 %263 
					                                   f32 %264 = OpLoad %258 
					                                   f32 %265 = OpExtInst %1 40 %264 %50 
					                                                OpStore %258 %265 
					                                   f32 %266 = OpLoad %215 
					                                   f32 %267 = OpFNegate %266 
					                                   f32 %268 = OpLoad %258 
					                                   f32 %269 = OpFAdd %267 %268 
					                                                OpStore %258 %269 
					                          Uniform f32* %270 = OpAccessChain %35 %37 %38 
					                                   f32 %271 = OpLoad %270 
					                                   f32 %273 = OpFMul %271 %272 
					                                   f32 %274 = OpLoad %258 
					                                   f32 %275 = OpFAdd %273 %274 
					                                                OpStore %258 %275 
					                                   f32 %276 = OpLoad %258 
					                                   f32 %277 = OpLoad %32 
					                                   f32 %278 = OpFDiv %276 %277 
					                                                OpStore %258 %278 
					                                   f32 %279 = OpLoad %258 
					                                   f32 %280 = OpExtInst %1 43 %279 %50 %47 
					                                                OpStore %258 %280 
					                                   f32 %281 = OpLoad %215 
					                                   f32 %282 = OpFNegate %281 
					                          Private f32* %283 = OpAccessChain %73 %27 
					                                   f32 %284 = OpLoad %283 
					                                   f32 %285 = OpFNegate %284 
					                                   f32 %286 = OpFAdd %282 %285 
					                                                OpStore %215 %286 
					                          Uniform f32* %287 = OpAccessChain %35 %37 %38 
					                                   f32 %288 = OpLoad %287 
					                                   f32 %289 = OpFMul %288 %272 
					                                   f32 %290 = OpLoad %215 
					                                   f32 %291 = OpFAdd %289 %290 
					                                                OpStore %215 %291 
					                                   f32 %292 = OpLoad %215 
					                                   f32 %293 = OpLoad %32 
					                                   f32 %294 = OpFDiv %292 %293 
					                                                OpStore %215 %294 
					                                   f32 %295 = OpLoad %215 
					                                   f32 %296 = OpExtInst %1 43 %295 %50 %47 
					                                                OpStore %215 %296 
					                          Private f32* %299 = OpAccessChain %73 %27 
					                                   f32 %300 = OpLoad %299 
					                                   f32 %301 = OpFNegate %300 
					                          Uniform f32* %302 = OpAccessChain %35 %37 %38 
					                                   f32 %303 = OpLoad %302 
					                                  bool %304 = OpFOrdGreaterThanEqual %301 %303 
					                                                OpStore %298 %304 
					                                  bool %306 = OpLoad %298 
					                                   f32 %307 = OpSelect %306 %47 %50 
					                                                OpStore %305 %307 
					                                   f32 %308 = OpLoad %215 
					                                   f32 %309 = OpLoad %305 
					                                   f32 %310 = OpFMul %308 %309 
					                                                OpStore %215 %310 
					                                 f32_4 %311 = OpLoad %73 
					                                 f32_3 %312 = OpVectorShuffle %311 %311 0 1 2 
					                                 f32_4 %313 = OpLoad %46 
					                                 f32_4 %314 = OpVectorShuffle %313 %312 4 5 6 3 
					                                                OpStore %46 %314 
					                                 f32_4 %315 = OpLoad %46 
					                                   f32 %316 = OpLoad %258 
					                                 f32_4 %317 = OpCompositeConstruct %316 %316 %316 %316 
					                                 f32_4 %318 = OpFMul %315 %317 
					                                 f32_4 %319 = OpLoad %49 
					                                 f32_4 %320 = OpFAdd %318 %319 
					                                                OpStore %49 %320 
					                                 f32_4 %321 = OpLoad %46 
					                                   f32 %322 = OpLoad %215 
					                                 f32_4 %323 = OpCompositeConstruct %322 %322 %322 %322 
					                                 f32_4 %324 = OpFMul %321 %323 
					                                 f32_4 %325 = OpLoad %56 
					                                 f32_4 %326 = OpFAdd %324 %325 
					                                                OpStore %56 %326 
					                                                OpBranch %67 
					                                        %67 = OpLabel 
					                                   i32 %327 = OpLoad %62 
					                                   i32 %328 = OpIAdd %327 %37 
					                                                OpStore %62 %328 
					                                                OpBranch %64 
					                                        %66 = OpLabel 
					                          Private f32* %330 = OpAccessChain %49 %27 
					                                   f32 %331 = OpLoad %330 
					                                  bool %332 = OpFOrdEqual %331 %50 
					                                                OpStore %329 %332 
					                                  bool %333 = OpLoad %329 
					                                   f32 %334 = OpSelect %333 %47 %50 
					                          Private f32* %335 = OpAccessChain %9 %29 
					                                                OpStore %335 %334 
					                          Private f32* %336 = OpAccessChain %9 %29 
					                                   f32 %337 = OpLoad %336 
					                          Private f32* %338 = OpAccessChain %49 %27 
					                                   f32 %339 = OpLoad %338 
					                                   f32 %340 = OpFAdd %337 %339 
					                          Private f32* %341 = OpAccessChain %9 %29 
					                                                OpStore %341 %340 
					                                 f32_4 %342 = OpLoad %49 
					                                 f32_3 %343 = OpVectorShuffle %342 %342 0 1 2 
					                                 f32_3 %344 = OpLoad %9 
					                                 f32_3 %345 = OpVectorShuffle %344 %344 0 0 0 
					                                 f32_3 %346 = OpFDiv %343 %345 
					                                                OpStore %9 %346 
					                          Private f32* %348 = OpAccessChain %56 %27 
					                                   f32 %349 = OpLoad %348 
					                                  bool %350 = OpFOrdEqual %349 %50 
					                                                OpStore %347 %350 
					                                  bool %351 = OpLoad %347 
					                                   f32 %352 = OpSelect %351 %47 %50 
					                                                OpStore %215 %352 
					                                   f32 %353 = OpLoad %215 
					                          Private f32* %354 = OpAccessChain %56 %27 
					                                   f32 %355 = OpLoad %354 
					                                   f32 %356 = OpFAdd %353 %355 
					                                                OpStore %215 %356 
					                                 f32_4 %357 = OpLoad %56 
					                                 f32_3 %358 = OpVectorShuffle %357 %357 0 1 2 
					                                   f32 %359 = OpLoad %215 
					                                 f32_3 %360 = OpCompositeConstruct %359 %359 %359 
					                                 f32_3 %361 = OpFDiv %358 %360 
					                                 f32_4 %362 = OpLoad %46 
					                                 f32_4 %363 = OpVectorShuffle %362 %361 4 5 6 3 
					                                                OpStore %46 %363 
					                          Private f32* %364 = OpAccessChain %56 %27 
					                                   f32 %365 = OpLoad %364 
					                                   f32 %367 = OpFMul %365 %366 
					                                                OpStore %215 %367 
					                                   f32 %368 = OpLoad %215 
					                                   f32 %369 = OpExtInst %1 37 %368 %47 
					                                                OpStore %215 %369 
					                                 f32_3 %370 = OpLoad %9 
					                                 f32_3 %371 = OpFNegate %370 
					                                 f32_4 %372 = OpLoad %46 
					                                 f32_3 %373 = OpVectorShuffle %372 %372 0 1 2 
					                                 f32_3 %374 = OpFAdd %371 %373 
					                                 f32_4 %375 = OpLoad %46 
					                                 f32_4 %376 = OpVectorShuffle %375 %374 4 5 6 3 
					                                                OpStore %46 %376 
					                                   f32 %379 = OpLoad %215 
					                                 f32_3 %380 = OpCompositeConstruct %379 %379 %379 
					                                 f32_4 %381 = OpLoad %46 
					                                 f32_3 %382 = OpVectorShuffle %381 %381 0 1 2 
					                                 f32_3 %383 = OpFMul %380 %382 
					                                 f32_3 %384 = OpLoad %9 
					                                 f32_3 %385 = OpFAdd %383 %384 
					                                 f32_4 %386 = OpLoad %378 
					                                 f32_4 %387 = OpVectorShuffle %386 %385 4 5 6 3 
					                                                OpStore %378 %387 
					                                   f32 %388 = OpLoad %215 
					                           Output f32* %390 = OpAccessChain %378 %27 
					                                                OpStore %390 %388 
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
					vec2 ImmCB_0_0_0[43];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
						ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
						ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
						ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
						ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
						ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
						ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
						ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
						ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
						ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
						ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
						ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
						ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
						ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
						ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
						ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
						ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
						ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
						ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
						ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
						ImmCB_0_0_0[22] = vec2(1.0, 0.0);
						ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
						ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
						ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
						ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
						ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
						ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
						ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
						ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
						ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
						ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
						ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
						ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
						ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
						ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
						ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.0730602965;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
			Name "Bokeh Filter (very large)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 401355
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[71];
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _MaxCoC;
					uniform 	float _RcpAspect;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
						ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
						ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
						ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
						ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
						ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
						ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
						ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
						ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
						ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
						ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
						ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
						ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
						ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
						ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
						ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
						ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
						ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
						ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
						ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
						ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
						ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
						ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
						ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
						ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
						ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
						ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
						ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
						ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
						ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
						ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
						ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
						ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
						ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
						ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
						ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
						ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
						ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
						ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
						ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
						ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
						ImmCB_0_0_0[43] = vec2(1.0, 0.0);
						ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
						ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
						ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
						ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
						ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
						ImmCB_0_0_0[50] = vec2(0.0, 1.0);
						ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
						ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
						ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
						ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
						ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
						ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
						ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
						ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
						ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
						ImmCB_0_0_0[64] = vec2(0.0, -1.0);
						ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
						ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
						ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
						ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
						ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.0442477837;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
					; Bound: 459
					; Schema: 0
					                                                OpCapability Shader 
					                                         %1 = OpExtInstImport "GLSL.std.450" 
					                                                OpMemoryModel Logical GLSL450 
					                                                OpEntryPoint Fragment %4 "main" %22 %297 %443 
					                                                OpExecutionMode %4 OriginUpperLeft 
					                                                OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                OpDecorate %12 DescriptorSet 12 
					                                                OpDecorate %12 Binding 12 
					                                                OpDecorate %16 DescriptorSet 16 
					                                                OpDecorate %16 Binding 16 
					                                                OpDecorate vs_TEXCOORD1 Location 22 
					                                                OpMemberDecorate %33 0 Offset 33 
					                                                OpMemberDecorate %33 1 Offset 33 
					                                                OpMemberDecorate %33 2 Offset 33 
					                                                OpMemberDecorate %33 3 Offset 33 
					                                                OpDecorate %33 Block 
					                                                OpDecorate %35 DescriptorSet 35 
					                                                OpDecorate %35 Binding 35 
					                                                OpDecorate vs_TEXCOORD0 Location 297 
					                                                OpDecorate %443 Location 443 
					                                         %2 = OpTypeVoid 
					                                         %3 = OpTypeFunction %2 
					                                         %6 = OpTypeFloat 32 
					                                         %7 = OpTypeVector %6 3 
					                                         %8 = OpTypePointer Private %7 
					                          Private f32_3* %9 = OpVariable Private 
					                                        %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                        %11 = OpTypePointer UniformConstant %10 
					   UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                        %14 = OpTypeSampler 
					                                        %15 = OpTypePointer UniformConstant %14 
					               UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                        %18 = OpTypeSampledImage %10 
					                                        %20 = OpTypeVector %6 2 
					                                        %21 = OpTypePointer Input %20 
					                  Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                        %24 = OpTypeVector %6 4 
					                                        %26 = OpTypeInt 32 0 
					                                    u32 %27 = OpConstant 3 
					                                    u32 %29 = OpConstant 0 
					                                        %30 = OpTypePointer Private %6 
					                           Private f32* %32 = OpVariable Private 
					                                        %33 = OpTypeStruct %6 %24 %6 %6 
					                                        %34 = OpTypePointer Uniform %33 
					Uniform struct {f32; f32_4; f32; f32;}* %35 = OpVariable Uniform 
					                                        %36 = OpTypeInt 32 1 
					                                    i32 %37 = OpConstant 1 
					                                    u32 %38 = OpConstant 1 
					                                        %39 = OpTypePointer Uniform %6 
					                                        %45 = OpTypePointer Private %24 
					                         Private f32_4* %46 = OpVariable Private 
					                                    f32 %47 = OpConstant 3,674022E-40 
					                         Private f32_4* %49 = OpVariable Private 
					                                    f32 %50 = OpConstant 3,674022E-40 
					                                    u32 %53 = OpConstant 2 
					                         Private f32_4* %56 = OpVariable Private 
					                                        %61 = OpTypePointer Function %36 
					                                    i32 %63 = OpConstant 0 
					                                    i32 %70 = OpConstant 71 
					                                        %71 = OpTypeBool 
					                         Private f32_4* %73 = OpVariable Private 
					                                    i32 %74 = OpConstant 2 
					                                        %83 = OpTypeVector %26 4 
					                                    u32 %84 = OpConstant 71 
					                                        %85 = OpTypeArray %83 %84 
					                                  u32_4 %86 = OpConstantComposite %29 %29 %29 %29 
					                                    u32 %87 = OpConstant 1049443788 
					                                  u32_4 %88 = OpConstantComposite %87 %29 %29 %29 
					                                    u32 %89 = OpConstant 1043341321 
					                                    u32 %90 = OpConstant 1046272668 
					                                  u32_4 %91 = OpConstantComposite %89 %90 %29 %29 
					                                    u32 %92 = OpConstant 3178983152 
					                                    u32 %93 = OpConstant 1049211711 
					                                  u32_4 %94 = OpConstantComposite %92 %93 %29 %29 
					                                    u32 %95 = OpConstant 3195961881 
					                                    u32 %96 = OpConstant 1039474978 
					                                  u32_4 %97 = OpConstantComposite %95 %96 %29 %29 
					                                    u32 %98 = OpConstant 3186958623 
					                                  u32_4 %99 = OpConstantComposite %95 %98 %29 %29 
					                                   u32 %100 = OpConstant 3178983122 
					                                   u32 %101 = OpConstant 3196695360 
					                                 u32_4 %102 = OpConstantComposite %100 %101 %29 %29 
					                                   u32 %103 = OpConstant 1043341319 
					                                   u32 %104 = OpConstant 3193756318 
					                                 u32_4 %105 = OpConstantComposite %103 %104 %29 %29 
					                                   u32 %106 = OpConstant 1057253870 
					                                 u32_4 %107 = OpConstantComposite %106 %29 %29 %29 
					                                   u32 %108 = OpConstant 1055824373 
					                                   u32 %109 = OpConstant 1046859531 
					                                 u32_4 %110 = OpConstantComposite %108 %109 %29 %29 
					                                   u32 %111 = OpConstant 1051008519 
					                                   u32 %112 = OpConstant 1053756656 
					                                 u32_4 %113 = OpConstantComposite %111 %112 %29 %29 
					                                   u32 %114 = OpConstant 1038858241 
					                                   u32 %115 = OpConstant 1057036298 
					                                 u32_4 %116 = OpConstantComposite %114 %115 %29 %29 
					                                   u32 %117 = OpConstant 3186341887 
					                                 u32_4 %118 = OpConstantComposite %117 %115 %29 %29 
					                                   u32 %119 = OpConstant 3198492170 
					                                   u32 %120 = OpConstant 1053756654 
					                                 u32_4 %121 = OpConstantComposite %119 %120 %29 %29 
					                                   u32 %122 = OpConstant 3203308021 
					                                   u32 %123 = OpConstant 1046859533 
					                                 u32_4 %124 = OpConstantComposite %122 %123 %29 %29 
					                                   u32 %125 = OpConstant 3204737518 
					                                 u32_4 %126 = OpConstantComposite %125 %29 %29 %29 
					                                   u32 %127 = OpConstant 3194343179 
					                                 u32_4 %128 = OpConstantComposite %122 %127 %29 %29 
					                                   u32 %129 = OpConstant 3198492164 
					                                   u32 %130 = OpConstant 3201240306 
					                                 u32_4 %131 = OpConstantComposite %129 %130 %29 %29 
					                                   u32 %132 = OpConstant 3186341859 
					                                   u32 %133 = OpConstant 3204519947 
					                                 u32_4 %134 = OpConstantComposite %132 %133 %29 %29 
					                                   u32 %135 = OpConstant 1038858277 
					                                   u32 %136 = OpConstant 3204519945 
					                                 u32_4 %137 = OpConstantComposite %135 %136 %29 %29 
					                                   u32 %138 = OpConstant 1051008517 
					                                 u32_4 %139 = OpConstantComposite %138 %130 %29 %29 
					                                 u32_4 %140 = OpConstantComposite %108 %127 %29 %29 
					                                   u32 %141 = OpConstant 1061303543 
					                                 u32_4 %142 = OpConstantComposite %141 %29 %29 %29 
					                                   u32 %143 = OpConstant 1060738094 
					                                   u32 %144 = OpConstant 1046804821 
					                                 u32_4 %145 = OpConstantComposite %143 %144 %29 %29 
					                                   u32 %146 = OpConstant 1059091989 
					                                   u32 %147 = OpConstant 1054526754 
					                                 u32_4 %148 = OpConstantComposite %146 %147 %29 %29 
					                                   u32 %149 = OpConstant 1056058378 
					                                   u32 %150 = OpConstant 1058526794 
					                                 u32_4 %151 = OpConstantComposite %149 %150 %29 %29 
					                                   u32 %152 = OpConstant 1049487178 
					                                   u32 %153 = OpConstant 1060423736 
					                                 u32_4 %154 = OpConstantComposite %152 %153 %29 %29 
					                                   u32 %155 = OpConstant 1030239637 
					                                   u32 %156 = OpConstant 1061267955 
					                                 u32_4 %157 = OpConstantComposite %155 %156 %29 %29 
					                                   u32 %158 = OpConstant 3190611012 
					                                   u32 %159 = OpConstant 1060984437 
					                                 u32_4 %160 = OpConstantComposite %158 %159 %29 %29 
					                                   u32 %161 = OpConstant 3200398585 
					                                   u32 %162 = OpConstant 1059598375 
					                                 u32_4 %163 = OpConstantComposite %161 %162 %29 %29 
					                                   u32 %164 = OpConstant 3205389598 
					                                   u32 %165 = OpConstant 1057232927 
					                                 u32_4 %166 = OpConstantComposite %164 %165 %29 %29 
					                                   u32 %167 = OpConstant 3207526768 
					                                   u32 %168 = OpConstant 1051231942 
					                                 u32_4 %169 = OpConstantComposite %167 %168 %29 %29 
					                                   u32 %170 = OpConstant 3208645035 
					                                   u32 %171 = OpConstant 1038585692 
					                                 u32_4 %172 = OpConstantComposite %170 %171 %29 %29 
					                                   u32 %173 = OpConstant 3186069381 
					                                 u32_4 %174 = OpConstantComposite %170 %173 %29 %29 
					                                   u32 %175 = OpConstant 3198715588 
					                                 u32_4 %176 = OpConstantComposite %167 %175 %29 %29 
					                                   u32 %177 = OpConstant 3205389597 
					                                   u32 %178 = OpConstant 3204716577 
					                                 u32_4 %179 = OpConstantComposite %177 %178 %29 %29 
					                                   u32 %180 = OpConstant 3200398581 
					                                   u32 %181 = OpConstant 3207082024 
					                                 u32_4 %182 = OpConstantComposite %180 %181 %29 %29 
					                                   u32 %183 = OpConstant 3190611015 
					                                   u32 %184 = OpConstant 3208468085 
					                                 u32_4 %185 = OpConstantComposite %183 %184 %29 %29 
					                                   u32 %186 = OpConstant 1030239696 
					                                   u32 %187 = OpConstant 3208751602 
					                                 u32_4 %188 = OpConstantComposite %186 %187 %29 %29 
					                                   u32 %189 = OpConstant 1049487191 
					                                   u32 %190 = OpConstant 3207907381 
					                                 u32_4 %191 = OpConstantComposite %189 %190 %29 %29 
					                                   u32 %192 = OpConstant 1056058375 
					                                   u32 %193 = OpConstant 3206010444 
					                                 u32_4 %194 = OpConstantComposite %192 %193 %29 %29 
					                                   u32 %195 = OpConstant 1059091990 
					                                   u32 %196 = OpConstant 3202010399 
					                                 u32_4 %197 = OpConstantComposite %195 %196 %29 %29 
					                                   u32 %198 = OpConstant 1060738095 
					                                   u32 %199 = OpConstant 3194288451 
					                                 u32_4 %200 = OpConstantComposite %198 %199 %29 %29 
					                                   u32 %201 = OpConstant 1065353216 
					                                 u32_4 %202 = OpConstantComposite %201 %29 %29 %29 
					                                   u32 %203 = OpConstant 1064932576 
					                                   u32 %204 = OpConstant 1046731911 
					                                 u32_4 %205 = OpConstantComposite %203 %204 %29 %29 
					                                   u32 %206 = OpConstant 1063691749 
					                                   u32 %207 = OpConstant 1054746115 
					                                 u32_4 %208 = OpConstantComposite %206 %207 %29 %29 
					                                   u32 %209 = OpConstant 1061692956 
					                                   u32 %210 = OpConstant 1059036423 
					                                 u32_4 %211 = OpConstantComposite %209 %210 %29 %29 
					                                 u32_4 %212 = OpConstantComposite %210 %209 %29 %29 
					                                   u32 %213 = OpConstant 1054746111 
					                                   u32 %214 = OpConstant 1063691750 
					                                 u32_4 %215 = OpConstantComposite %213 %214 %29 %29 
					                                   u32 %216 = OpConstant 1046731914 
					                                 u32_4 %217 = OpConstantComposite %216 %203 %29 %29 
					                                 u32_4 %218 = OpConstantComposite %29 %201 %29 %29 
					                                   u32 %219 = OpConstant 3194215560 
					                                 u32_4 %220 = OpConstantComposite %219 %203 %29 %29 
					                                   u32 %221 = OpConstant 3202229766 
					                                 u32_4 %222 = OpConstantComposite %221 %206 %29 %29 
					                                   u32 %223 = OpConstant 3206520074 
					                                   u32 %224 = OpConstant 1061692954 
					                                 u32_4 %225 = OpConstantComposite %223 %224 %29 %29 
					                                   u32 %226 = OpConstant 3209176607 
					                                   u32 %227 = OpConstant 1059036419 
					                                 u32_4 %228 = OpConstantComposite %226 %227 %29 %29 
					                                   u32 %229 = OpConstant 3211175397 
					                                   u32 %230 = OpConstant 1054746117 
					                                 u32_4 %231 = OpConstantComposite %229 %230 %29 %29 
					                                   u32 %232 = OpConstant 3212416224 
					                                 u32_4 %233 = OpConstantComposite %232 %204 %29 %29 
					                                   u32 %234 = OpConstant 3212836864 
					                                 u32_4 %235 = OpConstantComposite %234 %29 %29 %29 
					                                   u32 %236 = OpConstant 3194215555 
					                                 u32_4 %237 = OpConstantComposite %232 %236 %29 %29 
					                                   u32 %238 = OpConstant 3202229763 
					                                 u32_4 %239 = OpConstantComposite %229 %238 %29 %29 
					                                   u32 %240 = OpConstant 3209176602 
					                                   u32 %241 = OpConstant 3206520073 
					                                 u32_4 %242 = OpConstantComposite %240 %241 %29 %29 
					                                   u32 %243 = OpConstant 3206520068 
					                                   u32 %244 = OpConstant 3209176606 
					                                 u32_4 %245 = OpConstantComposite %243 %244 %29 %29 
					                                   u32 %246 = OpConstant 3202229753 
					                                   u32 %247 = OpConstant 3211175400 
					                                 u32_4 %248 = OpConstantComposite %246 %247 %29 %29 
					                                   u32 %249 = OpConstant 3194215533 
					                                   u32 %250 = OpConstant 3212416226 
					                                 u32_4 %251 = OpConstantComposite %249 %250 %29 %29 
					                                 u32_4 %252 = OpConstantComposite %29 %234 %29 %29 
					                                   u32 %253 = OpConstant 1046731949 
					                                   u32 %254 = OpConstant 3212416222 
					                                 u32_4 %255 = OpConstantComposite %253 %254 %29 %29 
					                                   u32 %256 = OpConstant 1054746106 
					                                   u32 %257 = OpConstant 3211175399 
					                                 u32_4 %258 = OpConstantComposite %256 %257 %29 %29 
					                                   u32 %259 = OpConstant 1059036421 
					                                 u32_4 %260 = OpConstantComposite %259 %244 %29 %29 
					                                   u32 %261 = OpConstant 1061692955 
					                                   u32 %262 = OpConstant 3206520072 
					                                 u32_4 %263 = OpConstantComposite %261 %262 %29 %29 
					                                 u32_4 %264 = OpConstantComposite %206 %238 %29 %29 
					                                   u32 %265 = OpConstant 3194215554 
					                                 u32_4 %266 = OpConstantComposite %203 %265 %29 %29 
					                             u32_4[71] %267 = OpConstantComposite %86 %88 %91 %94 %97 %99 %102 %105 %107 %110 %113 %116 %118 %121 %124 %126 %128 %131 %134 %137 %139 %140 %142 %145 %148 %151 %154 %157 %160 %163 %166 %169 %172 %174 %176 %179 %182 %185 %188 %191 %194 %197 %200 %202 %205 %208 %211 %212 %215 %217 %218 %220 %222 %225 %228 %231 %233 %235 %237 %239 %242 %245 %248 %251 %252 %255 %258 %260 %263 %264 %266 
					                                       %269 = OpTypeVector %26 2 
					                                       %270 = OpTypePointer Function %85 
					                                       %272 = OpTypePointer Function %83 
					                          Private f32* %280 = OpVariable Private 
					                                   i32 %290 = OpConstant 3 
					                  Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                          Private f32* %323 = OpVariable Private 
					                                   f32 %337 = OpConstant 3,674022E-40 
					                                       %362 = OpTypePointer Private %71 
					                         Private bool* %363 = OpVariable Private 
					                          Private f32* %370 = OpVariable Private 
					                         Private bool* %394 = OpVariable Private 
					                         Private bool* %412 = OpVariable Private 
					                                   f32 %431 = OpConstant 3,674022E-40 
					                                       %442 = OpTypePointer Output %24 
					                         Output f32_4* %443 = OpVariable Output 
					                                       %454 = OpTypePointer Output %6 
					                                       %457 = OpTypePointer Private %36 
					                          Private i32* %458 = OpVariable Private 
					                                    void %4 = OpFunction None %3 
					                                         %5 = OpLabel 
					                          Function i32* %62 = OpVariable Function 
					                   Function u32_4[71]* %271 = OpVariable Function 
					                    read_only Texture2D %13 = OpLoad %12 
					                                sampler %17 = OpLoad %16 
					             read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                  f32_2 %23 = OpLoad vs_TEXCOORD1 
					                                  f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                                    f32 %28 = OpCompositeExtract %25 3 
					                           Private f32* %31 = OpAccessChain %9 %29 
					                                                OpStore %31 %28 
					                           Uniform f32* %40 = OpAccessChain %35 %37 %38 
					                                    f32 %41 = OpLoad %40 
					                           Uniform f32* %42 = OpAccessChain %35 %37 %38 
					                                    f32 %43 = OpLoad %42 
					                                    f32 %44 = OpFAdd %41 %43 
					                                                OpStore %32 %44 
					                           Private f32* %48 = OpAccessChain %46 %27 
					                                                OpStore %48 %47 
					                           Private f32* %51 = OpAccessChain %49 %29 
					                                                OpStore %51 %50 
					                           Private f32* %52 = OpAccessChain %49 %38 
					                                                OpStore %52 %50 
					                           Private f32* %54 = OpAccessChain %49 %53 
					                                                OpStore %54 %50 
					                           Private f32* %55 = OpAccessChain %49 %27 
					                                                OpStore %55 %50 
					                           Private f32* %57 = OpAccessChain %56 %29 
					                                                OpStore %57 %50 
					                           Private f32* %58 = OpAccessChain %56 %38 
					                                                OpStore %58 %50 
					                           Private f32* %59 = OpAccessChain %56 %53 
					                                                OpStore %59 %50 
					                           Private f32* %60 = OpAccessChain %56 %27 
					                                                OpStore %60 %50 
					                                                OpStore %62 %63 
					                                                OpBranch %64 
					                                        %64 = OpLabel 
					                                                OpLoopMerge %66 %67 None 
					                                                OpBranch %68 
					                                        %68 = OpLabel 
					                                    i32 %69 = OpLoad %62 
					                                   bool %72 = OpSLessThan %69 %70 
					                                                OpBranchConditional %72 %65 %66 
					                                        %65 = OpLabel 
					                           Uniform f32* %75 = OpAccessChain %35 %74 
					                                    f32 %76 = OpLoad %75 
					                           Uniform f32* %77 = OpAccessChain %35 %74 
					                                    f32 %78 = OpLoad %77 
					                                  f32_2 %79 = OpCompositeConstruct %76 %78 
					                                    f32 %80 = OpCompositeExtract %79 0 
					                                    f32 %81 = OpCompositeExtract %79 1 
					                                  f32_2 %82 = OpCompositeConstruct %80 %81 
					                                   i32 %268 = OpLoad %62 
					                                                OpStore %271 %267 
					                       Function u32_4* %273 = OpAccessChain %271 %268 
					                                 u32_4 %274 = OpLoad %273 
					                                 u32_2 %275 = OpVectorShuffle %274 %274 0 1 
					                                 f32_2 %276 = OpBitcast %275 
					                                 f32_2 %277 = OpFMul %82 %276 
					                                 f32_4 %278 = OpLoad %73 
					                                 f32_4 %279 = OpVectorShuffle %278 %277 0 4 5 3 
					                                                OpStore %73 %279 
					                                 f32_4 %281 = OpLoad %73 
					                                 f32_2 %282 = OpVectorShuffle %281 %281 1 2 
					                                 f32_4 %283 = OpLoad %73 
					                                 f32_2 %284 = OpVectorShuffle %283 %283 1 2 
					                                   f32 %285 = OpDot %282 %284 
					                                                OpStore %280 %285 
					                                   f32 %286 = OpLoad %280 
					                                   f32 %287 = OpExtInst %1 31 %286 
					                                                OpStore %280 %287 
					                          Private f32* %288 = OpAccessChain %73 %38 
					                                   f32 %289 = OpLoad %288 
					                          Uniform f32* %291 = OpAccessChain %35 %290 
					                                   f32 %292 = OpLoad %291 
					                                   f32 %293 = OpFMul %289 %292 
					                          Private f32* %294 = OpAccessChain %73 %29 
					                                                OpStore %294 %293 
					                                 f32_4 %295 = OpLoad %73 
					                                 f32_2 %296 = OpVectorShuffle %295 %295 0 2 
					                                 f32_2 %298 = OpLoad vs_TEXCOORD0 
					                                 f32_2 %299 = OpFAdd %296 %298 
					                                 f32_4 %300 = OpLoad %73 
					                                 f32_4 %301 = OpVectorShuffle %300 %299 4 5 2 3 
					                                                OpStore %73 %301 
					                                 f32_4 %302 = OpLoad %73 
					                                 f32_2 %303 = OpVectorShuffle %302 %302 0 1 
					                                 f32_2 %304 = OpCompositeConstruct %50 %50 
					                                 f32_2 %305 = OpCompositeConstruct %47 %47 
					                                 f32_2 %306 = OpExtInst %1 43 %303 %304 %305 
					                                 f32_4 %307 = OpLoad %73 
					                                 f32_4 %308 = OpVectorShuffle %307 %306 4 5 2 3 
					                                                OpStore %73 %308 
					                                 f32_4 %309 = OpLoad %73 
					                                 f32_2 %310 = OpVectorShuffle %309 %309 0 1 
					                          Uniform f32* %311 = OpAccessChain %35 %63 
					                                   f32 %312 = OpLoad %311 
					                                 f32_2 %313 = OpCompositeConstruct %312 %312 
					                                 f32_2 %314 = OpFMul %310 %313 
					                                 f32_4 %315 = OpLoad %73 
					                                 f32_4 %316 = OpVectorShuffle %315 %314 4 5 2 3 
					                                                OpStore %73 %316 
					                   read_only Texture2D %317 = OpLoad %12 
					                               sampler %318 = OpLoad %16 
					            read_only Texture2DSampled %319 = OpSampledImage %317 %318 
					                                 f32_4 %320 = OpLoad %73 
					                                 f32_2 %321 = OpVectorShuffle %320 %320 0 1 
					                                 f32_4 %322 = OpImageSampleImplicitLod %319 %321 
					                                                OpStore %73 %322 
					                          Private f32* %324 = OpAccessChain %9 %29 
					                                   f32 %325 = OpLoad %324 
					                          Private f32* %326 = OpAccessChain %73 %27 
					                                   f32 %327 = OpLoad %326 
					                                   f32 %328 = OpExtInst %1 37 %325 %327 
					                                                OpStore %323 %328 
					                                   f32 %329 = OpLoad %323 
					                                   f32 %330 = OpExtInst %1 40 %329 %50 
					                                                OpStore %323 %330 
					                                   f32 %331 = OpLoad %280 
					                                   f32 %332 = OpFNegate %331 
					                                   f32 %333 = OpLoad %323 
					                                   f32 %334 = OpFAdd %332 %333 
					                                                OpStore %323 %334 
					                          Uniform f32* %335 = OpAccessChain %35 %37 %38 
					                                   f32 %336 = OpLoad %335 
					                                   f32 %338 = OpFMul %336 %337 
					                                   f32 %339 = OpLoad %323 
					                                   f32 %340 = OpFAdd %338 %339 
					                                                OpStore %323 %340 
					                                   f32 %341 = OpLoad %323 
					                                   f32 %342 = OpLoad %32 
					                                   f32 %343 = OpFDiv %341 %342 
					                                                OpStore %323 %343 
					                                   f32 %344 = OpLoad %323 
					                                   f32 %345 = OpExtInst %1 43 %344 %50 %47 
					                                                OpStore %323 %345 
					                                   f32 %346 = OpLoad %280 
					                                   f32 %347 = OpFNegate %346 
					                          Private f32* %348 = OpAccessChain %73 %27 
					                                   f32 %349 = OpLoad %348 
					                                   f32 %350 = OpFNegate %349 
					                                   f32 %351 = OpFAdd %347 %350 
					                                                OpStore %280 %351 
					                          Uniform f32* %352 = OpAccessChain %35 %37 %38 
					                                   f32 %353 = OpLoad %352 
					                                   f32 %354 = OpFMul %353 %337 
					                                   f32 %355 = OpLoad %280 
					                                   f32 %356 = OpFAdd %354 %355 
					                                                OpStore %280 %356 
					                                   f32 %357 = OpLoad %280 
					                                   f32 %358 = OpLoad %32 
					                                   f32 %359 = OpFDiv %357 %358 
					                                                OpStore %280 %359 
					                                   f32 %360 = OpLoad %280 
					                                   f32 %361 = OpExtInst %1 43 %360 %50 %47 
					                                                OpStore %280 %361 
					                          Private f32* %364 = OpAccessChain %73 %27 
					                                   f32 %365 = OpLoad %364 
					                                   f32 %366 = OpFNegate %365 
					                          Uniform f32* %367 = OpAccessChain %35 %37 %38 
					                                   f32 %368 = OpLoad %367 
					                                  bool %369 = OpFOrdGreaterThanEqual %366 %368 
					                                                OpStore %363 %369 
					                                  bool %371 = OpLoad %363 
					                                   f32 %372 = OpSelect %371 %47 %50 
					                                                OpStore %370 %372 
					                                   f32 %373 = OpLoad %280 
					                                   f32 %374 = OpLoad %370 
					                                   f32 %375 = OpFMul %373 %374 
					                                                OpStore %280 %375 
					                                 f32_4 %376 = OpLoad %73 
					                                 f32_3 %377 = OpVectorShuffle %376 %376 0 1 2 
					                                 f32_4 %378 = OpLoad %46 
					                                 f32_4 %379 = OpVectorShuffle %378 %377 4 5 6 3 
					                                                OpStore %46 %379 
					                                 f32_4 %380 = OpLoad %46 
					                                   f32 %381 = OpLoad %323 
					                                 f32_4 %382 = OpCompositeConstruct %381 %381 %381 %381 
					                                 f32_4 %383 = OpFMul %380 %382 
					                                 f32_4 %384 = OpLoad %49 
					                                 f32_4 %385 = OpFAdd %383 %384 
					                                                OpStore %49 %385 
					                                 f32_4 %386 = OpLoad %46 
					                                   f32 %387 = OpLoad %280 
					                                 f32_4 %388 = OpCompositeConstruct %387 %387 %387 %387 
					                                 f32_4 %389 = OpFMul %386 %388 
					                                 f32_4 %390 = OpLoad %56 
					                                 f32_4 %391 = OpFAdd %389 %390 
					                                                OpStore %56 %391 
					                                                OpBranch %67 
					                                        %67 = OpLabel 
					                                   i32 %392 = OpLoad %62 
					                                   i32 %393 = OpIAdd %392 %37 
					                                                OpStore %62 %393 
					                                                OpBranch %64 
					                                        %66 = OpLabel 
					                          Private f32* %395 = OpAccessChain %49 %27 
					                                   f32 %396 = OpLoad %395 
					                                  bool %397 = OpFOrdEqual %396 %50 
					                                                OpStore %394 %397 
					                                  bool %398 = OpLoad %394 
					                                   f32 %399 = OpSelect %398 %47 %50 
					                          Private f32* %400 = OpAccessChain %9 %29 
					                                                OpStore %400 %399 
					                          Private f32* %401 = OpAccessChain %9 %29 
					                                   f32 %402 = OpLoad %401 
					                          Private f32* %403 = OpAccessChain %49 %27 
					                                   f32 %404 = OpLoad %403 
					                                   f32 %405 = OpFAdd %402 %404 
					                          Private f32* %406 = OpAccessChain %9 %29 
					                                                OpStore %406 %405 
					                                 f32_4 %407 = OpLoad %49 
					                                 f32_3 %408 = OpVectorShuffle %407 %407 0 1 2 
					                                 f32_3 %409 = OpLoad %9 
					                                 f32_3 %410 = OpVectorShuffle %409 %409 0 0 0 
					                                 f32_3 %411 = OpFDiv %408 %410 
					                                                OpStore %9 %411 
					                          Private f32* %413 = OpAccessChain %56 %27 
					                                   f32 %414 = OpLoad %413 
					                                  bool %415 = OpFOrdEqual %414 %50 
					                                                OpStore %412 %415 
					                                  bool %416 = OpLoad %412 
					                                   f32 %417 = OpSelect %416 %47 %50 
					                                                OpStore %280 %417 
					                                   f32 %418 = OpLoad %280 
					                          Private f32* %419 = OpAccessChain %56 %27 
					                                   f32 %420 = OpLoad %419 
					                                   f32 %421 = OpFAdd %418 %420 
					                                                OpStore %280 %421 
					                                 f32_4 %422 = OpLoad %56 
					                                 f32_3 %423 = OpVectorShuffle %422 %422 0 1 2 
					                                   f32 %424 = OpLoad %280 
					                                 f32_3 %425 = OpCompositeConstruct %424 %424 %424 
					                                 f32_3 %426 = OpFDiv %423 %425 
					                                 f32_4 %427 = OpLoad %46 
					                                 f32_4 %428 = OpVectorShuffle %427 %426 4 5 6 3 
					                                                OpStore %46 %428 
					                          Private f32* %429 = OpAccessChain %56 %27 
					                                   f32 %430 = OpLoad %429 
					                                   f32 %432 = OpFMul %430 %431 
					                                                OpStore %280 %432 
					                                   f32 %433 = OpLoad %280 
					                                   f32 %434 = OpExtInst %1 37 %433 %47 
					                                                OpStore %280 %434 
					                                 f32_3 %435 = OpLoad %9 
					                                 f32_3 %436 = OpFNegate %435 
					                                 f32_4 %437 = OpLoad %46 
					                                 f32_3 %438 = OpVectorShuffle %437 %437 0 1 2 
					                                 f32_3 %439 = OpFAdd %436 %438 
					                                 f32_4 %440 = OpLoad %46 
					                                 f32_4 %441 = OpVectorShuffle %440 %439 4 5 6 3 
					                                                OpStore %46 %441 
					                                   f32 %444 = OpLoad %280 
					                                 f32_3 %445 = OpCompositeConstruct %444 %444 %444 
					                                 f32_4 %446 = OpLoad %46 
					                                 f32_3 %447 = OpVectorShuffle %446 %446 0 1 2 
					                                 f32_3 %448 = OpFMul %445 %447 
					                                 f32_3 %449 = OpLoad %9 
					                                 f32_3 %450 = OpFAdd %448 %449 
					                                 f32_4 %451 = OpLoad %443 
					                                 f32_4 %452 = OpVectorShuffle %451 %450 4 5 6 3 
					                                                OpStore %443 %452 
					                                   f32 %453 = OpLoad %280 
					                           Output f32* %455 = OpAccessChain %443 %27 
					                                                OpStore %455 %453 
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
					vec2 ImmCB_0_0_0[71];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
						ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
						ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
						ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
						ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
						ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
						ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
						ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
						ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
						ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
						ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
						ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
						ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
						ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
						ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
						ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
						ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
						ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
						ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
						ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
						ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
						ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
						ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
						ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
						ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
						ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
						ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
						ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
						ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
						ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
						ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
						ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
						ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
						ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
						ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
						ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
						ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
						ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
						ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
						ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
						ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
						ImmCB_0_0_0[43] = vec2(1.0, 0.0);
						ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
						ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
						ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
						ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
						ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
						ImmCB_0_0_0[50] = vec2(0.0, 1.0);
						ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
						ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
						ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
						ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
						ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
						ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
						ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
						ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
						ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
						ImmCB_0_0_0[64] = vec2(0.0, -1.0);
						ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
						ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
						ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
						ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
						ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.0442477837;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
			Name "Postfilter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 498732
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
						vec4 unused_0_2[5];
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
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat0 = u_xlat0 + u_xlat2;
					    u_xlat0 = u_xlat1 + u_xlat0;
					    SV_Target0 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25);
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
					; Bound: 109
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %26 %103 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %10 0 Offset 10 
					                                             OpMemberDecorate %10 1 Offset 10 
					                                             OpDecorate %10 Block 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate vs_TEXCOORD0 Location 26 
					                                             OpDecorate %46 DescriptorSet 46 
					                                             OpDecorate %46 Binding 46 
					                                             OpDecorate %50 DescriptorSet 50 
					                                             OpDecorate %50 Binding 50 
					                                             OpDecorate %103 Location 103 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeStruct %6 %7 
					                                     %11 = OpTypePointer Uniform %10 
					       Uniform struct {f32; f32_4;}* %12 = OpVariable Uniform 
					                                     %13 = OpTypeInt 32 1 
					                                 i32 %14 = OpConstant 1 
					                                     %15 = OpTypePointer Uniform %7 
					                                 f32 %20 = OpConstant 3,674022E-40 
					                                 f32 %21 = OpConstant 3,674022E-40 
					                               f32_4 %22 = OpConstantComposite %20 %20 %21 %20 
					                                     %24 = OpTypeVector %6 2 
					                                     %25 = OpTypePointer Input %24 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 f32 %31 = OpConstant 3,674022E-40 
					                                 f32 %32 = OpConstant 3,674022E-40 
					                                 i32 %37 = OpConstant 0 
					                                     %38 = OpTypePointer Uniform %6 
					                      Private f32_4* %43 = OpVariable Private 
					                                     %44 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %45 = OpTypePointer UniformConstant %44 
					UniformConstant read_only Texture2D* %46 = OpVariable UniformConstant 
					                                     %48 = OpTypeSampler 
					                                     %49 = OpTypePointer UniformConstant %48 
					            UniformConstant sampler* %50 = OpVariable UniformConstant 
					                                     %52 = OpTypeSampledImage %44 
					                               f32_4 %69 = OpConstantComposite %21 %20 %20 %20 
					                      Private f32_4* %83 = OpVariable Private 
					                                    %102 = OpTypePointer Output %7 
					                      Output f32_4* %103 = OpVariable Output 
					                                f32 %105 = OpConstant 3,674022E-40 
					                              f32_4 %106 = OpConstantComposite %105 %105 %105 %105 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                      Uniform f32_4* %16 = OpAccessChain %12 %14 
					                               f32_4 %17 = OpLoad %16 
					                               f32_4 %18 = OpVectorShuffle %17 %17 0 1 0 1 
					                               f32_4 %19 = OpFNegate %18 
					                               f32_4 %23 = OpFMul %19 %22 
					                               f32_2 %27 = OpLoad vs_TEXCOORD0 
					                               f32_4 %28 = OpVectorShuffle %27 %27 0 1 0 1 
					                               f32_4 %29 = OpFAdd %23 %28 
					                                             OpStore %9 %29 
					                               f32_4 %30 = OpLoad %9 
					                               f32_4 %33 = OpCompositeConstruct %31 %31 %31 %31 
					                               f32_4 %34 = OpCompositeConstruct %32 %32 %32 %32 
					                               f32_4 %35 = OpExtInst %1 43 %30 %33 %34 
					                                             OpStore %9 %35 
					                               f32_4 %36 = OpLoad %9 
					                        Uniform f32* %39 = OpAccessChain %12 %37 
					                                 f32 %40 = OpLoad %39 
					                               f32_4 %41 = OpCompositeConstruct %40 %40 %40 %40 
					                               f32_4 %42 = OpFMul %36 %41 
					                                             OpStore %9 %42 
					                 read_only Texture2D %47 = OpLoad %46 
					                             sampler %51 = OpLoad %50 
					          read_only Texture2DSampled %53 = OpSampledImage %47 %51 
					                               f32_4 %54 = OpLoad %9 
					                               f32_2 %55 = OpVectorShuffle %54 %54 0 1 
					                               f32_4 %56 = OpImageSampleImplicitLod %53 %55 
					                                             OpStore %43 %56 
					                 read_only Texture2D %57 = OpLoad %46 
					                             sampler %58 = OpLoad %50 
					          read_only Texture2DSampled %59 = OpSampledImage %57 %58 
					                               f32_4 %60 = OpLoad %9 
					                               f32_2 %61 = OpVectorShuffle %60 %60 2 3 
					                               f32_4 %62 = OpImageSampleImplicitLod %59 %61 
					                                             OpStore %9 %62 
					                               f32_4 %63 = OpLoad %9 
					                               f32_4 %64 = OpLoad %43 
					                               f32_4 %65 = OpFAdd %63 %64 
					                                             OpStore %9 %65 
					                      Uniform f32_4* %66 = OpAccessChain %12 %14 
					                               f32_4 %67 = OpLoad %66 
					                               f32_4 %68 = OpVectorShuffle %67 %67 0 1 0 1 
					                               f32_4 %70 = OpFMul %68 %69 
					                               f32_2 %71 = OpLoad vs_TEXCOORD0 
					                               f32_4 %72 = OpVectorShuffle %71 %71 0 1 0 1 
					                               f32_4 %73 = OpFAdd %70 %72 
					                                             OpStore %43 %73 
					                               f32_4 %74 = OpLoad %43 
					                               f32_4 %75 = OpCompositeConstruct %31 %31 %31 %31 
					                               f32_4 %76 = OpCompositeConstruct %32 %32 %32 %32 
					                               f32_4 %77 = OpExtInst %1 43 %74 %75 %76 
					                                             OpStore %43 %77 
					                               f32_4 %78 = OpLoad %43 
					                        Uniform f32* %79 = OpAccessChain %12 %37 
					                                 f32 %80 = OpLoad %79 
					                               f32_4 %81 = OpCompositeConstruct %80 %80 %80 %80 
					                               f32_4 %82 = OpFMul %78 %81 
					                                             OpStore %43 %82 
					                 read_only Texture2D %84 = OpLoad %46 
					                             sampler %85 = OpLoad %50 
					          read_only Texture2DSampled %86 = OpSampledImage %84 %85 
					                               f32_4 %87 = OpLoad %43 
					                               f32_2 %88 = OpVectorShuffle %87 %87 0 1 
					                               f32_4 %89 = OpImageSampleImplicitLod %86 %88 
					                                             OpStore %83 %89 
					                 read_only Texture2D %90 = OpLoad %46 
					                             sampler %91 = OpLoad %50 
					          read_only Texture2DSampled %92 = OpSampledImage %90 %91 
					                               f32_4 %93 = OpLoad %43 
					                               f32_2 %94 = OpVectorShuffle %93 %93 2 3 
					                               f32_4 %95 = OpImageSampleImplicitLod %92 %94 
					                                             OpStore %43 %95 
					                               f32_4 %96 = OpLoad %9 
					                               f32_4 %97 = OpLoad %83 
					                               f32_4 %98 = OpFAdd %96 %97 
					                                             OpStore %9 %98 
					                               f32_4 %99 = OpLoad %43 
					                              f32_4 %100 = OpLoad %9 
					                              f32_4 %101 = OpFAdd %99 %100 
					                                             OpStore %9 %101 
					                              f32_4 %104 = OpLoad %9 
					                              f32_4 %107 = OpFMul %104 %106 
					                                             OpStore %103 %107 
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4[3];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat0 = u_xlat0 + u_xlat2;
					    u_xlat0 = u_xlat1 + u_xlat0;
					    SV_Target0 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25);
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
			Name "Combine"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 588006
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
						vec4 unused_0_2[5];
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
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _MaxCoC;
					UNITY_LOCATION(0) uniform  sampler2D _DepthOfFieldTex;
					UNITY_LOCATION(1) uniform  sampler2D _CoCTex;
					UNITY_LOCATION(2) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = texture(_CoCTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat3 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat0.x = u_xlat0.x * _MaxCoC + (-u_xlat3);
					    u_xlat3 = float(1.0) / u_xlat3;
					    u_xlat0.x = u_xlat3 * u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6 = u_xlat0.x * u_xlat3;
					    u_xlat1 = texture(_DepthOfFieldTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat1.w;
					    u_xlat0.x = (-u_xlat6) * u_xlat1.w + u_xlat0.x;
					    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat1.w = max(u_xlat1.z, u_xlat3);
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat1 = u_xlat1 + (-u_xlat2);
					    SV_Target0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
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
					; Bound: 131
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %21 %123 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpDecorate %11 DescriptorSet 11 
					                                              OpDecorate %11 Binding 11 
					                                              OpDecorate %15 DescriptorSet 15 
					                                              OpDecorate %15 Binding 15 
					                                              OpDecorate vs_TEXCOORD1 Location 21 
					                                              OpMemberDecorate %35 0 Offset 35 
					                                              OpMemberDecorate %35 1 Offset 35 
					                                              OpDecorate %35 Block 
					                                              OpDecorate %37 DescriptorSet 37 
					                                              OpDecorate %37 Binding 37 
					                                              OpDecorate %78 DescriptorSet 78 
					                                              OpDecorate %78 Binding 78 
					                                              OpDecorate %80 DescriptorSet 80 
					                                              OpDecorate %80 Binding 80 
					                                              OpDecorate %111 DescriptorSet 111 
					                                              OpDecorate %111 Binding 111 
					                                              OpDecorate %113 DescriptorSet 113 
					                                              OpDecorate %113 Binding 113 
					                                              OpDecorate %123 Location 123 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypePointer Private %6 
					                          Private f32* %8 = OpVariable Private 
					                                       %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                      %10 = OpTypePointer UniformConstant %9 
					 UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
					                                      %13 = OpTypeSampler 
					                                      %14 = OpTypePointer UniformConstant %13 
					             UniformConstant sampler* %15 = OpVariable UniformConstant 
					                                      %17 = OpTypeSampledImage %9 
					                                      %19 = OpTypeVector %6 2 
					                                      %20 = OpTypePointer Input %19 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                      %23 = OpTypeVector %6 4 
					                                      %25 = OpTypeInt 32 0 
					                                  u32 %26 = OpConstant 0 
					                                  f32 %29 = OpConstant 3,674022E-40 
					                         Private f32* %34 = OpVariable Private 
					                                      %35 = OpTypeStruct %23 %6 
					                                      %36 = OpTypePointer Uniform %35 
					        Uniform struct {f32_4; f32;}* %37 = OpVariable Uniform 
					                                      %38 = OpTypeInt 32 1 
					                                  i32 %39 = OpConstant 0 
					                                  u32 %40 = OpConstant 1 
					                                      %41 = OpTypePointer Uniform %6 
					                                  i32 %48 = OpConstant 1 
					                                  f32 %55 = OpConstant 3,674022E-40 
					                                  f32 %62 = OpConstant 3,674022E-40 
					                                  f32 %65 = OpConstant 3,674022E-40 
					                                  f32 %67 = OpConstant 3,674022E-40 
					                         Private f32* %72 = OpVariable Private 
					                                      %76 = OpTypePointer Private %23 
					                       Private f32_4* %77 = OpVariable Private 
					 UniformConstant read_only Texture2D* %78 = OpVariable UniformConstant 
					             UniformConstant sampler* %80 = OpVariable UniformConstant 
					                                  u32 %88 = OpConstant 3 
					                                 u32 %104 = OpConstant 2 
					                      Private f32_4* %110 = OpVariable Private 
					UniformConstant read_only Texture2D* %111 = OpVariable UniformConstant 
					            UniformConstant sampler* %113 = OpVariable UniformConstant 
					                                     %122 = OpTypePointer Output %23 
					                       Output f32_4* %123 = OpVariable Output 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                  read_only Texture2D %12 = OpLoad %11 
					                              sampler %16 = OpLoad %15 
					           read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                                f32_2 %22 = OpLoad vs_TEXCOORD1 
					                                f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                  f32 %27 = OpCompositeExtract %24 0 
					                                              OpStore %8 %27 
					                                  f32 %28 = OpLoad %8 
					                                  f32 %30 = OpFAdd %28 %29 
					                                              OpStore %8 %30 
					                                  f32 %31 = OpLoad %8 
					                                  f32 %32 = OpLoad %8 
					                                  f32 %33 = OpFAdd %31 %32 
					                                              OpStore %8 %33 
					                         Uniform f32* %42 = OpAccessChain %37 %39 %40 
					                                  f32 %43 = OpLoad %42 
					                         Uniform f32* %44 = OpAccessChain %37 %39 %40 
					                                  f32 %45 = OpLoad %44 
					                                  f32 %46 = OpFAdd %43 %45 
					                                              OpStore %34 %46 
					                                  f32 %47 = OpLoad %8 
					                         Uniform f32* %49 = OpAccessChain %37 %48 
					                                  f32 %50 = OpLoad %49 
					                                  f32 %51 = OpFMul %47 %50 
					                                  f32 %52 = OpLoad %34 
					                                  f32 %53 = OpFNegate %52 
					                                  f32 %54 = OpFAdd %51 %53 
					                                              OpStore %8 %54 
					                                  f32 %56 = OpLoad %34 
					                                  f32 %57 = OpFDiv %55 %56 
					                                              OpStore %34 %57 
					                                  f32 %58 = OpLoad %34 
					                                  f32 %59 = OpLoad %8 
					                                  f32 %60 = OpFMul %58 %59 
					                                              OpStore %8 %60 
					                                  f32 %61 = OpLoad %8 
					                                  f32 %63 = OpExtInst %1 43 %61 %62 %55 
					                                              OpStore %8 %63 
					                                  f32 %64 = OpLoad %8 
					                                  f32 %66 = OpFMul %64 %65 
					                                  f32 %68 = OpFAdd %66 %67 
					                                              OpStore %34 %68 
					                                  f32 %69 = OpLoad %8 
					                                  f32 %70 = OpLoad %8 
					                                  f32 %71 = OpFMul %69 %70 
					                                              OpStore %8 %71 
					                                  f32 %73 = OpLoad %8 
					                                  f32 %74 = OpLoad %34 
					                                  f32 %75 = OpFMul %73 %74 
					                                              OpStore %72 %75 
					                  read_only Texture2D %79 = OpLoad %78 
					                              sampler %81 = OpLoad %80 
					           read_only Texture2DSampled %82 = OpSampledImage %79 %81 
					                                f32_2 %83 = OpLoad vs_TEXCOORD1 
					                                f32_4 %84 = OpImageSampleImplicitLod %82 %83 
					                                              OpStore %77 %84 
					                                  f32 %85 = OpLoad %34 
					                                  f32 %86 = OpLoad %8 
					                                  f32 %87 = OpFMul %85 %86 
					                         Private f32* %89 = OpAccessChain %77 %88 
					                                  f32 %90 = OpLoad %89 
					                                  f32 %91 = OpFAdd %87 %90 
					                                              OpStore %8 %91 
					                                  f32 %92 = OpLoad %72 
					                                  f32 %93 = OpFNegate %92 
					                         Private f32* %94 = OpAccessChain %77 %88 
					                                  f32 %95 = OpLoad %94 
					                                  f32 %96 = OpFMul %93 %95 
					                                  f32 %97 = OpLoad %8 
					                                  f32 %98 = OpFAdd %96 %97 
					                                              OpStore %8 %98 
					                         Private f32* %99 = OpAccessChain %77 %40 
					                                 f32 %100 = OpLoad %99 
					                        Private f32* %101 = OpAccessChain %77 %26 
					                                 f32 %102 = OpLoad %101 
					                                 f32 %103 = OpExtInst %1 40 %100 %102 
					                                              OpStore %34 %103 
					                        Private f32* %105 = OpAccessChain %77 %104 
					                                 f32 %106 = OpLoad %105 
					                                 f32 %107 = OpLoad %34 
					                                 f32 %108 = OpExtInst %1 40 %106 %107 
					                        Private f32* %109 = OpAccessChain %77 %88 
					                                              OpStore %109 %108 
					                 read_only Texture2D %112 = OpLoad %111 
					                             sampler %114 = OpLoad %113 
					          read_only Texture2DSampled %115 = OpSampledImage %112 %114 
					                               f32_2 %116 = OpLoad vs_TEXCOORD1 
					                               f32_4 %117 = OpImageSampleImplicitLod %115 %116 
					                                              OpStore %110 %117 
					                               f32_4 %118 = OpLoad %77 
					                               f32_4 %119 = OpLoad %110 
					                               f32_4 %120 = OpFNegate %119 
					                               f32_4 %121 = OpFAdd %118 %120 
					                                              OpStore %77 %121 
					                                 f32 %124 = OpLoad %8 
					                               f32_4 %125 = OpCompositeConstruct %124 %124 %124 %124 
					                               f32_4 %126 = OpLoad %77 
					                               f32_4 %127 = OpFMul %125 %126 
					                               f32_4 %128 = OpLoad %110 
					                               f32_4 %129 = OpFAdd %127 %128 
					                                              OpStore %123 %129 
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
						vec4 unused_0_2;
						float _MaxCoC;
						vec4 unused_0_4;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CoCTex;
					uniform  sampler2D _DepthOfFieldTex;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = texture(_CoCTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat3 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat0.x = u_xlat0.x * _MaxCoC + (-u_xlat3);
					    u_xlat3 = float(1.0) / u_xlat3;
					    u_xlat0.x = u_xlat3 * u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6 = u_xlat0.x * u_xlat3;
					    u_xlat1 = texture(_DepthOfFieldTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat1.w;
					    u_xlat0.x = (-u_xlat6) * u_xlat1.w + u_xlat0.x;
					    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat1.w = max(u_xlat1.z, u_xlat3);
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat1 = u_xlat1 + (-u_xlat2);
					    SV_Target0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
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
			Name "Debug Overlay"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 638956
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
						vec4 unused_0_2[5];
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
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Distance;
					uniform 	float _LensCoeff;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat3 = u_xlat0.x + (-_Distance);
					    u_xlat3 = u_xlat3 * _LensCoeff;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 80.0;
					    u_xlat3 = u_xlat0.x;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
					    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat9 = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat9 = u_xlat9 + 0.5;
					    u_xlat1.xyz = u_xlat0.xzz * vec3(u_xlat9) + vec3(0.0549999997, 0.0549999997, 0.0549999997);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.947867334, 0.947867334, 0.947867334);
					    u_xlat1.xyz = max(abs(u_xlat1.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.4000001, 2.4000001, 2.4000001);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat2.xyz = u_xlat0.xzz * vec3(0.0773993805, 0.0773993805, 0.0773993805);
					    u_xlatb0.xyz = greaterThanEqual(vec4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat0.xyzx).xyz;
					    SV_Target0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat1.x;
					    SV_Target0.y = (u_xlatb0.y) ? u_xlat2.y : u_xlat1.y;
					    SV_Target0.z = (u_xlatb0.z) ? u_xlat2.z : u_xlat1.z;
					    SV_Target0.w = 1.0;
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
					; Bound: 225
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %22 %182 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpDecorate %12 DescriptorSet 12 
					                                              OpDecorate %12 Binding 12 
					                                              OpDecorate %16 DescriptorSet 16 
					                                              OpDecorate %16 Binding 16 
					                                              OpDecorate vs_TEXCOORD1 Location 22 
					                                              OpMemberDecorate %30 0 Offset 30 
					                                              OpMemberDecorate %30 1 Offset 30 
					                                              OpMemberDecorate %30 2 Offset 30 
					                                              OpDecorate %30 Block 
					                                              OpDecorate %32 DescriptorSet 32 
					                                              OpDecorate %32 Binding 32 
					                                              OpDecorate %114 DescriptorSet 114 
					                                              OpDecorate %114 Binding 114 
					                                              OpDecorate %116 DescriptorSet 116 
					                                              OpDecorate %116 Binding 116 
					                                              OpDecorate %182 Location 182 
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
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                      %25 = OpTypeInt 32 0 
					                                  u32 %26 = OpConstant 0 
					                                      %28 = OpTypePointer Private %6 
					                                      %30 = OpTypeStruct %7 %6 %6 
					                                      %31 = OpTypePointer Uniform %30 
					   Uniform struct {f32_4; f32; f32;}* %32 = OpVariable Uniform 
					                                      %33 = OpTypeInt 32 1 
					                                  i32 %34 = OpConstant 0 
					                                  u32 %35 = OpConstant 2 
					                                      %36 = OpTypePointer Uniform %6 
					                                  u32 %42 = OpConstant 3 
					                                  f32 %47 = OpConstant 3,674022E-40 
					                         Private f32* %52 = OpVariable Private 
					                                  i32 %55 = OpConstant 1 
					                                  i32 %61 = OpConstant 2 
					                                  f32 %72 = OpConstant 3,674022E-40 
					                                  f32 %78 = OpConstant 3,674022E-40 
					                                      %88 = OpTypeVector %6 3 
					                                f32_3 %91 = OpConstantComposite %78 %47 %47 
					                                f32_3 %93 = OpConstantComposite %47 %78 %78 
					                                      %97 = OpTypePointer Private %88 
					                       Private f32_3* %98 = OpVariable Private 
					                                 f32 %102 = OpConstant 3,674022E-40 
					                               f32_3 %103 = OpConstantComposite %102 %102 %102 
					UniformConstant read_only Texture2D* %114 = OpVariable UniformConstant 
					            UniformConstant sampler* %116 = OpVariable UniformConstant 
					                        Private f32* %122 = OpVariable Private 
					                                 f32 %124 = OpConstant 3,674022E-40 
					                                 f32 %125 = OpConstant 3,674022E-40 
					                                 f32 %126 = OpConstant 3,674022E-40 
					                               f32_3 %127 = OpConstantComposite %124 %125 %126 
					                                 f32 %130 = OpConstant 3,674022E-40 
					                                 f32 %137 = OpConstant 3,674022E-40 
					                               f32_3 %138 = OpConstantComposite %137 %137 %137 
					                                 f32 %148 = OpConstant 3,674022E-40 
					                               f32_3 %149 = OpConstantComposite %148 %148 %148 
					                                 f32 %153 = OpConstant 3,674022E-40 
					                               f32_3 %154 = OpConstantComposite %153 %153 %153 
					                                 f32 %159 = OpConstant 3,674022E-40 
					                               f32_3 %160 = OpConstantComposite %159 %159 %159 
					                      Private f32_3* %164 = OpVariable Private 
					                                 f32 %167 = OpConstant 3,674022E-40 
					                               f32_3 %168 = OpConstantComposite %167 %167 %167 
					                                     %170 = OpTypeBool 
					                                     %171 = OpTypeVector %170 3 
					                                     %172 = OpTypePointer Private %171 
					                     Private bool_3* %173 = OpVariable Private 
					                                 f32 %174 = OpConstant 3,674022E-40 
					                               f32_4 %175 = OpConstantComposite %174 %174 %174 %78 
					                                     %178 = OpTypeVector %170 4 
					                                     %181 = OpTypePointer Output %7 
					                       Output f32_4* %182 = OpVariable Output 
					                                     %183 = OpTypePointer Private %170 
					                                     %186 = OpTypePointer Function %6 
					                                     %196 = OpTypePointer Output %6 
					                                 u32 %198 = OpConstant 1 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                       Function f32* %187 = OpVariable Function 
					                       Function f32* %201 = OpVariable Function 
					                       Function f32* %213 = OpVariable Function 
					                  read_only Texture2D %13 = OpLoad %12 
					                              sampler %17 = OpLoad %16 
					           read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                f32_2 %23 = OpLoad vs_TEXCOORD1 
					                                f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                  f32 %27 = OpCompositeExtract %24 0 
					                         Private f32* %29 = OpAccessChain %9 %26 
					                                              OpStore %29 %27 
					                         Uniform f32* %37 = OpAccessChain %32 %34 %35 
					                                  f32 %38 = OpLoad %37 
					                         Private f32* %39 = OpAccessChain %9 %26 
					                                  f32 %40 = OpLoad %39 
					                                  f32 %41 = OpFMul %38 %40 
					                         Uniform f32* %43 = OpAccessChain %32 %34 %42 
					                                  f32 %44 = OpLoad %43 
					                                  f32 %45 = OpFAdd %41 %44 
					                         Private f32* %46 = OpAccessChain %9 %26 
					                                              OpStore %46 %45 
					                         Private f32* %48 = OpAccessChain %9 %26 
					                                  f32 %49 = OpLoad %48 
					                                  f32 %50 = OpFDiv %47 %49 
					                         Private f32* %51 = OpAccessChain %9 %26 
					                                              OpStore %51 %50 
					                         Private f32* %53 = OpAccessChain %9 %26 
					                                  f32 %54 = OpLoad %53 
					                         Uniform f32* %56 = OpAccessChain %32 %55 
					                                  f32 %57 = OpLoad %56 
					                                  f32 %58 = OpFNegate %57 
					                                  f32 %59 = OpFAdd %54 %58 
					                                              OpStore %52 %59 
					                                  f32 %60 = OpLoad %52 
					                         Uniform f32* %62 = OpAccessChain %32 %61 
					                                  f32 %63 = OpLoad %62 
					                                  f32 %64 = OpFMul %60 %63 
					                                              OpStore %52 %64 
					                                  f32 %65 = OpLoad %52 
					                         Private f32* %66 = OpAccessChain %9 %26 
					                                  f32 %67 = OpLoad %66 
					                                  f32 %68 = OpFDiv %65 %67 
					                         Private f32* %69 = OpAccessChain %9 %26 
					                                              OpStore %69 %68 
					                         Private f32* %70 = OpAccessChain %9 %26 
					                                  f32 %71 = OpLoad %70 
					                                  f32 %73 = OpFMul %71 %72 
					                         Private f32* %74 = OpAccessChain %9 %26 
					                                              OpStore %74 %73 
					                         Private f32* %75 = OpAccessChain %9 %26 
					                                  f32 %76 = OpLoad %75 
					                                              OpStore %52 %76 
					                                  f32 %77 = OpLoad %52 
					                                  f32 %79 = OpExtInst %1 43 %77 %78 %47 
					                                              OpStore %52 %79 
					                         Private f32* %80 = OpAccessChain %9 %26 
					                                  f32 %81 = OpLoad %80 
					                                  f32 %82 = OpFNegate %81 
					                         Private f32* %83 = OpAccessChain %9 %26 
					                                              OpStore %83 %82 
					                         Private f32* %84 = OpAccessChain %9 %26 
					                                  f32 %85 = OpLoad %84 
					                                  f32 %86 = OpExtInst %1 43 %85 %78 %47 
					                         Private f32* %87 = OpAccessChain %9 %26 
					                                              OpStore %87 %86 
					                                f32_4 %89 = OpLoad %9 
					                                f32_3 %90 = OpVectorShuffle %89 %89 0 0 0 
					                                f32_3 %92 = OpFMul %90 %91 
					                                f32_3 %94 = OpFAdd %92 %93 
					                                f32_4 %95 = OpLoad %9 
					                                f32_4 %96 = OpVectorShuffle %95 %94 4 1 5 6 
					                                              OpStore %9 %96 
					                                f32_4 %99 = OpLoad %9 
					                               f32_3 %100 = OpVectorShuffle %99 %99 0 3 3 
					                               f32_3 %101 = OpFNegate %100 
					                               f32_3 %104 = OpFAdd %101 %103 
					                                              OpStore %98 %104 
					                                 f32 %105 = OpLoad %52 
					                               f32_3 %106 = OpCompositeConstruct %105 %105 %105 
					                               f32_3 %107 = OpLoad %98 
					                               f32_3 %108 = OpFMul %106 %107 
					                               f32_4 %109 = OpLoad %9 
					                               f32_3 %110 = OpVectorShuffle %109 %109 0 2 3 
					                               f32_3 %111 = OpFAdd %108 %110 
					                               f32_4 %112 = OpLoad %9 
					                               f32_4 %113 = OpVectorShuffle %112 %111 4 5 6 3 
					                                              OpStore %9 %113 
					                 read_only Texture2D %115 = OpLoad %114 
					                             sampler %117 = OpLoad %116 
					          read_only Texture2DSampled %118 = OpSampledImage %115 %117 
					                               f32_2 %119 = OpLoad vs_TEXCOORD1 
					                               f32_4 %120 = OpImageSampleImplicitLod %118 %119 
					                               f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                                              OpStore %98 %121 
					                               f32_3 %123 = OpLoad %98 
					                                 f32 %128 = OpDot %123 %127 
					                                              OpStore %122 %128 
					                                 f32 %129 = OpLoad %122 
					                                 f32 %131 = OpFAdd %129 %130 
					                                              OpStore %122 %131 
					                               f32_4 %132 = OpLoad %9 
					                               f32_3 %133 = OpVectorShuffle %132 %132 0 2 2 
					                                 f32 %134 = OpLoad %122 
					                               f32_3 %135 = OpCompositeConstruct %134 %134 %134 
					                               f32_3 %136 = OpFMul %133 %135 
					                               f32_3 %139 = OpFAdd %136 %138 
					                                              OpStore %98 %139 
					                                 f32 %140 = OpLoad %122 
					                               f32_3 %141 = OpCompositeConstruct %140 %140 %140 
					                               f32_4 %142 = OpLoad %9 
					                               f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                               f32_3 %144 = OpFMul %141 %143 
					                               f32_4 %145 = OpLoad %9 
					                               f32_4 %146 = OpVectorShuffle %145 %144 4 5 6 3 
					                                              OpStore %9 %146 
					                               f32_3 %147 = OpLoad %98 
					                               f32_3 %150 = OpFMul %147 %149 
					                                              OpStore %98 %150 
					                               f32_3 %151 = OpLoad %98 
					                               f32_3 %152 = OpExtInst %1 4 %151 
					                               f32_3 %155 = OpExtInst %1 40 %152 %154 
					                                              OpStore %98 %155 
					                               f32_3 %156 = OpLoad %98 
					                               f32_3 %157 = OpExtInst %1 30 %156 
					                                              OpStore %98 %157 
					                               f32_3 %158 = OpLoad %98 
					                               f32_3 %161 = OpFMul %158 %160 
					                                              OpStore %98 %161 
					                               f32_3 %162 = OpLoad %98 
					                               f32_3 %163 = OpExtInst %1 29 %162 
					                                              OpStore %98 %163 
					                               f32_4 %165 = OpLoad %9 
					                               f32_3 %166 = OpVectorShuffle %165 %165 0 2 2 
					                               f32_3 %169 = OpFMul %166 %168 
					                                              OpStore %164 %169 
					                               f32_4 %176 = OpLoad %9 
					                               f32_4 %177 = OpVectorShuffle %176 %176 0 1 2 0 
					                              bool_4 %179 = OpFOrdGreaterThanEqual %175 %177 
					                              bool_3 %180 = OpVectorShuffle %179 %179 0 1 2 
					                                              OpStore %173 %180 
					                       Private bool* %184 = OpAccessChain %173 %26 
					                                bool %185 = OpLoad %184 
					                                              OpSelectionMerge %189 None 
					                                              OpBranchConditional %185 %188 %192 
					                                     %188 = OpLabel 
					                        Private f32* %190 = OpAccessChain %164 %26 
					                                 f32 %191 = OpLoad %190 
					                                              OpStore %187 %191 
					                                              OpBranch %189 
					                                     %192 = OpLabel 
					                        Private f32* %193 = OpAccessChain %98 %26 
					                                 f32 %194 = OpLoad %193 
					                                              OpStore %187 %194 
					                                              OpBranch %189 
					                                     %189 = OpLabel 
					                                 f32 %195 = OpLoad %187 
					                         Output f32* %197 = OpAccessChain %182 %26 
					                                              OpStore %197 %195 
					                       Private bool* %199 = OpAccessChain %173 %198 
					                                bool %200 = OpLoad %199 
					                                              OpSelectionMerge %203 None 
					                                              OpBranchConditional %200 %202 %206 
					                                     %202 = OpLabel 
					                        Private f32* %204 = OpAccessChain %164 %198 
					                                 f32 %205 = OpLoad %204 
					                                              OpStore %201 %205 
					                                              OpBranch %203 
					                                     %206 = OpLabel 
					                        Private f32* %207 = OpAccessChain %98 %198 
					                                 f32 %208 = OpLoad %207 
					                                              OpStore %201 %208 
					                                              OpBranch %203 
					                                     %203 = OpLabel 
					                                 f32 %209 = OpLoad %201 
					                         Output f32* %210 = OpAccessChain %182 %198 
					                                              OpStore %210 %209 
					                       Private bool* %211 = OpAccessChain %173 %35 
					                                bool %212 = OpLoad %211 
					                                              OpSelectionMerge %215 None 
					                                              OpBranchConditional %212 %214 %218 
					                                     %214 = OpLabel 
					                        Private f32* %216 = OpAccessChain %164 %35 
					                                 f32 %217 = OpLoad %216 
					                                              OpStore %213 %217 
					                                              OpBranch %215 
					                                     %218 = OpLabel 
					                        Private f32* %219 = OpAccessChain %98 %35 
					                                 f32 %220 = OpLoad %219 
					                                              OpStore %213 %220 
					                                              OpBranch %215 
					                                     %215 = OpLabel 
					                                 f32 %221 = OpLoad %213 
					                         Output f32* %222 = OpAccessChain %182 %35 
					                                              OpStore %222 %221 
					                         Output f32* %223 = OpAccessChain %182 %42 
					                                              OpStore %223 %47 
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
						vec4 unused_0_0[21];
						vec4 _ZBufferParams;
						vec4 unused_0_2[8];
						float _Distance;
						float _LensCoeff;
						vec4 unused_0_5;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat3 = u_xlat0.x + (-_Distance);
					    u_xlat3 = u_xlat3 * _LensCoeff;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 80.0;
					    u_xlat3 = u_xlat0.x;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
					    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat9 = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat9 = u_xlat9 + 0.5;
					    u_xlat1.xyz = u_xlat0.xzz * vec3(u_xlat9) + vec3(0.0549999997, 0.0549999997, 0.0549999997);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.947867334, 0.947867334, 0.947867334);
					    u_xlat1.xyz = max(abs(u_xlat1.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.4000001, 2.4000001, 2.4000001);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat2.xyz = u_xlat0.xzz * vec3(0.0773993805, 0.0773993805, 0.0773993805);
					    u_xlatb0.xyz = greaterThanEqual(vec4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat0.xyzx).xyz;
					    SV_Target0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat1.x;
					    SV_Target0.y = (u_xlatb0.y) ? u_xlat2.y : u_xlat1.y;
					    SV_Target0.z = (u_xlatb0.z) ? u_xlat2.z : u_xlat1.z;
					    SV_Target0.w = 1.0;
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
	SubShader {
		Pass {
			Name "CoC Calculation"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 669107
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
						vec4 unused_0_2[5];
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
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Distance;
					uniform 	float _LensCoeff;
					uniform 	float _RcpMaxCoC;
					UNITY_LOCATION(0) uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat1;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat1 = u_xlat0.x + (-_Distance);
					    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
					    u_xlat1 = u_xlat1 * _LensCoeff;
					    u_xlat0.x = u_xlat1 / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.x * _RcpMaxCoC + 0.5;
					    SV_Target0 = u_xlat0.xxxx;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
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
					; Bound: 83
					; Schema: 0
					                                                OpCapability Shader 
					                                         %1 = OpExtInstImport "GLSL.std.450" 
					                                                OpMemoryModel Logical GLSL450 
					                                                OpEntryPoint Fragment %4 "main" %21 %74 
					                                                OpExecutionMode %4 OriginUpperLeft 
					                                                OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                OpDecorate %11 DescriptorSet 11 
					                                                OpDecorate %11 Binding 11 
					                                                OpDecorate %15 DescriptorSet 15 
					                                                OpDecorate %15 Binding 15 
					                                                OpDecorate vs_TEXCOORD1 Location 21 
					                                                OpMemberDecorate %28 0 Offset 28 
					                                                OpMemberDecorate %28 1 Offset 28 
					                                                OpMemberDecorate %28 2 Offset 28 
					                                                OpMemberDecorate %28 3 Offset 28 
					                                                OpDecorate %28 Block 
					                                                OpDecorate %30 DescriptorSet 30 
					                                                OpDecorate %30 Binding 30 
					                                                OpDecorate %74 Location 74 
					                                         %2 = OpTypeVoid 
					                                         %3 = OpTypeFunction %2 
					                                         %6 = OpTypeFloat 32 
					                                         %7 = OpTypePointer Private %6 
					                            Private f32* %8 = OpVariable Private 
					                                         %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                        %10 = OpTypePointer UniformConstant %9 
					   UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
					                                        %13 = OpTypeSampler 
					                                        %14 = OpTypePointer UniformConstant %13 
					               UniformConstant sampler* %15 = OpVariable UniformConstant 
					                                        %17 = OpTypeSampledImage %9 
					                                        %19 = OpTypeVector %6 2 
					                                        %20 = OpTypePointer Input %19 
					                  Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                        %23 = OpTypeVector %6 4 
					                                        %25 = OpTypeInt 32 0 
					                                    u32 %26 = OpConstant 0 
					                                        %28 = OpTypeStruct %23 %6 %6 %6 
					                                        %29 = OpTypePointer Uniform %28 
					Uniform struct {f32_4; f32; f32; f32;}* %30 = OpVariable Uniform 
					                                        %31 = OpTypeInt 32 1 
					                                    i32 %32 = OpConstant 0 
					                                    u32 %33 = OpConstant 2 
					                                        %34 = OpTypePointer Uniform %6 
					                                    u32 %39 = OpConstant 3 
					                                    f32 %43 = OpConstant 3,674022E-40 
					                           Private f32* %46 = OpVariable Private 
					                                    i32 %48 = OpConstant 1 
					                                    f32 %54 = OpConstant 3,674022E-40 
					                                    i32 %57 = OpConstant 2 
					                                    f32 %65 = OpConstant 3,674022E-40 
					                                    i32 %68 = OpConstant 3 
					                                        %73 = OpTypePointer Output %23 
					                          Output f32_4* %74 = OpVariable Output 
					                                    f32 %78 = OpConstant 3,674022E-40 
					                                    void %4 = OpFunction None %3 
					                                         %5 = OpLabel 
					                    read_only Texture2D %12 = OpLoad %11 
					                                sampler %16 = OpLoad %15 
					             read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                                  f32_2 %22 = OpLoad vs_TEXCOORD1 
					                                  f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                    f32 %27 = OpCompositeExtract %24 0 
					                                                OpStore %8 %27 
					                           Uniform f32* %35 = OpAccessChain %30 %32 %33 
					                                    f32 %36 = OpLoad %35 
					                                    f32 %37 = OpLoad %8 
					                                    f32 %38 = OpFMul %36 %37 
					                           Uniform f32* %40 = OpAccessChain %30 %32 %39 
					                                    f32 %41 = OpLoad %40 
					                                    f32 %42 = OpFAdd %38 %41 
					                                                OpStore %8 %42 
					                                    f32 %44 = OpLoad %8 
					                                    f32 %45 = OpFDiv %43 %44 
					                                                OpStore %8 %45 
					                                    f32 %47 = OpLoad %8 
					                           Uniform f32* %49 = OpAccessChain %30 %48 
					                                    f32 %50 = OpLoad %49 
					                                    f32 %51 = OpFNegate %50 
					                                    f32 %52 = OpFAdd %47 %51 
					                                                OpStore %46 %52 
					                                    f32 %53 = OpLoad %8 
					                                    f32 %55 = OpExtInst %1 40 %53 %54 
					                                                OpStore %8 %55 
					                                    f32 %56 = OpLoad %46 
					                           Uniform f32* %58 = OpAccessChain %30 %57 
					                                    f32 %59 = OpLoad %58 
					                                    f32 %60 = OpFMul %56 %59 
					                                                OpStore %46 %60 
					                                    f32 %61 = OpLoad %46 
					                                    f32 %62 = OpLoad %8 
					                                    f32 %63 = OpFDiv %61 %62 
					                                                OpStore %8 %63 
					                                    f32 %64 = OpLoad %8 
					                                    f32 %66 = OpFMul %64 %65 
					                                                OpStore %8 %66 
					                                    f32 %67 = OpLoad %8 
					                           Uniform f32* %69 = OpAccessChain %30 %68 
					                                    f32 %70 = OpLoad %69 
					                                    f32 %71 = OpFMul %67 %70 
					                                    f32 %72 = OpFAdd %71 %65 
					                                                OpStore %8 %72 
					                                    f32 %75 = OpLoad %8 
					                                  f32_4 %76 = OpCompositeConstruct %75 %75 %75 %75 
					                                                OpStore %74 %76 
					                                  f32_4 %77 = OpLoad %74 
					                                  f32_4 %79 = OpCompositeConstruct %78 %78 %78 %78 
					                                  f32_4 %80 = OpCompositeConstruct %43 %43 %43 %43 
					                                  f32_4 %81 = OpExtInst %1 43 %77 %79 %80 
					                                                OpStore %74 %81 
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
						vec4 unused_0_0[21];
						vec4 _ZBufferParams;
						vec4 unused_0_2[8];
						float _Distance;
						float _LensCoeff;
						float _RcpMaxCoC;
						vec4 unused_0_6;
					};
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat1;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat1 = u_xlat0.x + (-_Distance);
					    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
					    u_xlat1 = u_xlat1 * _LensCoeff;
					    u_xlat0.x = u_xlat1 / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.x * _RcpMaxCoC + 0.5;
					    SV_Target0 = u_xlat0.xxxx;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
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
			Name "CoC Temporal Filter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 777246
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
						vec4 unused_0_2[5];
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
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	vec3 _TaaParams;
					UNITY_LOCATION(0) uniform  sampler2D _CoCTex;
					UNITY_LOCATION(1) uniform  sampler2D _CameraMotionVectorsTexture;
					UNITY_LOCATION(2) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat6;
					float u_xlat10;
					bool u_xlatb11;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
					    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_CoCTex, u_xlat1.xy);
					    u_xlat1 = texture(_CoCTex, u_xlat1.zw);
					    u_xlat6.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
					    u_xlat6.xy = clamp(u_xlat6.xy, 0.0, 1.0);
					    u_xlat6.xy = u_xlat6.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_CoCTex, u_xlat6.xy);
					    u_xlatb15 = u_xlat2.x<u_xlat3.x;
					    u_xlat4.z = (u_xlatb15) ? u_xlat2.x : u_xlat3.x;
					    u_xlat6.x = max(u_xlat2.x, u_xlat3.x);
					    u_xlat6.x = max(u_xlat1.x, u_xlat6.x);
					    u_xlatb11 = u_xlat1.x<u_xlat4.z;
					    u_xlat0.z = u_xlat1.x;
					    u_xlat1.xw = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
					    u_xlat2.xy = (-u_xlat1.xw);
					    u_xlat4.xy = bool(u_xlatb15) ? u_xlat2.xy : vec2(0.0, 0.0);
					    u_xlat0.xyz = (bool(u_xlatb11)) ? u_xlat0.xyz : u_xlat4.xyz;
					    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat4 = texture(_CoCTex, u_xlat2.xy).yzxw;
					    u_xlat2 = texture(_CoCTex, u_xlat2.zw);
					    u_xlatb15 = u_xlat4.z<u_xlat0.z;
					    u_xlat4.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
					    u_xlat6.x = max(u_xlat6.x, u_xlat4.z);
					    u_xlat6.x = max(u_xlat2.x, u_xlat6.x);
					    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat4.xyz : u_xlat0.xyz;
					    u_xlatb15 = u_xlat2.x<u_xlat0.z;
					    u_xlat10 = min(u_xlat2.x, u_xlat0.z);
					    u_xlat0.xy = (bool(u_xlatb15)) ? u_xlat1.xw : u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_CameraMotionVectorsTexture, u_xlat0.xy);
					    u_xlat0.xy = (-u_xlat2.xy) + vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.x = max(u_xlat10, u_xlat2.x);
					    u_xlat0.x = min(u_xlat6.x, u_xlat0.x);
					    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
					    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat3.xxxx;
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
					; Bound: 361
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %38 %344 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpMemberDecorate %11 0 Offset 11 
					                                              OpMemberDecorate %11 1 Offset 11 
					                                              OpMemberDecorate %11 2 Offset 11 
					                                              OpDecorate %11 Block 
					                                              OpDecorate %13 DescriptorSet 13 
					                                              OpDecorate %13 Binding 13 
					                                              OpDecorate vs_TEXCOORD0 Location 38 
					                                              OpDecorate %57 DescriptorSet 57 
					                                              OpDecorate %57 Binding 57 
					                                              OpDecorate %61 DescriptorSet 61 
					                                              OpDecorate %61 Binding 61 
					                                              OpDecorate %283 DescriptorSet 283 
					                                              OpDecorate %283 Binding 283 
					                                              OpDecorate %285 DescriptorSet 285 
					                                              OpDecorate %285 Binding 285 
					                                              OpDecorate %316 DescriptorSet 316 
					                                              OpDecorate %316 Binding 316 
					                                              OpDecorate %318 DescriptorSet 318 
					                                              OpDecorate %318 Binding 318 
					                                              OpDecorate %344 Location 344 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 3 
					                                       %8 = OpTypePointer Private %7 
					                        Private f32_3* %9 = OpVariable Private 
					                                      %10 = OpTypeVector %6 4 
					                                      %11 = OpTypeStruct %6 %10 %7 
					                                      %12 = OpTypePointer Uniform %11 
					 Uniform struct {f32; f32_4; f32_3;}* %13 = OpVariable Uniform 
					                                      %14 = OpTypeInt 32 1 
					                                  i32 %15 = OpConstant 1 
					                                      %16 = OpTypeVector %6 2 
					                                      %17 = OpTypePointer Uniform %10 
					                                  f32 %21 = OpConstant 3,674022E-40 
					                                  f32 %22 = OpConstant 3,674022E-40 
					                                f32_2 %23 = OpConstantComposite %21 %22 
					                                      %27 = OpTypePointer Private %10 
					                       Private f32_4* %28 = OpVariable Private 
					                                  f32 %33 = OpConstant 3,674022E-40 
					                                  f32 %34 = OpConstant 3,674022E-40 
					                                f32_4 %35 = OpConstantComposite %33 %34 %34 %33 
					                                      %37 = OpTypePointer Input %16 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                  i32 %47 = OpConstant 0 
					                                      %48 = OpTypePointer Uniform %6 
					                                      %53 = OpTypePointer Private %6 
					                         Private f32* %54 = OpVariable Private 
					                                      %55 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                      %56 = OpTypePointer UniformConstant %55 
					 UniformConstant read_only Texture2D* %57 = OpVariable UniformConstant 
					                                      %59 = OpTypeSampler 
					                                      %60 = OpTypePointer UniformConstant %59 
					             UniformConstant sampler* %61 = OpVariable UniformConstant 
					                                      %63 = OpTypeSampledImage %55 
					                                      %68 = OpTypeInt 32 0 
					                                  u32 %69 = OpConstant 0 
					                                  u32 %78 = OpConstant 2 
					                                  i32 %81 = OpConstant 2 
					                                      %82 = OpTypePointer Uniform %7 
					                                     %113 = OpTypeBool 
					                                     %114 = OpTypePointer Private %113 
					                       Private bool* %115 = OpVariable Private 
					                      Private f32_4* %120 = OpVariable Private 
					                                     %122 = OpTypePointer Function %6 
					                       Private bool* %140 = OpVariable Private 
					                                     %146 = OpTypePointer Private %16 
					                      Private f32_2* %147 = OpVariable Private 
					                               f32_2 %151 = OpConstantComposite %33 %34 
					                      Private f32_2* %153 = OpVariable Private 
					                                     %157 = OpTypePointer Function %16 
					                               f32_2 %163 = OpConstantComposite %34 %34 
					                                     %168 = OpTypePointer Function %7 
					                               f32_4 %180 = OpConstantComposite %34 %33 %33 %34 
					                      Private f32_3* %194 = OpVariable Private 
					                       Private bool* %211 = OpVariable Private 
					                               f32_2 %220 = OpConstantComposite %34 %33 
					                        Private f32* %245 = OpVariable Private 
					UniformConstant read_only Texture2D* %283 = OpVariable UniformConstant 
					            UniformConstant sampler* %285 = OpVariable UniformConstant 
					UniformConstant read_only Texture2D* %316 = OpVariable UniformConstant 
					            UniformConstant sampler* %318 = OpVariable UniformConstant 
					                                     %343 = OpTypePointer Output %10 
					                       Output f32_4* %344 = OpVariable Output 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                       Function f32* %123 = OpVariable Function 
					                     Function f32_2* %158 = OpVariable Function 
					                     Function f32_3* %169 = OpVariable Function 
					                     Function f32_3* %233 = OpVariable Function 
					                     Function f32_2* %252 = OpVariable Function 
					                       Uniform f32_4* %18 = OpAccessChain %13 %15 
					                                f32_4 %19 = OpLoad %18 
					                                f32_2 %20 = OpVectorShuffle %19 %19 1 1 
					                                f32_2 %24 = OpFMul %20 %23 
					                                f32_3 %25 = OpLoad %9 
					                                f32_3 %26 = OpVectorShuffle %25 %24 3 4 2 
					                                              OpStore %9 %26 
					                       Uniform f32_4* %29 = OpAccessChain %13 %15 
					                                f32_4 %30 = OpLoad %29 
					                                f32_4 %31 = OpVectorShuffle %30 %30 0 1 1 1 
					                                f32_4 %32 = OpFNegate %31 
					                                f32_4 %36 = OpFMul %32 %35 
					                                f32_2 %39 = OpLoad vs_TEXCOORD0 
					                                f32_4 %40 = OpVectorShuffle %39 %39 0 1 0 1 
					                                f32_4 %41 = OpFAdd %36 %40 
					                                              OpStore %28 %41 
					                                f32_4 %42 = OpLoad %28 
					                                f32_4 %43 = OpCompositeConstruct %34 %34 %34 %34 
					                                f32_4 %44 = OpCompositeConstruct %33 %33 %33 %33 
					                                f32_4 %45 = OpExtInst %1 43 %42 %43 %44 
					                                              OpStore %28 %45 
					                                f32_4 %46 = OpLoad %28 
					                         Uniform f32* %49 = OpAccessChain %13 %47 
					                                  f32 %50 = OpLoad %49 
					                                f32_4 %51 = OpCompositeConstruct %50 %50 %50 %50 
					                                f32_4 %52 = OpFMul %46 %51 
					                                              OpStore %28 %52 
					                  read_only Texture2D %58 = OpLoad %57 
					                              sampler %62 = OpLoad %61 
					           read_only Texture2DSampled %64 = OpSampledImage %58 %62 
					                                f32_4 %65 = OpLoad %28 
					                                f32_2 %66 = OpVectorShuffle %65 %65 0 1 
					                                f32_4 %67 = OpImageSampleImplicitLod %64 %66 
					                                  f32 %70 = OpCompositeExtract %67 0 
					                                              OpStore %54 %70 
					                  read_only Texture2D %71 = OpLoad %57 
					                              sampler %72 = OpLoad %61 
					           read_only Texture2DSampled %73 = OpSampledImage %71 %72 
					                                f32_4 %74 = OpLoad %28 
					                                f32_2 %75 = OpVectorShuffle %74 %74 2 3 
					                                f32_4 %76 = OpImageSampleImplicitLod %73 %75 
					                                  f32 %77 = OpCompositeExtract %76 0 
					                         Private f32* %79 = OpAccessChain %9 %78 
					                                              OpStore %79 %77 
					                                f32_2 %80 = OpLoad vs_TEXCOORD0 
					                       Uniform f32_3* %83 = OpAccessChain %13 %81 
					                                f32_3 %84 = OpLoad %83 
					                                f32_2 %85 = OpVectorShuffle %84 %84 0 1 
					                                f32_2 %86 = OpFNegate %85 
					                                f32_2 %87 = OpFAdd %80 %86 
					                                f32_4 %88 = OpLoad %28 
					                                f32_4 %89 = OpVectorShuffle %88 %87 4 5 2 3 
					                                              OpStore %28 %89 
					                                f32_4 %90 = OpLoad %28 
					                                f32_2 %91 = OpVectorShuffle %90 %90 0 1 
					                                f32_2 %92 = OpCompositeConstruct %34 %34 
					                                f32_2 %93 = OpCompositeConstruct %33 %33 
					                                f32_2 %94 = OpExtInst %1 43 %91 %92 %93 
					                                f32_4 %95 = OpLoad %28 
					                                f32_4 %96 = OpVectorShuffle %95 %94 4 5 2 3 
					                                              OpStore %28 %96 
					                                f32_4 %97 = OpLoad %28 
					                                f32_2 %98 = OpVectorShuffle %97 %97 0 1 
					                         Uniform f32* %99 = OpAccessChain %13 %47 
					                                 f32 %100 = OpLoad %99 
					                               f32_2 %101 = OpCompositeConstruct %100 %100 
					                               f32_2 %102 = OpFMul %98 %101 
					                               f32_4 %103 = OpLoad %28 
					                               f32_4 %104 = OpVectorShuffle %103 %102 4 5 2 3 
					                                              OpStore %28 %104 
					                 read_only Texture2D %105 = OpLoad %57 
					                             sampler %106 = OpLoad %61 
					          read_only Texture2DSampled %107 = OpSampledImage %105 %106 
					                               f32_4 %108 = OpLoad %28 
					                               f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                               f32_4 %110 = OpImageSampleImplicitLod %107 %109 
					                                 f32 %111 = OpCompositeExtract %110 0 
					                        Private f32* %112 = OpAccessChain %28 %69 
					                                              OpStore %112 %111 
					                                 f32 %116 = OpLoad %54 
					                        Private f32* %117 = OpAccessChain %28 %69 
					                                 f32 %118 = OpLoad %117 
					                                bool %119 = OpFOrdLessThan %116 %118 
					                                              OpStore %115 %119 
					                                bool %121 = OpLoad %115 
					                                              OpSelectionMerge %125 None 
					                                              OpBranchConditional %121 %124 %127 
					                                     %124 = OpLabel 
					                                 f32 %126 = OpLoad %54 
					                                              OpStore %123 %126 
					                                              OpBranch %125 
					                                     %127 = OpLabel 
					                        Private f32* %128 = OpAccessChain %28 %69 
					                                 f32 %129 = OpLoad %128 
					                                              OpStore %123 %129 
					                                              OpBranch %125 
					                                     %125 = OpLabel 
					                                 f32 %130 = OpLoad %123 
					                        Private f32* %131 = OpAccessChain %120 %78 
					                                              OpStore %131 %130 
					                                 f32 %132 = OpLoad %54 
					                        Private f32* %133 = OpAccessChain %28 %69 
					                                 f32 %134 = OpLoad %133 
					                                 f32 %135 = OpExtInst %1 40 %132 %134 
					                                              OpStore %54 %135 
					                        Private f32* %136 = OpAccessChain %9 %78 
					                                 f32 %137 = OpLoad %136 
					                                 f32 %138 = OpLoad %54 
					                                 f32 %139 = OpExtInst %1 40 %137 %138 
					                                              OpStore %54 %139 
					                        Private f32* %141 = OpAccessChain %9 %78 
					                                 f32 %142 = OpLoad %141 
					                        Private f32* %143 = OpAccessChain %120 %78 
					                                 f32 %144 = OpLoad %143 
					                                bool %145 = OpFOrdLessThan %142 %144 
					                                              OpStore %140 %145 
					                      Uniform f32_4* %148 = OpAccessChain %13 %15 
					                               f32_4 %149 = OpLoad %148 
					                               f32_2 %150 = OpVectorShuffle %149 %149 0 1 
					                               f32_2 %152 = OpFMul %150 %151 
					                                              OpStore %147 %152 
					                               f32_2 %154 = OpLoad %147 
					                               f32_2 %155 = OpFNegate %154 
					                                              OpStore %153 %155 
					                                bool %156 = OpLoad %115 
					                                              OpSelectionMerge %160 None 
					                                              OpBranchConditional %156 %159 %162 
					                                     %159 = OpLabel 
					                               f32_2 %161 = OpLoad %153 
					                                              OpStore %158 %161 
					                                              OpBranch %160 
					                                     %162 = OpLabel 
					                                              OpStore %158 %163 
					                                              OpBranch %160 
					                                     %160 = OpLabel 
					                               f32_2 %164 = OpLoad %158 
					                               f32_4 %165 = OpLoad %120 
					                               f32_4 %166 = OpVectorShuffle %165 %164 4 5 2 3 
					                                              OpStore %120 %166 
					                                bool %167 = OpLoad %140 
					                                              OpSelectionMerge %171 None 
					                                              OpBranchConditional %167 %170 %173 
					                                     %170 = OpLabel 
					                               f32_3 %172 = OpLoad %9 
					                                              OpStore %169 %172 
					                                              OpBranch %171 
					                                     %173 = OpLabel 
					                               f32_4 %174 = OpLoad %120 
					                               f32_3 %175 = OpVectorShuffle %174 %174 0 1 2 
					                                              OpStore %169 %175 
					                                              OpBranch %171 
					                                     %171 = OpLabel 
					                               f32_3 %176 = OpLoad %169 
					                                              OpStore %9 %176 
					                      Uniform f32_4* %177 = OpAccessChain %13 %15 
					                               f32_4 %178 = OpLoad %177 
					                               f32_4 %179 = OpVectorShuffle %178 %178 1 1 0 1 
					                               f32_4 %181 = OpFMul %179 %180 
					                               f32_2 %182 = OpLoad vs_TEXCOORD0 
					                               f32_4 %183 = OpVectorShuffle %182 %182 0 1 0 1 
					                               f32_4 %184 = OpFAdd %181 %183 
					                                              OpStore %120 %184 
					                               f32_4 %185 = OpLoad %120 
					                               f32_4 %186 = OpCompositeConstruct %34 %34 %34 %34 
					                               f32_4 %187 = OpCompositeConstruct %33 %33 %33 %33 
					                               f32_4 %188 = OpExtInst %1 43 %185 %186 %187 
					                                              OpStore %120 %188 
					                               f32_4 %189 = OpLoad %120 
					                        Uniform f32* %190 = OpAccessChain %13 %47 
					                                 f32 %191 = OpLoad %190 
					                               f32_4 %192 = OpCompositeConstruct %191 %191 %191 %191 
					                               f32_4 %193 = OpFMul %189 %192 
					                                              OpStore %120 %193 
					                 read_only Texture2D %195 = OpLoad %57 
					                             sampler %196 = OpLoad %61 
					          read_only Texture2DSampled %197 = OpSampledImage %195 %196 
					                               f32_4 %198 = OpLoad %120 
					                               f32_2 %199 = OpVectorShuffle %198 %198 0 1 
					                               f32_4 %200 = OpImageSampleImplicitLod %197 %199 
					                                 f32 %201 = OpCompositeExtract %200 0 
					                        Private f32* %202 = OpAccessChain %194 %78 
					                                              OpStore %202 %201 
					                 read_only Texture2D %203 = OpLoad %57 
					                             sampler %204 = OpLoad %61 
					          read_only Texture2DSampled %205 = OpSampledImage %203 %204 
					                               f32_4 %206 = OpLoad %120 
					                               f32_2 %207 = OpVectorShuffle %206 %206 2 3 
					                               f32_4 %208 = OpImageSampleImplicitLod %205 %207 
					                                 f32 %209 = OpCompositeExtract %208 0 
					                        Private f32* %210 = OpAccessChain %120 %69 
					                                              OpStore %210 %209 
					                        Private f32* %212 = OpAccessChain %194 %78 
					                                 f32 %213 = OpLoad %212 
					                        Private f32* %214 = OpAccessChain %9 %78 
					                                 f32 %215 = OpLoad %214 
					                                bool %216 = OpFOrdLessThan %213 %215 
					                                              OpStore %211 %216 
					                      Uniform f32_4* %217 = OpAccessChain %13 %15 
					                               f32_4 %218 = OpLoad %217 
					                               f32_2 %219 = OpVectorShuffle %218 %218 1 1 
					                               f32_2 %221 = OpFMul %219 %220 
					                               f32_3 %222 = OpLoad %194 
					                               f32_3 %223 = OpVectorShuffle %222 %221 3 4 2 
					                                              OpStore %194 %223 
					                                 f32 %224 = OpLoad %54 
					                        Private f32* %225 = OpAccessChain %194 %78 
					                                 f32 %226 = OpLoad %225 
					                                 f32 %227 = OpExtInst %1 40 %224 %226 
					                                              OpStore %54 %227 
					                        Private f32* %228 = OpAccessChain %120 %69 
					                                 f32 %229 = OpLoad %228 
					                                 f32 %230 = OpLoad %54 
					                                 f32 %231 = OpExtInst %1 40 %229 %230 
					                                              OpStore %54 %231 
					                                bool %232 = OpLoad %211 
					                                              OpSelectionMerge %235 None 
					                                              OpBranchConditional %232 %234 %237 
					                                     %234 = OpLabel 
					                               f32_3 %236 = OpLoad %194 
					                                              OpStore %233 %236 
					                                              OpBranch %235 
					                                     %237 = OpLabel 
					                               f32_3 %238 = OpLoad %9 
					                                              OpStore %233 %238 
					                                              OpBranch %235 
					                                     %235 = OpLabel 
					                               f32_3 %239 = OpLoad %233 
					                                              OpStore %9 %239 
					                        Private f32* %240 = OpAccessChain %120 %69 
					                                 f32 %241 = OpLoad %240 
					                        Private f32* %242 = OpAccessChain %9 %78 
					                                 f32 %243 = OpLoad %242 
					                                bool %244 = OpFOrdLessThan %241 %243 
					                                              OpStore %115 %244 
					                        Private f32* %246 = OpAccessChain %120 %69 
					                                 f32 %247 = OpLoad %246 
					                        Private f32* %248 = OpAccessChain %9 %78 
					                                 f32 %249 = OpLoad %248 
					                                 f32 %250 = OpExtInst %1 37 %247 %249 
					                                              OpStore %245 %250 
					                                bool %251 = OpLoad %115 
					                                              OpSelectionMerge %254 None 
					                                              OpBranchConditional %251 %253 %256 
					                                     %253 = OpLabel 
					                               f32_2 %255 = OpLoad %147 
					                                              OpStore %252 %255 
					                                              OpBranch %254 
					                                     %256 = OpLabel 
					                               f32_3 %257 = OpLoad %9 
					                               f32_2 %258 = OpVectorShuffle %257 %257 0 1 
					                                              OpStore %252 %258 
					                                              OpBranch %254 
					                                     %254 = OpLabel 
					                               f32_2 %259 = OpLoad %252 
					                               f32_3 %260 = OpLoad %9 
					                               f32_3 %261 = OpVectorShuffle %260 %259 3 4 2 
					                                              OpStore %9 %261 
					                               f32_3 %262 = OpLoad %9 
					                               f32_2 %263 = OpVectorShuffle %262 %262 0 1 
					                               f32_2 %264 = OpLoad vs_TEXCOORD0 
					                               f32_2 %265 = OpFAdd %263 %264 
					                               f32_3 %266 = OpLoad %9 
					                               f32_3 %267 = OpVectorShuffle %266 %265 3 4 2 
					                                              OpStore %9 %267 
					                               f32_3 %268 = OpLoad %9 
					                               f32_2 %269 = OpVectorShuffle %268 %268 0 1 
					                               f32_2 %270 = OpCompositeConstruct %34 %34 
					                               f32_2 %271 = OpCompositeConstruct %33 %33 
					                               f32_2 %272 = OpExtInst %1 43 %269 %270 %271 
					                               f32_3 %273 = OpLoad %9 
					                               f32_3 %274 = OpVectorShuffle %273 %272 3 4 2 
					                                              OpStore %9 %274 
					                               f32_3 %275 = OpLoad %9 
					                               f32_2 %276 = OpVectorShuffle %275 %275 0 1 
					                        Uniform f32* %277 = OpAccessChain %13 %47 
					                                 f32 %278 = OpLoad %277 
					                               f32_2 %279 = OpCompositeConstruct %278 %278 
					                               f32_2 %280 = OpFMul %276 %279 
					                               f32_3 %281 = OpLoad %9 
					                               f32_3 %282 = OpVectorShuffle %281 %280 3 4 2 
					                                              OpStore %9 %282 
					                 read_only Texture2D %284 = OpLoad %283 
					                             sampler %286 = OpLoad %285 
					          read_only Texture2DSampled %287 = OpSampledImage %284 %286 
					                               f32_3 %288 = OpLoad %9 
					                               f32_2 %289 = OpVectorShuffle %288 %288 0 1 
					                               f32_4 %290 = OpImageSampleImplicitLod %287 %289 
					                               f32_2 %291 = OpVectorShuffle %290 %290 0 1 
					                               f32_3 %292 = OpLoad %9 
					                               f32_3 %293 = OpVectorShuffle %292 %291 3 4 2 
					                                              OpStore %9 %293 
					                               f32_3 %294 = OpLoad %9 
					                               f32_2 %295 = OpVectorShuffle %294 %294 0 1 
					                               f32_2 %296 = OpFNegate %295 
					                               f32_2 %297 = OpLoad vs_TEXCOORD0 
					                               f32_2 %298 = OpFAdd %296 %297 
					                               f32_3 %299 = OpLoad %9 
					                               f32_3 %300 = OpVectorShuffle %299 %298 3 4 2 
					                                              OpStore %9 %300 
					                               f32_3 %301 = OpLoad %9 
					                               f32_2 %302 = OpVectorShuffle %301 %301 0 1 
					                               f32_2 %303 = OpCompositeConstruct %34 %34 
					                               f32_2 %304 = OpCompositeConstruct %33 %33 
					                               f32_2 %305 = OpExtInst %1 43 %302 %303 %304 
					                               f32_3 %306 = OpLoad %9 
					                               f32_3 %307 = OpVectorShuffle %306 %305 3 4 2 
					                                              OpStore %9 %307 
					                               f32_3 %308 = OpLoad %9 
					                               f32_2 %309 = OpVectorShuffle %308 %308 0 1 
					                        Uniform f32* %310 = OpAccessChain %13 %47 
					                                 f32 %311 = OpLoad %310 
					                               f32_2 %312 = OpCompositeConstruct %311 %311 
					                               f32_2 %313 = OpFMul %309 %312 
					                               f32_3 %314 = OpLoad %9 
					                               f32_3 %315 = OpVectorShuffle %314 %313 3 4 2 
					                                              OpStore %9 %315 
					                 read_only Texture2D %317 = OpLoad %316 
					                             sampler %319 = OpLoad %318 
					          read_only Texture2DSampled %320 = OpSampledImage %317 %319 
					                               f32_3 %321 = OpLoad %9 
					                               f32_2 %322 = OpVectorShuffle %321 %321 0 1 
					                               f32_4 %323 = OpImageSampleImplicitLod %320 %322 
					                                 f32 %324 = OpCompositeExtract %323 0 
					                        Private f32* %325 = OpAccessChain %9 %69 
					                                              OpStore %325 %324 
					                                 f32 %326 = OpLoad %245 
					                        Private f32* %327 = OpAccessChain %9 %69 
					                                 f32 %328 = OpLoad %327 
					                                 f32 %329 = OpExtInst %1 40 %326 %328 
					                        Private f32* %330 = OpAccessChain %9 %69 
					                                              OpStore %330 %329 
					                                 f32 %331 = OpLoad %54 
					                        Private f32* %332 = OpAccessChain %9 %69 
					                                 f32 %333 = OpLoad %332 
					                                 f32 %334 = OpExtInst %1 37 %331 %333 
					                        Private f32* %335 = OpAccessChain %9 %69 
					                                              OpStore %335 %334 
					                        Private f32* %336 = OpAccessChain %28 %69 
					                                 f32 %337 = OpLoad %336 
					                                 f32 %338 = OpFNegate %337 
					                        Private f32* %339 = OpAccessChain %9 %69 
					                                 f32 %340 = OpLoad %339 
					                                 f32 %341 = OpFAdd %338 %340 
					                        Private f32* %342 = OpAccessChain %9 %69 
					                                              OpStore %342 %341 
					                        Uniform f32* %345 = OpAccessChain %13 %81 %78 
					                                 f32 %346 = OpLoad %345 
					                        Uniform f32* %347 = OpAccessChain %13 %81 %78 
					                                 f32 %348 = OpLoad %347 
					                        Uniform f32* %349 = OpAccessChain %13 %81 %78 
					                                 f32 %350 = OpLoad %349 
					                        Uniform f32* %351 = OpAccessChain %13 %81 %78 
					                                 f32 %352 = OpLoad %351 
					                               f32_4 %353 = OpCompositeConstruct %346 %348 %350 %352 
					                               f32_3 %354 = OpLoad %9 
					                               f32_4 %355 = OpVectorShuffle %354 %354 0 0 0 0 
					                               f32_4 %356 = OpFMul %353 %355 
					                               f32_4 %357 = OpLoad %28 
					                               f32_4 %358 = OpVectorShuffle %357 %357 0 0 0 0 
					                               f32_4 %359 = OpFAdd %356 %358 
					                                              OpStore %344 %359 
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4[2];
						vec3 _TaaParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraMotionVectorsTexture;
					uniform  sampler2D _CoCTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat6;
					float u_xlat10;
					bool u_xlatb11;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
					    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_CoCTex, u_xlat1.xy);
					    u_xlat1 = texture(_CoCTex, u_xlat1.zw);
					    u_xlat6.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
					    u_xlat6.xy = clamp(u_xlat6.xy, 0.0, 1.0);
					    u_xlat6.xy = u_xlat6.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_CoCTex, u_xlat6.xy);
					    u_xlatb15 = u_xlat2.x<u_xlat3.x;
					    u_xlat4.z = (u_xlatb15) ? u_xlat2.x : u_xlat3.x;
					    u_xlat6.x = max(u_xlat2.x, u_xlat3.x);
					    u_xlat6.x = max(u_xlat1.x, u_xlat6.x);
					    u_xlatb11 = u_xlat1.x<u_xlat4.z;
					    u_xlat0.z = u_xlat1.x;
					    u_xlat1.xw = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
					    u_xlat2.xy = (-u_xlat1.xw);
					    u_xlat4.xy = bool(u_xlatb15) ? u_xlat2.xy : vec2(0.0, 0.0);
					    u_xlat0.xyz = (bool(u_xlatb11)) ? u_xlat0.xyz : u_xlat4.xyz;
					    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat4 = texture(_CoCTex, u_xlat2.xy).yzxw;
					    u_xlat2 = texture(_CoCTex, u_xlat2.zw);
					    u_xlatb15 = u_xlat4.z<u_xlat0.z;
					    u_xlat4.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
					    u_xlat6.x = max(u_xlat6.x, u_xlat4.z);
					    u_xlat6.x = max(u_xlat2.x, u_xlat6.x);
					    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat4.xyz : u_xlat0.xyz;
					    u_xlatb15 = u_xlat2.x<u_xlat0.z;
					    u_xlat10 = min(u_xlat2.x, u_xlat0.z);
					    u_xlat0.xy = (bool(u_xlatb15)) ? u_xlat1.xw : u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_CameraMotionVectorsTexture, u_xlat0.xy);
					    u_xlat0.xy = (-u_xlat2.xy) + vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.x = max(u_xlat10, u_xlat2.x);
					    u_xlat0.x = min(u_xlat6.x, u_xlat0.x);
					    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
					    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat3.xxxx;
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
			Name "Downsample and Prefilter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 804587
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
						vec4 unused_0_2[5];
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
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _MaxCoC;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CoCTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat10;
					bool u_xlatb10;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat0.zw);
					    u_xlat16 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat16 = max(u_xlat1.z, u_xlat16);
					    u_xlat16 = u_xlat16 + 1.0;
					    u_xlat2 = texture(_CoCTex, u_xlat0.zw);
					    u_xlat10 = u_xlat2.x * 2.0 + -1.0;
					    u_xlat15 = abs(u_xlat10) / u_xlat16;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat2 = texture(_MainTex, u_xlat0.xy);
					    u_xlat3 = texture(_CoCTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat3.x * 2.0 + -1.0;
					    u_xlat5 = max(u_xlat2.y, u_xlat2.x);
					    u_xlat5 = max(u_xlat2.z, u_xlat5);
					    u_xlat5 = u_xlat5 + 1.0;
					    u_xlat5 = abs(u_xlat0.x) / u_xlat5;
					    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat5) + u_xlat1.xyz;
					    u_xlat5 = u_xlat15 + u_xlat5;
					    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat15 = max(u_xlat3.y, u_xlat3.x);
					    u_xlat15 = max(u_xlat3.z, u_xlat15);
					    u_xlat15 = u_xlat15 + 1.0;
					    u_xlat4 = texture(_CoCTex, u_xlat2.xy);
					    u_xlat16 = u_xlat4.x * 2.0 + -1.0;
					    u_xlat15 = abs(u_xlat16) / u_xlat15;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat15) + u_xlat1.xyz;
					    u_xlat5 = u_xlat15 + u_xlat5;
					    u_xlat3 = texture(_MainTex, u_xlat2.zw);
					    u_xlat2 = texture(_CoCTex, u_xlat2.zw);
					    u_xlat15 = u_xlat2.x * 2.0 + -1.0;
					    u_xlat2.x = max(u_xlat3.y, u_xlat3.x);
					    u_xlat2.x = max(u_xlat3.z, u_xlat2.x);
					    u_xlat2.x = u_xlat2.x + 1.0;
					    u_xlat2.x = abs(u_xlat15) / u_xlat2.x;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat5 = u_xlat5 + u_xlat2.x;
					    u_xlat5 = max(u_xlat5, 9.99999975e-05);
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat5);
					    u_xlat5 = min(u_xlat10, u_xlat16);
					    u_xlat10 = max(u_xlat10, u_xlat16);
					    u_xlat10 = max(u_xlat15, u_xlat10);
					    u_xlat5 = min(u_xlat15, u_xlat5);
					    u_xlat5 = min(u_xlat5, u_xlat0.x);
					    u_xlat0.x = max(u_xlat10, u_xlat0.x);
					    u_xlatb10 = u_xlat0.x<(-u_xlat5);
					    u_xlat0.x = (u_xlatb10) ? u_xlat5 : u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MaxCoC;
					    u_xlat5 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat5 = float(1.0) / u_xlat5;
					    u_xlat5 = u_xlat5 * abs(u_xlat0.x);
					    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.x;
					    u_xlat0.x = u_xlat5 * -2.0 + 3.0;
					    u_xlat5 = u_xlat5 * u_xlat5;
					    u_xlat0.x = u_xlat5 * u_xlat0.x;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
					; Bound: 355
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %26 %328 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %10 0 Offset 10 
					                                             OpMemberDecorate %10 1 Offset 10 
					                                             OpMemberDecorate %10 2 Offset 10 
					                                             OpDecorate %10 Block 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate vs_TEXCOORD0 Location 26 
					                                             OpDecorate %48 DescriptorSet 48 
					                                             OpDecorate %48 Binding 48 
					                                             OpDecorate %52 DescriptorSet 52 
					                                             OpDecorate %52 Binding 52 
					                                             OpDecorate %78 DescriptorSet 78 
					                                             OpDecorate %78 Binding 78 
					                                             OpDecorate %80 DescriptorSet 80 
					                                             OpDecorate %80 Binding 80 
					                                             OpDecorate %328 Location 328 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeStruct %6 %7 %6 
					                                     %11 = OpTypePointer Uniform %10 
					  Uniform struct {f32; f32_4; f32;}* %12 = OpVariable Uniform 
					                                     %13 = OpTypeInt 32 1 
					                                 i32 %14 = OpConstant 1 
					                                     %15 = OpTypePointer Uniform %7 
					                                 f32 %20 = OpConstant 3,674022E-40 
					                                 f32 %21 = OpConstant 3,674022E-40 
					                               f32_4 %22 = OpConstantComposite %20 %20 %21 %20 
					                                     %24 = OpTypeVector %6 2 
					                                     %25 = OpTypePointer Input %24 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 f32 %31 = OpConstant 3,674022E-40 
					                                 f32 %32 = OpConstant 3,674022E-40 
					                                 i32 %37 = OpConstant 0 
					                                     %38 = OpTypePointer Uniform %6 
					                                     %43 = OpTypeVector %6 3 
					                                     %44 = OpTypePointer Private %43 
					                      Private f32_3* %45 = OpVariable Private 
					                                     %46 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %47 = OpTypePointer UniformConstant %46 
					UniformConstant read_only Texture2D* %48 = OpVariable UniformConstant 
					                                     %50 = OpTypeSampler 
					                                     %51 = OpTypePointer UniformConstant %50 
					            UniformConstant sampler* %52 = OpVariable UniformConstant 
					                                     %54 = OpTypeSampledImage %46 
					                                     %60 = OpTypePointer Private %6 
					                        Private f32* %61 = OpVariable Private 
					                                     %62 = OpTypeInt 32 0 
					                                 u32 %63 = OpConstant 1 
					                                 u32 %66 = OpConstant 0 
					                                 u32 %70 = OpConstant 2 
					                        Private f32* %77 = OpVariable Private 
					UniformConstant read_only Texture2D* %78 = OpVariable UniformConstant 
					            UniformConstant sampler* %80 = OpVariable UniformConstant 
					                                 f32 %88 = OpConstant 3,674022E-40 
					                                 f32 %90 = OpConstant 3,674022E-40 
					                        Private f32* %92 = OpVariable Private 
					                     Private f32_4* %101 = OpVariable Private 
					                       Private f32* %124 = OpVariable Private 
					                              f32_4 %154 = OpConstantComposite %21 %20 %20 %20 
					                     Private f32_3* %168 = OpVariable Private 
					                                f32 %260 = OpConstant 3,674022E-40 
					                                    %287 = OpTypeBool 
					                                    %288 = OpTypePointer Private %287 
					                      Private bool* %289 = OpVariable Private 
					                                    %296 = OpTypePointer Function %6 
					                                i32 %308 = OpConstant 2 
					                                    %327 = OpTypePointer Output %7 
					                      Output f32_4* %328 = OpVariable Output 
					                                u32 %331 = OpConstant 3 
					                                    %332 = OpTypePointer Output %6 
					                                f32 %335 = OpConstant 3,674022E-40 
					                                f32 %337 = OpConstant 3,674022E-40 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                      Function f32* %297 = OpVariable Function 
					                      Uniform f32_4* %16 = OpAccessChain %12 %14 
					                               f32_4 %17 = OpLoad %16 
					                               f32_4 %18 = OpVectorShuffle %17 %17 0 1 0 1 
					                               f32_4 %19 = OpFNegate %18 
					                               f32_4 %23 = OpFMul %19 %22 
					                               f32_2 %27 = OpLoad vs_TEXCOORD0 
					                               f32_4 %28 = OpVectorShuffle %27 %27 0 1 0 1 
					                               f32_4 %29 = OpFAdd %23 %28 
					                                             OpStore %9 %29 
					                               f32_4 %30 = OpLoad %9 
					                               f32_4 %33 = OpCompositeConstruct %31 %31 %31 %31 
					                               f32_4 %34 = OpCompositeConstruct %32 %32 %32 %32 
					                               f32_4 %35 = OpExtInst %1 43 %30 %33 %34 
					                                             OpStore %9 %35 
					                               f32_4 %36 = OpLoad %9 
					                        Uniform f32* %39 = OpAccessChain %12 %37 
					                                 f32 %40 = OpLoad %39 
					                               f32_4 %41 = OpCompositeConstruct %40 %40 %40 %40 
					                               f32_4 %42 = OpFMul %36 %41 
					                                             OpStore %9 %42 
					                 read_only Texture2D %49 = OpLoad %48 
					                             sampler %53 = OpLoad %52 
					          read_only Texture2DSampled %55 = OpSampledImage %49 %53 
					                               f32_4 %56 = OpLoad %9 
					                               f32_2 %57 = OpVectorShuffle %56 %56 2 3 
					                               f32_4 %58 = OpImageSampleImplicitLod %55 %57 
					                               f32_3 %59 = OpVectorShuffle %58 %58 0 1 2 
					                                             OpStore %45 %59 
					                        Private f32* %64 = OpAccessChain %45 %63 
					                                 f32 %65 = OpLoad %64 
					                        Private f32* %67 = OpAccessChain %45 %66 
					                                 f32 %68 = OpLoad %67 
					                                 f32 %69 = OpExtInst %1 40 %65 %68 
					                                             OpStore %61 %69 
					                        Private f32* %71 = OpAccessChain %45 %70 
					                                 f32 %72 = OpLoad %71 
					                                 f32 %73 = OpLoad %61 
					                                 f32 %74 = OpExtInst %1 40 %72 %73 
					                                             OpStore %61 %74 
					                                 f32 %75 = OpLoad %61 
					                                 f32 %76 = OpFAdd %75 %32 
					                                             OpStore %61 %76 
					                 read_only Texture2D %79 = OpLoad %78 
					                             sampler %81 = OpLoad %80 
					          read_only Texture2DSampled %82 = OpSampledImage %79 %81 
					                               f32_4 %83 = OpLoad %9 
					                               f32_2 %84 = OpVectorShuffle %83 %83 2 3 
					                               f32_4 %85 = OpImageSampleImplicitLod %82 %84 
					                                 f32 %86 = OpCompositeExtract %85 0 
					                                             OpStore %77 %86 
					                                 f32 %87 = OpLoad %77 
					                                 f32 %89 = OpFMul %87 %88 
					                                 f32 %91 = OpFAdd %89 %90 
					                                             OpStore %77 %91 
					                                 f32 %93 = OpLoad %77 
					                                 f32 %94 = OpExtInst %1 4 %93 
					                                 f32 %95 = OpLoad %61 
					                                 f32 %96 = OpFDiv %94 %95 
					                                             OpStore %92 %96 
					                                 f32 %97 = OpLoad %92 
					                               f32_3 %98 = OpCompositeConstruct %97 %97 %97 
					                               f32_3 %99 = OpLoad %45 
					                              f32_3 %100 = OpFMul %98 %99 
					                                             OpStore %45 %100 
					                read_only Texture2D %102 = OpLoad %48 
					                            sampler %103 = OpLoad %52 
					         read_only Texture2DSampled %104 = OpSampledImage %102 %103 
					                              f32_4 %105 = OpLoad %9 
					                              f32_2 %106 = OpVectorShuffle %105 %105 0 1 
					                              f32_4 %107 = OpImageSampleImplicitLod %104 %106 
					                              f32_3 %108 = OpVectorShuffle %107 %107 0 1 2 
					                              f32_4 %109 = OpLoad %101 
					                              f32_4 %110 = OpVectorShuffle %109 %108 4 5 6 3 
					                                             OpStore %101 %110 
					                read_only Texture2D %111 = OpLoad %78 
					                            sampler %112 = OpLoad %80 
					         read_only Texture2DSampled %113 = OpSampledImage %111 %112 
					                              f32_4 %114 = OpLoad %9 
					                              f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                              f32_4 %116 = OpImageSampleImplicitLod %113 %115 
					                                f32 %117 = OpCompositeExtract %116 0 
					                       Private f32* %118 = OpAccessChain %9 %66 
					                                             OpStore %118 %117 
					                       Private f32* %119 = OpAccessChain %9 %66 
					                                f32 %120 = OpLoad %119 
					                                f32 %121 = OpFMul %120 %88 
					                                f32 %122 = OpFAdd %121 %90 
					                       Private f32* %123 = OpAccessChain %9 %66 
					                                             OpStore %123 %122 
					                       Private f32* %125 = OpAccessChain %101 %63 
					                                f32 %126 = OpLoad %125 
					                       Private f32* %127 = OpAccessChain %101 %66 
					                                f32 %128 = OpLoad %127 
					                                f32 %129 = OpExtInst %1 40 %126 %128 
					                                             OpStore %124 %129 
					                       Private f32* %130 = OpAccessChain %101 %70 
					                                f32 %131 = OpLoad %130 
					                                f32 %132 = OpLoad %124 
					                                f32 %133 = OpExtInst %1 40 %131 %132 
					                                             OpStore %124 %133 
					                                f32 %134 = OpLoad %124 
					                                f32 %135 = OpFAdd %134 %32 
					                                             OpStore %124 %135 
					                       Private f32* %136 = OpAccessChain %9 %66 
					                                f32 %137 = OpLoad %136 
					                                f32 %138 = OpExtInst %1 4 %137 
					                                f32 %139 = OpLoad %124 
					                                f32 %140 = OpFDiv %138 %139 
					                                             OpStore %124 %140 
					                              f32_4 %141 = OpLoad %101 
					                              f32_3 %142 = OpVectorShuffle %141 %141 0 1 2 
					                                f32 %143 = OpLoad %124 
					                              f32_3 %144 = OpCompositeConstruct %143 %143 %143 
					                              f32_3 %145 = OpFMul %142 %144 
					                              f32_3 %146 = OpLoad %45 
					                              f32_3 %147 = OpFAdd %145 %146 
					                                             OpStore %45 %147 
					                                f32 %148 = OpLoad %92 
					                                f32 %149 = OpLoad %124 
					                                f32 %150 = OpFAdd %148 %149 
					                                             OpStore %124 %150 
					                     Uniform f32_4* %151 = OpAccessChain %12 %14 
					                              f32_4 %152 = OpLoad %151 
					                              f32_4 %153 = OpVectorShuffle %152 %152 0 1 0 1 
					                              f32_4 %155 = OpFMul %153 %154 
					                              f32_2 %156 = OpLoad vs_TEXCOORD0 
					                              f32_4 %157 = OpVectorShuffle %156 %156 0 1 0 1 
					                              f32_4 %158 = OpFAdd %155 %157 
					                                             OpStore %101 %158 
					                              f32_4 %159 = OpLoad %101 
					                              f32_4 %160 = OpCompositeConstruct %31 %31 %31 %31 
					                              f32_4 %161 = OpCompositeConstruct %32 %32 %32 %32 
					                              f32_4 %162 = OpExtInst %1 43 %159 %160 %161 
					                                             OpStore %101 %162 
					                              f32_4 %163 = OpLoad %101 
					                       Uniform f32* %164 = OpAccessChain %12 %37 
					                                f32 %165 = OpLoad %164 
					                              f32_4 %166 = OpCompositeConstruct %165 %165 %165 %165 
					                              f32_4 %167 = OpFMul %163 %166 
					                                             OpStore %101 %167 
					                read_only Texture2D %169 = OpLoad %48 
					                            sampler %170 = OpLoad %52 
					         read_only Texture2DSampled %171 = OpSampledImage %169 %170 
					                              f32_4 %172 = OpLoad %101 
					                              f32_2 %173 = OpVectorShuffle %172 %172 0 1 
					                              f32_4 %174 = OpImageSampleImplicitLod %171 %173 
					                              f32_3 %175 = OpVectorShuffle %174 %174 0 1 2 
					                                             OpStore %168 %175 
					                       Private f32* %176 = OpAccessChain %168 %63 
					                                f32 %177 = OpLoad %176 
					                       Private f32* %178 = OpAccessChain %168 %66 
					                                f32 %179 = OpLoad %178 
					                                f32 %180 = OpExtInst %1 40 %177 %179 
					                                             OpStore %92 %180 
					                       Private f32* %181 = OpAccessChain %168 %70 
					                                f32 %182 = OpLoad %181 
					                                f32 %183 = OpLoad %92 
					                                f32 %184 = OpExtInst %1 40 %182 %183 
					                                             OpStore %92 %184 
					                                f32 %185 = OpLoad %92 
					                                f32 %186 = OpFAdd %185 %32 
					                                             OpStore %92 %186 
					                read_only Texture2D %187 = OpLoad %78 
					                            sampler %188 = OpLoad %80 
					         read_only Texture2DSampled %189 = OpSampledImage %187 %188 
					                              f32_4 %190 = OpLoad %101 
					                              f32_2 %191 = OpVectorShuffle %190 %190 0 1 
					                              f32_4 %192 = OpImageSampleImplicitLod %189 %191 
					                                f32 %193 = OpCompositeExtract %192 0 
					                                             OpStore %61 %193 
					                                f32 %194 = OpLoad %61 
					                                f32 %195 = OpFMul %194 %88 
					                                f32 %196 = OpFAdd %195 %90 
					                                             OpStore %61 %196 
					                                f32 %197 = OpLoad %61 
					                                f32 %198 = OpExtInst %1 4 %197 
					                                f32 %199 = OpLoad %92 
					                                f32 %200 = OpFDiv %198 %199 
					                                             OpStore %92 %200 
					                              f32_3 %201 = OpLoad %168 
					                                f32 %202 = OpLoad %92 
					                              f32_3 %203 = OpCompositeConstruct %202 %202 %202 
					                              f32_3 %204 = OpFMul %201 %203 
					                              f32_3 %205 = OpLoad %45 
					                              f32_3 %206 = OpFAdd %204 %205 
					                                             OpStore %45 %206 
					                                f32 %207 = OpLoad %92 
					                                f32 %208 = OpLoad %124 
					                                f32 %209 = OpFAdd %207 %208 
					                                             OpStore %124 %209 
					                read_only Texture2D %210 = OpLoad %48 
					                            sampler %211 = OpLoad %52 
					         read_only Texture2DSampled %212 = OpSampledImage %210 %211 
					                              f32_4 %213 = OpLoad %101 
					                              f32_2 %214 = OpVectorShuffle %213 %213 2 3 
					                              f32_4 %215 = OpImageSampleImplicitLod %212 %214 
					                              f32_3 %216 = OpVectorShuffle %215 %215 0 1 2 
					                                             OpStore %168 %216 
					                read_only Texture2D %217 = OpLoad %78 
					                            sampler %218 = OpLoad %80 
					         read_only Texture2DSampled %219 = OpSampledImage %217 %218 
					                              f32_4 %220 = OpLoad %101 
					                              f32_2 %221 = OpVectorShuffle %220 %220 2 3 
					                              f32_4 %222 = OpImageSampleImplicitLod %219 %221 
					                                f32 %223 = OpCompositeExtract %222 0 
					                                             OpStore %92 %223 
					                                f32 %224 = OpLoad %92 
					                                f32 %225 = OpFMul %224 %88 
					                                f32 %226 = OpFAdd %225 %90 
					                                             OpStore %92 %226 
					                       Private f32* %227 = OpAccessChain %168 %63 
					                                f32 %228 = OpLoad %227 
					                       Private f32* %229 = OpAccessChain %168 %66 
					                                f32 %230 = OpLoad %229 
					                                f32 %231 = OpExtInst %1 40 %228 %230 
					                       Private f32* %232 = OpAccessChain %101 %66 
					                                             OpStore %232 %231 
					                       Private f32* %233 = OpAccessChain %168 %70 
					                                f32 %234 = OpLoad %233 
					                       Private f32* %235 = OpAccessChain %101 %66 
					                                f32 %236 = OpLoad %235 
					                                f32 %237 = OpExtInst %1 40 %234 %236 
					                       Private f32* %238 = OpAccessChain %101 %66 
					                                             OpStore %238 %237 
					                       Private f32* %239 = OpAccessChain %101 %66 
					                                f32 %240 = OpLoad %239 
					                                f32 %241 = OpFAdd %240 %32 
					                       Private f32* %242 = OpAccessChain %101 %66 
					                                             OpStore %242 %241 
					                                f32 %243 = OpLoad %92 
					                                f32 %244 = OpExtInst %1 4 %243 
					                       Private f32* %245 = OpAccessChain %101 %66 
					                                f32 %246 = OpLoad %245 
					                                f32 %247 = OpFDiv %244 %246 
					                       Private f32* %248 = OpAccessChain %101 %66 
					                                             OpStore %248 %247 
					                              f32_3 %249 = OpLoad %168 
					                              f32_4 %250 = OpLoad %101 
					                              f32_3 %251 = OpVectorShuffle %250 %250 0 0 0 
					                              f32_3 %252 = OpFMul %249 %251 
					                              f32_3 %253 = OpLoad %45 
					                              f32_3 %254 = OpFAdd %252 %253 
					                                             OpStore %45 %254 
					                                f32 %255 = OpLoad %124 
					                       Private f32* %256 = OpAccessChain %101 %66 
					                                f32 %257 = OpLoad %256 
					                                f32 %258 = OpFAdd %255 %257 
					                                             OpStore %124 %258 
					                                f32 %259 = OpLoad %124 
					                                f32 %261 = OpExtInst %1 40 %259 %260 
					                                             OpStore %124 %261 
					                              f32_3 %262 = OpLoad %45 
					                                f32 %263 = OpLoad %124 
					                              f32_3 %264 = OpCompositeConstruct %263 %263 %263 
					                              f32_3 %265 = OpFDiv %262 %264 
					                                             OpStore %45 %265 
					                                f32 %266 = OpLoad %77 
					                                f32 %267 = OpLoad %61 
					                                f32 %268 = OpExtInst %1 37 %266 %267 
					                                             OpStore %124 %268 
					                                f32 %269 = OpLoad %77 
					                                f32 %270 = OpLoad %61 
					                                f32 %271 = OpExtInst %1 40 %269 %270 
					                                             OpStore %77 %271 
					                                f32 %272 = OpLoad %92 
					                                f32 %273 = OpLoad %77 
					                                f32 %274 = OpExtInst %1 40 %272 %273 
					                                             OpStore %77 %274 
					                                f32 %275 = OpLoad %92 
					                                f32 %276 = OpLoad %124 
					                                f32 %277 = OpExtInst %1 37 %275 %276 
					                                             OpStore %124 %277 
					                                f32 %278 = OpLoad %124 
					                       Private f32* %279 = OpAccessChain %9 %66 
					                                f32 %280 = OpLoad %279 
					                                f32 %281 = OpExtInst %1 37 %278 %280 
					                                             OpStore %124 %281 
					                                f32 %282 = OpLoad %77 
					                       Private f32* %283 = OpAccessChain %9 %66 
					                                f32 %284 = OpLoad %283 
					                                f32 %285 = OpExtInst %1 40 %282 %284 
					                       Private f32* %286 = OpAccessChain %9 %66 
					                                             OpStore %286 %285 
					                       Private f32* %290 = OpAccessChain %9 %66 
					                                f32 %291 = OpLoad %290 
					                                f32 %292 = OpLoad %124 
					                                f32 %293 = OpFNegate %292 
					                               bool %294 = OpFOrdLessThan %291 %293 
					                                             OpStore %289 %294 
					                               bool %295 = OpLoad %289 
					                                             OpSelectionMerge %299 None 
					                                             OpBranchConditional %295 %298 %301 
					                                    %298 = OpLabel 
					                                f32 %300 = OpLoad %124 
					                                             OpStore %297 %300 
					                                             OpBranch %299 
					                                    %301 = OpLabel 
					                       Private f32* %302 = OpAccessChain %9 %66 
					                                f32 %303 = OpLoad %302 
					                                             OpStore %297 %303 
					                                             OpBranch %299 
					                                    %299 = OpLabel 
					                                f32 %304 = OpLoad %297 
					                       Private f32* %305 = OpAccessChain %9 %66 
					                                             OpStore %305 %304 
					                       Private f32* %306 = OpAccessChain %9 %66 
					                                f32 %307 = OpLoad %306 
					                       Uniform f32* %309 = OpAccessChain %12 %308 
					                                f32 %310 = OpLoad %309 
					                                f32 %311 = OpFMul %307 %310 
					                       Private f32* %312 = OpAccessChain %9 %66 
					                                             OpStore %312 %311 
					                       Uniform f32* %313 = OpAccessChain %12 %14 %63 
					                                f32 %314 = OpLoad %313 
					                       Uniform f32* %315 = OpAccessChain %12 %14 %63 
					                                f32 %316 = OpLoad %315 
					                                f32 %317 = OpFAdd %314 %316 
					                                             OpStore %124 %317 
					                                f32 %318 = OpLoad %124 
					                                f32 %319 = OpFDiv %32 %318 
					                                             OpStore %124 %319 
					                                f32 %320 = OpLoad %124 
					                       Private f32* %321 = OpAccessChain %9 %66 
					                                f32 %322 = OpLoad %321 
					                                f32 %323 = OpExtInst %1 4 %322 
					                                f32 %324 = OpFMul %320 %323 
					                                             OpStore %124 %324 
					                                f32 %325 = OpLoad %124 
					                                f32 %326 = OpExtInst %1 43 %325 %31 %32 
					                                             OpStore %124 %326 
					                       Private f32* %329 = OpAccessChain %9 %66 
					                                f32 %330 = OpLoad %329 
					                        Output f32* %333 = OpAccessChain %328 %331 
					                                             OpStore %333 %330 
					                                f32 %334 = OpLoad %124 
					                                f32 %336 = OpFMul %334 %335 
					                                f32 %338 = OpFAdd %336 %337 
					                       Private f32* %339 = OpAccessChain %9 %66 
					                                             OpStore %339 %338 
					                                f32 %340 = OpLoad %124 
					                                f32 %341 = OpLoad %124 
					                                f32 %342 = OpFMul %340 %341 
					                                             OpStore %124 %342 
					                                f32 %343 = OpLoad %124 
					                       Private f32* %344 = OpAccessChain %9 %66 
					                                f32 %345 = OpLoad %344 
					                                f32 %346 = OpFMul %343 %345 
					                       Private f32* %347 = OpAccessChain %9 %66 
					                                             OpStore %347 %346 
					                              f32_4 %348 = OpLoad %9 
					                              f32_3 %349 = OpVectorShuffle %348 %348 0 0 0 
					                              f32_3 %350 = OpLoad %45 
					                              f32_3 %351 = OpFMul %349 %350 
					                              f32_4 %352 = OpLoad %328 
					                              f32_4 %353 = OpVectorShuffle %352 %351 4 5 6 3 
					                                             OpStore %328 %353 
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						vec4 unused_0_6;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CoCTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat10;
					bool u_xlatb10;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat0.zw);
					    u_xlat16 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat16 = max(u_xlat1.z, u_xlat16);
					    u_xlat16 = u_xlat16 + 1.0;
					    u_xlat2 = texture(_CoCTex, u_xlat0.zw);
					    u_xlat10 = u_xlat2.x * 2.0 + -1.0;
					    u_xlat15 = abs(u_xlat10) / u_xlat16;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat2 = texture(_MainTex, u_xlat0.xy);
					    u_xlat3 = texture(_CoCTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat3.x * 2.0 + -1.0;
					    u_xlat5 = max(u_xlat2.y, u_xlat2.x);
					    u_xlat5 = max(u_xlat2.z, u_xlat5);
					    u_xlat5 = u_xlat5 + 1.0;
					    u_xlat5 = abs(u_xlat0.x) / u_xlat5;
					    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat5) + u_xlat1.xyz;
					    u_xlat5 = u_xlat15 + u_xlat5;
					    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat15 = max(u_xlat3.y, u_xlat3.x);
					    u_xlat15 = max(u_xlat3.z, u_xlat15);
					    u_xlat15 = u_xlat15 + 1.0;
					    u_xlat4 = texture(_CoCTex, u_xlat2.xy);
					    u_xlat16 = u_xlat4.x * 2.0 + -1.0;
					    u_xlat15 = abs(u_xlat16) / u_xlat15;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat15) + u_xlat1.xyz;
					    u_xlat5 = u_xlat15 + u_xlat5;
					    u_xlat3 = texture(_MainTex, u_xlat2.zw);
					    u_xlat2 = texture(_CoCTex, u_xlat2.zw);
					    u_xlat15 = u_xlat2.x * 2.0 + -1.0;
					    u_xlat2.x = max(u_xlat3.y, u_xlat3.x);
					    u_xlat2.x = max(u_xlat3.z, u_xlat2.x);
					    u_xlat2.x = u_xlat2.x + 1.0;
					    u_xlat2.x = abs(u_xlat15) / u_xlat2.x;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat5 = u_xlat5 + u_xlat2.x;
					    u_xlat5 = max(u_xlat5, 9.99999975e-05);
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat5);
					    u_xlat5 = min(u_xlat10, u_xlat16);
					    u_xlat10 = max(u_xlat10, u_xlat16);
					    u_xlat10 = max(u_xlat15, u_xlat10);
					    u_xlat5 = min(u_xlat15, u_xlat5);
					    u_xlat5 = min(u_xlat5, u_xlat0.x);
					    u_xlat0.x = max(u_xlat10, u_xlat0.x);
					    u_xlatb10 = u_xlat0.x<(-u_xlat5);
					    u_xlat0.x = (u_xlatb10) ? u_xlat5 : u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MaxCoC;
					    u_xlat5 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat5 = float(1.0) / u_xlat5;
					    u_xlat5 = u_xlat5 * abs(u_xlat0.x);
					    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.x;
					    u_xlat0.x = u_xlat5 * -2.0 + 3.0;
					    u_xlat5 = u_xlat5 * u_xlat5;
					    u_xlat0.x = u_xlat5 * u_xlat0.x;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
			Name "Bokeh Filter (small)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 860609
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[16];
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _MaxCoC;
					uniform 	float _RcpAspect;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
						ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
						ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
						ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
						ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
						ImmCB_0_0_0[6] = vec2(1.0, 0.0);
						ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
						ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
						ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
						ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
						ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
						ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
						ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
						ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.196349546;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
					; Bound: 321
					; Schema: 0
					                                                OpCapability Shader 
					                                         %1 = OpExtInstImport "GLSL.std.450" 
					                                                OpMemoryModel Logical GLSL450 
					                                                OpEntryPoint Fragment %4 "main" %22 %159 %305 
					                                                OpExecutionMode %4 OriginUpperLeft 
					                                                OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                OpDecorate %12 DescriptorSet 12 
					                                                OpDecorate %12 Binding 12 
					                                                OpDecorate %16 DescriptorSet 16 
					                                                OpDecorate %16 Binding 16 
					                                                OpDecorate vs_TEXCOORD1 Location 22 
					                                                OpMemberDecorate %33 0 Offset 33 
					                                                OpMemberDecorate %33 1 Offset 33 
					                                                OpMemberDecorate %33 2 Offset 33 
					                                                OpMemberDecorate %33 3 Offset 33 
					                                                OpDecorate %33 Block 
					                                                OpDecorate %35 DescriptorSet 35 
					                                                OpDecorate %35 Binding 35 
					                                                OpDecorate vs_TEXCOORD0 Location 159 
					                                                OpDecorate %305 Location 305 
					                                         %2 = OpTypeVoid 
					                                         %3 = OpTypeFunction %2 
					                                         %6 = OpTypeFloat 32 
					                                         %7 = OpTypeVector %6 3 
					                                         %8 = OpTypePointer Private %7 
					                          Private f32_3* %9 = OpVariable Private 
					                                        %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                        %11 = OpTypePointer UniformConstant %10 
					   UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                        %14 = OpTypeSampler 
					                                        %15 = OpTypePointer UniformConstant %14 
					               UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                        %18 = OpTypeSampledImage %10 
					                                        %20 = OpTypeVector %6 2 
					                                        %21 = OpTypePointer Input %20 
					                  Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                        %24 = OpTypeVector %6 4 
					                                        %26 = OpTypeInt 32 0 
					                                    u32 %27 = OpConstant 3 
					                                    u32 %29 = OpConstant 0 
					                                        %30 = OpTypePointer Private %6 
					                           Private f32* %32 = OpVariable Private 
					                                        %33 = OpTypeStruct %6 %24 %6 %6 
					                                        %34 = OpTypePointer Uniform %33 
					Uniform struct {f32; f32_4; f32; f32;}* %35 = OpVariable Uniform 
					                                        %36 = OpTypeInt 32 1 
					                                    i32 %37 = OpConstant 1 
					                                    u32 %38 = OpConstant 1 
					                                        %39 = OpTypePointer Uniform %6 
					                                        %45 = OpTypePointer Private %24 
					                         Private f32_4* %46 = OpVariable Private 
					                                    f32 %47 = OpConstant 3,674022E-40 
					                         Private f32_4* %49 = OpVariable Private 
					                                    f32 %50 = OpConstant 3,674022E-40 
					                                    u32 %53 = OpConstant 2 
					                         Private f32_4* %56 = OpVariable Private 
					                                        %61 = OpTypePointer Function %36 
					                                    i32 %63 = OpConstant 0 
					                                    i32 %70 = OpConstant 16 
					                                        %71 = OpTypeBool 
					                         Private f32_4* %73 = OpVariable Private 
					                                    i32 %74 = OpConstant 2 
					                                        %83 = OpTypeVector %26 4 
					                                    u32 %84 = OpConstant 16 
					                                        %85 = OpTypeArray %83 %84 
					                                  u32_4 %86 = OpConstantComposite %29 %29 %29 %29 
					                                    u32 %87 = OpConstant 1057727209 
					                                  u32_4 %88 = OpConstantComposite %87 %29 %29 %29 
					                                    u32 %89 = OpConstant 1043110300 
					                                    u32 %90 = OpConstant 1057279317 
					                                  u32_4 %91 = OpConstantComposite %89 %90 %29 %29 
					                                    u32 %92 = OpConstant 3202478008 
					                                    u32 %93 = OpConstant 1050945282 
					                                  u32_4 %94 = OpConstantComposite %92 %93 %29 %29 
					                                    u32 %95 = OpConstant 3202478006 
					                                    u32 %96 = OpConstant 3198428933 
					                                  u32_4 %97 = OpConstantComposite %95 %96 %29 %29 
					                                    u32 %98 = OpConstant 1043110305 
					                                    u32 %99 = OpConstant 3204762965 
					                                 u32_4 %100 = OpConstantComposite %98 %99 %29 %29 
					                                   u32 %101 = OpConstant 1065353216 
					                                 u32_4 %102 = OpConstantComposite %101 %29 %29 %29 
					                                   u32 %103 = OpConstant 1062149053 
					                                   u32 %104 = OpConstant 1058437400 
					                                 u32_4 %105 = OpConstantComposite %103 %104 %29 %29 
					                                   u32 %106 = OpConstant 1050556281 
					                                   u32 %107 = OpConstant 1064532081 
					                                 u32_4 %108 = OpConstantComposite %106 %107 %29 %29 
					                                   u32 %109 = OpConstant 3198039931 
					                                   u32 %110 = OpConstant 1064532080 
					                                 u32_4 %111 = OpConstantComposite %109 %110 %29 %29 
					                                   u32 %112 = OpConstant 3209632702 
					                                   u32 %113 = OpConstant 1058437399 
					                                 u32_4 %114 = OpConstantComposite %112 %113 %29 %29 
					                                   u32 %115 = OpConstant 3212836864 
					                                 u32_4 %116 = OpConstantComposite %115 %29 %29 %29 
					                                   u32 %117 = OpConstant 3209632700 
					                                   u32 %118 = OpConstant 3205921050 
					                                 u32_4 %119 = OpConstantComposite %117 %118 %29 %29 
					                                   u32 %120 = OpConstant 3198039918 
					                                   u32 %121 = OpConstant 3212015730 
					                                 u32_4 %122 = OpConstantComposite %120 %121 %29 %29 
					                                   u32 %123 = OpConstant 1050556286 
					                                   u32 %124 = OpConstant 3212015728 
					                                 u32_4 %125 = OpConstantComposite %123 %124 %29 %29 
					                                   u32 %126 = OpConstant 1062149052 
					                                   u32 %127 = OpConstant 3205921049 
					                                 u32_4 %128 = OpConstantComposite %126 %127 %29 %29 
					                             u32_4[16] %129 = OpConstantComposite %86 %88 %91 %94 %97 %100 %102 %105 %108 %111 %114 %116 %119 %122 %125 %128 
					                                       %131 = OpTypeVector %26 2 
					                                       %132 = OpTypePointer Function %85 
					                                       %134 = OpTypePointer Function %83 
					                          Private f32* %142 = OpVariable Private 
					                                   i32 %152 = OpConstant 3 
					                  Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                          Private f32* %185 = OpVariable Private 
					                                   f32 %199 = OpConstant 3,674022E-40 
					                                       %224 = OpTypePointer Private %71 
					                         Private bool* %225 = OpVariable Private 
					                          Private f32* %232 = OpVariable Private 
					                         Private bool* %256 = OpVariable Private 
					                         Private bool* %274 = OpVariable Private 
					                                   f32 %293 = OpConstant 3,674022E-40 
					                                       %304 = OpTypePointer Output %24 
					                         Output f32_4* %305 = OpVariable Output 
					                                       %316 = OpTypePointer Output %6 
					                                       %319 = OpTypePointer Private %36 
					                          Private i32* %320 = OpVariable Private 
					                                    void %4 = OpFunction None %3 
					                                         %5 = OpLabel 
					                          Function i32* %62 = OpVariable Function 
					                   Function u32_4[16]* %133 = OpVariable Function 
					                    read_only Texture2D %13 = OpLoad %12 
					                                sampler %17 = OpLoad %16 
					             read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                  f32_2 %23 = OpLoad vs_TEXCOORD1 
					                                  f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                                    f32 %28 = OpCompositeExtract %25 3 
					                           Private f32* %31 = OpAccessChain %9 %29 
					                                                OpStore %31 %28 
					                           Uniform f32* %40 = OpAccessChain %35 %37 %38 
					                                    f32 %41 = OpLoad %40 
					                           Uniform f32* %42 = OpAccessChain %35 %37 %38 
					                                    f32 %43 = OpLoad %42 
					                                    f32 %44 = OpFAdd %41 %43 
					                                                OpStore %32 %44 
					                           Private f32* %48 = OpAccessChain %46 %27 
					                                                OpStore %48 %47 
					                           Private f32* %51 = OpAccessChain %49 %29 
					                                                OpStore %51 %50 
					                           Private f32* %52 = OpAccessChain %49 %38 
					                                                OpStore %52 %50 
					                           Private f32* %54 = OpAccessChain %49 %53 
					                                                OpStore %54 %50 
					                           Private f32* %55 = OpAccessChain %49 %27 
					                                                OpStore %55 %50 
					                           Private f32* %57 = OpAccessChain %56 %29 
					                                                OpStore %57 %50 
					                           Private f32* %58 = OpAccessChain %56 %38 
					                                                OpStore %58 %50 
					                           Private f32* %59 = OpAccessChain %56 %53 
					                                                OpStore %59 %50 
					                           Private f32* %60 = OpAccessChain %56 %27 
					                                                OpStore %60 %50 
					                                                OpStore %62 %63 
					                                                OpBranch %64 
					                                        %64 = OpLabel 
					                                                OpLoopMerge %66 %67 None 
					                                                OpBranch %68 
					                                        %68 = OpLabel 
					                                    i32 %69 = OpLoad %62 
					                                   bool %72 = OpSLessThan %69 %70 
					                                                OpBranchConditional %72 %65 %66 
					                                        %65 = OpLabel 
					                           Uniform f32* %75 = OpAccessChain %35 %74 
					                                    f32 %76 = OpLoad %75 
					                           Uniform f32* %77 = OpAccessChain %35 %74 
					                                    f32 %78 = OpLoad %77 
					                                  f32_2 %79 = OpCompositeConstruct %76 %78 
					                                    f32 %80 = OpCompositeExtract %79 0 
					                                    f32 %81 = OpCompositeExtract %79 1 
					                                  f32_2 %82 = OpCompositeConstruct %80 %81 
					                                   i32 %130 = OpLoad %62 
					                                                OpStore %133 %129 
					                       Function u32_4* %135 = OpAccessChain %133 %130 
					                                 u32_4 %136 = OpLoad %135 
					                                 u32_2 %137 = OpVectorShuffle %136 %136 0 1 
					                                 f32_2 %138 = OpBitcast %137 
					                                 f32_2 %139 = OpFMul %82 %138 
					                                 f32_4 %140 = OpLoad %73 
					                                 f32_4 %141 = OpVectorShuffle %140 %139 0 4 5 3 
					                                                OpStore %73 %141 
					                                 f32_4 %143 = OpLoad %73 
					                                 f32_2 %144 = OpVectorShuffle %143 %143 1 2 
					                                 f32_4 %145 = OpLoad %73 
					                                 f32_2 %146 = OpVectorShuffle %145 %145 1 2 
					                                   f32 %147 = OpDot %144 %146 
					                                                OpStore %142 %147 
					                                   f32 %148 = OpLoad %142 
					                                   f32 %149 = OpExtInst %1 31 %148 
					                                                OpStore %142 %149 
					                          Private f32* %150 = OpAccessChain %73 %38 
					                                   f32 %151 = OpLoad %150 
					                          Uniform f32* %153 = OpAccessChain %35 %152 
					                                   f32 %154 = OpLoad %153 
					                                   f32 %155 = OpFMul %151 %154 
					                          Private f32* %156 = OpAccessChain %73 %29 
					                                                OpStore %156 %155 
					                                 f32_4 %157 = OpLoad %73 
					                                 f32_2 %158 = OpVectorShuffle %157 %157 0 2 
					                                 f32_2 %160 = OpLoad vs_TEXCOORD0 
					                                 f32_2 %161 = OpFAdd %158 %160 
					                                 f32_4 %162 = OpLoad %73 
					                                 f32_4 %163 = OpVectorShuffle %162 %161 4 5 2 3 
					                                                OpStore %73 %163 
					                                 f32_4 %164 = OpLoad %73 
					                                 f32_2 %165 = OpVectorShuffle %164 %164 0 1 
					                                 f32_2 %166 = OpCompositeConstruct %50 %50 
					                                 f32_2 %167 = OpCompositeConstruct %47 %47 
					                                 f32_2 %168 = OpExtInst %1 43 %165 %166 %167 
					                                 f32_4 %169 = OpLoad %73 
					                                 f32_4 %170 = OpVectorShuffle %169 %168 4 5 2 3 
					                                                OpStore %73 %170 
					                                 f32_4 %171 = OpLoad %73 
					                                 f32_2 %172 = OpVectorShuffle %171 %171 0 1 
					                          Uniform f32* %173 = OpAccessChain %35 %63 
					                                   f32 %174 = OpLoad %173 
					                                 f32_2 %175 = OpCompositeConstruct %174 %174 
					                                 f32_2 %176 = OpFMul %172 %175 
					                                 f32_4 %177 = OpLoad %73 
					                                 f32_4 %178 = OpVectorShuffle %177 %176 4 5 2 3 
					                                                OpStore %73 %178 
					                   read_only Texture2D %179 = OpLoad %12 
					                               sampler %180 = OpLoad %16 
					            read_only Texture2DSampled %181 = OpSampledImage %179 %180 
					                                 f32_4 %182 = OpLoad %73 
					                                 f32_2 %183 = OpVectorShuffle %182 %182 0 1 
					                                 f32_4 %184 = OpImageSampleImplicitLod %181 %183 
					                                                OpStore %73 %184 
					                          Private f32* %186 = OpAccessChain %9 %29 
					                                   f32 %187 = OpLoad %186 
					                          Private f32* %188 = OpAccessChain %73 %27 
					                                   f32 %189 = OpLoad %188 
					                                   f32 %190 = OpExtInst %1 37 %187 %189 
					                                                OpStore %185 %190 
					                                   f32 %191 = OpLoad %185 
					                                   f32 %192 = OpExtInst %1 40 %191 %50 
					                                                OpStore %185 %192 
					                                   f32 %193 = OpLoad %142 
					                                   f32 %194 = OpFNegate %193 
					                                   f32 %195 = OpLoad %185 
					                                   f32 %196 = OpFAdd %194 %195 
					                                                OpStore %185 %196 
					                          Uniform f32* %197 = OpAccessChain %35 %37 %38 
					                                   f32 %198 = OpLoad %197 
					                                   f32 %200 = OpFMul %198 %199 
					                                   f32 %201 = OpLoad %185 
					                                   f32 %202 = OpFAdd %200 %201 
					                                                OpStore %185 %202 
					                                   f32 %203 = OpLoad %185 
					                                   f32 %204 = OpLoad %32 
					                                   f32 %205 = OpFDiv %203 %204 
					                                                OpStore %185 %205 
					                                   f32 %206 = OpLoad %185 
					                                   f32 %207 = OpExtInst %1 43 %206 %50 %47 
					                                                OpStore %185 %207 
					                                   f32 %208 = OpLoad %142 
					                                   f32 %209 = OpFNegate %208 
					                          Private f32* %210 = OpAccessChain %73 %27 
					                                   f32 %211 = OpLoad %210 
					                                   f32 %212 = OpFNegate %211 
					                                   f32 %213 = OpFAdd %209 %212 
					                                                OpStore %142 %213 
					                          Uniform f32* %214 = OpAccessChain %35 %37 %38 
					                                   f32 %215 = OpLoad %214 
					                                   f32 %216 = OpFMul %215 %199 
					                                   f32 %217 = OpLoad %142 
					                                   f32 %218 = OpFAdd %216 %217 
					                                                OpStore %142 %218 
					                                   f32 %219 = OpLoad %142 
					                                   f32 %220 = OpLoad %32 
					                                   f32 %221 = OpFDiv %219 %220 
					                                                OpStore %142 %221 
					                                   f32 %222 = OpLoad %142 
					                                   f32 %223 = OpExtInst %1 43 %222 %50 %47 
					                                                OpStore %142 %223 
					                          Private f32* %226 = OpAccessChain %73 %27 
					                                   f32 %227 = OpLoad %226 
					                                   f32 %228 = OpFNegate %227 
					                          Uniform f32* %229 = OpAccessChain %35 %37 %38 
					                                   f32 %230 = OpLoad %229 
					                                  bool %231 = OpFOrdGreaterThanEqual %228 %230 
					                                                OpStore %225 %231 
					                                  bool %233 = OpLoad %225 
					                                   f32 %234 = OpSelect %233 %47 %50 
					                                                OpStore %232 %234 
					                                   f32 %235 = OpLoad %142 
					                                   f32 %236 = OpLoad %232 
					                                   f32 %237 = OpFMul %235 %236 
					                                                OpStore %142 %237 
					                                 f32_4 %238 = OpLoad %73 
					                                 f32_3 %239 = OpVectorShuffle %238 %238 0 1 2 
					                                 f32_4 %240 = OpLoad %46 
					                                 f32_4 %241 = OpVectorShuffle %240 %239 4 5 6 3 
					                                                OpStore %46 %241 
					                                 f32_4 %242 = OpLoad %46 
					                                   f32 %243 = OpLoad %185 
					                                 f32_4 %244 = OpCompositeConstruct %243 %243 %243 %243 
					                                 f32_4 %245 = OpFMul %242 %244 
					                                 f32_4 %246 = OpLoad %49 
					                                 f32_4 %247 = OpFAdd %245 %246 
					                                                OpStore %49 %247 
					                                 f32_4 %248 = OpLoad %46 
					                                   f32 %249 = OpLoad %142 
					                                 f32_4 %250 = OpCompositeConstruct %249 %249 %249 %249 
					                                 f32_4 %251 = OpFMul %248 %250 
					                                 f32_4 %252 = OpLoad %56 
					                                 f32_4 %253 = OpFAdd %251 %252 
					                                                OpStore %56 %253 
					                                                OpBranch %67 
					                                        %67 = OpLabel 
					                                   i32 %254 = OpLoad %62 
					                                   i32 %255 = OpIAdd %254 %37 
					                                                OpStore %62 %255 
					                                                OpBranch %64 
					                                        %66 = OpLabel 
					                          Private f32* %257 = OpAccessChain %49 %27 
					                                   f32 %258 = OpLoad %257 
					                                  bool %259 = OpFOrdEqual %258 %50 
					                                                OpStore %256 %259 
					                                  bool %260 = OpLoad %256 
					                                   f32 %261 = OpSelect %260 %47 %50 
					                          Private f32* %262 = OpAccessChain %9 %29 
					                                                OpStore %262 %261 
					                          Private f32* %263 = OpAccessChain %9 %29 
					                                   f32 %264 = OpLoad %263 
					                          Private f32* %265 = OpAccessChain %49 %27 
					                                   f32 %266 = OpLoad %265 
					                                   f32 %267 = OpFAdd %264 %266 
					                          Private f32* %268 = OpAccessChain %9 %29 
					                                                OpStore %268 %267 
					                                 f32_4 %269 = OpLoad %49 
					                                 f32_3 %270 = OpVectorShuffle %269 %269 0 1 2 
					                                 f32_3 %271 = OpLoad %9 
					                                 f32_3 %272 = OpVectorShuffle %271 %271 0 0 0 
					                                 f32_3 %273 = OpFDiv %270 %272 
					                                                OpStore %9 %273 
					                          Private f32* %275 = OpAccessChain %56 %27 
					                                   f32 %276 = OpLoad %275 
					                                  bool %277 = OpFOrdEqual %276 %50 
					                                                OpStore %274 %277 
					                                  bool %278 = OpLoad %274 
					                                   f32 %279 = OpSelect %278 %47 %50 
					                                                OpStore %142 %279 
					                                   f32 %280 = OpLoad %142 
					                          Private f32* %281 = OpAccessChain %56 %27 
					                                   f32 %282 = OpLoad %281 
					                                   f32 %283 = OpFAdd %280 %282 
					                                                OpStore %142 %283 
					                                 f32_4 %284 = OpLoad %56 
					                                 f32_3 %285 = OpVectorShuffle %284 %284 0 1 2 
					                                   f32 %286 = OpLoad %142 
					                                 f32_3 %287 = OpCompositeConstruct %286 %286 %286 
					                                 f32_3 %288 = OpFDiv %285 %287 
					                                 f32_4 %289 = OpLoad %46 
					                                 f32_4 %290 = OpVectorShuffle %289 %288 4 5 6 3 
					                                                OpStore %46 %290 
					                          Private f32* %291 = OpAccessChain %56 %27 
					                                   f32 %292 = OpLoad %291 
					                                   f32 %294 = OpFMul %292 %293 
					                                                OpStore %142 %294 
					                                   f32 %295 = OpLoad %142 
					                                   f32 %296 = OpExtInst %1 37 %295 %47 
					                                                OpStore %142 %296 
					                                 f32_3 %297 = OpLoad %9 
					                                 f32_3 %298 = OpFNegate %297 
					                                 f32_4 %299 = OpLoad %46 
					                                 f32_3 %300 = OpVectorShuffle %299 %299 0 1 2 
					                                 f32_3 %301 = OpFAdd %298 %300 
					                                 f32_4 %302 = OpLoad %46 
					                                 f32_4 %303 = OpVectorShuffle %302 %301 4 5 6 3 
					                                                OpStore %46 %303 
					                                   f32 %306 = OpLoad %142 
					                                 f32_3 %307 = OpCompositeConstruct %306 %306 %306 
					                                 f32_4 %308 = OpLoad %46 
					                                 f32_3 %309 = OpVectorShuffle %308 %308 0 1 2 
					                                 f32_3 %310 = OpFMul %307 %309 
					                                 f32_3 %311 = OpLoad %9 
					                                 f32_3 %312 = OpFAdd %310 %311 
					                                 f32_4 %313 = OpLoad %305 
					                                 f32_4 %314 = OpVectorShuffle %313 %312 4 5 6 3 
					                                                OpStore %305 %314 
					                                   f32 %315 = OpLoad %142 
					                           Output f32* %317 = OpAccessChain %305 %27 
					                                                OpStore %317 %315 
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
					vec2 ImmCB_0_0_0[16];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
						ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
						ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
						ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
						ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
						ImmCB_0_0_0[6] = vec2(1.0, 0.0);
						ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
						ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
						ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
						ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
						ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
						ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
						ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
						ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.196349546;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
			Name "Bokeh Filter (medium)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 946570
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[22];
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _MaxCoC;
					uniform 	float _RcpAspect;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
						ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
						ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
						ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
						ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
						ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
						ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
						ImmCB_0_0_0[8] = vec2(1.0, 0.0);
						ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
						ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
						ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
						ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
						ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
						ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
						ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.142799661;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
					; Bound: 333
					; Schema: 0
					                                                OpCapability Shader 
					                                         %1 = OpExtInstImport "GLSL.std.450" 
					                                                OpMemoryModel Logical GLSL450 
					                                                OpEntryPoint Fragment %4 "main" %22 %171 %317 
					                                                OpExecutionMode %4 OriginUpperLeft 
					                                                OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                OpDecorate %12 DescriptorSet 12 
					                                                OpDecorate %12 Binding 12 
					                                                OpDecorate %16 DescriptorSet 16 
					                                                OpDecorate %16 Binding 16 
					                                                OpDecorate vs_TEXCOORD1 Location 22 
					                                                OpMemberDecorate %33 0 Offset 33 
					                                                OpMemberDecorate %33 1 Offset 33 
					                                                OpMemberDecorate %33 2 Offset 33 
					                                                OpMemberDecorate %33 3 Offset 33 
					                                                OpDecorate %33 Block 
					                                                OpDecorate %35 DescriptorSet 35 
					                                                OpDecorate %35 Binding 35 
					                                                OpDecorate vs_TEXCOORD0 Location 171 
					                                                OpDecorate %317 Location 317 
					                                         %2 = OpTypeVoid 
					                                         %3 = OpTypeFunction %2 
					                                         %6 = OpTypeFloat 32 
					                                         %7 = OpTypeVector %6 3 
					                                         %8 = OpTypePointer Private %7 
					                          Private f32_3* %9 = OpVariable Private 
					                                        %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                        %11 = OpTypePointer UniformConstant %10 
					   UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                        %14 = OpTypeSampler 
					                                        %15 = OpTypePointer UniformConstant %14 
					               UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                        %18 = OpTypeSampledImage %10 
					                                        %20 = OpTypeVector %6 2 
					                                        %21 = OpTypePointer Input %20 
					                  Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                        %24 = OpTypeVector %6 4 
					                                        %26 = OpTypeInt 32 0 
					                                    u32 %27 = OpConstant 3 
					                                    u32 %29 = OpConstant 0 
					                                        %30 = OpTypePointer Private %6 
					                           Private f32* %32 = OpVariable Private 
					                                        %33 = OpTypeStruct %6 %24 %6 %6 
					                                        %34 = OpTypePointer Uniform %33 
					Uniform struct {f32; f32_4; f32; f32;}* %35 = OpVariable Uniform 
					                                        %36 = OpTypeInt 32 1 
					                                    i32 %37 = OpConstant 1 
					                                    u32 %38 = OpConstant 1 
					                                        %39 = OpTypePointer Uniform %6 
					                                        %45 = OpTypePointer Private %24 
					                         Private f32_4* %46 = OpVariable Private 
					                                    f32 %47 = OpConstant 3,674022E-40 
					                         Private f32_4* %49 = OpVariable Private 
					                                    f32 %50 = OpConstant 3,674022E-40 
					                                    u32 %53 = OpConstant 2 
					                         Private f32_4* %56 = OpVariable Private 
					                                        %61 = OpTypePointer Function %36 
					                                    i32 %63 = OpConstant 0 
					                                    i32 %70 = OpConstant 22 
					                                        %71 = OpTypeBool 
					                         Private f32_4* %73 = OpVariable Private 
					                                    i32 %74 = OpConstant 2 
					                                        %83 = OpTypeVector %26 4 
					                                    u32 %84 = OpConstant 22 
					                                        %85 = OpTypeArray %83 %84 
					                                  u32_4 %86 = OpConstantComposite %29 %29 %29 %29 
					                                    u32 %87 = OpConstant 1057523849 
					                                  u32_4 %88 = OpConstantComposite %87 %29 %29 %29 
					                                    u32 %89 = OpConstant 1051345177 
					                                    u32 %90 = OpConstant 1054178812 
					                                  u32_4 %91 = OpConstantComposite %89 %90 %29 %29 
					                                    u32 %92 = OpConstant 3186822495 
					                                    u32 %93 = OpConstant 1057299508 
					                                  u32_4 %94 = OpConstantComposite %92 %93 %29 %29 
					                                    u32 %95 = OpConstant 3203794506 
					                                    u32 %96 = OpConstant 1047328091 
					                                  u32_4 %97 = OpConstantComposite %95 %96 %29 %29 
					                                    u32 %98 = OpConstant 3194811737 
					                                  u32_4 %99 = OpConstantComposite %95 %98 %29 %29 
					                                   u32 %100 = OpConstant 3186822466 
					                                   u32 %101 = OpConstant 3204783157 
					                                 u32_4 %102 = OpConstantComposite %100 %101 %29 %29 
					                                   u32 %103 = OpConstant 1051345175 
					                                   u32 %104 = OpConstant 3201662463 
					                                 u32_4 %105 = OpConstantComposite %103 %104 %29 %29 
					                                   u32 %106 = OpConstant 1065353216 
					                                 u32_4 %107 = OpConstantComposite %106 %29 %29 %29 
					                                   u32 %108 = OpConstant 1063691749 
					                                   u32 %109 = OpConstant 1054746115 
					                                 u32_4 %110 = OpConstantComposite %108 %109 %29 %29 
					                                   u32 %111 = OpConstant 1059036423 
					                                   u32 %112 = OpConstant 1061692956 
					                                 u32_4 %113 = OpConstantComposite %111 %112 %29 %29 
					                                   u32 %114 = OpConstant 1046731914 
					                                   u32 %115 = OpConstant 1064932576 
					                                 u32_4 %116 = OpConstantComposite %114 %115 %29 %29 
					                                   u32 %117 = OpConstant 3194215560 
					                                 u32_4 %118 = OpConstantComposite %117 %115 %29 %29 
					                                   u32 %119 = OpConstant 3206520074 
					                                   u32 %120 = OpConstant 1061692954 
					                                 u32_4 %121 = OpConstantComposite %119 %120 %29 %29 
					                                   u32 %122 = OpConstant 3211175397 
					                                   u32 %123 = OpConstant 1054746117 
					                                 u32_4 %124 = OpConstantComposite %122 %123 %29 %29 
					                                   u32 %125 = OpConstant 3212836864 
					                                 u32_4 %126 = OpConstantComposite %125 %29 %29 %29 
					                                   u32 %127 = OpConstant 3202229763 
					                                 u32_4 %128 = OpConstantComposite %122 %127 %29 %29 
					                                   u32 %129 = OpConstant 3206520068 
					                                   u32 %130 = OpConstant 3209176606 
					                                 u32_4 %131 = OpConstantComposite %129 %130 %29 %29 
					                                   u32 %132 = OpConstant 3194215533 
					                                   u32 %133 = OpConstant 3212416226 
					                                 u32_4 %134 = OpConstantComposite %132 %133 %29 %29 
					                                   u32 %135 = OpConstant 1046731949 
					                                   u32 %136 = OpConstant 3212416222 
					                                 u32_4 %137 = OpConstantComposite %135 %136 %29 %29 
					                                   u32 %138 = OpConstant 1059036421 
					                                 u32_4 %139 = OpConstantComposite %138 %130 %29 %29 
					                                 u32_4 %140 = OpConstantComposite %108 %127 %29 %29 
					                             u32_4[22] %141 = OpConstantComposite %86 %88 %91 %94 %97 %99 %102 %105 %107 %110 %113 %116 %118 %121 %124 %126 %128 %131 %134 %137 %139 %140 
					                                       %143 = OpTypeVector %26 2 
					                                       %144 = OpTypePointer Function %85 
					                                       %146 = OpTypePointer Function %83 
					                          Private f32* %154 = OpVariable Private 
					                                   i32 %164 = OpConstant 3 
					                  Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                          Private f32* %197 = OpVariable Private 
					                                   f32 %211 = OpConstant 3,674022E-40 
					                                       %236 = OpTypePointer Private %71 
					                         Private bool* %237 = OpVariable Private 
					                          Private f32* %244 = OpVariable Private 
					                         Private bool* %268 = OpVariable Private 
					                         Private bool* %286 = OpVariable Private 
					                                   f32 %305 = OpConstant 3,674022E-40 
					                                       %316 = OpTypePointer Output %24 
					                         Output f32_4* %317 = OpVariable Output 
					                                       %328 = OpTypePointer Output %6 
					                                       %331 = OpTypePointer Private %36 
					                          Private i32* %332 = OpVariable Private 
					                                    void %4 = OpFunction None %3 
					                                         %5 = OpLabel 
					                          Function i32* %62 = OpVariable Function 
					                   Function u32_4[22]* %145 = OpVariable Function 
					                    read_only Texture2D %13 = OpLoad %12 
					                                sampler %17 = OpLoad %16 
					             read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                  f32_2 %23 = OpLoad vs_TEXCOORD1 
					                                  f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                                    f32 %28 = OpCompositeExtract %25 3 
					                           Private f32* %31 = OpAccessChain %9 %29 
					                                                OpStore %31 %28 
					                           Uniform f32* %40 = OpAccessChain %35 %37 %38 
					                                    f32 %41 = OpLoad %40 
					                           Uniform f32* %42 = OpAccessChain %35 %37 %38 
					                                    f32 %43 = OpLoad %42 
					                                    f32 %44 = OpFAdd %41 %43 
					                                                OpStore %32 %44 
					                           Private f32* %48 = OpAccessChain %46 %27 
					                                                OpStore %48 %47 
					                           Private f32* %51 = OpAccessChain %49 %29 
					                                                OpStore %51 %50 
					                           Private f32* %52 = OpAccessChain %49 %38 
					                                                OpStore %52 %50 
					                           Private f32* %54 = OpAccessChain %49 %53 
					                                                OpStore %54 %50 
					                           Private f32* %55 = OpAccessChain %49 %27 
					                                                OpStore %55 %50 
					                           Private f32* %57 = OpAccessChain %56 %29 
					                                                OpStore %57 %50 
					                           Private f32* %58 = OpAccessChain %56 %38 
					                                                OpStore %58 %50 
					                           Private f32* %59 = OpAccessChain %56 %53 
					                                                OpStore %59 %50 
					                           Private f32* %60 = OpAccessChain %56 %27 
					                                                OpStore %60 %50 
					                                                OpStore %62 %63 
					                                                OpBranch %64 
					                                        %64 = OpLabel 
					                                                OpLoopMerge %66 %67 None 
					                                                OpBranch %68 
					                                        %68 = OpLabel 
					                                    i32 %69 = OpLoad %62 
					                                   bool %72 = OpSLessThan %69 %70 
					                                                OpBranchConditional %72 %65 %66 
					                                        %65 = OpLabel 
					                           Uniform f32* %75 = OpAccessChain %35 %74 
					                                    f32 %76 = OpLoad %75 
					                           Uniform f32* %77 = OpAccessChain %35 %74 
					                                    f32 %78 = OpLoad %77 
					                                  f32_2 %79 = OpCompositeConstruct %76 %78 
					                                    f32 %80 = OpCompositeExtract %79 0 
					                                    f32 %81 = OpCompositeExtract %79 1 
					                                  f32_2 %82 = OpCompositeConstruct %80 %81 
					                                   i32 %142 = OpLoad %62 
					                                                OpStore %145 %141 
					                       Function u32_4* %147 = OpAccessChain %145 %142 
					                                 u32_4 %148 = OpLoad %147 
					                                 u32_2 %149 = OpVectorShuffle %148 %148 0 1 
					                                 f32_2 %150 = OpBitcast %149 
					                                 f32_2 %151 = OpFMul %82 %150 
					                                 f32_4 %152 = OpLoad %73 
					                                 f32_4 %153 = OpVectorShuffle %152 %151 0 4 5 3 
					                                                OpStore %73 %153 
					                                 f32_4 %155 = OpLoad %73 
					                                 f32_2 %156 = OpVectorShuffle %155 %155 1 2 
					                                 f32_4 %157 = OpLoad %73 
					                                 f32_2 %158 = OpVectorShuffle %157 %157 1 2 
					                                   f32 %159 = OpDot %156 %158 
					                                                OpStore %154 %159 
					                                   f32 %160 = OpLoad %154 
					                                   f32 %161 = OpExtInst %1 31 %160 
					                                                OpStore %154 %161 
					                          Private f32* %162 = OpAccessChain %73 %38 
					                                   f32 %163 = OpLoad %162 
					                          Uniform f32* %165 = OpAccessChain %35 %164 
					                                   f32 %166 = OpLoad %165 
					                                   f32 %167 = OpFMul %163 %166 
					                          Private f32* %168 = OpAccessChain %73 %29 
					                                                OpStore %168 %167 
					                                 f32_4 %169 = OpLoad %73 
					                                 f32_2 %170 = OpVectorShuffle %169 %169 0 2 
					                                 f32_2 %172 = OpLoad vs_TEXCOORD0 
					                                 f32_2 %173 = OpFAdd %170 %172 
					                                 f32_4 %174 = OpLoad %73 
					                                 f32_4 %175 = OpVectorShuffle %174 %173 4 5 2 3 
					                                                OpStore %73 %175 
					                                 f32_4 %176 = OpLoad %73 
					                                 f32_2 %177 = OpVectorShuffle %176 %176 0 1 
					                                 f32_2 %178 = OpCompositeConstruct %50 %50 
					                                 f32_2 %179 = OpCompositeConstruct %47 %47 
					                                 f32_2 %180 = OpExtInst %1 43 %177 %178 %179 
					                                 f32_4 %181 = OpLoad %73 
					                                 f32_4 %182 = OpVectorShuffle %181 %180 4 5 2 3 
					                                                OpStore %73 %182 
					                                 f32_4 %183 = OpLoad %73 
					                                 f32_2 %184 = OpVectorShuffle %183 %183 0 1 
					                          Uniform f32* %185 = OpAccessChain %35 %63 
					                                   f32 %186 = OpLoad %185 
					                                 f32_2 %187 = OpCompositeConstruct %186 %186 
					                                 f32_2 %188 = OpFMul %184 %187 
					                                 f32_4 %189 = OpLoad %73 
					                                 f32_4 %190 = OpVectorShuffle %189 %188 4 5 2 3 
					                                                OpStore %73 %190 
					                   read_only Texture2D %191 = OpLoad %12 
					                               sampler %192 = OpLoad %16 
					            read_only Texture2DSampled %193 = OpSampledImage %191 %192 
					                                 f32_4 %194 = OpLoad %73 
					                                 f32_2 %195 = OpVectorShuffle %194 %194 0 1 
					                                 f32_4 %196 = OpImageSampleImplicitLod %193 %195 
					                                                OpStore %73 %196 
					                          Private f32* %198 = OpAccessChain %9 %29 
					                                   f32 %199 = OpLoad %198 
					                          Private f32* %200 = OpAccessChain %73 %27 
					                                   f32 %201 = OpLoad %200 
					                                   f32 %202 = OpExtInst %1 37 %199 %201 
					                                                OpStore %197 %202 
					                                   f32 %203 = OpLoad %197 
					                                   f32 %204 = OpExtInst %1 40 %203 %50 
					                                                OpStore %197 %204 
					                                   f32 %205 = OpLoad %154 
					                                   f32 %206 = OpFNegate %205 
					                                   f32 %207 = OpLoad %197 
					                                   f32 %208 = OpFAdd %206 %207 
					                                                OpStore %197 %208 
					                          Uniform f32* %209 = OpAccessChain %35 %37 %38 
					                                   f32 %210 = OpLoad %209 
					                                   f32 %212 = OpFMul %210 %211 
					                                   f32 %213 = OpLoad %197 
					                                   f32 %214 = OpFAdd %212 %213 
					                                                OpStore %197 %214 
					                                   f32 %215 = OpLoad %197 
					                                   f32 %216 = OpLoad %32 
					                                   f32 %217 = OpFDiv %215 %216 
					                                                OpStore %197 %217 
					                                   f32 %218 = OpLoad %197 
					                                   f32 %219 = OpExtInst %1 43 %218 %50 %47 
					                                                OpStore %197 %219 
					                                   f32 %220 = OpLoad %154 
					                                   f32 %221 = OpFNegate %220 
					                          Private f32* %222 = OpAccessChain %73 %27 
					                                   f32 %223 = OpLoad %222 
					                                   f32 %224 = OpFNegate %223 
					                                   f32 %225 = OpFAdd %221 %224 
					                                                OpStore %154 %225 
					                          Uniform f32* %226 = OpAccessChain %35 %37 %38 
					                                   f32 %227 = OpLoad %226 
					                                   f32 %228 = OpFMul %227 %211 
					                                   f32 %229 = OpLoad %154 
					                                   f32 %230 = OpFAdd %228 %229 
					                                                OpStore %154 %230 
					                                   f32 %231 = OpLoad %154 
					                                   f32 %232 = OpLoad %32 
					                                   f32 %233 = OpFDiv %231 %232 
					                                                OpStore %154 %233 
					                                   f32 %234 = OpLoad %154 
					                                   f32 %235 = OpExtInst %1 43 %234 %50 %47 
					                                                OpStore %154 %235 
					                          Private f32* %238 = OpAccessChain %73 %27 
					                                   f32 %239 = OpLoad %238 
					                                   f32 %240 = OpFNegate %239 
					                          Uniform f32* %241 = OpAccessChain %35 %37 %38 
					                                   f32 %242 = OpLoad %241 
					                                  bool %243 = OpFOrdGreaterThanEqual %240 %242 
					                                                OpStore %237 %243 
					                                  bool %245 = OpLoad %237 
					                                   f32 %246 = OpSelect %245 %47 %50 
					                                                OpStore %244 %246 
					                                   f32 %247 = OpLoad %154 
					                                   f32 %248 = OpLoad %244 
					                                   f32 %249 = OpFMul %247 %248 
					                                                OpStore %154 %249 
					                                 f32_4 %250 = OpLoad %73 
					                                 f32_3 %251 = OpVectorShuffle %250 %250 0 1 2 
					                                 f32_4 %252 = OpLoad %46 
					                                 f32_4 %253 = OpVectorShuffle %252 %251 4 5 6 3 
					                                                OpStore %46 %253 
					                                 f32_4 %254 = OpLoad %46 
					                                   f32 %255 = OpLoad %197 
					                                 f32_4 %256 = OpCompositeConstruct %255 %255 %255 %255 
					                                 f32_4 %257 = OpFMul %254 %256 
					                                 f32_4 %258 = OpLoad %49 
					                                 f32_4 %259 = OpFAdd %257 %258 
					                                                OpStore %49 %259 
					                                 f32_4 %260 = OpLoad %46 
					                                   f32 %261 = OpLoad %154 
					                                 f32_4 %262 = OpCompositeConstruct %261 %261 %261 %261 
					                                 f32_4 %263 = OpFMul %260 %262 
					                                 f32_4 %264 = OpLoad %56 
					                                 f32_4 %265 = OpFAdd %263 %264 
					                                                OpStore %56 %265 
					                                                OpBranch %67 
					                                        %67 = OpLabel 
					                                   i32 %266 = OpLoad %62 
					                                   i32 %267 = OpIAdd %266 %37 
					                                                OpStore %62 %267 
					                                                OpBranch %64 
					                                        %66 = OpLabel 
					                          Private f32* %269 = OpAccessChain %49 %27 
					                                   f32 %270 = OpLoad %269 
					                                  bool %271 = OpFOrdEqual %270 %50 
					                                                OpStore %268 %271 
					                                  bool %272 = OpLoad %268 
					                                   f32 %273 = OpSelect %272 %47 %50 
					                          Private f32* %274 = OpAccessChain %9 %29 
					                                                OpStore %274 %273 
					                          Private f32* %275 = OpAccessChain %9 %29 
					                                   f32 %276 = OpLoad %275 
					                          Private f32* %277 = OpAccessChain %49 %27 
					                                   f32 %278 = OpLoad %277 
					                                   f32 %279 = OpFAdd %276 %278 
					                          Private f32* %280 = OpAccessChain %9 %29 
					                                                OpStore %280 %279 
					                                 f32_4 %281 = OpLoad %49 
					                                 f32_3 %282 = OpVectorShuffle %281 %281 0 1 2 
					                                 f32_3 %283 = OpLoad %9 
					                                 f32_3 %284 = OpVectorShuffle %283 %283 0 0 0 
					                                 f32_3 %285 = OpFDiv %282 %284 
					                                                OpStore %9 %285 
					                          Private f32* %287 = OpAccessChain %56 %27 
					                                   f32 %288 = OpLoad %287 
					                                  bool %289 = OpFOrdEqual %288 %50 
					                                                OpStore %286 %289 
					                                  bool %290 = OpLoad %286 
					                                   f32 %291 = OpSelect %290 %47 %50 
					                                                OpStore %154 %291 
					                                   f32 %292 = OpLoad %154 
					                          Private f32* %293 = OpAccessChain %56 %27 
					                                   f32 %294 = OpLoad %293 
					                                   f32 %295 = OpFAdd %292 %294 
					                                                OpStore %154 %295 
					                                 f32_4 %296 = OpLoad %56 
					                                 f32_3 %297 = OpVectorShuffle %296 %296 0 1 2 
					                                   f32 %298 = OpLoad %154 
					                                 f32_3 %299 = OpCompositeConstruct %298 %298 %298 
					                                 f32_3 %300 = OpFDiv %297 %299 
					                                 f32_4 %301 = OpLoad %46 
					                                 f32_4 %302 = OpVectorShuffle %301 %300 4 5 6 3 
					                                                OpStore %46 %302 
					                          Private f32* %303 = OpAccessChain %56 %27 
					                                   f32 %304 = OpLoad %303 
					                                   f32 %306 = OpFMul %304 %305 
					                                                OpStore %154 %306 
					                                   f32 %307 = OpLoad %154 
					                                   f32 %308 = OpExtInst %1 37 %307 %47 
					                                                OpStore %154 %308 
					                                 f32_3 %309 = OpLoad %9 
					                                 f32_3 %310 = OpFNegate %309 
					                                 f32_4 %311 = OpLoad %46 
					                                 f32_3 %312 = OpVectorShuffle %311 %311 0 1 2 
					                                 f32_3 %313 = OpFAdd %310 %312 
					                                 f32_4 %314 = OpLoad %46 
					                                 f32_4 %315 = OpVectorShuffle %314 %313 4 5 6 3 
					                                                OpStore %46 %315 
					                                   f32 %318 = OpLoad %154 
					                                 f32_3 %319 = OpCompositeConstruct %318 %318 %318 
					                                 f32_4 %320 = OpLoad %46 
					                                 f32_3 %321 = OpVectorShuffle %320 %320 0 1 2 
					                                 f32_3 %322 = OpFMul %319 %321 
					                                 f32_3 %323 = OpLoad %9 
					                                 f32_3 %324 = OpFAdd %322 %323 
					                                 f32_4 %325 = OpLoad %317 
					                                 f32_4 %326 = OpVectorShuffle %325 %324 4 5 6 3 
					                                                OpStore %317 %326 
					                                   f32 %327 = OpLoad %154 
					                           Output f32* %329 = OpAccessChain %317 %27 
					                                                OpStore %329 %327 
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
					vec2 ImmCB_0_0_0[22];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
						ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
						ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
						ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
						ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
						ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
						ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
						ImmCB_0_0_0[8] = vec2(1.0, 0.0);
						ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
						ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
						ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
						ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
						ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
						ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
						ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.142799661;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
			Name "Bokeh Filter (large)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1022590
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[43];
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _MaxCoC;
					uniform 	float _RcpAspect;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
						ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
						ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
						ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
						ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
						ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
						ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
						ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
						ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
						ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
						ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
						ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
						ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
						ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
						ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
						ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
						ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
						ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
						ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
						ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
						ImmCB_0_0_0[22] = vec2(1.0, 0.0);
						ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
						ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
						ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
						ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
						ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
						ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
						ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
						ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
						ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
						ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
						ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
						ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
						ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
						ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
						ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.0730602965;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
					; Bound: 394
					; Schema: 0
					                                                OpCapability Shader 
					                                         %1 = OpExtInstImport "GLSL.std.450" 
					                                                OpMemoryModel Logical GLSL450 
					                                                OpEntryPoint Fragment %4 "main" %22 %232 %378 
					                                                OpExecutionMode %4 OriginUpperLeft 
					                                                OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                OpDecorate %12 DescriptorSet 12 
					                                                OpDecorate %12 Binding 12 
					                                                OpDecorate %16 DescriptorSet 16 
					                                                OpDecorate %16 Binding 16 
					                                                OpDecorate vs_TEXCOORD1 Location 22 
					                                                OpMemberDecorate %33 0 Offset 33 
					                                                OpMemberDecorate %33 1 Offset 33 
					                                                OpMemberDecorate %33 2 Offset 33 
					                                                OpMemberDecorate %33 3 Offset 33 
					                                                OpDecorate %33 Block 
					                                                OpDecorate %35 DescriptorSet 35 
					                                                OpDecorate %35 Binding 35 
					                                                OpDecorate vs_TEXCOORD0 Location 232 
					                                                OpDecorate %378 Location 378 
					                                         %2 = OpTypeVoid 
					                                         %3 = OpTypeFunction %2 
					                                         %6 = OpTypeFloat 32 
					                                         %7 = OpTypeVector %6 3 
					                                         %8 = OpTypePointer Private %7 
					                          Private f32_3* %9 = OpVariable Private 
					                                        %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                        %11 = OpTypePointer UniformConstant %10 
					   UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                        %14 = OpTypeSampler 
					                                        %15 = OpTypePointer UniformConstant %14 
					               UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                        %18 = OpTypeSampledImage %10 
					                                        %20 = OpTypeVector %6 2 
					                                        %21 = OpTypePointer Input %20 
					                  Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                        %24 = OpTypeVector %6 4 
					                                        %26 = OpTypeInt 32 0 
					                                    u32 %27 = OpConstant 3 
					                                    u32 %29 = OpConstant 0 
					                                        %30 = OpTypePointer Private %6 
					                           Private f32* %32 = OpVariable Private 
					                                        %33 = OpTypeStruct %6 %24 %6 %6 
					                                        %34 = OpTypePointer Uniform %33 
					Uniform struct {f32; f32_4; f32; f32;}* %35 = OpVariable Uniform 
					                                        %36 = OpTypeInt 32 1 
					                                    i32 %37 = OpConstant 1 
					                                    u32 %38 = OpConstant 1 
					                                        %39 = OpTypePointer Uniform %6 
					                                        %45 = OpTypePointer Private %24 
					                         Private f32_4* %46 = OpVariable Private 
					                                    f32 %47 = OpConstant 3,674022E-40 
					                         Private f32_4* %49 = OpVariable Private 
					                                    f32 %50 = OpConstant 3,674022E-40 
					                                    u32 %53 = OpConstant 2 
					                         Private f32_4* %56 = OpVariable Private 
					                                        %61 = OpTypePointer Function %36 
					                                    i32 %63 = OpConstant 0 
					                                    i32 %70 = OpConstant 43 
					                                        %71 = OpTypeBool 
					                         Private f32_4* %73 = OpVariable Private 
					                                    i32 %74 = OpConstant 2 
					                                        %83 = OpTypeVector %26 4 
					                                    u32 %84 = OpConstant 43 
					                                        %85 = OpTypeArray %83 %84 
					                                  u32_4 %86 = OpConstantComposite %29 %29 %29 %29 
					                                    u32 %87 = OpConstant 1052389004 
					                                  u32_4 %88 = OpConstantComposite %87 %29 %29 %29 
					                                    u32 %89 = OpConstant 1047013945 
					                                    u32 %90 = OpConstant 1049726997 
					                                  u32_4 %91 = OpConstantComposite %89 %90 %29 %29 
					                                    u32 %92 = OpConstant 3181754281 
					                                    u32 %93 = OpConstant 1052083084 
					                                  u32_4 %94 = OpConstantComposite %92 %93 %29 %29 
					                                    u32 %95 = OpConstant 3198664312 
					                                    u32 %96 = OpConstant 1042386948 
					                                  u32_4 %97 = OpConstantComposite %95 %96 %29 %29 
					                                    u32 %98 = OpConstant 3189870594 
					                                  u32_4 %99 = OpConstantComposite %95 %98 %29 %29 
					                                   u32 %100 = OpConstant 3181754261 
					                                   u32 %101 = OpConstant 3199566733 
					                                 u32_4 %102 = OpConstantComposite %100 %101 %29 %29 
					                                   u32 %103 = OpConstant 1047013942 
					                                   u32 %104 = OpConstant 3197210646 
					                                 u32_4 %105 = OpConstantComposite %103 %104 %29 %29 
					                                   u32 %106 = OpConstant 1060015011 
					                                 u32_4 %107 = OpConstantComposite %106 %29 %29 %29 
					                                   u32 %108 = OpConstant 1058882193 
					                                   u32 %109 = OpConstant 1050113794 
					                                 u32_4 %110 = OpConstantComposite %108 %109 %29 %29 
					                                   u32 %111 = OpConstant 1054451605 
					                                   u32 %112 = OpConstant 1057519379 
					                                 u32_4 %113 = OpConstantComposite %111 %112 %29 %29 
					                                   u32 %114 = OpConstant 1041980464 
					                                   u32 %115 = OpConstant 1059728211 
					                                 u32_4 %116 = OpConstantComposite %114 %115 %29 %29 
					                                   u32 %117 = OpConstant 3189464110 
					                                 u32_4 %118 = OpConstantComposite %117 %115 %29 %29 
					                                   u32 %119 = OpConstant 3201935257 
					                                   u32 %120 = OpConstant 1057519378 
					                                 u32_4 %121 = OpConstantComposite %119 %120 %29 %29 
					                                   u32 %122 = OpConstant 3206365841 
					                                   u32 %123 = OpConstant 1050113795 
					                                 u32_4 %124 = OpConstantComposite %122 %123 %29 %29 
					                                   u32 %125 = OpConstant 3207498659 
					                                 u32_4 %126 = OpConstantComposite %125 %29 %29 %29 
					                                   u32 %127 = OpConstant 3197597442 
					                                 u32_4 %128 = OpConstantComposite %122 %127 %29 %29 
					                                   u32 %129 = OpConstant 3201935249 
					                                   u32 %130 = OpConstant 3205003029 
					                                 u32_4 %131 = OpConstantComposite %129 %130 %29 %29 
					                                   u32 %132 = OpConstant 3189464092 
					                                   u32 %133 = OpConstant 3207211860 
					                                 u32_4 %134 = OpConstantComposite %132 %133 %29 %29 
					                                   u32 %135 = OpConstant 1041980487 
					                                   u32 %136 = OpConstant 3207211858 
					                                 u32_4 %137 = OpConstantComposite %135 %136 %29 %29 
					                                   u32 %138 = OpConstant 1054451603 
					                                 u32_4 %139 = OpConstantComposite %138 %130 %29 %29 
					                                 u32_4 %140 = OpConstantComposite %108 %127 %29 %29 
					                                   u32 %141 = OpConstant 1065353216 
					                                 u32_4 %142 = OpConstantComposite %141 %29 %29 %29 
					                                   u32 %143 = OpConstant 1064607851 
					                                   u32 %144 = OpConstant 1050077735 
					                                 u32_4 %145 = OpConstantComposite %143 %144 %29 %29 
					                                   u32 %146 = OpConstant 1062437986 
					                                   u32 %147 = OpConstant 1058026943 
					                                 u32_4 %148 = OpConstantComposite %146 %147 %29 %29 
					                                   u32 %149 = OpConstant 1059036423 
					                                   u32 %150 = OpConstant 1061692956 
					                                 u32_4 %151 = OpConstantComposite %149 %150 %29 %29 
					                                   u32 %152 = OpConstant 1052446201 
					                                   u32 %153 = OpConstant 1064193470 
					                                 u32_4 %154 = OpConstantComposite %152 %153 %29 %29 
					                                   u32 %155 = OpConstant 1033440267 
					                                   u32 %156 = OpConstant 1065306304 
					                                 u32_4 %157 = OpConstantComposite %155 %156 %29 %29 
					                                   u32 %158 = OpConstant 3194215560 
					                                   u32 %159 = OpConstant 1064932576 
					                                 u32_4 %160 = OpConstantComposite %158 %159 %29 %29 
					                                   u32 %161 = OpConstant 3204448257 
					                                   u32 %162 = OpConstant 1063105495 
					                                 u32_4 %163 = OpConstantComposite %161 %162 %29 %29 
					                                   u32 %164 = OpConstant 3208358219 
					                                   u32 %165 = OpConstant 1059987404 
					                                 u32_4 %166 = OpConstantComposite %164 %165 %29 %29 
					                                   u32 %167 = OpConstant 3211175397 
					                                   u32 %168 = OpConstant 1054746117 
					                                 u32_4 %169 = OpConstantComposite %167 %168 %29 %29 
					                                   u32 %170 = OpConstant 3212649477 
					                                   u32 %171 = OpConstant 1041800829 
					                                 u32_4 %172 = OpConstantComposite %170 %171 %29 %29 
					                                   u32 %173 = OpConstant 3212649476 
					                                   u32 %174 = OpConstant 3189284504 
					                                 u32_4 %175 = OpConstantComposite %173 %174 %29 %29 
					                                   u32 %176 = OpConstant 3202229763 
					                                 u32_4 %177 = OpConstantComposite %167 %176 %29 %29 
					                                   u32 %178 = OpConstant 3208358217 
					                                   u32 %179 = OpConstant 3207471054 
					                                 u32_4 %180 = OpConstantComposite %178 %179 %29 %29 
					                                   u32 %181 = OpConstant 3204448253 
					                                   u32 %182 = OpConstant 3210589144 
					                                 u32_4 %183 = OpConstantComposite %181 %182 %29 %29 
					                                   u32 %184 = OpConstant 3194215564 
					                                   u32 %185 = OpConstant 3212416224 
					                                 u32_4 %186 = OpConstantComposite %184 %185 %29 %29 
					                                   u32 %187 = OpConstant 1033440306 
					                                   u32 %188 = OpConstant 3212789951 
					                                 u32_4 %189 = OpConstantComposite %187 %188 %29 %29 
					                                   u32 %190 = OpConstant 1052446218 
					                                   u32 %191 = OpConstant 3211677115 
					                                 u32_4 %192 = OpConstantComposite %190 %191 %29 %29 
					                                   u32 %193 = OpConstant 1059036421 
					                                   u32 %194 = OpConstant 3209176606 
					                                 u32_4 %195 = OpConstantComposite %193 %194 %29 %29 
					                                   u32 %196 = OpConstant 1062437987 
					                                   u32 %197 = OpConstant 3205510589 
					                                 u32_4 %198 = OpConstantComposite %196 %197 %29 %29 
					                                   u32 %199 = OpConstant 1064607853 
					                                   u32 %200 = OpConstant 3197561371 
					                                 u32_4 %201 = OpConstantComposite %199 %200 %29 %29 
					                             u32_4[43] %202 = OpConstantComposite %86 %88 %91 %94 %97 %99 %102 %105 %107 %110 %113 %116 %118 %121 %124 %126 %128 %131 %134 %137 %139 %140 %142 %145 %148 %151 %154 %157 %160 %163 %166 %169 %172 %175 %177 %180 %183 %186 %189 %192 %195 %198 %201 
					                                       %204 = OpTypeVector %26 2 
					                                       %205 = OpTypePointer Function %85 
					                                       %207 = OpTypePointer Function %83 
					                          Private f32* %215 = OpVariable Private 
					                                   i32 %225 = OpConstant 3 
					                  Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                          Private f32* %258 = OpVariable Private 
					                                   f32 %272 = OpConstant 3,674022E-40 
					                                       %297 = OpTypePointer Private %71 
					                         Private bool* %298 = OpVariable Private 
					                          Private f32* %305 = OpVariable Private 
					                         Private bool* %329 = OpVariable Private 
					                         Private bool* %347 = OpVariable Private 
					                                   f32 %366 = OpConstant 3,674022E-40 
					                                       %377 = OpTypePointer Output %24 
					                         Output f32_4* %378 = OpVariable Output 
					                                       %389 = OpTypePointer Output %6 
					                                       %392 = OpTypePointer Private %36 
					                          Private i32* %393 = OpVariable Private 
					                                    void %4 = OpFunction None %3 
					                                         %5 = OpLabel 
					                          Function i32* %62 = OpVariable Function 
					                   Function u32_4[43]* %206 = OpVariable Function 
					                    read_only Texture2D %13 = OpLoad %12 
					                                sampler %17 = OpLoad %16 
					             read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                  f32_2 %23 = OpLoad vs_TEXCOORD1 
					                                  f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                                    f32 %28 = OpCompositeExtract %25 3 
					                           Private f32* %31 = OpAccessChain %9 %29 
					                                                OpStore %31 %28 
					                           Uniform f32* %40 = OpAccessChain %35 %37 %38 
					                                    f32 %41 = OpLoad %40 
					                           Uniform f32* %42 = OpAccessChain %35 %37 %38 
					                                    f32 %43 = OpLoad %42 
					                                    f32 %44 = OpFAdd %41 %43 
					                                                OpStore %32 %44 
					                           Private f32* %48 = OpAccessChain %46 %27 
					                                                OpStore %48 %47 
					                           Private f32* %51 = OpAccessChain %49 %29 
					                                                OpStore %51 %50 
					                           Private f32* %52 = OpAccessChain %49 %38 
					                                                OpStore %52 %50 
					                           Private f32* %54 = OpAccessChain %49 %53 
					                                                OpStore %54 %50 
					                           Private f32* %55 = OpAccessChain %49 %27 
					                                                OpStore %55 %50 
					                           Private f32* %57 = OpAccessChain %56 %29 
					                                                OpStore %57 %50 
					                           Private f32* %58 = OpAccessChain %56 %38 
					                                                OpStore %58 %50 
					                           Private f32* %59 = OpAccessChain %56 %53 
					                                                OpStore %59 %50 
					                           Private f32* %60 = OpAccessChain %56 %27 
					                                                OpStore %60 %50 
					                                                OpStore %62 %63 
					                                                OpBranch %64 
					                                        %64 = OpLabel 
					                                                OpLoopMerge %66 %67 None 
					                                                OpBranch %68 
					                                        %68 = OpLabel 
					                                    i32 %69 = OpLoad %62 
					                                   bool %72 = OpSLessThan %69 %70 
					                                                OpBranchConditional %72 %65 %66 
					                                        %65 = OpLabel 
					                           Uniform f32* %75 = OpAccessChain %35 %74 
					                                    f32 %76 = OpLoad %75 
					                           Uniform f32* %77 = OpAccessChain %35 %74 
					                                    f32 %78 = OpLoad %77 
					                                  f32_2 %79 = OpCompositeConstruct %76 %78 
					                                    f32 %80 = OpCompositeExtract %79 0 
					                                    f32 %81 = OpCompositeExtract %79 1 
					                                  f32_2 %82 = OpCompositeConstruct %80 %81 
					                                   i32 %203 = OpLoad %62 
					                                                OpStore %206 %202 
					                       Function u32_4* %208 = OpAccessChain %206 %203 
					                                 u32_4 %209 = OpLoad %208 
					                                 u32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                 f32_2 %211 = OpBitcast %210 
					                                 f32_2 %212 = OpFMul %82 %211 
					                                 f32_4 %213 = OpLoad %73 
					                                 f32_4 %214 = OpVectorShuffle %213 %212 0 4 5 3 
					                                                OpStore %73 %214 
					                                 f32_4 %216 = OpLoad %73 
					                                 f32_2 %217 = OpVectorShuffle %216 %216 1 2 
					                                 f32_4 %218 = OpLoad %73 
					                                 f32_2 %219 = OpVectorShuffle %218 %218 1 2 
					                                   f32 %220 = OpDot %217 %219 
					                                                OpStore %215 %220 
					                                   f32 %221 = OpLoad %215 
					                                   f32 %222 = OpExtInst %1 31 %221 
					                                                OpStore %215 %222 
					                          Private f32* %223 = OpAccessChain %73 %38 
					                                   f32 %224 = OpLoad %223 
					                          Uniform f32* %226 = OpAccessChain %35 %225 
					                                   f32 %227 = OpLoad %226 
					                                   f32 %228 = OpFMul %224 %227 
					                          Private f32* %229 = OpAccessChain %73 %29 
					                                                OpStore %229 %228 
					                                 f32_4 %230 = OpLoad %73 
					                                 f32_2 %231 = OpVectorShuffle %230 %230 0 2 
					                                 f32_2 %233 = OpLoad vs_TEXCOORD0 
					                                 f32_2 %234 = OpFAdd %231 %233 
					                                 f32_4 %235 = OpLoad %73 
					                                 f32_4 %236 = OpVectorShuffle %235 %234 4 5 2 3 
					                                                OpStore %73 %236 
					                                 f32_4 %237 = OpLoad %73 
					                                 f32_2 %238 = OpVectorShuffle %237 %237 0 1 
					                                 f32_2 %239 = OpCompositeConstruct %50 %50 
					                                 f32_2 %240 = OpCompositeConstruct %47 %47 
					                                 f32_2 %241 = OpExtInst %1 43 %238 %239 %240 
					                                 f32_4 %242 = OpLoad %73 
					                                 f32_4 %243 = OpVectorShuffle %242 %241 4 5 2 3 
					                                                OpStore %73 %243 
					                                 f32_4 %244 = OpLoad %73 
					                                 f32_2 %245 = OpVectorShuffle %244 %244 0 1 
					                          Uniform f32* %246 = OpAccessChain %35 %63 
					                                   f32 %247 = OpLoad %246 
					                                 f32_2 %248 = OpCompositeConstruct %247 %247 
					                                 f32_2 %249 = OpFMul %245 %248 
					                                 f32_4 %250 = OpLoad %73 
					                                 f32_4 %251 = OpVectorShuffle %250 %249 4 5 2 3 
					                                                OpStore %73 %251 
					                   read_only Texture2D %252 = OpLoad %12 
					                               sampler %253 = OpLoad %16 
					            read_only Texture2DSampled %254 = OpSampledImage %252 %253 
					                                 f32_4 %255 = OpLoad %73 
					                                 f32_2 %256 = OpVectorShuffle %255 %255 0 1 
					                                 f32_4 %257 = OpImageSampleImplicitLod %254 %256 
					                                                OpStore %73 %257 
					                          Private f32* %259 = OpAccessChain %9 %29 
					                                   f32 %260 = OpLoad %259 
					                          Private f32* %261 = OpAccessChain %73 %27 
					                                   f32 %262 = OpLoad %261 
					                                   f32 %263 = OpExtInst %1 37 %260 %262 
					                                                OpStore %258 %263 
					                                   f32 %264 = OpLoad %258 
					                                   f32 %265 = OpExtInst %1 40 %264 %50 
					                                                OpStore %258 %265 
					                                   f32 %266 = OpLoad %215 
					                                   f32 %267 = OpFNegate %266 
					                                   f32 %268 = OpLoad %258 
					                                   f32 %269 = OpFAdd %267 %268 
					                                                OpStore %258 %269 
					                          Uniform f32* %270 = OpAccessChain %35 %37 %38 
					                                   f32 %271 = OpLoad %270 
					                                   f32 %273 = OpFMul %271 %272 
					                                   f32 %274 = OpLoad %258 
					                                   f32 %275 = OpFAdd %273 %274 
					                                                OpStore %258 %275 
					                                   f32 %276 = OpLoad %258 
					                                   f32 %277 = OpLoad %32 
					                                   f32 %278 = OpFDiv %276 %277 
					                                                OpStore %258 %278 
					                                   f32 %279 = OpLoad %258 
					                                   f32 %280 = OpExtInst %1 43 %279 %50 %47 
					                                                OpStore %258 %280 
					                                   f32 %281 = OpLoad %215 
					                                   f32 %282 = OpFNegate %281 
					                          Private f32* %283 = OpAccessChain %73 %27 
					                                   f32 %284 = OpLoad %283 
					                                   f32 %285 = OpFNegate %284 
					                                   f32 %286 = OpFAdd %282 %285 
					                                                OpStore %215 %286 
					                          Uniform f32* %287 = OpAccessChain %35 %37 %38 
					                                   f32 %288 = OpLoad %287 
					                                   f32 %289 = OpFMul %288 %272 
					                                   f32 %290 = OpLoad %215 
					                                   f32 %291 = OpFAdd %289 %290 
					                                                OpStore %215 %291 
					                                   f32 %292 = OpLoad %215 
					                                   f32 %293 = OpLoad %32 
					                                   f32 %294 = OpFDiv %292 %293 
					                                                OpStore %215 %294 
					                                   f32 %295 = OpLoad %215 
					                                   f32 %296 = OpExtInst %1 43 %295 %50 %47 
					                                                OpStore %215 %296 
					                          Private f32* %299 = OpAccessChain %73 %27 
					                                   f32 %300 = OpLoad %299 
					                                   f32 %301 = OpFNegate %300 
					                          Uniform f32* %302 = OpAccessChain %35 %37 %38 
					                                   f32 %303 = OpLoad %302 
					                                  bool %304 = OpFOrdGreaterThanEqual %301 %303 
					                                                OpStore %298 %304 
					                                  bool %306 = OpLoad %298 
					                                   f32 %307 = OpSelect %306 %47 %50 
					                                                OpStore %305 %307 
					                                   f32 %308 = OpLoad %215 
					                                   f32 %309 = OpLoad %305 
					                                   f32 %310 = OpFMul %308 %309 
					                                                OpStore %215 %310 
					                                 f32_4 %311 = OpLoad %73 
					                                 f32_3 %312 = OpVectorShuffle %311 %311 0 1 2 
					                                 f32_4 %313 = OpLoad %46 
					                                 f32_4 %314 = OpVectorShuffle %313 %312 4 5 6 3 
					                                                OpStore %46 %314 
					                                 f32_4 %315 = OpLoad %46 
					                                   f32 %316 = OpLoad %258 
					                                 f32_4 %317 = OpCompositeConstruct %316 %316 %316 %316 
					                                 f32_4 %318 = OpFMul %315 %317 
					                                 f32_4 %319 = OpLoad %49 
					                                 f32_4 %320 = OpFAdd %318 %319 
					                                                OpStore %49 %320 
					                                 f32_4 %321 = OpLoad %46 
					                                   f32 %322 = OpLoad %215 
					                                 f32_4 %323 = OpCompositeConstruct %322 %322 %322 %322 
					                                 f32_4 %324 = OpFMul %321 %323 
					                                 f32_4 %325 = OpLoad %56 
					                                 f32_4 %326 = OpFAdd %324 %325 
					                                                OpStore %56 %326 
					                                                OpBranch %67 
					                                        %67 = OpLabel 
					                                   i32 %327 = OpLoad %62 
					                                   i32 %328 = OpIAdd %327 %37 
					                                                OpStore %62 %328 
					                                                OpBranch %64 
					                                        %66 = OpLabel 
					                          Private f32* %330 = OpAccessChain %49 %27 
					                                   f32 %331 = OpLoad %330 
					                                  bool %332 = OpFOrdEqual %331 %50 
					                                                OpStore %329 %332 
					                                  bool %333 = OpLoad %329 
					                                   f32 %334 = OpSelect %333 %47 %50 
					                          Private f32* %335 = OpAccessChain %9 %29 
					                                                OpStore %335 %334 
					                          Private f32* %336 = OpAccessChain %9 %29 
					                                   f32 %337 = OpLoad %336 
					                          Private f32* %338 = OpAccessChain %49 %27 
					                                   f32 %339 = OpLoad %338 
					                                   f32 %340 = OpFAdd %337 %339 
					                          Private f32* %341 = OpAccessChain %9 %29 
					                                                OpStore %341 %340 
					                                 f32_4 %342 = OpLoad %49 
					                                 f32_3 %343 = OpVectorShuffle %342 %342 0 1 2 
					                                 f32_3 %344 = OpLoad %9 
					                                 f32_3 %345 = OpVectorShuffle %344 %344 0 0 0 
					                                 f32_3 %346 = OpFDiv %343 %345 
					                                                OpStore %9 %346 
					                          Private f32* %348 = OpAccessChain %56 %27 
					                                   f32 %349 = OpLoad %348 
					                                  bool %350 = OpFOrdEqual %349 %50 
					                                                OpStore %347 %350 
					                                  bool %351 = OpLoad %347 
					                                   f32 %352 = OpSelect %351 %47 %50 
					                                                OpStore %215 %352 
					                                   f32 %353 = OpLoad %215 
					                          Private f32* %354 = OpAccessChain %56 %27 
					                                   f32 %355 = OpLoad %354 
					                                   f32 %356 = OpFAdd %353 %355 
					                                                OpStore %215 %356 
					                                 f32_4 %357 = OpLoad %56 
					                                 f32_3 %358 = OpVectorShuffle %357 %357 0 1 2 
					                                   f32 %359 = OpLoad %215 
					                                 f32_3 %360 = OpCompositeConstruct %359 %359 %359 
					                                 f32_3 %361 = OpFDiv %358 %360 
					                                 f32_4 %362 = OpLoad %46 
					                                 f32_4 %363 = OpVectorShuffle %362 %361 4 5 6 3 
					                                                OpStore %46 %363 
					                          Private f32* %364 = OpAccessChain %56 %27 
					                                   f32 %365 = OpLoad %364 
					                                   f32 %367 = OpFMul %365 %366 
					                                                OpStore %215 %367 
					                                   f32 %368 = OpLoad %215 
					                                   f32 %369 = OpExtInst %1 37 %368 %47 
					                                                OpStore %215 %369 
					                                 f32_3 %370 = OpLoad %9 
					                                 f32_3 %371 = OpFNegate %370 
					                                 f32_4 %372 = OpLoad %46 
					                                 f32_3 %373 = OpVectorShuffle %372 %372 0 1 2 
					                                 f32_3 %374 = OpFAdd %371 %373 
					                                 f32_4 %375 = OpLoad %46 
					                                 f32_4 %376 = OpVectorShuffle %375 %374 4 5 6 3 
					                                                OpStore %46 %376 
					                                   f32 %379 = OpLoad %215 
					                                 f32_3 %380 = OpCompositeConstruct %379 %379 %379 
					                                 f32_4 %381 = OpLoad %46 
					                                 f32_3 %382 = OpVectorShuffle %381 %381 0 1 2 
					                                 f32_3 %383 = OpFMul %380 %382 
					                                 f32_3 %384 = OpLoad %9 
					                                 f32_3 %385 = OpFAdd %383 %384 
					                                 f32_4 %386 = OpLoad %378 
					                                 f32_4 %387 = OpVectorShuffle %386 %385 4 5 6 3 
					                                                OpStore %378 %387 
					                                   f32 %388 = OpLoad %215 
					                           Output f32* %390 = OpAccessChain %378 %27 
					                                                OpStore %390 %388 
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
					vec2 ImmCB_0_0_0[43];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
						ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
						ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
						ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
						ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
						ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
						ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
						ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
						ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
						ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
						ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
						ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
						ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
						ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
						ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
						ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
						ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
						ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
						ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
						ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
						ImmCB_0_0_0[22] = vec2(1.0, 0.0);
						ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
						ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
						ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
						ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
						ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
						ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
						ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
						ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
						ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
						ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
						ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
						ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
						ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
						ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
						ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.0730602965;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
			Name "Bokeh Filter (very large)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1107324
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[71];
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _MaxCoC;
					uniform 	float _RcpAspect;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
						ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
						ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
						ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
						ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
						ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
						ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
						ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
						ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
						ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
						ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
						ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
						ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
						ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
						ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
						ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
						ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
						ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
						ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
						ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
						ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
						ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
						ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
						ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
						ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
						ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
						ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
						ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
						ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
						ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
						ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
						ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
						ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
						ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
						ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
						ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
						ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
						ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
						ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
						ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
						ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
						ImmCB_0_0_0[43] = vec2(1.0, 0.0);
						ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
						ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
						ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
						ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
						ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
						ImmCB_0_0_0[50] = vec2(0.0, 1.0);
						ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
						ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
						ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
						ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
						ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
						ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
						ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
						ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
						ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
						ImmCB_0_0_0[64] = vec2(0.0, -1.0);
						ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
						ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
						ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
						ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
						ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.0442477837;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
					; Bound: 459
					; Schema: 0
					                                                OpCapability Shader 
					                                         %1 = OpExtInstImport "GLSL.std.450" 
					                                                OpMemoryModel Logical GLSL450 
					                                                OpEntryPoint Fragment %4 "main" %22 %297 %443 
					                                                OpExecutionMode %4 OriginUpperLeft 
					                                                OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                OpDecorate %12 DescriptorSet 12 
					                                                OpDecorate %12 Binding 12 
					                                                OpDecorate %16 DescriptorSet 16 
					                                                OpDecorate %16 Binding 16 
					                                                OpDecorate vs_TEXCOORD1 Location 22 
					                                                OpMemberDecorate %33 0 Offset 33 
					                                                OpMemberDecorate %33 1 Offset 33 
					                                                OpMemberDecorate %33 2 Offset 33 
					                                                OpMemberDecorate %33 3 Offset 33 
					                                                OpDecorate %33 Block 
					                                                OpDecorate %35 DescriptorSet 35 
					                                                OpDecorate %35 Binding 35 
					                                                OpDecorate vs_TEXCOORD0 Location 297 
					                                                OpDecorate %443 Location 443 
					                                         %2 = OpTypeVoid 
					                                         %3 = OpTypeFunction %2 
					                                         %6 = OpTypeFloat 32 
					                                         %7 = OpTypeVector %6 3 
					                                         %8 = OpTypePointer Private %7 
					                          Private f32_3* %9 = OpVariable Private 
					                                        %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                        %11 = OpTypePointer UniformConstant %10 
					   UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                        %14 = OpTypeSampler 
					                                        %15 = OpTypePointer UniformConstant %14 
					               UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                        %18 = OpTypeSampledImage %10 
					                                        %20 = OpTypeVector %6 2 
					                                        %21 = OpTypePointer Input %20 
					                  Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                        %24 = OpTypeVector %6 4 
					                                        %26 = OpTypeInt 32 0 
					                                    u32 %27 = OpConstant 3 
					                                    u32 %29 = OpConstant 0 
					                                        %30 = OpTypePointer Private %6 
					                           Private f32* %32 = OpVariable Private 
					                                        %33 = OpTypeStruct %6 %24 %6 %6 
					                                        %34 = OpTypePointer Uniform %33 
					Uniform struct {f32; f32_4; f32; f32;}* %35 = OpVariable Uniform 
					                                        %36 = OpTypeInt 32 1 
					                                    i32 %37 = OpConstant 1 
					                                    u32 %38 = OpConstant 1 
					                                        %39 = OpTypePointer Uniform %6 
					                                        %45 = OpTypePointer Private %24 
					                         Private f32_4* %46 = OpVariable Private 
					                                    f32 %47 = OpConstant 3,674022E-40 
					                         Private f32_4* %49 = OpVariable Private 
					                                    f32 %50 = OpConstant 3,674022E-40 
					                                    u32 %53 = OpConstant 2 
					                         Private f32_4* %56 = OpVariable Private 
					                                        %61 = OpTypePointer Function %36 
					                                    i32 %63 = OpConstant 0 
					                                    i32 %70 = OpConstant 71 
					                                        %71 = OpTypeBool 
					                         Private f32_4* %73 = OpVariable Private 
					                                    i32 %74 = OpConstant 2 
					                                        %83 = OpTypeVector %26 4 
					                                    u32 %84 = OpConstant 71 
					                                        %85 = OpTypeArray %83 %84 
					                                  u32_4 %86 = OpConstantComposite %29 %29 %29 %29 
					                                    u32 %87 = OpConstant 1049443788 
					                                  u32_4 %88 = OpConstantComposite %87 %29 %29 %29 
					                                    u32 %89 = OpConstant 1043341321 
					                                    u32 %90 = OpConstant 1046272668 
					                                  u32_4 %91 = OpConstantComposite %89 %90 %29 %29 
					                                    u32 %92 = OpConstant 3178983152 
					                                    u32 %93 = OpConstant 1049211711 
					                                  u32_4 %94 = OpConstantComposite %92 %93 %29 %29 
					                                    u32 %95 = OpConstant 3195961881 
					                                    u32 %96 = OpConstant 1039474978 
					                                  u32_4 %97 = OpConstantComposite %95 %96 %29 %29 
					                                    u32 %98 = OpConstant 3186958623 
					                                  u32_4 %99 = OpConstantComposite %95 %98 %29 %29 
					                                   u32 %100 = OpConstant 3178983122 
					                                   u32 %101 = OpConstant 3196695360 
					                                 u32_4 %102 = OpConstantComposite %100 %101 %29 %29 
					                                   u32 %103 = OpConstant 1043341319 
					                                   u32 %104 = OpConstant 3193756318 
					                                 u32_4 %105 = OpConstantComposite %103 %104 %29 %29 
					                                   u32 %106 = OpConstant 1057253870 
					                                 u32_4 %107 = OpConstantComposite %106 %29 %29 %29 
					                                   u32 %108 = OpConstant 1055824373 
					                                   u32 %109 = OpConstant 1046859531 
					                                 u32_4 %110 = OpConstantComposite %108 %109 %29 %29 
					                                   u32 %111 = OpConstant 1051008519 
					                                   u32 %112 = OpConstant 1053756656 
					                                 u32_4 %113 = OpConstantComposite %111 %112 %29 %29 
					                                   u32 %114 = OpConstant 1038858241 
					                                   u32 %115 = OpConstant 1057036298 
					                                 u32_4 %116 = OpConstantComposite %114 %115 %29 %29 
					                                   u32 %117 = OpConstant 3186341887 
					                                 u32_4 %118 = OpConstantComposite %117 %115 %29 %29 
					                                   u32 %119 = OpConstant 3198492170 
					                                   u32 %120 = OpConstant 1053756654 
					                                 u32_4 %121 = OpConstantComposite %119 %120 %29 %29 
					                                   u32 %122 = OpConstant 3203308021 
					                                   u32 %123 = OpConstant 1046859533 
					                                 u32_4 %124 = OpConstantComposite %122 %123 %29 %29 
					                                   u32 %125 = OpConstant 3204737518 
					                                 u32_4 %126 = OpConstantComposite %125 %29 %29 %29 
					                                   u32 %127 = OpConstant 3194343179 
					                                 u32_4 %128 = OpConstantComposite %122 %127 %29 %29 
					                                   u32 %129 = OpConstant 3198492164 
					                                   u32 %130 = OpConstant 3201240306 
					                                 u32_4 %131 = OpConstantComposite %129 %130 %29 %29 
					                                   u32 %132 = OpConstant 3186341859 
					                                   u32 %133 = OpConstant 3204519947 
					                                 u32_4 %134 = OpConstantComposite %132 %133 %29 %29 
					                                   u32 %135 = OpConstant 1038858277 
					                                   u32 %136 = OpConstant 3204519945 
					                                 u32_4 %137 = OpConstantComposite %135 %136 %29 %29 
					                                   u32 %138 = OpConstant 1051008517 
					                                 u32_4 %139 = OpConstantComposite %138 %130 %29 %29 
					                                 u32_4 %140 = OpConstantComposite %108 %127 %29 %29 
					                                   u32 %141 = OpConstant 1061303543 
					                                 u32_4 %142 = OpConstantComposite %141 %29 %29 %29 
					                                   u32 %143 = OpConstant 1060738094 
					                                   u32 %144 = OpConstant 1046804821 
					                                 u32_4 %145 = OpConstantComposite %143 %144 %29 %29 
					                                   u32 %146 = OpConstant 1059091989 
					                                   u32 %147 = OpConstant 1054526754 
					                                 u32_4 %148 = OpConstantComposite %146 %147 %29 %29 
					                                   u32 %149 = OpConstant 1056058378 
					                                   u32 %150 = OpConstant 1058526794 
					                                 u32_4 %151 = OpConstantComposite %149 %150 %29 %29 
					                                   u32 %152 = OpConstant 1049487178 
					                                   u32 %153 = OpConstant 1060423736 
					                                 u32_4 %154 = OpConstantComposite %152 %153 %29 %29 
					                                   u32 %155 = OpConstant 1030239637 
					                                   u32 %156 = OpConstant 1061267955 
					                                 u32_4 %157 = OpConstantComposite %155 %156 %29 %29 
					                                   u32 %158 = OpConstant 3190611012 
					                                   u32 %159 = OpConstant 1060984437 
					                                 u32_4 %160 = OpConstantComposite %158 %159 %29 %29 
					                                   u32 %161 = OpConstant 3200398585 
					                                   u32 %162 = OpConstant 1059598375 
					                                 u32_4 %163 = OpConstantComposite %161 %162 %29 %29 
					                                   u32 %164 = OpConstant 3205389598 
					                                   u32 %165 = OpConstant 1057232927 
					                                 u32_4 %166 = OpConstantComposite %164 %165 %29 %29 
					                                   u32 %167 = OpConstant 3207526768 
					                                   u32 %168 = OpConstant 1051231942 
					                                 u32_4 %169 = OpConstantComposite %167 %168 %29 %29 
					                                   u32 %170 = OpConstant 3208645035 
					                                   u32 %171 = OpConstant 1038585692 
					                                 u32_4 %172 = OpConstantComposite %170 %171 %29 %29 
					                                   u32 %173 = OpConstant 3186069381 
					                                 u32_4 %174 = OpConstantComposite %170 %173 %29 %29 
					                                   u32 %175 = OpConstant 3198715588 
					                                 u32_4 %176 = OpConstantComposite %167 %175 %29 %29 
					                                   u32 %177 = OpConstant 3205389597 
					                                   u32 %178 = OpConstant 3204716577 
					                                 u32_4 %179 = OpConstantComposite %177 %178 %29 %29 
					                                   u32 %180 = OpConstant 3200398581 
					                                   u32 %181 = OpConstant 3207082024 
					                                 u32_4 %182 = OpConstantComposite %180 %181 %29 %29 
					                                   u32 %183 = OpConstant 3190611015 
					                                   u32 %184 = OpConstant 3208468085 
					                                 u32_4 %185 = OpConstantComposite %183 %184 %29 %29 
					                                   u32 %186 = OpConstant 1030239696 
					                                   u32 %187 = OpConstant 3208751602 
					                                 u32_4 %188 = OpConstantComposite %186 %187 %29 %29 
					                                   u32 %189 = OpConstant 1049487191 
					                                   u32 %190 = OpConstant 3207907381 
					                                 u32_4 %191 = OpConstantComposite %189 %190 %29 %29 
					                                   u32 %192 = OpConstant 1056058375 
					                                   u32 %193 = OpConstant 3206010444 
					                                 u32_4 %194 = OpConstantComposite %192 %193 %29 %29 
					                                   u32 %195 = OpConstant 1059091990 
					                                   u32 %196 = OpConstant 3202010399 
					                                 u32_4 %197 = OpConstantComposite %195 %196 %29 %29 
					                                   u32 %198 = OpConstant 1060738095 
					                                   u32 %199 = OpConstant 3194288451 
					                                 u32_4 %200 = OpConstantComposite %198 %199 %29 %29 
					                                   u32 %201 = OpConstant 1065353216 
					                                 u32_4 %202 = OpConstantComposite %201 %29 %29 %29 
					                                   u32 %203 = OpConstant 1064932576 
					                                   u32 %204 = OpConstant 1046731911 
					                                 u32_4 %205 = OpConstantComposite %203 %204 %29 %29 
					                                   u32 %206 = OpConstant 1063691749 
					                                   u32 %207 = OpConstant 1054746115 
					                                 u32_4 %208 = OpConstantComposite %206 %207 %29 %29 
					                                   u32 %209 = OpConstant 1061692956 
					                                   u32 %210 = OpConstant 1059036423 
					                                 u32_4 %211 = OpConstantComposite %209 %210 %29 %29 
					                                 u32_4 %212 = OpConstantComposite %210 %209 %29 %29 
					                                   u32 %213 = OpConstant 1054746111 
					                                   u32 %214 = OpConstant 1063691750 
					                                 u32_4 %215 = OpConstantComposite %213 %214 %29 %29 
					                                   u32 %216 = OpConstant 1046731914 
					                                 u32_4 %217 = OpConstantComposite %216 %203 %29 %29 
					                                 u32_4 %218 = OpConstantComposite %29 %201 %29 %29 
					                                   u32 %219 = OpConstant 3194215560 
					                                 u32_4 %220 = OpConstantComposite %219 %203 %29 %29 
					                                   u32 %221 = OpConstant 3202229766 
					                                 u32_4 %222 = OpConstantComposite %221 %206 %29 %29 
					                                   u32 %223 = OpConstant 3206520074 
					                                   u32 %224 = OpConstant 1061692954 
					                                 u32_4 %225 = OpConstantComposite %223 %224 %29 %29 
					                                   u32 %226 = OpConstant 3209176607 
					                                   u32 %227 = OpConstant 1059036419 
					                                 u32_4 %228 = OpConstantComposite %226 %227 %29 %29 
					                                   u32 %229 = OpConstant 3211175397 
					                                   u32 %230 = OpConstant 1054746117 
					                                 u32_4 %231 = OpConstantComposite %229 %230 %29 %29 
					                                   u32 %232 = OpConstant 3212416224 
					                                 u32_4 %233 = OpConstantComposite %232 %204 %29 %29 
					                                   u32 %234 = OpConstant 3212836864 
					                                 u32_4 %235 = OpConstantComposite %234 %29 %29 %29 
					                                   u32 %236 = OpConstant 3194215555 
					                                 u32_4 %237 = OpConstantComposite %232 %236 %29 %29 
					                                   u32 %238 = OpConstant 3202229763 
					                                 u32_4 %239 = OpConstantComposite %229 %238 %29 %29 
					                                   u32 %240 = OpConstant 3209176602 
					                                   u32 %241 = OpConstant 3206520073 
					                                 u32_4 %242 = OpConstantComposite %240 %241 %29 %29 
					                                   u32 %243 = OpConstant 3206520068 
					                                   u32 %244 = OpConstant 3209176606 
					                                 u32_4 %245 = OpConstantComposite %243 %244 %29 %29 
					                                   u32 %246 = OpConstant 3202229753 
					                                   u32 %247 = OpConstant 3211175400 
					                                 u32_4 %248 = OpConstantComposite %246 %247 %29 %29 
					                                   u32 %249 = OpConstant 3194215533 
					                                   u32 %250 = OpConstant 3212416226 
					                                 u32_4 %251 = OpConstantComposite %249 %250 %29 %29 
					                                 u32_4 %252 = OpConstantComposite %29 %234 %29 %29 
					                                   u32 %253 = OpConstant 1046731949 
					                                   u32 %254 = OpConstant 3212416222 
					                                 u32_4 %255 = OpConstantComposite %253 %254 %29 %29 
					                                   u32 %256 = OpConstant 1054746106 
					                                   u32 %257 = OpConstant 3211175399 
					                                 u32_4 %258 = OpConstantComposite %256 %257 %29 %29 
					                                   u32 %259 = OpConstant 1059036421 
					                                 u32_4 %260 = OpConstantComposite %259 %244 %29 %29 
					                                   u32 %261 = OpConstant 1061692955 
					                                   u32 %262 = OpConstant 3206520072 
					                                 u32_4 %263 = OpConstantComposite %261 %262 %29 %29 
					                                 u32_4 %264 = OpConstantComposite %206 %238 %29 %29 
					                                   u32 %265 = OpConstant 3194215554 
					                                 u32_4 %266 = OpConstantComposite %203 %265 %29 %29 
					                             u32_4[71] %267 = OpConstantComposite %86 %88 %91 %94 %97 %99 %102 %105 %107 %110 %113 %116 %118 %121 %124 %126 %128 %131 %134 %137 %139 %140 %142 %145 %148 %151 %154 %157 %160 %163 %166 %169 %172 %174 %176 %179 %182 %185 %188 %191 %194 %197 %200 %202 %205 %208 %211 %212 %215 %217 %218 %220 %222 %225 %228 %231 %233 %235 %237 %239 %242 %245 %248 %251 %252 %255 %258 %260 %263 %264 %266 
					                                       %269 = OpTypeVector %26 2 
					                                       %270 = OpTypePointer Function %85 
					                                       %272 = OpTypePointer Function %83 
					                          Private f32* %280 = OpVariable Private 
					                                   i32 %290 = OpConstant 3 
					                  Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                          Private f32* %323 = OpVariable Private 
					                                   f32 %337 = OpConstant 3,674022E-40 
					                                       %362 = OpTypePointer Private %71 
					                         Private bool* %363 = OpVariable Private 
					                          Private f32* %370 = OpVariable Private 
					                         Private bool* %394 = OpVariable Private 
					                         Private bool* %412 = OpVariable Private 
					                                   f32 %431 = OpConstant 3,674022E-40 
					                                       %442 = OpTypePointer Output %24 
					                         Output f32_4* %443 = OpVariable Output 
					                                       %454 = OpTypePointer Output %6 
					                                       %457 = OpTypePointer Private %36 
					                          Private i32* %458 = OpVariable Private 
					                                    void %4 = OpFunction None %3 
					                                         %5 = OpLabel 
					                          Function i32* %62 = OpVariable Function 
					                   Function u32_4[71]* %271 = OpVariable Function 
					                    read_only Texture2D %13 = OpLoad %12 
					                                sampler %17 = OpLoad %16 
					             read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                  f32_2 %23 = OpLoad vs_TEXCOORD1 
					                                  f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                                    f32 %28 = OpCompositeExtract %25 3 
					                           Private f32* %31 = OpAccessChain %9 %29 
					                                                OpStore %31 %28 
					                           Uniform f32* %40 = OpAccessChain %35 %37 %38 
					                                    f32 %41 = OpLoad %40 
					                           Uniform f32* %42 = OpAccessChain %35 %37 %38 
					                                    f32 %43 = OpLoad %42 
					                                    f32 %44 = OpFAdd %41 %43 
					                                                OpStore %32 %44 
					                           Private f32* %48 = OpAccessChain %46 %27 
					                                                OpStore %48 %47 
					                           Private f32* %51 = OpAccessChain %49 %29 
					                                                OpStore %51 %50 
					                           Private f32* %52 = OpAccessChain %49 %38 
					                                                OpStore %52 %50 
					                           Private f32* %54 = OpAccessChain %49 %53 
					                                                OpStore %54 %50 
					                           Private f32* %55 = OpAccessChain %49 %27 
					                                                OpStore %55 %50 
					                           Private f32* %57 = OpAccessChain %56 %29 
					                                                OpStore %57 %50 
					                           Private f32* %58 = OpAccessChain %56 %38 
					                                                OpStore %58 %50 
					                           Private f32* %59 = OpAccessChain %56 %53 
					                                                OpStore %59 %50 
					                           Private f32* %60 = OpAccessChain %56 %27 
					                                                OpStore %60 %50 
					                                                OpStore %62 %63 
					                                                OpBranch %64 
					                                        %64 = OpLabel 
					                                                OpLoopMerge %66 %67 None 
					                                                OpBranch %68 
					                                        %68 = OpLabel 
					                                    i32 %69 = OpLoad %62 
					                                   bool %72 = OpSLessThan %69 %70 
					                                                OpBranchConditional %72 %65 %66 
					                                        %65 = OpLabel 
					                           Uniform f32* %75 = OpAccessChain %35 %74 
					                                    f32 %76 = OpLoad %75 
					                           Uniform f32* %77 = OpAccessChain %35 %74 
					                                    f32 %78 = OpLoad %77 
					                                  f32_2 %79 = OpCompositeConstruct %76 %78 
					                                    f32 %80 = OpCompositeExtract %79 0 
					                                    f32 %81 = OpCompositeExtract %79 1 
					                                  f32_2 %82 = OpCompositeConstruct %80 %81 
					                                   i32 %268 = OpLoad %62 
					                                                OpStore %271 %267 
					                       Function u32_4* %273 = OpAccessChain %271 %268 
					                                 u32_4 %274 = OpLoad %273 
					                                 u32_2 %275 = OpVectorShuffle %274 %274 0 1 
					                                 f32_2 %276 = OpBitcast %275 
					                                 f32_2 %277 = OpFMul %82 %276 
					                                 f32_4 %278 = OpLoad %73 
					                                 f32_4 %279 = OpVectorShuffle %278 %277 0 4 5 3 
					                                                OpStore %73 %279 
					                                 f32_4 %281 = OpLoad %73 
					                                 f32_2 %282 = OpVectorShuffle %281 %281 1 2 
					                                 f32_4 %283 = OpLoad %73 
					                                 f32_2 %284 = OpVectorShuffle %283 %283 1 2 
					                                   f32 %285 = OpDot %282 %284 
					                                                OpStore %280 %285 
					                                   f32 %286 = OpLoad %280 
					                                   f32 %287 = OpExtInst %1 31 %286 
					                                                OpStore %280 %287 
					                          Private f32* %288 = OpAccessChain %73 %38 
					                                   f32 %289 = OpLoad %288 
					                          Uniform f32* %291 = OpAccessChain %35 %290 
					                                   f32 %292 = OpLoad %291 
					                                   f32 %293 = OpFMul %289 %292 
					                          Private f32* %294 = OpAccessChain %73 %29 
					                                                OpStore %294 %293 
					                                 f32_4 %295 = OpLoad %73 
					                                 f32_2 %296 = OpVectorShuffle %295 %295 0 2 
					                                 f32_2 %298 = OpLoad vs_TEXCOORD0 
					                                 f32_2 %299 = OpFAdd %296 %298 
					                                 f32_4 %300 = OpLoad %73 
					                                 f32_4 %301 = OpVectorShuffle %300 %299 4 5 2 3 
					                                                OpStore %73 %301 
					                                 f32_4 %302 = OpLoad %73 
					                                 f32_2 %303 = OpVectorShuffle %302 %302 0 1 
					                                 f32_2 %304 = OpCompositeConstruct %50 %50 
					                                 f32_2 %305 = OpCompositeConstruct %47 %47 
					                                 f32_2 %306 = OpExtInst %1 43 %303 %304 %305 
					                                 f32_4 %307 = OpLoad %73 
					                                 f32_4 %308 = OpVectorShuffle %307 %306 4 5 2 3 
					                                                OpStore %73 %308 
					                                 f32_4 %309 = OpLoad %73 
					                                 f32_2 %310 = OpVectorShuffle %309 %309 0 1 
					                          Uniform f32* %311 = OpAccessChain %35 %63 
					                                   f32 %312 = OpLoad %311 
					                                 f32_2 %313 = OpCompositeConstruct %312 %312 
					                                 f32_2 %314 = OpFMul %310 %313 
					                                 f32_4 %315 = OpLoad %73 
					                                 f32_4 %316 = OpVectorShuffle %315 %314 4 5 2 3 
					                                                OpStore %73 %316 
					                   read_only Texture2D %317 = OpLoad %12 
					                               sampler %318 = OpLoad %16 
					            read_only Texture2DSampled %319 = OpSampledImage %317 %318 
					                                 f32_4 %320 = OpLoad %73 
					                                 f32_2 %321 = OpVectorShuffle %320 %320 0 1 
					                                 f32_4 %322 = OpImageSampleImplicitLod %319 %321 
					                                                OpStore %73 %322 
					                          Private f32* %324 = OpAccessChain %9 %29 
					                                   f32 %325 = OpLoad %324 
					                          Private f32* %326 = OpAccessChain %73 %27 
					                                   f32 %327 = OpLoad %326 
					                                   f32 %328 = OpExtInst %1 37 %325 %327 
					                                                OpStore %323 %328 
					                                   f32 %329 = OpLoad %323 
					                                   f32 %330 = OpExtInst %1 40 %329 %50 
					                                                OpStore %323 %330 
					                                   f32 %331 = OpLoad %280 
					                                   f32 %332 = OpFNegate %331 
					                                   f32 %333 = OpLoad %323 
					                                   f32 %334 = OpFAdd %332 %333 
					                                                OpStore %323 %334 
					                          Uniform f32* %335 = OpAccessChain %35 %37 %38 
					                                   f32 %336 = OpLoad %335 
					                                   f32 %338 = OpFMul %336 %337 
					                                   f32 %339 = OpLoad %323 
					                                   f32 %340 = OpFAdd %338 %339 
					                                                OpStore %323 %340 
					                                   f32 %341 = OpLoad %323 
					                                   f32 %342 = OpLoad %32 
					                                   f32 %343 = OpFDiv %341 %342 
					                                                OpStore %323 %343 
					                                   f32 %344 = OpLoad %323 
					                                   f32 %345 = OpExtInst %1 43 %344 %50 %47 
					                                                OpStore %323 %345 
					                                   f32 %346 = OpLoad %280 
					                                   f32 %347 = OpFNegate %346 
					                          Private f32* %348 = OpAccessChain %73 %27 
					                                   f32 %349 = OpLoad %348 
					                                   f32 %350 = OpFNegate %349 
					                                   f32 %351 = OpFAdd %347 %350 
					                                                OpStore %280 %351 
					                          Uniform f32* %352 = OpAccessChain %35 %37 %38 
					                                   f32 %353 = OpLoad %352 
					                                   f32 %354 = OpFMul %353 %337 
					                                   f32 %355 = OpLoad %280 
					                                   f32 %356 = OpFAdd %354 %355 
					                                                OpStore %280 %356 
					                                   f32 %357 = OpLoad %280 
					                                   f32 %358 = OpLoad %32 
					                                   f32 %359 = OpFDiv %357 %358 
					                                                OpStore %280 %359 
					                                   f32 %360 = OpLoad %280 
					                                   f32 %361 = OpExtInst %1 43 %360 %50 %47 
					                                                OpStore %280 %361 
					                          Private f32* %364 = OpAccessChain %73 %27 
					                                   f32 %365 = OpLoad %364 
					                                   f32 %366 = OpFNegate %365 
					                          Uniform f32* %367 = OpAccessChain %35 %37 %38 
					                                   f32 %368 = OpLoad %367 
					                                  bool %369 = OpFOrdGreaterThanEqual %366 %368 
					                                                OpStore %363 %369 
					                                  bool %371 = OpLoad %363 
					                                   f32 %372 = OpSelect %371 %47 %50 
					                                                OpStore %370 %372 
					                                   f32 %373 = OpLoad %280 
					                                   f32 %374 = OpLoad %370 
					                                   f32 %375 = OpFMul %373 %374 
					                                                OpStore %280 %375 
					                                 f32_4 %376 = OpLoad %73 
					                                 f32_3 %377 = OpVectorShuffle %376 %376 0 1 2 
					                                 f32_4 %378 = OpLoad %46 
					                                 f32_4 %379 = OpVectorShuffle %378 %377 4 5 6 3 
					                                                OpStore %46 %379 
					                                 f32_4 %380 = OpLoad %46 
					                                   f32 %381 = OpLoad %323 
					                                 f32_4 %382 = OpCompositeConstruct %381 %381 %381 %381 
					                                 f32_4 %383 = OpFMul %380 %382 
					                                 f32_4 %384 = OpLoad %49 
					                                 f32_4 %385 = OpFAdd %383 %384 
					                                                OpStore %49 %385 
					                                 f32_4 %386 = OpLoad %46 
					                                   f32 %387 = OpLoad %280 
					                                 f32_4 %388 = OpCompositeConstruct %387 %387 %387 %387 
					                                 f32_4 %389 = OpFMul %386 %388 
					                                 f32_4 %390 = OpLoad %56 
					                                 f32_4 %391 = OpFAdd %389 %390 
					                                                OpStore %56 %391 
					                                                OpBranch %67 
					                                        %67 = OpLabel 
					                                   i32 %392 = OpLoad %62 
					                                   i32 %393 = OpIAdd %392 %37 
					                                                OpStore %62 %393 
					                                                OpBranch %64 
					                                        %66 = OpLabel 
					                          Private f32* %395 = OpAccessChain %49 %27 
					                                   f32 %396 = OpLoad %395 
					                                  bool %397 = OpFOrdEqual %396 %50 
					                                                OpStore %394 %397 
					                                  bool %398 = OpLoad %394 
					                                   f32 %399 = OpSelect %398 %47 %50 
					                          Private f32* %400 = OpAccessChain %9 %29 
					                                                OpStore %400 %399 
					                          Private f32* %401 = OpAccessChain %9 %29 
					                                   f32 %402 = OpLoad %401 
					                          Private f32* %403 = OpAccessChain %49 %27 
					                                   f32 %404 = OpLoad %403 
					                                   f32 %405 = OpFAdd %402 %404 
					                          Private f32* %406 = OpAccessChain %9 %29 
					                                                OpStore %406 %405 
					                                 f32_4 %407 = OpLoad %49 
					                                 f32_3 %408 = OpVectorShuffle %407 %407 0 1 2 
					                                 f32_3 %409 = OpLoad %9 
					                                 f32_3 %410 = OpVectorShuffle %409 %409 0 0 0 
					                                 f32_3 %411 = OpFDiv %408 %410 
					                                                OpStore %9 %411 
					                          Private f32* %413 = OpAccessChain %56 %27 
					                                   f32 %414 = OpLoad %413 
					                                  bool %415 = OpFOrdEqual %414 %50 
					                                                OpStore %412 %415 
					                                  bool %416 = OpLoad %412 
					                                   f32 %417 = OpSelect %416 %47 %50 
					                                                OpStore %280 %417 
					                                   f32 %418 = OpLoad %280 
					                          Private f32* %419 = OpAccessChain %56 %27 
					                                   f32 %420 = OpLoad %419 
					                                   f32 %421 = OpFAdd %418 %420 
					                                                OpStore %280 %421 
					                                 f32_4 %422 = OpLoad %56 
					                                 f32_3 %423 = OpVectorShuffle %422 %422 0 1 2 
					                                   f32 %424 = OpLoad %280 
					                                 f32_3 %425 = OpCompositeConstruct %424 %424 %424 
					                                 f32_3 %426 = OpFDiv %423 %425 
					                                 f32_4 %427 = OpLoad %46 
					                                 f32_4 %428 = OpVectorShuffle %427 %426 4 5 6 3 
					                                                OpStore %46 %428 
					                          Private f32* %429 = OpAccessChain %56 %27 
					                                   f32 %430 = OpLoad %429 
					                                   f32 %432 = OpFMul %430 %431 
					                                                OpStore %280 %432 
					                                   f32 %433 = OpLoad %280 
					                                   f32 %434 = OpExtInst %1 37 %433 %47 
					                                                OpStore %280 %434 
					                                 f32_3 %435 = OpLoad %9 
					                                 f32_3 %436 = OpFNegate %435 
					                                 f32_4 %437 = OpLoad %46 
					                                 f32_3 %438 = OpVectorShuffle %437 %437 0 1 2 
					                                 f32_3 %439 = OpFAdd %436 %438 
					                                 f32_4 %440 = OpLoad %46 
					                                 f32_4 %441 = OpVectorShuffle %440 %439 4 5 6 3 
					                                                OpStore %46 %441 
					                                   f32 %444 = OpLoad %280 
					                                 f32_3 %445 = OpCompositeConstruct %444 %444 %444 
					                                 f32_4 %446 = OpLoad %46 
					                                 f32_3 %447 = OpVectorShuffle %446 %446 0 1 2 
					                                 f32_3 %448 = OpFMul %445 %447 
					                                 f32_3 %449 = OpLoad %9 
					                                 f32_3 %450 = OpFAdd %448 %449 
					                                 f32_4 %451 = OpLoad %443 
					                                 f32_4 %452 = OpVectorShuffle %451 %450 4 5 6 3 
					                                                OpStore %443 %452 
					                                   f32 %453 = OpLoad %280 
					                           Output f32* %455 = OpAccessChain %443 %27 
					                                                OpStore %455 %453 
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
					vec2 ImmCB_0_0_0[71];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
						ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
						ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
						ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
						ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
						ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
						ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
						ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
						ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
						ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
						ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
						ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
						ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
						ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
						ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
						ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
						ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
						ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
						ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
						ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
						ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
						ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
						ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
						ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
						ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
						ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
						ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
						ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
						ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
						ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
						ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
						ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
						ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
						ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
						ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
						ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
						ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
						ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
						ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
						ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
						ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
						ImmCB_0_0_0[43] = vec2(1.0, 0.0);
						ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
						ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
						ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
						ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
						ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
						ImmCB_0_0_0[50] = vec2(0.0, 1.0);
						ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
						ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
						ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
						ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
						ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
						ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
						ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
						ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
						ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
						ImmCB_0_0_0[64] = vec2(0.0, -1.0);
						ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
						ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
						ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
						ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
						ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.0442477837;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
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
			Name "Postfilter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1169019
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
						vec4 unused_0_2[5];
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
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat0 = u_xlat0 + u_xlat2;
					    u_xlat0 = u_xlat1 + u_xlat0;
					    SV_Target0 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25);
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
					; Bound: 109
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %26 %103 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %10 0 Offset 10 
					                                             OpMemberDecorate %10 1 Offset 10 
					                                             OpDecorate %10 Block 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate vs_TEXCOORD0 Location 26 
					                                             OpDecorate %46 DescriptorSet 46 
					                                             OpDecorate %46 Binding 46 
					                                             OpDecorate %50 DescriptorSet 50 
					                                             OpDecorate %50 Binding 50 
					                                             OpDecorate %103 Location 103 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeStruct %6 %7 
					                                     %11 = OpTypePointer Uniform %10 
					       Uniform struct {f32; f32_4;}* %12 = OpVariable Uniform 
					                                     %13 = OpTypeInt 32 1 
					                                 i32 %14 = OpConstant 1 
					                                     %15 = OpTypePointer Uniform %7 
					                                 f32 %20 = OpConstant 3,674022E-40 
					                                 f32 %21 = OpConstant 3,674022E-40 
					                               f32_4 %22 = OpConstantComposite %20 %20 %21 %20 
					                                     %24 = OpTypeVector %6 2 
					                                     %25 = OpTypePointer Input %24 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 f32 %31 = OpConstant 3,674022E-40 
					                                 f32 %32 = OpConstant 3,674022E-40 
					                                 i32 %37 = OpConstant 0 
					                                     %38 = OpTypePointer Uniform %6 
					                      Private f32_4* %43 = OpVariable Private 
					                                     %44 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %45 = OpTypePointer UniformConstant %44 
					UniformConstant read_only Texture2D* %46 = OpVariable UniformConstant 
					                                     %48 = OpTypeSampler 
					                                     %49 = OpTypePointer UniformConstant %48 
					            UniformConstant sampler* %50 = OpVariable UniformConstant 
					                                     %52 = OpTypeSampledImage %44 
					                               f32_4 %69 = OpConstantComposite %21 %20 %20 %20 
					                      Private f32_4* %83 = OpVariable Private 
					                                    %102 = OpTypePointer Output %7 
					                      Output f32_4* %103 = OpVariable Output 
					                                f32 %105 = OpConstant 3,674022E-40 
					                              f32_4 %106 = OpConstantComposite %105 %105 %105 %105 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                      Uniform f32_4* %16 = OpAccessChain %12 %14 
					                               f32_4 %17 = OpLoad %16 
					                               f32_4 %18 = OpVectorShuffle %17 %17 0 1 0 1 
					                               f32_4 %19 = OpFNegate %18 
					                               f32_4 %23 = OpFMul %19 %22 
					                               f32_2 %27 = OpLoad vs_TEXCOORD0 
					                               f32_4 %28 = OpVectorShuffle %27 %27 0 1 0 1 
					                               f32_4 %29 = OpFAdd %23 %28 
					                                             OpStore %9 %29 
					                               f32_4 %30 = OpLoad %9 
					                               f32_4 %33 = OpCompositeConstruct %31 %31 %31 %31 
					                               f32_4 %34 = OpCompositeConstruct %32 %32 %32 %32 
					                               f32_4 %35 = OpExtInst %1 43 %30 %33 %34 
					                                             OpStore %9 %35 
					                               f32_4 %36 = OpLoad %9 
					                        Uniform f32* %39 = OpAccessChain %12 %37 
					                                 f32 %40 = OpLoad %39 
					                               f32_4 %41 = OpCompositeConstruct %40 %40 %40 %40 
					                               f32_4 %42 = OpFMul %36 %41 
					                                             OpStore %9 %42 
					                 read_only Texture2D %47 = OpLoad %46 
					                             sampler %51 = OpLoad %50 
					          read_only Texture2DSampled %53 = OpSampledImage %47 %51 
					                               f32_4 %54 = OpLoad %9 
					                               f32_2 %55 = OpVectorShuffle %54 %54 0 1 
					                               f32_4 %56 = OpImageSampleImplicitLod %53 %55 
					                                             OpStore %43 %56 
					                 read_only Texture2D %57 = OpLoad %46 
					                             sampler %58 = OpLoad %50 
					          read_only Texture2DSampled %59 = OpSampledImage %57 %58 
					                               f32_4 %60 = OpLoad %9 
					                               f32_2 %61 = OpVectorShuffle %60 %60 2 3 
					                               f32_4 %62 = OpImageSampleImplicitLod %59 %61 
					                                             OpStore %9 %62 
					                               f32_4 %63 = OpLoad %9 
					                               f32_4 %64 = OpLoad %43 
					                               f32_4 %65 = OpFAdd %63 %64 
					                                             OpStore %9 %65 
					                      Uniform f32_4* %66 = OpAccessChain %12 %14 
					                               f32_4 %67 = OpLoad %66 
					                               f32_4 %68 = OpVectorShuffle %67 %67 0 1 0 1 
					                               f32_4 %70 = OpFMul %68 %69 
					                               f32_2 %71 = OpLoad vs_TEXCOORD0 
					                               f32_4 %72 = OpVectorShuffle %71 %71 0 1 0 1 
					                               f32_4 %73 = OpFAdd %70 %72 
					                                             OpStore %43 %73 
					                               f32_4 %74 = OpLoad %43 
					                               f32_4 %75 = OpCompositeConstruct %31 %31 %31 %31 
					                               f32_4 %76 = OpCompositeConstruct %32 %32 %32 %32 
					                               f32_4 %77 = OpExtInst %1 43 %74 %75 %76 
					                                             OpStore %43 %77 
					                               f32_4 %78 = OpLoad %43 
					                        Uniform f32* %79 = OpAccessChain %12 %37 
					                                 f32 %80 = OpLoad %79 
					                               f32_4 %81 = OpCompositeConstruct %80 %80 %80 %80 
					                               f32_4 %82 = OpFMul %78 %81 
					                                             OpStore %43 %82 
					                 read_only Texture2D %84 = OpLoad %46 
					                             sampler %85 = OpLoad %50 
					          read_only Texture2DSampled %86 = OpSampledImage %84 %85 
					                               f32_4 %87 = OpLoad %43 
					                               f32_2 %88 = OpVectorShuffle %87 %87 0 1 
					                               f32_4 %89 = OpImageSampleImplicitLod %86 %88 
					                                             OpStore %83 %89 
					                 read_only Texture2D %90 = OpLoad %46 
					                             sampler %91 = OpLoad %50 
					          read_only Texture2DSampled %92 = OpSampledImage %90 %91 
					                               f32_4 %93 = OpLoad %43 
					                               f32_2 %94 = OpVectorShuffle %93 %93 2 3 
					                               f32_4 %95 = OpImageSampleImplicitLod %92 %94 
					                                             OpStore %43 %95 
					                               f32_4 %96 = OpLoad %9 
					                               f32_4 %97 = OpLoad %83 
					                               f32_4 %98 = OpFAdd %96 %97 
					                                             OpStore %9 %98 
					                               f32_4 %99 = OpLoad %43 
					                              f32_4 %100 = OpLoad %9 
					                              f32_4 %101 = OpFAdd %99 %100 
					                                             OpStore %9 %101 
					                              f32_4 %104 = OpLoad %9 
					                              f32_4 %107 = OpFMul %104 %106 
					                                             OpStore %103 %107 
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4[3];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat0 = u_xlat0 + u_xlat2;
					    u_xlat0 = u_xlat1 + u_xlat0;
					    SV_Target0 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25);
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
			Name "Combine"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1238324
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
						vec4 unused_0_2[5];
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
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _MaxCoC;
					UNITY_LOCATION(0) uniform  sampler2D _DepthOfFieldTex;
					UNITY_LOCATION(1) uniform  sampler2D _CoCTex;
					UNITY_LOCATION(2) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = texture(_CoCTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat3 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat0.x = u_xlat0.x * _MaxCoC + (-u_xlat3);
					    u_xlat3 = float(1.0) / u_xlat3;
					    u_xlat0.x = u_xlat3 * u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6 = u_xlat0.x * u_xlat3;
					    u_xlat1 = texture(_DepthOfFieldTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat1.w;
					    u_xlat0.x = (-u_xlat6) * u_xlat1.w + u_xlat0.x;
					    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat1.w = max(u_xlat1.z, u_xlat3);
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat1 = u_xlat1 + (-u_xlat2);
					    SV_Target0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
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
					; Bound: 131
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %21 %123 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpDecorate %11 DescriptorSet 11 
					                                              OpDecorate %11 Binding 11 
					                                              OpDecorate %15 DescriptorSet 15 
					                                              OpDecorate %15 Binding 15 
					                                              OpDecorate vs_TEXCOORD1 Location 21 
					                                              OpMemberDecorate %35 0 Offset 35 
					                                              OpMemberDecorate %35 1 Offset 35 
					                                              OpDecorate %35 Block 
					                                              OpDecorate %37 DescriptorSet 37 
					                                              OpDecorate %37 Binding 37 
					                                              OpDecorate %78 DescriptorSet 78 
					                                              OpDecorate %78 Binding 78 
					                                              OpDecorate %80 DescriptorSet 80 
					                                              OpDecorate %80 Binding 80 
					                                              OpDecorate %111 DescriptorSet 111 
					                                              OpDecorate %111 Binding 111 
					                                              OpDecorate %113 DescriptorSet 113 
					                                              OpDecorate %113 Binding 113 
					                                              OpDecorate %123 Location 123 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypePointer Private %6 
					                          Private f32* %8 = OpVariable Private 
					                                       %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                      %10 = OpTypePointer UniformConstant %9 
					 UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
					                                      %13 = OpTypeSampler 
					                                      %14 = OpTypePointer UniformConstant %13 
					             UniformConstant sampler* %15 = OpVariable UniformConstant 
					                                      %17 = OpTypeSampledImage %9 
					                                      %19 = OpTypeVector %6 2 
					                                      %20 = OpTypePointer Input %19 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                      %23 = OpTypeVector %6 4 
					                                      %25 = OpTypeInt 32 0 
					                                  u32 %26 = OpConstant 0 
					                                  f32 %29 = OpConstant 3,674022E-40 
					                         Private f32* %34 = OpVariable Private 
					                                      %35 = OpTypeStruct %23 %6 
					                                      %36 = OpTypePointer Uniform %35 
					        Uniform struct {f32_4; f32;}* %37 = OpVariable Uniform 
					                                      %38 = OpTypeInt 32 1 
					                                  i32 %39 = OpConstant 0 
					                                  u32 %40 = OpConstant 1 
					                                      %41 = OpTypePointer Uniform %6 
					                                  i32 %48 = OpConstant 1 
					                                  f32 %55 = OpConstant 3,674022E-40 
					                                  f32 %62 = OpConstant 3,674022E-40 
					                                  f32 %65 = OpConstant 3,674022E-40 
					                                  f32 %67 = OpConstant 3,674022E-40 
					                         Private f32* %72 = OpVariable Private 
					                                      %76 = OpTypePointer Private %23 
					                       Private f32_4* %77 = OpVariable Private 
					 UniformConstant read_only Texture2D* %78 = OpVariable UniformConstant 
					             UniformConstant sampler* %80 = OpVariable UniformConstant 
					                                  u32 %88 = OpConstant 3 
					                                 u32 %104 = OpConstant 2 
					                      Private f32_4* %110 = OpVariable Private 
					UniformConstant read_only Texture2D* %111 = OpVariable UniformConstant 
					            UniformConstant sampler* %113 = OpVariable UniformConstant 
					                                     %122 = OpTypePointer Output %23 
					                       Output f32_4* %123 = OpVariable Output 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                  read_only Texture2D %12 = OpLoad %11 
					                              sampler %16 = OpLoad %15 
					           read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                                f32_2 %22 = OpLoad vs_TEXCOORD1 
					                                f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                  f32 %27 = OpCompositeExtract %24 0 
					                                              OpStore %8 %27 
					                                  f32 %28 = OpLoad %8 
					                                  f32 %30 = OpFAdd %28 %29 
					                                              OpStore %8 %30 
					                                  f32 %31 = OpLoad %8 
					                                  f32 %32 = OpLoad %8 
					                                  f32 %33 = OpFAdd %31 %32 
					                                              OpStore %8 %33 
					                         Uniform f32* %42 = OpAccessChain %37 %39 %40 
					                                  f32 %43 = OpLoad %42 
					                         Uniform f32* %44 = OpAccessChain %37 %39 %40 
					                                  f32 %45 = OpLoad %44 
					                                  f32 %46 = OpFAdd %43 %45 
					                                              OpStore %34 %46 
					                                  f32 %47 = OpLoad %8 
					                         Uniform f32* %49 = OpAccessChain %37 %48 
					                                  f32 %50 = OpLoad %49 
					                                  f32 %51 = OpFMul %47 %50 
					                                  f32 %52 = OpLoad %34 
					                                  f32 %53 = OpFNegate %52 
					                                  f32 %54 = OpFAdd %51 %53 
					                                              OpStore %8 %54 
					                                  f32 %56 = OpLoad %34 
					                                  f32 %57 = OpFDiv %55 %56 
					                                              OpStore %34 %57 
					                                  f32 %58 = OpLoad %34 
					                                  f32 %59 = OpLoad %8 
					                                  f32 %60 = OpFMul %58 %59 
					                                              OpStore %8 %60 
					                                  f32 %61 = OpLoad %8 
					                                  f32 %63 = OpExtInst %1 43 %61 %62 %55 
					                                              OpStore %8 %63 
					                                  f32 %64 = OpLoad %8 
					                                  f32 %66 = OpFMul %64 %65 
					                                  f32 %68 = OpFAdd %66 %67 
					                                              OpStore %34 %68 
					                                  f32 %69 = OpLoad %8 
					                                  f32 %70 = OpLoad %8 
					                                  f32 %71 = OpFMul %69 %70 
					                                              OpStore %8 %71 
					                                  f32 %73 = OpLoad %8 
					                                  f32 %74 = OpLoad %34 
					                                  f32 %75 = OpFMul %73 %74 
					                                              OpStore %72 %75 
					                  read_only Texture2D %79 = OpLoad %78 
					                              sampler %81 = OpLoad %80 
					           read_only Texture2DSampled %82 = OpSampledImage %79 %81 
					                                f32_2 %83 = OpLoad vs_TEXCOORD1 
					                                f32_4 %84 = OpImageSampleImplicitLod %82 %83 
					                                              OpStore %77 %84 
					                                  f32 %85 = OpLoad %34 
					                                  f32 %86 = OpLoad %8 
					                                  f32 %87 = OpFMul %85 %86 
					                         Private f32* %89 = OpAccessChain %77 %88 
					                                  f32 %90 = OpLoad %89 
					                                  f32 %91 = OpFAdd %87 %90 
					                                              OpStore %8 %91 
					                                  f32 %92 = OpLoad %72 
					                                  f32 %93 = OpFNegate %92 
					                         Private f32* %94 = OpAccessChain %77 %88 
					                                  f32 %95 = OpLoad %94 
					                                  f32 %96 = OpFMul %93 %95 
					                                  f32 %97 = OpLoad %8 
					                                  f32 %98 = OpFAdd %96 %97 
					                                              OpStore %8 %98 
					                         Private f32* %99 = OpAccessChain %77 %40 
					                                 f32 %100 = OpLoad %99 
					                        Private f32* %101 = OpAccessChain %77 %26 
					                                 f32 %102 = OpLoad %101 
					                                 f32 %103 = OpExtInst %1 40 %100 %102 
					                                              OpStore %34 %103 
					                        Private f32* %105 = OpAccessChain %77 %104 
					                                 f32 %106 = OpLoad %105 
					                                 f32 %107 = OpLoad %34 
					                                 f32 %108 = OpExtInst %1 40 %106 %107 
					                        Private f32* %109 = OpAccessChain %77 %88 
					                                              OpStore %109 %108 
					                 read_only Texture2D %112 = OpLoad %111 
					                             sampler %114 = OpLoad %113 
					          read_only Texture2DSampled %115 = OpSampledImage %112 %114 
					                               f32_2 %116 = OpLoad vs_TEXCOORD1 
					                               f32_4 %117 = OpImageSampleImplicitLod %115 %116 
					                                              OpStore %110 %117 
					                               f32_4 %118 = OpLoad %77 
					                               f32_4 %119 = OpLoad %110 
					                               f32_4 %120 = OpFNegate %119 
					                               f32_4 %121 = OpFAdd %118 %120 
					                                              OpStore %77 %121 
					                                 f32 %124 = OpLoad %8 
					                               f32_4 %125 = OpCompositeConstruct %124 %124 %124 %124 
					                               f32_4 %126 = OpLoad %77 
					                               f32_4 %127 = OpFMul %125 %126 
					                               f32_4 %128 = OpLoad %110 
					                               f32_4 %129 = OpFAdd %127 %128 
					                                              OpStore %123 %129 
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
						vec4 unused_0_2;
						float _MaxCoC;
						vec4 unused_0_4;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CoCTex;
					uniform  sampler2D _DepthOfFieldTex;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = texture(_CoCTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat3 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat0.x = u_xlat0.x * _MaxCoC + (-u_xlat3);
					    u_xlat3 = float(1.0) / u_xlat3;
					    u_xlat0.x = u_xlat3 * u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6 = u_xlat0.x * u_xlat3;
					    u_xlat1 = texture(_DepthOfFieldTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat1.w;
					    u_xlat0.x = (-u_xlat6) * u_xlat1.w + u_xlat0.x;
					    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat1.w = max(u_xlat1.z, u_xlat3);
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat1 = u_xlat1 + (-u_xlat2);
					    SV_Target0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
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
			Name "Debug Overlay"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1278295
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
						vec4 unused_0_2[5];
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
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Distance;
					uniform 	float _LensCoeff;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat3 = u_xlat0.x + (-_Distance);
					    u_xlat3 = u_xlat3 * _LensCoeff;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 80.0;
					    u_xlat3 = u_xlat0.x;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
					    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat9 = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat9 = u_xlat9 + 0.5;
					    u_xlat1.xyz = u_xlat0.xzz * vec3(u_xlat9) + vec3(0.0549999997, 0.0549999997, 0.0549999997);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.947867334, 0.947867334, 0.947867334);
					    u_xlat1.xyz = max(abs(u_xlat1.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.4000001, 2.4000001, 2.4000001);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat2.xyz = u_xlat0.xzz * vec3(0.0773993805, 0.0773993805, 0.0773993805);
					    u_xlatb0.xyz = greaterThanEqual(vec4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat0.xyzx).xyz;
					    SV_Target0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat1.x;
					    SV_Target0.y = (u_xlatb0.y) ? u_xlat2.y : u_xlat1.y;
					    SV_Target0.z = (u_xlatb0.z) ? u_xlat2.z : u_xlat1.z;
					    SV_Target0.w = 1.0;
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
					; Bound: 225
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %22 %182 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpDecorate %12 DescriptorSet 12 
					                                              OpDecorate %12 Binding 12 
					                                              OpDecorate %16 DescriptorSet 16 
					                                              OpDecorate %16 Binding 16 
					                                              OpDecorate vs_TEXCOORD1 Location 22 
					                                              OpMemberDecorate %30 0 Offset 30 
					                                              OpMemberDecorate %30 1 Offset 30 
					                                              OpMemberDecorate %30 2 Offset 30 
					                                              OpDecorate %30 Block 
					                                              OpDecorate %32 DescriptorSet 32 
					                                              OpDecorate %32 Binding 32 
					                                              OpDecorate %114 DescriptorSet 114 
					                                              OpDecorate %114 Binding 114 
					                                              OpDecorate %116 DescriptorSet 116 
					                                              OpDecorate %116 Binding 116 
					                                              OpDecorate %182 Location 182 
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
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                      %25 = OpTypeInt 32 0 
					                                  u32 %26 = OpConstant 0 
					                                      %28 = OpTypePointer Private %6 
					                                      %30 = OpTypeStruct %7 %6 %6 
					                                      %31 = OpTypePointer Uniform %30 
					   Uniform struct {f32_4; f32; f32;}* %32 = OpVariable Uniform 
					                                      %33 = OpTypeInt 32 1 
					                                  i32 %34 = OpConstant 0 
					                                  u32 %35 = OpConstant 2 
					                                      %36 = OpTypePointer Uniform %6 
					                                  u32 %42 = OpConstant 3 
					                                  f32 %47 = OpConstant 3,674022E-40 
					                         Private f32* %52 = OpVariable Private 
					                                  i32 %55 = OpConstant 1 
					                                  i32 %61 = OpConstant 2 
					                                  f32 %72 = OpConstant 3,674022E-40 
					                                  f32 %78 = OpConstant 3,674022E-40 
					                                      %88 = OpTypeVector %6 3 
					                                f32_3 %91 = OpConstantComposite %78 %47 %47 
					                                f32_3 %93 = OpConstantComposite %47 %78 %78 
					                                      %97 = OpTypePointer Private %88 
					                       Private f32_3* %98 = OpVariable Private 
					                                 f32 %102 = OpConstant 3,674022E-40 
					                               f32_3 %103 = OpConstantComposite %102 %102 %102 
					UniformConstant read_only Texture2D* %114 = OpVariable UniformConstant 
					            UniformConstant sampler* %116 = OpVariable UniformConstant 
					                        Private f32* %122 = OpVariable Private 
					                                 f32 %124 = OpConstant 3,674022E-40 
					                                 f32 %125 = OpConstant 3,674022E-40 
					                                 f32 %126 = OpConstant 3,674022E-40 
					                               f32_3 %127 = OpConstantComposite %124 %125 %126 
					                                 f32 %130 = OpConstant 3,674022E-40 
					                                 f32 %137 = OpConstant 3,674022E-40 
					                               f32_3 %138 = OpConstantComposite %137 %137 %137 
					                                 f32 %148 = OpConstant 3,674022E-40 
					                               f32_3 %149 = OpConstantComposite %148 %148 %148 
					                                 f32 %153 = OpConstant 3,674022E-40 
					                               f32_3 %154 = OpConstantComposite %153 %153 %153 
					                                 f32 %159 = OpConstant 3,674022E-40 
					                               f32_3 %160 = OpConstantComposite %159 %159 %159 
					                      Private f32_3* %164 = OpVariable Private 
					                                 f32 %167 = OpConstant 3,674022E-40 
					                               f32_3 %168 = OpConstantComposite %167 %167 %167 
					                                     %170 = OpTypeBool 
					                                     %171 = OpTypeVector %170 3 
					                                     %172 = OpTypePointer Private %171 
					                     Private bool_3* %173 = OpVariable Private 
					                                 f32 %174 = OpConstant 3,674022E-40 
					                               f32_4 %175 = OpConstantComposite %174 %174 %174 %78 
					                                     %178 = OpTypeVector %170 4 
					                                     %181 = OpTypePointer Output %7 
					                       Output f32_4* %182 = OpVariable Output 
					                                     %183 = OpTypePointer Private %170 
					                                     %186 = OpTypePointer Function %6 
					                                     %196 = OpTypePointer Output %6 
					                                 u32 %198 = OpConstant 1 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                       Function f32* %187 = OpVariable Function 
					                       Function f32* %201 = OpVariable Function 
					                       Function f32* %213 = OpVariable Function 
					                  read_only Texture2D %13 = OpLoad %12 
					                              sampler %17 = OpLoad %16 
					           read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                f32_2 %23 = OpLoad vs_TEXCOORD1 
					                                f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                  f32 %27 = OpCompositeExtract %24 0 
					                         Private f32* %29 = OpAccessChain %9 %26 
					                                              OpStore %29 %27 
					                         Uniform f32* %37 = OpAccessChain %32 %34 %35 
					                                  f32 %38 = OpLoad %37 
					                         Private f32* %39 = OpAccessChain %9 %26 
					                                  f32 %40 = OpLoad %39 
					                                  f32 %41 = OpFMul %38 %40 
					                         Uniform f32* %43 = OpAccessChain %32 %34 %42 
					                                  f32 %44 = OpLoad %43 
					                                  f32 %45 = OpFAdd %41 %44 
					                         Private f32* %46 = OpAccessChain %9 %26 
					                                              OpStore %46 %45 
					                         Private f32* %48 = OpAccessChain %9 %26 
					                                  f32 %49 = OpLoad %48 
					                                  f32 %50 = OpFDiv %47 %49 
					                         Private f32* %51 = OpAccessChain %9 %26 
					                                              OpStore %51 %50 
					                         Private f32* %53 = OpAccessChain %9 %26 
					                                  f32 %54 = OpLoad %53 
					                         Uniform f32* %56 = OpAccessChain %32 %55 
					                                  f32 %57 = OpLoad %56 
					                                  f32 %58 = OpFNegate %57 
					                                  f32 %59 = OpFAdd %54 %58 
					                                              OpStore %52 %59 
					                                  f32 %60 = OpLoad %52 
					                         Uniform f32* %62 = OpAccessChain %32 %61 
					                                  f32 %63 = OpLoad %62 
					                                  f32 %64 = OpFMul %60 %63 
					                                              OpStore %52 %64 
					                                  f32 %65 = OpLoad %52 
					                         Private f32* %66 = OpAccessChain %9 %26 
					                                  f32 %67 = OpLoad %66 
					                                  f32 %68 = OpFDiv %65 %67 
					                         Private f32* %69 = OpAccessChain %9 %26 
					                                              OpStore %69 %68 
					                         Private f32* %70 = OpAccessChain %9 %26 
					                                  f32 %71 = OpLoad %70 
					                                  f32 %73 = OpFMul %71 %72 
					                         Private f32* %74 = OpAccessChain %9 %26 
					                                              OpStore %74 %73 
					                         Private f32* %75 = OpAccessChain %9 %26 
					                                  f32 %76 = OpLoad %75 
					                                              OpStore %52 %76 
					                                  f32 %77 = OpLoad %52 
					                                  f32 %79 = OpExtInst %1 43 %77 %78 %47 
					                                              OpStore %52 %79 
					                         Private f32* %80 = OpAccessChain %9 %26 
					                                  f32 %81 = OpLoad %80 
					                                  f32 %82 = OpFNegate %81 
					                         Private f32* %83 = OpAccessChain %9 %26 
					                                              OpStore %83 %82 
					                         Private f32* %84 = OpAccessChain %9 %26 
					                                  f32 %85 = OpLoad %84 
					                                  f32 %86 = OpExtInst %1 43 %85 %78 %47 
					                         Private f32* %87 = OpAccessChain %9 %26 
					                                              OpStore %87 %86 
					                                f32_4 %89 = OpLoad %9 
					                                f32_3 %90 = OpVectorShuffle %89 %89 0 0 0 
					                                f32_3 %92 = OpFMul %90 %91 
					                                f32_3 %94 = OpFAdd %92 %93 
					                                f32_4 %95 = OpLoad %9 
					                                f32_4 %96 = OpVectorShuffle %95 %94 4 1 5 6 
					                                              OpStore %9 %96 
					                                f32_4 %99 = OpLoad %9 
					                               f32_3 %100 = OpVectorShuffle %99 %99 0 3 3 
					                               f32_3 %101 = OpFNegate %100 
					                               f32_3 %104 = OpFAdd %101 %103 
					                                              OpStore %98 %104 
					                                 f32 %105 = OpLoad %52 
					                               f32_3 %106 = OpCompositeConstruct %105 %105 %105 
					                               f32_3 %107 = OpLoad %98 
					                               f32_3 %108 = OpFMul %106 %107 
					                               f32_4 %109 = OpLoad %9 
					                               f32_3 %110 = OpVectorShuffle %109 %109 0 2 3 
					                               f32_3 %111 = OpFAdd %108 %110 
					                               f32_4 %112 = OpLoad %9 
					                               f32_4 %113 = OpVectorShuffle %112 %111 4 5 6 3 
					                                              OpStore %9 %113 
					                 read_only Texture2D %115 = OpLoad %114 
					                             sampler %117 = OpLoad %116 
					          read_only Texture2DSampled %118 = OpSampledImage %115 %117 
					                               f32_2 %119 = OpLoad vs_TEXCOORD1 
					                               f32_4 %120 = OpImageSampleImplicitLod %118 %119 
					                               f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                                              OpStore %98 %121 
					                               f32_3 %123 = OpLoad %98 
					                                 f32 %128 = OpDot %123 %127 
					                                              OpStore %122 %128 
					                                 f32 %129 = OpLoad %122 
					                                 f32 %131 = OpFAdd %129 %130 
					                                              OpStore %122 %131 
					                               f32_4 %132 = OpLoad %9 
					                               f32_3 %133 = OpVectorShuffle %132 %132 0 2 2 
					                                 f32 %134 = OpLoad %122 
					                               f32_3 %135 = OpCompositeConstruct %134 %134 %134 
					                               f32_3 %136 = OpFMul %133 %135 
					                               f32_3 %139 = OpFAdd %136 %138 
					                                              OpStore %98 %139 
					                                 f32 %140 = OpLoad %122 
					                               f32_3 %141 = OpCompositeConstruct %140 %140 %140 
					                               f32_4 %142 = OpLoad %9 
					                               f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                               f32_3 %144 = OpFMul %141 %143 
					                               f32_4 %145 = OpLoad %9 
					                               f32_4 %146 = OpVectorShuffle %145 %144 4 5 6 3 
					                                              OpStore %9 %146 
					                               f32_3 %147 = OpLoad %98 
					                               f32_3 %150 = OpFMul %147 %149 
					                                              OpStore %98 %150 
					                               f32_3 %151 = OpLoad %98 
					                               f32_3 %152 = OpExtInst %1 4 %151 
					                               f32_3 %155 = OpExtInst %1 40 %152 %154 
					                                              OpStore %98 %155 
					                               f32_3 %156 = OpLoad %98 
					                               f32_3 %157 = OpExtInst %1 30 %156 
					                                              OpStore %98 %157 
					                               f32_3 %158 = OpLoad %98 
					                               f32_3 %161 = OpFMul %158 %160 
					                                              OpStore %98 %161 
					                               f32_3 %162 = OpLoad %98 
					                               f32_3 %163 = OpExtInst %1 29 %162 
					                                              OpStore %98 %163 
					                               f32_4 %165 = OpLoad %9 
					                               f32_3 %166 = OpVectorShuffle %165 %165 0 2 2 
					                               f32_3 %169 = OpFMul %166 %168 
					                                              OpStore %164 %169 
					                               f32_4 %176 = OpLoad %9 
					                               f32_4 %177 = OpVectorShuffle %176 %176 0 1 2 0 
					                              bool_4 %179 = OpFOrdGreaterThanEqual %175 %177 
					                              bool_3 %180 = OpVectorShuffle %179 %179 0 1 2 
					                                              OpStore %173 %180 
					                       Private bool* %184 = OpAccessChain %173 %26 
					                                bool %185 = OpLoad %184 
					                                              OpSelectionMerge %189 None 
					                                              OpBranchConditional %185 %188 %192 
					                                     %188 = OpLabel 
					                        Private f32* %190 = OpAccessChain %164 %26 
					                                 f32 %191 = OpLoad %190 
					                                              OpStore %187 %191 
					                                              OpBranch %189 
					                                     %192 = OpLabel 
					                        Private f32* %193 = OpAccessChain %98 %26 
					                                 f32 %194 = OpLoad %193 
					                                              OpStore %187 %194 
					                                              OpBranch %189 
					                                     %189 = OpLabel 
					                                 f32 %195 = OpLoad %187 
					                         Output f32* %197 = OpAccessChain %182 %26 
					                                              OpStore %197 %195 
					                       Private bool* %199 = OpAccessChain %173 %198 
					                                bool %200 = OpLoad %199 
					                                              OpSelectionMerge %203 None 
					                                              OpBranchConditional %200 %202 %206 
					                                     %202 = OpLabel 
					                        Private f32* %204 = OpAccessChain %164 %198 
					                                 f32 %205 = OpLoad %204 
					                                              OpStore %201 %205 
					                                              OpBranch %203 
					                                     %206 = OpLabel 
					                        Private f32* %207 = OpAccessChain %98 %198 
					                                 f32 %208 = OpLoad %207 
					                                              OpStore %201 %208 
					                                              OpBranch %203 
					                                     %203 = OpLabel 
					                                 f32 %209 = OpLoad %201 
					                         Output f32* %210 = OpAccessChain %182 %198 
					                                              OpStore %210 %209 
					                       Private bool* %211 = OpAccessChain %173 %35 
					                                bool %212 = OpLoad %211 
					                                              OpSelectionMerge %215 None 
					                                              OpBranchConditional %212 %214 %218 
					                                     %214 = OpLabel 
					                        Private f32* %216 = OpAccessChain %164 %35 
					                                 f32 %217 = OpLoad %216 
					                                              OpStore %213 %217 
					                                              OpBranch %215 
					                                     %218 = OpLabel 
					                        Private f32* %219 = OpAccessChain %98 %35 
					                                 f32 %220 = OpLoad %219 
					                                              OpStore %213 %220 
					                                              OpBranch %215 
					                                     %215 = OpLabel 
					                                 f32 %221 = OpLoad %213 
					                         Output f32* %222 = OpAccessChain %182 %35 
					                                              OpStore %222 %221 
					                         Output f32* %223 = OpAccessChain %182 %42 
					                                              OpStore %223 %47 
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
						vec4 unused_0_0[21];
						vec4 _ZBufferParams;
						vec4 unused_0_2[8];
						float _Distance;
						float _LensCoeff;
						vec4 unused_0_5;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat3 = u_xlat0.x + (-_Distance);
					    u_xlat3 = u_xlat3 * _LensCoeff;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 80.0;
					    u_xlat3 = u_xlat0.x;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
					    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat9 = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat9 = u_xlat9 + 0.5;
					    u_xlat1.xyz = u_xlat0.xzz * vec3(u_xlat9) + vec3(0.0549999997, 0.0549999997, 0.0549999997);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.947867334, 0.947867334, 0.947867334);
					    u_xlat1.xyz = max(abs(u_xlat1.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.4000001, 2.4000001, 2.4000001);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat2.xyz = u_xlat0.xzz * vec3(0.0773993805, 0.0773993805, 0.0773993805);
					    u_xlatb0.xyz = greaterThanEqual(vec4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat0.xyzx).xyz;
					    SV_Target0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat1.x;
					    SV_Target0.y = (u_xlatb0.y) ? u_xlat2.y : u_xlat1.y;
					    SV_Target0.z = (u_xlatb0.z) ? u_xlat2.z : u_xlat1.z;
					    SV_Target0.w = 1.0;
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