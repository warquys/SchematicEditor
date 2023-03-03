Shader "Hidden/PostProcessing/TemporalAntialiasing" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 62476
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
					uniform 	vec4 _CameraDepthTexture_TexelSize;
					uniform 	vec2 _Jitter;
					uniform 	vec4 _FinalBlendParameters;
					uniform 	float _Sharpness;
					UNITY_LOCATION(0) uniform  sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform  sampler2D _CameraMotionVectorsTexture;
					UNITY_LOCATION(2) uniform  sampler2D _MainTex;
					UNITY_LOCATION(3) uniform  sampler2D _HistoryTex;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec2 u_xlat14;
					bool u_xlatb14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xy + (-_CameraDepthTexture_TexelSize.xy);
					    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.xy = min(u_xlat0.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat0 = texture(_CameraDepthTexture, u_xlat0.xy).yzxw;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).yzxw;
					    u_xlatb21 = u_xlat0.z>=u_xlat1.z;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.x = float(-1.0);
					    u_xlat0.y = float(-1.0);
					    u_xlat1.x = float(0.0);
					    u_xlat1.y = float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.yyz);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = float(1.0);
					    u_xlat1.y = float(-1.0);
					    u_xlat2 = _CameraDepthTexture_TexelSize.xyxy * vec4(1.0, -1.0, -1.0, 1.0) + vs_TEXCOORD1.xyxy;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = min(u_xlat2, vec4(_RenderViewportScaleFactor));
					    u_xlat3 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat2.zw).yzxw;
					    u_xlat1.z = u_xlat3.x;
					    u_xlatb21 = u_xlat3.x>=u_xlat0.z;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat1.xyz = (-u_xlat0.yyz) + u_xlat1.xyz;
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat2.x = float(-1.0);
					    u_xlat2.y = float(1.0);
					    u_xlatb21 = u_xlat2.z>=u_xlat0.z;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy + _CameraDepthTexture_TexelSize.xy;
					    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
					    u_xlat1.xy = min(u_xlat1.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat1.xy);
					    u_xlatb14 = u_xlat1.x>=u_xlat0.z;
					    u_xlat14.x = u_xlatb14 ? 1.0 : float(0.0);
					    u_xlat1.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat14.xx * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * _CameraDepthTexture_TexelSize.xy + vs_TEXCOORD1.xy;
					    u_xlat0 = texture(_CameraMotionVectorsTexture, u_xlat0.xy);
					    u_xlat14.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = (-u_xlat0.xy) + vs_TEXCOORD1.xy;
					    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.xy = min(u_xlat0.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat1 = texture(_HistoryTex, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat14.x);
					    u_xlat7.x = u_xlat0.x * 100.0;
					    u_xlat0.x = u_xlat0.x * _FinalBlendParameters.z;
					    u_xlat7.x = min(u_xlat7.x, 1.0);
					    u_xlat7.x = u_xlat7.x * -3.75 + 4.0;
					    u_xlat14.xy = vs_TEXCOORD1.xy + (-_Jitter.xy);
					    u_xlat14.xy = max(u_xlat14.xy, vec2(0.0, 0.0));
					    u_xlat14.xy = min(u_xlat14.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat2.xy = (-_MainTex_TexelSize.xy) * vec2(0.5, 0.5) + u_xlat14.xy;
					    u_xlat2.xy = max(u_xlat2.xy, vec2(0.0, 0.0));
					    u_xlat2.xy = min(u_xlat2.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(0.5, 0.5) + u_xlat14.xy;
					    u_xlat4 = texture(_MainTex, u_xlat14.xy);
					    u_xlat14.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat14.xy = min(u_xlat14.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat3 = texture(_MainTex, u_xlat14.xy);
					    u_xlat5 = u_xlat2 + u_xlat3;
					    u_xlat6 = u_xlat4 + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(4.0, 4.0, 4.0, 4.0) + (-u_xlat6);
					    u_xlat6 = (-u_xlat5) * vec4(0.166666999, 0.166666999, 0.166666999, 0.166666999) + u_xlat4;
					    u_xlat6 = u_xlat6 * vec4(_Sharpness);
					    u_xlat4 = u_xlat6 * vec4(2.71828198, 2.71828198, 2.71828198, 2.71828198) + u_xlat4;
					    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat4 = min(u_xlat4, vec4(65472.0, 65472.0, 65472.0, 65472.0));
					    u_xlat5.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.142857, 0.142857, 0.142857);
					    u_xlat14.x = dot(u_xlat5.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat21 = dot(u_xlat4.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat14.x = (-u_xlat21) + u_xlat14.x;
					    u_xlat5.xyz = min(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat2.xyz = max(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat2.xyz = u_xlat7.xxx * abs(u_xlat14.xxx) + u_xlat2.xyz;
					    u_xlat7.xyz = (-u_xlat7.xxx) * abs(u_xlat14.xxx) + u_xlat5.xyz;
					    u_xlat3.xyz = (-u_xlat7.xyz) + u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat7.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat3.xyz = (-u_xlat7.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat7.xyz = u_xlat7.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat5.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat5.xyz;
					    u_xlat2.x = min(abs(u_xlat2.y), abs(u_xlat2.x));
					    u_xlat2.x = min(abs(u_xlat2.z), u_xlat2.x);
					    u_xlat2.x = min(u_xlat2.x, 1.0);
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat7.xyz;
					    u_xlat1 = (-u_xlat4) + u_xlat1;
					    u_xlat7.x = (-_FinalBlendParameters.x) + _FinalBlendParameters.y;
					    u_xlat0.x = u_xlat0.x * u_xlat7.x + _FinalBlendParameters.x;
					    u_xlat0.x = max(u_xlat0.x, _FinalBlendParameters.y);
					    u_xlat0.x = min(u_xlat0.x, _FinalBlendParameters.x);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat4;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = min(u_xlat0, vec4(65472.0, 65472.0, 65472.0, 65472.0));
					    SV_Target0 = u_xlat0;
					    SV_Target1 = u_xlat0;
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
					; Bound: 630
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %12 %625 %627 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate vs_TEXCOORD1 Location 12 
					                                                      OpMemberDecorate %14 0 Offset 14 
					                                                      OpMemberDecorate %14 1 Offset 14 
					                                                      OpMemberDecorate %14 2 Offset 14 
					                                                      OpMemberDecorate %14 3 Offset 14 
					                                                      OpMemberDecorate %14 4 Offset 14 
					                                                      OpMemberDecorate %14 5 Offset 14 
					                                                      OpDecorate %14 Block 
					                                                      OpDecorate %16 DescriptorSet 16 
					                                                      OpDecorate %16 Binding 16 
					                                                      OpDecorate %46 DescriptorSet 46 
					                                                      OpDecorate %46 Binding 46 
					                                                      OpDecorate %50 DescriptorSet 50 
					                                                      OpDecorate %50 Binding 50 
					                                                      OpDecorate %259 DescriptorSet 259 
					                                                      OpDecorate %259 Binding 259 
					                                                      OpDecorate %261 DescriptorSet 261 
					                                                      OpDecorate %261 Binding 261 
					                                                      OpDecorate %296 DescriptorSet 296 
					                                                      OpDecorate %296 Binding 296 
					                                                      OpDecorate %298 DescriptorSet 298 
					                                                      OpDecorate %298 Binding 298 
					                                                      OpDecorate %372 DescriptorSet 372 
					                                                      OpDecorate %372 Binding 372 
					                                                      OpDecorate %374 DescriptorSet 374 
					                                                      OpDecorate %374 Binding 374 
					                                                      OpDecorate %625 Location 625 
					                                                      OpDecorate %627 Location 627 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 2 
					                                              %11 = OpTypePointer Input %10 
					                        Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                              %14 = OpTypeStruct %6 %7 %7 %10 %7 %6 
					                                              %15 = OpTypePointer Uniform %14 
					Uniform struct {f32; f32_4; f32_4; f32_2; f32_4; f32;}* %16 = OpVariable Uniform 
					                                              %17 = OpTypeInt 32 1 
					                                          i32 %18 = OpConstant 2 
					                                              %19 = OpTypePointer Uniform %7 
					                                          f32 %29 = OpConstant 3,674022E-40 
					                                        f32_2 %30 = OpConstantComposite %29 %29 
					                                          i32 %36 = OpConstant 0 
					                                              %37 = OpTypePointer Uniform %6 
					                                              %44 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %45 = OpTypePointer UniformConstant %44 
					         UniformConstant read_only Texture2D* %46 = OpVariable UniformConstant 
					                                              %48 = OpTypeSampler 
					                                              %49 = OpTypePointer UniformConstant %48 
					                     UniformConstant sampler* %50 = OpVariable UniformConstant 
					                                              %52 = OpTypeSampledImage %44 
					                                              %57 = OpTypeInt 32 0 
					                                          u32 %58 = OpConstant 0 
					                                          u32 %60 = OpConstant 2 
					                                              %61 = OpTypePointer Private %6 
					                               Private f32_4* %63 = OpVariable Private 
					                                              %71 = OpTypeBool 
					                                              %72 = OpTypePointer Private %71 
					                                Private bool* %73 = OpVariable Private 
					                                 Private f32* %79 = OpVariable Private 
					                                          f32 %81 = OpConstant 3,674022E-40 
					                                          f32 %83 = OpConstant 3,674022E-40 
					                                          u32 %85 = OpConstant 1 
					                                              %89 = OpTypeVector %6 3 
					                              Private f32_4* %110 = OpVariable Private 
					                                       f32_4 %114 = OpConstantComposite %81 %83 %83 %81 
					                                       f32_4 %120 = OpConstantComposite %29 %29 %29 %29 
					                               Private bool* %222 = OpVariable Private 
					                                             %227 = OpTypePointer Private %10 
					                              Private f32_2* %228 = OpVariable Private 
					                                       f32_2 %235 = OpConstantComposite %81 %81 
					        UniformConstant read_only Texture2D* %259 = OpVariable UniformConstant 
					                    UniformConstant sampler* %261 = OpVariable UniformConstant 
					        UniformConstant read_only Texture2D* %296 = OpVariable UniformConstant 
					                    UniformConstant sampler* %298 = OpVariable UniformConstant 
					                                             %308 = OpTypePointer Private %89 
					                              Private f32_3* %309 = OpVariable Private 
					                                         f32 %312 = OpConstant 3,674022E-40 
					                                         i32 %317 = OpConstant 4 
					                                         f32 %328 = OpConstant 3,674022E-40 
					                                         f32 %330 = OpConstant 3,674022E-40 
					                                         i32 %334 = OpConstant 3 
					                                             %335 = OpTypePointer Uniform %10 
					                                         i32 %347 = OpConstant 1 
					                                         f32 %352 = OpConstant 3,674022E-40 
					                                       f32_2 %353 = OpConstantComposite %352 %352 
					        UniformConstant read_only Texture2D* %372 = OpVariable UniformConstant 
					                    UniformConstant sampler* %374 = OpVariable UniformConstant 
					                              Private f32_4* %380 = OpVariable Private 
					                              Private f32_4* %389 = OpVariable Private 
					                              Private f32_4* %408 = OpVariable Private 
					                              Private f32_4* %412 = OpVariable Private 
					                                       f32_4 %417 = OpConstantComposite %330 %330 %330 %330 
					                                         f32 %424 = OpConstant 3,674022E-40 
					                                       f32_4 %425 = OpConstantComposite %424 %424 %424 %424 
					                                         i32 %430 = OpConstant 5 
					                                         f32 %436 = OpConstant 3,674022E-40 
					                                       f32_4 %437 = OpConstantComposite %436 %436 %436 %436 
					                                         f32 %444 = OpConstant 3,674022E-40 
					                                       f32_4 %445 = OpConstantComposite %444 %444 %444 %444 
					                                         f32 %456 = OpConstant 3,674022E-40 
					                                       f32_3 %457 = OpConstantComposite %456 %456 %456 
					                                         f32 %463 = OpConstant 3,674022E-40 
					                                         f32 %464 = OpConstant 3,674022E-40 
					                                         f32 %465 = OpConstant 3,674022E-40 
					                                       f32_3 %466 = OpConstantComposite %463 %464 %465 
					                                       f32_3 %526 = OpConstantComposite %352 %352 %352 
					                                         f32 %542 = OpConstant 3,674022E-40 
					                                       f32_3 %543 = OpConstantComposite %542 %542 %542 
					                                             %624 = OpTypePointer Output %7 
					                               Output f32_4* %625 = OpVariable Output 
					                               Output f32_4* %627 = OpVariable Output 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_2 %13 = OpLoad vs_TEXCOORD1 
					                               Uniform f32_4* %20 = OpAccessChain %16 %18 
					                                        f32_4 %21 = OpLoad %20 
					                                        f32_2 %22 = OpVectorShuffle %21 %21 0 1 
					                                        f32_2 %23 = OpFNegate %22 
					                                        f32_2 %24 = OpFAdd %13 %23 
					                                        f32_4 %25 = OpLoad %9 
					                                        f32_4 %26 = OpVectorShuffle %25 %24 4 5 2 3 
					                                                      OpStore %9 %26 
					                                        f32_4 %27 = OpLoad %9 
					                                        f32_2 %28 = OpVectorShuffle %27 %27 0 1 
					                                        f32_2 %31 = OpExtInst %1 40 %28 %30 
					                                        f32_4 %32 = OpLoad %9 
					                                        f32_4 %33 = OpVectorShuffle %32 %31 4 5 2 3 
					                                                      OpStore %9 %33 
					                                        f32_4 %34 = OpLoad %9 
					                                        f32_2 %35 = OpVectorShuffle %34 %34 0 1 
					                                 Uniform f32* %38 = OpAccessChain %16 %36 
					                                          f32 %39 = OpLoad %38 
					                                        f32_2 %40 = OpCompositeConstruct %39 %39 
					                                        f32_2 %41 = OpExtInst %1 37 %35 %40 
					                                        f32_4 %42 = OpLoad %9 
					                                        f32_4 %43 = OpVectorShuffle %42 %41 4 5 2 3 
					                                                      OpStore %9 %43 
					                          read_only Texture2D %47 = OpLoad %46 
					                                      sampler %51 = OpLoad %50 
					                   read_only Texture2DSampled %53 = OpSampledImage %47 %51 
					                                        f32_4 %54 = OpLoad %9 
					                                        f32_2 %55 = OpVectorShuffle %54 %54 0 1 
					                                        f32_4 %56 = OpImageSampleImplicitLod %53 %55 
					                                          f32 %59 = OpCompositeExtract %56 0 
					                                 Private f32* %62 = OpAccessChain %9 %60 
					                                                      OpStore %62 %59 
					                          read_only Texture2D %64 = OpLoad %46 
					                                      sampler %65 = OpLoad %50 
					                   read_only Texture2DSampled %66 = OpSampledImage %64 %65 
					                                        f32_2 %67 = OpLoad vs_TEXCOORD1 
					                                        f32_4 %68 = OpImageSampleImplicitLod %66 %67 
					                                          f32 %69 = OpCompositeExtract %68 0 
					                                 Private f32* %70 = OpAccessChain %63 %60 
					                                                      OpStore %70 %69 
					                                 Private f32* %74 = OpAccessChain %9 %60 
					                                          f32 %75 = OpLoad %74 
					                                 Private f32* %76 = OpAccessChain %63 %60 
					                                          f32 %77 = OpLoad %76 
					                                         bool %78 = OpFOrdGreaterThanEqual %75 %77 
					                                                      OpStore %73 %78 
					                                         bool %80 = OpLoad %73 
					                                          f32 %82 = OpSelect %80 %81 %29 
					                                                      OpStore %79 %82 
					                                 Private f32* %84 = OpAccessChain %9 %58 
					                                                      OpStore %84 %83 
					                                 Private f32* %86 = OpAccessChain %9 %85 
					                                                      OpStore %86 %83 
					                                 Private f32* %87 = OpAccessChain %63 %58 
					                                                      OpStore %87 %29 
					                                 Private f32* %88 = OpAccessChain %63 %85 
					                                                      OpStore %88 %29 
					                                        f32_4 %90 = OpLoad %9 
					                                        f32_3 %91 = OpVectorShuffle %90 %90 0 1 2 
					                                        f32_4 %92 = OpLoad %63 
					                                        f32_3 %93 = OpVectorShuffle %92 %92 1 1 2 
					                                        f32_3 %94 = OpFNegate %93 
					                                        f32_3 %95 = OpFAdd %91 %94 
					                                        f32_4 %96 = OpLoad %9 
					                                        f32_4 %97 = OpVectorShuffle %96 %95 4 5 6 3 
					                                                      OpStore %9 %97 
					                                          f32 %98 = OpLoad %79 
					                                        f32_3 %99 = OpCompositeConstruct %98 %98 %98 
					                                       f32_4 %100 = OpLoad %9 
					                                       f32_3 %101 = OpVectorShuffle %100 %100 0 1 2 
					                                       f32_3 %102 = OpFMul %99 %101 
					                                       f32_4 %103 = OpLoad %63 
					                                       f32_3 %104 = OpVectorShuffle %103 %103 0 1 2 
					                                       f32_3 %105 = OpFAdd %102 %104 
					                                       f32_4 %106 = OpLoad %9 
					                                       f32_4 %107 = OpVectorShuffle %106 %105 4 5 6 3 
					                                                      OpStore %9 %107 
					                                Private f32* %108 = OpAccessChain %63 %58 
					                                                      OpStore %108 %81 
					                                Private f32* %109 = OpAccessChain %63 %85 
					                                                      OpStore %109 %83 
					                              Uniform f32_4* %111 = OpAccessChain %16 %18 
					                                       f32_4 %112 = OpLoad %111 
					                                       f32_4 %113 = OpVectorShuffle %112 %112 0 1 0 1 
					                                       f32_4 %115 = OpFMul %113 %114 
					                                       f32_2 %116 = OpLoad vs_TEXCOORD1 
					                                       f32_4 %117 = OpVectorShuffle %116 %116 0 1 0 1 
					                                       f32_4 %118 = OpFAdd %115 %117 
					                                                      OpStore %110 %118 
					                                       f32_4 %119 = OpLoad %110 
					                                       f32_4 %121 = OpExtInst %1 40 %119 %120 
					                                                      OpStore %110 %121 
					                                       f32_4 %122 = OpLoad %110 
					                                Uniform f32* %123 = OpAccessChain %16 %36 
					                                         f32 %124 = OpLoad %123 
					                                       f32_4 %125 = OpCompositeConstruct %124 %124 %124 %124 
					                                       f32_4 %126 = OpExtInst %1 37 %122 %125 
					                                                      OpStore %110 %126 
					                         read_only Texture2D %127 = OpLoad %46 
					                                     sampler %128 = OpLoad %50 
					                  read_only Texture2DSampled %129 = OpSampledImage %127 %128 
					                                       f32_4 %130 = OpLoad %110 
					                                       f32_2 %131 = OpVectorShuffle %130 %130 0 1 
					                                       f32_4 %132 = OpImageSampleImplicitLod %129 %131 
					                                         f32 %133 = OpCompositeExtract %132 0 
					                                Private f32* %134 = OpAccessChain %63 %60 
					                                                      OpStore %134 %133 
					                         read_only Texture2D %135 = OpLoad %46 
					                                     sampler %136 = OpLoad %50 
					                  read_only Texture2DSampled %137 = OpSampledImage %135 %136 
					                                       f32_4 %138 = OpLoad %110 
					                                       f32_2 %139 = OpVectorShuffle %138 %138 2 3 
					                                       f32_4 %140 = OpImageSampleImplicitLod %137 %139 
					                                         f32 %141 = OpCompositeExtract %140 0 
					                                Private f32* %142 = OpAccessChain %110 %60 
					                                                      OpStore %142 %141 
					                                Private f32* %143 = OpAccessChain %63 %60 
					                                         f32 %144 = OpLoad %143 
					                                Private f32* %145 = OpAccessChain %9 %60 
					                                         f32 %146 = OpLoad %145 
					                                        bool %147 = OpFOrdGreaterThanEqual %144 %146 
					                                                      OpStore %73 %147 
					                                        bool %148 = OpLoad %73 
					                                         f32 %149 = OpSelect %148 %81 %29 
					                                                      OpStore %79 %149 
					                                       f32_4 %150 = OpLoad %9 
					                                       f32_3 %151 = OpVectorShuffle %150 %150 1 1 2 
					                                       f32_3 %152 = OpFNegate %151 
					                                       f32_4 %153 = OpLoad %63 
					                                       f32_3 %154 = OpVectorShuffle %153 %153 0 1 2 
					                                       f32_3 %155 = OpFAdd %152 %154 
					                                       f32_4 %156 = OpLoad %63 
					                                       f32_4 %157 = OpVectorShuffle %156 %155 4 5 6 3 
					                                                      OpStore %63 %157 
					                                         f32 %158 = OpLoad %79 
					                                       f32_3 %159 = OpCompositeConstruct %158 %158 %158 
					                                       f32_4 %160 = OpLoad %63 
					                                       f32_3 %161 = OpVectorShuffle %160 %160 0 1 2 
					                                       f32_3 %162 = OpFMul %159 %161 
					                                       f32_4 %163 = OpLoad %9 
					                                       f32_3 %164 = OpVectorShuffle %163 %163 0 1 2 
					                                       f32_3 %165 = OpFAdd %162 %164 
					                                       f32_4 %166 = OpLoad %9 
					                                       f32_4 %167 = OpVectorShuffle %166 %165 4 5 6 3 
					                                                      OpStore %9 %167 
					                                Private f32* %168 = OpAccessChain %110 %58 
					                                                      OpStore %168 %83 
					                                Private f32* %169 = OpAccessChain %110 %85 
					                                                      OpStore %169 %81 
					                                Private f32* %170 = OpAccessChain %110 %60 
					                                         f32 %171 = OpLoad %170 
					                                Private f32* %172 = OpAccessChain %9 %60 
					                                         f32 %173 = OpLoad %172 
					                                        bool %174 = OpFOrdGreaterThanEqual %171 %173 
					                                                      OpStore %73 %174 
					                                        bool %175 = OpLoad %73 
					                                         f32 %176 = OpSelect %175 %81 %29 
					                                                      OpStore %79 %176 
					                                       f32_4 %177 = OpLoad %9 
					                                       f32_3 %178 = OpVectorShuffle %177 %177 0 1 2 
					                                       f32_3 %179 = OpFNegate %178 
					                                       f32_4 %180 = OpLoad %110 
					                                       f32_3 %181 = OpVectorShuffle %180 %180 0 1 2 
					                                       f32_3 %182 = OpFAdd %179 %181 
					                                       f32_4 %183 = OpLoad %63 
					                                       f32_4 %184 = OpVectorShuffle %183 %182 4 5 6 3 
					                                                      OpStore %63 %184 
					                                         f32 %185 = OpLoad %79 
					                                       f32_3 %186 = OpCompositeConstruct %185 %185 %185 
					                                       f32_4 %187 = OpLoad %63 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                                       f32_3 %189 = OpFMul %186 %188 
					                                       f32_4 %190 = OpLoad %9 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                                       f32_3 %192 = OpFAdd %189 %191 
					                                       f32_4 %193 = OpLoad %9 
					                                       f32_4 %194 = OpVectorShuffle %193 %192 4 5 6 3 
					                                                      OpStore %9 %194 
					                                       f32_2 %195 = OpLoad vs_TEXCOORD1 
					                              Uniform f32_4* %196 = OpAccessChain %16 %18 
					                                       f32_4 %197 = OpLoad %196 
					                                       f32_2 %198 = OpVectorShuffle %197 %197 0 1 
					                                       f32_2 %199 = OpFAdd %195 %198 
					                                       f32_4 %200 = OpLoad %63 
					                                       f32_4 %201 = OpVectorShuffle %200 %199 4 5 2 3 
					                                                      OpStore %63 %201 
					                                       f32_4 %202 = OpLoad %63 
					                                       f32_2 %203 = OpVectorShuffle %202 %202 0 1 
					                                       f32_2 %204 = OpExtInst %1 40 %203 %30 
					                                       f32_4 %205 = OpLoad %63 
					                                       f32_4 %206 = OpVectorShuffle %205 %204 4 5 2 3 
					                                                      OpStore %63 %206 
					                                       f32_4 %207 = OpLoad %63 
					                                       f32_2 %208 = OpVectorShuffle %207 %207 0 1 
					                                Uniform f32* %209 = OpAccessChain %16 %36 
					                                         f32 %210 = OpLoad %209 
					                                       f32_2 %211 = OpCompositeConstruct %210 %210 
					                                       f32_2 %212 = OpExtInst %1 37 %208 %211 
					                                       f32_4 %213 = OpLoad %63 
					                                       f32_4 %214 = OpVectorShuffle %213 %212 4 5 2 3 
					                                                      OpStore %63 %214 
					                         read_only Texture2D %215 = OpLoad %46 
					                                     sampler %216 = OpLoad %50 
					                  read_only Texture2DSampled %217 = OpSampledImage %215 %216 
					                                       f32_4 %218 = OpLoad %63 
					                                       f32_2 %219 = OpVectorShuffle %218 %218 0 1 
					                                       f32_4 %220 = OpImageSampleImplicitLod %217 %219 
					                                         f32 %221 = OpCompositeExtract %220 0 
					                                                      OpStore %79 %221 
					                                         f32 %223 = OpLoad %79 
					                                Private f32* %224 = OpAccessChain %9 %60 
					                                         f32 %225 = OpLoad %224 
					                                        bool %226 = OpFOrdGreaterThanEqual %223 %225 
					                                                      OpStore %222 %226 
					                                        bool %229 = OpLoad %222 
					                                         f32 %230 = OpSelect %229 %81 %29 
					                                Private f32* %231 = OpAccessChain %228 %58 
					                                                      OpStore %231 %230 
					                                       f32_4 %232 = OpLoad %9 
					                                       f32_2 %233 = OpVectorShuffle %232 %232 0 1 
					                                       f32_2 %234 = OpFNegate %233 
					                                       f32_2 %236 = OpFAdd %234 %235 
					                                       f32_4 %237 = OpLoad %63 
					                                       f32_4 %238 = OpVectorShuffle %237 %236 4 5 2 3 
					                                                      OpStore %63 %238 
					                                       f32_2 %239 = OpLoad %228 
					                                       f32_2 %240 = OpVectorShuffle %239 %239 0 0 
					                                       f32_4 %241 = OpLoad %63 
					                                       f32_2 %242 = OpVectorShuffle %241 %241 0 1 
					                                       f32_2 %243 = OpFMul %240 %242 
					                                       f32_4 %244 = OpLoad %9 
					                                       f32_2 %245 = OpVectorShuffle %244 %244 0 1 
					                                       f32_2 %246 = OpFAdd %243 %245 
					                                       f32_4 %247 = OpLoad %9 
					                                       f32_4 %248 = OpVectorShuffle %247 %246 4 5 2 3 
					                                                      OpStore %9 %248 
					                                       f32_4 %249 = OpLoad %9 
					                                       f32_2 %250 = OpVectorShuffle %249 %249 0 1 
					                              Uniform f32_4* %251 = OpAccessChain %16 %18 
					                                       f32_4 %252 = OpLoad %251 
					                                       f32_2 %253 = OpVectorShuffle %252 %252 0 1 
					                                       f32_2 %254 = OpFMul %250 %253 
					                                       f32_2 %255 = OpLoad vs_TEXCOORD1 
					                                       f32_2 %256 = OpFAdd %254 %255 
					                                       f32_4 %257 = OpLoad %9 
					                                       f32_4 %258 = OpVectorShuffle %257 %256 4 5 2 3 
					                                                      OpStore %9 %258 
					                         read_only Texture2D %260 = OpLoad %259 
					                                     sampler %262 = OpLoad %261 
					                  read_only Texture2DSampled %263 = OpSampledImage %260 %262 
					                                       f32_4 %264 = OpLoad %9 
					                                       f32_2 %265 = OpVectorShuffle %264 %264 0 1 
					                                       f32_4 %266 = OpImageSampleImplicitLod %263 %265 
					                                       f32_2 %267 = OpVectorShuffle %266 %266 0 1 
					                                       f32_4 %268 = OpLoad %9 
					                                       f32_4 %269 = OpVectorShuffle %268 %267 4 5 2 3 
					                                                      OpStore %9 %269 
					                                       f32_4 %270 = OpLoad %9 
					                                       f32_2 %271 = OpVectorShuffle %270 %270 0 1 
					                                       f32_4 %272 = OpLoad %9 
					                                       f32_2 %273 = OpVectorShuffle %272 %272 0 1 
					                                         f32 %274 = OpDot %271 %273 
					                                Private f32* %275 = OpAccessChain %228 %58 
					                                                      OpStore %275 %274 
					                                       f32_4 %276 = OpLoad %9 
					                                       f32_2 %277 = OpVectorShuffle %276 %276 0 1 
					                                       f32_2 %278 = OpFNegate %277 
					                                       f32_2 %279 = OpLoad vs_TEXCOORD1 
					                                       f32_2 %280 = OpFAdd %278 %279 
					                                       f32_4 %281 = OpLoad %9 
					                                       f32_4 %282 = OpVectorShuffle %281 %280 4 5 2 3 
					                                                      OpStore %9 %282 
					                                       f32_4 %283 = OpLoad %9 
					                                       f32_2 %284 = OpVectorShuffle %283 %283 0 1 
					                                       f32_2 %285 = OpExtInst %1 40 %284 %30 
					                                       f32_4 %286 = OpLoad %9 
					                                       f32_4 %287 = OpVectorShuffle %286 %285 4 5 2 3 
					                                                      OpStore %9 %287 
					                                       f32_4 %288 = OpLoad %9 
					                                       f32_2 %289 = OpVectorShuffle %288 %288 0 1 
					                                Uniform f32* %290 = OpAccessChain %16 %36 
					                                         f32 %291 = OpLoad %290 
					                                       f32_2 %292 = OpCompositeConstruct %291 %291 
					                                       f32_2 %293 = OpExtInst %1 37 %289 %292 
					                                       f32_4 %294 = OpLoad %9 
					                                       f32_4 %295 = OpVectorShuffle %294 %293 4 5 2 3 
					                                                      OpStore %9 %295 
					                         read_only Texture2D %297 = OpLoad %296 
					                                     sampler %299 = OpLoad %298 
					                  read_only Texture2DSampled %300 = OpSampledImage %297 %299 
					                                       f32_4 %301 = OpLoad %9 
					                                       f32_2 %302 = OpVectorShuffle %301 %301 0 1 
					                                       f32_4 %303 = OpImageSampleImplicitLod %300 %302 
					                                                      OpStore %63 %303 
					                                Private f32* %304 = OpAccessChain %228 %58 
					                                         f32 %305 = OpLoad %304 
					                                         f32 %306 = OpExtInst %1 31 %305 
					                                Private f32* %307 = OpAccessChain %9 %58 
					                                                      OpStore %307 %306 
					                                Private f32* %310 = OpAccessChain %9 %58 
					                                         f32 %311 = OpLoad %310 
					                                         f32 %313 = OpFMul %311 %312 
					                                Private f32* %314 = OpAccessChain %309 %58 
					                                                      OpStore %314 %313 
					                                Private f32* %315 = OpAccessChain %9 %58 
					                                         f32 %316 = OpLoad %315 
					                                Uniform f32* %318 = OpAccessChain %16 %317 %60 
					                                         f32 %319 = OpLoad %318 
					                                         f32 %320 = OpFMul %316 %319 
					                                Private f32* %321 = OpAccessChain %9 %58 
					                                                      OpStore %321 %320 
					                                Private f32* %322 = OpAccessChain %309 %58 
					                                         f32 %323 = OpLoad %322 
					                                         f32 %324 = OpExtInst %1 37 %323 %81 
					                                Private f32* %325 = OpAccessChain %309 %58 
					                                                      OpStore %325 %324 
					                                Private f32* %326 = OpAccessChain %309 %58 
					                                         f32 %327 = OpLoad %326 
					                                         f32 %329 = OpFMul %327 %328 
					                                         f32 %331 = OpFAdd %329 %330 
					                                Private f32* %332 = OpAccessChain %309 %58 
					                                                      OpStore %332 %331 
					                                       f32_2 %333 = OpLoad vs_TEXCOORD1 
					                              Uniform f32_2* %336 = OpAccessChain %16 %334 
					                                       f32_2 %337 = OpLoad %336 
					                                       f32_2 %338 = OpFNegate %337 
					                                       f32_2 %339 = OpFAdd %333 %338 
					                                                      OpStore %228 %339 
					                                       f32_2 %340 = OpLoad %228 
					                                       f32_2 %341 = OpExtInst %1 40 %340 %30 
					                                                      OpStore %228 %341 
					                                       f32_2 %342 = OpLoad %228 
					                                Uniform f32* %343 = OpAccessChain %16 %36 
					                                         f32 %344 = OpLoad %343 
					                                       f32_2 %345 = OpCompositeConstruct %344 %344 
					                                       f32_2 %346 = OpExtInst %1 37 %342 %345 
					                                                      OpStore %228 %346 
					                              Uniform f32_4* %348 = OpAccessChain %16 %347 
					                                       f32_4 %349 = OpLoad %348 
					                                       f32_2 %350 = OpVectorShuffle %349 %349 0 1 
					                                       f32_2 %351 = OpFNegate %350 
					                                       f32_2 %354 = OpFMul %351 %353 
					                                       f32_2 %355 = OpLoad %228 
					                                       f32_2 %356 = OpFAdd %354 %355 
					                                       f32_4 %357 = OpLoad %110 
					                                       f32_4 %358 = OpVectorShuffle %357 %356 4 5 2 3 
					                                                      OpStore %110 %358 
					                                       f32_4 %359 = OpLoad %110 
					                                       f32_2 %360 = OpVectorShuffle %359 %359 0 1 
					                                       f32_2 %361 = OpExtInst %1 40 %360 %30 
					                                       f32_4 %362 = OpLoad %110 
					                                       f32_4 %363 = OpVectorShuffle %362 %361 4 5 2 3 
					                                                      OpStore %110 %363 
					                                       f32_4 %364 = OpLoad %110 
					                                       f32_2 %365 = OpVectorShuffle %364 %364 0 1 
					                                Uniform f32* %366 = OpAccessChain %16 %36 
					                                         f32 %367 = OpLoad %366 
					                                       f32_2 %368 = OpCompositeConstruct %367 %367 
					                                       f32_2 %369 = OpExtInst %1 37 %365 %368 
					                                       f32_4 %370 = OpLoad %110 
					                                       f32_4 %371 = OpVectorShuffle %370 %369 4 5 2 3 
					                                                      OpStore %110 %371 
					                         read_only Texture2D %373 = OpLoad %372 
					                                     sampler %375 = OpLoad %374 
					                  read_only Texture2DSampled %376 = OpSampledImage %373 %375 
					                                       f32_4 %377 = OpLoad %110 
					                                       f32_2 %378 = OpVectorShuffle %377 %377 0 1 
					                                       f32_4 %379 = OpImageSampleImplicitLod %376 %378 
					                                                      OpStore %110 %379 
					                              Uniform f32_4* %381 = OpAccessChain %16 %347 
					                                       f32_4 %382 = OpLoad %381 
					                                       f32_2 %383 = OpVectorShuffle %382 %382 0 1 
					                                       f32_2 %384 = OpFMul %383 %353 
					                                       f32_2 %385 = OpLoad %228 
					                                       f32_2 %386 = OpFAdd %384 %385 
					                                       f32_4 %387 = OpLoad %380 
					                                       f32_4 %388 = OpVectorShuffle %387 %386 4 5 2 3 
					                                                      OpStore %380 %388 
					                         read_only Texture2D %390 = OpLoad %372 
					                                     sampler %391 = OpLoad %374 
					                  read_only Texture2DSampled %392 = OpSampledImage %390 %391 
					                                       f32_2 %393 = OpLoad %228 
					                                       f32_4 %394 = OpImageSampleImplicitLod %392 %393 
					                                                      OpStore %389 %394 
					                                       f32_4 %395 = OpLoad %380 
					                                       f32_2 %396 = OpVectorShuffle %395 %395 0 1 
					                                       f32_2 %397 = OpExtInst %1 40 %396 %30 
					                                                      OpStore %228 %397 
					                                       f32_2 %398 = OpLoad %228 
					                                Uniform f32* %399 = OpAccessChain %16 %36 
					                                         f32 %400 = OpLoad %399 
					                                       f32_2 %401 = OpCompositeConstruct %400 %400 
					                                       f32_2 %402 = OpExtInst %1 37 %398 %401 
					                                                      OpStore %228 %402 
					                         read_only Texture2D %403 = OpLoad %372 
					                                     sampler %404 = OpLoad %374 
					                  read_only Texture2DSampled %405 = OpSampledImage %403 %404 
					                                       f32_2 %406 = OpLoad %228 
					                                       f32_4 %407 = OpImageSampleImplicitLod %405 %406 
					                                                      OpStore %380 %407 
					                                       f32_4 %409 = OpLoad %110 
					                                       f32_4 %410 = OpLoad %380 
					                                       f32_4 %411 = OpFAdd %409 %410 
					                                                      OpStore %408 %411 
					                                       f32_4 %413 = OpLoad %389 
					                                       f32_4 %414 = OpLoad %389 
					                                       f32_4 %415 = OpFAdd %413 %414 
					                                                      OpStore %412 %415 
					                                       f32_4 %416 = OpLoad %408 
					                                       f32_4 %418 = OpFMul %416 %417 
					                                       f32_4 %419 = OpLoad %412 
					                                       f32_4 %420 = OpFNegate %419 
					                                       f32_4 %421 = OpFAdd %418 %420 
					                                                      OpStore %408 %421 
					                                       f32_4 %422 = OpLoad %408 
					                                       f32_4 %423 = OpFNegate %422 
					                                       f32_4 %426 = OpFMul %423 %425 
					                                       f32_4 %427 = OpLoad %389 
					                                       f32_4 %428 = OpFAdd %426 %427 
					                                                      OpStore %412 %428 
					                                       f32_4 %429 = OpLoad %412 
					                                Uniform f32* %431 = OpAccessChain %16 %430 
					                                         f32 %432 = OpLoad %431 
					                                       f32_4 %433 = OpCompositeConstruct %432 %432 %432 %432 
					                                       f32_4 %434 = OpFMul %429 %433 
					                                                      OpStore %412 %434 
					                                       f32_4 %435 = OpLoad %412 
					                                       f32_4 %438 = OpFMul %435 %437 
					                                       f32_4 %439 = OpLoad %389 
					                                       f32_4 %440 = OpFAdd %438 %439 
					                                                      OpStore %389 %440 
					                                       f32_4 %441 = OpLoad %389 
					                                       f32_4 %442 = OpExtInst %1 40 %441 %120 
					                                                      OpStore %389 %442 
					                                       f32_4 %443 = OpLoad %389 
					                                       f32_4 %446 = OpExtInst %1 37 %443 %445 
					                                                      OpStore %389 %446 
					                                       f32_4 %447 = OpLoad %389 
					                                       f32_3 %448 = OpVectorShuffle %447 %447 0 1 2 
					                                       f32_4 %449 = OpLoad %408 
					                                       f32_3 %450 = OpVectorShuffle %449 %449 0 1 2 
					                                       f32_3 %451 = OpFAdd %448 %450 
					                                       f32_4 %452 = OpLoad %408 
					                                       f32_4 %453 = OpVectorShuffle %452 %451 4 5 6 3 
					                                                      OpStore %408 %453 
					                                       f32_4 %454 = OpLoad %408 
					                                       f32_3 %455 = OpVectorShuffle %454 %454 0 1 2 
					                                       f32_3 %458 = OpFMul %455 %457 
					                                       f32_4 %459 = OpLoad %408 
					                                       f32_4 %460 = OpVectorShuffle %459 %458 4 5 6 3 
					                                                      OpStore %408 %460 
					                                       f32_4 %461 = OpLoad %408 
					                                       f32_3 %462 = OpVectorShuffle %461 %461 0 1 2 
					                                         f32 %467 = OpDot %462 %466 
					                                Private f32* %468 = OpAccessChain %228 %58 
					                                                      OpStore %468 %467 
					                                       f32_4 %469 = OpLoad %389 
					                                       f32_3 %470 = OpVectorShuffle %469 %469 0 1 2 
					                                         f32 %471 = OpDot %470 %466 
					                                                      OpStore %79 %471 
					                                         f32 %472 = OpLoad %79 
					                                         f32 %473 = OpFNegate %472 
					                                Private f32* %474 = OpAccessChain %228 %58 
					                                         f32 %475 = OpLoad %474 
					                                         f32 %476 = OpFAdd %473 %475 
					                                Private f32* %477 = OpAccessChain %228 %58 
					                                                      OpStore %477 %476 
					                                       f32_4 %478 = OpLoad %110 
					                                       f32_3 %479 = OpVectorShuffle %478 %478 0 1 2 
					                                       f32_4 %480 = OpLoad %380 
					                                       f32_3 %481 = OpVectorShuffle %480 %480 0 1 2 
					                                       f32_3 %482 = OpExtInst %1 37 %479 %481 
					                                       f32_4 %483 = OpLoad %408 
					                                       f32_4 %484 = OpVectorShuffle %483 %482 4 5 6 3 
					                                                      OpStore %408 %484 
					                                       f32_4 %485 = OpLoad %110 
					                                       f32_3 %486 = OpVectorShuffle %485 %485 0 1 2 
					                                       f32_4 %487 = OpLoad %380 
					                                       f32_3 %488 = OpVectorShuffle %487 %487 0 1 2 
					                                       f32_3 %489 = OpExtInst %1 40 %486 %488 
					                                       f32_4 %490 = OpLoad %110 
					                                       f32_4 %491 = OpVectorShuffle %490 %489 4 5 6 3 
					                                                      OpStore %110 %491 
					                                       f32_3 %492 = OpLoad %309 
					                                       f32_3 %493 = OpVectorShuffle %492 %492 0 0 0 
					                                       f32_2 %494 = OpLoad %228 
					                                       f32_3 %495 = OpVectorShuffle %494 %494 0 0 0 
					                                       f32_3 %496 = OpExtInst %1 4 %495 
					                                       f32_3 %497 = OpFMul %493 %496 
					                                       f32_4 %498 = OpLoad %110 
					                                       f32_3 %499 = OpVectorShuffle %498 %498 0 1 2 
					                                       f32_3 %500 = OpFAdd %497 %499 
					                                       f32_4 %501 = OpLoad %110 
					                                       f32_4 %502 = OpVectorShuffle %501 %500 4 5 6 3 
					                                                      OpStore %110 %502 
					                                       f32_3 %503 = OpLoad %309 
					                                       f32_3 %504 = OpVectorShuffle %503 %503 0 0 0 
					                                       f32_3 %505 = OpFNegate %504 
					                                       f32_2 %506 = OpLoad %228 
					                                       f32_3 %507 = OpVectorShuffle %506 %506 0 0 0 
					                                       f32_3 %508 = OpExtInst %1 4 %507 
					                                       f32_3 %509 = OpFMul %505 %508 
					                                       f32_4 %510 = OpLoad %408 
					                                       f32_3 %511 = OpVectorShuffle %510 %510 0 1 2 
					                                       f32_3 %512 = OpFAdd %509 %511 
					                                                      OpStore %309 %512 
					                                       f32_3 %513 = OpLoad %309 
					                                       f32_3 %514 = OpFNegate %513 
					                                       f32_4 %515 = OpLoad %110 
					                                       f32_3 %516 = OpVectorShuffle %515 %515 0 1 2 
					                                       f32_3 %517 = OpFAdd %514 %516 
					                                       f32_4 %518 = OpLoad %380 
					                                       f32_4 %519 = OpVectorShuffle %518 %517 4 5 6 3 
					                                                      OpStore %380 %519 
					                                       f32_3 %520 = OpLoad %309 
					                                       f32_4 %521 = OpLoad %110 
					                                       f32_3 %522 = OpVectorShuffle %521 %521 0 1 2 
					                                       f32_3 %523 = OpFAdd %520 %522 
					                                                      OpStore %309 %523 
					                                       f32_4 %524 = OpLoad %380 
					                                       f32_3 %525 = OpVectorShuffle %524 %524 0 1 2 
					                                       f32_3 %527 = OpFMul %525 %526 
					                                       f32_4 %528 = OpLoad %110 
					                                       f32_4 %529 = OpVectorShuffle %528 %527 4 5 6 3 
					                                                      OpStore %110 %529 
					                                       f32_3 %530 = OpLoad %309 
					                                       f32_3 %531 = OpFNegate %530 
					                                       f32_3 %532 = OpFMul %531 %526 
					                                       f32_4 %533 = OpLoad %63 
					                                       f32_3 %534 = OpVectorShuffle %533 %533 0 1 2 
					                                       f32_3 %535 = OpFAdd %532 %534 
					                                       f32_4 %536 = OpLoad %380 
					                                       f32_4 %537 = OpVectorShuffle %536 %535 4 5 6 3 
					                                                      OpStore %380 %537 
					                                       f32_3 %538 = OpLoad %309 
					                                       f32_3 %539 = OpFMul %538 %526 
					                                                      OpStore %309 %539 
					                                       f32_4 %540 = OpLoad %380 
					                                       f32_3 %541 = OpVectorShuffle %540 %540 0 1 2 
					                                       f32_3 %544 = OpFAdd %541 %543 
					                                       f32_4 %545 = OpLoad %408 
					                                       f32_4 %546 = OpVectorShuffle %545 %544 4 5 6 3 
					                                                      OpStore %408 %546 
					                                       f32_4 %547 = OpLoad %110 
					                                       f32_3 %548 = OpVectorShuffle %547 %547 0 1 2 
					                                       f32_4 %549 = OpLoad %408 
					                                       f32_3 %550 = OpVectorShuffle %549 %549 0 1 2 
					                                       f32_3 %551 = OpFDiv %548 %550 
					                                       f32_4 %552 = OpLoad %110 
					                                       f32_4 %553 = OpVectorShuffle %552 %551 4 5 6 3 
					                                                      OpStore %110 %553 
					                                Private f32* %554 = OpAccessChain %110 %85 
					                                         f32 %555 = OpLoad %554 
					                                         f32 %556 = OpExtInst %1 4 %555 
					                                Private f32* %557 = OpAccessChain %110 %58 
					                                         f32 %558 = OpLoad %557 
					                                         f32 %559 = OpExtInst %1 4 %558 
					                                         f32 %560 = OpExtInst %1 37 %556 %559 
					                                Private f32* %561 = OpAccessChain %110 %58 
					                                                      OpStore %561 %560 
					                                Private f32* %562 = OpAccessChain %110 %60 
					                                         f32 %563 = OpLoad %562 
					                                         f32 %564 = OpExtInst %1 4 %563 
					                                Private f32* %565 = OpAccessChain %110 %58 
					                                         f32 %566 = OpLoad %565 
					                                         f32 %567 = OpExtInst %1 37 %564 %566 
					                                Private f32* %568 = OpAccessChain %110 %58 
					                                                      OpStore %568 %567 
					                                Private f32* %569 = OpAccessChain %110 %58 
					                                         f32 %570 = OpLoad %569 
					                                         f32 %571 = OpExtInst %1 37 %570 %81 
					                                Private f32* %572 = OpAccessChain %110 %58 
					                                                      OpStore %572 %571 
					                                       f32_4 %573 = OpLoad %380 
					                                       f32_3 %574 = OpVectorShuffle %573 %573 0 1 2 
					                                       f32_4 %575 = OpLoad %110 
					                                       f32_3 %576 = OpVectorShuffle %575 %575 0 0 0 
					                                       f32_3 %577 = OpFMul %574 %576 
					                                       f32_3 %578 = OpLoad %309 
					                                       f32_3 %579 = OpFAdd %577 %578 
					                                       f32_4 %580 = OpLoad %63 
					                                       f32_4 %581 = OpVectorShuffle %580 %579 4 5 6 3 
					                                                      OpStore %63 %581 
					                                       f32_4 %582 = OpLoad %389 
					                                       f32_4 %583 = OpFNegate %582 
					                                       f32_4 %584 = OpLoad %63 
					                                       f32_4 %585 = OpFAdd %583 %584 
					                                                      OpStore %63 %585 
					                                Uniform f32* %586 = OpAccessChain %16 %317 %58 
					                                         f32 %587 = OpLoad %586 
					                                         f32 %588 = OpFNegate %587 
					                                Uniform f32* %589 = OpAccessChain %16 %317 %85 
					                                         f32 %590 = OpLoad %589 
					                                         f32 %591 = OpFAdd %588 %590 
					                                Private f32* %592 = OpAccessChain %309 %58 
					                                                      OpStore %592 %591 
					                                Private f32* %593 = OpAccessChain %9 %58 
					                                         f32 %594 = OpLoad %593 
					                                Private f32* %595 = OpAccessChain %309 %58 
					                                         f32 %596 = OpLoad %595 
					                                         f32 %597 = OpFMul %594 %596 
					                                Uniform f32* %598 = OpAccessChain %16 %317 %58 
					                                         f32 %599 = OpLoad %598 
					                                         f32 %600 = OpFAdd %597 %599 
					                                Private f32* %601 = OpAccessChain %9 %58 
					                                                      OpStore %601 %600 
					                                Private f32* %602 = OpAccessChain %9 %58 
					                                         f32 %603 = OpLoad %602 
					                                Uniform f32* %604 = OpAccessChain %16 %317 %85 
					                                         f32 %605 = OpLoad %604 
					                                         f32 %606 = OpExtInst %1 40 %603 %605 
					                                Private f32* %607 = OpAccessChain %9 %58 
					                                                      OpStore %607 %606 
					                                Private f32* %608 = OpAccessChain %9 %58 
					                                         f32 %609 = OpLoad %608 
					                                Uniform f32* %610 = OpAccessChain %16 %317 %58 
					                                         f32 %611 = OpLoad %610 
					                                         f32 %612 = OpExtInst %1 37 %609 %611 
					                                Private f32* %613 = OpAccessChain %9 %58 
					                                                      OpStore %613 %612 
					                                       f32_4 %614 = OpLoad %9 
					                                       f32_4 %615 = OpVectorShuffle %614 %614 0 0 0 0 
					                                       f32_4 %616 = OpLoad %63 
					                                       f32_4 %617 = OpFMul %615 %616 
					                                       f32_4 %618 = OpLoad %389 
					                                       f32_4 %619 = OpFAdd %617 %618 
					                                                      OpStore %9 %619 
					                                       f32_4 %620 = OpLoad %9 
					                                       f32_4 %621 = OpExtInst %1 40 %620 %120 
					                                                      OpStore %9 %621 
					                                       f32_4 %622 = OpLoad %9 
					                                       f32_4 %623 = OpExtInst %1 37 %622 %445 
					                                                      OpStore %9 %623 
					                                       f32_4 %626 = OpLoad %9 
					                                                      OpStore %625 %626 
					                                       f32_4 %628 = OpLoad %9 
					                                                      OpStore %627 %628 
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
						vec4 _CameraDepthTexture_TexelSize;
						vec2 _Jitter;
						vec4 _FinalBlendParameters;
						float _Sharpness;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _HistoryTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _CameraMotionVectorsTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec2 u_xlat14;
					bool u_xlatb14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xy + (-_CameraDepthTexture_TexelSize.xy);
					    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.xy = min(u_xlat0.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat0 = texture(_CameraDepthTexture, u_xlat0.xy).yzxw;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).yzxw;
					    u_xlatb21 = u_xlat0.z>=u_xlat1.z;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.x = float(-1.0);
					    u_xlat0.y = float(-1.0);
					    u_xlat1.x = float(0.0);
					    u_xlat1.y = float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.yyz);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = float(1.0);
					    u_xlat1.y = float(-1.0);
					    u_xlat2 = _CameraDepthTexture_TexelSize.xyxy * vec4(1.0, -1.0, -1.0, 1.0) + vs_TEXCOORD1.xyxy;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = min(u_xlat2, vec4(_RenderViewportScaleFactor));
					    u_xlat3 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat2.zw).yzxw;
					    u_xlat1.z = u_xlat3.x;
					    u_xlatb21 = u_xlat3.x>=u_xlat0.z;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat1.xyz = (-u_xlat0.yyz) + u_xlat1.xyz;
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat2.x = float(-1.0);
					    u_xlat2.y = float(1.0);
					    u_xlatb21 = u_xlat2.z>=u_xlat0.z;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy + _CameraDepthTexture_TexelSize.xy;
					    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
					    u_xlat1.xy = min(u_xlat1.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat1.xy);
					    u_xlatb14 = u_xlat1.x>=u_xlat0.z;
					    u_xlat14.x = u_xlatb14 ? 1.0 : float(0.0);
					    u_xlat1.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat14.xx * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * _CameraDepthTexture_TexelSize.xy + vs_TEXCOORD1.xy;
					    u_xlat0 = texture(_CameraMotionVectorsTexture, u_xlat0.xy);
					    u_xlat14.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = (-u_xlat0.xy) + vs_TEXCOORD1.xy;
					    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.xy = min(u_xlat0.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat1 = texture(_HistoryTex, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat14.x);
					    u_xlat7.x = u_xlat0.x * 100.0;
					    u_xlat0.x = u_xlat0.x * _FinalBlendParameters.z;
					    u_xlat7.x = min(u_xlat7.x, 1.0);
					    u_xlat7.x = u_xlat7.x * -3.75 + 4.0;
					    u_xlat14.xy = vs_TEXCOORD1.xy + (-_Jitter.xy);
					    u_xlat14.xy = max(u_xlat14.xy, vec2(0.0, 0.0));
					    u_xlat14.xy = min(u_xlat14.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat2.xy = (-_MainTex_TexelSize.xy) * vec2(0.5, 0.5) + u_xlat14.xy;
					    u_xlat2.xy = max(u_xlat2.xy, vec2(0.0, 0.0));
					    u_xlat2.xy = min(u_xlat2.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(0.5, 0.5) + u_xlat14.xy;
					    u_xlat4 = texture(_MainTex, u_xlat14.xy);
					    u_xlat14.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat14.xy = min(u_xlat14.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat3 = texture(_MainTex, u_xlat14.xy);
					    u_xlat5 = u_xlat2 + u_xlat3;
					    u_xlat6 = u_xlat4 + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(4.0, 4.0, 4.0, 4.0) + (-u_xlat6);
					    u_xlat6 = (-u_xlat5) * vec4(0.166666999, 0.166666999, 0.166666999, 0.166666999) + u_xlat4;
					    u_xlat6 = u_xlat6 * vec4(_Sharpness);
					    u_xlat4 = u_xlat6 * vec4(2.71828198, 2.71828198, 2.71828198, 2.71828198) + u_xlat4;
					    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat4 = min(u_xlat4, vec4(65472.0, 65472.0, 65472.0, 65472.0));
					    u_xlat5.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.142857, 0.142857, 0.142857);
					    u_xlat14.x = dot(u_xlat5.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat21 = dot(u_xlat4.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat14.x = (-u_xlat21) + u_xlat14.x;
					    u_xlat5.xyz = min(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat2.xyz = max(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat2.xyz = u_xlat7.xxx * abs(u_xlat14.xxx) + u_xlat2.xyz;
					    u_xlat7.xyz = (-u_xlat7.xxx) * abs(u_xlat14.xxx) + u_xlat5.xyz;
					    u_xlat3.xyz = (-u_xlat7.xyz) + u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat7.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat3.xyz = (-u_xlat7.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat7.xyz = u_xlat7.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat5.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat5.xyz;
					    u_xlat2.x = min(abs(u_xlat2.y), abs(u_xlat2.x));
					    u_xlat2.x = min(abs(u_xlat2.z), u_xlat2.x);
					    u_xlat2.x = min(u_xlat2.x, 1.0);
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat7.xyz;
					    u_xlat1 = (-u_xlat4) + u_xlat1;
					    u_xlat7.x = (-_FinalBlendParameters.x) + _FinalBlendParameters.y;
					    u_xlat0.x = u_xlat0.x * u_xlat7.x + _FinalBlendParameters.x;
					    u_xlat0.x = max(u_xlat0.x, _FinalBlendParameters.y);
					    u_xlat0.x = min(u_xlat0.x, _FinalBlendParameters.x);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat4;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = min(u_xlat0, vec4(65472.0, 65472.0, 65472.0, 65472.0));
					    SV_Target0 = u_xlat0;
					    SV_Target1 = u_xlat0;
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
			GpuProgramID 125620
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
					uniform 	vec2 _Jitter;
					uniform 	vec4 _FinalBlendParameters;
					uniform 	float _Sharpness;
					UNITY_LOCATION(0) uniform  sampler2D _CameraMotionVectorsTexture;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					UNITY_LOCATION(2) uniform  sampler2D _HistoryTex;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat7;
					vec2 u_xlat12;
					float u_xlat13;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xy + (-_Jitter.xy);
					    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.xy = min(u_xlat0.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat12.xy = (-_MainTex_TexelSize.xy) * vec2(0.5, 0.5) + u_xlat0.xy;
					    u_xlat12.xy = max(u_xlat12.xy, vec2(0.0, 0.0));
					    u_xlat12.xy = min(u_xlat12.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat1 = texture(_MainTex, u_xlat12.xy);
					    u_xlat12.xy = _MainTex_TexelSize.xy * vec2(0.5, 0.5) + u_xlat0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.xy = max(u_xlat12.xy, vec2(0.0, 0.0));
					    u_xlat0.xy = min(u_xlat0.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat3 = u_xlat0 + u_xlat1;
					    u_xlat4 = u_xlat2 + u_xlat2;
					    u_xlat3 = u_xlat3 * vec4(4.0, 4.0, 4.0, 4.0) + (-u_xlat4);
					    u_xlat4 = (-u_xlat3) * vec4(0.166666999, 0.166666999, 0.166666999, 0.166666999) + u_xlat2;
					    u_xlat4 = u_xlat4 * vec4(_Sharpness);
					    u_xlat2 = u_xlat4 * vec4(2.71828198, 2.71828198, 2.71828198, 2.71828198) + u_xlat2;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = min(u_xlat2, vec4(65472.0, 65472.0, 65472.0, 65472.0));
					    u_xlat3.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.142857, 0.142857, 0.142857);
					    u_xlat18 = dot(u_xlat3.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat19 = dot(u_xlat2.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat18 = u_xlat18 + (-u_xlat19);
					    u_xlat3.xyz = min(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat1 = texture(_CameraMotionVectorsTexture, vs_TEXCOORD1.xy);
					    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = (-u_xlat1.xy) + vs_TEXCOORD1.xy;
					    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
					    u_xlat1.xy = min(u_xlat1.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat4 = texture(_HistoryTex, u_xlat1.xy);
					    u_xlat1.x = sqrt(u_xlat13);
					    u_xlat7.x = u_xlat1.x * 100.0;
					    u_xlat1.x = u_xlat1.x * _FinalBlendParameters.z;
					    u_xlat7.x = min(u_xlat7.x, 1.0);
					    u_xlat7.x = u_xlat7.x * -3.75 + 4.0;
					    u_xlat3.xyz = (-u_xlat7.xxx) * abs(vec3(u_xlat18)) + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat7.xxx * abs(vec3(u_xlat18)) + u_xlat0.xyz;
					    u_xlat7.xyz = (-u_xlat3.xyz) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
					    u_xlat7.xyz = u_xlat7.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat3.xyz = (-u_xlat0.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat5.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
					    u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					    u_xlat18 = min(abs(u_xlat7.y), abs(u_xlat7.x));
					    u_xlat18 = min(abs(u_xlat7.z), u_xlat18);
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    u_xlat0 = (-u_xlat2) + u_xlat4;
					    u_xlat7.x = (-_FinalBlendParameters.x) + _FinalBlendParameters.y;
					    u_xlat1.x = u_xlat1.x * u_xlat7.x + _FinalBlendParameters.x;
					    u_xlat1.x = max(u_xlat1.x, _FinalBlendParameters.y);
					    u_xlat1.x = min(u_xlat1.x, _FinalBlendParameters.x);
					    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = min(u_xlat0, vec4(65472.0, 65472.0, 65472.0, 65472.0));
					    SV_Target0 = u_xlat0;
					    SV_Target1 = u_xlat0;
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
					; Bound: 406
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %12 %401 %403 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate vs_TEXCOORD1 Location 12 
					                                                      OpMemberDecorate %14 0 Offset 14 
					                                                      OpMemberDecorate %14 1 Offset 14 
					                                                      OpMemberDecorate %14 2 Offset 14 
					                                                      OpMemberDecorate %14 3 Offset 14 
					                                                      OpMemberDecorate %14 4 Offset 14 
					                                                      OpDecorate %14 Block 
					                                                      OpDecorate %16 DescriptorSet 16 
					                                                      OpDecorate %16 Binding 16 
					                                                      OpDecorate %67 DescriptorSet 67 
					                                                      OpDecorate %67 Binding 67 
					                                                      OpDecorate %71 DescriptorSet 71 
					                                                      OpDecorate %71 Binding 71 
					                                                      OpDecorate %196 DescriptorSet 196 
					                                                      OpDecorate %196 Binding 196 
					                                                      OpDecorate %198 DescriptorSet 198 
					                                                      OpDecorate %198 Binding 198 
					                                                      OpDecorate %232 DescriptorSet 232 
					                                                      OpDecorate %232 Binding 232 
					                                                      OpDecorate %234 DescriptorSet 234 
					                                                      OpDecorate %234 Binding 234 
					                                                      OpDecorate %401 Location 401 
					                                                      OpDecorate %403 Location 403 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 2 
					                                              %11 = OpTypePointer Input %10 
					                        Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                              %14 = OpTypeStruct %6 %7 %10 %7 %6 
					                                              %15 = OpTypePointer Uniform %14 
					Uniform struct {f32; f32_4; f32_2; f32_4; f32;}* %16 = OpVariable Uniform 
					                                              %17 = OpTypeInt 32 1 
					                                          i32 %18 = OpConstant 2 
					                                              %19 = OpTypePointer Uniform %10 
					                                          f32 %28 = OpConstant 3,674022E-40 
					                                        f32_2 %29 = OpConstantComposite %28 %28 
					                                          i32 %35 = OpConstant 0 
					                                              %36 = OpTypePointer Uniform %6 
					                                              %43 = OpTypePointer Private %10 
					                               Private f32_2* %44 = OpVariable Private 
					                                          i32 %45 = OpConstant 1 
					                                              %46 = OpTypePointer Uniform %7 
					                                          f32 %51 = OpConstant 3,674022E-40 
					                                        f32_2 %52 = OpConstantComposite %51 %51 
					                               Private f32_4* %64 = OpVariable Private 
					                                              %65 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %66 = OpTypePointer UniformConstant %65 
					         UniformConstant read_only Texture2D* %67 = OpVariable UniformConstant 
					                                              %69 = OpTypeSampler 
					                                              %70 = OpTypePointer UniformConstant %69 
					                     UniformConstant sampler* %71 = OpVariable UniformConstant 
					                                              %73 = OpTypeSampledImage %65 
					                               Private f32_4* %84 = OpVariable Private 
					                              Private f32_4* %109 = OpVariable Private 
					                              Private f32_4* %113 = OpVariable Private 
					                                         f32 %118 = OpConstant 3,674022E-40 
					                                       f32_4 %119 = OpConstantComposite %118 %118 %118 %118 
					                                         f32 %126 = OpConstant 3,674022E-40 
					                                       f32_4 %127 = OpConstantComposite %126 %126 %126 %126 
					                                         i32 %132 = OpConstant 4 
					                                         f32 %138 = OpConstant 3,674022E-40 
					                                       f32_4 %139 = OpConstantComposite %138 %138 %138 %138 
					                                       f32_4 %144 = OpConstantComposite %28 %28 %28 %28 
					                                         f32 %147 = OpConstant 3,674022E-40 
					                                       f32_4 %148 = OpConstantComposite %147 %147 %147 %147 
					                                             %150 = OpTypeVector %6 3 
					                                         f32 %160 = OpConstant 3,674022E-40 
					                                       f32_3 %161 = OpConstantComposite %160 %160 %160 
					                                             %165 = OpTypePointer Private %6 
					                                Private f32* %166 = OpVariable Private 
					                                         f32 %169 = OpConstant 3,674022E-40 
					                                         f32 %170 = OpConstant 3,674022E-40 
					                                         f32 %171 = OpConstant 3,674022E-40 
					                                       f32_3 %172 = OpConstantComposite %169 %170 %171 
					                                Private f32* %174 = OpVariable Private 
					        UniformConstant read_only Texture2D* %196 = OpVariable UniformConstant 
					                    UniformConstant sampler* %198 = OpVariable UniformConstant 
					                                Private f32* %206 = OpVariable Private 
					        UniformConstant read_only Texture2D* %232 = OpVariable UniformConstant 
					                    UniformConstant sampler* %234 = OpVariable UniformConstant 
					                                             %242 = OpTypeInt 32 0 
					                                         u32 %243 = OpConstant 0 
					                                             %245 = OpTypePointer Private %150 
					                              Private f32_3* %246 = OpVariable Private 
					                                         f32 %249 = OpConstant 3,674022E-40 
					                                         i32 %254 = OpConstant 3 
					                                         u32 %255 = OpConstant 2 
					                                         f32 %262 = OpConstant 3,674022E-40 
					                                         f32 %267 = OpConstant 3,674022E-40 
					                                       f32_3 %308 = OpConstantComposite %51 %51 %51 
					                              Private f32_3* %324 = OpVariable Private 
					                                         f32 %327 = OpConstant 3,674022E-40 
					                                       f32_3 %328 = OpConstantComposite %327 %327 %327 
					                                         u32 %333 = OpConstant 1 
					                                             %400 = OpTypePointer Output %7 
					                               Output f32_4* %401 = OpVariable Output 
					                               Output f32_4* %403 = OpVariable Output 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_2 %13 = OpLoad vs_TEXCOORD1 
					                               Uniform f32_2* %20 = OpAccessChain %16 %18 
					                                        f32_2 %21 = OpLoad %20 
					                                        f32_2 %22 = OpFNegate %21 
					                                        f32_2 %23 = OpFAdd %13 %22 
					                                        f32_4 %24 = OpLoad %9 
					                                        f32_4 %25 = OpVectorShuffle %24 %23 4 5 2 3 
					                                                      OpStore %9 %25 
					                                        f32_4 %26 = OpLoad %9 
					                                        f32_2 %27 = OpVectorShuffle %26 %26 0 1 
					                                        f32_2 %30 = OpExtInst %1 40 %27 %29 
					                                        f32_4 %31 = OpLoad %9 
					                                        f32_4 %32 = OpVectorShuffle %31 %30 4 5 2 3 
					                                                      OpStore %9 %32 
					                                        f32_4 %33 = OpLoad %9 
					                                        f32_2 %34 = OpVectorShuffle %33 %33 0 1 
					                                 Uniform f32* %37 = OpAccessChain %16 %35 
					                                          f32 %38 = OpLoad %37 
					                                        f32_2 %39 = OpCompositeConstruct %38 %38 
					                                        f32_2 %40 = OpExtInst %1 37 %34 %39 
					                                        f32_4 %41 = OpLoad %9 
					                                        f32_4 %42 = OpVectorShuffle %41 %40 4 5 2 3 
					                                                      OpStore %9 %42 
					                               Uniform f32_4* %47 = OpAccessChain %16 %45 
					                                        f32_4 %48 = OpLoad %47 
					                                        f32_2 %49 = OpVectorShuffle %48 %48 0 1 
					                                        f32_2 %50 = OpFNegate %49 
					                                        f32_2 %53 = OpFMul %50 %52 
					                                        f32_4 %54 = OpLoad %9 
					                                        f32_2 %55 = OpVectorShuffle %54 %54 0 1 
					                                        f32_2 %56 = OpFAdd %53 %55 
					                                                      OpStore %44 %56 
					                                        f32_2 %57 = OpLoad %44 
					                                        f32_2 %58 = OpExtInst %1 40 %57 %29 
					                                                      OpStore %44 %58 
					                                        f32_2 %59 = OpLoad %44 
					                                 Uniform f32* %60 = OpAccessChain %16 %35 
					                                          f32 %61 = OpLoad %60 
					                                        f32_2 %62 = OpCompositeConstruct %61 %61 
					                                        f32_2 %63 = OpExtInst %1 37 %59 %62 
					                                                      OpStore %44 %63 
					                          read_only Texture2D %68 = OpLoad %67 
					                                      sampler %72 = OpLoad %71 
					                   read_only Texture2DSampled %74 = OpSampledImage %68 %72 
					                                        f32_2 %75 = OpLoad %44 
					                                        f32_4 %76 = OpImageSampleImplicitLod %74 %75 
					                                                      OpStore %64 %76 
					                               Uniform f32_4* %77 = OpAccessChain %16 %45 
					                                        f32_4 %78 = OpLoad %77 
					                                        f32_2 %79 = OpVectorShuffle %78 %78 0 1 
					                                        f32_2 %80 = OpFMul %79 %52 
					                                        f32_4 %81 = OpLoad %9 
					                                        f32_2 %82 = OpVectorShuffle %81 %81 0 1 
					                                        f32_2 %83 = OpFAdd %80 %82 
					                                                      OpStore %44 %83 
					                          read_only Texture2D %85 = OpLoad %67 
					                                      sampler %86 = OpLoad %71 
					                   read_only Texture2DSampled %87 = OpSampledImage %85 %86 
					                                        f32_4 %88 = OpLoad %9 
					                                        f32_2 %89 = OpVectorShuffle %88 %88 0 1 
					                                        f32_4 %90 = OpImageSampleImplicitLod %87 %89 
					                                                      OpStore %84 %90 
					                                        f32_2 %91 = OpLoad %44 
					                                        f32_2 %92 = OpExtInst %1 40 %91 %29 
					                                        f32_4 %93 = OpLoad %9 
					                                        f32_4 %94 = OpVectorShuffle %93 %92 4 5 2 3 
					                                                      OpStore %9 %94 
					                                        f32_4 %95 = OpLoad %9 
					                                        f32_2 %96 = OpVectorShuffle %95 %95 0 1 
					                                 Uniform f32* %97 = OpAccessChain %16 %35 
					                                          f32 %98 = OpLoad %97 
					                                        f32_2 %99 = OpCompositeConstruct %98 %98 
					                                       f32_2 %100 = OpExtInst %1 37 %96 %99 
					                                       f32_4 %101 = OpLoad %9 
					                                       f32_4 %102 = OpVectorShuffle %101 %100 4 5 2 3 
					                                                      OpStore %9 %102 
					                         read_only Texture2D %103 = OpLoad %67 
					                                     sampler %104 = OpLoad %71 
					                  read_only Texture2DSampled %105 = OpSampledImage %103 %104 
					                                       f32_4 %106 = OpLoad %9 
					                                       f32_2 %107 = OpVectorShuffle %106 %106 0 1 
					                                       f32_4 %108 = OpImageSampleImplicitLod %105 %107 
					                                                      OpStore %9 %108 
					                                       f32_4 %110 = OpLoad %9 
					                                       f32_4 %111 = OpLoad %64 
					                                       f32_4 %112 = OpFAdd %110 %111 
					                                                      OpStore %109 %112 
					                                       f32_4 %114 = OpLoad %84 
					                                       f32_4 %115 = OpLoad %84 
					                                       f32_4 %116 = OpFAdd %114 %115 
					                                                      OpStore %113 %116 
					                                       f32_4 %117 = OpLoad %109 
					                                       f32_4 %120 = OpFMul %117 %119 
					                                       f32_4 %121 = OpLoad %113 
					                                       f32_4 %122 = OpFNegate %121 
					                                       f32_4 %123 = OpFAdd %120 %122 
					                                                      OpStore %109 %123 
					                                       f32_4 %124 = OpLoad %109 
					                                       f32_4 %125 = OpFNegate %124 
					                                       f32_4 %128 = OpFMul %125 %127 
					                                       f32_4 %129 = OpLoad %84 
					                                       f32_4 %130 = OpFAdd %128 %129 
					                                                      OpStore %113 %130 
					                                       f32_4 %131 = OpLoad %113 
					                                Uniform f32* %133 = OpAccessChain %16 %132 
					                                         f32 %134 = OpLoad %133 
					                                       f32_4 %135 = OpCompositeConstruct %134 %134 %134 %134 
					                                       f32_4 %136 = OpFMul %131 %135 
					                                                      OpStore %113 %136 
					                                       f32_4 %137 = OpLoad %113 
					                                       f32_4 %140 = OpFMul %137 %139 
					                                       f32_4 %141 = OpLoad %84 
					                                       f32_4 %142 = OpFAdd %140 %141 
					                                                      OpStore %84 %142 
					                                       f32_4 %143 = OpLoad %84 
					                                       f32_4 %145 = OpExtInst %1 40 %143 %144 
					                                                      OpStore %84 %145 
					                                       f32_4 %146 = OpLoad %84 
					                                       f32_4 %149 = OpExtInst %1 37 %146 %148 
					                                                      OpStore %84 %149 
					                                       f32_4 %151 = OpLoad %84 
					                                       f32_3 %152 = OpVectorShuffle %151 %151 0 1 2 
					                                       f32_4 %153 = OpLoad %109 
					                                       f32_3 %154 = OpVectorShuffle %153 %153 0 1 2 
					                                       f32_3 %155 = OpFAdd %152 %154 
					                                       f32_4 %156 = OpLoad %109 
					                                       f32_4 %157 = OpVectorShuffle %156 %155 4 5 6 3 
					                                                      OpStore %109 %157 
					                                       f32_4 %158 = OpLoad %109 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
					                                       f32_3 %162 = OpFMul %159 %161 
					                                       f32_4 %163 = OpLoad %109 
					                                       f32_4 %164 = OpVectorShuffle %163 %162 4 5 6 3 
					                                                      OpStore %109 %164 
					                                       f32_4 %167 = OpLoad %109 
					                                       f32_3 %168 = OpVectorShuffle %167 %167 0 1 2 
					                                         f32 %173 = OpDot %168 %172 
					                                                      OpStore %166 %173 
					                                       f32_4 %175 = OpLoad %84 
					                                       f32_3 %176 = OpVectorShuffle %175 %175 0 1 2 
					                                         f32 %177 = OpDot %176 %172 
					                                                      OpStore %174 %177 
					                                         f32 %178 = OpLoad %166 
					                                         f32 %179 = OpLoad %174 
					                                         f32 %180 = OpFNegate %179 
					                                         f32 %181 = OpFAdd %178 %180 
					                                                      OpStore %166 %181 
					                                       f32_4 %182 = OpLoad %64 
					                                       f32_3 %183 = OpVectorShuffle %182 %182 0 1 2 
					                                       f32_4 %184 = OpLoad %9 
					                                       f32_3 %185 = OpVectorShuffle %184 %184 0 1 2 
					                                       f32_3 %186 = OpExtInst %1 37 %183 %185 
					                                       f32_4 %187 = OpLoad %109 
					                                       f32_4 %188 = OpVectorShuffle %187 %186 4 5 6 3 
					                                                      OpStore %109 %188 
					                                       f32_4 %189 = OpLoad %9 
					                                       f32_3 %190 = OpVectorShuffle %189 %189 0 1 2 
					                                       f32_4 %191 = OpLoad %64 
					                                       f32_3 %192 = OpVectorShuffle %191 %191 0 1 2 
					                                       f32_3 %193 = OpExtInst %1 40 %190 %192 
					                                       f32_4 %194 = OpLoad %9 
					                                       f32_4 %195 = OpVectorShuffle %194 %193 4 5 6 3 
					                                                      OpStore %9 %195 
					                         read_only Texture2D %197 = OpLoad %196 
					                                     sampler %199 = OpLoad %198 
					                  read_only Texture2DSampled %200 = OpSampledImage %197 %199 
					                                       f32_2 %201 = OpLoad vs_TEXCOORD1 
					                                       f32_4 %202 = OpImageSampleImplicitLod %200 %201 
					                                       f32_2 %203 = OpVectorShuffle %202 %202 0 1 
					                                       f32_4 %204 = OpLoad %64 
					                                       f32_4 %205 = OpVectorShuffle %204 %203 4 5 2 3 
					                                                      OpStore %64 %205 
					                                       f32_4 %207 = OpLoad %64 
					                                       f32_2 %208 = OpVectorShuffle %207 %207 0 1 
					                                       f32_4 %209 = OpLoad %64 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                         f32 %211 = OpDot %208 %210 
					                                                      OpStore %206 %211 
					                                       f32_4 %212 = OpLoad %64 
					                                       f32_2 %213 = OpVectorShuffle %212 %212 0 1 
					                                       f32_2 %214 = OpFNegate %213 
					                                       f32_2 %215 = OpLoad vs_TEXCOORD1 
					                                       f32_2 %216 = OpFAdd %214 %215 
					                                       f32_4 %217 = OpLoad %64 
					                                       f32_4 %218 = OpVectorShuffle %217 %216 4 5 2 3 
					                                                      OpStore %64 %218 
					                                       f32_4 %219 = OpLoad %64 
					                                       f32_2 %220 = OpVectorShuffle %219 %219 0 1 
					                                       f32_2 %221 = OpExtInst %1 40 %220 %29 
					                                       f32_4 %222 = OpLoad %64 
					                                       f32_4 %223 = OpVectorShuffle %222 %221 4 5 2 3 
					                                                      OpStore %64 %223 
					                                       f32_4 %224 = OpLoad %64 
					                                       f32_2 %225 = OpVectorShuffle %224 %224 0 1 
					                                Uniform f32* %226 = OpAccessChain %16 %35 
					                                         f32 %227 = OpLoad %226 
					                                       f32_2 %228 = OpCompositeConstruct %227 %227 
					                                       f32_2 %229 = OpExtInst %1 37 %225 %228 
					                                       f32_4 %230 = OpLoad %64 
					                                       f32_4 %231 = OpVectorShuffle %230 %229 4 5 2 3 
					                                                      OpStore %64 %231 
					                         read_only Texture2D %233 = OpLoad %232 
					                                     sampler %235 = OpLoad %234 
					                  read_only Texture2DSampled %236 = OpSampledImage %233 %235 
					                                       f32_4 %237 = OpLoad %64 
					                                       f32_2 %238 = OpVectorShuffle %237 %237 0 1 
					                                       f32_4 %239 = OpImageSampleImplicitLod %236 %238 
					                                                      OpStore %113 %239 
					                                         f32 %240 = OpLoad %206 
					                                         f32 %241 = OpExtInst %1 31 %240 
					                                Private f32* %244 = OpAccessChain %64 %243 
					                                                      OpStore %244 %241 
					                                Private f32* %247 = OpAccessChain %64 %243 
					                                         f32 %248 = OpLoad %247 
					                                         f32 %250 = OpFMul %248 %249 
					                                Private f32* %251 = OpAccessChain %246 %243 
					                                                      OpStore %251 %250 
					                                Private f32* %252 = OpAccessChain %64 %243 
					                                         f32 %253 = OpLoad %252 
					                                Uniform f32* %256 = OpAccessChain %16 %254 %255 
					                                         f32 %257 = OpLoad %256 
					                                         f32 %258 = OpFMul %253 %257 
					                                Private f32* %259 = OpAccessChain %64 %243 
					                                                      OpStore %259 %258 
					                                Private f32* %260 = OpAccessChain %246 %243 
					                                         f32 %261 = OpLoad %260 
					                                         f32 %263 = OpExtInst %1 37 %261 %262 
					                                Private f32* %264 = OpAccessChain %246 %243 
					                                                      OpStore %264 %263 
					                                Private f32* %265 = OpAccessChain %246 %243 
					                                         f32 %266 = OpLoad %265 
					                                         f32 %268 = OpFMul %266 %267 
					                                         f32 %269 = OpFAdd %268 %118 
					                                Private f32* %270 = OpAccessChain %246 %243 
					                                                      OpStore %270 %269 
					                                       f32_3 %271 = OpLoad %246 
					                                       f32_3 %272 = OpVectorShuffle %271 %271 0 0 0 
					                                       f32_3 %273 = OpFNegate %272 
					                                         f32 %274 = OpLoad %166 
					                                       f32_3 %275 = OpCompositeConstruct %274 %274 %274 
					                                       f32_3 %276 = OpExtInst %1 4 %275 
					                                       f32_3 %277 = OpFMul %273 %276 
					                                       f32_4 %278 = OpLoad %109 
					                                       f32_3 %279 = OpVectorShuffle %278 %278 0 1 2 
					                                       f32_3 %280 = OpFAdd %277 %279 
					                                       f32_4 %281 = OpLoad %109 
					                                       f32_4 %282 = OpVectorShuffle %281 %280 4 5 6 3 
					                                                      OpStore %109 %282 
					                                       f32_3 %283 = OpLoad %246 
					                                       f32_3 %284 = OpVectorShuffle %283 %283 0 0 0 
					                                         f32 %285 = OpLoad %166 
					                                       f32_3 %286 = OpCompositeConstruct %285 %285 %285 
					                                       f32_3 %287 = OpExtInst %1 4 %286 
					                                       f32_3 %288 = OpFMul %284 %287 
					                                       f32_4 %289 = OpLoad %9 
					                                       f32_3 %290 = OpVectorShuffle %289 %289 0 1 2 
					                                       f32_3 %291 = OpFAdd %288 %290 
					                                       f32_4 %292 = OpLoad %9 
					                                       f32_4 %293 = OpVectorShuffle %292 %291 4 5 6 3 
					                                                      OpStore %9 %293 
					                                       f32_4 %294 = OpLoad %109 
					                                       f32_3 %295 = OpVectorShuffle %294 %294 0 1 2 
					                                       f32_3 %296 = OpFNegate %295 
					                                       f32_4 %297 = OpLoad %9 
					                                       f32_3 %298 = OpVectorShuffle %297 %297 0 1 2 
					                                       f32_3 %299 = OpFAdd %296 %298 
					                                                      OpStore %246 %299 
					                                       f32_4 %300 = OpLoad %109 
					                                       f32_3 %301 = OpVectorShuffle %300 %300 0 1 2 
					                                       f32_4 %302 = OpLoad %9 
					                                       f32_3 %303 = OpVectorShuffle %302 %302 0 1 2 
					                                       f32_3 %304 = OpFAdd %301 %303 
					                                       f32_4 %305 = OpLoad %9 
					                                       f32_4 %306 = OpVectorShuffle %305 %304 4 5 6 3 
					                                                      OpStore %9 %306 
					                                       f32_3 %307 = OpLoad %246 
					                                       f32_3 %309 = OpFMul %307 %308 
					                                                      OpStore %246 %309 
					                                       f32_4 %310 = OpLoad %9 
					                                       f32_3 %311 = OpVectorShuffle %310 %310 0 1 2 
					                                       f32_3 %312 = OpFNegate %311 
					                                       f32_3 %313 = OpFMul %312 %308 
					                                       f32_4 %314 = OpLoad %113 
					                                       f32_3 %315 = OpVectorShuffle %314 %314 0 1 2 
					                                       f32_3 %316 = OpFAdd %313 %315 
					                                       f32_4 %317 = OpLoad %109 
					                                       f32_4 %318 = OpVectorShuffle %317 %316 4 5 6 3 
					                                                      OpStore %109 %318 
					                                       f32_4 %319 = OpLoad %9 
					                                       f32_3 %320 = OpVectorShuffle %319 %319 0 1 2 
					                                       f32_3 %321 = OpFMul %320 %308 
					                                       f32_4 %322 = OpLoad %9 
					                                       f32_4 %323 = OpVectorShuffle %322 %321 4 5 6 3 
					                                                      OpStore %9 %323 
					                                       f32_4 %325 = OpLoad %109 
					                                       f32_3 %326 = OpVectorShuffle %325 %325 0 1 2 
					                                       f32_3 %329 = OpFAdd %326 %328 
					                                                      OpStore %324 %329 
					                                       f32_3 %330 = OpLoad %246 
					                                       f32_3 %331 = OpLoad %324 
					                                       f32_3 %332 = OpFDiv %330 %331 
					                                                      OpStore %246 %332 
					                                Private f32* %334 = OpAccessChain %246 %333 
					                                         f32 %335 = OpLoad %334 
					                                         f32 %336 = OpExtInst %1 4 %335 
					                                Private f32* %337 = OpAccessChain %246 %243 
					                                         f32 %338 = OpLoad %337 
					                                         f32 %339 = OpExtInst %1 4 %338 
					                                         f32 %340 = OpExtInst %1 37 %336 %339 
					                                                      OpStore %166 %340 
					                                Private f32* %341 = OpAccessChain %246 %255 
					                                         f32 %342 = OpLoad %341 
					                                         f32 %343 = OpExtInst %1 4 %342 
					                                         f32 %344 = OpLoad %166 
					                                         f32 %345 = OpExtInst %1 37 %343 %344 
					                                                      OpStore %166 %345 
					                                         f32 %346 = OpLoad %166 
					                                         f32 %347 = OpExtInst %1 37 %346 %262 
					                                                      OpStore %166 %347 
					                                       f32_4 %348 = OpLoad %109 
					                                       f32_3 %349 = OpVectorShuffle %348 %348 0 1 2 
					                                         f32 %350 = OpLoad %166 
					                                       f32_3 %351 = OpCompositeConstruct %350 %350 %350 
					                                       f32_3 %352 = OpFMul %349 %351 
					                                       f32_4 %353 = OpLoad %9 
					                                       f32_3 %354 = OpVectorShuffle %353 %353 0 1 2 
					                                       f32_3 %355 = OpFAdd %352 %354 
					                                       f32_4 %356 = OpLoad %113 
					                                       f32_4 %357 = OpVectorShuffle %356 %355 4 5 6 3 
					                                                      OpStore %113 %357 
					                                       f32_4 %358 = OpLoad %84 
					                                       f32_4 %359 = OpFNegate %358 
					                                       f32_4 %360 = OpLoad %113 
					                                       f32_4 %361 = OpFAdd %359 %360 
					                                                      OpStore %9 %361 
					                                Uniform f32* %362 = OpAccessChain %16 %254 %243 
					                                         f32 %363 = OpLoad %362 
					                                         f32 %364 = OpFNegate %363 
					                                Uniform f32* %365 = OpAccessChain %16 %254 %333 
					                                         f32 %366 = OpLoad %365 
					                                         f32 %367 = OpFAdd %364 %366 
					                                Private f32* %368 = OpAccessChain %246 %243 
					                                                      OpStore %368 %367 
					                                Private f32* %369 = OpAccessChain %64 %243 
					                                         f32 %370 = OpLoad %369 
					                                Private f32* %371 = OpAccessChain %246 %243 
					                                         f32 %372 = OpLoad %371 
					                                         f32 %373 = OpFMul %370 %372 
					                                Uniform f32* %374 = OpAccessChain %16 %254 %243 
					                                         f32 %375 = OpLoad %374 
					                                         f32 %376 = OpFAdd %373 %375 
					                                Private f32* %377 = OpAccessChain %64 %243 
					                                                      OpStore %377 %376 
					                                Private f32* %378 = OpAccessChain %64 %243 
					                                         f32 %379 = OpLoad %378 
					                                Uniform f32* %380 = OpAccessChain %16 %254 %333 
					                                         f32 %381 = OpLoad %380 
					                                         f32 %382 = OpExtInst %1 40 %379 %381 
					                                Private f32* %383 = OpAccessChain %64 %243 
					                                                      OpStore %383 %382 
					                                Private f32* %384 = OpAccessChain %64 %243 
					                                         f32 %385 = OpLoad %384 
					                                Uniform f32* %386 = OpAccessChain %16 %254 %243 
					                                         f32 %387 = OpLoad %386 
					                                         f32 %388 = OpExtInst %1 37 %385 %387 
					                                Private f32* %389 = OpAccessChain %64 %243 
					                                                      OpStore %389 %388 
					                                       f32_4 %390 = OpLoad %64 
					                                       f32_4 %391 = OpVectorShuffle %390 %390 0 0 0 0 
					                                       f32_4 %392 = OpLoad %9 
					                                       f32_4 %393 = OpFMul %391 %392 
					                                       f32_4 %394 = OpLoad %84 
					                                       f32_4 %395 = OpFAdd %393 %394 
					                                                      OpStore %9 %395 
					                                       f32_4 %396 = OpLoad %9 
					                                       f32_4 %397 = OpExtInst %1 40 %396 %144 
					                                                      OpStore %9 %397 
					                                       f32_4 %398 = OpLoad %9 
					                                       f32_4 %399 = OpExtInst %1 37 %398 %148 
					                                                      OpStore %9 %399 
					                                       f32_4 %402 = OpLoad %9 
					                                                      OpStore %401 %402 
					                                       f32_4 %404 = OpLoad %9 
					                                                      OpStore %403 %404 
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
						vec2 _Jitter;
						vec4 _FinalBlendParameters;
						float _Sharpness;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _HistoryTex;
					uniform  sampler2D _CameraMotionVectorsTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat7;
					vec2 u_xlat12;
					float u_xlat13;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xy + (-_Jitter.xy);
					    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.xy = min(u_xlat0.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat12.xy = (-_MainTex_TexelSize.xy) * vec2(0.5, 0.5) + u_xlat0.xy;
					    u_xlat12.xy = max(u_xlat12.xy, vec2(0.0, 0.0));
					    u_xlat12.xy = min(u_xlat12.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat1 = texture(_MainTex, u_xlat12.xy);
					    u_xlat12.xy = _MainTex_TexelSize.xy * vec2(0.5, 0.5) + u_xlat0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.xy = max(u_xlat12.xy, vec2(0.0, 0.0));
					    u_xlat0.xy = min(u_xlat0.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat3 = u_xlat0 + u_xlat1;
					    u_xlat4 = u_xlat2 + u_xlat2;
					    u_xlat3 = u_xlat3 * vec4(4.0, 4.0, 4.0, 4.0) + (-u_xlat4);
					    u_xlat4 = (-u_xlat3) * vec4(0.166666999, 0.166666999, 0.166666999, 0.166666999) + u_xlat2;
					    u_xlat4 = u_xlat4 * vec4(_Sharpness);
					    u_xlat2 = u_xlat4 * vec4(2.71828198, 2.71828198, 2.71828198, 2.71828198) + u_xlat2;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = min(u_xlat2, vec4(65472.0, 65472.0, 65472.0, 65472.0));
					    u_xlat3.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.142857, 0.142857, 0.142857);
					    u_xlat18 = dot(u_xlat3.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat19 = dot(u_xlat2.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat18 = u_xlat18 + (-u_xlat19);
					    u_xlat3.xyz = min(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat1 = texture(_CameraMotionVectorsTexture, vs_TEXCOORD1.xy);
					    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = (-u_xlat1.xy) + vs_TEXCOORD1.xy;
					    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
					    u_xlat1.xy = min(u_xlat1.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat4 = texture(_HistoryTex, u_xlat1.xy);
					    u_xlat1.x = sqrt(u_xlat13);
					    u_xlat7.x = u_xlat1.x * 100.0;
					    u_xlat1.x = u_xlat1.x * _FinalBlendParameters.z;
					    u_xlat7.x = min(u_xlat7.x, 1.0);
					    u_xlat7.x = u_xlat7.x * -3.75 + 4.0;
					    u_xlat3.xyz = (-u_xlat7.xxx) * abs(vec3(u_xlat18)) + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat7.xxx * abs(vec3(u_xlat18)) + u_xlat0.xyz;
					    u_xlat7.xyz = (-u_xlat3.xyz) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
					    u_xlat7.xyz = u_xlat7.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat3.xyz = (-u_xlat0.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat5.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
					    u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					    u_xlat18 = min(abs(u_xlat7.y), abs(u_xlat7.x));
					    u_xlat18 = min(abs(u_xlat7.z), u_xlat18);
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    u_xlat0 = (-u_xlat2) + u_xlat4;
					    u_xlat7.x = (-_FinalBlendParameters.x) + _FinalBlendParameters.y;
					    u_xlat1.x = u_xlat1.x * u_xlat7.x + _FinalBlendParameters.x;
					    u_xlat1.x = max(u_xlat1.x, _FinalBlendParameters.y);
					    u_xlat1.x = min(u_xlat1.x, _FinalBlendParameters.x);
					    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = min(u_xlat0, vec4(65472.0, 65472.0, 65472.0, 65472.0));
					    SV_Target0 = u_xlat0;
					    SV_Target1 = u_xlat0;
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