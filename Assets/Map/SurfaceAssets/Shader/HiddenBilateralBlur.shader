Shader "Hidden/BilateralBlur" {
	Properties {
		_MainTex ("Texture", any) = "" {}
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 33181
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
					UNITY_LOCATION(0) uniform  sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat6;
					float u_xlat7;
					float u_xlat15;
					float u_xlat16;
					float u_xlat17;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-5, 0));
					    u_xlat1 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-6, 0));
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-7, 0));
					    u_xlat4 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(-7, 0));
					    u_xlat15 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat15 = float(1.0) / u_xlat15;
					    u_xlat4 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat16 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat16 = float(1.0) / u_xlat16;
					    u_xlat15 = (-u_xlat15) + u_xlat16;
					    u_xlat15 = abs(u_xlat15) * 0.5;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat15 = u_xlat15 * -1.44269502;
					    u_xlat15 = exp2(u_xlat15);
					    u_xlat18 = u_xlat15 * 0.0277537704;
					    u_xlat15 = u_xlat15 * 0.0277537704 + 0.0854876339;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.0854876339, 0.0854876339, 0.0854876339) + u_xlat3.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(-6, 0));
					    u_xlat17 = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat17 = float(1.0) / u_xlat17;
					    u_xlat17 = u_xlat16 + (-u_xlat17);
					    u_xlat17 = abs(u_xlat17) * 0.5;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat17 = u_xlat17 * -1.44269502;
					    u_xlat17 = exp2(u_xlat17);
					    u_xlat3.x = u_xlat17 * 0.03740637;
					    u_xlat15 = u_xlat17 * 0.03740637 + u_xlat15;
					    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(-5, 0));
					    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.x = u_xlat16 + (-u_xlat2.x);
					    u_xlat2.x = abs(u_xlat2.x) * 0.5;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * -1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat7 = u_xlat2.x * 0.048153419;
					    u_xlat15 = u_xlat2.x * 0.048153419 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat7) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-4, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(-4, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0592061132;
					    u_xlat15 = u_xlat1.x * 0.0592061132 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-3, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(-3, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0695286617;
					    u_xlat15 = u_xlat1.x * 0.0695286617 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-2, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(-2, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0779864416;
					    u_xlat15 = u_xlat1.x * 0.0779864416 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-1, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(-1, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0835472643;
					    u_xlat15 = u_xlat1.x * 0.0835472643 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(1, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(1, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0835472643;
					    u_xlat15 = u_xlat1.x * 0.0835472643 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(2, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(2, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0779864416;
					    u_xlat15 = u_xlat1.x * 0.0779864416 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(3, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(3, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0695286617;
					    u_xlat15 = u_xlat1.x * 0.0695286617 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(4, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(4, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0592061132;
					    u_xlat15 = u_xlat1.x * 0.0592061132 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(5, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(5, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.048153419;
					    u_xlat15 = u_xlat1.x * 0.048153419 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(6, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(6, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.03740637;
					    u_xlat15 = u_xlat1.x * 0.03740637 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(7, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(7, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0277537704;
					    u_xlat15 = u_xlat1.x * 0.0277537704 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz / vec3(u_xlat15);
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
					; Bound: 986
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %138 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %59 DescriptorSet 59 
					                                             OpDecorate %59 Binding 59 
					                                             OpDecorate %61 DescriptorSet 61 
					                                             OpDecorate %61 Binding 61 
					                                             OpMemberDecorate %69 0 Offset 69 
					                                             OpDecorate %69 Block 
					                                             OpDecorate %71 DescriptorSet 71 
					                                             OpDecorate %71 Binding 71 
					                                             OpDecorate %138 Location 138 
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
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %24 = OpTypeInt 32 1 
					                                     %25 = OpTypeVector %24 2 
					                                 i32 %26 = OpConstant -5 
					                                 i32 %27 = OpConstant 0 
					                               i32_2 %28 = OpConstantComposite %26 %27 
					                                     %29 = OpTypeVector %6 4 
					                      Private f32_3* %32 = OpVariable Private 
					                                 i32 %37 = OpConstant -6 
					                               i32_2 %38 = OpConstantComposite %37 %27 
					                                     %41 = OpTypePointer Private %29 
					                      Private f32_4* %42 = OpVariable Private 
					                      Private f32_3* %48 = OpVariable Private 
					                                 i32 %53 = OpConstant -7 
					                               i32_2 %54 = OpConstantComposite %53 %27 
					                                     %57 = OpTypePointer Private %6 
					                        Private f32* %58 = OpVariable Private 
					UniformConstant read_only Texture2D* %59 = OpVariable UniformConstant 
					            UniformConstant sampler* %61 = OpVariable UniformConstant 
					                                     %66 = OpTypeInt 32 0 
					                                 u32 %67 = OpConstant 0 
					                                     %69 = OpTypeStruct %29 
					                                     %70 = OpTypePointer Uniform %69 
					            Uniform struct {f32_4;}* %71 = OpVariable Uniform 
					                                 u32 %72 = OpConstant 2 
					                                     %73 = OpTypePointer Uniform %6 
					                                 u32 %78 = OpConstant 3 
					                                 f32 %82 = OpConstant 3,674022E-40 
					                        Private f32* %85 = OpVariable Private 
					                                f32 %107 = OpConstant 3,674022E-40 
					                                f32 %113 = OpConstant 3,674022E-40 
					                       Private f32* %117 = OpVariable Private 
					                                f32 %119 = OpConstant 3,674022E-40 
					                                f32 %123 = OpConstant 3,674022E-40 
					                              f32_3 %131 = OpConstantComposite %123 %123 %123 
					                                    %137 = OpTypePointer Output %29 
					                      Output f32_4* %138 = OpVariable Output 
					                                    %141 = OpTypePointer Output %6 
					                       Private f32* %143 = OpVariable Private 
					                                f32 %174 = OpConstant 3,674022E-40 
					                       Private f32* %233 = OpVariable Private 
					                                f32 %236 = OpConstant 3,674022E-40 
					                                i32 %253 = OpConstant -4 
					                              i32_2 %254 = OpConstantComposite %253 %27 
					                                f32 %304 = OpConstant 3,674022E-40 
					                                i32 %321 = OpConstant -3 
					                              i32_2 %322 = OpConstantComposite %321 %27 
					                                f32 %372 = OpConstant 3,674022E-40 
					                                i32 %389 = OpConstant -2 
					                              i32_2 %390 = OpConstantComposite %389 %27 
					                                f32 %440 = OpConstant 3,674022E-40 
					                                i32 %457 = OpConstant -1 
					                              i32_2 %458 = OpConstantComposite %457 %27 
					                                f32 %508 = OpConstant 3,674022E-40 
					                                i32 %525 = OpConstant 1 
					                              i32_2 %526 = OpConstantComposite %525 %27 
					                                i32 %592 = OpConstant 2 
					                              i32_2 %593 = OpConstantComposite %592 %27 
					                                i32 %659 = OpConstant 3 
					                              i32_2 %660 = OpConstantComposite %659 %27 
					                                i32 %726 = OpConstant 4 
					                              i32_2 %727 = OpConstantComposite %726 %27 
					                                i32 %793 = OpConstant 5 
					                              i32_2 %794 = OpConstantComposite %793 %27 
					                                i32 %860 = OpConstant 6 
					                              i32_2 %861 = OpConstantComposite %860 %27 
					                                i32 %927 = OpConstant 7 
					                              i32_2 %928 = OpConstantComposite %927 %27 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %30 = OpImageSampleImplicitLod %19 %23 ConstOffset %29 
					                               f32_3 %31 = OpVectorShuffle %30 %30 0 1 2 
					                                             OpStore %9 %31 
					                 read_only Texture2D %33 = OpLoad %12 
					                             sampler %34 = OpLoad %16 
					          read_only Texture2DSampled %35 = OpSampledImage %33 %34 
					                               f32_2 %36 = OpLoad vs_TEXCOORD0 
					                               f32_4 %39 = OpImageSampleImplicitLod %35 %36 ConstOffset %29 
					                               f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
					                                             OpStore %32 %40 
					                 read_only Texture2D %43 = OpLoad %12 
					                             sampler %44 = OpLoad %16 
					          read_only Texture2DSampled %45 = OpSampledImage %43 %44 
					                               f32_2 %46 = OpLoad vs_TEXCOORD0 
					                               f32_4 %47 = OpImageSampleImplicitLod %45 %46 
					                                             OpStore %42 %47 
					                 read_only Texture2D %49 = OpLoad %12 
					                             sampler %50 = OpLoad %16 
					          read_only Texture2DSampled %51 = OpSampledImage %49 %50 
					                               f32_2 %52 = OpLoad vs_TEXCOORD0 
					                               f32_4 %55 = OpImageSampleImplicitLod %51 %52 ConstOffset %29 
					                               f32_3 %56 = OpVectorShuffle %55 %55 0 1 2 
					                                             OpStore %48 %56 
					                 read_only Texture2D %60 = OpLoad %59 
					                             sampler %62 = OpLoad %61 
					          read_only Texture2DSampled %63 = OpSampledImage %60 %62 
					                               f32_2 %64 = OpLoad vs_TEXCOORD0 
					                               f32_4 %65 = OpImageSampleImplicitLod %63 %64 ConstOffset %29 
					                                 f32 %68 = OpCompositeExtract %65 0 
					                                             OpStore %58 %68 
					                        Uniform f32* %74 = OpAccessChain %71 %27 %72 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpLoad %58 
					                                 f32 %77 = OpFMul %75 %76 
					                        Uniform f32* %79 = OpAccessChain %71 %27 %78 
					                                 f32 %80 = OpLoad %79 
					                                 f32 %81 = OpFAdd %77 %80 
					                                             OpStore %58 %81 
					                                 f32 %83 = OpLoad %58 
					                                 f32 %84 = OpFDiv %82 %83 
					                                             OpStore %58 %84 
					                 read_only Texture2D %86 = OpLoad %59 
					                             sampler %87 = OpLoad %61 
					          read_only Texture2DSampled %88 = OpSampledImage %86 %87 
					                               f32_2 %89 = OpLoad vs_TEXCOORD0 
					                               f32_4 %90 = OpImageSampleImplicitLod %88 %89 
					                                 f32 %91 = OpCompositeExtract %90 0 
					                                             OpStore %85 %91 
					                        Uniform f32* %92 = OpAccessChain %71 %27 %72 
					                                 f32 %93 = OpLoad %92 
					                                 f32 %94 = OpLoad %85 
					                                 f32 %95 = OpFMul %93 %94 
					                        Uniform f32* %96 = OpAccessChain %71 %27 %78 
					                                 f32 %97 = OpLoad %96 
					                                 f32 %98 = OpFAdd %95 %97 
					                                             OpStore %85 %98 
					                                 f32 %99 = OpLoad %85 
					                                f32 %100 = OpFDiv %82 %99 
					                                             OpStore %85 %100 
					                                f32 %101 = OpLoad %58 
					                                f32 %102 = OpFNegate %101 
					                                f32 %103 = OpLoad %85 
					                                f32 %104 = OpFAdd %102 %103 
					                                             OpStore %58 %104 
					                                f32 %105 = OpLoad %58 
					                                f32 %106 = OpExtInst %1 4 %105 
					                                f32 %108 = OpFMul %106 %107 
					                                             OpStore %58 %108 
					                                f32 %109 = OpLoad %58 
					                                f32 %110 = OpLoad %58 
					                                f32 %111 = OpFMul %109 %110 
					                                             OpStore %58 %111 
					                                f32 %112 = OpLoad %58 
					                                f32 %114 = OpFMul %112 %113 
					                                             OpStore %58 %114 
					                                f32 %115 = OpLoad %58 
					                                f32 %116 = OpExtInst %1 29 %115 
					                                             OpStore %58 %116 
					                                f32 %118 = OpLoad %58 
					                                f32 %120 = OpFMul %118 %119 
					                                             OpStore %117 %120 
					                                f32 %121 = OpLoad %58 
					                                f32 %122 = OpFMul %121 %119 
					                                f32 %124 = OpFAdd %122 %123 
					                                             OpStore %58 %124 
					                              f32_3 %125 = OpLoad %48 
					                                f32 %126 = OpLoad %117 
					                              f32_3 %127 = OpCompositeConstruct %126 %126 %126 
					                              f32_3 %128 = OpFMul %125 %127 
					                                             OpStore %48 %128 
					                              f32_4 %129 = OpLoad %42 
					                              f32_3 %130 = OpVectorShuffle %129 %129 0 1 2 
					                              f32_3 %132 = OpFMul %130 %131 
					                              f32_3 %133 = OpLoad %48 
					                              f32_3 %134 = OpFAdd %132 %133 
					                              f32_4 %135 = OpLoad %42 
					                              f32_4 %136 = OpVectorShuffle %135 %134 4 5 6 3 
					                                             OpStore %42 %136 
					                       Private f32* %139 = OpAccessChain %42 %78 
					                                f32 %140 = OpLoad %139 
					                        Output f32* %142 = OpAccessChain %138 %78 
					                                             OpStore %142 %140 
					                read_only Texture2D %144 = OpLoad %59 
					                            sampler %145 = OpLoad %61 
					         read_only Texture2DSampled %146 = OpSampledImage %144 %145 
					                              f32_2 %147 = OpLoad vs_TEXCOORD0 
					                              f32_4 %148 = OpImageSampleImplicitLod %146 %147 ConstOffset %29 
					                                f32 %149 = OpCompositeExtract %148 0 
					                                             OpStore %143 %149 
					                       Uniform f32* %150 = OpAccessChain %71 %27 %72 
					                                f32 %151 = OpLoad %150 
					                                f32 %152 = OpLoad %143 
					                                f32 %153 = OpFMul %151 %152 
					                       Uniform f32* %154 = OpAccessChain %71 %27 %78 
					                                f32 %155 = OpLoad %154 
					                                f32 %156 = OpFAdd %153 %155 
					                                             OpStore %143 %156 
					                                f32 %157 = OpLoad %143 
					                                f32 %158 = OpFDiv %82 %157 
					                                             OpStore %143 %158 
					                                f32 %159 = OpLoad %85 
					                                f32 %160 = OpLoad %143 
					                                f32 %161 = OpFNegate %160 
					                                f32 %162 = OpFAdd %159 %161 
					                                             OpStore %143 %162 
					                                f32 %163 = OpLoad %143 
					                                f32 %164 = OpExtInst %1 4 %163 
					                                f32 %165 = OpFMul %164 %107 
					                                             OpStore %143 %165 
					                                f32 %166 = OpLoad %143 
					                                f32 %167 = OpLoad %143 
					                                f32 %168 = OpFMul %166 %167 
					                                             OpStore %143 %168 
					                                f32 %169 = OpLoad %143 
					                                f32 %170 = OpFMul %169 %113 
					                                             OpStore %143 %170 
					                                f32 %171 = OpLoad %143 
					                                f32 %172 = OpExtInst %1 29 %171 
					                                             OpStore %143 %172 
					                                f32 %173 = OpLoad %143 
					                                f32 %175 = OpFMul %173 %174 
					                       Private f32* %176 = OpAccessChain %48 %67 
					                                             OpStore %176 %175 
					                                f32 %177 = OpLoad %143 
					                                f32 %178 = OpFMul %177 %174 
					                                f32 %179 = OpLoad %58 
					                                f32 %180 = OpFAdd %178 %179 
					                                             OpStore %58 %180 
					                              f32_3 %181 = OpLoad %48 
					                              f32_3 %182 = OpVectorShuffle %181 %181 0 0 0 
					                              f32_3 %183 = OpLoad %32 
					                              f32_3 %184 = OpFMul %182 %183 
					                              f32_4 %185 = OpLoad %42 
					                              f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                              f32_3 %187 = OpFAdd %184 %186 
					                                             OpStore %32 %187 
					                read_only Texture2D %188 = OpLoad %59 
					                            sampler %189 = OpLoad %61 
					         read_only Texture2DSampled %190 = OpSampledImage %188 %189 
					                              f32_2 %191 = OpLoad vs_TEXCOORD0 
					                              f32_4 %192 = OpImageSampleImplicitLod %190 %191 ConstOffset %29 
					                                f32 %193 = OpCompositeExtract %192 0 
					                       Private f32* %194 = OpAccessChain %42 %67 
					                                             OpStore %194 %193 
					                       Uniform f32* %195 = OpAccessChain %71 %27 %72 
					                                f32 %196 = OpLoad %195 
					                       Private f32* %197 = OpAccessChain %42 %67 
					                                f32 %198 = OpLoad %197 
					                                f32 %199 = OpFMul %196 %198 
					                       Uniform f32* %200 = OpAccessChain %71 %27 %78 
					                                f32 %201 = OpLoad %200 
					                                f32 %202 = OpFAdd %199 %201 
					                       Private f32* %203 = OpAccessChain %42 %67 
					                                             OpStore %203 %202 
					                       Private f32* %204 = OpAccessChain %42 %67 
					                                f32 %205 = OpLoad %204 
					                                f32 %206 = OpFDiv %82 %205 
					                       Private f32* %207 = OpAccessChain %42 %67 
					                                             OpStore %207 %206 
					                                f32 %208 = OpLoad %85 
					                       Private f32* %209 = OpAccessChain %42 %67 
					                                f32 %210 = OpLoad %209 
					                                f32 %211 = OpFNegate %210 
					                                f32 %212 = OpFAdd %208 %211 
					                       Private f32* %213 = OpAccessChain %42 %67 
					                                             OpStore %213 %212 
					                       Private f32* %214 = OpAccessChain %42 %67 
					                                f32 %215 = OpLoad %214 
					                                f32 %216 = OpExtInst %1 4 %215 
					                                f32 %217 = OpFMul %216 %107 
					                       Private f32* %218 = OpAccessChain %42 %67 
					                                             OpStore %218 %217 
					                       Private f32* %219 = OpAccessChain %42 %67 
					                                f32 %220 = OpLoad %219 
					                       Private f32* %221 = OpAccessChain %42 %67 
					                                f32 %222 = OpLoad %221 
					                                f32 %223 = OpFMul %220 %222 
					                       Private f32* %224 = OpAccessChain %42 %67 
					                                             OpStore %224 %223 
					                       Private f32* %225 = OpAccessChain %42 %67 
					                                f32 %226 = OpLoad %225 
					                                f32 %227 = OpFMul %226 %113 
					                       Private f32* %228 = OpAccessChain %42 %67 
					                                             OpStore %228 %227 
					                       Private f32* %229 = OpAccessChain %42 %67 
					                                f32 %230 = OpLoad %229 
					                                f32 %231 = OpExtInst %1 29 %230 
					                       Private f32* %232 = OpAccessChain %42 %67 
					                                             OpStore %232 %231 
					                       Private f32* %234 = OpAccessChain %42 %67 
					                                f32 %235 = OpLoad %234 
					                                f32 %237 = OpFMul %235 %236 
					                                             OpStore %233 %237 
					                       Private f32* %238 = OpAccessChain %42 %67 
					                                f32 %239 = OpLoad %238 
					                                f32 %240 = OpFMul %239 %236 
					                                f32 %241 = OpLoad %58 
					                                f32 %242 = OpFAdd %240 %241 
					                                             OpStore %58 %242 
					                                f32 %243 = OpLoad %233 
					                              f32_3 %244 = OpCompositeConstruct %243 %243 %243 
					                              f32_3 %245 = OpLoad %9 
					                              f32_3 %246 = OpFMul %244 %245 
					                              f32_3 %247 = OpLoad %32 
					                              f32_3 %248 = OpFAdd %246 %247 
					                                             OpStore %9 %248 
					                read_only Texture2D %249 = OpLoad %12 
					                            sampler %250 = OpLoad %16 
					         read_only Texture2DSampled %251 = OpSampledImage %249 %250 
					                              f32_2 %252 = OpLoad vs_TEXCOORD0 
					                              f32_4 %255 = OpImageSampleImplicitLod %251 %252 ConstOffset %29 
					                              f32_3 %256 = OpVectorShuffle %255 %255 0 1 2 
					                                             OpStore %32 %256 
					                read_only Texture2D %257 = OpLoad %59 
					                            sampler %258 = OpLoad %61 
					         read_only Texture2DSampled %259 = OpSampledImage %257 %258 
					                              f32_2 %260 = OpLoad vs_TEXCOORD0 
					                              f32_4 %261 = OpImageSampleImplicitLod %259 %260 ConstOffset %29 
					                                f32 %262 = OpCompositeExtract %261 0 
					                       Private f32* %263 = OpAccessChain %42 %67 
					                                             OpStore %263 %262 
					                       Uniform f32* %264 = OpAccessChain %71 %27 %72 
					                                f32 %265 = OpLoad %264 
					                       Private f32* %266 = OpAccessChain %42 %67 
					                                f32 %267 = OpLoad %266 
					                                f32 %268 = OpFMul %265 %267 
					                       Uniform f32* %269 = OpAccessChain %71 %27 %78 
					                                f32 %270 = OpLoad %269 
					                                f32 %271 = OpFAdd %268 %270 
					                       Private f32* %272 = OpAccessChain %42 %67 
					                                             OpStore %272 %271 
					                       Private f32* %273 = OpAccessChain %42 %67 
					                                f32 %274 = OpLoad %273 
					                                f32 %275 = OpFDiv %82 %274 
					                       Private f32* %276 = OpAccessChain %42 %67 
					                                             OpStore %276 %275 
					                                f32 %277 = OpLoad %85 
					                       Private f32* %278 = OpAccessChain %42 %67 
					                                f32 %279 = OpLoad %278 
					                                f32 %280 = OpFNegate %279 
					                                f32 %281 = OpFAdd %277 %280 
					                       Private f32* %282 = OpAccessChain %42 %67 
					                                             OpStore %282 %281 
					                       Private f32* %283 = OpAccessChain %42 %67 
					                                f32 %284 = OpLoad %283 
					                                f32 %285 = OpExtInst %1 4 %284 
					                                f32 %286 = OpFMul %285 %107 
					                       Private f32* %287 = OpAccessChain %42 %67 
					                                             OpStore %287 %286 
					                       Private f32* %288 = OpAccessChain %42 %67 
					                                f32 %289 = OpLoad %288 
					                       Private f32* %290 = OpAccessChain %42 %67 
					                                f32 %291 = OpLoad %290 
					                                f32 %292 = OpFMul %289 %291 
					                       Private f32* %293 = OpAccessChain %42 %67 
					                                             OpStore %293 %292 
					                       Private f32* %294 = OpAccessChain %42 %67 
					                                f32 %295 = OpLoad %294 
					                                f32 %296 = OpFMul %295 %113 
					                       Private f32* %297 = OpAccessChain %42 %67 
					                                             OpStore %297 %296 
					                       Private f32* %298 = OpAccessChain %42 %67 
					                                f32 %299 = OpLoad %298 
					                                f32 %300 = OpExtInst %1 29 %299 
					                       Private f32* %301 = OpAccessChain %42 %67 
					                                             OpStore %301 %300 
					                       Private f32* %302 = OpAccessChain %42 %67 
					                                f32 %303 = OpLoad %302 
					                                f32 %305 = OpFMul %303 %304 
					                                             OpStore %233 %305 
					                       Private f32* %306 = OpAccessChain %42 %67 
					                                f32 %307 = OpLoad %306 
					                                f32 %308 = OpFMul %307 %304 
					                                f32 %309 = OpLoad %58 
					                                f32 %310 = OpFAdd %308 %309 
					                                             OpStore %58 %310 
					                                f32 %311 = OpLoad %233 
					                              f32_3 %312 = OpCompositeConstruct %311 %311 %311 
					                              f32_3 %313 = OpLoad %32 
					                              f32_3 %314 = OpFMul %312 %313 
					                              f32_3 %315 = OpLoad %9 
					                              f32_3 %316 = OpFAdd %314 %315 
					                                             OpStore %9 %316 
					                read_only Texture2D %317 = OpLoad %12 
					                            sampler %318 = OpLoad %16 
					         read_only Texture2DSampled %319 = OpSampledImage %317 %318 
					                              f32_2 %320 = OpLoad vs_TEXCOORD0 
					                              f32_4 %323 = OpImageSampleImplicitLod %319 %320 ConstOffset %29 
					                              f32_3 %324 = OpVectorShuffle %323 %323 0 1 2 
					                                             OpStore %32 %324 
					                read_only Texture2D %325 = OpLoad %59 
					                            sampler %326 = OpLoad %61 
					         read_only Texture2DSampled %327 = OpSampledImage %325 %326 
					                              f32_2 %328 = OpLoad vs_TEXCOORD0 
					                              f32_4 %329 = OpImageSampleImplicitLod %327 %328 ConstOffset %29 
					                                f32 %330 = OpCompositeExtract %329 0 
					                       Private f32* %331 = OpAccessChain %42 %67 
					                                             OpStore %331 %330 
					                       Uniform f32* %332 = OpAccessChain %71 %27 %72 
					                                f32 %333 = OpLoad %332 
					                       Private f32* %334 = OpAccessChain %42 %67 
					                                f32 %335 = OpLoad %334 
					                                f32 %336 = OpFMul %333 %335 
					                       Uniform f32* %337 = OpAccessChain %71 %27 %78 
					                                f32 %338 = OpLoad %337 
					                                f32 %339 = OpFAdd %336 %338 
					                       Private f32* %340 = OpAccessChain %42 %67 
					                                             OpStore %340 %339 
					                       Private f32* %341 = OpAccessChain %42 %67 
					                                f32 %342 = OpLoad %341 
					                                f32 %343 = OpFDiv %82 %342 
					                       Private f32* %344 = OpAccessChain %42 %67 
					                                             OpStore %344 %343 
					                                f32 %345 = OpLoad %85 
					                       Private f32* %346 = OpAccessChain %42 %67 
					                                f32 %347 = OpLoad %346 
					                                f32 %348 = OpFNegate %347 
					                                f32 %349 = OpFAdd %345 %348 
					                       Private f32* %350 = OpAccessChain %42 %67 
					                                             OpStore %350 %349 
					                       Private f32* %351 = OpAccessChain %42 %67 
					                                f32 %352 = OpLoad %351 
					                                f32 %353 = OpExtInst %1 4 %352 
					                                f32 %354 = OpFMul %353 %107 
					                       Private f32* %355 = OpAccessChain %42 %67 
					                                             OpStore %355 %354 
					                       Private f32* %356 = OpAccessChain %42 %67 
					                                f32 %357 = OpLoad %356 
					                       Private f32* %358 = OpAccessChain %42 %67 
					                                f32 %359 = OpLoad %358 
					                                f32 %360 = OpFMul %357 %359 
					                       Private f32* %361 = OpAccessChain %42 %67 
					                                             OpStore %361 %360 
					                       Private f32* %362 = OpAccessChain %42 %67 
					                                f32 %363 = OpLoad %362 
					                                f32 %364 = OpFMul %363 %113 
					                       Private f32* %365 = OpAccessChain %42 %67 
					                                             OpStore %365 %364 
					                       Private f32* %366 = OpAccessChain %42 %67 
					                                f32 %367 = OpLoad %366 
					                                f32 %368 = OpExtInst %1 29 %367 
					                       Private f32* %369 = OpAccessChain %42 %67 
					                                             OpStore %369 %368 
					                       Private f32* %370 = OpAccessChain %42 %67 
					                                f32 %371 = OpLoad %370 
					                                f32 %373 = OpFMul %371 %372 
					                                             OpStore %233 %373 
					                       Private f32* %374 = OpAccessChain %42 %67 
					                                f32 %375 = OpLoad %374 
					                                f32 %376 = OpFMul %375 %372 
					                                f32 %377 = OpLoad %58 
					                                f32 %378 = OpFAdd %376 %377 
					                                             OpStore %58 %378 
					                                f32 %379 = OpLoad %233 
					                              f32_3 %380 = OpCompositeConstruct %379 %379 %379 
					                              f32_3 %381 = OpLoad %32 
					                              f32_3 %382 = OpFMul %380 %381 
					                              f32_3 %383 = OpLoad %9 
					                              f32_3 %384 = OpFAdd %382 %383 
					                                             OpStore %9 %384 
					                read_only Texture2D %385 = OpLoad %12 
					                            sampler %386 = OpLoad %16 
					         read_only Texture2DSampled %387 = OpSampledImage %385 %386 
					                              f32_2 %388 = OpLoad vs_TEXCOORD0 
					                              f32_4 %391 = OpImageSampleImplicitLod %387 %388 ConstOffset %29 
					                              f32_3 %392 = OpVectorShuffle %391 %391 0 1 2 
					                                             OpStore %32 %392 
					                read_only Texture2D %393 = OpLoad %59 
					                            sampler %394 = OpLoad %61 
					         read_only Texture2DSampled %395 = OpSampledImage %393 %394 
					                              f32_2 %396 = OpLoad vs_TEXCOORD0 
					                              f32_4 %397 = OpImageSampleImplicitLod %395 %396 ConstOffset %29 
					                                f32 %398 = OpCompositeExtract %397 0 
					                       Private f32* %399 = OpAccessChain %42 %67 
					                                             OpStore %399 %398 
					                       Uniform f32* %400 = OpAccessChain %71 %27 %72 
					                                f32 %401 = OpLoad %400 
					                       Private f32* %402 = OpAccessChain %42 %67 
					                                f32 %403 = OpLoad %402 
					                                f32 %404 = OpFMul %401 %403 
					                       Uniform f32* %405 = OpAccessChain %71 %27 %78 
					                                f32 %406 = OpLoad %405 
					                                f32 %407 = OpFAdd %404 %406 
					                       Private f32* %408 = OpAccessChain %42 %67 
					                                             OpStore %408 %407 
					                       Private f32* %409 = OpAccessChain %42 %67 
					                                f32 %410 = OpLoad %409 
					                                f32 %411 = OpFDiv %82 %410 
					                       Private f32* %412 = OpAccessChain %42 %67 
					                                             OpStore %412 %411 
					                                f32 %413 = OpLoad %85 
					                       Private f32* %414 = OpAccessChain %42 %67 
					                                f32 %415 = OpLoad %414 
					                                f32 %416 = OpFNegate %415 
					                                f32 %417 = OpFAdd %413 %416 
					                       Private f32* %418 = OpAccessChain %42 %67 
					                                             OpStore %418 %417 
					                       Private f32* %419 = OpAccessChain %42 %67 
					                                f32 %420 = OpLoad %419 
					                                f32 %421 = OpExtInst %1 4 %420 
					                                f32 %422 = OpFMul %421 %107 
					                       Private f32* %423 = OpAccessChain %42 %67 
					                                             OpStore %423 %422 
					                       Private f32* %424 = OpAccessChain %42 %67 
					                                f32 %425 = OpLoad %424 
					                       Private f32* %426 = OpAccessChain %42 %67 
					                                f32 %427 = OpLoad %426 
					                                f32 %428 = OpFMul %425 %427 
					                       Private f32* %429 = OpAccessChain %42 %67 
					                                             OpStore %429 %428 
					                       Private f32* %430 = OpAccessChain %42 %67 
					                                f32 %431 = OpLoad %430 
					                                f32 %432 = OpFMul %431 %113 
					                       Private f32* %433 = OpAccessChain %42 %67 
					                                             OpStore %433 %432 
					                       Private f32* %434 = OpAccessChain %42 %67 
					                                f32 %435 = OpLoad %434 
					                                f32 %436 = OpExtInst %1 29 %435 
					                       Private f32* %437 = OpAccessChain %42 %67 
					                                             OpStore %437 %436 
					                       Private f32* %438 = OpAccessChain %42 %67 
					                                f32 %439 = OpLoad %438 
					                                f32 %441 = OpFMul %439 %440 
					                                             OpStore %233 %441 
					                       Private f32* %442 = OpAccessChain %42 %67 
					                                f32 %443 = OpLoad %442 
					                                f32 %444 = OpFMul %443 %440 
					                                f32 %445 = OpLoad %58 
					                                f32 %446 = OpFAdd %444 %445 
					                                             OpStore %58 %446 
					                                f32 %447 = OpLoad %233 
					                              f32_3 %448 = OpCompositeConstruct %447 %447 %447 
					                              f32_3 %449 = OpLoad %32 
					                              f32_3 %450 = OpFMul %448 %449 
					                              f32_3 %451 = OpLoad %9 
					                              f32_3 %452 = OpFAdd %450 %451 
					                                             OpStore %9 %452 
					                read_only Texture2D %453 = OpLoad %12 
					                            sampler %454 = OpLoad %16 
					         read_only Texture2DSampled %455 = OpSampledImage %453 %454 
					                              f32_2 %456 = OpLoad vs_TEXCOORD0 
					                              f32_4 %459 = OpImageSampleImplicitLod %455 %456 ConstOffset %29 
					                              f32_3 %460 = OpVectorShuffle %459 %459 0 1 2 
					                                             OpStore %32 %460 
					                read_only Texture2D %461 = OpLoad %59 
					                            sampler %462 = OpLoad %61 
					         read_only Texture2DSampled %463 = OpSampledImage %461 %462 
					                              f32_2 %464 = OpLoad vs_TEXCOORD0 
					                              f32_4 %465 = OpImageSampleImplicitLod %463 %464 ConstOffset %29 
					                                f32 %466 = OpCompositeExtract %465 0 
					                       Private f32* %467 = OpAccessChain %42 %67 
					                                             OpStore %467 %466 
					                       Uniform f32* %468 = OpAccessChain %71 %27 %72 
					                                f32 %469 = OpLoad %468 
					                       Private f32* %470 = OpAccessChain %42 %67 
					                                f32 %471 = OpLoad %470 
					                                f32 %472 = OpFMul %469 %471 
					                       Uniform f32* %473 = OpAccessChain %71 %27 %78 
					                                f32 %474 = OpLoad %473 
					                                f32 %475 = OpFAdd %472 %474 
					                       Private f32* %476 = OpAccessChain %42 %67 
					                                             OpStore %476 %475 
					                       Private f32* %477 = OpAccessChain %42 %67 
					                                f32 %478 = OpLoad %477 
					                                f32 %479 = OpFDiv %82 %478 
					                       Private f32* %480 = OpAccessChain %42 %67 
					                                             OpStore %480 %479 
					                                f32 %481 = OpLoad %85 
					                       Private f32* %482 = OpAccessChain %42 %67 
					                                f32 %483 = OpLoad %482 
					                                f32 %484 = OpFNegate %483 
					                                f32 %485 = OpFAdd %481 %484 
					                       Private f32* %486 = OpAccessChain %42 %67 
					                                             OpStore %486 %485 
					                       Private f32* %487 = OpAccessChain %42 %67 
					                                f32 %488 = OpLoad %487 
					                                f32 %489 = OpExtInst %1 4 %488 
					                                f32 %490 = OpFMul %489 %107 
					                       Private f32* %491 = OpAccessChain %42 %67 
					                                             OpStore %491 %490 
					                       Private f32* %492 = OpAccessChain %42 %67 
					                                f32 %493 = OpLoad %492 
					                       Private f32* %494 = OpAccessChain %42 %67 
					                                f32 %495 = OpLoad %494 
					                                f32 %496 = OpFMul %493 %495 
					                       Private f32* %497 = OpAccessChain %42 %67 
					                                             OpStore %497 %496 
					                       Private f32* %498 = OpAccessChain %42 %67 
					                                f32 %499 = OpLoad %498 
					                                f32 %500 = OpFMul %499 %113 
					                       Private f32* %501 = OpAccessChain %42 %67 
					                                             OpStore %501 %500 
					                       Private f32* %502 = OpAccessChain %42 %67 
					                                f32 %503 = OpLoad %502 
					                                f32 %504 = OpExtInst %1 29 %503 
					                       Private f32* %505 = OpAccessChain %42 %67 
					                                             OpStore %505 %504 
					                       Private f32* %506 = OpAccessChain %42 %67 
					                                f32 %507 = OpLoad %506 
					                                f32 %509 = OpFMul %507 %508 
					                                             OpStore %233 %509 
					                       Private f32* %510 = OpAccessChain %42 %67 
					                                f32 %511 = OpLoad %510 
					                                f32 %512 = OpFMul %511 %508 
					                                f32 %513 = OpLoad %58 
					                                f32 %514 = OpFAdd %512 %513 
					                                             OpStore %58 %514 
					                                f32 %515 = OpLoad %233 
					                              f32_3 %516 = OpCompositeConstruct %515 %515 %515 
					                              f32_3 %517 = OpLoad %32 
					                              f32_3 %518 = OpFMul %516 %517 
					                              f32_3 %519 = OpLoad %9 
					                              f32_3 %520 = OpFAdd %518 %519 
					                                             OpStore %9 %520 
					                read_only Texture2D %521 = OpLoad %12 
					                            sampler %522 = OpLoad %16 
					         read_only Texture2DSampled %523 = OpSampledImage %521 %522 
					                              f32_2 %524 = OpLoad vs_TEXCOORD0 
					                              f32_4 %527 = OpImageSampleImplicitLod %523 %524 ConstOffset %29 
					                              f32_3 %528 = OpVectorShuffle %527 %527 0 1 2 
					                                             OpStore %32 %528 
					                read_only Texture2D %529 = OpLoad %59 
					                            sampler %530 = OpLoad %61 
					         read_only Texture2DSampled %531 = OpSampledImage %529 %530 
					                              f32_2 %532 = OpLoad vs_TEXCOORD0 
					                              f32_4 %533 = OpImageSampleImplicitLod %531 %532 ConstOffset %29 
					                                f32 %534 = OpCompositeExtract %533 0 
					                       Private f32* %535 = OpAccessChain %42 %67 
					                                             OpStore %535 %534 
					                       Uniform f32* %536 = OpAccessChain %71 %27 %72 
					                                f32 %537 = OpLoad %536 
					                       Private f32* %538 = OpAccessChain %42 %67 
					                                f32 %539 = OpLoad %538 
					                                f32 %540 = OpFMul %537 %539 
					                       Uniform f32* %541 = OpAccessChain %71 %27 %78 
					                                f32 %542 = OpLoad %541 
					                                f32 %543 = OpFAdd %540 %542 
					                       Private f32* %544 = OpAccessChain %42 %67 
					                                             OpStore %544 %543 
					                       Private f32* %545 = OpAccessChain %42 %67 
					                                f32 %546 = OpLoad %545 
					                                f32 %547 = OpFDiv %82 %546 
					                       Private f32* %548 = OpAccessChain %42 %67 
					                                             OpStore %548 %547 
					                                f32 %549 = OpLoad %85 
					                       Private f32* %550 = OpAccessChain %42 %67 
					                                f32 %551 = OpLoad %550 
					                                f32 %552 = OpFNegate %551 
					                                f32 %553 = OpFAdd %549 %552 
					                       Private f32* %554 = OpAccessChain %42 %67 
					                                             OpStore %554 %553 
					                       Private f32* %555 = OpAccessChain %42 %67 
					                                f32 %556 = OpLoad %555 
					                                f32 %557 = OpExtInst %1 4 %556 
					                                f32 %558 = OpFMul %557 %107 
					                       Private f32* %559 = OpAccessChain %42 %67 
					                                             OpStore %559 %558 
					                       Private f32* %560 = OpAccessChain %42 %67 
					                                f32 %561 = OpLoad %560 
					                       Private f32* %562 = OpAccessChain %42 %67 
					                                f32 %563 = OpLoad %562 
					                                f32 %564 = OpFMul %561 %563 
					                       Private f32* %565 = OpAccessChain %42 %67 
					                                             OpStore %565 %564 
					                       Private f32* %566 = OpAccessChain %42 %67 
					                                f32 %567 = OpLoad %566 
					                                f32 %568 = OpFMul %567 %113 
					                       Private f32* %569 = OpAccessChain %42 %67 
					                                             OpStore %569 %568 
					                       Private f32* %570 = OpAccessChain %42 %67 
					                                f32 %571 = OpLoad %570 
					                                f32 %572 = OpExtInst %1 29 %571 
					                       Private f32* %573 = OpAccessChain %42 %67 
					                                             OpStore %573 %572 
					                       Private f32* %574 = OpAccessChain %42 %67 
					                                f32 %575 = OpLoad %574 
					                                f32 %576 = OpFMul %575 %508 
					                                             OpStore %233 %576 
					                       Private f32* %577 = OpAccessChain %42 %67 
					                                f32 %578 = OpLoad %577 
					                                f32 %579 = OpFMul %578 %508 
					                                f32 %580 = OpLoad %58 
					                                f32 %581 = OpFAdd %579 %580 
					                                             OpStore %58 %581 
					                                f32 %582 = OpLoad %233 
					                              f32_3 %583 = OpCompositeConstruct %582 %582 %582 
					                              f32_3 %584 = OpLoad %32 
					                              f32_3 %585 = OpFMul %583 %584 
					                              f32_3 %586 = OpLoad %9 
					                              f32_3 %587 = OpFAdd %585 %586 
					                                             OpStore %9 %587 
					                read_only Texture2D %588 = OpLoad %12 
					                            sampler %589 = OpLoad %16 
					         read_only Texture2DSampled %590 = OpSampledImage %588 %589 
					                              f32_2 %591 = OpLoad vs_TEXCOORD0 
					                              f32_4 %594 = OpImageSampleImplicitLod %590 %591 ConstOffset %29 
					                              f32_3 %595 = OpVectorShuffle %594 %594 0 1 2 
					                                             OpStore %32 %595 
					                read_only Texture2D %596 = OpLoad %59 
					                            sampler %597 = OpLoad %61 
					         read_only Texture2DSampled %598 = OpSampledImage %596 %597 
					                              f32_2 %599 = OpLoad vs_TEXCOORD0 
					                              f32_4 %600 = OpImageSampleImplicitLod %598 %599 ConstOffset %29 
					                                f32 %601 = OpCompositeExtract %600 0 
					                       Private f32* %602 = OpAccessChain %42 %67 
					                                             OpStore %602 %601 
					                       Uniform f32* %603 = OpAccessChain %71 %27 %72 
					                                f32 %604 = OpLoad %603 
					                       Private f32* %605 = OpAccessChain %42 %67 
					                                f32 %606 = OpLoad %605 
					                                f32 %607 = OpFMul %604 %606 
					                       Uniform f32* %608 = OpAccessChain %71 %27 %78 
					                                f32 %609 = OpLoad %608 
					                                f32 %610 = OpFAdd %607 %609 
					                       Private f32* %611 = OpAccessChain %42 %67 
					                                             OpStore %611 %610 
					                       Private f32* %612 = OpAccessChain %42 %67 
					                                f32 %613 = OpLoad %612 
					                                f32 %614 = OpFDiv %82 %613 
					                       Private f32* %615 = OpAccessChain %42 %67 
					                                             OpStore %615 %614 
					                                f32 %616 = OpLoad %85 
					                       Private f32* %617 = OpAccessChain %42 %67 
					                                f32 %618 = OpLoad %617 
					                                f32 %619 = OpFNegate %618 
					                                f32 %620 = OpFAdd %616 %619 
					                       Private f32* %621 = OpAccessChain %42 %67 
					                                             OpStore %621 %620 
					                       Private f32* %622 = OpAccessChain %42 %67 
					                                f32 %623 = OpLoad %622 
					                                f32 %624 = OpExtInst %1 4 %623 
					                                f32 %625 = OpFMul %624 %107 
					                       Private f32* %626 = OpAccessChain %42 %67 
					                                             OpStore %626 %625 
					                       Private f32* %627 = OpAccessChain %42 %67 
					                                f32 %628 = OpLoad %627 
					                       Private f32* %629 = OpAccessChain %42 %67 
					                                f32 %630 = OpLoad %629 
					                                f32 %631 = OpFMul %628 %630 
					                       Private f32* %632 = OpAccessChain %42 %67 
					                                             OpStore %632 %631 
					                       Private f32* %633 = OpAccessChain %42 %67 
					                                f32 %634 = OpLoad %633 
					                                f32 %635 = OpFMul %634 %113 
					                       Private f32* %636 = OpAccessChain %42 %67 
					                                             OpStore %636 %635 
					                       Private f32* %637 = OpAccessChain %42 %67 
					                                f32 %638 = OpLoad %637 
					                                f32 %639 = OpExtInst %1 29 %638 
					                       Private f32* %640 = OpAccessChain %42 %67 
					                                             OpStore %640 %639 
					                       Private f32* %641 = OpAccessChain %42 %67 
					                                f32 %642 = OpLoad %641 
					                                f32 %643 = OpFMul %642 %440 
					                                             OpStore %233 %643 
					                       Private f32* %644 = OpAccessChain %42 %67 
					                                f32 %645 = OpLoad %644 
					                                f32 %646 = OpFMul %645 %440 
					                                f32 %647 = OpLoad %58 
					                                f32 %648 = OpFAdd %646 %647 
					                                             OpStore %58 %648 
					                                f32 %649 = OpLoad %233 
					                              f32_3 %650 = OpCompositeConstruct %649 %649 %649 
					                              f32_3 %651 = OpLoad %32 
					                              f32_3 %652 = OpFMul %650 %651 
					                              f32_3 %653 = OpLoad %9 
					                              f32_3 %654 = OpFAdd %652 %653 
					                                             OpStore %9 %654 
					                read_only Texture2D %655 = OpLoad %12 
					                            sampler %656 = OpLoad %16 
					         read_only Texture2DSampled %657 = OpSampledImage %655 %656 
					                              f32_2 %658 = OpLoad vs_TEXCOORD0 
					                              f32_4 %661 = OpImageSampleImplicitLod %657 %658 ConstOffset %29 
					                              f32_3 %662 = OpVectorShuffle %661 %661 0 1 2 
					                                             OpStore %32 %662 
					                read_only Texture2D %663 = OpLoad %59 
					                            sampler %664 = OpLoad %61 
					         read_only Texture2DSampled %665 = OpSampledImage %663 %664 
					                              f32_2 %666 = OpLoad vs_TEXCOORD0 
					                              f32_4 %667 = OpImageSampleImplicitLod %665 %666 ConstOffset %29 
					                                f32 %668 = OpCompositeExtract %667 0 
					                       Private f32* %669 = OpAccessChain %42 %67 
					                                             OpStore %669 %668 
					                       Uniform f32* %670 = OpAccessChain %71 %27 %72 
					                                f32 %671 = OpLoad %670 
					                       Private f32* %672 = OpAccessChain %42 %67 
					                                f32 %673 = OpLoad %672 
					                                f32 %674 = OpFMul %671 %673 
					                       Uniform f32* %675 = OpAccessChain %71 %27 %78 
					                                f32 %676 = OpLoad %675 
					                                f32 %677 = OpFAdd %674 %676 
					                       Private f32* %678 = OpAccessChain %42 %67 
					                                             OpStore %678 %677 
					                       Private f32* %679 = OpAccessChain %42 %67 
					                                f32 %680 = OpLoad %679 
					                                f32 %681 = OpFDiv %82 %680 
					                       Private f32* %682 = OpAccessChain %42 %67 
					                                             OpStore %682 %681 
					                                f32 %683 = OpLoad %85 
					                       Private f32* %684 = OpAccessChain %42 %67 
					                                f32 %685 = OpLoad %684 
					                                f32 %686 = OpFNegate %685 
					                                f32 %687 = OpFAdd %683 %686 
					                       Private f32* %688 = OpAccessChain %42 %67 
					                                             OpStore %688 %687 
					                       Private f32* %689 = OpAccessChain %42 %67 
					                                f32 %690 = OpLoad %689 
					                                f32 %691 = OpExtInst %1 4 %690 
					                                f32 %692 = OpFMul %691 %107 
					                       Private f32* %693 = OpAccessChain %42 %67 
					                                             OpStore %693 %692 
					                       Private f32* %694 = OpAccessChain %42 %67 
					                                f32 %695 = OpLoad %694 
					                       Private f32* %696 = OpAccessChain %42 %67 
					                                f32 %697 = OpLoad %696 
					                                f32 %698 = OpFMul %695 %697 
					                       Private f32* %699 = OpAccessChain %42 %67 
					                                             OpStore %699 %698 
					                       Private f32* %700 = OpAccessChain %42 %67 
					                                f32 %701 = OpLoad %700 
					                                f32 %702 = OpFMul %701 %113 
					                       Private f32* %703 = OpAccessChain %42 %67 
					                                             OpStore %703 %702 
					                       Private f32* %704 = OpAccessChain %42 %67 
					                                f32 %705 = OpLoad %704 
					                                f32 %706 = OpExtInst %1 29 %705 
					                       Private f32* %707 = OpAccessChain %42 %67 
					                                             OpStore %707 %706 
					                       Private f32* %708 = OpAccessChain %42 %67 
					                                f32 %709 = OpLoad %708 
					                                f32 %710 = OpFMul %709 %372 
					                                             OpStore %233 %710 
					                       Private f32* %711 = OpAccessChain %42 %67 
					                                f32 %712 = OpLoad %711 
					                                f32 %713 = OpFMul %712 %372 
					                                f32 %714 = OpLoad %58 
					                                f32 %715 = OpFAdd %713 %714 
					                                             OpStore %58 %715 
					                                f32 %716 = OpLoad %233 
					                              f32_3 %717 = OpCompositeConstruct %716 %716 %716 
					                              f32_3 %718 = OpLoad %32 
					                              f32_3 %719 = OpFMul %717 %718 
					                              f32_3 %720 = OpLoad %9 
					                              f32_3 %721 = OpFAdd %719 %720 
					                                             OpStore %9 %721 
					                read_only Texture2D %722 = OpLoad %12 
					                            sampler %723 = OpLoad %16 
					         read_only Texture2DSampled %724 = OpSampledImage %722 %723 
					                              f32_2 %725 = OpLoad vs_TEXCOORD0 
					                              f32_4 %728 = OpImageSampleImplicitLod %724 %725 ConstOffset %29 
					                              f32_3 %729 = OpVectorShuffle %728 %728 0 1 2 
					                                             OpStore %32 %729 
					                read_only Texture2D %730 = OpLoad %59 
					                            sampler %731 = OpLoad %61 
					         read_only Texture2DSampled %732 = OpSampledImage %730 %731 
					                              f32_2 %733 = OpLoad vs_TEXCOORD0 
					                              f32_4 %734 = OpImageSampleImplicitLod %732 %733 ConstOffset %29 
					                                f32 %735 = OpCompositeExtract %734 0 
					                       Private f32* %736 = OpAccessChain %42 %67 
					                                             OpStore %736 %735 
					                       Uniform f32* %737 = OpAccessChain %71 %27 %72 
					                                f32 %738 = OpLoad %737 
					                       Private f32* %739 = OpAccessChain %42 %67 
					                                f32 %740 = OpLoad %739 
					                                f32 %741 = OpFMul %738 %740 
					                       Uniform f32* %742 = OpAccessChain %71 %27 %78 
					                                f32 %743 = OpLoad %742 
					                                f32 %744 = OpFAdd %741 %743 
					                       Private f32* %745 = OpAccessChain %42 %67 
					                                             OpStore %745 %744 
					                       Private f32* %746 = OpAccessChain %42 %67 
					                                f32 %747 = OpLoad %746 
					                                f32 %748 = OpFDiv %82 %747 
					                       Private f32* %749 = OpAccessChain %42 %67 
					                                             OpStore %749 %748 
					                                f32 %750 = OpLoad %85 
					                       Private f32* %751 = OpAccessChain %42 %67 
					                                f32 %752 = OpLoad %751 
					                                f32 %753 = OpFNegate %752 
					                                f32 %754 = OpFAdd %750 %753 
					                       Private f32* %755 = OpAccessChain %42 %67 
					                                             OpStore %755 %754 
					                       Private f32* %756 = OpAccessChain %42 %67 
					                                f32 %757 = OpLoad %756 
					                                f32 %758 = OpExtInst %1 4 %757 
					                                f32 %759 = OpFMul %758 %107 
					                       Private f32* %760 = OpAccessChain %42 %67 
					                                             OpStore %760 %759 
					                       Private f32* %761 = OpAccessChain %42 %67 
					                                f32 %762 = OpLoad %761 
					                       Private f32* %763 = OpAccessChain %42 %67 
					                                f32 %764 = OpLoad %763 
					                                f32 %765 = OpFMul %762 %764 
					                       Private f32* %766 = OpAccessChain %42 %67 
					                                             OpStore %766 %765 
					                       Private f32* %767 = OpAccessChain %42 %67 
					                                f32 %768 = OpLoad %767 
					                                f32 %769 = OpFMul %768 %113 
					                       Private f32* %770 = OpAccessChain %42 %67 
					                                             OpStore %770 %769 
					                       Private f32* %771 = OpAccessChain %42 %67 
					                                f32 %772 = OpLoad %771 
					                                f32 %773 = OpExtInst %1 29 %772 
					                       Private f32* %774 = OpAccessChain %42 %67 
					                                             OpStore %774 %773 
					                       Private f32* %775 = OpAccessChain %42 %67 
					                                f32 %776 = OpLoad %775 
					                                f32 %777 = OpFMul %776 %304 
					                                             OpStore %233 %777 
					                       Private f32* %778 = OpAccessChain %42 %67 
					                                f32 %779 = OpLoad %778 
					                                f32 %780 = OpFMul %779 %304 
					                                f32 %781 = OpLoad %58 
					                                f32 %782 = OpFAdd %780 %781 
					                                             OpStore %58 %782 
					                                f32 %783 = OpLoad %233 
					                              f32_3 %784 = OpCompositeConstruct %783 %783 %783 
					                              f32_3 %785 = OpLoad %32 
					                              f32_3 %786 = OpFMul %784 %785 
					                              f32_3 %787 = OpLoad %9 
					                              f32_3 %788 = OpFAdd %786 %787 
					                                             OpStore %9 %788 
					                read_only Texture2D %789 = OpLoad %12 
					                            sampler %790 = OpLoad %16 
					         read_only Texture2DSampled %791 = OpSampledImage %789 %790 
					                              f32_2 %792 = OpLoad vs_TEXCOORD0 
					                              f32_4 %795 = OpImageSampleImplicitLod %791 %792 ConstOffset %29 
					                              f32_3 %796 = OpVectorShuffle %795 %795 0 1 2 
					                                             OpStore %32 %796 
					                read_only Texture2D %797 = OpLoad %59 
					                            sampler %798 = OpLoad %61 
					         read_only Texture2DSampled %799 = OpSampledImage %797 %798 
					                              f32_2 %800 = OpLoad vs_TEXCOORD0 
					                              f32_4 %801 = OpImageSampleImplicitLod %799 %800 ConstOffset %29 
					                                f32 %802 = OpCompositeExtract %801 0 
					                       Private f32* %803 = OpAccessChain %42 %67 
					                                             OpStore %803 %802 
					                       Uniform f32* %804 = OpAccessChain %71 %27 %72 
					                                f32 %805 = OpLoad %804 
					                       Private f32* %806 = OpAccessChain %42 %67 
					                                f32 %807 = OpLoad %806 
					                                f32 %808 = OpFMul %805 %807 
					                       Uniform f32* %809 = OpAccessChain %71 %27 %78 
					                                f32 %810 = OpLoad %809 
					                                f32 %811 = OpFAdd %808 %810 
					                       Private f32* %812 = OpAccessChain %42 %67 
					                                             OpStore %812 %811 
					                       Private f32* %813 = OpAccessChain %42 %67 
					                                f32 %814 = OpLoad %813 
					                                f32 %815 = OpFDiv %82 %814 
					                       Private f32* %816 = OpAccessChain %42 %67 
					                                             OpStore %816 %815 
					                                f32 %817 = OpLoad %85 
					                       Private f32* %818 = OpAccessChain %42 %67 
					                                f32 %819 = OpLoad %818 
					                                f32 %820 = OpFNegate %819 
					                                f32 %821 = OpFAdd %817 %820 
					                       Private f32* %822 = OpAccessChain %42 %67 
					                                             OpStore %822 %821 
					                       Private f32* %823 = OpAccessChain %42 %67 
					                                f32 %824 = OpLoad %823 
					                                f32 %825 = OpExtInst %1 4 %824 
					                                f32 %826 = OpFMul %825 %107 
					                       Private f32* %827 = OpAccessChain %42 %67 
					                                             OpStore %827 %826 
					                       Private f32* %828 = OpAccessChain %42 %67 
					                                f32 %829 = OpLoad %828 
					                       Private f32* %830 = OpAccessChain %42 %67 
					                                f32 %831 = OpLoad %830 
					                                f32 %832 = OpFMul %829 %831 
					                       Private f32* %833 = OpAccessChain %42 %67 
					                                             OpStore %833 %832 
					                       Private f32* %834 = OpAccessChain %42 %67 
					                                f32 %835 = OpLoad %834 
					                                f32 %836 = OpFMul %835 %113 
					                       Private f32* %837 = OpAccessChain %42 %67 
					                                             OpStore %837 %836 
					                       Private f32* %838 = OpAccessChain %42 %67 
					                                f32 %839 = OpLoad %838 
					                                f32 %840 = OpExtInst %1 29 %839 
					                       Private f32* %841 = OpAccessChain %42 %67 
					                                             OpStore %841 %840 
					                       Private f32* %842 = OpAccessChain %42 %67 
					                                f32 %843 = OpLoad %842 
					                                f32 %844 = OpFMul %843 %236 
					                                             OpStore %233 %844 
					                       Private f32* %845 = OpAccessChain %42 %67 
					                                f32 %846 = OpLoad %845 
					                                f32 %847 = OpFMul %846 %236 
					                                f32 %848 = OpLoad %58 
					                                f32 %849 = OpFAdd %847 %848 
					                                             OpStore %58 %849 
					                                f32 %850 = OpLoad %233 
					                              f32_3 %851 = OpCompositeConstruct %850 %850 %850 
					                              f32_3 %852 = OpLoad %32 
					                              f32_3 %853 = OpFMul %851 %852 
					                              f32_3 %854 = OpLoad %9 
					                              f32_3 %855 = OpFAdd %853 %854 
					                                             OpStore %9 %855 
					                read_only Texture2D %856 = OpLoad %12 
					                            sampler %857 = OpLoad %16 
					         read_only Texture2DSampled %858 = OpSampledImage %856 %857 
					                              f32_2 %859 = OpLoad vs_TEXCOORD0 
					                              f32_4 %862 = OpImageSampleImplicitLod %858 %859 ConstOffset %29 
					                              f32_3 %863 = OpVectorShuffle %862 %862 0 1 2 
					                                             OpStore %32 %863 
					                read_only Texture2D %864 = OpLoad %59 
					                            sampler %865 = OpLoad %61 
					         read_only Texture2DSampled %866 = OpSampledImage %864 %865 
					                              f32_2 %867 = OpLoad vs_TEXCOORD0 
					                              f32_4 %868 = OpImageSampleImplicitLod %866 %867 ConstOffset %29 
					                                f32 %869 = OpCompositeExtract %868 0 
					                       Private f32* %870 = OpAccessChain %42 %67 
					                                             OpStore %870 %869 
					                       Uniform f32* %871 = OpAccessChain %71 %27 %72 
					                                f32 %872 = OpLoad %871 
					                       Private f32* %873 = OpAccessChain %42 %67 
					                                f32 %874 = OpLoad %873 
					                                f32 %875 = OpFMul %872 %874 
					                       Uniform f32* %876 = OpAccessChain %71 %27 %78 
					                                f32 %877 = OpLoad %876 
					                                f32 %878 = OpFAdd %875 %877 
					                       Private f32* %879 = OpAccessChain %42 %67 
					                                             OpStore %879 %878 
					                       Private f32* %880 = OpAccessChain %42 %67 
					                                f32 %881 = OpLoad %880 
					                                f32 %882 = OpFDiv %82 %881 
					                       Private f32* %883 = OpAccessChain %42 %67 
					                                             OpStore %883 %882 
					                                f32 %884 = OpLoad %85 
					                       Private f32* %885 = OpAccessChain %42 %67 
					                                f32 %886 = OpLoad %885 
					                                f32 %887 = OpFNegate %886 
					                                f32 %888 = OpFAdd %884 %887 
					                       Private f32* %889 = OpAccessChain %42 %67 
					                                             OpStore %889 %888 
					                       Private f32* %890 = OpAccessChain %42 %67 
					                                f32 %891 = OpLoad %890 
					                                f32 %892 = OpExtInst %1 4 %891 
					                                f32 %893 = OpFMul %892 %107 
					                       Private f32* %894 = OpAccessChain %42 %67 
					                                             OpStore %894 %893 
					                       Private f32* %895 = OpAccessChain %42 %67 
					                                f32 %896 = OpLoad %895 
					                       Private f32* %897 = OpAccessChain %42 %67 
					                                f32 %898 = OpLoad %897 
					                                f32 %899 = OpFMul %896 %898 
					                       Private f32* %900 = OpAccessChain %42 %67 
					                                             OpStore %900 %899 
					                       Private f32* %901 = OpAccessChain %42 %67 
					                                f32 %902 = OpLoad %901 
					                                f32 %903 = OpFMul %902 %113 
					                       Private f32* %904 = OpAccessChain %42 %67 
					                                             OpStore %904 %903 
					                       Private f32* %905 = OpAccessChain %42 %67 
					                                f32 %906 = OpLoad %905 
					                                f32 %907 = OpExtInst %1 29 %906 
					                       Private f32* %908 = OpAccessChain %42 %67 
					                                             OpStore %908 %907 
					                       Private f32* %909 = OpAccessChain %42 %67 
					                                f32 %910 = OpLoad %909 
					                                f32 %911 = OpFMul %910 %174 
					                                             OpStore %233 %911 
					                       Private f32* %912 = OpAccessChain %42 %67 
					                                f32 %913 = OpLoad %912 
					                                f32 %914 = OpFMul %913 %174 
					                                f32 %915 = OpLoad %58 
					                                f32 %916 = OpFAdd %914 %915 
					                                             OpStore %58 %916 
					                                f32 %917 = OpLoad %233 
					                              f32_3 %918 = OpCompositeConstruct %917 %917 %917 
					                              f32_3 %919 = OpLoad %32 
					                              f32_3 %920 = OpFMul %918 %919 
					                              f32_3 %921 = OpLoad %9 
					                              f32_3 %922 = OpFAdd %920 %921 
					                                             OpStore %9 %922 
					                read_only Texture2D %923 = OpLoad %12 
					                            sampler %924 = OpLoad %16 
					         read_only Texture2DSampled %925 = OpSampledImage %923 %924 
					                              f32_2 %926 = OpLoad vs_TEXCOORD0 
					                              f32_4 %929 = OpImageSampleImplicitLod %925 %926 ConstOffset %29 
					                              f32_3 %930 = OpVectorShuffle %929 %929 0 1 2 
					                                             OpStore %32 %930 
					                read_only Texture2D %931 = OpLoad %59 
					                            sampler %932 = OpLoad %61 
					         read_only Texture2DSampled %933 = OpSampledImage %931 %932 
					                              f32_2 %934 = OpLoad vs_TEXCOORD0 
					                              f32_4 %935 = OpImageSampleImplicitLod %933 %934 ConstOffset %29 
					                                f32 %936 = OpCompositeExtract %935 0 
					                       Private f32* %937 = OpAccessChain %42 %67 
					                                             OpStore %937 %936 
					                       Uniform f32* %938 = OpAccessChain %71 %27 %72 
					                                f32 %939 = OpLoad %938 
					                       Private f32* %940 = OpAccessChain %42 %67 
					                                f32 %941 = OpLoad %940 
					                                f32 %942 = OpFMul %939 %941 
					                       Uniform f32* %943 = OpAccessChain %71 %27 %78 
					                                f32 %944 = OpLoad %943 
					                                f32 %945 = OpFAdd %942 %944 
					                       Private f32* %946 = OpAccessChain %42 %67 
					                                             OpStore %946 %945 
					                       Private f32* %947 = OpAccessChain %42 %67 
					                                f32 %948 = OpLoad %947 
					                                f32 %949 = OpFDiv %82 %948 
					                       Private f32* %950 = OpAccessChain %42 %67 
					                                             OpStore %950 %949 
					                                f32 %951 = OpLoad %85 
					                       Private f32* %952 = OpAccessChain %42 %67 
					                                f32 %953 = OpLoad %952 
					                                f32 %954 = OpFNegate %953 
					                                f32 %955 = OpFAdd %951 %954 
					                                             OpStore %85 %955 
					                                f32 %956 = OpLoad %85 
					                                f32 %957 = OpExtInst %1 4 %956 
					                                f32 %958 = OpFMul %957 %107 
					                                             OpStore %85 %958 
					                                f32 %959 = OpLoad %85 
					                                f32 %960 = OpLoad %85 
					                                f32 %961 = OpFMul %959 %960 
					                                             OpStore %85 %961 
					                                f32 %962 = OpLoad %85 
					                                f32 %963 = OpFMul %962 %113 
					                                             OpStore %85 %963 
					                                f32 %964 = OpLoad %85 
					                                f32 %965 = OpExtInst %1 29 %964 
					                                             OpStore %85 %965 
					                                f32 %966 = OpLoad %85 
					                                f32 %967 = OpFMul %966 %119 
					                       Private f32* %968 = OpAccessChain %42 %67 
					                                             OpStore %968 %967 
					                                f32 %969 = OpLoad %85 
					                                f32 %970 = OpFMul %969 %119 
					                                f32 %971 = OpLoad %58 
					                                f32 %972 = OpFAdd %970 %971 
					                                             OpStore %58 %972 
					                              f32_4 %973 = OpLoad %42 
					                              f32_3 %974 = OpVectorShuffle %973 %973 0 0 0 
					                              f32_3 %975 = OpLoad %32 
					                              f32_3 %976 = OpFMul %974 %975 
					                              f32_3 %977 = OpLoad %9 
					                              f32_3 %978 = OpFAdd %976 %977 
					                                             OpStore %9 %978 
					                              f32_3 %979 = OpLoad %9 
					                                f32 %980 = OpLoad %58 
					                              f32_3 %981 = OpCompositeConstruct %980 %980 %980 
					                              f32_3 %982 = OpFDiv %979 %981 
					                              f32_4 %983 = OpLoad %138 
					                              f32_4 %984 = OpVectorShuffle %983 %982 4 5 6 3 
					                                             OpStore %138 %984 
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[7];
						vec4 _ZBufferParams;
						vec4 unused_0_2;
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat6;
					float u_xlat7;
					float u_xlat15;
					float u_xlat16;
					float u_xlat17;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-5, 0));
					    u_xlat1 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-6, 0));
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-7, 0));
					    u_xlat4 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(-7, 0));
					    u_xlat15 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat15 = float(1.0) / u_xlat15;
					    u_xlat4 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat16 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat16 = float(1.0) / u_xlat16;
					    u_xlat15 = (-u_xlat15) + u_xlat16;
					    u_xlat15 = abs(u_xlat15) * 0.5;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat15 = u_xlat15 * -1.44269502;
					    u_xlat15 = exp2(u_xlat15);
					    u_xlat18 = u_xlat15 * 0.0277537704;
					    u_xlat15 = u_xlat15 * 0.0277537704 + 0.0854876339;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.0854876339, 0.0854876339, 0.0854876339) + u_xlat3.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(-6, 0));
					    u_xlat17 = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat17 = float(1.0) / u_xlat17;
					    u_xlat17 = u_xlat16 + (-u_xlat17);
					    u_xlat17 = abs(u_xlat17) * 0.5;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat17 = u_xlat17 * -1.44269502;
					    u_xlat17 = exp2(u_xlat17);
					    u_xlat3.x = u_xlat17 * 0.03740637;
					    u_xlat15 = u_xlat17 * 0.03740637 + u_xlat15;
					    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(-5, 0));
					    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.x = u_xlat16 + (-u_xlat2.x);
					    u_xlat2.x = abs(u_xlat2.x) * 0.5;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * -1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat7 = u_xlat2.x * 0.048153419;
					    u_xlat15 = u_xlat2.x * 0.048153419 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat7) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-4, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(-4, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0592061132;
					    u_xlat15 = u_xlat1.x * 0.0592061132 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-3, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(-3, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0695286617;
					    u_xlat15 = u_xlat1.x * 0.0695286617 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-2, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(-2, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0779864416;
					    u_xlat15 = u_xlat1.x * 0.0779864416 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-1, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(-1, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0835472643;
					    u_xlat15 = u_xlat1.x * 0.0835472643 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(1, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(1, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0835472643;
					    u_xlat15 = u_xlat1.x * 0.0835472643 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(2, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(2, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0779864416;
					    u_xlat15 = u_xlat1.x * 0.0779864416 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(3, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(3, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0695286617;
					    u_xlat15 = u_xlat1.x * 0.0695286617 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(4, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(4, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0592061132;
					    u_xlat15 = u_xlat1.x * 0.0592061132 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(5, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(5, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.048153419;
					    u_xlat15 = u_xlat1.x * 0.048153419 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(6, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(6, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.03740637;
					    u_xlat15 = u_xlat1.x * 0.03740637 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(7, 0));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(7, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0277537704;
					    u_xlat15 = u_xlat1.x * 0.0277537704 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz / vec3(u_xlat15);
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
			GpuProgramID 110770
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
					UNITY_LOCATION(0) uniform  sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat6;
					float u_xlat7;
					float u_xlat15;
					float u_xlat16;
					float u_xlat17;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -5));
					    u_xlat1 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -6));
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -7));
					    u_xlat4 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, -7));
					    u_xlat15 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat15 = float(1.0) / u_xlat15;
					    u_xlat4 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat16 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat16 = float(1.0) / u_xlat16;
					    u_xlat15 = (-u_xlat15) + u_xlat16;
					    u_xlat15 = abs(u_xlat15) * 0.5;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat15 = u_xlat15 * -1.44269502;
					    u_xlat15 = exp2(u_xlat15);
					    u_xlat18 = u_xlat15 * 0.0277537704;
					    u_xlat15 = u_xlat15 * 0.0277537704 + 0.0854876339;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.0854876339, 0.0854876339, 0.0854876339) + u_xlat3.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, -6));
					    u_xlat17 = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat17 = float(1.0) / u_xlat17;
					    u_xlat17 = u_xlat16 + (-u_xlat17);
					    u_xlat17 = abs(u_xlat17) * 0.5;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat17 = u_xlat17 * -1.44269502;
					    u_xlat17 = exp2(u_xlat17);
					    u_xlat3.x = u_xlat17 * 0.03740637;
					    u_xlat15 = u_xlat17 * 0.03740637 + u_xlat15;
					    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, -5));
					    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.x = u_xlat16 + (-u_xlat2.x);
					    u_xlat2.x = abs(u_xlat2.x) * 0.5;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * -1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat7 = u_xlat2.x * 0.048153419;
					    u_xlat15 = u_xlat2.x * 0.048153419 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat7) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -4));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, -4));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0592061132;
					    u_xlat15 = u_xlat1.x * 0.0592061132 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -3));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, -3));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0695286617;
					    u_xlat15 = u_xlat1.x * 0.0695286617 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -2));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, -2));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0779864416;
					    u_xlat15 = u_xlat1.x * 0.0779864416 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -1));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, -1));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0835472643;
					    u_xlat15 = u_xlat1.x * 0.0835472643 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 1));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, 1));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0835472643;
					    u_xlat15 = u_xlat1.x * 0.0835472643 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 2));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, 2));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0779864416;
					    u_xlat15 = u_xlat1.x * 0.0779864416 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 3));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, 3));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0695286617;
					    u_xlat15 = u_xlat1.x * 0.0695286617 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 4));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, 4));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0592061132;
					    u_xlat15 = u_xlat1.x * 0.0592061132 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 5));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, 5));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.048153419;
					    u_xlat15 = u_xlat1.x * 0.048153419 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 6));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, 6));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.03740637;
					    u_xlat15 = u_xlat1.x * 0.03740637 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 7));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, 7));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0277537704;
					    u_xlat15 = u_xlat1.x * 0.0277537704 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz / vec3(u_xlat15);
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
					; Bound: 986
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %138 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %59 DescriptorSet 59 
					                                             OpDecorate %59 Binding 59 
					                                             OpDecorate %61 DescriptorSet 61 
					                                             OpDecorate %61 Binding 61 
					                                             OpMemberDecorate %69 0 Offset 69 
					                                             OpDecorate %69 Block 
					                                             OpDecorate %71 DescriptorSet 71 
					                                             OpDecorate %71 Binding 71 
					                                             OpDecorate %138 Location 138 
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
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %24 = OpTypeInt 32 1 
					                                     %25 = OpTypeVector %24 2 
					                                 i32 %26 = OpConstant 0 
					                                 i32 %27 = OpConstant -5 
					                               i32_2 %28 = OpConstantComposite %26 %27 
					                                     %29 = OpTypeVector %6 4 
					                      Private f32_3* %32 = OpVariable Private 
					                                 i32 %37 = OpConstant -6 
					                               i32_2 %38 = OpConstantComposite %26 %37 
					                                     %41 = OpTypePointer Private %29 
					                      Private f32_4* %42 = OpVariable Private 
					                      Private f32_3* %48 = OpVariable Private 
					                                 i32 %53 = OpConstant -7 
					                               i32_2 %54 = OpConstantComposite %26 %53 
					                                     %57 = OpTypePointer Private %6 
					                        Private f32* %58 = OpVariable Private 
					UniformConstant read_only Texture2D* %59 = OpVariable UniformConstant 
					            UniformConstant sampler* %61 = OpVariable UniformConstant 
					                                     %66 = OpTypeInt 32 0 
					                                 u32 %67 = OpConstant 0 
					                                     %69 = OpTypeStruct %29 
					                                     %70 = OpTypePointer Uniform %69 
					            Uniform struct {f32_4;}* %71 = OpVariable Uniform 
					                                 u32 %72 = OpConstant 2 
					                                     %73 = OpTypePointer Uniform %6 
					                                 u32 %78 = OpConstant 3 
					                                 f32 %82 = OpConstant 3,674022E-40 
					                        Private f32* %85 = OpVariable Private 
					                                f32 %107 = OpConstant 3,674022E-40 
					                                f32 %113 = OpConstant 3,674022E-40 
					                       Private f32* %117 = OpVariable Private 
					                                f32 %119 = OpConstant 3,674022E-40 
					                                f32 %123 = OpConstant 3,674022E-40 
					                              f32_3 %131 = OpConstantComposite %123 %123 %123 
					                                    %137 = OpTypePointer Output %29 
					                      Output f32_4* %138 = OpVariable Output 
					                                    %141 = OpTypePointer Output %6 
					                       Private f32* %143 = OpVariable Private 
					                                f32 %174 = OpConstant 3,674022E-40 
					                       Private f32* %233 = OpVariable Private 
					                                f32 %236 = OpConstant 3,674022E-40 
					                                i32 %253 = OpConstant -4 
					                              i32_2 %254 = OpConstantComposite %26 %253 
					                                f32 %304 = OpConstant 3,674022E-40 
					                                i32 %321 = OpConstant -3 
					                              i32_2 %322 = OpConstantComposite %26 %321 
					                                f32 %372 = OpConstant 3,674022E-40 
					                                i32 %389 = OpConstant -2 
					                              i32_2 %390 = OpConstantComposite %26 %389 
					                                f32 %440 = OpConstant 3,674022E-40 
					                                i32 %457 = OpConstant -1 
					                              i32_2 %458 = OpConstantComposite %26 %457 
					                                f32 %508 = OpConstant 3,674022E-40 
					                                i32 %525 = OpConstant 1 
					                              i32_2 %526 = OpConstantComposite %26 %525 
					                                i32 %592 = OpConstant 2 
					                              i32_2 %593 = OpConstantComposite %26 %592 
					                                i32 %659 = OpConstant 3 
					                              i32_2 %660 = OpConstantComposite %26 %659 
					                                i32 %726 = OpConstant 4 
					                              i32_2 %727 = OpConstantComposite %26 %726 
					                                i32 %793 = OpConstant 5 
					                              i32_2 %794 = OpConstantComposite %26 %793 
					                                i32 %860 = OpConstant 6 
					                              i32_2 %861 = OpConstantComposite %26 %860 
					                                i32 %927 = OpConstant 7 
					                              i32_2 %928 = OpConstantComposite %26 %927 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %30 = OpImageSampleImplicitLod %19 %23 ConstOffset %29 
					                               f32_3 %31 = OpVectorShuffle %30 %30 0 1 2 
					                                             OpStore %9 %31 
					                 read_only Texture2D %33 = OpLoad %12 
					                             sampler %34 = OpLoad %16 
					          read_only Texture2DSampled %35 = OpSampledImage %33 %34 
					                               f32_2 %36 = OpLoad vs_TEXCOORD0 
					                               f32_4 %39 = OpImageSampleImplicitLod %35 %36 ConstOffset %29 
					                               f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
					                                             OpStore %32 %40 
					                 read_only Texture2D %43 = OpLoad %12 
					                             sampler %44 = OpLoad %16 
					          read_only Texture2DSampled %45 = OpSampledImage %43 %44 
					                               f32_2 %46 = OpLoad vs_TEXCOORD0 
					                               f32_4 %47 = OpImageSampleImplicitLod %45 %46 
					                                             OpStore %42 %47 
					                 read_only Texture2D %49 = OpLoad %12 
					                             sampler %50 = OpLoad %16 
					          read_only Texture2DSampled %51 = OpSampledImage %49 %50 
					                               f32_2 %52 = OpLoad vs_TEXCOORD0 
					                               f32_4 %55 = OpImageSampleImplicitLod %51 %52 ConstOffset %29 
					                               f32_3 %56 = OpVectorShuffle %55 %55 0 1 2 
					                                             OpStore %48 %56 
					                 read_only Texture2D %60 = OpLoad %59 
					                             sampler %62 = OpLoad %61 
					          read_only Texture2DSampled %63 = OpSampledImage %60 %62 
					                               f32_2 %64 = OpLoad vs_TEXCOORD0 
					                               f32_4 %65 = OpImageSampleImplicitLod %63 %64 ConstOffset %29 
					                                 f32 %68 = OpCompositeExtract %65 0 
					                                             OpStore %58 %68 
					                        Uniform f32* %74 = OpAccessChain %71 %26 %72 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpLoad %58 
					                                 f32 %77 = OpFMul %75 %76 
					                        Uniform f32* %79 = OpAccessChain %71 %26 %78 
					                                 f32 %80 = OpLoad %79 
					                                 f32 %81 = OpFAdd %77 %80 
					                                             OpStore %58 %81 
					                                 f32 %83 = OpLoad %58 
					                                 f32 %84 = OpFDiv %82 %83 
					                                             OpStore %58 %84 
					                 read_only Texture2D %86 = OpLoad %59 
					                             sampler %87 = OpLoad %61 
					          read_only Texture2DSampled %88 = OpSampledImage %86 %87 
					                               f32_2 %89 = OpLoad vs_TEXCOORD0 
					                               f32_4 %90 = OpImageSampleImplicitLod %88 %89 
					                                 f32 %91 = OpCompositeExtract %90 0 
					                                             OpStore %85 %91 
					                        Uniform f32* %92 = OpAccessChain %71 %26 %72 
					                                 f32 %93 = OpLoad %92 
					                                 f32 %94 = OpLoad %85 
					                                 f32 %95 = OpFMul %93 %94 
					                        Uniform f32* %96 = OpAccessChain %71 %26 %78 
					                                 f32 %97 = OpLoad %96 
					                                 f32 %98 = OpFAdd %95 %97 
					                                             OpStore %85 %98 
					                                 f32 %99 = OpLoad %85 
					                                f32 %100 = OpFDiv %82 %99 
					                                             OpStore %85 %100 
					                                f32 %101 = OpLoad %58 
					                                f32 %102 = OpFNegate %101 
					                                f32 %103 = OpLoad %85 
					                                f32 %104 = OpFAdd %102 %103 
					                                             OpStore %58 %104 
					                                f32 %105 = OpLoad %58 
					                                f32 %106 = OpExtInst %1 4 %105 
					                                f32 %108 = OpFMul %106 %107 
					                                             OpStore %58 %108 
					                                f32 %109 = OpLoad %58 
					                                f32 %110 = OpLoad %58 
					                                f32 %111 = OpFMul %109 %110 
					                                             OpStore %58 %111 
					                                f32 %112 = OpLoad %58 
					                                f32 %114 = OpFMul %112 %113 
					                                             OpStore %58 %114 
					                                f32 %115 = OpLoad %58 
					                                f32 %116 = OpExtInst %1 29 %115 
					                                             OpStore %58 %116 
					                                f32 %118 = OpLoad %58 
					                                f32 %120 = OpFMul %118 %119 
					                                             OpStore %117 %120 
					                                f32 %121 = OpLoad %58 
					                                f32 %122 = OpFMul %121 %119 
					                                f32 %124 = OpFAdd %122 %123 
					                                             OpStore %58 %124 
					                              f32_3 %125 = OpLoad %48 
					                                f32 %126 = OpLoad %117 
					                              f32_3 %127 = OpCompositeConstruct %126 %126 %126 
					                              f32_3 %128 = OpFMul %125 %127 
					                                             OpStore %48 %128 
					                              f32_4 %129 = OpLoad %42 
					                              f32_3 %130 = OpVectorShuffle %129 %129 0 1 2 
					                              f32_3 %132 = OpFMul %130 %131 
					                              f32_3 %133 = OpLoad %48 
					                              f32_3 %134 = OpFAdd %132 %133 
					                              f32_4 %135 = OpLoad %42 
					                              f32_4 %136 = OpVectorShuffle %135 %134 4 5 6 3 
					                                             OpStore %42 %136 
					                       Private f32* %139 = OpAccessChain %42 %78 
					                                f32 %140 = OpLoad %139 
					                        Output f32* %142 = OpAccessChain %138 %78 
					                                             OpStore %142 %140 
					                read_only Texture2D %144 = OpLoad %59 
					                            sampler %145 = OpLoad %61 
					         read_only Texture2DSampled %146 = OpSampledImage %144 %145 
					                              f32_2 %147 = OpLoad vs_TEXCOORD0 
					                              f32_4 %148 = OpImageSampleImplicitLod %146 %147 ConstOffset %29 
					                                f32 %149 = OpCompositeExtract %148 0 
					                                             OpStore %143 %149 
					                       Uniform f32* %150 = OpAccessChain %71 %26 %72 
					                                f32 %151 = OpLoad %150 
					                                f32 %152 = OpLoad %143 
					                                f32 %153 = OpFMul %151 %152 
					                       Uniform f32* %154 = OpAccessChain %71 %26 %78 
					                                f32 %155 = OpLoad %154 
					                                f32 %156 = OpFAdd %153 %155 
					                                             OpStore %143 %156 
					                                f32 %157 = OpLoad %143 
					                                f32 %158 = OpFDiv %82 %157 
					                                             OpStore %143 %158 
					                                f32 %159 = OpLoad %85 
					                                f32 %160 = OpLoad %143 
					                                f32 %161 = OpFNegate %160 
					                                f32 %162 = OpFAdd %159 %161 
					                                             OpStore %143 %162 
					                                f32 %163 = OpLoad %143 
					                                f32 %164 = OpExtInst %1 4 %163 
					                                f32 %165 = OpFMul %164 %107 
					                                             OpStore %143 %165 
					                                f32 %166 = OpLoad %143 
					                                f32 %167 = OpLoad %143 
					                                f32 %168 = OpFMul %166 %167 
					                                             OpStore %143 %168 
					                                f32 %169 = OpLoad %143 
					                                f32 %170 = OpFMul %169 %113 
					                                             OpStore %143 %170 
					                                f32 %171 = OpLoad %143 
					                                f32 %172 = OpExtInst %1 29 %171 
					                                             OpStore %143 %172 
					                                f32 %173 = OpLoad %143 
					                                f32 %175 = OpFMul %173 %174 
					                       Private f32* %176 = OpAccessChain %48 %67 
					                                             OpStore %176 %175 
					                                f32 %177 = OpLoad %143 
					                                f32 %178 = OpFMul %177 %174 
					                                f32 %179 = OpLoad %58 
					                                f32 %180 = OpFAdd %178 %179 
					                                             OpStore %58 %180 
					                              f32_3 %181 = OpLoad %48 
					                              f32_3 %182 = OpVectorShuffle %181 %181 0 0 0 
					                              f32_3 %183 = OpLoad %32 
					                              f32_3 %184 = OpFMul %182 %183 
					                              f32_4 %185 = OpLoad %42 
					                              f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                              f32_3 %187 = OpFAdd %184 %186 
					                                             OpStore %32 %187 
					                read_only Texture2D %188 = OpLoad %59 
					                            sampler %189 = OpLoad %61 
					         read_only Texture2DSampled %190 = OpSampledImage %188 %189 
					                              f32_2 %191 = OpLoad vs_TEXCOORD0 
					                              f32_4 %192 = OpImageSampleImplicitLod %190 %191 ConstOffset %29 
					                                f32 %193 = OpCompositeExtract %192 0 
					                       Private f32* %194 = OpAccessChain %42 %67 
					                                             OpStore %194 %193 
					                       Uniform f32* %195 = OpAccessChain %71 %26 %72 
					                                f32 %196 = OpLoad %195 
					                       Private f32* %197 = OpAccessChain %42 %67 
					                                f32 %198 = OpLoad %197 
					                                f32 %199 = OpFMul %196 %198 
					                       Uniform f32* %200 = OpAccessChain %71 %26 %78 
					                                f32 %201 = OpLoad %200 
					                                f32 %202 = OpFAdd %199 %201 
					                       Private f32* %203 = OpAccessChain %42 %67 
					                                             OpStore %203 %202 
					                       Private f32* %204 = OpAccessChain %42 %67 
					                                f32 %205 = OpLoad %204 
					                                f32 %206 = OpFDiv %82 %205 
					                       Private f32* %207 = OpAccessChain %42 %67 
					                                             OpStore %207 %206 
					                                f32 %208 = OpLoad %85 
					                       Private f32* %209 = OpAccessChain %42 %67 
					                                f32 %210 = OpLoad %209 
					                                f32 %211 = OpFNegate %210 
					                                f32 %212 = OpFAdd %208 %211 
					                       Private f32* %213 = OpAccessChain %42 %67 
					                                             OpStore %213 %212 
					                       Private f32* %214 = OpAccessChain %42 %67 
					                                f32 %215 = OpLoad %214 
					                                f32 %216 = OpExtInst %1 4 %215 
					                                f32 %217 = OpFMul %216 %107 
					                       Private f32* %218 = OpAccessChain %42 %67 
					                                             OpStore %218 %217 
					                       Private f32* %219 = OpAccessChain %42 %67 
					                                f32 %220 = OpLoad %219 
					                       Private f32* %221 = OpAccessChain %42 %67 
					                                f32 %222 = OpLoad %221 
					                                f32 %223 = OpFMul %220 %222 
					                       Private f32* %224 = OpAccessChain %42 %67 
					                                             OpStore %224 %223 
					                       Private f32* %225 = OpAccessChain %42 %67 
					                                f32 %226 = OpLoad %225 
					                                f32 %227 = OpFMul %226 %113 
					                       Private f32* %228 = OpAccessChain %42 %67 
					                                             OpStore %228 %227 
					                       Private f32* %229 = OpAccessChain %42 %67 
					                                f32 %230 = OpLoad %229 
					                                f32 %231 = OpExtInst %1 29 %230 
					                       Private f32* %232 = OpAccessChain %42 %67 
					                                             OpStore %232 %231 
					                       Private f32* %234 = OpAccessChain %42 %67 
					                                f32 %235 = OpLoad %234 
					                                f32 %237 = OpFMul %235 %236 
					                                             OpStore %233 %237 
					                       Private f32* %238 = OpAccessChain %42 %67 
					                                f32 %239 = OpLoad %238 
					                                f32 %240 = OpFMul %239 %236 
					                                f32 %241 = OpLoad %58 
					                                f32 %242 = OpFAdd %240 %241 
					                                             OpStore %58 %242 
					                                f32 %243 = OpLoad %233 
					                              f32_3 %244 = OpCompositeConstruct %243 %243 %243 
					                              f32_3 %245 = OpLoad %9 
					                              f32_3 %246 = OpFMul %244 %245 
					                              f32_3 %247 = OpLoad %32 
					                              f32_3 %248 = OpFAdd %246 %247 
					                                             OpStore %9 %248 
					                read_only Texture2D %249 = OpLoad %12 
					                            sampler %250 = OpLoad %16 
					         read_only Texture2DSampled %251 = OpSampledImage %249 %250 
					                              f32_2 %252 = OpLoad vs_TEXCOORD0 
					                              f32_4 %255 = OpImageSampleImplicitLod %251 %252 ConstOffset %29 
					                              f32_3 %256 = OpVectorShuffle %255 %255 0 1 2 
					                                             OpStore %32 %256 
					                read_only Texture2D %257 = OpLoad %59 
					                            sampler %258 = OpLoad %61 
					         read_only Texture2DSampled %259 = OpSampledImage %257 %258 
					                              f32_2 %260 = OpLoad vs_TEXCOORD0 
					                              f32_4 %261 = OpImageSampleImplicitLod %259 %260 ConstOffset %29 
					                                f32 %262 = OpCompositeExtract %261 0 
					                       Private f32* %263 = OpAccessChain %42 %67 
					                                             OpStore %263 %262 
					                       Uniform f32* %264 = OpAccessChain %71 %26 %72 
					                                f32 %265 = OpLoad %264 
					                       Private f32* %266 = OpAccessChain %42 %67 
					                                f32 %267 = OpLoad %266 
					                                f32 %268 = OpFMul %265 %267 
					                       Uniform f32* %269 = OpAccessChain %71 %26 %78 
					                                f32 %270 = OpLoad %269 
					                                f32 %271 = OpFAdd %268 %270 
					                       Private f32* %272 = OpAccessChain %42 %67 
					                                             OpStore %272 %271 
					                       Private f32* %273 = OpAccessChain %42 %67 
					                                f32 %274 = OpLoad %273 
					                                f32 %275 = OpFDiv %82 %274 
					                       Private f32* %276 = OpAccessChain %42 %67 
					                                             OpStore %276 %275 
					                                f32 %277 = OpLoad %85 
					                       Private f32* %278 = OpAccessChain %42 %67 
					                                f32 %279 = OpLoad %278 
					                                f32 %280 = OpFNegate %279 
					                                f32 %281 = OpFAdd %277 %280 
					                       Private f32* %282 = OpAccessChain %42 %67 
					                                             OpStore %282 %281 
					                       Private f32* %283 = OpAccessChain %42 %67 
					                                f32 %284 = OpLoad %283 
					                                f32 %285 = OpExtInst %1 4 %284 
					                                f32 %286 = OpFMul %285 %107 
					                       Private f32* %287 = OpAccessChain %42 %67 
					                                             OpStore %287 %286 
					                       Private f32* %288 = OpAccessChain %42 %67 
					                                f32 %289 = OpLoad %288 
					                       Private f32* %290 = OpAccessChain %42 %67 
					                                f32 %291 = OpLoad %290 
					                                f32 %292 = OpFMul %289 %291 
					                       Private f32* %293 = OpAccessChain %42 %67 
					                                             OpStore %293 %292 
					                       Private f32* %294 = OpAccessChain %42 %67 
					                                f32 %295 = OpLoad %294 
					                                f32 %296 = OpFMul %295 %113 
					                       Private f32* %297 = OpAccessChain %42 %67 
					                                             OpStore %297 %296 
					                       Private f32* %298 = OpAccessChain %42 %67 
					                                f32 %299 = OpLoad %298 
					                                f32 %300 = OpExtInst %1 29 %299 
					                       Private f32* %301 = OpAccessChain %42 %67 
					                                             OpStore %301 %300 
					                       Private f32* %302 = OpAccessChain %42 %67 
					                                f32 %303 = OpLoad %302 
					                                f32 %305 = OpFMul %303 %304 
					                                             OpStore %233 %305 
					                       Private f32* %306 = OpAccessChain %42 %67 
					                                f32 %307 = OpLoad %306 
					                                f32 %308 = OpFMul %307 %304 
					                                f32 %309 = OpLoad %58 
					                                f32 %310 = OpFAdd %308 %309 
					                                             OpStore %58 %310 
					                                f32 %311 = OpLoad %233 
					                              f32_3 %312 = OpCompositeConstruct %311 %311 %311 
					                              f32_3 %313 = OpLoad %32 
					                              f32_3 %314 = OpFMul %312 %313 
					                              f32_3 %315 = OpLoad %9 
					                              f32_3 %316 = OpFAdd %314 %315 
					                                             OpStore %9 %316 
					                read_only Texture2D %317 = OpLoad %12 
					                            sampler %318 = OpLoad %16 
					         read_only Texture2DSampled %319 = OpSampledImage %317 %318 
					                              f32_2 %320 = OpLoad vs_TEXCOORD0 
					                              f32_4 %323 = OpImageSampleImplicitLod %319 %320 ConstOffset %29 
					                              f32_3 %324 = OpVectorShuffle %323 %323 0 1 2 
					                                             OpStore %32 %324 
					                read_only Texture2D %325 = OpLoad %59 
					                            sampler %326 = OpLoad %61 
					         read_only Texture2DSampled %327 = OpSampledImage %325 %326 
					                              f32_2 %328 = OpLoad vs_TEXCOORD0 
					                              f32_4 %329 = OpImageSampleImplicitLod %327 %328 ConstOffset %29 
					                                f32 %330 = OpCompositeExtract %329 0 
					                       Private f32* %331 = OpAccessChain %42 %67 
					                                             OpStore %331 %330 
					                       Uniform f32* %332 = OpAccessChain %71 %26 %72 
					                                f32 %333 = OpLoad %332 
					                       Private f32* %334 = OpAccessChain %42 %67 
					                                f32 %335 = OpLoad %334 
					                                f32 %336 = OpFMul %333 %335 
					                       Uniform f32* %337 = OpAccessChain %71 %26 %78 
					                                f32 %338 = OpLoad %337 
					                                f32 %339 = OpFAdd %336 %338 
					                       Private f32* %340 = OpAccessChain %42 %67 
					                                             OpStore %340 %339 
					                       Private f32* %341 = OpAccessChain %42 %67 
					                                f32 %342 = OpLoad %341 
					                                f32 %343 = OpFDiv %82 %342 
					                       Private f32* %344 = OpAccessChain %42 %67 
					                                             OpStore %344 %343 
					                                f32 %345 = OpLoad %85 
					                       Private f32* %346 = OpAccessChain %42 %67 
					                                f32 %347 = OpLoad %346 
					                                f32 %348 = OpFNegate %347 
					                                f32 %349 = OpFAdd %345 %348 
					                       Private f32* %350 = OpAccessChain %42 %67 
					                                             OpStore %350 %349 
					                       Private f32* %351 = OpAccessChain %42 %67 
					                                f32 %352 = OpLoad %351 
					                                f32 %353 = OpExtInst %1 4 %352 
					                                f32 %354 = OpFMul %353 %107 
					                       Private f32* %355 = OpAccessChain %42 %67 
					                                             OpStore %355 %354 
					                       Private f32* %356 = OpAccessChain %42 %67 
					                                f32 %357 = OpLoad %356 
					                       Private f32* %358 = OpAccessChain %42 %67 
					                                f32 %359 = OpLoad %358 
					                                f32 %360 = OpFMul %357 %359 
					                       Private f32* %361 = OpAccessChain %42 %67 
					                                             OpStore %361 %360 
					                       Private f32* %362 = OpAccessChain %42 %67 
					                                f32 %363 = OpLoad %362 
					                                f32 %364 = OpFMul %363 %113 
					                       Private f32* %365 = OpAccessChain %42 %67 
					                                             OpStore %365 %364 
					                       Private f32* %366 = OpAccessChain %42 %67 
					                                f32 %367 = OpLoad %366 
					                                f32 %368 = OpExtInst %1 29 %367 
					                       Private f32* %369 = OpAccessChain %42 %67 
					                                             OpStore %369 %368 
					                       Private f32* %370 = OpAccessChain %42 %67 
					                                f32 %371 = OpLoad %370 
					                                f32 %373 = OpFMul %371 %372 
					                                             OpStore %233 %373 
					                       Private f32* %374 = OpAccessChain %42 %67 
					                                f32 %375 = OpLoad %374 
					                                f32 %376 = OpFMul %375 %372 
					                                f32 %377 = OpLoad %58 
					                                f32 %378 = OpFAdd %376 %377 
					                                             OpStore %58 %378 
					                                f32 %379 = OpLoad %233 
					                              f32_3 %380 = OpCompositeConstruct %379 %379 %379 
					                              f32_3 %381 = OpLoad %32 
					                              f32_3 %382 = OpFMul %380 %381 
					                              f32_3 %383 = OpLoad %9 
					                              f32_3 %384 = OpFAdd %382 %383 
					                                             OpStore %9 %384 
					                read_only Texture2D %385 = OpLoad %12 
					                            sampler %386 = OpLoad %16 
					         read_only Texture2DSampled %387 = OpSampledImage %385 %386 
					                              f32_2 %388 = OpLoad vs_TEXCOORD0 
					                              f32_4 %391 = OpImageSampleImplicitLod %387 %388 ConstOffset %29 
					                              f32_3 %392 = OpVectorShuffle %391 %391 0 1 2 
					                                             OpStore %32 %392 
					                read_only Texture2D %393 = OpLoad %59 
					                            sampler %394 = OpLoad %61 
					         read_only Texture2DSampled %395 = OpSampledImage %393 %394 
					                              f32_2 %396 = OpLoad vs_TEXCOORD0 
					                              f32_4 %397 = OpImageSampleImplicitLod %395 %396 ConstOffset %29 
					                                f32 %398 = OpCompositeExtract %397 0 
					                       Private f32* %399 = OpAccessChain %42 %67 
					                                             OpStore %399 %398 
					                       Uniform f32* %400 = OpAccessChain %71 %26 %72 
					                                f32 %401 = OpLoad %400 
					                       Private f32* %402 = OpAccessChain %42 %67 
					                                f32 %403 = OpLoad %402 
					                                f32 %404 = OpFMul %401 %403 
					                       Uniform f32* %405 = OpAccessChain %71 %26 %78 
					                                f32 %406 = OpLoad %405 
					                                f32 %407 = OpFAdd %404 %406 
					                       Private f32* %408 = OpAccessChain %42 %67 
					                                             OpStore %408 %407 
					                       Private f32* %409 = OpAccessChain %42 %67 
					                                f32 %410 = OpLoad %409 
					                                f32 %411 = OpFDiv %82 %410 
					                       Private f32* %412 = OpAccessChain %42 %67 
					                                             OpStore %412 %411 
					                                f32 %413 = OpLoad %85 
					                       Private f32* %414 = OpAccessChain %42 %67 
					                                f32 %415 = OpLoad %414 
					                                f32 %416 = OpFNegate %415 
					                                f32 %417 = OpFAdd %413 %416 
					                       Private f32* %418 = OpAccessChain %42 %67 
					                                             OpStore %418 %417 
					                       Private f32* %419 = OpAccessChain %42 %67 
					                                f32 %420 = OpLoad %419 
					                                f32 %421 = OpExtInst %1 4 %420 
					                                f32 %422 = OpFMul %421 %107 
					                       Private f32* %423 = OpAccessChain %42 %67 
					                                             OpStore %423 %422 
					                       Private f32* %424 = OpAccessChain %42 %67 
					                                f32 %425 = OpLoad %424 
					                       Private f32* %426 = OpAccessChain %42 %67 
					                                f32 %427 = OpLoad %426 
					                                f32 %428 = OpFMul %425 %427 
					                       Private f32* %429 = OpAccessChain %42 %67 
					                                             OpStore %429 %428 
					                       Private f32* %430 = OpAccessChain %42 %67 
					                                f32 %431 = OpLoad %430 
					                                f32 %432 = OpFMul %431 %113 
					                       Private f32* %433 = OpAccessChain %42 %67 
					                                             OpStore %433 %432 
					                       Private f32* %434 = OpAccessChain %42 %67 
					                                f32 %435 = OpLoad %434 
					                                f32 %436 = OpExtInst %1 29 %435 
					                       Private f32* %437 = OpAccessChain %42 %67 
					                                             OpStore %437 %436 
					                       Private f32* %438 = OpAccessChain %42 %67 
					                                f32 %439 = OpLoad %438 
					                                f32 %441 = OpFMul %439 %440 
					                                             OpStore %233 %441 
					                       Private f32* %442 = OpAccessChain %42 %67 
					                                f32 %443 = OpLoad %442 
					                                f32 %444 = OpFMul %443 %440 
					                                f32 %445 = OpLoad %58 
					                                f32 %446 = OpFAdd %444 %445 
					                                             OpStore %58 %446 
					                                f32 %447 = OpLoad %233 
					                              f32_3 %448 = OpCompositeConstruct %447 %447 %447 
					                              f32_3 %449 = OpLoad %32 
					                              f32_3 %450 = OpFMul %448 %449 
					                              f32_3 %451 = OpLoad %9 
					                              f32_3 %452 = OpFAdd %450 %451 
					                                             OpStore %9 %452 
					                read_only Texture2D %453 = OpLoad %12 
					                            sampler %454 = OpLoad %16 
					         read_only Texture2DSampled %455 = OpSampledImage %453 %454 
					                              f32_2 %456 = OpLoad vs_TEXCOORD0 
					                              f32_4 %459 = OpImageSampleImplicitLod %455 %456 ConstOffset %29 
					                              f32_3 %460 = OpVectorShuffle %459 %459 0 1 2 
					                                             OpStore %32 %460 
					                read_only Texture2D %461 = OpLoad %59 
					                            sampler %462 = OpLoad %61 
					         read_only Texture2DSampled %463 = OpSampledImage %461 %462 
					                              f32_2 %464 = OpLoad vs_TEXCOORD0 
					                              f32_4 %465 = OpImageSampleImplicitLod %463 %464 ConstOffset %29 
					                                f32 %466 = OpCompositeExtract %465 0 
					                       Private f32* %467 = OpAccessChain %42 %67 
					                                             OpStore %467 %466 
					                       Uniform f32* %468 = OpAccessChain %71 %26 %72 
					                                f32 %469 = OpLoad %468 
					                       Private f32* %470 = OpAccessChain %42 %67 
					                                f32 %471 = OpLoad %470 
					                                f32 %472 = OpFMul %469 %471 
					                       Uniform f32* %473 = OpAccessChain %71 %26 %78 
					                                f32 %474 = OpLoad %473 
					                                f32 %475 = OpFAdd %472 %474 
					                       Private f32* %476 = OpAccessChain %42 %67 
					                                             OpStore %476 %475 
					                       Private f32* %477 = OpAccessChain %42 %67 
					                                f32 %478 = OpLoad %477 
					                                f32 %479 = OpFDiv %82 %478 
					                       Private f32* %480 = OpAccessChain %42 %67 
					                                             OpStore %480 %479 
					                                f32 %481 = OpLoad %85 
					                       Private f32* %482 = OpAccessChain %42 %67 
					                                f32 %483 = OpLoad %482 
					                                f32 %484 = OpFNegate %483 
					                                f32 %485 = OpFAdd %481 %484 
					                       Private f32* %486 = OpAccessChain %42 %67 
					                                             OpStore %486 %485 
					                       Private f32* %487 = OpAccessChain %42 %67 
					                                f32 %488 = OpLoad %487 
					                                f32 %489 = OpExtInst %1 4 %488 
					                                f32 %490 = OpFMul %489 %107 
					                       Private f32* %491 = OpAccessChain %42 %67 
					                                             OpStore %491 %490 
					                       Private f32* %492 = OpAccessChain %42 %67 
					                                f32 %493 = OpLoad %492 
					                       Private f32* %494 = OpAccessChain %42 %67 
					                                f32 %495 = OpLoad %494 
					                                f32 %496 = OpFMul %493 %495 
					                       Private f32* %497 = OpAccessChain %42 %67 
					                                             OpStore %497 %496 
					                       Private f32* %498 = OpAccessChain %42 %67 
					                                f32 %499 = OpLoad %498 
					                                f32 %500 = OpFMul %499 %113 
					                       Private f32* %501 = OpAccessChain %42 %67 
					                                             OpStore %501 %500 
					                       Private f32* %502 = OpAccessChain %42 %67 
					                                f32 %503 = OpLoad %502 
					                                f32 %504 = OpExtInst %1 29 %503 
					                       Private f32* %505 = OpAccessChain %42 %67 
					                                             OpStore %505 %504 
					                       Private f32* %506 = OpAccessChain %42 %67 
					                                f32 %507 = OpLoad %506 
					                                f32 %509 = OpFMul %507 %508 
					                                             OpStore %233 %509 
					                       Private f32* %510 = OpAccessChain %42 %67 
					                                f32 %511 = OpLoad %510 
					                                f32 %512 = OpFMul %511 %508 
					                                f32 %513 = OpLoad %58 
					                                f32 %514 = OpFAdd %512 %513 
					                                             OpStore %58 %514 
					                                f32 %515 = OpLoad %233 
					                              f32_3 %516 = OpCompositeConstruct %515 %515 %515 
					                              f32_3 %517 = OpLoad %32 
					                              f32_3 %518 = OpFMul %516 %517 
					                              f32_3 %519 = OpLoad %9 
					                              f32_3 %520 = OpFAdd %518 %519 
					                                             OpStore %9 %520 
					                read_only Texture2D %521 = OpLoad %12 
					                            sampler %522 = OpLoad %16 
					         read_only Texture2DSampled %523 = OpSampledImage %521 %522 
					                              f32_2 %524 = OpLoad vs_TEXCOORD0 
					                              f32_4 %527 = OpImageSampleImplicitLod %523 %524 ConstOffset %29 
					                              f32_3 %528 = OpVectorShuffle %527 %527 0 1 2 
					                                             OpStore %32 %528 
					                read_only Texture2D %529 = OpLoad %59 
					                            sampler %530 = OpLoad %61 
					         read_only Texture2DSampled %531 = OpSampledImage %529 %530 
					                              f32_2 %532 = OpLoad vs_TEXCOORD0 
					                              f32_4 %533 = OpImageSampleImplicitLod %531 %532 ConstOffset %29 
					                                f32 %534 = OpCompositeExtract %533 0 
					                       Private f32* %535 = OpAccessChain %42 %67 
					                                             OpStore %535 %534 
					                       Uniform f32* %536 = OpAccessChain %71 %26 %72 
					                                f32 %537 = OpLoad %536 
					                       Private f32* %538 = OpAccessChain %42 %67 
					                                f32 %539 = OpLoad %538 
					                                f32 %540 = OpFMul %537 %539 
					                       Uniform f32* %541 = OpAccessChain %71 %26 %78 
					                                f32 %542 = OpLoad %541 
					                                f32 %543 = OpFAdd %540 %542 
					                       Private f32* %544 = OpAccessChain %42 %67 
					                                             OpStore %544 %543 
					                       Private f32* %545 = OpAccessChain %42 %67 
					                                f32 %546 = OpLoad %545 
					                                f32 %547 = OpFDiv %82 %546 
					                       Private f32* %548 = OpAccessChain %42 %67 
					                                             OpStore %548 %547 
					                                f32 %549 = OpLoad %85 
					                       Private f32* %550 = OpAccessChain %42 %67 
					                                f32 %551 = OpLoad %550 
					                                f32 %552 = OpFNegate %551 
					                                f32 %553 = OpFAdd %549 %552 
					                       Private f32* %554 = OpAccessChain %42 %67 
					                                             OpStore %554 %553 
					                       Private f32* %555 = OpAccessChain %42 %67 
					                                f32 %556 = OpLoad %555 
					                                f32 %557 = OpExtInst %1 4 %556 
					                                f32 %558 = OpFMul %557 %107 
					                       Private f32* %559 = OpAccessChain %42 %67 
					                                             OpStore %559 %558 
					                       Private f32* %560 = OpAccessChain %42 %67 
					                                f32 %561 = OpLoad %560 
					                       Private f32* %562 = OpAccessChain %42 %67 
					                                f32 %563 = OpLoad %562 
					                                f32 %564 = OpFMul %561 %563 
					                       Private f32* %565 = OpAccessChain %42 %67 
					                                             OpStore %565 %564 
					                       Private f32* %566 = OpAccessChain %42 %67 
					                                f32 %567 = OpLoad %566 
					                                f32 %568 = OpFMul %567 %113 
					                       Private f32* %569 = OpAccessChain %42 %67 
					                                             OpStore %569 %568 
					                       Private f32* %570 = OpAccessChain %42 %67 
					                                f32 %571 = OpLoad %570 
					                                f32 %572 = OpExtInst %1 29 %571 
					                       Private f32* %573 = OpAccessChain %42 %67 
					                                             OpStore %573 %572 
					                       Private f32* %574 = OpAccessChain %42 %67 
					                                f32 %575 = OpLoad %574 
					                                f32 %576 = OpFMul %575 %508 
					                                             OpStore %233 %576 
					                       Private f32* %577 = OpAccessChain %42 %67 
					                                f32 %578 = OpLoad %577 
					                                f32 %579 = OpFMul %578 %508 
					                                f32 %580 = OpLoad %58 
					                                f32 %581 = OpFAdd %579 %580 
					                                             OpStore %58 %581 
					                                f32 %582 = OpLoad %233 
					                              f32_3 %583 = OpCompositeConstruct %582 %582 %582 
					                              f32_3 %584 = OpLoad %32 
					                              f32_3 %585 = OpFMul %583 %584 
					                              f32_3 %586 = OpLoad %9 
					                              f32_3 %587 = OpFAdd %585 %586 
					                                             OpStore %9 %587 
					                read_only Texture2D %588 = OpLoad %12 
					                            sampler %589 = OpLoad %16 
					         read_only Texture2DSampled %590 = OpSampledImage %588 %589 
					                              f32_2 %591 = OpLoad vs_TEXCOORD0 
					                              f32_4 %594 = OpImageSampleImplicitLod %590 %591 ConstOffset %29 
					                              f32_3 %595 = OpVectorShuffle %594 %594 0 1 2 
					                                             OpStore %32 %595 
					                read_only Texture2D %596 = OpLoad %59 
					                            sampler %597 = OpLoad %61 
					         read_only Texture2DSampled %598 = OpSampledImage %596 %597 
					                              f32_2 %599 = OpLoad vs_TEXCOORD0 
					                              f32_4 %600 = OpImageSampleImplicitLod %598 %599 ConstOffset %29 
					                                f32 %601 = OpCompositeExtract %600 0 
					                       Private f32* %602 = OpAccessChain %42 %67 
					                                             OpStore %602 %601 
					                       Uniform f32* %603 = OpAccessChain %71 %26 %72 
					                                f32 %604 = OpLoad %603 
					                       Private f32* %605 = OpAccessChain %42 %67 
					                                f32 %606 = OpLoad %605 
					                                f32 %607 = OpFMul %604 %606 
					                       Uniform f32* %608 = OpAccessChain %71 %26 %78 
					                                f32 %609 = OpLoad %608 
					                                f32 %610 = OpFAdd %607 %609 
					                       Private f32* %611 = OpAccessChain %42 %67 
					                                             OpStore %611 %610 
					                       Private f32* %612 = OpAccessChain %42 %67 
					                                f32 %613 = OpLoad %612 
					                                f32 %614 = OpFDiv %82 %613 
					                       Private f32* %615 = OpAccessChain %42 %67 
					                                             OpStore %615 %614 
					                                f32 %616 = OpLoad %85 
					                       Private f32* %617 = OpAccessChain %42 %67 
					                                f32 %618 = OpLoad %617 
					                                f32 %619 = OpFNegate %618 
					                                f32 %620 = OpFAdd %616 %619 
					                       Private f32* %621 = OpAccessChain %42 %67 
					                                             OpStore %621 %620 
					                       Private f32* %622 = OpAccessChain %42 %67 
					                                f32 %623 = OpLoad %622 
					                                f32 %624 = OpExtInst %1 4 %623 
					                                f32 %625 = OpFMul %624 %107 
					                       Private f32* %626 = OpAccessChain %42 %67 
					                                             OpStore %626 %625 
					                       Private f32* %627 = OpAccessChain %42 %67 
					                                f32 %628 = OpLoad %627 
					                       Private f32* %629 = OpAccessChain %42 %67 
					                                f32 %630 = OpLoad %629 
					                                f32 %631 = OpFMul %628 %630 
					                       Private f32* %632 = OpAccessChain %42 %67 
					                                             OpStore %632 %631 
					                       Private f32* %633 = OpAccessChain %42 %67 
					                                f32 %634 = OpLoad %633 
					                                f32 %635 = OpFMul %634 %113 
					                       Private f32* %636 = OpAccessChain %42 %67 
					                                             OpStore %636 %635 
					                       Private f32* %637 = OpAccessChain %42 %67 
					                                f32 %638 = OpLoad %637 
					                                f32 %639 = OpExtInst %1 29 %638 
					                       Private f32* %640 = OpAccessChain %42 %67 
					                                             OpStore %640 %639 
					                       Private f32* %641 = OpAccessChain %42 %67 
					                                f32 %642 = OpLoad %641 
					                                f32 %643 = OpFMul %642 %440 
					                                             OpStore %233 %643 
					                       Private f32* %644 = OpAccessChain %42 %67 
					                                f32 %645 = OpLoad %644 
					                                f32 %646 = OpFMul %645 %440 
					                                f32 %647 = OpLoad %58 
					                                f32 %648 = OpFAdd %646 %647 
					                                             OpStore %58 %648 
					                                f32 %649 = OpLoad %233 
					                              f32_3 %650 = OpCompositeConstruct %649 %649 %649 
					                              f32_3 %651 = OpLoad %32 
					                              f32_3 %652 = OpFMul %650 %651 
					                              f32_3 %653 = OpLoad %9 
					                              f32_3 %654 = OpFAdd %652 %653 
					                                             OpStore %9 %654 
					                read_only Texture2D %655 = OpLoad %12 
					                            sampler %656 = OpLoad %16 
					         read_only Texture2DSampled %657 = OpSampledImage %655 %656 
					                              f32_2 %658 = OpLoad vs_TEXCOORD0 
					                              f32_4 %661 = OpImageSampleImplicitLod %657 %658 ConstOffset %29 
					                              f32_3 %662 = OpVectorShuffle %661 %661 0 1 2 
					                                             OpStore %32 %662 
					                read_only Texture2D %663 = OpLoad %59 
					                            sampler %664 = OpLoad %61 
					         read_only Texture2DSampled %665 = OpSampledImage %663 %664 
					                              f32_2 %666 = OpLoad vs_TEXCOORD0 
					                              f32_4 %667 = OpImageSampleImplicitLod %665 %666 ConstOffset %29 
					                                f32 %668 = OpCompositeExtract %667 0 
					                       Private f32* %669 = OpAccessChain %42 %67 
					                                             OpStore %669 %668 
					                       Uniform f32* %670 = OpAccessChain %71 %26 %72 
					                                f32 %671 = OpLoad %670 
					                       Private f32* %672 = OpAccessChain %42 %67 
					                                f32 %673 = OpLoad %672 
					                                f32 %674 = OpFMul %671 %673 
					                       Uniform f32* %675 = OpAccessChain %71 %26 %78 
					                                f32 %676 = OpLoad %675 
					                                f32 %677 = OpFAdd %674 %676 
					                       Private f32* %678 = OpAccessChain %42 %67 
					                                             OpStore %678 %677 
					                       Private f32* %679 = OpAccessChain %42 %67 
					                                f32 %680 = OpLoad %679 
					                                f32 %681 = OpFDiv %82 %680 
					                       Private f32* %682 = OpAccessChain %42 %67 
					                                             OpStore %682 %681 
					                                f32 %683 = OpLoad %85 
					                       Private f32* %684 = OpAccessChain %42 %67 
					                                f32 %685 = OpLoad %684 
					                                f32 %686 = OpFNegate %685 
					                                f32 %687 = OpFAdd %683 %686 
					                       Private f32* %688 = OpAccessChain %42 %67 
					                                             OpStore %688 %687 
					                       Private f32* %689 = OpAccessChain %42 %67 
					                                f32 %690 = OpLoad %689 
					                                f32 %691 = OpExtInst %1 4 %690 
					                                f32 %692 = OpFMul %691 %107 
					                       Private f32* %693 = OpAccessChain %42 %67 
					                                             OpStore %693 %692 
					                       Private f32* %694 = OpAccessChain %42 %67 
					                                f32 %695 = OpLoad %694 
					                       Private f32* %696 = OpAccessChain %42 %67 
					                                f32 %697 = OpLoad %696 
					                                f32 %698 = OpFMul %695 %697 
					                       Private f32* %699 = OpAccessChain %42 %67 
					                                             OpStore %699 %698 
					                       Private f32* %700 = OpAccessChain %42 %67 
					                                f32 %701 = OpLoad %700 
					                                f32 %702 = OpFMul %701 %113 
					                       Private f32* %703 = OpAccessChain %42 %67 
					                                             OpStore %703 %702 
					                       Private f32* %704 = OpAccessChain %42 %67 
					                                f32 %705 = OpLoad %704 
					                                f32 %706 = OpExtInst %1 29 %705 
					                       Private f32* %707 = OpAccessChain %42 %67 
					                                             OpStore %707 %706 
					                       Private f32* %708 = OpAccessChain %42 %67 
					                                f32 %709 = OpLoad %708 
					                                f32 %710 = OpFMul %709 %372 
					                                             OpStore %233 %710 
					                       Private f32* %711 = OpAccessChain %42 %67 
					                                f32 %712 = OpLoad %711 
					                                f32 %713 = OpFMul %712 %372 
					                                f32 %714 = OpLoad %58 
					                                f32 %715 = OpFAdd %713 %714 
					                                             OpStore %58 %715 
					                                f32 %716 = OpLoad %233 
					                              f32_3 %717 = OpCompositeConstruct %716 %716 %716 
					                              f32_3 %718 = OpLoad %32 
					                              f32_3 %719 = OpFMul %717 %718 
					                              f32_3 %720 = OpLoad %9 
					                              f32_3 %721 = OpFAdd %719 %720 
					                                             OpStore %9 %721 
					                read_only Texture2D %722 = OpLoad %12 
					                            sampler %723 = OpLoad %16 
					         read_only Texture2DSampled %724 = OpSampledImage %722 %723 
					                              f32_2 %725 = OpLoad vs_TEXCOORD0 
					                              f32_4 %728 = OpImageSampleImplicitLod %724 %725 ConstOffset %29 
					                              f32_3 %729 = OpVectorShuffle %728 %728 0 1 2 
					                                             OpStore %32 %729 
					                read_only Texture2D %730 = OpLoad %59 
					                            sampler %731 = OpLoad %61 
					         read_only Texture2DSampled %732 = OpSampledImage %730 %731 
					                              f32_2 %733 = OpLoad vs_TEXCOORD0 
					                              f32_4 %734 = OpImageSampleImplicitLod %732 %733 ConstOffset %29 
					                                f32 %735 = OpCompositeExtract %734 0 
					                       Private f32* %736 = OpAccessChain %42 %67 
					                                             OpStore %736 %735 
					                       Uniform f32* %737 = OpAccessChain %71 %26 %72 
					                                f32 %738 = OpLoad %737 
					                       Private f32* %739 = OpAccessChain %42 %67 
					                                f32 %740 = OpLoad %739 
					                                f32 %741 = OpFMul %738 %740 
					                       Uniform f32* %742 = OpAccessChain %71 %26 %78 
					                                f32 %743 = OpLoad %742 
					                                f32 %744 = OpFAdd %741 %743 
					                       Private f32* %745 = OpAccessChain %42 %67 
					                                             OpStore %745 %744 
					                       Private f32* %746 = OpAccessChain %42 %67 
					                                f32 %747 = OpLoad %746 
					                                f32 %748 = OpFDiv %82 %747 
					                       Private f32* %749 = OpAccessChain %42 %67 
					                                             OpStore %749 %748 
					                                f32 %750 = OpLoad %85 
					                       Private f32* %751 = OpAccessChain %42 %67 
					                                f32 %752 = OpLoad %751 
					                                f32 %753 = OpFNegate %752 
					                                f32 %754 = OpFAdd %750 %753 
					                       Private f32* %755 = OpAccessChain %42 %67 
					                                             OpStore %755 %754 
					                       Private f32* %756 = OpAccessChain %42 %67 
					                                f32 %757 = OpLoad %756 
					                                f32 %758 = OpExtInst %1 4 %757 
					                                f32 %759 = OpFMul %758 %107 
					                       Private f32* %760 = OpAccessChain %42 %67 
					                                             OpStore %760 %759 
					                       Private f32* %761 = OpAccessChain %42 %67 
					                                f32 %762 = OpLoad %761 
					                       Private f32* %763 = OpAccessChain %42 %67 
					                                f32 %764 = OpLoad %763 
					                                f32 %765 = OpFMul %762 %764 
					                       Private f32* %766 = OpAccessChain %42 %67 
					                                             OpStore %766 %765 
					                       Private f32* %767 = OpAccessChain %42 %67 
					                                f32 %768 = OpLoad %767 
					                                f32 %769 = OpFMul %768 %113 
					                       Private f32* %770 = OpAccessChain %42 %67 
					                                             OpStore %770 %769 
					                       Private f32* %771 = OpAccessChain %42 %67 
					                                f32 %772 = OpLoad %771 
					                                f32 %773 = OpExtInst %1 29 %772 
					                       Private f32* %774 = OpAccessChain %42 %67 
					                                             OpStore %774 %773 
					                       Private f32* %775 = OpAccessChain %42 %67 
					                                f32 %776 = OpLoad %775 
					                                f32 %777 = OpFMul %776 %304 
					                                             OpStore %233 %777 
					                       Private f32* %778 = OpAccessChain %42 %67 
					                                f32 %779 = OpLoad %778 
					                                f32 %780 = OpFMul %779 %304 
					                                f32 %781 = OpLoad %58 
					                                f32 %782 = OpFAdd %780 %781 
					                                             OpStore %58 %782 
					                                f32 %783 = OpLoad %233 
					                              f32_3 %784 = OpCompositeConstruct %783 %783 %783 
					                              f32_3 %785 = OpLoad %32 
					                              f32_3 %786 = OpFMul %784 %785 
					                              f32_3 %787 = OpLoad %9 
					                              f32_3 %788 = OpFAdd %786 %787 
					                                             OpStore %9 %788 
					                read_only Texture2D %789 = OpLoad %12 
					                            sampler %790 = OpLoad %16 
					         read_only Texture2DSampled %791 = OpSampledImage %789 %790 
					                              f32_2 %792 = OpLoad vs_TEXCOORD0 
					                              f32_4 %795 = OpImageSampleImplicitLod %791 %792 ConstOffset %29 
					                              f32_3 %796 = OpVectorShuffle %795 %795 0 1 2 
					                                             OpStore %32 %796 
					                read_only Texture2D %797 = OpLoad %59 
					                            sampler %798 = OpLoad %61 
					         read_only Texture2DSampled %799 = OpSampledImage %797 %798 
					                              f32_2 %800 = OpLoad vs_TEXCOORD0 
					                              f32_4 %801 = OpImageSampleImplicitLod %799 %800 ConstOffset %29 
					                                f32 %802 = OpCompositeExtract %801 0 
					                       Private f32* %803 = OpAccessChain %42 %67 
					                                             OpStore %803 %802 
					                       Uniform f32* %804 = OpAccessChain %71 %26 %72 
					                                f32 %805 = OpLoad %804 
					                       Private f32* %806 = OpAccessChain %42 %67 
					                                f32 %807 = OpLoad %806 
					                                f32 %808 = OpFMul %805 %807 
					                       Uniform f32* %809 = OpAccessChain %71 %26 %78 
					                                f32 %810 = OpLoad %809 
					                                f32 %811 = OpFAdd %808 %810 
					                       Private f32* %812 = OpAccessChain %42 %67 
					                                             OpStore %812 %811 
					                       Private f32* %813 = OpAccessChain %42 %67 
					                                f32 %814 = OpLoad %813 
					                                f32 %815 = OpFDiv %82 %814 
					                       Private f32* %816 = OpAccessChain %42 %67 
					                                             OpStore %816 %815 
					                                f32 %817 = OpLoad %85 
					                       Private f32* %818 = OpAccessChain %42 %67 
					                                f32 %819 = OpLoad %818 
					                                f32 %820 = OpFNegate %819 
					                                f32 %821 = OpFAdd %817 %820 
					                       Private f32* %822 = OpAccessChain %42 %67 
					                                             OpStore %822 %821 
					                       Private f32* %823 = OpAccessChain %42 %67 
					                                f32 %824 = OpLoad %823 
					                                f32 %825 = OpExtInst %1 4 %824 
					                                f32 %826 = OpFMul %825 %107 
					                       Private f32* %827 = OpAccessChain %42 %67 
					                                             OpStore %827 %826 
					                       Private f32* %828 = OpAccessChain %42 %67 
					                                f32 %829 = OpLoad %828 
					                       Private f32* %830 = OpAccessChain %42 %67 
					                                f32 %831 = OpLoad %830 
					                                f32 %832 = OpFMul %829 %831 
					                       Private f32* %833 = OpAccessChain %42 %67 
					                                             OpStore %833 %832 
					                       Private f32* %834 = OpAccessChain %42 %67 
					                                f32 %835 = OpLoad %834 
					                                f32 %836 = OpFMul %835 %113 
					                       Private f32* %837 = OpAccessChain %42 %67 
					                                             OpStore %837 %836 
					                       Private f32* %838 = OpAccessChain %42 %67 
					                                f32 %839 = OpLoad %838 
					                                f32 %840 = OpExtInst %1 29 %839 
					                       Private f32* %841 = OpAccessChain %42 %67 
					                                             OpStore %841 %840 
					                       Private f32* %842 = OpAccessChain %42 %67 
					                                f32 %843 = OpLoad %842 
					                                f32 %844 = OpFMul %843 %236 
					                                             OpStore %233 %844 
					                       Private f32* %845 = OpAccessChain %42 %67 
					                                f32 %846 = OpLoad %845 
					                                f32 %847 = OpFMul %846 %236 
					                                f32 %848 = OpLoad %58 
					                                f32 %849 = OpFAdd %847 %848 
					                                             OpStore %58 %849 
					                                f32 %850 = OpLoad %233 
					                              f32_3 %851 = OpCompositeConstruct %850 %850 %850 
					                              f32_3 %852 = OpLoad %32 
					                              f32_3 %853 = OpFMul %851 %852 
					                              f32_3 %854 = OpLoad %9 
					                              f32_3 %855 = OpFAdd %853 %854 
					                                             OpStore %9 %855 
					                read_only Texture2D %856 = OpLoad %12 
					                            sampler %857 = OpLoad %16 
					         read_only Texture2DSampled %858 = OpSampledImage %856 %857 
					                              f32_2 %859 = OpLoad vs_TEXCOORD0 
					                              f32_4 %862 = OpImageSampleImplicitLod %858 %859 ConstOffset %29 
					                              f32_3 %863 = OpVectorShuffle %862 %862 0 1 2 
					                                             OpStore %32 %863 
					                read_only Texture2D %864 = OpLoad %59 
					                            sampler %865 = OpLoad %61 
					         read_only Texture2DSampled %866 = OpSampledImage %864 %865 
					                              f32_2 %867 = OpLoad vs_TEXCOORD0 
					                              f32_4 %868 = OpImageSampleImplicitLod %866 %867 ConstOffset %29 
					                                f32 %869 = OpCompositeExtract %868 0 
					                       Private f32* %870 = OpAccessChain %42 %67 
					                                             OpStore %870 %869 
					                       Uniform f32* %871 = OpAccessChain %71 %26 %72 
					                                f32 %872 = OpLoad %871 
					                       Private f32* %873 = OpAccessChain %42 %67 
					                                f32 %874 = OpLoad %873 
					                                f32 %875 = OpFMul %872 %874 
					                       Uniform f32* %876 = OpAccessChain %71 %26 %78 
					                                f32 %877 = OpLoad %876 
					                                f32 %878 = OpFAdd %875 %877 
					                       Private f32* %879 = OpAccessChain %42 %67 
					                                             OpStore %879 %878 
					                       Private f32* %880 = OpAccessChain %42 %67 
					                                f32 %881 = OpLoad %880 
					                                f32 %882 = OpFDiv %82 %881 
					                       Private f32* %883 = OpAccessChain %42 %67 
					                                             OpStore %883 %882 
					                                f32 %884 = OpLoad %85 
					                       Private f32* %885 = OpAccessChain %42 %67 
					                                f32 %886 = OpLoad %885 
					                                f32 %887 = OpFNegate %886 
					                                f32 %888 = OpFAdd %884 %887 
					                       Private f32* %889 = OpAccessChain %42 %67 
					                                             OpStore %889 %888 
					                       Private f32* %890 = OpAccessChain %42 %67 
					                                f32 %891 = OpLoad %890 
					                                f32 %892 = OpExtInst %1 4 %891 
					                                f32 %893 = OpFMul %892 %107 
					                       Private f32* %894 = OpAccessChain %42 %67 
					                                             OpStore %894 %893 
					                       Private f32* %895 = OpAccessChain %42 %67 
					                                f32 %896 = OpLoad %895 
					                       Private f32* %897 = OpAccessChain %42 %67 
					                                f32 %898 = OpLoad %897 
					                                f32 %899 = OpFMul %896 %898 
					                       Private f32* %900 = OpAccessChain %42 %67 
					                                             OpStore %900 %899 
					                       Private f32* %901 = OpAccessChain %42 %67 
					                                f32 %902 = OpLoad %901 
					                                f32 %903 = OpFMul %902 %113 
					                       Private f32* %904 = OpAccessChain %42 %67 
					                                             OpStore %904 %903 
					                       Private f32* %905 = OpAccessChain %42 %67 
					                                f32 %906 = OpLoad %905 
					                                f32 %907 = OpExtInst %1 29 %906 
					                       Private f32* %908 = OpAccessChain %42 %67 
					                                             OpStore %908 %907 
					                       Private f32* %909 = OpAccessChain %42 %67 
					                                f32 %910 = OpLoad %909 
					                                f32 %911 = OpFMul %910 %174 
					                                             OpStore %233 %911 
					                       Private f32* %912 = OpAccessChain %42 %67 
					                                f32 %913 = OpLoad %912 
					                                f32 %914 = OpFMul %913 %174 
					                                f32 %915 = OpLoad %58 
					                                f32 %916 = OpFAdd %914 %915 
					                                             OpStore %58 %916 
					                                f32 %917 = OpLoad %233 
					                              f32_3 %918 = OpCompositeConstruct %917 %917 %917 
					                              f32_3 %919 = OpLoad %32 
					                              f32_3 %920 = OpFMul %918 %919 
					                              f32_3 %921 = OpLoad %9 
					                              f32_3 %922 = OpFAdd %920 %921 
					                                             OpStore %9 %922 
					                read_only Texture2D %923 = OpLoad %12 
					                            sampler %924 = OpLoad %16 
					         read_only Texture2DSampled %925 = OpSampledImage %923 %924 
					                              f32_2 %926 = OpLoad vs_TEXCOORD0 
					                              f32_4 %929 = OpImageSampleImplicitLod %925 %926 ConstOffset %29 
					                              f32_3 %930 = OpVectorShuffle %929 %929 0 1 2 
					                                             OpStore %32 %930 
					                read_only Texture2D %931 = OpLoad %59 
					                            sampler %932 = OpLoad %61 
					         read_only Texture2DSampled %933 = OpSampledImage %931 %932 
					                              f32_2 %934 = OpLoad vs_TEXCOORD0 
					                              f32_4 %935 = OpImageSampleImplicitLod %933 %934 ConstOffset %29 
					                                f32 %936 = OpCompositeExtract %935 0 
					                       Private f32* %937 = OpAccessChain %42 %67 
					                                             OpStore %937 %936 
					                       Uniform f32* %938 = OpAccessChain %71 %26 %72 
					                                f32 %939 = OpLoad %938 
					                       Private f32* %940 = OpAccessChain %42 %67 
					                                f32 %941 = OpLoad %940 
					                                f32 %942 = OpFMul %939 %941 
					                       Uniform f32* %943 = OpAccessChain %71 %26 %78 
					                                f32 %944 = OpLoad %943 
					                                f32 %945 = OpFAdd %942 %944 
					                       Private f32* %946 = OpAccessChain %42 %67 
					                                             OpStore %946 %945 
					                       Private f32* %947 = OpAccessChain %42 %67 
					                                f32 %948 = OpLoad %947 
					                                f32 %949 = OpFDiv %82 %948 
					                       Private f32* %950 = OpAccessChain %42 %67 
					                                             OpStore %950 %949 
					                                f32 %951 = OpLoad %85 
					                       Private f32* %952 = OpAccessChain %42 %67 
					                                f32 %953 = OpLoad %952 
					                                f32 %954 = OpFNegate %953 
					                                f32 %955 = OpFAdd %951 %954 
					                                             OpStore %85 %955 
					                                f32 %956 = OpLoad %85 
					                                f32 %957 = OpExtInst %1 4 %956 
					                                f32 %958 = OpFMul %957 %107 
					                                             OpStore %85 %958 
					                                f32 %959 = OpLoad %85 
					                                f32 %960 = OpLoad %85 
					                                f32 %961 = OpFMul %959 %960 
					                                             OpStore %85 %961 
					                                f32 %962 = OpLoad %85 
					                                f32 %963 = OpFMul %962 %113 
					                                             OpStore %85 %963 
					                                f32 %964 = OpLoad %85 
					                                f32 %965 = OpExtInst %1 29 %964 
					                                             OpStore %85 %965 
					                                f32 %966 = OpLoad %85 
					                                f32 %967 = OpFMul %966 %119 
					                       Private f32* %968 = OpAccessChain %42 %67 
					                                             OpStore %968 %967 
					                                f32 %969 = OpLoad %85 
					                                f32 %970 = OpFMul %969 %119 
					                                f32 %971 = OpLoad %58 
					                                f32 %972 = OpFAdd %970 %971 
					                                             OpStore %58 %972 
					                              f32_4 %973 = OpLoad %42 
					                              f32_3 %974 = OpVectorShuffle %973 %973 0 0 0 
					                              f32_3 %975 = OpLoad %32 
					                              f32_3 %976 = OpFMul %974 %975 
					                              f32_3 %977 = OpLoad %9 
					                              f32_3 %978 = OpFAdd %976 %977 
					                                             OpStore %9 %978 
					                              f32_3 %979 = OpLoad %9 
					                                f32 %980 = OpLoad %58 
					                              f32_3 %981 = OpCompositeConstruct %980 %980 %980 
					                              f32_3 %982 = OpFDiv %979 %981 
					                              f32_4 %983 = OpLoad %138 
					                              f32_4 %984 = OpVectorShuffle %983 %982 4 5 6 3 
					                                             OpStore %138 %984 
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[7];
						vec4 _ZBufferParams;
						vec4 unused_0_2;
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat6;
					float u_xlat7;
					float u_xlat15;
					float u_xlat16;
					float u_xlat17;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -5));
					    u_xlat1 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -6));
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -7));
					    u_xlat4 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, -7));
					    u_xlat15 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat15 = float(1.0) / u_xlat15;
					    u_xlat4 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat16 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat16 = float(1.0) / u_xlat16;
					    u_xlat15 = (-u_xlat15) + u_xlat16;
					    u_xlat15 = abs(u_xlat15) * 0.5;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat15 = u_xlat15 * -1.44269502;
					    u_xlat15 = exp2(u_xlat15);
					    u_xlat18 = u_xlat15 * 0.0277537704;
					    u_xlat15 = u_xlat15 * 0.0277537704 + 0.0854876339;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.0854876339, 0.0854876339, 0.0854876339) + u_xlat3.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, -6));
					    u_xlat17 = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat17 = float(1.0) / u_xlat17;
					    u_xlat17 = u_xlat16 + (-u_xlat17);
					    u_xlat17 = abs(u_xlat17) * 0.5;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat17 = u_xlat17 * -1.44269502;
					    u_xlat17 = exp2(u_xlat17);
					    u_xlat3.x = u_xlat17 * 0.03740637;
					    u_xlat15 = u_xlat17 * 0.03740637 + u_xlat15;
					    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, -5));
					    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.x = u_xlat16 + (-u_xlat2.x);
					    u_xlat2.x = abs(u_xlat2.x) * 0.5;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * -1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat7 = u_xlat2.x * 0.048153419;
					    u_xlat15 = u_xlat2.x * 0.048153419 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat7) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -4));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, -4));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0592061132;
					    u_xlat15 = u_xlat1.x * 0.0592061132 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -3));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, -3));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0695286617;
					    u_xlat15 = u_xlat1.x * 0.0695286617 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -2));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, -2));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0779864416;
					    u_xlat15 = u_xlat1.x * 0.0779864416 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -1));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, -1));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0835472643;
					    u_xlat15 = u_xlat1.x * 0.0835472643 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 1));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, 1));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0835472643;
					    u_xlat15 = u_xlat1.x * 0.0835472643 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 2));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, 2));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0779864416;
					    u_xlat15 = u_xlat1.x * 0.0779864416 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 3));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, 3));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0695286617;
					    u_xlat15 = u_xlat1.x * 0.0695286617 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 4));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, 4));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0592061132;
					    u_xlat15 = u_xlat1.x * 0.0592061132 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 5));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, 5));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.048153419;
					    u_xlat15 = u_xlat1.x * 0.048153419 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 6));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, 6));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.03740637;
					    u_xlat15 = u_xlat1.x * 0.03740637 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 7));
					    u_xlat3 = textureOffset(_CameraDepthTexture, vs_TEXCOORD0.xy, ivec2(0, 7));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat16;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6 = u_xlat1.x * 0.0277537704;
					    u_xlat15 = u_xlat1.x * 0.0277537704 + u_xlat15;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz / vec3(u_xlat15);
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
			GpuProgramID 172132
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
					UNITY_LOCATION(0) uniform  sampler2D _HalfResDepthBuffer;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat5;
					float u_xlat6;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-4, 0));
					    u_xlat1 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-5, 0));
					    u_xlat2 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-5, 0));
					    u_xlat12 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat2 = texture(_HalfResDepthBuffer, vs_TEXCOORD0.xy);
					    u_xlat13 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat12 = (-u_xlat12) + u_xlat13;
					    u_xlat12 = abs(u_xlat12) * 0.5;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat12 = u_xlat12 * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat2.x = u_xlat12 * 0.0388552807;
					    u_xlat12 = u_xlat12 * 0.0388552807 + 0.119682692;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat2.xyz * vec3(0.119682692, 0.119682692, 0.119682692) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat2 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-4, 0));
					    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.x = u_xlat13 + (-u_xlat2.x);
					    u_xlat2.x = abs(u_xlat2.x) * 0.5;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * -1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat6 = u_xlat2.x * 0.058255814;
					    u_xlat12 = u_xlat2.x * 0.058255814 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-3, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-3, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0798255801;
					    u_xlat12 = u_xlat1.x * 0.0798255801 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-2, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-2, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0999673903;
					    u_xlat12 = u_xlat1.x * 0.0999673903 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-1, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-1, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.114416353;
					    u_xlat12 = u_xlat1.x * 0.114416353 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(1, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(1, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.114416353;
					    u_xlat12 = u_xlat1.x * 0.114416353 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(2, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(2, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0999673903;
					    u_xlat12 = u_xlat1.x * 0.0999673903 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(3, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(3, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0798255801;
					    u_xlat12 = u_xlat1.x * 0.0798255801 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(4, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(4, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.058255814;
					    u_xlat12 = u_xlat1.x * 0.058255814 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(5, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(5, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0388552807;
					    u_xlat12 = u_xlat1.x * 0.0388552807 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz / vec3(u_xlat12);
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
					; Bound: 728
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %127 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %43 DescriptorSet 43 
					                                             OpDecorate %43 Binding 43 
					                                             OpDecorate %45 DescriptorSet 45 
					                                             OpDecorate %45 Binding 45 
					                                             OpMemberDecorate %53 0 Offset 53 
					                                             OpDecorate %53 Block 
					                                             OpDecorate %55 DescriptorSet 55 
					                                             OpDecorate %55 Binding 55 
					                                             OpDecorate %127 Location 127 
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
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %24 = OpTypeInt 32 1 
					                                     %25 = OpTypeVector %24 2 
					                                 i32 %26 = OpConstant -4 
					                                 i32 %27 = OpConstant 0 
					                               i32_2 %28 = OpConstantComposite %26 %27 
					                                     %29 = OpTypeVector %6 4 
					                      Private f32_3* %32 = OpVariable Private 
					                                 i32 %37 = OpConstant -5 
					                               i32_2 %38 = OpConstantComposite %37 %27 
					                                     %41 = OpTypePointer Private %6 
					                        Private f32* %42 = OpVariable Private 
					UniformConstant read_only Texture2D* %43 = OpVariable UniformConstant 
					            UniformConstant sampler* %45 = OpVariable UniformConstant 
					                                     %50 = OpTypeInt 32 0 
					                                 u32 %51 = OpConstant 0 
					                                     %53 = OpTypeStruct %29 
					                                     %54 = OpTypePointer Uniform %53 
					            Uniform struct {f32_4;}* %55 = OpVariable Uniform 
					                                 u32 %56 = OpConstant 2 
					                                     %57 = OpTypePointer Uniform %6 
					                                 u32 %62 = OpConstant 3 
					                                 f32 %66 = OpConstant 3,674022E-40 
					                        Private f32* %69 = OpVariable Private 
					                                 f32 %91 = OpConstant 3,674022E-40 
					                                 f32 %97 = OpConstant 3,674022E-40 
					                                    %101 = OpTypePointer Private %29 
					                     Private f32_4* %102 = OpVariable Private 
					                                f32 %104 = OpConstant 3,674022E-40 
					                                f32 %109 = OpConstant 3,674022E-40 
					                              f32_3 %122 = OpConstantComposite %109 %109 %109 
					                                    %126 = OpTypePointer Output %29 
					                      Output f32_4* %127 = OpVariable Output 
					                                    %130 = OpTypePointer Output %6 
					                       Private f32* %177 = OpVariable Private 
					                                f32 %180 = OpConstant 3,674022E-40 
					                                i32 %197 = OpConstant -3 
					                              i32_2 %198 = OpConstantComposite %197 %27 
					                                f32 %248 = OpConstant 3,674022E-40 
					                                i32 %265 = OpConstant -2 
					                              i32_2 %266 = OpConstantComposite %265 %27 
					                                f32 %316 = OpConstant 3,674022E-40 
					                                i32 %333 = OpConstant -1 
					                              i32_2 %334 = OpConstantComposite %333 %27 
					                                f32 %384 = OpConstant 3,674022E-40 
					                                i32 %401 = OpConstant 1 
					                              i32_2 %402 = OpConstantComposite %401 %27 
					                                i32 %468 = OpConstant 2 
					                              i32_2 %469 = OpConstantComposite %468 %27 
					                                i32 %535 = OpConstant 3 
					                              i32_2 %536 = OpConstantComposite %535 %27 
					                                i32 %602 = OpConstant 4 
					                              i32_2 %603 = OpConstantComposite %602 %27 
					                                i32 %669 = OpConstant 5 
					                              i32_2 %670 = OpConstantComposite %669 %27 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %30 = OpImageSampleImplicitLod %19 %23 ConstOffset %29 
					                               f32_3 %31 = OpVectorShuffle %30 %30 0 1 2 
					                                             OpStore %9 %31 
					                 read_only Texture2D %33 = OpLoad %12 
					                             sampler %34 = OpLoad %16 
					          read_only Texture2DSampled %35 = OpSampledImage %33 %34 
					                               f32_2 %36 = OpLoad vs_TEXCOORD0 
					                               f32_4 %39 = OpImageSampleImplicitLod %35 %36 ConstOffset %29 
					                               f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
					                                             OpStore %32 %40 
					                 read_only Texture2D %44 = OpLoad %43 
					                             sampler %46 = OpLoad %45 
					          read_only Texture2DSampled %47 = OpSampledImage %44 %46 
					                               f32_2 %48 = OpLoad vs_TEXCOORD0 
					                               f32_4 %49 = OpImageSampleImplicitLod %47 %48 ConstOffset %29 
					                                 f32 %52 = OpCompositeExtract %49 0 
					                                             OpStore %42 %52 
					                        Uniform f32* %58 = OpAccessChain %55 %27 %56 
					                                 f32 %59 = OpLoad %58 
					                                 f32 %60 = OpLoad %42 
					                                 f32 %61 = OpFMul %59 %60 
					                        Uniform f32* %63 = OpAccessChain %55 %27 %62 
					                                 f32 %64 = OpLoad %63 
					                                 f32 %65 = OpFAdd %61 %64 
					                                             OpStore %42 %65 
					                                 f32 %67 = OpLoad %42 
					                                 f32 %68 = OpFDiv %66 %67 
					                                             OpStore %42 %68 
					                 read_only Texture2D %70 = OpLoad %43 
					                             sampler %71 = OpLoad %45 
					          read_only Texture2DSampled %72 = OpSampledImage %70 %71 
					                               f32_2 %73 = OpLoad vs_TEXCOORD0 
					                               f32_4 %74 = OpImageSampleImplicitLod %72 %73 
					                                 f32 %75 = OpCompositeExtract %74 0 
					                                             OpStore %69 %75 
					                        Uniform f32* %76 = OpAccessChain %55 %27 %56 
					                                 f32 %77 = OpLoad %76 
					                                 f32 %78 = OpLoad %69 
					                                 f32 %79 = OpFMul %77 %78 
					                        Uniform f32* %80 = OpAccessChain %55 %27 %62 
					                                 f32 %81 = OpLoad %80 
					                                 f32 %82 = OpFAdd %79 %81 
					                                             OpStore %69 %82 
					                                 f32 %83 = OpLoad %69 
					                                 f32 %84 = OpFDiv %66 %83 
					                                             OpStore %69 %84 
					                                 f32 %85 = OpLoad %42 
					                                 f32 %86 = OpFNegate %85 
					                                 f32 %87 = OpLoad %69 
					                                 f32 %88 = OpFAdd %86 %87 
					                                             OpStore %42 %88 
					                                 f32 %89 = OpLoad %42 
					                                 f32 %90 = OpExtInst %1 4 %89 
					                                 f32 %92 = OpFMul %90 %91 
					                                             OpStore %42 %92 
					                                 f32 %93 = OpLoad %42 
					                                 f32 %94 = OpLoad %42 
					                                 f32 %95 = OpFMul %93 %94 
					                                             OpStore %42 %95 
					                                 f32 %96 = OpLoad %42 
					                                 f32 %98 = OpFMul %96 %97 
					                                             OpStore %42 %98 
					                                 f32 %99 = OpLoad %42 
					                                f32 %100 = OpExtInst %1 29 %99 
					                                             OpStore %42 %100 
					                                f32 %103 = OpLoad %42 
					                                f32 %105 = OpFMul %103 %104 
					                       Private f32* %106 = OpAccessChain %102 %51 
					                                             OpStore %106 %105 
					                                f32 %107 = OpLoad %42 
					                                f32 %108 = OpFMul %107 %104 
					                                f32 %110 = OpFAdd %108 %109 
					                                             OpStore %42 %110 
					                              f32_3 %111 = OpLoad %32 
					                              f32_4 %112 = OpLoad %102 
					                              f32_3 %113 = OpVectorShuffle %112 %112 0 0 0 
					                              f32_3 %114 = OpFMul %111 %113 
					                                             OpStore %32 %114 
					                read_only Texture2D %115 = OpLoad %12 
					                            sampler %116 = OpLoad %16 
					         read_only Texture2DSampled %117 = OpSampledImage %115 %116 
					                              f32_2 %118 = OpLoad vs_TEXCOORD0 
					                              f32_4 %119 = OpImageSampleImplicitLod %117 %118 
					                                             OpStore %102 %119 
					                              f32_4 %120 = OpLoad %102 
					                              f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                              f32_3 %123 = OpFMul %121 %122 
					                              f32_3 %124 = OpLoad %32 
					                              f32_3 %125 = OpFAdd %123 %124 
					                                             OpStore %32 %125 
					                       Private f32* %128 = OpAccessChain %102 %62 
					                                f32 %129 = OpLoad %128 
					                        Output f32* %131 = OpAccessChain %127 %62 
					                                             OpStore %131 %129 
					                read_only Texture2D %132 = OpLoad %43 
					                            sampler %133 = OpLoad %45 
					         read_only Texture2DSampled %134 = OpSampledImage %132 %133 
					                              f32_2 %135 = OpLoad vs_TEXCOORD0 
					                              f32_4 %136 = OpImageSampleImplicitLod %134 %135 ConstOffset %29 
					                                f32 %137 = OpCompositeExtract %136 0 
					                       Private f32* %138 = OpAccessChain %102 %51 
					                                             OpStore %138 %137 
					                       Uniform f32* %139 = OpAccessChain %55 %27 %56 
					                                f32 %140 = OpLoad %139 
					                       Private f32* %141 = OpAccessChain %102 %51 
					                                f32 %142 = OpLoad %141 
					                                f32 %143 = OpFMul %140 %142 
					                       Uniform f32* %144 = OpAccessChain %55 %27 %62 
					                                f32 %145 = OpLoad %144 
					                                f32 %146 = OpFAdd %143 %145 
					                       Private f32* %147 = OpAccessChain %102 %51 
					                                             OpStore %147 %146 
					                       Private f32* %148 = OpAccessChain %102 %51 
					                                f32 %149 = OpLoad %148 
					                                f32 %150 = OpFDiv %66 %149 
					                       Private f32* %151 = OpAccessChain %102 %51 
					                                             OpStore %151 %150 
					                                f32 %152 = OpLoad %69 
					                       Private f32* %153 = OpAccessChain %102 %51 
					                                f32 %154 = OpLoad %153 
					                                f32 %155 = OpFNegate %154 
					                                f32 %156 = OpFAdd %152 %155 
					                       Private f32* %157 = OpAccessChain %102 %51 
					                                             OpStore %157 %156 
					                       Private f32* %158 = OpAccessChain %102 %51 
					                                f32 %159 = OpLoad %158 
					                                f32 %160 = OpExtInst %1 4 %159 
					                                f32 %161 = OpFMul %160 %91 
					                       Private f32* %162 = OpAccessChain %102 %51 
					                                             OpStore %162 %161 
					                       Private f32* %163 = OpAccessChain %102 %51 
					                                f32 %164 = OpLoad %163 
					                       Private f32* %165 = OpAccessChain %102 %51 
					                                f32 %166 = OpLoad %165 
					                                f32 %167 = OpFMul %164 %166 
					                       Private f32* %168 = OpAccessChain %102 %51 
					                                             OpStore %168 %167 
					                       Private f32* %169 = OpAccessChain %102 %51 
					                                f32 %170 = OpLoad %169 
					                                f32 %171 = OpFMul %170 %97 
					                       Private f32* %172 = OpAccessChain %102 %51 
					                                             OpStore %172 %171 
					                       Private f32* %173 = OpAccessChain %102 %51 
					                                f32 %174 = OpLoad %173 
					                                f32 %175 = OpExtInst %1 29 %174 
					                       Private f32* %176 = OpAccessChain %102 %51 
					                                             OpStore %176 %175 
					                       Private f32* %178 = OpAccessChain %102 %51 
					                                f32 %179 = OpLoad %178 
					                                f32 %181 = OpFMul %179 %180 
					                                             OpStore %177 %181 
					                       Private f32* %182 = OpAccessChain %102 %51 
					                                f32 %183 = OpLoad %182 
					                                f32 %184 = OpFMul %183 %180 
					                                f32 %185 = OpLoad %42 
					                                f32 %186 = OpFAdd %184 %185 
					                                             OpStore %42 %186 
					                                f32 %187 = OpLoad %177 
					                              f32_3 %188 = OpCompositeConstruct %187 %187 %187 
					                              f32_3 %189 = OpLoad %9 
					                              f32_3 %190 = OpFMul %188 %189 
					                              f32_3 %191 = OpLoad %32 
					                              f32_3 %192 = OpFAdd %190 %191 
					                                             OpStore %9 %192 
					                read_only Texture2D %193 = OpLoad %12 
					                            sampler %194 = OpLoad %16 
					         read_only Texture2DSampled %195 = OpSampledImage %193 %194 
					                              f32_2 %196 = OpLoad vs_TEXCOORD0 
					                              f32_4 %199 = OpImageSampleImplicitLod %195 %196 ConstOffset %29 
					                              f32_3 %200 = OpVectorShuffle %199 %199 0 1 2 
					                                             OpStore %32 %200 
					                read_only Texture2D %201 = OpLoad %43 
					                            sampler %202 = OpLoad %45 
					         read_only Texture2DSampled %203 = OpSampledImage %201 %202 
					                              f32_2 %204 = OpLoad vs_TEXCOORD0 
					                              f32_4 %205 = OpImageSampleImplicitLod %203 %204 ConstOffset %29 
					                                f32 %206 = OpCompositeExtract %205 0 
					                       Private f32* %207 = OpAccessChain %102 %51 
					                                             OpStore %207 %206 
					                       Uniform f32* %208 = OpAccessChain %55 %27 %56 
					                                f32 %209 = OpLoad %208 
					                       Private f32* %210 = OpAccessChain %102 %51 
					                                f32 %211 = OpLoad %210 
					                                f32 %212 = OpFMul %209 %211 
					                       Uniform f32* %213 = OpAccessChain %55 %27 %62 
					                                f32 %214 = OpLoad %213 
					                                f32 %215 = OpFAdd %212 %214 
					                       Private f32* %216 = OpAccessChain %102 %51 
					                                             OpStore %216 %215 
					                       Private f32* %217 = OpAccessChain %102 %51 
					                                f32 %218 = OpLoad %217 
					                                f32 %219 = OpFDiv %66 %218 
					                       Private f32* %220 = OpAccessChain %102 %51 
					                                             OpStore %220 %219 
					                                f32 %221 = OpLoad %69 
					                       Private f32* %222 = OpAccessChain %102 %51 
					                                f32 %223 = OpLoad %222 
					                                f32 %224 = OpFNegate %223 
					                                f32 %225 = OpFAdd %221 %224 
					                       Private f32* %226 = OpAccessChain %102 %51 
					                                             OpStore %226 %225 
					                       Private f32* %227 = OpAccessChain %102 %51 
					                                f32 %228 = OpLoad %227 
					                                f32 %229 = OpExtInst %1 4 %228 
					                                f32 %230 = OpFMul %229 %91 
					                       Private f32* %231 = OpAccessChain %102 %51 
					                                             OpStore %231 %230 
					                       Private f32* %232 = OpAccessChain %102 %51 
					                                f32 %233 = OpLoad %232 
					                       Private f32* %234 = OpAccessChain %102 %51 
					                                f32 %235 = OpLoad %234 
					                                f32 %236 = OpFMul %233 %235 
					                       Private f32* %237 = OpAccessChain %102 %51 
					                                             OpStore %237 %236 
					                       Private f32* %238 = OpAccessChain %102 %51 
					                                f32 %239 = OpLoad %238 
					                                f32 %240 = OpFMul %239 %97 
					                       Private f32* %241 = OpAccessChain %102 %51 
					                                             OpStore %241 %240 
					                       Private f32* %242 = OpAccessChain %102 %51 
					                                f32 %243 = OpLoad %242 
					                                f32 %244 = OpExtInst %1 29 %243 
					                       Private f32* %245 = OpAccessChain %102 %51 
					                                             OpStore %245 %244 
					                       Private f32* %246 = OpAccessChain %102 %51 
					                                f32 %247 = OpLoad %246 
					                                f32 %249 = OpFMul %247 %248 
					                                             OpStore %177 %249 
					                       Private f32* %250 = OpAccessChain %102 %51 
					                                f32 %251 = OpLoad %250 
					                                f32 %252 = OpFMul %251 %248 
					                                f32 %253 = OpLoad %42 
					                                f32 %254 = OpFAdd %252 %253 
					                                             OpStore %42 %254 
					                                f32 %255 = OpLoad %177 
					                              f32_3 %256 = OpCompositeConstruct %255 %255 %255 
					                              f32_3 %257 = OpLoad %32 
					                              f32_3 %258 = OpFMul %256 %257 
					                              f32_3 %259 = OpLoad %9 
					                              f32_3 %260 = OpFAdd %258 %259 
					                                             OpStore %9 %260 
					                read_only Texture2D %261 = OpLoad %12 
					                            sampler %262 = OpLoad %16 
					         read_only Texture2DSampled %263 = OpSampledImage %261 %262 
					                              f32_2 %264 = OpLoad vs_TEXCOORD0 
					                              f32_4 %267 = OpImageSampleImplicitLod %263 %264 ConstOffset %29 
					                              f32_3 %268 = OpVectorShuffle %267 %267 0 1 2 
					                                             OpStore %32 %268 
					                read_only Texture2D %269 = OpLoad %43 
					                            sampler %270 = OpLoad %45 
					         read_only Texture2DSampled %271 = OpSampledImage %269 %270 
					                              f32_2 %272 = OpLoad vs_TEXCOORD0 
					                              f32_4 %273 = OpImageSampleImplicitLod %271 %272 ConstOffset %29 
					                                f32 %274 = OpCompositeExtract %273 0 
					                       Private f32* %275 = OpAccessChain %102 %51 
					                                             OpStore %275 %274 
					                       Uniform f32* %276 = OpAccessChain %55 %27 %56 
					                                f32 %277 = OpLoad %276 
					                       Private f32* %278 = OpAccessChain %102 %51 
					                                f32 %279 = OpLoad %278 
					                                f32 %280 = OpFMul %277 %279 
					                       Uniform f32* %281 = OpAccessChain %55 %27 %62 
					                                f32 %282 = OpLoad %281 
					                                f32 %283 = OpFAdd %280 %282 
					                       Private f32* %284 = OpAccessChain %102 %51 
					                                             OpStore %284 %283 
					                       Private f32* %285 = OpAccessChain %102 %51 
					                                f32 %286 = OpLoad %285 
					                                f32 %287 = OpFDiv %66 %286 
					                       Private f32* %288 = OpAccessChain %102 %51 
					                                             OpStore %288 %287 
					                                f32 %289 = OpLoad %69 
					                       Private f32* %290 = OpAccessChain %102 %51 
					                                f32 %291 = OpLoad %290 
					                                f32 %292 = OpFNegate %291 
					                                f32 %293 = OpFAdd %289 %292 
					                       Private f32* %294 = OpAccessChain %102 %51 
					                                             OpStore %294 %293 
					                       Private f32* %295 = OpAccessChain %102 %51 
					                                f32 %296 = OpLoad %295 
					                                f32 %297 = OpExtInst %1 4 %296 
					                                f32 %298 = OpFMul %297 %91 
					                       Private f32* %299 = OpAccessChain %102 %51 
					                                             OpStore %299 %298 
					                       Private f32* %300 = OpAccessChain %102 %51 
					                                f32 %301 = OpLoad %300 
					                       Private f32* %302 = OpAccessChain %102 %51 
					                                f32 %303 = OpLoad %302 
					                                f32 %304 = OpFMul %301 %303 
					                       Private f32* %305 = OpAccessChain %102 %51 
					                                             OpStore %305 %304 
					                       Private f32* %306 = OpAccessChain %102 %51 
					                                f32 %307 = OpLoad %306 
					                                f32 %308 = OpFMul %307 %97 
					                       Private f32* %309 = OpAccessChain %102 %51 
					                                             OpStore %309 %308 
					                       Private f32* %310 = OpAccessChain %102 %51 
					                                f32 %311 = OpLoad %310 
					                                f32 %312 = OpExtInst %1 29 %311 
					                       Private f32* %313 = OpAccessChain %102 %51 
					                                             OpStore %313 %312 
					                       Private f32* %314 = OpAccessChain %102 %51 
					                                f32 %315 = OpLoad %314 
					                                f32 %317 = OpFMul %315 %316 
					                                             OpStore %177 %317 
					                       Private f32* %318 = OpAccessChain %102 %51 
					                                f32 %319 = OpLoad %318 
					                                f32 %320 = OpFMul %319 %316 
					                                f32 %321 = OpLoad %42 
					                                f32 %322 = OpFAdd %320 %321 
					                                             OpStore %42 %322 
					                                f32 %323 = OpLoad %177 
					                              f32_3 %324 = OpCompositeConstruct %323 %323 %323 
					                              f32_3 %325 = OpLoad %32 
					                              f32_3 %326 = OpFMul %324 %325 
					                              f32_3 %327 = OpLoad %9 
					                              f32_3 %328 = OpFAdd %326 %327 
					                                             OpStore %9 %328 
					                read_only Texture2D %329 = OpLoad %12 
					                            sampler %330 = OpLoad %16 
					         read_only Texture2DSampled %331 = OpSampledImage %329 %330 
					                              f32_2 %332 = OpLoad vs_TEXCOORD0 
					                              f32_4 %335 = OpImageSampleImplicitLod %331 %332 ConstOffset %29 
					                              f32_3 %336 = OpVectorShuffle %335 %335 0 1 2 
					                                             OpStore %32 %336 
					                read_only Texture2D %337 = OpLoad %43 
					                            sampler %338 = OpLoad %45 
					         read_only Texture2DSampled %339 = OpSampledImage %337 %338 
					                              f32_2 %340 = OpLoad vs_TEXCOORD0 
					                              f32_4 %341 = OpImageSampleImplicitLod %339 %340 ConstOffset %29 
					                                f32 %342 = OpCompositeExtract %341 0 
					                       Private f32* %343 = OpAccessChain %102 %51 
					                                             OpStore %343 %342 
					                       Uniform f32* %344 = OpAccessChain %55 %27 %56 
					                                f32 %345 = OpLoad %344 
					                       Private f32* %346 = OpAccessChain %102 %51 
					                                f32 %347 = OpLoad %346 
					                                f32 %348 = OpFMul %345 %347 
					                       Uniform f32* %349 = OpAccessChain %55 %27 %62 
					                                f32 %350 = OpLoad %349 
					                                f32 %351 = OpFAdd %348 %350 
					                       Private f32* %352 = OpAccessChain %102 %51 
					                                             OpStore %352 %351 
					                       Private f32* %353 = OpAccessChain %102 %51 
					                                f32 %354 = OpLoad %353 
					                                f32 %355 = OpFDiv %66 %354 
					                       Private f32* %356 = OpAccessChain %102 %51 
					                                             OpStore %356 %355 
					                                f32 %357 = OpLoad %69 
					                       Private f32* %358 = OpAccessChain %102 %51 
					                                f32 %359 = OpLoad %358 
					                                f32 %360 = OpFNegate %359 
					                                f32 %361 = OpFAdd %357 %360 
					                       Private f32* %362 = OpAccessChain %102 %51 
					                                             OpStore %362 %361 
					                       Private f32* %363 = OpAccessChain %102 %51 
					                                f32 %364 = OpLoad %363 
					                                f32 %365 = OpExtInst %1 4 %364 
					                                f32 %366 = OpFMul %365 %91 
					                       Private f32* %367 = OpAccessChain %102 %51 
					                                             OpStore %367 %366 
					                       Private f32* %368 = OpAccessChain %102 %51 
					                                f32 %369 = OpLoad %368 
					                       Private f32* %370 = OpAccessChain %102 %51 
					                                f32 %371 = OpLoad %370 
					                                f32 %372 = OpFMul %369 %371 
					                       Private f32* %373 = OpAccessChain %102 %51 
					                                             OpStore %373 %372 
					                       Private f32* %374 = OpAccessChain %102 %51 
					                                f32 %375 = OpLoad %374 
					                                f32 %376 = OpFMul %375 %97 
					                       Private f32* %377 = OpAccessChain %102 %51 
					                                             OpStore %377 %376 
					                       Private f32* %378 = OpAccessChain %102 %51 
					                                f32 %379 = OpLoad %378 
					                                f32 %380 = OpExtInst %1 29 %379 
					                       Private f32* %381 = OpAccessChain %102 %51 
					                                             OpStore %381 %380 
					                       Private f32* %382 = OpAccessChain %102 %51 
					                                f32 %383 = OpLoad %382 
					                                f32 %385 = OpFMul %383 %384 
					                                             OpStore %177 %385 
					                       Private f32* %386 = OpAccessChain %102 %51 
					                                f32 %387 = OpLoad %386 
					                                f32 %388 = OpFMul %387 %384 
					                                f32 %389 = OpLoad %42 
					                                f32 %390 = OpFAdd %388 %389 
					                                             OpStore %42 %390 
					                                f32 %391 = OpLoad %177 
					                              f32_3 %392 = OpCompositeConstruct %391 %391 %391 
					                              f32_3 %393 = OpLoad %32 
					                              f32_3 %394 = OpFMul %392 %393 
					                              f32_3 %395 = OpLoad %9 
					                              f32_3 %396 = OpFAdd %394 %395 
					                                             OpStore %9 %396 
					                read_only Texture2D %397 = OpLoad %12 
					                            sampler %398 = OpLoad %16 
					         read_only Texture2DSampled %399 = OpSampledImage %397 %398 
					                              f32_2 %400 = OpLoad vs_TEXCOORD0 
					                              f32_4 %403 = OpImageSampleImplicitLod %399 %400 ConstOffset %29 
					                              f32_3 %404 = OpVectorShuffle %403 %403 0 1 2 
					                                             OpStore %32 %404 
					                read_only Texture2D %405 = OpLoad %43 
					                            sampler %406 = OpLoad %45 
					         read_only Texture2DSampled %407 = OpSampledImage %405 %406 
					                              f32_2 %408 = OpLoad vs_TEXCOORD0 
					                              f32_4 %409 = OpImageSampleImplicitLod %407 %408 ConstOffset %29 
					                                f32 %410 = OpCompositeExtract %409 0 
					                       Private f32* %411 = OpAccessChain %102 %51 
					                                             OpStore %411 %410 
					                       Uniform f32* %412 = OpAccessChain %55 %27 %56 
					                                f32 %413 = OpLoad %412 
					                       Private f32* %414 = OpAccessChain %102 %51 
					                                f32 %415 = OpLoad %414 
					                                f32 %416 = OpFMul %413 %415 
					                       Uniform f32* %417 = OpAccessChain %55 %27 %62 
					                                f32 %418 = OpLoad %417 
					                                f32 %419 = OpFAdd %416 %418 
					                       Private f32* %420 = OpAccessChain %102 %51 
					                                             OpStore %420 %419 
					                       Private f32* %421 = OpAccessChain %102 %51 
					                                f32 %422 = OpLoad %421 
					                                f32 %423 = OpFDiv %66 %422 
					                       Private f32* %424 = OpAccessChain %102 %51 
					                                             OpStore %424 %423 
					                                f32 %425 = OpLoad %69 
					                       Private f32* %426 = OpAccessChain %102 %51 
					                                f32 %427 = OpLoad %426 
					                                f32 %428 = OpFNegate %427 
					                                f32 %429 = OpFAdd %425 %428 
					                       Private f32* %430 = OpAccessChain %102 %51 
					                                             OpStore %430 %429 
					                       Private f32* %431 = OpAccessChain %102 %51 
					                                f32 %432 = OpLoad %431 
					                                f32 %433 = OpExtInst %1 4 %432 
					                                f32 %434 = OpFMul %433 %91 
					                       Private f32* %435 = OpAccessChain %102 %51 
					                                             OpStore %435 %434 
					                       Private f32* %436 = OpAccessChain %102 %51 
					                                f32 %437 = OpLoad %436 
					                       Private f32* %438 = OpAccessChain %102 %51 
					                                f32 %439 = OpLoad %438 
					                                f32 %440 = OpFMul %437 %439 
					                       Private f32* %441 = OpAccessChain %102 %51 
					                                             OpStore %441 %440 
					                       Private f32* %442 = OpAccessChain %102 %51 
					                                f32 %443 = OpLoad %442 
					                                f32 %444 = OpFMul %443 %97 
					                       Private f32* %445 = OpAccessChain %102 %51 
					                                             OpStore %445 %444 
					                       Private f32* %446 = OpAccessChain %102 %51 
					                                f32 %447 = OpLoad %446 
					                                f32 %448 = OpExtInst %1 29 %447 
					                       Private f32* %449 = OpAccessChain %102 %51 
					                                             OpStore %449 %448 
					                       Private f32* %450 = OpAccessChain %102 %51 
					                                f32 %451 = OpLoad %450 
					                                f32 %452 = OpFMul %451 %384 
					                                             OpStore %177 %452 
					                       Private f32* %453 = OpAccessChain %102 %51 
					                                f32 %454 = OpLoad %453 
					                                f32 %455 = OpFMul %454 %384 
					                                f32 %456 = OpLoad %42 
					                                f32 %457 = OpFAdd %455 %456 
					                                             OpStore %42 %457 
					                                f32 %458 = OpLoad %177 
					                              f32_3 %459 = OpCompositeConstruct %458 %458 %458 
					                              f32_3 %460 = OpLoad %32 
					                              f32_3 %461 = OpFMul %459 %460 
					                              f32_3 %462 = OpLoad %9 
					                              f32_3 %463 = OpFAdd %461 %462 
					                                             OpStore %9 %463 
					                read_only Texture2D %464 = OpLoad %12 
					                            sampler %465 = OpLoad %16 
					         read_only Texture2DSampled %466 = OpSampledImage %464 %465 
					                              f32_2 %467 = OpLoad vs_TEXCOORD0 
					                              f32_4 %470 = OpImageSampleImplicitLod %466 %467 ConstOffset %29 
					                              f32_3 %471 = OpVectorShuffle %470 %470 0 1 2 
					                                             OpStore %32 %471 
					                read_only Texture2D %472 = OpLoad %43 
					                            sampler %473 = OpLoad %45 
					         read_only Texture2DSampled %474 = OpSampledImage %472 %473 
					                              f32_2 %475 = OpLoad vs_TEXCOORD0 
					                              f32_4 %476 = OpImageSampleImplicitLod %474 %475 ConstOffset %29 
					                                f32 %477 = OpCompositeExtract %476 0 
					                       Private f32* %478 = OpAccessChain %102 %51 
					                                             OpStore %478 %477 
					                       Uniform f32* %479 = OpAccessChain %55 %27 %56 
					                                f32 %480 = OpLoad %479 
					                       Private f32* %481 = OpAccessChain %102 %51 
					                                f32 %482 = OpLoad %481 
					                                f32 %483 = OpFMul %480 %482 
					                       Uniform f32* %484 = OpAccessChain %55 %27 %62 
					                                f32 %485 = OpLoad %484 
					                                f32 %486 = OpFAdd %483 %485 
					                       Private f32* %487 = OpAccessChain %102 %51 
					                                             OpStore %487 %486 
					                       Private f32* %488 = OpAccessChain %102 %51 
					                                f32 %489 = OpLoad %488 
					                                f32 %490 = OpFDiv %66 %489 
					                       Private f32* %491 = OpAccessChain %102 %51 
					                                             OpStore %491 %490 
					                                f32 %492 = OpLoad %69 
					                       Private f32* %493 = OpAccessChain %102 %51 
					                                f32 %494 = OpLoad %493 
					                                f32 %495 = OpFNegate %494 
					                                f32 %496 = OpFAdd %492 %495 
					                       Private f32* %497 = OpAccessChain %102 %51 
					                                             OpStore %497 %496 
					                       Private f32* %498 = OpAccessChain %102 %51 
					                                f32 %499 = OpLoad %498 
					                                f32 %500 = OpExtInst %1 4 %499 
					                                f32 %501 = OpFMul %500 %91 
					                       Private f32* %502 = OpAccessChain %102 %51 
					                                             OpStore %502 %501 
					                       Private f32* %503 = OpAccessChain %102 %51 
					                                f32 %504 = OpLoad %503 
					                       Private f32* %505 = OpAccessChain %102 %51 
					                                f32 %506 = OpLoad %505 
					                                f32 %507 = OpFMul %504 %506 
					                       Private f32* %508 = OpAccessChain %102 %51 
					                                             OpStore %508 %507 
					                       Private f32* %509 = OpAccessChain %102 %51 
					                                f32 %510 = OpLoad %509 
					                                f32 %511 = OpFMul %510 %97 
					                       Private f32* %512 = OpAccessChain %102 %51 
					                                             OpStore %512 %511 
					                       Private f32* %513 = OpAccessChain %102 %51 
					                                f32 %514 = OpLoad %513 
					                                f32 %515 = OpExtInst %1 29 %514 
					                       Private f32* %516 = OpAccessChain %102 %51 
					                                             OpStore %516 %515 
					                       Private f32* %517 = OpAccessChain %102 %51 
					                                f32 %518 = OpLoad %517 
					                                f32 %519 = OpFMul %518 %316 
					                                             OpStore %177 %519 
					                       Private f32* %520 = OpAccessChain %102 %51 
					                                f32 %521 = OpLoad %520 
					                                f32 %522 = OpFMul %521 %316 
					                                f32 %523 = OpLoad %42 
					                                f32 %524 = OpFAdd %522 %523 
					                                             OpStore %42 %524 
					                                f32 %525 = OpLoad %177 
					                              f32_3 %526 = OpCompositeConstruct %525 %525 %525 
					                              f32_3 %527 = OpLoad %32 
					                              f32_3 %528 = OpFMul %526 %527 
					                              f32_3 %529 = OpLoad %9 
					                              f32_3 %530 = OpFAdd %528 %529 
					                                             OpStore %9 %530 
					                read_only Texture2D %531 = OpLoad %12 
					                            sampler %532 = OpLoad %16 
					         read_only Texture2DSampled %533 = OpSampledImage %531 %532 
					                              f32_2 %534 = OpLoad vs_TEXCOORD0 
					                              f32_4 %537 = OpImageSampleImplicitLod %533 %534 ConstOffset %29 
					                              f32_3 %538 = OpVectorShuffle %537 %537 0 1 2 
					                                             OpStore %32 %538 
					                read_only Texture2D %539 = OpLoad %43 
					                            sampler %540 = OpLoad %45 
					         read_only Texture2DSampled %541 = OpSampledImage %539 %540 
					                              f32_2 %542 = OpLoad vs_TEXCOORD0 
					                              f32_4 %543 = OpImageSampleImplicitLod %541 %542 ConstOffset %29 
					                                f32 %544 = OpCompositeExtract %543 0 
					                       Private f32* %545 = OpAccessChain %102 %51 
					                                             OpStore %545 %544 
					                       Uniform f32* %546 = OpAccessChain %55 %27 %56 
					                                f32 %547 = OpLoad %546 
					                       Private f32* %548 = OpAccessChain %102 %51 
					                                f32 %549 = OpLoad %548 
					                                f32 %550 = OpFMul %547 %549 
					                       Uniform f32* %551 = OpAccessChain %55 %27 %62 
					                                f32 %552 = OpLoad %551 
					                                f32 %553 = OpFAdd %550 %552 
					                       Private f32* %554 = OpAccessChain %102 %51 
					                                             OpStore %554 %553 
					                       Private f32* %555 = OpAccessChain %102 %51 
					                                f32 %556 = OpLoad %555 
					                                f32 %557 = OpFDiv %66 %556 
					                       Private f32* %558 = OpAccessChain %102 %51 
					                                             OpStore %558 %557 
					                                f32 %559 = OpLoad %69 
					                       Private f32* %560 = OpAccessChain %102 %51 
					                                f32 %561 = OpLoad %560 
					                                f32 %562 = OpFNegate %561 
					                                f32 %563 = OpFAdd %559 %562 
					                       Private f32* %564 = OpAccessChain %102 %51 
					                                             OpStore %564 %563 
					                       Private f32* %565 = OpAccessChain %102 %51 
					                                f32 %566 = OpLoad %565 
					                                f32 %567 = OpExtInst %1 4 %566 
					                                f32 %568 = OpFMul %567 %91 
					                       Private f32* %569 = OpAccessChain %102 %51 
					                                             OpStore %569 %568 
					                       Private f32* %570 = OpAccessChain %102 %51 
					                                f32 %571 = OpLoad %570 
					                       Private f32* %572 = OpAccessChain %102 %51 
					                                f32 %573 = OpLoad %572 
					                                f32 %574 = OpFMul %571 %573 
					                       Private f32* %575 = OpAccessChain %102 %51 
					                                             OpStore %575 %574 
					                       Private f32* %576 = OpAccessChain %102 %51 
					                                f32 %577 = OpLoad %576 
					                                f32 %578 = OpFMul %577 %97 
					                       Private f32* %579 = OpAccessChain %102 %51 
					                                             OpStore %579 %578 
					                       Private f32* %580 = OpAccessChain %102 %51 
					                                f32 %581 = OpLoad %580 
					                                f32 %582 = OpExtInst %1 29 %581 
					                       Private f32* %583 = OpAccessChain %102 %51 
					                                             OpStore %583 %582 
					                       Private f32* %584 = OpAccessChain %102 %51 
					                                f32 %585 = OpLoad %584 
					                                f32 %586 = OpFMul %585 %248 
					                                             OpStore %177 %586 
					                       Private f32* %587 = OpAccessChain %102 %51 
					                                f32 %588 = OpLoad %587 
					                                f32 %589 = OpFMul %588 %248 
					                                f32 %590 = OpLoad %42 
					                                f32 %591 = OpFAdd %589 %590 
					                                             OpStore %42 %591 
					                                f32 %592 = OpLoad %177 
					                              f32_3 %593 = OpCompositeConstruct %592 %592 %592 
					                              f32_3 %594 = OpLoad %32 
					                              f32_3 %595 = OpFMul %593 %594 
					                              f32_3 %596 = OpLoad %9 
					                              f32_3 %597 = OpFAdd %595 %596 
					                                             OpStore %9 %597 
					                read_only Texture2D %598 = OpLoad %12 
					                            sampler %599 = OpLoad %16 
					         read_only Texture2DSampled %600 = OpSampledImage %598 %599 
					                              f32_2 %601 = OpLoad vs_TEXCOORD0 
					                              f32_4 %604 = OpImageSampleImplicitLod %600 %601 ConstOffset %29 
					                              f32_3 %605 = OpVectorShuffle %604 %604 0 1 2 
					                                             OpStore %32 %605 
					                read_only Texture2D %606 = OpLoad %43 
					                            sampler %607 = OpLoad %45 
					         read_only Texture2DSampled %608 = OpSampledImage %606 %607 
					                              f32_2 %609 = OpLoad vs_TEXCOORD0 
					                              f32_4 %610 = OpImageSampleImplicitLod %608 %609 ConstOffset %29 
					                                f32 %611 = OpCompositeExtract %610 0 
					                       Private f32* %612 = OpAccessChain %102 %51 
					                                             OpStore %612 %611 
					                       Uniform f32* %613 = OpAccessChain %55 %27 %56 
					                                f32 %614 = OpLoad %613 
					                       Private f32* %615 = OpAccessChain %102 %51 
					                                f32 %616 = OpLoad %615 
					                                f32 %617 = OpFMul %614 %616 
					                       Uniform f32* %618 = OpAccessChain %55 %27 %62 
					                                f32 %619 = OpLoad %618 
					                                f32 %620 = OpFAdd %617 %619 
					                       Private f32* %621 = OpAccessChain %102 %51 
					                                             OpStore %621 %620 
					                       Private f32* %622 = OpAccessChain %102 %51 
					                                f32 %623 = OpLoad %622 
					                                f32 %624 = OpFDiv %66 %623 
					                       Private f32* %625 = OpAccessChain %102 %51 
					                                             OpStore %625 %624 
					                                f32 %626 = OpLoad %69 
					                       Private f32* %627 = OpAccessChain %102 %51 
					                                f32 %628 = OpLoad %627 
					                                f32 %629 = OpFNegate %628 
					                                f32 %630 = OpFAdd %626 %629 
					                       Private f32* %631 = OpAccessChain %102 %51 
					                                             OpStore %631 %630 
					                       Private f32* %632 = OpAccessChain %102 %51 
					                                f32 %633 = OpLoad %632 
					                                f32 %634 = OpExtInst %1 4 %633 
					                                f32 %635 = OpFMul %634 %91 
					                       Private f32* %636 = OpAccessChain %102 %51 
					                                             OpStore %636 %635 
					                       Private f32* %637 = OpAccessChain %102 %51 
					                                f32 %638 = OpLoad %637 
					                       Private f32* %639 = OpAccessChain %102 %51 
					                                f32 %640 = OpLoad %639 
					                                f32 %641 = OpFMul %638 %640 
					                       Private f32* %642 = OpAccessChain %102 %51 
					                                             OpStore %642 %641 
					                       Private f32* %643 = OpAccessChain %102 %51 
					                                f32 %644 = OpLoad %643 
					                                f32 %645 = OpFMul %644 %97 
					                       Private f32* %646 = OpAccessChain %102 %51 
					                                             OpStore %646 %645 
					                       Private f32* %647 = OpAccessChain %102 %51 
					                                f32 %648 = OpLoad %647 
					                                f32 %649 = OpExtInst %1 29 %648 
					                       Private f32* %650 = OpAccessChain %102 %51 
					                                             OpStore %650 %649 
					                       Private f32* %651 = OpAccessChain %102 %51 
					                                f32 %652 = OpLoad %651 
					                                f32 %653 = OpFMul %652 %180 
					                                             OpStore %177 %653 
					                       Private f32* %654 = OpAccessChain %102 %51 
					                                f32 %655 = OpLoad %654 
					                                f32 %656 = OpFMul %655 %180 
					                                f32 %657 = OpLoad %42 
					                                f32 %658 = OpFAdd %656 %657 
					                                             OpStore %42 %658 
					                                f32 %659 = OpLoad %177 
					                              f32_3 %660 = OpCompositeConstruct %659 %659 %659 
					                              f32_3 %661 = OpLoad %32 
					                              f32_3 %662 = OpFMul %660 %661 
					                              f32_3 %663 = OpLoad %9 
					                              f32_3 %664 = OpFAdd %662 %663 
					                                             OpStore %9 %664 
					                read_only Texture2D %665 = OpLoad %12 
					                            sampler %666 = OpLoad %16 
					         read_only Texture2DSampled %667 = OpSampledImage %665 %666 
					                              f32_2 %668 = OpLoad vs_TEXCOORD0 
					                              f32_4 %671 = OpImageSampleImplicitLod %667 %668 ConstOffset %29 
					                              f32_3 %672 = OpVectorShuffle %671 %671 0 1 2 
					                                             OpStore %32 %672 
					                read_only Texture2D %673 = OpLoad %43 
					                            sampler %674 = OpLoad %45 
					         read_only Texture2DSampled %675 = OpSampledImage %673 %674 
					                              f32_2 %676 = OpLoad vs_TEXCOORD0 
					                              f32_4 %677 = OpImageSampleImplicitLod %675 %676 ConstOffset %29 
					                                f32 %678 = OpCompositeExtract %677 0 
					                       Private f32* %679 = OpAccessChain %102 %51 
					                                             OpStore %679 %678 
					                       Uniform f32* %680 = OpAccessChain %55 %27 %56 
					                                f32 %681 = OpLoad %680 
					                       Private f32* %682 = OpAccessChain %102 %51 
					                                f32 %683 = OpLoad %682 
					                                f32 %684 = OpFMul %681 %683 
					                       Uniform f32* %685 = OpAccessChain %55 %27 %62 
					                                f32 %686 = OpLoad %685 
					                                f32 %687 = OpFAdd %684 %686 
					                       Private f32* %688 = OpAccessChain %102 %51 
					                                             OpStore %688 %687 
					                       Private f32* %689 = OpAccessChain %102 %51 
					                                f32 %690 = OpLoad %689 
					                                f32 %691 = OpFDiv %66 %690 
					                       Private f32* %692 = OpAccessChain %102 %51 
					                                             OpStore %692 %691 
					                                f32 %693 = OpLoad %69 
					                       Private f32* %694 = OpAccessChain %102 %51 
					                                f32 %695 = OpLoad %694 
					                                f32 %696 = OpFNegate %695 
					                                f32 %697 = OpFAdd %693 %696 
					                                             OpStore %69 %697 
					                                f32 %698 = OpLoad %69 
					                                f32 %699 = OpExtInst %1 4 %698 
					                                f32 %700 = OpFMul %699 %91 
					                                             OpStore %69 %700 
					                                f32 %701 = OpLoad %69 
					                                f32 %702 = OpLoad %69 
					                                f32 %703 = OpFMul %701 %702 
					                                             OpStore %69 %703 
					                                f32 %704 = OpLoad %69 
					                                f32 %705 = OpFMul %704 %97 
					                                             OpStore %69 %705 
					                                f32 %706 = OpLoad %69 
					                                f32 %707 = OpExtInst %1 29 %706 
					                                             OpStore %69 %707 
					                                f32 %708 = OpLoad %69 
					                                f32 %709 = OpFMul %708 %104 
					                       Private f32* %710 = OpAccessChain %102 %51 
					                                             OpStore %710 %709 
					                                f32 %711 = OpLoad %69 
					                                f32 %712 = OpFMul %711 %104 
					                                f32 %713 = OpLoad %42 
					                                f32 %714 = OpFAdd %712 %713 
					                                             OpStore %42 %714 
					                              f32_4 %715 = OpLoad %102 
					                              f32_3 %716 = OpVectorShuffle %715 %715 0 0 0 
					                              f32_3 %717 = OpLoad %32 
					                              f32_3 %718 = OpFMul %716 %717 
					                              f32_3 %719 = OpLoad %9 
					                              f32_3 %720 = OpFAdd %718 %719 
					                                             OpStore %9 %720 
					                              f32_3 %721 = OpLoad %9 
					                                f32 %722 = OpLoad %42 
					                              f32_3 %723 = OpCompositeConstruct %722 %722 %722 
					                              f32_3 %724 = OpFDiv %721 %723 
					                              f32_4 %725 = OpLoad %127 
					                              f32_4 %726 = OpVectorShuffle %725 %724 4 5 6 3 
					                                             OpStore %127 %726 
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[7];
						vec4 _ZBufferParams;
						vec4 unused_0_2;
					};
					uniform  sampler2D _HalfResDepthBuffer;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat5;
					float u_xlat6;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-4, 0));
					    u_xlat1 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-5, 0));
					    u_xlat2 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-5, 0));
					    u_xlat12 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat2 = texture(_HalfResDepthBuffer, vs_TEXCOORD0.xy);
					    u_xlat13 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat12 = (-u_xlat12) + u_xlat13;
					    u_xlat12 = abs(u_xlat12) * 0.5;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat12 = u_xlat12 * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat2.x = u_xlat12 * 0.0388552807;
					    u_xlat12 = u_xlat12 * 0.0388552807 + 0.119682692;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat2.xyz * vec3(0.119682692, 0.119682692, 0.119682692) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat2 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-4, 0));
					    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.x = u_xlat13 + (-u_xlat2.x);
					    u_xlat2.x = abs(u_xlat2.x) * 0.5;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * -1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat6 = u_xlat2.x * 0.058255814;
					    u_xlat12 = u_xlat2.x * 0.058255814 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-3, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-3, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0798255801;
					    u_xlat12 = u_xlat1.x * 0.0798255801 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-2, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-2, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0999673903;
					    u_xlat12 = u_xlat1.x * 0.0999673903 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-1, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-1, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.114416353;
					    u_xlat12 = u_xlat1.x * 0.114416353 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(1, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(1, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.114416353;
					    u_xlat12 = u_xlat1.x * 0.114416353 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(2, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(2, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0999673903;
					    u_xlat12 = u_xlat1.x * 0.0999673903 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(3, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(3, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0798255801;
					    u_xlat12 = u_xlat1.x * 0.0798255801 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(4, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(4, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.058255814;
					    u_xlat12 = u_xlat1.x * 0.058255814 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(5, 0));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(5, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0388552807;
					    u_xlat12 = u_xlat1.x * 0.0388552807 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz / vec3(u_xlat12);
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
			GpuProgramID 236712
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
					UNITY_LOCATION(0) uniform  sampler2D _HalfResDepthBuffer;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat5;
					float u_xlat6;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -4));
					    u_xlat1 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -5));
					    u_xlat2 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -5));
					    u_xlat12 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat2 = texture(_HalfResDepthBuffer, vs_TEXCOORD0.xy);
					    u_xlat13 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat12 = (-u_xlat12) + u_xlat13;
					    u_xlat12 = abs(u_xlat12) * 0.5;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat12 = u_xlat12 * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat2.x = u_xlat12 * 0.0388552807;
					    u_xlat12 = u_xlat12 * 0.0388552807 + 0.119682692;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat2.xyz * vec3(0.119682692, 0.119682692, 0.119682692) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat2 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -4));
					    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.x = u_xlat13 + (-u_xlat2.x);
					    u_xlat2.x = abs(u_xlat2.x) * 0.5;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * -1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat6 = u_xlat2.x * 0.058255814;
					    u_xlat12 = u_xlat2.x * 0.058255814 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -3));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -3));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0798255801;
					    u_xlat12 = u_xlat1.x * 0.0798255801 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -2));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -2));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0999673903;
					    u_xlat12 = u_xlat1.x * 0.0999673903 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -1));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -1));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.114416353;
					    u_xlat12 = u_xlat1.x * 0.114416353 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 1));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 1));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.114416353;
					    u_xlat12 = u_xlat1.x * 0.114416353 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 2));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 2));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0999673903;
					    u_xlat12 = u_xlat1.x * 0.0999673903 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 3));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 3));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0798255801;
					    u_xlat12 = u_xlat1.x * 0.0798255801 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 4));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 4));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.058255814;
					    u_xlat12 = u_xlat1.x * 0.058255814 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 5));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 5));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0388552807;
					    u_xlat12 = u_xlat1.x * 0.0388552807 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz / vec3(u_xlat12);
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
					; Bound: 728
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %127 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %43 DescriptorSet 43 
					                                             OpDecorate %43 Binding 43 
					                                             OpDecorate %45 DescriptorSet 45 
					                                             OpDecorate %45 Binding 45 
					                                             OpMemberDecorate %53 0 Offset 53 
					                                             OpDecorate %53 Block 
					                                             OpDecorate %55 DescriptorSet 55 
					                                             OpDecorate %55 Binding 55 
					                                             OpDecorate %127 Location 127 
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
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %24 = OpTypeInt 32 1 
					                                     %25 = OpTypeVector %24 2 
					                                 i32 %26 = OpConstant 0 
					                                 i32 %27 = OpConstant -4 
					                               i32_2 %28 = OpConstantComposite %26 %27 
					                                     %29 = OpTypeVector %6 4 
					                      Private f32_3* %32 = OpVariable Private 
					                                 i32 %37 = OpConstant -5 
					                               i32_2 %38 = OpConstantComposite %26 %37 
					                                     %41 = OpTypePointer Private %6 
					                        Private f32* %42 = OpVariable Private 
					UniformConstant read_only Texture2D* %43 = OpVariable UniformConstant 
					            UniformConstant sampler* %45 = OpVariable UniformConstant 
					                                     %50 = OpTypeInt 32 0 
					                                 u32 %51 = OpConstant 0 
					                                     %53 = OpTypeStruct %29 
					                                     %54 = OpTypePointer Uniform %53 
					            Uniform struct {f32_4;}* %55 = OpVariable Uniform 
					                                 u32 %56 = OpConstant 2 
					                                     %57 = OpTypePointer Uniform %6 
					                                 u32 %62 = OpConstant 3 
					                                 f32 %66 = OpConstant 3,674022E-40 
					                        Private f32* %69 = OpVariable Private 
					                                 f32 %91 = OpConstant 3,674022E-40 
					                                 f32 %97 = OpConstant 3,674022E-40 
					                                    %101 = OpTypePointer Private %29 
					                     Private f32_4* %102 = OpVariable Private 
					                                f32 %104 = OpConstant 3,674022E-40 
					                                f32 %109 = OpConstant 3,674022E-40 
					                              f32_3 %122 = OpConstantComposite %109 %109 %109 
					                                    %126 = OpTypePointer Output %29 
					                      Output f32_4* %127 = OpVariable Output 
					                                    %130 = OpTypePointer Output %6 
					                       Private f32* %177 = OpVariable Private 
					                                f32 %180 = OpConstant 3,674022E-40 
					                                i32 %197 = OpConstant -3 
					                              i32_2 %198 = OpConstantComposite %26 %197 
					                                f32 %248 = OpConstant 3,674022E-40 
					                                i32 %265 = OpConstant -2 
					                              i32_2 %266 = OpConstantComposite %26 %265 
					                                f32 %316 = OpConstant 3,674022E-40 
					                                i32 %333 = OpConstant -1 
					                              i32_2 %334 = OpConstantComposite %26 %333 
					                                f32 %384 = OpConstant 3,674022E-40 
					                                i32 %401 = OpConstant 1 
					                              i32_2 %402 = OpConstantComposite %26 %401 
					                                i32 %468 = OpConstant 2 
					                              i32_2 %469 = OpConstantComposite %26 %468 
					                                i32 %535 = OpConstant 3 
					                              i32_2 %536 = OpConstantComposite %26 %535 
					                                i32 %602 = OpConstant 4 
					                              i32_2 %603 = OpConstantComposite %26 %602 
					                                i32 %669 = OpConstant 5 
					                              i32_2 %670 = OpConstantComposite %26 %669 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %30 = OpImageSampleImplicitLod %19 %23 ConstOffset %29 
					                               f32_3 %31 = OpVectorShuffle %30 %30 0 1 2 
					                                             OpStore %9 %31 
					                 read_only Texture2D %33 = OpLoad %12 
					                             sampler %34 = OpLoad %16 
					          read_only Texture2DSampled %35 = OpSampledImage %33 %34 
					                               f32_2 %36 = OpLoad vs_TEXCOORD0 
					                               f32_4 %39 = OpImageSampleImplicitLod %35 %36 ConstOffset %29 
					                               f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
					                                             OpStore %32 %40 
					                 read_only Texture2D %44 = OpLoad %43 
					                             sampler %46 = OpLoad %45 
					          read_only Texture2DSampled %47 = OpSampledImage %44 %46 
					                               f32_2 %48 = OpLoad vs_TEXCOORD0 
					                               f32_4 %49 = OpImageSampleImplicitLod %47 %48 ConstOffset %29 
					                                 f32 %52 = OpCompositeExtract %49 0 
					                                             OpStore %42 %52 
					                        Uniform f32* %58 = OpAccessChain %55 %26 %56 
					                                 f32 %59 = OpLoad %58 
					                                 f32 %60 = OpLoad %42 
					                                 f32 %61 = OpFMul %59 %60 
					                        Uniform f32* %63 = OpAccessChain %55 %26 %62 
					                                 f32 %64 = OpLoad %63 
					                                 f32 %65 = OpFAdd %61 %64 
					                                             OpStore %42 %65 
					                                 f32 %67 = OpLoad %42 
					                                 f32 %68 = OpFDiv %66 %67 
					                                             OpStore %42 %68 
					                 read_only Texture2D %70 = OpLoad %43 
					                             sampler %71 = OpLoad %45 
					          read_only Texture2DSampled %72 = OpSampledImage %70 %71 
					                               f32_2 %73 = OpLoad vs_TEXCOORD0 
					                               f32_4 %74 = OpImageSampleImplicitLod %72 %73 
					                                 f32 %75 = OpCompositeExtract %74 0 
					                                             OpStore %69 %75 
					                        Uniform f32* %76 = OpAccessChain %55 %26 %56 
					                                 f32 %77 = OpLoad %76 
					                                 f32 %78 = OpLoad %69 
					                                 f32 %79 = OpFMul %77 %78 
					                        Uniform f32* %80 = OpAccessChain %55 %26 %62 
					                                 f32 %81 = OpLoad %80 
					                                 f32 %82 = OpFAdd %79 %81 
					                                             OpStore %69 %82 
					                                 f32 %83 = OpLoad %69 
					                                 f32 %84 = OpFDiv %66 %83 
					                                             OpStore %69 %84 
					                                 f32 %85 = OpLoad %42 
					                                 f32 %86 = OpFNegate %85 
					                                 f32 %87 = OpLoad %69 
					                                 f32 %88 = OpFAdd %86 %87 
					                                             OpStore %42 %88 
					                                 f32 %89 = OpLoad %42 
					                                 f32 %90 = OpExtInst %1 4 %89 
					                                 f32 %92 = OpFMul %90 %91 
					                                             OpStore %42 %92 
					                                 f32 %93 = OpLoad %42 
					                                 f32 %94 = OpLoad %42 
					                                 f32 %95 = OpFMul %93 %94 
					                                             OpStore %42 %95 
					                                 f32 %96 = OpLoad %42 
					                                 f32 %98 = OpFMul %96 %97 
					                                             OpStore %42 %98 
					                                 f32 %99 = OpLoad %42 
					                                f32 %100 = OpExtInst %1 29 %99 
					                                             OpStore %42 %100 
					                                f32 %103 = OpLoad %42 
					                                f32 %105 = OpFMul %103 %104 
					                       Private f32* %106 = OpAccessChain %102 %51 
					                                             OpStore %106 %105 
					                                f32 %107 = OpLoad %42 
					                                f32 %108 = OpFMul %107 %104 
					                                f32 %110 = OpFAdd %108 %109 
					                                             OpStore %42 %110 
					                              f32_3 %111 = OpLoad %32 
					                              f32_4 %112 = OpLoad %102 
					                              f32_3 %113 = OpVectorShuffle %112 %112 0 0 0 
					                              f32_3 %114 = OpFMul %111 %113 
					                                             OpStore %32 %114 
					                read_only Texture2D %115 = OpLoad %12 
					                            sampler %116 = OpLoad %16 
					         read_only Texture2DSampled %117 = OpSampledImage %115 %116 
					                              f32_2 %118 = OpLoad vs_TEXCOORD0 
					                              f32_4 %119 = OpImageSampleImplicitLod %117 %118 
					                                             OpStore %102 %119 
					                              f32_4 %120 = OpLoad %102 
					                              f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                              f32_3 %123 = OpFMul %121 %122 
					                              f32_3 %124 = OpLoad %32 
					                              f32_3 %125 = OpFAdd %123 %124 
					                                             OpStore %32 %125 
					                       Private f32* %128 = OpAccessChain %102 %62 
					                                f32 %129 = OpLoad %128 
					                        Output f32* %131 = OpAccessChain %127 %62 
					                                             OpStore %131 %129 
					                read_only Texture2D %132 = OpLoad %43 
					                            sampler %133 = OpLoad %45 
					         read_only Texture2DSampled %134 = OpSampledImage %132 %133 
					                              f32_2 %135 = OpLoad vs_TEXCOORD0 
					                              f32_4 %136 = OpImageSampleImplicitLod %134 %135 ConstOffset %29 
					                                f32 %137 = OpCompositeExtract %136 0 
					                       Private f32* %138 = OpAccessChain %102 %51 
					                                             OpStore %138 %137 
					                       Uniform f32* %139 = OpAccessChain %55 %26 %56 
					                                f32 %140 = OpLoad %139 
					                       Private f32* %141 = OpAccessChain %102 %51 
					                                f32 %142 = OpLoad %141 
					                                f32 %143 = OpFMul %140 %142 
					                       Uniform f32* %144 = OpAccessChain %55 %26 %62 
					                                f32 %145 = OpLoad %144 
					                                f32 %146 = OpFAdd %143 %145 
					                       Private f32* %147 = OpAccessChain %102 %51 
					                                             OpStore %147 %146 
					                       Private f32* %148 = OpAccessChain %102 %51 
					                                f32 %149 = OpLoad %148 
					                                f32 %150 = OpFDiv %66 %149 
					                       Private f32* %151 = OpAccessChain %102 %51 
					                                             OpStore %151 %150 
					                                f32 %152 = OpLoad %69 
					                       Private f32* %153 = OpAccessChain %102 %51 
					                                f32 %154 = OpLoad %153 
					                                f32 %155 = OpFNegate %154 
					                                f32 %156 = OpFAdd %152 %155 
					                       Private f32* %157 = OpAccessChain %102 %51 
					                                             OpStore %157 %156 
					                       Private f32* %158 = OpAccessChain %102 %51 
					                                f32 %159 = OpLoad %158 
					                                f32 %160 = OpExtInst %1 4 %159 
					                                f32 %161 = OpFMul %160 %91 
					                       Private f32* %162 = OpAccessChain %102 %51 
					                                             OpStore %162 %161 
					                       Private f32* %163 = OpAccessChain %102 %51 
					                                f32 %164 = OpLoad %163 
					                       Private f32* %165 = OpAccessChain %102 %51 
					                                f32 %166 = OpLoad %165 
					                                f32 %167 = OpFMul %164 %166 
					                       Private f32* %168 = OpAccessChain %102 %51 
					                                             OpStore %168 %167 
					                       Private f32* %169 = OpAccessChain %102 %51 
					                                f32 %170 = OpLoad %169 
					                                f32 %171 = OpFMul %170 %97 
					                       Private f32* %172 = OpAccessChain %102 %51 
					                                             OpStore %172 %171 
					                       Private f32* %173 = OpAccessChain %102 %51 
					                                f32 %174 = OpLoad %173 
					                                f32 %175 = OpExtInst %1 29 %174 
					                       Private f32* %176 = OpAccessChain %102 %51 
					                                             OpStore %176 %175 
					                       Private f32* %178 = OpAccessChain %102 %51 
					                                f32 %179 = OpLoad %178 
					                                f32 %181 = OpFMul %179 %180 
					                                             OpStore %177 %181 
					                       Private f32* %182 = OpAccessChain %102 %51 
					                                f32 %183 = OpLoad %182 
					                                f32 %184 = OpFMul %183 %180 
					                                f32 %185 = OpLoad %42 
					                                f32 %186 = OpFAdd %184 %185 
					                                             OpStore %42 %186 
					                                f32 %187 = OpLoad %177 
					                              f32_3 %188 = OpCompositeConstruct %187 %187 %187 
					                              f32_3 %189 = OpLoad %9 
					                              f32_3 %190 = OpFMul %188 %189 
					                              f32_3 %191 = OpLoad %32 
					                              f32_3 %192 = OpFAdd %190 %191 
					                                             OpStore %9 %192 
					                read_only Texture2D %193 = OpLoad %12 
					                            sampler %194 = OpLoad %16 
					         read_only Texture2DSampled %195 = OpSampledImage %193 %194 
					                              f32_2 %196 = OpLoad vs_TEXCOORD0 
					                              f32_4 %199 = OpImageSampleImplicitLod %195 %196 ConstOffset %29 
					                              f32_3 %200 = OpVectorShuffle %199 %199 0 1 2 
					                                             OpStore %32 %200 
					                read_only Texture2D %201 = OpLoad %43 
					                            sampler %202 = OpLoad %45 
					         read_only Texture2DSampled %203 = OpSampledImage %201 %202 
					                              f32_2 %204 = OpLoad vs_TEXCOORD0 
					                              f32_4 %205 = OpImageSampleImplicitLod %203 %204 ConstOffset %29 
					                                f32 %206 = OpCompositeExtract %205 0 
					                       Private f32* %207 = OpAccessChain %102 %51 
					                                             OpStore %207 %206 
					                       Uniform f32* %208 = OpAccessChain %55 %26 %56 
					                                f32 %209 = OpLoad %208 
					                       Private f32* %210 = OpAccessChain %102 %51 
					                                f32 %211 = OpLoad %210 
					                                f32 %212 = OpFMul %209 %211 
					                       Uniform f32* %213 = OpAccessChain %55 %26 %62 
					                                f32 %214 = OpLoad %213 
					                                f32 %215 = OpFAdd %212 %214 
					                       Private f32* %216 = OpAccessChain %102 %51 
					                                             OpStore %216 %215 
					                       Private f32* %217 = OpAccessChain %102 %51 
					                                f32 %218 = OpLoad %217 
					                                f32 %219 = OpFDiv %66 %218 
					                       Private f32* %220 = OpAccessChain %102 %51 
					                                             OpStore %220 %219 
					                                f32 %221 = OpLoad %69 
					                       Private f32* %222 = OpAccessChain %102 %51 
					                                f32 %223 = OpLoad %222 
					                                f32 %224 = OpFNegate %223 
					                                f32 %225 = OpFAdd %221 %224 
					                       Private f32* %226 = OpAccessChain %102 %51 
					                                             OpStore %226 %225 
					                       Private f32* %227 = OpAccessChain %102 %51 
					                                f32 %228 = OpLoad %227 
					                                f32 %229 = OpExtInst %1 4 %228 
					                                f32 %230 = OpFMul %229 %91 
					                       Private f32* %231 = OpAccessChain %102 %51 
					                                             OpStore %231 %230 
					                       Private f32* %232 = OpAccessChain %102 %51 
					                                f32 %233 = OpLoad %232 
					                       Private f32* %234 = OpAccessChain %102 %51 
					                                f32 %235 = OpLoad %234 
					                                f32 %236 = OpFMul %233 %235 
					                       Private f32* %237 = OpAccessChain %102 %51 
					                                             OpStore %237 %236 
					                       Private f32* %238 = OpAccessChain %102 %51 
					                                f32 %239 = OpLoad %238 
					                                f32 %240 = OpFMul %239 %97 
					                       Private f32* %241 = OpAccessChain %102 %51 
					                                             OpStore %241 %240 
					                       Private f32* %242 = OpAccessChain %102 %51 
					                                f32 %243 = OpLoad %242 
					                                f32 %244 = OpExtInst %1 29 %243 
					                       Private f32* %245 = OpAccessChain %102 %51 
					                                             OpStore %245 %244 
					                       Private f32* %246 = OpAccessChain %102 %51 
					                                f32 %247 = OpLoad %246 
					                                f32 %249 = OpFMul %247 %248 
					                                             OpStore %177 %249 
					                       Private f32* %250 = OpAccessChain %102 %51 
					                                f32 %251 = OpLoad %250 
					                                f32 %252 = OpFMul %251 %248 
					                                f32 %253 = OpLoad %42 
					                                f32 %254 = OpFAdd %252 %253 
					                                             OpStore %42 %254 
					                                f32 %255 = OpLoad %177 
					                              f32_3 %256 = OpCompositeConstruct %255 %255 %255 
					                              f32_3 %257 = OpLoad %32 
					                              f32_3 %258 = OpFMul %256 %257 
					                              f32_3 %259 = OpLoad %9 
					                              f32_3 %260 = OpFAdd %258 %259 
					                                             OpStore %9 %260 
					                read_only Texture2D %261 = OpLoad %12 
					                            sampler %262 = OpLoad %16 
					         read_only Texture2DSampled %263 = OpSampledImage %261 %262 
					                              f32_2 %264 = OpLoad vs_TEXCOORD0 
					                              f32_4 %267 = OpImageSampleImplicitLod %263 %264 ConstOffset %29 
					                              f32_3 %268 = OpVectorShuffle %267 %267 0 1 2 
					                                             OpStore %32 %268 
					                read_only Texture2D %269 = OpLoad %43 
					                            sampler %270 = OpLoad %45 
					         read_only Texture2DSampled %271 = OpSampledImage %269 %270 
					                              f32_2 %272 = OpLoad vs_TEXCOORD0 
					                              f32_4 %273 = OpImageSampleImplicitLod %271 %272 ConstOffset %29 
					                                f32 %274 = OpCompositeExtract %273 0 
					                       Private f32* %275 = OpAccessChain %102 %51 
					                                             OpStore %275 %274 
					                       Uniform f32* %276 = OpAccessChain %55 %26 %56 
					                                f32 %277 = OpLoad %276 
					                       Private f32* %278 = OpAccessChain %102 %51 
					                                f32 %279 = OpLoad %278 
					                                f32 %280 = OpFMul %277 %279 
					                       Uniform f32* %281 = OpAccessChain %55 %26 %62 
					                                f32 %282 = OpLoad %281 
					                                f32 %283 = OpFAdd %280 %282 
					                       Private f32* %284 = OpAccessChain %102 %51 
					                                             OpStore %284 %283 
					                       Private f32* %285 = OpAccessChain %102 %51 
					                                f32 %286 = OpLoad %285 
					                                f32 %287 = OpFDiv %66 %286 
					                       Private f32* %288 = OpAccessChain %102 %51 
					                                             OpStore %288 %287 
					                                f32 %289 = OpLoad %69 
					                       Private f32* %290 = OpAccessChain %102 %51 
					                                f32 %291 = OpLoad %290 
					                                f32 %292 = OpFNegate %291 
					                                f32 %293 = OpFAdd %289 %292 
					                       Private f32* %294 = OpAccessChain %102 %51 
					                                             OpStore %294 %293 
					                       Private f32* %295 = OpAccessChain %102 %51 
					                                f32 %296 = OpLoad %295 
					                                f32 %297 = OpExtInst %1 4 %296 
					                                f32 %298 = OpFMul %297 %91 
					                       Private f32* %299 = OpAccessChain %102 %51 
					                                             OpStore %299 %298 
					                       Private f32* %300 = OpAccessChain %102 %51 
					                                f32 %301 = OpLoad %300 
					                       Private f32* %302 = OpAccessChain %102 %51 
					                                f32 %303 = OpLoad %302 
					                                f32 %304 = OpFMul %301 %303 
					                       Private f32* %305 = OpAccessChain %102 %51 
					                                             OpStore %305 %304 
					                       Private f32* %306 = OpAccessChain %102 %51 
					                                f32 %307 = OpLoad %306 
					                                f32 %308 = OpFMul %307 %97 
					                       Private f32* %309 = OpAccessChain %102 %51 
					                                             OpStore %309 %308 
					                       Private f32* %310 = OpAccessChain %102 %51 
					                                f32 %311 = OpLoad %310 
					                                f32 %312 = OpExtInst %1 29 %311 
					                       Private f32* %313 = OpAccessChain %102 %51 
					                                             OpStore %313 %312 
					                       Private f32* %314 = OpAccessChain %102 %51 
					                                f32 %315 = OpLoad %314 
					                                f32 %317 = OpFMul %315 %316 
					                                             OpStore %177 %317 
					                       Private f32* %318 = OpAccessChain %102 %51 
					                                f32 %319 = OpLoad %318 
					                                f32 %320 = OpFMul %319 %316 
					                                f32 %321 = OpLoad %42 
					                                f32 %322 = OpFAdd %320 %321 
					                                             OpStore %42 %322 
					                                f32 %323 = OpLoad %177 
					                              f32_3 %324 = OpCompositeConstruct %323 %323 %323 
					                              f32_3 %325 = OpLoad %32 
					                              f32_3 %326 = OpFMul %324 %325 
					                              f32_3 %327 = OpLoad %9 
					                              f32_3 %328 = OpFAdd %326 %327 
					                                             OpStore %9 %328 
					                read_only Texture2D %329 = OpLoad %12 
					                            sampler %330 = OpLoad %16 
					         read_only Texture2DSampled %331 = OpSampledImage %329 %330 
					                              f32_2 %332 = OpLoad vs_TEXCOORD0 
					                              f32_4 %335 = OpImageSampleImplicitLod %331 %332 ConstOffset %29 
					                              f32_3 %336 = OpVectorShuffle %335 %335 0 1 2 
					                                             OpStore %32 %336 
					                read_only Texture2D %337 = OpLoad %43 
					                            sampler %338 = OpLoad %45 
					         read_only Texture2DSampled %339 = OpSampledImage %337 %338 
					                              f32_2 %340 = OpLoad vs_TEXCOORD0 
					                              f32_4 %341 = OpImageSampleImplicitLod %339 %340 ConstOffset %29 
					                                f32 %342 = OpCompositeExtract %341 0 
					                       Private f32* %343 = OpAccessChain %102 %51 
					                                             OpStore %343 %342 
					                       Uniform f32* %344 = OpAccessChain %55 %26 %56 
					                                f32 %345 = OpLoad %344 
					                       Private f32* %346 = OpAccessChain %102 %51 
					                                f32 %347 = OpLoad %346 
					                                f32 %348 = OpFMul %345 %347 
					                       Uniform f32* %349 = OpAccessChain %55 %26 %62 
					                                f32 %350 = OpLoad %349 
					                                f32 %351 = OpFAdd %348 %350 
					                       Private f32* %352 = OpAccessChain %102 %51 
					                                             OpStore %352 %351 
					                       Private f32* %353 = OpAccessChain %102 %51 
					                                f32 %354 = OpLoad %353 
					                                f32 %355 = OpFDiv %66 %354 
					                       Private f32* %356 = OpAccessChain %102 %51 
					                                             OpStore %356 %355 
					                                f32 %357 = OpLoad %69 
					                       Private f32* %358 = OpAccessChain %102 %51 
					                                f32 %359 = OpLoad %358 
					                                f32 %360 = OpFNegate %359 
					                                f32 %361 = OpFAdd %357 %360 
					                       Private f32* %362 = OpAccessChain %102 %51 
					                                             OpStore %362 %361 
					                       Private f32* %363 = OpAccessChain %102 %51 
					                                f32 %364 = OpLoad %363 
					                                f32 %365 = OpExtInst %1 4 %364 
					                                f32 %366 = OpFMul %365 %91 
					                       Private f32* %367 = OpAccessChain %102 %51 
					                                             OpStore %367 %366 
					                       Private f32* %368 = OpAccessChain %102 %51 
					                                f32 %369 = OpLoad %368 
					                       Private f32* %370 = OpAccessChain %102 %51 
					                                f32 %371 = OpLoad %370 
					                                f32 %372 = OpFMul %369 %371 
					                       Private f32* %373 = OpAccessChain %102 %51 
					                                             OpStore %373 %372 
					                       Private f32* %374 = OpAccessChain %102 %51 
					                                f32 %375 = OpLoad %374 
					                                f32 %376 = OpFMul %375 %97 
					                       Private f32* %377 = OpAccessChain %102 %51 
					                                             OpStore %377 %376 
					                       Private f32* %378 = OpAccessChain %102 %51 
					                                f32 %379 = OpLoad %378 
					                                f32 %380 = OpExtInst %1 29 %379 
					                       Private f32* %381 = OpAccessChain %102 %51 
					                                             OpStore %381 %380 
					                       Private f32* %382 = OpAccessChain %102 %51 
					                                f32 %383 = OpLoad %382 
					                                f32 %385 = OpFMul %383 %384 
					                                             OpStore %177 %385 
					                       Private f32* %386 = OpAccessChain %102 %51 
					                                f32 %387 = OpLoad %386 
					                                f32 %388 = OpFMul %387 %384 
					                                f32 %389 = OpLoad %42 
					                                f32 %390 = OpFAdd %388 %389 
					                                             OpStore %42 %390 
					                                f32 %391 = OpLoad %177 
					                              f32_3 %392 = OpCompositeConstruct %391 %391 %391 
					                              f32_3 %393 = OpLoad %32 
					                              f32_3 %394 = OpFMul %392 %393 
					                              f32_3 %395 = OpLoad %9 
					                              f32_3 %396 = OpFAdd %394 %395 
					                                             OpStore %9 %396 
					                read_only Texture2D %397 = OpLoad %12 
					                            sampler %398 = OpLoad %16 
					         read_only Texture2DSampled %399 = OpSampledImage %397 %398 
					                              f32_2 %400 = OpLoad vs_TEXCOORD0 
					                              f32_4 %403 = OpImageSampleImplicitLod %399 %400 ConstOffset %29 
					                              f32_3 %404 = OpVectorShuffle %403 %403 0 1 2 
					                                             OpStore %32 %404 
					                read_only Texture2D %405 = OpLoad %43 
					                            sampler %406 = OpLoad %45 
					         read_only Texture2DSampled %407 = OpSampledImage %405 %406 
					                              f32_2 %408 = OpLoad vs_TEXCOORD0 
					                              f32_4 %409 = OpImageSampleImplicitLod %407 %408 ConstOffset %29 
					                                f32 %410 = OpCompositeExtract %409 0 
					                       Private f32* %411 = OpAccessChain %102 %51 
					                                             OpStore %411 %410 
					                       Uniform f32* %412 = OpAccessChain %55 %26 %56 
					                                f32 %413 = OpLoad %412 
					                       Private f32* %414 = OpAccessChain %102 %51 
					                                f32 %415 = OpLoad %414 
					                                f32 %416 = OpFMul %413 %415 
					                       Uniform f32* %417 = OpAccessChain %55 %26 %62 
					                                f32 %418 = OpLoad %417 
					                                f32 %419 = OpFAdd %416 %418 
					                       Private f32* %420 = OpAccessChain %102 %51 
					                                             OpStore %420 %419 
					                       Private f32* %421 = OpAccessChain %102 %51 
					                                f32 %422 = OpLoad %421 
					                                f32 %423 = OpFDiv %66 %422 
					                       Private f32* %424 = OpAccessChain %102 %51 
					                                             OpStore %424 %423 
					                                f32 %425 = OpLoad %69 
					                       Private f32* %426 = OpAccessChain %102 %51 
					                                f32 %427 = OpLoad %426 
					                                f32 %428 = OpFNegate %427 
					                                f32 %429 = OpFAdd %425 %428 
					                       Private f32* %430 = OpAccessChain %102 %51 
					                                             OpStore %430 %429 
					                       Private f32* %431 = OpAccessChain %102 %51 
					                                f32 %432 = OpLoad %431 
					                                f32 %433 = OpExtInst %1 4 %432 
					                                f32 %434 = OpFMul %433 %91 
					                       Private f32* %435 = OpAccessChain %102 %51 
					                                             OpStore %435 %434 
					                       Private f32* %436 = OpAccessChain %102 %51 
					                                f32 %437 = OpLoad %436 
					                       Private f32* %438 = OpAccessChain %102 %51 
					                                f32 %439 = OpLoad %438 
					                                f32 %440 = OpFMul %437 %439 
					                       Private f32* %441 = OpAccessChain %102 %51 
					                                             OpStore %441 %440 
					                       Private f32* %442 = OpAccessChain %102 %51 
					                                f32 %443 = OpLoad %442 
					                                f32 %444 = OpFMul %443 %97 
					                       Private f32* %445 = OpAccessChain %102 %51 
					                                             OpStore %445 %444 
					                       Private f32* %446 = OpAccessChain %102 %51 
					                                f32 %447 = OpLoad %446 
					                                f32 %448 = OpExtInst %1 29 %447 
					                       Private f32* %449 = OpAccessChain %102 %51 
					                                             OpStore %449 %448 
					                       Private f32* %450 = OpAccessChain %102 %51 
					                                f32 %451 = OpLoad %450 
					                                f32 %452 = OpFMul %451 %384 
					                                             OpStore %177 %452 
					                       Private f32* %453 = OpAccessChain %102 %51 
					                                f32 %454 = OpLoad %453 
					                                f32 %455 = OpFMul %454 %384 
					                                f32 %456 = OpLoad %42 
					                                f32 %457 = OpFAdd %455 %456 
					                                             OpStore %42 %457 
					                                f32 %458 = OpLoad %177 
					                              f32_3 %459 = OpCompositeConstruct %458 %458 %458 
					                              f32_3 %460 = OpLoad %32 
					                              f32_3 %461 = OpFMul %459 %460 
					                              f32_3 %462 = OpLoad %9 
					                              f32_3 %463 = OpFAdd %461 %462 
					                                             OpStore %9 %463 
					                read_only Texture2D %464 = OpLoad %12 
					                            sampler %465 = OpLoad %16 
					         read_only Texture2DSampled %466 = OpSampledImage %464 %465 
					                              f32_2 %467 = OpLoad vs_TEXCOORD0 
					                              f32_4 %470 = OpImageSampleImplicitLod %466 %467 ConstOffset %29 
					                              f32_3 %471 = OpVectorShuffle %470 %470 0 1 2 
					                                             OpStore %32 %471 
					                read_only Texture2D %472 = OpLoad %43 
					                            sampler %473 = OpLoad %45 
					         read_only Texture2DSampled %474 = OpSampledImage %472 %473 
					                              f32_2 %475 = OpLoad vs_TEXCOORD0 
					                              f32_4 %476 = OpImageSampleImplicitLod %474 %475 ConstOffset %29 
					                                f32 %477 = OpCompositeExtract %476 0 
					                       Private f32* %478 = OpAccessChain %102 %51 
					                                             OpStore %478 %477 
					                       Uniform f32* %479 = OpAccessChain %55 %26 %56 
					                                f32 %480 = OpLoad %479 
					                       Private f32* %481 = OpAccessChain %102 %51 
					                                f32 %482 = OpLoad %481 
					                                f32 %483 = OpFMul %480 %482 
					                       Uniform f32* %484 = OpAccessChain %55 %26 %62 
					                                f32 %485 = OpLoad %484 
					                                f32 %486 = OpFAdd %483 %485 
					                       Private f32* %487 = OpAccessChain %102 %51 
					                                             OpStore %487 %486 
					                       Private f32* %488 = OpAccessChain %102 %51 
					                                f32 %489 = OpLoad %488 
					                                f32 %490 = OpFDiv %66 %489 
					                       Private f32* %491 = OpAccessChain %102 %51 
					                                             OpStore %491 %490 
					                                f32 %492 = OpLoad %69 
					                       Private f32* %493 = OpAccessChain %102 %51 
					                                f32 %494 = OpLoad %493 
					                                f32 %495 = OpFNegate %494 
					                                f32 %496 = OpFAdd %492 %495 
					                       Private f32* %497 = OpAccessChain %102 %51 
					                                             OpStore %497 %496 
					                       Private f32* %498 = OpAccessChain %102 %51 
					                                f32 %499 = OpLoad %498 
					                                f32 %500 = OpExtInst %1 4 %499 
					                                f32 %501 = OpFMul %500 %91 
					                       Private f32* %502 = OpAccessChain %102 %51 
					                                             OpStore %502 %501 
					                       Private f32* %503 = OpAccessChain %102 %51 
					                                f32 %504 = OpLoad %503 
					                       Private f32* %505 = OpAccessChain %102 %51 
					                                f32 %506 = OpLoad %505 
					                                f32 %507 = OpFMul %504 %506 
					                       Private f32* %508 = OpAccessChain %102 %51 
					                                             OpStore %508 %507 
					                       Private f32* %509 = OpAccessChain %102 %51 
					                                f32 %510 = OpLoad %509 
					                                f32 %511 = OpFMul %510 %97 
					                       Private f32* %512 = OpAccessChain %102 %51 
					                                             OpStore %512 %511 
					                       Private f32* %513 = OpAccessChain %102 %51 
					                                f32 %514 = OpLoad %513 
					                                f32 %515 = OpExtInst %1 29 %514 
					                       Private f32* %516 = OpAccessChain %102 %51 
					                                             OpStore %516 %515 
					                       Private f32* %517 = OpAccessChain %102 %51 
					                                f32 %518 = OpLoad %517 
					                                f32 %519 = OpFMul %518 %316 
					                                             OpStore %177 %519 
					                       Private f32* %520 = OpAccessChain %102 %51 
					                                f32 %521 = OpLoad %520 
					                                f32 %522 = OpFMul %521 %316 
					                                f32 %523 = OpLoad %42 
					                                f32 %524 = OpFAdd %522 %523 
					                                             OpStore %42 %524 
					                                f32 %525 = OpLoad %177 
					                              f32_3 %526 = OpCompositeConstruct %525 %525 %525 
					                              f32_3 %527 = OpLoad %32 
					                              f32_3 %528 = OpFMul %526 %527 
					                              f32_3 %529 = OpLoad %9 
					                              f32_3 %530 = OpFAdd %528 %529 
					                                             OpStore %9 %530 
					                read_only Texture2D %531 = OpLoad %12 
					                            sampler %532 = OpLoad %16 
					         read_only Texture2DSampled %533 = OpSampledImage %531 %532 
					                              f32_2 %534 = OpLoad vs_TEXCOORD0 
					                              f32_4 %537 = OpImageSampleImplicitLod %533 %534 ConstOffset %29 
					                              f32_3 %538 = OpVectorShuffle %537 %537 0 1 2 
					                                             OpStore %32 %538 
					                read_only Texture2D %539 = OpLoad %43 
					                            sampler %540 = OpLoad %45 
					         read_only Texture2DSampled %541 = OpSampledImage %539 %540 
					                              f32_2 %542 = OpLoad vs_TEXCOORD0 
					                              f32_4 %543 = OpImageSampleImplicitLod %541 %542 ConstOffset %29 
					                                f32 %544 = OpCompositeExtract %543 0 
					                       Private f32* %545 = OpAccessChain %102 %51 
					                                             OpStore %545 %544 
					                       Uniform f32* %546 = OpAccessChain %55 %26 %56 
					                                f32 %547 = OpLoad %546 
					                       Private f32* %548 = OpAccessChain %102 %51 
					                                f32 %549 = OpLoad %548 
					                                f32 %550 = OpFMul %547 %549 
					                       Uniform f32* %551 = OpAccessChain %55 %26 %62 
					                                f32 %552 = OpLoad %551 
					                                f32 %553 = OpFAdd %550 %552 
					                       Private f32* %554 = OpAccessChain %102 %51 
					                                             OpStore %554 %553 
					                       Private f32* %555 = OpAccessChain %102 %51 
					                                f32 %556 = OpLoad %555 
					                                f32 %557 = OpFDiv %66 %556 
					                       Private f32* %558 = OpAccessChain %102 %51 
					                                             OpStore %558 %557 
					                                f32 %559 = OpLoad %69 
					                       Private f32* %560 = OpAccessChain %102 %51 
					                                f32 %561 = OpLoad %560 
					                                f32 %562 = OpFNegate %561 
					                                f32 %563 = OpFAdd %559 %562 
					                       Private f32* %564 = OpAccessChain %102 %51 
					                                             OpStore %564 %563 
					                       Private f32* %565 = OpAccessChain %102 %51 
					                                f32 %566 = OpLoad %565 
					                                f32 %567 = OpExtInst %1 4 %566 
					                                f32 %568 = OpFMul %567 %91 
					                       Private f32* %569 = OpAccessChain %102 %51 
					                                             OpStore %569 %568 
					                       Private f32* %570 = OpAccessChain %102 %51 
					                                f32 %571 = OpLoad %570 
					                       Private f32* %572 = OpAccessChain %102 %51 
					                                f32 %573 = OpLoad %572 
					                                f32 %574 = OpFMul %571 %573 
					                       Private f32* %575 = OpAccessChain %102 %51 
					                                             OpStore %575 %574 
					                       Private f32* %576 = OpAccessChain %102 %51 
					                                f32 %577 = OpLoad %576 
					                                f32 %578 = OpFMul %577 %97 
					                       Private f32* %579 = OpAccessChain %102 %51 
					                                             OpStore %579 %578 
					                       Private f32* %580 = OpAccessChain %102 %51 
					                                f32 %581 = OpLoad %580 
					                                f32 %582 = OpExtInst %1 29 %581 
					                       Private f32* %583 = OpAccessChain %102 %51 
					                                             OpStore %583 %582 
					                       Private f32* %584 = OpAccessChain %102 %51 
					                                f32 %585 = OpLoad %584 
					                                f32 %586 = OpFMul %585 %248 
					                                             OpStore %177 %586 
					                       Private f32* %587 = OpAccessChain %102 %51 
					                                f32 %588 = OpLoad %587 
					                                f32 %589 = OpFMul %588 %248 
					                                f32 %590 = OpLoad %42 
					                                f32 %591 = OpFAdd %589 %590 
					                                             OpStore %42 %591 
					                                f32 %592 = OpLoad %177 
					                              f32_3 %593 = OpCompositeConstruct %592 %592 %592 
					                              f32_3 %594 = OpLoad %32 
					                              f32_3 %595 = OpFMul %593 %594 
					                              f32_3 %596 = OpLoad %9 
					                              f32_3 %597 = OpFAdd %595 %596 
					                                             OpStore %9 %597 
					                read_only Texture2D %598 = OpLoad %12 
					                            sampler %599 = OpLoad %16 
					         read_only Texture2DSampled %600 = OpSampledImage %598 %599 
					                              f32_2 %601 = OpLoad vs_TEXCOORD0 
					                              f32_4 %604 = OpImageSampleImplicitLod %600 %601 ConstOffset %29 
					                              f32_3 %605 = OpVectorShuffle %604 %604 0 1 2 
					                                             OpStore %32 %605 
					                read_only Texture2D %606 = OpLoad %43 
					                            sampler %607 = OpLoad %45 
					         read_only Texture2DSampled %608 = OpSampledImage %606 %607 
					                              f32_2 %609 = OpLoad vs_TEXCOORD0 
					                              f32_4 %610 = OpImageSampleImplicitLod %608 %609 ConstOffset %29 
					                                f32 %611 = OpCompositeExtract %610 0 
					                       Private f32* %612 = OpAccessChain %102 %51 
					                                             OpStore %612 %611 
					                       Uniform f32* %613 = OpAccessChain %55 %26 %56 
					                                f32 %614 = OpLoad %613 
					                       Private f32* %615 = OpAccessChain %102 %51 
					                                f32 %616 = OpLoad %615 
					                                f32 %617 = OpFMul %614 %616 
					                       Uniform f32* %618 = OpAccessChain %55 %26 %62 
					                                f32 %619 = OpLoad %618 
					                                f32 %620 = OpFAdd %617 %619 
					                       Private f32* %621 = OpAccessChain %102 %51 
					                                             OpStore %621 %620 
					                       Private f32* %622 = OpAccessChain %102 %51 
					                                f32 %623 = OpLoad %622 
					                                f32 %624 = OpFDiv %66 %623 
					                       Private f32* %625 = OpAccessChain %102 %51 
					                                             OpStore %625 %624 
					                                f32 %626 = OpLoad %69 
					                       Private f32* %627 = OpAccessChain %102 %51 
					                                f32 %628 = OpLoad %627 
					                                f32 %629 = OpFNegate %628 
					                                f32 %630 = OpFAdd %626 %629 
					                       Private f32* %631 = OpAccessChain %102 %51 
					                                             OpStore %631 %630 
					                       Private f32* %632 = OpAccessChain %102 %51 
					                                f32 %633 = OpLoad %632 
					                                f32 %634 = OpExtInst %1 4 %633 
					                                f32 %635 = OpFMul %634 %91 
					                       Private f32* %636 = OpAccessChain %102 %51 
					                                             OpStore %636 %635 
					                       Private f32* %637 = OpAccessChain %102 %51 
					                                f32 %638 = OpLoad %637 
					                       Private f32* %639 = OpAccessChain %102 %51 
					                                f32 %640 = OpLoad %639 
					                                f32 %641 = OpFMul %638 %640 
					                       Private f32* %642 = OpAccessChain %102 %51 
					                                             OpStore %642 %641 
					                       Private f32* %643 = OpAccessChain %102 %51 
					                                f32 %644 = OpLoad %643 
					                                f32 %645 = OpFMul %644 %97 
					                       Private f32* %646 = OpAccessChain %102 %51 
					                                             OpStore %646 %645 
					                       Private f32* %647 = OpAccessChain %102 %51 
					                                f32 %648 = OpLoad %647 
					                                f32 %649 = OpExtInst %1 29 %648 
					                       Private f32* %650 = OpAccessChain %102 %51 
					                                             OpStore %650 %649 
					                       Private f32* %651 = OpAccessChain %102 %51 
					                                f32 %652 = OpLoad %651 
					                                f32 %653 = OpFMul %652 %180 
					                                             OpStore %177 %653 
					                       Private f32* %654 = OpAccessChain %102 %51 
					                                f32 %655 = OpLoad %654 
					                                f32 %656 = OpFMul %655 %180 
					                                f32 %657 = OpLoad %42 
					                                f32 %658 = OpFAdd %656 %657 
					                                             OpStore %42 %658 
					                                f32 %659 = OpLoad %177 
					                              f32_3 %660 = OpCompositeConstruct %659 %659 %659 
					                              f32_3 %661 = OpLoad %32 
					                              f32_3 %662 = OpFMul %660 %661 
					                              f32_3 %663 = OpLoad %9 
					                              f32_3 %664 = OpFAdd %662 %663 
					                                             OpStore %9 %664 
					                read_only Texture2D %665 = OpLoad %12 
					                            sampler %666 = OpLoad %16 
					         read_only Texture2DSampled %667 = OpSampledImage %665 %666 
					                              f32_2 %668 = OpLoad vs_TEXCOORD0 
					                              f32_4 %671 = OpImageSampleImplicitLod %667 %668 ConstOffset %29 
					                              f32_3 %672 = OpVectorShuffle %671 %671 0 1 2 
					                                             OpStore %32 %672 
					                read_only Texture2D %673 = OpLoad %43 
					                            sampler %674 = OpLoad %45 
					         read_only Texture2DSampled %675 = OpSampledImage %673 %674 
					                              f32_2 %676 = OpLoad vs_TEXCOORD0 
					                              f32_4 %677 = OpImageSampleImplicitLod %675 %676 ConstOffset %29 
					                                f32 %678 = OpCompositeExtract %677 0 
					                       Private f32* %679 = OpAccessChain %102 %51 
					                                             OpStore %679 %678 
					                       Uniform f32* %680 = OpAccessChain %55 %26 %56 
					                                f32 %681 = OpLoad %680 
					                       Private f32* %682 = OpAccessChain %102 %51 
					                                f32 %683 = OpLoad %682 
					                                f32 %684 = OpFMul %681 %683 
					                       Uniform f32* %685 = OpAccessChain %55 %26 %62 
					                                f32 %686 = OpLoad %685 
					                                f32 %687 = OpFAdd %684 %686 
					                       Private f32* %688 = OpAccessChain %102 %51 
					                                             OpStore %688 %687 
					                       Private f32* %689 = OpAccessChain %102 %51 
					                                f32 %690 = OpLoad %689 
					                                f32 %691 = OpFDiv %66 %690 
					                       Private f32* %692 = OpAccessChain %102 %51 
					                                             OpStore %692 %691 
					                                f32 %693 = OpLoad %69 
					                       Private f32* %694 = OpAccessChain %102 %51 
					                                f32 %695 = OpLoad %694 
					                                f32 %696 = OpFNegate %695 
					                                f32 %697 = OpFAdd %693 %696 
					                                             OpStore %69 %697 
					                                f32 %698 = OpLoad %69 
					                                f32 %699 = OpExtInst %1 4 %698 
					                                f32 %700 = OpFMul %699 %91 
					                                             OpStore %69 %700 
					                                f32 %701 = OpLoad %69 
					                                f32 %702 = OpLoad %69 
					                                f32 %703 = OpFMul %701 %702 
					                                             OpStore %69 %703 
					                                f32 %704 = OpLoad %69 
					                                f32 %705 = OpFMul %704 %97 
					                                             OpStore %69 %705 
					                                f32 %706 = OpLoad %69 
					                                f32 %707 = OpExtInst %1 29 %706 
					                                             OpStore %69 %707 
					                                f32 %708 = OpLoad %69 
					                                f32 %709 = OpFMul %708 %104 
					                       Private f32* %710 = OpAccessChain %102 %51 
					                                             OpStore %710 %709 
					                                f32 %711 = OpLoad %69 
					                                f32 %712 = OpFMul %711 %104 
					                                f32 %713 = OpLoad %42 
					                                f32 %714 = OpFAdd %712 %713 
					                                             OpStore %42 %714 
					                              f32_4 %715 = OpLoad %102 
					                              f32_3 %716 = OpVectorShuffle %715 %715 0 0 0 
					                              f32_3 %717 = OpLoad %32 
					                              f32_3 %718 = OpFMul %716 %717 
					                              f32_3 %719 = OpLoad %9 
					                              f32_3 %720 = OpFAdd %718 %719 
					                                             OpStore %9 %720 
					                              f32_3 %721 = OpLoad %9 
					                                f32 %722 = OpLoad %42 
					                              f32_3 %723 = OpCompositeConstruct %722 %722 %722 
					                              f32_3 %724 = OpFDiv %721 %723 
					                              f32_4 %725 = OpLoad %127 
					                              f32_4 %726 = OpVectorShuffle %725 %724 4 5 6 3 
					                                             OpStore %127 %726 
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[7];
						vec4 _ZBufferParams;
						vec4 unused_0_2;
					};
					uniform  sampler2D _HalfResDepthBuffer;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat5;
					float u_xlat6;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -4));
					    u_xlat1 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -5));
					    u_xlat2 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -5));
					    u_xlat12 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat2 = texture(_HalfResDepthBuffer, vs_TEXCOORD0.xy);
					    u_xlat13 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat12 = (-u_xlat12) + u_xlat13;
					    u_xlat12 = abs(u_xlat12) * 0.5;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat12 = u_xlat12 * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat2.x = u_xlat12 * 0.0388552807;
					    u_xlat12 = u_xlat12 * 0.0388552807 + 0.119682692;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat2.xyz * vec3(0.119682692, 0.119682692, 0.119682692) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat2 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -4));
					    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.x = u_xlat13 + (-u_xlat2.x);
					    u_xlat2.x = abs(u_xlat2.x) * 0.5;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * -1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat6 = u_xlat2.x * 0.058255814;
					    u_xlat12 = u_xlat2.x * 0.058255814 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -3));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -3));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0798255801;
					    u_xlat12 = u_xlat1.x * 0.0798255801 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -2));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -2));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0999673903;
					    u_xlat12 = u_xlat1.x * 0.0999673903 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -1));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -1));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.114416353;
					    u_xlat12 = u_xlat1.x * 0.114416353 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 1));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 1));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.114416353;
					    u_xlat12 = u_xlat1.x * 0.114416353 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 2));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 2));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0999673903;
					    u_xlat12 = u_xlat1.x * 0.0999673903 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 3));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 3));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0798255801;
					    u_xlat12 = u_xlat1.x * 0.0798255801 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 4));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 4));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.058255814;
					    u_xlat12 = u_xlat1.x * 0.058255814 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 5));
					    u_xlat3 = textureOffset(_HalfResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 5));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0388552807;
					    u_xlat12 = u_xlat1.x * 0.0388552807 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz / vec3(u_xlat12);
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
			GpuProgramID 266594
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
					UNITY_BINDING(0) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					UNITY_BINDING(1) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
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
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_texture_gather
					#extension GL_ARB_texture_gather : enable
					#endif
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out float SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					vec2 u_xlat4;
					float u_xlat6;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0 = hlslcc_FragCoord.xyxy + hlslcc_FragCoord.xyxy;
					    u_xlatb0 = greaterThanEqual(u_xlat0, (-u_xlat0.zwzw));
					    u_xlat0.x = (u_xlatb0.x) ? float(2.0) : float(-2.0);
					    u_xlat0.y = (u_xlatb0.y) ? float(2.0) : float(-2.0);
					    u_xlat0.z = (u_xlatb0.z) ? float(0.5) : float(-0.5);
					    u_xlat0.w = (u_xlatb0.w) ? float(0.5) : float(-0.5);
					    u_xlat4.xy = u_xlat0.zw * hlslcc_FragCoord.xy;
					    u_xlat4.xy = fract(u_xlat4.xy);
					    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
					    u_xlati0.xy = ivec2(u_xlat0.xy);
					    u_xlati0.x = u_xlati0.y + u_xlati0.x;
					    u_xlatb0.x = u_xlati0.x==1;
					    u_xlat1 = textureGather(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat2.xy = min(u_xlat1.yw, u_xlat1.xz);
					    u_xlat1.xy = max(u_xlat1.yw, u_xlat1.xz);
					    u_xlat6 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat2.x = min(u_xlat2.y, u_xlat2.x);
					    SV_Target0 = (u_xlatb0.x) ? u_xlat2.x : u_xlat6;
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
					; Bound: 157
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %11 %114 %144 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpDecorate %11 BuiltIn TessLevelOuter 
					                                              OpDecorate %105 DescriptorSet 105 
					                                              OpDecorate %105 Binding 105 
					                                              OpDecorate %109 DescriptorSet 109 
					                                              OpDecorate %109 Binding 109 
					                                              OpDecorate vs_TEXCOORD0 Location 114 
					                                              OpDecorate %144 Location 144 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 4 
					                                       %8 = OpTypePointer Function %7 
					                                      %10 = OpTypePointer Input %7 
					                         Input f32_4* %11 = OpVariable Input 
					                                      %12 = OpTypeVector %6 3 
					                                  f32 %15 = OpConstant 3,674022E-40 
					                                      %16 = OpTypeInt 32 0 
					                                  u32 %17 = OpConstant 3 
					                                      %18 = OpTypePointer Input %6 
					                                      %26 = OpTypePointer Private %7 
					                       Private f32_4* %27 = OpVariable Private 
					                                      %33 = OpTypeBool 
					                                      %34 = OpTypeVector %33 4 
					                                      %35 = OpTypePointer Private %34 
					                      Private bool_4* %36 = OpVariable Private 
					                                  u32 %42 = OpConstant 0 
					                                      %43 = OpTypePointer Private %33 
					                                  f32 %46 = OpConstant 3,674022E-40 
					                                  f32 %47 = OpConstant 3,674022E-40 
					                                      %49 = OpTypePointer Private %6 
					                                  u32 %51 = OpConstant 1 
					                                  u32 %56 = OpConstant 2 
					                                  f32 %59 = OpConstant 3,674022E-40 
					                                  f32 %60 = OpConstant 3,674022E-40 
					                                      %67 = OpTypeVector %6 2 
					                                      %68 = OpTypePointer Private %67 
					                       Private f32_2* %69 = OpVariable Private 
					                                      %83 = OpTypeInt 32 1 
					                                      %84 = OpTypeVector %83 2 
					                                      %85 = OpTypePointer Private %84 
					                       Private i32_2* %86 = OpVariable Private 
					                                      %90 = OpTypePointer Private %83 
					                                  i32 %99 = OpConstant 1 
					                      Private f32_4* %102 = OpVariable Private 
					                                     %103 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %104 = OpTypePointer UniformConstant %103 
					UniformConstant read_only Texture2D* %105 = OpVariable UniformConstant 
					                                     %107 = OpTypeSampler 
					                                     %108 = OpTypePointer UniformConstant %107 
					            UniformConstant sampler* %109 = OpVariable UniformConstant 
					                                     %111 = OpTypeSampledImage %103 
					                                     %113 = OpTypePointer Input %67 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 i32 %116 = OpConstant 0 
					                      Private f32_2* %118 = OpVariable Private 
					                        Private f32* %131 = OpVariable Private 
					                                     %143 = OpTypePointer Output %6 
					                         Output f32* %144 = OpVariable Output 
					                                     %147 = OpTypePointer Function %6 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                       Function f32_4* %9 = OpVariable Function 
					                       Function f32* %148 = OpVariable Function 
					                                f32_4 %13 = OpLoad %11 
					                                f32_3 %14 = OpVectorShuffle %13 %13 0 1 2 
					                           Input f32* %19 = OpAccessChain %11 %17 
					                                  f32 %20 = OpLoad %19 
					                                  f32 %21 = OpFDiv %15 %20 
					                                  f32 %22 = OpCompositeExtract %14 0 
					                                  f32 %23 = OpCompositeExtract %14 1 
					                                  f32 %24 = OpCompositeExtract %14 2 
					                                f32_4 %25 = OpCompositeConstruct %22 %23 %24 %21 
					                                              OpStore %9 %25 
					                                f32_4 %28 = OpLoad %9 
					                                f32_4 %29 = OpVectorShuffle %28 %28 0 1 0 1 
					                                f32_4 %30 = OpLoad %9 
					                                f32_4 %31 = OpVectorShuffle %30 %30 0 1 0 1 
					                                f32_4 %32 = OpFAdd %29 %31 
					                                              OpStore %27 %32 
					                                f32_4 %37 = OpLoad %27 
					                                f32_4 %38 = OpLoad %27 
					                                f32_4 %39 = OpVectorShuffle %38 %38 2 3 2 3 
					                                f32_4 %40 = OpFNegate %39 
					                               bool_4 %41 = OpFOrdGreaterThanEqual %37 %40 
					                                              OpStore %36 %41 
					                        Private bool* %44 = OpAccessChain %36 %42 
					                                 bool %45 = OpLoad %44 
					                                  f32 %48 = OpSelect %45 %46 %47 
					                         Private f32* %50 = OpAccessChain %27 %42 
					                                              OpStore %50 %48 
					                        Private bool* %52 = OpAccessChain %36 %51 
					                                 bool %53 = OpLoad %52 
					                                  f32 %54 = OpSelect %53 %46 %47 
					                         Private f32* %55 = OpAccessChain %27 %51 
					                                              OpStore %55 %54 
					                        Private bool* %57 = OpAccessChain %36 %56 
					                                 bool %58 = OpLoad %57 
					                                  f32 %61 = OpSelect %58 %59 %60 
					                         Private f32* %62 = OpAccessChain %27 %56 
					                                              OpStore %62 %61 
					                        Private bool* %63 = OpAccessChain %36 %17 
					                                 bool %64 = OpLoad %63 
					                                  f32 %65 = OpSelect %64 %59 %60 
					                         Private f32* %66 = OpAccessChain %27 %17 
					                                              OpStore %66 %65 
					                                f32_4 %70 = OpLoad %27 
					                                f32_2 %71 = OpVectorShuffle %70 %70 2 3 
					                                f32_4 %72 = OpLoad %9 
					                                f32_2 %73 = OpVectorShuffle %72 %72 0 1 
					                                f32_2 %74 = OpFMul %71 %73 
					                                              OpStore %69 %74 
					                                f32_2 %75 = OpLoad %69 
					                                f32_2 %76 = OpExtInst %1 10 %75 
					                                              OpStore %69 %76 
					                                f32_2 %77 = OpLoad %69 
					                                f32_4 %78 = OpLoad %27 
					                                f32_2 %79 = OpVectorShuffle %78 %78 0 1 
					                                f32_2 %80 = OpFMul %77 %79 
					                                f32_4 %81 = OpLoad %27 
					                                f32_4 %82 = OpVectorShuffle %81 %80 4 5 2 3 
					                                              OpStore %27 %82 
					                                f32_4 %87 = OpLoad %27 
					                                f32_2 %88 = OpVectorShuffle %87 %87 0 1 
					                                i32_2 %89 = OpConvertFToS %88 
					                                              OpStore %86 %89 
					                         Private i32* %91 = OpAccessChain %86 %51 
					                                  i32 %92 = OpLoad %91 
					                         Private i32* %93 = OpAccessChain %86 %42 
					                                  i32 %94 = OpLoad %93 
					                                  i32 %95 = OpIAdd %92 %94 
					                         Private i32* %96 = OpAccessChain %86 %42 
					                                              OpStore %96 %95 
					                         Private i32* %97 = OpAccessChain %86 %42 
					                                  i32 %98 = OpLoad %97 
					                                bool %100 = OpIEqual %98 %99 
					                       Private bool* %101 = OpAccessChain %36 %42 
					                                              OpStore %101 %100 
					                 read_only Texture2D %106 = OpLoad %105 
					                             sampler %110 = OpLoad %109 
					          read_only Texture2DSampled %112 = OpSampledImage %106 %110 
					                               f32_2 %115 = OpLoad vs_TEXCOORD0 
					                               f32_4 %117 = OpImageGather %112 %115 %116 
					                                              OpStore %102 %117 
					                               f32_4 %119 = OpLoad %102 
					                               f32_2 %120 = OpVectorShuffle %119 %119 1 3 
					                               f32_4 %121 = OpLoad %102 
					                               f32_2 %122 = OpVectorShuffle %121 %121 0 2 
					                               f32_2 %123 = OpExtInst %1 37 %120 %122 
					                                              OpStore %118 %123 
					                               f32_4 %124 = OpLoad %102 
					                               f32_2 %125 = OpVectorShuffle %124 %124 1 3 
					                               f32_4 %126 = OpLoad %102 
					                               f32_2 %127 = OpVectorShuffle %126 %126 0 2 
					                               f32_2 %128 = OpExtInst %1 40 %125 %127 
					                               f32_4 %129 = OpLoad %102 
					                               f32_4 %130 = OpVectorShuffle %129 %128 4 5 2 3 
					                                              OpStore %102 %130 
					                        Private f32* %132 = OpAccessChain %102 %51 
					                                 f32 %133 = OpLoad %132 
					                        Private f32* %134 = OpAccessChain %102 %42 
					                                 f32 %135 = OpLoad %134 
					                                 f32 %136 = OpExtInst %1 40 %133 %135 
					                                              OpStore %131 %136 
					                        Private f32* %137 = OpAccessChain %118 %51 
					                                 f32 %138 = OpLoad %137 
					                        Private f32* %139 = OpAccessChain %118 %42 
					                                 f32 %140 = OpLoad %139 
					                                 f32 %141 = OpExtInst %1 37 %138 %140 
					                        Private f32* %142 = OpAccessChain %118 %42 
					                                              OpStore %142 %141 
					                       Private bool* %145 = OpAccessChain %36 %42 
					                                bool %146 = OpLoad %145 
					                                              OpSelectionMerge %150 None 
					                                              OpBranchConditional %146 %149 %153 
					                                     %149 = OpLabel 
					                        Private f32* %151 = OpAccessChain %118 %42 
					                                 f32 %152 = OpLoad %151 
					                                              OpStore %148 %152 
					                                              OpBranch %150 
					                                     %153 = OpLabel 
					                                 f32 %154 = OpLoad %131 
					                                              OpStore %148 %154 
					                                              OpBranch %150 
					                                     %150 = OpLabel 
					                                 f32 %155 = OpLoad %148 
					                                              OpStore %144 %155 
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
					UNITY_LOCATION(0) uniform  sampler2D _CameraDepthTexture;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out float SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					vec2 u_xlat4;
					float u_xlat6;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0 = hlslcc_FragCoord.xyxy + hlslcc_FragCoord.xyxy;
					    u_xlatb0 = greaterThanEqual(u_xlat0, (-u_xlat0.zwzw));
					    u_xlat0.x = (u_xlatb0.x) ? float(2.0) : float(-2.0);
					    u_xlat0.y = (u_xlatb0.y) ? float(2.0) : float(-2.0);
					    u_xlat0.z = (u_xlatb0.z) ? float(0.5) : float(-0.5);
					    u_xlat0.w = (u_xlatb0.w) ? float(0.5) : float(-0.5);
					    u_xlat4.xy = u_xlat0.zw * hlslcc_FragCoord.xy;
					    u_xlat4.xy = fract(u_xlat4.xy);
					    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
					    u_xlati0.xy = ivec2(u_xlat0.xy);
					    u_xlati0.x = u_xlati0.y + u_xlati0.x;
					    u_xlatb0.x = u_xlati0.x==1;
					    u_xlat1 = textureGather(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat2.xy = min(u_xlat1.yw, u_xlat1.xz);
					    u_xlat1.xy = max(u_xlat1.yw, u_xlat1.xz);
					    u_xlat6 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat2.x = min(u_xlat2.y, u_xlat2.x);
					    SV_Target0 = (u_xlatb0.x) ? u_xlat2.x : u_xlat6;
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
			GpuProgramID 389033
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
						vec4 unused_0_0[3];
						vec4 _HalfResDepthBuffer_TexelSize;
						vec4 unused_0_2;
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
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					out vec2 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat4;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xy = (-_HalfResDepthBuffer_TexelSize.xy) * vec2(0.5, 0.5) + in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = u_xlat0.xy;
					    u_xlat4.x = _HalfResDepthBuffer_TexelSize.x;
					    u_xlat4.y = 0.0;
					    vs_TEXCOORD3.xy = u_xlat4.xy + u_xlat0.xy;
					    u_xlat1.x = 0.0;
					    u_xlat1.y = _HalfResDepthBuffer_TexelSize.y;
					    vs_TEXCOORD2.xy = u_xlat0.xy + u_xlat1.xy;
					    vs_TEXCOORD4.xy = u_xlat0.xy + _HalfResDepthBuffer_TexelSize.xy;
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
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _HalfResDepthBuffer_TexelSize;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					out vec2 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat4;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xy = (-_HalfResDepthBuffer_TexelSize.xy) * vec2(0.5, 0.5) + in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = u_xlat0.xy;
					    u_xlat4.x = _HalfResDepthBuffer_TexelSize.x;
					    u_xlat4.y = 0.0;
					    vs_TEXCOORD3.xy = u_xlat4.xy + u_xlat0.xy;
					    u_xlat1.x = 0.0;
					    u_xlat1.y = _HalfResDepthBuffer_TexelSize.y;
					    vs_TEXCOORD2.xy = u_xlat0.xy + u_xlat1.xy;
					    vs_TEXCOORD4.xy = u_xlat0.xy + _HalfResDepthBuffer_TexelSize.xy;
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
					UNITY_LOCATION(0) uniform  sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform  sampler2D _HalfResDepthBuffer;
					UNITY_LOCATION(2) uniform  sampler2D _HalfResColor;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					in  vec2 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat1 = texture(_HalfResDepthBuffer, vs_TEXCOORD1.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat4;
					    u_xlat2 = texture(_HalfResDepthBuffer, vs_TEXCOORD3.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat1.y = float(1.0) / u_xlat4;
					    u_xlat2 = texture(_HalfResDepthBuffer, vs_TEXCOORD2.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat1.z = float(1.0) / u_xlat4;
					    u_xlat2 = texture(_HalfResDepthBuffer, vs_TEXCOORD4.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat1.w = float(1.0) / u_xlat4;
					    u_xlat0 = (-u_xlat0.xxxx) + u_xlat1.zxyw;
					    u_xlat1.x = dot(abs(u_xlat0.yzxw), vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb1 = u_xlat1.x<1.5;
					    if(u_xlatb1){
					        SV_Target0 = texture(_HalfResColor, vs_TEXCOORD0.xy);
					    }
					    if(!u_xlatb1){
					        u_xlatb1 = abs(u_xlat0.z)<abs(u_xlat0.y);
					        u_xlat2.x = abs(u_xlat0.z);
					        u_xlat2.yz = vs_TEXCOORD3.xy;
					        u_xlat3.x = abs(u_xlat0.y);
					        u_xlat3.yz = vs_TEXCOORD1.xy;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat2.xyz : u_xlat3.xyz;
					        u_xlatb13 = abs(u_xlat0.x)<u_xlat1.x;
					        u_xlat0.x = abs(u_xlat0.x);
					        u_xlat0.yz = vs_TEXCOORD2.xy;
					        u_xlat0.xyz = (bool(u_xlatb13)) ? u_xlat0.xyz : u_xlat1.xyz;
					        u_xlatb0 = abs(u_xlat0.w)<u_xlat0.x;
					        u_xlat0.xy = (bool(u_xlatb0)) ? vs_TEXCOORD4.xy : u_xlat0.yz;
					        SV_Target0 = texture(_HalfResColor, u_xlat0.xy);
					    }
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 140
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %9 %11 %37 %51 %61 %67 %75 %124 
					                                                     OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                     OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                     OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                                     OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                     OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
					                                                     OpDecorate vs_TEXCOORD0 Location 9 
					                                                     OpDecorate %11 Location 11 
					                                                     OpDecorate %18 ArrayStride 18 
					                                                     OpDecorate %19 ArrayStride 19 
					                                                     OpMemberDecorate %20 0 Offset 20 
					                                                     OpMemberDecorate %20 1 Offset 20 
					                                                     OpMemberDecorate %20 2 Offset 20 
					                                                     OpDecorate %20 Block 
					                                                     OpDecorate %22 DescriptorSet 22 
					                                                     OpDecorate %22 Binding 22 
					                                                     OpDecorate vs_TEXCOORD1 Location 37 
					                                                     OpDecorate vs_TEXCOORD3 Location 51 
					                                                     OpDecorate vs_TEXCOORD2 Location 61 
					                                                     OpDecorate vs_TEXCOORD4 Location 67 
					                                                     OpDecorate %75 Location 75 
					                                                     OpMemberDecorate %122 0 BuiltIn 122 
					                                                     OpMemberDecorate %122 1 BuiltIn 122 
					                                                     OpMemberDecorate %122 2 BuiltIn 122 
					                                                     OpDecorate %122 Block 
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
					                                             %16 = OpTypeInt 32 0 
					                                         u32 %17 = OpConstant 4 
					                                             %18 = OpTypeArray %13 %17 
					                                             %19 = OpTypeArray %13 %17 
					                                             %20 = OpTypeStruct %18 %19 %13 
					                                             %21 = OpTypePointer Uniform %20 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %22 = OpVariable Uniform 
					                                             %23 = OpTypeInt 32 1 
					                                         i32 %24 = OpConstant 2 
					                                             %25 = OpTypePointer Uniform %13 
					                                         f32 %30 = OpConstant 3,674022E-40 
					                                       f32_2 %31 = OpConstantComposite %30 %30 
					                      Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                             %40 = OpTypePointer Private %7 
					                              Private f32_2* %41 = OpVariable Private 
					                                         u32 %42 = OpConstant 0 
					                                             %43 = OpTypePointer Uniform %6 
					                                             %46 = OpTypePointer Private %6 
					                                         f32 %48 = OpConstant 3,674022E-40 
					                                         u32 %49 = OpConstant 1 
					                      Output f32_2* vs_TEXCOORD3 = OpVariable Output 
					                              Private f32_4* %56 = OpVariable Private 
					                      Output f32_2* vs_TEXCOORD2 = OpVariable Output 
					                      Output f32_2* vs_TEXCOORD4 = OpVariable Output 
					                                             %74 = OpTypePointer Input %13 
					                                Input f32_4* %75 = OpVariable Input 
					                                         i32 %78 = OpConstant 0 
					                                         i32 %79 = OpConstant 1 
					                                         i32 %98 = OpConstant 3 
					                                            %121 = OpTypeArray %6 %49 
					                                            %122 = OpTypeStruct %13 %6 %121 
					                                            %123 = OpTypePointer Output %122 
					       Output struct {f32_4; f32; f32[1];}* %124 = OpVariable Output 
					                                            %132 = OpTypePointer Output %13 
					                                            %134 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                                       f32_2 %12 = OpLoad %11 
					                                                     OpStore vs_TEXCOORD0 %12 
					                              Uniform f32_4* %26 = OpAccessChain %22 %24 
					                                       f32_4 %27 = OpLoad %26 
					                                       f32_2 %28 = OpVectorShuffle %27 %27 0 1 
					                                       f32_2 %29 = OpFNegate %28 
					                                       f32_2 %32 = OpFMul %29 %31 
					                                       f32_2 %33 = OpLoad %11 
					                                       f32_2 %34 = OpFAdd %32 %33 
					                                       f32_4 %35 = OpLoad %15 
					                                       f32_4 %36 = OpVectorShuffle %35 %34 4 5 2 3 
					                                                     OpStore %15 %36 
					                                       f32_4 %38 = OpLoad %15 
					                                       f32_2 %39 = OpVectorShuffle %38 %38 0 1 
					                                                     OpStore vs_TEXCOORD1 %39 
					                                Uniform f32* %44 = OpAccessChain %22 %24 %42 
					                                         f32 %45 = OpLoad %44 
					                                Private f32* %47 = OpAccessChain %41 %42 
					                                                     OpStore %47 %45 
					                                Private f32* %50 = OpAccessChain %41 %49 
					                                                     OpStore %50 %48 
					                                       f32_2 %52 = OpLoad %41 
					                                       f32_4 %53 = OpLoad %15 
					                                       f32_2 %54 = OpVectorShuffle %53 %53 0 1 
					                                       f32_2 %55 = OpFAdd %52 %54 
					                                                     OpStore vs_TEXCOORD3 %55 
					                                Private f32* %57 = OpAccessChain %56 %42 
					                                                     OpStore %57 %48 
					                                Uniform f32* %58 = OpAccessChain %22 %24 %49 
					                                         f32 %59 = OpLoad %58 
					                                Private f32* %60 = OpAccessChain %56 %49 
					                                                     OpStore %60 %59 
					                                       f32_4 %62 = OpLoad %15 
					                                       f32_2 %63 = OpVectorShuffle %62 %62 0 1 
					                                       f32_4 %64 = OpLoad %56 
					                                       f32_2 %65 = OpVectorShuffle %64 %64 0 1 
					                                       f32_2 %66 = OpFAdd %63 %65 
					                                                     OpStore vs_TEXCOORD2 %66 
					                                       f32_4 %68 = OpLoad %15 
					                                       f32_2 %69 = OpVectorShuffle %68 %68 0 1 
					                              Uniform f32_4* %70 = OpAccessChain %22 %24 
					                                       f32_4 %71 = OpLoad %70 
					                                       f32_2 %72 = OpVectorShuffle %71 %71 0 1 
					                                       f32_2 %73 = OpFAdd %69 %72 
					                                                     OpStore vs_TEXCOORD4 %73 
					                                       f32_4 %76 = OpLoad %75 
					                                       f32_4 %77 = OpVectorShuffle %76 %76 1 1 1 1 
					                              Uniform f32_4* %80 = OpAccessChain %22 %78 %79 
					                                       f32_4 %81 = OpLoad %80 
					                                       f32_4 %82 = OpFMul %77 %81 
					                                                     OpStore %15 %82 
					                              Uniform f32_4* %83 = OpAccessChain %22 %78 %78 
					                                       f32_4 %84 = OpLoad %83 
					                                       f32_4 %85 = OpLoad %75 
					                                       f32_4 %86 = OpVectorShuffle %85 %85 0 0 0 0 
					                                       f32_4 %87 = OpFMul %84 %86 
					                                       f32_4 %88 = OpLoad %15 
					                                       f32_4 %89 = OpFAdd %87 %88 
					                                                     OpStore %15 %89 
					                              Uniform f32_4* %90 = OpAccessChain %22 %78 %24 
					                                       f32_4 %91 = OpLoad %90 
					                                       f32_4 %92 = OpLoad %75 
					                                       f32_4 %93 = OpVectorShuffle %92 %92 2 2 2 2 
					                                       f32_4 %94 = OpFMul %91 %93 
					                                       f32_4 %95 = OpLoad %15 
					                                       f32_4 %96 = OpFAdd %94 %95 
					                                                     OpStore %15 %96 
					                                       f32_4 %97 = OpLoad %15 
					                              Uniform f32_4* %99 = OpAccessChain %22 %78 %98 
					                                      f32_4 %100 = OpLoad %99 
					                                      f32_4 %101 = OpFAdd %97 %100 
					                                                     OpStore %15 %101 
					                                      f32_4 %102 = OpLoad %15 
					                                      f32_4 %103 = OpVectorShuffle %102 %102 1 1 1 1 
					                             Uniform f32_4* %104 = OpAccessChain %22 %79 %79 
					                                      f32_4 %105 = OpLoad %104 
					                                      f32_4 %106 = OpFMul %103 %105 
					                                                     OpStore %56 %106 
					                             Uniform f32_4* %107 = OpAccessChain %22 %79 %78 
					                                      f32_4 %108 = OpLoad %107 
					                                      f32_4 %109 = OpLoad %15 
					                                      f32_4 %110 = OpVectorShuffle %109 %109 0 0 0 0 
					                                      f32_4 %111 = OpFMul %108 %110 
					                                      f32_4 %112 = OpLoad %56 
					                                      f32_4 %113 = OpFAdd %111 %112 
					                                                     OpStore %56 %113 
					                             Uniform f32_4* %114 = OpAccessChain %22 %79 %24 
					                                      f32_4 %115 = OpLoad %114 
					                                      f32_4 %116 = OpLoad %15 
					                                      f32_4 %117 = OpVectorShuffle %116 %116 2 2 2 2 
					                                      f32_4 %118 = OpFMul %115 %117 
					                                      f32_4 %119 = OpLoad %56 
					                                      f32_4 %120 = OpFAdd %118 %119 
					                                                     OpStore %56 %120 
					                             Uniform f32_4* %125 = OpAccessChain %22 %79 %98 
					                                      f32_4 %126 = OpLoad %125 
					                                      f32_4 %127 = OpLoad %15 
					                                      f32_4 %128 = OpVectorShuffle %127 %127 3 3 3 3 
					                                      f32_4 %129 = OpFMul %126 %128 
					                                      f32_4 %130 = OpLoad %56 
					                                      f32_4 %131 = OpFAdd %129 %130 
					                              Output f32_4* %133 = OpAccessChain %124 %78 
					                                                     OpStore %133 %131 
					                                Output f32* %135 = OpAccessChain %124 %78 %49 
					                                        f32 %136 = OpLoad %135 
					                                        f32 %137 = OpFNegate %136 
					                                Output f32* %138 = OpAccessChain %124 %78 %49 
					                                                     OpStore %138 %137 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 247
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %22 %57 %75 %93 %110 %147 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                              OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                              OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
					                                              OpDecorate %12 DescriptorSet 12 
					                                              OpDecorate %12 Binding 12 
					                                              OpDecorate %16 DescriptorSet 16 
					                                              OpDecorate %16 Binding 16 
					                                              OpDecorate vs_TEXCOORD0 Location 22 
					                                              OpMemberDecorate %30 0 Offset 30 
					                                              OpDecorate %30 Block 
					                                              OpDecorate %32 DescriptorSet 32 
					                                              OpDecorate %32 Binding 32 
					                                              OpDecorate %53 DescriptorSet 53 
					                                              OpDecorate %53 Binding 53 
					                                              OpDecorate vs_TEXCOORD1 Location 57 
					                                              OpDecorate vs_TEXCOORD3 Location 75 
					                                              OpDecorate vs_TEXCOORD2 Location 93 
					                                              OpDecorate vs_TEXCOORD4 Location 110 
					                                              OpDecorate %147 Location 147 
					                                              OpDecorate %148 DescriptorSet 148 
					                                              OpDecorate %148 Binding 148 
					                                              OpDecorate %150 DescriptorSet 150 
					                                              OpDecorate %150 Binding 150 
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
					                                      %25 = OpTypeInt 32 0 
					                                  u32 %26 = OpConstant 0 
					                                      %28 = OpTypePointer Private %6 
					                                      %30 = OpTypeStruct %7 
					                                      %31 = OpTypePointer Uniform %30 
					             Uniform struct {f32_4;}* %32 = OpVariable Uniform 
					                                      %33 = OpTypeInt 32 1 
					                                  i32 %34 = OpConstant 0 
					                                  u32 %35 = OpConstant 2 
					                                      %36 = OpTypePointer Uniform %6 
					                                  u32 %42 = OpConstant 3 
					                                  f32 %47 = OpConstant 3,674022E-40 
					                         Private f32* %52 = OpVariable Private 
					 UniformConstant read_only Texture2D* %53 = OpVariable UniformConstant 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                       Private f32_4* %68 = OpVariable Private 
					                Input f32_2* vs_TEXCOORD3 = OpVariable Input 
					                                  u32 %88 = OpConstant 1 
					                Input f32_2* vs_TEXCOORD2 = OpVariable Input 
					                Input f32_2* vs_TEXCOORD4 = OpVariable Input 
					                               f32_4 %133 = OpConstantComposite %47 %47 %47 %47 
					                                     %136 = OpTypeBool 
					                                     %137 = OpTypePointer Private %136 
					                       Private bool* %138 = OpVariable Private 
					                                 f32 %141 = OpConstant 3,674022E-40 
					                                     %146 = OpTypePointer Output %7 
					                       Output f32_4* %147 = OpVariable Output 
					UniformConstant read_only Texture2D* %148 = OpVariable UniformConstant 
					            UniformConstant sampler* %150 = OpVariable UniformConstant 
					                                     %166 = OpTypeVector %6 3 
					                                     %167 = OpTypePointer Private %166 
					                      Private f32_3* %168 = OpVariable Private 
					                      Private f32_3* %176 = OpVariable Private 
					                                     %185 = OpTypePointer Function %166 
					                       Private bool* %195 = OpVariable Private 
					                       Private bool* %221 = OpVariable Private 
					                                     %229 = OpTypePointer Function %20 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                     Function f32_3* %186 = OpVariable Function 
					                     Function f32_3* %210 = OpVariable Function 
					                     Function f32_2* %230 = OpVariable Function 
					                  read_only Texture2D %13 = OpLoad %12 
					                              sampler %17 = OpLoad %16 
					           read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                f32_2 %23 = OpLoad vs_TEXCOORD0 
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
					                  read_only Texture2D %54 = OpLoad %53 
					                              sampler %55 = OpLoad %16 
					           read_only Texture2DSampled %56 = OpSampledImage %54 %55 
					                                f32_2 %58 = OpLoad vs_TEXCOORD1 
					                                f32_4 %59 = OpImageSampleImplicitLod %56 %58 
					                                  f32 %60 = OpCompositeExtract %59 0 
					                                              OpStore %52 %60 
					                         Uniform f32* %61 = OpAccessChain %32 %34 %35 
					                                  f32 %62 = OpLoad %61 
					                                  f32 %63 = OpLoad %52 
					                                  f32 %64 = OpFMul %62 %63 
					                         Uniform f32* %65 = OpAccessChain %32 %34 %42 
					                                  f32 %66 = OpLoad %65 
					                                  f32 %67 = OpFAdd %64 %66 
					                                              OpStore %52 %67 
					                                  f32 %69 = OpLoad %52 
					                                  f32 %70 = OpFDiv %47 %69 
					                         Private f32* %71 = OpAccessChain %68 %26 
					                                              OpStore %71 %70 
					                  read_only Texture2D %72 = OpLoad %53 
					                              sampler %73 = OpLoad %16 
					           read_only Texture2DSampled %74 = OpSampledImage %72 %73 
					                                f32_2 %76 = OpLoad vs_TEXCOORD3 
					                                f32_4 %77 = OpImageSampleImplicitLod %74 %76 
					                                  f32 %78 = OpCompositeExtract %77 0 
					                                              OpStore %52 %78 
					                         Uniform f32* %79 = OpAccessChain %32 %34 %35 
					                                  f32 %80 = OpLoad %79 
					                                  f32 %81 = OpLoad %52 
					                                  f32 %82 = OpFMul %80 %81 
					                         Uniform f32* %83 = OpAccessChain %32 %34 %42 
					                                  f32 %84 = OpLoad %83 
					                                  f32 %85 = OpFAdd %82 %84 
					                                              OpStore %52 %85 
					                                  f32 %86 = OpLoad %52 
					                                  f32 %87 = OpFDiv %47 %86 
					                         Private f32* %89 = OpAccessChain %68 %88 
					                                              OpStore %89 %87 
					                  read_only Texture2D %90 = OpLoad %53 
					                              sampler %91 = OpLoad %16 
					           read_only Texture2DSampled %92 = OpSampledImage %90 %91 
					                                f32_2 %94 = OpLoad vs_TEXCOORD2 
					                                f32_4 %95 = OpImageSampleImplicitLod %92 %94 
					                                  f32 %96 = OpCompositeExtract %95 0 
					                                              OpStore %52 %96 
					                         Uniform f32* %97 = OpAccessChain %32 %34 %35 
					                                  f32 %98 = OpLoad %97 
					                                  f32 %99 = OpLoad %52 
					                                 f32 %100 = OpFMul %98 %99 
					                        Uniform f32* %101 = OpAccessChain %32 %34 %42 
					                                 f32 %102 = OpLoad %101 
					                                 f32 %103 = OpFAdd %100 %102 
					                                              OpStore %52 %103 
					                                 f32 %104 = OpLoad %52 
					                                 f32 %105 = OpFDiv %47 %104 
					                        Private f32* %106 = OpAccessChain %68 %35 
					                                              OpStore %106 %105 
					                 read_only Texture2D %107 = OpLoad %53 
					                             sampler %108 = OpLoad %16 
					          read_only Texture2DSampled %109 = OpSampledImage %107 %108 
					                               f32_2 %111 = OpLoad vs_TEXCOORD4 
					                               f32_4 %112 = OpImageSampleImplicitLod %109 %111 
					                                 f32 %113 = OpCompositeExtract %112 0 
					                                              OpStore %52 %113 
					                        Uniform f32* %114 = OpAccessChain %32 %34 %35 
					                                 f32 %115 = OpLoad %114 
					                                 f32 %116 = OpLoad %52 
					                                 f32 %117 = OpFMul %115 %116 
					                        Uniform f32* %118 = OpAccessChain %32 %34 %42 
					                                 f32 %119 = OpLoad %118 
					                                 f32 %120 = OpFAdd %117 %119 
					                                              OpStore %52 %120 
					                                 f32 %121 = OpLoad %52 
					                                 f32 %122 = OpFDiv %47 %121 
					                        Private f32* %123 = OpAccessChain %68 %42 
					                                              OpStore %123 %122 
					                               f32_4 %124 = OpLoad %9 
					                               f32_4 %125 = OpVectorShuffle %124 %124 0 0 0 0 
					                               f32_4 %126 = OpFNegate %125 
					                               f32_4 %127 = OpLoad %68 
					                               f32_4 %128 = OpVectorShuffle %127 %127 2 0 1 3 
					                               f32_4 %129 = OpFAdd %126 %128 
					                                              OpStore %9 %129 
					                               f32_4 %130 = OpLoad %9 
					                               f32_4 %131 = OpVectorShuffle %130 %130 1 2 0 3 
					                               f32_4 %132 = OpExtInst %1 4 %131 
					                                 f32 %134 = OpDot %132 %133 
					                        Private f32* %135 = OpAccessChain %68 %26 
					                                              OpStore %135 %134 
					                        Private f32* %139 = OpAccessChain %68 %26 
					                                 f32 %140 = OpLoad %139 
					                                bool %142 = OpFOrdLessThan %140 %141 
					                                              OpStore %138 %142 
					                                bool %143 = OpLoad %138 
					                                              OpSelectionMerge %145 None 
					                                              OpBranchConditional %143 %144 %145 
					                                     %144 = OpLabel 
					                 read_only Texture2D %149 = OpLoad %148 
					                             sampler %151 = OpLoad %150 
					          read_only Texture2DSampled %152 = OpSampledImage %149 %151 
					                               f32_2 %153 = OpLoad vs_TEXCOORD0 
					                               f32_4 %154 = OpImageSampleImplicitLod %152 %153 
					                                              OpStore %147 %154 
					                                              OpBranch %145 
					                                     %145 = OpLabel 
					                                bool %155 = OpLoad %138 
					                                bool %156 = OpLogicalNot %155 
					                                              OpSelectionMerge %158 None 
					                                              OpBranchConditional %156 %157 %158 
					                                     %157 = OpLabel 
					                        Private f32* %159 = OpAccessChain %9 %35 
					                                 f32 %160 = OpLoad %159 
					                                 f32 %161 = OpExtInst %1 4 %160 
					                        Private f32* %162 = OpAccessChain %9 %88 
					                                 f32 %163 = OpLoad %162 
					                                 f32 %164 = OpExtInst %1 4 %163 
					                                bool %165 = OpFOrdLessThan %161 %164 
					                                              OpStore %138 %165 
					                        Private f32* %169 = OpAccessChain %9 %35 
					                                 f32 %170 = OpLoad %169 
					                                 f32 %171 = OpExtInst %1 4 %170 
					                        Private f32* %172 = OpAccessChain %168 %26 
					                                              OpStore %172 %171 
					                               f32_2 %173 = OpLoad vs_TEXCOORD3 
					                               f32_3 %174 = OpLoad %168 
					                               f32_3 %175 = OpVectorShuffle %174 %173 0 3 4 
					                                              OpStore %168 %175 
					                        Private f32* %177 = OpAccessChain %9 %88 
					                                 f32 %178 = OpLoad %177 
					                                 f32 %179 = OpExtInst %1 4 %178 
					                        Private f32* %180 = OpAccessChain %176 %26 
					                                              OpStore %180 %179 
					                               f32_2 %181 = OpLoad vs_TEXCOORD1 
					                               f32_3 %182 = OpLoad %176 
					                               f32_3 %183 = OpVectorShuffle %182 %181 0 3 4 
					                                              OpStore %176 %183 
					                                bool %184 = OpLoad %138 
					                                              OpSelectionMerge %188 None 
					                                              OpBranchConditional %184 %187 %190 
					                                     %187 = OpLabel 
					                               f32_3 %189 = OpLoad %168 
					                                              OpStore %186 %189 
					                                              OpBranch %188 
					                                     %190 = OpLabel 
					                               f32_3 %191 = OpLoad %176 
					                                              OpStore %186 %191 
					                                              OpBranch %188 
					                                     %188 = OpLabel 
					                               f32_3 %192 = OpLoad %186 
					                               f32_4 %193 = OpLoad %68 
					                               f32_4 %194 = OpVectorShuffle %193 %192 4 5 6 3 
					                                              OpStore %68 %194 
					                        Private f32* %196 = OpAccessChain %9 %26 
					                                 f32 %197 = OpLoad %196 
					                                 f32 %198 = OpExtInst %1 4 %197 
					                        Private f32* %199 = OpAccessChain %68 %26 
					                                 f32 %200 = OpLoad %199 
					                                bool %201 = OpFOrdLessThan %198 %200 
					                                              OpStore %195 %201 
					                        Private f32* %202 = OpAccessChain %9 %26 
					                                 f32 %203 = OpLoad %202 
					                                 f32 %204 = OpExtInst %1 4 %203 
					                        Private f32* %205 = OpAccessChain %9 %26 
					                                              OpStore %205 %204 
					                               f32_2 %206 = OpLoad vs_TEXCOORD2 
					                               f32_4 %207 = OpLoad %9 
					                               f32_4 %208 = OpVectorShuffle %207 %206 0 4 5 3 
					                                              OpStore %9 %208 
					                                bool %209 = OpLoad %195 
					                                              OpSelectionMerge %212 None 
					                                              OpBranchConditional %209 %211 %215 
					                                     %211 = OpLabel 
					                               f32_4 %213 = OpLoad %9 
					                               f32_3 %214 = OpVectorShuffle %213 %213 0 1 2 
					                                              OpStore %210 %214 
					                                              OpBranch %212 
					                                     %215 = OpLabel 
					                               f32_4 %216 = OpLoad %68 
					                               f32_3 %217 = OpVectorShuffle %216 %216 0 1 2 
					                                              OpStore %210 %217 
					                                              OpBranch %212 
					                                     %212 = OpLabel 
					                               f32_3 %218 = OpLoad %210 
					                               f32_4 %219 = OpLoad %9 
					                               f32_4 %220 = OpVectorShuffle %219 %218 4 5 6 3 
					                                              OpStore %9 %220 
					                        Private f32* %222 = OpAccessChain %9 %42 
					                                 f32 %223 = OpLoad %222 
					                                 f32 %224 = OpExtInst %1 4 %223 
					                        Private f32* %225 = OpAccessChain %9 %26 
					                                 f32 %226 = OpLoad %225 
					                                bool %227 = OpFOrdLessThan %224 %226 
					                                              OpStore %221 %227 
					                                bool %228 = OpLoad %221 
					                                              OpSelectionMerge %232 None 
					                                              OpBranchConditional %228 %231 %234 
					                                     %231 = OpLabel 
					                               f32_2 %233 = OpLoad vs_TEXCOORD4 
					                                              OpStore %230 %233 
					                                              OpBranch %232 
					                                     %234 = OpLabel 
					                               f32_4 %235 = OpLoad %9 
					                               f32_2 %236 = OpVectorShuffle %235 %235 1 2 
					                                              OpStore %230 %236 
					                                              OpBranch %232 
					                                     %232 = OpLabel 
					                               f32_2 %237 = OpLoad %230 
					                               f32_4 %238 = OpLoad %9 
					                               f32_4 %239 = OpVectorShuffle %238 %237 4 5 2 3 
					                                              OpStore %9 %239 
					                 read_only Texture2D %240 = OpLoad %148 
					                             sampler %241 = OpLoad %16 
					          read_only Texture2DSampled %242 = OpSampledImage %240 %241 
					                               f32_4 %243 = OpLoad %9 
					                               f32_2 %244 = OpVectorShuffle %243 %243 0 1 
					                               f32_4 %245 = OpImageSampleImplicitLod %242 %244 
					                                              OpStore %147 %245 
					                                              OpBranch %158 
					                                     %158 = OpLabel 
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[7];
						vec4 _ZBufferParams;
						vec4 unused_0_2;
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _HalfResDepthBuffer;
					uniform  sampler2D _HalfResColor;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					in  vec2 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat1 = texture(_HalfResDepthBuffer, vs_TEXCOORD1.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat4;
					    u_xlat2 = texture(_HalfResDepthBuffer, vs_TEXCOORD3.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat1.y = float(1.0) / u_xlat4;
					    u_xlat2 = texture(_HalfResDepthBuffer, vs_TEXCOORD2.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat1.z = float(1.0) / u_xlat4;
					    u_xlat2 = texture(_HalfResDepthBuffer, vs_TEXCOORD4.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat1.w = float(1.0) / u_xlat4;
					    u_xlat0 = (-u_xlat0.xxxx) + u_xlat1.zxyw;
					    u_xlat1.x = dot(abs(u_xlat0.yzxw), vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb1 = u_xlat1.x<1.5;
					    if(u_xlatb1){
					        SV_Target0 = texture(_HalfResColor, vs_TEXCOORD0.xy);
					    }
					    if(!u_xlatb1){
					        u_xlatb1 = abs(u_xlat0.z)<abs(u_xlat0.y);
					        u_xlat2.x = abs(u_xlat0.z);
					        u_xlat2.yz = vs_TEXCOORD3.xy;
					        u_xlat3.x = abs(u_xlat0.y);
					        u_xlat3.yz = vs_TEXCOORD1.xy;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat2.xyz : u_xlat3.xyz;
					        u_xlatb13 = abs(u_xlat0.x)<u_xlat1.x;
					        u_xlat0.x = abs(u_xlat0.x);
					        u_xlat0.yz = vs_TEXCOORD2.xy;
					        u_xlat0.xyz = (bool(u_xlatb13)) ? u_xlat0.xyz : u_xlat1.xyz;
					        u_xlatb0 = abs(u_xlat0.w)<u_xlat0.x;
					        u_xlat0.xy = (bool(u_xlatb0)) ? vs_TEXCOORD4.xy : u_xlat0.yz;
					        SV_Target0 = texture(_HalfResColor, u_xlat0.xy);
					    }
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
			GpuProgramID 431233
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
					UNITY_BINDING(0) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					UNITY_BINDING(1) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
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
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_texture_gather
					#extension GL_ARB_texture_gather : enable
					#endif
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform  sampler2D _HalfResDepthBuffer;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out float SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					vec2 u_xlat4;
					float u_xlat6;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0 = hlslcc_FragCoord.xyxy + hlslcc_FragCoord.xyxy;
					    u_xlatb0 = greaterThanEqual(u_xlat0, (-u_xlat0.zwzw));
					    u_xlat0.x = (u_xlatb0.x) ? float(2.0) : float(-2.0);
					    u_xlat0.y = (u_xlatb0.y) ? float(2.0) : float(-2.0);
					    u_xlat0.z = (u_xlatb0.z) ? float(0.5) : float(-0.5);
					    u_xlat0.w = (u_xlatb0.w) ? float(0.5) : float(-0.5);
					    u_xlat4.xy = u_xlat0.zw * hlslcc_FragCoord.xy;
					    u_xlat4.xy = fract(u_xlat4.xy);
					    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
					    u_xlati0.xy = ivec2(u_xlat0.xy);
					    u_xlati0.x = u_xlati0.y + u_xlati0.x;
					    u_xlatb0.x = u_xlati0.x==1;
					    u_xlat1 = textureGather(_HalfResDepthBuffer, vs_TEXCOORD0.xy);
					    u_xlat2.xy = min(u_xlat1.yw, u_xlat1.xz);
					    u_xlat1.xy = max(u_xlat1.yw, u_xlat1.xz);
					    u_xlat6 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat2.x = min(u_xlat2.y, u_xlat2.x);
					    SV_Target0 = (u_xlatb0.x) ? u_xlat2.x : u_xlat6;
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
					; Bound: 157
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %11 %114 %144 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpDecorate %11 BuiltIn TessLevelOuter 
					                                              OpDecorate %105 DescriptorSet 105 
					                                              OpDecorate %105 Binding 105 
					                                              OpDecorate %109 DescriptorSet 109 
					                                              OpDecorate %109 Binding 109 
					                                              OpDecorate vs_TEXCOORD0 Location 114 
					                                              OpDecorate %144 Location 144 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 4 
					                                       %8 = OpTypePointer Function %7 
					                                      %10 = OpTypePointer Input %7 
					                         Input f32_4* %11 = OpVariable Input 
					                                      %12 = OpTypeVector %6 3 
					                                  f32 %15 = OpConstant 3,674022E-40 
					                                      %16 = OpTypeInt 32 0 
					                                  u32 %17 = OpConstant 3 
					                                      %18 = OpTypePointer Input %6 
					                                      %26 = OpTypePointer Private %7 
					                       Private f32_4* %27 = OpVariable Private 
					                                      %33 = OpTypeBool 
					                                      %34 = OpTypeVector %33 4 
					                                      %35 = OpTypePointer Private %34 
					                      Private bool_4* %36 = OpVariable Private 
					                                  u32 %42 = OpConstant 0 
					                                      %43 = OpTypePointer Private %33 
					                                  f32 %46 = OpConstant 3,674022E-40 
					                                  f32 %47 = OpConstant 3,674022E-40 
					                                      %49 = OpTypePointer Private %6 
					                                  u32 %51 = OpConstant 1 
					                                  u32 %56 = OpConstant 2 
					                                  f32 %59 = OpConstant 3,674022E-40 
					                                  f32 %60 = OpConstant 3,674022E-40 
					                                      %67 = OpTypeVector %6 2 
					                                      %68 = OpTypePointer Private %67 
					                       Private f32_2* %69 = OpVariable Private 
					                                      %83 = OpTypeInt 32 1 
					                                      %84 = OpTypeVector %83 2 
					                                      %85 = OpTypePointer Private %84 
					                       Private i32_2* %86 = OpVariable Private 
					                                      %90 = OpTypePointer Private %83 
					                                  i32 %99 = OpConstant 1 
					                      Private f32_4* %102 = OpVariable Private 
					                                     %103 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %104 = OpTypePointer UniformConstant %103 
					UniformConstant read_only Texture2D* %105 = OpVariable UniformConstant 
					                                     %107 = OpTypeSampler 
					                                     %108 = OpTypePointer UniformConstant %107 
					            UniformConstant sampler* %109 = OpVariable UniformConstant 
					                                     %111 = OpTypeSampledImage %103 
					                                     %113 = OpTypePointer Input %67 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 i32 %116 = OpConstant 0 
					                      Private f32_2* %118 = OpVariable Private 
					                        Private f32* %131 = OpVariable Private 
					                                     %143 = OpTypePointer Output %6 
					                         Output f32* %144 = OpVariable Output 
					                                     %147 = OpTypePointer Function %6 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                       Function f32_4* %9 = OpVariable Function 
					                       Function f32* %148 = OpVariable Function 
					                                f32_4 %13 = OpLoad %11 
					                                f32_3 %14 = OpVectorShuffle %13 %13 0 1 2 
					                           Input f32* %19 = OpAccessChain %11 %17 
					                                  f32 %20 = OpLoad %19 
					                                  f32 %21 = OpFDiv %15 %20 
					                                  f32 %22 = OpCompositeExtract %14 0 
					                                  f32 %23 = OpCompositeExtract %14 1 
					                                  f32 %24 = OpCompositeExtract %14 2 
					                                f32_4 %25 = OpCompositeConstruct %22 %23 %24 %21 
					                                              OpStore %9 %25 
					                                f32_4 %28 = OpLoad %9 
					                                f32_4 %29 = OpVectorShuffle %28 %28 0 1 0 1 
					                                f32_4 %30 = OpLoad %9 
					                                f32_4 %31 = OpVectorShuffle %30 %30 0 1 0 1 
					                                f32_4 %32 = OpFAdd %29 %31 
					                                              OpStore %27 %32 
					                                f32_4 %37 = OpLoad %27 
					                                f32_4 %38 = OpLoad %27 
					                                f32_4 %39 = OpVectorShuffle %38 %38 2 3 2 3 
					                                f32_4 %40 = OpFNegate %39 
					                               bool_4 %41 = OpFOrdGreaterThanEqual %37 %40 
					                                              OpStore %36 %41 
					                        Private bool* %44 = OpAccessChain %36 %42 
					                                 bool %45 = OpLoad %44 
					                                  f32 %48 = OpSelect %45 %46 %47 
					                         Private f32* %50 = OpAccessChain %27 %42 
					                                              OpStore %50 %48 
					                        Private bool* %52 = OpAccessChain %36 %51 
					                                 bool %53 = OpLoad %52 
					                                  f32 %54 = OpSelect %53 %46 %47 
					                         Private f32* %55 = OpAccessChain %27 %51 
					                                              OpStore %55 %54 
					                        Private bool* %57 = OpAccessChain %36 %56 
					                                 bool %58 = OpLoad %57 
					                                  f32 %61 = OpSelect %58 %59 %60 
					                         Private f32* %62 = OpAccessChain %27 %56 
					                                              OpStore %62 %61 
					                        Private bool* %63 = OpAccessChain %36 %17 
					                                 bool %64 = OpLoad %63 
					                                  f32 %65 = OpSelect %64 %59 %60 
					                         Private f32* %66 = OpAccessChain %27 %17 
					                                              OpStore %66 %65 
					                                f32_4 %70 = OpLoad %27 
					                                f32_2 %71 = OpVectorShuffle %70 %70 2 3 
					                                f32_4 %72 = OpLoad %9 
					                                f32_2 %73 = OpVectorShuffle %72 %72 0 1 
					                                f32_2 %74 = OpFMul %71 %73 
					                                              OpStore %69 %74 
					                                f32_2 %75 = OpLoad %69 
					                                f32_2 %76 = OpExtInst %1 10 %75 
					                                              OpStore %69 %76 
					                                f32_2 %77 = OpLoad %69 
					                                f32_4 %78 = OpLoad %27 
					                                f32_2 %79 = OpVectorShuffle %78 %78 0 1 
					                                f32_2 %80 = OpFMul %77 %79 
					                                f32_4 %81 = OpLoad %27 
					                                f32_4 %82 = OpVectorShuffle %81 %80 4 5 2 3 
					                                              OpStore %27 %82 
					                                f32_4 %87 = OpLoad %27 
					                                f32_2 %88 = OpVectorShuffle %87 %87 0 1 
					                                i32_2 %89 = OpConvertFToS %88 
					                                              OpStore %86 %89 
					                         Private i32* %91 = OpAccessChain %86 %51 
					                                  i32 %92 = OpLoad %91 
					                         Private i32* %93 = OpAccessChain %86 %42 
					                                  i32 %94 = OpLoad %93 
					                                  i32 %95 = OpIAdd %92 %94 
					                         Private i32* %96 = OpAccessChain %86 %42 
					                                              OpStore %96 %95 
					                         Private i32* %97 = OpAccessChain %86 %42 
					                                  i32 %98 = OpLoad %97 
					                                bool %100 = OpIEqual %98 %99 
					                       Private bool* %101 = OpAccessChain %36 %42 
					                                              OpStore %101 %100 
					                 read_only Texture2D %106 = OpLoad %105 
					                             sampler %110 = OpLoad %109 
					          read_only Texture2DSampled %112 = OpSampledImage %106 %110 
					                               f32_2 %115 = OpLoad vs_TEXCOORD0 
					                               f32_4 %117 = OpImageGather %112 %115 %116 
					                                              OpStore %102 %117 
					                               f32_4 %119 = OpLoad %102 
					                               f32_2 %120 = OpVectorShuffle %119 %119 1 3 
					                               f32_4 %121 = OpLoad %102 
					                               f32_2 %122 = OpVectorShuffle %121 %121 0 2 
					                               f32_2 %123 = OpExtInst %1 37 %120 %122 
					                                              OpStore %118 %123 
					                               f32_4 %124 = OpLoad %102 
					                               f32_2 %125 = OpVectorShuffle %124 %124 1 3 
					                               f32_4 %126 = OpLoad %102 
					                               f32_2 %127 = OpVectorShuffle %126 %126 0 2 
					                               f32_2 %128 = OpExtInst %1 40 %125 %127 
					                               f32_4 %129 = OpLoad %102 
					                               f32_4 %130 = OpVectorShuffle %129 %128 4 5 2 3 
					                                              OpStore %102 %130 
					                        Private f32* %132 = OpAccessChain %102 %51 
					                                 f32 %133 = OpLoad %132 
					                        Private f32* %134 = OpAccessChain %102 %42 
					                                 f32 %135 = OpLoad %134 
					                                 f32 %136 = OpExtInst %1 40 %133 %135 
					                                              OpStore %131 %136 
					                        Private f32* %137 = OpAccessChain %118 %51 
					                                 f32 %138 = OpLoad %137 
					                        Private f32* %139 = OpAccessChain %118 %42 
					                                 f32 %140 = OpLoad %139 
					                                 f32 %141 = OpExtInst %1 37 %138 %140 
					                        Private f32* %142 = OpAccessChain %118 %42 
					                                              OpStore %142 %141 
					                       Private bool* %145 = OpAccessChain %36 %42 
					                                bool %146 = OpLoad %145 
					                                              OpSelectionMerge %150 None 
					                                              OpBranchConditional %146 %149 %153 
					                                     %149 = OpLabel 
					                        Private f32* %151 = OpAccessChain %118 %42 
					                                 f32 %152 = OpLoad %151 
					                                              OpStore %148 %152 
					                                              OpBranch %150 
					                                     %153 = OpLabel 
					                                 f32 %154 = OpLoad %131 
					                                              OpStore %148 %154 
					                                              OpBranch %150 
					                                     %150 = OpLabel 
					                                 f32 %155 = OpLoad %148 
					                                              OpStore %144 %155 
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
					UNITY_LOCATION(0) uniform  sampler2D _HalfResDepthBuffer;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out float SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					vec2 u_xlat4;
					float u_xlat6;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0 = hlslcc_FragCoord.xyxy + hlslcc_FragCoord.xyxy;
					    u_xlatb0 = greaterThanEqual(u_xlat0, (-u_xlat0.zwzw));
					    u_xlat0.x = (u_xlatb0.x) ? float(2.0) : float(-2.0);
					    u_xlat0.y = (u_xlatb0.y) ? float(2.0) : float(-2.0);
					    u_xlat0.z = (u_xlatb0.z) ? float(0.5) : float(-0.5);
					    u_xlat0.w = (u_xlatb0.w) ? float(0.5) : float(-0.5);
					    u_xlat4.xy = u_xlat0.zw * hlslcc_FragCoord.xy;
					    u_xlat4.xy = fract(u_xlat4.xy);
					    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
					    u_xlati0.xy = ivec2(u_xlat0.xy);
					    u_xlati0.x = u_xlati0.y + u_xlati0.x;
					    u_xlatb0.x = u_xlati0.x==1;
					    u_xlat1 = textureGather(_HalfResDepthBuffer, vs_TEXCOORD0.xy);
					    u_xlat2.xy = min(u_xlat1.yw, u_xlat1.xz);
					    u_xlat1.xy = max(u_xlat1.yw, u_xlat1.xz);
					    u_xlat6 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat2.x = min(u_xlat2.y, u_xlat2.x);
					    SV_Target0 = (u_xlatb0.x) ? u_xlat2.x : u_xlat6;
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
			GpuProgramID 465839
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
						vec4 unused_0_0[4];
						vec4 _QuarterResDepthBuffer_TexelSize;
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
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					out vec2 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat4;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xy = (-_QuarterResDepthBuffer_TexelSize.xy) * vec2(0.5, 0.5) + in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = u_xlat0.xy;
					    u_xlat4.x = _QuarterResDepthBuffer_TexelSize.x;
					    u_xlat4.y = 0.0;
					    vs_TEXCOORD3.xy = u_xlat4.xy + u_xlat0.xy;
					    u_xlat1.x = 0.0;
					    u_xlat1.y = _QuarterResDepthBuffer_TexelSize.y;
					    vs_TEXCOORD2.xy = u_xlat0.xy + u_xlat1.xy;
					    vs_TEXCOORD4.xy = u_xlat0.xy + _QuarterResDepthBuffer_TexelSize.xy;
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
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _QuarterResDepthBuffer_TexelSize;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					out vec2 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat4;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xy = (-_QuarterResDepthBuffer_TexelSize.xy) * vec2(0.5, 0.5) + in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = u_xlat0.xy;
					    u_xlat4.x = _QuarterResDepthBuffer_TexelSize.x;
					    u_xlat4.y = 0.0;
					    vs_TEXCOORD3.xy = u_xlat4.xy + u_xlat0.xy;
					    u_xlat1.x = 0.0;
					    u_xlat1.y = _QuarterResDepthBuffer_TexelSize.y;
					    vs_TEXCOORD2.xy = u_xlat0.xy + u_xlat1.xy;
					    vs_TEXCOORD4.xy = u_xlat0.xy + _QuarterResDepthBuffer_TexelSize.xy;
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
					UNITY_LOCATION(0) uniform  sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform  sampler2D _QuarterResDepthBuffer;
					UNITY_LOCATION(2) uniform  sampler2D _QuarterResColor;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					in  vec2 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat1 = texture(_QuarterResDepthBuffer, vs_TEXCOORD1.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat4;
					    u_xlat2 = texture(_QuarterResDepthBuffer, vs_TEXCOORD3.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat1.y = float(1.0) / u_xlat4;
					    u_xlat2 = texture(_QuarterResDepthBuffer, vs_TEXCOORD2.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat1.z = float(1.0) / u_xlat4;
					    u_xlat2 = texture(_QuarterResDepthBuffer, vs_TEXCOORD4.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat1.w = float(1.0) / u_xlat4;
					    u_xlat0 = (-u_xlat0.xxxx) + u_xlat1.zxyw;
					    u_xlat1.x = dot(abs(u_xlat0.yzxw), vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb1 = u_xlat1.x<1.5;
					    if(u_xlatb1){
					        SV_Target0 = texture(_QuarterResColor, vs_TEXCOORD0.xy);
					    }
					    if(!u_xlatb1){
					        u_xlatb1 = abs(u_xlat0.z)<abs(u_xlat0.y);
					        u_xlat2.x = abs(u_xlat0.z);
					        u_xlat2.yz = vs_TEXCOORD3.xy;
					        u_xlat3.x = abs(u_xlat0.y);
					        u_xlat3.yz = vs_TEXCOORD1.xy;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat2.xyz : u_xlat3.xyz;
					        u_xlatb13 = abs(u_xlat0.x)<u_xlat1.x;
					        u_xlat0.x = abs(u_xlat0.x);
					        u_xlat0.yz = vs_TEXCOORD2.xy;
					        u_xlat0.xyz = (bool(u_xlatb13)) ? u_xlat0.xyz : u_xlat1.xyz;
					        u_xlatb0 = abs(u_xlat0.w)<u_xlat0.x;
					        u_xlat0.xy = (bool(u_xlatb0)) ? vs_TEXCOORD4.xy : u_xlat0.yz;
					        SV_Target0 = texture(_QuarterResColor, u_xlat0.xy);
					    }
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 140
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %9 %11 %37 %51 %61 %67 %75 %124 
					                                                     OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                     OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                     OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                                     OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                     OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
					                                                     OpDecorate vs_TEXCOORD0 Location 9 
					                                                     OpDecorate %11 Location 11 
					                                                     OpDecorate %18 ArrayStride 18 
					                                                     OpDecorate %19 ArrayStride 19 
					                                                     OpMemberDecorate %20 0 Offset 20 
					                                                     OpMemberDecorate %20 1 Offset 20 
					                                                     OpMemberDecorate %20 2 Offset 20 
					                                                     OpDecorate %20 Block 
					                                                     OpDecorate %22 DescriptorSet 22 
					                                                     OpDecorate %22 Binding 22 
					                                                     OpDecorate vs_TEXCOORD1 Location 37 
					                                                     OpDecorate vs_TEXCOORD3 Location 51 
					                                                     OpDecorate vs_TEXCOORD2 Location 61 
					                                                     OpDecorate vs_TEXCOORD4 Location 67 
					                                                     OpDecorate %75 Location 75 
					                                                     OpMemberDecorate %122 0 BuiltIn 122 
					                                                     OpMemberDecorate %122 1 BuiltIn 122 
					                                                     OpMemberDecorate %122 2 BuiltIn 122 
					                                                     OpDecorate %122 Block 
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
					                                             %16 = OpTypeInt 32 0 
					                                         u32 %17 = OpConstant 4 
					                                             %18 = OpTypeArray %13 %17 
					                                             %19 = OpTypeArray %13 %17 
					                                             %20 = OpTypeStruct %18 %19 %13 
					                                             %21 = OpTypePointer Uniform %20 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %22 = OpVariable Uniform 
					                                             %23 = OpTypeInt 32 1 
					                                         i32 %24 = OpConstant 2 
					                                             %25 = OpTypePointer Uniform %13 
					                                         f32 %30 = OpConstant 3,674022E-40 
					                                       f32_2 %31 = OpConstantComposite %30 %30 
					                      Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                             %40 = OpTypePointer Private %7 
					                              Private f32_2* %41 = OpVariable Private 
					                                         u32 %42 = OpConstant 0 
					                                             %43 = OpTypePointer Uniform %6 
					                                             %46 = OpTypePointer Private %6 
					                                         f32 %48 = OpConstant 3,674022E-40 
					                                         u32 %49 = OpConstant 1 
					                      Output f32_2* vs_TEXCOORD3 = OpVariable Output 
					                              Private f32_4* %56 = OpVariable Private 
					                      Output f32_2* vs_TEXCOORD2 = OpVariable Output 
					                      Output f32_2* vs_TEXCOORD4 = OpVariable Output 
					                                             %74 = OpTypePointer Input %13 
					                                Input f32_4* %75 = OpVariable Input 
					                                         i32 %78 = OpConstant 0 
					                                         i32 %79 = OpConstant 1 
					                                         i32 %98 = OpConstant 3 
					                                            %121 = OpTypeArray %6 %49 
					                                            %122 = OpTypeStruct %13 %6 %121 
					                                            %123 = OpTypePointer Output %122 
					       Output struct {f32_4; f32; f32[1];}* %124 = OpVariable Output 
					                                            %132 = OpTypePointer Output %13 
					                                            %134 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                                       f32_2 %12 = OpLoad %11 
					                                                     OpStore vs_TEXCOORD0 %12 
					                              Uniform f32_4* %26 = OpAccessChain %22 %24 
					                                       f32_4 %27 = OpLoad %26 
					                                       f32_2 %28 = OpVectorShuffle %27 %27 0 1 
					                                       f32_2 %29 = OpFNegate %28 
					                                       f32_2 %32 = OpFMul %29 %31 
					                                       f32_2 %33 = OpLoad %11 
					                                       f32_2 %34 = OpFAdd %32 %33 
					                                       f32_4 %35 = OpLoad %15 
					                                       f32_4 %36 = OpVectorShuffle %35 %34 4 5 2 3 
					                                                     OpStore %15 %36 
					                                       f32_4 %38 = OpLoad %15 
					                                       f32_2 %39 = OpVectorShuffle %38 %38 0 1 
					                                                     OpStore vs_TEXCOORD1 %39 
					                                Uniform f32* %44 = OpAccessChain %22 %24 %42 
					                                         f32 %45 = OpLoad %44 
					                                Private f32* %47 = OpAccessChain %41 %42 
					                                                     OpStore %47 %45 
					                                Private f32* %50 = OpAccessChain %41 %49 
					                                                     OpStore %50 %48 
					                                       f32_2 %52 = OpLoad %41 
					                                       f32_4 %53 = OpLoad %15 
					                                       f32_2 %54 = OpVectorShuffle %53 %53 0 1 
					                                       f32_2 %55 = OpFAdd %52 %54 
					                                                     OpStore vs_TEXCOORD3 %55 
					                                Private f32* %57 = OpAccessChain %56 %42 
					                                                     OpStore %57 %48 
					                                Uniform f32* %58 = OpAccessChain %22 %24 %49 
					                                         f32 %59 = OpLoad %58 
					                                Private f32* %60 = OpAccessChain %56 %49 
					                                                     OpStore %60 %59 
					                                       f32_4 %62 = OpLoad %15 
					                                       f32_2 %63 = OpVectorShuffle %62 %62 0 1 
					                                       f32_4 %64 = OpLoad %56 
					                                       f32_2 %65 = OpVectorShuffle %64 %64 0 1 
					                                       f32_2 %66 = OpFAdd %63 %65 
					                                                     OpStore vs_TEXCOORD2 %66 
					                                       f32_4 %68 = OpLoad %15 
					                                       f32_2 %69 = OpVectorShuffle %68 %68 0 1 
					                              Uniform f32_4* %70 = OpAccessChain %22 %24 
					                                       f32_4 %71 = OpLoad %70 
					                                       f32_2 %72 = OpVectorShuffle %71 %71 0 1 
					                                       f32_2 %73 = OpFAdd %69 %72 
					                                                     OpStore vs_TEXCOORD4 %73 
					                                       f32_4 %76 = OpLoad %75 
					                                       f32_4 %77 = OpVectorShuffle %76 %76 1 1 1 1 
					                              Uniform f32_4* %80 = OpAccessChain %22 %78 %79 
					                                       f32_4 %81 = OpLoad %80 
					                                       f32_4 %82 = OpFMul %77 %81 
					                                                     OpStore %15 %82 
					                              Uniform f32_4* %83 = OpAccessChain %22 %78 %78 
					                                       f32_4 %84 = OpLoad %83 
					                                       f32_4 %85 = OpLoad %75 
					                                       f32_4 %86 = OpVectorShuffle %85 %85 0 0 0 0 
					                                       f32_4 %87 = OpFMul %84 %86 
					                                       f32_4 %88 = OpLoad %15 
					                                       f32_4 %89 = OpFAdd %87 %88 
					                                                     OpStore %15 %89 
					                              Uniform f32_4* %90 = OpAccessChain %22 %78 %24 
					                                       f32_4 %91 = OpLoad %90 
					                                       f32_4 %92 = OpLoad %75 
					                                       f32_4 %93 = OpVectorShuffle %92 %92 2 2 2 2 
					                                       f32_4 %94 = OpFMul %91 %93 
					                                       f32_4 %95 = OpLoad %15 
					                                       f32_4 %96 = OpFAdd %94 %95 
					                                                     OpStore %15 %96 
					                                       f32_4 %97 = OpLoad %15 
					                              Uniform f32_4* %99 = OpAccessChain %22 %78 %98 
					                                      f32_4 %100 = OpLoad %99 
					                                      f32_4 %101 = OpFAdd %97 %100 
					                                                     OpStore %15 %101 
					                                      f32_4 %102 = OpLoad %15 
					                                      f32_4 %103 = OpVectorShuffle %102 %102 1 1 1 1 
					                             Uniform f32_4* %104 = OpAccessChain %22 %79 %79 
					                                      f32_4 %105 = OpLoad %104 
					                                      f32_4 %106 = OpFMul %103 %105 
					                                                     OpStore %56 %106 
					                             Uniform f32_4* %107 = OpAccessChain %22 %79 %78 
					                                      f32_4 %108 = OpLoad %107 
					                                      f32_4 %109 = OpLoad %15 
					                                      f32_4 %110 = OpVectorShuffle %109 %109 0 0 0 0 
					                                      f32_4 %111 = OpFMul %108 %110 
					                                      f32_4 %112 = OpLoad %56 
					                                      f32_4 %113 = OpFAdd %111 %112 
					                                                     OpStore %56 %113 
					                             Uniform f32_4* %114 = OpAccessChain %22 %79 %24 
					                                      f32_4 %115 = OpLoad %114 
					                                      f32_4 %116 = OpLoad %15 
					                                      f32_4 %117 = OpVectorShuffle %116 %116 2 2 2 2 
					                                      f32_4 %118 = OpFMul %115 %117 
					                                      f32_4 %119 = OpLoad %56 
					                                      f32_4 %120 = OpFAdd %118 %119 
					                                                     OpStore %56 %120 
					                             Uniform f32_4* %125 = OpAccessChain %22 %79 %98 
					                                      f32_4 %126 = OpLoad %125 
					                                      f32_4 %127 = OpLoad %15 
					                                      f32_4 %128 = OpVectorShuffle %127 %127 3 3 3 3 
					                                      f32_4 %129 = OpFMul %126 %128 
					                                      f32_4 %130 = OpLoad %56 
					                                      f32_4 %131 = OpFAdd %129 %130 
					                              Output f32_4* %133 = OpAccessChain %124 %78 
					                                                     OpStore %133 %131 
					                                Output f32* %135 = OpAccessChain %124 %78 %49 
					                                        f32 %136 = OpLoad %135 
					                                        f32 %137 = OpFNegate %136 
					                                Output f32* %138 = OpAccessChain %124 %78 %49 
					                                                     OpStore %138 %137 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 247
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %22 %57 %75 %93 %110 %147 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                              OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                              OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
					                                              OpDecorate %12 DescriptorSet 12 
					                                              OpDecorate %12 Binding 12 
					                                              OpDecorate %16 DescriptorSet 16 
					                                              OpDecorate %16 Binding 16 
					                                              OpDecorate vs_TEXCOORD0 Location 22 
					                                              OpMemberDecorate %30 0 Offset 30 
					                                              OpDecorate %30 Block 
					                                              OpDecorate %32 DescriptorSet 32 
					                                              OpDecorate %32 Binding 32 
					                                              OpDecorate %53 DescriptorSet 53 
					                                              OpDecorate %53 Binding 53 
					                                              OpDecorate vs_TEXCOORD1 Location 57 
					                                              OpDecorate vs_TEXCOORD3 Location 75 
					                                              OpDecorate vs_TEXCOORD2 Location 93 
					                                              OpDecorate vs_TEXCOORD4 Location 110 
					                                              OpDecorate %147 Location 147 
					                                              OpDecorate %148 DescriptorSet 148 
					                                              OpDecorate %148 Binding 148 
					                                              OpDecorate %150 DescriptorSet 150 
					                                              OpDecorate %150 Binding 150 
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
					                                      %25 = OpTypeInt 32 0 
					                                  u32 %26 = OpConstant 0 
					                                      %28 = OpTypePointer Private %6 
					                                      %30 = OpTypeStruct %7 
					                                      %31 = OpTypePointer Uniform %30 
					             Uniform struct {f32_4;}* %32 = OpVariable Uniform 
					                                      %33 = OpTypeInt 32 1 
					                                  i32 %34 = OpConstant 0 
					                                  u32 %35 = OpConstant 2 
					                                      %36 = OpTypePointer Uniform %6 
					                                  u32 %42 = OpConstant 3 
					                                  f32 %47 = OpConstant 3,674022E-40 
					                         Private f32* %52 = OpVariable Private 
					 UniformConstant read_only Texture2D* %53 = OpVariable UniformConstant 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                       Private f32_4* %68 = OpVariable Private 
					                Input f32_2* vs_TEXCOORD3 = OpVariable Input 
					                                  u32 %88 = OpConstant 1 
					                Input f32_2* vs_TEXCOORD2 = OpVariable Input 
					                Input f32_2* vs_TEXCOORD4 = OpVariable Input 
					                               f32_4 %133 = OpConstantComposite %47 %47 %47 %47 
					                                     %136 = OpTypeBool 
					                                     %137 = OpTypePointer Private %136 
					                       Private bool* %138 = OpVariable Private 
					                                 f32 %141 = OpConstant 3,674022E-40 
					                                     %146 = OpTypePointer Output %7 
					                       Output f32_4* %147 = OpVariable Output 
					UniformConstant read_only Texture2D* %148 = OpVariable UniformConstant 
					            UniformConstant sampler* %150 = OpVariable UniformConstant 
					                                     %166 = OpTypeVector %6 3 
					                                     %167 = OpTypePointer Private %166 
					                      Private f32_3* %168 = OpVariable Private 
					                      Private f32_3* %176 = OpVariable Private 
					                                     %185 = OpTypePointer Function %166 
					                       Private bool* %195 = OpVariable Private 
					                       Private bool* %221 = OpVariable Private 
					                                     %229 = OpTypePointer Function %20 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                     Function f32_3* %186 = OpVariable Function 
					                     Function f32_3* %210 = OpVariable Function 
					                     Function f32_2* %230 = OpVariable Function 
					                  read_only Texture2D %13 = OpLoad %12 
					                              sampler %17 = OpLoad %16 
					           read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                f32_2 %23 = OpLoad vs_TEXCOORD0 
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
					                  read_only Texture2D %54 = OpLoad %53 
					                              sampler %55 = OpLoad %16 
					           read_only Texture2DSampled %56 = OpSampledImage %54 %55 
					                                f32_2 %58 = OpLoad vs_TEXCOORD1 
					                                f32_4 %59 = OpImageSampleImplicitLod %56 %58 
					                                  f32 %60 = OpCompositeExtract %59 0 
					                                              OpStore %52 %60 
					                         Uniform f32* %61 = OpAccessChain %32 %34 %35 
					                                  f32 %62 = OpLoad %61 
					                                  f32 %63 = OpLoad %52 
					                                  f32 %64 = OpFMul %62 %63 
					                         Uniform f32* %65 = OpAccessChain %32 %34 %42 
					                                  f32 %66 = OpLoad %65 
					                                  f32 %67 = OpFAdd %64 %66 
					                                              OpStore %52 %67 
					                                  f32 %69 = OpLoad %52 
					                                  f32 %70 = OpFDiv %47 %69 
					                         Private f32* %71 = OpAccessChain %68 %26 
					                                              OpStore %71 %70 
					                  read_only Texture2D %72 = OpLoad %53 
					                              sampler %73 = OpLoad %16 
					           read_only Texture2DSampled %74 = OpSampledImage %72 %73 
					                                f32_2 %76 = OpLoad vs_TEXCOORD3 
					                                f32_4 %77 = OpImageSampleImplicitLod %74 %76 
					                                  f32 %78 = OpCompositeExtract %77 0 
					                                              OpStore %52 %78 
					                         Uniform f32* %79 = OpAccessChain %32 %34 %35 
					                                  f32 %80 = OpLoad %79 
					                                  f32 %81 = OpLoad %52 
					                                  f32 %82 = OpFMul %80 %81 
					                         Uniform f32* %83 = OpAccessChain %32 %34 %42 
					                                  f32 %84 = OpLoad %83 
					                                  f32 %85 = OpFAdd %82 %84 
					                                              OpStore %52 %85 
					                                  f32 %86 = OpLoad %52 
					                                  f32 %87 = OpFDiv %47 %86 
					                         Private f32* %89 = OpAccessChain %68 %88 
					                                              OpStore %89 %87 
					                  read_only Texture2D %90 = OpLoad %53 
					                              sampler %91 = OpLoad %16 
					           read_only Texture2DSampled %92 = OpSampledImage %90 %91 
					                                f32_2 %94 = OpLoad vs_TEXCOORD2 
					                                f32_4 %95 = OpImageSampleImplicitLod %92 %94 
					                                  f32 %96 = OpCompositeExtract %95 0 
					                                              OpStore %52 %96 
					                         Uniform f32* %97 = OpAccessChain %32 %34 %35 
					                                  f32 %98 = OpLoad %97 
					                                  f32 %99 = OpLoad %52 
					                                 f32 %100 = OpFMul %98 %99 
					                        Uniform f32* %101 = OpAccessChain %32 %34 %42 
					                                 f32 %102 = OpLoad %101 
					                                 f32 %103 = OpFAdd %100 %102 
					                                              OpStore %52 %103 
					                                 f32 %104 = OpLoad %52 
					                                 f32 %105 = OpFDiv %47 %104 
					                        Private f32* %106 = OpAccessChain %68 %35 
					                                              OpStore %106 %105 
					                 read_only Texture2D %107 = OpLoad %53 
					                             sampler %108 = OpLoad %16 
					          read_only Texture2DSampled %109 = OpSampledImage %107 %108 
					                               f32_2 %111 = OpLoad vs_TEXCOORD4 
					                               f32_4 %112 = OpImageSampleImplicitLod %109 %111 
					                                 f32 %113 = OpCompositeExtract %112 0 
					                                              OpStore %52 %113 
					                        Uniform f32* %114 = OpAccessChain %32 %34 %35 
					                                 f32 %115 = OpLoad %114 
					                                 f32 %116 = OpLoad %52 
					                                 f32 %117 = OpFMul %115 %116 
					                        Uniform f32* %118 = OpAccessChain %32 %34 %42 
					                                 f32 %119 = OpLoad %118 
					                                 f32 %120 = OpFAdd %117 %119 
					                                              OpStore %52 %120 
					                                 f32 %121 = OpLoad %52 
					                                 f32 %122 = OpFDiv %47 %121 
					                        Private f32* %123 = OpAccessChain %68 %42 
					                                              OpStore %123 %122 
					                               f32_4 %124 = OpLoad %9 
					                               f32_4 %125 = OpVectorShuffle %124 %124 0 0 0 0 
					                               f32_4 %126 = OpFNegate %125 
					                               f32_4 %127 = OpLoad %68 
					                               f32_4 %128 = OpVectorShuffle %127 %127 2 0 1 3 
					                               f32_4 %129 = OpFAdd %126 %128 
					                                              OpStore %9 %129 
					                               f32_4 %130 = OpLoad %9 
					                               f32_4 %131 = OpVectorShuffle %130 %130 1 2 0 3 
					                               f32_4 %132 = OpExtInst %1 4 %131 
					                                 f32 %134 = OpDot %132 %133 
					                        Private f32* %135 = OpAccessChain %68 %26 
					                                              OpStore %135 %134 
					                        Private f32* %139 = OpAccessChain %68 %26 
					                                 f32 %140 = OpLoad %139 
					                                bool %142 = OpFOrdLessThan %140 %141 
					                                              OpStore %138 %142 
					                                bool %143 = OpLoad %138 
					                                              OpSelectionMerge %145 None 
					                                              OpBranchConditional %143 %144 %145 
					                                     %144 = OpLabel 
					                 read_only Texture2D %149 = OpLoad %148 
					                             sampler %151 = OpLoad %150 
					          read_only Texture2DSampled %152 = OpSampledImage %149 %151 
					                               f32_2 %153 = OpLoad vs_TEXCOORD0 
					                               f32_4 %154 = OpImageSampleImplicitLod %152 %153 
					                                              OpStore %147 %154 
					                                              OpBranch %145 
					                                     %145 = OpLabel 
					                                bool %155 = OpLoad %138 
					                                bool %156 = OpLogicalNot %155 
					                                              OpSelectionMerge %158 None 
					                                              OpBranchConditional %156 %157 %158 
					                                     %157 = OpLabel 
					                        Private f32* %159 = OpAccessChain %9 %35 
					                                 f32 %160 = OpLoad %159 
					                                 f32 %161 = OpExtInst %1 4 %160 
					                        Private f32* %162 = OpAccessChain %9 %88 
					                                 f32 %163 = OpLoad %162 
					                                 f32 %164 = OpExtInst %1 4 %163 
					                                bool %165 = OpFOrdLessThan %161 %164 
					                                              OpStore %138 %165 
					                        Private f32* %169 = OpAccessChain %9 %35 
					                                 f32 %170 = OpLoad %169 
					                                 f32 %171 = OpExtInst %1 4 %170 
					                        Private f32* %172 = OpAccessChain %168 %26 
					                                              OpStore %172 %171 
					                               f32_2 %173 = OpLoad vs_TEXCOORD3 
					                               f32_3 %174 = OpLoad %168 
					                               f32_3 %175 = OpVectorShuffle %174 %173 0 3 4 
					                                              OpStore %168 %175 
					                        Private f32* %177 = OpAccessChain %9 %88 
					                                 f32 %178 = OpLoad %177 
					                                 f32 %179 = OpExtInst %1 4 %178 
					                        Private f32* %180 = OpAccessChain %176 %26 
					                                              OpStore %180 %179 
					                               f32_2 %181 = OpLoad vs_TEXCOORD1 
					                               f32_3 %182 = OpLoad %176 
					                               f32_3 %183 = OpVectorShuffle %182 %181 0 3 4 
					                                              OpStore %176 %183 
					                                bool %184 = OpLoad %138 
					                                              OpSelectionMerge %188 None 
					                                              OpBranchConditional %184 %187 %190 
					                                     %187 = OpLabel 
					                               f32_3 %189 = OpLoad %168 
					                                              OpStore %186 %189 
					                                              OpBranch %188 
					                                     %190 = OpLabel 
					                               f32_3 %191 = OpLoad %176 
					                                              OpStore %186 %191 
					                                              OpBranch %188 
					                                     %188 = OpLabel 
					                               f32_3 %192 = OpLoad %186 
					                               f32_4 %193 = OpLoad %68 
					                               f32_4 %194 = OpVectorShuffle %193 %192 4 5 6 3 
					                                              OpStore %68 %194 
					                        Private f32* %196 = OpAccessChain %9 %26 
					                                 f32 %197 = OpLoad %196 
					                                 f32 %198 = OpExtInst %1 4 %197 
					                        Private f32* %199 = OpAccessChain %68 %26 
					                                 f32 %200 = OpLoad %199 
					                                bool %201 = OpFOrdLessThan %198 %200 
					                                              OpStore %195 %201 
					                        Private f32* %202 = OpAccessChain %9 %26 
					                                 f32 %203 = OpLoad %202 
					                                 f32 %204 = OpExtInst %1 4 %203 
					                        Private f32* %205 = OpAccessChain %9 %26 
					                                              OpStore %205 %204 
					                               f32_2 %206 = OpLoad vs_TEXCOORD2 
					                               f32_4 %207 = OpLoad %9 
					                               f32_4 %208 = OpVectorShuffle %207 %206 0 4 5 3 
					                                              OpStore %9 %208 
					                                bool %209 = OpLoad %195 
					                                              OpSelectionMerge %212 None 
					                                              OpBranchConditional %209 %211 %215 
					                                     %211 = OpLabel 
					                               f32_4 %213 = OpLoad %9 
					                               f32_3 %214 = OpVectorShuffle %213 %213 0 1 2 
					                                              OpStore %210 %214 
					                                              OpBranch %212 
					                                     %215 = OpLabel 
					                               f32_4 %216 = OpLoad %68 
					                               f32_3 %217 = OpVectorShuffle %216 %216 0 1 2 
					                                              OpStore %210 %217 
					                                              OpBranch %212 
					                                     %212 = OpLabel 
					                               f32_3 %218 = OpLoad %210 
					                               f32_4 %219 = OpLoad %9 
					                               f32_4 %220 = OpVectorShuffle %219 %218 4 5 6 3 
					                                              OpStore %9 %220 
					                        Private f32* %222 = OpAccessChain %9 %42 
					                                 f32 %223 = OpLoad %222 
					                                 f32 %224 = OpExtInst %1 4 %223 
					                        Private f32* %225 = OpAccessChain %9 %26 
					                                 f32 %226 = OpLoad %225 
					                                bool %227 = OpFOrdLessThan %224 %226 
					                                              OpStore %221 %227 
					                                bool %228 = OpLoad %221 
					                                              OpSelectionMerge %232 None 
					                                              OpBranchConditional %228 %231 %234 
					                                     %231 = OpLabel 
					                               f32_2 %233 = OpLoad vs_TEXCOORD4 
					                                              OpStore %230 %233 
					                                              OpBranch %232 
					                                     %234 = OpLabel 
					                               f32_4 %235 = OpLoad %9 
					                               f32_2 %236 = OpVectorShuffle %235 %235 1 2 
					                                              OpStore %230 %236 
					                                              OpBranch %232 
					                                     %232 = OpLabel 
					                               f32_2 %237 = OpLoad %230 
					                               f32_4 %238 = OpLoad %9 
					                               f32_4 %239 = OpVectorShuffle %238 %237 4 5 2 3 
					                                              OpStore %9 %239 
					                 read_only Texture2D %240 = OpLoad %148 
					                             sampler %241 = OpLoad %16 
					          read_only Texture2DSampled %242 = OpSampledImage %240 %241 
					                               f32_4 %243 = OpLoad %9 
					                               f32_2 %244 = OpVectorShuffle %243 %243 0 1 
					                               f32_4 %245 = OpImageSampleImplicitLod %242 %244 
					                                              OpStore %147 %245 
					                                              OpBranch %158 
					                                     %158 = OpLabel 
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[7];
						vec4 _ZBufferParams;
						vec4 unused_0_2;
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _QuarterResDepthBuffer;
					uniform  sampler2D _QuarterResColor;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					in  vec2 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat1 = texture(_QuarterResDepthBuffer, vs_TEXCOORD1.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat4;
					    u_xlat2 = texture(_QuarterResDepthBuffer, vs_TEXCOORD3.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat1.y = float(1.0) / u_xlat4;
					    u_xlat2 = texture(_QuarterResDepthBuffer, vs_TEXCOORD2.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat1.z = float(1.0) / u_xlat4;
					    u_xlat2 = texture(_QuarterResDepthBuffer, vs_TEXCOORD4.xy);
					    u_xlat4 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat1.w = float(1.0) / u_xlat4;
					    u_xlat0 = (-u_xlat0.xxxx) + u_xlat1.zxyw;
					    u_xlat1.x = dot(abs(u_xlat0.yzxw), vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb1 = u_xlat1.x<1.5;
					    if(u_xlatb1){
					        SV_Target0 = texture(_QuarterResColor, vs_TEXCOORD0.xy);
					    }
					    if(!u_xlatb1){
					        u_xlatb1 = abs(u_xlat0.z)<abs(u_xlat0.y);
					        u_xlat2.x = abs(u_xlat0.z);
					        u_xlat2.yz = vs_TEXCOORD3.xy;
					        u_xlat3.x = abs(u_xlat0.y);
					        u_xlat3.yz = vs_TEXCOORD1.xy;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat2.xyz : u_xlat3.xyz;
					        u_xlatb13 = abs(u_xlat0.x)<u_xlat1.x;
					        u_xlat0.x = abs(u_xlat0.x);
					        u_xlat0.yz = vs_TEXCOORD2.xy;
					        u_xlat0.xyz = (bool(u_xlatb13)) ? u_xlat0.xyz : u_xlat1.xyz;
					        u_xlatb0 = abs(u_xlat0.w)<u_xlat0.x;
					        u_xlat0.xy = (bool(u_xlatb0)) ? vs_TEXCOORD4.xy : u_xlat0.yz;
					        SV_Target0 = texture(_QuarterResColor, u_xlat0.xy);
					    }
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
			GpuProgramID 546888
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
					UNITY_LOCATION(0) uniform  sampler2D _QuarterResDepthBuffer;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat5;
					float u_xlat6;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-5, 0));
					    u_xlat1 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-6, 0));
					    u_xlat2 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-6, 0));
					    u_xlat12 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat2 = texture(_QuarterResDepthBuffer, vs_TEXCOORD0.xy);
					    u_xlat13 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat12 = (-u_xlat12) + u_xlat13;
					    u_xlat12 = abs(u_xlat12) * 0.5;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat12 = u_xlat12 * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat2.x = u_xlat12 * 0.0323794;
					    u_xlat12 = u_xlat12 * 0.0323794 + 0.0997355729;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat2.xyz * vec3(0.0997355729, 0.0997355729, 0.0997355729) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat2 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-5, 0));
					    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.x = u_xlat13 + (-u_xlat2.x);
					    u_xlat2.x = abs(u_xlat2.x) * 0.5;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * -1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat6 = u_xlat2.x * 0.0456622727;
					    u_xlat12 = u_xlat2.x * 0.0456622727 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-4, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-4, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0604926832;
					    u_xlat12 = u_xlat1.x * 0.0604926832 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-3, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-3, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0752843618;
					    u_xlat12 = u_xlat1.x * 0.0752843618 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-2, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-2, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0880163312;
					    u_xlat12 = u_xlat1.x * 0.0880163312 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-1, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-1, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.096667029;
					    u_xlat12 = u_xlat1.x * 0.096667029 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(1, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(1, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.096667029;
					    u_xlat12 = u_xlat1.x * 0.096667029 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(2, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(2, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0880163312;
					    u_xlat12 = u_xlat1.x * 0.0880163312 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(3, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(3, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0752843618;
					    u_xlat12 = u_xlat1.x * 0.0752843618 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(4, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(4, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0604926832;
					    u_xlat12 = u_xlat1.x * 0.0604926832 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(5, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(5, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0456622727;
					    u_xlat12 = u_xlat1.x * 0.0456622727 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(6, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(6, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0323794;
					    u_xlat12 = u_xlat1.x * 0.0323794 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz / vec3(u_xlat12);
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
					; Bound: 863
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %127 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %43 DescriptorSet 43 
					                                             OpDecorate %43 Binding 43 
					                                             OpDecorate %45 DescriptorSet 45 
					                                             OpDecorate %45 Binding 45 
					                                             OpMemberDecorate %53 0 Offset 53 
					                                             OpDecorate %53 Block 
					                                             OpDecorate %55 DescriptorSet 55 
					                                             OpDecorate %55 Binding 55 
					                                             OpDecorate %127 Location 127 
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
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %24 = OpTypeInt 32 1 
					                                     %25 = OpTypeVector %24 2 
					                                 i32 %26 = OpConstant -5 
					                                 i32 %27 = OpConstant 0 
					                               i32_2 %28 = OpConstantComposite %26 %27 
					                                     %29 = OpTypeVector %6 4 
					                      Private f32_3* %32 = OpVariable Private 
					                                 i32 %37 = OpConstant -6 
					                               i32_2 %38 = OpConstantComposite %37 %27 
					                                     %41 = OpTypePointer Private %6 
					                        Private f32* %42 = OpVariable Private 
					UniformConstant read_only Texture2D* %43 = OpVariable UniformConstant 
					            UniformConstant sampler* %45 = OpVariable UniformConstant 
					                                     %50 = OpTypeInt 32 0 
					                                 u32 %51 = OpConstant 0 
					                                     %53 = OpTypeStruct %29 
					                                     %54 = OpTypePointer Uniform %53 
					            Uniform struct {f32_4;}* %55 = OpVariable Uniform 
					                                 u32 %56 = OpConstant 2 
					                                     %57 = OpTypePointer Uniform %6 
					                                 u32 %62 = OpConstant 3 
					                                 f32 %66 = OpConstant 3,674022E-40 
					                        Private f32* %69 = OpVariable Private 
					                                 f32 %91 = OpConstant 3,674022E-40 
					                                 f32 %97 = OpConstant 3,674022E-40 
					                                    %101 = OpTypePointer Private %29 
					                     Private f32_4* %102 = OpVariable Private 
					                                f32 %104 = OpConstant 3,674022E-40 
					                                f32 %109 = OpConstant 3,674022E-40 
					                              f32_3 %122 = OpConstantComposite %109 %109 %109 
					                                    %126 = OpTypePointer Output %29 
					                      Output f32_4* %127 = OpVariable Output 
					                                    %130 = OpTypePointer Output %6 
					                       Private f32* %177 = OpVariable Private 
					                                f32 %180 = OpConstant 3,674022E-40 
					                                i32 %197 = OpConstant -4 
					                              i32_2 %198 = OpConstantComposite %197 %27 
					                                f32 %248 = OpConstant 3,674022E-40 
					                                i32 %265 = OpConstant -3 
					                              i32_2 %266 = OpConstantComposite %265 %27 
					                                f32 %316 = OpConstant 3,674022E-40 
					                                i32 %333 = OpConstant -2 
					                              i32_2 %334 = OpConstantComposite %333 %27 
					                                f32 %384 = OpConstant 3,674022E-40 
					                                i32 %401 = OpConstant -1 
					                              i32_2 %402 = OpConstantComposite %401 %27 
					                                f32 %452 = OpConstant 3,674022E-40 
					                                i32 %469 = OpConstant 1 
					                              i32_2 %470 = OpConstantComposite %469 %27 
					                                i32 %536 = OpConstant 2 
					                              i32_2 %537 = OpConstantComposite %536 %27 
					                                i32 %603 = OpConstant 3 
					                              i32_2 %604 = OpConstantComposite %603 %27 
					                                i32 %670 = OpConstant 4 
					                              i32_2 %671 = OpConstantComposite %670 %27 
					                                i32 %737 = OpConstant 5 
					                              i32_2 %738 = OpConstantComposite %737 %27 
					                                i32 %804 = OpConstant 6 
					                              i32_2 %805 = OpConstantComposite %804 %27 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %30 = OpImageSampleImplicitLod %19 %23 ConstOffset %29 
					                               f32_3 %31 = OpVectorShuffle %30 %30 0 1 2 
					                                             OpStore %9 %31 
					                 read_only Texture2D %33 = OpLoad %12 
					                             sampler %34 = OpLoad %16 
					          read_only Texture2DSampled %35 = OpSampledImage %33 %34 
					                               f32_2 %36 = OpLoad vs_TEXCOORD0 
					                               f32_4 %39 = OpImageSampleImplicitLod %35 %36 ConstOffset %29 
					                               f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
					                                             OpStore %32 %40 
					                 read_only Texture2D %44 = OpLoad %43 
					                             sampler %46 = OpLoad %45 
					          read_only Texture2DSampled %47 = OpSampledImage %44 %46 
					                               f32_2 %48 = OpLoad vs_TEXCOORD0 
					                               f32_4 %49 = OpImageSampleImplicitLod %47 %48 ConstOffset %29 
					                                 f32 %52 = OpCompositeExtract %49 0 
					                                             OpStore %42 %52 
					                        Uniform f32* %58 = OpAccessChain %55 %27 %56 
					                                 f32 %59 = OpLoad %58 
					                                 f32 %60 = OpLoad %42 
					                                 f32 %61 = OpFMul %59 %60 
					                        Uniform f32* %63 = OpAccessChain %55 %27 %62 
					                                 f32 %64 = OpLoad %63 
					                                 f32 %65 = OpFAdd %61 %64 
					                                             OpStore %42 %65 
					                                 f32 %67 = OpLoad %42 
					                                 f32 %68 = OpFDiv %66 %67 
					                                             OpStore %42 %68 
					                 read_only Texture2D %70 = OpLoad %43 
					                             sampler %71 = OpLoad %45 
					          read_only Texture2DSampled %72 = OpSampledImage %70 %71 
					                               f32_2 %73 = OpLoad vs_TEXCOORD0 
					                               f32_4 %74 = OpImageSampleImplicitLod %72 %73 
					                                 f32 %75 = OpCompositeExtract %74 0 
					                                             OpStore %69 %75 
					                        Uniform f32* %76 = OpAccessChain %55 %27 %56 
					                                 f32 %77 = OpLoad %76 
					                                 f32 %78 = OpLoad %69 
					                                 f32 %79 = OpFMul %77 %78 
					                        Uniform f32* %80 = OpAccessChain %55 %27 %62 
					                                 f32 %81 = OpLoad %80 
					                                 f32 %82 = OpFAdd %79 %81 
					                                             OpStore %69 %82 
					                                 f32 %83 = OpLoad %69 
					                                 f32 %84 = OpFDiv %66 %83 
					                                             OpStore %69 %84 
					                                 f32 %85 = OpLoad %42 
					                                 f32 %86 = OpFNegate %85 
					                                 f32 %87 = OpLoad %69 
					                                 f32 %88 = OpFAdd %86 %87 
					                                             OpStore %42 %88 
					                                 f32 %89 = OpLoad %42 
					                                 f32 %90 = OpExtInst %1 4 %89 
					                                 f32 %92 = OpFMul %90 %91 
					                                             OpStore %42 %92 
					                                 f32 %93 = OpLoad %42 
					                                 f32 %94 = OpLoad %42 
					                                 f32 %95 = OpFMul %93 %94 
					                                             OpStore %42 %95 
					                                 f32 %96 = OpLoad %42 
					                                 f32 %98 = OpFMul %96 %97 
					                                             OpStore %42 %98 
					                                 f32 %99 = OpLoad %42 
					                                f32 %100 = OpExtInst %1 29 %99 
					                                             OpStore %42 %100 
					                                f32 %103 = OpLoad %42 
					                                f32 %105 = OpFMul %103 %104 
					                       Private f32* %106 = OpAccessChain %102 %51 
					                                             OpStore %106 %105 
					                                f32 %107 = OpLoad %42 
					                                f32 %108 = OpFMul %107 %104 
					                                f32 %110 = OpFAdd %108 %109 
					                                             OpStore %42 %110 
					                              f32_3 %111 = OpLoad %32 
					                              f32_4 %112 = OpLoad %102 
					                              f32_3 %113 = OpVectorShuffle %112 %112 0 0 0 
					                              f32_3 %114 = OpFMul %111 %113 
					                                             OpStore %32 %114 
					                read_only Texture2D %115 = OpLoad %12 
					                            sampler %116 = OpLoad %16 
					         read_only Texture2DSampled %117 = OpSampledImage %115 %116 
					                              f32_2 %118 = OpLoad vs_TEXCOORD0 
					                              f32_4 %119 = OpImageSampleImplicitLod %117 %118 
					                                             OpStore %102 %119 
					                              f32_4 %120 = OpLoad %102 
					                              f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                              f32_3 %123 = OpFMul %121 %122 
					                              f32_3 %124 = OpLoad %32 
					                              f32_3 %125 = OpFAdd %123 %124 
					                                             OpStore %32 %125 
					                       Private f32* %128 = OpAccessChain %102 %62 
					                                f32 %129 = OpLoad %128 
					                        Output f32* %131 = OpAccessChain %127 %62 
					                                             OpStore %131 %129 
					                read_only Texture2D %132 = OpLoad %43 
					                            sampler %133 = OpLoad %45 
					         read_only Texture2DSampled %134 = OpSampledImage %132 %133 
					                              f32_2 %135 = OpLoad vs_TEXCOORD0 
					                              f32_4 %136 = OpImageSampleImplicitLod %134 %135 ConstOffset %29 
					                                f32 %137 = OpCompositeExtract %136 0 
					                       Private f32* %138 = OpAccessChain %102 %51 
					                                             OpStore %138 %137 
					                       Uniform f32* %139 = OpAccessChain %55 %27 %56 
					                                f32 %140 = OpLoad %139 
					                       Private f32* %141 = OpAccessChain %102 %51 
					                                f32 %142 = OpLoad %141 
					                                f32 %143 = OpFMul %140 %142 
					                       Uniform f32* %144 = OpAccessChain %55 %27 %62 
					                                f32 %145 = OpLoad %144 
					                                f32 %146 = OpFAdd %143 %145 
					                       Private f32* %147 = OpAccessChain %102 %51 
					                                             OpStore %147 %146 
					                       Private f32* %148 = OpAccessChain %102 %51 
					                                f32 %149 = OpLoad %148 
					                                f32 %150 = OpFDiv %66 %149 
					                       Private f32* %151 = OpAccessChain %102 %51 
					                                             OpStore %151 %150 
					                                f32 %152 = OpLoad %69 
					                       Private f32* %153 = OpAccessChain %102 %51 
					                                f32 %154 = OpLoad %153 
					                                f32 %155 = OpFNegate %154 
					                                f32 %156 = OpFAdd %152 %155 
					                       Private f32* %157 = OpAccessChain %102 %51 
					                                             OpStore %157 %156 
					                       Private f32* %158 = OpAccessChain %102 %51 
					                                f32 %159 = OpLoad %158 
					                                f32 %160 = OpExtInst %1 4 %159 
					                                f32 %161 = OpFMul %160 %91 
					                       Private f32* %162 = OpAccessChain %102 %51 
					                                             OpStore %162 %161 
					                       Private f32* %163 = OpAccessChain %102 %51 
					                                f32 %164 = OpLoad %163 
					                       Private f32* %165 = OpAccessChain %102 %51 
					                                f32 %166 = OpLoad %165 
					                                f32 %167 = OpFMul %164 %166 
					                       Private f32* %168 = OpAccessChain %102 %51 
					                                             OpStore %168 %167 
					                       Private f32* %169 = OpAccessChain %102 %51 
					                                f32 %170 = OpLoad %169 
					                                f32 %171 = OpFMul %170 %97 
					                       Private f32* %172 = OpAccessChain %102 %51 
					                                             OpStore %172 %171 
					                       Private f32* %173 = OpAccessChain %102 %51 
					                                f32 %174 = OpLoad %173 
					                                f32 %175 = OpExtInst %1 29 %174 
					                       Private f32* %176 = OpAccessChain %102 %51 
					                                             OpStore %176 %175 
					                       Private f32* %178 = OpAccessChain %102 %51 
					                                f32 %179 = OpLoad %178 
					                                f32 %181 = OpFMul %179 %180 
					                                             OpStore %177 %181 
					                       Private f32* %182 = OpAccessChain %102 %51 
					                                f32 %183 = OpLoad %182 
					                                f32 %184 = OpFMul %183 %180 
					                                f32 %185 = OpLoad %42 
					                                f32 %186 = OpFAdd %184 %185 
					                                             OpStore %42 %186 
					                                f32 %187 = OpLoad %177 
					                              f32_3 %188 = OpCompositeConstruct %187 %187 %187 
					                              f32_3 %189 = OpLoad %9 
					                              f32_3 %190 = OpFMul %188 %189 
					                              f32_3 %191 = OpLoad %32 
					                              f32_3 %192 = OpFAdd %190 %191 
					                                             OpStore %9 %192 
					                read_only Texture2D %193 = OpLoad %12 
					                            sampler %194 = OpLoad %16 
					         read_only Texture2DSampled %195 = OpSampledImage %193 %194 
					                              f32_2 %196 = OpLoad vs_TEXCOORD0 
					                              f32_4 %199 = OpImageSampleImplicitLod %195 %196 ConstOffset %29 
					                              f32_3 %200 = OpVectorShuffle %199 %199 0 1 2 
					                                             OpStore %32 %200 
					                read_only Texture2D %201 = OpLoad %43 
					                            sampler %202 = OpLoad %45 
					         read_only Texture2DSampled %203 = OpSampledImage %201 %202 
					                              f32_2 %204 = OpLoad vs_TEXCOORD0 
					                              f32_4 %205 = OpImageSampleImplicitLod %203 %204 ConstOffset %29 
					                                f32 %206 = OpCompositeExtract %205 0 
					                       Private f32* %207 = OpAccessChain %102 %51 
					                                             OpStore %207 %206 
					                       Uniform f32* %208 = OpAccessChain %55 %27 %56 
					                                f32 %209 = OpLoad %208 
					                       Private f32* %210 = OpAccessChain %102 %51 
					                                f32 %211 = OpLoad %210 
					                                f32 %212 = OpFMul %209 %211 
					                       Uniform f32* %213 = OpAccessChain %55 %27 %62 
					                                f32 %214 = OpLoad %213 
					                                f32 %215 = OpFAdd %212 %214 
					                       Private f32* %216 = OpAccessChain %102 %51 
					                                             OpStore %216 %215 
					                       Private f32* %217 = OpAccessChain %102 %51 
					                                f32 %218 = OpLoad %217 
					                                f32 %219 = OpFDiv %66 %218 
					                       Private f32* %220 = OpAccessChain %102 %51 
					                                             OpStore %220 %219 
					                                f32 %221 = OpLoad %69 
					                       Private f32* %222 = OpAccessChain %102 %51 
					                                f32 %223 = OpLoad %222 
					                                f32 %224 = OpFNegate %223 
					                                f32 %225 = OpFAdd %221 %224 
					                       Private f32* %226 = OpAccessChain %102 %51 
					                                             OpStore %226 %225 
					                       Private f32* %227 = OpAccessChain %102 %51 
					                                f32 %228 = OpLoad %227 
					                                f32 %229 = OpExtInst %1 4 %228 
					                                f32 %230 = OpFMul %229 %91 
					                       Private f32* %231 = OpAccessChain %102 %51 
					                                             OpStore %231 %230 
					                       Private f32* %232 = OpAccessChain %102 %51 
					                                f32 %233 = OpLoad %232 
					                       Private f32* %234 = OpAccessChain %102 %51 
					                                f32 %235 = OpLoad %234 
					                                f32 %236 = OpFMul %233 %235 
					                       Private f32* %237 = OpAccessChain %102 %51 
					                                             OpStore %237 %236 
					                       Private f32* %238 = OpAccessChain %102 %51 
					                                f32 %239 = OpLoad %238 
					                                f32 %240 = OpFMul %239 %97 
					                       Private f32* %241 = OpAccessChain %102 %51 
					                                             OpStore %241 %240 
					                       Private f32* %242 = OpAccessChain %102 %51 
					                                f32 %243 = OpLoad %242 
					                                f32 %244 = OpExtInst %1 29 %243 
					                       Private f32* %245 = OpAccessChain %102 %51 
					                                             OpStore %245 %244 
					                       Private f32* %246 = OpAccessChain %102 %51 
					                                f32 %247 = OpLoad %246 
					                                f32 %249 = OpFMul %247 %248 
					                                             OpStore %177 %249 
					                       Private f32* %250 = OpAccessChain %102 %51 
					                                f32 %251 = OpLoad %250 
					                                f32 %252 = OpFMul %251 %248 
					                                f32 %253 = OpLoad %42 
					                                f32 %254 = OpFAdd %252 %253 
					                                             OpStore %42 %254 
					                                f32 %255 = OpLoad %177 
					                              f32_3 %256 = OpCompositeConstruct %255 %255 %255 
					                              f32_3 %257 = OpLoad %32 
					                              f32_3 %258 = OpFMul %256 %257 
					                              f32_3 %259 = OpLoad %9 
					                              f32_3 %260 = OpFAdd %258 %259 
					                                             OpStore %9 %260 
					                read_only Texture2D %261 = OpLoad %12 
					                            sampler %262 = OpLoad %16 
					         read_only Texture2DSampled %263 = OpSampledImage %261 %262 
					                              f32_2 %264 = OpLoad vs_TEXCOORD0 
					                              f32_4 %267 = OpImageSampleImplicitLod %263 %264 ConstOffset %29 
					                              f32_3 %268 = OpVectorShuffle %267 %267 0 1 2 
					                                             OpStore %32 %268 
					                read_only Texture2D %269 = OpLoad %43 
					                            sampler %270 = OpLoad %45 
					         read_only Texture2DSampled %271 = OpSampledImage %269 %270 
					                              f32_2 %272 = OpLoad vs_TEXCOORD0 
					                              f32_4 %273 = OpImageSampleImplicitLod %271 %272 ConstOffset %29 
					                                f32 %274 = OpCompositeExtract %273 0 
					                       Private f32* %275 = OpAccessChain %102 %51 
					                                             OpStore %275 %274 
					                       Uniform f32* %276 = OpAccessChain %55 %27 %56 
					                                f32 %277 = OpLoad %276 
					                       Private f32* %278 = OpAccessChain %102 %51 
					                                f32 %279 = OpLoad %278 
					                                f32 %280 = OpFMul %277 %279 
					                       Uniform f32* %281 = OpAccessChain %55 %27 %62 
					                                f32 %282 = OpLoad %281 
					                                f32 %283 = OpFAdd %280 %282 
					                       Private f32* %284 = OpAccessChain %102 %51 
					                                             OpStore %284 %283 
					                       Private f32* %285 = OpAccessChain %102 %51 
					                                f32 %286 = OpLoad %285 
					                                f32 %287 = OpFDiv %66 %286 
					                       Private f32* %288 = OpAccessChain %102 %51 
					                                             OpStore %288 %287 
					                                f32 %289 = OpLoad %69 
					                       Private f32* %290 = OpAccessChain %102 %51 
					                                f32 %291 = OpLoad %290 
					                                f32 %292 = OpFNegate %291 
					                                f32 %293 = OpFAdd %289 %292 
					                       Private f32* %294 = OpAccessChain %102 %51 
					                                             OpStore %294 %293 
					                       Private f32* %295 = OpAccessChain %102 %51 
					                                f32 %296 = OpLoad %295 
					                                f32 %297 = OpExtInst %1 4 %296 
					                                f32 %298 = OpFMul %297 %91 
					                       Private f32* %299 = OpAccessChain %102 %51 
					                                             OpStore %299 %298 
					                       Private f32* %300 = OpAccessChain %102 %51 
					                                f32 %301 = OpLoad %300 
					                       Private f32* %302 = OpAccessChain %102 %51 
					                                f32 %303 = OpLoad %302 
					                                f32 %304 = OpFMul %301 %303 
					                       Private f32* %305 = OpAccessChain %102 %51 
					                                             OpStore %305 %304 
					                       Private f32* %306 = OpAccessChain %102 %51 
					                                f32 %307 = OpLoad %306 
					                                f32 %308 = OpFMul %307 %97 
					                       Private f32* %309 = OpAccessChain %102 %51 
					                                             OpStore %309 %308 
					                       Private f32* %310 = OpAccessChain %102 %51 
					                                f32 %311 = OpLoad %310 
					                                f32 %312 = OpExtInst %1 29 %311 
					                       Private f32* %313 = OpAccessChain %102 %51 
					                                             OpStore %313 %312 
					                       Private f32* %314 = OpAccessChain %102 %51 
					                                f32 %315 = OpLoad %314 
					                                f32 %317 = OpFMul %315 %316 
					                                             OpStore %177 %317 
					                       Private f32* %318 = OpAccessChain %102 %51 
					                                f32 %319 = OpLoad %318 
					                                f32 %320 = OpFMul %319 %316 
					                                f32 %321 = OpLoad %42 
					                                f32 %322 = OpFAdd %320 %321 
					                                             OpStore %42 %322 
					                                f32 %323 = OpLoad %177 
					                              f32_3 %324 = OpCompositeConstruct %323 %323 %323 
					                              f32_3 %325 = OpLoad %32 
					                              f32_3 %326 = OpFMul %324 %325 
					                              f32_3 %327 = OpLoad %9 
					                              f32_3 %328 = OpFAdd %326 %327 
					                                             OpStore %9 %328 
					                read_only Texture2D %329 = OpLoad %12 
					                            sampler %330 = OpLoad %16 
					         read_only Texture2DSampled %331 = OpSampledImage %329 %330 
					                              f32_2 %332 = OpLoad vs_TEXCOORD0 
					                              f32_4 %335 = OpImageSampleImplicitLod %331 %332 ConstOffset %29 
					                              f32_3 %336 = OpVectorShuffle %335 %335 0 1 2 
					                                             OpStore %32 %336 
					                read_only Texture2D %337 = OpLoad %43 
					                            sampler %338 = OpLoad %45 
					         read_only Texture2DSampled %339 = OpSampledImage %337 %338 
					                              f32_2 %340 = OpLoad vs_TEXCOORD0 
					                              f32_4 %341 = OpImageSampleImplicitLod %339 %340 ConstOffset %29 
					                                f32 %342 = OpCompositeExtract %341 0 
					                       Private f32* %343 = OpAccessChain %102 %51 
					                                             OpStore %343 %342 
					                       Uniform f32* %344 = OpAccessChain %55 %27 %56 
					                                f32 %345 = OpLoad %344 
					                       Private f32* %346 = OpAccessChain %102 %51 
					                                f32 %347 = OpLoad %346 
					                                f32 %348 = OpFMul %345 %347 
					                       Uniform f32* %349 = OpAccessChain %55 %27 %62 
					                                f32 %350 = OpLoad %349 
					                                f32 %351 = OpFAdd %348 %350 
					                       Private f32* %352 = OpAccessChain %102 %51 
					                                             OpStore %352 %351 
					                       Private f32* %353 = OpAccessChain %102 %51 
					                                f32 %354 = OpLoad %353 
					                                f32 %355 = OpFDiv %66 %354 
					                       Private f32* %356 = OpAccessChain %102 %51 
					                                             OpStore %356 %355 
					                                f32 %357 = OpLoad %69 
					                       Private f32* %358 = OpAccessChain %102 %51 
					                                f32 %359 = OpLoad %358 
					                                f32 %360 = OpFNegate %359 
					                                f32 %361 = OpFAdd %357 %360 
					                       Private f32* %362 = OpAccessChain %102 %51 
					                                             OpStore %362 %361 
					                       Private f32* %363 = OpAccessChain %102 %51 
					                                f32 %364 = OpLoad %363 
					                                f32 %365 = OpExtInst %1 4 %364 
					                                f32 %366 = OpFMul %365 %91 
					                       Private f32* %367 = OpAccessChain %102 %51 
					                                             OpStore %367 %366 
					                       Private f32* %368 = OpAccessChain %102 %51 
					                                f32 %369 = OpLoad %368 
					                       Private f32* %370 = OpAccessChain %102 %51 
					                                f32 %371 = OpLoad %370 
					                                f32 %372 = OpFMul %369 %371 
					                       Private f32* %373 = OpAccessChain %102 %51 
					                                             OpStore %373 %372 
					                       Private f32* %374 = OpAccessChain %102 %51 
					                                f32 %375 = OpLoad %374 
					                                f32 %376 = OpFMul %375 %97 
					                       Private f32* %377 = OpAccessChain %102 %51 
					                                             OpStore %377 %376 
					                       Private f32* %378 = OpAccessChain %102 %51 
					                                f32 %379 = OpLoad %378 
					                                f32 %380 = OpExtInst %1 29 %379 
					                       Private f32* %381 = OpAccessChain %102 %51 
					                                             OpStore %381 %380 
					                       Private f32* %382 = OpAccessChain %102 %51 
					                                f32 %383 = OpLoad %382 
					                                f32 %385 = OpFMul %383 %384 
					                                             OpStore %177 %385 
					                       Private f32* %386 = OpAccessChain %102 %51 
					                                f32 %387 = OpLoad %386 
					                                f32 %388 = OpFMul %387 %384 
					                                f32 %389 = OpLoad %42 
					                                f32 %390 = OpFAdd %388 %389 
					                                             OpStore %42 %390 
					                                f32 %391 = OpLoad %177 
					                              f32_3 %392 = OpCompositeConstruct %391 %391 %391 
					                              f32_3 %393 = OpLoad %32 
					                              f32_3 %394 = OpFMul %392 %393 
					                              f32_3 %395 = OpLoad %9 
					                              f32_3 %396 = OpFAdd %394 %395 
					                                             OpStore %9 %396 
					                read_only Texture2D %397 = OpLoad %12 
					                            sampler %398 = OpLoad %16 
					         read_only Texture2DSampled %399 = OpSampledImage %397 %398 
					                              f32_2 %400 = OpLoad vs_TEXCOORD0 
					                              f32_4 %403 = OpImageSampleImplicitLod %399 %400 ConstOffset %29 
					                              f32_3 %404 = OpVectorShuffle %403 %403 0 1 2 
					                                             OpStore %32 %404 
					                read_only Texture2D %405 = OpLoad %43 
					                            sampler %406 = OpLoad %45 
					         read_only Texture2DSampled %407 = OpSampledImage %405 %406 
					                              f32_2 %408 = OpLoad vs_TEXCOORD0 
					                              f32_4 %409 = OpImageSampleImplicitLod %407 %408 ConstOffset %29 
					                                f32 %410 = OpCompositeExtract %409 0 
					                       Private f32* %411 = OpAccessChain %102 %51 
					                                             OpStore %411 %410 
					                       Uniform f32* %412 = OpAccessChain %55 %27 %56 
					                                f32 %413 = OpLoad %412 
					                       Private f32* %414 = OpAccessChain %102 %51 
					                                f32 %415 = OpLoad %414 
					                                f32 %416 = OpFMul %413 %415 
					                       Uniform f32* %417 = OpAccessChain %55 %27 %62 
					                                f32 %418 = OpLoad %417 
					                                f32 %419 = OpFAdd %416 %418 
					                       Private f32* %420 = OpAccessChain %102 %51 
					                                             OpStore %420 %419 
					                       Private f32* %421 = OpAccessChain %102 %51 
					                                f32 %422 = OpLoad %421 
					                                f32 %423 = OpFDiv %66 %422 
					                       Private f32* %424 = OpAccessChain %102 %51 
					                                             OpStore %424 %423 
					                                f32 %425 = OpLoad %69 
					                       Private f32* %426 = OpAccessChain %102 %51 
					                                f32 %427 = OpLoad %426 
					                                f32 %428 = OpFNegate %427 
					                                f32 %429 = OpFAdd %425 %428 
					                       Private f32* %430 = OpAccessChain %102 %51 
					                                             OpStore %430 %429 
					                       Private f32* %431 = OpAccessChain %102 %51 
					                                f32 %432 = OpLoad %431 
					                                f32 %433 = OpExtInst %1 4 %432 
					                                f32 %434 = OpFMul %433 %91 
					                       Private f32* %435 = OpAccessChain %102 %51 
					                                             OpStore %435 %434 
					                       Private f32* %436 = OpAccessChain %102 %51 
					                                f32 %437 = OpLoad %436 
					                       Private f32* %438 = OpAccessChain %102 %51 
					                                f32 %439 = OpLoad %438 
					                                f32 %440 = OpFMul %437 %439 
					                       Private f32* %441 = OpAccessChain %102 %51 
					                                             OpStore %441 %440 
					                       Private f32* %442 = OpAccessChain %102 %51 
					                                f32 %443 = OpLoad %442 
					                                f32 %444 = OpFMul %443 %97 
					                       Private f32* %445 = OpAccessChain %102 %51 
					                                             OpStore %445 %444 
					                       Private f32* %446 = OpAccessChain %102 %51 
					                                f32 %447 = OpLoad %446 
					                                f32 %448 = OpExtInst %1 29 %447 
					                       Private f32* %449 = OpAccessChain %102 %51 
					                                             OpStore %449 %448 
					                       Private f32* %450 = OpAccessChain %102 %51 
					                                f32 %451 = OpLoad %450 
					                                f32 %453 = OpFMul %451 %452 
					                                             OpStore %177 %453 
					                       Private f32* %454 = OpAccessChain %102 %51 
					                                f32 %455 = OpLoad %454 
					                                f32 %456 = OpFMul %455 %452 
					                                f32 %457 = OpLoad %42 
					                                f32 %458 = OpFAdd %456 %457 
					                                             OpStore %42 %458 
					                                f32 %459 = OpLoad %177 
					                              f32_3 %460 = OpCompositeConstruct %459 %459 %459 
					                              f32_3 %461 = OpLoad %32 
					                              f32_3 %462 = OpFMul %460 %461 
					                              f32_3 %463 = OpLoad %9 
					                              f32_3 %464 = OpFAdd %462 %463 
					                                             OpStore %9 %464 
					                read_only Texture2D %465 = OpLoad %12 
					                            sampler %466 = OpLoad %16 
					         read_only Texture2DSampled %467 = OpSampledImage %465 %466 
					                              f32_2 %468 = OpLoad vs_TEXCOORD0 
					                              f32_4 %471 = OpImageSampleImplicitLod %467 %468 ConstOffset %29 
					                              f32_3 %472 = OpVectorShuffle %471 %471 0 1 2 
					                                             OpStore %32 %472 
					                read_only Texture2D %473 = OpLoad %43 
					                            sampler %474 = OpLoad %45 
					         read_only Texture2DSampled %475 = OpSampledImage %473 %474 
					                              f32_2 %476 = OpLoad vs_TEXCOORD0 
					                              f32_4 %477 = OpImageSampleImplicitLod %475 %476 ConstOffset %29 
					                                f32 %478 = OpCompositeExtract %477 0 
					                       Private f32* %479 = OpAccessChain %102 %51 
					                                             OpStore %479 %478 
					                       Uniform f32* %480 = OpAccessChain %55 %27 %56 
					                                f32 %481 = OpLoad %480 
					                       Private f32* %482 = OpAccessChain %102 %51 
					                                f32 %483 = OpLoad %482 
					                                f32 %484 = OpFMul %481 %483 
					                       Uniform f32* %485 = OpAccessChain %55 %27 %62 
					                                f32 %486 = OpLoad %485 
					                                f32 %487 = OpFAdd %484 %486 
					                       Private f32* %488 = OpAccessChain %102 %51 
					                                             OpStore %488 %487 
					                       Private f32* %489 = OpAccessChain %102 %51 
					                                f32 %490 = OpLoad %489 
					                                f32 %491 = OpFDiv %66 %490 
					                       Private f32* %492 = OpAccessChain %102 %51 
					                                             OpStore %492 %491 
					                                f32 %493 = OpLoad %69 
					                       Private f32* %494 = OpAccessChain %102 %51 
					                                f32 %495 = OpLoad %494 
					                                f32 %496 = OpFNegate %495 
					                                f32 %497 = OpFAdd %493 %496 
					                       Private f32* %498 = OpAccessChain %102 %51 
					                                             OpStore %498 %497 
					                       Private f32* %499 = OpAccessChain %102 %51 
					                                f32 %500 = OpLoad %499 
					                                f32 %501 = OpExtInst %1 4 %500 
					                                f32 %502 = OpFMul %501 %91 
					                       Private f32* %503 = OpAccessChain %102 %51 
					                                             OpStore %503 %502 
					                       Private f32* %504 = OpAccessChain %102 %51 
					                                f32 %505 = OpLoad %504 
					                       Private f32* %506 = OpAccessChain %102 %51 
					                                f32 %507 = OpLoad %506 
					                                f32 %508 = OpFMul %505 %507 
					                       Private f32* %509 = OpAccessChain %102 %51 
					                                             OpStore %509 %508 
					                       Private f32* %510 = OpAccessChain %102 %51 
					                                f32 %511 = OpLoad %510 
					                                f32 %512 = OpFMul %511 %97 
					                       Private f32* %513 = OpAccessChain %102 %51 
					                                             OpStore %513 %512 
					                       Private f32* %514 = OpAccessChain %102 %51 
					                                f32 %515 = OpLoad %514 
					                                f32 %516 = OpExtInst %1 29 %515 
					                       Private f32* %517 = OpAccessChain %102 %51 
					                                             OpStore %517 %516 
					                       Private f32* %518 = OpAccessChain %102 %51 
					                                f32 %519 = OpLoad %518 
					                                f32 %520 = OpFMul %519 %452 
					                                             OpStore %177 %520 
					                       Private f32* %521 = OpAccessChain %102 %51 
					                                f32 %522 = OpLoad %521 
					                                f32 %523 = OpFMul %522 %452 
					                                f32 %524 = OpLoad %42 
					                                f32 %525 = OpFAdd %523 %524 
					                                             OpStore %42 %525 
					                                f32 %526 = OpLoad %177 
					                              f32_3 %527 = OpCompositeConstruct %526 %526 %526 
					                              f32_3 %528 = OpLoad %32 
					                              f32_3 %529 = OpFMul %527 %528 
					                              f32_3 %530 = OpLoad %9 
					                              f32_3 %531 = OpFAdd %529 %530 
					                                             OpStore %9 %531 
					                read_only Texture2D %532 = OpLoad %12 
					                            sampler %533 = OpLoad %16 
					         read_only Texture2DSampled %534 = OpSampledImage %532 %533 
					                              f32_2 %535 = OpLoad vs_TEXCOORD0 
					                              f32_4 %538 = OpImageSampleImplicitLod %534 %535 ConstOffset %29 
					                              f32_3 %539 = OpVectorShuffle %538 %538 0 1 2 
					                                             OpStore %32 %539 
					                read_only Texture2D %540 = OpLoad %43 
					                            sampler %541 = OpLoad %45 
					         read_only Texture2DSampled %542 = OpSampledImage %540 %541 
					                              f32_2 %543 = OpLoad vs_TEXCOORD0 
					                              f32_4 %544 = OpImageSampleImplicitLod %542 %543 ConstOffset %29 
					                                f32 %545 = OpCompositeExtract %544 0 
					                       Private f32* %546 = OpAccessChain %102 %51 
					                                             OpStore %546 %545 
					                       Uniform f32* %547 = OpAccessChain %55 %27 %56 
					                                f32 %548 = OpLoad %547 
					                       Private f32* %549 = OpAccessChain %102 %51 
					                                f32 %550 = OpLoad %549 
					                                f32 %551 = OpFMul %548 %550 
					                       Uniform f32* %552 = OpAccessChain %55 %27 %62 
					                                f32 %553 = OpLoad %552 
					                                f32 %554 = OpFAdd %551 %553 
					                       Private f32* %555 = OpAccessChain %102 %51 
					                                             OpStore %555 %554 
					                       Private f32* %556 = OpAccessChain %102 %51 
					                                f32 %557 = OpLoad %556 
					                                f32 %558 = OpFDiv %66 %557 
					                       Private f32* %559 = OpAccessChain %102 %51 
					                                             OpStore %559 %558 
					                                f32 %560 = OpLoad %69 
					                       Private f32* %561 = OpAccessChain %102 %51 
					                                f32 %562 = OpLoad %561 
					                                f32 %563 = OpFNegate %562 
					                                f32 %564 = OpFAdd %560 %563 
					                       Private f32* %565 = OpAccessChain %102 %51 
					                                             OpStore %565 %564 
					                       Private f32* %566 = OpAccessChain %102 %51 
					                                f32 %567 = OpLoad %566 
					                                f32 %568 = OpExtInst %1 4 %567 
					                                f32 %569 = OpFMul %568 %91 
					                       Private f32* %570 = OpAccessChain %102 %51 
					                                             OpStore %570 %569 
					                       Private f32* %571 = OpAccessChain %102 %51 
					                                f32 %572 = OpLoad %571 
					                       Private f32* %573 = OpAccessChain %102 %51 
					                                f32 %574 = OpLoad %573 
					                                f32 %575 = OpFMul %572 %574 
					                       Private f32* %576 = OpAccessChain %102 %51 
					                                             OpStore %576 %575 
					                       Private f32* %577 = OpAccessChain %102 %51 
					                                f32 %578 = OpLoad %577 
					                                f32 %579 = OpFMul %578 %97 
					                       Private f32* %580 = OpAccessChain %102 %51 
					                                             OpStore %580 %579 
					                       Private f32* %581 = OpAccessChain %102 %51 
					                                f32 %582 = OpLoad %581 
					                                f32 %583 = OpExtInst %1 29 %582 
					                       Private f32* %584 = OpAccessChain %102 %51 
					                                             OpStore %584 %583 
					                       Private f32* %585 = OpAccessChain %102 %51 
					                                f32 %586 = OpLoad %585 
					                                f32 %587 = OpFMul %586 %384 
					                                             OpStore %177 %587 
					                       Private f32* %588 = OpAccessChain %102 %51 
					                                f32 %589 = OpLoad %588 
					                                f32 %590 = OpFMul %589 %384 
					                                f32 %591 = OpLoad %42 
					                                f32 %592 = OpFAdd %590 %591 
					                                             OpStore %42 %592 
					                                f32 %593 = OpLoad %177 
					                              f32_3 %594 = OpCompositeConstruct %593 %593 %593 
					                              f32_3 %595 = OpLoad %32 
					                              f32_3 %596 = OpFMul %594 %595 
					                              f32_3 %597 = OpLoad %9 
					                              f32_3 %598 = OpFAdd %596 %597 
					                                             OpStore %9 %598 
					                read_only Texture2D %599 = OpLoad %12 
					                            sampler %600 = OpLoad %16 
					         read_only Texture2DSampled %601 = OpSampledImage %599 %600 
					                              f32_2 %602 = OpLoad vs_TEXCOORD0 
					                              f32_4 %605 = OpImageSampleImplicitLod %601 %602 ConstOffset %29 
					                              f32_3 %606 = OpVectorShuffle %605 %605 0 1 2 
					                                             OpStore %32 %606 
					                read_only Texture2D %607 = OpLoad %43 
					                            sampler %608 = OpLoad %45 
					         read_only Texture2DSampled %609 = OpSampledImage %607 %608 
					                              f32_2 %610 = OpLoad vs_TEXCOORD0 
					                              f32_4 %611 = OpImageSampleImplicitLod %609 %610 ConstOffset %29 
					                                f32 %612 = OpCompositeExtract %611 0 
					                       Private f32* %613 = OpAccessChain %102 %51 
					                                             OpStore %613 %612 
					                       Uniform f32* %614 = OpAccessChain %55 %27 %56 
					                                f32 %615 = OpLoad %614 
					                       Private f32* %616 = OpAccessChain %102 %51 
					                                f32 %617 = OpLoad %616 
					                                f32 %618 = OpFMul %615 %617 
					                       Uniform f32* %619 = OpAccessChain %55 %27 %62 
					                                f32 %620 = OpLoad %619 
					                                f32 %621 = OpFAdd %618 %620 
					                       Private f32* %622 = OpAccessChain %102 %51 
					                                             OpStore %622 %621 
					                       Private f32* %623 = OpAccessChain %102 %51 
					                                f32 %624 = OpLoad %623 
					                                f32 %625 = OpFDiv %66 %624 
					                       Private f32* %626 = OpAccessChain %102 %51 
					                                             OpStore %626 %625 
					                                f32 %627 = OpLoad %69 
					                       Private f32* %628 = OpAccessChain %102 %51 
					                                f32 %629 = OpLoad %628 
					                                f32 %630 = OpFNegate %629 
					                                f32 %631 = OpFAdd %627 %630 
					                       Private f32* %632 = OpAccessChain %102 %51 
					                                             OpStore %632 %631 
					                       Private f32* %633 = OpAccessChain %102 %51 
					                                f32 %634 = OpLoad %633 
					                                f32 %635 = OpExtInst %1 4 %634 
					                                f32 %636 = OpFMul %635 %91 
					                       Private f32* %637 = OpAccessChain %102 %51 
					                                             OpStore %637 %636 
					                       Private f32* %638 = OpAccessChain %102 %51 
					                                f32 %639 = OpLoad %638 
					                       Private f32* %640 = OpAccessChain %102 %51 
					                                f32 %641 = OpLoad %640 
					                                f32 %642 = OpFMul %639 %641 
					                       Private f32* %643 = OpAccessChain %102 %51 
					                                             OpStore %643 %642 
					                       Private f32* %644 = OpAccessChain %102 %51 
					                                f32 %645 = OpLoad %644 
					                                f32 %646 = OpFMul %645 %97 
					                       Private f32* %647 = OpAccessChain %102 %51 
					                                             OpStore %647 %646 
					                       Private f32* %648 = OpAccessChain %102 %51 
					                                f32 %649 = OpLoad %648 
					                                f32 %650 = OpExtInst %1 29 %649 
					                       Private f32* %651 = OpAccessChain %102 %51 
					                                             OpStore %651 %650 
					                       Private f32* %652 = OpAccessChain %102 %51 
					                                f32 %653 = OpLoad %652 
					                                f32 %654 = OpFMul %653 %316 
					                                             OpStore %177 %654 
					                       Private f32* %655 = OpAccessChain %102 %51 
					                                f32 %656 = OpLoad %655 
					                                f32 %657 = OpFMul %656 %316 
					                                f32 %658 = OpLoad %42 
					                                f32 %659 = OpFAdd %657 %658 
					                                             OpStore %42 %659 
					                                f32 %660 = OpLoad %177 
					                              f32_3 %661 = OpCompositeConstruct %660 %660 %660 
					                              f32_3 %662 = OpLoad %32 
					                              f32_3 %663 = OpFMul %661 %662 
					                              f32_3 %664 = OpLoad %9 
					                              f32_3 %665 = OpFAdd %663 %664 
					                                             OpStore %9 %665 
					                read_only Texture2D %666 = OpLoad %12 
					                            sampler %667 = OpLoad %16 
					         read_only Texture2DSampled %668 = OpSampledImage %666 %667 
					                              f32_2 %669 = OpLoad vs_TEXCOORD0 
					                              f32_4 %672 = OpImageSampleImplicitLod %668 %669 ConstOffset %29 
					                              f32_3 %673 = OpVectorShuffle %672 %672 0 1 2 
					                                             OpStore %32 %673 
					                read_only Texture2D %674 = OpLoad %43 
					                            sampler %675 = OpLoad %45 
					         read_only Texture2DSampled %676 = OpSampledImage %674 %675 
					                              f32_2 %677 = OpLoad vs_TEXCOORD0 
					                              f32_4 %678 = OpImageSampleImplicitLod %676 %677 ConstOffset %29 
					                                f32 %679 = OpCompositeExtract %678 0 
					                       Private f32* %680 = OpAccessChain %102 %51 
					                                             OpStore %680 %679 
					                       Uniform f32* %681 = OpAccessChain %55 %27 %56 
					                                f32 %682 = OpLoad %681 
					                       Private f32* %683 = OpAccessChain %102 %51 
					                                f32 %684 = OpLoad %683 
					                                f32 %685 = OpFMul %682 %684 
					                       Uniform f32* %686 = OpAccessChain %55 %27 %62 
					                                f32 %687 = OpLoad %686 
					                                f32 %688 = OpFAdd %685 %687 
					                       Private f32* %689 = OpAccessChain %102 %51 
					                                             OpStore %689 %688 
					                       Private f32* %690 = OpAccessChain %102 %51 
					                                f32 %691 = OpLoad %690 
					                                f32 %692 = OpFDiv %66 %691 
					                       Private f32* %693 = OpAccessChain %102 %51 
					                                             OpStore %693 %692 
					                                f32 %694 = OpLoad %69 
					                       Private f32* %695 = OpAccessChain %102 %51 
					                                f32 %696 = OpLoad %695 
					                                f32 %697 = OpFNegate %696 
					                                f32 %698 = OpFAdd %694 %697 
					                       Private f32* %699 = OpAccessChain %102 %51 
					                                             OpStore %699 %698 
					                       Private f32* %700 = OpAccessChain %102 %51 
					                                f32 %701 = OpLoad %700 
					                                f32 %702 = OpExtInst %1 4 %701 
					                                f32 %703 = OpFMul %702 %91 
					                       Private f32* %704 = OpAccessChain %102 %51 
					                                             OpStore %704 %703 
					                       Private f32* %705 = OpAccessChain %102 %51 
					                                f32 %706 = OpLoad %705 
					                       Private f32* %707 = OpAccessChain %102 %51 
					                                f32 %708 = OpLoad %707 
					                                f32 %709 = OpFMul %706 %708 
					                       Private f32* %710 = OpAccessChain %102 %51 
					                                             OpStore %710 %709 
					                       Private f32* %711 = OpAccessChain %102 %51 
					                                f32 %712 = OpLoad %711 
					                                f32 %713 = OpFMul %712 %97 
					                       Private f32* %714 = OpAccessChain %102 %51 
					                                             OpStore %714 %713 
					                       Private f32* %715 = OpAccessChain %102 %51 
					                                f32 %716 = OpLoad %715 
					                                f32 %717 = OpExtInst %1 29 %716 
					                       Private f32* %718 = OpAccessChain %102 %51 
					                                             OpStore %718 %717 
					                       Private f32* %719 = OpAccessChain %102 %51 
					                                f32 %720 = OpLoad %719 
					                                f32 %721 = OpFMul %720 %248 
					                                             OpStore %177 %721 
					                       Private f32* %722 = OpAccessChain %102 %51 
					                                f32 %723 = OpLoad %722 
					                                f32 %724 = OpFMul %723 %248 
					                                f32 %725 = OpLoad %42 
					                                f32 %726 = OpFAdd %724 %725 
					                                             OpStore %42 %726 
					                                f32 %727 = OpLoad %177 
					                              f32_3 %728 = OpCompositeConstruct %727 %727 %727 
					                              f32_3 %729 = OpLoad %32 
					                              f32_3 %730 = OpFMul %728 %729 
					                              f32_3 %731 = OpLoad %9 
					                              f32_3 %732 = OpFAdd %730 %731 
					                                             OpStore %9 %732 
					                read_only Texture2D %733 = OpLoad %12 
					                            sampler %734 = OpLoad %16 
					         read_only Texture2DSampled %735 = OpSampledImage %733 %734 
					                              f32_2 %736 = OpLoad vs_TEXCOORD0 
					                              f32_4 %739 = OpImageSampleImplicitLod %735 %736 ConstOffset %29 
					                              f32_3 %740 = OpVectorShuffle %739 %739 0 1 2 
					                                             OpStore %32 %740 
					                read_only Texture2D %741 = OpLoad %43 
					                            sampler %742 = OpLoad %45 
					         read_only Texture2DSampled %743 = OpSampledImage %741 %742 
					                              f32_2 %744 = OpLoad vs_TEXCOORD0 
					                              f32_4 %745 = OpImageSampleImplicitLod %743 %744 ConstOffset %29 
					                                f32 %746 = OpCompositeExtract %745 0 
					                       Private f32* %747 = OpAccessChain %102 %51 
					                                             OpStore %747 %746 
					                       Uniform f32* %748 = OpAccessChain %55 %27 %56 
					                                f32 %749 = OpLoad %748 
					                       Private f32* %750 = OpAccessChain %102 %51 
					                                f32 %751 = OpLoad %750 
					                                f32 %752 = OpFMul %749 %751 
					                       Uniform f32* %753 = OpAccessChain %55 %27 %62 
					                                f32 %754 = OpLoad %753 
					                                f32 %755 = OpFAdd %752 %754 
					                       Private f32* %756 = OpAccessChain %102 %51 
					                                             OpStore %756 %755 
					                       Private f32* %757 = OpAccessChain %102 %51 
					                                f32 %758 = OpLoad %757 
					                                f32 %759 = OpFDiv %66 %758 
					                       Private f32* %760 = OpAccessChain %102 %51 
					                                             OpStore %760 %759 
					                                f32 %761 = OpLoad %69 
					                       Private f32* %762 = OpAccessChain %102 %51 
					                                f32 %763 = OpLoad %762 
					                                f32 %764 = OpFNegate %763 
					                                f32 %765 = OpFAdd %761 %764 
					                       Private f32* %766 = OpAccessChain %102 %51 
					                                             OpStore %766 %765 
					                       Private f32* %767 = OpAccessChain %102 %51 
					                                f32 %768 = OpLoad %767 
					                                f32 %769 = OpExtInst %1 4 %768 
					                                f32 %770 = OpFMul %769 %91 
					                       Private f32* %771 = OpAccessChain %102 %51 
					                                             OpStore %771 %770 
					                       Private f32* %772 = OpAccessChain %102 %51 
					                                f32 %773 = OpLoad %772 
					                       Private f32* %774 = OpAccessChain %102 %51 
					                                f32 %775 = OpLoad %774 
					                                f32 %776 = OpFMul %773 %775 
					                       Private f32* %777 = OpAccessChain %102 %51 
					                                             OpStore %777 %776 
					                       Private f32* %778 = OpAccessChain %102 %51 
					                                f32 %779 = OpLoad %778 
					                                f32 %780 = OpFMul %779 %97 
					                       Private f32* %781 = OpAccessChain %102 %51 
					                                             OpStore %781 %780 
					                       Private f32* %782 = OpAccessChain %102 %51 
					                                f32 %783 = OpLoad %782 
					                                f32 %784 = OpExtInst %1 29 %783 
					                       Private f32* %785 = OpAccessChain %102 %51 
					                                             OpStore %785 %784 
					                       Private f32* %786 = OpAccessChain %102 %51 
					                                f32 %787 = OpLoad %786 
					                                f32 %788 = OpFMul %787 %180 
					                                             OpStore %177 %788 
					                       Private f32* %789 = OpAccessChain %102 %51 
					                                f32 %790 = OpLoad %789 
					                                f32 %791 = OpFMul %790 %180 
					                                f32 %792 = OpLoad %42 
					                                f32 %793 = OpFAdd %791 %792 
					                                             OpStore %42 %793 
					                                f32 %794 = OpLoad %177 
					                              f32_3 %795 = OpCompositeConstruct %794 %794 %794 
					                              f32_3 %796 = OpLoad %32 
					                              f32_3 %797 = OpFMul %795 %796 
					                              f32_3 %798 = OpLoad %9 
					                              f32_3 %799 = OpFAdd %797 %798 
					                                             OpStore %9 %799 
					                read_only Texture2D %800 = OpLoad %12 
					                            sampler %801 = OpLoad %16 
					         read_only Texture2DSampled %802 = OpSampledImage %800 %801 
					                              f32_2 %803 = OpLoad vs_TEXCOORD0 
					                              f32_4 %806 = OpImageSampleImplicitLod %802 %803 ConstOffset %29 
					                              f32_3 %807 = OpVectorShuffle %806 %806 0 1 2 
					                                             OpStore %32 %807 
					                read_only Texture2D %808 = OpLoad %43 
					                            sampler %809 = OpLoad %45 
					         read_only Texture2DSampled %810 = OpSampledImage %808 %809 
					                              f32_2 %811 = OpLoad vs_TEXCOORD0 
					                              f32_4 %812 = OpImageSampleImplicitLod %810 %811 ConstOffset %29 
					                                f32 %813 = OpCompositeExtract %812 0 
					                       Private f32* %814 = OpAccessChain %102 %51 
					                                             OpStore %814 %813 
					                       Uniform f32* %815 = OpAccessChain %55 %27 %56 
					                                f32 %816 = OpLoad %815 
					                       Private f32* %817 = OpAccessChain %102 %51 
					                                f32 %818 = OpLoad %817 
					                                f32 %819 = OpFMul %816 %818 
					                       Uniform f32* %820 = OpAccessChain %55 %27 %62 
					                                f32 %821 = OpLoad %820 
					                                f32 %822 = OpFAdd %819 %821 
					                       Private f32* %823 = OpAccessChain %102 %51 
					                                             OpStore %823 %822 
					                       Private f32* %824 = OpAccessChain %102 %51 
					                                f32 %825 = OpLoad %824 
					                                f32 %826 = OpFDiv %66 %825 
					                       Private f32* %827 = OpAccessChain %102 %51 
					                                             OpStore %827 %826 
					                                f32 %828 = OpLoad %69 
					                       Private f32* %829 = OpAccessChain %102 %51 
					                                f32 %830 = OpLoad %829 
					                                f32 %831 = OpFNegate %830 
					                                f32 %832 = OpFAdd %828 %831 
					                                             OpStore %69 %832 
					                                f32 %833 = OpLoad %69 
					                                f32 %834 = OpExtInst %1 4 %833 
					                                f32 %835 = OpFMul %834 %91 
					                                             OpStore %69 %835 
					                                f32 %836 = OpLoad %69 
					                                f32 %837 = OpLoad %69 
					                                f32 %838 = OpFMul %836 %837 
					                                             OpStore %69 %838 
					                                f32 %839 = OpLoad %69 
					                                f32 %840 = OpFMul %839 %97 
					                                             OpStore %69 %840 
					                                f32 %841 = OpLoad %69 
					                                f32 %842 = OpExtInst %1 29 %841 
					                                             OpStore %69 %842 
					                                f32 %843 = OpLoad %69 
					                                f32 %844 = OpFMul %843 %104 
					                       Private f32* %845 = OpAccessChain %102 %51 
					                                             OpStore %845 %844 
					                                f32 %846 = OpLoad %69 
					                                f32 %847 = OpFMul %846 %104 
					                                f32 %848 = OpLoad %42 
					                                f32 %849 = OpFAdd %847 %848 
					                                             OpStore %42 %849 
					                              f32_4 %850 = OpLoad %102 
					                              f32_3 %851 = OpVectorShuffle %850 %850 0 0 0 
					                              f32_3 %852 = OpLoad %32 
					                              f32_3 %853 = OpFMul %851 %852 
					                              f32_3 %854 = OpLoad %9 
					                              f32_3 %855 = OpFAdd %853 %854 
					                                             OpStore %9 %855 
					                              f32_3 %856 = OpLoad %9 
					                                f32 %857 = OpLoad %42 
					                              f32_3 %858 = OpCompositeConstruct %857 %857 %857 
					                              f32_3 %859 = OpFDiv %856 %858 
					                              f32_4 %860 = OpLoad %127 
					                              f32_4 %861 = OpVectorShuffle %860 %859 4 5 6 3 
					                                             OpStore %127 %861 
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[7];
						vec4 _ZBufferParams;
						vec4 unused_0_2;
					};
					uniform  sampler2D _QuarterResDepthBuffer;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat5;
					float u_xlat6;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-5, 0));
					    u_xlat1 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-6, 0));
					    u_xlat2 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-6, 0));
					    u_xlat12 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat2 = texture(_QuarterResDepthBuffer, vs_TEXCOORD0.xy);
					    u_xlat13 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat12 = (-u_xlat12) + u_xlat13;
					    u_xlat12 = abs(u_xlat12) * 0.5;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat12 = u_xlat12 * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat2.x = u_xlat12 * 0.0323794;
					    u_xlat12 = u_xlat12 * 0.0323794 + 0.0997355729;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat2.xyz * vec3(0.0997355729, 0.0997355729, 0.0997355729) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat2 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-5, 0));
					    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.x = u_xlat13 + (-u_xlat2.x);
					    u_xlat2.x = abs(u_xlat2.x) * 0.5;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * -1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat6 = u_xlat2.x * 0.0456622727;
					    u_xlat12 = u_xlat2.x * 0.0456622727 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-4, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-4, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0604926832;
					    u_xlat12 = u_xlat1.x * 0.0604926832 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-3, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-3, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0752843618;
					    u_xlat12 = u_xlat1.x * 0.0752843618 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-2, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-2, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0880163312;
					    u_xlat12 = u_xlat1.x * 0.0880163312 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(-1, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(-1, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.096667029;
					    u_xlat12 = u_xlat1.x * 0.096667029 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(1, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(1, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.096667029;
					    u_xlat12 = u_xlat1.x * 0.096667029 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(2, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(2, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0880163312;
					    u_xlat12 = u_xlat1.x * 0.0880163312 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(3, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(3, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0752843618;
					    u_xlat12 = u_xlat1.x * 0.0752843618 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(4, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(4, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0604926832;
					    u_xlat12 = u_xlat1.x * 0.0604926832 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(5, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(5, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0456622727;
					    u_xlat12 = u_xlat1.x * 0.0456622727 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(6, 0));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(6, 0));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0323794;
					    u_xlat12 = u_xlat1.x * 0.0323794 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz / vec3(u_xlat12);
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
			GpuProgramID 611475
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
					UNITY_LOCATION(0) uniform  sampler2D _QuarterResDepthBuffer;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat5;
					float u_xlat6;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -5));
					    u_xlat1 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -6));
					    u_xlat2 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -6));
					    u_xlat12 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat2 = texture(_QuarterResDepthBuffer, vs_TEXCOORD0.xy);
					    u_xlat13 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat12 = (-u_xlat12) + u_xlat13;
					    u_xlat12 = abs(u_xlat12) * 0.5;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat12 = u_xlat12 * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat2.x = u_xlat12 * 0.0323794;
					    u_xlat12 = u_xlat12 * 0.0323794 + 0.0997355729;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat2.xyz * vec3(0.0997355729, 0.0997355729, 0.0997355729) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat2 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -5));
					    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.x = u_xlat13 + (-u_xlat2.x);
					    u_xlat2.x = abs(u_xlat2.x) * 0.5;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * -1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat6 = u_xlat2.x * 0.0456622727;
					    u_xlat12 = u_xlat2.x * 0.0456622727 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -4));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -4));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0604926832;
					    u_xlat12 = u_xlat1.x * 0.0604926832 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -3));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -3));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0752843618;
					    u_xlat12 = u_xlat1.x * 0.0752843618 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -2));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -2));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0880163312;
					    u_xlat12 = u_xlat1.x * 0.0880163312 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -1));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -1));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.096667029;
					    u_xlat12 = u_xlat1.x * 0.096667029 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 1));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 1));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.096667029;
					    u_xlat12 = u_xlat1.x * 0.096667029 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 2));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 2));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0880163312;
					    u_xlat12 = u_xlat1.x * 0.0880163312 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 3));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 3));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0752843618;
					    u_xlat12 = u_xlat1.x * 0.0752843618 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 4));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 4));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0604926832;
					    u_xlat12 = u_xlat1.x * 0.0604926832 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 5));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 5));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0456622727;
					    u_xlat12 = u_xlat1.x * 0.0456622727 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 6));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 6));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0323794;
					    u_xlat12 = u_xlat1.x * 0.0323794 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz / vec3(u_xlat12);
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
					; Bound: 863
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %127 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %43 DescriptorSet 43 
					                                             OpDecorate %43 Binding 43 
					                                             OpDecorate %45 DescriptorSet 45 
					                                             OpDecorate %45 Binding 45 
					                                             OpMemberDecorate %53 0 Offset 53 
					                                             OpDecorate %53 Block 
					                                             OpDecorate %55 DescriptorSet 55 
					                                             OpDecorate %55 Binding 55 
					                                             OpDecorate %127 Location 127 
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
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %24 = OpTypeInt 32 1 
					                                     %25 = OpTypeVector %24 2 
					                                 i32 %26 = OpConstant 0 
					                                 i32 %27 = OpConstant -5 
					                               i32_2 %28 = OpConstantComposite %26 %27 
					                                     %29 = OpTypeVector %6 4 
					                      Private f32_3* %32 = OpVariable Private 
					                                 i32 %37 = OpConstant -6 
					                               i32_2 %38 = OpConstantComposite %26 %37 
					                                     %41 = OpTypePointer Private %6 
					                        Private f32* %42 = OpVariable Private 
					UniformConstant read_only Texture2D* %43 = OpVariable UniformConstant 
					            UniformConstant sampler* %45 = OpVariable UniformConstant 
					                                     %50 = OpTypeInt 32 0 
					                                 u32 %51 = OpConstant 0 
					                                     %53 = OpTypeStruct %29 
					                                     %54 = OpTypePointer Uniform %53 
					            Uniform struct {f32_4;}* %55 = OpVariable Uniform 
					                                 u32 %56 = OpConstant 2 
					                                     %57 = OpTypePointer Uniform %6 
					                                 u32 %62 = OpConstant 3 
					                                 f32 %66 = OpConstant 3,674022E-40 
					                        Private f32* %69 = OpVariable Private 
					                                 f32 %91 = OpConstant 3,674022E-40 
					                                 f32 %97 = OpConstant 3,674022E-40 
					                                    %101 = OpTypePointer Private %29 
					                     Private f32_4* %102 = OpVariable Private 
					                                f32 %104 = OpConstant 3,674022E-40 
					                                f32 %109 = OpConstant 3,674022E-40 
					                              f32_3 %122 = OpConstantComposite %109 %109 %109 
					                                    %126 = OpTypePointer Output %29 
					                      Output f32_4* %127 = OpVariable Output 
					                                    %130 = OpTypePointer Output %6 
					                       Private f32* %177 = OpVariable Private 
					                                f32 %180 = OpConstant 3,674022E-40 
					                                i32 %197 = OpConstant -4 
					                              i32_2 %198 = OpConstantComposite %26 %197 
					                                f32 %248 = OpConstant 3,674022E-40 
					                                i32 %265 = OpConstant -3 
					                              i32_2 %266 = OpConstantComposite %26 %265 
					                                f32 %316 = OpConstant 3,674022E-40 
					                                i32 %333 = OpConstant -2 
					                              i32_2 %334 = OpConstantComposite %26 %333 
					                                f32 %384 = OpConstant 3,674022E-40 
					                                i32 %401 = OpConstant -1 
					                              i32_2 %402 = OpConstantComposite %26 %401 
					                                f32 %452 = OpConstant 3,674022E-40 
					                                i32 %469 = OpConstant 1 
					                              i32_2 %470 = OpConstantComposite %26 %469 
					                                i32 %536 = OpConstant 2 
					                              i32_2 %537 = OpConstantComposite %26 %536 
					                                i32 %603 = OpConstant 3 
					                              i32_2 %604 = OpConstantComposite %26 %603 
					                                i32 %670 = OpConstant 4 
					                              i32_2 %671 = OpConstantComposite %26 %670 
					                                i32 %737 = OpConstant 5 
					                              i32_2 %738 = OpConstantComposite %26 %737 
					                                i32 %804 = OpConstant 6 
					                              i32_2 %805 = OpConstantComposite %26 %804 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %30 = OpImageSampleImplicitLod %19 %23 ConstOffset %29 
					                               f32_3 %31 = OpVectorShuffle %30 %30 0 1 2 
					                                             OpStore %9 %31 
					                 read_only Texture2D %33 = OpLoad %12 
					                             sampler %34 = OpLoad %16 
					          read_only Texture2DSampled %35 = OpSampledImage %33 %34 
					                               f32_2 %36 = OpLoad vs_TEXCOORD0 
					                               f32_4 %39 = OpImageSampleImplicitLod %35 %36 ConstOffset %29 
					                               f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
					                                             OpStore %32 %40 
					                 read_only Texture2D %44 = OpLoad %43 
					                             sampler %46 = OpLoad %45 
					          read_only Texture2DSampled %47 = OpSampledImage %44 %46 
					                               f32_2 %48 = OpLoad vs_TEXCOORD0 
					                               f32_4 %49 = OpImageSampleImplicitLod %47 %48 ConstOffset %29 
					                                 f32 %52 = OpCompositeExtract %49 0 
					                                             OpStore %42 %52 
					                        Uniform f32* %58 = OpAccessChain %55 %26 %56 
					                                 f32 %59 = OpLoad %58 
					                                 f32 %60 = OpLoad %42 
					                                 f32 %61 = OpFMul %59 %60 
					                        Uniform f32* %63 = OpAccessChain %55 %26 %62 
					                                 f32 %64 = OpLoad %63 
					                                 f32 %65 = OpFAdd %61 %64 
					                                             OpStore %42 %65 
					                                 f32 %67 = OpLoad %42 
					                                 f32 %68 = OpFDiv %66 %67 
					                                             OpStore %42 %68 
					                 read_only Texture2D %70 = OpLoad %43 
					                             sampler %71 = OpLoad %45 
					          read_only Texture2DSampled %72 = OpSampledImage %70 %71 
					                               f32_2 %73 = OpLoad vs_TEXCOORD0 
					                               f32_4 %74 = OpImageSampleImplicitLod %72 %73 
					                                 f32 %75 = OpCompositeExtract %74 0 
					                                             OpStore %69 %75 
					                        Uniform f32* %76 = OpAccessChain %55 %26 %56 
					                                 f32 %77 = OpLoad %76 
					                                 f32 %78 = OpLoad %69 
					                                 f32 %79 = OpFMul %77 %78 
					                        Uniform f32* %80 = OpAccessChain %55 %26 %62 
					                                 f32 %81 = OpLoad %80 
					                                 f32 %82 = OpFAdd %79 %81 
					                                             OpStore %69 %82 
					                                 f32 %83 = OpLoad %69 
					                                 f32 %84 = OpFDiv %66 %83 
					                                             OpStore %69 %84 
					                                 f32 %85 = OpLoad %42 
					                                 f32 %86 = OpFNegate %85 
					                                 f32 %87 = OpLoad %69 
					                                 f32 %88 = OpFAdd %86 %87 
					                                             OpStore %42 %88 
					                                 f32 %89 = OpLoad %42 
					                                 f32 %90 = OpExtInst %1 4 %89 
					                                 f32 %92 = OpFMul %90 %91 
					                                             OpStore %42 %92 
					                                 f32 %93 = OpLoad %42 
					                                 f32 %94 = OpLoad %42 
					                                 f32 %95 = OpFMul %93 %94 
					                                             OpStore %42 %95 
					                                 f32 %96 = OpLoad %42 
					                                 f32 %98 = OpFMul %96 %97 
					                                             OpStore %42 %98 
					                                 f32 %99 = OpLoad %42 
					                                f32 %100 = OpExtInst %1 29 %99 
					                                             OpStore %42 %100 
					                                f32 %103 = OpLoad %42 
					                                f32 %105 = OpFMul %103 %104 
					                       Private f32* %106 = OpAccessChain %102 %51 
					                                             OpStore %106 %105 
					                                f32 %107 = OpLoad %42 
					                                f32 %108 = OpFMul %107 %104 
					                                f32 %110 = OpFAdd %108 %109 
					                                             OpStore %42 %110 
					                              f32_3 %111 = OpLoad %32 
					                              f32_4 %112 = OpLoad %102 
					                              f32_3 %113 = OpVectorShuffle %112 %112 0 0 0 
					                              f32_3 %114 = OpFMul %111 %113 
					                                             OpStore %32 %114 
					                read_only Texture2D %115 = OpLoad %12 
					                            sampler %116 = OpLoad %16 
					         read_only Texture2DSampled %117 = OpSampledImage %115 %116 
					                              f32_2 %118 = OpLoad vs_TEXCOORD0 
					                              f32_4 %119 = OpImageSampleImplicitLod %117 %118 
					                                             OpStore %102 %119 
					                              f32_4 %120 = OpLoad %102 
					                              f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                              f32_3 %123 = OpFMul %121 %122 
					                              f32_3 %124 = OpLoad %32 
					                              f32_3 %125 = OpFAdd %123 %124 
					                                             OpStore %32 %125 
					                       Private f32* %128 = OpAccessChain %102 %62 
					                                f32 %129 = OpLoad %128 
					                        Output f32* %131 = OpAccessChain %127 %62 
					                                             OpStore %131 %129 
					                read_only Texture2D %132 = OpLoad %43 
					                            sampler %133 = OpLoad %45 
					         read_only Texture2DSampled %134 = OpSampledImage %132 %133 
					                              f32_2 %135 = OpLoad vs_TEXCOORD0 
					                              f32_4 %136 = OpImageSampleImplicitLod %134 %135 ConstOffset %29 
					                                f32 %137 = OpCompositeExtract %136 0 
					                       Private f32* %138 = OpAccessChain %102 %51 
					                                             OpStore %138 %137 
					                       Uniform f32* %139 = OpAccessChain %55 %26 %56 
					                                f32 %140 = OpLoad %139 
					                       Private f32* %141 = OpAccessChain %102 %51 
					                                f32 %142 = OpLoad %141 
					                                f32 %143 = OpFMul %140 %142 
					                       Uniform f32* %144 = OpAccessChain %55 %26 %62 
					                                f32 %145 = OpLoad %144 
					                                f32 %146 = OpFAdd %143 %145 
					                       Private f32* %147 = OpAccessChain %102 %51 
					                                             OpStore %147 %146 
					                       Private f32* %148 = OpAccessChain %102 %51 
					                                f32 %149 = OpLoad %148 
					                                f32 %150 = OpFDiv %66 %149 
					                       Private f32* %151 = OpAccessChain %102 %51 
					                                             OpStore %151 %150 
					                                f32 %152 = OpLoad %69 
					                       Private f32* %153 = OpAccessChain %102 %51 
					                                f32 %154 = OpLoad %153 
					                                f32 %155 = OpFNegate %154 
					                                f32 %156 = OpFAdd %152 %155 
					                       Private f32* %157 = OpAccessChain %102 %51 
					                                             OpStore %157 %156 
					                       Private f32* %158 = OpAccessChain %102 %51 
					                                f32 %159 = OpLoad %158 
					                                f32 %160 = OpExtInst %1 4 %159 
					                                f32 %161 = OpFMul %160 %91 
					                       Private f32* %162 = OpAccessChain %102 %51 
					                                             OpStore %162 %161 
					                       Private f32* %163 = OpAccessChain %102 %51 
					                                f32 %164 = OpLoad %163 
					                       Private f32* %165 = OpAccessChain %102 %51 
					                                f32 %166 = OpLoad %165 
					                                f32 %167 = OpFMul %164 %166 
					                       Private f32* %168 = OpAccessChain %102 %51 
					                                             OpStore %168 %167 
					                       Private f32* %169 = OpAccessChain %102 %51 
					                                f32 %170 = OpLoad %169 
					                                f32 %171 = OpFMul %170 %97 
					                       Private f32* %172 = OpAccessChain %102 %51 
					                                             OpStore %172 %171 
					                       Private f32* %173 = OpAccessChain %102 %51 
					                                f32 %174 = OpLoad %173 
					                                f32 %175 = OpExtInst %1 29 %174 
					                       Private f32* %176 = OpAccessChain %102 %51 
					                                             OpStore %176 %175 
					                       Private f32* %178 = OpAccessChain %102 %51 
					                                f32 %179 = OpLoad %178 
					                                f32 %181 = OpFMul %179 %180 
					                                             OpStore %177 %181 
					                       Private f32* %182 = OpAccessChain %102 %51 
					                                f32 %183 = OpLoad %182 
					                                f32 %184 = OpFMul %183 %180 
					                                f32 %185 = OpLoad %42 
					                                f32 %186 = OpFAdd %184 %185 
					                                             OpStore %42 %186 
					                                f32 %187 = OpLoad %177 
					                              f32_3 %188 = OpCompositeConstruct %187 %187 %187 
					                              f32_3 %189 = OpLoad %9 
					                              f32_3 %190 = OpFMul %188 %189 
					                              f32_3 %191 = OpLoad %32 
					                              f32_3 %192 = OpFAdd %190 %191 
					                                             OpStore %9 %192 
					                read_only Texture2D %193 = OpLoad %12 
					                            sampler %194 = OpLoad %16 
					         read_only Texture2DSampled %195 = OpSampledImage %193 %194 
					                              f32_2 %196 = OpLoad vs_TEXCOORD0 
					                              f32_4 %199 = OpImageSampleImplicitLod %195 %196 ConstOffset %29 
					                              f32_3 %200 = OpVectorShuffle %199 %199 0 1 2 
					                                             OpStore %32 %200 
					                read_only Texture2D %201 = OpLoad %43 
					                            sampler %202 = OpLoad %45 
					         read_only Texture2DSampled %203 = OpSampledImage %201 %202 
					                              f32_2 %204 = OpLoad vs_TEXCOORD0 
					                              f32_4 %205 = OpImageSampleImplicitLod %203 %204 ConstOffset %29 
					                                f32 %206 = OpCompositeExtract %205 0 
					                       Private f32* %207 = OpAccessChain %102 %51 
					                                             OpStore %207 %206 
					                       Uniform f32* %208 = OpAccessChain %55 %26 %56 
					                                f32 %209 = OpLoad %208 
					                       Private f32* %210 = OpAccessChain %102 %51 
					                                f32 %211 = OpLoad %210 
					                                f32 %212 = OpFMul %209 %211 
					                       Uniform f32* %213 = OpAccessChain %55 %26 %62 
					                                f32 %214 = OpLoad %213 
					                                f32 %215 = OpFAdd %212 %214 
					                       Private f32* %216 = OpAccessChain %102 %51 
					                                             OpStore %216 %215 
					                       Private f32* %217 = OpAccessChain %102 %51 
					                                f32 %218 = OpLoad %217 
					                                f32 %219 = OpFDiv %66 %218 
					                       Private f32* %220 = OpAccessChain %102 %51 
					                                             OpStore %220 %219 
					                                f32 %221 = OpLoad %69 
					                       Private f32* %222 = OpAccessChain %102 %51 
					                                f32 %223 = OpLoad %222 
					                                f32 %224 = OpFNegate %223 
					                                f32 %225 = OpFAdd %221 %224 
					                       Private f32* %226 = OpAccessChain %102 %51 
					                                             OpStore %226 %225 
					                       Private f32* %227 = OpAccessChain %102 %51 
					                                f32 %228 = OpLoad %227 
					                                f32 %229 = OpExtInst %1 4 %228 
					                                f32 %230 = OpFMul %229 %91 
					                       Private f32* %231 = OpAccessChain %102 %51 
					                                             OpStore %231 %230 
					                       Private f32* %232 = OpAccessChain %102 %51 
					                                f32 %233 = OpLoad %232 
					                       Private f32* %234 = OpAccessChain %102 %51 
					                                f32 %235 = OpLoad %234 
					                                f32 %236 = OpFMul %233 %235 
					                       Private f32* %237 = OpAccessChain %102 %51 
					                                             OpStore %237 %236 
					                       Private f32* %238 = OpAccessChain %102 %51 
					                                f32 %239 = OpLoad %238 
					                                f32 %240 = OpFMul %239 %97 
					                       Private f32* %241 = OpAccessChain %102 %51 
					                                             OpStore %241 %240 
					                       Private f32* %242 = OpAccessChain %102 %51 
					                                f32 %243 = OpLoad %242 
					                                f32 %244 = OpExtInst %1 29 %243 
					                       Private f32* %245 = OpAccessChain %102 %51 
					                                             OpStore %245 %244 
					                       Private f32* %246 = OpAccessChain %102 %51 
					                                f32 %247 = OpLoad %246 
					                                f32 %249 = OpFMul %247 %248 
					                                             OpStore %177 %249 
					                       Private f32* %250 = OpAccessChain %102 %51 
					                                f32 %251 = OpLoad %250 
					                                f32 %252 = OpFMul %251 %248 
					                                f32 %253 = OpLoad %42 
					                                f32 %254 = OpFAdd %252 %253 
					                                             OpStore %42 %254 
					                                f32 %255 = OpLoad %177 
					                              f32_3 %256 = OpCompositeConstruct %255 %255 %255 
					                              f32_3 %257 = OpLoad %32 
					                              f32_3 %258 = OpFMul %256 %257 
					                              f32_3 %259 = OpLoad %9 
					                              f32_3 %260 = OpFAdd %258 %259 
					                                             OpStore %9 %260 
					                read_only Texture2D %261 = OpLoad %12 
					                            sampler %262 = OpLoad %16 
					         read_only Texture2DSampled %263 = OpSampledImage %261 %262 
					                              f32_2 %264 = OpLoad vs_TEXCOORD0 
					                              f32_4 %267 = OpImageSampleImplicitLod %263 %264 ConstOffset %29 
					                              f32_3 %268 = OpVectorShuffle %267 %267 0 1 2 
					                                             OpStore %32 %268 
					                read_only Texture2D %269 = OpLoad %43 
					                            sampler %270 = OpLoad %45 
					         read_only Texture2DSampled %271 = OpSampledImage %269 %270 
					                              f32_2 %272 = OpLoad vs_TEXCOORD0 
					                              f32_4 %273 = OpImageSampleImplicitLod %271 %272 ConstOffset %29 
					                                f32 %274 = OpCompositeExtract %273 0 
					                       Private f32* %275 = OpAccessChain %102 %51 
					                                             OpStore %275 %274 
					                       Uniform f32* %276 = OpAccessChain %55 %26 %56 
					                                f32 %277 = OpLoad %276 
					                       Private f32* %278 = OpAccessChain %102 %51 
					                                f32 %279 = OpLoad %278 
					                                f32 %280 = OpFMul %277 %279 
					                       Uniform f32* %281 = OpAccessChain %55 %26 %62 
					                                f32 %282 = OpLoad %281 
					                                f32 %283 = OpFAdd %280 %282 
					                       Private f32* %284 = OpAccessChain %102 %51 
					                                             OpStore %284 %283 
					                       Private f32* %285 = OpAccessChain %102 %51 
					                                f32 %286 = OpLoad %285 
					                                f32 %287 = OpFDiv %66 %286 
					                       Private f32* %288 = OpAccessChain %102 %51 
					                                             OpStore %288 %287 
					                                f32 %289 = OpLoad %69 
					                       Private f32* %290 = OpAccessChain %102 %51 
					                                f32 %291 = OpLoad %290 
					                                f32 %292 = OpFNegate %291 
					                                f32 %293 = OpFAdd %289 %292 
					                       Private f32* %294 = OpAccessChain %102 %51 
					                                             OpStore %294 %293 
					                       Private f32* %295 = OpAccessChain %102 %51 
					                                f32 %296 = OpLoad %295 
					                                f32 %297 = OpExtInst %1 4 %296 
					                                f32 %298 = OpFMul %297 %91 
					                       Private f32* %299 = OpAccessChain %102 %51 
					                                             OpStore %299 %298 
					                       Private f32* %300 = OpAccessChain %102 %51 
					                                f32 %301 = OpLoad %300 
					                       Private f32* %302 = OpAccessChain %102 %51 
					                                f32 %303 = OpLoad %302 
					                                f32 %304 = OpFMul %301 %303 
					                       Private f32* %305 = OpAccessChain %102 %51 
					                                             OpStore %305 %304 
					                       Private f32* %306 = OpAccessChain %102 %51 
					                                f32 %307 = OpLoad %306 
					                                f32 %308 = OpFMul %307 %97 
					                       Private f32* %309 = OpAccessChain %102 %51 
					                                             OpStore %309 %308 
					                       Private f32* %310 = OpAccessChain %102 %51 
					                                f32 %311 = OpLoad %310 
					                                f32 %312 = OpExtInst %1 29 %311 
					                       Private f32* %313 = OpAccessChain %102 %51 
					                                             OpStore %313 %312 
					                       Private f32* %314 = OpAccessChain %102 %51 
					                                f32 %315 = OpLoad %314 
					                                f32 %317 = OpFMul %315 %316 
					                                             OpStore %177 %317 
					                       Private f32* %318 = OpAccessChain %102 %51 
					                                f32 %319 = OpLoad %318 
					                                f32 %320 = OpFMul %319 %316 
					                                f32 %321 = OpLoad %42 
					                                f32 %322 = OpFAdd %320 %321 
					                                             OpStore %42 %322 
					                                f32 %323 = OpLoad %177 
					                              f32_3 %324 = OpCompositeConstruct %323 %323 %323 
					                              f32_3 %325 = OpLoad %32 
					                              f32_3 %326 = OpFMul %324 %325 
					                              f32_3 %327 = OpLoad %9 
					                              f32_3 %328 = OpFAdd %326 %327 
					                                             OpStore %9 %328 
					                read_only Texture2D %329 = OpLoad %12 
					                            sampler %330 = OpLoad %16 
					         read_only Texture2DSampled %331 = OpSampledImage %329 %330 
					                              f32_2 %332 = OpLoad vs_TEXCOORD0 
					                              f32_4 %335 = OpImageSampleImplicitLod %331 %332 ConstOffset %29 
					                              f32_3 %336 = OpVectorShuffle %335 %335 0 1 2 
					                                             OpStore %32 %336 
					                read_only Texture2D %337 = OpLoad %43 
					                            sampler %338 = OpLoad %45 
					         read_only Texture2DSampled %339 = OpSampledImage %337 %338 
					                              f32_2 %340 = OpLoad vs_TEXCOORD0 
					                              f32_4 %341 = OpImageSampleImplicitLod %339 %340 ConstOffset %29 
					                                f32 %342 = OpCompositeExtract %341 0 
					                       Private f32* %343 = OpAccessChain %102 %51 
					                                             OpStore %343 %342 
					                       Uniform f32* %344 = OpAccessChain %55 %26 %56 
					                                f32 %345 = OpLoad %344 
					                       Private f32* %346 = OpAccessChain %102 %51 
					                                f32 %347 = OpLoad %346 
					                                f32 %348 = OpFMul %345 %347 
					                       Uniform f32* %349 = OpAccessChain %55 %26 %62 
					                                f32 %350 = OpLoad %349 
					                                f32 %351 = OpFAdd %348 %350 
					                       Private f32* %352 = OpAccessChain %102 %51 
					                                             OpStore %352 %351 
					                       Private f32* %353 = OpAccessChain %102 %51 
					                                f32 %354 = OpLoad %353 
					                                f32 %355 = OpFDiv %66 %354 
					                       Private f32* %356 = OpAccessChain %102 %51 
					                                             OpStore %356 %355 
					                                f32 %357 = OpLoad %69 
					                       Private f32* %358 = OpAccessChain %102 %51 
					                                f32 %359 = OpLoad %358 
					                                f32 %360 = OpFNegate %359 
					                                f32 %361 = OpFAdd %357 %360 
					                       Private f32* %362 = OpAccessChain %102 %51 
					                                             OpStore %362 %361 
					                       Private f32* %363 = OpAccessChain %102 %51 
					                                f32 %364 = OpLoad %363 
					                                f32 %365 = OpExtInst %1 4 %364 
					                                f32 %366 = OpFMul %365 %91 
					                       Private f32* %367 = OpAccessChain %102 %51 
					                                             OpStore %367 %366 
					                       Private f32* %368 = OpAccessChain %102 %51 
					                                f32 %369 = OpLoad %368 
					                       Private f32* %370 = OpAccessChain %102 %51 
					                                f32 %371 = OpLoad %370 
					                                f32 %372 = OpFMul %369 %371 
					                       Private f32* %373 = OpAccessChain %102 %51 
					                                             OpStore %373 %372 
					                       Private f32* %374 = OpAccessChain %102 %51 
					                                f32 %375 = OpLoad %374 
					                                f32 %376 = OpFMul %375 %97 
					                       Private f32* %377 = OpAccessChain %102 %51 
					                                             OpStore %377 %376 
					                       Private f32* %378 = OpAccessChain %102 %51 
					                                f32 %379 = OpLoad %378 
					                                f32 %380 = OpExtInst %1 29 %379 
					                       Private f32* %381 = OpAccessChain %102 %51 
					                                             OpStore %381 %380 
					                       Private f32* %382 = OpAccessChain %102 %51 
					                                f32 %383 = OpLoad %382 
					                                f32 %385 = OpFMul %383 %384 
					                                             OpStore %177 %385 
					                       Private f32* %386 = OpAccessChain %102 %51 
					                                f32 %387 = OpLoad %386 
					                                f32 %388 = OpFMul %387 %384 
					                                f32 %389 = OpLoad %42 
					                                f32 %390 = OpFAdd %388 %389 
					                                             OpStore %42 %390 
					                                f32 %391 = OpLoad %177 
					                              f32_3 %392 = OpCompositeConstruct %391 %391 %391 
					                              f32_3 %393 = OpLoad %32 
					                              f32_3 %394 = OpFMul %392 %393 
					                              f32_3 %395 = OpLoad %9 
					                              f32_3 %396 = OpFAdd %394 %395 
					                                             OpStore %9 %396 
					                read_only Texture2D %397 = OpLoad %12 
					                            sampler %398 = OpLoad %16 
					         read_only Texture2DSampled %399 = OpSampledImage %397 %398 
					                              f32_2 %400 = OpLoad vs_TEXCOORD0 
					                              f32_4 %403 = OpImageSampleImplicitLod %399 %400 ConstOffset %29 
					                              f32_3 %404 = OpVectorShuffle %403 %403 0 1 2 
					                                             OpStore %32 %404 
					                read_only Texture2D %405 = OpLoad %43 
					                            sampler %406 = OpLoad %45 
					         read_only Texture2DSampled %407 = OpSampledImage %405 %406 
					                              f32_2 %408 = OpLoad vs_TEXCOORD0 
					                              f32_4 %409 = OpImageSampleImplicitLod %407 %408 ConstOffset %29 
					                                f32 %410 = OpCompositeExtract %409 0 
					                       Private f32* %411 = OpAccessChain %102 %51 
					                                             OpStore %411 %410 
					                       Uniform f32* %412 = OpAccessChain %55 %26 %56 
					                                f32 %413 = OpLoad %412 
					                       Private f32* %414 = OpAccessChain %102 %51 
					                                f32 %415 = OpLoad %414 
					                                f32 %416 = OpFMul %413 %415 
					                       Uniform f32* %417 = OpAccessChain %55 %26 %62 
					                                f32 %418 = OpLoad %417 
					                                f32 %419 = OpFAdd %416 %418 
					                       Private f32* %420 = OpAccessChain %102 %51 
					                                             OpStore %420 %419 
					                       Private f32* %421 = OpAccessChain %102 %51 
					                                f32 %422 = OpLoad %421 
					                                f32 %423 = OpFDiv %66 %422 
					                       Private f32* %424 = OpAccessChain %102 %51 
					                                             OpStore %424 %423 
					                                f32 %425 = OpLoad %69 
					                       Private f32* %426 = OpAccessChain %102 %51 
					                                f32 %427 = OpLoad %426 
					                                f32 %428 = OpFNegate %427 
					                                f32 %429 = OpFAdd %425 %428 
					                       Private f32* %430 = OpAccessChain %102 %51 
					                                             OpStore %430 %429 
					                       Private f32* %431 = OpAccessChain %102 %51 
					                                f32 %432 = OpLoad %431 
					                                f32 %433 = OpExtInst %1 4 %432 
					                                f32 %434 = OpFMul %433 %91 
					                       Private f32* %435 = OpAccessChain %102 %51 
					                                             OpStore %435 %434 
					                       Private f32* %436 = OpAccessChain %102 %51 
					                                f32 %437 = OpLoad %436 
					                       Private f32* %438 = OpAccessChain %102 %51 
					                                f32 %439 = OpLoad %438 
					                                f32 %440 = OpFMul %437 %439 
					                       Private f32* %441 = OpAccessChain %102 %51 
					                                             OpStore %441 %440 
					                       Private f32* %442 = OpAccessChain %102 %51 
					                                f32 %443 = OpLoad %442 
					                                f32 %444 = OpFMul %443 %97 
					                       Private f32* %445 = OpAccessChain %102 %51 
					                                             OpStore %445 %444 
					                       Private f32* %446 = OpAccessChain %102 %51 
					                                f32 %447 = OpLoad %446 
					                                f32 %448 = OpExtInst %1 29 %447 
					                       Private f32* %449 = OpAccessChain %102 %51 
					                                             OpStore %449 %448 
					                       Private f32* %450 = OpAccessChain %102 %51 
					                                f32 %451 = OpLoad %450 
					                                f32 %453 = OpFMul %451 %452 
					                                             OpStore %177 %453 
					                       Private f32* %454 = OpAccessChain %102 %51 
					                                f32 %455 = OpLoad %454 
					                                f32 %456 = OpFMul %455 %452 
					                                f32 %457 = OpLoad %42 
					                                f32 %458 = OpFAdd %456 %457 
					                                             OpStore %42 %458 
					                                f32 %459 = OpLoad %177 
					                              f32_3 %460 = OpCompositeConstruct %459 %459 %459 
					                              f32_3 %461 = OpLoad %32 
					                              f32_3 %462 = OpFMul %460 %461 
					                              f32_3 %463 = OpLoad %9 
					                              f32_3 %464 = OpFAdd %462 %463 
					                                             OpStore %9 %464 
					                read_only Texture2D %465 = OpLoad %12 
					                            sampler %466 = OpLoad %16 
					         read_only Texture2DSampled %467 = OpSampledImage %465 %466 
					                              f32_2 %468 = OpLoad vs_TEXCOORD0 
					                              f32_4 %471 = OpImageSampleImplicitLod %467 %468 ConstOffset %29 
					                              f32_3 %472 = OpVectorShuffle %471 %471 0 1 2 
					                                             OpStore %32 %472 
					                read_only Texture2D %473 = OpLoad %43 
					                            sampler %474 = OpLoad %45 
					         read_only Texture2DSampled %475 = OpSampledImage %473 %474 
					                              f32_2 %476 = OpLoad vs_TEXCOORD0 
					                              f32_4 %477 = OpImageSampleImplicitLod %475 %476 ConstOffset %29 
					                                f32 %478 = OpCompositeExtract %477 0 
					                       Private f32* %479 = OpAccessChain %102 %51 
					                                             OpStore %479 %478 
					                       Uniform f32* %480 = OpAccessChain %55 %26 %56 
					                                f32 %481 = OpLoad %480 
					                       Private f32* %482 = OpAccessChain %102 %51 
					                                f32 %483 = OpLoad %482 
					                                f32 %484 = OpFMul %481 %483 
					                       Uniform f32* %485 = OpAccessChain %55 %26 %62 
					                                f32 %486 = OpLoad %485 
					                                f32 %487 = OpFAdd %484 %486 
					                       Private f32* %488 = OpAccessChain %102 %51 
					                                             OpStore %488 %487 
					                       Private f32* %489 = OpAccessChain %102 %51 
					                                f32 %490 = OpLoad %489 
					                                f32 %491 = OpFDiv %66 %490 
					                       Private f32* %492 = OpAccessChain %102 %51 
					                                             OpStore %492 %491 
					                                f32 %493 = OpLoad %69 
					                       Private f32* %494 = OpAccessChain %102 %51 
					                                f32 %495 = OpLoad %494 
					                                f32 %496 = OpFNegate %495 
					                                f32 %497 = OpFAdd %493 %496 
					                       Private f32* %498 = OpAccessChain %102 %51 
					                                             OpStore %498 %497 
					                       Private f32* %499 = OpAccessChain %102 %51 
					                                f32 %500 = OpLoad %499 
					                                f32 %501 = OpExtInst %1 4 %500 
					                                f32 %502 = OpFMul %501 %91 
					                       Private f32* %503 = OpAccessChain %102 %51 
					                                             OpStore %503 %502 
					                       Private f32* %504 = OpAccessChain %102 %51 
					                                f32 %505 = OpLoad %504 
					                       Private f32* %506 = OpAccessChain %102 %51 
					                                f32 %507 = OpLoad %506 
					                                f32 %508 = OpFMul %505 %507 
					                       Private f32* %509 = OpAccessChain %102 %51 
					                                             OpStore %509 %508 
					                       Private f32* %510 = OpAccessChain %102 %51 
					                                f32 %511 = OpLoad %510 
					                                f32 %512 = OpFMul %511 %97 
					                       Private f32* %513 = OpAccessChain %102 %51 
					                                             OpStore %513 %512 
					                       Private f32* %514 = OpAccessChain %102 %51 
					                                f32 %515 = OpLoad %514 
					                                f32 %516 = OpExtInst %1 29 %515 
					                       Private f32* %517 = OpAccessChain %102 %51 
					                                             OpStore %517 %516 
					                       Private f32* %518 = OpAccessChain %102 %51 
					                                f32 %519 = OpLoad %518 
					                                f32 %520 = OpFMul %519 %452 
					                                             OpStore %177 %520 
					                       Private f32* %521 = OpAccessChain %102 %51 
					                                f32 %522 = OpLoad %521 
					                                f32 %523 = OpFMul %522 %452 
					                                f32 %524 = OpLoad %42 
					                                f32 %525 = OpFAdd %523 %524 
					                                             OpStore %42 %525 
					                                f32 %526 = OpLoad %177 
					                              f32_3 %527 = OpCompositeConstruct %526 %526 %526 
					                              f32_3 %528 = OpLoad %32 
					                              f32_3 %529 = OpFMul %527 %528 
					                              f32_3 %530 = OpLoad %9 
					                              f32_3 %531 = OpFAdd %529 %530 
					                                             OpStore %9 %531 
					                read_only Texture2D %532 = OpLoad %12 
					                            sampler %533 = OpLoad %16 
					         read_only Texture2DSampled %534 = OpSampledImage %532 %533 
					                              f32_2 %535 = OpLoad vs_TEXCOORD0 
					                              f32_4 %538 = OpImageSampleImplicitLod %534 %535 ConstOffset %29 
					                              f32_3 %539 = OpVectorShuffle %538 %538 0 1 2 
					                                             OpStore %32 %539 
					                read_only Texture2D %540 = OpLoad %43 
					                            sampler %541 = OpLoad %45 
					         read_only Texture2DSampled %542 = OpSampledImage %540 %541 
					                              f32_2 %543 = OpLoad vs_TEXCOORD0 
					                              f32_4 %544 = OpImageSampleImplicitLod %542 %543 ConstOffset %29 
					                                f32 %545 = OpCompositeExtract %544 0 
					                       Private f32* %546 = OpAccessChain %102 %51 
					                                             OpStore %546 %545 
					                       Uniform f32* %547 = OpAccessChain %55 %26 %56 
					                                f32 %548 = OpLoad %547 
					                       Private f32* %549 = OpAccessChain %102 %51 
					                                f32 %550 = OpLoad %549 
					                                f32 %551 = OpFMul %548 %550 
					                       Uniform f32* %552 = OpAccessChain %55 %26 %62 
					                                f32 %553 = OpLoad %552 
					                                f32 %554 = OpFAdd %551 %553 
					                       Private f32* %555 = OpAccessChain %102 %51 
					                                             OpStore %555 %554 
					                       Private f32* %556 = OpAccessChain %102 %51 
					                                f32 %557 = OpLoad %556 
					                                f32 %558 = OpFDiv %66 %557 
					                       Private f32* %559 = OpAccessChain %102 %51 
					                                             OpStore %559 %558 
					                                f32 %560 = OpLoad %69 
					                       Private f32* %561 = OpAccessChain %102 %51 
					                                f32 %562 = OpLoad %561 
					                                f32 %563 = OpFNegate %562 
					                                f32 %564 = OpFAdd %560 %563 
					                       Private f32* %565 = OpAccessChain %102 %51 
					                                             OpStore %565 %564 
					                       Private f32* %566 = OpAccessChain %102 %51 
					                                f32 %567 = OpLoad %566 
					                                f32 %568 = OpExtInst %1 4 %567 
					                                f32 %569 = OpFMul %568 %91 
					                       Private f32* %570 = OpAccessChain %102 %51 
					                                             OpStore %570 %569 
					                       Private f32* %571 = OpAccessChain %102 %51 
					                                f32 %572 = OpLoad %571 
					                       Private f32* %573 = OpAccessChain %102 %51 
					                                f32 %574 = OpLoad %573 
					                                f32 %575 = OpFMul %572 %574 
					                       Private f32* %576 = OpAccessChain %102 %51 
					                                             OpStore %576 %575 
					                       Private f32* %577 = OpAccessChain %102 %51 
					                                f32 %578 = OpLoad %577 
					                                f32 %579 = OpFMul %578 %97 
					                       Private f32* %580 = OpAccessChain %102 %51 
					                                             OpStore %580 %579 
					                       Private f32* %581 = OpAccessChain %102 %51 
					                                f32 %582 = OpLoad %581 
					                                f32 %583 = OpExtInst %1 29 %582 
					                       Private f32* %584 = OpAccessChain %102 %51 
					                                             OpStore %584 %583 
					                       Private f32* %585 = OpAccessChain %102 %51 
					                                f32 %586 = OpLoad %585 
					                                f32 %587 = OpFMul %586 %384 
					                                             OpStore %177 %587 
					                       Private f32* %588 = OpAccessChain %102 %51 
					                                f32 %589 = OpLoad %588 
					                                f32 %590 = OpFMul %589 %384 
					                                f32 %591 = OpLoad %42 
					                                f32 %592 = OpFAdd %590 %591 
					                                             OpStore %42 %592 
					                                f32 %593 = OpLoad %177 
					                              f32_3 %594 = OpCompositeConstruct %593 %593 %593 
					                              f32_3 %595 = OpLoad %32 
					                              f32_3 %596 = OpFMul %594 %595 
					                              f32_3 %597 = OpLoad %9 
					                              f32_3 %598 = OpFAdd %596 %597 
					                                             OpStore %9 %598 
					                read_only Texture2D %599 = OpLoad %12 
					                            sampler %600 = OpLoad %16 
					         read_only Texture2DSampled %601 = OpSampledImage %599 %600 
					                              f32_2 %602 = OpLoad vs_TEXCOORD0 
					                              f32_4 %605 = OpImageSampleImplicitLod %601 %602 ConstOffset %29 
					                              f32_3 %606 = OpVectorShuffle %605 %605 0 1 2 
					                                             OpStore %32 %606 
					                read_only Texture2D %607 = OpLoad %43 
					                            sampler %608 = OpLoad %45 
					         read_only Texture2DSampled %609 = OpSampledImage %607 %608 
					                              f32_2 %610 = OpLoad vs_TEXCOORD0 
					                              f32_4 %611 = OpImageSampleImplicitLod %609 %610 ConstOffset %29 
					                                f32 %612 = OpCompositeExtract %611 0 
					                       Private f32* %613 = OpAccessChain %102 %51 
					                                             OpStore %613 %612 
					                       Uniform f32* %614 = OpAccessChain %55 %26 %56 
					                                f32 %615 = OpLoad %614 
					                       Private f32* %616 = OpAccessChain %102 %51 
					                                f32 %617 = OpLoad %616 
					                                f32 %618 = OpFMul %615 %617 
					                       Uniform f32* %619 = OpAccessChain %55 %26 %62 
					                                f32 %620 = OpLoad %619 
					                                f32 %621 = OpFAdd %618 %620 
					                       Private f32* %622 = OpAccessChain %102 %51 
					                                             OpStore %622 %621 
					                       Private f32* %623 = OpAccessChain %102 %51 
					                                f32 %624 = OpLoad %623 
					                                f32 %625 = OpFDiv %66 %624 
					                       Private f32* %626 = OpAccessChain %102 %51 
					                                             OpStore %626 %625 
					                                f32 %627 = OpLoad %69 
					                       Private f32* %628 = OpAccessChain %102 %51 
					                                f32 %629 = OpLoad %628 
					                                f32 %630 = OpFNegate %629 
					                                f32 %631 = OpFAdd %627 %630 
					                       Private f32* %632 = OpAccessChain %102 %51 
					                                             OpStore %632 %631 
					                       Private f32* %633 = OpAccessChain %102 %51 
					                                f32 %634 = OpLoad %633 
					                                f32 %635 = OpExtInst %1 4 %634 
					                                f32 %636 = OpFMul %635 %91 
					                       Private f32* %637 = OpAccessChain %102 %51 
					                                             OpStore %637 %636 
					                       Private f32* %638 = OpAccessChain %102 %51 
					                                f32 %639 = OpLoad %638 
					                       Private f32* %640 = OpAccessChain %102 %51 
					                                f32 %641 = OpLoad %640 
					                                f32 %642 = OpFMul %639 %641 
					                       Private f32* %643 = OpAccessChain %102 %51 
					                                             OpStore %643 %642 
					                       Private f32* %644 = OpAccessChain %102 %51 
					                                f32 %645 = OpLoad %644 
					                                f32 %646 = OpFMul %645 %97 
					                       Private f32* %647 = OpAccessChain %102 %51 
					                                             OpStore %647 %646 
					                       Private f32* %648 = OpAccessChain %102 %51 
					                                f32 %649 = OpLoad %648 
					                                f32 %650 = OpExtInst %1 29 %649 
					                       Private f32* %651 = OpAccessChain %102 %51 
					                                             OpStore %651 %650 
					                       Private f32* %652 = OpAccessChain %102 %51 
					                                f32 %653 = OpLoad %652 
					                                f32 %654 = OpFMul %653 %316 
					                                             OpStore %177 %654 
					                       Private f32* %655 = OpAccessChain %102 %51 
					                                f32 %656 = OpLoad %655 
					                                f32 %657 = OpFMul %656 %316 
					                                f32 %658 = OpLoad %42 
					                                f32 %659 = OpFAdd %657 %658 
					                                             OpStore %42 %659 
					                                f32 %660 = OpLoad %177 
					                              f32_3 %661 = OpCompositeConstruct %660 %660 %660 
					                              f32_3 %662 = OpLoad %32 
					                              f32_3 %663 = OpFMul %661 %662 
					                              f32_3 %664 = OpLoad %9 
					                              f32_3 %665 = OpFAdd %663 %664 
					                                             OpStore %9 %665 
					                read_only Texture2D %666 = OpLoad %12 
					                            sampler %667 = OpLoad %16 
					         read_only Texture2DSampled %668 = OpSampledImage %666 %667 
					                              f32_2 %669 = OpLoad vs_TEXCOORD0 
					                              f32_4 %672 = OpImageSampleImplicitLod %668 %669 ConstOffset %29 
					                              f32_3 %673 = OpVectorShuffle %672 %672 0 1 2 
					                                             OpStore %32 %673 
					                read_only Texture2D %674 = OpLoad %43 
					                            sampler %675 = OpLoad %45 
					         read_only Texture2DSampled %676 = OpSampledImage %674 %675 
					                              f32_2 %677 = OpLoad vs_TEXCOORD0 
					                              f32_4 %678 = OpImageSampleImplicitLod %676 %677 ConstOffset %29 
					                                f32 %679 = OpCompositeExtract %678 0 
					                       Private f32* %680 = OpAccessChain %102 %51 
					                                             OpStore %680 %679 
					                       Uniform f32* %681 = OpAccessChain %55 %26 %56 
					                                f32 %682 = OpLoad %681 
					                       Private f32* %683 = OpAccessChain %102 %51 
					                                f32 %684 = OpLoad %683 
					                                f32 %685 = OpFMul %682 %684 
					                       Uniform f32* %686 = OpAccessChain %55 %26 %62 
					                                f32 %687 = OpLoad %686 
					                                f32 %688 = OpFAdd %685 %687 
					                       Private f32* %689 = OpAccessChain %102 %51 
					                                             OpStore %689 %688 
					                       Private f32* %690 = OpAccessChain %102 %51 
					                                f32 %691 = OpLoad %690 
					                                f32 %692 = OpFDiv %66 %691 
					                       Private f32* %693 = OpAccessChain %102 %51 
					                                             OpStore %693 %692 
					                                f32 %694 = OpLoad %69 
					                       Private f32* %695 = OpAccessChain %102 %51 
					                                f32 %696 = OpLoad %695 
					                                f32 %697 = OpFNegate %696 
					                                f32 %698 = OpFAdd %694 %697 
					                       Private f32* %699 = OpAccessChain %102 %51 
					                                             OpStore %699 %698 
					                       Private f32* %700 = OpAccessChain %102 %51 
					                                f32 %701 = OpLoad %700 
					                                f32 %702 = OpExtInst %1 4 %701 
					                                f32 %703 = OpFMul %702 %91 
					                       Private f32* %704 = OpAccessChain %102 %51 
					                                             OpStore %704 %703 
					                       Private f32* %705 = OpAccessChain %102 %51 
					                                f32 %706 = OpLoad %705 
					                       Private f32* %707 = OpAccessChain %102 %51 
					                                f32 %708 = OpLoad %707 
					                                f32 %709 = OpFMul %706 %708 
					                       Private f32* %710 = OpAccessChain %102 %51 
					                                             OpStore %710 %709 
					                       Private f32* %711 = OpAccessChain %102 %51 
					                                f32 %712 = OpLoad %711 
					                                f32 %713 = OpFMul %712 %97 
					                       Private f32* %714 = OpAccessChain %102 %51 
					                                             OpStore %714 %713 
					                       Private f32* %715 = OpAccessChain %102 %51 
					                                f32 %716 = OpLoad %715 
					                                f32 %717 = OpExtInst %1 29 %716 
					                       Private f32* %718 = OpAccessChain %102 %51 
					                                             OpStore %718 %717 
					                       Private f32* %719 = OpAccessChain %102 %51 
					                                f32 %720 = OpLoad %719 
					                                f32 %721 = OpFMul %720 %248 
					                                             OpStore %177 %721 
					                       Private f32* %722 = OpAccessChain %102 %51 
					                                f32 %723 = OpLoad %722 
					                                f32 %724 = OpFMul %723 %248 
					                                f32 %725 = OpLoad %42 
					                                f32 %726 = OpFAdd %724 %725 
					                                             OpStore %42 %726 
					                                f32 %727 = OpLoad %177 
					                              f32_3 %728 = OpCompositeConstruct %727 %727 %727 
					                              f32_3 %729 = OpLoad %32 
					                              f32_3 %730 = OpFMul %728 %729 
					                              f32_3 %731 = OpLoad %9 
					                              f32_3 %732 = OpFAdd %730 %731 
					                                             OpStore %9 %732 
					                read_only Texture2D %733 = OpLoad %12 
					                            sampler %734 = OpLoad %16 
					         read_only Texture2DSampled %735 = OpSampledImage %733 %734 
					                              f32_2 %736 = OpLoad vs_TEXCOORD0 
					                              f32_4 %739 = OpImageSampleImplicitLod %735 %736 ConstOffset %29 
					                              f32_3 %740 = OpVectorShuffle %739 %739 0 1 2 
					                                             OpStore %32 %740 
					                read_only Texture2D %741 = OpLoad %43 
					                            sampler %742 = OpLoad %45 
					         read_only Texture2DSampled %743 = OpSampledImage %741 %742 
					                              f32_2 %744 = OpLoad vs_TEXCOORD0 
					                              f32_4 %745 = OpImageSampleImplicitLod %743 %744 ConstOffset %29 
					                                f32 %746 = OpCompositeExtract %745 0 
					                       Private f32* %747 = OpAccessChain %102 %51 
					                                             OpStore %747 %746 
					                       Uniform f32* %748 = OpAccessChain %55 %26 %56 
					                                f32 %749 = OpLoad %748 
					                       Private f32* %750 = OpAccessChain %102 %51 
					                                f32 %751 = OpLoad %750 
					                                f32 %752 = OpFMul %749 %751 
					                       Uniform f32* %753 = OpAccessChain %55 %26 %62 
					                                f32 %754 = OpLoad %753 
					                                f32 %755 = OpFAdd %752 %754 
					                       Private f32* %756 = OpAccessChain %102 %51 
					                                             OpStore %756 %755 
					                       Private f32* %757 = OpAccessChain %102 %51 
					                                f32 %758 = OpLoad %757 
					                                f32 %759 = OpFDiv %66 %758 
					                       Private f32* %760 = OpAccessChain %102 %51 
					                                             OpStore %760 %759 
					                                f32 %761 = OpLoad %69 
					                       Private f32* %762 = OpAccessChain %102 %51 
					                                f32 %763 = OpLoad %762 
					                                f32 %764 = OpFNegate %763 
					                                f32 %765 = OpFAdd %761 %764 
					                       Private f32* %766 = OpAccessChain %102 %51 
					                                             OpStore %766 %765 
					                       Private f32* %767 = OpAccessChain %102 %51 
					                                f32 %768 = OpLoad %767 
					                                f32 %769 = OpExtInst %1 4 %768 
					                                f32 %770 = OpFMul %769 %91 
					                       Private f32* %771 = OpAccessChain %102 %51 
					                                             OpStore %771 %770 
					                       Private f32* %772 = OpAccessChain %102 %51 
					                                f32 %773 = OpLoad %772 
					                       Private f32* %774 = OpAccessChain %102 %51 
					                                f32 %775 = OpLoad %774 
					                                f32 %776 = OpFMul %773 %775 
					                       Private f32* %777 = OpAccessChain %102 %51 
					                                             OpStore %777 %776 
					                       Private f32* %778 = OpAccessChain %102 %51 
					                                f32 %779 = OpLoad %778 
					                                f32 %780 = OpFMul %779 %97 
					                       Private f32* %781 = OpAccessChain %102 %51 
					                                             OpStore %781 %780 
					                       Private f32* %782 = OpAccessChain %102 %51 
					                                f32 %783 = OpLoad %782 
					                                f32 %784 = OpExtInst %1 29 %783 
					                       Private f32* %785 = OpAccessChain %102 %51 
					                                             OpStore %785 %784 
					                       Private f32* %786 = OpAccessChain %102 %51 
					                                f32 %787 = OpLoad %786 
					                                f32 %788 = OpFMul %787 %180 
					                                             OpStore %177 %788 
					                       Private f32* %789 = OpAccessChain %102 %51 
					                                f32 %790 = OpLoad %789 
					                                f32 %791 = OpFMul %790 %180 
					                                f32 %792 = OpLoad %42 
					                                f32 %793 = OpFAdd %791 %792 
					                                             OpStore %42 %793 
					                                f32 %794 = OpLoad %177 
					                              f32_3 %795 = OpCompositeConstruct %794 %794 %794 
					                              f32_3 %796 = OpLoad %32 
					                              f32_3 %797 = OpFMul %795 %796 
					                              f32_3 %798 = OpLoad %9 
					                              f32_3 %799 = OpFAdd %797 %798 
					                                             OpStore %9 %799 
					                read_only Texture2D %800 = OpLoad %12 
					                            sampler %801 = OpLoad %16 
					         read_only Texture2DSampled %802 = OpSampledImage %800 %801 
					                              f32_2 %803 = OpLoad vs_TEXCOORD0 
					                              f32_4 %806 = OpImageSampleImplicitLod %802 %803 ConstOffset %29 
					                              f32_3 %807 = OpVectorShuffle %806 %806 0 1 2 
					                                             OpStore %32 %807 
					                read_only Texture2D %808 = OpLoad %43 
					                            sampler %809 = OpLoad %45 
					         read_only Texture2DSampled %810 = OpSampledImage %808 %809 
					                              f32_2 %811 = OpLoad vs_TEXCOORD0 
					                              f32_4 %812 = OpImageSampleImplicitLod %810 %811 ConstOffset %29 
					                                f32 %813 = OpCompositeExtract %812 0 
					                       Private f32* %814 = OpAccessChain %102 %51 
					                                             OpStore %814 %813 
					                       Uniform f32* %815 = OpAccessChain %55 %26 %56 
					                                f32 %816 = OpLoad %815 
					                       Private f32* %817 = OpAccessChain %102 %51 
					                                f32 %818 = OpLoad %817 
					                                f32 %819 = OpFMul %816 %818 
					                       Uniform f32* %820 = OpAccessChain %55 %26 %62 
					                                f32 %821 = OpLoad %820 
					                                f32 %822 = OpFAdd %819 %821 
					                       Private f32* %823 = OpAccessChain %102 %51 
					                                             OpStore %823 %822 
					                       Private f32* %824 = OpAccessChain %102 %51 
					                                f32 %825 = OpLoad %824 
					                                f32 %826 = OpFDiv %66 %825 
					                       Private f32* %827 = OpAccessChain %102 %51 
					                                             OpStore %827 %826 
					                                f32 %828 = OpLoad %69 
					                       Private f32* %829 = OpAccessChain %102 %51 
					                                f32 %830 = OpLoad %829 
					                                f32 %831 = OpFNegate %830 
					                                f32 %832 = OpFAdd %828 %831 
					                                             OpStore %69 %832 
					                                f32 %833 = OpLoad %69 
					                                f32 %834 = OpExtInst %1 4 %833 
					                                f32 %835 = OpFMul %834 %91 
					                                             OpStore %69 %835 
					                                f32 %836 = OpLoad %69 
					                                f32 %837 = OpLoad %69 
					                                f32 %838 = OpFMul %836 %837 
					                                             OpStore %69 %838 
					                                f32 %839 = OpLoad %69 
					                                f32 %840 = OpFMul %839 %97 
					                                             OpStore %69 %840 
					                                f32 %841 = OpLoad %69 
					                                f32 %842 = OpExtInst %1 29 %841 
					                                             OpStore %69 %842 
					                                f32 %843 = OpLoad %69 
					                                f32 %844 = OpFMul %843 %104 
					                       Private f32* %845 = OpAccessChain %102 %51 
					                                             OpStore %845 %844 
					                                f32 %846 = OpLoad %69 
					                                f32 %847 = OpFMul %846 %104 
					                                f32 %848 = OpLoad %42 
					                                f32 %849 = OpFAdd %847 %848 
					                                             OpStore %42 %849 
					                              f32_4 %850 = OpLoad %102 
					                              f32_3 %851 = OpVectorShuffle %850 %850 0 0 0 
					                              f32_3 %852 = OpLoad %32 
					                              f32_3 %853 = OpFMul %851 %852 
					                              f32_3 %854 = OpLoad %9 
					                              f32_3 %855 = OpFAdd %853 %854 
					                                             OpStore %9 %855 
					                              f32_3 %856 = OpLoad %9 
					                                f32 %857 = OpLoad %42 
					                              f32_3 %858 = OpCompositeConstruct %857 %857 %857 
					                              f32_3 %859 = OpFDiv %856 %858 
					                              f32_4 %860 = OpLoad %127 
					                              f32_4 %861 = OpVectorShuffle %860 %859 4 5 6 3 
					                                             OpStore %127 %861 
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[7];
						vec4 _ZBufferParams;
						vec4 unused_0_2;
					};
					uniform  sampler2D _QuarterResDepthBuffer;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat5;
					float u_xlat6;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -5));
					    u_xlat1 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -6));
					    u_xlat2 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -6));
					    u_xlat12 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat2 = texture(_QuarterResDepthBuffer, vs_TEXCOORD0.xy);
					    u_xlat13 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat12 = (-u_xlat12) + u_xlat13;
					    u_xlat12 = abs(u_xlat12) * 0.5;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat12 = u_xlat12 * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat2.x = u_xlat12 * 0.0323794;
					    u_xlat12 = u_xlat12 * 0.0323794 + 0.0997355729;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat2.xyz * vec3(0.0997355729, 0.0997355729, 0.0997355729) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat2 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -5));
					    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.x = u_xlat13 + (-u_xlat2.x);
					    u_xlat2.x = abs(u_xlat2.x) * 0.5;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * -1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat6 = u_xlat2.x * 0.0456622727;
					    u_xlat12 = u_xlat2.x * 0.0456622727 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -4));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -4));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0604926832;
					    u_xlat12 = u_xlat1.x * 0.0604926832 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -3));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -3));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0752843618;
					    u_xlat12 = u_xlat1.x * 0.0752843618 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -2));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -2));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0880163312;
					    u_xlat12 = u_xlat1.x * 0.0880163312 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, -1));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, -1));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.096667029;
					    u_xlat12 = u_xlat1.x * 0.096667029 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 1));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 1));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.096667029;
					    u_xlat12 = u_xlat1.x * 0.096667029 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 2));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 2));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0880163312;
					    u_xlat12 = u_xlat1.x * 0.0880163312 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 3));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 3));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0752843618;
					    u_xlat12 = u_xlat1.x * 0.0752843618 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 4));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 4));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0604926832;
					    u_xlat12 = u_xlat1.x * 0.0604926832 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 5));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 5));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0456622727;
					    u_xlat12 = u_xlat1.x * 0.0456622727 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2 = textureOffset(_MainTex, vs_TEXCOORD0.xy, ivec2(0, 6));
					    u_xlat3 = textureOffset(_QuarterResDepthBuffer, vs_TEXCOORD0.xy, ivec2(0, 6));
					    u_xlat1.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat13;
					    u_xlat1.x = abs(u_xlat1.x) * 0.5;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * -1.44269502;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat5 = u_xlat1.x * 0.0323794;
					    u_xlat12 = u_xlat1.x * 0.0323794 + u_xlat12;
					    u_xlat0.xyz = vec3(u_xlat5) * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz / vec3(u_xlat12);
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
			GpuProgramID 708995
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
						vec4 _CameraDepthTexture_TexelSize;
						vec4 unused_0_2[2];
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
					out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.xz = _CameraDepthTexture_TexelSize.xy;
					    u_xlat1.xy = (-_CameraDepthTexture_TexelSize.xy) * vec2(0.5, 0.5) + in_TEXCOORD0.xy;
					    u_xlat1.w = u_xlat0.z + u_xlat1.y;
					    phase0_Output0_0 = u_xlat1.xyxw;
					    u_xlat0.y = 0.0;
					    vs_TEXCOORD2.xy = u_xlat0.xy + u_xlat1.xy;
					    vs_TEXCOORD3.xy = u_xlat1.xy + _CameraDepthTexture_TexelSize.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					vs_TEXCOORD0 = phase0_Output0_0.xy;
					vs_TEXCOORD1 = phase0_Output0_0.zw;
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
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _CameraDepthTexture_TexelSize;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.xz = _CameraDepthTexture_TexelSize.xy;
					    u_xlat1.xy = (-_CameraDepthTexture_TexelSize.xy) * vec2(0.5, 0.5) + in_TEXCOORD0.xy;
					    u_xlat1.w = u_xlat0.z + u_xlat1.y;
					    phase0_Output0_0 = u_xlat1.xyxw;
					    u_xlat0.y = 0.0;
					    vs_TEXCOORD2.xy = u_xlat0.xy + u_xlat1.xy;
					    vs_TEXCOORD3.xy = u_xlat1.xy + _CameraDepthTexture_TexelSize.xy;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					vs_TEXCOORD0 = phase0_Output0_0.xy;
					vs_TEXCOORD1 = phase0_Output0_0.zw;
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
					UNITY_LOCATION(0) uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					layout(location = 0) out float SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					float u_xlat9;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0 = hlslcc_FragCoord.xyxy + hlslcc_FragCoord.xyxy;
					    u_xlatb0 = greaterThanEqual(u_xlat0, (-u_xlat0.zwzw));
					    u_xlat0.x = (u_xlatb0.x) ? float(2.0) : float(-2.0);
					    u_xlat0.y = (u_xlatb0.y) ? float(2.0) : float(-2.0);
					    u_xlat0.z = (u_xlatb0.z) ? float(0.5) : float(-0.5);
					    u_xlat0.w = (u_xlatb0.w) ? float(0.5) : float(-0.5);
					    u_xlat6.xy = u_xlat0.zw * hlslcc_FragCoord.xy;
					    u_xlat6.xy = fract(u_xlat6.xy);
					    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
					    u_xlati0.xy = ivec2(u_xlat0.xy);
					    u_xlati0.x = u_xlati0.y + u_xlati0.x;
					    u_xlatb0.x = u_xlati0.x==1;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat2 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat3 = min(u_xlat1.x, u_xlat2.x);
					    u_xlat6.x = max(u_xlat1.x, u_xlat2.x);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD2.xy);
					    u_xlat2 = texture(_CameraDepthTexture, vs_TEXCOORD3.xy);
					    u_xlat9 = min(u_xlat1.x, u_xlat2.x);
					    u_xlat1.x = max(u_xlat1.x, u_xlat2.x);
					    u_xlat6.x = max(u_xlat6.x, u_xlat1.x);
					    u_xlat3 = min(u_xlat9, u_xlat3);
					    SV_Target0 = (u_xlatb0.x) ? u_xlat3 : u_xlat6.x;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 141
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %35 %56 %62 %70 %119 %129 %132 
					                                                     OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                     OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                                     OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                     OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                     OpDecorate %12 ArrayStride 12 
					                                                     OpDecorate %13 ArrayStride 13 
					                                                     OpMemberDecorate %14 0 Offset 14 
					                                                     OpMemberDecorate %14 1 Offset 14 
					                                                     OpMemberDecorate %14 2 Offset 14 
					                                                     OpDecorate %14 Block 
					                                                     OpDecorate %16 DescriptorSet 16 
					                                                     OpDecorate %16 Binding 16 
					                                                     OpDecorate %35 Location 35 
					                                                     OpDecorate vs_TEXCOORD2 Location 56 
					                                                     OpDecorate vs_TEXCOORD3 Location 62 
					                                                     OpDecorate %70 Location 70 
					                                                     OpMemberDecorate %117 0 BuiltIn 117 
					                                                     OpMemberDecorate %117 1 BuiltIn 117 
					                                                     OpMemberDecorate %117 2 BuiltIn 117 
					                                                     OpDecorate %117 Block 
					                                                     OpDecorate vs_TEXCOORD0 Location 129 
					                                                     OpDecorate vs_TEXCOORD1 Location 132 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 4 
					                                              %8 = OpTypePointer Private %7 
					                               Private f32_4* %9 = OpVariable Private 
					                                             %10 = OpTypeInt 32 0 
					                                         u32 %11 = OpConstant 4 
					                                             %12 = OpTypeArray %7 %11 
					                                             %13 = OpTypeArray %7 %11 
					                                             %14 = OpTypeStruct %12 %13 %7 
					                                             %15 = OpTypePointer Uniform %14 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %16 = OpVariable Uniform 
					                                             %17 = OpTypeInt 32 1 
					                                         i32 %18 = OpConstant 2 
					                                             %19 = OpTypeVector %6 2 
					                                             %20 = OpTypePointer Uniform %7 
					                              Private f32_4* %26 = OpVariable Private 
					                                         f32 %31 = OpConstant 3,674022E-40 
					                                       f32_2 %32 = OpConstantComposite %31 %31 
					                                             %34 = OpTypePointer Input %19 
					                                Input f32_2* %35 = OpVariable Input 
					                                         u32 %40 = OpConstant 2 
					                                             %41 = OpTypePointer Private %6 
					                                         u32 %44 = OpConstant 1 
					                                         u32 %48 = OpConstant 3 
					                              Private f32_4* %50 = OpVariable Private 
					                                         f32 %53 = OpConstant 3,674022E-40 
					                                             %55 = OpTypePointer Output %19 
					                      Output f32_2* vs_TEXCOORD2 = OpVariable Output 
					                      Output f32_2* vs_TEXCOORD3 = OpVariable Output 
					                                             %69 = OpTypePointer Input %7 
					                                Input f32_4* %70 = OpVariable Input 
					                                         i32 %73 = OpConstant 0 
					                                         i32 %74 = OpConstant 1 
					                                         i32 %93 = OpConstant 3 
					                                            %116 = OpTypeArray %6 %44 
					                                            %117 = OpTypeStruct %7 %6 %116 
					                                            %118 = OpTypePointer Output %117 
					       Output struct {f32_4; f32; f32[1];}* %119 = OpVariable Output 
					                                            %127 = OpTypePointer Output %7 
					                      Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                      Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                            %135 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                              Uniform f32_4* %21 = OpAccessChain %16 %18 
					                                       f32_4 %22 = OpLoad %21 
					                                       f32_2 %23 = OpVectorShuffle %22 %22 0 1 
					                                       f32_4 %24 = OpLoad %9 
					                                       f32_4 %25 = OpVectorShuffle %24 %23 4 1 5 3 
					                                                     OpStore %9 %25 
					                              Uniform f32_4* %27 = OpAccessChain %16 %18 
					                                       f32_4 %28 = OpLoad %27 
					                                       f32_2 %29 = OpVectorShuffle %28 %28 0 1 
					                                       f32_2 %30 = OpFNegate %29 
					                                       f32_2 %33 = OpFMul %30 %32 
					                                       f32_2 %36 = OpLoad %35 
					                                       f32_2 %37 = OpFAdd %33 %36 
					                                       f32_4 %38 = OpLoad %26 
					                                       f32_4 %39 = OpVectorShuffle %38 %37 4 5 2 3 
					                                                     OpStore %26 %39 
					                                Private f32* %42 = OpAccessChain %9 %40 
					                                         f32 %43 = OpLoad %42 
					                                Private f32* %45 = OpAccessChain %26 %44 
					                                         f32 %46 = OpLoad %45 
					                                         f32 %47 = OpFAdd %43 %46 
					                                Private f32* %49 = OpAccessChain %26 %48 
					                                                     OpStore %49 %47 
					                                       f32_4 %51 = OpLoad %26 
					                                       f32_4 %52 = OpVectorShuffle %51 %51 0 1 0 3 
					                                                     OpStore %50 %52 
					                                Private f32* %54 = OpAccessChain %9 %44 
					                                                     OpStore %54 %53 
					                                       f32_4 %57 = OpLoad %9 
					                                       f32_2 %58 = OpVectorShuffle %57 %57 0 1 
					                                       f32_4 %59 = OpLoad %26 
					                                       f32_2 %60 = OpVectorShuffle %59 %59 0 1 
					                                       f32_2 %61 = OpFAdd %58 %60 
					                                                     OpStore vs_TEXCOORD2 %61 
					                                       f32_4 %63 = OpLoad %26 
					                                       f32_2 %64 = OpVectorShuffle %63 %63 0 1 
					                              Uniform f32_4* %65 = OpAccessChain %16 %18 
					                                       f32_4 %66 = OpLoad %65 
					                                       f32_2 %67 = OpVectorShuffle %66 %66 0 1 
					                                       f32_2 %68 = OpFAdd %64 %67 
					                                                     OpStore vs_TEXCOORD3 %68 
					                                       f32_4 %71 = OpLoad %70 
					                                       f32_4 %72 = OpVectorShuffle %71 %71 1 1 1 1 
					                              Uniform f32_4* %75 = OpAccessChain %16 %73 %74 
					                                       f32_4 %76 = OpLoad %75 
					                                       f32_4 %77 = OpFMul %72 %76 
					                                                     OpStore %9 %77 
					                              Uniform f32_4* %78 = OpAccessChain %16 %73 %73 
					                                       f32_4 %79 = OpLoad %78 
					                                       f32_4 %80 = OpLoad %70 
					                                       f32_4 %81 = OpVectorShuffle %80 %80 0 0 0 0 
					                                       f32_4 %82 = OpFMul %79 %81 
					                                       f32_4 %83 = OpLoad %9 
					                                       f32_4 %84 = OpFAdd %82 %83 
					                                                     OpStore %9 %84 
					                              Uniform f32_4* %85 = OpAccessChain %16 %73 %18 
					                                       f32_4 %86 = OpLoad %85 
					                                       f32_4 %87 = OpLoad %70 
					                                       f32_4 %88 = OpVectorShuffle %87 %87 2 2 2 2 
					                                       f32_4 %89 = OpFMul %86 %88 
					                                       f32_4 %90 = OpLoad %9 
					                                       f32_4 %91 = OpFAdd %89 %90 
					                                                     OpStore %9 %91 
					                                       f32_4 %92 = OpLoad %9 
					                              Uniform f32_4* %94 = OpAccessChain %16 %73 %93 
					                                       f32_4 %95 = OpLoad %94 
					                                       f32_4 %96 = OpFAdd %92 %95 
					                                                     OpStore %9 %96 
					                                       f32_4 %97 = OpLoad %9 
					                                       f32_4 %98 = OpVectorShuffle %97 %97 1 1 1 1 
					                              Uniform f32_4* %99 = OpAccessChain %16 %74 %74 
					                                      f32_4 %100 = OpLoad %99 
					                                      f32_4 %101 = OpFMul %98 %100 
					                                                     OpStore %26 %101 
					                             Uniform f32_4* %102 = OpAccessChain %16 %74 %73 
					                                      f32_4 %103 = OpLoad %102 
					                                      f32_4 %104 = OpLoad %9 
					                                      f32_4 %105 = OpVectorShuffle %104 %104 0 0 0 0 
					                                      f32_4 %106 = OpFMul %103 %105 
					                                      f32_4 %107 = OpLoad %26 
					                                      f32_4 %108 = OpFAdd %106 %107 
					                                                     OpStore %26 %108 
					                             Uniform f32_4* %109 = OpAccessChain %16 %74 %18 
					                                      f32_4 %110 = OpLoad %109 
					                                      f32_4 %111 = OpLoad %9 
					                                      f32_4 %112 = OpVectorShuffle %111 %111 2 2 2 2 
					                                      f32_4 %113 = OpFMul %110 %112 
					                                      f32_4 %114 = OpLoad %26 
					                                      f32_4 %115 = OpFAdd %113 %114 
					                                                     OpStore %26 %115 
					                             Uniform f32_4* %120 = OpAccessChain %16 %74 %93 
					                                      f32_4 %121 = OpLoad %120 
					                                      f32_4 %122 = OpLoad %9 
					                                      f32_4 %123 = OpVectorShuffle %122 %122 3 3 3 3 
					                                      f32_4 %124 = OpFMul %121 %123 
					                                      f32_4 %125 = OpLoad %26 
					                                      f32_4 %126 = OpFAdd %124 %125 
					                              Output f32_4* %128 = OpAccessChain %119 %73 
					                                                     OpStore %128 %126 
					                                      f32_4 %130 = OpLoad %50 
					                                      f32_2 %131 = OpVectorShuffle %130 %130 0 1 
					                                                     OpStore vs_TEXCOORD0 %131 
					                                      f32_4 %133 = OpLoad %50 
					                                      f32_2 %134 = OpVectorShuffle %133 %133 2 3 
					                                                     OpStore vs_TEXCOORD1 %134 
					                                Output f32* %136 = OpAccessChain %119 %73 %44 
					                                        f32 %137 = OpLoad %136 
					                                        f32 %138 = OpFNegate %137 
					                                Output f32* %139 = OpAccessChain %119 %73 %44 
					                                                     OpStore %139 %138 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 183
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %11 %114 %121 %138 %147 %170 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                              OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                              OpDecorate %11 BuiltIn TessLevelOuter 
					                                              OpDecorate %105 DescriptorSet 105 
					                                              OpDecorate %105 Binding 105 
					                                              OpDecorate %109 DescriptorSet 109 
					                                              OpDecorate %109 Binding 109 
					                                              OpDecorate vs_TEXCOORD0 Location 114 
					                                              OpDecorate vs_TEXCOORD1 Location 121 
					                                              OpDecorate vs_TEXCOORD2 Location 138 
					                                              OpDecorate vs_TEXCOORD3 Location 147 
					                                              OpDecorate %170 Location 170 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 4 
					                                       %8 = OpTypePointer Function %7 
					                                      %10 = OpTypePointer Input %7 
					                         Input f32_4* %11 = OpVariable Input 
					                                      %12 = OpTypeVector %6 3 
					                                  f32 %15 = OpConstant 3,674022E-40 
					                                      %16 = OpTypeInt 32 0 
					                                  u32 %17 = OpConstant 3 
					                                      %18 = OpTypePointer Input %6 
					                                      %26 = OpTypePointer Private %7 
					                       Private f32_4* %27 = OpVariable Private 
					                                      %33 = OpTypeBool 
					                                      %34 = OpTypeVector %33 4 
					                                      %35 = OpTypePointer Private %34 
					                      Private bool_4* %36 = OpVariable Private 
					                                  u32 %42 = OpConstant 0 
					                                      %43 = OpTypePointer Private %33 
					                                  f32 %46 = OpConstant 3,674022E-40 
					                                  f32 %47 = OpConstant 3,674022E-40 
					                                      %49 = OpTypePointer Private %6 
					                                  u32 %51 = OpConstant 1 
					                                  u32 %56 = OpConstant 2 
					                                  f32 %59 = OpConstant 3,674022E-40 
					                                  f32 %60 = OpConstant 3,674022E-40 
					                                      %67 = OpTypeVector %6 2 
					                                      %68 = OpTypePointer Private %67 
					                       Private f32_2* %69 = OpVariable Private 
					                                      %83 = OpTypeInt 32 1 
					                                      %84 = OpTypeVector %83 2 
					                                      %85 = OpTypePointer Private %84 
					                       Private i32_2* %86 = OpVariable Private 
					                                      %90 = OpTypePointer Private %83 
					                                  i32 %99 = OpConstant 1 
					                        Private f32* %102 = OpVariable Private 
					                                     %103 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %104 = OpTypePointer UniformConstant %103 
					UniformConstant read_only Texture2D* %105 = OpVariable UniformConstant 
					                                     %107 = OpTypeSampler 
					                                     %108 = OpTypePointer UniformConstant %107 
					            UniformConstant sampler* %109 = OpVariable UniformConstant 
					                                     %111 = OpTypeSampledImage %103 
					                                     %113 = OpTypePointer Input %67 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                        Private f32* %126 = OpVariable Private 
					                Input f32_2* vs_TEXCOORD2 = OpVariable Input 
					                        Private f32* %143 = OpVariable Private 
					                Input f32_2* vs_TEXCOORD3 = OpVariable Input 
					                        Private f32* %151 = OpVariable Private 
					                                     %169 = OpTypePointer Output %6 
					                         Output f32* %170 = OpVariable Output 
					                                     %173 = OpTypePointer Function %6 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                       Function f32_4* %9 = OpVariable Function 
					                       Function f32* %174 = OpVariable Function 
					                                f32_4 %13 = OpLoad %11 
					                                f32_3 %14 = OpVectorShuffle %13 %13 0 1 2 
					                           Input f32* %19 = OpAccessChain %11 %17 
					                                  f32 %20 = OpLoad %19 
					                                  f32 %21 = OpFDiv %15 %20 
					                                  f32 %22 = OpCompositeExtract %14 0 
					                                  f32 %23 = OpCompositeExtract %14 1 
					                                  f32 %24 = OpCompositeExtract %14 2 
					                                f32_4 %25 = OpCompositeConstruct %22 %23 %24 %21 
					                                              OpStore %9 %25 
					                                f32_4 %28 = OpLoad %9 
					                                f32_4 %29 = OpVectorShuffle %28 %28 0 1 0 1 
					                                f32_4 %30 = OpLoad %9 
					                                f32_4 %31 = OpVectorShuffle %30 %30 0 1 0 1 
					                                f32_4 %32 = OpFAdd %29 %31 
					                                              OpStore %27 %32 
					                                f32_4 %37 = OpLoad %27 
					                                f32_4 %38 = OpLoad %27 
					                                f32_4 %39 = OpVectorShuffle %38 %38 2 3 2 3 
					                                f32_4 %40 = OpFNegate %39 
					                               bool_4 %41 = OpFOrdGreaterThanEqual %37 %40 
					                                              OpStore %36 %41 
					                        Private bool* %44 = OpAccessChain %36 %42 
					                                 bool %45 = OpLoad %44 
					                                  f32 %48 = OpSelect %45 %46 %47 
					                         Private f32* %50 = OpAccessChain %27 %42 
					                                              OpStore %50 %48 
					                        Private bool* %52 = OpAccessChain %36 %51 
					                                 bool %53 = OpLoad %52 
					                                  f32 %54 = OpSelect %53 %46 %47 
					                         Private f32* %55 = OpAccessChain %27 %51 
					                                              OpStore %55 %54 
					                        Private bool* %57 = OpAccessChain %36 %56 
					                                 bool %58 = OpLoad %57 
					                                  f32 %61 = OpSelect %58 %59 %60 
					                         Private f32* %62 = OpAccessChain %27 %56 
					                                              OpStore %62 %61 
					                        Private bool* %63 = OpAccessChain %36 %17 
					                                 bool %64 = OpLoad %63 
					                                  f32 %65 = OpSelect %64 %59 %60 
					                         Private f32* %66 = OpAccessChain %27 %17 
					                                              OpStore %66 %65 
					                                f32_4 %70 = OpLoad %27 
					                                f32_2 %71 = OpVectorShuffle %70 %70 2 3 
					                                f32_4 %72 = OpLoad %9 
					                                f32_2 %73 = OpVectorShuffle %72 %72 0 1 
					                                f32_2 %74 = OpFMul %71 %73 
					                                              OpStore %69 %74 
					                                f32_2 %75 = OpLoad %69 
					                                f32_2 %76 = OpExtInst %1 10 %75 
					                                              OpStore %69 %76 
					                                f32_2 %77 = OpLoad %69 
					                                f32_4 %78 = OpLoad %27 
					                                f32_2 %79 = OpVectorShuffle %78 %78 0 1 
					                                f32_2 %80 = OpFMul %77 %79 
					                                f32_4 %81 = OpLoad %27 
					                                f32_4 %82 = OpVectorShuffle %81 %80 4 5 2 3 
					                                              OpStore %27 %82 
					                                f32_4 %87 = OpLoad %27 
					                                f32_2 %88 = OpVectorShuffle %87 %87 0 1 
					                                i32_2 %89 = OpConvertFToS %88 
					                                              OpStore %86 %89 
					                         Private i32* %91 = OpAccessChain %86 %51 
					                                  i32 %92 = OpLoad %91 
					                         Private i32* %93 = OpAccessChain %86 %42 
					                                  i32 %94 = OpLoad %93 
					                                  i32 %95 = OpIAdd %92 %94 
					                         Private i32* %96 = OpAccessChain %86 %42 
					                                              OpStore %96 %95 
					                         Private i32* %97 = OpAccessChain %86 %42 
					                                  i32 %98 = OpLoad %97 
					                                bool %100 = OpIEqual %98 %99 
					                       Private bool* %101 = OpAccessChain %36 %42 
					                                              OpStore %101 %100 
					                 read_only Texture2D %106 = OpLoad %105 
					                             sampler %110 = OpLoad %109 
					          read_only Texture2DSampled %112 = OpSampledImage %106 %110 
					                               f32_2 %115 = OpLoad vs_TEXCOORD0 
					                               f32_4 %116 = OpImageSampleImplicitLod %112 %115 
					                                 f32 %117 = OpCompositeExtract %116 0 
					                                              OpStore %102 %117 
					                 read_only Texture2D %118 = OpLoad %105 
					                             sampler %119 = OpLoad %109 
					          read_only Texture2DSampled %120 = OpSampledImage %118 %119 
					                               f32_2 %122 = OpLoad vs_TEXCOORD1 
					                               f32_4 %123 = OpImageSampleImplicitLod %120 %122 
					                                 f32 %124 = OpCompositeExtract %123 0 
					                        Private f32* %125 = OpAccessChain %69 %42 
					                                              OpStore %125 %124 
					                        Private f32* %127 = OpAccessChain %69 %42 
					                                 f32 %128 = OpLoad %127 
					                                 f32 %129 = OpLoad %102 
					                                 f32 %130 = OpExtInst %1 37 %128 %129 
					                                              OpStore %126 %130 
					                        Private f32* %131 = OpAccessChain %69 %42 
					                                 f32 %132 = OpLoad %131 
					                                 f32 %133 = OpLoad %102 
					                                 f32 %134 = OpExtInst %1 40 %132 %133 
					                                              OpStore %102 %134 
					                 read_only Texture2D %135 = OpLoad %105 
					                             sampler %136 = OpLoad %109 
					          read_only Texture2DSampled %137 = OpSampledImage %135 %136 
					                               f32_2 %139 = OpLoad vs_TEXCOORD2 
					                               f32_4 %140 = OpImageSampleImplicitLod %137 %139 
					                                 f32 %141 = OpCompositeExtract %140 0 
					                        Private f32* %142 = OpAccessChain %69 %42 
					                                              OpStore %142 %141 
					                 read_only Texture2D %144 = OpLoad %105 
					                             sampler %145 = OpLoad %109 
					          read_only Texture2DSampled %146 = OpSampledImage %144 %145 
					                               f32_2 %148 = OpLoad vs_TEXCOORD3 
					                               f32_4 %149 = OpImageSampleImplicitLod %146 %148 
					                                 f32 %150 = OpCompositeExtract %149 0 
					                                              OpStore %143 %150 
					                        Private f32* %152 = OpAccessChain %69 %42 
					                                 f32 %153 = OpLoad %152 
					                                 f32 %154 = OpLoad %143 
					                                 f32 %155 = OpExtInst %1 37 %153 %154 
					                                              OpStore %151 %155 
					                        Private f32* %156 = OpAccessChain %69 %42 
					                                 f32 %157 = OpLoad %156 
					                                 f32 %158 = OpLoad %143 
					                                 f32 %159 = OpExtInst %1 40 %157 %158 
					                        Private f32* %160 = OpAccessChain %69 %42 
					                                              OpStore %160 %159 
					                        Private f32* %161 = OpAccessChain %69 %42 
					                                 f32 %162 = OpLoad %161 
					                                 f32 %163 = OpLoad %102 
					                                 f32 %164 = OpExtInst %1 40 %162 %163 
					                                              OpStore %102 %164 
					                                 f32 %165 = OpLoad %126 
					                                 f32 %166 = OpLoad %151 
					                                 f32 %167 = OpExtInst %1 37 %165 %166 
					                        Private f32* %168 = OpAccessChain %69 %42 
					                                              OpStore %168 %167 
					                       Private bool* %171 = OpAccessChain %36 %42 
					                                bool %172 = OpLoad %171 
					                                              OpSelectionMerge %176 None 
					                                              OpBranchConditional %172 %175 %179 
					                                     %175 = OpLabel 
					                        Private f32* %177 = OpAccessChain %69 %42 
					                                 f32 %178 = OpLoad %177 
					                                              OpStore %174 %178 
					                                              OpBranch %176 
					                                     %179 = OpLabel 
					                                 f32 %180 = OpLoad %102 
					                                              OpStore %174 %180 
					                                              OpBranch %176 
					                                     %176 = OpLabel 
					                                 f32 %181 = OpLoad %174 
					                                              OpStore %170 %181 
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
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					layout(location = 0) out float SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					float u_xlat9;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0 = hlslcc_FragCoord.xyxy + hlslcc_FragCoord.xyxy;
					    u_xlatb0 = greaterThanEqual(u_xlat0, (-u_xlat0.zwzw));
					    u_xlat0.x = (u_xlatb0.x) ? float(2.0) : float(-2.0);
					    u_xlat0.y = (u_xlatb0.y) ? float(2.0) : float(-2.0);
					    u_xlat0.z = (u_xlatb0.z) ? float(0.5) : float(-0.5);
					    u_xlat0.w = (u_xlatb0.w) ? float(0.5) : float(-0.5);
					    u_xlat6.xy = u_xlat0.zw * hlslcc_FragCoord.xy;
					    u_xlat6.xy = fract(u_xlat6.xy);
					    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
					    u_xlati0.xy = ivec2(u_xlat0.xy);
					    u_xlati0.x = u_xlati0.y + u_xlati0.x;
					    u_xlatb0.x = u_xlati0.x==1;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat2 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat3 = min(u_xlat1.x, u_xlat2.x);
					    u_xlat6.x = max(u_xlat1.x, u_xlat2.x);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD2.xy);
					    u_xlat2 = texture(_CameraDepthTexture, vs_TEXCOORD3.xy);
					    u_xlat9 = min(u_xlat1.x, u_xlat2.x);
					    u_xlat1.x = max(u_xlat1.x, u_xlat2.x);
					    u_xlat6.x = max(u_xlat6.x, u_xlat1.x);
					    u_xlat3 = min(u_xlat9, u_xlat3);
					    SV_Target0 = (u_xlatb0.x) ? u_xlat3 : u_xlat6.x;
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
			GpuProgramID 758431
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
						vec4 unused_0_0[3];
						vec4 _HalfResDepthBuffer_TexelSize;
						vec4 unused_0_2;
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
					out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.xz = _HalfResDepthBuffer_TexelSize.xy;
					    u_xlat1.xy = (-_HalfResDepthBuffer_TexelSize.xy) * vec2(0.5, 0.5) + in_TEXCOORD0.xy;
					    u_xlat1.w = u_xlat0.z + u_xlat1.y;
					    phase0_Output0_0 = u_xlat1.xyxw;
					    u_xlat0.y = 0.0;
					    vs_TEXCOORD2.xy = u_xlat0.xy + u_xlat1.xy;
					    vs_TEXCOORD3.xy = u_xlat1.xy + _HalfResDepthBuffer_TexelSize.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					vs_TEXCOORD0 = phase0_Output0_0.xy;
					vs_TEXCOORD1 = phase0_Output0_0.zw;
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
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _HalfResDepthBuffer_TexelSize;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.xz = _HalfResDepthBuffer_TexelSize.xy;
					    u_xlat1.xy = (-_HalfResDepthBuffer_TexelSize.xy) * vec2(0.5, 0.5) + in_TEXCOORD0.xy;
					    u_xlat1.w = u_xlat0.z + u_xlat1.y;
					    phase0_Output0_0 = u_xlat1.xyxw;
					    u_xlat0.y = 0.0;
					    vs_TEXCOORD2.xy = u_xlat0.xy + u_xlat1.xy;
					    vs_TEXCOORD3.xy = u_xlat1.xy + _HalfResDepthBuffer_TexelSize.xy;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					vs_TEXCOORD0 = phase0_Output0_0.xy;
					vs_TEXCOORD1 = phase0_Output0_0.zw;
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
					UNITY_LOCATION(0) uniform  sampler2D _HalfResDepthBuffer;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					layout(location = 0) out float SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					float u_xlat9;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0 = hlslcc_FragCoord.xyxy + hlslcc_FragCoord.xyxy;
					    u_xlatb0 = greaterThanEqual(u_xlat0, (-u_xlat0.zwzw));
					    u_xlat0.x = (u_xlatb0.x) ? float(2.0) : float(-2.0);
					    u_xlat0.y = (u_xlatb0.y) ? float(2.0) : float(-2.0);
					    u_xlat0.z = (u_xlatb0.z) ? float(0.5) : float(-0.5);
					    u_xlat0.w = (u_xlatb0.w) ? float(0.5) : float(-0.5);
					    u_xlat6.xy = u_xlat0.zw * hlslcc_FragCoord.xy;
					    u_xlat6.xy = fract(u_xlat6.xy);
					    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
					    u_xlati0.xy = ivec2(u_xlat0.xy);
					    u_xlati0.x = u_xlati0.y + u_xlati0.x;
					    u_xlatb0.x = u_xlati0.x==1;
					    u_xlat1 = texture(_HalfResDepthBuffer, vs_TEXCOORD0.xy);
					    u_xlat2 = texture(_HalfResDepthBuffer, vs_TEXCOORD1.xy);
					    u_xlat3 = min(u_xlat1.x, u_xlat2.x);
					    u_xlat6.x = max(u_xlat1.x, u_xlat2.x);
					    u_xlat1 = texture(_HalfResDepthBuffer, vs_TEXCOORD2.xy);
					    u_xlat2 = texture(_HalfResDepthBuffer, vs_TEXCOORD3.xy);
					    u_xlat9 = min(u_xlat1.x, u_xlat2.x);
					    u_xlat1.x = max(u_xlat1.x, u_xlat2.x);
					    u_xlat6.x = max(u_xlat6.x, u_xlat1.x);
					    u_xlat3 = min(u_xlat9, u_xlat3);
					    SV_Target0 = (u_xlatb0.x) ? u_xlat3 : u_xlat6.x;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 141
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %35 %56 %62 %70 %119 %129 %132 
					                                                     OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                     OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                                     OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                     OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                     OpDecorate %12 ArrayStride 12 
					                                                     OpDecorate %13 ArrayStride 13 
					                                                     OpMemberDecorate %14 0 Offset 14 
					                                                     OpMemberDecorate %14 1 Offset 14 
					                                                     OpMemberDecorate %14 2 Offset 14 
					                                                     OpDecorate %14 Block 
					                                                     OpDecorate %16 DescriptorSet 16 
					                                                     OpDecorate %16 Binding 16 
					                                                     OpDecorate %35 Location 35 
					                                                     OpDecorate vs_TEXCOORD2 Location 56 
					                                                     OpDecorate vs_TEXCOORD3 Location 62 
					                                                     OpDecorate %70 Location 70 
					                                                     OpMemberDecorate %117 0 BuiltIn 117 
					                                                     OpMemberDecorate %117 1 BuiltIn 117 
					                                                     OpMemberDecorate %117 2 BuiltIn 117 
					                                                     OpDecorate %117 Block 
					                                                     OpDecorate vs_TEXCOORD0 Location 129 
					                                                     OpDecorate vs_TEXCOORD1 Location 132 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 4 
					                                              %8 = OpTypePointer Private %7 
					                               Private f32_4* %9 = OpVariable Private 
					                                             %10 = OpTypeInt 32 0 
					                                         u32 %11 = OpConstant 4 
					                                             %12 = OpTypeArray %7 %11 
					                                             %13 = OpTypeArray %7 %11 
					                                             %14 = OpTypeStruct %12 %13 %7 
					                                             %15 = OpTypePointer Uniform %14 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %16 = OpVariable Uniform 
					                                             %17 = OpTypeInt 32 1 
					                                         i32 %18 = OpConstant 2 
					                                             %19 = OpTypeVector %6 2 
					                                             %20 = OpTypePointer Uniform %7 
					                              Private f32_4* %26 = OpVariable Private 
					                                         f32 %31 = OpConstant 3,674022E-40 
					                                       f32_2 %32 = OpConstantComposite %31 %31 
					                                             %34 = OpTypePointer Input %19 
					                                Input f32_2* %35 = OpVariable Input 
					                                         u32 %40 = OpConstant 2 
					                                             %41 = OpTypePointer Private %6 
					                                         u32 %44 = OpConstant 1 
					                                         u32 %48 = OpConstant 3 
					                              Private f32_4* %50 = OpVariable Private 
					                                         f32 %53 = OpConstant 3,674022E-40 
					                                             %55 = OpTypePointer Output %19 
					                      Output f32_2* vs_TEXCOORD2 = OpVariable Output 
					                      Output f32_2* vs_TEXCOORD3 = OpVariable Output 
					                                             %69 = OpTypePointer Input %7 
					                                Input f32_4* %70 = OpVariable Input 
					                                         i32 %73 = OpConstant 0 
					                                         i32 %74 = OpConstant 1 
					                                         i32 %93 = OpConstant 3 
					                                            %116 = OpTypeArray %6 %44 
					                                            %117 = OpTypeStruct %7 %6 %116 
					                                            %118 = OpTypePointer Output %117 
					       Output struct {f32_4; f32; f32[1];}* %119 = OpVariable Output 
					                                            %127 = OpTypePointer Output %7 
					                      Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                      Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                            %135 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                              Uniform f32_4* %21 = OpAccessChain %16 %18 
					                                       f32_4 %22 = OpLoad %21 
					                                       f32_2 %23 = OpVectorShuffle %22 %22 0 1 
					                                       f32_4 %24 = OpLoad %9 
					                                       f32_4 %25 = OpVectorShuffle %24 %23 4 1 5 3 
					                                                     OpStore %9 %25 
					                              Uniform f32_4* %27 = OpAccessChain %16 %18 
					                                       f32_4 %28 = OpLoad %27 
					                                       f32_2 %29 = OpVectorShuffle %28 %28 0 1 
					                                       f32_2 %30 = OpFNegate %29 
					                                       f32_2 %33 = OpFMul %30 %32 
					                                       f32_2 %36 = OpLoad %35 
					                                       f32_2 %37 = OpFAdd %33 %36 
					                                       f32_4 %38 = OpLoad %26 
					                                       f32_4 %39 = OpVectorShuffle %38 %37 4 5 2 3 
					                                                     OpStore %26 %39 
					                                Private f32* %42 = OpAccessChain %9 %40 
					                                         f32 %43 = OpLoad %42 
					                                Private f32* %45 = OpAccessChain %26 %44 
					                                         f32 %46 = OpLoad %45 
					                                         f32 %47 = OpFAdd %43 %46 
					                                Private f32* %49 = OpAccessChain %26 %48 
					                                                     OpStore %49 %47 
					                                       f32_4 %51 = OpLoad %26 
					                                       f32_4 %52 = OpVectorShuffle %51 %51 0 1 0 3 
					                                                     OpStore %50 %52 
					                                Private f32* %54 = OpAccessChain %9 %44 
					                                                     OpStore %54 %53 
					                                       f32_4 %57 = OpLoad %9 
					                                       f32_2 %58 = OpVectorShuffle %57 %57 0 1 
					                                       f32_4 %59 = OpLoad %26 
					                                       f32_2 %60 = OpVectorShuffle %59 %59 0 1 
					                                       f32_2 %61 = OpFAdd %58 %60 
					                                                     OpStore vs_TEXCOORD2 %61 
					                                       f32_4 %63 = OpLoad %26 
					                                       f32_2 %64 = OpVectorShuffle %63 %63 0 1 
					                              Uniform f32_4* %65 = OpAccessChain %16 %18 
					                                       f32_4 %66 = OpLoad %65 
					                                       f32_2 %67 = OpVectorShuffle %66 %66 0 1 
					                                       f32_2 %68 = OpFAdd %64 %67 
					                                                     OpStore vs_TEXCOORD3 %68 
					                                       f32_4 %71 = OpLoad %70 
					                                       f32_4 %72 = OpVectorShuffle %71 %71 1 1 1 1 
					                              Uniform f32_4* %75 = OpAccessChain %16 %73 %74 
					                                       f32_4 %76 = OpLoad %75 
					                                       f32_4 %77 = OpFMul %72 %76 
					                                                     OpStore %9 %77 
					                              Uniform f32_4* %78 = OpAccessChain %16 %73 %73 
					                                       f32_4 %79 = OpLoad %78 
					                                       f32_4 %80 = OpLoad %70 
					                                       f32_4 %81 = OpVectorShuffle %80 %80 0 0 0 0 
					                                       f32_4 %82 = OpFMul %79 %81 
					                                       f32_4 %83 = OpLoad %9 
					                                       f32_4 %84 = OpFAdd %82 %83 
					                                                     OpStore %9 %84 
					                              Uniform f32_4* %85 = OpAccessChain %16 %73 %18 
					                                       f32_4 %86 = OpLoad %85 
					                                       f32_4 %87 = OpLoad %70 
					                                       f32_4 %88 = OpVectorShuffle %87 %87 2 2 2 2 
					                                       f32_4 %89 = OpFMul %86 %88 
					                                       f32_4 %90 = OpLoad %9 
					                                       f32_4 %91 = OpFAdd %89 %90 
					                                                     OpStore %9 %91 
					                                       f32_4 %92 = OpLoad %9 
					                              Uniform f32_4* %94 = OpAccessChain %16 %73 %93 
					                                       f32_4 %95 = OpLoad %94 
					                                       f32_4 %96 = OpFAdd %92 %95 
					                                                     OpStore %9 %96 
					                                       f32_4 %97 = OpLoad %9 
					                                       f32_4 %98 = OpVectorShuffle %97 %97 1 1 1 1 
					                              Uniform f32_4* %99 = OpAccessChain %16 %74 %74 
					                                      f32_4 %100 = OpLoad %99 
					                                      f32_4 %101 = OpFMul %98 %100 
					                                                     OpStore %26 %101 
					                             Uniform f32_4* %102 = OpAccessChain %16 %74 %73 
					                                      f32_4 %103 = OpLoad %102 
					                                      f32_4 %104 = OpLoad %9 
					                                      f32_4 %105 = OpVectorShuffle %104 %104 0 0 0 0 
					                                      f32_4 %106 = OpFMul %103 %105 
					                                      f32_4 %107 = OpLoad %26 
					                                      f32_4 %108 = OpFAdd %106 %107 
					                                                     OpStore %26 %108 
					                             Uniform f32_4* %109 = OpAccessChain %16 %74 %18 
					                                      f32_4 %110 = OpLoad %109 
					                                      f32_4 %111 = OpLoad %9 
					                                      f32_4 %112 = OpVectorShuffle %111 %111 2 2 2 2 
					                                      f32_4 %113 = OpFMul %110 %112 
					                                      f32_4 %114 = OpLoad %26 
					                                      f32_4 %115 = OpFAdd %113 %114 
					                                                     OpStore %26 %115 
					                             Uniform f32_4* %120 = OpAccessChain %16 %74 %93 
					                                      f32_4 %121 = OpLoad %120 
					                                      f32_4 %122 = OpLoad %9 
					                                      f32_4 %123 = OpVectorShuffle %122 %122 3 3 3 3 
					                                      f32_4 %124 = OpFMul %121 %123 
					                                      f32_4 %125 = OpLoad %26 
					                                      f32_4 %126 = OpFAdd %124 %125 
					                              Output f32_4* %128 = OpAccessChain %119 %73 
					                                                     OpStore %128 %126 
					                                      f32_4 %130 = OpLoad %50 
					                                      f32_2 %131 = OpVectorShuffle %130 %130 0 1 
					                                                     OpStore vs_TEXCOORD0 %131 
					                                      f32_4 %133 = OpLoad %50 
					                                      f32_2 %134 = OpVectorShuffle %133 %133 2 3 
					                                                     OpStore vs_TEXCOORD1 %134 
					                                Output f32* %136 = OpAccessChain %119 %73 %44 
					                                        f32 %137 = OpLoad %136 
					                                        f32 %138 = OpFNegate %137 
					                                Output f32* %139 = OpAccessChain %119 %73 %44 
					                                                     OpStore %139 %138 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 183
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %11 %114 %121 %138 %147 %170 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                              OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                              OpDecorate %11 BuiltIn TessLevelOuter 
					                                              OpDecorate %105 DescriptorSet 105 
					                                              OpDecorate %105 Binding 105 
					                                              OpDecorate %109 DescriptorSet 109 
					                                              OpDecorate %109 Binding 109 
					                                              OpDecorate vs_TEXCOORD0 Location 114 
					                                              OpDecorate vs_TEXCOORD1 Location 121 
					                                              OpDecorate vs_TEXCOORD2 Location 138 
					                                              OpDecorate vs_TEXCOORD3 Location 147 
					                                              OpDecorate %170 Location 170 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 4 
					                                       %8 = OpTypePointer Function %7 
					                                      %10 = OpTypePointer Input %7 
					                         Input f32_4* %11 = OpVariable Input 
					                                      %12 = OpTypeVector %6 3 
					                                  f32 %15 = OpConstant 3,674022E-40 
					                                      %16 = OpTypeInt 32 0 
					                                  u32 %17 = OpConstant 3 
					                                      %18 = OpTypePointer Input %6 
					                                      %26 = OpTypePointer Private %7 
					                       Private f32_4* %27 = OpVariable Private 
					                                      %33 = OpTypeBool 
					                                      %34 = OpTypeVector %33 4 
					                                      %35 = OpTypePointer Private %34 
					                      Private bool_4* %36 = OpVariable Private 
					                                  u32 %42 = OpConstant 0 
					                                      %43 = OpTypePointer Private %33 
					                                  f32 %46 = OpConstant 3,674022E-40 
					                                  f32 %47 = OpConstant 3,674022E-40 
					                                      %49 = OpTypePointer Private %6 
					                                  u32 %51 = OpConstant 1 
					                                  u32 %56 = OpConstant 2 
					                                  f32 %59 = OpConstant 3,674022E-40 
					                                  f32 %60 = OpConstant 3,674022E-40 
					                                      %67 = OpTypeVector %6 2 
					                                      %68 = OpTypePointer Private %67 
					                       Private f32_2* %69 = OpVariable Private 
					                                      %83 = OpTypeInt 32 1 
					                                      %84 = OpTypeVector %83 2 
					                                      %85 = OpTypePointer Private %84 
					                       Private i32_2* %86 = OpVariable Private 
					                                      %90 = OpTypePointer Private %83 
					                                  i32 %99 = OpConstant 1 
					                        Private f32* %102 = OpVariable Private 
					                                     %103 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %104 = OpTypePointer UniformConstant %103 
					UniformConstant read_only Texture2D* %105 = OpVariable UniformConstant 
					                                     %107 = OpTypeSampler 
					                                     %108 = OpTypePointer UniformConstant %107 
					            UniformConstant sampler* %109 = OpVariable UniformConstant 
					                                     %111 = OpTypeSampledImage %103 
					                                     %113 = OpTypePointer Input %67 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                        Private f32* %126 = OpVariable Private 
					                Input f32_2* vs_TEXCOORD2 = OpVariable Input 
					                        Private f32* %143 = OpVariable Private 
					                Input f32_2* vs_TEXCOORD3 = OpVariable Input 
					                        Private f32* %151 = OpVariable Private 
					                                     %169 = OpTypePointer Output %6 
					                         Output f32* %170 = OpVariable Output 
					                                     %173 = OpTypePointer Function %6 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                       Function f32_4* %9 = OpVariable Function 
					                       Function f32* %174 = OpVariable Function 
					                                f32_4 %13 = OpLoad %11 
					                                f32_3 %14 = OpVectorShuffle %13 %13 0 1 2 
					                           Input f32* %19 = OpAccessChain %11 %17 
					                                  f32 %20 = OpLoad %19 
					                                  f32 %21 = OpFDiv %15 %20 
					                                  f32 %22 = OpCompositeExtract %14 0 
					                                  f32 %23 = OpCompositeExtract %14 1 
					                                  f32 %24 = OpCompositeExtract %14 2 
					                                f32_4 %25 = OpCompositeConstruct %22 %23 %24 %21 
					                                              OpStore %9 %25 
					                                f32_4 %28 = OpLoad %9 
					                                f32_4 %29 = OpVectorShuffle %28 %28 0 1 0 1 
					                                f32_4 %30 = OpLoad %9 
					                                f32_4 %31 = OpVectorShuffle %30 %30 0 1 0 1 
					                                f32_4 %32 = OpFAdd %29 %31 
					                                              OpStore %27 %32 
					                                f32_4 %37 = OpLoad %27 
					                                f32_4 %38 = OpLoad %27 
					                                f32_4 %39 = OpVectorShuffle %38 %38 2 3 2 3 
					                                f32_4 %40 = OpFNegate %39 
					                               bool_4 %41 = OpFOrdGreaterThanEqual %37 %40 
					                                              OpStore %36 %41 
					                        Private bool* %44 = OpAccessChain %36 %42 
					                                 bool %45 = OpLoad %44 
					                                  f32 %48 = OpSelect %45 %46 %47 
					                         Private f32* %50 = OpAccessChain %27 %42 
					                                              OpStore %50 %48 
					                        Private bool* %52 = OpAccessChain %36 %51 
					                                 bool %53 = OpLoad %52 
					                                  f32 %54 = OpSelect %53 %46 %47 
					                         Private f32* %55 = OpAccessChain %27 %51 
					                                              OpStore %55 %54 
					                        Private bool* %57 = OpAccessChain %36 %56 
					                                 bool %58 = OpLoad %57 
					                                  f32 %61 = OpSelect %58 %59 %60 
					                         Private f32* %62 = OpAccessChain %27 %56 
					                                              OpStore %62 %61 
					                        Private bool* %63 = OpAccessChain %36 %17 
					                                 bool %64 = OpLoad %63 
					                                  f32 %65 = OpSelect %64 %59 %60 
					                         Private f32* %66 = OpAccessChain %27 %17 
					                                              OpStore %66 %65 
					                                f32_4 %70 = OpLoad %27 
					                                f32_2 %71 = OpVectorShuffle %70 %70 2 3 
					                                f32_4 %72 = OpLoad %9 
					                                f32_2 %73 = OpVectorShuffle %72 %72 0 1 
					                                f32_2 %74 = OpFMul %71 %73 
					                                              OpStore %69 %74 
					                                f32_2 %75 = OpLoad %69 
					                                f32_2 %76 = OpExtInst %1 10 %75 
					                                              OpStore %69 %76 
					                                f32_2 %77 = OpLoad %69 
					                                f32_4 %78 = OpLoad %27 
					                                f32_2 %79 = OpVectorShuffle %78 %78 0 1 
					                                f32_2 %80 = OpFMul %77 %79 
					                                f32_4 %81 = OpLoad %27 
					                                f32_4 %82 = OpVectorShuffle %81 %80 4 5 2 3 
					                                              OpStore %27 %82 
					                                f32_4 %87 = OpLoad %27 
					                                f32_2 %88 = OpVectorShuffle %87 %87 0 1 
					                                i32_2 %89 = OpConvertFToS %88 
					                                              OpStore %86 %89 
					                         Private i32* %91 = OpAccessChain %86 %51 
					                                  i32 %92 = OpLoad %91 
					                         Private i32* %93 = OpAccessChain %86 %42 
					                                  i32 %94 = OpLoad %93 
					                                  i32 %95 = OpIAdd %92 %94 
					                         Private i32* %96 = OpAccessChain %86 %42 
					                                              OpStore %96 %95 
					                         Private i32* %97 = OpAccessChain %86 %42 
					                                  i32 %98 = OpLoad %97 
					                                bool %100 = OpIEqual %98 %99 
					                       Private bool* %101 = OpAccessChain %36 %42 
					                                              OpStore %101 %100 
					                 read_only Texture2D %106 = OpLoad %105 
					                             sampler %110 = OpLoad %109 
					          read_only Texture2DSampled %112 = OpSampledImage %106 %110 
					                               f32_2 %115 = OpLoad vs_TEXCOORD0 
					                               f32_4 %116 = OpImageSampleImplicitLod %112 %115 
					                                 f32 %117 = OpCompositeExtract %116 0 
					                                              OpStore %102 %117 
					                 read_only Texture2D %118 = OpLoad %105 
					                             sampler %119 = OpLoad %109 
					          read_only Texture2DSampled %120 = OpSampledImage %118 %119 
					                               f32_2 %122 = OpLoad vs_TEXCOORD1 
					                               f32_4 %123 = OpImageSampleImplicitLod %120 %122 
					                                 f32 %124 = OpCompositeExtract %123 0 
					                        Private f32* %125 = OpAccessChain %69 %42 
					                                              OpStore %125 %124 
					                        Private f32* %127 = OpAccessChain %69 %42 
					                                 f32 %128 = OpLoad %127 
					                                 f32 %129 = OpLoad %102 
					                                 f32 %130 = OpExtInst %1 37 %128 %129 
					                                              OpStore %126 %130 
					                        Private f32* %131 = OpAccessChain %69 %42 
					                                 f32 %132 = OpLoad %131 
					                                 f32 %133 = OpLoad %102 
					                                 f32 %134 = OpExtInst %1 40 %132 %133 
					                                              OpStore %102 %134 
					                 read_only Texture2D %135 = OpLoad %105 
					                             sampler %136 = OpLoad %109 
					          read_only Texture2DSampled %137 = OpSampledImage %135 %136 
					                               f32_2 %139 = OpLoad vs_TEXCOORD2 
					                               f32_4 %140 = OpImageSampleImplicitLod %137 %139 
					                                 f32 %141 = OpCompositeExtract %140 0 
					                        Private f32* %142 = OpAccessChain %69 %42 
					                                              OpStore %142 %141 
					                 read_only Texture2D %144 = OpLoad %105 
					                             sampler %145 = OpLoad %109 
					          read_only Texture2DSampled %146 = OpSampledImage %144 %145 
					                               f32_2 %148 = OpLoad vs_TEXCOORD3 
					                               f32_4 %149 = OpImageSampleImplicitLod %146 %148 
					                                 f32 %150 = OpCompositeExtract %149 0 
					                                              OpStore %143 %150 
					                        Private f32* %152 = OpAccessChain %69 %42 
					                                 f32 %153 = OpLoad %152 
					                                 f32 %154 = OpLoad %143 
					                                 f32 %155 = OpExtInst %1 37 %153 %154 
					                                              OpStore %151 %155 
					                        Private f32* %156 = OpAccessChain %69 %42 
					                                 f32 %157 = OpLoad %156 
					                                 f32 %158 = OpLoad %143 
					                                 f32 %159 = OpExtInst %1 40 %157 %158 
					                        Private f32* %160 = OpAccessChain %69 %42 
					                                              OpStore %160 %159 
					                        Private f32* %161 = OpAccessChain %69 %42 
					                                 f32 %162 = OpLoad %161 
					                                 f32 %163 = OpLoad %102 
					                                 f32 %164 = OpExtInst %1 40 %162 %163 
					                                              OpStore %102 %164 
					                                 f32 %165 = OpLoad %126 
					                                 f32 %166 = OpLoad %151 
					                                 f32 %167 = OpExtInst %1 37 %165 %166 
					                        Private f32* %168 = OpAccessChain %69 %42 
					                                              OpStore %168 %167 
					                       Private bool* %171 = OpAccessChain %36 %42 
					                                bool %172 = OpLoad %171 
					                                              OpSelectionMerge %176 None 
					                                              OpBranchConditional %172 %175 %179 
					                                     %175 = OpLabel 
					                        Private f32* %177 = OpAccessChain %69 %42 
					                                 f32 %178 = OpLoad %177 
					                                              OpStore %174 %178 
					                                              OpBranch %176 
					                                     %179 = OpLabel 
					                                 f32 %180 = OpLoad %102 
					                                              OpStore %174 %180 
					                                              OpBranch %176 
					                                     %176 = OpLabel 
					                                 f32 %181 = OpLoad %174 
					                                              OpStore %170 %181 
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
					uniform  sampler2D _HalfResDepthBuffer;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					layout(location = 0) out float SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					float u_xlat9;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0 = hlslcc_FragCoord.xyxy + hlslcc_FragCoord.xyxy;
					    u_xlatb0 = greaterThanEqual(u_xlat0, (-u_xlat0.zwzw));
					    u_xlat0.x = (u_xlatb0.x) ? float(2.0) : float(-2.0);
					    u_xlat0.y = (u_xlatb0.y) ? float(2.0) : float(-2.0);
					    u_xlat0.z = (u_xlatb0.z) ? float(0.5) : float(-0.5);
					    u_xlat0.w = (u_xlatb0.w) ? float(0.5) : float(-0.5);
					    u_xlat6.xy = u_xlat0.zw * hlslcc_FragCoord.xy;
					    u_xlat6.xy = fract(u_xlat6.xy);
					    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
					    u_xlati0.xy = ivec2(u_xlat0.xy);
					    u_xlati0.x = u_xlati0.y + u_xlati0.x;
					    u_xlatb0.x = u_xlati0.x==1;
					    u_xlat1 = texture(_HalfResDepthBuffer, vs_TEXCOORD0.xy);
					    u_xlat2 = texture(_HalfResDepthBuffer, vs_TEXCOORD1.xy);
					    u_xlat3 = min(u_xlat1.x, u_xlat2.x);
					    u_xlat6.x = max(u_xlat1.x, u_xlat2.x);
					    u_xlat1 = texture(_HalfResDepthBuffer, vs_TEXCOORD2.xy);
					    u_xlat2 = texture(_HalfResDepthBuffer, vs_TEXCOORD3.xy);
					    u_xlat9 = min(u_xlat1.x, u_xlat2.x);
					    u_xlat1.x = max(u_xlat1.x, u_xlat2.x);
					    u_xlat6.x = max(u_xlat6.x, u_xlat1.x);
					    u_xlat3 = min(u_xlat9, u_xlat3);
					    SV_Target0 = (u_xlatb0.x) ? u_xlat3 : u_xlat6.x;
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