Shader "Hidden/IES/FadeSpotlightCookieEdges" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 63358
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
					uniform 	float _HorizontalFadeDistance;
					uniform 	float _VerticalFadeDistance;
					uniform 	float _VerticalCenter;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat8;
					void main()
					{
					    u_xlat0.x = (-_VerticalCenter) + 1.0;
					    u_xlat0.y = (-u_xlat0.x);
					    u_xlat0.x = -0.5;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat8.xy = vec2(_HorizontalFadeDistance, _VerticalFadeDistance) * vec2(_HorizontalFadeDistance, _VerticalFadeDistance);
					    u_xlat0.xy = u_xlat0.xy / u_xlat8.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = (-u_xlat1) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat3 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * vec4(6.0, 6.0, 6.0, 6.0) + vec4(2.0, 2.0, 2.0, 2.0);
					    u_xlat0 = u_xlat0.xxxx * u_xlat2;
					    u_xlat0 = exp2(u_xlat0);
					    SV_Target0 = u_xlat0 * (-u_xlat1) + u_xlat1;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
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
					; Bound: 129
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %36 %121 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %10 0 Offset 10 
					                                             OpMemberDecorate %10 1 Offset 10 
					                                             OpMemberDecorate %10 2 Offset 10 
					                                             OpDecorate %10 Block 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate vs_TEXCOORD0 Location 36 
					                                             OpDecorate %82 DescriptorSet 82 
					                                             OpDecorate %82 Binding 82 
					                                             OpDecorate %86 DescriptorSet 86 
					                                             OpDecorate %86 Binding 86 
					                                             OpDecorate %121 Location 121 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeStruct %6 %6 %6 
					                                     %11 = OpTypePointer Uniform %10 
					    Uniform struct {f32; f32; f32;}* %12 = OpVariable Uniform 
					                                     %13 = OpTypeInt 32 1 
					                                 i32 %14 = OpConstant 2 
					                                     %15 = OpTypePointer Uniform %6 
					                                 f32 %19 = OpConstant 3,674022E-40 
					                                     %21 = OpTypeInt 32 0 
					                                 u32 %22 = OpConstant 0 
					                                     %23 = OpTypePointer Private %6 
					                                 u32 %28 = OpConstant 1 
					                                 f32 %30 = OpConstant 3,674022E-40 
					                                     %32 = OpTypeVector %6 2 
					                                     %35 = OpTypePointer Input %32 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %48 = OpTypePointer Private %32 
					                      Private f32_2* %49 = OpVariable Private 
					                                 i32 %50 = OpConstant 0 
					                                 i32 %53 = OpConstant 1 
					                      Private f32_4* %79 = OpVariable Private 
					                                     %80 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %81 = OpTypePointer UniformConstant %80 
					UniformConstant read_only Texture2D* %82 = OpVariable UniformConstant 
					                                     %84 = OpTypeSampler 
					                                     %85 = OpTypePointer UniformConstant %84 
					            UniformConstant sampler* %86 = OpVariable UniformConstant 
					                                     %88 = OpTypeSampledImage %80 
					                      Private f32_4* %92 = OpVariable Private 
					                               f32_4 %95 = OpConstantComposite %19 %19 %19 %19 
					                     Private f32_4* %100 = OpVariable Private 
					                                f32 %108 = OpConstant 3,674022E-40 
					                              f32_4 %109 = OpConstantComposite %108 %108 %108 %108 
					                                f32 %111 = OpConstant 3,674022E-40 
					                              f32_4 %112 = OpConstantComposite %111 %111 %111 %111 
					                                    %120 = OpTypePointer Output %7 
					                      Output f32_4* %121 = OpVariable Output 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                        Uniform f32* %16 = OpAccessChain %12 %14 
					                                 f32 %17 = OpLoad %16 
					                                 f32 %18 = OpFNegate %17 
					                                 f32 %20 = OpFAdd %18 %19 
					                        Private f32* %24 = OpAccessChain %9 %22 
					                                             OpStore %24 %20 
					                        Private f32* %25 = OpAccessChain %9 %22 
					                                 f32 %26 = OpLoad %25 
					                                 f32 %27 = OpFNegate %26 
					                        Private f32* %29 = OpAccessChain %9 %28 
					                                             OpStore %29 %27 
					                        Private f32* %31 = OpAccessChain %9 %22 
					                                             OpStore %31 %30 
					                               f32_4 %33 = OpLoad %9 
					                               f32_2 %34 = OpVectorShuffle %33 %33 0 1 
					                               f32_2 %37 = OpLoad vs_TEXCOORD0 
					                               f32_2 %38 = OpFAdd %34 %37 
					                               f32_4 %39 = OpLoad %9 
					                               f32_4 %40 = OpVectorShuffle %39 %38 4 5 2 3 
					                                             OpStore %9 %40 
					                               f32_4 %41 = OpLoad %9 
					                               f32_2 %42 = OpVectorShuffle %41 %41 0 1 
					                               f32_4 %43 = OpLoad %9 
					                               f32_2 %44 = OpVectorShuffle %43 %43 0 1 
					                               f32_2 %45 = OpFMul %42 %44 
					                               f32_4 %46 = OpLoad %9 
					                               f32_4 %47 = OpVectorShuffle %46 %45 4 5 2 3 
					                                             OpStore %9 %47 
					                        Uniform f32* %51 = OpAccessChain %12 %50 
					                                 f32 %52 = OpLoad %51 
					                        Uniform f32* %54 = OpAccessChain %12 %53 
					                                 f32 %55 = OpLoad %54 
					                               f32_2 %56 = OpCompositeConstruct %52 %55 
					                        Uniform f32* %57 = OpAccessChain %12 %50 
					                                 f32 %58 = OpLoad %57 
					                        Uniform f32* %59 = OpAccessChain %12 %53 
					                                 f32 %60 = OpLoad %59 
					                               f32_2 %61 = OpCompositeConstruct %58 %60 
					                               f32_2 %62 = OpFMul %56 %61 
					                                             OpStore %49 %62 
					                               f32_4 %63 = OpLoad %9 
					                               f32_2 %64 = OpVectorShuffle %63 %63 0 1 
					                               f32_2 %65 = OpLoad %49 
					                               f32_2 %66 = OpFDiv %64 %65 
					                               f32_4 %67 = OpLoad %9 
					                               f32_4 %68 = OpVectorShuffle %67 %66 4 5 2 3 
					                                             OpStore %9 %68 
					                        Private f32* %69 = OpAccessChain %9 %28 
					                                 f32 %70 = OpLoad %69 
					                        Private f32* %71 = OpAccessChain %9 %22 
					                                 f32 %72 = OpLoad %71 
					                                 f32 %73 = OpFAdd %70 %72 
					                        Private f32* %74 = OpAccessChain %9 %22 
					                                             OpStore %74 %73 
					                        Private f32* %75 = OpAccessChain %9 %22 
					                                 f32 %76 = OpLoad %75 
					                                 f32 %77 = OpExtInst %1 30 %76 
					                        Private f32* %78 = OpAccessChain %9 %22 
					                                             OpStore %78 %77 
					                 read_only Texture2D %83 = OpLoad %82 
					                             sampler %87 = OpLoad %86 
					          read_only Texture2DSampled %89 = OpSampledImage %83 %87 
					                               f32_2 %90 = OpLoad vs_TEXCOORD0 
					                               f32_4 %91 = OpImageSampleImplicitLod %89 %90 
					                                             OpStore %79 %91 
					                               f32_4 %93 = OpLoad %79 
					                               f32_4 %94 = OpFNegate %93 
					                               f32_4 %96 = OpFAdd %94 %95 
					                                             OpStore %92 %96 
					                               f32_4 %97 = OpLoad %92 
					                               f32_4 %98 = OpLoad %92 
					                               f32_4 %99 = OpFMul %97 %98 
					                                             OpStore %92 %99 
					                              f32_4 %101 = OpLoad %92 
					                              f32_4 %102 = OpLoad %92 
					                              f32_4 %103 = OpFMul %101 %102 
					                                             OpStore %100 %103 
					                              f32_4 %104 = OpLoad %92 
					                              f32_4 %105 = OpLoad %100 
					                              f32_4 %106 = OpFMul %104 %105 
					                                             OpStore %92 %106 
					                              f32_4 %107 = OpLoad %92 
					                              f32_4 %110 = OpFMul %107 %109 
					                              f32_4 %113 = OpFAdd %110 %112 
					                                             OpStore %92 %113 
					                              f32_4 %114 = OpLoad %9 
					                              f32_4 %115 = OpVectorShuffle %114 %114 0 0 0 0 
					                              f32_4 %116 = OpLoad %92 
					                              f32_4 %117 = OpFMul %115 %116 
					                                             OpStore %9 %117 
					                              f32_4 %118 = OpLoad %9 
					                              f32_4 %119 = OpExtInst %1 29 %118 
					                                             OpStore %9 %119 
					                              f32_4 %122 = OpLoad %9 
					                              f32_4 %123 = OpLoad %79 
					                              f32_4 %124 = OpFNegate %123 
					                              f32_4 %125 = OpFMul %122 %124 
					                              f32_4 %126 = OpLoad %79 
					                              f32_4 %127 = OpFAdd %125 %126 
					                                             OpStore %121 %127 
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
						vec4 unused_0_0[2];
						float _HorizontalFadeDistance;
						float _VerticalFadeDistance;
						float _VerticalCenter;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat8;
					void main()
					{
					    u_xlat0.x = (-_VerticalCenter) + 1.0;
					    u_xlat0.y = (-u_xlat0.x);
					    u_xlat0.x = -0.5;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat8.xy = vec2(_HorizontalFadeDistance, _VerticalFadeDistance) * vec2(_HorizontalFadeDistance, _VerticalFadeDistance);
					    u_xlat0.xy = u_xlat0.xy / u_xlat8.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = (-u_xlat1) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat3 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * vec4(6.0, 6.0, 6.0, 6.0) + vec4(2.0, 2.0, 2.0, 2.0);
					    u_xlat0 = u_xlat0.xxxx * u_xlat2;
					    u_xlat0 = exp2(u_xlat0);
					    SV_Target0 = u_xlat0 * (-u_xlat1) + u_xlat1;
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