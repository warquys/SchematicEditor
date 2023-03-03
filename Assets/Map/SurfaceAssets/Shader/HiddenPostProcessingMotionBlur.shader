Shader "Hidden/PostProcessing/MotionBlur" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 30151
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
						vec4 unused_0_2[6];
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
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 _CameraMotionVectorsTexture_TexelSize;
					uniform 	float _VelocityScale;
					uniform 	float _RcpMaxBlurRadius;
					UNITY_LOCATION(0) uniform  sampler2D _CameraMotionVectorsTexture;
					UNITY_LOCATION(1) uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0.x = _VelocityScale * 0.5;
					    u_xlat0.xy = u_xlat0.xx * _CameraMotionVectorsTexture_TexelSize.zw;
					    u_xlat1 = texture(_CameraMotionVectorsTexture, vs_TEXCOORD0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
					    u_xlat4 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 * _RcpMaxBlurRadius;
					    u_xlat4 = max(u_xlat4, 1.0);
					    u_xlat0.xy = u_xlat0.xy / vec2(u_xlat4);
					    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_RcpMaxBlurRadius, _RcpMaxBlurRadius)) + vec2(1.0, 1.0);
					    SV_Target0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    u_xlat0.x = (-unity_OrthoParams.w) + 1.0;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat1.x * _ZBufferParams.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2 + _ZBufferParams.y;
					    u_xlat2 = (-unity_OrthoParams.w) * u_xlat2 + 1.0;
					    SV_Target0.z = u_xlat2 / u_xlat0.x;
					    SV_Target0.w = 0.0;
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
					; Bound: 141
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %45 %89 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpMemberDecorate %11 0 Offset 11 
					                                                      OpMemberDecorate %11 1 Offset 11 
					                                                      OpMemberDecorate %11 2 Offset 11 
					                                                      OpMemberDecorate %11 3 Offset 11 
					                                                      OpMemberDecorate %11 4 Offset 11 
					                                                      OpDecorate %11 Block 
					                                                      OpDecorate %13 DescriptorSet 13 
					                                                      OpDecorate %13 Binding 13 
					                                                      OpDecorate %36 DescriptorSet 36 
					                                                      OpDecorate %36 Binding 36 
					                                                      OpDecorate %40 DescriptorSet 40 
					                                                      OpDecorate %40 Binding 40 
					                                                      OpDecorate vs_TEXCOORD0 Location 45 
					                                                      OpDecorate %89 Location 89 
					                                                      OpDecorate %103 DescriptorSet 103 
					                                                      OpDecorate %103 Binding 103 
					                                                      OpDecorate %105 DescriptorSet 105 
					                                                      OpDecorate %105 Binding 105 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypeStruct %10 %10 %10 %6 %6 
					                                              %12 = OpTypePointer Uniform %11 
					Uniform struct {f32_4; f32_4; f32_4; f32; f32;}* %13 = OpVariable Uniform 
					                                              %14 = OpTypeInt 32 1 
					                                          i32 %15 = OpConstant 3 
					                                              %16 = OpTypePointer Uniform %6 
					                                          f32 %19 = OpConstant 3,674022E-40 
					                                              %21 = OpTypeInt 32 0 
					                                          u32 %22 = OpConstant 0 
					                                              %23 = OpTypePointer Private %6 
					                                          i32 %27 = OpConstant 2 
					                                              %28 = OpTypePointer Uniform %10 
					                               Private f32_2* %33 = OpVariable Private 
					                                              %34 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %35 = OpTypePointer UniformConstant %34 
					         UniformConstant read_only Texture2D* %36 = OpVariable UniformConstant 
					                                              %38 = OpTypeSampler 
					                                              %39 = OpTypePointer UniformConstant %38 
					                     UniformConstant sampler* %40 = OpVariable UniformConstant 
					                                              %42 = OpTypeSampledImage %34 
					                                              %44 = OpTypePointer Input %7 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                          i32 %62 = OpConstant 4 
					                                          f32 %69 = OpConstant 3,674022E-40 
					                                        f32_2 %86 = OpConstantComposite %69 %69 
					                                              %88 = OpTypePointer Output %10 
					                                Output f32_4* %89 = OpVariable Output 
					                                        f32_2 %91 = OpConstantComposite %19 %19 
					                                          i32 %95 = OpConstant 0 
					                                          u32 %96 = OpConstant 3 
					                                Private f32* %102 = OpVariable Private 
					        UniformConstant read_only Texture2D* %103 = OpVariable UniformConstant 
					                    UniformConstant sampler* %105 = OpVariable UniformConstant 
					                                         i32 %112 = OpConstant 1 
					                                         u32 %120 = OpConstant 1 
					                                         u32 %135 = OpConstant 2 
					                                             %136 = OpTypePointer Output %6 
					                                         f32 %138 = OpConstant 3,674022E-40 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                 Uniform f32* %17 = OpAccessChain %13 %15 
					                                          f32 %18 = OpLoad %17 
					                                          f32 %20 = OpFMul %18 %19 
					                                 Private f32* %24 = OpAccessChain %9 %22 
					                                                      OpStore %24 %20 
					                                        f32_2 %25 = OpLoad %9 
					                                        f32_2 %26 = OpVectorShuffle %25 %25 0 0 
					                               Uniform f32_4* %29 = OpAccessChain %13 %27 
					                                        f32_4 %30 = OpLoad %29 
					                                        f32_2 %31 = OpVectorShuffle %30 %30 2 3 
					                                        f32_2 %32 = OpFMul %26 %31 
					                                                      OpStore %9 %32 
					                          read_only Texture2D %37 = OpLoad %36 
					                                      sampler %41 = OpLoad %40 
					                   read_only Texture2DSampled %43 = OpSampledImage %37 %41 
					                                        f32_2 %46 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %47 = OpImageSampleImplicitLod %43 %46 
					                                        f32_2 %48 = OpVectorShuffle %47 %47 0 1 
					                                                      OpStore %33 %48 
					                                        f32_2 %49 = OpLoad %9 
					                                        f32_2 %50 = OpLoad %33 
					                                        f32_2 %51 = OpFMul %49 %50 
					                                                      OpStore %9 %51 
					                                        f32_2 %52 = OpLoad %9 
					                                        f32_2 %53 = OpLoad %9 
					                                          f32 %54 = OpDot %52 %53 
					                                 Private f32* %55 = OpAccessChain %33 %22 
					                                                      OpStore %55 %54 
					                                 Private f32* %56 = OpAccessChain %33 %22 
					                                          f32 %57 = OpLoad %56 
					                                          f32 %58 = OpExtInst %1 31 %57 
					                                 Private f32* %59 = OpAccessChain %33 %22 
					                                                      OpStore %59 %58 
					                                 Private f32* %60 = OpAccessChain %33 %22 
					                                          f32 %61 = OpLoad %60 
					                                 Uniform f32* %63 = OpAccessChain %13 %62 
					                                          f32 %64 = OpLoad %63 
					                                          f32 %65 = OpFMul %61 %64 
					                                 Private f32* %66 = OpAccessChain %33 %22 
					                                                      OpStore %66 %65 
					                                 Private f32* %67 = OpAccessChain %33 %22 
					                                          f32 %68 = OpLoad %67 
					                                          f32 %70 = OpExtInst %1 40 %68 %69 
					                                 Private f32* %71 = OpAccessChain %33 %22 
					                                                      OpStore %71 %70 
					                                        f32_2 %72 = OpLoad %9 
					                                        f32_2 %73 = OpLoad %33 
					                                        f32_2 %74 = OpVectorShuffle %73 %73 0 0 
					                                        f32_2 %75 = OpFDiv %72 %74 
					                                                      OpStore %9 %75 
					                                        f32_2 %76 = OpLoad %9 
					                                 Uniform f32* %77 = OpAccessChain %13 %62 
					                                          f32 %78 = OpLoad %77 
					                                 Uniform f32* %79 = OpAccessChain %13 %62 
					                                          f32 %80 = OpLoad %79 
					                                        f32_2 %81 = OpCompositeConstruct %78 %80 
					                                          f32 %82 = OpCompositeExtract %81 0 
					                                          f32 %83 = OpCompositeExtract %81 1 
					                                        f32_2 %84 = OpCompositeConstruct %82 %83 
					                                        f32_2 %85 = OpFMul %76 %84 
					                                        f32_2 %87 = OpFAdd %85 %86 
					                                                      OpStore %9 %87 
					                                        f32_2 %90 = OpLoad %9 
					                                        f32_2 %92 = OpFMul %90 %91 
					                                        f32_4 %93 = OpLoad %89 
					                                        f32_4 %94 = OpVectorShuffle %93 %92 4 5 2 3 
					                                                      OpStore %89 %94 
					                                 Uniform f32* %97 = OpAccessChain %13 %95 %96 
					                                          f32 %98 = OpLoad %97 
					                                          f32 %99 = OpFNegate %98 
					                                         f32 %100 = OpFAdd %99 %69 
					                                Private f32* %101 = OpAccessChain %9 %22 
					                                                      OpStore %101 %100 
					                         read_only Texture2D %104 = OpLoad %103 
					                                     sampler %106 = OpLoad %105 
					                  read_only Texture2DSampled %107 = OpSampledImage %104 %106 
					                                       f32_2 %108 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %109 = OpImageSampleImplicitLod %107 %108 
					                                         f32 %110 = OpCompositeExtract %109 0 
					                                                      OpStore %102 %110 
					                                         f32 %111 = OpLoad %102 
					                                Uniform f32* %113 = OpAccessChain %13 %112 %22 
					                                         f32 %114 = OpLoad %113 
					                                         f32 %115 = OpFMul %111 %114 
					                                                      OpStore %102 %115 
					                                Private f32* %116 = OpAccessChain %9 %22 
					                                         f32 %117 = OpLoad %116 
					                                         f32 %118 = OpLoad %102 
					                                         f32 %119 = OpFMul %117 %118 
					                                Uniform f32* %121 = OpAccessChain %13 %112 %120 
					                                         f32 %122 = OpLoad %121 
					                                         f32 %123 = OpFAdd %119 %122 
					                                Private f32* %124 = OpAccessChain %9 %22 
					                                                      OpStore %124 %123 
					                                Uniform f32* %125 = OpAccessChain %13 %95 %96 
					                                         f32 %126 = OpLoad %125 
					                                         f32 %127 = OpFNegate %126 
					                                         f32 %128 = OpLoad %102 
					                                         f32 %129 = OpFMul %127 %128 
					                                         f32 %130 = OpFAdd %129 %69 
					                                                      OpStore %102 %130 
					                                         f32 %131 = OpLoad %102 
					                                Private f32* %132 = OpAccessChain %9 %22 
					                                         f32 %133 = OpLoad %132 
					                                         f32 %134 = OpFDiv %131 %133 
					                                 Output f32* %137 = OpAccessChain %89 %135 
					                                                      OpStore %137 %134 
					                                 Output f32* %139 = OpAccessChain %89 %96 
					                                                      OpStore %139 %138 
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
						vec4 unused_0_0[20];
						vec4 unity_OrthoParams;
						vec4 _ZBufferParams;
						vec4 unused_0_3[7];
						vec4 _CameraMotionVectorsTexture_TexelSize;
						vec4 unused_0_5;
						float _VelocityScale;
						vec4 unused_0_7;
						float _RcpMaxBlurRadius;
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _CameraMotionVectorsTexture;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0.x = _VelocityScale * 0.5;
					    u_xlat0.xy = u_xlat0.xx * _CameraMotionVectorsTexture_TexelSize.zw;
					    u_xlat1 = texture(_CameraMotionVectorsTexture, vs_TEXCOORD0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
					    u_xlat4 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 * unused_0_7.y;
					    u_xlat4 = max(u_xlat4, 1.0);
					    u_xlat0.xy = u_xlat0.xy / vec2(u_xlat4);
					    u_xlat0.xy = u_xlat0.xy * unused_0_7.yy + vec2(1.0, 1.0);
					    SV_Target0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    u_xlat0.x = (-unity_OrthoParams.w) + 1.0;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat1.x * _ZBufferParams.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2 + _ZBufferParams.y;
					    u_xlat2 = (-unity_OrthoParams.w) * u_xlat2 + 1.0;
					    SV_Target0.z = u_xlat2 / u_xlat0.x;
					    SV_Target0.w = 0.0;
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
			GpuProgramID 86497
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
						vec4 unused_0_2[6];
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
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _MaxBlurRadius;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.zw = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0 = u_xlat0 * vec4(_MaxBlurRadius);
					    u_xlat1.x = dot(u_xlat0.zw, u_xlat0.zw);
					    u_xlat4 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlatb1 = u_xlat1.x<u_xlat4;
					    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.xy : u_xlat0.zw;
					    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1.zw = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1 = u_xlat1 * vec4(_MaxBlurRadius);
					    u_xlat9 = dot(u_xlat1.zw, u_xlat1.zw);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.zw : u_xlat0.xy;
					    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    SV_Target0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
					    SV_Target0.zw = vec2(0.0, 0.0);
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
					; Bound: 216
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %25 %198 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %10 0 Offset 10 
					                                             OpMemberDecorate %10 1 Offset 10 
					                                             OpDecorate %10 Block 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate vs_TEXCOORD0 Location 25 
					                                             OpDecorate %31 DescriptorSet 31 
					                                             OpDecorate %31 Binding 31 
					                                             OpDecorate %35 DescriptorSet 35 
					                                             OpDecorate %35 Binding 35 
					                                             OpDecorate %198 Location 198 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeStruct %7 %6 
					                                     %11 = OpTypePointer Uniform %10 
					       Uniform struct {f32_4; f32;}* %12 = OpVariable Uniform 
					                                     %13 = OpTypeInt 32 1 
					                                 i32 %14 = OpConstant 0 
					                                     %15 = OpTypePointer Uniform %7 
					                                 f32 %19 = OpConstant 3,674022E-40 
					                                 f32 %20 = OpConstant 3,674022E-40 
					                               f32_4 %21 = OpConstantComposite %19 %19 %20 %19 
					                                     %23 = OpTypeVector %6 2 
					                                     %24 = OpTypePointer Input %23 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %29 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %30 = OpTypePointer UniformConstant %29 
					UniformConstant read_only Texture2D* %31 = OpVariable UniformConstant 
					                                     %33 = OpTypeSampler 
					                                     %34 = OpTypePointer UniformConstant %33 
					            UniformConstant sampler* %35 = OpVariable UniformConstant 
					                                     %37 = OpTypeSampledImage %29 
					                                     %45 = OpTypePointer Private %23 
					                      Private f32_2* %46 = OpVariable Private 
					                                 f32 %55 = OpConstant 3,674022E-40 
					                               f32_2 %56 = OpConstantComposite %55 %55 
					                                 f32 %58 = OpConstant 3,674022E-40 
					                               f32_2 %59 = OpConstantComposite %58 %58 
					                                 i32 %70 = OpConstant 1 
					                                     %71 = OpTypePointer Uniform %6 
					                      Private f32_4* %76 = OpVariable Private 
					                                     %82 = OpTypeInt 32 0 
					                                 u32 %83 = OpConstant 0 
					                                     %84 = OpTypePointer Private %6 
					                        Private f32* %86 = OpVariable Private 
					                                     %92 = OpTypeBool 
					                                     %93 = OpTypePointer Private %92 
					                       Private bool* %94 = OpVariable Private 
					                                    %100 = OpTypePointer Function %23 
					                              f32_4 %121 = OpConstantComposite %19 %20 %20 %20 
					                     Private f32_2* %135 = OpVariable Private 
					                       Private f32* %159 = OpVariable Private 
					                      Private bool* %165 = OpVariable Private 
					                                    %197 = OpTypePointer Output %7 
					                      Output f32_4* %198 = OpVariable Output 
					                                f32 %211 = OpConstant 3,674022E-40 
					                              f32_2 %212 = OpConstantComposite %211 %211 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                    Function f32_2* %101 = OpVariable Function 
					                    Function f32_2* %171 = OpVariable Function 
					                    Function f32_2* %200 = OpVariable Function 
					                      Uniform f32_4* %16 = OpAccessChain %12 %14 
					                               f32_4 %17 = OpLoad %16 
					                               f32_4 %18 = OpVectorShuffle %17 %17 0 1 0 1 
					                               f32_4 %22 = OpFMul %18 %21 
					                               f32_2 %26 = OpLoad vs_TEXCOORD0 
					                               f32_4 %27 = OpVectorShuffle %26 %26 0 1 0 1 
					                               f32_4 %28 = OpFAdd %22 %27 
					                                             OpStore %9 %28 
					                 read_only Texture2D %32 = OpLoad %31 
					                             sampler %36 = OpLoad %35 
					          read_only Texture2DSampled %38 = OpSampledImage %32 %36 
					                               f32_4 %39 = OpLoad %9 
					                               f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                               f32_4 %41 = OpImageSampleImplicitLod %38 %40 
					                               f32_2 %42 = OpVectorShuffle %41 %41 0 1 
					                               f32_4 %43 = OpLoad %9 
					                               f32_4 %44 = OpVectorShuffle %43 %42 4 5 2 3 
					                                             OpStore %9 %44 
					                 read_only Texture2D %47 = OpLoad %31 
					                             sampler %48 = OpLoad %35 
					          read_only Texture2DSampled %49 = OpSampledImage %47 %48 
					                               f32_4 %50 = OpLoad %9 
					                               f32_2 %51 = OpVectorShuffle %50 %50 2 3 
					                               f32_4 %52 = OpImageSampleImplicitLod %49 %51 
					                               f32_2 %53 = OpVectorShuffle %52 %52 0 1 
					                                             OpStore %46 %53 
					                               f32_2 %54 = OpLoad %46 
					                               f32_2 %57 = OpFMul %54 %56 
					                               f32_2 %60 = OpFAdd %57 %59 
					                               f32_4 %61 = OpLoad %9 
					                               f32_4 %62 = OpVectorShuffle %61 %60 0 1 4 5 
					                                             OpStore %9 %62 
					                               f32_4 %63 = OpLoad %9 
					                               f32_2 %64 = OpVectorShuffle %63 %63 0 1 
					                               f32_2 %65 = OpFMul %64 %56 
					                               f32_2 %66 = OpFAdd %65 %59 
					                               f32_4 %67 = OpLoad %9 
					                               f32_4 %68 = OpVectorShuffle %67 %66 4 5 2 3 
					                                             OpStore %9 %68 
					                               f32_4 %69 = OpLoad %9 
					                        Uniform f32* %72 = OpAccessChain %12 %70 
					                                 f32 %73 = OpLoad %72 
					                               f32_4 %74 = OpCompositeConstruct %73 %73 %73 %73 
					                               f32_4 %75 = OpFMul %69 %74 
					                                             OpStore %9 %75 
					                               f32_4 %77 = OpLoad %9 
					                               f32_2 %78 = OpVectorShuffle %77 %77 0 1 
					                               f32_4 %79 = OpLoad %9 
					                               f32_2 %80 = OpVectorShuffle %79 %79 0 1 
					                                 f32 %81 = OpDot %78 %80 
					                        Private f32* %85 = OpAccessChain %76 %83 
					                                             OpStore %85 %81 
					                               f32_4 %87 = OpLoad %9 
					                               f32_2 %88 = OpVectorShuffle %87 %87 2 3 
					                               f32_4 %89 = OpLoad %9 
					                               f32_2 %90 = OpVectorShuffle %89 %89 2 3 
					                                 f32 %91 = OpDot %88 %90 
					                                             OpStore %86 %91 
					                        Private f32* %95 = OpAccessChain %76 %83 
					                                 f32 %96 = OpLoad %95 
					                                 f32 %97 = OpLoad %86 
					                                bool %98 = OpFOrdLessThan %96 %97 
					                                             OpStore %94 %98 
					                                bool %99 = OpLoad %94 
					                                             OpSelectionMerge %103 None 
					                                             OpBranchConditional %99 %102 %106 
					                                    %102 = OpLabel 
					                              f32_4 %104 = OpLoad %9 
					                              f32_2 %105 = OpVectorShuffle %104 %104 2 3 
					                                             OpStore %101 %105 
					                                             OpBranch %103 
					                                    %106 = OpLabel 
					                              f32_4 %107 = OpLoad %9 
					                              f32_2 %108 = OpVectorShuffle %107 %107 0 1 
					                                             OpStore %101 %108 
					                                             OpBranch %103 
					                                    %103 = OpLabel 
					                              f32_2 %109 = OpLoad %101 
					                              f32_4 %110 = OpLoad %9 
					                              f32_4 %111 = OpVectorShuffle %110 %109 4 5 2 3 
					                                             OpStore %9 %111 
					                              f32_4 %112 = OpLoad %9 
					                              f32_2 %113 = OpVectorShuffle %112 %112 0 1 
					                              f32_4 %114 = OpLoad %9 
					                              f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                f32 %116 = OpDot %113 %115 
					                       Private f32* %117 = OpAccessChain %46 %83 
					                                             OpStore %117 %116 
					                     Uniform f32_4* %118 = OpAccessChain %12 %14 
					                              f32_4 %119 = OpLoad %118 
					                              f32_4 %120 = OpVectorShuffle %119 %119 0 1 0 1 
					                              f32_4 %122 = OpFMul %120 %121 
					                              f32_2 %123 = OpLoad vs_TEXCOORD0 
					                              f32_4 %124 = OpVectorShuffle %123 %123 0 1 0 1 
					                              f32_4 %125 = OpFAdd %122 %124 
					                                             OpStore %76 %125 
					                read_only Texture2D %126 = OpLoad %31 
					                            sampler %127 = OpLoad %35 
					         read_only Texture2DSampled %128 = OpSampledImage %126 %127 
					                              f32_4 %129 = OpLoad %76 
					                              f32_2 %130 = OpVectorShuffle %129 %129 0 1 
					                              f32_4 %131 = OpImageSampleImplicitLod %128 %130 
					                              f32_2 %132 = OpVectorShuffle %131 %131 0 1 
					                              f32_4 %133 = OpLoad %76 
					                              f32_4 %134 = OpVectorShuffle %133 %132 4 5 2 3 
					                                             OpStore %76 %134 
					                read_only Texture2D %136 = OpLoad %31 
					                            sampler %137 = OpLoad %35 
					         read_only Texture2DSampled %138 = OpSampledImage %136 %137 
					                              f32_4 %139 = OpLoad %76 
					                              f32_2 %140 = OpVectorShuffle %139 %139 2 3 
					                              f32_4 %141 = OpImageSampleImplicitLod %138 %140 
					                              f32_2 %142 = OpVectorShuffle %141 %141 0 1 
					                                             OpStore %135 %142 
					                              f32_2 %143 = OpLoad %135 
					                              f32_2 %144 = OpFMul %143 %56 
					                              f32_2 %145 = OpFAdd %144 %59 
					                              f32_4 %146 = OpLoad %76 
					                              f32_4 %147 = OpVectorShuffle %146 %145 0 1 4 5 
					                                             OpStore %76 %147 
					                              f32_4 %148 = OpLoad %76 
					                              f32_2 %149 = OpVectorShuffle %148 %148 0 1 
					                              f32_2 %150 = OpFMul %149 %56 
					                              f32_2 %151 = OpFAdd %150 %59 
					                              f32_4 %152 = OpLoad %76 
					                              f32_4 %153 = OpVectorShuffle %152 %151 4 5 2 3 
					                                             OpStore %76 %153 
					                              f32_4 %154 = OpLoad %76 
					                       Uniform f32* %155 = OpAccessChain %12 %70 
					                                f32 %156 = OpLoad %155 
					                              f32_4 %157 = OpCompositeConstruct %156 %156 %156 %156 
					                              f32_4 %158 = OpFMul %154 %157 
					                                             OpStore %76 %158 
					                              f32_4 %160 = OpLoad %76 
					                              f32_2 %161 = OpVectorShuffle %160 %160 0 1 
					                              f32_4 %162 = OpLoad %76 
					                              f32_2 %163 = OpVectorShuffle %162 %162 0 1 
					                                f32 %164 = OpDot %161 %163 
					                                             OpStore %159 %164 
					                       Private f32* %166 = OpAccessChain %46 %83 
					                                f32 %167 = OpLoad %166 
					                                f32 %168 = OpLoad %159 
					                               bool %169 = OpFOrdLessThan %167 %168 
					                                             OpStore %165 %169 
					                               bool %170 = OpLoad %165 
					                                             OpSelectionMerge %173 None 
					                                             OpBranchConditional %170 %172 %176 
					                                    %172 = OpLabel 
					                              f32_4 %174 = OpLoad %76 
					                              f32_2 %175 = OpVectorShuffle %174 %174 0 1 
					                                             OpStore %171 %175 
					                                             OpBranch %173 
					                                    %176 = OpLabel 
					                              f32_4 %177 = OpLoad %9 
					                              f32_2 %178 = OpVectorShuffle %177 %177 0 1 
					                                             OpStore %171 %178 
					                                             OpBranch %173 
					                                    %173 = OpLabel 
					                              f32_2 %179 = OpLoad %171 
					                              f32_4 %180 = OpLoad %9 
					                              f32_4 %181 = OpVectorShuffle %180 %179 4 5 2 3 
					                                             OpStore %9 %181 
					                              f32_4 %182 = OpLoad %9 
					                              f32_2 %183 = OpVectorShuffle %182 %182 0 1 
					                              f32_4 %184 = OpLoad %9 
					                              f32_2 %185 = OpVectorShuffle %184 %184 0 1 
					                                f32 %186 = OpDot %183 %185 
					                       Private f32* %187 = OpAccessChain %46 %83 
					                                             OpStore %187 %186 
					                              f32_4 %188 = OpLoad %76 
					                              f32_2 %189 = OpVectorShuffle %188 %188 2 3 
					                              f32_4 %190 = OpLoad %76 
					                              f32_2 %191 = OpVectorShuffle %190 %190 2 3 
					                                f32 %192 = OpDot %189 %191 
					                                             OpStore %159 %192 
					                       Private f32* %193 = OpAccessChain %46 %83 
					                                f32 %194 = OpLoad %193 
					                                f32 %195 = OpLoad %159 
					                               bool %196 = OpFOrdLessThan %194 %195 
					                                             OpStore %165 %196 
					                               bool %199 = OpLoad %165 
					                                             OpSelectionMerge %202 None 
					                                             OpBranchConditional %199 %201 %205 
					                                    %201 = OpLabel 
					                              f32_4 %203 = OpLoad %76 
					                              f32_2 %204 = OpVectorShuffle %203 %203 2 3 
					                                             OpStore %200 %204 
					                                             OpBranch %202 
					                                    %205 = OpLabel 
					                              f32_4 %206 = OpLoad %9 
					                              f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                                             OpStore %200 %207 
					                                             OpBranch %202 
					                                    %202 = OpLabel 
					                              f32_2 %208 = OpLoad %200 
					                              f32_4 %209 = OpLoad %198 
					                              f32_4 %210 = OpVectorShuffle %209 %208 4 5 2 3 
					                                             OpStore %198 %210 
					                              f32_4 %213 = OpLoad %198 
					                              f32_4 %214 = OpVectorShuffle %213 %212 0 1 4 5 
					                                             OpStore %198 %214 
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
						vec4 unused_0_2[3];
						float _MaxBlurRadius;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.zw = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0 = u_xlat0 * vec4(_MaxBlurRadius);
					    u_xlat1.x = dot(u_xlat0.zw, u_xlat0.zw);
					    u_xlat4 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlatb1 = u_xlat1.x<u_xlat4;
					    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.xy : u_xlat0.zw;
					    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1.zw = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1 = u_xlat1 * vec4(_MaxBlurRadius);
					    u_xlat9 = dot(u_xlat1.zw, u_xlat1.zw);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.zw : u_xlat0.xy;
					    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    SV_Target0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
					    SV_Target0.zw = vec2(0.0, 0.0);
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
			GpuProgramID 156359
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
						vec4 unused_0_2[6];
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
					uniform 	vec4 _MainTex_TexelSize;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat6;
					bool u_xlatb6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat6 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat9 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat0.xy : u_xlat1.xy;
					    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat9 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat2.xy : u_xlat0.xy;
					    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    SV_Target0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
					    SV_Target0.zw = vec2(0.0, 0.0);
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
					; Bound: 172
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %25 %155 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %10 0 Offset 10 
					                                             OpDecorate %10 Block 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate vs_TEXCOORD0 Location 25 
					                                             OpDecorate %31 DescriptorSet 31 
					                                             OpDecorate %31 Binding 31 
					                                             OpDecorate %35 DescriptorSet 35 
					                                             OpDecorate %35 Binding 35 
					                                             OpDecorate %155 Location 155 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeStruct %7 
					                                     %11 = OpTypePointer Uniform %10 
					            Uniform struct {f32_4;}* %12 = OpVariable Uniform 
					                                     %13 = OpTypeInt 32 1 
					                                 i32 %14 = OpConstant 0 
					                                     %15 = OpTypePointer Uniform %7 
					                                 f32 %19 = OpConstant 3,674022E-40 
					                                 f32 %20 = OpConstant 3,674022E-40 
					                               f32_4 %21 = OpConstantComposite %19 %19 %20 %19 
					                                     %23 = OpTypeVector %6 2 
					                                     %24 = OpTypePointer Input %23 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %29 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %30 = OpTypePointer UniformConstant %29 
					UniformConstant read_only Texture2D* %31 = OpVariable UniformConstant 
					                                     %33 = OpTypeSampler 
					                                     %34 = OpTypePointer UniformConstant %33 
					            UniformConstant sampler* %35 = OpVariable UniformConstant 
					                                     %37 = OpTypeSampledImage %29 
					                                     %45 = OpTypePointer Private %23 
					                      Private f32_2* %46 = OpVariable Private 
					                      Private f32_4* %54 = OpVariable Private 
					                                     %60 = OpTypeInt 32 0 
					                                 u32 %61 = OpConstant 0 
					                                     %62 = OpTypePointer Private %6 
					                        Private f32* %64 = OpVariable Private 
					                                     %68 = OpTypeBool 
					                                     %69 = OpTypePointer Private %68 
					                       Private bool* %70 = OpVariable Private 
					                                     %76 = OpTypePointer Function %23 
					                               f32_4 %96 = OpConstantComposite %19 %20 %20 %20 
					                     Private f32_2* %110 = OpVariable Private 
					                       Private f32* %118 = OpVariable Private 
					                      Private bool* %124 = OpVariable Private 
					                                    %154 = OpTypePointer Output %7 
					                      Output f32_4* %155 = OpVariable Output 
					                                f32 %167 = OpConstant 3,674022E-40 
					                              f32_2 %168 = OpConstantComposite %167 %167 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                     Function f32_2* %77 = OpVariable Function 
					                    Function f32_2* %130 = OpVariable Function 
					                    Function f32_2* %157 = OpVariable Function 
					                      Uniform f32_4* %16 = OpAccessChain %12 %14 
					                               f32_4 %17 = OpLoad %16 
					                               f32_4 %18 = OpVectorShuffle %17 %17 0 1 0 1 
					                               f32_4 %22 = OpFMul %18 %21 
					                               f32_2 %26 = OpLoad vs_TEXCOORD0 
					                               f32_4 %27 = OpVectorShuffle %26 %26 0 1 0 1 
					                               f32_4 %28 = OpFAdd %22 %27 
					                                             OpStore %9 %28 
					                 read_only Texture2D %32 = OpLoad %31 
					                             sampler %36 = OpLoad %35 
					          read_only Texture2DSampled %38 = OpSampledImage %32 %36 
					                               f32_4 %39 = OpLoad %9 
					                               f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                               f32_4 %41 = OpImageSampleImplicitLod %38 %40 
					                               f32_2 %42 = OpVectorShuffle %41 %41 0 1 
					                               f32_4 %43 = OpLoad %9 
					                               f32_4 %44 = OpVectorShuffle %43 %42 4 5 2 3 
					                                             OpStore %9 %44 
					                 read_only Texture2D %47 = OpLoad %31 
					                             sampler %48 = OpLoad %35 
					          read_only Texture2DSampled %49 = OpSampledImage %47 %48 
					                               f32_4 %50 = OpLoad %9 
					                               f32_2 %51 = OpVectorShuffle %50 %50 2 3 
					                               f32_4 %52 = OpImageSampleImplicitLod %49 %51 
					                               f32_2 %53 = OpVectorShuffle %52 %52 0 1 
					                                             OpStore %46 %53 
					                               f32_4 %55 = OpLoad %9 
					                               f32_2 %56 = OpVectorShuffle %55 %55 0 1 
					                               f32_4 %57 = OpLoad %9 
					                               f32_2 %58 = OpVectorShuffle %57 %57 0 1 
					                                 f32 %59 = OpDot %56 %58 
					                        Private f32* %63 = OpAccessChain %54 %61 
					                                             OpStore %63 %59 
					                               f32_2 %65 = OpLoad %46 
					                               f32_2 %66 = OpLoad %46 
					                                 f32 %67 = OpDot %65 %66 
					                                             OpStore %64 %67 
					                        Private f32* %71 = OpAccessChain %54 %61 
					                                 f32 %72 = OpLoad %71 
					                                 f32 %73 = OpLoad %64 
					                                bool %74 = OpFOrdLessThan %72 %73 
					                                             OpStore %70 %74 
					                                bool %75 = OpLoad %70 
					                                             OpSelectionMerge %79 None 
					                                             OpBranchConditional %75 %78 %81 
					                                     %78 = OpLabel 
					                               f32_2 %80 = OpLoad %46 
					                                             OpStore %77 %80 
					                                             OpBranch %79 
					                                     %81 = OpLabel 
					                               f32_4 %82 = OpLoad %9 
					                               f32_2 %83 = OpVectorShuffle %82 %82 0 1 
					                                             OpStore %77 %83 
					                                             OpBranch %79 
					                                     %79 = OpLabel 
					                               f32_2 %84 = OpLoad %77 
					                               f32_4 %85 = OpLoad %9 
					                               f32_4 %86 = OpVectorShuffle %85 %84 4 5 2 3 
					                                             OpStore %9 %86 
					                               f32_4 %87 = OpLoad %9 
					                               f32_2 %88 = OpVectorShuffle %87 %87 0 1 
					                               f32_4 %89 = OpLoad %9 
					                               f32_2 %90 = OpVectorShuffle %89 %89 0 1 
					                                 f32 %91 = OpDot %88 %90 
					                        Private f32* %92 = OpAccessChain %46 %61 
					                                             OpStore %92 %91 
					                      Uniform f32_4* %93 = OpAccessChain %12 %14 
					                               f32_4 %94 = OpLoad %93 
					                               f32_4 %95 = OpVectorShuffle %94 %94 0 1 0 1 
					                               f32_4 %97 = OpFMul %95 %96 
					                               f32_2 %98 = OpLoad vs_TEXCOORD0 
					                               f32_4 %99 = OpVectorShuffle %98 %98 0 1 0 1 
					                              f32_4 %100 = OpFAdd %97 %99 
					                                             OpStore %54 %100 
					                read_only Texture2D %101 = OpLoad %31 
					                            sampler %102 = OpLoad %35 
					         read_only Texture2DSampled %103 = OpSampledImage %101 %102 
					                              f32_4 %104 = OpLoad %54 
					                              f32_2 %105 = OpVectorShuffle %104 %104 0 1 
					                              f32_4 %106 = OpImageSampleImplicitLod %103 %105 
					                              f32_2 %107 = OpVectorShuffle %106 %106 0 1 
					                              f32_4 %108 = OpLoad %54 
					                              f32_4 %109 = OpVectorShuffle %108 %107 4 5 2 3 
					                                             OpStore %54 %109 
					                read_only Texture2D %111 = OpLoad %31 
					                            sampler %112 = OpLoad %35 
					         read_only Texture2DSampled %113 = OpSampledImage %111 %112 
					                              f32_4 %114 = OpLoad %54 
					                              f32_2 %115 = OpVectorShuffle %114 %114 2 3 
					                              f32_4 %116 = OpImageSampleImplicitLod %113 %115 
					                              f32_2 %117 = OpVectorShuffle %116 %116 0 1 
					                                             OpStore %110 %117 
					                              f32_4 %119 = OpLoad %54 
					                              f32_2 %120 = OpVectorShuffle %119 %119 0 1 
					                              f32_4 %121 = OpLoad %54 
					                              f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                f32 %123 = OpDot %120 %122 
					                                             OpStore %118 %123 
					                       Private f32* %125 = OpAccessChain %46 %61 
					                                f32 %126 = OpLoad %125 
					                                f32 %127 = OpLoad %118 
					                               bool %128 = OpFOrdLessThan %126 %127 
					                                             OpStore %124 %128 
					                               bool %129 = OpLoad %124 
					                                             OpSelectionMerge %132 None 
					                                             OpBranchConditional %129 %131 %135 
					                                    %131 = OpLabel 
					                              f32_4 %133 = OpLoad %54 
					                              f32_2 %134 = OpVectorShuffle %133 %133 0 1 
					                                             OpStore %130 %134 
					                                             OpBranch %132 
					                                    %135 = OpLabel 
					                              f32_4 %136 = OpLoad %9 
					                              f32_2 %137 = OpVectorShuffle %136 %136 0 1 
					                                             OpStore %130 %137 
					                                             OpBranch %132 
					                                    %132 = OpLabel 
					                              f32_2 %138 = OpLoad %130 
					                              f32_4 %139 = OpLoad %9 
					                              f32_4 %140 = OpVectorShuffle %139 %138 4 5 2 3 
					                                             OpStore %9 %140 
					                              f32_4 %141 = OpLoad %9 
					                              f32_2 %142 = OpVectorShuffle %141 %141 0 1 
					                              f32_4 %143 = OpLoad %9 
					                              f32_2 %144 = OpVectorShuffle %143 %143 0 1 
					                                f32 %145 = OpDot %142 %144 
					                       Private f32* %146 = OpAccessChain %46 %61 
					                                             OpStore %146 %145 
					                              f32_2 %147 = OpLoad %110 
					                              f32_2 %148 = OpLoad %110 
					                                f32 %149 = OpDot %147 %148 
					                                             OpStore %118 %149 
					                       Private f32* %150 = OpAccessChain %46 %61 
					                                f32 %151 = OpLoad %150 
					                                f32 %152 = OpLoad %118 
					                               bool %153 = OpFOrdLessThan %151 %152 
					                                             OpStore %124 %153 
					                               bool %156 = OpLoad %124 
					                                             OpSelectionMerge %159 None 
					                                             OpBranchConditional %156 %158 %161 
					                                    %158 = OpLabel 
					                              f32_2 %160 = OpLoad %110 
					                                             OpStore %157 %160 
					                                             OpBranch %159 
					                                    %161 = OpLabel 
					                              f32_4 %162 = OpLoad %9 
					                              f32_2 %163 = OpVectorShuffle %162 %162 0 1 
					                                             OpStore %157 %163 
					                                             OpBranch %159 
					                                    %159 = OpLabel 
					                              f32_2 %164 = OpLoad %157 
					                              f32_4 %165 = OpLoad %155 
					                              f32_4 %166 = OpVectorShuffle %165 %164 4 5 2 3 
					                                             OpStore %155 %166 
					                              f32_4 %169 = OpLoad %155 
					                              f32_4 %170 = OpVectorShuffle %169 %168 0 1 4 5 
					                                             OpStore %155 %170 
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
						vec4 unused_0_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat6;
					bool u_xlatb6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat6 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat9 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat0.xy : u_xlat1.xy;
					    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat9 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat2.xy : u_xlat0.xy;
					    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    SV_Target0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
					    SV_Target0.zw = vec2(0.0, 0.0);
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
			GpuProgramID 208174
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
						vec4 unused_0_2[6];
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
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	int _TileMaxLoop;
					uniform 	vec2 _TileMaxOffs;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					int u_xlati2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat10;
					vec2 u_xlat13;
					bool u_xlatb13;
					int u_xlati17;
					float u_xlat18;
					void main()
					{
					    u_xlat0.xy = _MainTex_TexelSize.xy * vec2(_TileMaxOffs.x, _TileMaxOffs.y) + vs_TEXCOORD0.xy;
					    u_xlat1.y = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xw = _MainTex_TexelSize.xy;
					    u_xlat10.x = float(0.0);
					    u_xlat10.y = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<_TileMaxLoop ; u_xlati_loop_1++)
					    {
					        u_xlat7.x = float(u_xlati_loop_1);
					        u_xlat7.xy = u_xlat1.xy * u_xlat7.xx + u_xlat0.xy;
					        u_xlat3.xy = u_xlat10.xy;
					        for(int u_xlati_loop_2 = 0 ; u_xlati_loop_2<_TileMaxLoop ; u_xlati_loop_2++)
					        {
					            u_xlat13.x = float(u_xlati_loop_2);
					            u_xlat13.xy = u_xlat1.zw * u_xlat13.xx + u_xlat7.xy;
					            u_xlat4 = texture(_MainTex, u_xlat13.xy);
					            u_xlat13.x = dot(u_xlat3.xy, u_xlat3.xy);
					            u_xlat18 = dot(u_xlat4.xy, u_xlat4.xy);
					            u_xlatb13 = u_xlat13.x<u_xlat18;
					            u_xlat3.xy = (bool(u_xlatb13)) ? u_xlat4.xy : u_xlat3.xy;
					        }
					        u_xlat10.xy = u_xlat3.xy;
					    }
					    SV_Target0.xy = u_xlat10.xy;
					    SV_Target0.zw = vec2(0.0, 0.0);
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
					; Bound: 152
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %32 %139 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpMemberDecorate %12 0 Offset 12 
					                                              OpMemberDecorate %12 1 Offset 12 
					                                              OpMemberDecorate %12 2 Offset 12 
					                                              OpDecorate %12 Block 
					                                              OpDecorate %14 DescriptorSet 14 
					                                              OpDecorate %14 Binding 14 
					                                              OpDecorate vs_TEXCOORD0 Location 32 
					                                              OpDecorate %100 DescriptorSet 100 
					                                              OpDecorate %100 Binding 100 
					                                              OpDecorate %104 DescriptorSet 104 
					                                              OpDecorate %104 Binding 104 
					                                              OpDecorate %139 Location 139 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 2 
					                                       %8 = OpTypePointer Private %7 
					                        Private f32_2* %9 = OpVariable Private 
					                                      %10 = OpTypeVector %6 4 
					                                      %11 = OpTypeInt 32 1 
					                                      %12 = OpTypeStruct %10 %11 %7 
					                                      %13 = OpTypePointer Uniform %12 
					 Uniform struct {f32_4; i32; f32_2;}* %14 = OpVariable Uniform 
					                                  i32 %15 = OpConstant 0 
					                                      %16 = OpTypePointer Uniform %10 
					                                  i32 %20 = OpConstant 2 
					                                      %21 = OpTypeInt 32 0 
					                                  u32 %22 = OpConstant 0 
					                                      %23 = OpTypePointer Uniform %6 
					                                  u32 %26 = OpConstant 1 
					                                      %31 = OpTypePointer Input %7 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                      %35 = OpTypePointer Private %10 
					                       Private f32_4* %36 = OpVariable Private 
					                                  f32 %37 = OpConstant 3,674022E-40 
					                                      %38 = OpTypePointer Private %6 
					                                  u32 %40 = OpConstant 2 
					                       Private f32_2* %47 = OpVariable Private 
					                                      %50 = OpTypePointer Function %11 
					                                  i32 %58 = OpConstant 1 
					                                      %59 = OpTypePointer Uniform %11 
					                                      %62 = OpTypeBool 
					                       Private f32_2* %64 = OpVariable Private 
					                       Private f32_2* %75 = OpVariable Private 
					                       Private f32_2* %87 = OpVariable Private 
					                                      %98 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                      %99 = OpTypePointer UniformConstant %98 
					UniformConstant read_only Texture2D* %100 = OpVariable UniformConstant 
					                                     %102 = OpTypeSampler 
					                                     %103 = OpTypePointer UniformConstant %102 
					            UniformConstant sampler* %104 = OpVariable UniformConstant 
					                                     %106 = OpTypeSampledImage %98 
					                        Private f32* %111 = OpVariable Private 
					                        Private f32* %115 = OpVariable Private 
					                                     %119 = OpTypePointer Private %62 
					                       Private bool* %120 = OpVariable Private 
					                                     %125 = OpTypePointer Function %7 
					                                     %138 = OpTypePointer Output %10 
					                       Output f32_4* %139 = OpVariable Output 
					                               f32_2 %143 = OpConstantComposite %37 %37 
					                                     %147 = OpTypePointer Private %11 
					                        Private i32* %148 = OpVariable Private 
					                       Private bool* %149 = OpVariable Private 
					                       Private bool* %150 = OpVariable Private 
					                        Private i32* %151 = OpVariable Private 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                        Function i32* %51 = OpVariable Function 
					                        Function i32* %77 = OpVariable Function 
					                     Function f32_2* %126 = OpVariable Function 
					                       Uniform f32_4* %17 = OpAccessChain %14 %15 
					                                f32_4 %18 = OpLoad %17 
					                                f32_2 %19 = OpVectorShuffle %18 %18 0 1 
					                         Uniform f32* %24 = OpAccessChain %14 %20 %22 
					                                  f32 %25 = OpLoad %24 
					                         Uniform f32* %27 = OpAccessChain %14 %20 %26 
					                                  f32 %28 = OpLoad %27 
					                                f32_2 %29 = OpCompositeConstruct %25 %28 
					                                f32_2 %30 = OpFMul %19 %29 
					                                f32_2 %33 = OpLoad vs_TEXCOORD0 
					                                f32_2 %34 = OpFAdd %30 %33 
					                                              OpStore %9 %34 
					                         Private f32* %39 = OpAccessChain %36 %26 
					                                              OpStore %39 %37 
					                         Private f32* %41 = OpAccessChain %36 %40 
					                                              OpStore %41 %37 
					                       Uniform f32_4* %42 = OpAccessChain %14 %15 
					                                f32_4 %43 = OpLoad %42 
					                                f32_2 %44 = OpVectorShuffle %43 %43 0 1 
					                                f32_4 %45 = OpLoad %36 
					                                f32_4 %46 = OpVectorShuffle %45 %44 4 1 2 5 
					                                              OpStore %36 %46 
					                         Private f32* %48 = OpAccessChain %47 %22 
					                                              OpStore %48 %37 
					                         Private f32* %49 = OpAccessChain %47 %26 
					                                              OpStore %49 %37 
					                                              OpStore %51 %15 
					                                              OpBranch %52 
					                                      %52 = OpLabel 
					                                              OpLoopMerge %54 %55 None 
					                                              OpBranch %56 
					                                      %56 = OpLabel 
					                                  i32 %57 = OpLoad %51 
					                         Uniform i32* %60 = OpAccessChain %14 %58 
					                                  i32 %61 = OpLoad %60 
					                                 bool %63 = OpSLessThan %57 %61 
					                                              OpBranchConditional %63 %53 %54 
					                                      %53 = OpLabel 
					                                  i32 %65 = OpLoad %51 
					                                  f32 %66 = OpConvertSToF %65 
					                         Private f32* %67 = OpAccessChain %64 %22 
					                                              OpStore %67 %66 
					                                f32_4 %68 = OpLoad %36 
					                                f32_2 %69 = OpVectorShuffle %68 %68 0 1 
					                                f32_2 %70 = OpLoad %64 
					                                f32_2 %71 = OpVectorShuffle %70 %70 0 0 
					                                f32_2 %72 = OpFMul %69 %71 
					                                f32_2 %73 = OpLoad %9 
					                                f32_2 %74 = OpFAdd %72 %73 
					                                              OpStore %64 %74 
					                                f32_2 %76 = OpLoad %47 
					                                              OpStore %75 %76 
					                                              OpStore %77 %15 
					                                              OpBranch %78 
					                                      %78 = OpLabel 
					                                              OpLoopMerge %80 %81 None 
					                                              OpBranch %82 
					                                      %82 = OpLabel 
					                                  i32 %83 = OpLoad %77 
					                         Uniform i32* %84 = OpAccessChain %14 %58 
					                                  i32 %85 = OpLoad %84 
					                                 bool %86 = OpSLessThan %83 %85 
					                                              OpBranchConditional %86 %79 %80 
					                                      %79 = OpLabel 
					                                  i32 %88 = OpLoad %77 
					                                  f32 %89 = OpConvertSToF %88 
					                         Private f32* %90 = OpAccessChain %87 %22 
					                                              OpStore %90 %89 
					                                f32_4 %91 = OpLoad %36 
					                                f32_2 %92 = OpVectorShuffle %91 %91 2 3 
					                                f32_2 %93 = OpLoad %87 
					                                f32_2 %94 = OpVectorShuffle %93 %93 0 0 
					                                f32_2 %95 = OpFMul %92 %94 
					                                f32_2 %96 = OpLoad %64 
					                                f32_2 %97 = OpFAdd %95 %96 
					                                              OpStore %87 %97 
					                 read_only Texture2D %101 = OpLoad %100 
					                             sampler %105 = OpLoad %104 
					          read_only Texture2DSampled %107 = OpSampledImage %101 %105 
					                               f32_2 %108 = OpLoad %87 
					                               f32_4 %109 = OpImageSampleImplicitLod %107 %108 
					                               f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                              OpStore %87 %110 
					                               f32_2 %112 = OpLoad %75 
					                               f32_2 %113 = OpLoad %75 
					                                 f32 %114 = OpDot %112 %113 
					                                              OpStore %111 %114 
					                               f32_2 %116 = OpLoad %87 
					                               f32_2 %117 = OpLoad %87 
					                                 f32 %118 = OpDot %116 %117 
					                                              OpStore %115 %118 
					                                 f32 %121 = OpLoad %111 
					                                 f32 %122 = OpLoad %115 
					                                bool %123 = OpFOrdLessThan %121 %122 
					                                              OpStore %120 %123 
					                                bool %124 = OpLoad %120 
					                                              OpSelectionMerge %128 None 
					                                              OpBranchConditional %124 %127 %130 
					                                     %127 = OpLabel 
					                               f32_2 %129 = OpLoad %87 
					                                              OpStore %126 %129 
					                                              OpBranch %128 
					                                     %130 = OpLabel 
					                               f32_2 %131 = OpLoad %75 
					                                              OpStore %126 %131 
					                                              OpBranch %128 
					                                     %128 = OpLabel 
					                               f32_2 %132 = OpLoad %126 
					                                              OpStore %75 %132 
					                                              OpBranch %81 
					                                      %81 = OpLabel 
					                                 i32 %133 = OpLoad %77 
					                                 i32 %134 = OpIAdd %133 %58 
					                                              OpStore %77 %134 
					                                              OpBranch %78 
					                                      %80 = OpLabel 
					                               f32_2 %135 = OpLoad %75 
					                                              OpStore %47 %135 
					                                              OpBranch %55 
					                                      %55 = OpLabel 
					                                 i32 %136 = OpLoad %51 
					                                 i32 %137 = OpIAdd %136 %58 
					                                              OpStore %51 %137 
					                                              OpBranch %52 
					                                      %54 = OpLabel 
					                               f32_2 %140 = OpLoad %47 
					                               f32_4 %141 = OpLoad %139 
					                               f32_4 %142 = OpVectorShuffle %141 %140 4 5 2 3 
					                                              OpStore %139 %142 
					                               f32_4 %144 = OpLoad %139 
					                               f32_4 %145 = OpVectorShuffle %144 %143 0 1 4 5 
					                                              OpStore %139 %145 
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
						vec4 unused_0_2[2];
						int _TileMaxLoop;
						vec2 _TileMaxOffs;
						vec4 unused_0_5;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					int u_xlati2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat10;
					vec2 u_xlat13;
					bool u_xlatb13;
					int u_xlati17;
					float u_xlat18;
					void main()
					{
					    u_xlat0.xy = _MainTex_TexelSize.xy * vec2(_TileMaxOffs.x, _TileMaxOffs.y) + vs_TEXCOORD0.xy;
					    u_xlat1.y = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xw = _MainTex_TexelSize.xy;
					    u_xlat10.x = float(0.0);
					    u_xlat10.y = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<_TileMaxLoop ; u_xlati_loop_1++)
					    {
					        u_xlat7.x = float(u_xlati_loop_1);
					        u_xlat7.xy = u_xlat1.xy * u_xlat7.xx + u_xlat0.xy;
					        u_xlat3.xy = u_xlat10.xy;
					        for(int u_xlati_loop_2 = 0 ; u_xlati_loop_2<_TileMaxLoop ; u_xlati_loop_2++)
					        {
					            u_xlat13.x = float(u_xlati_loop_2);
					            u_xlat13.xy = u_xlat1.zw * u_xlat13.xx + u_xlat7.xy;
					            u_xlat4 = texture(_MainTex, u_xlat13.xy);
					            u_xlat13.x = dot(u_xlat3.xy, u_xlat3.xy);
					            u_xlat18 = dot(u_xlat4.xy, u_xlat4.xy);
					            u_xlatb13 = u_xlat13.x<u_xlat18;
					            u_xlat3.xy = (bool(u_xlatb13)) ? u_xlat4.xy : u_xlat3.xy;
					        }
					        u_xlat10.xy = u_xlat3.xy;
					    }
					    SV_Target0.xy = u_xlat10.xy;
					    SV_Target0.zw = vec2(0.0, 0.0);
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
			GpuProgramID 301335
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
						vec4 unused_0_2[6];
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
					uniform 	vec4 _MainTex_TexelSize;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat8;
					bool u_xlatb8;
					vec2 u_xlat9;
					float u_xlat12;
					bool u_xlatb12;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat8 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlatb8 = u_xlat8<u_xlat12;
					    u_xlat0.xy = (bool(u_xlatb8)) ? u_xlat0.xy : u_xlat1.xy;
					    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, -1.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlatb8 = u_xlat12<u_xlat8;
					    u_xlat0.xy = (bool(u_xlatb8)) ? u_xlat0.xy : u_xlat2.xy;
					    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat12 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat9.xy = u_xlat2.xy * vec2(1.00999999, 1.00999999);
					    u_xlat2.x = dot(u_xlat9.xy, u_xlat9.xy);
					    u_xlatb12 = u_xlat2.x<u_xlat12;
					    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : u_xlat9.xy;
					    u_xlat12 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat2 = (-_MainTex_TexelSize.xyxy) * vec4(-1.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat3 = texture(_MainTex, u_xlat2.zw);
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat9.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlatb12 = u_xlat9.x<u_xlat12;
					    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : u_xlat3.xy;
					    u_xlat12 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb8 = u_xlat12<u_xlat8;
					    u_xlat0.xy = (bool(u_xlatb8)) ? u_xlat0.xy : u_xlat1.xy;
					    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 1.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat3 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat9.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlatb12 = u_xlat9.x<u_xlat12;
					    u_xlat9.xy = (bool(u_xlatb12)) ? u_xlat2.xy : u_xlat3.xy;
					    u_xlat12 = dot(u_xlat9.xy, u_xlat9.xy);
					    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb12 = u_xlat2.x<u_xlat12;
					    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat9.xy : u_xlat1.xy;
					    u_xlat12 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb8 = u_xlat12<u_xlat8;
					    u_xlat0.xy = (bool(u_xlatb8)) ? u_xlat0.xy : u_xlat1.xy;
					    SV_Target0.xy = u_xlat0.xy * vec2(0.990099013, 0.990099013);
					    SV_Target0.zw = vec2(0.0, 0.0);
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
					; Bound: 359
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %25 %347 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %10 0 Offset 10 
					                                             OpDecorate %10 Block 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate vs_TEXCOORD0 Location 25 
					                                             OpDecorate %31 DescriptorSet 31 
					                                             OpDecorate %31 Binding 31 
					                                             OpDecorate %35 DescriptorSet 35 
					                                             OpDecorate %35 Binding 35 
					                                             OpDecorate %347 Location 347 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeStruct %7 
					                                     %11 = OpTypePointer Uniform %10 
					            Uniform struct {f32_4;}* %12 = OpVariable Uniform 
					                                     %13 = OpTypeInt 32 1 
					                                 i32 %14 = OpConstant 0 
					                                     %15 = OpTypePointer Uniform %7 
					                                 f32 %19 = OpConstant 3,674022E-40 
					                                 f32 %20 = OpConstant 3,674022E-40 
					                               f32_4 %21 = OpConstantComposite %19 %20 %20 %20 
					                                     %23 = OpTypeVector %6 2 
					                                     %24 = OpTypePointer Input %23 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %29 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %30 = OpTypePointer UniformConstant %29 
					UniformConstant read_only Texture2D* %31 = OpVariable UniformConstant 
					                                     %33 = OpTypeSampler 
					                                     %34 = OpTypePointer UniformConstant %33 
					            UniformConstant sampler* %35 = OpVariable UniformConstant 
					                                     %37 = OpTypeSampledImage %29 
					                                     %45 = OpTypePointer Private %23 
					                      Private f32_2* %46 = OpVariable Private 
					                      Private f32_4* %54 = OpVariable Private 
					                                     %60 = OpTypeInt 32 0 
					                                 u32 %61 = OpConstant 0 
					                                     %62 = OpTypePointer Private %6 
					                        Private f32* %64 = OpVariable Private 
					                                     %68 = OpTypeBool 
					                                     %69 = OpTypePointer Private %68 
					                       Private bool* %70 = OpVariable Private 
					                                     %76 = OpTypePointer Function %23 
					                                 f32 %96 = OpConstant 3,674022E-40 
					                               f32_4 %97 = OpConstantComposite %20 %19 %96 %20 
					                     Private f32_2* %102 = OpVariable Private 
					                       Private f32* %119 = OpVariable Private 
					                      Private bool* %123 = OpVariable Private 
					                                f32 %157 = OpConstant 3,674022E-40 
					                              f32_2 %158 = OpConstantComposite %157 %157 
					                     Private f32_4* %160 = OpVariable Private 
					                      Private bool* %165 = OpVariable Private 
					                              f32_4 %190 = OpConstantComposite %96 %20 %20 %19 
					                       Private f32* %211 = OpVariable Private 
					                              f32_4 %265 = OpConstantComposite %20 %20 %19 %20 
					                                    %346 = OpTypePointer Output %7 
					                      Output f32_4* %347 = OpVariable Output 
					                                f32 %350 = OpConstant 3,674022E-40 
					                              f32_2 %351 = OpConstantComposite %350 %350 
					                              f32_2 %355 = OpConstantComposite %19 %19 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                     Function f32_2* %77 = OpVariable Function 
					                    Function f32_2* %129 = OpVariable Function 
					                    Function f32_2* %171 = OpVariable Function 
					                    Function f32_2* %219 = OpVariable Function 
					                    Function f32_2* %239 = OpVariable Function 
					                    Function f32_2* %293 = OpVariable Function 
					                    Function f32_2* %315 = OpVariable Function 
					                    Function f32_2* %335 = OpVariable Function 
					                      Uniform f32_4* %16 = OpAccessChain %12 %14 
					                               f32_4 %17 = OpLoad %16 
					                               f32_4 %18 = OpVectorShuffle %17 %17 1 1 0 1 
					                               f32_4 %22 = OpFMul %18 %21 
					                               f32_2 %26 = OpLoad vs_TEXCOORD0 
					                               f32_4 %27 = OpVectorShuffle %26 %26 0 1 0 1 
					                               f32_4 %28 = OpFAdd %22 %27 
					                                             OpStore %9 %28 
					                 read_only Texture2D %32 = OpLoad %31 
					                             sampler %36 = OpLoad %35 
					          read_only Texture2DSampled %38 = OpSampledImage %32 %36 
					                               f32_4 %39 = OpLoad %9 
					                               f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                               f32_4 %41 = OpImageSampleImplicitLod %38 %40 
					                               f32_2 %42 = OpVectorShuffle %41 %41 0 1 
					                               f32_4 %43 = OpLoad %9 
					                               f32_4 %44 = OpVectorShuffle %43 %42 4 5 2 3 
					                                             OpStore %9 %44 
					                 read_only Texture2D %47 = OpLoad %31 
					                             sampler %48 = OpLoad %35 
					          read_only Texture2DSampled %49 = OpSampledImage %47 %48 
					                               f32_4 %50 = OpLoad %9 
					                               f32_2 %51 = OpVectorShuffle %50 %50 2 3 
					                               f32_4 %52 = OpImageSampleImplicitLod %49 %51 
					                               f32_2 %53 = OpVectorShuffle %52 %52 0 1 
					                                             OpStore %46 %53 
					                               f32_4 %55 = OpLoad %9 
					                               f32_2 %56 = OpVectorShuffle %55 %55 0 1 
					                               f32_4 %57 = OpLoad %9 
					                               f32_2 %58 = OpVectorShuffle %57 %57 0 1 
					                                 f32 %59 = OpDot %56 %58 
					                        Private f32* %63 = OpAccessChain %54 %61 
					                                             OpStore %63 %59 
					                               f32_2 %65 = OpLoad %46 
					                               f32_2 %66 = OpLoad %46 
					                                 f32 %67 = OpDot %65 %66 
					                                             OpStore %64 %67 
					                        Private f32* %71 = OpAccessChain %54 %61 
					                                 f32 %72 = OpLoad %71 
					                                 f32 %73 = OpLoad %64 
					                                bool %74 = OpFOrdLessThan %72 %73 
					                                             OpStore %70 %74 
					                                bool %75 = OpLoad %70 
					                                             OpSelectionMerge %79 None 
					                                             OpBranchConditional %75 %78 %81 
					                                     %78 = OpLabel 
					                               f32_2 %80 = OpLoad %46 
					                                             OpStore %77 %80 
					                                             OpBranch %79 
					                                     %81 = OpLabel 
					                               f32_4 %82 = OpLoad %9 
					                               f32_2 %83 = OpVectorShuffle %82 %82 0 1 
					                                             OpStore %77 %83 
					                                             OpBranch %79 
					                                     %79 = OpLabel 
					                               f32_2 %84 = OpLoad %77 
					                               f32_4 %85 = OpLoad %9 
					                               f32_4 %86 = OpVectorShuffle %85 %84 4 5 2 3 
					                                             OpStore %9 %86 
					                               f32_4 %87 = OpLoad %9 
					                               f32_2 %88 = OpVectorShuffle %87 %87 0 1 
					                               f32_4 %89 = OpLoad %9 
					                               f32_2 %90 = OpVectorShuffle %89 %89 0 1 
					                                 f32 %91 = OpDot %88 %90 
					                        Private f32* %92 = OpAccessChain %46 %61 
					                                             OpStore %92 %91 
					                      Uniform f32_4* %93 = OpAccessChain %12 %14 
					                               f32_4 %94 = OpLoad %93 
					                               f32_4 %95 = OpVectorShuffle %94 %94 0 1 0 1 
					                               f32_4 %98 = OpFMul %95 %97 
					                               f32_2 %99 = OpLoad vs_TEXCOORD0 
					                              f32_4 %100 = OpVectorShuffle %99 %99 0 1 0 1 
					                              f32_4 %101 = OpFAdd %98 %100 
					                                             OpStore %54 %101 
					                read_only Texture2D %103 = OpLoad %31 
					                            sampler %104 = OpLoad %35 
					         read_only Texture2DSampled %105 = OpSampledImage %103 %104 
					                              f32_4 %106 = OpLoad %54 
					                              f32_2 %107 = OpVectorShuffle %106 %106 2 3 
					                              f32_4 %108 = OpImageSampleImplicitLod %105 %107 
					                              f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                                             OpStore %102 %109 
					                read_only Texture2D %110 = OpLoad %31 
					                            sampler %111 = OpLoad %35 
					         read_only Texture2DSampled %112 = OpSampledImage %110 %111 
					                              f32_4 %113 = OpLoad %54 
					                              f32_2 %114 = OpVectorShuffle %113 %113 0 1 
					                              f32_4 %115 = OpImageSampleImplicitLod %112 %114 
					                              f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                              f32_4 %117 = OpLoad %54 
					                              f32_4 %118 = OpVectorShuffle %117 %116 4 5 2 3 
					                                             OpStore %54 %118 
					                              f32_2 %120 = OpLoad %102 
					                              f32_2 %121 = OpLoad %102 
					                                f32 %122 = OpDot %120 %121 
					                                             OpStore %119 %122 
					                                f32 %124 = OpLoad %119 
					                       Private f32* %125 = OpAccessChain %46 %61 
					                                f32 %126 = OpLoad %125 
					                               bool %127 = OpFOrdLessThan %124 %126 
					                                             OpStore %123 %127 
					                               bool %128 = OpLoad %123 
					                                             OpSelectionMerge %131 None 
					                                             OpBranchConditional %128 %130 %134 
					                                    %130 = OpLabel 
					                              f32_4 %132 = OpLoad %9 
					                              f32_2 %133 = OpVectorShuffle %132 %132 0 1 
					                                             OpStore %129 %133 
					                                             OpBranch %131 
					                                    %134 = OpLabel 
					                              f32_2 %135 = OpLoad %102 
					                                             OpStore %129 %135 
					                                             OpBranch %131 
					                                    %131 = OpLabel 
					                              f32_2 %136 = OpLoad %129 
					                              f32_4 %137 = OpLoad %9 
					                              f32_4 %138 = OpVectorShuffle %137 %136 4 5 2 3 
					                                             OpStore %9 %138 
					                              f32_4 %139 = OpLoad %9 
					                              f32_2 %140 = OpVectorShuffle %139 %139 0 1 
					                              f32_4 %141 = OpLoad %9 
					                              f32_2 %142 = OpVectorShuffle %141 %141 0 1 
					                                f32 %143 = OpDot %140 %142 
					                       Private f32* %144 = OpAccessChain %46 %61 
					                                             OpStore %144 %143 
					                              f32_4 %145 = OpLoad %54 
					                              f32_2 %146 = OpVectorShuffle %145 %145 0 1 
					                              f32_4 %147 = OpLoad %54 
					                              f32_2 %148 = OpVectorShuffle %147 %147 0 1 
					                                f32 %149 = OpDot %146 %148 
					                                             OpStore %119 %149 
					                read_only Texture2D %150 = OpLoad %31 
					                            sampler %151 = OpLoad %35 
					         read_only Texture2DSampled %152 = OpSampledImage %150 %151 
					                              f32_2 %153 = OpLoad vs_TEXCOORD0 
					                              f32_4 %154 = OpImageSampleImplicitLod %152 %153 
					                              f32_2 %155 = OpVectorShuffle %154 %154 0 1 
					                                             OpStore %102 %155 
					                              f32_2 %156 = OpLoad %102 
					                              f32_2 %159 = OpFMul %156 %158 
					                                             OpStore %102 %159 
					                              f32_2 %161 = OpLoad %102 
					                              f32_2 %162 = OpLoad %102 
					                                f32 %163 = OpDot %161 %162 
					                       Private f32* %164 = OpAccessChain %160 %61 
					                                             OpStore %164 %163 
					                       Private f32* %166 = OpAccessChain %160 %61 
					                                f32 %167 = OpLoad %166 
					                                f32 %168 = OpLoad %119 
					                               bool %169 = OpFOrdLessThan %167 %168 
					                                             OpStore %165 %169 
					                               bool %170 = OpLoad %165 
					                                             OpSelectionMerge %173 None 
					                                             OpBranchConditional %170 %172 %176 
					                                    %172 = OpLabel 
					                              f32_4 %174 = OpLoad %54 
					                              f32_2 %175 = OpVectorShuffle %174 %174 0 1 
					                                             OpStore %171 %175 
					                                             OpBranch %173 
					                                    %176 = OpLabel 
					                              f32_2 %177 = OpLoad %102 
					                                             OpStore %171 %177 
					                                             OpBranch %173 
					                                    %173 = OpLabel 
					                              f32_2 %178 = OpLoad %171 
					                              f32_4 %179 = OpLoad %54 
					                              f32_4 %180 = OpVectorShuffle %179 %178 4 5 2 3 
					                                             OpStore %54 %180 
					                              f32_4 %181 = OpLoad %54 
					                              f32_2 %182 = OpVectorShuffle %181 %181 0 1 
					                              f32_4 %183 = OpLoad %54 
					                              f32_2 %184 = OpVectorShuffle %183 %183 0 1 
					                                f32 %185 = OpDot %182 %184 
					                                             OpStore %119 %185 
					                     Uniform f32_4* %186 = OpAccessChain %12 %14 
					                              f32_4 %187 = OpLoad %186 
					                              f32_4 %188 = OpVectorShuffle %187 %187 0 1 0 1 
					                              f32_4 %189 = OpFNegate %188 
					                              f32_4 %191 = OpFMul %189 %190 
					                              f32_2 %192 = OpLoad vs_TEXCOORD0 
					                              f32_4 %193 = OpVectorShuffle %192 %192 0 1 0 1 
					                              f32_4 %194 = OpFAdd %191 %193 
					                                             OpStore %160 %194 
					                read_only Texture2D %195 = OpLoad %31 
					                            sampler %196 = OpLoad %35 
					         read_only Texture2DSampled %197 = OpSampledImage %195 %196 
					                              f32_4 %198 = OpLoad %160 
					                              f32_2 %199 = OpVectorShuffle %198 %198 2 3 
					                              f32_4 %200 = OpImageSampleImplicitLod %197 %199 
					                              f32_2 %201 = OpVectorShuffle %200 %200 0 1 
					                                             OpStore %102 %201 
					                read_only Texture2D %202 = OpLoad %31 
					                            sampler %203 = OpLoad %35 
					         read_only Texture2DSampled %204 = OpSampledImage %202 %203 
					                              f32_4 %205 = OpLoad %160 
					                              f32_2 %206 = OpVectorShuffle %205 %205 0 1 
					                              f32_4 %207 = OpImageSampleImplicitLod %204 %206 
					                              f32_2 %208 = OpVectorShuffle %207 %207 0 1 
					                              f32_4 %209 = OpLoad %160 
					                              f32_4 %210 = OpVectorShuffle %209 %208 4 5 2 3 
					                                             OpStore %160 %210 
					                              f32_2 %212 = OpLoad %102 
					                              f32_2 %213 = OpLoad %102 
					                                f32 %214 = OpDot %212 %213 
					                                             OpStore %211 %214 
					                                f32 %215 = OpLoad %211 
					                                f32 %216 = OpLoad %119 
					                               bool %217 = OpFOrdLessThan %215 %216 
					                                             OpStore %165 %217 
					                               bool %218 = OpLoad %165 
					                                             OpSelectionMerge %221 None 
					                                             OpBranchConditional %218 %220 %224 
					                                    %220 = OpLabel 
					                              f32_4 %222 = OpLoad %54 
					                              f32_2 %223 = OpVectorShuffle %222 %222 0 1 
					                                             OpStore %219 %223 
					                                             OpBranch %221 
					                                    %224 = OpLabel 
					                              f32_2 %225 = OpLoad %102 
					                                             OpStore %219 %225 
					                                             OpBranch %221 
					                                    %221 = OpLabel 
					                              f32_2 %226 = OpLoad %219 
					                              f32_4 %227 = OpLoad %54 
					                              f32_4 %228 = OpVectorShuffle %227 %226 4 5 2 3 
					                                             OpStore %54 %228 
					                              f32_4 %229 = OpLoad %54 
					                              f32_2 %230 = OpVectorShuffle %229 %229 0 1 
					                              f32_4 %231 = OpLoad %54 
					                              f32_2 %232 = OpVectorShuffle %231 %231 0 1 
					                                f32 %233 = OpDot %230 %232 
					                                             OpStore %119 %233 
					                                f32 %234 = OpLoad %119 
					                       Private f32* %235 = OpAccessChain %46 %61 
					                                f32 %236 = OpLoad %235 
					                               bool %237 = OpFOrdLessThan %234 %236 
					                                             OpStore %123 %237 
					                               bool %238 = OpLoad %123 
					                                             OpSelectionMerge %241 None 
					                                             OpBranchConditional %238 %240 %244 
					                                    %240 = OpLabel 
					                              f32_4 %242 = OpLoad %9 
					                              f32_2 %243 = OpVectorShuffle %242 %242 0 1 
					                                             OpStore %239 %243 
					                                             OpBranch %241 
					                                    %244 = OpLabel 
					                              f32_4 %245 = OpLoad %54 
					                              f32_2 %246 = OpVectorShuffle %245 %245 0 1 
					                                             OpStore %239 %246 
					                                             OpBranch %241 
					                                    %241 = OpLabel 
					                              f32_2 %247 = OpLoad %239 
					                              f32_4 %248 = OpLoad %9 
					                              f32_4 %249 = OpVectorShuffle %248 %247 4 5 2 3 
					                                             OpStore %9 %249 
					                              f32_4 %250 = OpLoad %9 
					                              f32_2 %251 = OpVectorShuffle %250 %250 0 1 
					                              f32_4 %252 = OpLoad %9 
					                              f32_2 %253 = OpVectorShuffle %252 %252 0 1 
					                                f32 %254 = OpDot %251 %253 
					                       Private f32* %255 = OpAccessChain %46 %61 
					                                             OpStore %255 %254 
					                              f32_4 %256 = OpLoad %160 
					                              f32_2 %257 = OpVectorShuffle %256 %256 0 1 
					                              f32_4 %258 = OpLoad %160 
					                              f32_2 %259 = OpVectorShuffle %258 %258 0 1 
					                                f32 %260 = OpDot %257 %259 
					                                             OpStore %119 %260 
					                     Uniform f32_4* %261 = OpAccessChain %12 %14 
					                              f32_4 %262 = OpLoad %261 
					                              f32_4 %263 = OpVectorShuffle %262 %262 0 1 1 1 
					                              f32_4 %264 = OpFNegate %263 
					                              f32_4 %266 = OpFMul %264 %265 
					                              f32_2 %267 = OpLoad vs_TEXCOORD0 
					                              f32_4 %268 = OpVectorShuffle %267 %267 0 1 0 1 
					                              f32_4 %269 = OpFAdd %266 %268 
					                                             OpStore %54 %269 
					                read_only Texture2D %270 = OpLoad %31 
					                            sampler %271 = OpLoad %35 
					         read_only Texture2DSampled %272 = OpSampledImage %270 %271 
					                              f32_4 %273 = OpLoad %54 
					                              f32_2 %274 = OpVectorShuffle %273 %273 2 3 
					                              f32_4 %275 = OpImageSampleImplicitLod %272 %274 
					                              f32_2 %276 = OpVectorShuffle %275 %275 0 1 
					                                             OpStore %102 %276 
					                read_only Texture2D %277 = OpLoad %31 
					                            sampler %278 = OpLoad %35 
					         read_only Texture2DSampled %279 = OpSampledImage %277 %278 
					                              f32_4 %280 = OpLoad %54 
					                              f32_2 %281 = OpVectorShuffle %280 %280 0 1 
					                              f32_4 %282 = OpImageSampleImplicitLod %279 %281 
					                              f32_2 %283 = OpVectorShuffle %282 %282 0 1 
					                              f32_4 %284 = OpLoad %54 
					                              f32_4 %285 = OpVectorShuffle %284 %283 4 5 2 3 
					                                             OpStore %54 %285 
					                              f32_2 %286 = OpLoad %102 
					                              f32_2 %287 = OpLoad %102 
					                                f32 %288 = OpDot %286 %287 
					                                             OpStore %211 %288 
					                                f32 %289 = OpLoad %211 
					                                f32 %290 = OpLoad %119 
					                               bool %291 = OpFOrdLessThan %289 %290 
					                                             OpStore %165 %291 
					                               bool %292 = OpLoad %165 
					                                             OpSelectionMerge %295 None 
					                                             OpBranchConditional %292 %294 %298 
					                                    %294 = OpLabel 
					                              f32_4 %296 = OpLoad %160 
					                              f32_2 %297 = OpVectorShuffle %296 %296 0 1 
					                                             OpStore %293 %297 
					                                             OpBranch %295 
					                                    %298 = OpLabel 
					                              f32_2 %299 = OpLoad %102 
					                                             OpStore %293 %299 
					                                             OpBranch %295 
					                                    %295 = OpLabel 
					                              f32_2 %300 = OpLoad %293 
					                                             OpStore %102 %300 
					                              f32_2 %301 = OpLoad %102 
					                              f32_2 %302 = OpLoad %102 
					                                f32 %303 = OpDot %301 %302 
					                                             OpStore %119 %303 
					                              f32_4 %304 = OpLoad %54 
					                              f32_2 %305 = OpVectorShuffle %304 %304 0 1 
					                              f32_4 %306 = OpLoad %54 
					                              f32_2 %307 = OpVectorShuffle %306 %306 0 1 
					                                f32 %308 = OpDot %305 %307 
					                       Private f32* %309 = OpAccessChain %160 %61 
					                                             OpStore %309 %308 
					                       Private f32* %310 = OpAccessChain %160 %61 
					                                f32 %311 = OpLoad %310 
					                                f32 %312 = OpLoad %119 
					                               bool %313 = OpFOrdLessThan %311 %312 
					                                             OpStore %165 %313 
					                               bool %314 = OpLoad %165 
					                                             OpSelectionMerge %317 None 
					                                             OpBranchConditional %314 %316 %319 
					                                    %316 = OpLabel 
					                              f32_2 %318 = OpLoad %102 
					                                             OpStore %315 %318 
					                                             OpBranch %317 
					                                    %319 = OpLabel 
					                              f32_4 %320 = OpLoad %54 
					                              f32_2 %321 = OpVectorShuffle %320 %320 0 1 
					                                             OpStore %315 %321 
					                                             OpBranch %317 
					                                    %317 = OpLabel 
					                              f32_2 %322 = OpLoad %315 
					                              f32_4 %323 = OpLoad %54 
					                              f32_4 %324 = OpVectorShuffle %323 %322 4 5 2 3 
					                                             OpStore %54 %324 
					                              f32_4 %325 = OpLoad %54 
					                              f32_2 %326 = OpVectorShuffle %325 %325 0 1 
					                              f32_4 %327 = OpLoad %54 
					                              f32_2 %328 = OpVectorShuffle %327 %327 0 1 
					                                f32 %329 = OpDot %326 %328 
					                                             OpStore %119 %329 
					                                f32 %330 = OpLoad %119 
					                       Private f32* %331 = OpAccessChain %46 %61 
					                                f32 %332 = OpLoad %331 
					                               bool %333 = OpFOrdLessThan %330 %332 
					                                             OpStore %123 %333 
					                               bool %334 = OpLoad %123 
					                                             OpSelectionMerge %337 None 
					                                             OpBranchConditional %334 %336 %340 
					                                    %336 = OpLabel 
					                              f32_4 %338 = OpLoad %9 
					                              f32_2 %339 = OpVectorShuffle %338 %338 0 1 
					                                             OpStore %335 %339 
					                                             OpBranch %337 
					                                    %340 = OpLabel 
					                              f32_4 %341 = OpLoad %54 
					                              f32_2 %342 = OpVectorShuffle %341 %341 0 1 
					                                             OpStore %335 %342 
					                                             OpBranch %337 
					                                    %337 = OpLabel 
					                              f32_2 %343 = OpLoad %335 
					                              f32_4 %344 = OpLoad %9 
					                              f32_4 %345 = OpVectorShuffle %344 %343 4 5 2 3 
					                                             OpStore %9 %345 
					                              f32_4 %348 = OpLoad %9 
					                              f32_2 %349 = OpVectorShuffle %348 %348 0 1 
					                              f32_2 %352 = OpFMul %349 %351 
					                              f32_4 %353 = OpLoad %347 
					                              f32_4 %354 = OpVectorShuffle %353 %352 4 5 2 3 
					                                             OpStore %347 %354 
					                              f32_4 %356 = OpLoad %347 
					                              f32_4 %357 = OpVectorShuffle %356 %355 0 1 4 5 
					                                             OpStore %347 %357 
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
						vec4 unused_0_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat8;
					bool u_xlatb8;
					vec2 u_xlat9;
					float u_xlat12;
					bool u_xlatb12;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat8 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlatb8 = u_xlat8<u_xlat12;
					    u_xlat0.xy = (bool(u_xlatb8)) ? u_xlat0.xy : u_xlat1.xy;
					    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, -1.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlatb8 = u_xlat12<u_xlat8;
					    u_xlat0.xy = (bool(u_xlatb8)) ? u_xlat0.xy : u_xlat2.xy;
					    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat12 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat9.xy = u_xlat2.xy * vec2(1.00999999, 1.00999999);
					    u_xlat2.x = dot(u_xlat9.xy, u_xlat9.xy);
					    u_xlatb12 = u_xlat2.x<u_xlat12;
					    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : u_xlat9.xy;
					    u_xlat12 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat2 = (-_MainTex_TexelSize.xyxy) * vec4(-1.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat3 = texture(_MainTex, u_xlat2.zw);
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat9.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlatb12 = u_xlat9.x<u_xlat12;
					    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : u_xlat3.xy;
					    u_xlat12 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb8 = u_xlat12<u_xlat8;
					    u_xlat0.xy = (bool(u_xlatb8)) ? u_xlat0.xy : u_xlat1.xy;
					    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 1.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat3 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat9.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlatb12 = u_xlat9.x<u_xlat12;
					    u_xlat9.xy = (bool(u_xlatb12)) ? u_xlat2.xy : u_xlat3.xy;
					    u_xlat12 = dot(u_xlat9.xy, u_xlat9.xy);
					    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb12 = u_xlat2.x<u_xlat12;
					    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat9.xy : u_xlat1.xy;
					    u_xlat12 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb8 = u_xlat12<u_xlat8;
					    u_xlat0.xy = (bool(u_xlatb8)) ? u_xlat0.xy : u_xlat1.xy;
					    SV_Target0.xy = u_xlat0.xy * vec2(0.990099013, 0.990099013);
					    SV_Target0.zw = vec2(0.0, 0.0);
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
			GpuProgramID 386820
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
						vec4 unused_0_2[6];
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
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	vec2 _VelocityTex_TexelSize;
					uniform 	vec2 _NeighborMaxTex_TexelSize;
					uniform 	float _MaxBlurRadius;
					uniform 	float _LoopCount;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _VelocityTex;
					UNITY_LOCATION(2) uniform  sampler2D _NeighborMaxTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec2 u_xlatb7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					float u_xlat14;
					float u_xlat21;
					vec2 u_xlat23;
					float u_xlat24;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					bool u_xlatb32;
					float u_xlat34;
					float u_xlat37;
					float u_xlat38;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(2.0, 0.0);
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    u_xlat1.xy = floor(u_xlat1.xy);
					    u_xlat1.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat1.xy);
					    u_xlat1.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 52.9829178;
					    u_xlat1.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 6.28318548;
					    u_xlat2.x = cos(u_xlat1.x);
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat1.xy = u_xlat2.xy * vec2(_NeighborMaxTex_TexelSize.x, _NeighborMaxTex_TexelSize.y);
					    u_xlat1.xy = u_xlat1.xy * vec2(0.25, 0.25) + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_NeighborMaxTex, u_xlat1.xy);
					    u_xlat21 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat21 = sqrt(u_xlat21);
					    u_xlatb31 = u_xlat21<2.0;
					    if(u_xlatb31){
					        SV_Target0 = u_xlat0;
					        return;
					    }
					    u_xlat2 = textureLod(_VelocityTex, vs_TEXCOORD0.xy, 0.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_MaxBlurRadius);
					    u_xlat31 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat31 = sqrt(u_xlat31);
					    u_xlat3.xy = max(vec2(u_xlat31), vec2(0.5, 1.0));
					    u_xlat31 = float(1.0) / u_xlat2.z;
					    u_xlat32 = u_xlat3.x + u_xlat3.x;
					    u_xlatb32 = u_xlat21<u_xlat32;
					    u_xlat3.x = u_xlat21 / u_xlat3.x;
					    u_xlat2.xy = u_xlat2.xy * u_xlat3.xx;
					    u_xlat2.xy = (bool(u_xlatb32)) ? u_xlat2.xy : u_xlat1.xy;
					    u_xlat32 = u_xlat21 * 0.5;
					    u_xlat32 = min(u_xlat32, _LoopCount);
					    u_xlat32 = floor(u_xlat32);
					    u_xlat3.x = float(1.0) / u_xlat32;
					    u_xlat23.xy = vs_TEXCOORD0.xy * _ScreenParams.xy;
					    u_xlat23.xy = floor(u_xlat23.xy);
					    u_xlat23.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat23.xy);
					    u_xlat3.z = fract(u_xlat23.x);
					    u_xlat23.xy = u_xlat3.zx * vec2(52.9829178, 0.25);
					    u_xlat23.x = fract(u_xlat23.x);
					    u_xlat23.x = u_xlat23.x + -0.5;
					    u_xlat4 = (-u_xlat3.x) * 0.5 + 1.0;
					    u_xlat5.w = 1.0;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat6.w = float(0.0);
					    u_xlat14 = u_xlat4;
					    u_xlat24 = 0.0;
					    u_xlat34 = u_xlat3.y;
					    while(true){
					        u_xlatb7.x = u_xlat23.y>=u_xlat14;
					        if(u_xlatb7.x){break;}
					        u_xlat7.xy = vec2(u_xlat24) * vec2(0.25, 0.5);
					        u_xlat7.xy = fract(u_xlat7.xy);
					        u_xlatb7.xy = lessThan(vec4(0.499000013, 0.499000013, 0.0, 0.0), u_xlat7.xyxx).xy;
					        u_xlat7.xz = (u_xlatb7.x) ? u_xlat2.xy : u_xlat1.xy;
					        u_xlat37 = (u_xlatb7.y) ? (-u_xlat14) : u_xlat14;
					        u_xlat37 = u_xlat23.x * u_xlat3.x + u_xlat37;
					        u_xlat7.xz = vec2(u_xlat37) * u_xlat7.xz;
					        u_xlat8.xy = u_xlat7.xz * _MainTex_TexelSize.xy + vs_TEXCOORD0.xy;
					        u_xlat7.xz = u_xlat7.xz * _VelocityTex_TexelSize.xy + vs_TEXCOORD0.xy;
					        u_xlat8 = textureLod(_MainTex, u_xlat8.xy, 0.0);
					        u_xlat9 = textureLod(_VelocityTex, u_xlat7.xz, 0.0);
					        u_xlat7.xz = u_xlat9.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					        u_xlat7.xz = u_xlat7.xz * vec2(_MaxBlurRadius);
					        u_xlat38 = u_xlat2.z + (-u_xlat9.z);
					        u_xlat38 = u_xlat31 * u_xlat38;
					        u_xlat38 = u_xlat38 * 20.0;
					        u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
					        u_xlat7.x = dot(u_xlat7.xz, u_xlat7.xz);
					        u_xlat7.x = sqrt(u_xlat7.x);
					        u_xlat7.x = (-u_xlat34) + u_xlat7.x;
					        u_xlat7.x = u_xlat38 * u_xlat7.x + u_xlat34;
					        u_xlat27 = (-u_xlat21) * abs(u_xlat37) + u_xlat7.x;
					        u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					        u_xlat27 = u_xlat27 / u_xlat7.x;
					        u_xlat37 = (-u_xlat14) + 1.20000005;
					        u_xlat27 = u_xlat37 * u_xlat27;
					        u_xlat5.xyz = u_xlat8.xyz;
					        u_xlat6 = u_xlat5 * vec4(u_xlat27) + u_xlat6;
					        u_xlat34 = max(u_xlat34, u_xlat7.x);
					        u_xlat5.x = (-u_xlat3.x) + u_xlat14;
					        u_xlat14 = (u_xlatb7.y) ? u_xlat5.x : u_xlat14;
					        u_xlat24 = u_xlat24 + 1.0;
					    }
					    u_xlat1.x = dot(vec2(u_xlat34), vec2(u_xlat32));
					    u_xlat1.x = 1.20000005 / u_xlat1.x;
					    u_xlat2.xyz = u_xlat0.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat1 = u_xlat2 * u_xlat1.xxxx + u_xlat6;
					    SV_Target0.xyz = u_xlat1.xyz / u_xlat1.www;
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
					; Bound: 550
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %22 %142 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %12 DescriptorSet 12 
					                                                      OpDecorate %12 Binding 12 
					                                                      OpDecorate %16 DescriptorSet 16 
					                                                      OpDecorate %16 Binding 16 
					                                                      OpDecorate vs_TEXCOORD0 Location 22 
					                                                      OpMemberDecorate %35 0 Offset 35 
					                                                      OpMemberDecorate %35 1 Offset 35 
					                                                      OpMemberDecorate %35 2 Offset 35 
					                                                      OpMemberDecorate %35 3 Offset 35 
					                                                      OpMemberDecorate %35 4 Offset 35 
					                                                      OpMemberDecorate %35 5 Offset 35 
					                                                      OpDecorate %35 Block 
					                                                      OpDecorate %37 DescriptorSet 37 
					                                                      OpDecorate %37 Binding 37 
					                                                      OpDecorate %114 DescriptorSet 114 
					                                                      OpDecorate %114 Binding 114 
					                                                      OpDecorate %116 DescriptorSet 116 
					                                                      OpDecorate %116 Binding 116 
					                                                      OpDecorate %142 Location 142 
					                                                      OpDecorate %145 DescriptorSet 145 
					                                                      OpDecorate %145 Binding 145 
					                                                      OpDecorate %147 DescriptorSet 147 
					                                                      OpDecorate %147 Binding 147 
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
					                               Private f32_4* %25 = OpVariable Private 
					                                          f32 %27 = OpConstant 3,674022E-40 
					                                          f32 %28 = OpConstant 3,674022E-40 
					                                        f32_2 %29 = OpConstantComposite %27 %28 
					                                              %35 = OpTypeStruct %7 %7 %20 %20 %6 %6 
					                                              %36 = OpTypePointer Uniform %35 
					Uniform struct {f32_4; f32_4; f32_2; f32_2; f32; f32;}* %37 = OpVariable Uniform 
					                                              %38 = OpTypeInt 32 1 
					                                          i32 %39 = OpConstant 0 
					                                              %40 = OpTypePointer Uniform %7 
					                                          f32 %52 = OpConstant 3,674022E-40 
					                                          f32 %53 = OpConstant 3,674022E-40 
					                                        f32_2 %54 = OpConstantComposite %52 %53 
					                                              %58 = OpTypeInt 32 0 
					                                          u32 %59 = OpConstant 0 
					                                              %60 = OpTypePointer Private %6 
					                                          f32 %68 = OpConstant 3,674022E-40 
					                                          f32 %77 = OpConstant 3,674022E-40 
					                               Private f32_4* %80 = OpVariable Private 
					                                          u32 %91 = OpConstant 1 
					                                          i32 %95 = OpConstant 3 
					                                              %96 = OpTypePointer Uniform %6 
					                                         f32 %107 = OpConstant 3,674022E-40 
					                                       f32_2 %108 = OpConstantComposite %107 %107 
					        UniformConstant read_only Texture2D* %114 = OpVariable UniformConstant 
					                    UniformConstant sampler* %116 = OpVariable UniformConstant 
					                                Private f32* %125 = OpVariable Private 
					                                             %133 = OpTypeBool 
					                                             %134 = OpTypePointer Private %133 
					                               Private bool* %135 = OpVariable Private 
					                                             %141 = OpTypePointer Output %7 
					                               Output f32_4* %142 = OpVariable Output 
					        UniformConstant read_only Texture2D* %145 = OpVariable UniformConstant 
					                    UniformConstant sampler* %147 = OpVariable UniformConstant 
					                                             %152 = OpTypeVector %6 3 
					                                       f32_2 %158 = OpConstantComposite %27 %27 
					                                         f32 %160 = OpConstant 3,674022E-40 
					                                       f32_2 %161 = OpConstantComposite %160 %160 
					                                         i32 %167 = OpConstant 4 
					                                Private f32* %174 = OpVariable Private 
					                                             %182 = OpTypePointer Private %152 
					                              Private f32_3* %183 = OpVariable Private 
					                                         f32 %186 = OpConstant 3,674022E-40 
					                                         f32 %187 = OpConstant 3,674022E-40 
					                                       f32_2 %188 = OpConstantComposite %186 %187 
					                                         u32 %192 = OpConstant 2 
					                                Private f32* %196 = OpVariable Private 
					                               Private bool* %202 = OpVariable Private 
					                                             %219 = OpTypePointer Function %20 
					                                         i32 %234 = OpConstant 5 
					                                             %243 = OpTypePointer Private %20 
					                              Private f32_2* %244 = OpVariable Private 
					                                       f32_2 %261 = OpConstantComposite %68 %107 
					                                         f32 %269 = OpConstant 3,674022E-40 
					                                Private f32* %272 = OpVariable Private 
					                              Private f32_4* %278 = OpVariable Private 
					                                         u32 %279 = OpConstant 3 
					                              Private f32_4* %281 = OpVariable Private 
					                                Private f32* %286 = OpVariable Private 
					                                Private f32* %288 = OpVariable Private 
					                                Private f32* %289 = OpVariable Private 
					                                        bool %297 = OpConstantTrue 
					                                             %298 = OpTypeVector %133 2 
					                                             %299 = OpTypePointer Private %298 
					                             Private bool_2* %300 = OpVariable Private 
					                              Private f32_3* %311 = OpVariable Private 
					                                       f32_2 %314 = OpConstantComposite %107 %186 
					                                         f32 %323 = OpConstant 3,674022E-40 
					                                       f32_4 %324 = OpConstantComposite %323 %323 %28 %28 
					                                             %327 = OpTypeVector %133 4 
					                                Private f32* %343 = OpVariable Private 
					                                             %346 = OpTypePointer Function %6 
					                              Private f32_3* %369 = OpVariable Private 
					                                         i32 %372 = OpConstant 1 
					                                         i32 %383 = OpConstant 2 
					                                             %384 = OpTypePointer Uniform %20 
					                                         f32 %436 = OpConstant 3,674022E-40 
					                                Private f32* %467 = OpVariable Private 
					                                         f32 %484 = OpConstant 3,674022E-40 
					                                             %547 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                             Function f32_2* %220 = OpVariable Function 
					                             Function f32_2* %332 = OpVariable Function 
					                               Function f32* %347 = OpVariable Function 
					                               Function f32* %507 = OpVariable Function 
					                          read_only Texture2D %13 = OpLoad %12 
					                                      sampler %17 = OpLoad %16 
					                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                        f32_2 %23 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                                      OpStore %9 %24 
					                                        f32_2 %26 = OpLoad vs_TEXCOORD0 
					                                        f32_2 %30 = OpFAdd %26 %29 
					                                        f32_4 %31 = OpLoad %25 
					                                        f32_4 %32 = OpVectorShuffle %31 %30 4 5 2 3 
					                                                      OpStore %25 %32 
					                                        f32_4 %33 = OpLoad %25 
					                                        f32_2 %34 = OpVectorShuffle %33 %33 0 1 
					                               Uniform f32_4* %41 = OpAccessChain %37 %39 
					                                        f32_4 %42 = OpLoad %41 
					                                        f32_2 %43 = OpVectorShuffle %42 %42 0 1 
					                                        f32_2 %44 = OpFMul %34 %43 
					                                        f32_4 %45 = OpLoad %25 
					                                        f32_4 %46 = OpVectorShuffle %45 %44 4 5 2 3 
					                                                      OpStore %25 %46 
					                                        f32_4 %47 = OpLoad %25 
					                                        f32_2 %48 = OpVectorShuffle %47 %47 0 1 
					                                        f32_2 %49 = OpExtInst %1 8 %48 
					                                        f32_4 %50 = OpLoad %25 
					                                        f32_4 %51 = OpVectorShuffle %50 %49 4 5 2 3 
					                                                      OpStore %25 %51 
					                                        f32_4 %55 = OpLoad %25 
					                                        f32_2 %56 = OpVectorShuffle %55 %55 0 1 
					                                          f32 %57 = OpDot %54 %56 
					                                 Private f32* %61 = OpAccessChain %25 %59 
					                                                      OpStore %61 %57 
					                                 Private f32* %62 = OpAccessChain %25 %59 
					                                          f32 %63 = OpLoad %62 
					                                          f32 %64 = OpExtInst %1 10 %63 
					                                 Private f32* %65 = OpAccessChain %25 %59 
					                                                      OpStore %65 %64 
					                                 Private f32* %66 = OpAccessChain %25 %59 
					                                          f32 %67 = OpLoad %66 
					                                          f32 %69 = OpFMul %67 %68 
					                                 Private f32* %70 = OpAccessChain %25 %59 
					                                                      OpStore %70 %69 
					                                 Private f32* %71 = OpAccessChain %25 %59 
					                                          f32 %72 = OpLoad %71 
					                                          f32 %73 = OpExtInst %1 10 %72 
					                                 Private f32* %74 = OpAccessChain %25 %59 
					                                                      OpStore %74 %73 
					                                 Private f32* %75 = OpAccessChain %25 %59 
					                                          f32 %76 = OpLoad %75 
					                                          f32 %78 = OpFMul %76 %77 
					                                 Private f32* %79 = OpAccessChain %25 %59 
					                                                      OpStore %79 %78 
					                                 Private f32* %81 = OpAccessChain %25 %59 
					                                          f32 %82 = OpLoad %81 
					                                          f32 %83 = OpExtInst %1 14 %82 
					                                 Private f32* %84 = OpAccessChain %80 %59 
					                                                      OpStore %84 %83 
					                                 Private f32* %85 = OpAccessChain %25 %59 
					                                          f32 %86 = OpLoad %85 
					                                          f32 %87 = OpExtInst %1 13 %86 
					                                 Private f32* %88 = OpAccessChain %25 %59 
					                                                      OpStore %88 %87 
					                                 Private f32* %89 = OpAccessChain %25 %59 
					                                          f32 %90 = OpLoad %89 
					                                 Private f32* %92 = OpAccessChain %80 %91 
					                                                      OpStore %92 %90 
					                                        f32_4 %93 = OpLoad %80 
					                                        f32_2 %94 = OpVectorShuffle %93 %93 0 1 
					                                 Uniform f32* %97 = OpAccessChain %37 %95 %59 
					                                          f32 %98 = OpLoad %97 
					                                 Uniform f32* %99 = OpAccessChain %37 %95 %91 
					                                         f32 %100 = OpLoad %99 
					                                       f32_2 %101 = OpCompositeConstruct %98 %100 
					                                       f32_2 %102 = OpFMul %94 %101 
					                                       f32_4 %103 = OpLoad %25 
					                                       f32_4 %104 = OpVectorShuffle %103 %102 4 5 2 3 
					                                                      OpStore %25 %104 
					                                       f32_4 %105 = OpLoad %25 
					                                       f32_2 %106 = OpVectorShuffle %105 %105 0 1 
					                                       f32_2 %109 = OpFMul %106 %108 
					                                       f32_2 %110 = OpLoad vs_TEXCOORD0 
					                                       f32_2 %111 = OpFAdd %109 %110 
					                                       f32_4 %112 = OpLoad %25 
					                                       f32_4 %113 = OpVectorShuffle %112 %111 4 5 2 3 
					                                                      OpStore %25 %113 
					                         read_only Texture2D %115 = OpLoad %114 
					                                     sampler %117 = OpLoad %116 
					                  read_only Texture2DSampled %118 = OpSampledImage %115 %117 
					                                       f32_4 %119 = OpLoad %25 
					                                       f32_2 %120 = OpVectorShuffle %119 %119 0 1 
					                                       f32_4 %121 = OpImageSampleImplicitLod %118 %120 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_4 %123 = OpLoad %25 
					                                       f32_4 %124 = OpVectorShuffle %123 %122 4 5 2 3 
					                                                      OpStore %25 %124 
					                                       f32_4 %126 = OpLoad %25 
					                                       f32_2 %127 = OpVectorShuffle %126 %126 0 1 
					                                       f32_4 %128 = OpLoad %25 
					                                       f32_2 %129 = OpVectorShuffle %128 %128 0 1 
					                                         f32 %130 = OpDot %127 %129 
					                                                      OpStore %125 %130 
					                                         f32 %131 = OpLoad %125 
					                                         f32 %132 = OpExtInst %1 31 %131 
					                                                      OpStore %125 %132 
					                                         f32 %136 = OpLoad %125 
					                                        bool %137 = OpFOrdLessThan %136 %27 
					                                                      OpStore %135 %137 
					                                        bool %138 = OpLoad %135 
					                                                      OpSelectionMerge %140 None 
					                                                      OpBranchConditional %138 %139 %140 
					                                             %139 = OpLabel 
					                                       f32_4 %143 = OpLoad %9 
					                                                      OpStore %142 %143 
					                                                      OpReturn
					                                             %140 = OpLabel 
					                         read_only Texture2D %146 = OpLoad %145 
					                                     sampler %148 = OpLoad %147 
					                  read_only Texture2DSampled %149 = OpSampledImage %146 %148 
					                                       f32_2 %150 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %151 = OpImageSampleExplicitLod %149 %150 Lod %7 
					                                       f32_3 %153 = OpVectorShuffle %151 %151 0 1 2 
					                                       f32_4 %154 = OpLoad %80 
					                                       f32_4 %155 = OpVectorShuffle %154 %153 4 5 6 3 
					                                                      OpStore %80 %155 
					                                       f32_4 %156 = OpLoad %80 
					                                       f32_2 %157 = OpVectorShuffle %156 %156 0 1 
					                                       f32_2 %159 = OpFMul %157 %158 
					                                       f32_2 %162 = OpFAdd %159 %161 
					                                       f32_4 %163 = OpLoad %80 
					                                       f32_4 %164 = OpVectorShuffle %163 %162 4 5 2 3 
					                                                      OpStore %80 %164 
					                                       f32_4 %165 = OpLoad %80 
					                                       f32_2 %166 = OpVectorShuffle %165 %165 0 1 
					                                Uniform f32* %168 = OpAccessChain %37 %167 
					                                         f32 %169 = OpLoad %168 
					                                       f32_2 %170 = OpCompositeConstruct %169 %169 
					                                       f32_2 %171 = OpFMul %166 %170 
					                                       f32_4 %172 = OpLoad %80 
					                                       f32_4 %173 = OpVectorShuffle %172 %171 4 5 2 3 
					                                                      OpStore %80 %173 
					                                       f32_4 %175 = OpLoad %80 
					                                       f32_2 %176 = OpVectorShuffle %175 %175 0 1 
					                                       f32_4 %177 = OpLoad %80 
					                                       f32_2 %178 = OpVectorShuffle %177 %177 0 1 
					                                         f32 %179 = OpDot %176 %178 
					                                                      OpStore %174 %179 
					                                         f32 %180 = OpLoad %174 
					                                         f32 %181 = OpExtInst %1 31 %180 
					                                                      OpStore %174 %181 
					                                         f32 %184 = OpLoad %174 
					                                       f32_2 %185 = OpCompositeConstruct %184 %184 
					                                       f32_2 %189 = OpExtInst %1 40 %185 %188 
					                                       f32_3 %190 = OpLoad %183 
					                                       f32_3 %191 = OpVectorShuffle %190 %189 3 4 2 
					                                                      OpStore %183 %191 
					                                Private f32* %193 = OpAccessChain %80 %192 
					                                         f32 %194 = OpLoad %193 
					                                         f32 %195 = OpFDiv %187 %194 
					                                                      OpStore %174 %195 
					                                Private f32* %197 = OpAccessChain %183 %59 
					                                         f32 %198 = OpLoad %197 
					                                Private f32* %199 = OpAccessChain %183 %59 
					                                         f32 %200 = OpLoad %199 
					                                         f32 %201 = OpFAdd %198 %200 
					                                                      OpStore %196 %201 
					                                         f32 %203 = OpLoad %125 
					                                         f32 %204 = OpLoad %196 
					                                        bool %205 = OpFOrdLessThan %203 %204 
					                                                      OpStore %202 %205 
					                                         f32 %206 = OpLoad %125 
					                                Private f32* %207 = OpAccessChain %183 %59 
					                                         f32 %208 = OpLoad %207 
					                                         f32 %209 = OpFDiv %206 %208 
					                                Private f32* %210 = OpAccessChain %183 %59 
					                                                      OpStore %210 %209 
					                                       f32_4 %211 = OpLoad %80 
					                                       f32_2 %212 = OpVectorShuffle %211 %211 0 1 
					                                       f32_3 %213 = OpLoad %183 
					                                       f32_2 %214 = OpVectorShuffle %213 %213 0 0 
					                                       f32_2 %215 = OpFMul %212 %214 
					                                       f32_4 %216 = OpLoad %80 
					                                       f32_4 %217 = OpVectorShuffle %216 %215 4 5 2 3 
					                                                      OpStore %80 %217 
					                                        bool %218 = OpLoad %202 
					                                                      OpSelectionMerge %222 None 
					                                                      OpBranchConditional %218 %221 %225 
					                                             %221 = OpLabel 
					                                       f32_4 %223 = OpLoad %80 
					                                       f32_2 %224 = OpVectorShuffle %223 %223 0 1 
					                                                      OpStore %220 %224 
					                                                      OpBranch %222 
					                                             %225 = OpLabel 
					                                       f32_4 %226 = OpLoad %25 
					                                       f32_2 %227 = OpVectorShuffle %226 %226 0 1 
					                                                      OpStore %220 %227 
					                                                      OpBranch %222 
					                                             %222 = OpLabel 
					                                       f32_2 %228 = OpLoad %220 
					                                       f32_4 %229 = OpLoad %80 
					                                       f32_4 %230 = OpVectorShuffle %229 %228 4 5 2 3 
					                                                      OpStore %80 %230 
					                                         f32 %231 = OpLoad %125 
					                                         f32 %232 = OpFMul %231 %186 
					                                                      OpStore %196 %232 
					                                         f32 %233 = OpLoad %196 
					                                Uniform f32* %235 = OpAccessChain %37 %234 
					                                         f32 %236 = OpLoad %235 
					                                         f32 %237 = OpExtInst %1 37 %233 %236 
					                                                      OpStore %196 %237 
					                                         f32 %238 = OpLoad %196 
					                                         f32 %239 = OpExtInst %1 8 %238 
					                                                      OpStore %196 %239 
					                                         f32 %240 = OpLoad %196 
					                                         f32 %241 = OpFDiv %187 %240 
					                                Private f32* %242 = OpAccessChain %183 %59 
					                                                      OpStore %242 %241 
					                                       f32_2 %245 = OpLoad vs_TEXCOORD0 
					                              Uniform f32_4* %246 = OpAccessChain %37 %39 
					                                       f32_4 %247 = OpLoad %246 
					                                       f32_2 %248 = OpVectorShuffle %247 %247 0 1 
					                                       f32_2 %249 = OpFMul %245 %248 
					                                                      OpStore %244 %249 
					                                       f32_2 %250 = OpLoad %244 
					                                       f32_2 %251 = OpExtInst %1 8 %250 
					                                                      OpStore %244 %251 
					                                       f32_2 %252 = OpLoad %244 
					                                         f32 %253 = OpDot %54 %252 
					                                Private f32* %254 = OpAccessChain %244 %59 
					                                                      OpStore %254 %253 
					                                Private f32* %255 = OpAccessChain %244 %59 
					                                         f32 %256 = OpLoad %255 
					                                         f32 %257 = OpExtInst %1 10 %256 
					                                Private f32* %258 = OpAccessChain %183 %192 
					                                                      OpStore %258 %257 
					                                       f32_3 %259 = OpLoad %183 
					                                       f32_2 %260 = OpVectorShuffle %259 %259 2 0 
					                                       f32_2 %262 = OpFMul %260 %261 
					                                                      OpStore %244 %262 
					                                Private f32* %263 = OpAccessChain %244 %59 
					                                         f32 %264 = OpLoad %263 
					                                         f32 %265 = OpExtInst %1 10 %264 
					                                Private f32* %266 = OpAccessChain %244 %59 
					                                                      OpStore %266 %265 
					                                Private f32* %267 = OpAccessChain %244 %59 
					                                         f32 %268 = OpLoad %267 
					                                         f32 %270 = OpFAdd %268 %269 
					                                Private f32* %271 = OpAccessChain %244 %59 
					                                                      OpStore %271 %270 
					                                Private f32* %273 = OpAccessChain %183 %59 
					                                         f32 %274 = OpLoad %273 
					                                         f32 %275 = OpFNegate %274 
					                                         f32 %276 = OpFMul %275 %186 
					                                         f32 %277 = OpFAdd %276 %187 
					                                                      OpStore %272 %277 
					                                Private f32* %280 = OpAccessChain %278 %279 
					                                                      OpStore %280 %187 
					                                Private f32* %282 = OpAccessChain %281 %59 
					                                                      OpStore %282 %28 
					                                Private f32* %283 = OpAccessChain %281 %91 
					                                                      OpStore %283 %28 
					                                Private f32* %284 = OpAccessChain %281 %192 
					                                                      OpStore %284 %28 
					                                Private f32* %285 = OpAccessChain %281 %279 
					                                                      OpStore %285 %28 
					                                         f32 %287 = OpLoad %272 
					                                                      OpStore %286 %287 
					                                                      OpStore %288 %28 
					                                Private f32* %290 = OpAccessChain %183 %91 
					                                         f32 %291 = OpLoad %290 
					                                                      OpStore %289 %291 
					                                                      OpBranch %292 
					                                             %292 = OpLabel 
					                                                      OpLoopMerge %294 %295 None 
					                                                      OpBranch %296 
					                                             %296 = OpLabel 
					                                                      OpBranchConditional %297 %293 %294 
					                                             %293 = OpLabel 
					                                Private f32* %301 = OpAccessChain %244 %91 
					                                         f32 %302 = OpLoad %301 
					                                         f32 %303 = OpLoad %286 
					                                        bool %304 = OpFOrdGreaterThanEqual %302 %303 
					                               Private bool* %305 = OpAccessChain %300 %59 
					                                                      OpStore %305 %304 
					                               Private bool* %306 = OpAccessChain %300 %59 
					                                        bool %307 = OpLoad %306 
					                                                      OpSelectionMerge %309 None 
					                                                      OpBranchConditional %307 %308 %309 
					                                             %308 = OpLabel 
					                                                      OpBranch %294 
					                                             %309 = OpLabel 
					                                         f32 %312 = OpLoad %288 
					                                       f32_2 %313 = OpCompositeConstruct %312 %312 
					                                       f32_2 %315 = OpFMul %313 %314 
					                                       f32_3 %316 = OpLoad %311 
					                                       f32_3 %317 = OpVectorShuffle %316 %315 3 4 2 
					                                                      OpStore %311 %317 
					                                       f32_3 %318 = OpLoad %311 
					                                       f32_2 %319 = OpVectorShuffle %318 %318 0 1 
					                                       f32_2 %320 = OpExtInst %1 10 %319 
					                                       f32_3 %321 = OpLoad %311 
					                                       f32_3 %322 = OpVectorShuffle %321 %320 3 4 2 
					                                                      OpStore %311 %322 
					                                       f32_3 %325 = OpLoad %311 
					                                       f32_4 %326 = OpVectorShuffle %325 %325 0 1 0 0 
					                                      bool_4 %328 = OpFOrdLessThan %324 %326 
					                                      bool_2 %329 = OpVectorShuffle %328 %328 0 1 
					                                                      OpStore %300 %329 
					                               Private bool* %330 = OpAccessChain %300 %59 
					                                        bool %331 = OpLoad %330 
					                                                      OpSelectionMerge %334 None 
					                                                      OpBranchConditional %331 %333 %337 
					                                             %333 = OpLabel 
					                                       f32_4 %335 = OpLoad %80 
					                                       f32_2 %336 = OpVectorShuffle %335 %335 0 1 
					                                                      OpStore %332 %336 
					                                                      OpBranch %334 
					                                             %337 = OpLabel 
					                                       f32_4 %338 = OpLoad %25 
					                                       f32_2 %339 = OpVectorShuffle %338 %338 0 1 
					                                                      OpStore %332 %339 
					                                                      OpBranch %334 
					                                             %334 = OpLabel 
					                                       f32_2 %340 = OpLoad %332 
					                                       f32_3 %341 = OpLoad %311 
					                                       f32_3 %342 = OpVectorShuffle %341 %340 3 1 4 
					                                                      OpStore %311 %342 
					                               Private bool* %344 = OpAccessChain %300 %91 
					                                        bool %345 = OpLoad %344 
					                                                      OpSelectionMerge %349 None 
					                                                      OpBranchConditional %345 %348 %352 
					                                             %348 = OpLabel 
					                                         f32 %350 = OpLoad %286 
					                                         f32 %351 = OpFNegate %350 
					                                                      OpStore %347 %351 
					                                                      OpBranch %349 
					                                             %352 = OpLabel 
					                                         f32 %353 = OpLoad %286 
					                                                      OpStore %347 %353 
					                                                      OpBranch %349 
					                                             %349 = OpLabel 
					                                         f32 %354 = OpLoad %347 
					                                                      OpStore %343 %354 
					                                Private f32* %355 = OpAccessChain %244 %59 
					                                         f32 %356 = OpLoad %355 
					                                Private f32* %357 = OpAccessChain %183 %59 
					                                         f32 %358 = OpLoad %357 
					                                         f32 %359 = OpFMul %356 %358 
					                                         f32 %360 = OpLoad %343 
					                                         f32 %361 = OpFAdd %359 %360 
					                                                      OpStore %343 %361 
					                                         f32 %362 = OpLoad %343 
					                                       f32_2 %363 = OpCompositeConstruct %362 %362 
					                                       f32_3 %364 = OpLoad %311 
					                                       f32_2 %365 = OpVectorShuffle %364 %364 0 2 
					                                       f32_2 %366 = OpFMul %363 %365 
					                                       f32_3 %367 = OpLoad %311 
					                                       f32_3 %368 = OpVectorShuffle %367 %366 3 1 4 
					                                                      OpStore %311 %368 
					                                       f32_3 %370 = OpLoad %311 
					                                       f32_2 %371 = OpVectorShuffle %370 %370 0 2 
					                              Uniform f32_4* %373 = OpAccessChain %37 %372 
					                                       f32_4 %374 = OpLoad %373 
					                                       f32_2 %375 = OpVectorShuffle %374 %374 0 1 
					                                       f32_2 %376 = OpFMul %371 %375 
					                                       f32_2 %377 = OpLoad vs_TEXCOORD0 
					                                       f32_2 %378 = OpFAdd %376 %377 
					                                       f32_3 %379 = OpLoad %369 
					                                       f32_3 %380 = OpVectorShuffle %379 %378 3 4 2 
					                                                      OpStore %369 %380 
					                                       f32_3 %381 = OpLoad %311 
					                                       f32_2 %382 = OpVectorShuffle %381 %381 0 2 
					                              Uniform f32_2* %385 = OpAccessChain %37 %383 
					                                       f32_2 %386 = OpLoad %385 
					                                       f32_2 %387 = OpFMul %382 %386 
					                                       f32_2 %388 = OpLoad vs_TEXCOORD0 
					                                       f32_2 %389 = OpFAdd %387 %388 
					                                       f32_3 %390 = OpLoad %311 
					                                       f32_3 %391 = OpVectorShuffle %390 %389 3 1 4 
					                                                      OpStore %311 %391 
					                         read_only Texture2D %392 = OpLoad %12 
					                                     sampler %393 = OpLoad %16 
					                  read_only Texture2DSampled %394 = OpSampledImage %392 %393 
					                                       f32_3 %395 = OpLoad %369 
					                                       f32_2 %396 = OpVectorShuffle %395 %395 0 1 
					                                       f32_4 %397 = OpImageSampleExplicitLod %394 %396 Lod %7 
					                                       f32_3 %398 = OpVectorShuffle %397 %397 0 1 2 
					                                       f32_4 %399 = OpLoad %278 
					                                       f32_4 %400 = OpVectorShuffle %399 %398 4 5 6 3 
					                                                      OpStore %278 %400 
					                         read_only Texture2D %401 = OpLoad %145 
					                                     sampler %402 = OpLoad %147 
					                  read_only Texture2DSampled %403 = OpSampledImage %401 %402 
					                                       f32_3 %404 = OpLoad %311 
					                                       f32_2 %405 = OpVectorShuffle %404 %404 0 2 
					                                       f32_4 %406 = OpImageSampleExplicitLod %403 %405 Lod %7 
					                                       f32_3 %407 = OpVectorShuffle %406 %406 0 1 2 
					                                                      OpStore %369 %407 
					                                       f32_3 %408 = OpLoad %369 
					                                       f32_2 %409 = OpVectorShuffle %408 %408 0 1 
					                                       f32_2 %410 = OpFMul %409 %158 
					                                       f32_2 %411 = OpFAdd %410 %161 
					                                       f32_3 %412 = OpLoad %311 
					                                       f32_3 %413 = OpVectorShuffle %412 %411 3 1 4 
					                                                      OpStore %311 %413 
					                                       f32_3 %414 = OpLoad %311 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 2 
					                                Uniform f32* %416 = OpAccessChain %37 %167 
					                                         f32 %417 = OpLoad %416 
					                                       f32_2 %418 = OpCompositeConstruct %417 %417 
					                                       f32_2 %419 = OpFMul %415 %418 
					                                       f32_3 %420 = OpLoad %311 
					                                       f32_3 %421 = OpVectorShuffle %420 %419 3 1 4 
					                                                      OpStore %311 %421 
					                                Private f32* %422 = OpAccessChain %80 %192 
					                                         f32 %423 = OpLoad %422 
					                                Private f32* %424 = OpAccessChain %369 %192 
					                                         f32 %425 = OpLoad %424 
					                                         f32 %426 = OpFNegate %425 
					                                         f32 %427 = OpFAdd %423 %426 
					                                Private f32* %428 = OpAccessChain %369 %59 
					                                                      OpStore %428 %427 
					                                         f32 %429 = OpLoad %174 
					                                Private f32* %430 = OpAccessChain %369 %59 
					                                         f32 %431 = OpLoad %430 
					                                         f32 %432 = OpFMul %429 %431 
					                                Private f32* %433 = OpAccessChain %369 %59 
					                                                      OpStore %433 %432 
					                                Private f32* %434 = OpAccessChain %369 %59 
					                                         f32 %435 = OpLoad %434 
					                                         f32 %437 = OpFMul %435 %436 
					                                Private f32* %438 = OpAccessChain %369 %59 
					                                                      OpStore %438 %437 
					                                Private f32* %439 = OpAccessChain %369 %59 
					                                         f32 %440 = OpLoad %439 
					                                         f32 %441 = OpExtInst %1 43 %440 %28 %187 
					                                Private f32* %442 = OpAccessChain %369 %59 
					                                                      OpStore %442 %441 
					                                       f32_3 %443 = OpLoad %311 
					                                       f32_2 %444 = OpVectorShuffle %443 %443 0 2 
					                                       f32_3 %445 = OpLoad %311 
					                                       f32_2 %446 = OpVectorShuffle %445 %445 0 2 
					                                         f32 %447 = OpDot %444 %446 
					                                Private f32* %448 = OpAccessChain %311 %59 
					                                                      OpStore %448 %447 
					                                Private f32* %449 = OpAccessChain %311 %59 
					                                         f32 %450 = OpLoad %449 
					                                         f32 %451 = OpExtInst %1 31 %450 
					                                Private f32* %452 = OpAccessChain %311 %59 
					                                                      OpStore %452 %451 
					                                         f32 %453 = OpLoad %289 
					                                         f32 %454 = OpFNegate %453 
					                                Private f32* %455 = OpAccessChain %311 %59 
					                                         f32 %456 = OpLoad %455 
					                                         f32 %457 = OpFAdd %454 %456 
					                                Private f32* %458 = OpAccessChain %311 %59 
					                                                      OpStore %458 %457 
					                                Private f32* %459 = OpAccessChain %369 %59 
					                                         f32 %460 = OpLoad %459 
					                                Private f32* %461 = OpAccessChain %311 %59 
					                                         f32 %462 = OpLoad %461 
					                                         f32 %463 = OpFMul %460 %462 
					                                         f32 %464 = OpLoad %289 
					                                         f32 %465 = OpFAdd %463 %464 
					                                Private f32* %466 = OpAccessChain %311 %59 
					                                                      OpStore %466 %465 
					                                         f32 %468 = OpLoad %125 
					                                         f32 %469 = OpFNegate %468 
					                                         f32 %470 = OpLoad %343 
					                                         f32 %471 = OpExtInst %1 4 %470 
					                                         f32 %472 = OpFMul %469 %471 
					                                Private f32* %473 = OpAccessChain %311 %59 
					                                         f32 %474 = OpLoad %473 
					                                         f32 %475 = OpFAdd %472 %474 
					                                                      OpStore %467 %475 
					                                         f32 %476 = OpLoad %467 
					                                         f32 %477 = OpExtInst %1 43 %476 %28 %187 
					                                                      OpStore %467 %477 
					                                         f32 %478 = OpLoad %467 
					                                Private f32* %479 = OpAccessChain %311 %59 
					                                         f32 %480 = OpLoad %479 
					                                         f32 %481 = OpFDiv %478 %480 
					                                                      OpStore %467 %481 
					                                         f32 %482 = OpLoad %286 
					                                         f32 %483 = OpFNegate %482 
					                                         f32 %485 = OpFAdd %483 %484 
					                                                      OpStore %343 %485 
					                                         f32 %486 = OpLoad %343 
					                                         f32 %487 = OpLoad %467 
					                                         f32 %488 = OpFMul %486 %487 
					                                                      OpStore %467 %488 
					                                       f32_4 %489 = OpLoad %278 
					                                         f32 %490 = OpLoad %467 
					                                       f32_4 %491 = OpCompositeConstruct %490 %490 %490 %490 
					                                       f32_4 %492 = OpFMul %489 %491 
					                                       f32_4 %493 = OpLoad %281 
					                                       f32_4 %494 = OpFAdd %492 %493 
					                                                      OpStore %281 %494 
					                                         f32 %495 = OpLoad %289 
					                                Private f32* %496 = OpAccessChain %311 %59 
					                                         f32 %497 = OpLoad %496 
					                                         f32 %498 = OpExtInst %1 40 %495 %497 
					                                                      OpStore %289 %498 
					                                Private f32* %499 = OpAccessChain %183 %59 
					                                         f32 %500 = OpLoad %499 
					                                         f32 %501 = OpFNegate %500 
					                                         f32 %502 = OpLoad %286 
					                                         f32 %503 = OpFAdd %501 %502 
					                                Private f32* %504 = OpAccessChain %278 %59 
					                                                      OpStore %504 %503 
					                               Private bool* %505 = OpAccessChain %300 %91 
					                                        bool %506 = OpLoad %505 
					                                                      OpSelectionMerge %509 None 
					                                                      OpBranchConditional %506 %508 %512 
					                                             %508 = OpLabel 
					                                Private f32* %510 = OpAccessChain %278 %59 
					                                         f32 %511 = OpLoad %510 
					                                                      OpStore %507 %511 
					                                                      OpBranch %509 
					                                             %512 = OpLabel 
					                                         f32 %513 = OpLoad %286 
					                                                      OpStore %507 %513 
					                                                      OpBranch %509 
					                                             %509 = OpLabel 
					                                         f32 %514 = OpLoad %507 
					                                                      OpStore %286 %514 
					                                         f32 %515 = OpLoad %288 
					                                         f32 %516 = OpFAdd %515 %187 
					                                                      OpStore %288 %516 
					                                                      OpBranch %295 
					                                             %295 = OpLabel 
					                                                      OpBranch %292 
					                                             %294 = OpLabel 
					                                         f32 %517 = OpLoad %289 
					                                       f32_2 %518 = OpCompositeConstruct %517 %517 
					                                         f32 %519 = OpLoad %196 
					                                       f32_2 %520 = OpCompositeConstruct %519 %519 
					                                         f32 %521 = OpDot %518 %520 
					                                Private f32* %522 = OpAccessChain %25 %59 
					                                                      OpStore %522 %521 
					                                Private f32* %523 = OpAccessChain %25 %59 
					                                         f32 %524 = OpLoad %523 
					                                         f32 %525 = OpFDiv %484 %524 
					                                Private f32* %526 = OpAccessChain %25 %59 
					                                                      OpStore %526 %525 
					                                       f32_4 %527 = OpLoad %9 
					                                       f32_3 %528 = OpVectorShuffle %527 %527 0 1 2 
					                                       f32_4 %529 = OpLoad %80 
					                                       f32_4 %530 = OpVectorShuffle %529 %528 4 5 6 3 
					                                                      OpStore %80 %530 
					                                Private f32* %531 = OpAccessChain %80 %279 
					                                                      OpStore %531 %187 
					                                       f32_4 %532 = OpLoad %80 
					                                       f32_4 %533 = OpLoad %25 
					                                       f32_4 %534 = OpVectorShuffle %533 %533 0 0 0 0 
					                                       f32_4 %535 = OpFMul %532 %534 
					                                       f32_4 %536 = OpLoad %281 
					                                       f32_4 %537 = OpFAdd %535 %536 
					                                                      OpStore %25 %537 
					                                       f32_4 %538 = OpLoad %25 
					                                       f32_3 %539 = OpVectorShuffle %538 %538 0 1 2 
					                                       f32_4 %540 = OpLoad %25 
					                                       f32_3 %541 = OpVectorShuffle %540 %540 3 3 3 
					                                       f32_3 %542 = OpFDiv %539 %541 
					                                       f32_4 %543 = OpLoad %142 
					                                       f32_4 %544 = OpVectorShuffle %543 %542 4 5 6 3 
					                                                      OpStore %142 %544 
					                                Private f32* %545 = OpAccessChain %9 %279 
					                                         f32 %546 = OpLoad %545 
					                                 Output f32* %548 = OpAccessChain %142 %279 
					                                                      OpStore %548 %546 
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
						vec4 unused_0_0[22];
						vec4 _ScreenParams;
						vec4 unused_0_2[5];
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						vec2 _VelocityTex_TexelSize;
						vec2 _NeighborMaxTex_TexelSize;
						vec4 unused_0_7;
						float _MaxBlurRadius;
						float _LoopCount;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _VelocityTex;
					uniform  sampler2D _NeighborMaxTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec2 u_xlatb7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					float u_xlat14;
					float u_xlat21;
					vec2 u_xlat23;
					float u_xlat24;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					bool u_xlatb32;
					float u_xlat34;
					float u_xlat37;
					float u_xlat38;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(2.0, 0.0);
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    u_xlat1.xy = floor(u_xlat1.xy);
					    u_xlat1.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat1.xy);
					    u_xlat1.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 52.9829178;
					    u_xlat1.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 6.28318548;
					    u_xlat2.x = cos(u_xlat1.x);
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat1.xy = u_xlat2.xy * vec2(_NeighborMaxTex_TexelSize.x, _NeighborMaxTex_TexelSize.y);
					    u_xlat1.xy = u_xlat1.xy * vec2(0.25, 0.25) + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_NeighborMaxTex, u_xlat1.xy);
					    u_xlat21 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat21 = sqrt(u_xlat21);
					    u_xlatb31 = u_xlat21<2.0;
					    if(u_xlatb31){
					        SV_Target0 = u_xlat0;
					        return;
					    }
					    u_xlat2 = textureLod(_VelocityTex, vs_TEXCOORD0.xy, 0.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_MaxBlurRadius);
					    u_xlat31 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat31 = sqrt(u_xlat31);
					    u_xlat3.xy = max(vec2(u_xlat31), vec2(0.5, 1.0));
					    u_xlat31 = float(1.0) / u_xlat2.z;
					    u_xlat32 = u_xlat3.x + u_xlat3.x;
					    u_xlatb32 = u_xlat21<u_xlat32;
					    u_xlat3.x = u_xlat21 / u_xlat3.x;
					    u_xlat2.xy = u_xlat2.xy * u_xlat3.xx;
					    u_xlat2.xy = (bool(u_xlatb32)) ? u_xlat2.xy : u_xlat1.xy;
					    u_xlat32 = u_xlat21 * 0.5;
					    u_xlat32 = min(u_xlat32, _LoopCount);
					    u_xlat32 = floor(u_xlat32);
					    u_xlat3.x = float(1.0) / u_xlat32;
					    u_xlat23.xy = vs_TEXCOORD0.xy * _ScreenParams.xy;
					    u_xlat23.xy = floor(u_xlat23.xy);
					    u_xlat23.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat23.xy);
					    u_xlat3.z = fract(u_xlat23.x);
					    u_xlat23.xy = u_xlat3.zx * vec2(52.9829178, 0.25);
					    u_xlat23.x = fract(u_xlat23.x);
					    u_xlat23.x = u_xlat23.x + -0.5;
					    u_xlat4 = (-u_xlat3.x) * 0.5 + 1.0;
					    u_xlat5.w = 1.0;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat6.w = float(0.0);
					    u_xlat14 = u_xlat4;
					    u_xlat24 = 0.0;
					    u_xlat34 = u_xlat3.y;
					    while(true){
					        u_xlatb7.x = u_xlat23.y>=u_xlat14;
					        if(u_xlatb7.x){break;}
					        u_xlat7.xy = vec2(u_xlat24) * vec2(0.25, 0.5);
					        u_xlat7.xy = fract(u_xlat7.xy);
					        u_xlatb7.xy = lessThan(vec4(0.499000013, 0.499000013, 0.0, 0.0), u_xlat7.xyxx).xy;
					        u_xlat7.xz = (u_xlatb7.x) ? u_xlat2.xy : u_xlat1.xy;
					        u_xlat37 = (u_xlatb7.y) ? (-u_xlat14) : u_xlat14;
					        u_xlat37 = u_xlat23.x * u_xlat3.x + u_xlat37;
					        u_xlat7.xz = vec2(u_xlat37) * u_xlat7.xz;
					        u_xlat8.xy = u_xlat7.xz * _MainTex_TexelSize.xy + vs_TEXCOORD0.xy;
					        u_xlat7.xz = u_xlat7.xz * _VelocityTex_TexelSize.xy + vs_TEXCOORD0.xy;
					        u_xlat8 = textureLod(_MainTex, u_xlat8.xy, 0.0);
					        u_xlat9 = textureLod(_VelocityTex, u_xlat7.xz, 0.0);
					        u_xlat7.xz = u_xlat9.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					        u_xlat7.xz = u_xlat7.xz * vec2(_MaxBlurRadius);
					        u_xlat38 = u_xlat2.z + (-u_xlat9.z);
					        u_xlat38 = u_xlat31 * u_xlat38;
					        u_xlat38 = u_xlat38 * 20.0;
					        u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
					        u_xlat7.x = dot(u_xlat7.xz, u_xlat7.xz);
					        u_xlat7.x = sqrt(u_xlat7.x);
					        u_xlat7.x = (-u_xlat34) + u_xlat7.x;
					        u_xlat7.x = u_xlat38 * u_xlat7.x + u_xlat34;
					        u_xlat27 = (-u_xlat21) * abs(u_xlat37) + u_xlat7.x;
					        u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					        u_xlat27 = u_xlat27 / u_xlat7.x;
					        u_xlat37 = (-u_xlat14) + 1.20000005;
					        u_xlat27 = u_xlat37 * u_xlat27;
					        u_xlat5.xyz = u_xlat8.xyz;
					        u_xlat6 = u_xlat5 * vec4(u_xlat27) + u_xlat6;
					        u_xlat34 = max(u_xlat34, u_xlat7.x);
					        u_xlat5.x = (-u_xlat3.x) + u_xlat14;
					        u_xlat14 = (u_xlatb7.y) ? u_xlat5.x : u_xlat14;
					        u_xlat24 = u_xlat24 + 1.0;
					    }
					    u_xlat1.x = dot(vec2(u_xlat34), vec2(u_xlat32));
					    u_xlat1.x = 1.20000005 / u_xlat1.x;
					    u_xlat2.xyz = u_xlat0.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat1 = u_xlat2 * u_xlat1.xxxx + u_xlat6;
					    SV_Target0.xyz = u_xlat1.xyz / u_xlat1.www;
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