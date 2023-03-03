Shader "Decal/particle decal" {
	Properties {
		[HDR] _TintColor ("Tint Color", Vector) = (1,1,1,1)
		_Texture ("Texture", 2D) = "white" {}
		_scale ("scale", Float) = 1
		_range ("Range", Range(0, 50)) = 1
		[Enum(UnityEngine.Rendering.BlendMode)] BlenDST ("Blend mode Destination", Float) = 10
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
			Blend SrcAlpha Zero, SrcAlpha Zero
			ZTest Always
			ZWrite Off
			Cull Front
			GpuProgramID 43029
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
						vec4 unused_1_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_1_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD2;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat1.xyz = u_xlat0.xwy * vec3(0.5, 0.5, -0.5);
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat1.yy + u_xlat1.xz;
					    u_xlat0.xyz = in_TEXCOORD1.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_TEXCOORD1.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_TEXCOORD1.www + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + unity_ObjectToWorld[3].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat0.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[3].www + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(-1.0, -1.0, 1.0) + in_TEXCOORD0.xyz;
					    u_xlatb6 = in_TEXCOORD0.z!=0.0;
					    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3 = in_TEXCOORD2;
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
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in  vec4 in_POSITION0;
					in  vec3 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD2;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat1.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xy;
					    u_xlat0.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD1.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_TEXCOORD1.www + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(-1.0, -1.0, 1.0) + in_TEXCOORD0.xyz;
					    u_xlatb6 = in_TEXCOORD0.z!=0.0;
					    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3 = in_TEXCOORD2;
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
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
					uniform 	float _range;
					uniform 	float _scale;
					uniform 	vec4 _TintColor;
					UNITY_LOCATION(0) uniform  sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform  sampler2D _Texture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat9;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
					    u_xlat0 = texture(_CameraDepthTexture, u_xlat0.xy);
					    u_xlat0.x = dot(u_xlat0.xy, vec2(1.0, 0.00392156886));
					    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD2.z;
					    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
					    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
					    u_xlat1 = dFdx(u_xlat0.zxyx);
					    u_xlat2 = dFdy(u_xlat0.xyzy);
					    u_xlat3 = u_xlat1 * u_xlat2;
					    u_xlat1 = u_xlat2.zxwx * u_xlat1.wzxz + (-u_xlat3);
					    u_xlat12 = dot(u_xlat1.xzw, u_xlat1.xzw);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1 = vec4(u_xlat12) * u_xlat1;
					    u_xlatb2 = greaterThanEqual(abs(u_xlat1.zzxx), abs(u_xlat1));
					    u_xlatb1.xy = greaterThanEqual(abs(u_xlat1.wwww), abs(u_xlat1.zxzz)).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat12 = u_xlat1.y * u_xlat1.x;
					    u_xlat1.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb2.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb2.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb2.w ? float(1.0) : 0.0;
					;
					    u_xlat1 = u_xlat1.yyww * u_xlat1.xxzz;
					    u_xlat2 = u_xlat0.zyxz + (-vs_TEXCOORD1.zyxz);
					    u_xlat3.x = vs_TEXCOORD3.x + -1.0;
					    u_xlat3.x = u_xlat3.x * (-_scale);
					    u_xlat2 = u_xlat2 * u_xlat3.xxxx + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1.xy = u_xlat1.zw + u_xlat1.xy;
					    u_xlat9.xy = u_xlat0.xy + (-vs_TEXCOORD1.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD1.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlatb0 = _range>=u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat4.xy = u_xlat9.xy * u_xlat3.xx + vec2(0.5, 0.5);
					    u_xlat4.xy = vec2(u_xlat12) * u_xlat4.xy + u_xlat1.xy;
					    u_xlat4.xy = u_xlat4.xy + vec2(-0.5, -0.5);
					    u_xlat12 = vs_TEXCOORD3.y * 0.0174532924;
					    u_xlat1.x = sin(u_xlat12);
					    u_xlat2.x = cos(u_xlat12);
					    u_xlat3.x = sin((-u_xlat12));
					    u_xlat3.z = u_xlat1.x;
					    u_xlat3.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yz);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat4.xy = u_xlat1.xy + vec2(0.5, 0.5);
					    u_xlat1 = texture(_Texture, u_xlat4.xy);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1;
					    u_xlat0 = u_xlat0 * vs_COLOR0;
					    SV_Target0 = u_xlat0 * _TintColor;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 425
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %11 %80 %93 %106 %149 %386 %404 %413 %414 %416 %417 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %16 ArrayStride 16 
					                                                      OpDecorate %17 ArrayStride 17 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpMemberDecorate %19 0 Offset 19 
					                                                      OpMemberDecorate %19 1 Offset 19 
					                                                      OpMemberDecorate %19 2 Offset 19 
					                                                      OpDecorate %19 Block 
					                                                      OpDecorate %21 DescriptorSet 21 
					                                                      OpDecorate %21 Binding 21 
					                                                      OpMemberDecorate %78 0 BuiltIn 78 
					                                                      OpMemberDecorate %78 1 BuiltIn 78 
					                                                      OpMemberDecorate %78 2 BuiltIn 78 
					                                                      OpDecorate %78 Block 
					                                                      OpDecorate vs_TEXCOORD0 Location 93 
					                                                      OpDecorate %106 Location 106 
					                                                      OpDecorate vs_TEXCOORD1 Location 149 
					                                                      OpDecorate %386 Location 386 
					                                                      OpDecorate vs_TEXCOORD2 Location 404 
					                                                      OpDecorate %413 Location 413 
					                                                      OpDecorate %414 Location 414 
					                                                      OpDecorate vs_TEXCOORD3 Location 416 
					                                                      OpDecorate %417 Location 417 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %14 = OpTypeInt 32 0 
					                                          u32 %15 = OpConstant 4 
					                                              %16 = OpTypeArray %7 %15 
					                                              %17 = OpTypeArray %7 %15 
					                                              %18 = OpTypeArray %7 %15 
					                                              %19 = OpTypeStruct %16 %17 %18 
					                                              %20 = OpTypePointer Uniform %19 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4[4];}* %21 = OpVariable Uniform 
					                                              %22 = OpTypeInt 32 1 
					                                          i32 %23 = OpConstant 0 
					                                          i32 %24 = OpConstant 1 
					                                              %25 = OpTypePointer Uniform %7 
					                                          i32 %36 = OpConstant 2 
					                                          i32 %45 = OpConstant 3 
					                               Private f32_4* %49 = OpVariable Private 
					                                          u32 %76 = OpConstant 1 
					                                              %77 = OpTypeArray %6 %76 
					                                              %78 = OpTypeStruct %7 %6 %77 
					                                              %79 = OpTypePointer Output %78 
					         Output struct {f32_4; f32; f32[1];}* %80 = OpVariable Output 
					                                              %82 = OpTypePointer Output %7 
					                                              %84 = OpTypeVector %6 3 
					                                          f32 %87 = OpConstant 3,674022E-40 
					                                          f32 %88 = OpConstant 3,674022E-40 
					                                        f32_3 %89 = OpConstantComposite %87 %87 %88 
					                       Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                                              %94 = OpTypeVector %6 2 
					                                Input f32_4* %106 = OpVariable Input 
					                                             %148 = OpTypePointer Output %84 
					                       Output f32_3* vs_TEXCOORD1 = OpVariable Output 
					                                         f32 %375 = OpConstant 3,674022E-40 
					                                         f32 %376 = OpConstant 3,674022E-40 
					                                       f32_3 %377 = OpConstantComposite %375 %375 %376 
					                                             %385 = OpTypePointer Input %84 
					                                Input f32_3* %386 = OpVariable Input 
					                                             %391 = OpTypeBool 
					                                             %392 = OpTypePointer Private %391 
					                               Private bool* %393 = OpVariable Private 
					                                         u32 %394 = OpConstant 2 
					                                             %395 = OpTypePointer Input %6 
					                                         f32 %398 = OpConstant 3,674022E-40 
					                                             %400 = OpTypePointer Private %6 
					                                Private f32* %401 = OpVariable Private 
					                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
					                               Output f32_4* %413 = OpVariable Output 
					                                Input f32_4* %414 = OpVariable Input 
					                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
					                                Input f32_4* %417 = OpVariable Input 
					                                             %419 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
					                               Uniform f32_4* %26 = OpAccessChain %21 %23 %24 
					                                        f32_4 %27 = OpLoad %26 
					                                        f32_4 %28 = OpFMul %13 %27 
					                                                      OpStore %9 %28 
					                               Uniform f32_4* %29 = OpAccessChain %21 %23 %23 
					                                        f32_4 %30 = OpLoad %29 
					                                        f32_4 %31 = OpLoad %11 
					                                        f32_4 %32 = OpVectorShuffle %31 %31 0 0 0 0 
					                                        f32_4 %33 = OpFMul %30 %32 
					                                        f32_4 %34 = OpLoad %9 
					                                        f32_4 %35 = OpFAdd %33 %34 
					                                                      OpStore %9 %35 
					                               Uniform f32_4* %37 = OpAccessChain %21 %23 %36 
					                                        f32_4 %38 = OpLoad %37 
					                                        f32_4 %39 = OpLoad %11 
					                                        f32_4 %40 = OpVectorShuffle %39 %39 2 2 2 2 
					                                        f32_4 %41 = OpFMul %38 %40 
					                                        f32_4 %42 = OpLoad %9 
					                                        f32_4 %43 = OpFAdd %41 %42 
					                                                      OpStore %9 %43 
					                                        f32_4 %44 = OpLoad %9 
					                               Uniform f32_4* %46 = OpAccessChain %21 %23 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_4 %48 = OpFAdd %44 %47 
					                                                      OpStore %9 %48 
					                                        f32_4 %50 = OpLoad %9 
					                                        f32_4 %51 = OpVectorShuffle %50 %50 1 1 1 1 
					                               Uniform f32_4* %52 = OpAccessChain %21 %36 %24 
					                                        f32_4 %53 = OpLoad %52 
					                                        f32_4 %54 = OpFMul %51 %53 
					                                                      OpStore %49 %54 
					                               Uniform f32_4* %55 = OpAccessChain %21 %36 %23 
					                                        f32_4 %56 = OpLoad %55 
					                                        f32_4 %57 = OpLoad %9 
					                                        f32_4 %58 = OpVectorShuffle %57 %57 0 0 0 0 
					                                        f32_4 %59 = OpFMul %56 %58 
					                                        f32_4 %60 = OpLoad %49 
					                                        f32_4 %61 = OpFAdd %59 %60 
					                                                      OpStore %49 %61 
					                               Uniform f32_4* %62 = OpAccessChain %21 %36 %36 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_4 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 2 2 2 2 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %49 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %49 %68 
					                               Uniform f32_4* %69 = OpAccessChain %21 %36 %45 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %9 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 3 3 3 3 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %49 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %9 %75 
					                                        f32_4 %81 = OpLoad %9 
					                                Output f32_4* %83 = OpAccessChain %80 %23 
					                                                      OpStore %83 %81 
					                                        f32_4 %85 = OpLoad %9 
					                                        f32_3 %86 = OpVectorShuffle %85 %85 0 3 1 
					                                        f32_3 %90 = OpFMul %86 %89 
					                                        f32_4 %91 = OpLoad %49 
					                                        f32_4 %92 = OpVectorShuffle %91 %90 4 5 6 3 
					                                                      OpStore %49 %92 
					                                        f32_4 %95 = OpLoad %9 
					                                        f32_2 %96 = OpVectorShuffle %95 %95 2 3 
					                                        f32_4 %97 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %98 = OpVectorShuffle %97 %96 0 1 4 5 
					                                                      OpStore vs_TEXCOORD0 %98 
					                                        f32_4 %99 = OpLoad %49 
					                                       f32_2 %100 = OpVectorShuffle %99 %99 1 1 
					                                       f32_4 %101 = OpLoad %49 
					                                       f32_2 %102 = OpVectorShuffle %101 %101 0 2 
					                                       f32_2 %103 = OpFAdd %100 %102 
					                                       f32_4 %104 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %105 = OpVectorShuffle %104 %103 4 5 2 3 
					                                                      OpStore vs_TEXCOORD0 %105 
					                                       f32_4 %107 = OpLoad %106 
					                                       f32_3 %108 = OpVectorShuffle %107 %107 1 1 1 
					                              Uniform f32_4* %109 = OpAccessChain %21 %23 %24 
					                                       f32_4 %110 = OpLoad %109 
					                                       f32_3 %111 = OpVectorShuffle %110 %110 0 1 2 
					                                       f32_3 %112 = OpFMul %108 %111 
					                                       f32_4 %113 = OpLoad %9 
					                                       f32_4 %114 = OpVectorShuffle %113 %112 4 5 6 3 
					                                                      OpStore %9 %114 
					                              Uniform f32_4* %115 = OpAccessChain %21 %23 %23 
					                                       f32_4 %116 = OpLoad %115 
					                                       f32_3 %117 = OpVectorShuffle %116 %116 0 1 2 
					                                       f32_4 %118 = OpLoad %106 
					                                       f32_3 %119 = OpVectorShuffle %118 %118 0 0 0 
					                                       f32_3 %120 = OpFMul %117 %119 
					                                       f32_4 %121 = OpLoad %9 
					                                       f32_3 %122 = OpVectorShuffle %121 %121 0 1 2 
					                                       f32_3 %123 = OpFAdd %120 %122 
					                                       f32_4 %124 = OpLoad %9 
					                                       f32_4 %125 = OpVectorShuffle %124 %123 4 5 6 3 
					                                                      OpStore %9 %125 
					                              Uniform f32_4* %126 = OpAccessChain %21 %23 %36 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_3 %128 = OpVectorShuffle %127 %127 0 1 2 
					                                       f32_4 %129 = OpLoad %106 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 2 2 2 
					                                       f32_3 %131 = OpFMul %128 %130 
					                                       f32_4 %132 = OpLoad %9 
					                                       f32_3 %133 = OpVectorShuffle %132 %132 0 1 2 
					                                       f32_3 %134 = OpFAdd %131 %133 
					                                       f32_4 %135 = OpLoad %9 
					                                       f32_4 %136 = OpVectorShuffle %135 %134 4 5 6 3 
					                                                      OpStore %9 %136 
					                              Uniform f32_4* %137 = OpAccessChain %21 %23 %45 
					                                       f32_4 %138 = OpLoad %137 
					                                       f32_3 %139 = OpVectorShuffle %138 %138 0 1 2 
					                                       f32_4 %140 = OpLoad %106 
					                                       f32_3 %141 = OpVectorShuffle %140 %140 3 3 3 
					                                       f32_3 %142 = OpFMul %139 %141 
					                                       f32_4 %143 = OpLoad %9 
					                                       f32_3 %144 = OpVectorShuffle %143 %143 0 1 2 
					                                       f32_3 %145 = OpFAdd %142 %144 
					                                       f32_4 %146 = OpLoad %9 
					                                       f32_4 %147 = OpVectorShuffle %146 %145 4 5 6 3 
					                                                      OpStore %9 %147 
					                                       f32_4 %150 = OpLoad %9 
					                                       f32_3 %151 = OpVectorShuffle %150 %150 0 1 2 
					                              Uniform f32_4* %152 = OpAccessChain %21 %23 %45 
					                                       f32_4 %153 = OpLoad %152 
					                                       f32_3 %154 = OpVectorShuffle %153 %153 0 1 2 
					                                       f32_3 %155 = OpFAdd %151 %154 
					                                                      OpStore vs_TEXCOORD1 %155 
					                              Uniform f32_4* %156 = OpAccessChain %21 %23 %24 
					                                       f32_4 %157 = OpLoad %156 
					                                       f32_3 %158 = OpVectorShuffle %157 %157 1 1 1 
					                              Uniform f32_4* %159 = OpAccessChain %21 %24 %24 
					                                       f32_4 %160 = OpLoad %159 
					                                       f32_3 %161 = OpVectorShuffle %160 %160 0 1 2 
					                                       f32_3 %162 = OpFMul %158 %161 
					                                       f32_4 %163 = OpLoad %9 
					                                       f32_4 %164 = OpVectorShuffle %163 %162 4 5 6 3 
					                                                      OpStore %9 %164 
					                              Uniform f32_4* %165 = OpAccessChain %21 %24 %23 
					                                       f32_4 %166 = OpLoad %165 
					                                       f32_3 %167 = OpVectorShuffle %166 %166 0 1 2 
					                              Uniform f32_4* %168 = OpAccessChain %21 %23 %24 
					                                       f32_4 %169 = OpLoad %168 
					                                       f32_3 %170 = OpVectorShuffle %169 %169 0 0 0 
					                                       f32_3 %171 = OpFMul %167 %170 
					                                       f32_4 %172 = OpLoad %9 
					                                       f32_3 %173 = OpVectorShuffle %172 %172 0 1 2 
					                                       f32_3 %174 = OpFAdd %171 %173 
					                                       f32_4 %175 = OpLoad %9 
					                                       f32_4 %176 = OpVectorShuffle %175 %174 4 5 6 3 
					                                                      OpStore %9 %176 
					                              Uniform f32_4* %177 = OpAccessChain %21 %24 %36 
					                                       f32_4 %178 = OpLoad %177 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                              Uniform f32_4* %180 = OpAccessChain %21 %23 %24 
					                                       f32_4 %181 = OpLoad %180 
					                                       f32_3 %182 = OpVectorShuffle %181 %181 2 2 2 
					                                       f32_3 %183 = OpFMul %179 %182 
					                                       f32_4 %184 = OpLoad %9 
					                                       f32_3 %185 = OpVectorShuffle %184 %184 0 1 2 
					                                       f32_3 %186 = OpFAdd %183 %185 
					                                       f32_4 %187 = OpLoad %9 
					                                       f32_4 %188 = OpVectorShuffle %187 %186 4 5 6 3 
					                                                      OpStore %9 %188 
					                              Uniform f32_4* %189 = OpAccessChain %21 %24 %45 
					                                       f32_4 %190 = OpLoad %189 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                              Uniform f32_4* %192 = OpAccessChain %21 %23 %24 
					                                       f32_4 %193 = OpLoad %192 
					                                       f32_3 %194 = OpVectorShuffle %193 %193 3 3 3 
					                                       f32_3 %195 = OpFMul %191 %194 
					                                       f32_4 %196 = OpLoad %9 
					                                       f32_3 %197 = OpVectorShuffle %196 %196 0 1 2 
					                                       f32_3 %198 = OpFAdd %195 %197 
					                                       f32_4 %199 = OpLoad %9 
					                                       f32_4 %200 = OpVectorShuffle %199 %198 4 5 6 3 
					                                                      OpStore %9 %200 
					                                       f32_4 %201 = OpLoad %9 
					                                       f32_3 %202 = OpVectorShuffle %201 %201 0 1 2 
					                                       f32_4 %203 = OpLoad %11 
					                                       f32_3 %204 = OpVectorShuffle %203 %203 1 1 1 
					                                       f32_3 %205 = OpFMul %202 %204 
					                                       f32_4 %206 = OpLoad %9 
					                                       f32_4 %207 = OpVectorShuffle %206 %205 4 5 6 3 
					                                                      OpStore %9 %207 
					                              Uniform f32_4* %208 = OpAccessChain %21 %23 %23 
					                                       f32_4 %209 = OpLoad %208 
					                                       f32_3 %210 = OpVectorShuffle %209 %209 1 1 1 
					                              Uniform f32_4* %211 = OpAccessChain %21 %24 %24 
					                                       f32_4 %212 = OpLoad %211 
					                                       f32_3 %213 = OpVectorShuffle %212 %212 0 1 2 
					                                       f32_3 %214 = OpFMul %210 %213 
					                                       f32_4 %215 = OpLoad %49 
					                                       f32_4 %216 = OpVectorShuffle %215 %214 4 5 6 3 
					                                                      OpStore %49 %216 
					                              Uniform f32_4* %217 = OpAccessChain %21 %24 %23 
					                                       f32_4 %218 = OpLoad %217 
					                                       f32_3 %219 = OpVectorShuffle %218 %218 0 1 2 
					                              Uniform f32_4* %220 = OpAccessChain %21 %23 %23 
					                                       f32_4 %221 = OpLoad %220 
					                                       f32_3 %222 = OpVectorShuffle %221 %221 0 0 0 
					                                       f32_3 %223 = OpFMul %219 %222 
					                                       f32_4 %224 = OpLoad %49 
					                                       f32_3 %225 = OpVectorShuffle %224 %224 0 1 2 
					                                       f32_3 %226 = OpFAdd %223 %225 
					                                       f32_4 %227 = OpLoad %49 
					                                       f32_4 %228 = OpVectorShuffle %227 %226 4 5 6 3 
					                                                      OpStore %49 %228 
					                              Uniform f32_4* %229 = OpAccessChain %21 %24 %36 
					                                       f32_4 %230 = OpLoad %229 
					                                       f32_3 %231 = OpVectorShuffle %230 %230 0 1 2 
					                              Uniform f32_4* %232 = OpAccessChain %21 %23 %23 
					                                       f32_4 %233 = OpLoad %232 
					                                       f32_3 %234 = OpVectorShuffle %233 %233 2 2 2 
					                                       f32_3 %235 = OpFMul %231 %234 
					                                       f32_4 %236 = OpLoad %49 
					                                       f32_3 %237 = OpVectorShuffle %236 %236 0 1 2 
					                                       f32_3 %238 = OpFAdd %235 %237 
					                                       f32_4 %239 = OpLoad %49 
					                                       f32_4 %240 = OpVectorShuffle %239 %238 4 5 6 3 
					                                                      OpStore %49 %240 
					                              Uniform f32_4* %241 = OpAccessChain %21 %24 %45 
					                                       f32_4 %242 = OpLoad %241 
					                                       f32_3 %243 = OpVectorShuffle %242 %242 0 1 2 
					                              Uniform f32_4* %244 = OpAccessChain %21 %23 %23 
					                                       f32_4 %245 = OpLoad %244 
					                                       f32_3 %246 = OpVectorShuffle %245 %245 3 3 3 
					                                       f32_3 %247 = OpFMul %243 %246 
					                                       f32_4 %248 = OpLoad %49 
					                                       f32_3 %249 = OpVectorShuffle %248 %248 0 1 2 
					                                       f32_3 %250 = OpFAdd %247 %249 
					                                       f32_4 %251 = OpLoad %49 
					                                       f32_4 %252 = OpVectorShuffle %251 %250 4 5 6 3 
					                                                      OpStore %49 %252 
					                                       f32_4 %253 = OpLoad %49 
					                                       f32_3 %254 = OpVectorShuffle %253 %253 0 1 2 
					                                       f32_4 %255 = OpLoad %11 
					                                       f32_3 %256 = OpVectorShuffle %255 %255 0 0 0 
					                                       f32_3 %257 = OpFMul %254 %256 
					                                       f32_4 %258 = OpLoad %9 
					                                       f32_3 %259 = OpVectorShuffle %258 %258 0 1 2 
					                                       f32_3 %260 = OpFAdd %257 %259 
					                                       f32_4 %261 = OpLoad %9 
					                                       f32_4 %262 = OpVectorShuffle %261 %260 4 5 6 3 
					                                                      OpStore %9 %262 
					                              Uniform f32_4* %263 = OpAccessChain %21 %23 %36 
					                                       f32_4 %264 = OpLoad %263 
					                                       f32_3 %265 = OpVectorShuffle %264 %264 1 1 1 
					                              Uniform f32_4* %266 = OpAccessChain %21 %24 %24 
					                                       f32_4 %267 = OpLoad %266 
					                                       f32_3 %268 = OpVectorShuffle %267 %267 0 1 2 
					                                       f32_3 %269 = OpFMul %265 %268 
					                                       f32_4 %270 = OpLoad %49 
					                                       f32_4 %271 = OpVectorShuffle %270 %269 4 5 6 3 
					                                                      OpStore %49 %271 
					                              Uniform f32_4* %272 = OpAccessChain %21 %24 %23 
					                                       f32_4 %273 = OpLoad %272 
					                                       f32_3 %274 = OpVectorShuffle %273 %273 0 1 2 
					                              Uniform f32_4* %275 = OpAccessChain %21 %23 %36 
					                                       f32_4 %276 = OpLoad %275 
					                                       f32_3 %277 = OpVectorShuffle %276 %276 0 0 0 
					                                       f32_3 %278 = OpFMul %274 %277 
					                                       f32_4 %279 = OpLoad %49 
					                                       f32_3 %280 = OpVectorShuffle %279 %279 0 1 2 
					                                       f32_3 %281 = OpFAdd %278 %280 
					                                       f32_4 %282 = OpLoad %49 
					                                       f32_4 %283 = OpVectorShuffle %282 %281 4 5 6 3 
					                                                      OpStore %49 %283 
					                              Uniform f32_4* %284 = OpAccessChain %21 %24 %36 
					                                       f32_4 %285 = OpLoad %284 
					                                       f32_3 %286 = OpVectorShuffle %285 %285 0 1 2 
					                              Uniform f32_4* %287 = OpAccessChain %21 %23 %36 
					                                       f32_4 %288 = OpLoad %287 
					                                       f32_3 %289 = OpVectorShuffle %288 %288 2 2 2 
					                                       f32_3 %290 = OpFMul %286 %289 
					                                       f32_4 %291 = OpLoad %49 
					                                       f32_3 %292 = OpVectorShuffle %291 %291 0 1 2 
					                                       f32_3 %293 = OpFAdd %290 %292 
					                                       f32_4 %294 = OpLoad %49 
					                                       f32_4 %295 = OpVectorShuffle %294 %293 4 5 6 3 
					                                                      OpStore %49 %295 
					                              Uniform f32_4* %296 = OpAccessChain %21 %24 %45 
					                                       f32_4 %297 = OpLoad %296 
					                                       f32_3 %298 = OpVectorShuffle %297 %297 0 1 2 
					                              Uniform f32_4* %299 = OpAccessChain %21 %23 %36 
					                                       f32_4 %300 = OpLoad %299 
					                                       f32_3 %301 = OpVectorShuffle %300 %300 3 3 3 
					                                       f32_3 %302 = OpFMul %298 %301 
					                                       f32_4 %303 = OpLoad %49 
					                                       f32_3 %304 = OpVectorShuffle %303 %303 0 1 2 
					                                       f32_3 %305 = OpFAdd %302 %304 
					                                       f32_4 %306 = OpLoad %49 
					                                       f32_4 %307 = OpVectorShuffle %306 %305 4 5 6 3 
					                                                      OpStore %49 %307 
					                                       f32_4 %308 = OpLoad %49 
					                                       f32_3 %309 = OpVectorShuffle %308 %308 0 1 2 
					                                       f32_4 %310 = OpLoad %11 
					                                       f32_3 %311 = OpVectorShuffle %310 %310 2 2 2 
					                                       f32_3 %312 = OpFMul %309 %311 
					                                       f32_4 %313 = OpLoad %9 
					                                       f32_3 %314 = OpVectorShuffle %313 %313 0 1 2 
					                                       f32_3 %315 = OpFAdd %312 %314 
					                                       f32_4 %316 = OpLoad %9 
					                                       f32_4 %317 = OpVectorShuffle %316 %315 4 5 6 3 
					                                                      OpStore %9 %317 
					                              Uniform f32_4* %318 = OpAccessChain %21 %23 %45 
					                                       f32_4 %319 = OpLoad %318 
					                                       f32_3 %320 = OpVectorShuffle %319 %319 1 1 1 
					                              Uniform f32_4* %321 = OpAccessChain %21 %24 %24 
					                                       f32_4 %322 = OpLoad %321 
					                                       f32_3 %323 = OpVectorShuffle %322 %322 0 1 2 
					                                       f32_3 %324 = OpFMul %320 %323 
					                                       f32_4 %325 = OpLoad %49 
					                                       f32_4 %326 = OpVectorShuffle %325 %324 4 5 6 3 
					                                                      OpStore %49 %326 
					                              Uniform f32_4* %327 = OpAccessChain %21 %24 %23 
					                                       f32_4 %328 = OpLoad %327 
					                                       f32_3 %329 = OpVectorShuffle %328 %328 0 1 2 
					                              Uniform f32_4* %330 = OpAccessChain %21 %23 %45 
					                                       f32_4 %331 = OpLoad %330 
					                                       f32_3 %332 = OpVectorShuffle %331 %331 0 0 0 
					                                       f32_3 %333 = OpFMul %329 %332 
					                                       f32_4 %334 = OpLoad %49 
					                                       f32_3 %335 = OpVectorShuffle %334 %334 0 1 2 
					                                       f32_3 %336 = OpFAdd %333 %335 
					                                       f32_4 %337 = OpLoad %49 
					                                       f32_4 %338 = OpVectorShuffle %337 %336 4 5 6 3 
					                                                      OpStore %49 %338 
					                              Uniform f32_4* %339 = OpAccessChain %21 %24 %36 
					                                       f32_4 %340 = OpLoad %339 
					                                       f32_3 %341 = OpVectorShuffle %340 %340 0 1 2 
					                              Uniform f32_4* %342 = OpAccessChain %21 %23 %45 
					                                       f32_4 %343 = OpLoad %342 
					                                       f32_3 %344 = OpVectorShuffle %343 %343 2 2 2 
					                                       f32_3 %345 = OpFMul %341 %344 
					                                       f32_4 %346 = OpLoad %49 
					                                       f32_3 %347 = OpVectorShuffle %346 %346 0 1 2 
					                                       f32_3 %348 = OpFAdd %345 %347 
					                                       f32_4 %349 = OpLoad %49 
					                                       f32_4 %350 = OpVectorShuffle %349 %348 4 5 6 3 
					                                                      OpStore %49 %350 
					                              Uniform f32_4* %351 = OpAccessChain %21 %24 %45 
					                                       f32_4 %352 = OpLoad %351 
					                                       f32_3 %353 = OpVectorShuffle %352 %352 0 1 2 
					                              Uniform f32_4* %354 = OpAccessChain %21 %23 %45 
					                                       f32_4 %355 = OpLoad %354 
					                                       f32_3 %356 = OpVectorShuffle %355 %355 3 3 3 
					                                       f32_3 %357 = OpFMul %353 %356 
					                                       f32_4 %358 = OpLoad %49 
					                                       f32_3 %359 = OpVectorShuffle %358 %358 0 1 2 
					                                       f32_3 %360 = OpFAdd %357 %359 
					                                       f32_4 %361 = OpLoad %49 
					                                       f32_4 %362 = OpVectorShuffle %361 %360 4 5 6 3 
					                                                      OpStore %49 %362 
					                                       f32_4 %363 = OpLoad %49 
					                                       f32_3 %364 = OpVectorShuffle %363 %363 0 1 2 
					                                       f32_4 %365 = OpLoad %11 
					                                       f32_3 %366 = OpVectorShuffle %365 %365 3 3 3 
					                                       f32_3 %367 = OpFMul %364 %366 
					                                       f32_4 %368 = OpLoad %9 
					                                       f32_3 %369 = OpVectorShuffle %368 %368 0 1 2 
					                                       f32_3 %370 = OpFAdd %367 %369 
					                                       f32_4 %371 = OpLoad %9 
					                                       f32_4 %372 = OpVectorShuffle %371 %370 4 5 6 3 
					                                                      OpStore %9 %372 
					                                       f32_4 %373 = OpLoad %9 
					                                       f32_3 %374 = OpVectorShuffle %373 %373 0 1 2 
					                                       f32_3 %378 = OpFMul %374 %377 
					                                       f32_4 %379 = OpLoad %49 
					                                       f32_4 %380 = OpVectorShuffle %379 %378 4 5 6 3 
					                                                      OpStore %49 %380 
					                                       f32_4 %381 = OpLoad %9 
					                                       f32_3 %382 = OpVectorShuffle %381 %381 0 1 2 
					                                       f32_3 %383 = OpFNegate %382 
					                                       f32_3 %384 = OpFMul %383 %377 
					                                       f32_3 %387 = OpLoad %386 
					                                       f32_3 %388 = OpFAdd %384 %387 
					                                       f32_4 %389 = OpLoad %9 
					                                       f32_4 %390 = OpVectorShuffle %389 %388 4 5 6 3 
					                                                      OpStore %9 %390 
					                                  Input f32* %396 = OpAccessChain %386 %394 
					                                         f32 %397 = OpLoad %396 
					                                        bool %399 = OpFOrdNotEqual %397 %398 
					                                                      OpStore %393 %399 
					                                        bool %402 = OpLoad %393 
					                                         f32 %403 = OpSelect %402 %376 %398 
					                                                      OpStore %401 %403 
					                                         f32 %405 = OpLoad %401 
					                                       f32_3 %406 = OpCompositeConstruct %405 %405 %405 
					                                       f32_4 %407 = OpLoad %9 
					                                       f32_3 %408 = OpVectorShuffle %407 %407 0 1 2 
					                                       f32_3 %409 = OpFMul %406 %408 
					                                       f32_4 %410 = OpLoad %49 
					                                       f32_3 %411 = OpVectorShuffle %410 %410 0 1 2 
					                                       f32_3 %412 = OpFAdd %409 %411 
					                                                      OpStore vs_TEXCOORD2 %412 
					                                       f32_4 %415 = OpLoad %414 
					                                                      OpStore %413 %415 
					                                       f32_4 %418 = OpLoad %417 
					                                                      OpStore vs_TEXCOORD3 %418 
					                                 Output f32* %420 = OpAccessChain %80 %23 %76 
					                                         f32 %421 = OpLoad %420 
					                                         f32 %422 = OpFNegate %421 
					                                 Output f32* %423 = OpAccessChain %80 %23 %76 
					                                                      OpStore %423 %422 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 381
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %11 %76 %225 %230 %370 %374 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                                      OpDecorate vs_TEXCOORD0 Location 11 
					                                                      OpDecorate %22 DescriptorSet 22 
					                                                      OpDecorate %22 Binding 22 
					                                                      OpDecorate %26 DescriptorSet 26 
					                                                      OpDecorate %26 Binding 26 
					                                                      OpDecorate %47 ArrayStride 47 
					                                                      OpMemberDecorate %48 0 Offset 48 
					                                                      OpMemberDecorate %48 1 Offset 48 
					                                                      OpMemberDecorate %48 2 Offset 48 
					                                                      OpMemberDecorate %48 3 Offset 48 
					                                                      OpMemberDecorate %48 4 Offset 48 
					                                                      OpMemberDecorate %48 5 Offset 48 
					                                                      OpDecorate %48 Block 
					                                                      OpDecorate %50 DescriptorSet 50 
					                                                      OpDecorate %50 Binding 50 
					                                                      OpDecorate vs_TEXCOORD2 Location 76 
					                                                      OpDecorate vs_TEXCOORD1 Location 225 
					                                                      OpDecorate vs_TEXCOORD3 Location 230 
					                                                      OpDecorate %357 DescriptorSet 357 
					                                                      OpDecorate %357 Binding 357 
					                                                      OpDecorate %359 DescriptorSet 359 
					                                                      OpDecorate %359 Binding 359 
					                                                      OpDecorate %370 Location 370 
					                                                      OpDecorate %374 Location 374 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypePointer Input %7 
					                        Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                              %12 = OpTypeVector %6 2 
					                                              %20 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %21 = OpTypePointer UniformConstant %20 
					         UniformConstant read_only Texture2D* %22 = OpVariable UniformConstant 
					                                              %24 = OpTypeSampler 
					                                              %25 = OpTypePointer UniformConstant %24 
					                     UniformConstant sampler* %26 = OpVariable UniformConstant 
					                                              %28 = OpTypeSampledImage %20 
					                                          f32 %38 = OpConstant 3,674022E-40 
					                                          f32 %39 = OpConstant 3,674022E-40 
					                                        f32_2 %40 = OpConstantComposite %38 %39 
					                                              %42 = OpTypeInt 32 0 
					                                          u32 %43 = OpConstant 0 
					                                              %44 = OpTypePointer Private %6 
					                                          u32 %46 = OpConstant 4 
					                                              %47 = OpTypeArray %7 %46 
					                                              %48 = OpTypeStruct %7 %7 %47 %6 %6 %7 
					                                              %49 = OpTypePointer Uniform %48 
					Uniform struct {f32_4; f32_4; f32_4[4]; f32; f32; f32_4;}* %50 = OpVariable Uniform 
					                                              %51 = OpTypeInt 32 1 
					                                          i32 %52 = OpConstant 1 
					                                              %53 = OpTypePointer Uniform %6 
					                                          u32 %59 = OpConstant 1 
					                                              %68 = OpTypeVector %6 3 
					                                              %69 = OpTypePointer Private %68 
					                               Private f32_3* %70 = OpVariable Private 
					                                          i32 %71 = OpConstant 0 
					                                          u32 %72 = OpConstant 2 
					                                              %75 = OpTypePointer Input %68 
					                        Input f32_3* vs_TEXCOORD2 = OpVariable Input 
					                                              %77 = OpTypePointer Input %6 
					                               Private f32_4* %92 = OpVariable Private 
					                                          i32 %95 = OpConstant 2 
					                                              %96 = OpTypePointer Uniform %7 
					                                         i32 %127 = OpConstant 3 
					                              Private f32_4* %137 = OpVariable Private 
					                              Private f32_4* %141 = OpVariable Private 
					                                Private f32* %153 = OpVariable Private 
					                                             %165 = OpTypeBool 
					                                             %166 = OpTypeVector %165 4 
					                                             %167 = OpTypePointer Private %166 
					                             Private bool_4* %168 = OpVariable Private 
					                                             %175 = OpTypeVector %165 2 
					                                             %176 = OpTypePointer Private %175 
					                             Private bool_2* %177 = OpVariable Private 
					                                             %186 = OpTypePointer Private %165 
					                                         f32 %189 = OpConstant 3,674022E-40 
					                                         u32 %213 = OpConstant 3 
					                        Input f32_3* vs_TEXCOORD1 = OpVariable Input 
					                        Input f32_4* vs_TEXCOORD3 = OpVariable Input 
					                                         f32 %233 = OpConstant 3,674022E-40 
					                                         i32 %238 = OpConstant 4 
					                                         f32 %248 = OpConstant 3,674022E-40 
					                                       f32_4 %249 = OpConstantComposite %248 %248 %248 %248 
					                                             %261 = OpTypePointer Private %12 
					                              Private f32_2* %262 = OpVariable Private 
					                               Private bool* %286 = OpVariable Private 
					                                       f32_2 %299 = OpConstantComposite %248 %248 
					                                         f32 %315 = OpConstant 3,674022E-40 
					                                       f32_2 %316 = OpConstantComposite %315 %315 
					                                         f32 %322 = OpConstant 3,674022E-40 
					        UniformConstant read_only Texture2D* %357 = OpVariable UniformConstant 
					                    UniformConstant sampler* %359 = OpVariable UniformConstant 
					                                Input f32_4* %370 = OpVariable Input 
					                                             %373 = OpTypePointer Output %7 
					                               Output f32_4* %374 = OpVariable Output 
					                                         i32 %376 = OpConstant 5 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad vs_TEXCOORD0 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                        f32_4 %15 = OpLoad vs_TEXCOORD0 
					                                        f32_2 %16 = OpVectorShuffle %15 %15 3 3 
					                                        f32_2 %17 = OpFDiv %14 %16 
					                                        f32_4 %18 = OpLoad %9 
					                                        f32_4 %19 = OpVectorShuffle %18 %17 4 5 2 3 
					                                                      OpStore %9 %19 
					                          read_only Texture2D %23 = OpLoad %22 
					                                      sampler %27 = OpLoad %26 
					                   read_only Texture2DSampled %29 = OpSampledImage %23 %27 
					                                        f32_4 %30 = OpLoad %9 
					                                        f32_2 %31 = OpVectorShuffle %30 %30 0 1 
					                                        f32_4 %32 = OpImageSampleImplicitLod %29 %31 
					                                        f32_2 %33 = OpVectorShuffle %32 %32 0 1 
					                                        f32_4 %34 = OpLoad %9 
					                                        f32_4 %35 = OpVectorShuffle %34 %33 4 5 2 3 
					                                                      OpStore %9 %35 
					                                        f32_4 %36 = OpLoad %9 
					                                        f32_2 %37 = OpVectorShuffle %36 %36 0 1 
					                                          f32 %41 = OpDot %37 %40 
					                                 Private f32* %45 = OpAccessChain %9 %43 
					                                                      OpStore %45 %41 
					                                 Uniform f32* %54 = OpAccessChain %50 %52 %43 
					                                          f32 %55 = OpLoad %54 
					                                 Private f32* %56 = OpAccessChain %9 %43 
					                                          f32 %57 = OpLoad %56 
					                                          f32 %58 = OpFMul %55 %57 
					                                 Uniform f32* %60 = OpAccessChain %50 %52 %59 
					                                          f32 %61 = OpLoad %60 
					                                          f32 %62 = OpFAdd %58 %61 
					                                 Private f32* %63 = OpAccessChain %9 %43 
					                                                      OpStore %63 %62 
					                                 Private f32* %64 = OpAccessChain %9 %43 
					                                          f32 %65 = OpLoad %64 
					                                          f32 %66 = OpFDiv %38 %65 
					                                 Private f32* %67 = OpAccessChain %9 %43 
					                                                      OpStore %67 %66 
					                                 Uniform f32* %73 = OpAccessChain %50 %71 %72 
					                                          f32 %74 = OpLoad %73 
					                                   Input f32* %78 = OpAccessChain vs_TEXCOORD2 %72 
					                                          f32 %79 = OpLoad %78 
					                                          f32 %80 = OpFDiv %74 %79 
					                                 Private f32* %81 = OpAccessChain %70 %43 
					                                                      OpStore %81 %80 
					                                        f32_3 %82 = OpLoad %70 
					                                        f32_3 %83 = OpVectorShuffle %82 %82 0 0 0 
					                                        f32_3 %84 = OpLoad vs_TEXCOORD2 
					                                        f32_3 %85 = OpFMul %83 %84 
					                                                      OpStore %70 %85 
					                                        f32_4 %86 = OpLoad %9 
					                                        f32_3 %87 = OpVectorShuffle %86 %86 0 0 0 
					                                        f32_3 %88 = OpLoad %70 
					                                        f32_3 %89 = OpFMul %87 %88 
					                                        f32_4 %90 = OpLoad %9 
					                                        f32_4 %91 = OpVectorShuffle %90 %89 4 5 6 3 
					                                                      OpStore %9 %91 
					                                        f32_4 %93 = OpLoad %9 
					                                        f32_3 %94 = OpVectorShuffle %93 %93 1 1 1 
					                               Uniform f32_4* %97 = OpAccessChain %50 %95 %52 
					                                        f32_4 %98 = OpLoad %97 
					                                        f32_3 %99 = OpVectorShuffle %98 %98 0 1 2 
					                                       f32_3 %100 = OpFMul %94 %99 
					                                       f32_4 %101 = OpLoad %92 
					                                       f32_4 %102 = OpVectorShuffle %101 %100 4 5 6 3 
					                                                      OpStore %92 %102 
					                              Uniform f32_4* %103 = OpAccessChain %50 %95 %71 
					                                       f32_4 %104 = OpLoad %103 
					                                       f32_3 %105 = OpVectorShuffle %104 %104 0 1 2 
					                                       f32_4 %106 = OpLoad %9 
					                                       f32_3 %107 = OpVectorShuffle %106 %106 0 0 0 
					                                       f32_3 %108 = OpFMul %105 %107 
					                                       f32_4 %109 = OpLoad %92 
					                                       f32_3 %110 = OpVectorShuffle %109 %109 0 1 2 
					                                       f32_3 %111 = OpFAdd %108 %110 
					                                       f32_4 %112 = OpLoad %9 
					                                       f32_4 %113 = OpVectorShuffle %112 %111 4 5 2 6 
					                                                      OpStore %9 %113 
					                              Uniform f32_4* %114 = OpAccessChain %50 %95 %95 
					                                       f32_4 %115 = OpLoad %114 
					                                       f32_3 %116 = OpVectorShuffle %115 %115 0 1 2 
					                                       f32_4 %117 = OpLoad %9 
					                                       f32_3 %118 = OpVectorShuffle %117 %117 2 2 2 
					                                       f32_3 %119 = OpFMul %116 %118 
					                                       f32_4 %120 = OpLoad %9 
					                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 3 
					                                       f32_3 %122 = OpFAdd %119 %121 
					                                       f32_4 %123 = OpLoad %9 
					                                       f32_4 %124 = OpVectorShuffle %123 %122 4 5 6 3 
					                                                      OpStore %9 %124 
					                                       f32_4 %125 = OpLoad %9 
					                                       f32_3 %126 = OpVectorShuffle %125 %125 0 1 2 
					                              Uniform f32_4* %128 = OpAccessChain %50 %95 %127 
					                                       f32_4 %129 = OpLoad %128 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 0 1 2 
					                                       f32_3 %131 = OpFAdd %126 %130 
					                                       f32_4 %132 = OpLoad %9 
					                                       f32_4 %133 = OpVectorShuffle %132 %131 4 5 6 3 
					                                                      OpStore %9 %133 
					                                       f32_4 %134 = OpLoad %9 
					                                       f32_4 %135 = OpVectorShuffle %134 %134 2 0 1 0 
					                                       f32_4 %136 = OpDPdx %135 
					                                                      OpStore %92 %136 
					                                       f32_4 %138 = OpLoad %9 
					                                       f32_4 %139 = OpVectorShuffle %138 %138 0 1 2 1 
					                                       f32_4 %140 = OpDPdy %139 
					                                                      OpStore %137 %140 
					                                       f32_4 %142 = OpLoad %92 
					                                       f32_4 %143 = OpLoad %137 
					                                       f32_4 %144 = OpFMul %142 %143 
					                                                      OpStore %141 %144 
					                                       f32_4 %145 = OpLoad %137 
					                                       f32_4 %146 = OpVectorShuffle %145 %145 2 0 3 0 
					                                       f32_4 %147 = OpLoad %92 
					                                       f32_4 %148 = OpVectorShuffle %147 %147 3 2 0 2 
					                                       f32_4 %149 = OpFMul %146 %148 
					                                       f32_4 %150 = OpLoad %141 
					                                       f32_4 %151 = OpFNegate %150 
					                                       f32_4 %152 = OpFAdd %149 %151 
					                                                      OpStore %92 %152 
					                                       f32_4 %154 = OpLoad %92 
					                                       f32_3 %155 = OpVectorShuffle %154 %154 0 2 3 
					                                       f32_4 %156 = OpLoad %92 
					                                       f32_3 %157 = OpVectorShuffle %156 %156 0 2 3 
					                                         f32 %158 = OpDot %155 %157 
					                                                      OpStore %153 %158 
					                                         f32 %159 = OpLoad %153 
					                                         f32 %160 = OpExtInst %1 32 %159 
					                                                      OpStore %153 %160 
					                                         f32 %161 = OpLoad %153 
					                                       f32_4 %162 = OpCompositeConstruct %161 %161 %161 %161 
					                                       f32_4 %163 = OpLoad %92 
					                                       f32_4 %164 = OpFMul %162 %163 
					                                                      OpStore %92 %164 
					                                       f32_4 %169 = OpLoad %92 
					                                       f32_4 %170 = OpVectorShuffle %169 %169 2 2 0 0 
					                                       f32_4 %171 = OpExtInst %1 4 %170 
					                                       f32_4 %172 = OpLoad %92 
					                                       f32_4 %173 = OpExtInst %1 4 %172 
					                                      bool_4 %174 = OpFOrdGreaterThanEqual %171 %173 
					                                                      OpStore %168 %174 
					                                       f32_4 %178 = OpLoad %92 
					                                       f32_4 %179 = OpVectorShuffle %178 %178 3 3 3 3 
					                                       f32_4 %180 = OpExtInst %1 4 %179 
					                                       f32_4 %181 = OpLoad %92 
					                                       f32_4 %182 = OpVectorShuffle %181 %181 2 0 2 2 
					                                       f32_4 %183 = OpExtInst %1 4 %182 
					                                      bool_4 %184 = OpFOrdGreaterThanEqual %180 %183 
					                                      bool_2 %185 = OpVectorShuffle %184 %184 0 1 
					                                                      OpStore %177 %185 
					                               Private bool* %187 = OpAccessChain %177 %43 
					                                        bool %188 = OpLoad %187 
					                                         f32 %190 = OpSelect %188 %38 %189 
					                                Private f32* %191 = OpAccessChain %92 %43 
					                                                      OpStore %191 %190 
					                               Private bool* %192 = OpAccessChain %177 %59 
					                                        bool %193 = OpLoad %192 
					                                         f32 %194 = OpSelect %193 %38 %189 
					                                Private f32* %195 = OpAccessChain %92 %59 
					                                                      OpStore %195 %194 
					                                Private f32* %196 = OpAccessChain %92 %59 
					                                         f32 %197 = OpLoad %196 
					                                Private f32* %198 = OpAccessChain %92 %43 
					                                         f32 %199 = OpLoad %198 
					                                         f32 %200 = OpFMul %197 %199 
					                                                      OpStore %153 %200 
					                               Private bool* %201 = OpAccessChain %168 %43 
					                                        bool %202 = OpLoad %201 
					                                         f32 %203 = OpSelect %202 %38 %189 
					                                Private f32* %204 = OpAccessChain %92 %43 
					                                                      OpStore %204 %203 
					                               Private bool* %205 = OpAccessChain %168 %59 
					                                        bool %206 = OpLoad %205 
					                                         f32 %207 = OpSelect %206 %38 %189 
					                                Private f32* %208 = OpAccessChain %92 %59 
					                                                      OpStore %208 %207 
					                               Private bool* %209 = OpAccessChain %168 %72 
					                                        bool %210 = OpLoad %209 
					                                         f32 %211 = OpSelect %210 %38 %189 
					                                Private f32* %212 = OpAccessChain %92 %72 
					                                                      OpStore %212 %211 
					                               Private bool* %214 = OpAccessChain %168 %213 
					                                        bool %215 = OpLoad %214 
					                                         f32 %216 = OpSelect %215 %38 %189 
					                                Private f32* %217 = OpAccessChain %92 %213 
					                                                      OpStore %217 %216 
					                                       f32_4 %218 = OpLoad %92 
					                                       f32_4 %219 = OpVectorShuffle %218 %218 1 1 3 3 
					                                       f32_4 %220 = OpLoad %92 
					                                       f32_4 %221 = OpVectorShuffle %220 %220 0 0 2 2 
					                                       f32_4 %222 = OpFMul %219 %221 
					                                                      OpStore %92 %222 
					                                       f32_4 %223 = OpLoad %9 
					                                       f32_4 %224 = OpVectorShuffle %223 %223 2 1 0 2 
					                                       f32_3 %226 = OpLoad vs_TEXCOORD1 
					                                       f32_4 %227 = OpVectorShuffle %226 %226 2 1 0 2 
					                                       f32_4 %228 = OpFNegate %227 
					                                       f32_4 %229 = OpFAdd %224 %228 
					                                                      OpStore %137 %229 
					                                  Input f32* %231 = OpAccessChain vs_TEXCOORD3 %43 
					                                         f32 %232 = OpLoad %231 
					                                         f32 %234 = OpFAdd %232 %233 
					                                Private f32* %235 = OpAccessChain %141 %43 
					                                                      OpStore %235 %234 
					                                Private f32* %236 = OpAccessChain %141 %43 
					                                         f32 %237 = OpLoad %236 
					                                Uniform f32* %239 = OpAccessChain %50 %238 
					                                         f32 %240 = OpLoad %239 
					                                         f32 %241 = OpFNegate %240 
					                                         f32 %242 = OpFMul %237 %241 
					                                Private f32* %243 = OpAccessChain %141 %43 
					                                                      OpStore %243 %242 
					                                       f32_4 %244 = OpLoad %137 
					                                       f32_4 %245 = OpLoad %141 
					                                       f32_4 %246 = OpVectorShuffle %245 %245 0 0 0 0 
					                                       f32_4 %247 = OpFMul %244 %246 
					                                       f32_4 %250 = OpFAdd %247 %249 
					                                                      OpStore %137 %250 
					                                       f32_4 %251 = OpLoad %92 
					                                       f32_4 %252 = OpLoad %137 
					                                       f32_4 %253 = OpFMul %251 %252 
					                                                      OpStore %92 %253 
					                                       f32_4 %254 = OpLoad %92 
					                                       f32_2 %255 = OpVectorShuffle %254 %254 2 3 
					                                       f32_4 %256 = OpLoad %92 
					                                       f32_2 %257 = OpVectorShuffle %256 %256 0 1 
					                                       f32_2 %258 = OpFAdd %255 %257 
					                                       f32_4 %259 = OpLoad %92 
					                                       f32_4 %260 = OpVectorShuffle %259 %258 4 5 2 3 
					                                                      OpStore %92 %260 
					                                       f32_4 %263 = OpLoad %9 
					                                       f32_2 %264 = OpVectorShuffle %263 %263 0 1 
					                                       f32_3 %265 = OpLoad vs_TEXCOORD1 
					                                       f32_2 %266 = OpVectorShuffle %265 %265 0 1 
					                                       f32_2 %267 = OpFNegate %266 
					                                       f32_2 %268 = OpFAdd %264 %267 
					                                                      OpStore %262 %268 
					                                       f32_4 %269 = OpLoad %9 
					                                       f32_3 %270 = OpVectorShuffle %269 %269 0 1 2 
					                                       f32_3 %271 = OpLoad vs_TEXCOORD1 
					                                       f32_3 %272 = OpFNegate %271 
					                                       f32_3 %273 = OpFAdd %270 %272 
					                                       f32_4 %274 = OpLoad %9 
					                                       f32_4 %275 = OpVectorShuffle %274 %273 4 5 6 3 
					                                                      OpStore %9 %275 
					                                       f32_4 %276 = OpLoad %9 
					                                       f32_3 %277 = OpVectorShuffle %276 %276 0 1 2 
					                                       f32_4 %278 = OpLoad %9 
					                                       f32_3 %279 = OpVectorShuffle %278 %278 0 1 2 
					                                         f32 %280 = OpDot %277 %279 
					                                Private f32* %281 = OpAccessChain %9 %43 
					                                                      OpStore %281 %280 
					                                Private f32* %282 = OpAccessChain %9 %43 
					                                         f32 %283 = OpLoad %282 
					                                         f32 %284 = OpExtInst %1 31 %283 
					                                Private f32* %285 = OpAccessChain %9 %43 
					                                                      OpStore %285 %284 
					                                Uniform f32* %287 = OpAccessChain %50 %127 
					                                         f32 %288 = OpLoad %287 
					                                Private f32* %289 = OpAccessChain %9 %43 
					                                         f32 %290 = OpLoad %289 
					                                        bool %291 = OpFOrdGreaterThanEqual %288 %290 
					                                                      OpStore %286 %291 
					                                        bool %292 = OpLoad %286 
					                                         f32 %293 = OpSelect %292 %38 %189 
					                                Private f32* %294 = OpAccessChain %9 %43 
					                                                      OpStore %294 %293 
					                                       f32_2 %295 = OpLoad %262 
					                                       f32_4 %296 = OpLoad %141 
					                                       f32_2 %297 = OpVectorShuffle %296 %296 0 0 
					                                       f32_2 %298 = OpFMul %295 %297 
					                                       f32_2 %300 = OpFAdd %298 %299 
					                                       f32_3 %301 = OpLoad %70 
					                                       f32_3 %302 = OpVectorShuffle %301 %300 3 4 2 
					                                                      OpStore %70 %302 
					                                         f32 %303 = OpLoad %153 
					                                       f32_2 %304 = OpCompositeConstruct %303 %303 
					                                       f32_3 %305 = OpLoad %70 
					                                       f32_2 %306 = OpVectorShuffle %305 %305 0 1 
					                                       f32_2 %307 = OpFMul %304 %306 
					                                       f32_4 %308 = OpLoad %92 
					                                       f32_2 %309 = OpVectorShuffle %308 %308 0 1 
					                                       f32_2 %310 = OpFAdd %307 %309 
					                                       f32_3 %311 = OpLoad %70 
					                                       f32_3 %312 = OpVectorShuffle %311 %310 3 4 2 
					                                                      OpStore %70 %312 
					                                       f32_3 %313 = OpLoad %70 
					                                       f32_2 %314 = OpVectorShuffle %313 %313 0 1 
					                                       f32_2 %317 = OpFAdd %314 %316 
					                                       f32_3 %318 = OpLoad %70 
					                                       f32_3 %319 = OpVectorShuffle %318 %317 3 4 2 
					                                                      OpStore %70 %319 
					                                  Input f32* %320 = OpAccessChain vs_TEXCOORD3 %59 
					                                         f32 %321 = OpLoad %320 
					                                         f32 %323 = OpFMul %321 %322 
					                                                      OpStore %153 %323 
					                                         f32 %324 = OpLoad %153 
					                                         f32 %325 = OpExtInst %1 13 %324 
					                                Private f32* %326 = OpAccessChain %92 %43 
					                                                      OpStore %326 %325 
					                                         f32 %327 = OpLoad %153 
					                                         f32 %328 = OpExtInst %1 14 %327 
					                                Private f32* %329 = OpAccessChain %137 %43 
					                                                      OpStore %329 %328 
					                                         f32 %330 = OpLoad %153 
					                                         f32 %331 = OpFNegate %330 
					                                         f32 %332 = OpExtInst %1 13 %331 
					                                Private f32* %333 = OpAccessChain %141 %43 
					                                                      OpStore %333 %332 
					                                Private f32* %334 = OpAccessChain %92 %43 
					                                         f32 %335 = OpLoad %334 
					                                Private f32* %336 = OpAccessChain %141 %72 
					                                                      OpStore %336 %335 
					                                Private f32* %337 = OpAccessChain %137 %43 
					                                         f32 %338 = OpLoad %337 
					                                Private f32* %339 = OpAccessChain %141 %59 
					                                                      OpStore %339 %338 
					                                       f32_3 %340 = OpLoad %70 
					                                       f32_2 %341 = OpVectorShuffle %340 %340 0 1 
					                                       f32_4 %342 = OpLoad %141 
					                                       f32_2 %343 = OpVectorShuffle %342 %342 1 2 
					                                         f32 %344 = OpDot %341 %343 
					                                Private f32* %345 = OpAccessChain %92 %43 
					                                                      OpStore %345 %344 
					                                       f32_3 %346 = OpLoad %70 
					                                       f32_2 %347 = OpVectorShuffle %346 %346 0 1 
					                                       f32_4 %348 = OpLoad %141 
					                                       f32_2 %349 = OpVectorShuffle %348 %348 0 1 
					                                         f32 %350 = OpDot %347 %349 
					                                Private f32* %351 = OpAccessChain %92 %59 
					                                                      OpStore %351 %350 
					                                       f32_4 %352 = OpLoad %92 
					                                       f32_2 %353 = OpVectorShuffle %352 %352 0 1 
					                                       f32_2 %354 = OpFAdd %353 %299 
					                                       f32_3 %355 = OpLoad %70 
					                                       f32_3 %356 = OpVectorShuffle %355 %354 3 4 2 
					                                                      OpStore %70 %356 
					                         read_only Texture2D %358 = OpLoad %357 
					                                     sampler %360 = OpLoad %359 
					                  read_only Texture2DSampled %361 = OpSampledImage %358 %360 
					                                       f32_3 %362 = OpLoad %70 
					                                       f32_2 %363 = OpVectorShuffle %362 %362 0 1 
					                                       f32_4 %364 = OpImageSampleImplicitLod %361 %363 
					                                                      OpStore %92 %364 
					                                       f32_4 %365 = OpLoad %9 
					                                       f32_4 %366 = OpVectorShuffle %365 %365 0 0 0 0 
					                                       f32_4 %367 = OpLoad %92 
					                                       f32_4 %368 = OpFMul %366 %367 
					                                                      OpStore %9 %368 
					                                       f32_4 %369 = OpLoad %9 
					                                       f32_4 %371 = OpLoad %370 
					                                       f32_4 %372 = OpFMul %369 %371 
					                                                      OpStore %9 %372 
					                                       f32_4 %375 = OpLoad %9 
					                              Uniform f32_4* %377 = OpAccessChain %50 %376 
					                                       f32_4 %378 = OpLoad %377 
					                                       f32_4 %379 = OpFMul %375 %378 
					                                                      OpStore %374 %379 
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
						float _range;
						float _scale;
						vec4 _TintColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2;
						vec4 _ZBufferParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerCameraRare {
						vec4 unused_2_0[18];
						mat4x4 unity_CameraToWorld;
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _Texture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat9;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
					    u_xlat0 = texture(_CameraDepthTexture, u_xlat0.xy);
					    u_xlat0.x = dot(u_xlat0.xy, vec2(1.0, 0.00392156886));
					    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD2.z;
					    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_CameraToWorld[1].xyz;
					    u_xlat0.xyw = unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.xyz = u_xlat0.xyz + unity_CameraToWorld[3].xyz;
					    u_xlat1 = dFdx(u_xlat0.zxyx);
					    u_xlat2 = dFdy(u_xlat0.xyzy);
					    u_xlat3 = u_xlat1 * u_xlat2;
					    u_xlat1 = u_xlat2.zxwx * u_xlat1.wzxz + (-u_xlat3);
					    u_xlat12 = dot(u_xlat1.xzw, u_xlat1.xzw);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1 = vec4(u_xlat12) * u_xlat1;
					    u_xlatb2 = greaterThanEqual(abs(u_xlat1.zzxx), abs(u_xlat1));
					    u_xlatb1.xy = greaterThanEqual(abs(u_xlat1.wwww), abs(u_xlat1.zxzz)).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat12 = u_xlat1.y * u_xlat1.x;
					    u_xlat1.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb2.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb2.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb2.w ? float(1.0) : 0.0;
					;
					    u_xlat1 = u_xlat1.yyww * u_xlat1.xxzz;
					    u_xlat2 = u_xlat0.zyxz + (-vs_TEXCOORD1.zyxz);
					    u_xlat3.x = vs_TEXCOORD3.x + -1.0;
					    u_xlat3.x = u_xlat3.x * (-_scale);
					    u_xlat2 = u_xlat2 * u_xlat3.xxxx + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1.xy = u_xlat1.zw + u_xlat1.xy;
					    u_xlat9.xy = u_xlat0.xy + (-vs_TEXCOORD1.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD1.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlatb0 = _range>=u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat4.xy = u_xlat9.xy * u_xlat3.xx + vec2(0.5, 0.5);
					    u_xlat4.xy = vec2(u_xlat12) * u_xlat4.xy + u_xlat1.xy;
					    u_xlat4.xy = u_xlat4.xy + vec2(-0.5, -0.5);
					    u_xlat12 = vs_TEXCOORD3.y * 0.0174532924;
					    u_xlat1.x = sin(u_xlat12);
					    u_xlat2.x = cos(u_xlat12);
					    u_xlat3.x = sin((-u_xlat12));
					    u_xlat3.z = u_xlat1.x;
					    u_xlat3.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yz);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat4.xy = u_xlat1.xy + vec2(0.5, 0.5);
					    u_xlat1 = texture(_Texture, u_xlat4.xy);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1;
					    u_xlat0 = u_xlat0 * vs_COLOR0;
					    SV_Target0 = u_xlat0 * _TintColor;
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