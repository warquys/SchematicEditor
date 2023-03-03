Shader "Hidden/PostProcessing/Bloom" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 15914
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
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	vec4 _Threshold;
					uniform 	vec4 _Params;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _AutoExposureTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat7;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + vs_TEXCOORD0.xyxy;
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
					    u_xlat1.xy = vs_TEXCOORD0.xy + (-_MainTex_TexelSize.xy);
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(0.0, -1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat2 = texture(_MainTex, u_xlat2.zw);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1 = u_xlat1 + u_xlat3;
					    u_xlat3.xy = vs_TEXCOORD0.xy;
					    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat1 = u_xlat1 + u_xlat3;
					    u_xlat4 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat4 = u_xlat4 * vec4(_RenderViewportScaleFactor);
					    u_xlat5 = texture(_MainTex, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, u_xlat4.zw);
					    u_xlat1 = u_xlat1 + u_xlat5;
					    u_xlat5 = u_xlat3 + u_xlat5;
					    u_xlat1 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125);
					    u_xlat0 = u_xlat0 * vec4(0.125, 0.125, 0.125, 0.125) + u_xlat1;
					    u_xlat1 = u_xlat2 + u_xlat4;
					    u_xlat2 = u_xlat3 + u_xlat4;
					    u_xlat1 = u_xlat3 + u_xlat1;
					    u_xlat0 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125) + u_xlat0;
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 1.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat4 = u_xlat3 + u_xlat5;
					    u_xlat1 = u_xlat1 + u_xlat4;
					    u_xlat0 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125) + u_xlat0;
					    u_xlat1.xy = vs_TEXCOORD0.xy + _MainTex_TexelSize.xy;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat3 + u_xlat1;
					    u_xlat0 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125) + u_xlat0;
					    u_xlat0 = min(u_xlat0, vec4(65504.0, 65504.0, 65504.0, 65504.0));
					    u_xlat1 = texture(_AutoExposureTex, vs_TEXCOORD0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat0 = min(u_xlat0, _Params.xxxx);
					    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat1.x = max(u_xlat0.z, u_xlat1.x);
					    u_xlat1.yz = u_xlat1.xx + (-_Threshold.yx);
					    u_xlat1.xy = max(u_xlat1.xy, vec2(9.99999975e-05, 0.0));
					    u_xlat7 = min(u_xlat1.y, _Threshold.z);
					    u_xlat19 = u_xlat7 * _Threshold.w;
					    u_xlat7 = u_xlat7 * u_xlat19;
					    u_xlat7 = max(u_xlat1.z, u_xlat7);
					    u_xlat1.x = u_xlat7 / u_xlat1.x;
					    SV_Target0 = u_xlat0 * u_xlat1.xxxx;
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
					; Bound: 419
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %25 %413 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                    OpMemberDecorate %10 0 Offset 10 
					                                                    OpMemberDecorate %10 1 Offset 10 
					                                                    OpMemberDecorate %10 2 Offset 10 
					                                                    OpMemberDecorate %10 3 Offset 10 
					                                                    OpDecorate %10 Block 
					                                                    OpDecorate %12 DescriptorSet 12 
					                                                    OpDecorate %12 Binding 12 
					                                                    OpDecorate vs_TEXCOORD0 Location 25 
					                                                    OpDecorate %45 DescriptorSet 45 
					                                                    OpDecorate %45 Binding 45 
					                                                    OpDecorate %49 DescriptorSet 49 
					                                                    OpDecorate %49 Binding 49 
					                                                    OpDecorate %335 DescriptorSet 335 
					                                                    OpDecorate %335 Binding 335 
					                                                    OpDecorate %337 DescriptorSet 337 
					                                                    OpDecorate %337 Binding 337 
					                                                    OpDecorate %413 Location 413 
					                                             %2 = OpTypeVoid 
					                                             %3 = OpTypeFunction %2 
					                                             %6 = OpTypeFloat 32 
					                                             %7 = OpTypeVector %6 4 
					                                             %8 = OpTypePointer Private %7 
					                              Private f32_4* %9 = OpVariable Private 
					                                            %10 = OpTypeStruct %6 %7 %7 %7 
					                                            %11 = OpTypePointer Uniform %10 
					Uniform struct {f32; f32_4; f32_4; f32_4;}* %12 = OpVariable Uniform 
					                                            %13 = OpTypeInt 32 1 
					                                        i32 %14 = OpConstant 1 
					                                            %15 = OpTypePointer Uniform %7 
					                                        f32 %19 = OpConstant 3,674022E-40 
					                                        f32 %20 = OpConstant 3,674022E-40 
					                                      f32_4 %21 = OpConstantComposite %19 %19 %20 %19 
					                                            %23 = OpTypeVector %6 2 
					                                            %24 = OpTypePointer Input %23 
					                      Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                        f32 %30 = OpConstant 3,674022E-40 
					                                        f32 %31 = OpConstant 3,674022E-40 
					                                        i32 %36 = OpConstant 0 
					                                            %37 = OpTypePointer Uniform %6 
					                             Private f32_4* %42 = OpVariable Private 
					                                            %43 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                            %44 = OpTypePointer UniformConstant %43 
					       UniformConstant read_only Texture2D* %45 = OpVariable UniformConstant 
					                                            %47 = OpTypeSampler 
					                                            %48 = OpTypePointer UniformConstant %47 
					                   UniformConstant sampler* %49 = OpVariable UniformConstant 
					                                            %51 = OpTypeSampledImage %43 
					                                      f32_4 %68 = OpConstantComposite %19 %20 %20 %20 
					                             Private f32_4* %82 = OpVariable Private 
					                                       f32 %133 = OpConstant 3,674022E-40 
					                                     f32_4 %134 = OpConstantComposite %30 %133 %31 %133 
					                            Private f32_4* %148 = OpVariable Private 
					                            Private f32_4* %194 = OpVariable Private 
					                                     f32_4 %198 = OpConstantComposite %133 %30 %31 %30 
					                            Private f32_4* %212 = OpVariable Private 
					                                       f32 %232 = OpConstant 3,674022E-40 
					                                     f32_4 %233 = OpConstantComposite %232 %232 %232 %232 
					                                       f32 %236 = OpConstant 3,674022E-40 
					                                     f32_4 %237 = OpConstantComposite %236 %236 %236 %236 
					                                     f32_4 %257 = OpConstantComposite %133 %31 %30 %31 
					                                       f32 %332 = OpConstant 3,674022E-40 
					                                     f32_4 %333 = OpConstantComposite %332 %332 %332 %332 
					      UniformConstant read_only Texture2D* %335 = OpVariable UniformConstant 
					                  UniformConstant sampler* %337 = OpVariable UniformConstant 
					                                           %342 = OpTypeInt 32 0 
					                                       u32 %343 = OpConstant 0 
					                                           %345 = OpTypePointer Private %6 
					                                       i32 %352 = OpConstant 3 
					                                       u32 %357 = OpConstant 1 
					                                       u32 %364 = OpConstant 2 
					                                       i32 %373 = OpConstant 2 
					                                       f32 %383 = OpConstant 3,674022E-40 
					                                     f32_2 %384 = OpConstantComposite %383 %30 
					                              Private f32* %388 = OpVariable Private 
					                              Private f32* %394 = OpVariable Private 
					                                       u32 %396 = OpConstant 3 
					                                           %412 = OpTypePointer Output %7 
					                             Output f32_4* %413 = OpVariable Output 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                             Uniform f32_4* %16 = OpAccessChain %12 %14 
					                                      f32_4 %17 = OpLoad %16 
					                                      f32_4 %18 = OpVectorShuffle %17 %17 0 1 0 1 
					                                      f32_4 %22 = OpFMul %18 %21 
					                                      f32_2 %26 = OpLoad vs_TEXCOORD0 
					                                      f32_4 %27 = OpVectorShuffle %26 %26 0 1 0 1 
					                                      f32_4 %28 = OpFAdd %22 %27 
					                                                    OpStore %9 %28 
					                                      f32_4 %29 = OpLoad %9 
					                                      f32_4 %32 = OpCompositeConstruct %30 %30 %30 %30 
					                                      f32_4 %33 = OpCompositeConstruct %31 %31 %31 %31 
					                                      f32_4 %34 = OpExtInst %1 43 %29 %32 %33 
					                                                    OpStore %9 %34 
					                                      f32_4 %35 = OpLoad %9 
					                               Uniform f32* %38 = OpAccessChain %12 %36 
					                                        f32 %39 = OpLoad %38 
					                                      f32_4 %40 = OpCompositeConstruct %39 %39 %39 %39 
					                                      f32_4 %41 = OpFMul %35 %40 
					                                                    OpStore %9 %41 
					                        read_only Texture2D %46 = OpLoad %45 
					                                    sampler %50 = OpLoad %49 
					                 read_only Texture2DSampled %52 = OpSampledImage %46 %50 
					                                      f32_4 %53 = OpLoad %9 
					                                      f32_2 %54 = OpVectorShuffle %53 %53 0 1 
					                                      f32_4 %55 = OpImageSampleImplicitLod %52 %54 
					                                                    OpStore %42 %55 
					                        read_only Texture2D %56 = OpLoad %45 
					                                    sampler %57 = OpLoad %49 
					                 read_only Texture2DSampled %58 = OpSampledImage %56 %57 
					                                      f32_4 %59 = OpLoad %9 
					                                      f32_2 %60 = OpVectorShuffle %59 %59 2 3 
					                                      f32_4 %61 = OpImageSampleImplicitLod %58 %60 
					                                                    OpStore %9 %61 
					                                      f32_4 %62 = OpLoad %9 
					                                      f32_4 %63 = OpLoad %42 
					                                      f32_4 %64 = OpFAdd %62 %63 
					                                                    OpStore %9 %64 
					                             Uniform f32_4* %65 = OpAccessChain %12 %14 
					                                      f32_4 %66 = OpLoad %65 
					                                      f32_4 %67 = OpVectorShuffle %66 %66 0 1 0 1 
					                                      f32_4 %69 = OpFMul %67 %68 
					                                      f32_2 %70 = OpLoad vs_TEXCOORD0 
					                                      f32_4 %71 = OpVectorShuffle %70 %70 0 1 0 1 
					                                      f32_4 %72 = OpFAdd %69 %71 
					                                                    OpStore %42 %72 
					                                      f32_4 %73 = OpLoad %42 
					                                      f32_4 %74 = OpCompositeConstruct %30 %30 %30 %30 
					                                      f32_4 %75 = OpCompositeConstruct %31 %31 %31 %31 
					                                      f32_4 %76 = OpExtInst %1 43 %73 %74 %75 
					                                                    OpStore %42 %76 
					                                      f32_4 %77 = OpLoad %42 
					                               Uniform f32* %78 = OpAccessChain %12 %36 
					                                        f32 %79 = OpLoad %78 
					                                      f32_4 %80 = OpCompositeConstruct %79 %79 %79 %79 
					                                      f32_4 %81 = OpFMul %77 %80 
					                                                    OpStore %42 %81 
					                        read_only Texture2D %83 = OpLoad %45 
					                                    sampler %84 = OpLoad %49 
					                 read_only Texture2DSampled %85 = OpSampledImage %83 %84 
					                                      f32_4 %86 = OpLoad %42 
					                                      f32_2 %87 = OpVectorShuffle %86 %86 0 1 
					                                      f32_4 %88 = OpImageSampleImplicitLod %85 %87 
					                                                    OpStore %82 %88 
					                        read_only Texture2D %89 = OpLoad %45 
					                                    sampler %90 = OpLoad %49 
					                 read_only Texture2DSampled %91 = OpSampledImage %89 %90 
					                                      f32_4 %92 = OpLoad %42 
					                                      f32_2 %93 = OpVectorShuffle %92 %92 2 3 
					                                      f32_4 %94 = OpImageSampleImplicitLod %91 %93 
					                                                    OpStore %42 %94 
					                                      f32_4 %95 = OpLoad %9 
					                                      f32_4 %96 = OpLoad %82 
					                                      f32_4 %97 = OpFAdd %95 %96 
					                                                    OpStore %9 %97 
					                                      f32_4 %98 = OpLoad %42 
					                                      f32_4 %99 = OpLoad %9 
					                                     f32_4 %100 = OpFAdd %98 %99 
					                                                    OpStore %9 %100 
					                                     f32_2 %101 = OpLoad vs_TEXCOORD0 
					                            Uniform f32_4* %102 = OpAccessChain %12 %14 
					                                     f32_4 %103 = OpLoad %102 
					                                     f32_2 %104 = OpVectorShuffle %103 %103 0 1 
					                                     f32_2 %105 = OpFNegate %104 
					                                     f32_2 %106 = OpFAdd %101 %105 
					                                     f32_4 %107 = OpLoad %42 
					                                     f32_4 %108 = OpVectorShuffle %107 %106 4 5 2 3 
					                                                    OpStore %42 %108 
					                                     f32_4 %109 = OpLoad %42 
					                                     f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                     f32_2 %111 = OpCompositeConstruct %30 %30 
					                                     f32_2 %112 = OpCompositeConstruct %31 %31 
					                                     f32_2 %113 = OpExtInst %1 43 %110 %111 %112 
					                                     f32_4 %114 = OpLoad %42 
					                                     f32_4 %115 = OpVectorShuffle %114 %113 4 5 2 3 
					                                                    OpStore %42 %115 
					                                     f32_4 %116 = OpLoad %42 
					                                     f32_2 %117 = OpVectorShuffle %116 %116 0 1 
					                              Uniform f32* %118 = OpAccessChain %12 %36 
					                                       f32 %119 = OpLoad %118 
					                                     f32_2 %120 = OpCompositeConstruct %119 %119 
					                                     f32_2 %121 = OpFMul %117 %120 
					                                     f32_4 %122 = OpLoad %42 
					                                     f32_4 %123 = OpVectorShuffle %122 %121 4 5 2 3 
					                                                    OpStore %42 %123 
					                       read_only Texture2D %124 = OpLoad %45 
					                                   sampler %125 = OpLoad %49 
					                read_only Texture2DSampled %126 = OpSampledImage %124 %125 
					                                     f32_4 %127 = OpLoad %42 
					                                     f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                                     f32_4 %129 = OpImageSampleImplicitLod %126 %128 
					                                                    OpStore %42 %129 
					                            Uniform f32_4* %130 = OpAccessChain %12 %14 
					                                     f32_4 %131 = OpLoad %130 
					                                     f32_4 %132 = OpVectorShuffle %131 %131 0 1 0 1 
					                                     f32_4 %135 = OpFMul %132 %134 
					                                     f32_2 %136 = OpLoad vs_TEXCOORD0 
					                                     f32_4 %137 = OpVectorShuffle %136 %136 0 1 0 1 
					                                     f32_4 %138 = OpFAdd %135 %137 
					                                                    OpStore %82 %138 
					                                     f32_4 %139 = OpLoad %82 
					                                     f32_4 %140 = OpCompositeConstruct %30 %30 %30 %30 
					                                     f32_4 %141 = OpCompositeConstruct %31 %31 %31 %31 
					                                     f32_4 %142 = OpExtInst %1 43 %139 %140 %141 
					                                                    OpStore %82 %142 
					                                     f32_4 %143 = OpLoad %82 
					                              Uniform f32* %144 = OpAccessChain %12 %36 
					                                       f32 %145 = OpLoad %144 
					                                     f32_4 %146 = OpCompositeConstruct %145 %145 %145 %145 
					                                     f32_4 %147 = OpFMul %143 %146 
					                                                    OpStore %82 %147 
					                       read_only Texture2D %149 = OpLoad %45 
					                                   sampler %150 = OpLoad %49 
					                read_only Texture2DSampled %151 = OpSampledImage %149 %150 
					                                     f32_4 %152 = OpLoad %82 
					                                     f32_2 %153 = OpVectorShuffle %152 %152 0 1 
					                                     f32_4 %154 = OpImageSampleImplicitLod %151 %153 
					                                                    OpStore %148 %154 
					                       read_only Texture2D %155 = OpLoad %45 
					                                   sampler %156 = OpLoad %49 
					                read_only Texture2DSampled %157 = OpSampledImage %155 %156 
					                                     f32_4 %158 = OpLoad %82 
					                                     f32_2 %159 = OpVectorShuffle %158 %158 2 3 
					                                     f32_4 %160 = OpImageSampleImplicitLod %157 %159 
					                                                    OpStore %82 %160 
					                                     f32_4 %161 = OpLoad %82 
					                                     f32_4 %162 = OpLoad %148 
					                                     f32_4 %163 = OpFAdd %161 %162 
					                                                    OpStore %82 %163 
					                                     f32_4 %164 = OpLoad %42 
					                                     f32_4 %165 = OpLoad %148 
					                                     f32_4 %166 = OpFAdd %164 %165 
					                                                    OpStore %42 %166 
					                                     f32_2 %167 = OpLoad vs_TEXCOORD0 
					                                     f32_4 %168 = OpLoad %148 
					                                     f32_4 %169 = OpVectorShuffle %168 %167 4 5 2 3 
					                                                    OpStore %148 %169 
					                                     f32_4 %170 = OpLoad %148 
					                                     f32_2 %171 = OpVectorShuffle %170 %170 0 1 
					                                     f32_2 %172 = OpCompositeConstruct %30 %30 
					                                     f32_2 %173 = OpCompositeConstruct %31 %31 
					                                     f32_2 %174 = OpExtInst %1 43 %171 %172 %173 
					                                     f32_4 %175 = OpLoad %148 
					                                     f32_4 %176 = OpVectorShuffle %175 %174 4 5 2 3 
					                                                    OpStore %148 %176 
					                                     f32_4 %177 = OpLoad %148 
					                                     f32_2 %178 = OpVectorShuffle %177 %177 0 1 
					                              Uniform f32* %179 = OpAccessChain %12 %36 
					                                       f32 %180 = OpLoad %179 
					                                     f32_2 %181 = OpCompositeConstruct %180 %180 
					                                     f32_2 %182 = OpFMul %178 %181 
					                                     f32_4 %183 = OpLoad %148 
					                                     f32_4 %184 = OpVectorShuffle %183 %182 4 5 2 3 
					                                                    OpStore %148 %184 
					                       read_only Texture2D %185 = OpLoad %45 
					                                   sampler %186 = OpLoad %49 
					                read_only Texture2DSampled %187 = OpSampledImage %185 %186 
					                                     f32_4 %188 = OpLoad %148 
					                                     f32_2 %189 = OpVectorShuffle %188 %188 0 1 
					                                     f32_4 %190 = OpImageSampleImplicitLod %187 %189 
					                                                    OpStore %148 %190 
					                                     f32_4 %191 = OpLoad %42 
					                                     f32_4 %192 = OpLoad %148 
					                                     f32_4 %193 = OpFAdd %191 %192 
					                                                    OpStore %42 %193 
					                            Uniform f32_4* %195 = OpAccessChain %12 %14 
					                                     f32_4 %196 = OpLoad %195 
					                                     f32_4 %197 = OpVectorShuffle %196 %196 0 1 0 1 
					                                     f32_4 %199 = OpFMul %197 %198 
					                                     f32_2 %200 = OpLoad vs_TEXCOORD0 
					                                     f32_4 %201 = OpVectorShuffle %200 %200 0 1 0 1 
					                                     f32_4 %202 = OpFAdd %199 %201 
					                                                    OpStore %194 %202 
					                                     f32_4 %203 = OpLoad %194 
					                                     f32_4 %204 = OpCompositeConstruct %30 %30 %30 %30 
					                                     f32_4 %205 = OpCompositeConstruct %31 %31 %31 %31 
					                                     f32_4 %206 = OpExtInst %1 43 %203 %204 %205 
					                                                    OpStore %194 %206 
					                                     f32_4 %207 = OpLoad %194 
					                              Uniform f32* %208 = OpAccessChain %12 %36 
					                                       f32 %209 = OpLoad %208 
					                                     f32_4 %210 = OpCompositeConstruct %209 %209 %209 %209 
					                                     f32_4 %211 = OpFMul %207 %210 
					                                                    OpStore %194 %211 
					                       read_only Texture2D %213 = OpLoad %45 
					                                   sampler %214 = OpLoad %49 
					                read_only Texture2DSampled %215 = OpSampledImage %213 %214 
					                                     f32_4 %216 = OpLoad %194 
					                                     f32_2 %217 = OpVectorShuffle %216 %216 0 1 
					                                     f32_4 %218 = OpImageSampleImplicitLod %215 %217 
					                                                    OpStore %212 %218 
					                       read_only Texture2D %219 = OpLoad %45 
					                                   sampler %220 = OpLoad %49 
					                read_only Texture2DSampled %221 = OpSampledImage %219 %220 
					                                     f32_4 %222 = OpLoad %194 
					                                     f32_2 %223 = OpVectorShuffle %222 %222 2 3 
					                                     f32_4 %224 = OpImageSampleImplicitLod %221 %223 
					                                                    OpStore %194 %224 
					                                     f32_4 %225 = OpLoad %42 
					                                     f32_4 %226 = OpLoad %212 
					                                     f32_4 %227 = OpFAdd %225 %226 
					                                                    OpStore %42 %227 
					                                     f32_4 %228 = OpLoad %148 
					                                     f32_4 %229 = OpLoad %212 
					                                     f32_4 %230 = OpFAdd %228 %229 
					                                                    OpStore %212 %230 
					                                     f32_4 %231 = OpLoad %42 
					                                     f32_4 %234 = OpFMul %231 %233 
					                                                    OpStore %42 %234 
					                                     f32_4 %235 = OpLoad %9 
					                                     f32_4 %238 = OpFMul %235 %237 
					                                     f32_4 %239 = OpLoad %42 
					                                     f32_4 %240 = OpFAdd %238 %239 
					                                                    OpStore %9 %240 
					                                     f32_4 %241 = OpLoad %82 
					                                     f32_4 %242 = OpLoad %194 
					                                     f32_4 %243 = OpFAdd %241 %242 
					                                                    OpStore %42 %243 
					                                     f32_4 %244 = OpLoad %148 
					                                     f32_4 %245 = OpLoad %194 
					                                     f32_4 %246 = OpFAdd %244 %245 
					                                                    OpStore %82 %246 
					                                     f32_4 %247 = OpLoad %148 
					                                     f32_4 %248 = OpLoad %42 
					                                     f32_4 %249 = OpFAdd %247 %248 
					                                                    OpStore %42 %249 
					                                     f32_4 %250 = OpLoad %42 
					                                     f32_4 %251 = OpFMul %250 %233 
					                                     f32_4 %252 = OpLoad %9 
					                                     f32_4 %253 = OpFAdd %251 %252 
					                                                    OpStore %9 %253 
					                            Uniform f32_4* %254 = OpAccessChain %12 %14 
					                                     f32_4 %255 = OpLoad %254 
					                                     f32_4 %256 = OpVectorShuffle %255 %255 0 1 0 1 
					                                     f32_4 %258 = OpFMul %256 %257 
					                                     f32_2 %259 = OpLoad vs_TEXCOORD0 
					                                     f32_4 %260 = OpVectorShuffle %259 %259 0 1 0 1 
					                                     f32_4 %261 = OpFAdd %258 %260 
					                                                    OpStore %42 %261 
					                                     f32_4 %262 = OpLoad %42 
					                                     f32_4 %263 = OpCompositeConstruct %30 %30 %30 %30 
					                                     f32_4 %264 = OpCompositeConstruct %31 %31 %31 %31 
					                                     f32_4 %265 = OpExtInst %1 43 %262 %263 %264 
					                                                    OpStore %42 %265 
					                                     f32_4 %266 = OpLoad %42 
					                              Uniform f32* %267 = OpAccessChain %12 %36 
					                                       f32 %268 = OpLoad %267 
					                                     f32_4 %269 = OpCompositeConstruct %268 %268 %268 %268 
					                                     f32_4 %270 = OpFMul %266 %269 
					                                                    OpStore %42 %270 
					                       read_only Texture2D %271 = OpLoad %45 
					                                   sampler %272 = OpLoad %49 
					                read_only Texture2DSampled %273 = OpSampledImage %271 %272 
					                                     f32_4 %274 = OpLoad %42 
					                                     f32_2 %275 = OpVectorShuffle %274 %274 2 3 
					                                     f32_4 %276 = OpImageSampleImplicitLod %273 %275 
					                                                    OpStore %148 %276 
					                       read_only Texture2D %277 = OpLoad %45 
					                                   sampler %278 = OpLoad %49 
					                read_only Texture2DSampled %279 = OpSampledImage %277 %278 
					                                     f32_4 %280 = OpLoad %42 
					                                     f32_2 %281 = OpVectorShuffle %280 %280 0 1 
					                                     f32_4 %282 = OpImageSampleImplicitLod %279 %281 
					                                                    OpStore %42 %282 
					                                     f32_4 %283 = OpLoad %148 
					                                     f32_4 %284 = OpLoad %212 
					                                     f32_4 %285 = OpFAdd %283 %284 
					                                                    OpStore %194 %285 
					                                     f32_4 %286 = OpLoad %42 
					                                     f32_4 %287 = OpLoad %194 
					                                     f32_4 %288 = OpFAdd %286 %287 
					                                                    OpStore %42 %288 
					                                     f32_4 %289 = OpLoad %42 
					                                     f32_4 %290 = OpFMul %289 %233 
					                                     f32_4 %291 = OpLoad %9 
					                                     f32_4 %292 = OpFAdd %290 %291 
					                                                    OpStore %9 %292 
					                                     f32_2 %293 = OpLoad vs_TEXCOORD0 
					                            Uniform f32_4* %294 = OpAccessChain %12 %14 
					                                     f32_4 %295 = OpLoad %294 
					                                     f32_2 %296 = OpVectorShuffle %295 %295 0 1 
					                                     f32_2 %297 = OpFAdd %293 %296 
					                                     f32_4 %298 = OpLoad %42 
					                                     f32_4 %299 = OpVectorShuffle %298 %297 4 5 2 3 
					                                                    OpStore %42 %299 
					                                     f32_4 %300 = OpLoad %42 
					                                     f32_2 %301 = OpVectorShuffle %300 %300 0 1 
					                                     f32_2 %302 = OpCompositeConstruct %30 %30 
					                                     f32_2 %303 = OpCompositeConstruct %31 %31 
					                                     f32_2 %304 = OpExtInst %1 43 %301 %302 %303 
					                                     f32_4 %305 = OpLoad %42 
					                                     f32_4 %306 = OpVectorShuffle %305 %304 4 5 2 3 
					                                                    OpStore %42 %306 
					                                     f32_4 %307 = OpLoad %42 
					                                     f32_2 %308 = OpVectorShuffle %307 %307 0 1 
					                              Uniform f32* %309 = OpAccessChain %12 %36 
					                                       f32 %310 = OpLoad %309 
					                                     f32_2 %311 = OpCompositeConstruct %310 %310 
					                                     f32_2 %312 = OpFMul %308 %311 
					                                     f32_4 %313 = OpLoad %42 
					                                     f32_4 %314 = OpVectorShuffle %313 %312 4 5 2 3 
					                                                    OpStore %42 %314 
					                       read_only Texture2D %315 = OpLoad %45 
					                                   sampler %316 = OpLoad %49 
					                read_only Texture2DSampled %317 = OpSampledImage %315 %316 
					                                     f32_4 %318 = OpLoad %42 
					                                     f32_2 %319 = OpVectorShuffle %318 %318 0 1 
					                                     f32_4 %320 = OpImageSampleImplicitLod %317 %319 
					                                                    OpStore %42 %320 
					                                     f32_4 %321 = OpLoad %42 
					                                     f32_4 %322 = OpLoad %82 
					                                     f32_4 %323 = OpFAdd %321 %322 
					                                                    OpStore %42 %323 
					                                     f32_4 %324 = OpLoad %148 
					                                     f32_4 %325 = OpLoad %42 
					                                     f32_4 %326 = OpFAdd %324 %325 
					                                                    OpStore %42 %326 
					                                     f32_4 %327 = OpLoad %42 
					                                     f32_4 %328 = OpFMul %327 %233 
					                                     f32_4 %329 = OpLoad %9 
					                                     f32_4 %330 = OpFAdd %328 %329 
					                                                    OpStore %9 %330 
					                                     f32_4 %331 = OpLoad %9 
					                                     f32_4 %334 = OpExtInst %1 37 %331 %333 
					                                                    OpStore %9 %334 
					                       read_only Texture2D %336 = OpLoad %335 
					                                   sampler %338 = OpLoad %337 
					                read_only Texture2DSampled %339 = OpSampledImage %336 %338 
					                                     f32_2 %340 = OpLoad vs_TEXCOORD0 
					                                     f32_4 %341 = OpImageSampleImplicitLod %339 %340 
					                                       f32 %344 = OpCompositeExtract %341 0 
					                              Private f32* %346 = OpAccessChain %42 %343 
					                                                    OpStore %346 %344 
					                                     f32_4 %347 = OpLoad %9 
					                                     f32_4 %348 = OpLoad %42 
					                                     f32_4 %349 = OpVectorShuffle %348 %348 0 0 0 0 
					                                     f32_4 %350 = OpFMul %347 %349 
					                                                    OpStore %9 %350 
					                                     f32_4 %351 = OpLoad %9 
					                            Uniform f32_4* %353 = OpAccessChain %12 %352 
					                                     f32_4 %354 = OpLoad %353 
					                                     f32_4 %355 = OpVectorShuffle %354 %354 0 0 0 0 
					                                     f32_4 %356 = OpExtInst %1 37 %351 %355 
					                                                    OpStore %9 %356 
					                              Private f32* %358 = OpAccessChain %9 %357 
					                                       f32 %359 = OpLoad %358 
					                              Private f32* %360 = OpAccessChain %9 %343 
					                                       f32 %361 = OpLoad %360 
					                                       f32 %362 = OpExtInst %1 40 %359 %361 
					                              Private f32* %363 = OpAccessChain %42 %343 
					                                                    OpStore %363 %362 
					                              Private f32* %365 = OpAccessChain %9 %364 
					                                       f32 %366 = OpLoad %365 
					                              Private f32* %367 = OpAccessChain %42 %343 
					                                       f32 %368 = OpLoad %367 
					                                       f32 %369 = OpExtInst %1 40 %366 %368 
					                              Private f32* %370 = OpAccessChain %42 %343 
					                                                    OpStore %370 %369 
					                                     f32_4 %371 = OpLoad %42 
					                                     f32_2 %372 = OpVectorShuffle %371 %371 0 0 
					                            Uniform f32_4* %374 = OpAccessChain %12 %373 
					                                     f32_4 %375 = OpLoad %374 
					                                     f32_2 %376 = OpVectorShuffle %375 %375 1 0 
					                                     f32_2 %377 = OpFNegate %376 
					                                     f32_2 %378 = OpFAdd %372 %377 
					                                     f32_4 %379 = OpLoad %42 
					                                     f32_4 %380 = OpVectorShuffle %379 %378 0 4 5 3 
					                                                    OpStore %42 %380 
					                                     f32_4 %381 = OpLoad %42 
					                                     f32_2 %382 = OpVectorShuffle %381 %381 0 1 
					                                     f32_2 %385 = OpExtInst %1 40 %382 %384 
					                                     f32_4 %386 = OpLoad %42 
					                                     f32_4 %387 = OpVectorShuffle %386 %385 4 5 2 3 
					                                                    OpStore %42 %387 
					                              Private f32* %389 = OpAccessChain %42 %357 
					                                       f32 %390 = OpLoad %389 
					                              Uniform f32* %391 = OpAccessChain %12 %373 %364 
					                                       f32 %392 = OpLoad %391 
					                                       f32 %393 = OpExtInst %1 37 %390 %392 
					                                                    OpStore %388 %393 
					                                       f32 %395 = OpLoad %388 
					                              Uniform f32* %397 = OpAccessChain %12 %373 %396 
					                                       f32 %398 = OpLoad %397 
					                                       f32 %399 = OpFMul %395 %398 
					                                                    OpStore %394 %399 
					                                       f32 %400 = OpLoad %388 
					                                       f32 %401 = OpLoad %394 
					                                       f32 %402 = OpFMul %400 %401 
					                                                    OpStore %388 %402 
					                              Private f32* %403 = OpAccessChain %42 %364 
					                                       f32 %404 = OpLoad %403 
					                                       f32 %405 = OpLoad %388 
					                                       f32 %406 = OpExtInst %1 40 %404 %405 
					                                                    OpStore %388 %406 
					                                       f32 %407 = OpLoad %388 
					                              Private f32* %408 = OpAccessChain %42 %343 
					                                       f32 %409 = OpLoad %408 
					                                       f32 %410 = OpFDiv %407 %409 
					                              Private f32* %411 = OpAccessChain %42 %343 
					                                                    OpStore %411 %410 
					                                     f32_4 %414 = OpLoad %9 
					                                     f32_4 %415 = OpLoad %42 
					                                     f32_4 %416 = OpVectorShuffle %415 %415 0 0 0 0 
					                                     f32_4 %417 = OpFMul %414 %416 
					                                                    OpStore %413 %417 
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
						vec4 _Threshold;
						vec4 _Params;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AutoExposureTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat7;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + vs_TEXCOORD0.xyxy;
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
					    u_xlat1.xy = vs_TEXCOORD0.xy + (-_MainTex_TexelSize.xy);
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(0.0, -1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat2 = texture(_MainTex, u_xlat2.zw);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1 = u_xlat1 + u_xlat3;
					    u_xlat3.xy = vs_TEXCOORD0.xy;
					    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat1 = u_xlat1 + u_xlat3;
					    u_xlat4 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat4 = u_xlat4 * vec4(_RenderViewportScaleFactor);
					    u_xlat5 = texture(_MainTex, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, u_xlat4.zw);
					    u_xlat1 = u_xlat1 + u_xlat5;
					    u_xlat5 = u_xlat3 + u_xlat5;
					    u_xlat1 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125);
					    u_xlat0 = u_xlat0 * vec4(0.125, 0.125, 0.125, 0.125) + u_xlat1;
					    u_xlat1 = u_xlat2 + u_xlat4;
					    u_xlat2 = u_xlat3 + u_xlat4;
					    u_xlat1 = u_xlat3 + u_xlat1;
					    u_xlat0 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125) + u_xlat0;
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 1.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat4 = u_xlat3 + u_xlat5;
					    u_xlat1 = u_xlat1 + u_xlat4;
					    u_xlat0 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125) + u_xlat0;
					    u_xlat1.xy = vs_TEXCOORD0.xy + _MainTex_TexelSize.xy;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat3 + u_xlat1;
					    u_xlat0 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125) + u_xlat0;
					    u_xlat0 = min(u_xlat0, vec4(65504.0, 65504.0, 65504.0, 65504.0));
					    u_xlat1 = texture(_AutoExposureTex, vs_TEXCOORD0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat0 = min(u_xlat0, _Params.xxxx);
					    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat1.x = max(u_xlat0.z, u_xlat1.x);
					    u_xlat1.yz = u_xlat1.xx + (-_Threshold.yx);
					    u_xlat1.xy = max(u_xlat1.xy, vec2(9.99999975e-05, 0.0));
					    u_xlat7 = min(u_xlat1.y, _Threshold.z);
					    u_xlat19 = u_xlat7 * _Threshold.w;
					    u_xlat7 = u_xlat7 * u_xlat19;
					    u_xlat7 = max(u_xlat1.z, u_xlat7);
					    u_xlat1.x = u_xlat7 / u_xlat1.x;
					    SV_Target0 = u_xlat0 * u_xlat1.xxxx;
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
			GpuProgramID 106751
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
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	vec4 _Threshold;
					uniform 	vec4 _Params;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _AutoExposureTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat4;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-1.0, -1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 1.0, 1.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat0 = u_xlat0 + u_xlat2;
					    u_xlat0 = u_xlat1 + u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25);
					    u_xlat0 = min(u_xlat0, vec4(65504.0, 65504.0, 65504.0, 65504.0));
					    u_xlat1 = texture(_AutoExposureTex, vs_TEXCOORD0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat0 = min(u_xlat0, _Params.xxxx);
					    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat1.x = max(u_xlat0.z, u_xlat1.x);
					    u_xlat1.yz = u_xlat1.xx + (-_Threshold.yx);
					    u_xlat1.xy = max(u_xlat1.xy, vec2(9.99999975e-05, 0.0));
					    u_xlat4 = min(u_xlat1.y, _Threshold.z);
					    u_xlat10 = u_xlat4 * _Threshold.w;
					    u_xlat4 = u_xlat4 * u_xlat10;
					    u_xlat4 = max(u_xlat1.z, u_xlat4);
					    u_xlat1.x = u_xlat4 / u_xlat1.x;
					    SV_Target0 = u_xlat0 * u_xlat1.xxxx;
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
					; Bound: 192
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %25 %186 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                    OpMemberDecorate %10 0 Offset 10 
					                                                    OpMemberDecorate %10 1 Offset 10 
					                                                    OpMemberDecorate %10 2 Offset 10 
					                                                    OpMemberDecorate %10 3 Offset 10 
					                                                    OpDecorate %10 Block 
					                                                    OpDecorate %12 DescriptorSet 12 
					                                                    OpDecorate %12 Binding 12 
					                                                    OpDecorate vs_TEXCOORD0 Location 25 
					                                                    OpDecorate %44 DescriptorSet 44 
					                                                    OpDecorate %44 Binding 44 
					                                                    OpDecorate %48 DescriptorSet 48 
					                                                    OpDecorate %48 Binding 48 
					                                                    OpDecorate %108 DescriptorSet 108 
					                                                    OpDecorate %108 Binding 108 
					                                                    OpDecorate %110 DescriptorSet 110 
					                                                    OpDecorate %110 Binding 110 
					                                                    OpDecorate %186 Location 186 
					                                             %2 = OpTypeVoid 
					                                             %3 = OpTypeFunction %2 
					                                             %6 = OpTypeFloat 32 
					                                             %7 = OpTypeVector %6 4 
					                                             %8 = OpTypePointer Private %7 
					                              Private f32_4* %9 = OpVariable Private 
					                                            %10 = OpTypeStruct %6 %7 %7 %7 
					                                            %11 = OpTypePointer Uniform %10 
					Uniform struct {f32; f32_4; f32_4; f32_4;}* %12 = OpVariable Uniform 
					                                            %13 = OpTypeInt 32 1 
					                                        i32 %14 = OpConstant 1 
					                                            %15 = OpTypePointer Uniform %7 
					                                        f32 %19 = OpConstant 3,674022E-40 
					                                        f32 %20 = OpConstant 3,674022E-40 
					                                      f32_4 %21 = OpConstantComposite %19 %19 %20 %19 
					                                            %23 = OpTypeVector %6 2 
					                                            %24 = OpTypePointer Input %23 
					                      Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                        f32 %30 = OpConstant 3,674022E-40 
					                                        i32 %35 = OpConstant 0 
					                                            %36 = OpTypePointer Uniform %6 
					                             Private f32_4* %41 = OpVariable Private 
					                                            %42 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                            %43 = OpTypePointer UniformConstant %42 
					       UniformConstant read_only Texture2D* %44 = OpVariable UniformConstant 
					                                            %46 = OpTypeSampler 
					                                            %47 = OpTypePointer UniformConstant %46 
					                   UniformConstant sampler* %48 = OpVariable UniformConstant 
					                                            %50 = OpTypeSampledImage %42 
					                                      f32_4 %67 = OpConstantComposite %19 %20 %20 %20 
					                             Private f32_4* %81 = OpVariable Private 
					                                       f32 %101 = OpConstant 3,674022E-40 
					                                     f32_4 %102 = OpConstantComposite %101 %101 %101 %101 
					                                       f32 %105 = OpConstant 3,674022E-40 
					                                     f32_4 %106 = OpConstantComposite %105 %105 %105 %105 
					      UniformConstant read_only Texture2D* %108 = OpVariable UniformConstant 
					                  UniformConstant sampler* %110 = OpVariable UniformConstant 
					                                           %115 = OpTypeInt 32 0 
					                                       u32 %116 = OpConstant 0 
					                                           %118 = OpTypePointer Private %6 
					                                       i32 %125 = OpConstant 3 
					                                       u32 %130 = OpConstant 1 
					                                       u32 %137 = OpConstant 2 
					                                       i32 %146 = OpConstant 2 
					                                       f32 %156 = OpConstant 3,674022E-40 
					                                     f32_2 %157 = OpConstantComposite %156 %30 
					                              Private f32* %161 = OpVariable Private 
					                              Private f32* %167 = OpVariable Private 
					                                       u32 %169 = OpConstant 3 
					                                           %185 = OpTypePointer Output %7 
					                             Output f32_4* %186 = OpVariable Output 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                             Uniform f32_4* %16 = OpAccessChain %12 %14 
					                                      f32_4 %17 = OpLoad %16 
					                                      f32_4 %18 = OpVectorShuffle %17 %17 0 1 0 1 
					                                      f32_4 %22 = OpFMul %18 %21 
					                                      f32_2 %26 = OpLoad vs_TEXCOORD0 
					                                      f32_4 %27 = OpVectorShuffle %26 %26 0 1 0 1 
					                                      f32_4 %28 = OpFAdd %22 %27 
					                                                    OpStore %9 %28 
					                                      f32_4 %29 = OpLoad %9 
					                                      f32_4 %31 = OpCompositeConstruct %30 %30 %30 %30 
					                                      f32_4 %32 = OpCompositeConstruct %20 %20 %20 %20 
					                                      f32_4 %33 = OpExtInst %1 43 %29 %31 %32 
					                                                    OpStore %9 %33 
					                                      f32_4 %34 = OpLoad %9 
					                               Uniform f32* %37 = OpAccessChain %12 %35 
					                                        f32 %38 = OpLoad %37 
					                                      f32_4 %39 = OpCompositeConstruct %38 %38 %38 %38 
					                                      f32_4 %40 = OpFMul %34 %39 
					                                                    OpStore %9 %40 
					                        read_only Texture2D %45 = OpLoad %44 
					                                    sampler %49 = OpLoad %48 
					                 read_only Texture2DSampled %51 = OpSampledImage %45 %49 
					                                      f32_4 %52 = OpLoad %9 
					                                      f32_2 %53 = OpVectorShuffle %52 %52 0 1 
					                                      f32_4 %54 = OpImageSampleImplicitLod %51 %53 
					                                                    OpStore %41 %54 
					                        read_only Texture2D %55 = OpLoad %44 
					                                    sampler %56 = OpLoad %48 
					                 read_only Texture2DSampled %57 = OpSampledImage %55 %56 
					                                      f32_4 %58 = OpLoad %9 
					                                      f32_2 %59 = OpVectorShuffle %58 %58 2 3 
					                                      f32_4 %60 = OpImageSampleImplicitLod %57 %59 
					                                                    OpStore %9 %60 
					                                      f32_4 %61 = OpLoad %9 
					                                      f32_4 %62 = OpLoad %41 
					                                      f32_4 %63 = OpFAdd %61 %62 
					                                                    OpStore %9 %63 
					                             Uniform f32_4* %64 = OpAccessChain %12 %14 
					                                      f32_4 %65 = OpLoad %64 
					                                      f32_4 %66 = OpVectorShuffle %65 %65 0 1 0 1 
					                                      f32_4 %68 = OpFMul %66 %67 
					                                      f32_2 %69 = OpLoad vs_TEXCOORD0 
					                                      f32_4 %70 = OpVectorShuffle %69 %69 0 1 0 1 
					                                      f32_4 %71 = OpFAdd %68 %70 
					                                                    OpStore %41 %71 
					                                      f32_4 %72 = OpLoad %41 
					                                      f32_4 %73 = OpCompositeConstruct %30 %30 %30 %30 
					                                      f32_4 %74 = OpCompositeConstruct %20 %20 %20 %20 
					                                      f32_4 %75 = OpExtInst %1 43 %72 %73 %74 
					                                                    OpStore %41 %75 
					                                      f32_4 %76 = OpLoad %41 
					                               Uniform f32* %77 = OpAccessChain %12 %35 
					                                        f32 %78 = OpLoad %77 
					                                      f32_4 %79 = OpCompositeConstruct %78 %78 %78 %78 
					                                      f32_4 %80 = OpFMul %76 %79 
					                                                    OpStore %41 %80 
					                        read_only Texture2D %82 = OpLoad %44 
					                                    sampler %83 = OpLoad %48 
					                 read_only Texture2DSampled %84 = OpSampledImage %82 %83 
					                                      f32_4 %85 = OpLoad %41 
					                                      f32_2 %86 = OpVectorShuffle %85 %85 0 1 
					                                      f32_4 %87 = OpImageSampleImplicitLod %84 %86 
					                                                    OpStore %81 %87 
					                        read_only Texture2D %88 = OpLoad %44 
					                                    sampler %89 = OpLoad %48 
					                 read_only Texture2DSampled %90 = OpSampledImage %88 %89 
					                                      f32_4 %91 = OpLoad %41 
					                                      f32_2 %92 = OpVectorShuffle %91 %91 2 3 
					                                      f32_4 %93 = OpImageSampleImplicitLod %90 %92 
					                                                    OpStore %41 %93 
					                                      f32_4 %94 = OpLoad %9 
					                                      f32_4 %95 = OpLoad %81 
					                                      f32_4 %96 = OpFAdd %94 %95 
					                                                    OpStore %9 %96 
					                                      f32_4 %97 = OpLoad %41 
					                                      f32_4 %98 = OpLoad %9 
					                                      f32_4 %99 = OpFAdd %97 %98 
					                                                    OpStore %9 %99 
					                                     f32_4 %100 = OpLoad %9 
					                                     f32_4 %103 = OpFMul %100 %102 
					                                                    OpStore %9 %103 
					                                     f32_4 %104 = OpLoad %9 
					                                     f32_4 %107 = OpExtInst %1 37 %104 %106 
					                                                    OpStore %9 %107 
					                       read_only Texture2D %109 = OpLoad %108 
					                                   sampler %111 = OpLoad %110 
					                read_only Texture2DSampled %112 = OpSampledImage %109 %111 
					                                     f32_2 %113 = OpLoad vs_TEXCOORD0 
					                                     f32_4 %114 = OpImageSampleImplicitLod %112 %113 
					                                       f32 %117 = OpCompositeExtract %114 0 
					                              Private f32* %119 = OpAccessChain %41 %116 
					                                                    OpStore %119 %117 
					                                     f32_4 %120 = OpLoad %9 
					                                     f32_4 %121 = OpLoad %41 
					                                     f32_4 %122 = OpVectorShuffle %121 %121 0 0 0 0 
					                                     f32_4 %123 = OpFMul %120 %122 
					                                                    OpStore %9 %123 
					                                     f32_4 %124 = OpLoad %9 
					                            Uniform f32_4* %126 = OpAccessChain %12 %125 
					                                     f32_4 %127 = OpLoad %126 
					                                     f32_4 %128 = OpVectorShuffle %127 %127 0 0 0 0 
					                                     f32_4 %129 = OpExtInst %1 37 %124 %128 
					                                                    OpStore %9 %129 
					                              Private f32* %131 = OpAccessChain %9 %130 
					                                       f32 %132 = OpLoad %131 
					                              Private f32* %133 = OpAccessChain %9 %116 
					                                       f32 %134 = OpLoad %133 
					                                       f32 %135 = OpExtInst %1 40 %132 %134 
					                              Private f32* %136 = OpAccessChain %41 %116 
					                                                    OpStore %136 %135 
					                              Private f32* %138 = OpAccessChain %9 %137 
					                                       f32 %139 = OpLoad %138 
					                              Private f32* %140 = OpAccessChain %41 %116 
					                                       f32 %141 = OpLoad %140 
					                                       f32 %142 = OpExtInst %1 40 %139 %141 
					                              Private f32* %143 = OpAccessChain %41 %116 
					                                                    OpStore %143 %142 
					                                     f32_4 %144 = OpLoad %41 
					                                     f32_2 %145 = OpVectorShuffle %144 %144 0 0 
					                            Uniform f32_4* %147 = OpAccessChain %12 %146 
					                                     f32_4 %148 = OpLoad %147 
					                                     f32_2 %149 = OpVectorShuffle %148 %148 1 0 
					                                     f32_2 %150 = OpFNegate %149 
					                                     f32_2 %151 = OpFAdd %145 %150 
					                                     f32_4 %152 = OpLoad %41 
					                                     f32_4 %153 = OpVectorShuffle %152 %151 0 4 5 3 
					                                                    OpStore %41 %153 
					                                     f32_4 %154 = OpLoad %41 
					                                     f32_2 %155 = OpVectorShuffle %154 %154 0 1 
					                                     f32_2 %158 = OpExtInst %1 40 %155 %157 
					                                     f32_4 %159 = OpLoad %41 
					                                     f32_4 %160 = OpVectorShuffle %159 %158 4 5 2 3 
					                                                    OpStore %41 %160 
					                              Private f32* %162 = OpAccessChain %41 %130 
					                                       f32 %163 = OpLoad %162 
					                              Uniform f32* %164 = OpAccessChain %12 %146 %137 
					                                       f32 %165 = OpLoad %164 
					                                       f32 %166 = OpExtInst %1 37 %163 %165 
					                                                    OpStore %161 %166 
					                                       f32 %168 = OpLoad %161 
					                              Uniform f32* %170 = OpAccessChain %12 %146 %169 
					                                       f32 %171 = OpLoad %170 
					                                       f32 %172 = OpFMul %168 %171 
					                                                    OpStore %167 %172 
					                                       f32 %173 = OpLoad %161 
					                                       f32 %174 = OpLoad %167 
					                                       f32 %175 = OpFMul %173 %174 
					                                                    OpStore %161 %175 
					                              Private f32* %176 = OpAccessChain %41 %137 
					                                       f32 %177 = OpLoad %176 
					                                       f32 %178 = OpLoad %161 
					                                       f32 %179 = OpExtInst %1 40 %177 %178 
					                                                    OpStore %161 %179 
					                                       f32 %180 = OpLoad %161 
					                              Private f32* %181 = OpAccessChain %41 %116 
					                                       f32 %182 = OpLoad %181 
					                                       f32 %183 = OpFDiv %180 %182 
					                              Private f32* %184 = OpAccessChain %41 %116 
					                                                    OpStore %184 %183 
					                                     f32_4 %187 = OpLoad %9 
					                                     f32_4 %188 = OpLoad %41 
					                                     f32_4 %189 = OpVectorShuffle %188 %188 0 0 0 0 
					                                     f32_4 %190 = OpFMul %187 %189 
					                                                    OpStore %186 %190 
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
						vec4 _Threshold;
						vec4 _Params;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AutoExposureTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat4;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-1.0, -1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 1.0, 1.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat0 = u_xlat0 + u_xlat2;
					    u_xlat0 = u_xlat1 + u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25);
					    u_xlat0 = min(u_xlat0, vec4(65504.0, 65504.0, 65504.0, 65504.0));
					    u_xlat1 = texture(_AutoExposureTex, vs_TEXCOORD0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat0 = min(u_xlat0, _Params.xxxx);
					    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat1.x = max(u_xlat0.z, u_xlat1.x);
					    u_xlat1.yz = u_xlat1.xx + (-_Threshold.yx);
					    u_xlat1.xy = max(u_xlat1.xy, vec2(9.99999975e-05, 0.0));
					    u_xlat4 = min(u_xlat1.y, _Threshold.z);
					    u_xlat10 = u_xlat4 * _Threshold.w;
					    u_xlat4 = u_xlat4 * u_xlat10;
					    u_xlat4 = max(u_xlat1.z, u_xlat4);
					    u_xlat1.x = u_xlat4 / u_xlat1.x;
					    SV_Target0 = u_xlat0 * u_xlat1.xxxx;
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
			GpuProgramID 155655
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
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + vs_TEXCOORD0.xyxy;
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
					    u_xlat1.xy = vs_TEXCOORD0.xy + (-_MainTex_TexelSize.xy);
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(0.0, -1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat2 = texture(_MainTex, u_xlat2.zw);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1 = u_xlat1 + u_xlat3;
					    u_xlat3.xy = vs_TEXCOORD0.xy;
					    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat1 = u_xlat1 + u_xlat3;
					    u_xlat4 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat4 = u_xlat4 * vec4(_RenderViewportScaleFactor);
					    u_xlat5 = texture(_MainTex, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, u_xlat4.zw);
					    u_xlat1 = u_xlat1 + u_xlat5;
					    u_xlat5 = u_xlat3 + u_xlat5;
					    u_xlat1 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125);
					    u_xlat0 = u_xlat0 * vec4(0.125, 0.125, 0.125, 0.125) + u_xlat1;
					    u_xlat1 = u_xlat2 + u_xlat4;
					    u_xlat2 = u_xlat3 + u_xlat4;
					    u_xlat1 = u_xlat3 + u_xlat1;
					    u_xlat0 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125) + u_xlat0;
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 1.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat4 = u_xlat3 + u_xlat5;
					    u_xlat1 = u_xlat1 + u_xlat4;
					    u_xlat0 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125) + u_xlat0;
					    u_xlat1.xy = vs_TEXCOORD0.xy + _MainTex_TexelSize.xy;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat3 + u_xlat1;
					    SV_Target0 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125) + u_xlat0;
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
					; Bound: 334
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %25 %328 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %10 0 Offset 10 
					                                             OpMemberDecorate %10 1 Offset 10 
					                                             OpDecorate %10 Block 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate vs_TEXCOORD0 Location 25 
					                                             OpDecorate %45 DescriptorSet 45 
					                                             OpDecorate %45 Binding 45 
					                                             OpDecorate %49 DescriptorSet 49 
					                                             OpDecorate %49 Binding 49 
					                                             OpDecorate %328 Location 328 
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
					                                 f32 %19 = OpConstant 3,674022E-40 
					                                 f32 %20 = OpConstant 3,674022E-40 
					                               f32_4 %21 = OpConstantComposite %19 %19 %20 %19 
					                                     %23 = OpTypeVector %6 2 
					                                     %24 = OpTypePointer Input %23 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 f32 %30 = OpConstant 3,674022E-40 
					                                 f32 %31 = OpConstant 3,674022E-40 
					                                 i32 %36 = OpConstant 0 
					                                     %37 = OpTypePointer Uniform %6 
					                      Private f32_4* %42 = OpVariable Private 
					                                     %43 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %44 = OpTypePointer UniformConstant %43 
					UniformConstant read_only Texture2D* %45 = OpVariable UniformConstant 
					                                     %47 = OpTypeSampler 
					                                     %48 = OpTypePointer UniformConstant %47 
					            UniformConstant sampler* %49 = OpVariable UniformConstant 
					                                     %51 = OpTypeSampledImage %43 
					                               f32_4 %68 = OpConstantComposite %19 %20 %20 %20 
					                      Private f32_4* %82 = OpVariable Private 
					                                f32 %133 = OpConstant 3,674022E-40 
					                              f32_4 %134 = OpConstantComposite %30 %133 %31 %133 
					                     Private f32_4* %148 = OpVariable Private 
					                     Private f32_4* %194 = OpVariable Private 
					                              f32_4 %198 = OpConstantComposite %133 %30 %31 %30 
					                     Private f32_4* %212 = OpVariable Private 
					                                f32 %232 = OpConstant 3,674022E-40 
					                              f32_4 %233 = OpConstantComposite %232 %232 %232 %232 
					                                f32 %236 = OpConstant 3,674022E-40 
					                              f32_4 %237 = OpConstantComposite %236 %236 %236 %236 
					                              f32_4 %257 = OpConstantComposite %133 %31 %30 %31 
					                                    %327 = OpTypePointer Output %7 
					                      Output f32_4* %328 = OpVariable Output 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                      Uniform f32_4* %16 = OpAccessChain %12 %14 
					                               f32_4 %17 = OpLoad %16 
					                               f32_4 %18 = OpVectorShuffle %17 %17 0 1 0 1 
					                               f32_4 %22 = OpFMul %18 %21 
					                               f32_2 %26 = OpLoad vs_TEXCOORD0 
					                               f32_4 %27 = OpVectorShuffle %26 %26 0 1 0 1 
					                               f32_4 %28 = OpFAdd %22 %27 
					                                             OpStore %9 %28 
					                               f32_4 %29 = OpLoad %9 
					                               f32_4 %32 = OpCompositeConstruct %30 %30 %30 %30 
					                               f32_4 %33 = OpCompositeConstruct %31 %31 %31 %31 
					                               f32_4 %34 = OpExtInst %1 43 %29 %32 %33 
					                                             OpStore %9 %34 
					                               f32_4 %35 = OpLoad %9 
					                        Uniform f32* %38 = OpAccessChain %12 %36 
					                                 f32 %39 = OpLoad %38 
					                               f32_4 %40 = OpCompositeConstruct %39 %39 %39 %39 
					                               f32_4 %41 = OpFMul %35 %40 
					                                             OpStore %9 %41 
					                 read_only Texture2D %46 = OpLoad %45 
					                             sampler %50 = OpLoad %49 
					          read_only Texture2DSampled %52 = OpSampledImage %46 %50 
					                               f32_4 %53 = OpLoad %9 
					                               f32_2 %54 = OpVectorShuffle %53 %53 0 1 
					                               f32_4 %55 = OpImageSampleImplicitLod %52 %54 
					                                             OpStore %42 %55 
					                 read_only Texture2D %56 = OpLoad %45 
					                             sampler %57 = OpLoad %49 
					          read_only Texture2DSampled %58 = OpSampledImage %56 %57 
					                               f32_4 %59 = OpLoad %9 
					                               f32_2 %60 = OpVectorShuffle %59 %59 2 3 
					                               f32_4 %61 = OpImageSampleImplicitLod %58 %60 
					                                             OpStore %9 %61 
					                               f32_4 %62 = OpLoad %9 
					                               f32_4 %63 = OpLoad %42 
					                               f32_4 %64 = OpFAdd %62 %63 
					                                             OpStore %9 %64 
					                      Uniform f32_4* %65 = OpAccessChain %12 %14 
					                               f32_4 %66 = OpLoad %65 
					                               f32_4 %67 = OpVectorShuffle %66 %66 0 1 0 1 
					                               f32_4 %69 = OpFMul %67 %68 
					                               f32_2 %70 = OpLoad vs_TEXCOORD0 
					                               f32_4 %71 = OpVectorShuffle %70 %70 0 1 0 1 
					                               f32_4 %72 = OpFAdd %69 %71 
					                                             OpStore %42 %72 
					                               f32_4 %73 = OpLoad %42 
					                               f32_4 %74 = OpCompositeConstruct %30 %30 %30 %30 
					                               f32_4 %75 = OpCompositeConstruct %31 %31 %31 %31 
					                               f32_4 %76 = OpExtInst %1 43 %73 %74 %75 
					                                             OpStore %42 %76 
					                               f32_4 %77 = OpLoad %42 
					                        Uniform f32* %78 = OpAccessChain %12 %36 
					                                 f32 %79 = OpLoad %78 
					                               f32_4 %80 = OpCompositeConstruct %79 %79 %79 %79 
					                               f32_4 %81 = OpFMul %77 %80 
					                                             OpStore %42 %81 
					                 read_only Texture2D %83 = OpLoad %45 
					                             sampler %84 = OpLoad %49 
					          read_only Texture2DSampled %85 = OpSampledImage %83 %84 
					                               f32_4 %86 = OpLoad %42 
					                               f32_2 %87 = OpVectorShuffle %86 %86 0 1 
					                               f32_4 %88 = OpImageSampleImplicitLod %85 %87 
					                                             OpStore %82 %88 
					                 read_only Texture2D %89 = OpLoad %45 
					                             sampler %90 = OpLoad %49 
					          read_only Texture2DSampled %91 = OpSampledImage %89 %90 
					                               f32_4 %92 = OpLoad %42 
					                               f32_2 %93 = OpVectorShuffle %92 %92 2 3 
					                               f32_4 %94 = OpImageSampleImplicitLod %91 %93 
					                                             OpStore %42 %94 
					                               f32_4 %95 = OpLoad %9 
					                               f32_4 %96 = OpLoad %82 
					                               f32_4 %97 = OpFAdd %95 %96 
					                                             OpStore %9 %97 
					                               f32_4 %98 = OpLoad %42 
					                               f32_4 %99 = OpLoad %9 
					                              f32_4 %100 = OpFAdd %98 %99 
					                                             OpStore %9 %100 
					                              f32_2 %101 = OpLoad vs_TEXCOORD0 
					                     Uniform f32_4* %102 = OpAccessChain %12 %14 
					                              f32_4 %103 = OpLoad %102 
					                              f32_2 %104 = OpVectorShuffle %103 %103 0 1 
					                              f32_2 %105 = OpFNegate %104 
					                              f32_2 %106 = OpFAdd %101 %105 
					                              f32_4 %107 = OpLoad %42 
					                              f32_4 %108 = OpVectorShuffle %107 %106 4 5 2 3 
					                                             OpStore %42 %108 
					                              f32_4 %109 = OpLoad %42 
					                              f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                              f32_2 %111 = OpCompositeConstruct %30 %30 
					                              f32_2 %112 = OpCompositeConstruct %31 %31 
					                              f32_2 %113 = OpExtInst %1 43 %110 %111 %112 
					                              f32_4 %114 = OpLoad %42 
					                              f32_4 %115 = OpVectorShuffle %114 %113 4 5 2 3 
					                                             OpStore %42 %115 
					                              f32_4 %116 = OpLoad %42 
					                              f32_2 %117 = OpVectorShuffle %116 %116 0 1 
					                       Uniform f32* %118 = OpAccessChain %12 %36 
					                                f32 %119 = OpLoad %118 
					                              f32_2 %120 = OpCompositeConstruct %119 %119 
					                              f32_2 %121 = OpFMul %117 %120 
					                              f32_4 %122 = OpLoad %42 
					                              f32_4 %123 = OpVectorShuffle %122 %121 4 5 2 3 
					                                             OpStore %42 %123 
					                read_only Texture2D %124 = OpLoad %45 
					                            sampler %125 = OpLoad %49 
					         read_only Texture2DSampled %126 = OpSampledImage %124 %125 
					                              f32_4 %127 = OpLoad %42 
					                              f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                              f32_4 %129 = OpImageSampleImplicitLod %126 %128 
					                                             OpStore %42 %129 
					                     Uniform f32_4* %130 = OpAccessChain %12 %14 
					                              f32_4 %131 = OpLoad %130 
					                              f32_4 %132 = OpVectorShuffle %131 %131 0 1 0 1 
					                              f32_4 %135 = OpFMul %132 %134 
					                              f32_2 %136 = OpLoad vs_TEXCOORD0 
					                              f32_4 %137 = OpVectorShuffle %136 %136 0 1 0 1 
					                              f32_4 %138 = OpFAdd %135 %137 
					                                             OpStore %82 %138 
					                              f32_4 %139 = OpLoad %82 
					                              f32_4 %140 = OpCompositeConstruct %30 %30 %30 %30 
					                              f32_4 %141 = OpCompositeConstruct %31 %31 %31 %31 
					                              f32_4 %142 = OpExtInst %1 43 %139 %140 %141 
					                                             OpStore %82 %142 
					                              f32_4 %143 = OpLoad %82 
					                       Uniform f32* %144 = OpAccessChain %12 %36 
					                                f32 %145 = OpLoad %144 
					                              f32_4 %146 = OpCompositeConstruct %145 %145 %145 %145 
					                              f32_4 %147 = OpFMul %143 %146 
					                                             OpStore %82 %147 
					                read_only Texture2D %149 = OpLoad %45 
					                            sampler %150 = OpLoad %49 
					         read_only Texture2DSampled %151 = OpSampledImage %149 %150 
					                              f32_4 %152 = OpLoad %82 
					                              f32_2 %153 = OpVectorShuffle %152 %152 0 1 
					                              f32_4 %154 = OpImageSampleImplicitLod %151 %153 
					                                             OpStore %148 %154 
					                read_only Texture2D %155 = OpLoad %45 
					                            sampler %156 = OpLoad %49 
					         read_only Texture2DSampled %157 = OpSampledImage %155 %156 
					                              f32_4 %158 = OpLoad %82 
					                              f32_2 %159 = OpVectorShuffle %158 %158 2 3 
					                              f32_4 %160 = OpImageSampleImplicitLod %157 %159 
					                                             OpStore %82 %160 
					                              f32_4 %161 = OpLoad %82 
					                              f32_4 %162 = OpLoad %148 
					                              f32_4 %163 = OpFAdd %161 %162 
					                                             OpStore %82 %163 
					                              f32_4 %164 = OpLoad %42 
					                              f32_4 %165 = OpLoad %148 
					                              f32_4 %166 = OpFAdd %164 %165 
					                                             OpStore %42 %166 
					                              f32_2 %167 = OpLoad vs_TEXCOORD0 
					                              f32_4 %168 = OpLoad %148 
					                              f32_4 %169 = OpVectorShuffle %168 %167 4 5 2 3 
					                                             OpStore %148 %169 
					                              f32_4 %170 = OpLoad %148 
					                              f32_2 %171 = OpVectorShuffle %170 %170 0 1 
					                              f32_2 %172 = OpCompositeConstruct %30 %30 
					                              f32_2 %173 = OpCompositeConstruct %31 %31 
					                              f32_2 %174 = OpExtInst %1 43 %171 %172 %173 
					                              f32_4 %175 = OpLoad %148 
					                              f32_4 %176 = OpVectorShuffle %175 %174 4 5 2 3 
					                                             OpStore %148 %176 
					                              f32_4 %177 = OpLoad %148 
					                              f32_2 %178 = OpVectorShuffle %177 %177 0 1 
					                       Uniform f32* %179 = OpAccessChain %12 %36 
					                                f32 %180 = OpLoad %179 
					                              f32_2 %181 = OpCompositeConstruct %180 %180 
					                              f32_2 %182 = OpFMul %178 %181 
					                              f32_4 %183 = OpLoad %148 
					                              f32_4 %184 = OpVectorShuffle %183 %182 4 5 2 3 
					                                             OpStore %148 %184 
					                read_only Texture2D %185 = OpLoad %45 
					                            sampler %186 = OpLoad %49 
					         read_only Texture2DSampled %187 = OpSampledImage %185 %186 
					                              f32_4 %188 = OpLoad %148 
					                              f32_2 %189 = OpVectorShuffle %188 %188 0 1 
					                              f32_4 %190 = OpImageSampleImplicitLod %187 %189 
					                                             OpStore %148 %190 
					                              f32_4 %191 = OpLoad %42 
					                              f32_4 %192 = OpLoad %148 
					                              f32_4 %193 = OpFAdd %191 %192 
					                                             OpStore %42 %193 
					                     Uniform f32_4* %195 = OpAccessChain %12 %14 
					                              f32_4 %196 = OpLoad %195 
					                              f32_4 %197 = OpVectorShuffle %196 %196 0 1 0 1 
					                              f32_4 %199 = OpFMul %197 %198 
					                              f32_2 %200 = OpLoad vs_TEXCOORD0 
					                              f32_4 %201 = OpVectorShuffle %200 %200 0 1 0 1 
					                              f32_4 %202 = OpFAdd %199 %201 
					                                             OpStore %194 %202 
					                              f32_4 %203 = OpLoad %194 
					                              f32_4 %204 = OpCompositeConstruct %30 %30 %30 %30 
					                              f32_4 %205 = OpCompositeConstruct %31 %31 %31 %31 
					                              f32_4 %206 = OpExtInst %1 43 %203 %204 %205 
					                                             OpStore %194 %206 
					                              f32_4 %207 = OpLoad %194 
					                       Uniform f32* %208 = OpAccessChain %12 %36 
					                                f32 %209 = OpLoad %208 
					                              f32_4 %210 = OpCompositeConstruct %209 %209 %209 %209 
					                              f32_4 %211 = OpFMul %207 %210 
					                                             OpStore %194 %211 
					                read_only Texture2D %213 = OpLoad %45 
					                            sampler %214 = OpLoad %49 
					         read_only Texture2DSampled %215 = OpSampledImage %213 %214 
					                              f32_4 %216 = OpLoad %194 
					                              f32_2 %217 = OpVectorShuffle %216 %216 0 1 
					                              f32_4 %218 = OpImageSampleImplicitLod %215 %217 
					                                             OpStore %212 %218 
					                read_only Texture2D %219 = OpLoad %45 
					                            sampler %220 = OpLoad %49 
					         read_only Texture2DSampled %221 = OpSampledImage %219 %220 
					                              f32_4 %222 = OpLoad %194 
					                              f32_2 %223 = OpVectorShuffle %222 %222 2 3 
					                              f32_4 %224 = OpImageSampleImplicitLod %221 %223 
					                                             OpStore %194 %224 
					                              f32_4 %225 = OpLoad %42 
					                              f32_4 %226 = OpLoad %212 
					                              f32_4 %227 = OpFAdd %225 %226 
					                                             OpStore %42 %227 
					                              f32_4 %228 = OpLoad %148 
					                              f32_4 %229 = OpLoad %212 
					                              f32_4 %230 = OpFAdd %228 %229 
					                                             OpStore %212 %230 
					                              f32_4 %231 = OpLoad %42 
					                              f32_4 %234 = OpFMul %231 %233 
					                                             OpStore %42 %234 
					                              f32_4 %235 = OpLoad %9 
					                              f32_4 %238 = OpFMul %235 %237 
					                              f32_4 %239 = OpLoad %42 
					                              f32_4 %240 = OpFAdd %238 %239 
					                                             OpStore %9 %240 
					                              f32_4 %241 = OpLoad %82 
					                              f32_4 %242 = OpLoad %194 
					                              f32_4 %243 = OpFAdd %241 %242 
					                                             OpStore %42 %243 
					                              f32_4 %244 = OpLoad %148 
					                              f32_4 %245 = OpLoad %194 
					                              f32_4 %246 = OpFAdd %244 %245 
					                                             OpStore %82 %246 
					                              f32_4 %247 = OpLoad %148 
					                              f32_4 %248 = OpLoad %42 
					                              f32_4 %249 = OpFAdd %247 %248 
					                                             OpStore %42 %249 
					                              f32_4 %250 = OpLoad %42 
					                              f32_4 %251 = OpFMul %250 %233 
					                              f32_4 %252 = OpLoad %9 
					                              f32_4 %253 = OpFAdd %251 %252 
					                                             OpStore %9 %253 
					                     Uniform f32_4* %254 = OpAccessChain %12 %14 
					                              f32_4 %255 = OpLoad %254 
					                              f32_4 %256 = OpVectorShuffle %255 %255 0 1 0 1 
					                              f32_4 %258 = OpFMul %256 %257 
					                              f32_2 %259 = OpLoad vs_TEXCOORD0 
					                              f32_4 %260 = OpVectorShuffle %259 %259 0 1 0 1 
					                              f32_4 %261 = OpFAdd %258 %260 
					                                             OpStore %42 %261 
					                              f32_4 %262 = OpLoad %42 
					                              f32_4 %263 = OpCompositeConstruct %30 %30 %30 %30 
					                              f32_4 %264 = OpCompositeConstruct %31 %31 %31 %31 
					                              f32_4 %265 = OpExtInst %1 43 %262 %263 %264 
					                                             OpStore %42 %265 
					                              f32_4 %266 = OpLoad %42 
					                       Uniform f32* %267 = OpAccessChain %12 %36 
					                                f32 %268 = OpLoad %267 
					                              f32_4 %269 = OpCompositeConstruct %268 %268 %268 %268 
					                              f32_4 %270 = OpFMul %266 %269 
					                                             OpStore %42 %270 
					                read_only Texture2D %271 = OpLoad %45 
					                            sampler %272 = OpLoad %49 
					         read_only Texture2DSampled %273 = OpSampledImage %271 %272 
					                              f32_4 %274 = OpLoad %42 
					                              f32_2 %275 = OpVectorShuffle %274 %274 2 3 
					                              f32_4 %276 = OpImageSampleImplicitLod %273 %275 
					                                             OpStore %148 %276 
					                read_only Texture2D %277 = OpLoad %45 
					                            sampler %278 = OpLoad %49 
					         read_only Texture2DSampled %279 = OpSampledImage %277 %278 
					                              f32_4 %280 = OpLoad %42 
					                              f32_2 %281 = OpVectorShuffle %280 %280 0 1 
					                              f32_4 %282 = OpImageSampleImplicitLod %279 %281 
					                                             OpStore %42 %282 
					                              f32_4 %283 = OpLoad %148 
					                              f32_4 %284 = OpLoad %212 
					                              f32_4 %285 = OpFAdd %283 %284 
					                                             OpStore %194 %285 
					                              f32_4 %286 = OpLoad %42 
					                              f32_4 %287 = OpLoad %194 
					                              f32_4 %288 = OpFAdd %286 %287 
					                                             OpStore %42 %288 
					                              f32_4 %289 = OpLoad %42 
					                              f32_4 %290 = OpFMul %289 %233 
					                              f32_4 %291 = OpLoad %9 
					                              f32_4 %292 = OpFAdd %290 %291 
					                                             OpStore %9 %292 
					                              f32_2 %293 = OpLoad vs_TEXCOORD0 
					                     Uniform f32_4* %294 = OpAccessChain %12 %14 
					                              f32_4 %295 = OpLoad %294 
					                              f32_2 %296 = OpVectorShuffle %295 %295 0 1 
					                              f32_2 %297 = OpFAdd %293 %296 
					                              f32_4 %298 = OpLoad %42 
					                              f32_4 %299 = OpVectorShuffle %298 %297 4 5 2 3 
					                                             OpStore %42 %299 
					                              f32_4 %300 = OpLoad %42 
					                              f32_2 %301 = OpVectorShuffle %300 %300 0 1 
					                              f32_2 %302 = OpCompositeConstruct %30 %30 
					                              f32_2 %303 = OpCompositeConstruct %31 %31 
					                              f32_2 %304 = OpExtInst %1 43 %301 %302 %303 
					                              f32_4 %305 = OpLoad %42 
					                              f32_4 %306 = OpVectorShuffle %305 %304 4 5 2 3 
					                                             OpStore %42 %306 
					                              f32_4 %307 = OpLoad %42 
					                              f32_2 %308 = OpVectorShuffle %307 %307 0 1 
					                       Uniform f32* %309 = OpAccessChain %12 %36 
					                                f32 %310 = OpLoad %309 
					                              f32_2 %311 = OpCompositeConstruct %310 %310 
					                              f32_2 %312 = OpFMul %308 %311 
					                              f32_4 %313 = OpLoad %42 
					                              f32_4 %314 = OpVectorShuffle %313 %312 4 5 2 3 
					                                             OpStore %42 %314 
					                read_only Texture2D %315 = OpLoad %45 
					                            sampler %316 = OpLoad %49 
					         read_only Texture2DSampled %317 = OpSampledImage %315 %316 
					                              f32_4 %318 = OpLoad %42 
					                              f32_2 %319 = OpVectorShuffle %318 %318 0 1 
					                              f32_4 %320 = OpImageSampleImplicitLod %317 %319 
					                                             OpStore %42 %320 
					                              f32_4 %321 = OpLoad %42 
					                              f32_4 %322 = OpLoad %82 
					                              f32_4 %323 = OpFAdd %321 %322 
					                                             OpStore %42 %323 
					                              f32_4 %324 = OpLoad %148 
					                              f32_4 %325 = OpLoad %42 
					                              f32_4 %326 = OpFAdd %324 %325 
					                                             OpStore %42 %326 
					                              f32_4 %329 = OpLoad %42 
					                              f32_4 %330 = OpFMul %329 %233 
					                              f32_4 %331 = OpLoad %9 
					                              f32_4 %332 = OpFAdd %330 %331 
					                                             OpStore %328 %332 
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
						vec4 unused_0_4[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + vs_TEXCOORD0.xyxy;
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
					    u_xlat1.xy = vs_TEXCOORD0.xy + (-_MainTex_TexelSize.xy);
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(0.0, -1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat2 = texture(_MainTex, u_xlat2.zw);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1 = u_xlat1 + u_xlat3;
					    u_xlat3.xy = vs_TEXCOORD0.xy;
					    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat1 = u_xlat1 + u_xlat3;
					    u_xlat4 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat4 = u_xlat4 * vec4(_RenderViewportScaleFactor);
					    u_xlat5 = texture(_MainTex, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, u_xlat4.zw);
					    u_xlat1 = u_xlat1 + u_xlat5;
					    u_xlat5 = u_xlat3 + u_xlat5;
					    u_xlat1 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125);
					    u_xlat0 = u_xlat0 * vec4(0.125, 0.125, 0.125, 0.125) + u_xlat1;
					    u_xlat1 = u_xlat2 + u_xlat4;
					    u_xlat2 = u_xlat3 + u_xlat4;
					    u_xlat1 = u_xlat3 + u_xlat1;
					    u_xlat0 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125) + u_xlat0;
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 1.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat4 = u_xlat3 + u_xlat5;
					    u_xlat1 = u_xlat1 + u_xlat4;
					    u_xlat0 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125) + u_xlat0;
					    u_xlat1.xy = vs_TEXCOORD0.xy + _MainTex_TexelSize.xy;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat3 + u_xlat1;
					    SV_Target0 = u_xlat1 * vec4(0.03125, 0.03125, 0.03125, 0.03125) + u_xlat0;
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
			GpuProgramID 248902
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
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-1.0, -1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 1.0, 1.0, 1.0) + vs_TEXCOORD0.xyxy;
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
					; Bound: 107
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %25 %101 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %10 0 Offset 10 
					                                             OpMemberDecorate %10 1 Offset 10 
					                                             OpDecorate %10 Block 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate vs_TEXCOORD0 Location 25 
					                                             OpDecorate %44 DescriptorSet 44 
					                                             OpDecorate %44 Binding 44 
					                                             OpDecorate %48 DescriptorSet 48 
					                                             OpDecorate %48 Binding 48 
					                                             OpDecorate %101 Location 101 
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
					                                 f32 %19 = OpConstant 3,674022E-40 
					                                 f32 %20 = OpConstant 3,674022E-40 
					                               f32_4 %21 = OpConstantComposite %19 %19 %20 %19 
					                                     %23 = OpTypeVector %6 2 
					                                     %24 = OpTypePointer Input %23 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 f32 %30 = OpConstant 3,674022E-40 
					                                 i32 %35 = OpConstant 0 
					                                     %36 = OpTypePointer Uniform %6 
					                      Private f32_4* %41 = OpVariable Private 
					                                     %42 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %43 = OpTypePointer UniformConstant %42 
					UniformConstant read_only Texture2D* %44 = OpVariable UniformConstant 
					                                     %46 = OpTypeSampler 
					                                     %47 = OpTypePointer UniformConstant %46 
					            UniformConstant sampler* %48 = OpVariable UniformConstant 
					                                     %50 = OpTypeSampledImage %42 
					                               f32_4 %67 = OpConstantComposite %19 %20 %20 %20 
					                      Private f32_4* %81 = OpVariable Private 
					                                    %100 = OpTypePointer Output %7 
					                      Output f32_4* %101 = OpVariable Output 
					                                f32 %103 = OpConstant 3,674022E-40 
					                              f32_4 %104 = OpConstantComposite %103 %103 %103 %103 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                      Uniform f32_4* %16 = OpAccessChain %12 %14 
					                               f32_4 %17 = OpLoad %16 
					                               f32_4 %18 = OpVectorShuffle %17 %17 0 1 0 1 
					                               f32_4 %22 = OpFMul %18 %21 
					                               f32_2 %26 = OpLoad vs_TEXCOORD0 
					                               f32_4 %27 = OpVectorShuffle %26 %26 0 1 0 1 
					                               f32_4 %28 = OpFAdd %22 %27 
					                                             OpStore %9 %28 
					                               f32_4 %29 = OpLoad %9 
					                               f32_4 %31 = OpCompositeConstruct %30 %30 %30 %30 
					                               f32_4 %32 = OpCompositeConstruct %20 %20 %20 %20 
					                               f32_4 %33 = OpExtInst %1 43 %29 %31 %32 
					                                             OpStore %9 %33 
					                               f32_4 %34 = OpLoad %9 
					                        Uniform f32* %37 = OpAccessChain %12 %35 
					                                 f32 %38 = OpLoad %37 
					                               f32_4 %39 = OpCompositeConstruct %38 %38 %38 %38 
					                               f32_4 %40 = OpFMul %34 %39 
					                                             OpStore %9 %40 
					                 read_only Texture2D %45 = OpLoad %44 
					                             sampler %49 = OpLoad %48 
					          read_only Texture2DSampled %51 = OpSampledImage %45 %49 
					                               f32_4 %52 = OpLoad %9 
					                               f32_2 %53 = OpVectorShuffle %52 %52 0 1 
					                               f32_4 %54 = OpImageSampleImplicitLod %51 %53 
					                                             OpStore %41 %54 
					                 read_only Texture2D %55 = OpLoad %44 
					                             sampler %56 = OpLoad %48 
					          read_only Texture2DSampled %57 = OpSampledImage %55 %56 
					                               f32_4 %58 = OpLoad %9 
					                               f32_2 %59 = OpVectorShuffle %58 %58 2 3 
					                               f32_4 %60 = OpImageSampleImplicitLod %57 %59 
					                                             OpStore %9 %60 
					                               f32_4 %61 = OpLoad %9 
					                               f32_4 %62 = OpLoad %41 
					                               f32_4 %63 = OpFAdd %61 %62 
					                                             OpStore %9 %63 
					                      Uniform f32_4* %64 = OpAccessChain %12 %14 
					                               f32_4 %65 = OpLoad %64 
					                               f32_4 %66 = OpVectorShuffle %65 %65 0 1 0 1 
					                               f32_4 %68 = OpFMul %66 %67 
					                               f32_2 %69 = OpLoad vs_TEXCOORD0 
					                               f32_4 %70 = OpVectorShuffle %69 %69 0 1 0 1 
					                               f32_4 %71 = OpFAdd %68 %70 
					                                             OpStore %41 %71 
					                               f32_4 %72 = OpLoad %41 
					                               f32_4 %73 = OpCompositeConstruct %30 %30 %30 %30 
					                               f32_4 %74 = OpCompositeConstruct %20 %20 %20 %20 
					                               f32_4 %75 = OpExtInst %1 43 %72 %73 %74 
					                                             OpStore %41 %75 
					                               f32_4 %76 = OpLoad %41 
					                        Uniform f32* %77 = OpAccessChain %12 %35 
					                                 f32 %78 = OpLoad %77 
					                               f32_4 %79 = OpCompositeConstruct %78 %78 %78 %78 
					                               f32_4 %80 = OpFMul %76 %79 
					                                             OpStore %41 %80 
					                 read_only Texture2D %82 = OpLoad %44 
					                             sampler %83 = OpLoad %48 
					          read_only Texture2DSampled %84 = OpSampledImage %82 %83 
					                               f32_4 %85 = OpLoad %41 
					                               f32_2 %86 = OpVectorShuffle %85 %85 0 1 
					                               f32_4 %87 = OpImageSampleImplicitLod %84 %86 
					                                             OpStore %81 %87 
					                 read_only Texture2D %88 = OpLoad %44 
					                             sampler %89 = OpLoad %48 
					          read_only Texture2DSampled %90 = OpSampledImage %88 %89 
					                               f32_4 %91 = OpLoad %41 
					                               f32_2 %92 = OpVectorShuffle %91 %91 2 3 
					                               f32_4 %93 = OpImageSampleImplicitLod %90 %92 
					                                             OpStore %41 %93 
					                               f32_4 %94 = OpLoad %9 
					                               f32_4 %95 = OpLoad %81 
					                               f32_4 %96 = OpFAdd %94 %95 
					                                             OpStore %9 %96 
					                               f32_4 %97 = OpLoad %41 
					                               f32_4 %98 = OpLoad %9 
					                               f32_4 %99 = OpFAdd %97 %98 
					                                             OpStore %9 %99 
					                              f32_4 %102 = OpLoad %9 
					                              f32_4 %105 = OpFMul %102 %104 
					                                             OpStore %101 %105 
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
						vec4 unused_0_4[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-1.0, -1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 1.0, 1.0, 1.0) + vs_TEXCOORD0.xyxy;
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
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 302136
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
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _SampleScale;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _BloomTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.x = 1.0;
					    u_xlat1.z = _SampleScale;
					    u_xlat1 = u_xlat1.xxzz * _MainTex_TexelSize.xyxy;
					    u_xlat2.z = float(-1.0);
					    u_xlat2.w = float(0.0);
					    u_xlat2.x = _SampleScale;
					    u_xlat3 = (-u_xlat1.xywy) * u_xlat2.xxwx + vs_TEXCOORD0.xyxy;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
					    u_xlat4 = texture(_MainTex, u_xlat3.xy);
					    u_xlat3 = texture(_MainTex, u_xlat3.zw);
					    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + u_xlat4;
					    u_xlat4.xy = (-u_xlat1.zy) * u_xlat2.zx + vs_TEXCOORD0.xy;
					    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat3 = u_xlat3 + u_xlat4;
					    u_xlat4 = u_xlat1.zwxw * u_xlat2.zwxw + vs_TEXCOORD0.xyxy;
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat5 = u_xlat1.zywy * u_xlat2.zxwx + vs_TEXCOORD0.xyxy;
					    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * u_xlat2.xx + vs_TEXCOORD0.xy;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = u_xlat5 * vec4(_RenderViewportScaleFactor);
					    u_xlat4 = u_xlat4 * vec4(_RenderViewportScaleFactor);
					    u_xlat5 = texture(_MainTex, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, u_xlat4.zw);
					    u_xlat3 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + u_xlat3;
					    u_xlat0 = u_xlat0 * vec4(4.0, 4.0, 4.0, 4.0) + u_xlat3;
					    u_xlat0 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + u_xlat0;
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat2 = texture(_MainTex, u_xlat2.zw);
					    u_xlat0 = u_xlat0 + u_xlat3;
					    u_xlat0 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + u_xlat0;
					    u_xlat0 = u_xlat1 + u_xlat0;
					    u_xlat1 = texture(_BloomTex, vs_TEXCOORD1.xy);
					    SV_Target0 = u_xlat0 * vec4(0.0625, 0.0625, 0.0625, 0.0625) + u_xlat1;
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
					; Bound: 280
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %12 %268 %272 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpDecorate vs_TEXCOORD0 Location 12 
					                                              OpMemberDecorate %27 0 Offset 27 
					                                              OpMemberDecorate %27 1 Offset 27 
					                                              OpMemberDecorate %27 2 Offset 27 
					                                              OpDecorate %27 Block 
					                                              OpDecorate %29 DescriptorSet 29 
					                                              OpDecorate %29 Binding 29 
					                                              OpDecorate %41 DescriptorSet 41 
					                                              OpDecorate %41 Binding 41 
					                                              OpDecorate %45 DescriptorSet 45 
					                                              OpDecorate %45 Binding 45 
					                                              OpDecorate %263 DescriptorSet 263 
					                                              OpDecorate %263 Binding 263 
					                                              OpDecorate %265 DescriptorSet 265 
					                                              OpDecorate %265 Binding 265 
					                                              OpDecorate vs_TEXCOORD1 Location 268 
					                                              OpDecorate %272 Location 272 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 4 
					                                       %8 = OpTypePointer Private %7 
					                        Private f32_4* %9 = OpVariable Private 
					                                      %10 = OpTypeVector %6 2 
					                                      %11 = OpTypePointer Input %10 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                  f32 %18 = OpConstant 3,674022E-40 
					                                  f32 %19 = OpConstant 3,674022E-40 
					                                      %27 = OpTypeStruct %6 %7 %6 
					                                      %28 = OpTypePointer Uniform %27 
					   Uniform struct {f32; f32_4; f32;}* %29 = OpVariable Uniform 
					                                      %30 = OpTypeInt 32 1 
					                                  i32 %31 = OpConstant 0 
					                                      %32 = OpTypePointer Uniform %6 
					                                      %39 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                      %40 = OpTypePointer UniformConstant %39 
					 UniformConstant read_only Texture2D* %41 = OpVariable UniformConstant 
					                                      %43 = OpTypeSampler 
					                                      %44 = OpTypePointer UniformConstant %43 
					             UniformConstant sampler* %45 = OpVariable UniformConstant 
					                                      %47 = OpTypeSampledImage %39 
					                       Private f32_4* %52 = OpVariable Private 
					                                      %53 = OpTypeInt 32 0 
					                                  u32 %54 = OpConstant 0 
					                                      %55 = OpTypePointer Private %6 
					                                  i32 %57 = OpConstant 2 
					                                  u32 %60 = OpConstant 2 
					                                  i32 %64 = OpConstant 1 
					                                      %65 = OpTypePointer Uniform %7 
					                       Private f32_4* %70 = OpVariable Private 
					                                  f32 %71 = OpConstant 3,674022E-40 
					                                  u32 %73 = OpConstant 3 
					                       Private f32_4* %78 = OpVariable Private 
					                       Private f32_4* %97 = OpVariable Private 
					                                 f32 %111 = OpConstant 3,674022E-40 
					                               f32_4 %112 = OpConstantComposite %111 %111 %111 %111 
					                      Private f32_4* %162 = OpVariable Private 
					                                 f32 %232 = OpConstant 3,674022E-40 
					                               f32_4 %233 = OpConstantComposite %232 %232 %232 %232 
					UniformConstant read_only Texture2D* %263 = OpVariable UniformConstant 
					            UniformConstant sampler* %265 = OpVariable UniformConstant 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                     %271 = OpTypePointer Output %7 
					                       Output f32_4* %272 = OpVariable Output 
					                                 f32 %274 = OpConstant 3,674022E-40 
					                               f32_4 %275 = OpConstantComposite %274 %274 %274 %274 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                                f32_2 %13 = OpLoad vs_TEXCOORD0 
					                                f32_4 %14 = OpLoad %9 
					                                f32_4 %15 = OpVectorShuffle %14 %13 4 5 2 3 
					                                              OpStore %9 %15 
					                                f32_4 %16 = OpLoad %9 
					                                f32_2 %17 = OpVectorShuffle %16 %16 0 1 
					                                f32_2 %20 = OpCompositeConstruct %18 %18 
					                                f32_2 %21 = OpCompositeConstruct %19 %19 
					                                f32_2 %22 = OpExtInst %1 43 %17 %20 %21 
					                                f32_4 %23 = OpLoad %9 
					                                f32_4 %24 = OpVectorShuffle %23 %22 4 5 2 3 
					                                              OpStore %9 %24 
					                                f32_4 %25 = OpLoad %9 
					                                f32_2 %26 = OpVectorShuffle %25 %25 0 1 
					                         Uniform f32* %33 = OpAccessChain %29 %31 
					                                  f32 %34 = OpLoad %33 
					                                f32_2 %35 = OpCompositeConstruct %34 %34 
					                                f32_2 %36 = OpFMul %26 %35 
					                                f32_4 %37 = OpLoad %9 
					                                f32_4 %38 = OpVectorShuffle %37 %36 4 5 2 3 
					                                              OpStore %9 %38 
					                  read_only Texture2D %42 = OpLoad %41 
					                              sampler %46 = OpLoad %45 
					           read_only Texture2DSampled %48 = OpSampledImage %42 %46 
					                                f32_4 %49 = OpLoad %9 
					                                f32_2 %50 = OpVectorShuffle %49 %49 0 1 
					                                f32_4 %51 = OpImageSampleImplicitLod %48 %50 
					                                              OpStore %9 %51 
					                         Private f32* %56 = OpAccessChain %52 %54 
					                                              OpStore %56 %19 
					                         Uniform f32* %58 = OpAccessChain %29 %57 
					                                  f32 %59 = OpLoad %58 
					                         Private f32* %61 = OpAccessChain %52 %60 
					                                              OpStore %61 %59 
					                                f32_4 %62 = OpLoad %52 
					                                f32_4 %63 = OpVectorShuffle %62 %62 0 0 2 2 
					                       Uniform f32_4* %66 = OpAccessChain %29 %64 
					                                f32_4 %67 = OpLoad %66 
					                                f32_4 %68 = OpVectorShuffle %67 %67 0 1 0 1 
					                                f32_4 %69 = OpFMul %63 %68 
					                                              OpStore %52 %69 
					                         Private f32* %72 = OpAccessChain %70 %60 
					                                              OpStore %72 %71 
					                         Private f32* %74 = OpAccessChain %70 %73 
					                                              OpStore %74 %18 
					                         Uniform f32* %75 = OpAccessChain %29 %57 
					                                  f32 %76 = OpLoad %75 
					                         Private f32* %77 = OpAccessChain %70 %54 
					                                              OpStore %77 %76 
					                                f32_4 %79 = OpLoad %52 
					                                f32_4 %80 = OpVectorShuffle %79 %79 0 1 3 1 
					                                f32_4 %81 = OpFNegate %80 
					                                f32_4 %82 = OpLoad %70 
					                                f32_4 %83 = OpVectorShuffle %82 %82 0 0 3 0 
					                                f32_4 %84 = OpFMul %81 %83 
					                                f32_2 %85 = OpLoad vs_TEXCOORD0 
					                                f32_4 %86 = OpVectorShuffle %85 %85 0 1 0 1 
					                                f32_4 %87 = OpFAdd %84 %86 
					                                              OpStore %78 %87 
					                                f32_4 %88 = OpLoad %78 
					                                f32_4 %89 = OpCompositeConstruct %18 %18 %18 %18 
					                                f32_4 %90 = OpCompositeConstruct %19 %19 %19 %19 
					                                f32_4 %91 = OpExtInst %1 43 %88 %89 %90 
					                                              OpStore %78 %91 
					                                f32_4 %92 = OpLoad %78 
					                         Uniform f32* %93 = OpAccessChain %29 %31 
					                                  f32 %94 = OpLoad %93 
					                                f32_4 %95 = OpCompositeConstruct %94 %94 %94 %94 
					                                f32_4 %96 = OpFMul %92 %95 
					                                              OpStore %78 %96 
					                  read_only Texture2D %98 = OpLoad %41 
					                              sampler %99 = OpLoad %45 
					          read_only Texture2DSampled %100 = OpSampledImage %98 %99 
					                               f32_4 %101 = OpLoad %78 
					                               f32_2 %102 = OpVectorShuffle %101 %101 0 1 
					                               f32_4 %103 = OpImageSampleImplicitLod %100 %102 
					                                              OpStore %97 %103 
					                 read_only Texture2D %104 = OpLoad %41 
					                             sampler %105 = OpLoad %45 
					          read_only Texture2DSampled %106 = OpSampledImage %104 %105 
					                               f32_4 %107 = OpLoad %78 
					                               f32_2 %108 = OpVectorShuffle %107 %107 2 3 
					                               f32_4 %109 = OpImageSampleImplicitLod %106 %108 
					                                              OpStore %78 %109 
					                               f32_4 %110 = OpLoad %78 
					                               f32_4 %113 = OpFMul %110 %112 
					                               f32_4 %114 = OpLoad %97 
					                               f32_4 %115 = OpFAdd %113 %114 
					                                              OpStore %78 %115 
					                               f32_4 %116 = OpLoad %52 
					                               f32_2 %117 = OpVectorShuffle %116 %116 2 1 
					                               f32_2 %118 = OpFNegate %117 
					                               f32_4 %119 = OpLoad %70 
					                               f32_2 %120 = OpVectorShuffle %119 %119 2 0 
					                               f32_2 %121 = OpFMul %118 %120 
					                               f32_2 %122 = OpLoad vs_TEXCOORD0 
					                               f32_2 %123 = OpFAdd %121 %122 
					                               f32_4 %124 = OpLoad %97 
					                               f32_4 %125 = OpVectorShuffle %124 %123 4 5 2 3 
					                                              OpStore %97 %125 
					                               f32_4 %126 = OpLoad %97 
					                               f32_2 %127 = OpVectorShuffle %126 %126 0 1 
					                               f32_2 %128 = OpCompositeConstruct %18 %18 
					                               f32_2 %129 = OpCompositeConstruct %19 %19 
					                               f32_2 %130 = OpExtInst %1 43 %127 %128 %129 
					                               f32_4 %131 = OpLoad %97 
					                               f32_4 %132 = OpVectorShuffle %131 %130 4 5 2 3 
					                                              OpStore %97 %132 
					                               f32_4 %133 = OpLoad %97 
					                               f32_2 %134 = OpVectorShuffle %133 %133 0 1 
					                        Uniform f32* %135 = OpAccessChain %29 %31 
					                                 f32 %136 = OpLoad %135 
					                               f32_2 %137 = OpCompositeConstruct %136 %136 
					                               f32_2 %138 = OpFMul %134 %137 
					                               f32_4 %139 = OpLoad %97 
					                               f32_4 %140 = OpVectorShuffle %139 %138 4 5 2 3 
					                                              OpStore %97 %140 
					                 read_only Texture2D %141 = OpLoad %41 
					                             sampler %142 = OpLoad %45 
					          read_only Texture2DSampled %143 = OpSampledImage %141 %142 
					                               f32_4 %144 = OpLoad %97 
					                               f32_2 %145 = OpVectorShuffle %144 %144 0 1 
					                               f32_4 %146 = OpImageSampleImplicitLod %143 %145 
					                                              OpStore %97 %146 
					                               f32_4 %147 = OpLoad %78 
					                               f32_4 %148 = OpLoad %97 
					                               f32_4 %149 = OpFAdd %147 %148 
					                                              OpStore %78 %149 
					                               f32_4 %150 = OpLoad %52 
					                               f32_4 %151 = OpVectorShuffle %150 %150 2 3 0 3 
					                               f32_4 %152 = OpLoad %70 
					                               f32_4 %153 = OpVectorShuffle %152 %152 2 3 0 3 
					                               f32_4 %154 = OpFMul %151 %153 
					                               f32_2 %155 = OpLoad vs_TEXCOORD0 
					                               f32_4 %156 = OpVectorShuffle %155 %155 0 1 0 1 
					                               f32_4 %157 = OpFAdd %154 %156 
					                                              OpStore %97 %157 
					                               f32_4 %158 = OpLoad %97 
					                               f32_4 %159 = OpCompositeConstruct %18 %18 %18 %18 
					                               f32_4 %160 = OpCompositeConstruct %19 %19 %19 %19 
					                               f32_4 %161 = OpExtInst %1 43 %158 %159 %160 
					                                              OpStore %97 %161 
					                               f32_4 %163 = OpLoad %52 
					                               f32_4 %164 = OpVectorShuffle %163 %163 2 1 3 1 
					                               f32_4 %165 = OpLoad %70 
					                               f32_4 %166 = OpVectorShuffle %165 %165 2 0 3 0 
					                               f32_4 %167 = OpFMul %164 %166 
					                               f32_2 %168 = OpLoad vs_TEXCOORD0 
					                               f32_4 %169 = OpVectorShuffle %168 %168 0 1 0 1 
					                               f32_4 %170 = OpFAdd %167 %169 
					                                              OpStore %162 %170 
					                               f32_4 %171 = OpLoad %162 
					                               f32_4 %172 = OpCompositeConstruct %18 %18 %18 %18 
					                               f32_4 %173 = OpCompositeConstruct %19 %19 %19 %19 
					                               f32_4 %174 = OpExtInst %1 43 %171 %172 %173 
					                                              OpStore %162 %174 
					                               f32_4 %175 = OpLoad %52 
					                               f32_2 %176 = OpVectorShuffle %175 %175 0 1 
					                               f32_4 %177 = OpLoad %70 
					                               f32_2 %178 = OpVectorShuffle %177 %177 0 0 
					                               f32_2 %179 = OpFMul %176 %178 
					                               f32_2 %180 = OpLoad vs_TEXCOORD0 
					                               f32_2 %181 = OpFAdd %179 %180 
					                               f32_4 %182 = OpLoad %52 
					                               f32_4 %183 = OpVectorShuffle %182 %181 4 5 2 3 
					                                              OpStore %52 %183 
					                               f32_4 %184 = OpLoad %52 
					                               f32_2 %185 = OpVectorShuffle %184 %184 0 1 
					                               f32_2 %186 = OpCompositeConstruct %18 %18 
					                               f32_2 %187 = OpCompositeConstruct %19 %19 
					                               f32_2 %188 = OpExtInst %1 43 %185 %186 %187 
					                               f32_4 %189 = OpLoad %52 
					                               f32_4 %190 = OpVectorShuffle %189 %188 4 5 2 3 
					                                              OpStore %52 %190 
					                               f32_4 %191 = OpLoad %52 
					                               f32_2 %192 = OpVectorShuffle %191 %191 0 1 
					                        Uniform f32* %193 = OpAccessChain %29 %31 
					                                 f32 %194 = OpLoad %193 
					                               f32_2 %195 = OpCompositeConstruct %194 %194 
					                               f32_2 %196 = OpFMul %192 %195 
					                               f32_4 %197 = OpLoad %52 
					                               f32_4 %198 = OpVectorShuffle %197 %196 4 5 2 3 
					                                              OpStore %52 %198 
					                 read_only Texture2D %199 = OpLoad %41 
					                             sampler %200 = OpLoad %45 
					          read_only Texture2DSampled %201 = OpSampledImage %199 %200 
					                               f32_4 %202 = OpLoad %52 
					                               f32_2 %203 = OpVectorShuffle %202 %202 0 1 
					                               f32_4 %204 = OpImageSampleImplicitLod %201 %203 
					                                              OpStore %52 %204 
					                               f32_4 %205 = OpLoad %162 
					                        Uniform f32* %206 = OpAccessChain %29 %31 
					                                 f32 %207 = OpLoad %206 
					                               f32_4 %208 = OpCompositeConstruct %207 %207 %207 %207 
					                               f32_4 %209 = OpFMul %205 %208 
					                                              OpStore %70 %209 
					                               f32_4 %210 = OpLoad %97 
					                        Uniform f32* %211 = OpAccessChain %29 %31 
					                                 f32 %212 = OpLoad %211 
					                               f32_4 %213 = OpCompositeConstruct %212 %212 %212 %212 
					                               f32_4 %214 = OpFMul %210 %213 
					                                              OpStore %97 %214 
					                 read_only Texture2D %215 = OpLoad %41 
					                             sampler %216 = OpLoad %45 
					          read_only Texture2DSampled %217 = OpSampledImage %215 %216 
					                               f32_4 %218 = OpLoad %97 
					                               f32_2 %219 = OpVectorShuffle %218 %218 0 1 
					                               f32_4 %220 = OpImageSampleImplicitLod %217 %219 
					                                              OpStore %162 %220 
					                 read_only Texture2D %221 = OpLoad %41 
					                             sampler %222 = OpLoad %45 
					          read_only Texture2DSampled %223 = OpSampledImage %221 %222 
					                               f32_4 %224 = OpLoad %97 
					                               f32_2 %225 = OpVectorShuffle %224 %224 2 3 
					                               f32_4 %226 = OpImageSampleImplicitLod %223 %225 
					                                              OpStore %97 %226 
					                               f32_4 %227 = OpLoad %162 
					                               f32_4 %228 = OpFMul %227 %112 
					                               f32_4 %229 = OpLoad %78 
					                               f32_4 %230 = OpFAdd %228 %229 
					                                              OpStore %78 %230 
					                               f32_4 %231 = OpLoad %9 
					                               f32_4 %234 = OpFMul %231 %233 
					                               f32_4 %235 = OpLoad %78 
					                               f32_4 %236 = OpFAdd %234 %235 
					                                              OpStore %9 %236 
					                               f32_4 %237 = OpLoad %97 
					                               f32_4 %238 = OpFMul %237 %112 
					                               f32_4 %239 = OpLoad %9 
					                               f32_4 %240 = OpFAdd %238 %239 
					                                              OpStore %9 %240 
					                 read_only Texture2D %241 = OpLoad %41 
					                             sampler %242 = OpLoad %45 
					          read_only Texture2DSampled %243 = OpSampledImage %241 %242 
					                               f32_4 %244 = OpLoad %70 
					                               f32_2 %245 = OpVectorShuffle %244 %244 0 1 
					                               f32_4 %246 = OpImageSampleImplicitLod %243 %245 
					                                              OpStore %78 %246 
					                 read_only Texture2D %247 = OpLoad %41 
					                             sampler %248 = OpLoad %45 
					          read_only Texture2DSampled %249 = OpSampledImage %247 %248 
					                               f32_4 %250 = OpLoad %70 
					                               f32_2 %251 = OpVectorShuffle %250 %250 2 3 
					                               f32_4 %252 = OpImageSampleImplicitLod %249 %251 
					                                              OpStore %70 %252 
					                               f32_4 %253 = OpLoad %9 
					                               f32_4 %254 = OpLoad %78 
					                               f32_4 %255 = OpFAdd %253 %254 
					                                              OpStore %9 %255 
					                               f32_4 %256 = OpLoad %70 
					                               f32_4 %257 = OpFMul %256 %112 
					                               f32_4 %258 = OpLoad %9 
					                               f32_4 %259 = OpFAdd %257 %258 
					                                              OpStore %9 %259 
					                               f32_4 %260 = OpLoad %52 
					                               f32_4 %261 = OpLoad %9 
					                               f32_4 %262 = OpFAdd %260 %261 
					                                              OpStore %9 %262 
					                 read_only Texture2D %264 = OpLoad %263 
					                             sampler %266 = OpLoad %265 
					          read_only Texture2DSampled %267 = OpSampledImage %264 %266 
					                               f32_2 %269 = OpLoad vs_TEXCOORD1 
					                               f32_4 %270 = OpImageSampleImplicitLod %267 %269 
					                                              OpStore %52 %270 
					                               f32_4 %273 = OpLoad %9 
					                               f32_4 %276 = OpFMul %273 %275 
					                               f32_4 %277 = OpLoad %52 
					                               f32_4 %278 = OpFAdd %276 %277 
					                                              OpStore %272 %278 
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
						float _SampleScale;
						vec4 unused_0_5[3];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _BloomTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.x = 1.0;
					    u_xlat1.z = _SampleScale;
					    u_xlat1 = u_xlat1.xxzz * _MainTex_TexelSize.xyxy;
					    u_xlat2.z = float(-1.0);
					    u_xlat2.w = float(0.0);
					    u_xlat2.x = _SampleScale;
					    u_xlat3 = (-u_xlat1.xywy) * u_xlat2.xxwx + vs_TEXCOORD0.xyxy;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
					    u_xlat4 = texture(_MainTex, u_xlat3.xy);
					    u_xlat3 = texture(_MainTex, u_xlat3.zw);
					    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + u_xlat4;
					    u_xlat4.xy = (-u_xlat1.zy) * u_xlat2.zx + vs_TEXCOORD0.xy;
					    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat3 = u_xlat3 + u_xlat4;
					    u_xlat4 = u_xlat1.zwxw * u_xlat2.zwxw + vs_TEXCOORD0.xyxy;
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat5 = u_xlat1.zywy * u_xlat2.zxwx + vs_TEXCOORD0.xyxy;
					    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * u_xlat2.xx + vs_TEXCOORD0.xy;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = u_xlat5 * vec4(_RenderViewportScaleFactor);
					    u_xlat4 = u_xlat4 * vec4(_RenderViewportScaleFactor);
					    u_xlat5 = texture(_MainTex, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, u_xlat4.zw);
					    u_xlat3 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + u_xlat3;
					    u_xlat0 = u_xlat0 * vec4(4.0, 4.0, 4.0, 4.0) + u_xlat3;
					    u_xlat0 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + u_xlat0;
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat2 = texture(_MainTex, u_xlat2.zw);
					    u_xlat0 = u_xlat0 + u_xlat3;
					    u_xlat0 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + u_xlat0;
					    u_xlat0 = u_xlat1 + u_xlat0;
					    u_xlat1 = texture(_BloomTex, vs_TEXCOORD1.xy);
					    SV_Target0 = u_xlat0 * vec4(0.0625, 0.0625, 0.0625, 0.0625) + u_xlat1;
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
			GpuProgramID 338895
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
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _SampleScale;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _BloomTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-1.0, -1.0, 1.0, 1.0);
					    u_xlat1.x = _SampleScale * 0.5;
					    u_xlat2 = u_xlat0.xyzy * u_xlat1.xxxx + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat0 = u_xlat0.xwzw * u_xlat1.xxxx + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat2 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1 = texture(_BloomTex, vs_TEXCOORD1.xy);
					    SV_Target0 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25) + u_xlat1;
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
					                                              OpEntryPoint Fragment %4 "main" %42 %119 %123 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpMemberDecorate %10 0 Offset 10 
					                                              OpMemberDecorate %10 1 Offset 10 
					                                              OpMemberDecorate %10 2 Offset 10 
					                                              OpDecorate %10 Block 
					                                              OpDecorate %12 DescriptorSet 12 
					                                              OpDecorate %12 Binding 12 
					                                              OpDecorate vs_TEXCOORD0 Location 42 
					                                              OpDecorate %76 DescriptorSet 76 
					                                              OpDecorate %76 Binding 76 
					                                              OpDecorate %80 DescriptorSet 80 
					                                              OpDecorate %80 Binding 80 
					                                              OpDecorate %114 DescriptorSet 114 
					                                              OpDecorate %114 Binding 114 
					                                              OpDecorate %116 DescriptorSet 116 
					                                              OpDecorate %116 Binding 116 
					                                              OpDecorate vs_TEXCOORD1 Location 119 
					                                              OpDecorate %123 Location 123 
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
					                                  f32 %19 = OpConstant 3,674022E-40 
					                                  f32 %20 = OpConstant 3,674022E-40 
					                                f32_4 %21 = OpConstantComposite %19 %19 %20 %20 
					                       Private f32_4* %23 = OpVariable Private 
					                                  i32 %24 = OpConstant 2 
					                                      %25 = OpTypePointer Uniform %6 
					                                  f32 %28 = OpConstant 3,674022E-40 
					                                      %30 = OpTypeInt 32 0 
					                                  u32 %31 = OpConstant 0 
					                                      %32 = OpTypePointer Private %6 
					                       Private f32_4* %34 = OpVariable Private 
					                                      %40 = OpTypeVector %6 2 
					                                      %41 = OpTypePointer Input %40 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                  f32 %47 = OpConstant 3,674022E-40 
					                                  i32 %64 = OpConstant 0 
					                                      %74 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                      %75 = OpTypePointer UniformConstant %74 
					 UniformConstant read_only Texture2D* %76 = OpVariable UniformConstant 
					                                      %78 = OpTypeSampler 
					                                      %79 = OpTypePointer UniformConstant %78 
					             UniformConstant sampler* %80 = OpVariable UniformConstant 
					                                      %82 = OpTypeSampledImage %74 
					UniformConstant read_only Texture2D* %114 = OpVariable UniformConstant 
					            UniformConstant sampler* %116 = OpVariable UniformConstant 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                     %122 = OpTypePointer Output %7 
					                       Output f32_4* %123 = OpVariable Output 
					                                 f32 %125 = OpConstant 3,674022E-40 
					                               f32_4 %126 = OpConstantComposite %125 %125 %125 %125 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                       Uniform f32_4* %16 = OpAccessChain %12 %14 
					                                f32_4 %17 = OpLoad %16 
					                                f32_4 %18 = OpVectorShuffle %17 %17 0 1 0 1 
					                                f32_4 %22 = OpFMul %18 %21 
					                                              OpStore %9 %22 
					                         Uniform f32* %26 = OpAccessChain %12 %24 
					                                  f32 %27 = OpLoad %26 
					                                  f32 %29 = OpFMul %27 %28 
					                         Private f32* %33 = OpAccessChain %23 %31 
					                                              OpStore %33 %29 
					                                f32_4 %35 = OpLoad %9 
					                                f32_4 %36 = OpVectorShuffle %35 %35 0 1 2 1 
					                                f32_4 %37 = OpLoad %23 
					                                f32_4 %38 = OpVectorShuffle %37 %37 0 0 0 0 
					                                f32_4 %39 = OpFMul %36 %38 
					                                f32_2 %43 = OpLoad vs_TEXCOORD0 
					                                f32_4 %44 = OpVectorShuffle %43 %43 0 1 0 1 
					                                f32_4 %45 = OpFAdd %39 %44 
					                                              OpStore %34 %45 
					                                f32_4 %46 = OpLoad %34 
					                                f32_4 %48 = OpCompositeConstruct %47 %47 %47 %47 
					                                f32_4 %49 = OpCompositeConstruct %20 %20 %20 %20 
					                                f32_4 %50 = OpExtInst %1 43 %46 %48 %49 
					                                              OpStore %34 %50 
					                                f32_4 %51 = OpLoad %9 
					                                f32_4 %52 = OpVectorShuffle %51 %51 0 3 2 3 
					                                f32_4 %53 = OpLoad %23 
					                                f32_4 %54 = OpVectorShuffle %53 %53 0 0 0 0 
					                                f32_4 %55 = OpFMul %52 %54 
					                                f32_2 %56 = OpLoad vs_TEXCOORD0 
					                                f32_4 %57 = OpVectorShuffle %56 %56 0 1 0 1 
					                                f32_4 %58 = OpFAdd %55 %57 
					                                              OpStore %9 %58 
					                                f32_4 %59 = OpLoad %9 
					                                f32_4 %60 = OpCompositeConstruct %47 %47 %47 %47 
					                                f32_4 %61 = OpCompositeConstruct %20 %20 %20 %20 
					                                f32_4 %62 = OpExtInst %1 43 %59 %60 %61 
					                                              OpStore %9 %62 
					                                f32_4 %63 = OpLoad %9 
					                         Uniform f32* %65 = OpAccessChain %12 %64 
					                                  f32 %66 = OpLoad %65 
					                                f32_4 %67 = OpCompositeConstruct %66 %66 %66 %66 
					                                f32_4 %68 = OpFMul %63 %67 
					                                              OpStore %9 %68 
					                                f32_4 %69 = OpLoad %34 
					                         Uniform f32* %70 = OpAccessChain %12 %64 
					                                  f32 %71 = OpLoad %70 
					                                f32_4 %72 = OpCompositeConstruct %71 %71 %71 %71 
					                                f32_4 %73 = OpFMul %69 %72 
					                                              OpStore %23 %73 
					                  read_only Texture2D %77 = OpLoad %76 
					                              sampler %81 = OpLoad %80 
					           read_only Texture2DSampled %83 = OpSampledImage %77 %81 
					                                f32_4 %84 = OpLoad %23 
					                                f32_2 %85 = OpVectorShuffle %84 %84 0 1 
					                                f32_4 %86 = OpImageSampleImplicitLod %83 %85 
					                                              OpStore %34 %86 
					                  read_only Texture2D %87 = OpLoad %76 
					                              sampler %88 = OpLoad %80 
					           read_only Texture2DSampled %89 = OpSampledImage %87 %88 
					                                f32_4 %90 = OpLoad %23 
					                                f32_2 %91 = OpVectorShuffle %90 %90 2 3 
					                                f32_4 %92 = OpImageSampleImplicitLod %89 %91 
					                                              OpStore %23 %92 
					                                f32_4 %93 = OpLoad %23 
					                                f32_4 %94 = OpLoad %34 
					                                f32_4 %95 = OpFAdd %93 %94 
					                                              OpStore %23 %95 
					                  read_only Texture2D %96 = OpLoad %76 
					                              sampler %97 = OpLoad %80 
					           read_only Texture2DSampled %98 = OpSampledImage %96 %97 
					                                f32_4 %99 = OpLoad %9 
					                               f32_2 %100 = OpVectorShuffle %99 %99 0 1 
					                               f32_4 %101 = OpImageSampleImplicitLod %98 %100 
					                                              OpStore %34 %101 
					                 read_only Texture2D %102 = OpLoad %76 
					                             sampler %103 = OpLoad %80 
					          read_only Texture2DSampled %104 = OpSampledImage %102 %103 
					                               f32_4 %105 = OpLoad %9 
					                               f32_2 %106 = OpVectorShuffle %105 %105 2 3 
					                               f32_4 %107 = OpImageSampleImplicitLod %104 %106 
					                                              OpStore %9 %107 
					                               f32_4 %108 = OpLoad %23 
					                               f32_4 %109 = OpLoad %34 
					                               f32_4 %110 = OpFAdd %108 %109 
					                                              OpStore %23 %110 
					                               f32_4 %111 = OpLoad %9 
					                               f32_4 %112 = OpLoad %23 
					                               f32_4 %113 = OpFAdd %111 %112 
					                                              OpStore %9 %113 
					                 read_only Texture2D %115 = OpLoad %114 
					                             sampler %117 = OpLoad %116 
					          read_only Texture2DSampled %118 = OpSampledImage %115 %117 
					                               f32_2 %120 = OpLoad vs_TEXCOORD1 
					                               f32_4 %121 = OpImageSampleImplicitLod %118 %120 
					                                              OpStore %23 %121 
					                               f32_4 %124 = OpLoad %9 
					                               f32_4 %127 = OpFMul %124 %126 
					                               f32_4 %128 = OpLoad %23 
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						float _SampleScale;
						vec4 unused_0_5[3];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _BloomTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-1.0, -1.0, 1.0, 1.0);
					    u_xlat1.x = _SampleScale * 0.5;
					    u_xlat2 = u_xlat0.xyzy * u_xlat1.xxxx + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat0 = u_xlat0.xwzw * u_xlat1.xxxx + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat2 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1 = texture(_BloomTex, vs_TEXCOORD1.xy);
					    SV_Target0 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25) + u_xlat1;
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
			GpuProgramID 426934
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
					uniform 	vec4 _Threshold;
					uniform 	vec4 _Params;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _AutoExposureTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat5;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.xyz = min(u_xlat0.xyz, vec3(65504.0, 65504.0, 65504.0));
					    u_xlat1 = texture(_AutoExposureTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat0.xyz = min(u_xlat0.xyz, _Params.xxx);
					    u_xlat6 = max(u_xlat0.y, u_xlat0.x);
					    u_xlat6 = max(u_xlat0.z, u_xlat6);
					    u_xlat1.xy = vec2(u_xlat6) + (-_Threshold.yx);
					    u_xlat6 = max(u_xlat6, 9.99999975e-05);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = min(u_xlat1.x, _Threshold.z);
					    u_xlat5 = u_xlat1.x * _Threshold.w;
					    u_xlat1.x = u_xlat1.x * u_xlat5;
					    u_xlat1.x = max(u_xlat1.y, u_xlat1.x);
					    u_xlat6 = u_xlat1.x / u_xlat6;
					    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					; Bound: 129
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %38 %118 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate vs_TEXCOORD1 Location 22 
					                                             OpDecorate %33 DescriptorSet 33 
					                                             OpDecorate %33 Binding 33 
					                                             OpDecorate %35 DescriptorSet 35 
					                                             OpDecorate %35 Binding 35 
					                                             OpDecorate vs_TEXCOORD0 Location 38 
					                                             OpMemberDecorate %49 0 Offset 49 
					                                             OpMemberDecorate %49 1 Offset 49 
					                                             OpDecorate %49 Block 
					                                             OpDecorate %51 DescriptorSet 51 
					                                             OpDecorate %51 Binding 51 
					                                             OpDecorate %118 Location 118 
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
					                                 f32 %28 = OpConstant 3,674022E-40 
					                               f32_3 %29 = OpConstantComposite %28 %28 %28 
					                                     %31 = OpTypePointer Private %6 
					                        Private f32* %32 = OpVariable Private 
					UniformConstant read_only Texture2D* %33 = OpVariable UniformConstant 
					            UniformConstant sampler* %35 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %41 = OpTypeInt 32 0 
					                                 u32 %42 = OpConstant 0 
					                                     %49 = OpTypeStruct %24 %24 
					                                     %50 = OpTypePointer Uniform %49 
					     Uniform struct {f32_4; f32_4;}* %51 = OpVariable Uniform 
					                                     %52 = OpTypeInt 32 1 
					                                 i32 %53 = OpConstant 1 
					                                     %54 = OpTypePointer Uniform %24 
					                                 u32 %59 = OpConstant 1 
					                                 u32 %65 = OpConstant 2 
					                                     %70 = OpTypePointer Private %20 
					                      Private f32_2* %71 = OpVariable Private 
					                                 i32 %74 = OpConstant 0 
					                                 f32 %81 = OpConstant 3,674022E-40 
					                                 f32 %85 = OpConstant 3,674022E-40 
					                                     %90 = OpTypePointer Uniform %6 
					                        Private f32* %95 = OpVariable Private 
					                                 u32 %98 = OpConstant 3 
					                                    %117 = OpTypePointer Output %24 
					                      Output f32_4* %118 = OpVariable Output 
					                                f32 %125 = OpConstant 3,674022E-40 
					                                    %126 = OpTypePointer Output %6 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD1 
					                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
					                                             OpStore %9 %26 
					                               f32_3 %27 = OpLoad %9 
					                               f32_3 %30 = OpExtInst %1 37 %27 %29 
					                                             OpStore %9 %30 
					                 read_only Texture2D %34 = OpLoad %33 
					                             sampler %36 = OpLoad %35 
					          read_only Texture2DSampled %37 = OpSampledImage %34 %36 
					                               f32_2 %39 = OpLoad vs_TEXCOORD0 
					                               f32_4 %40 = OpImageSampleImplicitLod %37 %39 
					                                 f32 %43 = OpCompositeExtract %40 0 
					                                             OpStore %32 %43 
					                                 f32 %44 = OpLoad %32 
					                               f32_3 %45 = OpCompositeConstruct %44 %44 %44 
					                               f32_3 %46 = OpLoad %9 
					                               f32_3 %47 = OpFMul %45 %46 
					                                             OpStore %9 %47 
					                               f32_3 %48 = OpLoad %9 
					                      Uniform f32_4* %55 = OpAccessChain %51 %53 
					                               f32_4 %56 = OpLoad %55 
					                               f32_3 %57 = OpVectorShuffle %56 %56 0 0 0 
					                               f32_3 %58 = OpExtInst %1 37 %48 %57 
					                                             OpStore %9 %58 
					                        Private f32* %60 = OpAccessChain %9 %59 
					                                 f32 %61 = OpLoad %60 
					                        Private f32* %62 = OpAccessChain %9 %42 
					                                 f32 %63 = OpLoad %62 
					                                 f32 %64 = OpExtInst %1 40 %61 %63 
					                                             OpStore %32 %64 
					                        Private f32* %66 = OpAccessChain %9 %65 
					                                 f32 %67 = OpLoad %66 
					                                 f32 %68 = OpLoad %32 
					                                 f32 %69 = OpExtInst %1 40 %67 %68 
					                                             OpStore %32 %69 
					                                 f32 %72 = OpLoad %32 
					                               f32_2 %73 = OpCompositeConstruct %72 %72 
					                      Uniform f32_4* %75 = OpAccessChain %51 %74 
					                               f32_4 %76 = OpLoad %75 
					                               f32_2 %77 = OpVectorShuffle %76 %76 1 0 
					                               f32_2 %78 = OpFNegate %77 
					                               f32_2 %79 = OpFAdd %73 %78 
					                                             OpStore %71 %79 
					                                 f32 %80 = OpLoad %32 
					                                 f32 %82 = OpExtInst %1 40 %80 %81 
					                                             OpStore %32 %82 
					                        Private f32* %83 = OpAccessChain %71 %42 
					                                 f32 %84 = OpLoad %83 
					                                 f32 %86 = OpExtInst %1 40 %84 %85 
					                        Private f32* %87 = OpAccessChain %71 %42 
					                                             OpStore %87 %86 
					                        Private f32* %88 = OpAccessChain %71 %42 
					                                 f32 %89 = OpLoad %88 
					                        Uniform f32* %91 = OpAccessChain %51 %74 %65 
					                                 f32 %92 = OpLoad %91 
					                                 f32 %93 = OpExtInst %1 37 %89 %92 
					                        Private f32* %94 = OpAccessChain %71 %42 
					                                             OpStore %94 %93 
					                        Private f32* %96 = OpAccessChain %71 %42 
					                                 f32 %97 = OpLoad %96 
					                        Uniform f32* %99 = OpAccessChain %51 %74 %98 
					                                f32 %100 = OpLoad %99 
					                                f32 %101 = OpFMul %97 %100 
					                                             OpStore %95 %101 
					                       Private f32* %102 = OpAccessChain %71 %42 
					                                f32 %103 = OpLoad %102 
					                                f32 %104 = OpLoad %95 
					                                f32 %105 = OpFMul %103 %104 
					                       Private f32* %106 = OpAccessChain %71 %42 
					                                             OpStore %106 %105 
					                       Private f32* %107 = OpAccessChain %71 %59 
					                                f32 %108 = OpLoad %107 
					                       Private f32* %109 = OpAccessChain %71 %42 
					                                f32 %110 = OpLoad %109 
					                                f32 %111 = OpExtInst %1 40 %108 %110 
					                       Private f32* %112 = OpAccessChain %71 %42 
					                                             OpStore %112 %111 
					                       Private f32* %113 = OpAccessChain %71 %42 
					                                f32 %114 = OpLoad %113 
					                                f32 %115 = OpLoad %32 
					                                f32 %116 = OpFDiv %114 %115 
					                                             OpStore %32 %116 
					                                f32 %119 = OpLoad %32 
					                              f32_3 %120 = OpCompositeConstruct %119 %119 %119 
					                              f32_3 %121 = OpLoad %9 
					                              f32_3 %122 = OpFMul %120 %121 
					                              f32_4 %123 = OpLoad %118 
					                              f32_4 %124 = OpVectorShuffle %123 %122 4 5 6 3 
					                                             OpStore %118 %124 
					                        Output f32* %127 = OpAccessChain %118 %98 
					                                             OpStore %127 %125 
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
						vec4 unused_0_0[31];
						vec4 _Threshold;
						vec4 _Params;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AutoExposureTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat5;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.xyz = min(u_xlat0.xyz, vec3(65504.0, 65504.0, 65504.0));
					    u_xlat1 = texture(_AutoExposureTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat0.xyz = min(u_xlat0.xyz, _Params.xxx);
					    u_xlat6 = max(u_xlat0.y, u_xlat0.x);
					    u_xlat6 = max(u_xlat0.z, u_xlat6);
					    u_xlat1.xy = vec2(u_xlat6) + (-_Threshold.yx);
					    u_xlat6 = max(u_xlat6, 9.99999975e-05);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = min(u_xlat1.x, _Threshold.z);
					    u_xlat5 = u_xlat1.x * _Threshold.w;
					    u_xlat1.x = u_xlat1.x * u_xlat5;
					    u_xlat1.x = max(u_xlat1.y, u_xlat1.x);
					    u_xlat6 = u_xlat1.x / u_xlat6;
					    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 491318
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
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _SampleScale;
					uniform 	vec4 _ColorIntensity;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.x = 1.0;
					    u_xlat1.z = _SampleScale;
					    u_xlat1 = u_xlat1.xxzz * _MainTex_TexelSize.xyxy;
					    u_xlat2.z = float(-1.0);
					    u_xlat2.w = float(0.0);
					    u_xlat2.x = _SampleScale;
					    u_xlat3 = (-u_xlat1.xywy) * u_xlat2.xxwx + vs_TEXCOORD0.xyxy;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
					    u_xlat4 = texture(_MainTex, u_xlat3.xy);
					    u_xlat3 = texture(_MainTex, u_xlat3.zw);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat4.xyz;
					    u_xlat4.xy = (-u_xlat1.zy) * u_xlat2.zx + vs_TEXCOORD0.xy;
					    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat4.xyz;
					    u_xlat4 = u_xlat1.zwxw * u_xlat2.zwxw + vs_TEXCOORD0.xyxy;
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat5 = u_xlat1.zywy * u_xlat2.zxwx + vs_TEXCOORD0.xyxy;
					    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * u_xlat2.xx + vs_TEXCOORD0.xy;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = u_xlat5 * vec4(_RenderViewportScaleFactor);
					    u_xlat4 = u_xlat4 * vec4(_RenderViewportScaleFactor);
					    u_xlat5 = texture(_MainTex, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, u_xlat4.zw);
					    u_xlat3.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(4.0, 4.0, 4.0) + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat2 = texture(_MainTex, u_xlat2.zw);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.0625, 0.0625, 0.0625);
					    u_xlat0.xyz = u_xlat0.xyz * _ColorIntensity.www;
					    SV_Target0.xyz = u_xlat0.xyz * _ColorIntensity.xyz;
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
					; Bound: 329
					; Schema: 0
					                                                  OpCapability Shader 
					                                           %1 = OpExtInstImport "GLSL.std.450" 
					                                                  OpMemoryModel Logical GLSL450 
					                                                  OpEntryPoint Fragment %4 "main" %12 %318 
					                                                  OpExecutionMode %4 OriginUpperLeft 
					                                                  OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                  OpDecorate vs_TEXCOORD0 Location 12 
					                                                  OpMemberDecorate %28 0 Offset 28 
					                                                  OpMemberDecorate %28 1 Offset 28 
					                                                  OpMemberDecorate %28 2 Offset 28 
					                                                  OpMemberDecorate %28 3 Offset 28 
					                                                  OpDecorate %28 Block 
					                                                  OpDecorate %30 DescriptorSet 30 
					                                                  OpDecorate %30 Binding 30 
					                                                  OpDecorate %42 DescriptorSet 42 
					                                                  OpDecorate %42 Binding 42 
					                                                  OpDecorate %46 DescriptorSet 46 
					                                                  OpDecorate %46 Binding 46 
					                                                  OpDecorate %318 Location 318 
					                                           %2 = OpTypeVoid 
					                                           %3 = OpTypeFunction %2 
					                                           %6 = OpTypeFloat 32 
					                                           %7 = OpTypeVector %6 3 
					                                           %8 = OpTypePointer Private %7 
					                            Private f32_3* %9 = OpVariable Private 
					                                          %10 = OpTypeVector %6 2 
					                                          %11 = OpTypePointer Input %10 
					                    Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                      f32 %18 = OpConstant 3,674022E-40 
					                                      f32 %19 = OpConstant 3,674022E-40 
					                                          %27 = OpTypeVector %6 4 
					                                          %28 = OpTypeStruct %6 %27 %6 %27 
					                                          %29 = OpTypePointer Uniform %28 
					Uniform struct {f32; f32_4; f32; f32_4;}* %30 = OpVariable Uniform 
					                                          %31 = OpTypeInt 32 1 
					                                      i32 %32 = OpConstant 0 
					                                          %33 = OpTypePointer Uniform %6 
					                                          %40 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                          %41 = OpTypePointer UniformConstant %40 
					     UniformConstant read_only Texture2D* %42 = OpVariable UniformConstant 
					                                          %44 = OpTypeSampler 
					                                          %45 = OpTypePointer UniformConstant %44 
					                 UniformConstant sampler* %46 = OpVariable UniformConstant 
					                                          %48 = OpTypeSampledImage %40 
					                                          %54 = OpTypePointer Private %27 
					                           Private f32_4* %55 = OpVariable Private 
					                                          %56 = OpTypeInt 32 0 
					                                      u32 %57 = OpConstant 0 
					                                          %58 = OpTypePointer Private %6 
					                                      i32 %60 = OpConstant 2 
					                                      u32 %63 = OpConstant 2 
					                                      i32 %67 = OpConstant 1 
					                                          %68 = OpTypePointer Uniform %27 
					                           Private f32_4* %73 = OpVariable Private 
					                                      f32 %74 = OpConstant 3,674022E-40 
					                                      u32 %76 = OpConstant 3 
					                           Private f32_4* %81 = OpVariable Private 
					                          Private f32_4* %100 = OpVariable Private 
					                                     f32 %121 = OpConstant 3,674022E-40 
					                                   f32_3 %122 = OpConstantComposite %121 %121 %121 
					                          Private f32_4* %182 = OpVariable Private 
					                                     f32 %265 = OpConstant 3,674022E-40 
					                                   f32_3 %266 = OpConstantComposite %265 %265 %265 
					                                     f32 %308 = OpConstant 3,674022E-40 
					                                   f32_3 %309 = OpConstantComposite %308 %308 %308 
					                                     i32 %312 = OpConstant 3 
					                                         %317 = OpTypePointer Output %27 
					                           Output f32_4* %318 = OpVariable Output 
					                                         %326 = OpTypePointer Output %6 
					                                      void %4 = OpFunction None %3 
					                                           %5 = OpLabel 
					                                    f32_2 %13 = OpLoad vs_TEXCOORD0 
					                                    f32_3 %14 = OpLoad %9 
					                                    f32_3 %15 = OpVectorShuffle %14 %13 3 4 2 
					                                                  OpStore %9 %15 
					                                    f32_3 %16 = OpLoad %9 
					                                    f32_2 %17 = OpVectorShuffle %16 %16 0 1 
					                                    f32_2 %20 = OpCompositeConstruct %18 %18 
					                                    f32_2 %21 = OpCompositeConstruct %19 %19 
					                                    f32_2 %22 = OpExtInst %1 43 %17 %20 %21 
					                                    f32_3 %23 = OpLoad %9 
					                                    f32_3 %24 = OpVectorShuffle %23 %22 3 4 2 
					                                                  OpStore %9 %24 
					                                    f32_3 %25 = OpLoad %9 
					                                    f32_2 %26 = OpVectorShuffle %25 %25 0 1 
					                             Uniform f32* %34 = OpAccessChain %30 %32 
					                                      f32 %35 = OpLoad %34 
					                                    f32_2 %36 = OpCompositeConstruct %35 %35 
					                                    f32_2 %37 = OpFMul %26 %36 
					                                    f32_3 %38 = OpLoad %9 
					                                    f32_3 %39 = OpVectorShuffle %38 %37 3 4 2 
					                                                  OpStore %9 %39 
					                      read_only Texture2D %43 = OpLoad %42 
					                                  sampler %47 = OpLoad %46 
					               read_only Texture2DSampled %49 = OpSampledImage %43 %47 
					                                    f32_3 %50 = OpLoad %9 
					                                    f32_2 %51 = OpVectorShuffle %50 %50 0 1 
					                                    f32_4 %52 = OpImageSampleImplicitLod %49 %51 
					                                    f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
					                                                  OpStore %9 %53 
					                             Private f32* %59 = OpAccessChain %55 %57 
					                                                  OpStore %59 %19 
					                             Uniform f32* %61 = OpAccessChain %30 %60 
					                                      f32 %62 = OpLoad %61 
					                             Private f32* %64 = OpAccessChain %55 %63 
					                                                  OpStore %64 %62 
					                                    f32_4 %65 = OpLoad %55 
					                                    f32_4 %66 = OpVectorShuffle %65 %65 0 0 2 2 
					                           Uniform f32_4* %69 = OpAccessChain %30 %67 
					                                    f32_4 %70 = OpLoad %69 
					                                    f32_4 %71 = OpVectorShuffle %70 %70 0 1 0 1 
					                                    f32_4 %72 = OpFMul %66 %71 
					                                                  OpStore %55 %72 
					                             Private f32* %75 = OpAccessChain %73 %63 
					                                                  OpStore %75 %74 
					                             Private f32* %77 = OpAccessChain %73 %76 
					                                                  OpStore %77 %18 
					                             Uniform f32* %78 = OpAccessChain %30 %60 
					                                      f32 %79 = OpLoad %78 
					                             Private f32* %80 = OpAccessChain %73 %57 
					                                                  OpStore %80 %79 
					                                    f32_4 %82 = OpLoad %55 
					                                    f32_4 %83 = OpVectorShuffle %82 %82 0 1 3 1 
					                                    f32_4 %84 = OpFNegate %83 
					                                    f32_4 %85 = OpLoad %73 
					                                    f32_4 %86 = OpVectorShuffle %85 %85 0 0 3 0 
					                                    f32_4 %87 = OpFMul %84 %86 
					                                    f32_2 %88 = OpLoad vs_TEXCOORD0 
					                                    f32_4 %89 = OpVectorShuffle %88 %88 0 1 0 1 
					                                    f32_4 %90 = OpFAdd %87 %89 
					                                                  OpStore %81 %90 
					                                    f32_4 %91 = OpLoad %81 
					                                    f32_4 %92 = OpCompositeConstruct %18 %18 %18 %18 
					                                    f32_4 %93 = OpCompositeConstruct %19 %19 %19 %19 
					                                    f32_4 %94 = OpExtInst %1 43 %91 %92 %93 
					                                                  OpStore %81 %94 
					                                    f32_4 %95 = OpLoad %81 
					                             Uniform f32* %96 = OpAccessChain %30 %32 
					                                      f32 %97 = OpLoad %96 
					                                    f32_4 %98 = OpCompositeConstruct %97 %97 %97 %97 
					                                    f32_4 %99 = OpFMul %95 %98 
					                                                  OpStore %81 %99 
					                     read_only Texture2D %101 = OpLoad %42 
					                                 sampler %102 = OpLoad %46 
					              read_only Texture2DSampled %103 = OpSampledImage %101 %102 
					                                   f32_4 %104 = OpLoad %81 
					                                   f32_2 %105 = OpVectorShuffle %104 %104 0 1 
					                                   f32_4 %106 = OpImageSampleImplicitLod %103 %105 
					                                   f32_3 %107 = OpVectorShuffle %106 %106 0 1 2 
					                                   f32_4 %108 = OpLoad %100 
					                                   f32_4 %109 = OpVectorShuffle %108 %107 4 5 6 3 
					                                                  OpStore %100 %109 
					                     read_only Texture2D %110 = OpLoad %42 
					                                 sampler %111 = OpLoad %46 
					              read_only Texture2DSampled %112 = OpSampledImage %110 %111 
					                                   f32_4 %113 = OpLoad %81 
					                                   f32_2 %114 = OpVectorShuffle %113 %113 2 3 
					                                   f32_4 %115 = OpImageSampleImplicitLod %112 %114 
					                                   f32_3 %116 = OpVectorShuffle %115 %115 0 1 2 
					                                   f32_4 %117 = OpLoad %81 
					                                   f32_4 %118 = OpVectorShuffle %117 %116 4 5 6 3 
					                                                  OpStore %81 %118 
					                                   f32_4 %119 = OpLoad %81 
					                                   f32_3 %120 = OpVectorShuffle %119 %119 0 1 2 
					                                   f32_3 %123 = OpFMul %120 %122 
					                                   f32_4 %124 = OpLoad %100 
					                                   f32_3 %125 = OpVectorShuffle %124 %124 0 1 2 
					                                   f32_3 %126 = OpFAdd %123 %125 
					                                   f32_4 %127 = OpLoad %81 
					                                   f32_4 %128 = OpVectorShuffle %127 %126 4 5 6 3 
					                                                  OpStore %81 %128 
					                                   f32_4 %129 = OpLoad %55 
					                                   f32_2 %130 = OpVectorShuffle %129 %129 2 1 
					                                   f32_2 %131 = OpFNegate %130 
					                                   f32_4 %132 = OpLoad %73 
					                                   f32_2 %133 = OpVectorShuffle %132 %132 2 0 
					                                   f32_2 %134 = OpFMul %131 %133 
					                                   f32_2 %135 = OpLoad vs_TEXCOORD0 
					                                   f32_2 %136 = OpFAdd %134 %135 
					                                   f32_4 %137 = OpLoad %100 
					                                   f32_4 %138 = OpVectorShuffle %137 %136 4 5 2 3 
					                                                  OpStore %100 %138 
					                                   f32_4 %139 = OpLoad %100 
					                                   f32_2 %140 = OpVectorShuffle %139 %139 0 1 
					                                   f32_2 %141 = OpCompositeConstruct %18 %18 
					                                   f32_2 %142 = OpCompositeConstruct %19 %19 
					                                   f32_2 %143 = OpExtInst %1 43 %140 %141 %142 
					                                   f32_4 %144 = OpLoad %100 
					                                   f32_4 %145 = OpVectorShuffle %144 %143 4 5 2 3 
					                                                  OpStore %100 %145 
					                                   f32_4 %146 = OpLoad %100 
					                                   f32_2 %147 = OpVectorShuffle %146 %146 0 1 
					                            Uniform f32* %148 = OpAccessChain %30 %32 
					                                     f32 %149 = OpLoad %148 
					                                   f32_2 %150 = OpCompositeConstruct %149 %149 
					                                   f32_2 %151 = OpFMul %147 %150 
					                                   f32_4 %152 = OpLoad %100 
					                                   f32_4 %153 = OpVectorShuffle %152 %151 4 5 2 3 
					                                                  OpStore %100 %153 
					                     read_only Texture2D %154 = OpLoad %42 
					                                 sampler %155 = OpLoad %46 
					              read_only Texture2DSampled %156 = OpSampledImage %154 %155 
					                                   f32_4 %157 = OpLoad %100 
					                                   f32_2 %158 = OpVectorShuffle %157 %157 0 1 
					                                   f32_4 %159 = OpImageSampleImplicitLod %156 %158 
					                                   f32_3 %160 = OpVectorShuffle %159 %159 0 1 2 
					                                   f32_4 %161 = OpLoad %100 
					                                   f32_4 %162 = OpVectorShuffle %161 %160 4 5 6 3 
					                                                  OpStore %100 %162 
					                                   f32_4 %163 = OpLoad %81 
					                                   f32_3 %164 = OpVectorShuffle %163 %163 0 1 2 
					                                   f32_4 %165 = OpLoad %100 
					                                   f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                   f32_3 %167 = OpFAdd %164 %166 
					                                   f32_4 %168 = OpLoad %81 
					                                   f32_4 %169 = OpVectorShuffle %168 %167 4 5 6 3 
					                                                  OpStore %81 %169 
					                                   f32_4 %170 = OpLoad %55 
					                                   f32_4 %171 = OpVectorShuffle %170 %170 2 3 0 3 
					                                   f32_4 %172 = OpLoad %73 
					                                   f32_4 %173 = OpVectorShuffle %172 %172 2 3 0 3 
					                                   f32_4 %174 = OpFMul %171 %173 
					                                   f32_2 %175 = OpLoad vs_TEXCOORD0 
					                                   f32_4 %176 = OpVectorShuffle %175 %175 0 1 0 1 
					                                   f32_4 %177 = OpFAdd %174 %176 
					                                                  OpStore %100 %177 
					                                   f32_4 %178 = OpLoad %100 
					                                   f32_4 %179 = OpCompositeConstruct %18 %18 %18 %18 
					                                   f32_4 %180 = OpCompositeConstruct %19 %19 %19 %19 
					                                   f32_4 %181 = OpExtInst %1 43 %178 %179 %180 
					                                                  OpStore %100 %181 
					                                   f32_4 %183 = OpLoad %55 
					                                   f32_4 %184 = OpVectorShuffle %183 %183 2 1 3 1 
					                                   f32_4 %185 = OpLoad %73 
					                                   f32_4 %186 = OpVectorShuffle %185 %185 2 0 3 0 
					                                   f32_4 %187 = OpFMul %184 %186 
					                                   f32_2 %188 = OpLoad vs_TEXCOORD0 
					                                   f32_4 %189 = OpVectorShuffle %188 %188 0 1 0 1 
					                                   f32_4 %190 = OpFAdd %187 %189 
					                                                  OpStore %182 %190 
					                                   f32_4 %191 = OpLoad %182 
					                                   f32_4 %192 = OpCompositeConstruct %18 %18 %18 %18 
					                                   f32_4 %193 = OpCompositeConstruct %19 %19 %19 %19 
					                                   f32_4 %194 = OpExtInst %1 43 %191 %192 %193 
					                                                  OpStore %182 %194 
					                                   f32_4 %195 = OpLoad %55 
					                                   f32_2 %196 = OpVectorShuffle %195 %195 0 1 
					                                   f32_4 %197 = OpLoad %73 
					                                   f32_2 %198 = OpVectorShuffle %197 %197 0 0 
					                                   f32_2 %199 = OpFMul %196 %198 
					                                   f32_2 %200 = OpLoad vs_TEXCOORD0 
					                                   f32_2 %201 = OpFAdd %199 %200 
					                                   f32_4 %202 = OpLoad %55 
					                                   f32_4 %203 = OpVectorShuffle %202 %201 4 5 2 3 
					                                                  OpStore %55 %203 
					                                   f32_4 %204 = OpLoad %55 
					                                   f32_2 %205 = OpVectorShuffle %204 %204 0 1 
					                                   f32_2 %206 = OpCompositeConstruct %18 %18 
					                                   f32_2 %207 = OpCompositeConstruct %19 %19 
					                                   f32_2 %208 = OpExtInst %1 43 %205 %206 %207 
					                                   f32_4 %209 = OpLoad %55 
					                                   f32_4 %210 = OpVectorShuffle %209 %208 4 5 2 3 
					                                                  OpStore %55 %210 
					                                   f32_4 %211 = OpLoad %55 
					                                   f32_2 %212 = OpVectorShuffle %211 %211 0 1 
					                            Uniform f32* %213 = OpAccessChain %30 %32 
					                                     f32 %214 = OpLoad %213 
					                                   f32_2 %215 = OpCompositeConstruct %214 %214 
					                                   f32_2 %216 = OpFMul %212 %215 
					                                   f32_4 %217 = OpLoad %55 
					                                   f32_4 %218 = OpVectorShuffle %217 %216 4 5 2 3 
					                                                  OpStore %55 %218 
					                     read_only Texture2D %219 = OpLoad %42 
					                                 sampler %220 = OpLoad %46 
					              read_only Texture2DSampled %221 = OpSampledImage %219 %220 
					                                   f32_4 %222 = OpLoad %55 
					                                   f32_2 %223 = OpVectorShuffle %222 %222 0 1 
					                                   f32_4 %224 = OpImageSampleImplicitLod %221 %223 
					                                   f32_3 %225 = OpVectorShuffle %224 %224 0 1 2 
					                                   f32_4 %226 = OpLoad %55 
					                                   f32_4 %227 = OpVectorShuffle %226 %225 4 5 6 3 
					                                                  OpStore %55 %227 
					                                   f32_4 %228 = OpLoad %182 
					                            Uniform f32* %229 = OpAccessChain %30 %32 
					                                     f32 %230 = OpLoad %229 
					                                   f32_4 %231 = OpCompositeConstruct %230 %230 %230 %230 
					                                   f32_4 %232 = OpFMul %228 %231 
					                                                  OpStore %73 %232 
					                                   f32_4 %233 = OpLoad %100 
					                            Uniform f32* %234 = OpAccessChain %30 %32 
					                                     f32 %235 = OpLoad %234 
					                                   f32_4 %236 = OpCompositeConstruct %235 %235 %235 %235 
					                                   f32_4 %237 = OpFMul %233 %236 
					                                                  OpStore %100 %237 
					                     read_only Texture2D %238 = OpLoad %42 
					                                 sampler %239 = OpLoad %46 
					              read_only Texture2DSampled %240 = OpSampledImage %238 %239 
					                                   f32_4 %241 = OpLoad %100 
					                                   f32_2 %242 = OpVectorShuffle %241 %241 0 1 
					                                   f32_4 %243 = OpImageSampleImplicitLod %240 %242 
					                                   f32_3 %244 = OpVectorShuffle %243 %243 0 1 2 
					                                   f32_4 %245 = OpLoad %182 
					                                   f32_4 %246 = OpVectorShuffle %245 %244 4 5 6 3 
					                                                  OpStore %182 %246 
					                     read_only Texture2D %247 = OpLoad %42 
					                                 sampler %248 = OpLoad %46 
					              read_only Texture2DSampled %249 = OpSampledImage %247 %248 
					                                   f32_4 %250 = OpLoad %100 
					                                   f32_2 %251 = OpVectorShuffle %250 %250 2 3 
					                                   f32_4 %252 = OpImageSampleImplicitLod %249 %251 
					                                   f32_3 %253 = OpVectorShuffle %252 %252 0 1 2 
					                                   f32_4 %254 = OpLoad %100 
					                                   f32_4 %255 = OpVectorShuffle %254 %253 4 5 6 3 
					                                                  OpStore %100 %255 
					                                   f32_4 %256 = OpLoad %182 
					                                   f32_3 %257 = OpVectorShuffle %256 %256 0 1 2 
					                                   f32_3 %258 = OpFMul %257 %122 
					                                   f32_4 %259 = OpLoad %81 
					                                   f32_3 %260 = OpVectorShuffle %259 %259 0 1 2 
					                                   f32_3 %261 = OpFAdd %258 %260 
					                                   f32_4 %262 = OpLoad %81 
					                                   f32_4 %263 = OpVectorShuffle %262 %261 4 5 6 3 
					                                                  OpStore %81 %263 
					                                   f32_3 %264 = OpLoad %9 
					                                   f32_3 %267 = OpFMul %264 %266 
					                                   f32_4 %268 = OpLoad %81 
					                                   f32_3 %269 = OpVectorShuffle %268 %268 0 1 2 
					                                   f32_3 %270 = OpFAdd %267 %269 
					                                                  OpStore %9 %270 
					                                   f32_4 %271 = OpLoad %100 
					                                   f32_3 %272 = OpVectorShuffle %271 %271 0 1 2 
					                                   f32_3 %273 = OpFMul %272 %122 
					                                   f32_3 %274 = OpLoad %9 
					                                   f32_3 %275 = OpFAdd %273 %274 
					                                                  OpStore %9 %275 
					                     read_only Texture2D %276 = OpLoad %42 
					                                 sampler %277 = OpLoad %46 
					              read_only Texture2DSampled %278 = OpSampledImage %276 %277 
					                                   f32_4 %279 = OpLoad %73 
					                                   f32_2 %280 = OpVectorShuffle %279 %279 0 1 
					                                   f32_4 %281 = OpImageSampleImplicitLod %278 %280 
					                                   f32_3 %282 = OpVectorShuffle %281 %281 0 1 2 
					                                   f32_4 %283 = OpLoad %81 
					                                   f32_4 %284 = OpVectorShuffle %283 %282 4 5 6 3 
					                                                  OpStore %81 %284 
					                     read_only Texture2D %285 = OpLoad %42 
					                                 sampler %286 = OpLoad %46 
					              read_only Texture2DSampled %287 = OpSampledImage %285 %286 
					                                   f32_4 %288 = OpLoad %73 
					                                   f32_2 %289 = OpVectorShuffle %288 %288 2 3 
					                                   f32_4 %290 = OpImageSampleImplicitLod %287 %289 
					                                   f32_3 %291 = OpVectorShuffle %290 %290 0 1 2 
					                                   f32_4 %292 = OpLoad %73 
					                                   f32_4 %293 = OpVectorShuffle %292 %291 4 5 6 3 
					                                                  OpStore %73 %293 
					                                   f32_3 %294 = OpLoad %9 
					                                   f32_4 %295 = OpLoad %81 
					                                   f32_3 %296 = OpVectorShuffle %295 %295 0 1 2 
					                                   f32_3 %297 = OpFAdd %294 %296 
					                                                  OpStore %9 %297 
					                                   f32_4 %298 = OpLoad %73 
					                                   f32_3 %299 = OpVectorShuffle %298 %298 0 1 2 
					                                   f32_3 %300 = OpFMul %299 %122 
					                                   f32_3 %301 = OpLoad %9 
					                                   f32_3 %302 = OpFAdd %300 %301 
					                                                  OpStore %9 %302 
					                                   f32_4 %303 = OpLoad %55 
					                                   f32_3 %304 = OpVectorShuffle %303 %303 0 1 2 
					                                   f32_3 %305 = OpLoad %9 
					                                   f32_3 %306 = OpFAdd %304 %305 
					                                                  OpStore %9 %306 
					                                   f32_3 %307 = OpLoad %9 
					                                   f32_3 %310 = OpFMul %307 %309 
					                                                  OpStore %9 %310 
					                                   f32_3 %311 = OpLoad %9 
					                          Uniform f32_4* %313 = OpAccessChain %30 %312 
					                                   f32_4 %314 = OpLoad %313 
					                                   f32_3 %315 = OpVectorShuffle %314 %314 3 3 3 
					                                   f32_3 %316 = OpFMul %311 %315 
					                                                  OpStore %9 %316 
					                                   f32_3 %319 = OpLoad %9 
					                          Uniform f32_4* %320 = OpAccessChain %30 %312 
					                                   f32_4 %321 = OpLoad %320 
					                                   f32_3 %322 = OpVectorShuffle %321 %321 0 1 2 
					                                   f32_3 %323 = OpFMul %319 %322 
					                                   f32_4 %324 = OpLoad %318 
					                                   f32_4 %325 = OpVectorShuffle %324 %323 4 5 6 3 
					                                                  OpStore %318 %325 
					                             Output f32* %327 = OpAccessChain %318 %76 
					                                                  OpStore %327 %19 
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
						float _SampleScale;
						vec4 _ColorIntensity;
						vec4 unused_0_6[2];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.x = 1.0;
					    u_xlat1.z = _SampleScale;
					    u_xlat1 = u_xlat1.xxzz * _MainTex_TexelSize.xyxy;
					    u_xlat2.z = float(-1.0);
					    u_xlat2.w = float(0.0);
					    u_xlat2.x = _SampleScale;
					    u_xlat3 = (-u_xlat1.xywy) * u_xlat2.xxwx + vs_TEXCOORD0.xyxy;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
					    u_xlat4 = texture(_MainTex, u_xlat3.xy);
					    u_xlat3 = texture(_MainTex, u_xlat3.zw);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat4.xyz;
					    u_xlat4.xy = (-u_xlat1.zy) * u_xlat2.zx + vs_TEXCOORD0.xy;
					    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat4.xyz;
					    u_xlat4 = u_xlat1.zwxw * u_xlat2.zwxw + vs_TEXCOORD0.xyxy;
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat5 = u_xlat1.zywy * u_xlat2.zxwx + vs_TEXCOORD0.xyxy;
					    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * u_xlat2.xx + vs_TEXCOORD0.xy;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = u_xlat5 * vec4(_RenderViewportScaleFactor);
					    u_xlat4 = u_xlat4 * vec4(_RenderViewportScaleFactor);
					    u_xlat5 = texture(_MainTex, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, u_xlat4.zw);
					    u_xlat3.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(4.0, 4.0, 4.0) + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat2 = texture(_MainTex, u_xlat2.zw);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.0625, 0.0625, 0.0625);
					    u_xlat0.xyz = u_xlat0.xyz * _ColorIntensity.www;
					    SV_Target0.xyz = u_xlat0.xyz * _ColorIntensity.xyz;
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
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 586610
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
					uniform 	float _RenderViewportScaleFactor;
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	float _SampleScale;
					uniform 	vec4 _ColorIntensity;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-1.0, -1.0, 1.0, 1.0);
					    u_xlat1.x = _SampleScale * 0.5;
					    u_xlat2 = u_xlat0.xyzy * u_xlat1.xxxx + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat0 = u_xlat0.xwzw * u_xlat1.xxxx + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.25, 0.25, 0.25);
					    u_xlat0.xyz = u_xlat0.xyz * _ColorIntensity.www;
					    SV_Target0.xyz = u_xlat0.xyz * _ColorIntensity.xyz;
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
					; Bound: 169
					; Schema: 0
					                                                  OpCapability Shader 
					                                           %1 = OpExtInstImport "GLSL.std.450" 
					                                                  OpMemoryModel Logical GLSL450 
					                                                  OpEntryPoint Fragment %4 "main" %42 %156 
					                                                  OpExecutionMode %4 OriginUpperLeft 
					                                                  OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                  OpMemberDecorate %10 0 Offset 10 
					                                                  OpMemberDecorate %10 1 Offset 10 
					                                                  OpMemberDecorate %10 2 Offset 10 
					                                                  OpMemberDecorate %10 3 Offset 10 
					                                                  OpDecorate %10 Block 
					                                                  OpDecorate %12 DescriptorSet 12 
					                                                  OpDecorate %12 Binding 12 
					                                                  OpDecorate vs_TEXCOORD0 Location 42 
					                                                  OpDecorate %76 DescriptorSet 76 
					                                                  OpDecorate %76 Binding 76 
					                                                  OpDecorate %80 DescriptorSet 80 
					                                                  OpDecorate %80 Binding 80 
					                                                  OpDecorate %156 Location 156 
					                                           %2 = OpTypeVoid 
					                                           %3 = OpTypeFunction %2 
					                                           %6 = OpTypeFloat 32 
					                                           %7 = OpTypeVector %6 4 
					                                           %8 = OpTypePointer Private %7 
					                            Private f32_4* %9 = OpVariable Private 
					                                          %10 = OpTypeStruct %6 %7 %6 %7 
					                                          %11 = OpTypePointer Uniform %10 
					Uniform struct {f32; f32_4; f32; f32_4;}* %12 = OpVariable Uniform 
					                                          %13 = OpTypeInt 32 1 
					                                      i32 %14 = OpConstant 1 
					                                          %15 = OpTypePointer Uniform %7 
					                                      f32 %19 = OpConstant 3,674022E-40 
					                                      f32 %20 = OpConstant 3,674022E-40 
					                                    f32_4 %21 = OpConstantComposite %19 %19 %20 %20 
					                           Private f32_4* %23 = OpVariable Private 
					                                      i32 %24 = OpConstant 2 
					                                          %25 = OpTypePointer Uniform %6 
					                                      f32 %28 = OpConstant 3,674022E-40 
					                                          %30 = OpTypeInt 32 0 
					                                      u32 %31 = OpConstant 0 
					                                          %32 = OpTypePointer Private %6 
					                           Private f32_4* %34 = OpVariable Private 
					                                          %40 = OpTypeVector %6 2 
					                                          %41 = OpTypePointer Input %40 
					                    Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                      f32 %47 = OpConstant 3,674022E-40 
					                                      i32 %64 = OpConstant 0 
					                                          %74 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                          %75 = OpTypePointer UniformConstant %74 
					     UniformConstant read_only Texture2D* %76 = OpVariable UniformConstant 
					                                          %78 = OpTypeSampler 
					                                          %79 = OpTypePointer UniformConstant %78 
					                 UniformConstant sampler* %80 = OpVariable UniformConstant 
					                                          %82 = OpTypeSampledImage %74 
					                                          %87 = OpTypeVector %6 3 
					                                     f32 %141 = OpConstant 3,674022E-40 
					                                   f32_3 %142 = OpConstantComposite %141 %141 %141 
					                                     i32 %148 = OpConstant 3 
					                                         %155 = OpTypePointer Output %7 
					                           Output f32_4* %156 = OpVariable Output 
					                                     u32 %165 = OpConstant 3 
					                                         %166 = OpTypePointer Output %6 
					                                      void %4 = OpFunction None %3 
					                                           %5 = OpLabel 
					                           Uniform f32_4* %16 = OpAccessChain %12 %14 
					                                    f32_4 %17 = OpLoad %16 
					                                    f32_4 %18 = OpVectorShuffle %17 %17 0 1 0 1 
					                                    f32_4 %22 = OpFMul %18 %21 
					                                                  OpStore %9 %22 
					                             Uniform f32* %26 = OpAccessChain %12 %24 
					                                      f32 %27 = OpLoad %26 
					                                      f32 %29 = OpFMul %27 %28 
					                             Private f32* %33 = OpAccessChain %23 %31 
					                                                  OpStore %33 %29 
					                                    f32_4 %35 = OpLoad %9 
					                                    f32_4 %36 = OpVectorShuffle %35 %35 0 1 2 1 
					                                    f32_4 %37 = OpLoad %23 
					                                    f32_4 %38 = OpVectorShuffle %37 %37 0 0 0 0 
					                                    f32_4 %39 = OpFMul %36 %38 
					                                    f32_2 %43 = OpLoad vs_TEXCOORD0 
					                                    f32_4 %44 = OpVectorShuffle %43 %43 0 1 0 1 
					                                    f32_4 %45 = OpFAdd %39 %44 
					                                                  OpStore %34 %45 
					                                    f32_4 %46 = OpLoad %34 
					                                    f32_4 %48 = OpCompositeConstruct %47 %47 %47 %47 
					                                    f32_4 %49 = OpCompositeConstruct %20 %20 %20 %20 
					                                    f32_4 %50 = OpExtInst %1 43 %46 %48 %49 
					                                                  OpStore %34 %50 
					                                    f32_4 %51 = OpLoad %9 
					                                    f32_4 %52 = OpVectorShuffle %51 %51 0 3 2 3 
					                                    f32_4 %53 = OpLoad %23 
					                                    f32_4 %54 = OpVectorShuffle %53 %53 0 0 0 0 
					                                    f32_4 %55 = OpFMul %52 %54 
					                                    f32_2 %56 = OpLoad vs_TEXCOORD0 
					                                    f32_4 %57 = OpVectorShuffle %56 %56 0 1 0 1 
					                                    f32_4 %58 = OpFAdd %55 %57 
					                                                  OpStore %9 %58 
					                                    f32_4 %59 = OpLoad %9 
					                                    f32_4 %60 = OpCompositeConstruct %47 %47 %47 %47 
					                                    f32_4 %61 = OpCompositeConstruct %20 %20 %20 %20 
					                                    f32_4 %62 = OpExtInst %1 43 %59 %60 %61 
					                                                  OpStore %9 %62 
					                                    f32_4 %63 = OpLoad %9 
					                             Uniform f32* %65 = OpAccessChain %12 %64 
					                                      f32 %66 = OpLoad %65 
					                                    f32_4 %67 = OpCompositeConstruct %66 %66 %66 %66 
					                                    f32_4 %68 = OpFMul %63 %67 
					                                                  OpStore %9 %68 
					                                    f32_4 %69 = OpLoad %34 
					                             Uniform f32* %70 = OpAccessChain %12 %64 
					                                      f32 %71 = OpLoad %70 
					                                    f32_4 %72 = OpCompositeConstruct %71 %71 %71 %71 
					                                    f32_4 %73 = OpFMul %69 %72 
					                                                  OpStore %23 %73 
					                      read_only Texture2D %77 = OpLoad %76 
					                                  sampler %81 = OpLoad %80 
					               read_only Texture2DSampled %83 = OpSampledImage %77 %81 
					                                    f32_4 %84 = OpLoad %23 
					                                    f32_2 %85 = OpVectorShuffle %84 %84 0 1 
					                                    f32_4 %86 = OpImageSampleImplicitLod %83 %85 
					                                    f32_3 %88 = OpVectorShuffle %86 %86 0 1 2 
					                                    f32_4 %89 = OpLoad %34 
					                                    f32_4 %90 = OpVectorShuffle %89 %88 4 5 6 3 
					                                                  OpStore %34 %90 
					                      read_only Texture2D %91 = OpLoad %76 
					                                  sampler %92 = OpLoad %80 
					               read_only Texture2DSampled %93 = OpSampledImage %91 %92 
					                                    f32_4 %94 = OpLoad %23 
					                                    f32_2 %95 = OpVectorShuffle %94 %94 2 3 
					                                    f32_4 %96 = OpImageSampleImplicitLod %93 %95 
					                                    f32_3 %97 = OpVectorShuffle %96 %96 0 1 2 
					                                    f32_4 %98 = OpLoad %23 
					                                    f32_4 %99 = OpVectorShuffle %98 %97 4 5 6 3 
					                                                  OpStore %23 %99 
					                                   f32_4 %100 = OpLoad %23 
					                                   f32_3 %101 = OpVectorShuffle %100 %100 0 1 2 
					                                   f32_4 %102 = OpLoad %34 
					                                   f32_3 %103 = OpVectorShuffle %102 %102 0 1 2 
					                                   f32_3 %104 = OpFAdd %101 %103 
					                                   f32_4 %105 = OpLoad %23 
					                                   f32_4 %106 = OpVectorShuffle %105 %104 4 5 6 3 
					                                                  OpStore %23 %106 
					                     read_only Texture2D %107 = OpLoad %76 
					                                 sampler %108 = OpLoad %80 
					              read_only Texture2DSampled %109 = OpSampledImage %107 %108 
					                                   f32_4 %110 = OpLoad %9 
					                                   f32_2 %111 = OpVectorShuffle %110 %110 0 1 
					                                   f32_4 %112 = OpImageSampleImplicitLod %109 %111 
					                                   f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
					                                   f32_4 %114 = OpLoad %34 
					                                   f32_4 %115 = OpVectorShuffle %114 %113 4 5 6 3 
					                                                  OpStore %34 %115 
					                     read_only Texture2D %116 = OpLoad %76 
					                                 sampler %117 = OpLoad %80 
					              read_only Texture2DSampled %118 = OpSampledImage %116 %117 
					                                   f32_4 %119 = OpLoad %9 
					                                   f32_2 %120 = OpVectorShuffle %119 %119 2 3 
					                                   f32_4 %121 = OpImageSampleImplicitLod %118 %120 
					                                   f32_3 %122 = OpVectorShuffle %121 %121 0 1 2 
					                                   f32_4 %123 = OpLoad %9 
					                                   f32_4 %124 = OpVectorShuffle %123 %122 4 5 6 3 
					                                                  OpStore %9 %124 
					                                   f32_4 %125 = OpLoad %23 
					                                   f32_3 %126 = OpVectorShuffle %125 %125 0 1 2 
					                                   f32_4 %127 = OpLoad %34 
					                                   f32_3 %128 = OpVectorShuffle %127 %127 0 1 2 
					                                   f32_3 %129 = OpFAdd %126 %128 
					                                   f32_4 %130 = OpLoad %23 
					                                   f32_4 %131 = OpVectorShuffle %130 %129 4 5 6 3 
					                                                  OpStore %23 %131 
					                                   f32_4 %132 = OpLoad %9 
					                                   f32_3 %133 = OpVectorShuffle %132 %132 0 1 2 
					                                   f32_4 %134 = OpLoad %23 
					                                   f32_3 %135 = OpVectorShuffle %134 %134 0 1 2 
					                                   f32_3 %136 = OpFAdd %133 %135 
					                                   f32_4 %137 = OpLoad %9 
					                                   f32_4 %138 = OpVectorShuffle %137 %136 4 5 6 3 
					                                                  OpStore %9 %138 
					                                   f32_4 %139 = OpLoad %9 
					                                   f32_3 %140 = OpVectorShuffle %139 %139 0 1 2 
					                                   f32_3 %143 = OpFMul %140 %142 
					                                   f32_4 %144 = OpLoad %9 
					                                   f32_4 %145 = OpVectorShuffle %144 %143 4 5 6 3 
					                                                  OpStore %9 %145 
					                                   f32_4 %146 = OpLoad %9 
					                                   f32_3 %147 = OpVectorShuffle %146 %146 0 1 2 
					                          Uniform f32_4* %149 = OpAccessChain %12 %148 
					                                   f32_4 %150 = OpLoad %149 
					                                   f32_3 %151 = OpVectorShuffle %150 %150 3 3 3 
					                                   f32_3 %152 = OpFMul %147 %151 
					                                   f32_4 %153 = OpLoad %9 
					                                   f32_4 %154 = OpVectorShuffle %153 %152 4 5 6 3 
					                                                  OpStore %9 %154 
					                                   f32_4 %157 = OpLoad %9 
					                                   f32_3 %158 = OpVectorShuffle %157 %157 0 1 2 
					                          Uniform f32_4* %159 = OpAccessChain %12 %148 
					                                   f32_4 %160 = OpLoad %159 
					                                   f32_3 %161 = OpVectorShuffle %160 %160 0 1 2 
					                                   f32_3 %162 = OpFMul %158 %161 
					                                   f32_4 %163 = OpLoad %156 
					                                   f32_4 %164 = OpVectorShuffle %163 %162 4 5 6 3 
					                                                  OpStore %156 %164 
					                             Output f32* %167 = OpAccessChain %156 %165 
					                                                  OpStore %167 %20 
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
						float _SampleScale;
						vec4 _ColorIntensity;
						vec4 unused_0_6[2];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-1.0, -1.0, 1.0, 1.0);
					    u_xlat1.x = _SampleScale * 0.5;
					    u_xlat2 = u_xlat0.xyzy * u_xlat1.xxxx + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat0 = u_xlat0.xwzw * u_xlat1.xxxx + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.25, 0.25, 0.25);
					    u_xlat0.xyz = u_xlat0.xyz * _ColorIntensity.www;
					    SV_Target0.xyz = u_xlat0.xyz * _ColorIntensity.xyz;
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