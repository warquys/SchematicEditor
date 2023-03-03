Shader "Hidden/PostProcessing/Lut2DBaker" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 5123
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
						vec4 unused_0_2[19];
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
					uniform 	vec4 _Lut2D_Params;
					uniform 	vec3 _ColorBalance;
					uniform 	vec3 _ColorFilter;
					uniform 	vec3 _HueSatCon;
					uniform 	float _Brightness;
					uniform 	vec3 _ChannelMixerRed;
					uniform 	vec3 _ChannelMixerGreen;
					uniform 	vec3 _ChannelMixerBlue;
					uniform 	vec3 _Lift;
					uniform 	vec3 _InvGamma;
					uniform 	vec3 _Gain;
					UNITY_LOCATION(0) uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD1.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness)) + vec3(-0.217637643, -0.217637643, -0.217637643);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.217637643, 0.217637643, 0.217637643);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7 = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat15.x + u_xlat4.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7 = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(0.00390625, 0.00390625, 0.00390625);
					    u_xlat0.w = 0.75;
					    u_xlat1 = texture(_Curves, u_xlat0.xw).wxyz;
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat2 = texture(_Curves, u_xlat0.yw);
					    u_xlat0 = texture(_Curves, u_xlat0.zw);
					    u_xlat1.z = u_xlat0.w;
					    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
					    u_xlat1.y = u_xlat2.w;
					    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat1.xyz + vec3(0.00390625, 0.00390625, 0.00390625);
					    u_xlat0.w = 0.75;
					    u_xlat1 = texture(_Curves, u_xlat0.xw);
					    SV_Target0.x = u_xlat1.x;
					    SV_Target0.x = clamp(SV_Target0.x, 0.0, 1.0);
					    u_xlat1 = texture(_Curves, u_xlat0.yw);
					    u_xlat0 = texture(_Curves, u_xlat0.zw);
					    SV_Target0.z = u_xlat0.z;
					    SV_Target0.z = clamp(SV_Target0.z, 0.0, 1.0);
					    SV_Target0.y = u_xlat1.y;
					    SV_Target0.y = clamp(SV_Target0.y, 0.0, 1.0);
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
					; Bound: 691
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %12 %653 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate vs_TEXCOORD1 Location 12 
					                                                      OpMemberDecorate %15 0 Offset 15 
					                                                      OpMemberDecorate %15 1 Offset 15 
					                                                      OpMemberDecorate %15 2 Offset 15 
					                                                      OpMemberDecorate %15 3 Offset 15 
					                                                      OpMemberDecorate %15 4 Offset 15 
					                                                      OpMemberDecorate %15 5 Offset 15 
					                                                      OpMemberDecorate %15 6 Offset 15 
					                                                      OpMemberDecorate %15 7 Offset 15 
					                                                      OpMemberDecorate %15 8 Offset 15 
					                                                      OpMemberDecorate %15 9 Offset 15 
					                                                      OpMemberDecorate %15 10 Offset 15 
					                                                      OpDecorate %15 Block 
					                                                      OpDecorate %17 DescriptorSet 17 
					                                                      OpDecorate %17 Binding 17 
					                                                      OpDecorate %390 DescriptorSet 390 
					                                                      OpDecorate %390 Binding 390 
					                                                      OpDecorate %394 DescriptorSet 394 
					                                                      OpDecorate %394 Binding 394 
					                                                      OpDecorate %653 Location 653 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 2 
					                                              %11 = OpTypePointer Input %10 
					                        Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                              %14 = OpTypeVector %6 3 
					                                              %15 = OpTypeStruct %7 %14 %14 %14 %6 %14 %14 %14 %14 %14 %14 
					                                              %16 = OpTypePointer Uniform %15 
					Uniform struct {f32_4; f32_3; f32_3; f32_3; f32; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3;}* %17 = OpVariable Uniform 
					                                              %18 = OpTypeInt 32 1 
					                                          i32 %19 = OpConstant 0 
					                                              %20 = OpTypePointer Uniform %7 
					                               Private f32_4* %28 = OpVariable Private 
					                                              %29 = OpTypeInt 32 0 
					                                          u32 %30 = OpConstant 1 
					                                              %31 = OpTypePointer Private %6 
					                                          u32 %34 = OpConstant 0 
					                                              %35 = OpTypePointer Uniform %6 
					                                          u32 %56 = OpConstant 3 
					                                          i32 %68 = OpConstant 4 
					                                          f32 %81 = OpConstant 3,674022E-40 
					                                        f32_3 %82 = OpConstantComposite %81 %81 %81 
					                                          i32 %88 = OpConstant 3 
					                                              %89 = OpTypePointer Uniform %14 
					                                          f32 %94 = OpConstant 3,674022E-40 
					                                        f32_3 %95 = OpConstantComposite %94 %94 %94 
					                                          f32 %99 = OpConstant 3,674022E-40 
					                                         f32 %100 = OpConstant 3,674022E-40 
					                                         f32 %101 = OpConstant 3,674022E-40 
					                                       f32_3 %102 = OpConstantComposite %99 %100 %101 
					                                         f32 %107 = OpConstant 3,674022E-40 
					                                         f32 %108 = OpConstant 3,674022E-40 
					                                         f32 %109 = OpConstant 3,674022E-40 
					                                       f32_3 %110 = OpConstantComposite %107 %108 %109 
					                                         f32 %115 = OpConstant 3,674022E-40 
					                                         f32 %116 = OpConstant 3,674022E-40 
					                                         f32 %117 = OpConstant 3,674022E-40 
					                                       f32_3 %118 = OpConstantComposite %115 %116 %117 
					                                         u32 %122 = OpConstant 2 
					                                         i32 %126 = OpConstant 1 
					                                         f32 %132 = OpConstant 3,674022E-40 
					                                         f32 %133 = OpConstant 3,674022E-40 
					                                         f32 %134 = OpConstant 3,674022E-40 
					                                       f32_3 %135 = OpConstantComposite %132 %133 %134 
					                                         f32 %140 = OpConstant 3,674022E-40 
					                                         f32 %141 = OpConstant 3,674022E-40 
					                                         f32 %142 = OpConstant 3,674022E-40 
					                                       f32_3 %143 = OpConstantComposite %140 %141 %142 
					                                         f32 %148 = OpConstant 3,674022E-40 
					                                         f32 %149 = OpConstant 3,674022E-40 
					                                         f32 %150 = OpConstant 3,674022E-40 
					                                       f32_3 %151 = OpConstantComposite %148 %149 %150 
					                                         i32 %158 = OpConstant 2 
					                                         i32 %166 = OpConstant 5 
					                                         i32 %173 = OpConstant 6 
					                                         i32 %180 = OpConstant 7 
					                                         i32 %187 = OpConstant 10 
					                                         i32 %191 = OpConstant 8 
					                                         f32 %205 = OpConstant 3,674022E-40 
					                                       f32_3 %206 = OpConstantComposite %205 %205 %205 
					                                         f32 %208 = OpConstant 3,674022E-40 
					                                       f32_3 %209 = OpConstantComposite %208 %208 %208 
					                                         f32 %215 = OpConstant 3,674022E-40 
					                                         f32 %216 = OpConstant 3,674022E-40 
					                                         f32 %224 = OpConstant 3,674022E-40 
					                                       f32_3 %225 = OpConstantComposite %224 %224 %224 
					                                         f32 %227 = OpConstant 3,674022E-40 
					                                       f32_3 %228 = OpConstantComposite %227 %227 %227 
					                                         i32 %234 = OpConstant 9 
					                                       f32_3 %254 = OpConstantComposite %215 %215 %215 
					                                             %258 = OpTypeBool 
					                                             %259 = OpTypePointer Private %258 
					                               Private bool* %260 = OpVariable Private 
					                                Private f32* %266 = OpVariable Private 
					                              Private f32_4* %273 = OpVariable Private 
					                                         f32 %283 = OpConstant 3,674022E-40 
					                                             %308 = OpTypePointer Private %14 
					                              Private f32_3* %309 = OpVariable Private 
					                                         f32 %312 = OpConstant 3,674022E-40 
					                                         f32 %313 = OpConstant 3,674022E-40 
					                                         f32 %314 = OpConstant 3,674022E-40 
					                                       f32_3 %315 = OpConstantComposite %312 %313 %314 
					                              Private f32_3* %345 = OpVariable Private 
					                                         f32 %348 = OpConstant 3,674022E-40 
					                                         f32 %350 = OpConstant 3,674022E-40 
					                                             %353 = OpTypePointer Private %10 
					                              Private f32_2* %354 = OpVariable Private 
					                              Private f32_2* %378 = OpVariable Private 
					                                         f32 %385 = OpConstant 3,674022E-40 
					                                             %388 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                             %389 = OpTypePointer UniformConstant %388 
					        UniformConstant read_only Texture2D* %390 = OpVariable UniformConstant 
					                                             %392 = OpTypeSampler 
					                                             %393 = OpTypePointer UniformConstant %392 
					                    UniformConstant sampler* %394 = OpVariable UniformConstant 
					                                             %396 = OpTypeSampledImage %388 
					                                         f32 %423 = OpConstant 3,674022E-40 
					                                         f32 %424 = OpConstant 3,674022E-40 
					                                       f32_3 %425 = OpConstantComposite %423 %208 %424 
					                               Private bool* %427 = OpVariable Private 
					                                             %432 = OpTypePointer Function %6 
					                                         f32 %459 = OpConstant 3,674022E-40 
					                                       f32_3 %460 = OpConstantComposite %216 %283 %459 
					                                       f32_3 %465 = OpConstantComposite %348 %348 %348 
					                                         f32 %467 = OpConstant 3,674022E-40 
					                                       f32_3 %468 = OpConstantComposite %467 %467 %467 
					                              Private f32_2* %483 = OpVariable Private 
					                                       f32_3 %494 = OpConstantComposite %216 %216 %216 
					                                         f32 %589 = OpConstant 3,674022E-40 
					                                       f32_3 %590 = OpConstantComposite %589 %589 %589 
					                                         f32 %594 = OpConstant 3,674022E-40 
					                                             %652 = OpTypePointer Output %7 
					                               Output f32_4* %653 = OpVariable Output 
					                                             %656 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                               Function f32* %433 = OpVariable Function 
					                               Function f32* %447 = OpVariable Function 
					                                        f32_2 %13 = OpLoad vs_TEXCOORD1 
					                               Uniform f32_4* %21 = OpAccessChain %17 %19 
					                                        f32_4 %22 = OpLoad %21 
					                                        f32_2 %23 = OpVectorShuffle %22 %22 1 2 
					                                        f32_2 %24 = OpFNegate %23 
					                                        f32_2 %25 = OpFAdd %13 %24 
					                                        f32_4 %26 = OpLoad %9 
					                                        f32_4 %27 = OpVectorShuffle %26 %25 0 4 5 3 
					                                                      OpStore %9 %27 
					                                 Private f32* %32 = OpAccessChain %9 %30 
					                                          f32 %33 = OpLoad %32 
					                                 Uniform f32* %36 = OpAccessChain %17 %19 %34 
					                                          f32 %37 = OpLoad %36 
					                                          f32 %38 = OpFMul %33 %37 
					                                 Private f32* %39 = OpAccessChain %28 %34 
					                                                      OpStore %39 %38 
					                                 Private f32* %40 = OpAccessChain %28 %34 
					                                          f32 %41 = OpLoad %40 
					                                          f32 %42 = OpExtInst %1 10 %41 
					                                 Private f32* %43 = OpAccessChain %9 %34 
					                                                      OpStore %43 %42 
					                                 Private f32* %44 = OpAccessChain %9 %34 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %46 = OpAccessChain %17 %19 %34 
					                                          f32 %47 = OpLoad %46 
					                                          f32 %48 = OpFDiv %45 %47 
					                                 Private f32* %49 = OpAccessChain %28 %34 
					                                                      OpStore %49 %48 
					                                 Private f32* %50 = OpAccessChain %9 %30 
					                                          f32 %51 = OpLoad %50 
					                                 Private f32* %52 = OpAccessChain %28 %34 
					                                          f32 %53 = OpLoad %52 
					                                          f32 %54 = OpFNegate %53 
					                                          f32 %55 = OpFAdd %51 %54 
					                                 Private f32* %57 = OpAccessChain %9 %56 
					                                                      OpStore %57 %55 
					                                        f32_4 %58 = OpLoad %9 
					                                        f32_3 %59 = OpVectorShuffle %58 %58 0 2 3 
					                               Uniform f32_4* %60 = OpAccessChain %17 %19 
					                                        f32_4 %61 = OpLoad %60 
					                                        f32_3 %62 = OpVectorShuffle %61 %61 3 3 3 
					                                        f32_3 %63 = OpFMul %59 %62 
					                                        f32_4 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %63 4 5 6 3 
					                                                      OpStore %9 %65 
					                                        f32_4 %66 = OpLoad %9 
					                                        f32_3 %67 = OpVectorShuffle %66 %66 0 1 2 
					                                 Uniform f32* %69 = OpAccessChain %17 %68 
					                                          f32 %70 = OpLoad %69 
					                                 Uniform f32* %71 = OpAccessChain %17 %68 
					                                          f32 %72 = OpLoad %71 
					                                 Uniform f32* %73 = OpAccessChain %17 %68 
					                                          f32 %74 = OpLoad %73 
					                                        f32_3 %75 = OpCompositeConstruct %70 %72 %74 
					                                          f32 %76 = OpCompositeExtract %75 0 
					                                          f32 %77 = OpCompositeExtract %75 1 
					                                          f32 %78 = OpCompositeExtract %75 2 
					                                        f32_3 %79 = OpCompositeConstruct %76 %77 %78 
					                                        f32_3 %80 = OpFMul %67 %79 
					                                        f32_3 %83 = OpFAdd %80 %82 
					                                        f32_4 %84 = OpLoad %9 
					                                        f32_4 %85 = OpVectorShuffle %84 %83 4 5 6 3 
					                                                      OpStore %9 %85 
					                                        f32_4 %86 = OpLoad %9 
					                                        f32_3 %87 = OpVectorShuffle %86 %86 0 1 2 
					                               Uniform f32_3* %90 = OpAccessChain %17 %88 
					                                        f32_3 %91 = OpLoad %90 
					                                        f32_3 %92 = OpVectorShuffle %91 %91 2 2 2 
					                                        f32_3 %93 = OpFMul %87 %92 
					                                        f32_3 %96 = OpFAdd %93 %95 
					                                        f32_4 %97 = OpLoad %9 
					                                        f32_4 %98 = OpVectorShuffle %97 %96 4 5 6 3 
					                                                      OpStore %9 %98 
					                                       f32_4 %103 = OpLoad %9 
					                                       f32_3 %104 = OpVectorShuffle %103 %103 0 1 2 
					                                         f32 %105 = OpDot %102 %104 
					                                Private f32* %106 = OpAccessChain %28 %34 
					                                                      OpStore %106 %105 
					                                       f32_4 %111 = OpLoad %9 
					                                       f32_3 %112 = OpVectorShuffle %111 %111 0 1 2 
					                                         f32 %113 = OpDot %110 %112 
					                                Private f32* %114 = OpAccessChain %28 %30 
					                                                      OpStore %114 %113 
					                                       f32_4 %119 = OpLoad %9 
					                                       f32_3 %120 = OpVectorShuffle %119 %119 0 1 2 
					                                         f32 %121 = OpDot %118 %120 
					                                Private f32* %123 = OpAccessChain %28 %122 
					                                                      OpStore %123 %121 
					                                       f32_4 %124 = OpLoad %28 
					                                       f32_3 %125 = OpVectorShuffle %124 %124 0 1 2 
					                              Uniform f32_3* %127 = OpAccessChain %17 %126 
					                                       f32_3 %128 = OpLoad %127 
					                                       f32_3 %129 = OpFMul %125 %128 
					                                       f32_4 %130 = OpLoad %9 
					                                       f32_4 %131 = OpVectorShuffle %130 %129 4 5 6 3 
					                                                      OpStore %9 %131 
					                                       f32_4 %136 = OpLoad %9 
					                                       f32_3 %137 = OpVectorShuffle %136 %136 0 1 2 
					                                         f32 %138 = OpDot %135 %137 
					                                Private f32* %139 = OpAccessChain %28 %34 
					                                                      OpStore %139 %138 
					                                       f32_4 %144 = OpLoad %9 
					                                       f32_3 %145 = OpVectorShuffle %144 %144 0 1 2 
					                                         f32 %146 = OpDot %143 %145 
					                                Private f32* %147 = OpAccessChain %28 %30 
					                                                      OpStore %147 %146 
					                                       f32_4 %152 = OpLoad %9 
					                                       f32_3 %153 = OpVectorShuffle %152 %152 0 1 2 
					                                         f32 %154 = OpDot %151 %153 
					                                Private f32* %155 = OpAccessChain %28 %122 
					                                                      OpStore %155 %154 
					                                       f32_4 %156 = OpLoad %28 
					                                       f32_3 %157 = OpVectorShuffle %156 %156 0 1 2 
					                              Uniform f32_3* %159 = OpAccessChain %17 %158 
					                                       f32_3 %160 = OpLoad %159 
					                                       f32_3 %161 = OpFMul %157 %160 
					                                       f32_4 %162 = OpLoad %9 
					                                       f32_4 %163 = OpVectorShuffle %162 %161 4 5 6 3 
					                                                      OpStore %9 %163 
					                                       f32_4 %164 = OpLoad %9 
					                                       f32_3 %165 = OpVectorShuffle %164 %164 0 1 2 
					                              Uniform f32_3* %167 = OpAccessChain %17 %166 
					                                       f32_3 %168 = OpLoad %167 
					                                         f32 %169 = OpDot %165 %168 
					                                Private f32* %170 = OpAccessChain %28 %34 
					                                                      OpStore %170 %169 
					                                       f32_4 %171 = OpLoad %9 
					                                       f32_3 %172 = OpVectorShuffle %171 %171 0 1 2 
					                              Uniform f32_3* %174 = OpAccessChain %17 %173 
					                                       f32_3 %175 = OpLoad %174 
					                                         f32 %176 = OpDot %172 %175 
					                                Private f32* %177 = OpAccessChain %28 %30 
					                                                      OpStore %177 %176 
					                                       f32_4 %178 = OpLoad %9 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                              Uniform f32_3* %181 = OpAccessChain %17 %180 
					                                       f32_3 %182 = OpLoad %181 
					                                         f32 %183 = OpDot %179 %182 
					                                Private f32* %184 = OpAccessChain %28 %122 
					                                                      OpStore %184 %183 
					                                       f32_4 %185 = OpLoad %28 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                              Uniform f32_3* %188 = OpAccessChain %17 %187 
					                                       f32_3 %189 = OpLoad %188 
					                                       f32_3 %190 = OpFMul %186 %189 
					                              Uniform f32_3* %192 = OpAccessChain %17 %191 
					                                       f32_3 %193 = OpLoad %192 
					                                       f32_3 %194 = OpFAdd %190 %193 
					                                       f32_4 %195 = OpLoad %9 
					                                       f32_4 %196 = OpVectorShuffle %195 %194 4 5 6 3 
					                                                      OpStore %9 %196 
					                                       f32_4 %197 = OpLoad %9 
					                                       f32_3 %198 = OpVectorShuffle %197 %197 0 1 2 
					                                       f32_3 %199 = OpExtInst %1 4 %198 
					                                       f32_3 %200 = OpExtInst %1 30 %199 
					                                       f32_4 %201 = OpLoad %28 
					                                       f32_4 %202 = OpVectorShuffle %201 %200 4 5 6 3 
					                                                      OpStore %28 %202 
					                                       f32_4 %203 = OpLoad %9 
					                                       f32_3 %204 = OpVectorShuffle %203 %203 0 1 2 
					                                       f32_3 %207 = OpFMul %204 %206 
					                                       f32_3 %210 = OpFAdd %207 %209 
					                                       f32_4 %211 = OpLoad %9 
					                                       f32_4 %212 = OpVectorShuffle %211 %210 4 5 6 3 
					                                                      OpStore %9 %212 
					                                       f32_4 %213 = OpLoad %9 
					                                       f32_3 %214 = OpVectorShuffle %213 %213 0 1 2 
					                                       f32_3 %217 = OpCompositeConstruct %215 %215 %215 
					                                       f32_3 %218 = OpCompositeConstruct %216 %216 %216 
					                                       f32_3 %219 = OpExtInst %1 43 %214 %217 %218 
					                                       f32_4 %220 = OpLoad %9 
					                                       f32_4 %221 = OpVectorShuffle %220 %219 4 5 6 3 
					                                                      OpStore %9 %221 
					                                       f32_4 %222 = OpLoad %9 
					                                       f32_3 %223 = OpVectorShuffle %222 %222 0 1 2 
					                                       f32_3 %226 = OpFMul %223 %225 
					                                       f32_3 %229 = OpFAdd %226 %228 
					                                       f32_4 %230 = OpLoad %9 
					                                       f32_4 %231 = OpVectorShuffle %230 %229 4 5 6 3 
					                                                      OpStore %9 %231 
					                                       f32_4 %232 = OpLoad %28 
					                                       f32_3 %233 = OpVectorShuffle %232 %232 0 1 2 
					                              Uniform f32_3* %235 = OpAccessChain %17 %234 
					                                       f32_3 %236 = OpLoad %235 
					                                       f32_3 %237 = OpFMul %233 %236 
					                                       f32_4 %238 = OpLoad %28 
					                                       f32_4 %239 = OpVectorShuffle %238 %237 4 5 6 3 
					                                                      OpStore %28 %239 
					                                       f32_4 %240 = OpLoad %28 
					                                       f32_3 %241 = OpVectorShuffle %240 %240 0 1 2 
					                                       f32_3 %242 = OpExtInst %1 29 %241 
					                                       f32_4 %243 = OpLoad %28 
					                                       f32_4 %244 = OpVectorShuffle %243 %242 4 5 6 3 
					                                                      OpStore %28 %244 
					                                       f32_4 %245 = OpLoad %9 
					                                       f32_3 %246 = OpVectorShuffle %245 %245 0 1 2 
					                                       f32_4 %247 = OpLoad %28 
					                                       f32_3 %248 = OpVectorShuffle %247 %247 0 1 2 
					                                       f32_3 %249 = OpFMul %246 %248 
					                                       f32_4 %250 = OpLoad %9 
					                                       f32_4 %251 = OpVectorShuffle %250 %249 4 5 6 3 
					                                                      OpStore %9 %251 
					                                       f32_4 %252 = OpLoad %9 
					                                       f32_3 %253 = OpVectorShuffle %252 %252 0 1 2 
					                                       f32_3 %255 = OpExtInst %1 40 %253 %254 
					                                       f32_4 %256 = OpLoad %9 
					                                       f32_4 %257 = OpVectorShuffle %256 %255 4 5 6 3 
					                                                      OpStore %9 %257 
					                                Private f32* %261 = OpAccessChain %9 %30 
					                                         f32 %262 = OpLoad %261 
					                                Private f32* %263 = OpAccessChain %9 %122 
					                                         f32 %264 = OpLoad %263 
					                                        bool %265 = OpFOrdGreaterThanEqual %262 %264 
					                                                      OpStore %260 %265 
					                                        bool %267 = OpLoad %260 
					                                         f32 %268 = OpSelect %267 %216 %215 
					                                                      OpStore %266 %268 
					                                       f32_4 %269 = OpLoad %9 
					                                       f32_2 %270 = OpVectorShuffle %269 %269 2 1 
					                                       f32_4 %271 = OpLoad %28 
					                                       f32_4 %272 = OpVectorShuffle %271 %270 4 5 2 3 
					                                                      OpStore %28 %272 
					                                       f32_4 %274 = OpLoad %9 
					                                       f32_2 %275 = OpVectorShuffle %274 %274 1 2 
					                                       f32_4 %276 = OpLoad %28 
					                                       f32_2 %277 = OpVectorShuffle %276 %276 0 1 
					                                       f32_2 %278 = OpFNegate %277 
					                                       f32_2 %279 = OpFAdd %275 %278 
					                                       f32_4 %280 = OpLoad %273 
					                                       f32_4 %281 = OpVectorShuffle %280 %279 4 5 2 3 
					                                                      OpStore %273 %281 
					                                Private f32* %282 = OpAccessChain %28 %122 
					                                                      OpStore %282 %227 
					                                Private f32* %284 = OpAccessChain %28 %56 
					                                                      OpStore %284 %283 
					                                Private f32* %285 = OpAccessChain %273 %122 
					                                                      OpStore %285 %216 
					                                Private f32* %286 = OpAccessChain %273 %56 
					                                                      OpStore %286 %227 
					                                         f32 %287 = OpLoad %266 
					                                       f32_4 %288 = OpCompositeConstruct %287 %287 %287 %287 
					                                       f32_4 %289 = OpLoad %273 
					                                       f32_4 %290 = OpVectorShuffle %289 %289 0 1 3 2 
					                                       f32_4 %291 = OpFMul %288 %290 
					                                       f32_4 %292 = OpLoad %28 
					                                       f32_4 %293 = OpVectorShuffle %292 %292 0 1 3 2 
					                                       f32_4 %294 = OpFAdd %291 %293 
					                                                      OpStore %28 %294 
					                                Private f32* %295 = OpAccessChain %9 %34 
					                                         f32 %296 = OpLoad %295 
					                                Private f32* %297 = OpAccessChain %28 %34 
					                                         f32 %298 = OpLoad %297 
					                                        bool %299 = OpFOrdGreaterThanEqual %296 %298 
					                                                      OpStore %260 %299 
					                                        bool %300 = OpLoad %260 
					                                         f32 %301 = OpSelect %300 %216 %215 
					                                                      OpStore %266 %301 
					                                Private f32* %302 = OpAccessChain %28 %56 
					                                         f32 %303 = OpLoad %302 
					                                Private f32* %304 = OpAccessChain %273 %122 
					                                                      OpStore %304 %303 
					                                Private f32* %305 = OpAccessChain %9 %34 
					                                         f32 %306 = OpLoad %305 
					                                Private f32* %307 = OpAccessChain %28 %56 
					                                                      OpStore %307 %306 
					                                       f32_4 %310 = OpLoad %9 
					                                       f32_3 %311 = OpVectorShuffle %310 %310 0 1 2 
					                                         f32 %316 = OpDot %311 %315 
					                                Private f32* %317 = OpAccessChain %309 %34 
					                                                      OpStore %317 %316 
					                                       f32_4 %318 = OpLoad %28 
					                                       f32_3 %319 = OpVectorShuffle %318 %318 3 1 0 
					                                       f32_4 %320 = OpLoad %273 
					                                       f32_4 %321 = OpVectorShuffle %320 %319 4 5 2 6 
					                                                      OpStore %273 %321 
					                                       f32_4 %322 = OpLoad %28 
					                                       f32_4 %323 = OpFNegate %322 
					                                       f32_4 %324 = OpLoad %273 
					                                       f32_4 %325 = OpFAdd %323 %324 
					                                                      OpStore %273 %325 
					                                         f32 %326 = OpLoad %266 
					                                       f32_4 %327 = OpCompositeConstruct %326 %326 %326 %326 
					                                       f32_4 %328 = OpLoad %273 
					                                       f32_4 %329 = OpFMul %327 %328 
					                                       f32_4 %330 = OpLoad %28 
					                                       f32_4 %331 = OpFAdd %329 %330 
					                                                      OpStore %9 %331 
					                                Private f32* %332 = OpAccessChain %9 %30 
					                                         f32 %333 = OpLoad %332 
					                                Private f32* %334 = OpAccessChain %9 %56 
					                                         f32 %335 = OpLoad %334 
					                                         f32 %336 = OpExtInst %1 37 %333 %335 
					                                Private f32* %337 = OpAccessChain %28 %34 
					                                                      OpStore %337 %336 
					                                Private f32* %338 = OpAccessChain %9 %34 
					                                         f32 %339 = OpLoad %338 
					                                Private f32* %340 = OpAccessChain %28 %34 
					                                         f32 %341 = OpLoad %340 
					                                         f32 %342 = OpFNegate %341 
					                                         f32 %343 = OpFAdd %339 %342 
					                                Private f32* %344 = OpAccessChain %28 %34 
					                                                      OpStore %344 %343 
					                                Private f32* %346 = OpAccessChain %28 %34 
					                                         f32 %347 = OpLoad %346 
					                                         f32 %349 = OpFMul %347 %348 
					                                         f32 %351 = OpFAdd %349 %350 
					                                Private f32* %352 = OpAccessChain %345 %34 
					                                                      OpStore %352 %351 
					                                Private f32* %355 = OpAccessChain %9 %30 
					                                         f32 %356 = OpLoad %355 
					                                         f32 %357 = OpFNegate %356 
					                                Private f32* %358 = OpAccessChain %9 %56 
					                                         f32 %359 = OpLoad %358 
					                                         f32 %360 = OpFAdd %357 %359 
					                                Private f32* %361 = OpAccessChain %354 %34 
					                                                      OpStore %361 %360 
					                                Private f32* %362 = OpAccessChain %354 %34 
					                                         f32 %363 = OpLoad %362 
					                                Private f32* %364 = OpAccessChain %345 %34 
					                                         f32 %365 = OpLoad %364 
					                                         f32 %366 = OpFDiv %363 %365 
					                                Private f32* %367 = OpAccessChain %354 %34 
					                                                      OpStore %367 %366 
					                                Private f32* %368 = OpAccessChain %354 %34 
					                                         f32 %369 = OpLoad %368 
					                                Private f32* %370 = OpAccessChain %9 %122 
					                                         f32 %371 = OpLoad %370 
					                                         f32 %372 = OpFAdd %369 %371 
					                                Private f32* %373 = OpAccessChain %354 %34 
					                                                      OpStore %373 %372 
					                                Private f32* %374 = OpAccessChain %354 %34 
					                                         f32 %375 = OpLoad %374 
					                                         f32 %376 = OpExtInst %1 4 %375 
					                                Private f32* %377 = OpAccessChain %273 %34 
					                                                      OpStore %377 %376 
					                                Private f32* %379 = OpAccessChain %273 %34 
					                                         f32 %380 = OpLoad %379 
					                                Uniform f32* %381 = OpAccessChain %17 %88 %34 
					                                         f32 %382 = OpLoad %381 
					                                         f32 %383 = OpFAdd %380 %382 
					                                Private f32* %384 = OpAccessChain %378 %34 
					                                                      OpStore %384 %383 
					                                Private f32* %386 = OpAccessChain %309 %30 
					                                                      OpStore %386 %385 
					                                Private f32* %387 = OpAccessChain %378 %30 
					                                                      OpStore %387 %385 
					                         read_only Texture2D %391 = OpLoad %390 
					                                     sampler %395 = OpLoad %394 
					                  read_only Texture2DSampled %397 = OpSampledImage %391 %395 
					                                       f32_2 %398 = OpLoad %378 
					                                       f32_4 %399 = OpImageSampleExplicitLod %397 %398 Lod %7 
					                                         f32 %400 = OpCompositeExtract %399 0 
					                                Private f32* %401 = OpAccessChain %354 %34 
					                                                      OpStore %401 %400 
					                         read_only Texture2D %402 = OpLoad %390 
					                                     sampler %403 = OpLoad %394 
					                  read_only Texture2DSampled %404 = OpSampledImage %402 %403 
					                                       f32_3 %405 = OpLoad %309 
					                                       f32_2 %406 = OpVectorShuffle %405 %405 0 1 
					                                       f32_4 %407 = OpImageSampleExplicitLod %404 %406 Lod %7 
					                                         f32 %408 = OpCompositeExtract %407 3 
					                                Private f32* %409 = OpAccessChain %354 %30 
					                                                      OpStore %409 %408 
					                                       f32_2 %410 = OpLoad %354 
					                                                      OpStore %354 %410 
					                                       f32_2 %411 = OpLoad %354 
					                                       f32_2 %412 = OpCompositeConstruct %215 %215 
					                                       f32_2 %413 = OpCompositeConstruct %216 %216 
					                                       f32_2 %414 = OpExtInst %1 43 %411 %412 %413 
					                                                      OpStore %354 %414 
					                                Private f32* %415 = OpAccessChain %378 %34 
					                                         f32 %416 = OpLoad %415 
					                                Private f32* %417 = OpAccessChain %354 %34 
					                                         f32 %418 = OpLoad %417 
					                                         f32 %419 = OpFAdd %416 %418 
					                                Private f32* %420 = OpAccessChain %354 %34 
					                                                      OpStore %420 %419 
					                                       f32_2 %421 = OpLoad %354 
					                                       f32_3 %422 = OpVectorShuffle %421 %421 0 0 0 
					                                       f32_3 %426 = OpFAdd %422 %425 
					                                                      OpStore %345 %426 
					                                Private f32* %428 = OpAccessChain %345 %34 
					                                         f32 %429 = OpLoad %428 
					                                        bool %430 = OpFOrdLessThan %216 %429 
					                                                      OpStore %427 %430 
					                                        bool %431 = OpLoad %427 
					                                                      OpSelectionMerge %435 None 
					                                                      OpBranchConditional %431 %434 %438 
					                                             %434 = OpLabel 
					                                Private f32* %436 = OpAccessChain %345 %122 
					                                         f32 %437 = OpLoad %436 
					                                                      OpStore %433 %437 
					                                                      OpBranch %435 
					                                             %438 = OpLabel 
					                                Private f32* %439 = OpAccessChain %345 %34 
					                                         f32 %440 = OpLoad %439 
					                                                      OpStore %433 %440 
					                                                      OpBranch %435 
					                                             %435 = OpLabel 
					                                         f32 %441 = OpLoad %433 
					                                Private f32* %442 = OpAccessChain %354 %34 
					                                                      OpStore %442 %441 
					                                Private f32* %443 = OpAccessChain %345 %34 
					                                         f32 %444 = OpLoad %443 
					                                        bool %445 = OpFOrdLessThan %444 %215 
					                                                      OpStore %260 %445 
					                                        bool %446 = OpLoad %260 
					                                                      OpSelectionMerge %449 None 
					                                                      OpBranchConditional %446 %448 %452 
					                                             %448 = OpLabel 
					                                Private f32* %450 = OpAccessChain %345 %30 
					                                         f32 %451 = OpLoad %450 
					                                                      OpStore %447 %451 
					                                                      OpBranch %449 
					                                             %452 = OpLabel 
					                                Private f32* %453 = OpAccessChain %354 %34 
					                                         f32 %454 = OpLoad %453 
					                                                      OpStore %447 %454 
					                                                      OpBranch %449 
					                                             %449 = OpLabel 
					                                         f32 %455 = OpLoad %447 
					                                Private f32* %456 = OpAccessChain %354 %34 
					                                                      OpStore %456 %455 
					                                       f32_2 %457 = OpLoad %354 
					                                       f32_3 %458 = OpVectorShuffle %457 %457 0 0 0 
					                                       f32_3 %461 = OpFAdd %458 %460 
					                                                      OpStore %345 %461 
					                                       f32_3 %462 = OpLoad %345 
					                                       f32_3 %463 = OpExtInst %1 10 %462 
					                                                      OpStore %345 %463 
					                                       f32_3 %464 = OpLoad %345 
					                                       f32_3 %466 = OpFMul %464 %465 
					                                       f32_3 %469 = OpFAdd %466 %468 
					                                                      OpStore %345 %469 
					                                       f32_3 %470 = OpLoad %345 
					                                       f32_3 %471 = OpExtInst %1 4 %470 
					                                       f32_3 %472 = OpFAdd %471 %228 
					                                                      OpStore %345 %472 
					                                       f32_3 %473 = OpLoad %345 
					                                       f32_3 %474 = OpCompositeConstruct %215 %215 %215 
					                                       f32_3 %475 = OpCompositeConstruct %216 %216 %216 
					                                       f32_3 %476 = OpExtInst %1 43 %473 %474 %475 
					                                                      OpStore %345 %476 
					                                       f32_3 %477 = OpLoad %345 
					                                       f32_3 %478 = OpFAdd %477 %228 
					                                                      OpStore %345 %478 
					                                Private f32* %479 = OpAccessChain %9 %34 
					                                         f32 %480 = OpLoad %479 
					                                         f32 %481 = OpFAdd %480 %350 
					                                Private f32* %482 = OpAccessChain %354 %34 
					                                                      OpStore %482 %481 
					                                Private f32* %484 = OpAccessChain %28 %34 
					                                         f32 %485 = OpLoad %484 
					                                Private f32* %486 = OpAccessChain %354 %34 
					                                         f32 %487 = OpLoad %486 
					                                         f32 %488 = OpFDiv %485 %487 
					                                Private f32* %489 = OpAccessChain %483 %34 
					                                                      OpStore %489 %488 
					                                       f32_2 %490 = OpLoad %483 
					                                       f32_3 %491 = OpVectorShuffle %490 %490 0 0 0 
					                                       f32_3 %492 = OpLoad %345 
					                                       f32_3 %493 = OpFMul %491 %492 
					                                       f32_3 %495 = OpFAdd %493 %494 
					                                       f32_4 %496 = OpLoad %28 
					                                       f32_4 %497 = OpVectorShuffle %496 %495 4 5 6 3 
					                                                      OpStore %28 %497 
					                                       f32_4 %498 = OpLoad %9 
					                                       f32_3 %499 = OpVectorShuffle %498 %498 0 0 0 
					                                       f32_4 %500 = OpLoad %28 
					                                       f32_3 %501 = OpVectorShuffle %500 %500 0 1 2 
					                                       f32_3 %502 = OpFMul %499 %501 
					                                                      OpStore %309 %502 
					                                       f32_3 %503 = OpLoad %309 
					                                         f32 %504 = OpDot %503 %315 
					                                Private f32* %505 = OpAccessChain %354 %34 
					                                                      OpStore %505 %504 
					                                       f32_4 %506 = OpLoad %9 
					                                       f32_3 %507 = OpVectorShuffle %506 %506 0 0 0 
					                                       f32_4 %508 = OpLoad %28 
					                                       f32_3 %509 = OpVectorShuffle %508 %508 0 1 2 
					                                       f32_3 %510 = OpFMul %507 %509 
					                                       f32_2 %511 = OpLoad %354 
					                                       f32_3 %512 = OpVectorShuffle %511 %511 0 0 0 
					                                       f32_3 %513 = OpFNegate %512 
					                                       f32_3 %514 = OpFAdd %510 %513 
					                                       f32_4 %515 = OpLoad %28 
					                                       f32_4 %516 = OpVectorShuffle %515 %514 4 5 6 3 
					                                                      OpStore %28 %516 
					                                Private f32* %517 = OpAccessChain %273 %30 
					                                                      OpStore %517 %385 
					                                Private f32* %518 = OpAccessChain %483 %30 
					                                                      OpStore %518 %385 
					                         read_only Texture2D %519 = OpLoad %390 
					                                     sampler %520 = OpLoad %394 
					                  read_only Texture2DSampled %521 = OpSampledImage %519 %520 
					                                       f32_4 %522 = OpLoad %273 
					                                       f32_2 %523 = OpVectorShuffle %522 %522 0 1 
					                                       f32_4 %524 = OpImageSampleExplicitLod %521 %523 Lod %7 
					                                         f32 %525 = OpCompositeExtract %524 1 
					                                Private f32* %526 = OpAccessChain %9 %34 
					                                                      OpStore %526 %525 
					                         read_only Texture2D %527 = OpLoad %390 
					                                     sampler %528 = OpLoad %394 
					                  read_only Texture2DSampled %529 = OpSampledImage %527 %528 
					                                       f32_2 %530 = OpLoad %483 
					                                       f32_4 %531 = OpImageSampleExplicitLod %529 %530 Lod %7 
					                                         f32 %532 = OpCompositeExtract %531 2 
					                                Private f32* %533 = OpAccessChain %9 %56 
					                                                      OpStore %533 %532 
					                                       f32_4 %534 = OpLoad %9 
					                                       f32_2 %535 = OpVectorShuffle %534 %534 0 3 
					                                       f32_4 %536 = OpLoad %9 
					                                       f32_4 %537 = OpVectorShuffle %536 %535 4 1 2 5 
					                                                      OpStore %9 %537 
					                                       f32_4 %538 = OpLoad %9 
					                                       f32_2 %539 = OpVectorShuffle %538 %538 0 3 
					                                       f32_2 %540 = OpCompositeConstruct %215 %215 
					                                       f32_2 %541 = OpCompositeConstruct %216 %216 
					                                       f32_2 %542 = OpExtInst %1 43 %539 %540 %541 
					                                       f32_4 %543 = OpLoad %9 
					                                       f32_4 %544 = OpVectorShuffle %543 %542 4 1 2 5 
					                                                      OpStore %9 %544 
					                                Private f32* %545 = OpAccessChain %9 %34 
					                                         f32 %546 = OpLoad %545 
					                                Private f32* %547 = OpAccessChain %9 %34 
					                                         f32 %548 = OpLoad %547 
					                                         f32 %549 = OpFAdd %546 %548 
					                                Private f32* %550 = OpAccessChain %9 %34 
					                                                      OpStore %550 %549 
					                                       f32_4 %551 = OpLoad %9 
					                                       f32_2 %552 = OpVectorShuffle %551 %551 3 3 
					                                       f32_4 %553 = OpLoad %9 
					                                       f32_2 %554 = OpVectorShuffle %553 %553 0 0 
					                                         f32 %555 = OpDot %552 %554 
					                                Private f32* %556 = OpAccessChain %9 %34 
					                                                      OpStore %556 %555 
					                                Private f32* %557 = OpAccessChain %9 %34 
					                                         f32 %558 = OpLoad %557 
					                                Private f32* %559 = OpAccessChain %354 %30 
					                                         f32 %560 = OpLoad %559 
					                                         f32 %561 = OpFMul %558 %560 
					                                Private f32* %562 = OpAccessChain %9 %34 
					                                                      OpStore %562 %561 
					                              Uniform f32_3* %563 = OpAccessChain %17 %88 
					                                       f32_3 %564 = OpLoad %563 
					                                       f32_2 %565 = OpVectorShuffle %564 %564 1 1 
					                                       f32_4 %566 = OpLoad %9 
					                                       f32_2 %567 = OpVectorShuffle %566 %566 0 0 
					                                         f32 %568 = OpDot %565 %567 
					                                Private f32* %569 = OpAccessChain %9 %34 
					                                                      OpStore %569 %568 
					                                       f32_4 %570 = OpLoad %9 
					                                       f32_3 %571 = OpVectorShuffle %570 %570 0 0 0 
					                                       f32_4 %572 = OpLoad %28 
					                                       f32_3 %573 = OpVectorShuffle %572 %572 0 1 2 
					                                       f32_3 %574 = OpFMul %571 %573 
					                                       f32_2 %575 = OpLoad %354 
					                                       f32_3 %576 = OpVectorShuffle %575 %575 0 0 0 
					                                       f32_3 %577 = OpFAdd %574 %576 
					                                       f32_4 %578 = OpLoad %9 
					                                       f32_4 %579 = OpVectorShuffle %578 %577 4 5 6 3 
					                                                      OpStore %9 %579 
					                                       f32_4 %580 = OpLoad %9 
					                                       f32_3 %581 = OpVectorShuffle %580 %580 0 1 2 
					                                       f32_3 %582 = OpCompositeConstruct %215 %215 %215 
					                                       f32_3 %583 = OpCompositeConstruct %216 %216 %216 
					                                       f32_3 %584 = OpExtInst %1 43 %581 %582 %583 
					                                       f32_4 %585 = OpLoad %9 
					                                       f32_4 %586 = OpVectorShuffle %585 %584 4 5 6 3 
					                                                      OpStore %9 %586 
					                                       f32_4 %587 = OpLoad %9 
					                                       f32_3 %588 = OpVectorShuffle %587 %587 0 1 2 
					                                       f32_3 %591 = OpFAdd %588 %590 
					                                       f32_4 %592 = OpLoad %9 
					                                       f32_4 %593 = OpVectorShuffle %592 %591 4 5 6 3 
					                                                      OpStore %9 %593 
					                                Private f32* %595 = OpAccessChain %9 %56 
					                                                      OpStore %595 %594 
					                         read_only Texture2D %596 = OpLoad %390 
					                                     sampler %597 = OpLoad %394 
					                  read_only Texture2DSampled %598 = OpSampledImage %596 %597 
					                                       f32_4 %599 = OpLoad %9 
					                                       f32_2 %600 = OpVectorShuffle %599 %599 0 3 
					                                       f32_4 %601 = OpImageSampleImplicitLod %598 %600 
					                                         f32 %602 = OpCompositeExtract %601 3 
					                                Private f32* %603 = OpAccessChain %28 %34 
					                                                      OpStore %603 %602 
					                                Private f32* %604 = OpAccessChain %28 %34 
					                                         f32 %605 = OpLoad %604 
					                                Private f32* %606 = OpAccessChain %28 %34 
					                                                      OpStore %606 %605 
					                                Private f32* %607 = OpAccessChain %28 %34 
					                                         f32 %608 = OpLoad %607 
					                                         f32 %609 = OpExtInst %1 43 %608 %215 %216 
					                                Private f32* %610 = OpAccessChain %28 %34 
					                                                      OpStore %610 %609 
					                         read_only Texture2D %611 = OpLoad %390 
					                                     sampler %612 = OpLoad %394 
					                  read_only Texture2DSampled %613 = OpSampledImage %611 %612 
					                                       f32_4 %614 = OpLoad %9 
					                                       f32_2 %615 = OpVectorShuffle %614 %614 1 3 
					                                       f32_4 %616 = OpImageSampleImplicitLod %613 %615 
					                                         f32 %617 = OpCompositeExtract %616 3 
					                                Private f32* %618 = OpAccessChain %345 %34 
					                                                      OpStore %618 %617 
					                         read_only Texture2D %619 = OpLoad %390 
					                                     sampler %620 = OpLoad %394 
					                  read_only Texture2DSampled %621 = OpSampledImage %619 %620 
					                                       f32_4 %622 = OpLoad %9 
					                                       f32_2 %623 = OpVectorShuffle %622 %622 2 3 
					                                       f32_4 %624 = OpImageSampleImplicitLod %621 %623 
					                                         f32 %625 = OpCompositeExtract %624 3 
					                                Private f32* %626 = OpAccessChain %345 %30 
					                                                      OpStore %626 %625 
					                                       f32_3 %627 = OpLoad %345 
					                                       f32_2 %628 = OpVectorShuffle %627 %627 0 1 
					                                       f32_4 %629 = OpLoad %28 
					                                       f32_4 %630 = OpVectorShuffle %629 %628 0 4 5 3 
					                                                      OpStore %28 %630 
					                                       f32_4 %631 = OpLoad %28 
					                                       f32_2 %632 = OpVectorShuffle %631 %631 1 2 
					                                       f32_2 %633 = OpCompositeConstruct %215 %215 
					                                       f32_2 %634 = OpCompositeConstruct %216 %216 
					                                       f32_2 %635 = OpExtInst %1 43 %632 %633 %634 
					                                       f32_4 %636 = OpLoad %28 
					                                       f32_4 %637 = OpVectorShuffle %636 %635 0 4 5 3 
					                                                      OpStore %28 %637 
					                                       f32_4 %638 = OpLoad %28 
					                                       f32_3 %639 = OpVectorShuffle %638 %638 0 1 2 
					                                       f32_3 %640 = OpFAdd %639 %590 
					                                       f32_4 %641 = OpLoad %9 
					                                       f32_4 %642 = OpVectorShuffle %641 %640 4 5 6 3 
					                                                      OpStore %9 %642 
					                                Private f32* %643 = OpAccessChain %9 %56 
					                                                      OpStore %643 %594 
					                         read_only Texture2D %644 = OpLoad %390 
					                                     sampler %645 = OpLoad %394 
					                  read_only Texture2DSampled %646 = OpSampledImage %644 %645 
					                                       f32_4 %647 = OpLoad %9 
					                                       f32_2 %648 = OpVectorShuffle %647 %647 0 3 
					                                       f32_4 %649 = OpImageSampleImplicitLod %646 %648 
					                                         f32 %650 = OpCompositeExtract %649 0 
					                                Private f32* %651 = OpAccessChain %9 %34 
					                                                      OpStore %651 %650 
					                                Private f32* %654 = OpAccessChain %9 %34 
					                                         f32 %655 = OpLoad %654 
					                                 Output f32* %657 = OpAccessChain %653 %34 
					                                                      OpStore %657 %655 
					                                 Output f32* %658 = OpAccessChain %653 %34 
					                                         f32 %659 = OpLoad %658 
					                                         f32 %660 = OpExtInst %1 43 %659 %215 %216 
					                                 Output f32* %661 = OpAccessChain %653 %34 
					                                                      OpStore %661 %660 
					                         read_only Texture2D %662 = OpLoad %390 
					                                     sampler %663 = OpLoad %394 
					                  read_only Texture2DSampled %664 = OpSampledImage %662 %663 
					                                       f32_4 %665 = OpLoad %9 
					                                       f32_2 %666 = OpVectorShuffle %665 %665 1 3 
					                                       f32_4 %667 = OpImageSampleImplicitLod %664 %666 
					                                         f32 %668 = OpCompositeExtract %667 1 
					                                Private f32* %669 = OpAccessChain %9 %34 
					                                                      OpStore %669 %668 
					                         read_only Texture2D %670 = OpLoad %390 
					                                     sampler %671 = OpLoad %394 
					                  read_only Texture2DSampled %672 = OpSampledImage %670 %671 
					                                       f32_4 %673 = OpLoad %9 
					                                       f32_2 %674 = OpVectorShuffle %673 %673 2 3 
					                                       f32_4 %675 = OpImageSampleImplicitLod %672 %674 
					                                         f32 %676 = OpCompositeExtract %675 2 
					                                Private f32* %677 = OpAccessChain %9 %30 
					                                                      OpStore %677 %676 
					                                       f32_4 %678 = OpLoad %9 
					                                       f32_2 %679 = OpVectorShuffle %678 %678 0 1 
					                                       f32_4 %680 = OpLoad %653 
					                                       f32_4 %681 = OpVectorShuffle %680 %679 0 4 5 3 
					                                                      OpStore %653 %681 
					                                       f32_4 %682 = OpLoad %653 
					                                       f32_2 %683 = OpVectorShuffle %682 %682 1 2 
					                                       f32_2 %684 = OpCompositeConstruct %215 %215 
					                                       f32_2 %685 = OpCompositeConstruct %216 %216 
					                                       f32_2 %686 = OpExtInst %1 43 %683 %684 %685 
					                                       f32_4 %687 = OpLoad %653 
					                                       f32_4 %688 = OpVectorShuffle %687 %686 0 4 5 3 
					                                                      OpStore %653 %688 
					                                 Output f32* %689 = OpAccessChain %653 %56 
					                                                      OpStore %689 %216 
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
						vec4 _Lut2D_Params;
						vec4 unused_0_2;
						vec3 _ColorBalance;
						vec3 _ColorFilter;
						vec3 _HueSatCon;
						float _Brightness;
						vec3 _ChannelMixerRed;
						vec3 _ChannelMixerGreen;
						vec3 _ChannelMixerBlue;
						vec3 _Lift;
						vec3 _InvGamma;
						vec3 _Gain;
						vec4 unused_0_13[7];
					};
					uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD1.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness)) + vec3(-0.217637643, -0.217637643, -0.217637643);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.217637643, 0.217637643, 0.217637643);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7 = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat15.x + u_xlat4.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7 = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(0.00390625, 0.00390625, 0.00390625);
					    u_xlat0.w = 0.75;
					    u_xlat1 = texture(_Curves, u_xlat0.xw).wxyz;
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat2 = texture(_Curves, u_xlat0.yw);
					    u_xlat0 = texture(_Curves, u_xlat0.zw);
					    u_xlat1.z = u_xlat0.w;
					    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
					    u_xlat1.y = u_xlat2.w;
					    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat1.xyz + vec3(0.00390625, 0.00390625, 0.00390625);
					    u_xlat0.w = 0.75;
					    u_xlat1 = texture(_Curves, u_xlat0.xw);
					    SV_Target0.x = u_xlat1.x;
					    SV_Target0.x = clamp(SV_Target0.x, 0.0, 1.0);
					    u_xlat1 = texture(_Curves, u_xlat0.yw);
					    u_xlat0 = texture(_Curves, u_xlat0.zw);
					    SV_Target0.z = u_xlat0.z;
					    SV_Target0.z = clamp(SV_Target0.z, 0.0, 1.0);
					    SV_Target0.y = u_xlat1.y;
					    SV_Target0.y = clamp(SV_Target0.y, 0.0, 1.0);
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
			GpuProgramID 74640
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
						vec4 unused_0_2[19];
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
					uniform 	vec4 _Lut2D_Params;
					uniform 	vec4 _UserLut2D_Params;
					uniform 	vec3 _ColorBalance;
					uniform 	vec3 _ColorFilter;
					uniform 	vec3 _HueSatCon;
					uniform 	float _Brightness;
					uniform 	vec3 _ChannelMixerRed;
					uniform 	vec3 _ChannelMixerGreen;
					uniform 	vec3 _ChannelMixerBlue;
					uniform 	vec3 _Lift;
					uniform 	vec3 _InvGamma;
					uniform 	vec3 _Gain;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat8;
					vec2 u_xlat12;
					vec2 u_xlat13;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = _UserLut2D_Params.y;
					    u_xlat1.yz = vs_TEXCOORD1.xy + (-_Lut2D_Params.yz);
					    u_xlat2.x = u_xlat1.y * _Lut2D_Params.x;
					    u_xlat1.x = fract(u_xlat2.x);
					    u_xlat2.x = u_xlat1.x / _Lut2D_Params.x;
					    u_xlat1.w = u_xlat1.y + (-u_xlat2.x);
					    u_xlat2.xyz = u_xlat1.xzw * _Lut2D_Params.www;
					    u_xlat3.xyz = u_xlat2.zxy * _UserLut2D_Params.zzz;
					    u_xlat7 = floor(u_xlat3.x);
					    u_xlat3.xw = _UserLut2D_Params.xy * vec2(0.5, 0.5);
					    u_xlat3.yz = u_xlat3.yz * _UserLut2D_Params.xy + u_xlat3.xw;
					    u_xlat3.x = u_xlat7 * _UserLut2D_Params.y + u_xlat3.y;
					    u_xlat7 = u_xlat2.z * _UserLut2D_Params.z + (-u_xlat7);
					    u_xlat0.y = float(0.0);
					    u_xlat12.y = float(0.25);
					    u_xlat0.xy = u_xlat0.xy + u_xlat3.xz;
					    u_xlat3 = texture(_MainTex, u_xlat3.xz);
					    u_xlat4 = texture(_MainTex, u_xlat0.xy);
					    u_xlat4.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
					    u_xlat3.xyz = vec3(u_xlat7) * u_xlat4.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = (-u_xlat1.xzw) * _Lut2D_Params.www + u_xlat3.xyz;
					    u_xlat1.xyz = _UserLut2D_Params.www * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness)) + vec3(-0.217637643, -0.217637643, -0.217637643);
					    u_xlat1.xyz = u_xlat1.xyz * _HueSatCon.zzz + vec3(0.217637643, 0.217637643, 0.217637643);
					    u_xlat2.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat1.xyz);
					    u_xlat2.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat1.xyz);
					    u_xlat2.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat2.xyz * _ColorBalance.xyz;
					    u_xlat2.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat1.xyz);
					    u_xlat2.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat1.xyz);
					    u_xlat2.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat2.xyz * _ColorFilter.xyz;
					    u_xlat2.x = dot(u_xlat1.xyz, _ChannelMixerRed.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, _ChannelMixerGreen.xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, _ChannelMixerBlue.xyz);
					    u_xlat1.xyz = u_xlat2.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat2.xyz = log2(abs(u_xlat1.xyz));
					    u_xlat1.xyz = u_xlat1.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat2.xyz = u_xlat2.xyz * _InvGamma.xyz;
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb0 = u_xlat1.y>=u_xlat1.z;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat2.xy = u_xlat1.zy;
					    u_xlat3.xy = u_xlat1.yz + (-u_xlat2.xy);
					    u_xlat2.z = float(-1.0);
					    u_xlat2.w = float(0.666666687);
					    u_xlat3.z = float(1.0);
					    u_xlat3.w = float(-1.0);
					    u_xlat2 = u_xlat0.xxxx * u_xlat3.xywz + u_xlat2.xywz;
					    u_xlatb0 = u_xlat1.x>=u_xlat2.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat3.z = u_xlat2.w;
					    u_xlat2.w = u_xlat1.x;
					    u_xlat13.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat3.xyw = u_xlat2.wyx;
					    u_xlat3 = (-u_xlat2) + u_xlat3;
					    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
					    u_xlat0.x = min(u_xlat2.y, u_xlat2.w);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat6.x = u_xlat0.x * 6.0 + 9.99999975e-05;
					    u_xlat8 = (-u_xlat2.y) + u_xlat2.w;
					    u_xlat6.x = u_xlat8 / u_xlat6.x;
					    u_xlat6.x = u_xlat6.x + u_xlat2.z;
					    u_xlat12.x = abs(u_xlat6.x);
					    u_xlat3 = textureLod(_Curves, u_xlat12.xy, 0.0).yxzw;
					    u_xlat4.x = u_xlat12.x + _HueSatCon.x;
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat3.x + u_xlat3.x;
					    u_xlat12.x = u_xlat2.x + 9.99999975e-05;
					    u_xlat1.x = u_xlat0.x / u_xlat12.x;
					    u_xlat1.y = float(0.25);
					    u_xlat13.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat1.xy, 0.0).zxyw;
					    u_xlat5 = textureLod(_Curves, u_xlat13.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat3.xx, u_xlat6.xx);
					    u_xlat0.x = u_xlat0.x * u_xlat5.x;
					    u_xlat0.x = dot(_HueSatCon.yy, u_xlat0.xx);
					    u_xlat4.y = 0.25;
					    u_xlat3 = textureLod(_Curves, u_xlat4.xy, 0.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat4.x + u_xlat3.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = u_xlat1.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat2.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + u_xlat1.xxx;
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(0.00390625, 0.00390625, 0.00390625);
					    u_xlat0.w = 0.75;
					    u_xlat1 = texture(_Curves, u_xlat0.xw).wxyz;
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat2 = texture(_Curves, u_xlat0.yw);
					    u_xlat0 = texture(_Curves, u_xlat0.zw);
					    u_xlat1.z = u_xlat0.w;
					    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
					    u_xlat1.y = u_xlat2.w;
					    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat1.xyz + vec3(0.00390625, 0.00390625, 0.00390625);
					    u_xlat0.w = 0.75;
					    u_xlat1 = texture(_Curves, u_xlat0.xw);
					    SV_Target0.x = u_xlat1.x;
					    SV_Target0.x = clamp(SV_Target0.x, 0.0, 1.0);
					    u_xlat1 = texture(_Curves, u_xlat0.yw);
					    u_xlat0 = texture(_Curves, u_xlat0.zw);
					    SV_Target0.z = u_xlat0.z;
					    SV_Target0.z = clamp(SV_Target0.z, 0.0, 1.0);
					    SV_Target0.y = u_xlat1.y;
					    SV_Target0.y = clamp(SV_Target0.y, 0.0, 1.0);
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
					; Bound: 812
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %27 %774 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpMemberDecorate %11 0 Offset 11 
					                                                      OpMemberDecorate %11 1 Offset 11 
					                                                      OpMemberDecorate %11 2 Offset 11 
					                                                      OpMemberDecorate %11 3 Offset 11 
					                                                      OpMemberDecorate %11 4 Offset 11 
					                                                      OpMemberDecorate %11 5 Offset 11 
					                                                      OpMemberDecorate %11 6 Offset 11 
					                                                      OpMemberDecorate %11 7 Offset 11 
					                                                      OpMemberDecorate %11 8 Offset 11 
					                                                      OpMemberDecorate %11 9 Offset 11 
					                                                      OpMemberDecorate %11 10 Offset 11 
					                                                      OpMemberDecorate %11 11 Offset 11 
					                                                      OpDecorate %11 Block 
					                                                      OpDecorate %13 DescriptorSet 13 
					                                                      OpDecorate %13 Binding 13 
					                                                      OpDecorate vs_TEXCOORD1 Location 27 
					                                                      OpDecorate %139 DescriptorSet 139 
					                                                      OpDecorate %139 Binding 139 
					                                                      OpDecorate %143 DescriptorSet 143 
					                                                      OpDecorate %143 Binding 143 
					                                                      OpDecorate %504 DescriptorSet 504 
					                                                      OpDecorate %504 Binding 504 
					                                                      OpDecorate %506 DescriptorSet 506 
					                                                      OpDecorate %506 Binding 506 
					                                                      OpDecorate %774 Location 774 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 3 
					                                              %11 = OpTypeStruct %7 %7 %10 %10 %10 %6 %10 %10 %10 %10 %10 %10 
					                                              %12 = OpTypePointer Uniform %11 
					Uniform struct {f32_4; f32_4; f32_3; f32_3; f32_3; f32; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3;}* %13 = OpVariable Uniform 
					                                              %14 = OpTypeInt 32 1 
					                                          i32 %15 = OpConstant 1 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 1 
					                                              %18 = OpTypePointer Uniform %6 
					                                          u32 %21 = OpConstant 0 
					                                              %22 = OpTypePointer Private %6 
					                               Private f32_4* %24 = OpVariable Private 
					                                              %25 = OpTypeVector %6 2 
					                                              %26 = OpTypePointer Input %25 
					                        Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                          i32 %29 = OpConstant 0 
					                                              %30 = OpTypePointer Uniform %7 
					                               Private f32_4* %38 = OpVariable Private 
					                                          u32 %61 = OpConstant 3 
					                               Private f32_4* %71 = OpVariable Private 
					                                              %80 = OpTypePointer Private %25 
					                               Private f32_2* %81 = OpVariable Private 
					                                          f32 %89 = OpConstant 3,674022E-40 
					                                        f32_2 %90 = OpConstantComposite %89 %89 
					                                         u32 %114 = OpConstant 2 
					                                         f32 %125 = OpConstant 3,674022E-40 
					                              Private f32_2* %127 = OpVariable Private 
					                                         f32 %128 = OpConstant 3,674022E-40 
					                                             %137 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                             %138 = OpTypePointer UniformConstant %137 
					        UniformConstant read_only Texture2D* %139 = OpVariable UniformConstant 
					                                             %141 = OpTypeSampler 
					                                             %142 = OpTypePointer UniformConstant %141 
					                    UniformConstant sampler* %143 = OpVariable UniformConstant 
					                                             %145 = OpTypeSampledImage %137 
					                                             %153 = OpTypePointer Private %10 
					                              Private f32_3* %154 = OpVariable Private 
					                                         i32 %201 = OpConstant 5 
					                                         f32 %214 = OpConstant 3,674022E-40 
					                                       f32_3 %215 = OpConstantComposite %214 %214 %214 
					                                         i32 %221 = OpConstant 4 
					                                             %222 = OpTypePointer Uniform %10 
					                                         f32 %227 = OpConstant 3,674022E-40 
					                                       f32_3 %228 = OpConstantComposite %227 %227 %227 
					                                         f32 %232 = OpConstant 3,674022E-40 
					                                         f32 %233 = OpConstant 3,674022E-40 
					                                         f32 %234 = OpConstant 3,674022E-40 
					                                       f32_3 %235 = OpConstantComposite %232 %233 %234 
					                                         f32 %240 = OpConstant 3,674022E-40 
					                                         f32 %241 = OpConstant 3,674022E-40 
					                                         f32 %242 = OpConstant 3,674022E-40 
					                                       f32_3 %243 = OpConstantComposite %240 %241 %242 
					                                         f32 %248 = OpConstant 3,674022E-40 
					                                         f32 %249 = OpConstant 3,674022E-40 
					                                         f32 %250 = OpConstant 3,674022E-40 
					                                       f32_3 %251 = OpConstantComposite %248 %249 %250 
					                                         i32 %258 = OpConstant 2 
					                                         f32 %264 = OpConstant 3,674022E-40 
					                                         f32 %265 = OpConstant 3,674022E-40 
					                                         f32 %266 = OpConstant 3,674022E-40 
					                                       f32_3 %267 = OpConstantComposite %264 %265 %266 
					                                         f32 %272 = OpConstant 3,674022E-40 
					                                         f32 %273 = OpConstant 3,674022E-40 
					                                         f32 %274 = OpConstant 3,674022E-40 
					                                       f32_3 %275 = OpConstantComposite %272 %273 %274 
					                                         f32 %280 = OpConstant 3,674022E-40 
					                                         f32 %281 = OpConstant 3,674022E-40 
					                                         f32 %282 = OpConstant 3,674022E-40 
					                                       f32_3 %283 = OpConstantComposite %280 %281 %282 
					                                         i32 %290 = OpConstant 3 
					                                         i32 %298 = OpConstant 6 
					                                         i32 %305 = OpConstant 7 
					                                         i32 %312 = OpConstant 8 
					                                         i32 %319 = OpConstant 11 
					                                         i32 %323 = OpConstant 9 
					                                         f32 %337 = OpConstant 3,674022E-40 
					                                       f32_3 %338 = OpConstantComposite %337 %337 %337 
					                                       f32_3 %340 = OpConstantComposite %89 %89 %89 
					                                         f32 %346 = OpConstant 3,674022E-40 
					                                         f32 %354 = OpConstant 3,674022E-40 
					                                       f32_3 %355 = OpConstantComposite %354 %354 %354 
					                                         f32 %357 = OpConstant 3,674022E-40 
					                                       f32_3 %358 = OpConstantComposite %357 %357 %357 
					                                         i32 %364 = OpConstant 10 
					                                       f32_3 %384 = OpConstantComposite %125 %125 %125 
					                                             %388 = OpTypeBool 
					                                             %389 = OpTypePointer Private %388 
					                               Private bool* %390 = OpVariable Private 
					                                         f32 %412 = OpConstant 3,674022E-40 
					                              Private f32_2* %438 = OpVariable Private 
					                                         f32 %441 = OpConstant 3,674022E-40 
					                                         f32 %442 = OpConstant 3,674022E-40 
					                                         f32 %443 = OpConstant 3,674022E-40 
					                                       f32_3 %444 = OpConstantComposite %441 %442 %443 
					                              Private f32_3* %474 = OpVariable Private 
					                                         f32 %477 = OpConstant 3,674022E-40 
					                                         f32 %479 = OpConstant 3,674022E-40 
					                                Private f32* %482 = OpVariable Private 
					        UniformConstant read_only Texture2D* %504 = OpVariable UniformConstant 
					                    UniformConstant sampler* %506 = OpVariable UniformConstant 
					                                         f32 %613 = OpConstant 3,674022E-40 
					                                         f32 %614 = OpConstant 3,674022E-40 
					                                       f32_3 %615 = OpConstantComposite %613 %89 %614 
					                               Private bool* %617 = OpVariable Private 
					                                Private f32* %621 = OpVariable Private 
					                                             %623 = OpTypePointer Function %6 
					                               Private bool* %633 = OpVariable Private 
					                                         f32 %649 = OpConstant 3,674022E-40 
					                                       f32_3 %650 = OpConstantComposite %346 %412 %649 
					                                       f32_3 %655 = OpConstantComposite %477 %477 %477 
					                                         f32 %657 = OpConstant 3,674022E-40 
					                                       f32_3 %658 = OpConstantComposite %657 %657 %657 
					                                       f32_3 %673 = OpConstantComposite %346 %346 %346 
					                                         f32 %711 = OpConstant 3,674022E-40 
					                                       f32_3 %712 = OpConstantComposite %711 %711 %711 
					                                         f32 %716 = OpConstant 3,674022E-40 
					                                             %773 = OpTypePointer Output %7 
					                               Output f32_4* %774 = OpVariable Output 
					                                             %777 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                               Function f32* %624 = OpVariable Function 
					                               Function f32* %638 = OpVariable Function 
					                                 Uniform f32* %19 = OpAccessChain %13 %15 %17 
					                                          f32 %20 = OpLoad %19 
					                                 Private f32* %23 = OpAccessChain %9 %21 
					                                                      OpStore %23 %20 
					                                        f32_2 %28 = OpLoad vs_TEXCOORD1 
					                               Uniform f32_4* %31 = OpAccessChain %13 %29 
					                                        f32_4 %32 = OpLoad %31 
					                                        f32_2 %33 = OpVectorShuffle %32 %32 1 2 
					                                        f32_2 %34 = OpFNegate %33 
					                                        f32_2 %35 = OpFAdd %28 %34 
					                                        f32_4 %36 = OpLoad %24 
					                                        f32_4 %37 = OpVectorShuffle %36 %35 0 4 5 3 
					                                                      OpStore %24 %37 
					                                 Private f32* %39 = OpAccessChain %24 %17 
					                                          f32 %40 = OpLoad %39 
					                                 Uniform f32* %41 = OpAccessChain %13 %29 %21 
					                                          f32 %42 = OpLoad %41 
					                                          f32 %43 = OpFMul %40 %42 
					                                 Private f32* %44 = OpAccessChain %38 %21 
					                                                      OpStore %44 %43 
					                                 Private f32* %45 = OpAccessChain %38 %21 
					                                          f32 %46 = OpLoad %45 
					                                          f32 %47 = OpExtInst %1 10 %46 
					                                 Private f32* %48 = OpAccessChain %24 %21 
					                                                      OpStore %48 %47 
					                                 Private f32* %49 = OpAccessChain %24 %21 
					                                          f32 %50 = OpLoad %49 
					                                 Uniform f32* %51 = OpAccessChain %13 %29 %21 
					                                          f32 %52 = OpLoad %51 
					                                          f32 %53 = OpFDiv %50 %52 
					                                 Private f32* %54 = OpAccessChain %38 %21 
					                                                      OpStore %54 %53 
					                                 Private f32* %55 = OpAccessChain %24 %17 
					                                          f32 %56 = OpLoad %55 
					                                 Private f32* %57 = OpAccessChain %38 %21 
					                                          f32 %58 = OpLoad %57 
					                                          f32 %59 = OpFNegate %58 
					                                          f32 %60 = OpFAdd %56 %59 
					                                 Private f32* %62 = OpAccessChain %24 %61 
					                                                      OpStore %62 %60 
					                                        f32_4 %63 = OpLoad %24 
					                                        f32_3 %64 = OpVectorShuffle %63 %63 0 2 3 
					                               Uniform f32_4* %65 = OpAccessChain %13 %29 
					                                        f32_4 %66 = OpLoad %65 
					                                        f32_3 %67 = OpVectorShuffle %66 %66 3 3 3 
					                                        f32_3 %68 = OpFMul %64 %67 
					                                        f32_4 %69 = OpLoad %38 
					                                        f32_4 %70 = OpVectorShuffle %69 %68 4 5 6 3 
					                                                      OpStore %38 %70 
					                                        f32_4 %72 = OpLoad %38 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 2 0 1 
					                               Uniform f32_4* %74 = OpAccessChain %13 %15 
					                                        f32_4 %75 = OpLoad %74 
					                                        f32_3 %76 = OpVectorShuffle %75 %75 2 2 2 
					                                        f32_3 %77 = OpFMul %73 %76 
					                                        f32_4 %78 = OpLoad %71 
					                                        f32_4 %79 = OpVectorShuffle %78 %77 4 5 6 3 
					                                                      OpStore %71 %79 
					                                 Private f32* %82 = OpAccessChain %71 %21 
					                                          f32 %83 = OpLoad %82 
					                                          f32 %84 = OpExtInst %1 8 %83 
					                                 Private f32* %85 = OpAccessChain %81 %21 
					                                                      OpStore %85 %84 
					                               Uniform f32_4* %86 = OpAccessChain %13 %15 
					                                        f32_4 %87 = OpLoad %86 
					                                        f32_2 %88 = OpVectorShuffle %87 %87 0 1 
					                                        f32_2 %91 = OpFMul %88 %90 
					                                        f32_4 %92 = OpLoad %71 
					                                        f32_4 %93 = OpVectorShuffle %92 %91 4 1 2 5 
					                                                      OpStore %71 %93 
					                                        f32_4 %94 = OpLoad %71 
					                                        f32_2 %95 = OpVectorShuffle %94 %94 1 2 
					                               Uniform f32_4* %96 = OpAccessChain %13 %15 
					                                        f32_4 %97 = OpLoad %96 
					                                        f32_2 %98 = OpVectorShuffle %97 %97 0 1 
					                                        f32_2 %99 = OpFMul %95 %98 
					                                       f32_4 %100 = OpLoad %71 
					                                       f32_2 %101 = OpVectorShuffle %100 %100 0 3 
					                                       f32_2 %102 = OpFAdd %99 %101 
					                                       f32_4 %103 = OpLoad %71 
					                                       f32_4 %104 = OpVectorShuffle %103 %102 0 4 5 3 
					                                                      OpStore %71 %104 
					                                Private f32* %105 = OpAccessChain %81 %21 
					                                         f32 %106 = OpLoad %105 
					                                Uniform f32* %107 = OpAccessChain %13 %15 %17 
					                                         f32 %108 = OpLoad %107 
					                                         f32 %109 = OpFMul %106 %108 
					                                Private f32* %110 = OpAccessChain %71 %17 
					                                         f32 %111 = OpLoad %110 
					                                         f32 %112 = OpFAdd %109 %111 
					                                Private f32* %113 = OpAccessChain %71 %21 
					                                                      OpStore %113 %112 
					                                Private f32* %115 = OpAccessChain %38 %114 
					                                         f32 %116 = OpLoad %115 
					                                Uniform f32* %117 = OpAccessChain %13 %15 %114 
					                                         f32 %118 = OpLoad %117 
					                                         f32 %119 = OpFMul %116 %118 
					                                Private f32* %120 = OpAccessChain %81 %21 
					                                         f32 %121 = OpLoad %120 
					                                         f32 %122 = OpFNegate %121 
					                                         f32 %123 = OpFAdd %119 %122 
					                                Private f32* %124 = OpAccessChain %81 %21 
					                                                      OpStore %124 %123 
					                                Private f32* %126 = OpAccessChain %9 %17 
					                                                      OpStore %126 %125 
					                                Private f32* %129 = OpAccessChain %127 %17 
					                                                      OpStore %129 %128 
					                                       f32_4 %130 = OpLoad %9 
					                                       f32_2 %131 = OpVectorShuffle %130 %130 0 1 
					                                       f32_4 %132 = OpLoad %71 
					                                       f32_2 %133 = OpVectorShuffle %132 %132 0 2 
					                                       f32_2 %134 = OpFAdd %131 %133 
					                                       f32_4 %135 = OpLoad %9 
					                                       f32_4 %136 = OpVectorShuffle %135 %134 4 5 2 3 
					                                                      OpStore %9 %136 
					                         read_only Texture2D %140 = OpLoad %139 
					                                     sampler %144 = OpLoad %143 
					                  read_only Texture2DSampled %146 = OpSampledImage %140 %144 
					                                       f32_4 %147 = OpLoad %71 
					                                       f32_2 %148 = OpVectorShuffle %147 %147 0 2 
					                                       f32_4 %149 = OpImageSampleImplicitLod %146 %148 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_4 %151 = OpLoad %71 
					                                       f32_4 %152 = OpVectorShuffle %151 %150 4 5 6 3 
					                                                      OpStore %71 %152 
					                         read_only Texture2D %155 = OpLoad %139 
					                                     sampler %156 = OpLoad %143 
					                  read_only Texture2DSampled %157 = OpSampledImage %155 %156 
					                                       f32_4 %158 = OpLoad %9 
					                                       f32_2 %159 = OpVectorShuffle %158 %158 0 1 
					                                       f32_4 %160 = OpImageSampleImplicitLod %157 %159 
					                                       f32_3 %161 = OpVectorShuffle %160 %160 0 1 2 
					                                                      OpStore %154 %161 
					                                       f32_4 %162 = OpLoad %71 
					                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
					                                       f32_3 %164 = OpFNegate %163 
					                                       f32_3 %165 = OpLoad %154 
					                                       f32_3 %166 = OpFAdd %164 %165 
					                                                      OpStore %154 %166 
					                                       f32_2 %167 = OpLoad %81 
					                                       f32_3 %168 = OpVectorShuffle %167 %167 0 0 0 
					                                       f32_3 %169 = OpLoad %154 
					                                       f32_3 %170 = OpFMul %168 %169 
					                                       f32_4 %171 = OpLoad %71 
					                                       f32_3 %172 = OpVectorShuffle %171 %171 0 1 2 
					                                       f32_3 %173 = OpFAdd %170 %172 
					                                       f32_4 %174 = OpLoad %71 
					                                       f32_4 %175 = OpVectorShuffle %174 %173 4 5 6 3 
					                                                      OpStore %71 %175 
					                                       f32_4 %176 = OpLoad %24 
					                                       f32_3 %177 = OpVectorShuffle %176 %176 0 2 3 
					                                       f32_3 %178 = OpFNegate %177 
					                              Uniform f32_4* %179 = OpAccessChain %13 %29 
					                                       f32_4 %180 = OpLoad %179 
					                                       f32_3 %181 = OpVectorShuffle %180 %180 3 3 3 
					                                       f32_3 %182 = OpFMul %178 %181 
					                                       f32_4 %183 = OpLoad %71 
					                                       f32_3 %184 = OpVectorShuffle %183 %183 0 1 2 
					                                       f32_3 %185 = OpFAdd %182 %184 
					                                       f32_4 %186 = OpLoad %24 
					                                       f32_4 %187 = OpVectorShuffle %186 %185 4 5 6 3 
					                                                      OpStore %24 %187 
					                              Uniform f32_4* %188 = OpAccessChain %13 %15 
					                                       f32_4 %189 = OpLoad %188 
					                                       f32_3 %190 = OpVectorShuffle %189 %189 3 3 3 
					                                       f32_4 %191 = OpLoad %24 
					                                       f32_3 %192 = OpVectorShuffle %191 %191 0 1 2 
					                                       f32_3 %193 = OpFMul %190 %192 
					                                       f32_4 %194 = OpLoad %38 
					                                       f32_3 %195 = OpVectorShuffle %194 %194 0 1 2 
					                                       f32_3 %196 = OpFAdd %193 %195 
					                                       f32_4 %197 = OpLoad %24 
					                                       f32_4 %198 = OpVectorShuffle %197 %196 4 5 6 3 
					                                                      OpStore %24 %198 
					                                       f32_4 %199 = OpLoad %24 
					                                       f32_3 %200 = OpVectorShuffle %199 %199 0 1 2 
					                                Uniform f32* %202 = OpAccessChain %13 %201 
					                                         f32 %203 = OpLoad %202 
					                                Uniform f32* %204 = OpAccessChain %13 %201 
					                                         f32 %205 = OpLoad %204 
					                                Uniform f32* %206 = OpAccessChain %13 %201 
					                                         f32 %207 = OpLoad %206 
					                                       f32_3 %208 = OpCompositeConstruct %203 %205 %207 
					                                         f32 %209 = OpCompositeExtract %208 0 
					                                         f32 %210 = OpCompositeExtract %208 1 
					                                         f32 %211 = OpCompositeExtract %208 2 
					                                       f32_3 %212 = OpCompositeConstruct %209 %210 %211 
					                                       f32_3 %213 = OpFMul %200 %212 
					                                       f32_3 %216 = OpFAdd %213 %215 
					                                       f32_4 %217 = OpLoad %24 
					                                       f32_4 %218 = OpVectorShuffle %217 %216 4 5 6 3 
					                                                      OpStore %24 %218 
					                                       f32_4 %219 = OpLoad %24 
					                                       f32_3 %220 = OpVectorShuffle %219 %219 0 1 2 
					                              Uniform f32_3* %223 = OpAccessChain %13 %221 
					                                       f32_3 %224 = OpLoad %223 
					                                       f32_3 %225 = OpVectorShuffle %224 %224 2 2 2 
					                                       f32_3 %226 = OpFMul %220 %225 
					                                       f32_3 %229 = OpFAdd %226 %228 
					                                       f32_4 %230 = OpLoad %24 
					                                       f32_4 %231 = OpVectorShuffle %230 %229 4 5 6 3 
					                                                      OpStore %24 %231 
					                                       f32_4 %236 = OpLoad %24 
					                                       f32_3 %237 = OpVectorShuffle %236 %236 0 1 2 
					                                         f32 %238 = OpDot %235 %237 
					                                Private f32* %239 = OpAccessChain %38 %21 
					                                                      OpStore %239 %238 
					                                       f32_4 %244 = OpLoad %24 
					                                       f32_3 %245 = OpVectorShuffle %244 %244 0 1 2 
					                                         f32 %246 = OpDot %243 %245 
					                                Private f32* %247 = OpAccessChain %38 %17 
					                                                      OpStore %247 %246 
					                                       f32_4 %252 = OpLoad %24 
					                                       f32_3 %253 = OpVectorShuffle %252 %252 0 1 2 
					                                         f32 %254 = OpDot %251 %253 
					                                Private f32* %255 = OpAccessChain %38 %114 
					                                                      OpStore %255 %254 
					                                       f32_4 %256 = OpLoad %38 
					                                       f32_3 %257 = OpVectorShuffle %256 %256 0 1 2 
					                              Uniform f32_3* %259 = OpAccessChain %13 %258 
					                                       f32_3 %260 = OpLoad %259 
					                                       f32_3 %261 = OpFMul %257 %260 
					                                       f32_4 %262 = OpLoad %24 
					                                       f32_4 %263 = OpVectorShuffle %262 %261 4 5 6 3 
					                                                      OpStore %24 %263 
					                                       f32_4 %268 = OpLoad %24 
					                                       f32_3 %269 = OpVectorShuffle %268 %268 0 1 2 
					                                         f32 %270 = OpDot %267 %269 
					                                Private f32* %271 = OpAccessChain %38 %21 
					                                                      OpStore %271 %270 
					                                       f32_4 %276 = OpLoad %24 
					                                       f32_3 %277 = OpVectorShuffle %276 %276 0 1 2 
					                                         f32 %278 = OpDot %275 %277 
					                                Private f32* %279 = OpAccessChain %38 %17 
					                                                      OpStore %279 %278 
					                                       f32_4 %284 = OpLoad %24 
					                                       f32_3 %285 = OpVectorShuffle %284 %284 0 1 2 
					                                         f32 %286 = OpDot %283 %285 
					                                Private f32* %287 = OpAccessChain %38 %114 
					                                                      OpStore %287 %286 
					                                       f32_4 %288 = OpLoad %38 
					                                       f32_3 %289 = OpVectorShuffle %288 %288 0 1 2 
					                              Uniform f32_3* %291 = OpAccessChain %13 %290 
					                                       f32_3 %292 = OpLoad %291 
					                                       f32_3 %293 = OpFMul %289 %292 
					                                       f32_4 %294 = OpLoad %24 
					                                       f32_4 %295 = OpVectorShuffle %294 %293 4 5 6 3 
					                                                      OpStore %24 %295 
					                                       f32_4 %296 = OpLoad %24 
					                                       f32_3 %297 = OpVectorShuffle %296 %296 0 1 2 
					                              Uniform f32_3* %299 = OpAccessChain %13 %298 
					                                       f32_3 %300 = OpLoad %299 
					                                         f32 %301 = OpDot %297 %300 
					                                Private f32* %302 = OpAccessChain %38 %21 
					                                                      OpStore %302 %301 
					                                       f32_4 %303 = OpLoad %24 
					                                       f32_3 %304 = OpVectorShuffle %303 %303 0 1 2 
					                              Uniform f32_3* %306 = OpAccessChain %13 %305 
					                                       f32_3 %307 = OpLoad %306 
					                                         f32 %308 = OpDot %304 %307 
					                                Private f32* %309 = OpAccessChain %38 %17 
					                                                      OpStore %309 %308 
					                                       f32_4 %310 = OpLoad %24 
					                                       f32_3 %311 = OpVectorShuffle %310 %310 0 1 2 
					                              Uniform f32_3* %313 = OpAccessChain %13 %312 
					                                       f32_3 %314 = OpLoad %313 
					                                         f32 %315 = OpDot %311 %314 
					                                Private f32* %316 = OpAccessChain %38 %114 
					                                                      OpStore %316 %315 
					                                       f32_4 %317 = OpLoad %38 
					                                       f32_3 %318 = OpVectorShuffle %317 %317 0 1 2 
					                              Uniform f32_3* %320 = OpAccessChain %13 %319 
					                                       f32_3 %321 = OpLoad %320 
					                                       f32_3 %322 = OpFMul %318 %321 
					                              Uniform f32_3* %324 = OpAccessChain %13 %323 
					                                       f32_3 %325 = OpLoad %324 
					                                       f32_3 %326 = OpFAdd %322 %325 
					                                       f32_4 %327 = OpLoad %24 
					                                       f32_4 %328 = OpVectorShuffle %327 %326 4 5 6 3 
					                                                      OpStore %24 %328 
					                                       f32_4 %329 = OpLoad %24 
					                                       f32_3 %330 = OpVectorShuffle %329 %329 0 1 2 
					                                       f32_3 %331 = OpExtInst %1 4 %330 
					                                       f32_3 %332 = OpExtInst %1 30 %331 
					                                       f32_4 %333 = OpLoad %38 
					                                       f32_4 %334 = OpVectorShuffle %333 %332 4 5 6 3 
					                                                      OpStore %38 %334 
					                                       f32_4 %335 = OpLoad %24 
					                                       f32_3 %336 = OpVectorShuffle %335 %335 0 1 2 
					                                       f32_3 %339 = OpFMul %336 %338 
					                                       f32_3 %341 = OpFAdd %339 %340 
					                                       f32_4 %342 = OpLoad %24 
					                                       f32_4 %343 = OpVectorShuffle %342 %341 4 5 6 3 
					                                                      OpStore %24 %343 
					                                       f32_4 %344 = OpLoad %24 
					                                       f32_3 %345 = OpVectorShuffle %344 %344 0 1 2 
					                                       f32_3 %347 = OpCompositeConstruct %125 %125 %125 
					                                       f32_3 %348 = OpCompositeConstruct %346 %346 %346 
					                                       f32_3 %349 = OpExtInst %1 43 %345 %347 %348 
					                                       f32_4 %350 = OpLoad %24 
					                                       f32_4 %351 = OpVectorShuffle %350 %349 4 5 6 3 
					                                                      OpStore %24 %351 
					                                       f32_4 %352 = OpLoad %24 
					                                       f32_3 %353 = OpVectorShuffle %352 %352 0 1 2 
					                                       f32_3 %356 = OpFMul %353 %355 
					                                       f32_3 %359 = OpFAdd %356 %358 
					                                       f32_4 %360 = OpLoad %24 
					                                       f32_4 %361 = OpVectorShuffle %360 %359 4 5 6 3 
					                                                      OpStore %24 %361 
					                                       f32_4 %362 = OpLoad %38 
					                                       f32_3 %363 = OpVectorShuffle %362 %362 0 1 2 
					                              Uniform f32_3* %365 = OpAccessChain %13 %364 
					                                       f32_3 %366 = OpLoad %365 
					                                       f32_3 %367 = OpFMul %363 %366 
					                                       f32_4 %368 = OpLoad %38 
					                                       f32_4 %369 = OpVectorShuffle %368 %367 4 5 6 3 
					                                                      OpStore %38 %369 
					                                       f32_4 %370 = OpLoad %38 
					                                       f32_3 %371 = OpVectorShuffle %370 %370 0 1 2 
					                                       f32_3 %372 = OpExtInst %1 29 %371 
					                                       f32_4 %373 = OpLoad %38 
					                                       f32_4 %374 = OpVectorShuffle %373 %372 4 5 6 3 
					                                                      OpStore %38 %374 
					                                       f32_4 %375 = OpLoad %24 
					                                       f32_3 %376 = OpVectorShuffle %375 %375 0 1 2 
					                                       f32_4 %377 = OpLoad %38 
					                                       f32_3 %378 = OpVectorShuffle %377 %377 0 1 2 
					                                       f32_3 %379 = OpFMul %376 %378 
					                                       f32_4 %380 = OpLoad %24 
					                                       f32_4 %381 = OpVectorShuffle %380 %379 4 5 6 3 
					                                                      OpStore %24 %381 
					                                       f32_4 %382 = OpLoad %24 
					                                       f32_3 %383 = OpVectorShuffle %382 %382 0 1 2 
					                                       f32_3 %385 = OpExtInst %1 40 %383 %384 
					                                       f32_4 %386 = OpLoad %24 
					                                       f32_4 %387 = OpVectorShuffle %386 %385 4 5 6 3 
					                                                      OpStore %24 %387 
					                                Private f32* %391 = OpAccessChain %24 %17 
					                                         f32 %392 = OpLoad %391 
					                                Private f32* %393 = OpAccessChain %24 %114 
					                                         f32 %394 = OpLoad %393 
					                                        bool %395 = OpFOrdGreaterThanEqual %392 %394 
					                                                      OpStore %390 %395 
					                                        bool %396 = OpLoad %390 
					                                         f32 %397 = OpSelect %396 %346 %125 
					                                Private f32* %398 = OpAccessChain %9 %21 
					                                                      OpStore %398 %397 
					                                       f32_4 %399 = OpLoad %24 
					                                       f32_2 %400 = OpVectorShuffle %399 %399 2 1 
					                                       f32_4 %401 = OpLoad %38 
					                                       f32_4 %402 = OpVectorShuffle %401 %400 4 5 2 3 
					                                                      OpStore %38 %402 
					                                       f32_4 %403 = OpLoad %24 
					                                       f32_2 %404 = OpVectorShuffle %403 %403 1 2 
					                                       f32_4 %405 = OpLoad %38 
					                                       f32_2 %406 = OpVectorShuffle %405 %405 0 1 
					                                       f32_2 %407 = OpFNegate %406 
					                                       f32_2 %408 = OpFAdd %404 %407 
					                                       f32_4 %409 = OpLoad %71 
					                                       f32_4 %410 = OpVectorShuffle %409 %408 4 5 2 3 
					                                                      OpStore %71 %410 
					                                Private f32* %411 = OpAccessChain %38 %114 
					                                                      OpStore %411 %357 
					                                Private f32* %413 = OpAccessChain %38 %61 
					                                                      OpStore %413 %412 
					                                Private f32* %414 = OpAccessChain %71 %114 
					                                                      OpStore %414 %346 
					                                Private f32* %415 = OpAccessChain %71 %61 
					                                                      OpStore %415 %357 
					                                       f32_4 %416 = OpLoad %9 
					                                       f32_4 %417 = OpVectorShuffle %416 %416 0 0 0 0 
					                                       f32_4 %418 = OpLoad %71 
					                                       f32_4 %419 = OpVectorShuffle %418 %418 0 1 3 2 
					                                       f32_4 %420 = OpFMul %417 %419 
					                                       f32_4 %421 = OpLoad %38 
					                                       f32_4 %422 = OpVectorShuffle %421 %421 0 1 3 2 
					                                       f32_4 %423 = OpFAdd %420 %422 
					                                                      OpStore %38 %423 
					                                Private f32* %424 = OpAccessChain %24 %21 
					                                         f32 %425 = OpLoad %424 
					                                Private f32* %426 = OpAccessChain %38 %21 
					                                         f32 %427 = OpLoad %426 
					                                        bool %428 = OpFOrdGreaterThanEqual %425 %427 
					                                                      OpStore %390 %428 
					                                        bool %429 = OpLoad %390 
					                                         f32 %430 = OpSelect %429 %346 %125 
					                                Private f32* %431 = OpAccessChain %9 %21 
					                                                      OpStore %431 %430 
					                                Private f32* %432 = OpAccessChain %38 %61 
					                                         f32 %433 = OpLoad %432 
					                                Private f32* %434 = OpAccessChain %71 %114 
					                                                      OpStore %434 %433 
					                                Private f32* %435 = OpAccessChain %24 %21 
					                                         f32 %436 = OpLoad %435 
					                                Private f32* %437 = OpAccessChain %38 %61 
					                                                      OpStore %437 %436 
					                                       f32_4 %439 = OpLoad %24 
					                                       f32_3 %440 = OpVectorShuffle %439 %439 0 1 2 
					                                         f32 %445 = OpDot %440 %444 
					                                Private f32* %446 = OpAccessChain %438 %21 
					                                                      OpStore %446 %445 
					                                       f32_4 %447 = OpLoad %38 
					                                       f32_3 %448 = OpVectorShuffle %447 %447 3 1 0 
					                                       f32_4 %449 = OpLoad %71 
					                                       f32_4 %450 = OpVectorShuffle %449 %448 4 5 2 6 
					                                                      OpStore %71 %450 
					                                       f32_4 %451 = OpLoad %38 
					                                       f32_4 %452 = OpFNegate %451 
					                                       f32_4 %453 = OpLoad %71 
					                                       f32_4 %454 = OpFAdd %452 %453 
					                                                      OpStore %71 %454 
					                                       f32_4 %455 = OpLoad %9 
					                                       f32_4 %456 = OpVectorShuffle %455 %455 0 0 0 0 
					                                       f32_4 %457 = OpLoad %71 
					                                       f32_4 %458 = OpFMul %456 %457 
					                                       f32_4 %459 = OpLoad %38 
					                                       f32_4 %460 = OpFAdd %458 %459 
					                                                      OpStore %38 %460 
					                                Private f32* %461 = OpAccessChain %38 %17 
					                                         f32 %462 = OpLoad %461 
					                                Private f32* %463 = OpAccessChain %38 %61 
					                                         f32 %464 = OpLoad %463 
					                                         f32 %465 = OpExtInst %1 37 %462 %464 
					                                Private f32* %466 = OpAccessChain %9 %21 
					                                                      OpStore %466 %465 
					                                Private f32* %467 = OpAccessChain %9 %21 
					                                         f32 %468 = OpLoad %467 
					                                         f32 %469 = OpFNegate %468 
					                                Private f32* %470 = OpAccessChain %38 %21 
					                                         f32 %471 = OpLoad %470 
					                                         f32 %472 = OpFAdd %469 %471 
					                                Private f32* %473 = OpAccessChain %9 %21 
					                                                      OpStore %473 %472 
					                                Private f32* %475 = OpAccessChain %9 %21 
					                                         f32 %476 = OpLoad %475 
					                                         f32 %478 = OpFMul %476 %477 
					                                         f32 %480 = OpFAdd %478 %479 
					                                Private f32* %481 = OpAccessChain %474 %21 
					                                                      OpStore %481 %480 
					                                Private f32* %483 = OpAccessChain %38 %17 
					                                         f32 %484 = OpLoad %483 
					                                         f32 %485 = OpFNegate %484 
					                                Private f32* %486 = OpAccessChain %38 %61 
					                                         f32 %487 = OpLoad %486 
					                                         f32 %488 = OpFAdd %485 %487 
					                                                      OpStore %482 %488 
					                                         f32 %489 = OpLoad %482 
					                                Private f32* %490 = OpAccessChain %474 %21 
					                                         f32 %491 = OpLoad %490 
					                                         f32 %492 = OpFDiv %489 %491 
					                                Private f32* %493 = OpAccessChain %474 %21 
					                                                      OpStore %493 %492 
					                                Private f32* %494 = OpAccessChain %474 %21 
					                                         f32 %495 = OpLoad %494 
					                                Private f32* %496 = OpAccessChain %38 %114 
					                                         f32 %497 = OpLoad %496 
					                                         f32 %498 = OpFAdd %495 %497 
					                                Private f32* %499 = OpAccessChain %474 %21 
					                                                      OpStore %499 %498 
					                                Private f32* %500 = OpAccessChain %474 %21 
					                                         f32 %501 = OpLoad %500 
					                                         f32 %502 = OpExtInst %1 4 %501 
					                                Private f32* %503 = OpAccessChain %127 %21 
					                                                      OpStore %503 %502 
					                         read_only Texture2D %505 = OpLoad %504 
					                                     sampler %507 = OpLoad %506 
					                  read_only Texture2DSampled %508 = OpSampledImage %505 %507 
					                                       f32_2 %509 = OpLoad %127 
					                                       f32_4 %510 = OpImageSampleExplicitLod %508 %509 Lod %7 
					                                         f32 %511 = OpCompositeExtract %510 1 
					                                Private f32* %512 = OpAccessChain %474 %21 
					                                                      OpStore %512 %511 
					                                Private f32* %513 = OpAccessChain %127 %21 
					                                         f32 %514 = OpLoad %513 
					                                Uniform f32* %515 = OpAccessChain %13 %221 %21 
					                                         f32 %516 = OpLoad %515 
					                                         f32 %517 = OpFAdd %514 %516 
					                                Private f32* %518 = OpAccessChain %71 %21 
					                                                      OpStore %518 %517 
					                                Private f32* %519 = OpAccessChain %474 %21 
					                                         f32 %520 = OpLoad %519 
					                                Private f32* %521 = OpAccessChain %474 %21 
					                                                      OpStore %521 %520 
					                                Private f32* %522 = OpAccessChain %474 %21 
					                                         f32 %523 = OpLoad %522 
					                                         f32 %524 = OpExtInst %1 43 %523 %125 %346 
					                                Private f32* %525 = OpAccessChain %474 %21 
					                                                      OpStore %525 %524 
					                                Private f32* %526 = OpAccessChain %474 %21 
					                                         f32 %527 = OpLoad %526 
					                                Private f32* %528 = OpAccessChain %474 %21 
					                                         f32 %529 = OpLoad %528 
					                                         f32 %530 = OpFAdd %527 %529 
					                                Private f32* %531 = OpAccessChain %474 %21 
					                                                      OpStore %531 %530 
					                                Private f32* %532 = OpAccessChain %38 %21 
					                                         f32 %533 = OpLoad %532 
					                                         f32 %534 = OpFAdd %533 %479 
					                                Private f32* %535 = OpAccessChain %127 %21 
					                                                      OpStore %535 %534 
					                                Private f32* %536 = OpAccessChain %9 %21 
					                                         f32 %537 = OpLoad %536 
					                                Private f32* %538 = OpAccessChain %127 %21 
					                                         f32 %539 = OpLoad %538 
					                                         f32 %540 = OpFDiv %537 %539 
					                                Private f32* %541 = OpAccessChain %24 %21 
					                                                      OpStore %541 %540 
					                                Private f32* %542 = OpAccessChain %24 %17 
					                                                      OpStore %542 %128 
					                                Private f32* %543 = OpAccessChain %438 %17 
					                                                      OpStore %543 %128 
					                         read_only Texture2D %544 = OpLoad %504 
					                                     sampler %545 = OpLoad %506 
					                  read_only Texture2DSampled %546 = OpSampledImage %544 %545 
					                                       f32_4 %547 = OpLoad %24 
					                                       f32_2 %548 = OpVectorShuffle %547 %547 0 1 
					                                       f32_4 %549 = OpImageSampleExplicitLod %546 %548 Lod %7 
					                                         f32 %550 = OpCompositeExtract %549 2 
					                                Private f32* %551 = OpAccessChain %9 %21 
					                                                      OpStore %551 %550 
					                         read_only Texture2D %552 = OpLoad %504 
					                                     sampler %553 = OpLoad %506 
					                  read_only Texture2DSampled %554 = OpSampledImage %552 %553 
					                                       f32_2 %555 = OpLoad %438 
					                                       f32_4 %556 = OpImageSampleExplicitLod %554 %555 Lod %7 
					                                         f32 %557 = OpCompositeExtract %556 3 
					                                Private f32* %558 = OpAccessChain %9 %114 
					                                                      OpStore %558 %557 
					                                       f32_4 %559 = OpLoad %9 
					                                       f32_2 %560 = OpVectorShuffle %559 %559 0 2 
					                                       f32_4 %561 = OpLoad %9 
					                                       f32_4 %562 = OpVectorShuffle %561 %560 4 1 5 3 
					                                                      OpStore %9 %562 
					                                       f32_4 %563 = OpLoad %9 
					                                       f32_2 %564 = OpVectorShuffle %563 %563 0 2 
					                                       f32_2 %565 = OpCompositeConstruct %125 %125 
					                                       f32_2 %566 = OpCompositeConstruct %346 %346 
					                                       f32_2 %567 = OpExtInst %1 43 %564 %565 %566 
					                                       f32_4 %568 = OpLoad %9 
					                                       f32_4 %569 = OpVectorShuffle %568 %567 4 1 5 3 
					                                                      OpStore %9 %569 
					                                       f32_4 %570 = OpLoad %9 
					                                       f32_2 %571 = OpVectorShuffle %570 %570 0 0 
					                                       f32_3 %572 = OpLoad %474 
					                                       f32_2 %573 = OpVectorShuffle %572 %572 0 0 
					                                         f32 %574 = OpDot %571 %573 
					                                Private f32* %575 = OpAccessChain %9 %21 
					                                                      OpStore %575 %574 
					                                Private f32* %576 = OpAccessChain %9 %21 
					                                         f32 %577 = OpLoad %576 
					                                Private f32* %578 = OpAccessChain %9 %114 
					                                         f32 %579 = OpLoad %578 
					                                         f32 %580 = OpFMul %577 %579 
					                                Private f32* %581 = OpAccessChain %9 %21 
					                                                      OpStore %581 %580 
					                              Uniform f32_3* %582 = OpAccessChain %13 %221 
					                                       f32_3 %583 = OpLoad %582 
					                                       f32_2 %584 = OpVectorShuffle %583 %583 1 1 
					                                       f32_4 %585 = OpLoad %9 
					                                       f32_2 %586 = OpVectorShuffle %585 %585 0 0 
					                                         f32 %587 = OpDot %584 %586 
					                                Private f32* %588 = OpAccessChain %9 %21 
					                                                      OpStore %588 %587 
					                                Private f32* %589 = OpAccessChain %71 %17 
					                                                      OpStore %589 %128 
					                         read_only Texture2D %590 = OpLoad %504 
					                                     sampler %591 = OpLoad %506 
					                  read_only Texture2DSampled %592 = OpSampledImage %590 %591 
					                                       f32_4 %593 = OpLoad %71 
					                                       f32_2 %594 = OpVectorShuffle %593 %593 0 1 
					                                       f32_4 %595 = OpImageSampleExplicitLod %592 %594 Lod %7 
					                                         f32 %596 = OpCompositeExtract %595 0 
					                                Private f32* %597 = OpAccessChain %474 %21 
					                                                      OpStore %597 %596 
					                                Private f32* %598 = OpAccessChain %474 %21 
					                                         f32 %599 = OpLoad %598 
					                                Private f32* %600 = OpAccessChain %474 %21 
					                                                      OpStore %600 %599 
					                                Private f32* %601 = OpAccessChain %474 %21 
					                                         f32 %602 = OpLoad %601 
					                                         f32 %603 = OpExtInst %1 43 %602 %125 %346 
					                                Private f32* %604 = OpAccessChain %474 %21 
					                                                      OpStore %604 %603 
					                                Private f32* %605 = OpAccessChain %71 %21 
					                                         f32 %606 = OpLoad %605 
					                                Private f32* %607 = OpAccessChain %474 %21 
					                                         f32 %608 = OpLoad %607 
					                                         f32 %609 = OpFAdd %606 %608 
					                                Private f32* %610 = OpAccessChain %474 %21 
					                                                      OpStore %610 %609 
					                                       f32_3 %611 = OpLoad %474 
					                                       f32_3 %612 = OpVectorShuffle %611 %611 0 0 0 
					                                       f32_3 %616 = OpFAdd %612 %615 
					                                                      OpStore %474 %616 
					                                Private f32* %618 = OpAccessChain %474 %21 
					                                         f32 %619 = OpLoad %618 
					                                        bool %620 = OpFOrdLessThan %346 %619 
					                                                      OpStore %617 %620 
					                                        bool %622 = OpLoad %617 
					                                                      OpSelectionMerge %626 None 
					                                                      OpBranchConditional %622 %625 %629 
					                                             %625 = OpLabel 
					                                Private f32* %627 = OpAccessChain %474 %114 
					                                         f32 %628 = OpLoad %627 
					                                                      OpStore %624 %628 
					                                                      OpBranch %626 
					                                             %629 = OpLabel 
					                                Private f32* %630 = OpAccessChain %474 %21 
					                                         f32 %631 = OpLoad %630 
					                                                      OpStore %624 %631 
					                                                      OpBranch %626 
					                                             %626 = OpLabel 
					                                         f32 %632 = OpLoad %624 
					                                                      OpStore %621 %632 
					                                Private f32* %634 = OpAccessChain %474 %21 
					                                         f32 %635 = OpLoad %634 
					                                        bool %636 = OpFOrdLessThan %635 %125 
					                                                      OpStore %633 %636 
					                                        bool %637 = OpLoad %633 
					                                                      OpSelectionMerge %640 None 
					                                                      OpBranchConditional %637 %639 %643 
					                                             %639 = OpLabel 
					                                Private f32* %641 = OpAccessChain %474 %17 
					                                         f32 %642 = OpLoad %641 
					                                                      OpStore %638 %642 
					                                                      OpBranch %640 
					                                             %643 = OpLabel 
					                                         f32 %644 = OpLoad %621 
					                                                      OpStore %638 %644 
					                                                      OpBranch %640 
					                                             %640 = OpLabel 
					                                         f32 %645 = OpLoad %638 
					                                Private f32* %646 = OpAccessChain %474 %21 
					                                                      OpStore %646 %645 
					                                       f32_3 %647 = OpLoad %474 
					                                       f32_3 %648 = OpVectorShuffle %647 %647 0 0 0 
					                                       f32_3 %651 = OpFAdd %648 %650 
					                                                      OpStore %474 %651 
					                                       f32_3 %652 = OpLoad %474 
					                                       f32_3 %653 = OpExtInst %1 10 %652 
					                                                      OpStore %474 %653 
					                                       f32_3 %654 = OpLoad %474 
					                                       f32_3 %656 = OpFMul %654 %655 
					                                       f32_3 %659 = OpFAdd %656 %658 
					                                                      OpStore %474 %659 
					                                       f32_3 %660 = OpLoad %474 
					                                       f32_3 %661 = OpExtInst %1 4 %660 
					                                       f32_3 %662 = OpFAdd %661 %358 
					                                                      OpStore %474 %662 
					                                       f32_3 %663 = OpLoad %474 
					                                       f32_3 %664 = OpCompositeConstruct %125 %125 %125 
					                                       f32_3 %665 = OpCompositeConstruct %346 %346 %346 
					                                       f32_3 %666 = OpExtInst %1 43 %663 %664 %665 
					                                                      OpStore %474 %666 
					                                       f32_3 %667 = OpLoad %474 
					                                       f32_3 %668 = OpFAdd %667 %358 
					                                                      OpStore %474 %668 
					                                       f32_4 %669 = OpLoad %24 
					                                       f32_3 %670 = OpVectorShuffle %669 %669 0 0 0 
					                                       f32_3 %671 = OpLoad %474 
					                                       f32_3 %672 = OpFMul %670 %671 
					                                       f32_3 %674 = OpFAdd %672 %673 
					                                                      OpStore %474 %674 
					                                       f32_3 %675 = OpLoad %474 
					                                       f32_4 %676 = OpLoad %38 
					                                       f32_3 %677 = OpVectorShuffle %676 %676 0 0 0 
					                                       f32_3 %678 = OpFMul %675 %677 
					                                       f32_4 %679 = OpLoad %24 
					                                       f32_4 %680 = OpVectorShuffle %679 %678 4 5 6 3 
					                                                      OpStore %24 %680 
					                                       f32_4 %681 = OpLoad %24 
					                                       f32_3 %682 = OpVectorShuffle %681 %681 0 1 2 
					                                         f32 %683 = OpDot %682 %444 
					                                Private f32* %684 = OpAccessChain %24 %21 
					                                                      OpStore %684 %683 
					                                       f32_4 %685 = OpLoad %38 
					                                       f32_3 %686 = OpVectorShuffle %685 %685 0 0 0 
					                                       f32_3 %687 = OpLoad %474 
					                                       f32_3 %688 = OpFMul %686 %687 
					                                       f32_4 %689 = OpLoad %24 
					                                       f32_3 %690 = OpVectorShuffle %689 %689 0 0 0 
					                                       f32_3 %691 = OpFNegate %690 
					                                       f32_3 %692 = OpFAdd %688 %691 
					                                                      OpStore %474 %692 
					                                       f32_4 %693 = OpLoad %9 
					                                       f32_3 %694 = OpVectorShuffle %693 %693 0 0 0 
					                                       f32_3 %695 = OpLoad %474 
					                                       f32_3 %696 = OpFMul %694 %695 
					                                       f32_4 %697 = OpLoad %24 
					                                       f32_3 %698 = OpVectorShuffle %697 %697 0 0 0 
					                                       f32_3 %699 = OpFAdd %696 %698 
					                                       f32_4 %700 = OpLoad %9 
					                                       f32_4 %701 = OpVectorShuffle %700 %699 4 5 6 3 
					                                                      OpStore %9 %701 
					                                       f32_4 %702 = OpLoad %9 
					                                       f32_3 %703 = OpVectorShuffle %702 %702 0 1 2 
					                                       f32_3 %704 = OpCompositeConstruct %125 %125 %125 
					                                       f32_3 %705 = OpCompositeConstruct %346 %346 %346 
					                                       f32_3 %706 = OpExtInst %1 43 %703 %704 %705 
					                                       f32_4 %707 = OpLoad %9 
					                                       f32_4 %708 = OpVectorShuffle %707 %706 4 5 6 3 
					                                                      OpStore %9 %708 
					                                       f32_4 %709 = OpLoad %9 
					                                       f32_3 %710 = OpVectorShuffle %709 %709 0 1 2 
					                                       f32_3 %713 = OpFAdd %710 %712 
					                                       f32_4 %714 = OpLoad %9 
					                                       f32_4 %715 = OpVectorShuffle %714 %713 4 5 6 3 
					                                                      OpStore %9 %715 
					                                Private f32* %717 = OpAccessChain %9 %61 
					                                                      OpStore %717 %716 
					                         read_only Texture2D %718 = OpLoad %504 
					                                     sampler %719 = OpLoad %506 
					                  read_only Texture2DSampled %720 = OpSampledImage %718 %719 
					                                       f32_4 %721 = OpLoad %9 
					                                       f32_2 %722 = OpVectorShuffle %721 %721 0 3 
					                                       f32_4 %723 = OpImageSampleImplicitLod %720 %722 
					                                         f32 %724 = OpCompositeExtract %723 3 
					                                Private f32* %725 = OpAccessChain %24 %21 
					                                                      OpStore %725 %724 
					                                Private f32* %726 = OpAccessChain %24 %21 
					                                         f32 %727 = OpLoad %726 
					                                Private f32* %728 = OpAccessChain %24 %21 
					                                                      OpStore %728 %727 
					                                Private f32* %729 = OpAccessChain %24 %21 
					                                         f32 %730 = OpLoad %729 
					                                         f32 %731 = OpExtInst %1 43 %730 %125 %346 
					                                Private f32* %732 = OpAccessChain %24 %21 
					                                                      OpStore %732 %731 
					                         read_only Texture2D %733 = OpLoad %504 
					                                     sampler %734 = OpLoad %506 
					                  read_only Texture2DSampled %735 = OpSampledImage %733 %734 
					                                       f32_4 %736 = OpLoad %9 
					                                       f32_2 %737 = OpVectorShuffle %736 %736 1 3 
					                                       f32_4 %738 = OpImageSampleImplicitLod %735 %737 
					                                         f32 %739 = OpCompositeExtract %738 3 
					                                Private f32* %740 = OpAccessChain %81 %21 
					                                                      OpStore %740 %739 
					                         read_only Texture2D %741 = OpLoad %504 
					                                     sampler %742 = OpLoad %506 
					                  read_only Texture2DSampled %743 = OpSampledImage %741 %742 
					                                       f32_4 %744 = OpLoad %9 
					                                       f32_2 %745 = OpVectorShuffle %744 %744 2 3 
					                                       f32_4 %746 = OpImageSampleImplicitLod %743 %745 
					                                         f32 %747 = OpCompositeExtract %746 3 
					                                Private f32* %748 = OpAccessChain %81 %17 
					                                                      OpStore %748 %747 
					                                       f32_2 %749 = OpLoad %81 
					                                       f32_4 %750 = OpLoad %24 
					                                       f32_4 %751 = OpVectorShuffle %750 %749 0 4 5 3 
					                                                      OpStore %24 %751 
					                                       f32_4 %752 = OpLoad %24 
					                                       f32_2 %753 = OpVectorShuffle %752 %752 1 2 
					                                       f32_2 %754 = OpCompositeConstruct %125 %125 
					                                       f32_2 %755 = OpCompositeConstruct %346 %346 
					                                       f32_2 %756 = OpExtInst %1 43 %753 %754 %755 
					                                       f32_4 %757 = OpLoad %24 
					                                       f32_4 %758 = OpVectorShuffle %757 %756 0 4 5 3 
					                                                      OpStore %24 %758 
					                                       f32_4 %759 = OpLoad %24 
					                                       f32_3 %760 = OpVectorShuffle %759 %759 0 1 2 
					                                       f32_3 %761 = OpFAdd %760 %712 
					                                       f32_4 %762 = OpLoad %9 
					                                       f32_4 %763 = OpVectorShuffle %762 %761 4 5 6 3 
					                                                      OpStore %9 %763 
					                                Private f32* %764 = OpAccessChain %9 %61 
					                                                      OpStore %764 %716 
					                         read_only Texture2D %765 = OpLoad %504 
					                                     sampler %766 = OpLoad %506 
					                  read_only Texture2DSampled %767 = OpSampledImage %765 %766 
					                                       f32_4 %768 = OpLoad %9 
					                                       f32_2 %769 = OpVectorShuffle %768 %768 0 3 
					                                       f32_4 %770 = OpImageSampleImplicitLod %767 %769 
					                                         f32 %771 = OpCompositeExtract %770 0 
					                                Private f32* %772 = OpAccessChain %9 %21 
					                                                      OpStore %772 %771 
					                                Private f32* %775 = OpAccessChain %9 %21 
					                                         f32 %776 = OpLoad %775 
					                                 Output f32* %778 = OpAccessChain %774 %21 
					                                                      OpStore %778 %776 
					                                 Output f32* %779 = OpAccessChain %774 %21 
					                                         f32 %780 = OpLoad %779 
					                                         f32 %781 = OpExtInst %1 43 %780 %125 %346 
					                                 Output f32* %782 = OpAccessChain %774 %21 
					                                                      OpStore %782 %781 
					                         read_only Texture2D %783 = OpLoad %504 
					                                     sampler %784 = OpLoad %506 
					                  read_only Texture2DSampled %785 = OpSampledImage %783 %784 
					                                       f32_4 %786 = OpLoad %9 
					                                       f32_2 %787 = OpVectorShuffle %786 %786 1 3 
					                                       f32_4 %788 = OpImageSampleImplicitLod %785 %787 
					                                         f32 %789 = OpCompositeExtract %788 1 
					                                Private f32* %790 = OpAccessChain %9 %21 
					                                                      OpStore %790 %789 
					                         read_only Texture2D %791 = OpLoad %504 
					                                     sampler %792 = OpLoad %506 
					                  read_only Texture2DSampled %793 = OpSampledImage %791 %792 
					                                       f32_4 %794 = OpLoad %9 
					                                       f32_2 %795 = OpVectorShuffle %794 %794 2 3 
					                                       f32_4 %796 = OpImageSampleImplicitLod %793 %795 
					                                         f32 %797 = OpCompositeExtract %796 2 
					                                Private f32* %798 = OpAccessChain %9 %17 
					                                                      OpStore %798 %797 
					                                       f32_4 %799 = OpLoad %9 
					                                       f32_2 %800 = OpVectorShuffle %799 %799 0 1 
					                                       f32_4 %801 = OpLoad %774 
					                                       f32_4 %802 = OpVectorShuffle %801 %800 0 4 5 3 
					                                                      OpStore %774 %802 
					                                       f32_4 %803 = OpLoad %774 
					                                       f32_2 %804 = OpVectorShuffle %803 %803 1 2 
					                                       f32_2 %805 = OpCompositeConstruct %125 %125 
					                                       f32_2 %806 = OpCompositeConstruct %346 %346 
					                                       f32_2 %807 = OpExtInst %1 43 %804 %805 %806 
					                                       f32_4 %808 = OpLoad %774 
					                                       f32_4 %809 = OpVectorShuffle %808 %807 0 4 5 3 
					                                                      OpStore %774 %809 
					                                 Output f32* %810 = OpAccessChain %774 %61 
					                                                      OpStore %810 %346 
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
						vec4 _Lut2D_Params;
						vec4 _UserLut2D_Params;
						vec3 _ColorBalance;
						vec3 _ColorFilter;
						vec3 _HueSatCon;
						float _Brightness;
						vec3 _ChannelMixerRed;
						vec3 _ChannelMixerGreen;
						vec3 _ChannelMixerBlue;
						vec3 _Lift;
						vec3 _InvGamma;
						vec3 _Gain;
						vec4 unused_0_13[7];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat8;
					vec2 u_xlat12;
					vec2 u_xlat13;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = _UserLut2D_Params.y;
					    u_xlat1.yz = vs_TEXCOORD1.xy + (-_Lut2D_Params.yz);
					    u_xlat2.x = u_xlat1.y * _Lut2D_Params.x;
					    u_xlat1.x = fract(u_xlat2.x);
					    u_xlat2.x = u_xlat1.x / _Lut2D_Params.x;
					    u_xlat1.w = u_xlat1.y + (-u_xlat2.x);
					    u_xlat2.xyz = u_xlat1.xzw * _Lut2D_Params.www;
					    u_xlat3.xyz = u_xlat2.zxy * _UserLut2D_Params.zzz;
					    u_xlat7 = floor(u_xlat3.x);
					    u_xlat3.xw = _UserLut2D_Params.xy * vec2(0.5, 0.5);
					    u_xlat3.yz = u_xlat3.yz * _UserLut2D_Params.xy + u_xlat3.xw;
					    u_xlat3.x = u_xlat7 * _UserLut2D_Params.y + u_xlat3.y;
					    u_xlat7 = u_xlat2.z * _UserLut2D_Params.z + (-u_xlat7);
					    u_xlat0.y = float(0.0);
					    u_xlat12.y = float(0.25);
					    u_xlat0.xy = u_xlat0.xy + u_xlat3.xz;
					    u_xlat3 = texture(_MainTex, u_xlat3.xz);
					    u_xlat4 = texture(_MainTex, u_xlat0.xy);
					    u_xlat4.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
					    u_xlat3.xyz = vec3(u_xlat7) * u_xlat4.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = (-u_xlat1.xzw) * _Lut2D_Params.www + u_xlat3.xyz;
					    u_xlat1.xyz = _UserLut2D_Params.www * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness)) + vec3(-0.217637643, -0.217637643, -0.217637643);
					    u_xlat1.xyz = u_xlat1.xyz * _HueSatCon.zzz + vec3(0.217637643, 0.217637643, 0.217637643);
					    u_xlat2.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat1.xyz);
					    u_xlat2.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat1.xyz);
					    u_xlat2.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat2.xyz * _ColorBalance.xyz;
					    u_xlat2.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat1.xyz);
					    u_xlat2.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat1.xyz);
					    u_xlat2.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat2.xyz * _ColorFilter.xyz;
					    u_xlat2.x = dot(u_xlat1.xyz, _ChannelMixerRed.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, _ChannelMixerGreen.xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, _ChannelMixerBlue.xyz);
					    u_xlat1.xyz = u_xlat2.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat2.xyz = log2(abs(u_xlat1.xyz));
					    u_xlat1.xyz = u_xlat1.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat2.xyz = u_xlat2.xyz * _InvGamma.xyz;
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb0 = u_xlat1.y>=u_xlat1.z;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat2.xy = u_xlat1.zy;
					    u_xlat3.xy = u_xlat1.yz + (-u_xlat2.xy);
					    u_xlat2.z = float(-1.0);
					    u_xlat2.w = float(0.666666687);
					    u_xlat3.z = float(1.0);
					    u_xlat3.w = float(-1.0);
					    u_xlat2 = u_xlat0.xxxx * u_xlat3.xywz + u_xlat2.xywz;
					    u_xlatb0 = u_xlat1.x>=u_xlat2.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat3.z = u_xlat2.w;
					    u_xlat2.w = u_xlat1.x;
					    u_xlat13.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat3.xyw = u_xlat2.wyx;
					    u_xlat3 = (-u_xlat2) + u_xlat3;
					    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
					    u_xlat0.x = min(u_xlat2.y, u_xlat2.w);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat6.x = u_xlat0.x * 6.0 + 9.99999975e-05;
					    u_xlat8 = (-u_xlat2.y) + u_xlat2.w;
					    u_xlat6.x = u_xlat8 / u_xlat6.x;
					    u_xlat6.x = u_xlat6.x + u_xlat2.z;
					    u_xlat12.x = abs(u_xlat6.x);
					    u_xlat3 = textureLod(_Curves, u_xlat12.xy, 0.0).yxzw;
					    u_xlat4.x = u_xlat12.x + _HueSatCon.x;
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat3.x + u_xlat3.x;
					    u_xlat12.x = u_xlat2.x + 9.99999975e-05;
					    u_xlat1.x = u_xlat0.x / u_xlat12.x;
					    u_xlat1.y = float(0.25);
					    u_xlat13.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat1.xy, 0.0).zxyw;
					    u_xlat5 = textureLod(_Curves, u_xlat13.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat3.xx, u_xlat6.xx);
					    u_xlat0.x = u_xlat0.x * u_xlat5.x;
					    u_xlat0.x = dot(_HueSatCon.yy, u_xlat0.xx);
					    u_xlat4.y = 0.25;
					    u_xlat3 = textureLod(_Curves, u_xlat4.xy, 0.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat4.x + u_xlat3.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = u_xlat1.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat2.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + u_xlat1.xxx;
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(0.00390625, 0.00390625, 0.00390625);
					    u_xlat0.w = 0.75;
					    u_xlat1 = texture(_Curves, u_xlat0.xw).wxyz;
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat2 = texture(_Curves, u_xlat0.yw);
					    u_xlat0 = texture(_Curves, u_xlat0.zw);
					    u_xlat1.z = u_xlat0.w;
					    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
					    u_xlat1.y = u_xlat2.w;
					    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat1.xyz + vec3(0.00390625, 0.00390625, 0.00390625);
					    u_xlat0.w = 0.75;
					    u_xlat1 = texture(_Curves, u_xlat0.xw);
					    SV_Target0.x = u_xlat1.x;
					    SV_Target0.x = clamp(SV_Target0.x, 0.0, 1.0);
					    u_xlat1 = texture(_Curves, u_xlat0.yw);
					    u_xlat0 = texture(_Curves, u_xlat0.zw);
					    SV_Target0.z = u_xlat0.z;
					    SV_Target0.z = clamp(SV_Target0.z, 0.0, 1.0);
					    SV_Target0.y = u_xlat1.y;
					    SV_Target0.y = clamp(SV_Target0.y, 0.0, 1.0);
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
			GpuProgramID 140334
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
						vec4 unused_0_2[19];
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
					uniform 	vec4 _Lut2D_Params;
					uniform 	vec3 _ColorBalance;
					uniform 	vec3 _ColorFilter;
					uniform 	vec3 _HueSatCon;
					uniform 	vec3 _ChannelMixerRed;
					uniform 	vec3 _ChannelMixerGreen;
					uniform 	vec3 _ChannelMixerBlue;
					uniform 	vec3 _Lift;
					uniform 	vec3 _InvGamma;
					uniform 	vec3 _Gain;
					UNITY_LOCATION(0) uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD0.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www + vec3(-0.413588405, -0.413588405, -0.413588405);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.0275523961, 0.0275523961, 0.0275523961);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(13.6054821, 13.6054821, 13.6054821);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0479959995, -0.0479959995, -0.0479959995);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.179999992, 0.179999992, 0.179999992);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7 = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat15.x + u_xlat4.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7 = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    SV_Target0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
					; Bound: 599
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %12 %590 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate vs_TEXCOORD0 Location 12 
					                                                      OpMemberDecorate %15 0 Offset 15 
					                                                      OpMemberDecorate %15 1 Offset 15 
					                                                      OpMemberDecorate %15 2 Offset 15 
					                                                      OpMemberDecorate %15 3 Offset 15 
					                                                      OpMemberDecorate %15 4 Offset 15 
					                                                      OpMemberDecorate %15 5 Offset 15 
					                                                      OpMemberDecorate %15 6 Offset 15 
					                                                      OpMemberDecorate %15 7 Offset 15 
					                                                      OpMemberDecorate %15 8 Offset 15 
					                                                      OpMemberDecorate %15 9 Offset 15 
					                                                      OpDecorate %15 Block 
					                                                      OpDecorate %17 DescriptorSet 17 
					                                                      OpDecorate %17 Binding 17 
					                                                      OpDecorate %399 DescriptorSet 399 
					                                                      OpDecorate %399 Binding 399 
					                                                      OpDecorate %403 DescriptorSet 403 
					                                                      OpDecorate %403 Binding 403 
					                                                      OpDecorate %590 Location 590 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 2 
					                                              %11 = OpTypePointer Input %10 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                              %14 = OpTypeVector %6 3 
					                                              %15 = OpTypeStruct %7 %14 %14 %14 %14 %14 %14 %14 %14 %14 
					                                              %16 = OpTypePointer Uniform %15 
					Uniform struct {f32_4; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3;}* %17 = OpVariable Uniform 
					                                              %18 = OpTypeInt 32 1 
					                                          i32 %19 = OpConstant 0 
					                                              %20 = OpTypePointer Uniform %7 
					                               Private f32_4* %28 = OpVariable Private 
					                                              %29 = OpTypeInt 32 0 
					                                          u32 %30 = OpConstant 1 
					                                              %31 = OpTypePointer Private %6 
					                                          u32 %34 = OpConstant 0 
					                                              %35 = OpTypePointer Uniform %6 
					                                          u32 %56 = OpConstant 3 
					                                          f32 %64 = OpConstant 3,674022E-40 
					                                        f32_3 %65 = OpConstantComposite %64 %64 %64 
					                                          i32 %71 = OpConstant 3 
					                                              %72 = OpTypePointer Uniform %14 
					                                          f32 %77 = OpConstant 3,674022E-40 
					                                        f32_3 %78 = OpConstantComposite %77 %77 %77 
					                                          f32 %84 = OpConstant 3,674022E-40 
					                                        f32_3 %85 = OpConstantComposite %84 %84 %84 
					                                          f32 %96 = OpConstant 3,674022E-40 
					                                        f32_3 %97 = OpConstantComposite %96 %96 %96 
					                                         f32 %103 = OpConstant 3,674022E-40 
					                                       f32_3 %104 = OpConstantComposite %103 %103 %103 
					                                         f32 %108 = OpConstant 3,674022E-40 
					                                         f32 %109 = OpConstant 3,674022E-40 
					                                         f32 %110 = OpConstant 3,674022E-40 
					                                       f32_3 %111 = OpConstantComposite %108 %109 %110 
					                                         f32 %116 = OpConstant 3,674022E-40 
					                                         f32 %117 = OpConstant 3,674022E-40 
					                                         f32 %118 = OpConstant 3,674022E-40 
					                                       f32_3 %119 = OpConstantComposite %116 %117 %118 
					                                         f32 %124 = OpConstant 3,674022E-40 
					                                         f32 %125 = OpConstant 3,674022E-40 
					                                         f32 %126 = OpConstant 3,674022E-40 
					                                       f32_3 %127 = OpConstantComposite %124 %125 %126 
					                                         u32 %131 = OpConstant 2 
					                                         i32 %135 = OpConstant 1 
					                                         f32 %141 = OpConstant 3,674022E-40 
					                                         f32 %142 = OpConstant 3,674022E-40 
					                                         f32 %143 = OpConstant 3,674022E-40 
					                                       f32_3 %144 = OpConstantComposite %141 %142 %143 
					                                         f32 %149 = OpConstant 3,674022E-40 
					                                         f32 %150 = OpConstant 3,674022E-40 
					                                         f32 %151 = OpConstant 3,674022E-40 
					                                       f32_3 %152 = OpConstantComposite %149 %150 %151 
					                                         f32 %157 = OpConstant 3,674022E-40 
					                                         f32 %158 = OpConstant 3,674022E-40 
					                                         f32 %159 = OpConstant 3,674022E-40 
					                                       f32_3 %160 = OpConstantComposite %157 %158 %159 
					                                         i32 %167 = OpConstant 2 
					                                         i32 %175 = OpConstant 4 
					                                         i32 %182 = OpConstant 5 
					                                         i32 %189 = OpConstant 6 
					                                         i32 %196 = OpConstant 9 
					                                         i32 %200 = OpConstant 7 
					                                         f32 %214 = OpConstant 3,674022E-40 
					                                       f32_3 %215 = OpConstantComposite %214 %214 %214 
					                                         f32 %217 = OpConstant 3,674022E-40 
					                                       f32_3 %218 = OpConstantComposite %217 %217 %217 
					                                         f32 %224 = OpConstant 3,674022E-40 
					                                         f32 %225 = OpConstant 3,674022E-40 
					                                         f32 %233 = OpConstant 3,674022E-40 
					                                       f32_3 %234 = OpConstantComposite %233 %233 %233 
					                                         f32 %236 = OpConstant 3,674022E-40 
					                                       f32_3 %237 = OpConstantComposite %236 %236 %236 
					                                         i32 %243 = OpConstant 8 
					                                       f32_3 %263 = OpConstantComposite %224 %224 %224 
					                                             %267 = OpTypeBool 
					                                             %268 = OpTypePointer Private %267 
					                               Private bool* %269 = OpVariable Private 
					                                Private f32* %275 = OpVariable Private 
					                              Private f32_4* %282 = OpVariable Private 
					                                         f32 %292 = OpConstant 3,674022E-40 
					                                             %317 = OpTypePointer Private %14 
					                              Private f32_3* %318 = OpVariable Private 
					                                         f32 %321 = OpConstant 3,674022E-40 
					                                         f32 %322 = OpConstant 3,674022E-40 
					                                         f32 %323 = OpConstant 3,674022E-40 
					                                       f32_3 %324 = OpConstantComposite %321 %322 %323 
					                              Private f32_3* %354 = OpVariable Private 
					                                         f32 %357 = OpConstant 3,674022E-40 
					                                         f32 %359 = OpConstant 3,674022E-40 
					                                             %362 = OpTypePointer Private %10 
					                              Private f32_2* %363 = OpVariable Private 
					                              Private f32_2* %387 = OpVariable Private 
					                                         f32 %394 = OpConstant 3,674022E-40 
					                                             %397 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                             %398 = OpTypePointer UniformConstant %397 
					        UniformConstant read_only Texture2D* %399 = OpVariable UniformConstant 
					                                             %401 = OpTypeSampler 
					                                             %402 = OpTypePointer UniformConstant %401 
					                    UniformConstant sampler* %403 = OpVariable UniformConstant 
					                                             %405 = OpTypeSampledImage %397 
					                                         f32 %432 = OpConstant 3,674022E-40 
					                                         f32 %433 = OpConstant 3,674022E-40 
					                                       f32_3 %434 = OpConstantComposite %432 %217 %433 
					                               Private bool* %436 = OpVariable Private 
					                                             %441 = OpTypePointer Function %6 
					                                         f32 %468 = OpConstant 3,674022E-40 
					                                       f32_3 %469 = OpConstantComposite %225 %292 %468 
					                                       f32_3 %474 = OpConstantComposite %357 %357 %357 
					                                         f32 %476 = OpConstant 3,674022E-40 
					                                       f32_3 %477 = OpConstantComposite %476 %476 %476 
					                              Private f32_2* %492 = OpVariable Private 
					                                       f32_3 %503 = OpConstantComposite %225 %225 %225 
					                                             %589 = OpTypePointer Output %7 
					                               Output f32_4* %590 = OpVariable Output 
					                                             %596 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                               Function f32* %442 = OpVariable Function 
					                               Function f32* %456 = OpVariable Function 
					                                        f32_2 %13 = OpLoad vs_TEXCOORD0 
					                               Uniform f32_4* %21 = OpAccessChain %17 %19 
					                                        f32_4 %22 = OpLoad %21 
					                                        f32_2 %23 = OpVectorShuffle %22 %22 1 2 
					                                        f32_2 %24 = OpFNegate %23 
					                                        f32_2 %25 = OpFAdd %13 %24 
					                                        f32_4 %26 = OpLoad %9 
					                                        f32_4 %27 = OpVectorShuffle %26 %25 0 4 5 3 
					                                                      OpStore %9 %27 
					                                 Private f32* %32 = OpAccessChain %9 %30 
					                                          f32 %33 = OpLoad %32 
					                                 Uniform f32* %36 = OpAccessChain %17 %19 %34 
					                                          f32 %37 = OpLoad %36 
					                                          f32 %38 = OpFMul %33 %37 
					                                 Private f32* %39 = OpAccessChain %28 %34 
					                                                      OpStore %39 %38 
					                                 Private f32* %40 = OpAccessChain %28 %34 
					                                          f32 %41 = OpLoad %40 
					                                          f32 %42 = OpExtInst %1 10 %41 
					                                 Private f32* %43 = OpAccessChain %9 %34 
					                                                      OpStore %43 %42 
					                                 Private f32* %44 = OpAccessChain %9 %34 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %46 = OpAccessChain %17 %19 %34 
					                                          f32 %47 = OpLoad %46 
					                                          f32 %48 = OpFDiv %45 %47 
					                                 Private f32* %49 = OpAccessChain %28 %34 
					                                                      OpStore %49 %48 
					                                 Private f32* %50 = OpAccessChain %9 %30 
					                                          f32 %51 = OpLoad %50 
					                                 Private f32* %52 = OpAccessChain %28 %34 
					                                          f32 %53 = OpLoad %52 
					                                          f32 %54 = OpFNegate %53 
					                                          f32 %55 = OpFAdd %51 %54 
					                                 Private f32* %57 = OpAccessChain %9 %56 
					                                                      OpStore %57 %55 
					                                        f32_4 %58 = OpLoad %9 
					                                        f32_3 %59 = OpVectorShuffle %58 %58 0 2 3 
					                               Uniform f32_4* %60 = OpAccessChain %17 %19 
					                                        f32_4 %61 = OpLoad %60 
					                                        f32_3 %62 = OpVectorShuffle %61 %61 3 3 3 
					                                        f32_3 %63 = OpFMul %59 %62 
					                                        f32_3 %66 = OpFAdd %63 %65 
					                                        f32_4 %67 = OpLoad %9 
					                                        f32_4 %68 = OpVectorShuffle %67 %66 4 5 6 3 
					                                                      OpStore %9 %68 
					                                        f32_4 %69 = OpLoad %9 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 0 1 2 
					                               Uniform f32_3* %73 = OpAccessChain %17 %71 
					                                        f32_3 %74 = OpLoad %73 
					                                        f32_3 %75 = OpVectorShuffle %74 %74 2 2 2 
					                                        f32_3 %76 = OpFMul %70 %75 
					                                        f32_3 %79 = OpFAdd %76 %78 
					                                        f32_4 %80 = OpLoad %9 
					                                        f32_4 %81 = OpVectorShuffle %80 %79 4 5 6 3 
					                                                      OpStore %9 %81 
					                                        f32_4 %82 = OpLoad %9 
					                                        f32_3 %83 = OpVectorShuffle %82 %82 0 1 2 
					                                        f32_3 %86 = OpFMul %83 %85 
					                                        f32_4 %87 = OpLoad %9 
					                                        f32_4 %88 = OpVectorShuffle %87 %86 4 5 6 3 
					                                                      OpStore %9 %88 
					                                        f32_4 %89 = OpLoad %9 
					                                        f32_3 %90 = OpVectorShuffle %89 %89 0 1 2 
					                                        f32_3 %91 = OpExtInst %1 29 %90 
					                                        f32_4 %92 = OpLoad %9 
					                                        f32_4 %93 = OpVectorShuffle %92 %91 4 5 6 3 
					                                                      OpStore %9 %93 
					                                        f32_4 %94 = OpLoad %9 
					                                        f32_3 %95 = OpVectorShuffle %94 %94 0 1 2 
					                                        f32_3 %98 = OpFAdd %95 %97 
					                                        f32_4 %99 = OpLoad %9 
					                                       f32_4 %100 = OpVectorShuffle %99 %98 4 5 6 3 
					                                                      OpStore %9 %100 
					                                       f32_4 %101 = OpLoad %9 
					                                       f32_3 %102 = OpVectorShuffle %101 %101 0 1 2 
					                                       f32_3 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %9 
					                                       f32_4 %107 = OpVectorShuffle %106 %105 4 5 6 3 
					                                                      OpStore %9 %107 
					                                       f32_4 %112 = OpLoad %9 
					                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
					                                         f32 %114 = OpDot %111 %113 
					                                Private f32* %115 = OpAccessChain %28 %34 
					                                                      OpStore %115 %114 
					                                       f32_4 %120 = OpLoad %9 
					                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                                         f32 %122 = OpDot %119 %121 
					                                Private f32* %123 = OpAccessChain %28 %30 
					                                                      OpStore %123 %122 
					                                       f32_4 %128 = OpLoad %9 
					                                       f32_3 %129 = OpVectorShuffle %128 %128 0 1 2 
					                                         f32 %130 = OpDot %127 %129 
					                                Private f32* %132 = OpAccessChain %28 %131 
					                                                      OpStore %132 %130 
					                                       f32_4 %133 = OpLoad %28 
					                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
					                              Uniform f32_3* %136 = OpAccessChain %17 %135 
					                                       f32_3 %137 = OpLoad %136 
					                                       f32_3 %138 = OpFMul %134 %137 
					                                       f32_4 %139 = OpLoad %9 
					                                       f32_4 %140 = OpVectorShuffle %139 %138 4 5 6 3 
					                                                      OpStore %9 %140 
					                                       f32_4 %145 = OpLoad %9 
					                                       f32_3 %146 = OpVectorShuffle %145 %145 0 1 2 
					                                         f32 %147 = OpDot %144 %146 
					                                Private f32* %148 = OpAccessChain %28 %34 
					                                                      OpStore %148 %147 
					                                       f32_4 %153 = OpLoad %9 
					                                       f32_3 %154 = OpVectorShuffle %153 %153 0 1 2 
					                                         f32 %155 = OpDot %152 %154 
					                                Private f32* %156 = OpAccessChain %28 %30 
					                                                      OpStore %156 %155 
					                                       f32_4 %161 = OpLoad %9 
					                                       f32_3 %162 = OpVectorShuffle %161 %161 0 1 2 
					                                         f32 %163 = OpDot %160 %162 
					                                Private f32* %164 = OpAccessChain %28 %131 
					                                                      OpStore %164 %163 
					                                       f32_4 %165 = OpLoad %28 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                              Uniform f32_3* %168 = OpAccessChain %17 %167 
					                                       f32_3 %169 = OpLoad %168 
					                                       f32_3 %170 = OpFMul %166 %169 
					                                       f32_4 %171 = OpLoad %9 
					                                       f32_4 %172 = OpVectorShuffle %171 %170 4 5 6 3 
					                                                      OpStore %9 %172 
					                                       f32_4 %173 = OpLoad %9 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                              Uniform f32_3* %176 = OpAccessChain %17 %175 
					                                       f32_3 %177 = OpLoad %176 
					                                         f32 %178 = OpDot %174 %177 
					                                Private f32* %179 = OpAccessChain %28 %34 
					                                                      OpStore %179 %178 
					                                       f32_4 %180 = OpLoad %9 
					                                       f32_3 %181 = OpVectorShuffle %180 %180 0 1 2 
					                              Uniform f32_3* %183 = OpAccessChain %17 %182 
					                                       f32_3 %184 = OpLoad %183 
					                                         f32 %185 = OpDot %181 %184 
					                                Private f32* %186 = OpAccessChain %28 %30 
					                                                      OpStore %186 %185 
					                                       f32_4 %187 = OpLoad %9 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                              Uniform f32_3* %190 = OpAccessChain %17 %189 
					                                       f32_3 %191 = OpLoad %190 
					                                         f32 %192 = OpDot %188 %191 
					                                Private f32* %193 = OpAccessChain %28 %131 
					                                                      OpStore %193 %192 
					                                       f32_4 %194 = OpLoad %28 
					                                       f32_3 %195 = OpVectorShuffle %194 %194 0 1 2 
					                              Uniform f32_3* %197 = OpAccessChain %17 %196 
					                                       f32_3 %198 = OpLoad %197 
					                                       f32_3 %199 = OpFMul %195 %198 
					                              Uniform f32_3* %201 = OpAccessChain %17 %200 
					                                       f32_3 %202 = OpLoad %201 
					                                       f32_3 %203 = OpFAdd %199 %202 
					                                       f32_4 %204 = OpLoad %9 
					                                       f32_4 %205 = OpVectorShuffle %204 %203 4 5 6 3 
					                                                      OpStore %9 %205 
					                                       f32_4 %206 = OpLoad %9 
					                                       f32_3 %207 = OpVectorShuffle %206 %206 0 1 2 
					                                       f32_3 %208 = OpExtInst %1 4 %207 
					                                       f32_3 %209 = OpExtInst %1 30 %208 
					                                       f32_4 %210 = OpLoad %28 
					                                       f32_4 %211 = OpVectorShuffle %210 %209 4 5 6 3 
					                                                      OpStore %28 %211 
					                                       f32_4 %212 = OpLoad %9 
					                                       f32_3 %213 = OpVectorShuffle %212 %212 0 1 2 
					                                       f32_3 %216 = OpFMul %213 %215 
					                                       f32_3 %219 = OpFAdd %216 %218 
					                                       f32_4 %220 = OpLoad %9 
					                                       f32_4 %221 = OpVectorShuffle %220 %219 4 5 6 3 
					                                                      OpStore %9 %221 
					                                       f32_4 %222 = OpLoad %9 
					                                       f32_3 %223 = OpVectorShuffle %222 %222 0 1 2 
					                                       f32_3 %226 = OpCompositeConstruct %224 %224 %224 
					                                       f32_3 %227 = OpCompositeConstruct %225 %225 %225 
					                                       f32_3 %228 = OpExtInst %1 43 %223 %226 %227 
					                                       f32_4 %229 = OpLoad %9 
					                                       f32_4 %230 = OpVectorShuffle %229 %228 4 5 6 3 
					                                                      OpStore %9 %230 
					                                       f32_4 %231 = OpLoad %9 
					                                       f32_3 %232 = OpVectorShuffle %231 %231 0 1 2 
					                                       f32_3 %235 = OpFMul %232 %234 
					                                       f32_3 %238 = OpFAdd %235 %237 
					                                       f32_4 %239 = OpLoad %9 
					                                       f32_4 %240 = OpVectorShuffle %239 %238 4 5 6 3 
					                                                      OpStore %9 %240 
					                                       f32_4 %241 = OpLoad %28 
					                                       f32_3 %242 = OpVectorShuffle %241 %241 0 1 2 
					                              Uniform f32_3* %244 = OpAccessChain %17 %243 
					                                       f32_3 %245 = OpLoad %244 
					                                       f32_3 %246 = OpFMul %242 %245 
					                                       f32_4 %247 = OpLoad %28 
					                                       f32_4 %248 = OpVectorShuffle %247 %246 4 5 6 3 
					                                                      OpStore %28 %248 
					                                       f32_4 %249 = OpLoad %28 
					                                       f32_3 %250 = OpVectorShuffle %249 %249 0 1 2 
					                                       f32_3 %251 = OpExtInst %1 29 %250 
					                                       f32_4 %252 = OpLoad %28 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 4 5 6 3 
					                                                      OpStore %28 %253 
					                                       f32_4 %254 = OpLoad %9 
					                                       f32_3 %255 = OpVectorShuffle %254 %254 0 1 2 
					                                       f32_4 %256 = OpLoad %28 
					                                       f32_3 %257 = OpVectorShuffle %256 %256 0 1 2 
					                                       f32_3 %258 = OpFMul %255 %257 
					                                       f32_4 %259 = OpLoad %9 
					                                       f32_4 %260 = OpVectorShuffle %259 %258 4 5 6 3 
					                                                      OpStore %9 %260 
					                                       f32_4 %261 = OpLoad %9 
					                                       f32_3 %262 = OpVectorShuffle %261 %261 0 1 2 
					                                       f32_3 %264 = OpExtInst %1 40 %262 %263 
					                                       f32_4 %265 = OpLoad %9 
					                                       f32_4 %266 = OpVectorShuffle %265 %264 4 5 6 3 
					                                                      OpStore %9 %266 
					                                Private f32* %270 = OpAccessChain %9 %30 
					                                         f32 %271 = OpLoad %270 
					                                Private f32* %272 = OpAccessChain %9 %131 
					                                         f32 %273 = OpLoad %272 
					                                        bool %274 = OpFOrdGreaterThanEqual %271 %273 
					                                                      OpStore %269 %274 
					                                        bool %276 = OpLoad %269 
					                                         f32 %277 = OpSelect %276 %225 %224 
					                                                      OpStore %275 %277 
					                                       f32_4 %278 = OpLoad %9 
					                                       f32_2 %279 = OpVectorShuffle %278 %278 2 1 
					                                       f32_4 %280 = OpLoad %28 
					                                       f32_4 %281 = OpVectorShuffle %280 %279 4 5 2 3 
					                                                      OpStore %28 %281 
					                                       f32_4 %283 = OpLoad %9 
					                                       f32_2 %284 = OpVectorShuffle %283 %283 1 2 
					                                       f32_4 %285 = OpLoad %28 
					                                       f32_2 %286 = OpVectorShuffle %285 %285 0 1 
					                                       f32_2 %287 = OpFNegate %286 
					                                       f32_2 %288 = OpFAdd %284 %287 
					                                       f32_4 %289 = OpLoad %282 
					                                       f32_4 %290 = OpVectorShuffle %289 %288 4 5 2 3 
					                                                      OpStore %282 %290 
					                                Private f32* %291 = OpAccessChain %28 %131 
					                                                      OpStore %291 %236 
					                                Private f32* %293 = OpAccessChain %28 %56 
					                                                      OpStore %293 %292 
					                                Private f32* %294 = OpAccessChain %282 %131 
					                                                      OpStore %294 %225 
					                                Private f32* %295 = OpAccessChain %282 %56 
					                                                      OpStore %295 %236 
					                                         f32 %296 = OpLoad %275 
					                                       f32_4 %297 = OpCompositeConstruct %296 %296 %296 %296 
					                                       f32_4 %298 = OpLoad %282 
					                                       f32_4 %299 = OpVectorShuffle %298 %298 0 1 3 2 
					                                       f32_4 %300 = OpFMul %297 %299 
					                                       f32_4 %301 = OpLoad %28 
					                                       f32_4 %302 = OpVectorShuffle %301 %301 0 1 3 2 
					                                       f32_4 %303 = OpFAdd %300 %302 
					                                                      OpStore %28 %303 
					                                Private f32* %304 = OpAccessChain %9 %34 
					                                         f32 %305 = OpLoad %304 
					                                Private f32* %306 = OpAccessChain %28 %34 
					                                         f32 %307 = OpLoad %306 
					                                        bool %308 = OpFOrdGreaterThanEqual %305 %307 
					                                                      OpStore %269 %308 
					                                        bool %309 = OpLoad %269 
					                                         f32 %310 = OpSelect %309 %225 %224 
					                                                      OpStore %275 %310 
					                                Private f32* %311 = OpAccessChain %28 %56 
					                                         f32 %312 = OpLoad %311 
					                                Private f32* %313 = OpAccessChain %282 %131 
					                                                      OpStore %313 %312 
					                                Private f32* %314 = OpAccessChain %9 %34 
					                                         f32 %315 = OpLoad %314 
					                                Private f32* %316 = OpAccessChain %28 %56 
					                                                      OpStore %316 %315 
					                                       f32_4 %319 = OpLoad %9 
					                                       f32_3 %320 = OpVectorShuffle %319 %319 0 1 2 
					                                         f32 %325 = OpDot %320 %324 
					                                Private f32* %326 = OpAccessChain %318 %34 
					                                                      OpStore %326 %325 
					                                       f32_4 %327 = OpLoad %28 
					                                       f32_3 %328 = OpVectorShuffle %327 %327 3 1 0 
					                                       f32_4 %329 = OpLoad %282 
					                                       f32_4 %330 = OpVectorShuffle %329 %328 4 5 2 6 
					                                                      OpStore %282 %330 
					                                       f32_4 %331 = OpLoad %28 
					                                       f32_4 %332 = OpFNegate %331 
					                                       f32_4 %333 = OpLoad %282 
					                                       f32_4 %334 = OpFAdd %332 %333 
					                                                      OpStore %282 %334 
					                                         f32 %335 = OpLoad %275 
					                                       f32_4 %336 = OpCompositeConstruct %335 %335 %335 %335 
					                                       f32_4 %337 = OpLoad %282 
					                                       f32_4 %338 = OpFMul %336 %337 
					                                       f32_4 %339 = OpLoad %28 
					                                       f32_4 %340 = OpFAdd %338 %339 
					                                                      OpStore %9 %340 
					                                Private f32* %341 = OpAccessChain %9 %30 
					                                         f32 %342 = OpLoad %341 
					                                Private f32* %343 = OpAccessChain %9 %56 
					                                         f32 %344 = OpLoad %343 
					                                         f32 %345 = OpExtInst %1 37 %342 %344 
					                                Private f32* %346 = OpAccessChain %28 %34 
					                                                      OpStore %346 %345 
					                                Private f32* %347 = OpAccessChain %9 %34 
					                                         f32 %348 = OpLoad %347 
					                                Private f32* %349 = OpAccessChain %28 %34 
					                                         f32 %350 = OpLoad %349 
					                                         f32 %351 = OpFNegate %350 
					                                         f32 %352 = OpFAdd %348 %351 
					                                Private f32* %353 = OpAccessChain %28 %34 
					                                                      OpStore %353 %352 
					                                Private f32* %355 = OpAccessChain %28 %34 
					                                         f32 %356 = OpLoad %355 
					                                         f32 %358 = OpFMul %356 %357 
					                                         f32 %360 = OpFAdd %358 %359 
					                                Private f32* %361 = OpAccessChain %354 %34 
					                                                      OpStore %361 %360 
					                                Private f32* %364 = OpAccessChain %9 %30 
					                                         f32 %365 = OpLoad %364 
					                                         f32 %366 = OpFNegate %365 
					                                Private f32* %367 = OpAccessChain %9 %56 
					                                         f32 %368 = OpLoad %367 
					                                         f32 %369 = OpFAdd %366 %368 
					                                Private f32* %370 = OpAccessChain %363 %34 
					                                                      OpStore %370 %369 
					                                Private f32* %371 = OpAccessChain %363 %34 
					                                         f32 %372 = OpLoad %371 
					                                Private f32* %373 = OpAccessChain %354 %34 
					                                         f32 %374 = OpLoad %373 
					                                         f32 %375 = OpFDiv %372 %374 
					                                Private f32* %376 = OpAccessChain %363 %34 
					                                                      OpStore %376 %375 
					                                Private f32* %377 = OpAccessChain %363 %34 
					                                         f32 %378 = OpLoad %377 
					                                Private f32* %379 = OpAccessChain %9 %131 
					                                         f32 %380 = OpLoad %379 
					                                         f32 %381 = OpFAdd %378 %380 
					                                Private f32* %382 = OpAccessChain %363 %34 
					                                                      OpStore %382 %381 
					                                Private f32* %383 = OpAccessChain %363 %34 
					                                         f32 %384 = OpLoad %383 
					                                         f32 %385 = OpExtInst %1 4 %384 
					                                Private f32* %386 = OpAccessChain %282 %34 
					                                                      OpStore %386 %385 
					                                Private f32* %388 = OpAccessChain %282 %34 
					                                         f32 %389 = OpLoad %388 
					                                Uniform f32* %390 = OpAccessChain %17 %71 %34 
					                                         f32 %391 = OpLoad %390 
					                                         f32 %392 = OpFAdd %389 %391 
					                                Private f32* %393 = OpAccessChain %387 %34 
					                                                      OpStore %393 %392 
					                                Private f32* %395 = OpAccessChain %318 %30 
					                                                      OpStore %395 %394 
					                                Private f32* %396 = OpAccessChain %387 %30 
					                                                      OpStore %396 %394 
					                         read_only Texture2D %400 = OpLoad %399 
					                                     sampler %404 = OpLoad %403 
					                  read_only Texture2DSampled %406 = OpSampledImage %400 %404 
					                                       f32_2 %407 = OpLoad %387 
					                                       f32_4 %408 = OpImageSampleExplicitLod %406 %407 Lod %7 
					                                         f32 %409 = OpCompositeExtract %408 0 
					                                Private f32* %410 = OpAccessChain %363 %34 
					                                                      OpStore %410 %409 
					                         read_only Texture2D %411 = OpLoad %399 
					                                     sampler %412 = OpLoad %403 
					                  read_only Texture2DSampled %413 = OpSampledImage %411 %412 
					                                       f32_3 %414 = OpLoad %318 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_4 %416 = OpImageSampleExplicitLod %413 %415 Lod %7 
					                                         f32 %417 = OpCompositeExtract %416 3 
					                                Private f32* %418 = OpAccessChain %363 %30 
					                                                      OpStore %418 %417 
					                                       f32_2 %419 = OpLoad %363 
					                                                      OpStore %363 %419 
					                                       f32_2 %420 = OpLoad %363 
					                                       f32_2 %421 = OpCompositeConstruct %224 %224 
					                                       f32_2 %422 = OpCompositeConstruct %225 %225 
					                                       f32_2 %423 = OpExtInst %1 43 %420 %421 %422 
					                                                      OpStore %363 %423 
					                                Private f32* %424 = OpAccessChain %387 %34 
					                                         f32 %425 = OpLoad %424 
					                                Private f32* %426 = OpAccessChain %363 %34 
					                                         f32 %427 = OpLoad %426 
					                                         f32 %428 = OpFAdd %425 %427 
					                                Private f32* %429 = OpAccessChain %363 %34 
					                                                      OpStore %429 %428 
					                                       f32_2 %430 = OpLoad %363 
					                                       f32_3 %431 = OpVectorShuffle %430 %430 0 0 0 
					                                       f32_3 %435 = OpFAdd %431 %434 
					                                                      OpStore %354 %435 
					                                Private f32* %437 = OpAccessChain %354 %34 
					                                         f32 %438 = OpLoad %437 
					                                        bool %439 = OpFOrdLessThan %225 %438 
					                                                      OpStore %436 %439 
					                                        bool %440 = OpLoad %436 
					                                                      OpSelectionMerge %444 None 
					                                                      OpBranchConditional %440 %443 %447 
					                                             %443 = OpLabel 
					                                Private f32* %445 = OpAccessChain %354 %131 
					                                         f32 %446 = OpLoad %445 
					                                                      OpStore %442 %446 
					                                                      OpBranch %444 
					                                             %447 = OpLabel 
					                                Private f32* %448 = OpAccessChain %354 %34 
					                                         f32 %449 = OpLoad %448 
					                                                      OpStore %442 %449 
					                                                      OpBranch %444 
					                                             %444 = OpLabel 
					                                         f32 %450 = OpLoad %442 
					                                Private f32* %451 = OpAccessChain %363 %34 
					                                                      OpStore %451 %450 
					                                Private f32* %452 = OpAccessChain %354 %34 
					                                         f32 %453 = OpLoad %452 
					                                        bool %454 = OpFOrdLessThan %453 %224 
					                                                      OpStore %269 %454 
					                                        bool %455 = OpLoad %269 
					                                                      OpSelectionMerge %458 None 
					                                                      OpBranchConditional %455 %457 %461 
					                                             %457 = OpLabel 
					                                Private f32* %459 = OpAccessChain %354 %30 
					                                         f32 %460 = OpLoad %459 
					                                                      OpStore %456 %460 
					                                                      OpBranch %458 
					                                             %461 = OpLabel 
					                                Private f32* %462 = OpAccessChain %363 %34 
					                                         f32 %463 = OpLoad %462 
					                                                      OpStore %456 %463 
					                                                      OpBranch %458 
					                                             %458 = OpLabel 
					                                         f32 %464 = OpLoad %456 
					                                Private f32* %465 = OpAccessChain %363 %34 
					                                                      OpStore %465 %464 
					                                       f32_2 %466 = OpLoad %363 
					                                       f32_3 %467 = OpVectorShuffle %466 %466 0 0 0 
					                                       f32_3 %470 = OpFAdd %467 %469 
					                                                      OpStore %354 %470 
					                                       f32_3 %471 = OpLoad %354 
					                                       f32_3 %472 = OpExtInst %1 10 %471 
					                                                      OpStore %354 %472 
					                                       f32_3 %473 = OpLoad %354 
					                                       f32_3 %475 = OpFMul %473 %474 
					                                       f32_3 %478 = OpFAdd %475 %477 
					                                                      OpStore %354 %478 
					                                       f32_3 %479 = OpLoad %354 
					                                       f32_3 %480 = OpExtInst %1 4 %479 
					                                       f32_3 %481 = OpFAdd %480 %237 
					                                                      OpStore %354 %481 
					                                       f32_3 %482 = OpLoad %354 
					                                       f32_3 %483 = OpCompositeConstruct %224 %224 %224 
					                                       f32_3 %484 = OpCompositeConstruct %225 %225 %225 
					                                       f32_3 %485 = OpExtInst %1 43 %482 %483 %484 
					                                                      OpStore %354 %485 
					                                       f32_3 %486 = OpLoad %354 
					                                       f32_3 %487 = OpFAdd %486 %237 
					                                                      OpStore %354 %487 
					                                Private f32* %488 = OpAccessChain %9 %34 
					                                         f32 %489 = OpLoad %488 
					                                         f32 %490 = OpFAdd %489 %359 
					                                Private f32* %491 = OpAccessChain %363 %34 
					                                                      OpStore %491 %490 
					                                Private f32* %493 = OpAccessChain %28 %34 
					                                         f32 %494 = OpLoad %493 
					                                Private f32* %495 = OpAccessChain %363 %34 
					                                         f32 %496 = OpLoad %495 
					                                         f32 %497 = OpFDiv %494 %496 
					                                Private f32* %498 = OpAccessChain %492 %34 
					                                                      OpStore %498 %497 
					                                       f32_2 %499 = OpLoad %492 
					                                       f32_3 %500 = OpVectorShuffle %499 %499 0 0 0 
					                                       f32_3 %501 = OpLoad %354 
					                                       f32_3 %502 = OpFMul %500 %501 
					                                       f32_3 %504 = OpFAdd %502 %503 
					                                       f32_4 %505 = OpLoad %28 
					                                       f32_4 %506 = OpVectorShuffle %505 %504 4 5 6 3 
					                                                      OpStore %28 %506 
					                                       f32_4 %507 = OpLoad %9 
					                                       f32_3 %508 = OpVectorShuffle %507 %507 0 0 0 
					                                       f32_4 %509 = OpLoad %28 
					                                       f32_3 %510 = OpVectorShuffle %509 %509 0 1 2 
					                                       f32_3 %511 = OpFMul %508 %510 
					                                                      OpStore %318 %511 
					                                       f32_3 %512 = OpLoad %318 
					                                         f32 %513 = OpDot %512 %324 
					                                Private f32* %514 = OpAccessChain %363 %34 
					                                                      OpStore %514 %513 
					                                       f32_4 %515 = OpLoad %9 
					                                       f32_3 %516 = OpVectorShuffle %515 %515 0 0 0 
					                                       f32_4 %517 = OpLoad %28 
					                                       f32_3 %518 = OpVectorShuffle %517 %517 0 1 2 
					                                       f32_3 %519 = OpFMul %516 %518 
					                                       f32_2 %520 = OpLoad %363 
					                                       f32_3 %521 = OpVectorShuffle %520 %520 0 0 0 
					                                       f32_3 %522 = OpFNegate %521 
					                                       f32_3 %523 = OpFAdd %519 %522 
					                                       f32_4 %524 = OpLoad %28 
					                                       f32_4 %525 = OpVectorShuffle %524 %523 4 5 6 3 
					                                                      OpStore %28 %525 
					                                Private f32* %526 = OpAccessChain %282 %30 
					                                                      OpStore %526 %394 
					                                Private f32* %527 = OpAccessChain %492 %30 
					                                                      OpStore %527 %394 
					                         read_only Texture2D %528 = OpLoad %399 
					                                     sampler %529 = OpLoad %403 
					                  read_only Texture2DSampled %530 = OpSampledImage %528 %529 
					                                       f32_4 %531 = OpLoad %282 
					                                       f32_2 %532 = OpVectorShuffle %531 %531 0 1 
					                                       f32_4 %533 = OpImageSampleExplicitLod %530 %532 Lod %7 
					                                         f32 %534 = OpCompositeExtract %533 1 
					                                Private f32* %535 = OpAccessChain %9 %34 
					                                                      OpStore %535 %534 
					                         read_only Texture2D %536 = OpLoad %399 
					                                     sampler %537 = OpLoad %403 
					                  read_only Texture2DSampled %538 = OpSampledImage %536 %537 
					                                       f32_2 %539 = OpLoad %492 
					                                       f32_4 %540 = OpImageSampleExplicitLod %538 %539 Lod %7 
					                                         f32 %541 = OpCompositeExtract %540 2 
					                                Private f32* %542 = OpAccessChain %9 %56 
					                                                      OpStore %542 %541 
					                                       f32_4 %543 = OpLoad %9 
					                                       f32_2 %544 = OpVectorShuffle %543 %543 0 3 
					                                       f32_4 %545 = OpLoad %9 
					                                       f32_4 %546 = OpVectorShuffle %545 %544 4 1 2 5 
					                                                      OpStore %9 %546 
					                                       f32_4 %547 = OpLoad %9 
					                                       f32_2 %548 = OpVectorShuffle %547 %547 0 3 
					                                       f32_2 %549 = OpCompositeConstruct %224 %224 
					                                       f32_2 %550 = OpCompositeConstruct %225 %225 
					                                       f32_2 %551 = OpExtInst %1 43 %548 %549 %550 
					                                       f32_4 %552 = OpLoad %9 
					                                       f32_4 %553 = OpVectorShuffle %552 %551 4 1 2 5 
					                                                      OpStore %9 %553 
					                                Private f32* %554 = OpAccessChain %9 %34 
					                                         f32 %555 = OpLoad %554 
					                                Private f32* %556 = OpAccessChain %9 %34 
					                                         f32 %557 = OpLoad %556 
					                                         f32 %558 = OpFAdd %555 %557 
					                                Private f32* %559 = OpAccessChain %9 %34 
					                                                      OpStore %559 %558 
					                                       f32_4 %560 = OpLoad %9 
					                                       f32_2 %561 = OpVectorShuffle %560 %560 3 3 
					                                       f32_4 %562 = OpLoad %9 
					                                       f32_2 %563 = OpVectorShuffle %562 %562 0 0 
					                                         f32 %564 = OpDot %561 %563 
					                                Private f32* %565 = OpAccessChain %9 %34 
					                                                      OpStore %565 %564 
					                                Private f32* %566 = OpAccessChain %9 %34 
					                                         f32 %567 = OpLoad %566 
					                                Private f32* %568 = OpAccessChain %363 %30 
					                                         f32 %569 = OpLoad %568 
					                                         f32 %570 = OpFMul %567 %569 
					                                Private f32* %571 = OpAccessChain %9 %34 
					                                                      OpStore %571 %570 
					                              Uniform f32_3* %572 = OpAccessChain %17 %71 
					                                       f32_3 %573 = OpLoad %572 
					                                       f32_2 %574 = OpVectorShuffle %573 %573 1 1 
					                                       f32_4 %575 = OpLoad %9 
					                                       f32_2 %576 = OpVectorShuffle %575 %575 0 0 
					                                         f32 %577 = OpDot %574 %576 
					                                Private f32* %578 = OpAccessChain %9 %34 
					                                                      OpStore %578 %577 
					                                       f32_4 %579 = OpLoad %9 
					                                       f32_3 %580 = OpVectorShuffle %579 %579 0 0 0 
					                                       f32_4 %581 = OpLoad %28 
					                                       f32_3 %582 = OpVectorShuffle %581 %581 0 1 2 
					                                       f32_3 %583 = OpFMul %580 %582 
					                                       f32_2 %584 = OpLoad %363 
					                                       f32_3 %585 = OpVectorShuffle %584 %584 0 0 0 
					                                       f32_3 %586 = OpFAdd %583 %585 
					                                       f32_4 %587 = OpLoad %9 
					                                       f32_4 %588 = OpVectorShuffle %587 %586 4 5 6 3 
					                                                      OpStore %9 %588 
					                                       f32_4 %591 = OpLoad %9 
					                                       f32_3 %592 = OpVectorShuffle %591 %591 0 1 2 
					                                       f32_3 %593 = OpExtInst %1 40 %592 %263 
					                                       f32_4 %594 = OpLoad %590 
					                                       f32_4 %595 = OpVectorShuffle %594 %593 4 5 6 3 
					                                                      OpStore %590 %595 
					                                 Output f32* %597 = OpAccessChain %590 %56 
					                                                      OpStore %597 %225 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "d3d11 " {
					Keywords { "TONEMAPPING_ACES" }
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
						vec4 unused_0_2[19];
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
					Keywords { "TONEMAPPING_ACES" }
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
					uniform 	vec4 _Lut2D_Params;
					uniform 	vec3 _ColorBalance;
					uniform 	vec3 _ColorFilter;
					uniform 	vec3 _HueSatCon;
					uniform 	vec3 _ChannelMixerRed;
					uniform 	vec3 _ChannelMixerGreen;
					uniform 	vec3 _ChannelMixerBlue;
					uniform 	vec3 _Lift;
					uniform 	vec3 _InvGamma;
					uniform 	vec3 _Gain;
					UNITY_LOCATION(0) uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					bvec2 u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					vec3 u_xlat7;
					bool u_xlatb7;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD0.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www + vec3(-0.386036009, -0.386036009, -0.386036009);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(13.6054821, 13.6054821, 13.6054821);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0479959995, -0.0479959995, -0.0479959995);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.179999992, 0.179999992, 0.179999992);
					    u_xlat1.x = dot(vec3(0.439700991, 0.382977992, 0.177334994), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.0897922963, 0.813422978, 0.0967615992), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0175439995, 0.111543998, 0.870703995), u_xlat0.xyz);
					    u_xlat0.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = min(u_xlat0.xyz, vec3(65504.0, 65504.0, 65504.0));
					    u_xlat1.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(1.525878e-05, 1.525878e-05, 1.525878e-05);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz + vec3(9.72000027, 9.72000027, 9.72000027);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.0570776239, 0.0570776239, 0.0570776239);
					    u_xlat2.xyz = log2(u_xlat0.xyz);
					    u_xlatb0.xyz = lessThan(u_xlat0.xyzx, vec4(3.05175708e-05, 3.05175708e-05, 3.05175708e-05, 0.0)).xyz;
					    u_xlat2.xyz = u_xlat2.xyz + vec3(9.72000027, 9.72000027, 9.72000027);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.0570776239, 0.0570776239, 0.0570776239);
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat2.x;
					    u_xlat0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat2.y;
					    u_xlat0.z = (u_xlatb0.z) ? u_xlat1.z : u_xlat2.z;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.413588405, -0.413588405, -0.413588405);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.413588405, 0.413588405, 0.413588405);
					    u_xlatb1 = lessThan(u_xlat0.xxyy, vec4(-0.301369876, 1.46799636, -0.301369876, 1.46799636));
					    u_xlat0.xyw = u_xlat0.xyz * vec3(17.5200005, 17.5200005, 17.5200005) + vec3(-9.72000027, -9.72000027, -9.72000027);
					    u_xlatb2.xy = lessThan(u_xlat0.zzzz, vec4(-0.301369876, 1.46799636, 0.0, 0.0)).xy;
					    u_xlat0.xyz = exp2(u_xlat0.xyw);
					    u_xlat7.x = (u_xlatb1.y) ? u_xlat0.x : float(65504.0);
					    u_xlat7.z = (u_xlatb1.w) ? u_xlat0.y : float(65504.0);
					    u_xlat0.xyw = u_xlat0.xyz + vec3(-1.52587891e-05, -1.52587891e-05, -1.52587891e-05);
					    u_xlat12 = (u_xlatb2.y) ? u_xlat0.z : 65504.0;
					    u_xlat0.xyw = u_xlat0.xyw + u_xlat0.xyw;
					    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat7.x;
					    u_xlat1.y = (u_xlatb1.z) ? u_xlat0.y : u_xlat7.z;
					    u_xlat1.z = (u_xlatb2.x) ? u_xlat0.w : u_xlat12;
					    u_xlat0.x = dot(vec3(1.45143926, -0.236510754, -0.214928567), u_xlat1.xyz);
					    u_xlat0.y = dot(vec3(-0.0765537769, 1.17622972, -0.0996759236), u_xlat1.xyz);
					    u_xlat0.z = dot(vec3(0.00831614807, -0.00603244966, 0.997716308), u_xlat1.xyz);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7.x;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat4.x + -0.5;
					    u_xlat6.x = u_xlat6.x + u_xlat15.x;
					    u_xlatb12 = 1.0<u_xlat6.x;
					    u_xlat7.xy = u_xlat6.xx + vec2(1.0, -1.0);
					    u_xlat12 = (u_xlatb12) ? u_xlat7.y : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat7.x : u_xlat12;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7.x = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7.x;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    u_xlat7.x = dot(vec3(0.695452213, 0.140678704, 0.163869068), u_xlat0.xyz);
					    u_xlat7.y = dot(vec3(0.0447945632, 0.859671116, 0.0955343172), u_xlat0.xyz);
					    u_xlat7.z = dot(vec3(-0.00552588282, 0.00402521016, 1.00150073), u_xlat0.xyz);
					    u_xlat0.xyz = (-u_xlat7.yxz) + u_xlat7.zyx;
					    u_xlat0.xy = u_xlat0.xy * u_xlat7.zy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = u_xlat7.x * u_xlat0.z + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat6.x = u_xlat7.y + u_xlat7.z;
					    u_xlat6.x = u_xlat7.x + u_xlat6.x;
					    u_xlat0.x = u_xlat0.x * 1.75 + u_xlat6.x;
					    u_xlat6.x = u_xlat0.x * 0.333333343;
					    u_xlat6.x = 0.0799999982 / u_xlat6.x;
					    u_xlat12 = min(u_xlat7.y, u_xlat7.x);
					    u_xlat12 = min(u_xlat7.z, u_xlat12);
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat18 = max(u_xlat7.y, u_xlat7.x);
					    u_xlat18 = max(u_xlat7.z, u_xlat18);
					    u_xlat2.xy = max(vec2(u_xlat18), vec2(9.99999975e-05, 0.00999999978));
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat6.y = u_xlat12 / u_xlat2.y;
					    u_xlat6.xz = u_xlat6.xy + vec2(-0.5, -0.400000006);
					    u_xlat1.x = u_xlat6.z * 2.5;
					    u_xlat18 = u_xlat6.z * intBitsToFloat(int(0x7F800000u)) + 0.5;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat18 = u_xlat18 * 2.0 + -1.0;
					    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat18 = u_xlat18 * u_xlat1.x + 1.0;
					    u_xlat18 = u_xlat18 * 0.0250000004;
					    u_xlat6.x = u_xlat6.x * u_xlat18;
					    u_xlatb1.x = u_xlat0.x>=0.479999989;
					    u_xlatb0.x = 0.159999996>=u_xlat0.x;
					    u_xlat6.x = (u_xlatb1.x) ? 0.0 : u_xlat6.x;
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat18 : u_xlat6.x;
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat2.yzw = u_xlat0.xxx * u_xlat7.xyz;
					    u_xlat6.x = (-u_xlat7.x) * u_xlat0.x + 0.0299999993;
					    u_xlat18 = u_xlat7.y * u_xlat0.x + (-u_xlat2.w);
					    u_xlat18 = u_xlat18 * 1.73205078;
					    u_xlat1.x = u_xlat2.y * 2.0 + (-u_xlat2.z);
					    u_xlat0.x = (-u_xlat7.z) * u_xlat0.x + u_xlat1.x;
					    u_xlat1.x = max(abs(u_xlat0.x), abs(u_xlat18));
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat7.x = min(abs(u_xlat0.x), abs(u_xlat18));
					    u_xlat1.x = u_xlat1.x * u_xlat7.x;
					    u_xlat7.x = u_xlat1.x * u_xlat1.x;
					    u_xlat13 = u_xlat7.x * 0.0208350997 + -0.0851330012;
					    u_xlat13 = u_xlat7.x * u_xlat13 + 0.180141002;
					    u_xlat13 = u_xlat7.x * u_xlat13 + -0.330299497;
					    u_xlat7.x = u_xlat7.x * u_xlat13 + 0.999866009;
					    u_xlat13 = u_xlat7.x * u_xlat1.x;
					    u_xlat13 = u_xlat13 * -2.0 + 1.57079637;
					    u_xlatb19 = abs(u_xlat0.x)<abs(u_xlat18);
					    u_xlat13 = u_xlatb19 ? u_xlat13 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat7.x + u_xlat13;
					    u_xlatb7 = u_xlat0.x<(-u_xlat0.x);
					    u_xlat7.x = u_xlatb7 ? -3.14159274 : float(0.0);
					    u_xlat1.x = u_xlat7.x + u_xlat1.x;
					    u_xlat7.x = min(u_xlat0.x, u_xlat18);
					    u_xlat0.x = max(u_xlat0.x, u_xlat18);
					    u_xlatb0.x = u_xlat0.x>=(-u_xlat0.x);
					    u_xlatb18 = u_xlat7.x<(-u_xlat7.x);
					    u_xlatb0.x = u_xlatb0.x && u_xlatb18;
					    u_xlat0.x = (u_xlatb0.x) ? (-u_xlat1.x) : u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 57.2957802;
					    u_xlatb1.xy = equal(u_xlat2.zwzz, u_xlat2.yzyy).xy;
					    u_xlatb18 = u_xlatb1.y && u_xlatb1.x;
					    u_xlat0.x = (u_xlatb18) ? 0.0 : u_xlat0.x;
					    u_xlatb18 = u_xlat0.x<0.0;
					    u_xlat1.x = u_xlat0.x + 360.0;
					    u_xlat0.x = (u_xlatb18) ? u_xlat1.x : u_xlat0.x;
					    u_xlatb18 = 180.0<u_xlat0.x;
					    u_xlat1.xy = u_xlat0.xx + vec2(360.0, -360.0);
					    u_xlat18 = (u_xlatb18) ? u_xlat1.y : u_xlat0.x;
					    u_xlatb0.x = u_xlat0.x<-180.0;
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat18;
					    u_xlat0.x = u_xlat0.x * 0.0148148146;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat18 = u_xlat0.x * -2.0 + 3.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat18;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat6.y * u_xlat0.x;
					    u_xlat0.x = u_xlat6.x * u_xlat0.x;
					    u_xlat2.x = u_xlat0.x * 0.180000007 + u_xlat2.y;
					    u_xlat0.x = dot(vec3(1.45143926, -0.236510754, -0.214928567), u_xlat2.xzw);
					    u_xlat0.y = dot(vec3(-0.0765537769, 1.17622972, -0.0996759236), u_xlat2.xzw);
					    u_xlat0.z = dot(vec3(0.00831614807, -0.00603244966, 0.997716308), u_xlat2.xzw);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat18 = dot(u_xlat0.xyz, vec3(0.272228986, 0.674081981, 0.0536894985));
					    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(u_xlat18);
					    u_xlat1.xyz = u_xlat0.xyz * vec3(278.508514, 278.508514, 278.508514) + vec3(10.7771997, 10.7771997, 10.7771997);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(293.604492, 293.604492, 293.604492) + vec3(88.7121964, 88.7121964, 88.7121964);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(80.6889038, 80.6889038, 80.6889038);
					    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
					    u_xlat1.z = dot(vec3(-0.00557464967, 0.0040607336, 1.01033914), u_xlat0.xyz);
					    u_xlat1.x = dot(vec3(0.662454188, 0.134004205, 0.156187683), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.272228718, 0.674081743, 0.0536895171), u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
					    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
					    u_xlat0.xy = u_xlat1.xy / u_xlat0.xx;
					    u_xlat18 = max(u_xlat1.y, 0.0);
					    u_xlat18 = min(u_xlat18, 65504.0);
					    u_xlat18 = log2(u_xlat18);
					    u_xlat18 = u_xlat18 * 0.981100023;
					    u_xlat1.y = exp2(u_xlat18);
					    u_xlat18 = (-u_xlat0.x) + 1.0;
					    u_xlat0.z = (-u_xlat0.y) + u_xlat18;
					    u_xlat6.x = max(u_xlat0.y, 9.99999975e-05);
					    u_xlat6.x = u_xlat1.y / u_xlat6.x;
					    u_xlat1.xz = u_xlat6.xx * u_xlat0.xz;
					    u_xlat0.x = dot(vec3(1.6410234, -0.324803293, -0.236424699), u_xlat1.xyz);
					    u_xlat0.y = dot(vec3(-0.663662851, 1.61533165, 0.0167563483), u_xlat1.xyz);
					    u_xlat0.z = dot(vec3(0.0117218941, -0.00828444213, 0.988394856), u_xlat1.xyz);
					    u_xlat18 = dot(u_xlat0.xyz, vec3(0.272228986, 0.674081981, 0.0536894985));
					    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.930000007, 0.930000007, 0.930000007) + vec3(u_xlat18);
					    u_xlat1.x = dot(vec3(0.662454188, 0.134004205, 0.156187683), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.272228718, 0.674081743, 0.0536895171), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.00557464967, 0.0040607336, 1.01033914), u_xlat0.xyz);
					    u_xlat0.x = dot(vec3(0.987223983, -0.00611326983, 0.0159533005), u_xlat1.xyz);
					    u_xlat0.y = dot(vec3(-0.00759836007, 1.00186002, 0.00533019984), u_xlat1.xyz);
					    u_xlat0.z = dot(vec3(0.00307257008, -0.00509594986, 1.08168006), u_xlat1.xyz);
					    u_xlat1.x = dot(vec3(3.2409699, -1.5373832, -0.498610765), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.969243646, 1.8759675, 0.0415550582), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0556300804, -0.203976959, 1.05697155), u_xlat0.xyz);
					    SV_Target0.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "TONEMAPPING_ACES" }
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
					; Bound: 1683
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %12 %1674 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate vs_TEXCOORD0 Location 12 
					                                                      OpMemberDecorate %15 0 Offset 15 
					                                                      OpMemberDecorate %15 1 Offset 15 
					                                                      OpMemberDecorate %15 2 Offset 15 
					                                                      OpMemberDecorate %15 3 Offset 15 
					                                                      OpMemberDecorate %15 4 Offset 15 
					                                                      OpMemberDecorate %15 5 Offset 15 
					                                                      OpMemberDecorate %15 6 Offset 15 
					                                                      OpMemberDecorate %15 7 Offset 15 
					                                                      OpMemberDecorate %15 8 Offset 15 
					                                                      OpMemberDecorate %15 9 Offset 15 
					                                                      OpDecorate %15 Block 
					                                                      OpDecorate %17 DescriptorSet 17 
					                                                      OpDecorate %17 Binding 17 
					                                                      OpDecorate %665 DescriptorSet 665 
					                                                      OpDecorate %665 Binding 665 
					                                                      OpDecorate %669 DescriptorSet 669 
					                                                      OpDecorate %669 Binding 669 
					                                                      OpDecorate %1674 Location 1674 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 2 
					                                              %11 = OpTypePointer Input %10 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                              %14 = OpTypeVector %6 3 
					                                              %15 = OpTypeStruct %7 %14 %14 %14 %14 %14 %14 %14 %14 %14 
					                                              %16 = OpTypePointer Uniform %15 
					Uniform struct {f32_4; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3;}* %17 = OpVariable Uniform 
					                                              %18 = OpTypeInt 32 1 
					                                          i32 %19 = OpConstant 0 
					                                              %20 = OpTypePointer Uniform %7 
					                               Private f32_4* %28 = OpVariable Private 
					                                              %29 = OpTypeInt 32 0 
					                                          u32 %30 = OpConstant 1 
					                                              %31 = OpTypePointer Private %6 
					                                          u32 %34 = OpConstant 0 
					                                              %35 = OpTypePointer Uniform %6 
					                                          u32 %56 = OpConstant 3 
					                                          f32 %64 = OpConstant 3,674022E-40 
					                                        f32_3 %65 = OpConstantComposite %64 %64 %64 
					                                          f32 %71 = OpConstant 3,674022E-40 
					                                        f32_3 %72 = OpConstantComposite %71 %71 %71 
					                                          f32 %83 = OpConstant 3,674022E-40 
					                                        f32_3 %84 = OpConstantComposite %83 %83 %83 
					                                          f32 %90 = OpConstant 3,674022E-40 
					                                        f32_3 %91 = OpConstantComposite %90 %90 %90 
					                                          f32 %95 = OpConstant 3,674022E-40 
					                                          f32 %96 = OpConstant 3,674022E-40 
					                                          f32 %97 = OpConstant 3,674022E-40 
					                                        f32_3 %98 = OpConstantComposite %95 %96 %97 
					                                         f32 %103 = OpConstant 3,674022E-40 
					                                         f32 %104 = OpConstant 3,674022E-40 
					                                         f32 %105 = OpConstant 3,674022E-40 
					                                       f32_3 %106 = OpConstantComposite %103 %104 %105 
					                                         f32 %111 = OpConstant 3,674022E-40 
					                                         f32 %112 = OpConstant 3,674022E-40 
					                                         f32 %113 = OpConstant 3,674022E-40 
					                                       f32_3 %114 = OpConstantComposite %111 %112 %113 
					                                         u32 %118 = OpConstant 2 
					                                         f32 %122 = OpConstant 3,674022E-40 
					                                       f32_3 %123 = OpConstantComposite %122 %122 %122 
					                                         f32 %129 = OpConstant 3,674022E-40 
					                                       f32_3 %130 = OpConstantComposite %129 %129 %129 
					                                         f32 %136 = OpConstant 3,674022E-40 
					                                       f32_3 %137 = OpConstantComposite %136 %136 %136 
					                                         f32 %139 = OpConstant 3,674022E-40 
					                                       f32_3 %140 = OpConstantComposite %139 %139 %139 
					                                         f32 %151 = OpConstant 3,674022E-40 
					                                       f32_3 %152 = OpConstantComposite %151 %151 %151 
					                                         f32 %158 = OpConstant 3,674022E-40 
					                                       f32_3 %159 = OpConstantComposite %158 %158 %158 
					                              Private f32_4* %163 = OpVariable Private 
					                                             %169 = OpTypeBool 
					                                             %170 = OpTypeVector %169 3 
					                                             %171 = OpTypePointer Private %170 
					                             Private bool_3* %172 = OpVariable Private 
					                                         f32 %175 = OpConstant 3,674022E-40 
					                                       f32_4 %176 = OpConstantComposite %175 %175 %175 %122 
					                                             %177 = OpTypeVector %169 4 
					                                             %190 = OpTypePointer Private %169 
					                                             %193 = OpTypePointer Function %6 
					                                         f32 %230 = OpConstant 3,674022E-40 
					                                       f32_3 %231 = OpConstantComposite %230 %230 %230 
					                                         i32 %237 = OpConstant 3 
					                                             %238 = OpTypePointer Uniform %14 
					                                         f32 %243 = OpConstant 3,674022E-40 
					                                       f32_3 %244 = OpConstantComposite %243 %243 %243 
					                                             %248 = OpTypePointer Private %177 
					                             Private bool_4* %249 = OpVariable Private 
					                                         f32 %252 = OpConstant 3,674022E-40 
					                                         f32 %253 = OpConstant 3,674022E-40 
					                                       f32_4 %254 = OpConstantComposite %252 %253 %252 %253 
					                                         f32 %258 = OpConstant 3,674022E-40 
					                                       f32_3 %259 = OpConstantComposite %258 %258 %258 
					                                         f32 %261 = OpConstant 3,674022E-40 
					                                       f32_3 %262 = OpConstantComposite %261 %261 %261 
					                                             %266 = OpTypeVector %169 2 
					                                             %267 = OpTypePointer Private %266 
					                             Private bool_2* %268 = OpVariable Private 
					                                       f32_4 %271 = OpConstantComposite %252 %253 %122 %122 
					                                             %279 = OpTypePointer Private %14 
					                              Private f32_3* %280 = OpVariable Private 
					                                         f32 %303 = OpConstant 3,674022E-40 
					                                       f32_3 %304 = OpConstantComposite %303 %303 %303 
					                                Private f32* %308 = OpVariable Private 
					                                         f32 %360 = OpConstant 3,674022E-40 
					                                         f32 %361 = OpConstant 3,674022E-40 
					                                         f32 %362 = OpConstant 3,674022E-40 
					                                       f32_3 %363 = OpConstantComposite %360 %361 %362 
					                                         f32 %368 = OpConstant 3,674022E-40 
					                                         f32 %369 = OpConstant 3,674022E-40 
					                                         f32 %370 = OpConstant 3,674022E-40 
					                                       f32_3 %371 = OpConstantComposite %368 %369 %370 
					                                         f32 %376 = OpConstant 3,674022E-40 
					                                         f32 %377 = OpConstant 3,674022E-40 
					                                         f32 %378 = OpConstant 3,674022E-40 
					                                       f32_3 %379 = OpConstantComposite %376 %377 %378 
					                                         f32 %384 = OpConstant 3,674022E-40 
					                                         f32 %385 = OpConstant 3,674022E-40 
					                                         f32 %386 = OpConstant 3,674022E-40 
					                                       f32_3 %387 = OpConstantComposite %384 %385 %386 
					                                         f32 %392 = OpConstant 3,674022E-40 
					                                         f32 %393 = OpConstant 3,674022E-40 
					                                         f32 %394 = OpConstant 3,674022E-40 
					                                       f32_3 %395 = OpConstantComposite %392 %393 %394 
					                                         f32 %400 = OpConstant 3,674022E-40 
					                                         f32 %401 = OpConstant 3,674022E-40 
					                                         f32 %402 = OpConstant 3,674022E-40 
					                                       f32_3 %403 = OpConstantComposite %400 %401 %402 
					                                         i32 %410 = OpConstant 1 
					                                         f32 %416 = OpConstant 3,674022E-40 
					                                         f32 %417 = OpConstant 3,674022E-40 
					                                         f32 %418 = OpConstant 3,674022E-40 
					                                       f32_3 %419 = OpConstantComposite %416 %417 %418 
					                                         f32 %424 = OpConstant 3,674022E-40 
					                                         f32 %425 = OpConstant 3,674022E-40 
					                                         f32 %426 = OpConstant 3,674022E-40 
					                                       f32_3 %427 = OpConstantComposite %424 %425 %426 
					                                         f32 %432 = OpConstant 3,674022E-40 
					                                         f32 %433 = OpConstant 3,674022E-40 
					                                         f32 %434 = OpConstant 3,674022E-40 
					                                       f32_3 %435 = OpConstantComposite %432 %433 %434 
					                                         i32 %442 = OpConstant 2 
					                                         i32 %450 = OpConstant 4 
					                                         i32 %457 = OpConstant 5 
					                                         i32 %464 = OpConstant 6 
					                                         i32 %471 = OpConstant 9 
					                                         i32 %475 = OpConstant 7 
					                                         f32 %489 = OpConstant 3,674022E-40 
					                                       f32_3 %490 = OpConstantComposite %489 %489 %489 
					                                         f32 %497 = OpConstant 3,674022E-40 
					                                         f32 %505 = OpConstant 3,674022E-40 
					                                       f32_3 %506 = OpConstantComposite %505 %505 %505 
					                                         f32 %508 = OpConstant 3,674022E-40 
					                                       f32_3 %509 = OpConstantComposite %508 %508 %508 
					                                         i32 %515 = OpConstant 8 
					                               Private bool* %538 = OpVariable Private 
					                                Private f32* %544 = OpVariable Private 
					                                         f32 %560 = OpConstant 3,674022E-40 
					                              Private f32_3* %585 = OpVariable Private 
					                                         f32 %588 = OpConstant 3,674022E-40 
					                                         f32 %589 = OpConstant 3,674022E-40 
					                                         f32 %590 = OpConstant 3,674022E-40 
					                                       f32_3 %591 = OpConstantComposite %588 %589 %590 
					                                         f32 %623 = OpConstant 3,674022E-40 
					                                         f32 %625 = OpConstant 3,674022E-40 
					                              Private f32_3* %628 = OpVariable Private 
					                                             %652 = OpTypePointer Private %10 
					                              Private f32_2* %653 = OpVariable Private 
					                                         f32 %660 = OpConstant 3,674022E-40 
					                                             %663 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                             %664 = OpTypePointer UniformConstant %663 
					        UniformConstant read_only Texture2D* %665 = OpVariable UniformConstant 
					                                             %667 = OpTypeSampler 
					                                             %668 = OpTypePointer UniformConstant %667 
					                    UniformConstant sampler* %669 = OpVariable UniformConstant 
					                                             %671 = OpTypeSampledImage %663 
					                                         f32 %698 = OpConstant 3,674022E-40 
					                                       f32_2 %712 = OpConstantComposite %497 %508 
					                               Private bool* %726 = OpVariable Private 
					                                         f32 %742 = OpConstant 3,674022E-40 
					                                       f32_3 %743 = OpConstantComposite %497 %560 %742 
					                                       f32_3 %748 = OpConstantComposite %623 %623 %623 
					                                         f32 %750 = OpConstant 3,674022E-40 
					                                       f32_3 %751 = OpConstantComposite %750 %750 %750 
					                              Private f32_2* %766 = OpVariable Private 
					                                       f32_3 %777 = OpConstantComposite %497 %497 %497 
					                                         f32 %863 = OpConstant 3,674022E-40 
					                                         f32 %864 = OpConstant 3,674022E-40 
					                                         f32 %865 = OpConstant 3,674022E-40 
					                                       f32_3 %866 = OpConstantComposite %863 %864 %865 
					                                         f32 %871 = OpConstant 3,674022E-40 
					                                         f32 %872 = OpConstant 3,674022E-40 
					                                         f32 %873 = OpConstant 3,674022E-40 
					                                       f32_3 %874 = OpConstantComposite %871 %872 %873 
					                                         f32 %879 = OpConstant 3,674022E-40 
					                                         f32 %880 = OpConstant 3,674022E-40 
					                                         f32 %881 = OpConstant 3,674022E-40 
					                                       f32_3 %882 = OpConstantComposite %879 %880 %881 
					                                         f32 %935 = OpConstant 3,674022E-40 
					                                         f32 %945 = OpConstant 3,674022E-40 
					                                         f32 %972 = OpConstant 3,674022E-40 
					                                       f32_2 %973 = OpConstantComposite %625 %972 
					                                         f32 %989 = OpConstant 3,674022E-40 
					                                       f32_2 %990 = OpConstantComposite %698 %989 
					                                         f32 %996 = OpConstant 3,674022E-40 
					                                        i32 %1001 = OpConstant 2139095040 
					                                        f32 %1034 = OpConstant 3,674022E-40 
					                                        f32 %1043 = OpConstant 3,674022E-40 
					                                        f32 %1046 = OpConstant 3,674022E-40 
					                                        f32 %1088 = OpConstant 3,674022E-40 
					                                        f32 %1101 = OpConstant 3,674022E-40 
					                               Private f32* %1151 = OpVariable Private 
					                                        f32 %1154 = OpConstant 3,674022E-40 
					                                        f32 %1156 = OpConstant 3,674022E-40 
					                                        f32 %1162 = OpConstant 3,674022E-40 
					                                        f32 %1168 = OpConstant 3,674022E-40 
					                                        f32 %1174 = OpConstant 3,674022E-40 
					                                        f32 %1183 = OpConstant 3,674022E-40 
					                                        f32 %1185 = OpConstant 3,674022E-40 
					                              Private bool* %1187 = OpVariable Private 
					                              Private bool* %1205 = OpVariable Private 
					                                        f32 %1213 = OpConstant 3,674022E-40 
					                                        f32 %1265 = OpConstant 3,674022E-40 
					                                        f32 %1295 = OpConstant 3,674022E-40 
					                                        f32 %1309 = OpConstant 3,674022E-40 
					                                        f32 %1315 = OpConstant 3,674022E-40 
					                                      f32_2 %1316 = OpConstantComposite %1295 %1315 
					                                        f32 %1332 = OpConstant 3,674022E-40 
					                                        f32 %1348 = OpConstant 3,674022E-40 
					                                        f32 %1364 = OpConstant 3,674022E-40 
					                                        f32 %1397 = OpConstant 3,674022E-40 
					                                        f32 %1422 = OpConstant 3,674022E-40 
					                                        f32 %1423 = OpConstant 3,674022E-40 
					                                        f32 %1424 = OpConstant 3,674022E-40 
					                                      f32_3 %1425 = OpConstantComposite %1422 %1423 %1424 
					                                        f32 %1437 = OpConstant 3,674022E-40 
					                                      f32_3 %1438 = OpConstantComposite %1437 %1437 %1437 
					                                        f32 %1447 = OpConstant 3,674022E-40 
					                                      f32_3 %1448 = OpConstantComposite %1447 %1447 %1447 
					                                        f32 %1450 = OpConstant 3,674022E-40 
					                                      f32_3 %1451 = OpConstantComposite %1450 %1450 %1450 
					                                        f32 %1464 = OpConstant 3,674022E-40 
					                                      f32_3 %1465 = OpConstantComposite %1464 %1464 %1464 
					                                        f32 %1467 = OpConstant 3,674022E-40 
					                                      f32_3 %1468 = OpConstantComposite %1467 %1467 %1467 
					                                        f32 %1477 = OpConstant 3,674022E-40 
					                                      f32_3 %1478 = OpConstantComposite %1477 %1477 %1477 
					                                        f32 %1489 = OpConstant 3,674022E-40 
					                                        f32 %1490 = OpConstant 3,674022E-40 
					                                        f32 %1491 = OpConstant 3,674022E-40 
					                                      f32_3 %1492 = OpConstantComposite %1489 %1490 %1491 
					                                        f32 %1497 = OpConstant 3,674022E-40 
					                                        f32 %1498 = OpConstant 3,674022E-40 
					                                        f32 %1499 = OpConstant 3,674022E-40 
					                                      f32_3 %1500 = OpConstantComposite %1497 %1498 %1499 
					                                        f32 %1505 = OpConstant 3,674022E-40 
					                                        f32 %1506 = OpConstant 3,674022E-40 
					                                        f32 %1507 = OpConstant 3,674022E-40 
					                                      f32_3 %1508 = OpConstantComposite %1505 %1506 %1507 
					                                        f32 %1536 = OpConstant 3,674022E-40 
					                                        f32 %1568 = OpConstant 3,674022E-40 
					                                        f32 %1569 = OpConstant 3,674022E-40 
					                                        f32 %1570 = OpConstant 3,674022E-40 
					                                      f32_3 %1571 = OpConstantComposite %1568 %1569 %1570 
					                                        f32 %1576 = OpConstant 3,674022E-40 
					                                        f32 %1577 = OpConstant 3,674022E-40 
					                                        f32 %1578 = OpConstant 3,674022E-40 
					                                      f32_3 %1579 = OpConstantComposite %1576 %1577 %1578 
					                                        f32 %1584 = OpConstant 3,674022E-40 
					                                        f32 %1585 = OpConstant 3,674022E-40 
					                                        f32 %1586 = OpConstant 3,674022E-40 
					                                      f32_3 %1587 = OpConstantComposite %1584 %1585 %1586 
					                                        f32 %1605 = OpConstant 3,674022E-40 
					                                      f32_3 %1606 = OpConstantComposite %1605 %1605 %1605 
					                                        f32 %1625 = OpConstant 3,674022E-40 
					                                        f32 %1626 = OpConstant 3,674022E-40 
					                                        f32 %1627 = OpConstant 3,674022E-40 
					                                      f32_3 %1628 = OpConstantComposite %1625 %1626 %1627 
					                                        f32 %1633 = OpConstant 3,674022E-40 
					                                        f32 %1634 = OpConstant 3,674022E-40 
					                                        f32 %1635 = OpConstant 3,674022E-40 
					                                      f32_3 %1636 = OpConstantComposite %1633 %1634 %1635 
					                                        f32 %1641 = OpConstant 3,674022E-40 
					                                        f32 %1642 = OpConstant 3,674022E-40 
					                                        f32 %1643 = OpConstant 3,674022E-40 
					                                      f32_3 %1644 = OpConstantComposite %1641 %1642 %1643 
					                                        f32 %1649 = OpConstant 3,674022E-40 
					                                        f32 %1650 = OpConstant 3,674022E-40 
					                                        f32 %1651 = OpConstant 3,674022E-40 
					                                      f32_3 %1652 = OpConstantComposite %1649 %1650 %1651 
					                                        f32 %1657 = OpConstant 3,674022E-40 
					                                        f32 %1658 = OpConstant 3,674022E-40 
					                                        f32 %1659 = OpConstant 3,674022E-40 
					                                      f32_3 %1660 = OpConstantComposite %1657 %1658 %1659 
					                                        f32 %1665 = OpConstant 3,674022E-40 
					                                        f32 %1666 = OpConstant 3,674022E-40 
					                                        f32 %1667 = OpConstant 3,674022E-40 
					                                      f32_3 %1668 = OpConstantComposite %1665 %1666 %1667 
					                                            %1673 = OpTypePointer Output %7 
					                              Output f32_4* %1674 = OpVariable Output 
					                                            %1680 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                               Function f32* %194 = OpVariable Function 
					                               Function f32* %206 = OpVariable Function 
					                               Function f32* %218 = OpVariable Function 
					                               Function f32* %283 = OpVariable Function 
					                               Function f32* %293 = OpVariable Function 
					                               Function f32* %311 = OpVariable Function 
					                               Function f32* %327 = OpVariable Function 
					                               Function f32* %339 = OpVariable Function 
					                               Function f32* %351 = OpVariable Function 
					                               Function f32* %717 = OpVariable Function 
					                               Function f32* %731 = OpVariable Function 
					                              Function f32* %1053 = OpVariable Function 
					                              Function f32* %1063 = OpVariable Function 
					                              Function f32* %1252 = OpVariable Function 
					                              Function f32* %1282 = OpVariable Function 
					                              Function f32* %1299 = OpVariable Function 
					                              Function f32* %1321 = OpVariable Function 
					                              Function f32* %1337 = OpVariable Function 
					                                        f32_2 %13 = OpLoad vs_TEXCOORD0 
					                               Uniform f32_4* %21 = OpAccessChain %17 %19 
					                                        f32_4 %22 = OpLoad %21 
					                                        f32_2 %23 = OpVectorShuffle %22 %22 1 2 
					                                        f32_2 %24 = OpFNegate %23 
					                                        f32_2 %25 = OpFAdd %13 %24 
					                                        f32_4 %26 = OpLoad %9 
					                                        f32_4 %27 = OpVectorShuffle %26 %25 0 4 5 3 
					                                                      OpStore %9 %27 
					                                 Private f32* %32 = OpAccessChain %9 %30 
					                                          f32 %33 = OpLoad %32 
					                                 Uniform f32* %36 = OpAccessChain %17 %19 %34 
					                                          f32 %37 = OpLoad %36 
					                                          f32 %38 = OpFMul %33 %37 
					                                 Private f32* %39 = OpAccessChain %28 %34 
					                                                      OpStore %39 %38 
					                                 Private f32* %40 = OpAccessChain %28 %34 
					                                          f32 %41 = OpLoad %40 
					                                          f32 %42 = OpExtInst %1 10 %41 
					                                 Private f32* %43 = OpAccessChain %9 %34 
					                                                      OpStore %43 %42 
					                                 Private f32* %44 = OpAccessChain %9 %34 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %46 = OpAccessChain %17 %19 %34 
					                                          f32 %47 = OpLoad %46 
					                                          f32 %48 = OpFDiv %45 %47 
					                                 Private f32* %49 = OpAccessChain %28 %34 
					                                                      OpStore %49 %48 
					                                 Private f32* %50 = OpAccessChain %9 %30 
					                                          f32 %51 = OpLoad %50 
					                                 Private f32* %52 = OpAccessChain %28 %34 
					                                          f32 %53 = OpLoad %52 
					                                          f32 %54 = OpFNegate %53 
					                                          f32 %55 = OpFAdd %51 %54 
					                                 Private f32* %57 = OpAccessChain %9 %56 
					                                                      OpStore %57 %55 
					                                        f32_4 %58 = OpLoad %9 
					                                        f32_3 %59 = OpVectorShuffle %58 %58 0 2 3 
					                               Uniform f32_4* %60 = OpAccessChain %17 %19 
					                                        f32_4 %61 = OpLoad %60 
					                                        f32_3 %62 = OpVectorShuffle %61 %61 3 3 3 
					                                        f32_3 %63 = OpFMul %59 %62 
					                                        f32_3 %66 = OpFAdd %63 %65 
					                                        f32_4 %67 = OpLoad %9 
					                                        f32_4 %68 = OpVectorShuffle %67 %66 4 5 6 3 
					                                                      OpStore %9 %68 
					                                        f32_4 %69 = OpLoad %9 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 0 1 2 
					                                        f32_3 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %9 
					                                        f32_4 %75 = OpVectorShuffle %74 %73 4 5 6 3 
					                                                      OpStore %9 %75 
					                                        f32_4 %76 = OpLoad %9 
					                                        f32_3 %77 = OpVectorShuffle %76 %76 0 1 2 
					                                        f32_3 %78 = OpExtInst %1 29 %77 
					                                        f32_4 %79 = OpLoad %9 
					                                        f32_4 %80 = OpVectorShuffle %79 %78 4 5 6 3 
					                                                      OpStore %9 %80 
					                                        f32_4 %81 = OpLoad %9 
					                                        f32_3 %82 = OpVectorShuffle %81 %81 0 1 2 
					                                        f32_3 %85 = OpFAdd %82 %84 
					                                        f32_4 %86 = OpLoad %9 
					                                        f32_4 %87 = OpVectorShuffle %86 %85 4 5 6 3 
					                                                      OpStore %9 %87 
					                                        f32_4 %88 = OpLoad %9 
					                                        f32_3 %89 = OpVectorShuffle %88 %88 0 1 2 
					                                        f32_3 %92 = OpFMul %89 %91 
					                                        f32_4 %93 = OpLoad %9 
					                                        f32_4 %94 = OpVectorShuffle %93 %92 4 5 6 3 
					                                                      OpStore %9 %94 
					                                        f32_4 %99 = OpLoad %9 
					                                       f32_3 %100 = OpVectorShuffle %99 %99 0 1 2 
					                                         f32 %101 = OpDot %98 %100 
					                                Private f32* %102 = OpAccessChain %28 %34 
					                                                      OpStore %102 %101 
					                                       f32_4 %107 = OpLoad %9 
					                                       f32_3 %108 = OpVectorShuffle %107 %107 0 1 2 
					                                         f32 %109 = OpDot %106 %108 
					                                Private f32* %110 = OpAccessChain %28 %30 
					                                                      OpStore %110 %109 
					                                       f32_4 %115 = OpLoad %9 
					                                       f32_3 %116 = OpVectorShuffle %115 %115 0 1 2 
					                                         f32 %117 = OpDot %114 %116 
					                                Private f32* %119 = OpAccessChain %28 %118 
					                                                      OpStore %119 %117 
					                                       f32_4 %120 = OpLoad %28 
					                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                                       f32_3 %124 = OpExtInst %1 40 %121 %123 
					                                       f32_4 %125 = OpLoad %9 
					                                       f32_4 %126 = OpVectorShuffle %125 %124 4 5 6 3 
					                                                      OpStore %9 %126 
					                                       f32_4 %127 = OpLoad %9 
					                                       f32_3 %128 = OpVectorShuffle %127 %127 0 1 2 
					                                       f32_3 %131 = OpExtInst %1 37 %128 %130 
					                                       f32_4 %132 = OpLoad %9 
					                                       f32_4 %133 = OpVectorShuffle %132 %131 4 5 6 3 
					                                                      OpStore %9 %133 
					                                       f32_4 %134 = OpLoad %9 
					                                       f32_3 %135 = OpVectorShuffle %134 %134 0 1 2 
					                                       f32_3 %138 = OpFMul %135 %137 
					                                       f32_3 %141 = OpFAdd %138 %140 
					                                       f32_4 %142 = OpLoad %28 
					                                       f32_4 %143 = OpVectorShuffle %142 %141 4 5 6 3 
					                                                      OpStore %28 %143 
					                                       f32_4 %144 = OpLoad %28 
					                                       f32_3 %145 = OpVectorShuffle %144 %144 0 1 2 
					                                       f32_3 %146 = OpExtInst %1 30 %145 
					                                       f32_4 %147 = OpLoad %28 
					                                       f32_4 %148 = OpVectorShuffle %147 %146 4 5 6 3 
					                                                      OpStore %28 %148 
					                                       f32_4 %149 = OpLoad %28 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_3 %153 = OpFAdd %150 %152 
					                                       f32_4 %154 = OpLoad %28 
					                                       f32_4 %155 = OpVectorShuffle %154 %153 4 5 6 3 
					                                                      OpStore %28 %155 
					                                       f32_4 %156 = OpLoad %28 
					                                       f32_3 %157 = OpVectorShuffle %156 %156 0 1 2 
					                                       f32_3 %160 = OpFMul %157 %159 
					                                       f32_4 %161 = OpLoad %28 
					                                       f32_4 %162 = OpVectorShuffle %161 %160 4 5 6 3 
					                                                      OpStore %28 %162 
					                                       f32_4 %164 = OpLoad %9 
					                                       f32_3 %165 = OpVectorShuffle %164 %164 0 1 2 
					                                       f32_3 %166 = OpExtInst %1 30 %165 
					                                       f32_4 %167 = OpLoad %163 
					                                       f32_4 %168 = OpVectorShuffle %167 %166 4 5 6 3 
					                                                      OpStore %163 %168 
					                                       f32_4 %173 = OpLoad %9 
					                                       f32_4 %174 = OpVectorShuffle %173 %173 0 1 2 0 
					                                      bool_4 %178 = OpFOrdLessThan %174 %176 
					                                      bool_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                                      OpStore %172 %179 
					                                       f32_4 %180 = OpLoad %163 
					                                       f32_3 %181 = OpVectorShuffle %180 %180 0 1 2 
					                                       f32_3 %182 = OpFAdd %181 %152 
					                                       f32_4 %183 = OpLoad %163 
					                                       f32_4 %184 = OpVectorShuffle %183 %182 4 5 6 3 
					                                                      OpStore %163 %184 
					                                       f32_4 %185 = OpLoad %163 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                                       f32_3 %187 = OpFMul %186 %159 
					                                       f32_4 %188 = OpLoad %163 
					                                       f32_4 %189 = OpVectorShuffle %188 %187 4 5 6 3 
					                                                      OpStore %163 %189 
					                               Private bool* %191 = OpAccessChain %172 %34 
					                                        bool %192 = OpLoad %191 
					                                                      OpSelectionMerge %196 None 
					                                                      OpBranchConditional %192 %195 %199 
					                                             %195 = OpLabel 
					                                Private f32* %197 = OpAccessChain %28 %34 
					                                         f32 %198 = OpLoad %197 
					                                                      OpStore %194 %198 
					                                                      OpBranch %196 
					                                             %199 = OpLabel 
					                                Private f32* %200 = OpAccessChain %163 %34 
					                                         f32 %201 = OpLoad %200 
					                                                      OpStore %194 %201 
					                                                      OpBranch %196 
					                                             %196 = OpLabel 
					                                         f32 %202 = OpLoad %194 
					                                Private f32* %203 = OpAccessChain %9 %34 
					                                                      OpStore %203 %202 
					                               Private bool* %204 = OpAccessChain %172 %30 
					                                        bool %205 = OpLoad %204 
					                                                      OpSelectionMerge %208 None 
					                                                      OpBranchConditional %205 %207 %211 
					                                             %207 = OpLabel 
					                                Private f32* %209 = OpAccessChain %28 %30 
					                                         f32 %210 = OpLoad %209 
					                                                      OpStore %206 %210 
					                                                      OpBranch %208 
					                                             %211 = OpLabel 
					                                Private f32* %212 = OpAccessChain %163 %30 
					                                         f32 %213 = OpLoad %212 
					                                                      OpStore %206 %213 
					                                                      OpBranch %208 
					                                             %208 = OpLabel 
					                                         f32 %214 = OpLoad %206 
					                                Private f32* %215 = OpAccessChain %9 %30 
					                                                      OpStore %215 %214 
					                               Private bool* %216 = OpAccessChain %172 %118 
					                                        bool %217 = OpLoad %216 
					                                                      OpSelectionMerge %220 None 
					                                                      OpBranchConditional %217 %219 %223 
					                                             %219 = OpLabel 
					                                Private f32* %221 = OpAccessChain %28 %118 
					                                         f32 %222 = OpLoad %221 
					                                                      OpStore %218 %222 
					                                                      OpBranch %220 
					                                             %223 = OpLabel 
					                                Private f32* %224 = OpAccessChain %163 %118 
					                                         f32 %225 = OpLoad %224 
					                                                      OpStore %218 %225 
					                                                      OpBranch %220 
					                                             %220 = OpLabel 
					                                         f32 %226 = OpLoad %218 
					                                Private f32* %227 = OpAccessChain %9 %118 
					                                                      OpStore %227 %226 
					                                       f32_4 %228 = OpLoad %9 
					                                       f32_3 %229 = OpVectorShuffle %228 %228 0 1 2 
					                                       f32_3 %232 = OpFAdd %229 %231 
					                                       f32_4 %233 = OpLoad %9 
					                                       f32_4 %234 = OpVectorShuffle %233 %232 4 5 6 3 
					                                                      OpStore %9 %234 
					                                       f32_4 %235 = OpLoad %9 
					                                       f32_3 %236 = OpVectorShuffle %235 %235 0 1 2 
					                              Uniform f32_3* %239 = OpAccessChain %17 %237 
					                                       f32_3 %240 = OpLoad %239 
					                                       f32_3 %241 = OpVectorShuffle %240 %240 2 2 2 
					                                       f32_3 %242 = OpFMul %236 %241 
					                                       f32_3 %245 = OpFAdd %242 %244 
					                                       f32_4 %246 = OpLoad %9 
					                                       f32_4 %247 = OpVectorShuffle %246 %245 4 5 6 3 
					                                                      OpStore %9 %247 
					                                       f32_4 %250 = OpLoad %9 
					                                       f32_4 %251 = OpVectorShuffle %250 %250 0 0 1 1 
					                                      bool_4 %255 = OpFOrdLessThan %251 %254 
					                                                      OpStore %249 %255 
					                                       f32_4 %256 = OpLoad %9 
					                                       f32_3 %257 = OpVectorShuffle %256 %256 0 1 2 
					                                       f32_3 %260 = OpFMul %257 %259 
					                                       f32_3 %263 = OpFAdd %260 %262 
					                                       f32_4 %264 = OpLoad %9 
					                                       f32_4 %265 = OpVectorShuffle %264 %263 4 5 2 6 
					                                                      OpStore %9 %265 
					                                       f32_4 %269 = OpLoad %9 
					                                       f32_4 %270 = OpVectorShuffle %269 %269 2 2 2 2 
					                                      bool_4 %272 = OpFOrdLessThan %270 %271 
					                                      bool_2 %273 = OpVectorShuffle %272 %272 0 1 
					                                                      OpStore %268 %273 
					                                       f32_4 %274 = OpLoad %9 
					                                       f32_3 %275 = OpVectorShuffle %274 %274 0 1 3 
					                                       f32_3 %276 = OpExtInst %1 29 %275 
					                                       f32_4 %277 = OpLoad %9 
					                                       f32_4 %278 = OpVectorShuffle %277 %276 4 5 6 3 
					                                                      OpStore %9 %278 
					                               Private bool* %281 = OpAccessChain %249 %30 
					                                        bool %282 = OpLoad %281 
					                                                      OpSelectionMerge %285 None 
					                                                      OpBranchConditional %282 %284 %288 
					                                             %284 = OpLabel 
					                                Private f32* %286 = OpAccessChain %9 %34 
					                                         f32 %287 = OpLoad %286 
					                                                      OpStore %283 %287 
					                                                      OpBranch %285 
					                                             %288 = OpLabel 
					                                                      OpStore %283 %129 
					                                                      OpBranch %285 
					                                             %285 = OpLabel 
					                                         f32 %289 = OpLoad %283 
					                                Private f32* %290 = OpAccessChain %280 %34 
					                                                      OpStore %290 %289 
					                               Private bool* %291 = OpAccessChain %249 %56 
					                                        bool %292 = OpLoad %291 
					                                                      OpSelectionMerge %295 None 
					                                                      OpBranchConditional %292 %294 %298 
					                                             %294 = OpLabel 
					                                Private f32* %296 = OpAccessChain %9 %30 
					                                         f32 %297 = OpLoad %296 
					                                                      OpStore %293 %297 
					                                                      OpBranch %295 
					                                             %298 = OpLabel 
					                                                      OpStore %293 %129 
					                                                      OpBranch %295 
					                                             %295 = OpLabel 
					                                         f32 %299 = OpLoad %293 
					                                Private f32* %300 = OpAccessChain %280 %118 
					                                                      OpStore %300 %299 
					                                       f32_4 %301 = OpLoad %9 
					                                       f32_3 %302 = OpVectorShuffle %301 %301 0 1 2 
					                                       f32_3 %305 = OpFAdd %302 %304 
					                                       f32_4 %306 = OpLoad %9 
					                                       f32_4 %307 = OpVectorShuffle %306 %305 4 5 2 6 
					                                                      OpStore %9 %307 
					                               Private bool* %309 = OpAccessChain %268 %30 
					                                        bool %310 = OpLoad %309 
					                                                      OpSelectionMerge %313 None 
					                                                      OpBranchConditional %310 %312 %316 
					                                             %312 = OpLabel 
					                                Private f32* %314 = OpAccessChain %9 %118 
					                                         f32 %315 = OpLoad %314 
					                                                      OpStore %311 %315 
					                                                      OpBranch %313 
					                                             %316 = OpLabel 
					                                                      OpStore %311 %129 
					                                                      OpBranch %313 
					                                             %313 = OpLabel 
					                                         f32 %317 = OpLoad %311 
					                                                      OpStore %308 %317 
					                                       f32_4 %318 = OpLoad %9 
					                                       f32_3 %319 = OpVectorShuffle %318 %318 0 1 3 
					                                       f32_4 %320 = OpLoad %9 
					                                       f32_3 %321 = OpVectorShuffle %320 %320 0 1 3 
					                                       f32_3 %322 = OpFAdd %319 %321 
					                                       f32_4 %323 = OpLoad %9 
					                                       f32_4 %324 = OpVectorShuffle %323 %322 4 5 2 6 
					                                                      OpStore %9 %324 
					                               Private bool* %325 = OpAccessChain %249 %34 
					                                        bool %326 = OpLoad %325 
					                                                      OpSelectionMerge %329 None 
					                                                      OpBranchConditional %326 %328 %332 
					                                             %328 = OpLabel 
					                                Private f32* %330 = OpAccessChain %9 %34 
					                                         f32 %331 = OpLoad %330 
					                                                      OpStore %327 %331 
					                                                      OpBranch %329 
					                                             %332 = OpLabel 
					                                Private f32* %333 = OpAccessChain %280 %34 
					                                         f32 %334 = OpLoad %333 
					                                                      OpStore %327 %334 
					                                                      OpBranch %329 
					                                             %329 = OpLabel 
					                                         f32 %335 = OpLoad %327 
					                                Private f32* %336 = OpAccessChain %28 %34 
					                                                      OpStore %336 %335 
					                               Private bool* %337 = OpAccessChain %249 %118 
					                                        bool %338 = OpLoad %337 
					                                                      OpSelectionMerge %341 None 
					                                                      OpBranchConditional %338 %340 %344 
					                                             %340 = OpLabel 
					                                Private f32* %342 = OpAccessChain %9 %30 
					                                         f32 %343 = OpLoad %342 
					                                                      OpStore %339 %343 
					                                                      OpBranch %341 
					                                             %344 = OpLabel 
					                                Private f32* %345 = OpAccessChain %280 %118 
					                                         f32 %346 = OpLoad %345 
					                                                      OpStore %339 %346 
					                                                      OpBranch %341 
					                                             %341 = OpLabel 
					                                         f32 %347 = OpLoad %339 
					                                Private f32* %348 = OpAccessChain %28 %30 
					                                                      OpStore %348 %347 
					                               Private bool* %349 = OpAccessChain %268 %34 
					                                        bool %350 = OpLoad %349 
					                                                      OpSelectionMerge %353 None 
					                                                      OpBranchConditional %350 %352 %356 
					                                             %352 = OpLabel 
					                                Private f32* %354 = OpAccessChain %9 %56 
					                                         f32 %355 = OpLoad %354 
					                                                      OpStore %351 %355 
					                                                      OpBranch %353 
					                                             %356 = OpLabel 
					                                         f32 %357 = OpLoad %308 
					                                                      OpStore %351 %357 
					                                                      OpBranch %353 
					                                             %353 = OpLabel 
					                                         f32 %358 = OpLoad %351 
					                                Private f32* %359 = OpAccessChain %28 %118 
					                                                      OpStore %359 %358 
					                                       f32_4 %364 = OpLoad %28 
					                                       f32_3 %365 = OpVectorShuffle %364 %364 0 1 2 
					                                         f32 %366 = OpDot %363 %365 
					                                Private f32* %367 = OpAccessChain %9 %34 
					                                                      OpStore %367 %366 
					                                       f32_4 %372 = OpLoad %28 
					                                       f32_3 %373 = OpVectorShuffle %372 %372 0 1 2 
					                                         f32 %374 = OpDot %371 %373 
					                                Private f32* %375 = OpAccessChain %9 %30 
					                                                      OpStore %375 %374 
					                                       f32_4 %380 = OpLoad %28 
					                                       f32_3 %381 = OpVectorShuffle %380 %380 0 1 2 
					                                         f32 %382 = OpDot %379 %381 
					                                Private f32* %383 = OpAccessChain %9 %118 
					                                                      OpStore %383 %382 
					                                       f32_4 %388 = OpLoad %9 
					                                       f32_3 %389 = OpVectorShuffle %388 %388 0 1 2 
					                                         f32 %390 = OpDot %387 %389 
					                                Private f32* %391 = OpAccessChain %28 %34 
					                                                      OpStore %391 %390 
					                                       f32_4 %396 = OpLoad %9 
					                                       f32_3 %397 = OpVectorShuffle %396 %396 0 1 2 
					                                         f32 %398 = OpDot %395 %397 
					                                Private f32* %399 = OpAccessChain %28 %30 
					                                                      OpStore %399 %398 
					                                       f32_4 %404 = OpLoad %9 
					                                       f32_3 %405 = OpVectorShuffle %404 %404 0 1 2 
					                                         f32 %406 = OpDot %403 %405 
					                                Private f32* %407 = OpAccessChain %28 %118 
					                                                      OpStore %407 %406 
					                                       f32_4 %408 = OpLoad %28 
					                                       f32_3 %409 = OpVectorShuffle %408 %408 0 1 2 
					                              Uniform f32_3* %411 = OpAccessChain %17 %410 
					                                       f32_3 %412 = OpLoad %411 
					                                       f32_3 %413 = OpFMul %409 %412 
					                                       f32_4 %414 = OpLoad %9 
					                                       f32_4 %415 = OpVectorShuffle %414 %413 4 5 6 3 
					                                                      OpStore %9 %415 
					                                       f32_4 %420 = OpLoad %9 
					                                       f32_3 %421 = OpVectorShuffle %420 %420 0 1 2 
					                                         f32 %422 = OpDot %419 %421 
					                                Private f32* %423 = OpAccessChain %28 %34 
					                                                      OpStore %423 %422 
					                                       f32_4 %428 = OpLoad %9 
					                                       f32_3 %429 = OpVectorShuffle %428 %428 0 1 2 
					                                         f32 %430 = OpDot %427 %429 
					                                Private f32* %431 = OpAccessChain %28 %30 
					                                                      OpStore %431 %430 
					                                       f32_4 %436 = OpLoad %9 
					                                       f32_3 %437 = OpVectorShuffle %436 %436 0 1 2 
					                                         f32 %438 = OpDot %435 %437 
					                                Private f32* %439 = OpAccessChain %28 %118 
					                                                      OpStore %439 %438 
					                                       f32_4 %440 = OpLoad %28 
					                                       f32_3 %441 = OpVectorShuffle %440 %440 0 1 2 
					                              Uniform f32_3* %443 = OpAccessChain %17 %442 
					                                       f32_3 %444 = OpLoad %443 
					                                       f32_3 %445 = OpFMul %441 %444 
					                                       f32_4 %446 = OpLoad %9 
					                                       f32_4 %447 = OpVectorShuffle %446 %445 4 5 6 3 
					                                                      OpStore %9 %447 
					                                       f32_4 %448 = OpLoad %9 
					                                       f32_3 %449 = OpVectorShuffle %448 %448 0 1 2 
					                              Uniform f32_3* %451 = OpAccessChain %17 %450 
					                                       f32_3 %452 = OpLoad %451 
					                                         f32 %453 = OpDot %449 %452 
					                                Private f32* %454 = OpAccessChain %28 %34 
					                                                      OpStore %454 %453 
					                                       f32_4 %455 = OpLoad %9 
					                                       f32_3 %456 = OpVectorShuffle %455 %455 0 1 2 
					                              Uniform f32_3* %458 = OpAccessChain %17 %457 
					                                       f32_3 %459 = OpLoad %458 
					                                         f32 %460 = OpDot %456 %459 
					                                Private f32* %461 = OpAccessChain %28 %30 
					                                                      OpStore %461 %460 
					                                       f32_4 %462 = OpLoad %9 
					                                       f32_3 %463 = OpVectorShuffle %462 %462 0 1 2 
					                              Uniform f32_3* %465 = OpAccessChain %17 %464 
					                                       f32_3 %466 = OpLoad %465 
					                                         f32 %467 = OpDot %463 %466 
					                                Private f32* %468 = OpAccessChain %28 %118 
					                                                      OpStore %468 %467 
					                                       f32_4 %469 = OpLoad %28 
					                                       f32_3 %470 = OpVectorShuffle %469 %469 0 1 2 
					                              Uniform f32_3* %472 = OpAccessChain %17 %471 
					                                       f32_3 %473 = OpLoad %472 
					                                       f32_3 %474 = OpFMul %470 %473 
					                              Uniform f32_3* %476 = OpAccessChain %17 %475 
					                                       f32_3 %477 = OpLoad %476 
					                                       f32_3 %478 = OpFAdd %474 %477 
					                                       f32_4 %479 = OpLoad %9 
					                                       f32_4 %480 = OpVectorShuffle %479 %478 4 5 6 3 
					                                                      OpStore %9 %480 
					                                       f32_4 %481 = OpLoad %9 
					                                       f32_3 %482 = OpVectorShuffle %481 %481 0 1 2 
					                                       f32_3 %483 = OpExtInst %1 4 %482 
					                                       f32_3 %484 = OpExtInst %1 30 %483 
					                                       f32_4 %485 = OpLoad %28 
					                                       f32_4 %486 = OpVectorShuffle %485 %484 4 5 6 3 
					                                                      OpStore %28 %486 
					                                       f32_4 %487 = OpLoad %9 
					                                       f32_3 %488 = OpVectorShuffle %487 %487 0 1 2 
					                                       f32_3 %491 = OpFMul %488 %490 
					                                       f32_3 %492 = OpFAdd %491 %137 
					                                       f32_4 %493 = OpLoad %9 
					                                       f32_4 %494 = OpVectorShuffle %493 %492 4 5 6 3 
					                                                      OpStore %9 %494 
					                                       f32_4 %495 = OpLoad %9 
					                                       f32_3 %496 = OpVectorShuffle %495 %495 0 1 2 
					                                       f32_3 %498 = OpCompositeConstruct %122 %122 %122 
					                                       f32_3 %499 = OpCompositeConstruct %497 %497 %497 
					                                       f32_3 %500 = OpExtInst %1 43 %496 %498 %499 
					                                       f32_4 %501 = OpLoad %9 
					                                       f32_4 %502 = OpVectorShuffle %501 %500 4 5 6 3 
					                                                      OpStore %9 %502 
					                                       f32_4 %503 = OpLoad %9 
					                                       f32_3 %504 = OpVectorShuffle %503 %503 0 1 2 
					                                       f32_3 %507 = OpFMul %504 %506 
					                                       f32_3 %510 = OpFAdd %507 %509 
					                                       f32_4 %511 = OpLoad %9 
					                                       f32_4 %512 = OpVectorShuffle %511 %510 4 5 6 3 
					                                                      OpStore %9 %512 
					                                       f32_4 %513 = OpLoad %28 
					                                       f32_3 %514 = OpVectorShuffle %513 %513 0 1 2 
					                              Uniform f32_3* %516 = OpAccessChain %17 %515 
					                                       f32_3 %517 = OpLoad %516 
					                                       f32_3 %518 = OpFMul %514 %517 
					                                       f32_4 %519 = OpLoad %28 
					                                       f32_4 %520 = OpVectorShuffle %519 %518 4 5 6 3 
					                                                      OpStore %28 %520 
					                                       f32_4 %521 = OpLoad %28 
					                                       f32_3 %522 = OpVectorShuffle %521 %521 0 1 2 
					                                       f32_3 %523 = OpExtInst %1 29 %522 
					                                       f32_4 %524 = OpLoad %28 
					                                       f32_4 %525 = OpVectorShuffle %524 %523 4 5 6 3 
					                                                      OpStore %28 %525 
					                                       f32_4 %526 = OpLoad %9 
					                                       f32_3 %527 = OpVectorShuffle %526 %526 0 1 2 
					                                       f32_4 %528 = OpLoad %28 
					                                       f32_3 %529 = OpVectorShuffle %528 %528 0 1 2 
					                                       f32_3 %530 = OpFMul %527 %529 
					                                       f32_4 %531 = OpLoad %9 
					                                       f32_4 %532 = OpVectorShuffle %531 %530 4 5 6 3 
					                                                      OpStore %9 %532 
					                                       f32_4 %533 = OpLoad %9 
					                                       f32_3 %534 = OpVectorShuffle %533 %533 0 1 2 
					                                       f32_3 %535 = OpExtInst %1 40 %534 %123 
					                                       f32_4 %536 = OpLoad %9 
					                                       f32_4 %537 = OpVectorShuffle %536 %535 4 5 6 3 
					                                                      OpStore %9 %537 
					                                Private f32* %539 = OpAccessChain %9 %30 
					                                         f32 %540 = OpLoad %539 
					                                Private f32* %541 = OpAccessChain %9 %118 
					                                         f32 %542 = OpLoad %541 
					                                        bool %543 = OpFOrdGreaterThanEqual %540 %542 
					                                                      OpStore %538 %543 
					                                        bool %545 = OpLoad %538 
					                                         f32 %546 = OpSelect %545 %497 %122 
					                                                      OpStore %544 %546 
					                                       f32_4 %547 = OpLoad %9 
					                                       f32_2 %548 = OpVectorShuffle %547 %547 2 1 
					                                       f32_4 %549 = OpLoad %28 
					                                       f32_4 %550 = OpVectorShuffle %549 %548 4 5 2 3 
					                                                      OpStore %28 %550 
					                                       f32_4 %551 = OpLoad %9 
					                                       f32_2 %552 = OpVectorShuffle %551 %551 1 2 
					                                       f32_4 %553 = OpLoad %28 
					                                       f32_2 %554 = OpVectorShuffle %553 %553 0 1 
					                                       f32_2 %555 = OpFNegate %554 
					                                       f32_2 %556 = OpFAdd %552 %555 
					                                       f32_4 %557 = OpLoad %163 
					                                       f32_4 %558 = OpVectorShuffle %557 %556 4 5 2 3 
					                                                      OpStore %163 %558 
					                                Private f32* %559 = OpAccessChain %28 %118 
					                                                      OpStore %559 %508 
					                                Private f32* %561 = OpAccessChain %28 %56 
					                                                      OpStore %561 %560 
					                                Private f32* %562 = OpAccessChain %163 %118 
					                                                      OpStore %562 %497 
					                                Private f32* %563 = OpAccessChain %163 %56 
					                                                      OpStore %563 %508 
					                                         f32 %564 = OpLoad %544 
					                                       f32_4 %565 = OpCompositeConstruct %564 %564 %564 %564 
					                                       f32_4 %566 = OpLoad %163 
					                                       f32_4 %567 = OpVectorShuffle %566 %566 0 1 3 2 
					                                       f32_4 %568 = OpFMul %565 %567 
					                                       f32_4 %569 = OpLoad %28 
					                                       f32_4 %570 = OpVectorShuffle %569 %569 0 1 3 2 
					                                       f32_4 %571 = OpFAdd %568 %570 
					                                                      OpStore %28 %571 
					                                Private f32* %572 = OpAccessChain %9 %34 
					                                         f32 %573 = OpLoad %572 
					                                Private f32* %574 = OpAccessChain %28 %34 
					                                         f32 %575 = OpLoad %574 
					                                        bool %576 = OpFOrdGreaterThanEqual %573 %575 
					                                                      OpStore %538 %576 
					                                        bool %577 = OpLoad %538 
					                                         f32 %578 = OpSelect %577 %497 %122 
					                                                      OpStore %544 %578 
					                                Private f32* %579 = OpAccessChain %28 %56 
					                                         f32 %580 = OpLoad %579 
					                                Private f32* %581 = OpAccessChain %163 %118 
					                                                      OpStore %581 %580 
					                                Private f32* %582 = OpAccessChain %9 %34 
					                                         f32 %583 = OpLoad %582 
					                                Private f32* %584 = OpAccessChain %28 %56 
					                                                      OpStore %584 %583 
					                                       f32_4 %586 = OpLoad %9 
					                                       f32_3 %587 = OpVectorShuffle %586 %586 0 1 2 
					                                         f32 %592 = OpDot %587 %591 
					                                Private f32* %593 = OpAccessChain %585 %34 
					                                                      OpStore %593 %592 
					                                       f32_4 %594 = OpLoad %28 
					                                       f32_3 %595 = OpVectorShuffle %594 %594 3 1 0 
					                                       f32_4 %596 = OpLoad %163 
					                                       f32_4 %597 = OpVectorShuffle %596 %595 4 5 2 6 
					                                                      OpStore %163 %597 
					                                       f32_4 %598 = OpLoad %28 
					                                       f32_4 %599 = OpFNegate %598 
					                                       f32_4 %600 = OpLoad %163 
					                                       f32_4 %601 = OpFAdd %599 %600 
					                                                      OpStore %163 %601 
					                                         f32 %602 = OpLoad %544 
					                                       f32_4 %603 = OpCompositeConstruct %602 %602 %602 %602 
					                                       f32_4 %604 = OpLoad %163 
					                                       f32_4 %605 = OpFMul %603 %604 
					                                       f32_4 %606 = OpLoad %28 
					                                       f32_4 %607 = OpFAdd %605 %606 
					                                                      OpStore %9 %607 
					                                Private f32* %608 = OpAccessChain %9 %30 
					                                         f32 %609 = OpLoad %608 
					                                Private f32* %610 = OpAccessChain %9 %56 
					                                         f32 %611 = OpLoad %610 
					                                         f32 %612 = OpExtInst %1 37 %609 %611 
					                                Private f32* %613 = OpAccessChain %28 %34 
					                                                      OpStore %613 %612 
					                                Private f32* %614 = OpAccessChain %9 %34 
					                                         f32 %615 = OpLoad %614 
					                                Private f32* %616 = OpAccessChain %28 %34 
					                                         f32 %617 = OpLoad %616 
					                                         f32 %618 = OpFNegate %617 
					                                         f32 %619 = OpFAdd %615 %618 
					                                Private f32* %620 = OpAccessChain %28 %34 
					                                                      OpStore %620 %619 
					                                Private f32* %621 = OpAccessChain %28 %34 
					                                         f32 %622 = OpLoad %621 
					                                         f32 %624 = OpFMul %622 %623 
					                                         f32 %626 = OpFAdd %624 %625 
					                                Private f32* %627 = OpAccessChain %280 %34 
					                                                      OpStore %627 %626 
					                                Private f32* %629 = OpAccessChain %9 %30 
					                                         f32 %630 = OpLoad %629 
					                                         f32 %631 = OpFNegate %630 
					                                Private f32* %632 = OpAccessChain %9 %56 
					                                         f32 %633 = OpLoad %632 
					                                         f32 %634 = OpFAdd %631 %633 
					                                Private f32* %635 = OpAccessChain %628 %34 
					                                                      OpStore %635 %634 
					                                Private f32* %636 = OpAccessChain %628 %34 
					                                         f32 %637 = OpLoad %636 
					                                Private f32* %638 = OpAccessChain %280 %34 
					                                         f32 %639 = OpLoad %638 
					                                         f32 %640 = OpFDiv %637 %639 
					                                Private f32* %641 = OpAccessChain %628 %34 
					                                                      OpStore %641 %640 
					                                Private f32* %642 = OpAccessChain %628 %34 
					                                         f32 %643 = OpLoad %642 
					                                Private f32* %644 = OpAccessChain %9 %118 
					                                         f32 %645 = OpLoad %644 
					                                         f32 %646 = OpFAdd %643 %645 
					                                Private f32* %647 = OpAccessChain %628 %34 
					                                                      OpStore %647 %646 
					                                Private f32* %648 = OpAccessChain %628 %34 
					                                         f32 %649 = OpLoad %648 
					                                         f32 %650 = OpExtInst %1 4 %649 
					                                Private f32* %651 = OpAccessChain %163 %34 
					                                                      OpStore %651 %650 
					                                Private f32* %654 = OpAccessChain %163 %34 
					                                         f32 %655 = OpLoad %654 
					                                Uniform f32* %656 = OpAccessChain %17 %237 %34 
					                                         f32 %657 = OpLoad %656 
					                                         f32 %658 = OpFAdd %655 %657 
					                                Private f32* %659 = OpAccessChain %653 %34 
					                                                      OpStore %659 %658 
					                                Private f32* %661 = OpAccessChain %585 %30 
					                                                      OpStore %661 %660 
					                                Private f32* %662 = OpAccessChain %653 %30 
					                                                      OpStore %662 %660 
					                         read_only Texture2D %666 = OpLoad %665 
					                                     sampler %670 = OpLoad %669 
					                  read_only Texture2DSampled %672 = OpSampledImage %666 %670 
					                                       f32_2 %673 = OpLoad %653 
					                                       f32_4 %674 = OpImageSampleExplicitLod %672 %673 Lod %7 
					                                         f32 %675 = OpCompositeExtract %674 0 
					                                Private f32* %676 = OpAccessChain %628 %34 
					                                                      OpStore %676 %675 
					                         read_only Texture2D %677 = OpLoad %665 
					                                     sampler %678 = OpLoad %669 
					                  read_only Texture2DSampled %679 = OpSampledImage %677 %678 
					                                       f32_3 %680 = OpLoad %585 
					                                       f32_2 %681 = OpVectorShuffle %680 %680 0 1 
					                                       f32_4 %682 = OpImageSampleExplicitLod %679 %681 Lod %7 
					                                         f32 %683 = OpCompositeExtract %682 3 
					                                Private f32* %684 = OpAccessChain %628 %30 
					                                                      OpStore %684 %683 
					                                       f32_3 %685 = OpLoad %628 
					                                       f32_2 %686 = OpVectorShuffle %685 %685 0 1 
					                                       f32_3 %687 = OpLoad %628 
					                                       f32_3 %688 = OpVectorShuffle %687 %686 3 4 2 
					                                                      OpStore %628 %688 
					                                       f32_3 %689 = OpLoad %628 
					                                       f32_2 %690 = OpVectorShuffle %689 %689 0 1 
					                                       f32_2 %691 = OpCompositeConstruct %122 %122 
					                                       f32_2 %692 = OpCompositeConstruct %497 %497 
					                                       f32_2 %693 = OpExtInst %1 43 %690 %691 %692 
					                                       f32_3 %694 = OpLoad %628 
					                                       f32_3 %695 = OpVectorShuffle %694 %693 3 4 2 
					                                                      OpStore %628 %695 
					                                Private f32* %696 = OpAccessChain %628 %34 
					                                         f32 %697 = OpLoad %696 
					                                         f32 %699 = OpFAdd %697 %698 
					                                Private f32* %700 = OpAccessChain %628 %34 
					                                                      OpStore %700 %699 
					                                Private f32* %701 = OpAccessChain %628 %34 
					                                         f32 %702 = OpLoad %701 
					                                Private f32* %703 = OpAccessChain %653 %34 
					                                         f32 %704 = OpLoad %703 
					                                         f32 %705 = OpFAdd %702 %704 
					                                Private f32* %706 = OpAccessChain %628 %34 
					                                                      OpStore %706 %705 
					                                Private f32* %707 = OpAccessChain %628 %34 
					                                         f32 %708 = OpLoad %707 
					                                        bool %709 = OpFOrdLessThan %497 %708 
					                                                      OpStore %538 %709 
					                                       f32_3 %710 = OpLoad %628 
					                                       f32_2 %711 = OpVectorShuffle %710 %710 0 0 
					                                       f32_2 %713 = OpFAdd %711 %712 
					                                       f32_3 %714 = OpLoad %280 
					                                       f32_3 %715 = OpVectorShuffle %714 %713 3 4 2 
					                                                      OpStore %280 %715 
					                                        bool %716 = OpLoad %538 
					                                                      OpSelectionMerge %719 None 
					                                                      OpBranchConditional %716 %718 %722 
					                                             %718 = OpLabel 
					                                Private f32* %720 = OpAccessChain %280 %30 
					                                         f32 %721 = OpLoad %720 
					                                                      OpStore %717 %721 
					                                                      OpBranch %719 
					                                             %722 = OpLabel 
					                                Private f32* %723 = OpAccessChain %628 %34 
					                                         f32 %724 = OpLoad %723 
					                                                      OpStore %717 %724 
					                                                      OpBranch %719 
					                                             %719 = OpLabel 
					                                         f32 %725 = OpLoad %717 
					                                                      OpStore %544 %725 
					                                Private f32* %727 = OpAccessChain %628 %34 
					                                         f32 %728 = OpLoad %727 
					                                        bool %729 = OpFOrdLessThan %728 %122 
					                                                      OpStore %726 %729 
					                                        bool %730 = OpLoad %726 
					                                                      OpSelectionMerge %733 None 
					                                                      OpBranchConditional %730 %732 %736 
					                                             %732 = OpLabel 
					                                Private f32* %734 = OpAccessChain %280 %34 
					                                         f32 %735 = OpLoad %734 
					                                                      OpStore %731 %735 
					                                                      OpBranch %733 
					                                             %736 = OpLabel 
					                                         f32 %737 = OpLoad %544 
					                                                      OpStore %731 %737 
					                                                      OpBranch %733 
					                                             %733 = OpLabel 
					                                         f32 %738 = OpLoad %731 
					                                Private f32* %739 = OpAccessChain %628 %34 
					                                                      OpStore %739 %738 
					                                       f32_3 %740 = OpLoad %628 
					                                       f32_3 %741 = OpVectorShuffle %740 %740 0 0 0 
					                                       f32_3 %744 = OpFAdd %741 %743 
					                                                      OpStore %280 %744 
					                                       f32_3 %745 = OpLoad %280 
					                                       f32_3 %746 = OpExtInst %1 10 %745 
					                                                      OpStore %280 %746 
					                                       f32_3 %747 = OpLoad %280 
					                                       f32_3 %749 = OpFMul %747 %748 
					                                       f32_3 %752 = OpFAdd %749 %751 
					                                                      OpStore %280 %752 
					                                       f32_3 %753 = OpLoad %280 
					                                       f32_3 %754 = OpExtInst %1 4 %753 
					                                       f32_3 %755 = OpFAdd %754 %509 
					                                                      OpStore %280 %755 
					                                       f32_3 %756 = OpLoad %280 
					                                       f32_3 %757 = OpCompositeConstruct %122 %122 %122 
					                                       f32_3 %758 = OpCompositeConstruct %497 %497 %497 
					                                       f32_3 %759 = OpExtInst %1 43 %756 %757 %758 
					                                                      OpStore %280 %759 
					                                       f32_3 %760 = OpLoad %280 
					                                       f32_3 %761 = OpFAdd %760 %509 
					                                                      OpStore %280 %761 
					                                Private f32* %762 = OpAccessChain %9 %34 
					                                         f32 %763 = OpLoad %762 
					                                         f32 %764 = OpFAdd %763 %625 
					                                Private f32* %765 = OpAccessChain %628 %34 
					                                                      OpStore %765 %764 
					                                Private f32* %767 = OpAccessChain %28 %34 
					                                         f32 %768 = OpLoad %767 
					                                Private f32* %769 = OpAccessChain %628 %34 
					                                         f32 %770 = OpLoad %769 
					                                         f32 %771 = OpFDiv %768 %770 
					                                Private f32* %772 = OpAccessChain %766 %34 
					                                                      OpStore %772 %771 
					                                       f32_2 %773 = OpLoad %766 
					                                       f32_3 %774 = OpVectorShuffle %773 %773 0 0 0 
					                                       f32_3 %775 = OpLoad %280 
					                                       f32_3 %776 = OpFMul %774 %775 
					                                       f32_3 %778 = OpFAdd %776 %777 
					                                       f32_4 %779 = OpLoad %28 
					                                       f32_4 %780 = OpVectorShuffle %779 %778 4 5 6 3 
					                                                      OpStore %28 %780 
					                                       f32_4 %781 = OpLoad %9 
					                                       f32_3 %782 = OpVectorShuffle %781 %781 0 0 0 
					                                       f32_4 %783 = OpLoad %28 
					                                       f32_3 %784 = OpVectorShuffle %783 %783 0 1 2 
					                                       f32_3 %785 = OpFMul %782 %784 
					                                                      OpStore %585 %785 
					                                       f32_3 %786 = OpLoad %585 
					                                         f32 %787 = OpDot %786 %591 
					                                Private f32* %788 = OpAccessChain %628 %34 
					                                                      OpStore %788 %787 
					                                       f32_4 %789 = OpLoad %9 
					                                       f32_3 %790 = OpVectorShuffle %789 %789 0 0 0 
					                                       f32_4 %791 = OpLoad %28 
					                                       f32_3 %792 = OpVectorShuffle %791 %791 0 1 2 
					                                       f32_3 %793 = OpFMul %790 %792 
					                                       f32_3 %794 = OpLoad %628 
					                                       f32_3 %795 = OpVectorShuffle %794 %794 0 0 0 
					                                       f32_3 %796 = OpFNegate %795 
					                                       f32_3 %797 = OpFAdd %793 %796 
					                                       f32_4 %798 = OpLoad %28 
					                                       f32_4 %799 = OpVectorShuffle %798 %797 4 5 6 3 
					                                                      OpStore %28 %799 
					                                Private f32* %800 = OpAccessChain %163 %30 
					                                                      OpStore %800 %660 
					                                Private f32* %801 = OpAccessChain %766 %30 
					                                                      OpStore %801 %660 
					                         read_only Texture2D %802 = OpLoad %665 
					                                     sampler %803 = OpLoad %669 
					                  read_only Texture2DSampled %804 = OpSampledImage %802 %803 
					                                       f32_4 %805 = OpLoad %163 
					                                       f32_2 %806 = OpVectorShuffle %805 %805 0 1 
					                                       f32_4 %807 = OpImageSampleExplicitLod %804 %806 Lod %7 
					                                         f32 %808 = OpCompositeExtract %807 1 
					                                Private f32* %809 = OpAccessChain %9 %34 
					                                                      OpStore %809 %808 
					                         read_only Texture2D %810 = OpLoad %665 
					                                     sampler %811 = OpLoad %669 
					                  read_only Texture2DSampled %812 = OpSampledImage %810 %811 
					                                       f32_2 %813 = OpLoad %766 
					                                       f32_4 %814 = OpImageSampleExplicitLod %812 %813 Lod %7 
					                                         f32 %815 = OpCompositeExtract %814 2 
					                                Private f32* %816 = OpAccessChain %9 %56 
					                                                      OpStore %816 %815 
					                                       f32_4 %817 = OpLoad %9 
					                                       f32_2 %818 = OpVectorShuffle %817 %817 0 3 
					                                       f32_4 %819 = OpLoad %9 
					                                       f32_4 %820 = OpVectorShuffle %819 %818 4 1 2 5 
					                                                      OpStore %9 %820 
					                                       f32_4 %821 = OpLoad %9 
					                                       f32_2 %822 = OpVectorShuffle %821 %821 0 3 
					                                       f32_2 %823 = OpCompositeConstruct %122 %122 
					                                       f32_2 %824 = OpCompositeConstruct %497 %497 
					                                       f32_2 %825 = OpExtInst %1 43 %822 %823 %824 
					                                       f32_4 %826 = OpLoad %9 
					                                       f32_4 %827 = OpVectorShuffle %826 %825 4 1 2 5 
					                                                      OpStore %9 %827 
					                                Private f32* %828 = OpAccessChain %9 %34 
					                                         f32 %829 = OpLoad %828 
					                                Private f32* %830 = OpAccessChain %9 %34 
					                                         f32 %831 = OpLoad %830 
					                                         f32 %832 = OpFAdd %829 %831 
					                                Private f32* %833 = OpAccessChain %9 %34 
					                                                      OpStore %833 %832 
					                                       f32_4 %834 = OpLoad %9 
					                                       f32_2 %835 = OpVectorShuffle %834 %834 3 3 
					                                       f32_4 %836 = OpLoad %9 
					                                       f32_2 %837 = OpVectorShuffle %836 %836 0 0 
					                                         f32 %838 = OpDot %835 %837 
					                                Private f32* %839 = OpAccessChain %9 %34 
					                                                      OpStore %839 %838 
					                                Private f32* %840 = OpAccessChain %9 %34 
					                                         f32 %841 = OpLoad %840 
					                                Private f32* %842 = OpAccessChain %628 %30 
					                                         f32 %843 = OpLoad %842 
					                                         f32 %844 = OpFMul %841 %843 
					                                Private f32* %845 = OpAccessChain %9 %34 
					                                                      OpStore %845 %844 
					                              Uniform f32_3* %846 = OpAccessChain %17 %237 
					                                       f32_3 %847 = OpLoad %846 
					                                       f32_2 %848 = OpVectorShuffle %847 %847 1 1 
					                                       f32_4 %849 = OpLoad %9 
					                                       f32_2 %850 = OpVectorShuffle %849 %849 0 0 
					                                         f32 %851 = OpDot %848 %850 
					                                Private f32* %852 = OpAccessChain %9 %34 
					                                                      OpStore %852 %851 
					                                       f32_4 %853 = OpLoad %9 
					                                       f32_3 %854 = OpVectorShuffle %853 %853 0 0 0 
					                                       f32_4 %855 = OpLoad %28 
					                                       f32_3 %856 = OpVectorShuffle %855 %855 0 1 2 
					                                       f32_3 %857 = OpFMul %854 %856 
					                                       f32_3 %858 = OpLoad %628 
					                                       f32_3 %859 = OpVectorShuffle %858 %858 0 0 0 
					                                       f32_3 %860 = OpFAdd %857 %859 
					                                       f32_4 %861 = OpLoad %9 
					                                       f32_4 %862 = OpVectorShuffle %861 %860 4 5 6 3 
					                                                      OpStore %9 %862 
					                                       f32_4 %867 = OpLoad %9 
					                                       f32_3 %868 = OpVectorShuffle %867 %867 0 1 2 
					                                         f32 %869 = OpDot %866 %868 
					                                Private f32* %870 = OpAccessChain %280 %34 
					                                                      OpStore %870 %869 
					                                       f32_4 %875 = OpLoad %9 
					                                       f32_3 %876 = OpVectorShuffle %875 %875 0 1 2 
					                                         f32 %877 = OpDot %874 %876 
					                                Private f32* %878 = OpAccessChain %280 %30 
					                                                      OpStore %878 %877 
					                                       f32_4 %883 = OpLoad %9 
					                                       f32_3 %884 = OpVectorShuffle %883 %883 0 1 2 
					                                         f32 %885 = OpDot %882 %884 
					                                Private f32* %886 = OpAccessChain %280 %118 
					                                                      OpStore %886 %885 
					                                       f32_3 %887 = OpLoad %280 
					                                       f32_3 %888 = OpVectorShuffle %887 %887 1 0 2 
					                                       f32_3 %889 = OpFNegate %888 
					                                       f32_3 %890 = OpLoad %280 
					                                       f32_3 %891 = OpVectorShuffle %890 %890 2 1 0 
					                                       f32_3 %892 = OpFAdd %889 %891 
					                                       f32_4 %893 = OpLoad %9 
					                                       f32_4 %894 = OpVectorShuffle %893 %892 4 5 6 3 
					                                                      OpStore %9 %894 
					                                       f32_4 %895 = OpLoad %9 
					                                       f32_2 %896 = OpVectorShuffle %895 %895 0 1 
					                                       f32_3 %897 = OpLoad %280 
					                                       f32_2 %898 = OpVectorShuffle %897 %897 2 1 
					                                       f32_2 %899 = OpFMul %896 %898 
					                                       f32_4 %900 = OpLoad %9 
					                                       f32_4 %901 = OpVectorShuffle %900 %899 4 5 2 3 
					                                                      OpStore %9 %901 
					                                Private f32* %902 = OpAccessChain %9 %30 
					                                         f32 %903 = OpLoad %902 
					                                Private f32* %904 = OpAccessChain %9 %34 
					                                         f32 %905 = OpLoad %904 
					                                         f32 %906 = OpFAdd %903 %905 
					                                Private f32* %907 = OpAccessChain %9 %34 
					                                                      OpStore %907 %906 
					                                Private f32* %908 = OpAccessChain %280 %34 
					                                         f32 %909 = OpLoad %908 
					                                Private f32* %910 = OpAccessChain %9 %118 
					                                         f32 %911 = OpLoad %910 
					                                         f32 %912 = OpFMul %909 %911 
					                                Private f32* %913 = OpAccessChain %9 %34 
					                                         f32 %914 = OpLoad %913 
					                                         f32 %915 = OpFAdd %912 %914 
					                                Private f32* %916 = OpAccessChain %9 %34 
					                                                      OpStore %916 %915 
					                                Private f32* %917 = OpAccessChain %9 %34 
					                                         f32 %918 = OpLoad %917 
					                                         f32 %919 = OpExtInst %1 31 %918 
					                                Private f32* %920 = OpAccessChain %9 %34 
					                                                      OpStore %920 %919 
					                                Private f32* %921 = OpAccessChain %280 %30 
					                                         f32 %922 = OpLoad %921 
					                                Private f32* %923 = OpAccessChain %280 %118 
					                                         f32 %924 = OpLoad %923 
					                                         f32 %925 = OpFAdd %922 %924 
					                                Private f32* %926 = OpAccessChain %628 %34 
					                                                      OpStore %926 %925 
					                                Private f32* %927 = OpAccessChain %280 %34 
					                                         f32 %928 = OpLoad %927 
					                                Private f32* %929 = OpAccessChain %628 %34 
					                                         f32 %930 = OpLoad %929 
					                                         f32 %931 = OpFAdd %928 %930 
					                                Private f32* %932 = OpAccessChain %628 %34 
					                                                      OpStore %932 %931 
					                                Private f32* %933 = OpAccessChain %9 %34 
					                                         f32 %934 = OpLoad %933 
					                                         f32 %936 = OpFMul %934 %935 
					                                Private f32* %937 = OpAccessChain %628 %34 
					                                         f32 %938 = OpLoad %937 
					                                         f32 %939 = OpFAdd %936 %938 
					                                Private f32* %940 = OpAccessChain %9 %34 
					                                                      OpStore %940 %939 
					                                Private f32* %941 = OpAccessChain %9 %34 
					                                         f32 %942 = OpLoad %941 
					                                         f32 %943 = OpFMul %942 %742 
					                                Private f32* %944 = OpAccessChain %628 %34 
					                                                      OpStore %944 %943 
					                                Private f32* %946 = OpAccessChain %628 %34 
					                                         f32 %947 = OpLoad %946 
					                                         f32 %948 = OpFDiv %945 %947 
					                                Private f32* %949 = OpAccessChain %628 %34 
					                                                      OpStore %949 %948 
					                                Private f32* %950 = OpAccessChain %280 %30 
					                                         f32 %951 = OpLoad %950 
					                                Private f32* %952 = OpAccessChain %280 %34 
					                                         f32 %953 = OpLoad %952 
					                                         f32 %954 = OpExtInst %1 37 %951 %953 
					                                                      OpStore %308 %954 
					                                Private f32* %955 = OpAccessChain %280 %118 
					                                         f32 %956 = OpLoad %955 
					                                         f32 %957 = OpLoad %308 
					                                         f32 %958 = OpExtInst %1 37 %956 %957 
					                                                      OpStore %308 %958 
					                                         f32 %959 = OpLoad %308 
					                                         f32 %960 = OpExtInst %1 40 %959 %625 
					                                                      OpStore %308 %960 
					                                Private f32* %961 = OpAccessChain %280 %30 
					                                         f32 %962 = OpLoad %961 
					                                Private f32* %963 = OpAccessChain %280 %34 
					                                         f32 %964 = OpLoad %963 
					                                         f32 %965 = OpExtInst %1 40 %962 %964 
					                                                      OpStore %544 %965 
					                                Private f32* %966 = OpAccessChain %280 %118 
					                                         f32 %967 = OpLoad %966 
					                                         f32 %968 = OpLoad %544 
					                                         f32 %969 = OpExtInst %1 40 %967 %968 
					                                                      OpStore %544 %969 
					                                         f32 %970 = OpLoad %544 
					                                       f32_2 %971 = OpCompositeConstruct %970 %970 
					                                       f32_2 %974 = OpExtInst %1 40 %971 %973 
					                                       f32_4 %975 = OpLoad %163 
					                                       f32_4 %976 = OpVectorShuffle %975 %974 4 5 2 3 
					                                                      OpStore %163 %976 
					                                         f32 %977 = OpLoad %308 
					                                         f32 %978 = OpFNegate %977 
					                                Private f32* %979 = OpAccessChain %163 %34 
					                                         f32 %980 = OpLoad %979 
					                                         f32 %981 = OpFAdd %978 %980 
					                                                      OpStore %308 %981 
					                                         f32 %982 = OpLoad %308 
					                                Private f32* %983 = OpAccessChain %163 %30 
					                                         f32 %984 = OpLoad %983 
					                                         f32 %985 = OpFDiv %982 %984 
					                                Private f32* %986 = OpAccessChain %628 %30 
					                                                      OpStore %986 %985 
					                                       f32_3 %987 = OpLoad %628 
					                                       f32_2 %988 = OpVectorShuffle %987 %987 0 1 
					                                       f32_2 %991 = OpFAdd %988 %990 
					                                       f32_3 %992 = OpLoad %628 
					                                       f32_3 %993 = OpVectorShuffle %992 %991 3 1 4 
					                                                      OpStore %628 %993 
					                                Private f32* %994 = OpAccessChain %628 %118 
					                                         f32 %995 = OpLoad %994 
					                                         f32 %997 = OpFMul %995 %996 
					                                Private f32* %998 = OpAccessChain %28 %34 
					                                                      OpStore %998 %997 
					                                Private f32* %999 = OpAccessChain %628 %118 
					                                        f32 %1000 = OpLoad %999 
					                                        f32 %1002 = OpBitcast %1001 
					                                        f32 %1003 = OpFMul %1000 %1002 
					                                        f32 %1004 = OpFAdd %1003 %136 
					                                                      OpStore %544 %1004 
					                                        f32 %1005 = OpLoad %544 
					                                        f32 %1006 = OpExtInst %1 43 %1005 %122 %497 
					                                                      OpStore %544 %1006 
					                                        f32 %1007 = OpLoad %544 
					                                        f32 %1008 = OpFMul %1007 %505 
					                                        f32 %1009 = OpFAdd %1008 %508 
					                                                      OpStore %544 %1009 
					                               Private f32* %1010 = OpAccessChain %28 %34 
					                                        f32 %1011 = OpLoad %1010 
					                                        f32 %1012 = OpExtInst %1 4 %1011 
					                                        f32 %1013 = OpFNegate %1012 
					                                        f32 %1014 = OpFAdd %1013 %497 
					                               Private f32* %1015 = OpAccessChain %28 %34 
					                                                      OpStore %1015 %1014 
					                               Private f32* %1016 = OpAccessChain %28 %34 
					                                        f32 %1017 = OpLoad %1016 
					                                        f32 %1018 = OpExtInst %1 40 %1017 %122 
					                               Private f32* %1019 = OpAccessChain %28 %34 
					                                                      OpStore %1019 %1018 
					                               Private f32* %1020 = OpAccessChain %28 %34 
					                                        f32 %1021 = OpLoad %1020 
					                                        f32 %1022 = OpFNegate %1021 
					                               Private f32* %1023 = OpAccessChain %28 %34 
					                                        f32 %1024 = OpLoad %1023 
					                                        f32 %1025 = OpFMul %1022 %1024 
					                                        f32 %1026 = OpFAdd %1025 %497 
					                               Private f32* %1027 = OpAccessChain %28 %34 
					                                                      OpStore %1027 %1026 
					                                        f32 %1028 = OpLoad %544 
					                               Private f32* %1029 = OpAccessChain %28 %34 
					                                        f32 %1030 = OpLoad %1029 
					                                        f32 %1031 = OpFMul %1028 %1030 
					                                        f32 %1032 = OpFAdd %1031 %497 
					                                                      OpStore %544 %1032 
					                                        f32 %1033 = OpLoad %544 
					                                        f32 %1035 = OpFMul %1033 %1034 
					                                                      OpStore %544 %1035 
					                               Private f32* %1036 = OpAccessChain %628 %34 
					                                        f32 %1037 = OpLoad %1036 
					                                        f32 %1038 = OpLoad %544 
					                                        f32 %1039 = OpFMul %1037 %1038 
					                               Private f32* %1040 = OpAccessChain %628 %34 
					                                                      OpStore %1040 %1039 
					                               Private f32* %1041 = OpAccessChain %9 %34 
					                                        f32 %1042 = OpLoad %1041 
					                                       bool %1044 = OpFOrdGreaterThanEqual %1042 %1043 
					                              Private bool* %1045 = OpAccessChain %249 %34 
					                                                      OpStore %1045 %1044 
					                               Private f32* %1047 = OpAccessChain %9 %34 
					                                        f32 %1048 = OpLoad %1047 
					                                       bool %1049 = OpFOrdGreaterThanEqual %1046 %1048 
					                              Private bool* %1050 = OpAccessChain %172 %34 
					                                                      OpStore %1050 %1049 
					                              Private bool* %1051 = OpAccessChain %249 %34 
					                                       bool %1052 = OpLoad %1051 
					                                                      OpSelectionMerge %1055 None 
					                                                      OpBranchConditional %1052 %1054 %1056 
					                                            %1054 = OpLabel 
					                                                      OpStore %1053 %122 
					                                                      OpBranch %1055 
					                                            %1056 = OpLabel 
					                               Private f32* %1057 = OpAccessChain %628 %34 
					                                        f32 %1058 = OpLoad %1057 
					                                                      OpStore %1053 %1058 
					                                                      OpBranch %1055 
					                                            %1055 = OpLabel 
					                                        f32 %1059 = OpLoad %1053 
					                               Private f32* %1060 = OpAccessChain %628 %34 
					                                                      OpStore %1060 %1059 
					                              Private bool* %1061 = OpAccessChain %172 %34 
					                                       bool %1062 = OpLoad %1061 
					                                                      OpSelectionMerge %1065 None 
					                                                      OpBranchConditional %1062 %1064 %1067 
					                                            %1064 = OpLabel 
					                                        f32 %1066 = OpLoad %544 
					                                                      OpStore %1063 %1066 
					                                                      OpBranch %1065 
					                                            %1067 = OpLabel 
					                               Private f32* %1068 = OpAccessChain %628 %34 
					                                        f32 %1069 = OpLoad %1068 
					                                                      OpStore %1063 %1069 
					                                                      OpBranch %1065 
					                                            %1065 = OpLabel 
					                                        f32 %1070 = OpLoad %1063 
					                               Private f32* %1071 = OpAccessChain %9 %34 
					                                                      OpStore %1071 %1070 
					                               Private f32* %1072 = OpAccessChain %9 %34 
					                                        f32 %1073 = OpLoad %1072 
					                                        f32 %1074 = OpFAdd %1073 %497 
					                               Private f32* %1075 = OpAccessChain %9 %34 
					                                                      OpStore %1075 %1074 
					                                      f32_4 %1076 = OpLoad %9 
					                                      f32_3 %1077 = OpVectorShuffle %1076 %1076 0 0 0 
					                                      f32_3 %1078 = OpLoad %280 
					                                      f32_3 %1079 = OpFMul %1077 %1078 
					                                      f32_4 %1080 = OpLoad %163 
					                                      f32_4 %1081 = OpVectorShuffle %1080 %1079 0 4 5 6 
					                                                      OpStore %163 %1081 
					                               Private f32* %1082 = OpAccessChain %280 %34 
					                                        f32 %1083 = OpLoad %1082 
					                                        f32 %1084 = OpFNegate %1083 
					                               Private f32* %1085 = OpAccessChain %9 %34 
					                                        f32 %1086 = OpLoad %1085 
					                                        f32 %1087 = OpFMul %1084 %1086 
					                                        f32 %1089 = OpFAdd %1087 %1088 
					                               Private f32* %1090 = OpAccessChain %628 %34 
					                                                      OpStore %1090 %1089 
					                               Private f32* %1091 = OpAccessChain %280 %30 
					                                        f32 %1092 = OpLoad %1091 
					                               Private f32* %1093 = OpAccessChain %9 %34 
					                                        f32 %1094 = OpLoad %1093 
					                                        f32 %1095 = OpFMul %1092 %1094 
					                               Private f32* %1096 = OpAccessChain %163 %56 
					                                        f32 %1097 = OpLoad %1096 
					                                        f32 %1098 = OpFNegate %1097 
					                                        f32 %1099 = OpFAdd %1095 %1098 
					                                                      OpStore %544 %1099 
					                                        f32 %1100 = OpLoad %544 
					                                        f32 %1102 = OpFMul %1100 %1101 
					                                                      OpStore %544 %1102 
					                               Private f32* %1103 = OpAccessChain %163 %30 
					                                        f32 %1104 = OpLoad %1103 
					                                        f32 %1105 = OpFMul %1104 %505 
					                               Private f32* %1106 = OpAccessChain %163 %118 
					                                        f32 %1107 = OpLoad %1106 
					                                        f32 %1108 = OpFNegate %1107 
					                                        f32 %1109 = OpFAdd %1105 %1108 
					                               Private f32* %1110 = OpAccessChain %28 %34 
					                                                      OpStore %1110 %1109 
					                               Private f32* %1111 = OpAccessChain %280 %118 
					                                        f32 %1112 = OpLoad %1111 
					                                        f32 %1113 = OpFNegate %1112 
					                               Private f32* %1114 = OpAccessChain %9 %34 
					                                        f32 %1115 = OpLoad %1114 
					                                        f32 %1116 = OpFMul %1113 %1115 
					                               Private f32* %1117 = OpAccessChain %28 %34 
					                                        f32 %1118 = OpLoad %1117 
					                                        f32 %1119 = OpFAdd %1116 %1118 
					                               Private f32* %1120 = OpAccessChain %9 %34 
					                                                      OpStore %1120 %1119 
					                               Private f32* %1121 = OpAccessChain %9 %34 
					                                        f32 %1122 = OpLoad %1121 
					                                        f32 %1123 = OpExtInst %1 4 %1122 
					                                        f32 %1124 = OpLoad %544 
					                                        f32 %1125 = OpExtInst %1 4 %1124 
					                                        f32 %1126 = OpExtInst %1 40 %1123 %1125 
					                               Private f32* %1127 = OpAccessChain %28 %34 
					                                                      OpStore %1127 %1126 
					                               Private f32* %1128 = OpAccessChain %28 %34 
					                                        f32 %1129 = OpLoad %1128 
					                                        f32 %1130 = OpFDiv %497 %1129 
					                               Private f32* %1131 = OpAccessChain %28 %34 
					                                                      OpStore %1131 %1130 
					                               Private f32* %1132 = OpAccessChain %9 %34 
					                                        f32 %1133 = OpLoad %1132 
					                                        f32 %1134 = OpExtInst %1 4 %1133 
					                                        f32 %1135 = OpLoad %544 
					                                        f32 %1136 = OpExtInst %1 4 %1135 
					                                        f32 %1137 = OpExtInst %1 37 %1134 %1136 
					                               Private f32* %1138 = OpAccessChain %280 %34 
					                                                      OpStore %1138 %1137 
					                               Private f32* %1139 = OpAccessChain %28 %34 
					                                        f32 %1140 = OpLoad %1139 
					                               Private f32* %1141 = OpAccessChain %280 %34 
					                                        f32 %1142 = OpLoad %1141 
					                                        f32 %1143 = OpFMul %1140 %1142 
					                               Private f32* %1144 = OpAccessChain %28 %34 
					                                                      OpStore %1144 %1143 
					                               Private f32* %1145 = OpAccessChain %28 %34 
					                                        f32 %1146 = OpLoad %1145 
					                               Private f32* %1147 = OpAccessChain %28 %34 
					                                        f32 %1148 = OpLoad %1147 
					                                        f32 %1149 = OpFMul %1146 %1148 
					                               Private f32* %1150 = OpAccessChain %280 %34 
					                                                      OpStore %1150 %1149 
					                               Private f32* %1152 = OpAccessChain %280 %34 
					                                        f32 %1153 = OpLoad %1152 
					                                        f32 %1155 = OpFMul %1153 %1154 
					                                        f32 %1157 = OpFAdd %1155 %1156 
					                                                      OpStore %1151 %1157 
					                               Private f32* %1158 = OpAccessChain %280 %34 
					                                        f32 %1159 = OpLoad %1158 
					                                        f32 %1160 = OpLoad %1151 
					                                        f32 %1161 = OpFMul %1159 %1160 
					                                        f32 %1163 = OpFAdd %1161 %1162 
					                                                      OpStore %1151 %1163 
					                               Private f32* %1164 = OpAccessChain %280 %34 
					                                        f32 %1165 = OpLoad %1164 
					                                        f32 %1166 = OpLoad %1151 
					                                        f32 %1167 = OpFMul %1165 %1166 
					                                        f32 %1169 = OpFAdd %1167 %1168 
					                                                      OpStore %1151 %1169 
					                               Private f32* %1170 = OpAccessChain %280 %34 
					                                        f32 %1171 = OpLoad %1170 
					                                        f32 %1172 = OpLoad %1151 
					                                        f32 %1173 = OpFMul %1171 %1172 
					                                        f32 %1175 = OpFAdd %1173 %1174 
					                               Private f32* %1176 = OpAccessChain %280 %34 
					                                                      OpStore %1176 %1175 
					                               Private f32* %1177 = OpAccessChain %280 %34 
					                                        f32 %1178 = OpLoad %1177 
					                               Private f32* %1179 = OpAccessChain %28 %34 
					                                        f32 %1180 = OpLoad %1179 
					                                        f32 %1181 = OpFMul %1178 %1180 
					                                                      OpStore %1151 %1181 
					                                        f32 %1182 = OpLoad %1151 
					                                        f32 %1184 = OpFMul %1182 %1183 
					                                        f32 %1186 = OpFAdd %1184 %1185 
					                                                      OpStore %1151 %1186 
					                               Private f32* %1188 = OpAccessChain %9 %34 
					                                        f32 %1189 = OpLoad %1188 
					                                        f32 %1190 = OpExtInst %1 4 %1189 
					                                        f32 %1191 = OpLoad %544 
					                                        f32 %1192 = OpExtInst %1 4 %1191 
					                                       bool %1193 = OpFOrdLessThan %1190 %1192 
					                                                      OpStore %1187 %1193 
					                                       bool %1194 = OpLoad %1187 
					                                        f32 %1195 = OpLoad %1151 
					                                        f32 %1196 = OpSelect %1194 %1195 %122 
					                                                      OpStore %1151 %1196 
					                               Private f32* %1197 = OpAccessChain %28 %34 
					                                        f32 %1198 = OpLoad %1197 
					                               Private f32* %1199 = OpAccessChain %280 %34 
					                                        f32 %1200 = OpLoad %1199 
					                                        f32 %1201 = OpFMul %1198 %1200 
					                                        f32 %1202 = OpLoad %1151 
					                                        f32 %1203 = OpFAdd %1201 %1202 
					                               Private f32* %1204 = OpAccessChain %28 %34 
					                                                      OpStore %1204 %1203 
					                               Private f32* %1206 = OpAccessChain %9 %34 
					                                        f32 %1207 = OpLoad %1206 
					                               Private f32* %1208 = OpAccessChain %9 %34 
					                                        f32 %1209 = OpLoad %1208 
					                                        f32 %1210 = OpFNegate %1209 
					                                       bool %1211 = OpFOrdLessThan %1207 %1210 
					                                                      OpStore %1205 %1211 
					                                       bool %1212 = OpLoad %1205 
					                                        f32 %1214 = OpSelect %1212 %1213 %122 
					                               Private f32* %1215 = OpAccessChain %280 %34 
					                                                      OpStore %1215 %1214 
					                               Private f32* %1216 = OpAccessChain %280 %34 
					                                        f32 %1217 = OpLoad %1216 
					                               Private f32* %1218 = OpAccessChain %28 %34 
					                                        f32 %1219 = OpLoad %1218 
					                                        f32 %1220 = OpFAdd %1217 %1219 
					                               Private f32* %1221 = OpAccessChain %28 %34 
					                                                      OpStore %1221 %1220 
					                               Private f32* %1222 = OpAccessChain %9 %34 
					                                        f32 %1223 = OpLoad %1222 
					                                        f32 %1224 = OpLoad %544 
					                                        f32 %1225 = OpExtInst %1 37 %1223 %1224 
					                               Private f32* %1226 = OpAccessChain %280 %34 
					                                                      OpStore %1226 %1225 
					                               Private f32* %1227 = OpAccessChain %9 %34 
					                                        f32 %1228 = OpLoad %1227 
					                                        f32 %1229 = OpLoad %544 
					                                        f32 %1230 = OpExtInst %1 40 %1228 %1229 
					                               Private f32* %1231 = OpAccessChain %9 %34 
					                                                      OpStore %1231 %1230 
					                               Private f32* %1232 = OpAccessChain %9 %34 
					                                        f32 %1233 = OpLoad %1232 
					                               Private f32* %1234 = OpAccessChain %9 %34 
					                                        f32 %1235 = OpLoad %1234 
					                                        f32 %1236 = OpFNegate %1235 
					                                       bool %1237 = OpFOrdGreaterThanEqual %1233 %1236 
					                              Private bool* %1238 = OpAccessChain %172 %34 
					                                                      OpStore %1238 %1237 
					                               Private f32* %1239 = OpAccessChain %280 %34 
					                                        f32 %1240 = OpLoad %1239 
					                               Private f32* %1241 = OpAccessChain %280 %34 
					                                        f32 %1242 = OpLoad %1241 
					                                        f32 %1243 = OpFNegate %1242 
					                                       bool %1244 = OpFOrdLessThan %1240 %1243 
					                                                      OpStore %538 %1244 
					                              Private bool* %1245 = OpAccessChain %172 %34 
					                                       bool %1246 = OpLoad %1245 
					                                       bool %1247 = OpLoad %538 
					                                       bool %1248 = OpLogicalAnd %1246 %1247 
					                              Private bool* %1249 = OpAccessChain %172 %34 
					                                                      OpStore %1249 %1248 
					                              Private bool* %1250 = OpAccessChain %172 %34 
					                                       bool %1251 = OpLoad %1250 
					                                                      OpSelectionMerge %1254 None 
					                                                      OpBranchConditional %1251 %1253 %1258 
					                                            %1253 = OpLabel 
					                               Private f32* %1255 = OpAccessChain %28 %34 
					                                        f32 %1256 = OpLoad %1255 
					                                        f32 %1257 = OpFNegate %1256 
					                                                      OpStore %1252 %1257 
					                                                      OpBranch %1254 
					                                            %1258 = OpLabel 
					                               Private f32* %1259 = OpAccessChain %28 %34 
					                                        f32 %1260 = OpLoad %1259 
					                                                      OpStore %1252 %1260 
					                                                      OpBranch %1254 
					                                            %1254 = OpLabel 
					                                        f32 %1261 = OpLoad %1252 
					                               Private f32* %1262 = OpAccessChain %9 %34 
					                                                      OpStore %1262 %1261 
					                               Private f32* %1263 = OpAccessChain %9 %34 
					                                        f32 %1264 = OpLoad %1263 
					                                        f32 %1266 = OpFMul %1264 %1265 
					                               Private f32* %1267 = OpAccessChain %9 %34 
					                                                      OpStore %1267 %1266 
					                                      f32_4 %1268 = OpLoad %163 
					                                      f32_4 %1269 = OpVectorShuffle %1268 %1268 2 3 2 2 
					                                      f32_4 %1270 = OpLoad %163 
					                                      f32_4 %1271 = OpVectorShuffle %1270 %1270 1 2 1 1 
					                                     bool_4 %1272 = OpFOrdEqual %1269 %1271 
					                                     bool_2 %1273 = OpVectorShuffle %1272 %1272 0 1 
					                                     bool_4 %1274 = OpLoad %249 
					                                     bool_4 %1275 = OpVectorShuffle %1274 %1273 4 5 2 3 
					                                                      OpStore %249 %1275 
					                              Private bool* %1276 = OpAccessChain %249 %30 
					                                       bool %1277 = OpLoad %1276 
					                              Private bool* %1278 = OpAccessChain %249 %34 
					                                       bool %1279 = OpLoad %1278 
					                                       bool %1280 = OpLogicalAnd %1277 %1279 
					                                                      OpStore %538 %1280 
					                                       bool %1281 = OpLoad %538 
					                                                      OpSelectionMerge %1284 None 
					                                                      OpBranchConditional %1281 %1283 %1285 
					                                            %1283 = OpLabel 
					                                                      OpStore %1282 %122 
					                                                      OpBranch %1284 
					                                            %1285 = OpLabel 
					                               Private f32* %1286 = OpAccessChain %9 %34 
					                                        f32 %1287 = OpLoad %1286 
					                                                      OpStore %1282 %1287 
					                                                      OpBranch %1284 
					                                            %1284 = OpLabel 
					                                        f32 %1288 = OpLoad %1282 
					                               Private f32* %1289 = OpAccessChain %9 %34 
					                                                      OpStore %1289 %1288 
					                               Private f32* %1290 = OpAccessChain %9 %34 
					                                        f32 %1291 = OpLoad %1290 
					                                       bool %1292 = OpFOrdLessThan %1291 %122 
					                                                      OpStore %538 %1292 
					                               Private f32* %1293 = OpAccessChain %9 %34 
					                                        f32 %1294 = OpLoad %1293 
					                                        f32 %1296 = OpFAdd %1294 %1295 
					                               Private f32* %1297 = OpAccessChain %28 %34 
					                                                      OpStore %1297 %1296 
					                                       bool %1298 = OpLoad %538 
					                                                      OpSelectionMerge %1301 None 
					                                                      OpBranchConditional %1298 %1300 %1304 
					                                            %1300 = OpLabel 
					                               Private f32* %1302 = OpAccessChain %28 %34 
					                                        f32 %1303 = OpLoad %1302 
					                                                      OpStore %1299 %1303 
					                                                      OpBranch %1301 
					                                            %1304 = OpLabel 
					                               Private f32* %1305 = OpAccessChain %9 %34 
					                                        f32 %1306 = OpLoad %1305 
					                                                      OpStore %1299 %1306 
					                                                      OpBranch %1301 
					                                            %1301 = OpLabel 
					                                        f32 %1307 = OpLoad %1299 
					                               Private f32* %1308 = OpAccessChain %9 %34 
					                                                      OpStore %1308 %1307 
					                               Private f32* %1310 = OpAccessChain %9 %34 
					                                        f32 %1311 = OpLoad %1310 
					                                       bool %1312 = OpFOrdLessThan %1309 %1311 
					                                                      OpStore %538 %1312 
					                                      f32_4 %1313 = OpLoad %9 
					                                      f32_2 %1314 = OpVectorShuffle %1313 %1313 0 0 
					                                      f32_2 %1317 = OpFAdd %1314 %1316 
					                                      f32_4 %1318 = OpLoad %28 
					                                      f32_4 %1319 = OpVectorShuffle %1318 %1317 4 5 2 3 
					                                                      OpStore %28 %1319 
					                                       bool %1320 = OpLoad %538 
					                                                      OpSelectionMerge %1323 None 
					                                                      OpBranchConditional %1320 %1322 %1326 
					                                            %1322 = OpLabel 
					                               Private f32* %1324 = OpAccessChain %28 %30 
					                                        f32 %1325 = OpLoad %1324 
					                                                      OpStore %1321 %1325 
					                                                      OpBranch %1323 
					                                            %1326 = OpLabel 
					                               Private f32* %1327 = OpAccessChain %9 %34 
					                                        f32 %1328 = OpLoad %1327 
					                                                      OpStore %1321 %1328 
					                                                      OpBranch %1323 
					                                            %1323 = OpLabel 
					                                        f32 %1329 = OpLoad %1321 
					                                                      OpStore %544 %1329 
					                               Private f32* %1330 = OpAccessChain %9 %34 
					                                        f32 %1331 = OpLoad %1330 
					                                       bool %1333 = OpFOrdLessThan %1331 %1332 
					                              Private bool* %1334 = OpAccessChain %172 %34 
					                                                      OpStore %1334 %1333 
					                              Private bool* %1335 = OpAccessChain %172 %34 
					                                       bool %1336 = OpLoad %1335 
					                                                      OpSelectionMerge %1339 None 
					                                                      OpBranchConditional %1336 %1338 %1342 
					                                            %1338 = OpLabel 
					                               Private f32* %1340 = OpAccessChain %28 %34 
					                                        f32 %1341 = OpLoad %1340 
					                                                      OpStore %1337 %1341 
					                                                      OpBranch %1339 
					                                            %1342 = OpLabel 
					                                        f32 %1343 = OpLoad %544 
					                                                      OpStore %1337 %1343 
					                                                      OpBranch %1339 
					                                            %1339 = OpLabel 
					                                        f32 %1344 = OpLoad %1337 
					                               Private f32* %1345 = OpAccessChain %9 %34 
					                                                      OpStore %1345 %1344 
					                               Private f32* %1346 = OpAccessChain %9 %34 
					                                        f32 %1347 = OpLoad %1346 
					                                        f32 %1349 = OpFMul %1347 %1348 
					                               Private f32* %1350 = OpAccessChain %9 %34 
					                                                      OpStore %1350 %1349 
					                               Private f32* %1351 = OpAccessChain %9 %34 
					                                        f32 %1352 = OpLoad %1351 
					                                        f32 %1353 = OpExtInst %1 4 %1352 
					                                        f32 %1354 = OpFNegate %1353 
					                                        f32 %1355 = OpFAdd %1354 %497 
					                               Private f32* %1356 = OpAccessChain %9 %34 
					                                                      OpStore %1356 %1355 
					                               Private f32* %1357 = OpAccessChain %9 %34 
					                                        f32 %1358 = OpLoad %1357 
					                                        f32 %1359 = OpExtInst %1 40 %1358 %122 
					                               Private f32* %1360 = OpAccessChain %9 %34 
					                                                      OpStore %1360 %1359 
					                               Private f32* %1361 = OpAccessChain %9 %34 
					                                        f32 %1362 = OpLoad %1361 
					                                        f32 %1363 = OpFMul %1362 %1183 
					                                        f32 %1365 = OpFAdd %1363 %1364 
					                                                      OpStore %544 %1365 
					                               Private f32* %1366 = OpAccessChain %9 %34 
					                                        f32 %1367 = OpLoad %1366 
					                               Private f32* %1368 = OpAccessChain %9 %34 
					                                        f32 %1369 = OpLoad %1368 
					                                        f32 %1370 = OpFMul %1367 %1369 
					                               Private f32* %1371 = OpAccessChain %9 %34 
					                                                      OpStore %1371 %1370 
					                               Private f32* %1372 = OpAccessChain %9 %34 
					                                        f32 %1373 = OpLoad %1372 
					                                        f32 %1374 = OpLoad %544 
					                                        f32 %1375 = OpFMul %1373 %1374 
					                               Private f32* %1376 = OpAccessChain %9 %34 
					                                                      OpStore %1376 %1375 
					                               Private f32* %1377 = OpAccessChain %9 %34 
					                                        f32 %1378 = OpLoad %1377 
					                               Private f32* %1379 = OpAccessChain %9 %34 
					                                        f32 %1380 = OpLoad %1379 
					                                        f32 %1381 = OpFMul %1378 %1380 
					                               Private f32* %1382 = OpAccessChain %9 %34 
					                                                      OpStore %1382 %1381 
					                               Private f32* %1383 = OpAccessChain %628 %30 
					                                        f32 %1384 = OpLoad %1383 
					                               Private f32* %1385 = OpAccessChain %9 %34 
					                                        f32 %1386 = OpLoad %1385 
					                                        f32 %1387 = OpFMul %1384 %1386 
					                               Private f32* %1388 = OpAccessChain %9 %34 
					                                                      OpStore %1388 %1387 
					                               Private f32* %1389 = OpAccessChain %628 %34 
					                                        f32 %1390 = OpLoad %1389 
					                               Private f32* %1391 = OpAccessChain %9 %34 
					                                        f32 %1392 = OpLoad %1391 
					                                        f32 %1393 = OpFMul %1390 %1392 
					                               Private f32* %1394 = OpAccessChain %9 %34 
					                                                      OpStore %1394 %1393 
					                               Private f32* %1395 = OpAccessChain %9 %34 
					                                        f32 %1396 = OpLoad %1395 
					                                        f32 %1398 = OpFMul %1396 %1397 
					                               Private f32* %1399 = OpAccessChain %163 %30 
					                                        f32 %1400 = OpLoad %1399 
					                                        f32 %1401 = OpFAdd %1398 %1400 
					                               Private f32* %1402 = OpAccessChain %163 %34 
					                                                      OpStore %1402 %1401 
					                                      f32_4 %1403 = OpLoad %163 
					                                      f32_3 %1404 = OpVectorShuffle %1403 %1403 0 2 3 
					                                        f32 %1405 = OpDot %363 %1404 
					                               Private f32* %1406 = OpAccessChain %9 %34 
					                                                      OpStore %1406 %1405 
					                                      f32_4 %1407 = OpLoad %163 
					                                      f32_3 %1408 = OpVectorShuffle %1407 %1407 0 2 3 
					                                        f32 %1409 = OpDot %371 %1408 
					                               Private f32* %1410 = OpAccessChain %9 %30 
					                                                      OpStore %1410 %1409 
					                                      f32_4 %1411 = OpLoad %163 
					                                      f32_3 %1412 = OpVectorShuffle %1411 %1411 0 2 3 
					                                        f32 %1413 = OpDot %379 %1412 
					                               Private f32* %1414 = OpAccessChain %9 %118 
					                                                      OpStore %1414 %1413 
					                                      f32_4 %1415 = OpLoad %9 
					                                      f32_3 %1416 = OpVectorShuffle %1415 %1415 0 1 2 
					                                      f32_3 %1417 = OpExtInst %1 40 %1416 %123 
					                                      f32_4 %1418 = OpLoad %9 
					                                      f32_4 %1419 = OpVectorShuffle %1418 %1417 4 5 6 3 
					                                                      OpStore %9 %1419 
					                                      f32_4 %1420 = OpLoad %9 
					                                      f32_3 %1421 = OpVectorShuffle %1420 %1420 0 1 2 
					                                        f32 %1426 = OpDot %1421 %1425 
					                                                      OpStore %544 %1426 
					                                        f32 %1427 = OpLoad %544 
					                                      f32_3 %1428 = OpCompositeConstruct %1427 %1427 %1427 
					                                      f32_3 %1429 = OpFNegate %1428 
					                                      f32_4 %1430 = OpLoad %9 
					                                      f32_3 %1431 = OpVectorShuffle %1430 %1430 0 1 2 
					                                      f32_3 %1432 = OpFAdd %1429 %1431 
					                                      f32_4 %1433 = OpLoad %9 
					                                      f32_4 %1434 = OpVectorShuffle %1433 %1432 4 5 6 3 
					                                                      OpStore %9 %1434 
					                                      f32_4 %1435 = OpLoad %9 
					                                      f32_3 %1436 = OpVectorShuffle %1435 %1435 0 1 2 
					                                      f32_3 %1439 = OpFMul %1436 %1438 
					                                        f32 %1440 = OpLoad %544 
					                                      f32_3 %1441 = OpCompositeConstruct %1440 %1440 %1440 
					                                      f32_3 %1442 = OpFAdd %1439 %1441 
					                                      f32_4 %1443 = OpLoad %9 
					                                      f32_4 %1444 = OpVectorShuffle %1443 %1442 4 5 6 3 
					                                                      OpStore %9 %1444 
					                                      f32_4 %1445 = OpLoad %9 
					                                      f32_3 %1446 = OpVectorShuffle %1445 %1445 0 1 2 
					                                      f32_3 %1449 = OpFMul %1446 %1448 
					                                      f32_3 %1452 = OpFAdd %1449 %1451 
					                                      f32_4 %1453 = OpLoad %28 
					                                      f32_4 %1454 = OpVectorShuffle %1453 %1452 4 5 6 3 
					                                                      OpStore %28 %1454 
					                                      f32_4 %1455 = OpLoad %9 
					                                      f32_3 %1456 = OpVectorShuffle %1455 %1455 0 1 2 
					                                      f32_4 %1457 = OpLoad %28 
					                                      f32_3 %1458 = OpVectorShuffle %1457 %1457 0 1 2 
					                                      f32_3 %1459 = OpFMul %1456 %1458 
					                                      f32_4 %1460 = OpLoad %28 
					                                      f32_4 %1461 = OpVectorShuffle %1460 %1459 4 5 6 3 
					                                                      OpStore %28 %1461 
					                                      f32_4 %1462 = OpLoad %9 
					                                      f32_3 %1463 = OpVectorShuffle %1462 %1462 0 1 2 
					                                      f32_3 %1466 = OpFMul %1463 %1465 
					                                      f32_3 %1469 = OpFAdd %1466 %1468 
					                                      f32_4 %1470 = OpLoad %163 
					                                      f32_4 %1471 = OpVectorShuffle %1470 %1469 4 5 6 3 
					                                                      OpStore %163 %1471 
					                                      f32_4 %1472 = OpLoad %9 
					                                      f32_3 %1473 = OpVectorShuffle %1472 %1472 0 1 2 
					                                      f32_4 %1474 = OpLoad %163 
					                                      f32_3 %1475 = OpVectorShuffle %1474 %1474 0 1 2 
					                                      f32_3 %1476 = OpFMul %1473 %1475 
					                                      f32_3 %1479 = OpFAdd %1476 %1478 
					                                      f32_4 %1480 = OpLoad %9 
					                                      f32_4 %1481 = OpVectorShuffle %1480 %1479 4 5 6 3 
					                                                      OpStore %9 %1481 
					                                      f32_4 %1482 = OpLoad %28 
					                                      f32_3 %1483 = OpVectorShuffle %1482 %1482 0 1 2 
					                                      f32_4 %1484 = OpLoad %9 
					                                      f32_3 %1485 = OpVectorShuffle %1484 %1484 0 1 2 
					                                      f32_3 %1486 = OpFDiv %1483 %1485 
					                                      f32_4 %1487 = OpLoad %9 
					                                      f32_4 %1488 = OpVectorShuffle %1487 %1486 4 5 6 3 
					                                                      OpStore %9 %1488 
					                                      f32_4 %1493 = OpLoad %9 
					                                      f32_3 %1494 = OpVectorShuffle %1493 %1493 0 1 2 
					                                        f32 %1495 = OpDot %1492 %1494 
					                               Private f32* %1496 = OpAccessChain %28 %118 
					                                                      OpStore %1496 %1495 
					                                      f32_4 %1501 = OpLoad %9 
					                                      f32_3 %1502 = OpVectorShuffle %1501 %1501 0 1 2 
					                                        f32 %1503 = OpDot %1500 %1502 
					                               Private f32* %1504 = OpAccessChain %28 %34 
					                                                      OpStore %1504 %1503 
					                                      f32_4 %1509 = OpLoad %9 
					                                      f32_3 %1510 = OpVectorShuffle %1509 %1509 0 1 2 
					                                        f32 %1511 = OpDot %1508 %1510 
					                               Private f32* %1512 = OpAccessChain %28 %30 
					                                                      OpStore %1512 %1511 
					                                      f32_4 %1513 = OpLoad %28 
					                                      f32_3 %1514 = OpVectorShuffle %1513 %1513 0 1 2 
					                                        f32 %1515 = OpDot %1514 %777 
					                               Private f32* %1516 = OpAccessChain %9 %34 
					                                                      OpStore %1516 %1515 
					                               Private f32* %1517 = OpAccessChain %9 %34 
					                                        f32 %1518 = OpLoad %1517 
					                                        f32 %1519 = OpExtInst %1 40 %1518 %625 
					                               Private f32* %1520 = OpAccessChain %9 %34 
					                                                      OpStore %1520 %1519 
					                                      f32_4 %1521 = OpLoad %28 
					                                      f32_2 %1522 = OpVectorShuffle %1521 %1521 0 1 
					                                      f32_4 %1523 = OpLoad %9 
					                                      f32_2 %1524 = OpVectorShuffle %1523 %1523 0 0 
					                                      f32_2 %1525 = OpFDiv %1522 %1524 
					                                      f32_4 %1526 = OpLoad %9 
					                                      f32_4 %1527 = OpVectorShuffle %1526 %1525 4 5 2 3 
					                                                      OpStore %9 %1527 
					                               Private f32* %1528 = OpAccessChain %28 %30 
					                                        f32 %1529 = OpLoad %1528 
					                                        f32 %1530 = OpExtInst %1 40 %1529 %122 
					                                                      OpStore %544 %1530 
					                                        f32 %1531 = OpLoad %544 
					                                        f32 %1532 = OpExtInst %1 37 %1531 %129 
					                                                      OpStore %544 %1532 
					                                        f32 %1533 = OpLoad %544 
					                                        f32 %1534 = OpExtInst %1 30 %1533 
					                                                      OpStore %544 %1534 
					                                        f32 %1535 = OpLoad %544 
					                                        f32 %1537 = OpFMul %1535 %1536 
					                                                      OpStore %544 %1537 
					                                        f32 %1538 = OpLoad %544 
					                                        f32 %1539 = OpExtInst %1 29 %1538 
					                               Private f32* %1540 = OpAccessChain %28 %30 
					                                                      OpStore %1540 %1539 
					                               Private f32* %1541 = OpAccessChain %9 %34 
					                                        f32 %1542 = OpLoad %1541 
					                                        f32 %1543 = OpFNegate %1542 
					                                        f32 %1544 = OpFAdd %1543 %497 
					                                                      OpStore %544 %1544 
					                               Private f32* %1545 = OpAccessChain %9 %30 
					                                        f32 %1546 = OpLoad %1545 
					                                        f32 %1547 = OpFNegate %1546 
					                                        f32 %1548 = OpLoad %544 
					                                        f32 %1549 = OpFAdd %1547 %1548 
					                               Private f32* %1550 = OpAccessChain %9 %118 
					                                                      OpStore %1550 %1549 
					                               Private f32* %1551 = OpAccessChain %9 %30 
					                                        f32 %1552 = OpLoad %1551 
					                                        f32 %1553 = OpExtInst %1 40 %1552 %625 
					                               Private f32* %1554 = OpAccessChain %628 %34 
					                                                      OpStore %1554 %1553 
					                               Private f32* %1555 = OpAccessChain %28 %30 
					                                        f32 %1556 = OpLoad %1555 
					                               Private f32* %1557 = OpAccessChain %628 %34 
					                                        f32 %1558 = OpLoad %1557 
					                                        f32 %1559 = OpFDiv %1556 %1558 
					                               Private f32* %1560 = OpAccessChain %628 %34 
					                                                      OpStore %1560 %1559 
					                                      f32_3 %1561 = OpLoad %628 
					                                      f32_2 %1562 = OpVectorShuffle %1561 %1561 0 0 
					                                      f32_4 %1563 = OpLoad %9 
					                                      f32_2 %1564 = OpVectorShuffle %1563 %1563 0 2 
					                                      f32_2 %1565 = OpFMul %1562 %1564 
					                                      f32_4 %1566 = OpLoad %28 
					                                      f32_4 %1567 = OpVectorShuffle %1566 %1565 4 1 5 3 
					                                                      OpStore %28 %1567 
					                                      f32_4 %1572 = OpLoad %28 
					                                      f32_3 %1573 = OpVectorShuffle %1572 %1572 0 1 2 
					                                        f32 %1574 = OpDot %1571 %1573 
					                               Private f32* %1575 = OpAccessChain %9 %34 
					                                                      OpStore %1575 %1574 
					                                      f32_4 %1580 = OpLoad %28 
					                                      f32_3 %1581 = OpVectorShuffle %1580 %1580 0 1 2 
					                                        f32 %1582 = OpDot %1579 %1581 
					                               Private f32* %1583 = OpAccessChain %9 %30 
					                                                      OpStore %1583 %1582 
					                                      f32_4 %1588 = OpLoad %28 
					                                      f32_3 %1589 = OpVectorShuffle %1588 %1588 0 1 2 
					                                        f32 %1590 = OpDot %1587 %1589 
					                               Private f32* %1591 = OpAccessChain %9 %118 
					                                                      OpStore %1591 %1590 
					                                      f32_4 %1592 = OpLoad %9 
					                                      f32_3 %1593 = OpVectorShuffle %1592 %1592 0 1 2 
					                                        f32 %1594 = OpDot %1593 %1425 
					                                                      OpStore %544 %1594 
					                                        f32 %1595 = OpLoad %544 
					                                      f32_3 %1596 = OpCompositeConstruct %1595 %1595 %1595 
					                                      f32_3 %1597 = OpFNegate %1596 
					                                      f32_4 %1598 = OpLoad %9 
					                                      f32_3 %1599 = OpVectorShuffle %1598 %1598 0 1 2 
					                                      f32_3 %1600 = OpFAdd %1597 %1599 
					                                      f32_4 %1601 = OpLoad %9 
					                                      f32_4 %1602 = OpVectorShuffle %1601 %1600 4 5 6 3 
					                                                      OpStore %9 %1602 
					                                      f32_4 %1603 = OpLoad %9 
					                                      f32_3 %1604 = OpVectorShuffle %1603 %1603 0 1 2 
					                                      f32_3 %1607 = OpFMul %1604 %1606 
					                                        f32 %1608 = OpLoad %544 
					                                      f32_3 %1609 = OpCompositeConstruct %1608 %1608 %1608 
					                                      f32_3 %1610 = OpFAdd %1607 %1609 
					                                      f32_4 %1611 = OpLoad %9 
					                                      f32_4 %1612 = OpVectorShuffle %1611 %1610 4 5 6 3 
					                                                      OpStore %9 %1612 
					                                      f32_4 %1613 = OpLoad %9 
					                                      f32_3 %1614 = OpVectorShuffle %1613 %1613 0 1 2 
					                                        f32 %1615 = OpDot %1500 %1614 
					                               Private f32* %1616 = OpAccessChain %28 %34 
					                                                      OpStore %1616 %1615 
					                                      f32_4 %1617 = OpLoad %9 
					                                      f32_3 %1618 = OpVectorShuffle %1617 %1617 0 1 2 
					                                        f32 %1619 = OpDot %1508 %1618 
					                               Private f32* %1620 = OpAccessChain %28 %30 
					                                                      OpStore %1620 %1619 
					                                      f32_4 %1621 = OpLoad %9 
					                                      f32_3 %1622 = OpVectorShuffle %1621 %1621 0 1 2 
					                                        f32 %1623 = OpDot %1492 %1622 
					                               Private f32* %1624 = OpAccessChain %28 %118 
					                                                      OpStore %1624 %1623 
					                                      f32_4 %1629 = OpLoad %28 
					                                      f32_3 %1630 = OpVectorShuffle %1629 %1629 0 1 2 
					                                        f32 %1631 = OpDot %1628 %1630 
					                               Private f32* %1632 = OpAccessChain %9 %34 
					                                                      OpStore %1632 %1631 
					                                      f32_4 %1637 = OpLoad %28 
					                                      f32_3 %1638 = OpVectorShuffle %1637 %1637 0 1 2 
					                                        f32 %1639 = OpDot %1636 %1638 
					                               Private f32* %1640 = OpAccessChain %9 %30 
					                                                      OpStore %1640 %1639 
					                                      f32_4 %1645 = OpLoad %28 
					                                      f32_3 %1646 = OpVectorShuffle %1645 %1645 0 1 2 
					                                        f32 %1647 = OpDot %1644 %1646 
					                               Private f32* %1648 = OpAccessChain %9 %118 
					                                                      OpStore %1648 %1647 
					                                      f32_4 %1653 = OpLoad %9 
					                                      f32_3 %1654 = OpVectorShuffle %1653 %1653 0 1 2 
					                                        f32 %1655 = OpDot %1652 %1654 
					                               Private f32* %1656 = OpAccessChain %28 %34 
					                                                      OpStore %1656 %1655 
					                                      f32_4 %1661 = OpLoad %9 
					                                      f32_3 %1662 = OpVectorShuffle %1661 %1661 0 1 2 
					                                        f32 %1663 = OpDot %1660 %1662 
					                               Private f32* %1664 = OpAccessChain %28 %30 
					                                                      OpStore %1664 %1663 
					                                      f32_4 %1669 = OpLoad %9 
					                                      f32_3 %1670 = OpVectorShuffle %1669 %1669 0 1 2 
					                                        f32 %1671 = OpDot %1668 %1670 
					                               Private f32* %1672 = OpAccessChain %28 %118 
					                                                      OpStore %1672 %1671 
					                                      f32_4 %1675 = OpLoad %28 
					                                      f32_3 %1676 = OpVectorShuffle %1675 %1675 0 1 2 
					                                      f32_3 %1677 = OpExtInst %1 40 %1676 %123 
					                                      f32_4 %1678 = OpLoad %1674 
					                                      f32_4 %1679 = OpVectorShuffle %1678 %1677 4 5 6 3 
					                                                      OpStore %1674 %1679 
					                                Output f32* %1681 = OpAccessChain %1674 %56 
					                                                      OpStore %1681 %497 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "d3d11 " {
					Keywords { "TONEMAPPING_NEUTRAL" }
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
						vec4 unused_0_2[19];
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
					Keywords { "TONEMAPPING_NEUTRAL" }
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
					uniform 	vec4 _Lut2D_Params;
					uniform 	vec3 _ColorBalance;
					uniform 	vec3 _ColorFilter;
					uniform 	vec3 _HueSatCon;
					uniform 	vec3 _ChannelMixerRed;
					uniform 	vec3 _ChannelMixerGreen;
					uniform 	vec3 _ChannelMixerBlue;
					uniform 	vec3 _Lift;
					uniform 	vec3 _InvGamma;
					uniform 	vec3 _Gain;
					UNITY_LOCATION(0) uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD0.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www + vec3(-0.413588405, -0.413588405, -0.413588405);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.0275523961, 0.0275523961, 0.0275523961);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(13.6054821, 13.6054821, 13.6054821);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0479959995, -0.0479959995, -0.0479959995);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.179999992, 0.179999992, 0.179999992);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7 = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat15.x + u_xlat4.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7 = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = u_xlat0.xyz * vec3(0.262677222, 0.262677222, 0.262677222) + vec3(0.0695999935, 0.0695999935, 0.0695999935);
					    u_xlat2.xyz = u_xlat0.xyz * vec3(1.31338608, 1.31338608, 1.31338608);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.262677222, 0.262677222, 0.262677222) + vec3(0.289999992, 0.289999992, 0.289999992);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + vec3(0.0816000104, 0.0816000104, 0.0816000104);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(0.00543999998, 0.00543999998, 0.00543999998);
					    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0666666627, -0.0666666627, -0.0666666627);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.31338608, 1.31338608, 1.31338608);
					    SV_Target0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "TONEMAPPING_NEUTRAL" }
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
					; Bound: 668
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %12 %659 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate vs_TEXCOORD0 Location 12 
					                                                      OpMemberDecorate %15 0 Offset 15 
					                                                      OpMemberDecorate %15 1 Offset 15 
					                                                      OpMemberDecorate %15 2 Offset 15 
					                                                      OpMemberDecorate %15 3 Offset 15 
					                                                      OpMemberDecorate %15 4 Offset 15 
					                                                      OpMemberDecorate %15 5 Offset 15 
					                                                      OpMemberDecorate %15 6 Offset 15 
					                                                      OpMemberDecorate %15 7 Offset 15 
					                                                      OpMemberDecorate %15 8 Offset 15 
					                                                      OpMemberDecorate %15 9 Offset 15 
					                                                      OpDecorate %15 Block 
					                                                      OpDecorate %17 DescriptorSet 17 
					                                                      OpDecorate %17 Binding 17 
					                                                      OpDecorate %399 DescriptorSet 399 
					                                                      OpDecorate %399 Binding 399 
					                                                      OpDecorate %403 DescriptorSet 403 
					                                                      OpDecorate %403 Binding 403 
					                                                      OpDecorate %659 Location 659 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 2 
					                                              %11 = OpTypePointer Input %10 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                              %14 = OpTypeVector %6 3 
					                                              %15 = OpTypeStruct %7 %14 %14 %14 %14 %14 %14 %14 %14 %14 
					                                              %16 = OpTypePointer Uniform %15 
					Uniform struct {f32_4; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3;}* %17 = OpVariable Uniform 
					                                              %18 = OpTypeInt 32 1 
					                                          i32 %19 = OpConstant 0 
					                                              %20 = OpTypePointer Uniform %7 
					                               Private f32_4* %28 = OpVariable Private 
					                                              %29 = OpTypeInt 32 0 
					                                          u32 %30 = OpConstant 1 
					                                              %31 = OpTypePointer Private %6 
					                                          u32 %34 = OpConstant 0 
					                                              %35 = OpTypePointer Uniform %6 
					                                          u32 %56 = OpConstant 3 
					                                          f32 %64 = OpConstant 3,674022E-40 
					                                        f32_3 %65 = OpConstantComposite %64 %64 %64 
					                                          i32 %71 = OpConstant 3 
					                                              %72 = OpTypePointer Uniform %14 
					                                          f32 %77 = OpConstant 3,674022E-40 
					                                        f32_3 %78 = OpConstantComposite %77 %77 %77 
					                                          f32 %84 = OpConstant 3,674022E-40 
					                                        f32_3 %85 = OpConstantComposite %84 %84 %84 
					                                          f32 %96 = OpConstant 3,674022E-40 
					                                        f32_3 %97 = OpConstantComposite %96 %96 %96 
					                                         f32 %103 = OpConstant 3,674022E-40 
					                                       f32_3 %104 = OpConstantComposite %103 %103 %103 
					                                         f32 %108 = OpConstant 3,674022E-40 
					                                         f32 %109 = OpConstant 3,674022E-40 
					                                         f32 %110 = OpConstant 3,674022E-40 
					                                       f32_3 %111 = OpConstantComposite %108 %109 %110 
					                                         f32 %116 = OpConstant 3,674022E-40 
					                                         f32 %117 = OpConstant 3,674022E-40 
					                                         f32 %118 = OpConstant 3,674022E-40 
					                                       f32_3 %119 = OpConstantComposite %116 %117 %118 
					                                         f32 %124 = OpConstant 3,674022E-40 
					                                         f32 %125 = OpConstant 3,674022E-40 
					                                         f32 %126 = OpConstant 3,674022E-40 
					                                       f32_3 %127 = OpConstantComposite %124 %125 %126 
					                                         u32 %131 = OpConstant 2 
					                                         i32 %135 = OpConstant 1 
					                                         f32 %141 = OpConstant 3,674022E-40 
					                                         f32 %142 = OpConstant 3,674022E-40 
					                                         f32 %143 = OpConstant 3,674022E-40 
					                                       f32_3 %144 = OpConstantComposite %141 %142 %143 
					                                         f32 %149 = OpConstant 3,674022E-40 
					                                         f32 %150 = OpConstant 3,674022E-40 
					                                         f32 %151 = OpConstant 3,674022E-40 
					                                       f32_3 %152 = OpConstantComposite %149 %150 %151 
					                                         f32 %157 = OpConstant 3,674022E-40 
					                                         f32 %158 = OpConstant 3,674022E-40 
					                                         f32 %159 = OpConstant 3,674022E-40 
					                                       f32_3 %160 = OpConstantComposite %157 %158 %159 
					                                         i32 %167 = OpConstant 2 
					                                         i32 %175 = OpConstant 4 
					                                         i32 %182 = OpConstant 5 
					                                         i32 %189 = OpConstant 6 
					                                         i32 %196 = OpConstant 9 
					                                         i32 %200 = OpConstant 7 
					                                         f32 %214 = OpConstant 3,674022E-40 
					                                       f32_3 %215 = OpConstantComposite %214 %214 %214 
					                                         f32 %217 = OpConstant 3,674022E-40 
					                                       f32_3 %218 = OpConstantComposite %217 %217 %217 
					                                         f32 %224 = OpConstant 3,674022E-40 
					                                         f32 %225 = OpConstant 3,674022E-40 
					                                         f32 %233 = OpConstant 3,674022E-40 
					                                       f32_3 %234 = OpConstantComposite %233 %233 %233 
					                                         f32 %236 = OpConstant 3,674022E-40 
					                                       f32_3 %237 = OpConstantComposite %236 %236 %236 
					                                         i32 %243 = OpConstant 8 
					                                       f32_3 %263 = OpConstantComposite %224 %224 %224 
					                                             %267 = OpTypeBool 
					                                             %268 = OpTypePointer Private %267 
					                               Private bool* %269 = OpVariable Private 
					                                Private f32* %275 = OpVariable Private 
					                              Private f32_4* %282 = OpVariable Private 
					                                         f32 %292 = OpConstant 3,674022E-40 
					                                             %317 = OpTypePointer Private %14 
					                              Private f32_3* %318 = OpVariable Private 
					                                         f32 %321 = OpConstant 3,674022E-40 
					                                         f32 %322 = OpConstant 3,674022E-40 
					                                         f32 %323 = OpConstant 3,674022E-40 
					                                       f32_3 %324 = OpConstantComposite %321 %322 %323 
					                              Private f32_3* %354 = OpVariable Private 
					                                         f32 %357 = OpConstant 3,674022E-40 
					                                         f32 %359 = OpConstant 3,674022E-40 
					                                             %362 = OpTypePointer Private %10 
					                              Private f32_2* %363 = OpVariable Private 
					                              Private f32_2* %387 = OpVariable Private 
					                                         f32 %394 = OpConstant 3,674022E-40 
					                                             %397 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                             %398 = OpTypePointer UniformConstant %397 
					        UniformConstant read_only Texture2D* %399 = OpVariable UniformConstant 
					                                             %401 = OpTypeSampler 
					                                             %402 = OpTypePointer UniformConstant %401 
					                    UniformConstant sampler* %403 = OpVariable UniformConstant 
					                                             %405 = OpTypeSampledImage %397 
					                                         f32 %432 = OpConstant 3,674022E-40 
					                                         f32 %433 = OpConstant 3,674022E-40 
					                                       f32_3 %434 = OpConstantComposite %432 %217 %433 
					                               Private bool* %436 = OpVariable Private 
					                                             %441 = OpTypePointer Function %6 
					                                         f32 %468 = OpConstant 3,674022E-40 
					                                       f32_3 %469 = OpConstantComposite %225 %292 %468 
					                                       f32_3 %474 = OpConstantComposite %357 %357 %357 
					                                         f32 %476 = OpConstant 3,674022E-40 
					                                       f32_3 %477 = OpConstantComposite %476 %476 %476 
					                              Private f32_2* %492 = OpVariable Private 
					                                       f32_3 %503 = OpConstantComposite %225 %225 %225 
					                                         f32 %596 = OpConstant 3,674022E-40 
					                                       f32_3 %597 = OpConstantComposite %596 %596 %596 
					                                         f32 %599 = OpConstant 3,674022E-40 
					                                       f32_3 %600 = OpConstantComposite %599 %599 %599 
					                                         f32 %606 = OpConstant 3,674022E-40 
					                                       f32_3 %607 = OpConstantComposite %606 %606 %606 
					                                         f32 %614 = OpConstant 3,674022E-40 
					                                       f32_3 %615 = OpConstantComposite %614 %614 %614 
					                                         f32 %624 = OpConstant 3,674022E-40 
					                                       f32_3 %625 = OpConstantComposite %624 %624 %624 
					                                         f32 %634 = OpConstant 3,674022E-40 
					                                       f32_3 %635 = OpConstantComposite %634 %634 %634 
					                                         f32 %648 = OpConstant 3,674022E-40 
					                                       f32_3 %649 = OpConstantComposite %648 %648 %648 
					                                             %658 = OpTypePointer Output %7 
					                               Output f32_4* %659 = OpVariable Output 
					                                             %665 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                               Function f32* %442 = OpVariable Function 
					                               Function f32* %456 = OpVariable Function 
					                                        f32_2 %13 = OpLoad vs_TEXCOORD0 
					                               Uniform f32_4* %21 = OpAccessChain %17 %19 
					                                        f32_4 %22 = OpLoad %21 
					                                        f32_2 %23 = OpVectorShuffle %22 %22 1 2 
					                                        f32_2 %24 = OpFNegate %23 
					                                        f32_2 %25 = OpFAdd %13 %24 
					                                        f32_4 %26 = OpLoad %9 
					                                        f32_4 %27 = OpVectorShuffle %26 %25 0 4 5 3 
					                                                      OpStore %9 %27 
					                                 Private f32* %32 = OpAccessChain %9 %30 
					                                          f32 %33 = OpLoad %32 
					                                 Uniform f32* %36 = OpAccessChain %17 %19 %34 
					                                          f32 %37 = OpLoad %36 
					                                          f32 %38 = OpFMul %33 %37 
					                                 Private f32* %39 = OpAccessChain %28 %34 
					                                                      OpStore %39 %38 
					                                 Private f32* %40 = OpAccessChain %28 %34 
					                                          f32 %41 = OpLoad %40 
					                                          f32 %42 = OpExtInst %1 10 %41 
					                                 Private f32* %43 = OpAccessChain %9 %34 
					                                                      OpStore %43 %42 
					                                 Private f32* %44 = OpAccessChain %9 %34 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %46 = OpAccessChain %17 %19 %34 
					                                          f32 %47 = OpLoad %46 
					                                          f32 %48 = OpFDiv %45 %47 
					                                 Private f32* %49 = OpAccessChain %28 %34 
					                                                      OpStore %49 %48 
					                                 Private f32* %50 = OpAccessChain %9 %30 
					                                          f32 %51 = OpLoad %50 
					                                 Private f32* %52 = OpAccessChain %28 %34 
					                                          f32 %53 = OpLoad %52 
					                                          f32 %54 = OpFNegate %53 
					                                          f32 %55 = OpFAdd %51 %54 
					                                 Private f32* %57 = OpAccessChain %9 %56 
					                                                      OpStore %57 %55 
					                                        f32_4 %58 = OpLoad %9 
					                                        f32_3 %59 = OpVectorShuffle %58 %58 0 2 3 
					                               Uniform f32_4* %60 = OpAccessChain %17 %19 
					                                        f32_4 %61 = OpLoad %60 
					                                        f32_3 %62 = OpVectorShuffle %61 %61 3 3 3 
					                                        f32_3 %63 = OpFMul %59 %62 
					                                        f32_3 %66 = OpFAdd %63 %65 
					                                        f32_4 %67 = OpLoad %9 
					                                        f32_4 %68 = OpVectorShuffle %67 %66 4 5 6 3 
					                                                      OpStore %9 %68 
					                                        f32_4 %69 = OpLoad %9 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 0 1 2 
					                               Uniform f32_3* %73 = OpAccessChain %17 %71 
					                                        f32_3 %74 = OpLoad %73 
					                                        f32_3 %75 = OpVectorShuffle %74 %74 2 2 2 
					                                        f32_3 %76 = OpFMul %70 %75 
					                                        f32_3 %79 = OpFAdd %76 %78 
					                                        f32_4 %80 = OpLoad %9 
					                                        f32_4 %81 = OpVectorShuffle %80 %79 4 5 6 3 
					                                                      OpStore %9 %81 
					                                        f32_4 %82 = OpLoad %9 
					                                        f32_3 %83 = OpVectorShuffle %82 %82 0 1 2 
					                                        f32_3 %86 = OpFMul %83 %85 
					                                        f32_4 %87 = OpLoad %9 
					                                        f32_4 %88 = OpVectorShuffle %87 %86 4 5 6 3 
					                                                      OpStore %9 %88 
					                                        f32_4 %89 = OpLoad %9 
					                                        f32_3 %90 = OpVectorShuffle %89 %89 0 1 2 
					                                        f32_3 %91 = OpExtInst %1 29 %90 
					                                        f32_4 %92 = OpLoad %9 
					                                        f32_4 %93 = OpVectorShuffle %92 %91 4 5 6 3 
					                                                      OpStore %9 %93 
					                                        f32_4 %94 = OpLoad %9 
					                                        f32_3 %95 = OpVectorShuffle %94 %94 0 1 2 
					                                        f32_3 %98 = OpFAdd %95 %97 
					                                        f32_4 %99 = OpLoad %9 
					                                       f32_4 %100 = OpVectorShuffle %99 %98 4 5 6 3 
					                                                      OpStore %9 %100 
					                                       f32_4 %101 = OpLoad %9 
					                                       f32_3 %102 = OpVectorShuffle %101 %101 0 1 2 
					                                       f32_3 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %9 
					                                       f32_4 %107 = OpVectorShuffle %106 %105 4 5 6 3 
					                                                      OpStore %9 %107 
					                                       f32_4 %112 = OpLoad %9 
					                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
					                                         f32 %114 = OpDot %111 %113 
					                                Private f32* %115 = OpAccessChain %28 %34 
					                                                      OpStore %115 %114 
					                                       f32_4 %120 = OpLoad %9 
					                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                                         f32 %122 = OpDot %119 %121 
					                                Private f32* %123 = OpAccessChain %28 %30 
					                                                      OpStore %123 %122 
					                                       f32_4 %128 = OpLoad %9 
					                                       f32_3 %129 = OpVectorShuffle %128 %128 0 1 2 
					                                         f32 %130 = OpDot %127 %129 
					                                Private f32* %132 = OpAccessChain %28 %131 
					                                                      OpStore %132 %130 
					                                       f32_4 %133 = OpLoad %28 
					                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
					                              Uniform f32_3* %136 = OpAccessChain %17 %135 
					                                       f32_3 %137 = OpLoad %136 
					                                       f32_3 %138 = OpFMul %134 %137 
					                                       f32_4 %139 = OpLoad %9 
					                                       f32_4 %140 = OpVectorShuffle %139 %138 4 5 6 3 
					                                                      OpStore %9 %140 
					                                       f32_4 %145 = OpLoad %9 
					                                       f32_3 %146 = OpVectorShuffle %145 %145 0 1 2 
					                                         f32 %147 = OpDot %144 %146 
					                                Private f32* %148 = OpAccessChain %28 %34 
					                                                      OpStore %148 %147 
					                                       f32_4 %153 = OpLoad %9 
					                                       f32_3 %154 = OpVectorShuffle %153 %153 0 1 2 
					                                         f32 %155 = OpDot %152 %154 
					                                Private f32* %156 = OpAccessChain %28 %30 
					                                                      OpStore %156 %155 
					                                       f32_4 %161 = OpLoad %9 
					                                       f32_3 %162 = OpVectorShuffle %161 %161 0 1 2 
					                                         f32 %163 = OpDot %160 %162 
					                                Private f32* %164 = OpAccessChain %28 %131 
					                                                      OpStore %164 %163 
					                                       f32_4 %165 = OpLoad %28 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                              Uniform f32_3* %168 = OpAccessChain %17 %167 
					                                       f32_3 %169 = OpLoad %168 
					                                       f32_3 %170 = OpFMul %166 %169 
					                                       f32_4 %171 = OpLoad %9 
					                                       f32_4 %172 = OpVectorShuffle %171 %170 4 5 6 3 
					                                                      OpStore %9 %172 
					                                       f32_4 %173 = OpLoad %9 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                              Uniform f32_3* %176 = OpAccessChain %17 %175 
					                                       f32_3 %177 = OpLoad %176 
					                                         f32 %178 = OpDot %174 %177 
					                                Private f32* %179 = OpAccessChain %28 %34 
					                                                      OpStore %179 %178 
					                                       f32_4 %180 = OpLoad %9 
					                                       f32_3 %181 = OpVectorShuffle %180 %180 0 1 2 
					                              Uniform f32_3* %183 = OpAccessChain %17 %182 
					                                       f32_3 %184 = OpLoad %183 
					                                         f32 %185 = OpDot %181 %184 
					                                Private f32* %186 = OpAccessChain %28 %30 
					                                                      OpStore %186 %185 
					                                       f32_4 %187 = OpLoad %9 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                              Uniform f32_3* %190 = OpAccessChain %17 %189 
					                                       f32_3 %191 = OpLoad %190 
					                                         f32 %192 = OpDot %188 %191 
					                                Private f32* %193 = OpAccessChain %28 %131 
					                                                      OpStore %193 %192 
					                                       f32_4 %194 = OpLoad %28 
					                                       f32_3 %195 = OpVectorShuffle %194 %194 0 1 2 
					                              Uniform f32_3* %197 = OpAccessChain %17 %196 
					                                       f32_3 %198 = OpLoad %197 
					                                       f32_3 %199 = OpFMul %195 %198 
					                              Uniform f32_3* %201 = OpAccessChain %17 %200 
					                                       f32_3 %202 = OpLoad %201 
					                                       f32_3 %203 = OpFAdd %199 %202 
					                                       f32_4 %204 = OpLoad %9 
					                                       f32_4 %205 = OpVectorShuffle %204 %203 4 5 6 3 
					                                                      OpStore %9 %205 
					                                       f32_4 %206 = OpLoad %9 
					                                       f32_3 %207 = OpVectorShuffle %206 %206 0 1 2 
					                                       f32_3 %208 = OpExtInst %1 4 %207 
					                                       f32_3 %209 = OpExtInst %1 30 %208 
					                                       f32_4 %210 = OpLoad %28 
					                                       f32_4 %211 = OpVectorShuffle %210 %209 4 5 6 3 
					                                                      OpStore %28 %211 
					                                       f32_4 %212 = OpLoad %9 
					                                       f32_3 %213 = OpVectorShuffle %212 %212 0 1 2 
					                                       f32_3 %216 = OpFMul %213 %215 
					                                       f32_3 %219 = OpFAdd %216 %218 
					                                       f32_4 %220 = OpLoad %9 
					                                       f32_4 %221 = OpVectorShuffle %220 %219 4 5 6 3 
					                                                      OpStore %9 %221 
					                                       f32_4 %222 = OpLoad %9 
					                                       f32_3 %223 = OpVectorShuffle %222 %222 0 1 2 
					                                       f32_3 %226 = OpCompositeConstruct %224 %224 %224 
					                                       f32_3 %227 = OpCompositeConstruct %225 %225 %225 
					                                       f32_3 %228 = OpExtInst %1 43 %223 %226 %227 
					                                       f32_4 %229 = OpLoad %9 
					                                       f32_4 %230 = OpVectorShuffle %229 %228 4 5 6 3 
					                                                      OpStore %9 %230 
					                                       f32_4 %231 = OpLoad %9 
					                                       f32_3 %232 = OpVectorShuffle %231 %231 0 1 2 
					                                       f32_3 %235 = OpFMul %232 %234 
					                                       f32_3 %238 = OpFAdd %235 %237 
					                                       f32_4 %239 = OpLoad %9 
					                                       f32_4 %240 = OpVectorShuffle %239 %238 4 5 6 3 
					                                                      OpStore %9 %240 
					                                       f32_4 %241 = OpLoad %28 
					                                       f32_3 %242 = OpVectorShuffle %241 %241 0 1 2 
					                              Uniform f32_3* %244 = OpAccessChain %17 %243 
					                                       f32_3 %245 = OpLoad %244 
					                                       f32_3 %246 = OpFMul %242 %245 
					                                       f32_4 %247 = OpLoad %28 
					                                       f32_4 %248 = OpVectorShuffle %247 %246 4 5 6 3 
					                                                      OpStore %28 %248 
					                                       f32_4 %249 = OpLoad %28 
					                                       f32_3 %250 = OpVectorShuffle %249 %249 0 1 2 
					                                       f32_3 %251 = OpExtInst %1 29 %250 
					                                       f32_4 %252 = OpLoad %28 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 4 5 6 3 
					                                                      OpStore %28 %253 
					                                       f32_4 %254 = OpLoad %9 
					                                       f32_3 %255 = OpVectorShuffle %254 %254 0 1 2 
					                                       f32_4 %256 = OpLoad %28 
					                                       f32_3 %257 = OpVectorShuffle %256 %256 0 1 2 
					                                       f32_3 %258 = OpFMul %255 %257 
					                                       f32_4 %259 = OpLoad %9 
					                                       f32_4 %260 = OpVectorShuffle %259 %258 4 5 6 3 
					                                                      OpStore %9 %260 
					                                       f32_4 %261 = OpLoad %9 
					                                       f32_3 %262 = OpVectorShuffle %261 %261 0 1 2 
					                                       f32_3 %264 = OpExtInst %1 40 %262 %263 
					                                       f32_4 %265 = OpLoad %9 
					                                       f32_4 %266 = OpVectorShuffle %265 %264 4 5 6 3 
					                                                      OpStore %9 %266 
					                                Private f32* %270 = OpAccessChain %9 %30 
					                                         f32 %271 = OpLoad %270 
					                                Private f32* %272 = OpAccessChain %9 %131 
					                                         f32 %273 = OpLoad %272 
					                                        bool %274 = OpFOrdGreaterThanEqual %271 %273 
					                                                      OpStore %269 %274 
					                                        bool %276 = OpLoad %269 
					                                         f32 %277 = OpSelect %276 %225 %224 
					                                                      OpStore %275 %277 
					                                       f32_4 %278 = OpLoad %9 
					                                       f32_2 %279 = OpVectorShuffle %278 %278 2 1 
					                                       f32_4 %280 = OpLoad %28 
					                                       f32_4 %281 = OpVectorShuffle %280 %279 4 5 2 3 
					                                                      OpStore %28 %281 
					                                       f32_4 %283 = OpLoad %9 
					                                       f32_2 %284 = OpVectorShuffle %283 %283 1 2 
					                                       f32_4 %285 = OpLoad %28 
					                                       f32_2 %286 = OpVectorShuffle %285 %285 0 1 
					                                       f32_2 %287 = OpFNegate %286 
					                                       f32_2 %288 = OpFAdd %284 %287 
					                                       f32_4 %289 = OpLoad %282 
					                                       f32_4 %290 = OpVectorShuffle %289 %288 4 5 2 3 
					                                                      OpStore %282 %290 
					                                Private f32* %291 = OpAccessChain %28 %131 
					                                                      OpStore %291 %236 
					                                Private f32* %293 = OpAccessChain %28 %56 
					                                                      OpStore %293 %292 
					                                Private f32* %294 = OpAccessChain %282 %131 
					                                                      OpStore %294 %225 
					                                Private f32* %295 = OpAccessChain %282 %56 
					                                                      OpStore %295 %236 
					                                         f32 %296 = OpLoad %275 
					                                       f32_4 %297 = OpCompositeConstruct %296 %296 %296 %296 
					                                       f32_4 %298 = OpLoad %282 
					                                       f32_4 %299 = OpVectorShuffle %298 %298 0 1 3 2 
					                                       f32_4 %300 = OpFMul %297 %299 
					                                       f32_4 %301 = OpLoad %28 
					                                       f32_4 %302 = OpVectorShuffle %301 %301 0 1 3 2 
					                                       f32_4 %303 = OpFAdd %300 %302 
					                                                      OpStore %28 %303 
					                                Private f32* %304 = OpAccessChain %9 %34 
					                                         f32 %305 = OpLoad %304 
					                                Private f32* %306 = OpAccessChain %28 %34 
					                                         f32 %307 = OpLoad %306 
					                                        bool %308 = OpFOrdGreaterThanEqual %305 %307 
					                                                      OpStore %269 %308 
					                                        bool %309 = OpLoad %269 
					                                         f32 %310 = OpSelect %309 %225 %224 
					                                                      OpStore %275 %310 
					                                Private f32* %311 = OpAccessChain %28 %56 
					                                         f32 %312 = OpLoad %311 
					                                Private f32* %313 = OpAccessChain %282 %131 
					                                                      OpStore %313 %312 
					                                Private f32* %314 = OpAccessChain %9 %34 
					                                         f32 %315 = OpLoad %314 
					                                Private f32* %316 = OpAccessChain %28 %56 
					                                                      OpStore %316 %315 
					                                       f32_4 %319 = OpLoad %9 
					                                       f32_3 %320 = OpVectorShuffle %319 %319 0 1 2 
					                                         f32 %325 = OpDot %320 %324 
					                                Private f32* %326 = OpAccessChain %318 %34 
					                                                      OpStore %326 %325 
					                                       f32_4 %327 = OpLoad %28 
					                                       f32_3 %328 = OpVectorShuffle %327 %327 3 1 0 
					                                       f32_4 %329 = OpLoad %282 
					                                       f32_4 %330 = OpVectorShuffle %329 %328 4 5 2 6 
					                                                      OpStore %282 %330 
					                                       f32_4 %331 = OpLoad %28 
					                                       f32_4 %332 = OpFNegate %331 
					                                       f32_4 %333 = OpLoad %282 
					                                       f32_4 %334 = OpFAdd %332 %333 
					                                                      OpStore %282 %334 
					                                         f32 %335 = OpLoad %275 
					                                       f32_4 %336 = OpCompositeConstruct %335 %335 %335 %335 
					                                       f32_4 %337 = OpLoad %282 
					                                       f32_4 %338 = OpFMul %336 %337 
					                                       f32_4 %339 = OpLoad %28 
					                                       f32_4 %340 = OpFAdd %338 %339 
					                                                      OpStore %9 %340 
					                                Private f32* %341 = OpAccessChain %9 %30 
					                                         f32 %342 = OpLoad %341 
					                                Private f32* %343 = OpAccessChain %9 %56 
					                                         f32 %344 = OpLoad %343 
					                                         f32 %345 = OpExtInst %1 37 %342 %344 
					                                Private f32* %346 = OpAccessChain %28 %34 
					                                                      OpStore %346 %345 
					                                Private f32* %347 = OpAccessChain %9 %34 
					                                         f32 %348 = OpLoad %347 
					                                Private f32* %349 = OpAccessChain %28 %34 
					                                         f32 %350 = OpLoad %349 
					                                         f32 %351 = OpFNegate %350 
					                                         f32 %352 = OpFAdd %348 %351 
					                                Private f32* %353 = OpAccessChain %28 %34 
					                                                      OpStore %353 %352 
					                                Private f32* %355 = OpAccessChain %28 %34 
					                                         f32 %356 = OpLoad %355 
					                                         f32 %358 = OpFMul %356 %357 
					                                         f32 %360 = OpFAdd %358 %359 
					                                Private f32* %361 = OpAccessChain %354 %34 
					                                                      OpStore %361 %360 
					                                Private f32* %364 = OpAccessChain %9 %30 
					                                         f32 %365 = OpLoad %364 
					                                         f32 %366 = OpFNegate %365 
					                                Private f32* %367 = OpAccessChain %9 %56 
					                                         f32 %368 = OpLoad %367 
					                                         f32 %369 = OpFAdd %366 %368 
					                                Private f32* %370 = OpAccessChain %363 %34 
					                                                      OpStore %370 %369 
					                                Private f32* %371 = OpAccessChain %363 %34 
					                                         f32 %372 = OpLoad %371 
					                                Private f32* %373 = OpAccessChain %354 %34 
					                                         f32 %374 = OpLoad %373 
					                                         f32 %375 = OpFDiv %372 %374 
					                                Private f32* %376 = OpAccessChain %363 %34 
					                                                      OpStore %376 %375 
					                                Private f32* %377 = OpAccessChain %363 %34 
					                                         f32 %378 = OpLoad %377 
					                                Private f32* %379 = OpAccessChain %9 %131 
					                                         f32 %380 = OpLoad %379 
					                                         f32 %381 = OpFAdd %378 %380 
					                                Private f32* %382 = OpAccessChain %363 %34 
					                                                      OpStore %382 %381 
					                                Private f32* %383 = OpAccessChain %363 %34 
					                                         f32 %384 = OpLoad %383 
					                                         f32 %385 = OpExtInst %1 4 %384 
					                                Private f32* %386 = OpAccessChain %282 %34 
					                                                      OpStore %386 %385 
					                                Private f32* %388 = OpAccessChain %282 %34 
					                                         f32 %389 = OpLoad %388 
					                                Uniform f32* %390 = OpAccessChain %17 %71 %34 
					                                         f32 %391 = OpLoad %390 
					                                         f32 %392 = OpFAdd %389 %391 
					                                Private f32* %393 = OpAccessChain %387 %34 
					                                                      OpStore %393 %392 
					                                Private f32* %395 = OpAccessChain %318 %30 
					                                                      OpStore %395 %394 
					                                Private f32* %396 = OpAccessChain %387 %30 
					                                                      OpStore %396 %394 
					                         read_only Texture2D %400 = OpLoad %399 
					                                     sampler %404 = OpLoad %403 
					                  read_only Texture2DSampled %406 = OpSampledImage %400 %404 
					                                       f32_2 %407 = OpLoad %387 
					                                       f32_4 %408 = OpImageSampleExplicitLod %406 %407 Lod %7 
					                                         f32 %409 = OpCompositeExtract %408 0 
					                                Private f32* %410 = OpAccessChain %363 %34 
					                                                      OpStore %410 %409 
					                         read_only Texture2D %411 = OpLoad %399 
					                                     sampler %412 = OpLoad %403 
					                  read_only Texture2DSampled %413 = OpSampledImage %411 %412 
					                                       f32_3 %414 = OpLoad %318 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_4 %416 = OpImageSampleExplicitLod %413 %415 Lod %7 
					                                         f32 %417 = OpCompositeExtract %416 3 
					                                Private f32* %418 = OpAccessChain %363 %30 
					                                                      OpStore %418 %417 
					                                       f32_2 %419 = OpLoad %363 
					                                                      OpStore %363 %419 
					                                       f32_2 %420 = OpLoad %363 
					                                       f32_2 %421 = OpCompositeConstruct %224 %224 
					                                       f32_2 %422 = OpCompositeConstruct %225 %225 
					                                       f32_2 %423 = OpExtInst %1 43 %420 %421 %422 
					                                                      OpStore %363 %423 
					                                Private f32* %424 = OpAccessChain %387 %34 
					                                         f32 %425 = OpLoad %424 
					                                Private f32* %426 = OpAccessChain %363 %34 
					                                         f32 %427 = OpLoad %426 
					                                         f32 %428 = OpFAdd %425 %427 
					                                Private f32* %429 = OpAccessChain %363 %34 
					                                                      OpStore %429 %428 
					                                       f32_2 %430 = OpLoad %363 
					                                       f32_3 %431 = OpVectorShuffle %430 %430 0 0 0 
					                                       f32_3 %435 = OpFAdd %431 %434 
					                                                      OpStore %354 %435 
					                                Private f32* %437 = OpAccessChain %354 %34 
					                                         f32 %438 = OpLoad %437 
					                                        bool %439 = OpFOrdLessThan %225 %438 
					                                                      OpStore %436 %439 
					                                        bool %440 = OpLoad %436 
					                                                      OpSelectionMerge %444 None 
					                                                      OpBranchConditional %440 %443 %447 
					                                             %443 = OpLabel 
					                                Private f32* %445 = OpAccessChain %354 %131 
					                                         f32 %446 = OpLoad %445 
					                                                      OpStore %442 %446 
					                                                      OpBranch %444 
					                                             %447 = OpLabel 
					                                Private f32* %448 = OpAccessChain %354 %34 
					                                         f32 %449 = OpLoad %448 
					                                                      OpStore %442 %449 
					                                                      OpBranch %444 
					                                             %444 = OpLabel 
					                                         f32 %450 = OpLoad %442 
					                                Private f32* %451 = OpAccessChain %363 %34 
					                                                      OpStore %451 %450 
					                                Private f32* %452 = OpAccessChain %354 %34 
					                                         f32 %453 = OpLoad %452 
					                                        bool %454 = OpFOrdLessThan %453 %224 
					                                                      OpStore %269 %454 
					                                        bool %455 = OpLoad %269 
					                                                      OpSelectionMerge %458 None 
					                                                      OpBranchConditional %455 %457 %461 
					                                             %457 = OpLabel 
					                                Private f32* %459 = OpAccessChain %354 %30 
					                                         f32 %460 = OpLoad %459 
					                                                      OpStore %456 %460 
					                                                      OpBranch %458 
					                                             %461 = OpLabel 
					                                Private f32* %462 = OpAccessChain %363 %34 
					                                         f32 %463 = OpLoad %462 
					                                                      OpStore %456 %463 
					                                                      OpBranch %458 
					                                             %458 = OpLabel 
					                                         f32 %464 = OpLoad %456 
					                                Private f32* %465 = OpAccessChain %363 %34 
					                                                      OpStore %465 %464 
					                                       f32_2 %466 = OpLoad %363 
					                                       f32_3 %467 = OpVectorShuffle %466 %466 0 0 0 
					                                       f32_3 %470 = OpFAdd %467 %469 
					                                                      OpStore %354 %470 
					                                       f32_3 %471 = OpLoad %354 
					                                       f32_3 %472 = OpExtInst %1 10 %471 
					                                                      OpStore %354 %472 
					                                       f32_3 %473 = OpLoad %354 
					                                       f32_3 %475 = OpFMul %473 %474 
					                                       f32_3 %478 = OpFAdd %475 %477 
					                                                      OpStore %354 %478 
					                                       f32_3 %479 = OpLoad %354 
					                                       f32_3 %480 = OpExtInst %1 4 %479 
					                                       f32_3 %481 = OpFAdd %480 %237 
					                                                      OpStore %354 %481 
					                                       f32_3 %482 = OpLoad %354 
					                                       f32_3 %483 = OpCompositeConstruct %224 %224 %224 
					                                       f32_3 %484 = OpCompositeConstruct %225 %225 %225 
					                                       f32_3 %485 = OpExtInst %1 43 %482 %483 %484 
					                                                      OpStore %354 %485 
					                                       f32_3 %486 = OpLoad %354 
					                                       f32_3 %487 = OpFAdd %486 %237 
					                                                      OpStore %354 %487 
					                                Private f32* %488 = OpAccessChain %9 %34 
					                                         f32 %489 = OpLoad %488 
					                                         f32 %490 = OpFAdd %489 %359 
					                                Private f32* %491 = OpAccessChain %363 %34 
					                                                      OpStore %491 %490 
					                                Private f32* %493 = OpAccessChain %28 %34 
					                                         f32 %494 = OpLoad %493 
					                                Private f32* %495 = OpAccessChain %363 %34 
					                                         f32 %496 = OpLoad %495 
					                                         f32 %497 = OpFDiv %494 %496 
					                                Private f32* %498 = OpAccessChain %492 %34 
					                                                      OpStore %498 %497 
					                                       f32_2 %499 = OpLoad %492 
					                                       f32_3 %500 = OpVectorShuffle %499 %499 0 0 0 
					                                       f32_3 %501 = OpLoad %354 
					                                       f32_3 %502 = OpFMul %500 %501 
					                                       f32_3 %504 = OpFAdd %502 %503 
					                                       f32_4 %505 = OpLoad %28 
					                                       f32_4 %506 = OpVectorShuffle %505 %504 4 5 6 3 
					                                                      OpStore %28 %506 
					                                       f32_4 %507 = OpLoad %9 
					                                       f32_3 %508 = OpVectorShuffle %507 %507 0 0 0 
					                                       f32_4 %509 = OpLoad %28 
					                                       f32_3 %510 = OpVectorShuffle %509 %509 0 1 2 
					                                       f32_3 %511 = OpFMul %508 %510 
					                                                      OpStore %318 %511 
					                                       f32_3 %512 = OpLoad %318 
					                                         f32 %513 = OpDot %512 %324 
					                                Private f32* %514 = OpAccessChain %363 %34 
					                                                      OpStore %514 %513 
					                                       f32_4 %515 = OpLoad %9 
					                                       f32_3 %516 = OpVectorShuffle %515 %515 0 0 0 
					                                       f32_4 %517 = OpLoad %28 
					                                       f32_3 %518 = OpVectorShuffle %517 %517 0 1 2 
					                                       f32_3 %519 = OpFMul %516 %518 
					                                       f32_2 %520 = OpLoad %363 
					                                       f32_3 %521 = OpVectorShuffle %520 %520 0 0 0 
					                                       f32_3 %522 = OpFNegate %521 
					                                       f32_3 %523 = OpFAdd %519 %522 
					                                       f32_4 %524 = OpLoad %28 
					                                       f32_4 %525 = OpVectorShuffle %524 %523 4 5 6 3 
					                                                      OpStore %28 %525 
					                                Private f32* %526 = OpAccessChain %282 %30 
					                                                      OpStore %526 %394 
					                                Private f32* %527 = OpAccessChain %492 %30 
					                                                      OpStore %527 %394 
					                         read_only Texture2D %528 = OpLoad %399 
					                                     sampler %529 = OpLoad %403 
					                  read_only Texture2DSampled %530 = OpSampledImage %528 %529 
					                                       f32_4 %531 = OpLoad %282 
					                                       f32_2 %532 = OpVectorShuffle %531 %531 0 1 
					                                       f32_4 %533 = OpImageSampleExplicitLod %530 %532 Lod %7 
					                                         f32 %534 = OpCompositeExtract %533 1 
					                                Private f32* %535 = OpAccessChain %9 %34 
					                                                      OpStore %535 %534 
					                         read_only Texture2D %536 = OpLoad %399 
					                                     sampler %537 = OpLoad %403 
					                  read_only Texture2DSampled %538 = OpSampledImage %536 %537 
					                                       f32_2 %539 = OpLoad %492 
					                                       f32_4 %540 = OpImageSampleExplicitLod %538 %539 Lod %7 
					                                         f32 %541 = OpCompositeExtract %540 2 
					                                Private f32* %542 = OpAccessChain %9 %56 
					                                                      OpStore %542 %541 
					                                       f32_4 %543 = OpLoad %9 
					                                       f32_2 %544 = OpVectorShuffle %543 %543 0 3 
					                                       f32_4 %545 = OpLoad %9 
					                                       f32_4 %546 = OpVectorShuffle %545 %544 4 1 2 5 
					                                                      OpStore %9 %546 
					                                       f32_4 %547 = OpLoad %9 
					                                       f32_2 %548 = OpVectorShuffle %547 %547 0 3 
					                                       f32_2 %549 = OpCompositeConstruct %224 %224 
					                                       f32_2 %550 = OpCompositeConstruct %225 %225 
					                                       f32_2 %551 = OpExtInst %1 43 %548 %549 %550 
					                                       f32_4 %552 = OpLoad %9 
					                                       f32_4 %553 = OpVectorShuffle %552 %551 4 1 2 5 
					                                                      OpStore %9 %553 
					                                Private f32* %554 = OpAccessChain %9 %34 
					                                         f32 %555 = OpLoad %554 
					                                Private f32* %556 = OpAccessChain %9 %34 
					                                         f32 %557 = OpLoad %556 
					                                         f32 %558 = OpFAdd %555 %557 
					                                Private f32* %559 = OpAccessChain %9 %34 
					                                                      OpStore %559 %558 
					                                       f32_4 %560 = OpLoad %9 
					                                       f32_2 %561 = OpVectorShuffle %560 %560 3 3 
					                                       f32_4 %562 = OpLoad %9 
					                                       f32_2 %563 = OpVectorShuffle %562 %562 0 0 
					                                         f32 %564 = OpDot %561 %563 
					                                Private f32* %565 = OpAccessChain %9 %34 
					                                                      OpStore %565 %564 
					                                Private f32* %566 = OpAccessChain %9 %34 
					                                         f32 %567 = OpLoad %566 
					                                Private f32* %568 = OpAccessChain %363 %30 
					                                         f32 %569 = OpLoad %568 
					                                         f32 %570 = OpFMul %567 %569 
					                                Private f32* %571 = OpAccessChain %9 %34 
					                                                      OpStore %571 %570 
					                              Uniform f32_3* %572 = OpAccessChain %17 %71 
					                                       f32_3 %573 = OpLoad %572 
					                                       f32_2 %574 = OpVectorShuffle %573 %573 1 1 
					                                       f32_4 %575 = OpLoad %9 
					                                       f32_2 %576 = OpVectorShuffle %575 %575 0 0 
					                                         f32 %577 = OpDot %574 %576 
					                                Private f32* %578 = OpAccessChain %9 %34 
					                                                      OpStore %578 %577 
					                                       f32_4 %579 = OpLoad %9 
					                                       f32_3 %580 = OpVectorShuffle %579 %579 0 0 0 
					                                       f32_4 %581 = OpLoad %28 
					                                       f32_3 %582 = OpVectorShuffle %581 %581 0 1 2 
					                                       f32_3 %583 = OpFMul %580 %582 
					                                       f32_2 %584 = OpLoad %363 
					                                       f32_3 %585 = OpVectorShuffle %584 %584 0 0 0 
					                                       f32_3 %586 = OpFAdd %583 %585 
					                                       f32_4 %587 = OpLoad %9 
					                                       f32_4 %588 = OpVectorShuffle %587 %586 4 5 6 3 
					                                                      OpStore %9 %588 
					                                       f32_4 %589 = OpLoad %9 
					                                       f32_3 %590 = OpVectorShuffle %589 %589 0 1 2 
					                                       f32_3 %591 = OpExtInst %1 40 %590 %263 
					                                       f32_4 %592 = OpLoad %9 
					                                       f32_4 %593 = OpVectorShuffle %592 %591 4 5 6 3 
					                                                      OpStore %9 %593 
					                                       f32_4 %594 = OpLoad %9 
					                                       f32_3 %595 = OpVectorShuffle %594 %594 0 1 2 
					                                       f32_3 %598 = OpFMul %595 %597 
					                                       f32_3 %601 = OpFAdd %598 %600 
					                                       f32_4 %602 = OpLoad %28 
					                                       f32_4 %603 = OpVectorShuffle %602 %601 4 5 6 3 
					                                                      OpStore %28 %603 
					                                       f32_4 %604 = OpLoad %9 
					                                       f32_3 %605 = OpVectorShuffle %604 %604 0 1 2 
					                                       f32_3 %608 = OpFMul %605 %607 
					                                       f32_4 %609 = OpLoad %282 
					                                       f32_4 %610 = OpVectorShuffle %609 %608 4 5 6 3 
					                                                      OpStore %282 %610 
					                                       f32_4 %611 = OpLoad %9 
					                                       f32_3 %612 = OpVectorShuffle %611 %611 0 1 2 
					                                       f32_3 %613 = OpFMul %612 %597 
					                                       f32_3 %616 = OpFAdd %613 %615 
					                                       f32_4 %617 = OpLoad %9 
					                                       f32_4 %618 = OpVectorShuffle %617 %616 4 5 6 3 
					                                                      OpStore %9 %618 
					                                       f32_4 %619 = OpLoad %282 
					                                       f32_3 %620 = OpVectorShuffle %619 %619 0 1 2 
					                                       f32_4 %621 = OpLoad %9 
					                                       f32_3 %622 = OpVectorShuffle %621 %621 0 1 2 
					                                       f32_3 %623 = OpFMul %620 %622 
					                                       f32_3 %626 = OpFAdd %623 %625 
					                                       f32_4 %627 = OpLoad %9 
					                                       f32_4 %628 = OpVectorShuffle %627 %626 4 5 6 3 
					                                                      OpStore %9 %628 
					                                       f32_4 %629 = OpLoad %282 
					                                       f32_3 %630 = OpVectorShuffle %629 %629 0 1 2 
					                                       f32_4 %631 = OpLoad %28 
					                                       f32_3 %632 = OpVectorShuffle %631 %631 0 1 2 
					                                       f32_3 %633 = OpFMul %630 %632 
					                                       f32_3 %636 = OpFAdd %633 %635 
					                                       f32_4 %637 = OpLoad %28 
					                                       f32_4 %638 = OpVectorShuffle %637 %636 4 5 6 3 
					                                                      OpStore %28 %638 
					                                       f32_4 %639 = OpLoad %28 
					                                       f32_3 %640 = OpVectorShuffle %639 %639 0 1 2 
					                                       f32_4 %641 = OpLoad %9 
					                                       f32_3 %642 = OpVectorShuffle %641 %641 0 1 2 
					                                       f32_3 %643 = OpFDiv %640 %642 
					                                       f32_4 %644 = OpLoad %9 
					                                       f32_4 %645 = OpVectorShuffle %644 %643 4 5 6 3 
					                                                      OpStore %9 %645 
					                                       f32_4 %646 = OpLoad %9 
					                                       f32_3 %647 = OpVectorShuffle %646 %646 0 1 2 
					                                       f32_3 %650 = OpFAdd %647 %649 
					                                       f32_4 %651 = OpLoad %9 
					                                       f32_4 %652 = OpVectorShuffle %651 %650 4 5 6 3 
					                                                      OpStore %9 %652 
					                                       f32_4 %653 = OpLoad %9 
					                                       f32_3 %654 = OpVectorShuffle %653 %653 0 1 2 
					                                       f32_3 %655 = OpFMul %654 %607 
					                                       f32_4 %656 = OpLoad %9 
					                                       f32_4 %657 = OpVectorShuffle %656 %655 4 5 6 3 
					                                                      OpStore %9 %657 
					                                       f32_4 %660 = OpLoad %9 
					                                       f32_3 %661 = OpVectorShuffle %660 %660 0 1 2 
					                                       f32_3 %662 = OpExtInst %1 40 %661 %263 
					                                       f32_4 %663 = OpLoad %659 
					                                       f32_4 %664 = OpVectorShuffle %663 %662 4 5 6 3 
					                                                      OpStore %659 %664 
					                                 Output f32* %666 = OpAccessChain %659 %56 
					                                                      OpStore %666 %225 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "d3d11 " {
					Keywords { "TONEMAPPING_CUSTOM" }
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
						vec4 unused_0_2[19];
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
					Keywords { "TONEMAPPING_CUSTOM" }
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
					uniform 	vec4 _Lut2D_Params;
					uniform 	vec3 _ColorBalance;
					uniform 	vec3 _ColorFilter;
					uniform 	vec3 _HueSatCon;
					uniform 	vec3 _ChannelMixerRed;
					uniform 	vec3 _ChannelMixerGreen;
					uniform 	vec3 _ChannelMixerBlue;
					uniform 	vec3 _Lift;
					uniform 	vec3 _InvGamma;
					uniform 	vec3 _Gain;
					uniform 	vec4 _CustomToneCurve;
					uniform 	vec4 _ToeSegmentA;
					uniform 	vec4 _ToeSegmentB;
					uniform 	vec4 _MidSegmentA;
					uniform 	vec4 _MidSegmentB;
					uniform 	vec4 _ShoSegmentA;
					uniform 	vec4 _ShoSegmentB;
					UNITY_LOCATION(0) uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat12;
					bool u_xlatb12;
					bvec2 u_xlatb13;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD0.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www + vec3(-0.413588405, -0.413588405, -0.413588405);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.0275523961, 0.0275523961, 0.0275523961);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(13.6054821, 13.6054821, 13.6054821);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0479959995, -0.0479959995, -0.0479959995);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.179999992, 0.179999992, 0.179999992);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7 = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat15.x + u_xlat4.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7 = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = u_xlat0.xyz * _CustomToneCurve.xxx;
					    u_xlatb13.xy = lessThan(u_xlat1.zzzz, _CustomToneCurve.yzyz).xy;
					    u_xlatb2 = lessThan(u_xlat1.xxyy, _CustomToneCurve.yzyz);
					    u_xlat3 = (u_xlatb13.y) ? _MidSegmentA : _ShoSegmentA;
					    u_xlat3 = (u_xlatb13.x) ? _ToeSegmentA : u_xlat3;
					    u_xlat12 = u_xlat0.z * _CustomToneCurve.x + (-u_xlat3.x);
					    u_xlat12 = u_xlat3.z * u_xlat12;
					    u_xlat18 = log2(u_xlat12);
					    u_xlatb12 = 0.0<u_xlat12;
					    u_xlat1.xy = (u_xlatb13.y) ? _MidSegmentB.xy : _ShoSegmentB.xy;
					    u_xlat1.xy = (u_xlatb13.x) ? _ToeSegmentB.xy : u_xlat1.xy;
					    u_xlat18 = u_xlat18 * u_xlat1.y;
					    u_xlat18 = u_xlat18 * 0.693147182 + u_xlat1.x;
					    u_xlat18 = u_xlat18 * 1.44269502;
					    u_xlat18 = exp2(u_xlat18);
					    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
					    u_xlat1.z = u_xlat12 * u_xlat3.w + u_xlat3.y;
					    u_xlat3 = (u_xlatb2.y) ? _MidSegmentA : _ShoSegmentA;
					    u_xlat3 = (u_xlatb2.x) ? _ToeSegmentA : u_xlat3;
					    u_xlat0.x = u_xlat0.x * _CustomToneCurve.x + (-u_xlat3.x);
					    u_xlat0.x = u_xlat3.z * u_xlat0.x;
					    u_xlat12 = log2(u_xlat0.x);
					    u_xlatb0 = 0.0<u_xlat0.x;
					    u_xlat4.x = (u_xlatb2.y) ? _MidSegmentB.x : _ShoSegmentB.x;
					    u_xlat4.y = (u_xlatb2.y) ? _MidSegmentB.y : _ShoSegmentB.y;
					    u_xlat4.z = (u_xlatb2.w) ? _MidSegmentB.x : _ShoSegmentB.x;
					    u_xlat4.w = (u_xlatb2.w) ? _MidSegmentB.y : _ShoSegmentB.y;
					    {
					        vec4 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb2.x) ? _ToeSegmentB.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb2.x) ? _ToeSegmentB.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb2.z) ? _ToeSegmentB.x : u_xlat4.z;
					        hlslcc_movcTemp.w = (u_xlatb2.z) ? _ToeSegmentB.y : u_xlat4.w;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat12 = u_xlat12 * u_xlat4.y;
					    u_xlat12 = u_xlat12 * 0.693147182 + u_xlat4.x;
					    u_xlat12 = u_xlat12 * 1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat0.x = u_xlatb0 ? u_xlat12 : float(0.0);
					    u_xlat1.x = u_xlat0.x * u_xlat3.w + u_xlat3.y;
					    u_xlat3 = (u_xlatb2.w) ? _MidSegmentA : _ShoSegmentA;
					    u_xlat2 = (u_xlatb2.z) ? _ToeSegmentA : u_xlat3;
					    u_xlat0.x = u_xlat0.y * _CustomToneCurve.x + (-u_xlat2.x);
					    u_xlat0.x = u_xlat2.z * u_xlat0.x;
					    u_xlat6.x = log2(u_xlat0.x);
					    u_xlatb0 = 0.0<u_xlat0.x;
					    u_xlat6.x = u_xlat6.x * u_xlat4.w;
					    u_xlat6.x = u_xlat6.x * 0.693147182 + u_xlat4.z;
					    u_xlat6.x = u_xlat6.x * 1.44269502;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat0.x = u_xlatb0 ? u_xlat6.x : float(0.0);
					    u_xlat1.y = u_xlat0.x * u_xlat2.w + u_xlat2.y;
					    SV_Target0.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "TONEMAPPING_CUSTOM" }
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
					; Bound: 991
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %12 %982 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate vs_TEXCOORD0 Location 12 
					                                                      OpMemberDecorate %15 0 Offset 15 
					                                                      OpMemberDecorate %15 1 Offset 15 
					                                                      OpMemberDecorate %15 2 Offset 15 
					                                                      OpMemberDecorate %15 3 Offset 15 
					                                                      OpMemberDecorate %15 4 Offset 15 
					                                                      OpMemberDecorate %15 5 Offset 15 
					                                                      OpMemberDecorate %15 6 Offset 15 
					                                                      OpMemberDecorate %15 7 Offset 15 
					                                                      OpMemberDecorate %15 8 Offset 15 
					                                                      OpMemberDecorate %15 9 Offset 15 
					                                                      OpMemberDecorate %15 10 Offset 15 
					                                                      OpMemberDecorate %15 11 Offset 15 
					                                                      OpMemberDecorate %15 12 Offset 15 
					                                                      OpMemberDecorate %15 13 Offset 15 
					                                                      OpMemberDecorate %15 14 Offset 15 
					                                                      OpMemberDecorate %15 15 Offset 15 
					                                                      OpMemberDecorate %15 16 Offset 15 
					                                                      OpDecorate %15 Block 
					                                                      OpDecorate %17 DescriptorSet 17 
					                                                      OpDecorate %17 Binding 17 
					                                                      OpDecorate %399 DescriptorSet 399 
					                                                      OpDecorate %399 Binding 399 
					                                                      OpDecorate %403 DescriptorSet 403 
					                                                      OpDecorate %403 Binding 403 
					                                                      OpDecorate %982 Location 982 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 2 
					                                              %11 = OpTypePointer Input %10 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                              %14 = OpTypeVector %6 3 
					                                              %15 = OpTypeStruct %7 %14 %14 %14 %14 %14 %14 %14 %14 %14 %7 %7 %7 %7 %7 %7 %7 
					                                              %16 = OpTypePointer Uniform %15 
					Uniform struct {f32_4; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3; f32_3; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %17 = OpVariable Uniform 
					                                              %18 = OpTypeInt 32 1 
					                                          i32 %19 = OpConstant 0 
					                                              %20 = OpTypePointer Uniform %7 
					                               Private f32_4* %28 = OpVariable Private 
					                                              %29 = OpTypeInt 32 0 
					                                          u32 %30 = OpConstant 1 
					                                              %31 = OpTypePointer Private %6 
					                                          u32 %34 = OpConstant 0 
					                                              %35 = OpTypePointer Uniform %6 
					                                          u32 %56 = OpConstant 3 
					                                          f32 %64 = OpConstant 3,674022E-40 
					                                        f32_3 %65 = OpConstantComposite %64 %64 %64 
					                                          i32 %71 = OpConstant 3 
					                                              %72 = OpTypePointer Uniform %14 
					                                          f32 %77 = OpConstant 3,674022E-40 
					                                        f32_3 %78 = OpConstantComposite %77 %77 %77 
					                                          f32 %84 = OpConstant 3,674022E-40 
					                                        f32_3 %85 = OpConstantComposite %84 %84 %84 
					                                          f32 %96 = OpConstant 3,674022E-40 
					                                        f32_3 %97 = OpConstantComposite %96 %96 %96 
					                                         f32 %103 = OpConstant 3,674022E-40 
					                                       f32_3 %104 = OpConstantComposite %103 %103 %103 
					                                         f32 %108 = OpConstant 3,674022E-40 
					                                         f32 %109 = OpConstant 3,674022E-40 
					                                         f32 %110 = OpConstant 3,674022E-40 
					                                       f32_3 %111 = OpConstantComposite %108 %109 %110 
					                                         f32 %116 = OpConstant 3,674022E-40 
					                                         f32 %117 = OpConstant 3,674022E-40 
					                                         f32 %118 = OpConstant 3,674022E-40 
					                                       f32_3 %119 = OpConstantComposite %116 %117 %118 
					                                         f32 %124 = OpConstant 3,674022E-40 
					                                         f32 %125 = OpConstant 3,674022E-40 
					                                         f32 %126 = OpConstant 3,674022E-40 
					                                       f32_3 %127 = OpConstantComposite %124 %125 %126 
					                                         u32 %131 = OpConstant 2 
					                                         i32 %135 = OpConstant 1 
					                                         f32 %141 = OpConstant 3,674022E-40 
					                                         f32 %142 = OpConstant 3,674022E-40 
					                                         f32 %143 = OpConstant 3,674022E-40 
					                                       f32_3 %144 = OpConstantComposite %141 %142 %143 
					                                         f32 %149 = OpConstant 3,674022E-40 
					                                         f32 %150 = OpConstant 3,674022E-40 
					                                         f32 %151 = OpConstant 3,674022E-40 
					                                       f32_3 %152 = OpConstantComposite %149 %150 %151 
					                                         f32 %157 = OpConstant 3,674022E-40 
					                                         f32 %158 = OpConstant 3,674022E-40 
					                                         f32 %159 = OpConstant 3,674022E-40 
					                                       f32_3 %160 = OpConstantComposite %157 %158 %159 
					                                         i32 %167 = OpConstant 2 
					                                         i32 %175 = OpConstant 4 
					                                         i32 %182 = OpConstant 5 
					                                         i32 %189 = OpConstant 6 
					                                         i32 %196 = OpConstant 9 
					                                         i32 %200 = OpConstant 7 
					                                         f32 %214 = OpConstant 3,674022E-40 
					                                       f32_3 %215 = OpConstantComposite %214 %214 %214 
					                                         f32 %217 = OpConstant 3,674022E-40 
					                                       f32_3 %218 = OpConstantComposite %217 %217 %217 
					                                         f32 %224 = OpConstant 3,674022E-40 
					                                         f32 %225 = OpConstant 3,674022E-40 
					                                         f32 %233 = OpConstant 3,674022E-40 
					                                       f32_3 %234 = OpConstantComposite %233 %233 %233 
					                                         f32 %236 = OpConstant 3,674022E-40 
					                                       f32_3 %237 = OpConstantComposite %236 %236 %236 
					                                         i32 %243 = OpConstant 8 
					                                       f32_3 %263 = OpConstantComposite %224 %224 %224 
					                                             %267 = OpTypeBool 
					                                             %268 = OpTypePointer Private %267 
					                               Private bool* %269 = OpVariable Private 
					                                Private f32* %275 = OpVariable Private 
					                              Private f32_4* %282 = OpVariable Private 
					                                         f32 %292 = OpConstant 3,674022E-40 
					                              Private f32_4* %317 = OpVariable Private 
					                                         f32 %320 = OpConstant 3,674022E-40 
					                                         f32 %321 = OpConstant 3,674022E-40 
					                                         f32 %322 = OpConstant 3,674022E-40 
					                                       f32_3 %323 = OpConstantComposite %320 %321 %322 
					                                             %353 = OpTypePointer Private %14 
					                              Private f32_3* %354 = OpVariable Private 
					                                         f32 %357 = OpConstant 3,674022E-40 
					                                         f32 %359 = OpConstant 3,674022E-40 
					                                             %362 = OpTypePointer Private %10 
					                              Private f32_2* %363 = OpVariable Private 
					                              Private f32_2* %387 = OpVariable Private 
					                                         f32 %394 = OpConstant 3,674022E-40 
					                                             %397 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                             %398 = OpTypePointer UniformConstant %397 
					        UniformConstant read_only Texture2D* %399 = OpVariable UniformConstant 
					                                             %401 = OpTypeSampler 
					                                             %402 = OpTypePointer UniformConstant %401 
					                    UniformConstant sampler* %403 = OpVariable UniformConstant 
					                                             %405 = OpTypeSampledImage %397 
					                                         f32 %432 = OpConstant 3,674022E-40 
					                                         f32 %433 = OpConstant 3,674022E-40 
					                                       f32_3 %434 = OpConstantComposite %432 %217 %433 
					                               Private bool* %436 = OpVariable Private 
					                                             %441 = OpTypePointer Function %6 
					                                         f32 %468 = OpConstant 3,674022E-40 
					                                       f32_3 %469 = OpConstantComposite %225 %292 %468 
					                                       f32_3 %474 = OpConstantComposite %357 %357 %357 
					                                         f32 %476 = OpConstant 3,674022E-40 
					                                       f32_3 %477 = OpConstantComposite %476 %476 %476 
					                              Private f32_2* %492 = OpVariable Private 
					                                       f32_3 %503 = OpConstantComposite %225 %225 %225 
					                                         i32 %599 = OpConstant 10 
					                                             %606 = OpTypeVector %267 2 
					                                             %607 = OpTypePointer Private %606 
					                             Private bool_2* %608 = OpVariable Private 
					                                             %614 = OpTypeVector %267 4 
					                                             %617 = OpTypePointer Private %614 
					                             Private bool_4* %618 = OpVariable Private 
					                                             %627 = OpTypePointer Function %7 
					                                         i32 %631 = OpConstant 13 
					                                         i32 %635 = OpConstant 15 
					                                         i32 %644 = OpConstant 11 
					                                Private f32* %650 = OpVariable Private 
					                               Private bool* %666 = OpVariable Private 
					                                             %671 = OpTypePointer Function %10 
					                                         i32 %675 = OpConstant 14 
					                                         i32 %680 = OpConstant 16 
					                                         i32 %692 = OpConstant 12 
					                                         f32 %707 = OpConstant 3,674022E-40 
					                                         f32 %713 = OpConstant 3,674022E-40 
					                               Private bool* %768 = OpVariable Private 
					                              Private f32_4* %772 = OpVariable Private 
					                                             %981 = OpTypePointer Output %7 
					                               Output f32_4* %982 = OpVariable Output 
					                                             %988 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                               Function f32* %442 = OpVariable Function 
					                               Function f32* %456 = OpVariable Function 
					                             Function f32_4* %628 = OpVariable Function 
					                             Function f32_4* %641 = OpVariable Function 
					                             Function f32_2* %672 = OpVariable Function 
					                             Function f32_2* %689 = OpVariable Function 
					                             Function f32_4* %730 = OpVariable Function 
					                             Function f32_4* %741 = OpVariable Function 
					                               Function f32* %775 = OpVariable Function 
					                               Function f32* %787 = OpVariable Function 
					                               Function f32* %799 = OpVariable Function 
					                               Function f32* %811 = OpVariable Function 
					                             Function f32_4* %821 = OpVariable Function 
					                               Function f32* %825 = OpVariable Function 
					                               Function f32* %837 = OpVariable Function 
					                               Function f32* %849 = OpVariable Function 
					                               Function f32* %861 = OpVariable Function 
					                             Function f32_4* %900 = OpVariable Function 
					                             Function f32_4* %911 = OpVariable Function 
					                               Function f32* %964 = OpVariable Function 
					                                        f32_2 %13 = OpLoad vs_TEXCOORD0 
					                               Uniform f32_4* %21 = OpAccessChain %17 %19 
					                                        f32_4 %22 = OpLoad %21 
					                                        f32_2 %23 = OpVectorShuffle %22 %22 1 2 
					                                        f32_2 %24 = OpFNegate %23 
					                                        f32_2 %25 = OpFAdd %13 %24 
					                                        f32_4 %26 = OpLoad %9 
					                                        f32_4 %27 = OpVectorShuffle %26 %25 0 4 5 3 
					                                                      OpStore %9 %27 
					                                 Private f32* %32 = OpAccessChain %9 %30 
					                                          f32 %33 = OpLoad %32 
					                                 Uniform f32* %36 = OpAccessChain %17 %19 %34 
					                                          f32 %37 = OpLoad %36 
					                                          f32 %38 = OpFMul %33 %37 
					                                 Private f32* %39 = OpAccessChain %28 %34 
					                                                      OpStore %39 %38 
					                                 Private f32* %40 = OpAccessChain %28 %34 
					                                          f32 %41 = OpLoad %40 
					                                          f32 %42 = OpExtInst %1 10 %41 
					                                 Private f32* %43 = OpAccessChain %9 %34 
					                                                      OpStore %43 %42 
					                                 Private f32* %44 = OpAccessChain %9 %34 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %46 = OpAccessChain %17 %19 %34 
					                                          f32 %47 = OpLoad %46 
					                                          f32 %48 = OpFDiv %45 %47 
					                                 Private f32* %49 = OpAccessChain %28 %34 
					                                                      OpStore %49 %48 
					                                 Private f32* %50 = OpAccessChain %9 %30 
					                                          f32 %51 = OpLoad %50 
					                                 Private f32* %52 = OpAccessChain %28 %34 
					                                          f32 %53 = OpLoad %52 
					                                          f32 %54 = OpFNegate %53 
					                                          f32 %55 = OpFAdd %51 %54 
					                                 Private f32* %57 = OpAccessChain %9 %56 
					                                                      OpStore %57 %55 
					                                        f32_4 %58 = OpLoad %9 
					                                        f32_3 %59 = OpVectorShuffle %58 %58 0 2 3 
					                               Uniform f32_4* %60 = OpAccessChain %17 %19 
					                                        f32_4 %61 = OpLoad %60 
					                                        f32_3 %62 = OpVectorShuffle %61 %61 3 3 3 
					                                        f32_3 %63 = OpFMul %59 %62 
					                                        f32_3 %66 = OpFAdd %63 %65 
					                                        f32_4 %67 = OpLoad %9 
					                                        f32_4 %68 = OpVectorShuffle %67 %66 4 5 6 3 
					                                                      OpStore %9 %68 
					                                        f32_4 %69 = OpLoad %9 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 0 1 2 
					                               Uniform f32_3* %73 = OpAccessChain %17 %71 
					                                        f32_3 %74 = OpLoad %73 
					                                        f32_3 %75 = OpVectorShuffle %74 %74 2 2 2 
					                                        f32_3 %76 = OpFMul %70 %75 
					                                        f32_3 %79 = OpFAdd %76 %78 
					                                        f32_4 %80 = OpLoad %9 
					                                        f32_4 %81 = OpVectorShuffle %80 %79 4 5 6 3 
					                                                      OpStore %9 %81 
					                                        f32_4 %82 = OpLoad %9 
					                                        f32_3 %83 = OpVectorShuffle %82 %82 0 1 2 
					                                        f32_3 %86 = OpFMul %83 %85 
					                                        f32_4 %87 = OpLoad %9 
					                                        f32_4 %88 = OpVectorShuffle %87 %86 4 5 6 3 
					                                                      OpStore %9 %88 
					                                        f32_4 %89 = OpLoad %9 
					                                        f32_3 %90 = OpVectorShuffle %89 %89 0 1 2 
					                                        f32_3 %91 = OpExtInst %1 29 %90 
					                                        f32_4 %92 = OpLoad %9 
					                                        f32_4 %93 = OpVectorShuffle %92 %91 4 5 6 3 
					                                                      OpStore %9 %93 
					                                        f32_4 %94 = OpLoad %9 
					                                        f32_3 %95 = OpVectorShuffle %94 %94 0 1 2 
					                                        f32_3 %98 = OpFAdd %95 %97 
					                                        f32_4 %99 = OpLoad %9 
					                                       f32_4 %100 = OpVectorShuffle %99 %98 4 5 6 3 
					                                                      OpStore %9 %100 
					                                       f32_4 %101 = OpLoad %9 
					                                       f32_3 %102 = OpVectorShuffle %101 %101 0 1 2 
					                                       f32_3 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %9 
					                                       f32_4 %107 = OpVectorShuffle %106 %105 4 5 6 3 
					                                                      OpStore %9 %107 
					                                       f32_4 %112 = OpLoad %9 
					                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
					                                         f32 %114 = OpDot %111 %113 
					                                Private f32* %115 = OpAccessChain %28 %34 
					                                                      OpStore %115 %114 
					                                       f32_4 %120 = OpLoad %9 
					                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                                         f32 %122 = OpDot %119 %121 
					                                Private f32* %123 = OpAccessChain %28 %30 
					                                                      OpStore %123 %122 
					                                       f32_4 %128 = OpLoad %9 
					                                       f32_3 %129 = OpVectorShuffle %128 %128 0 1 2 
					                                         f32 %130 = OpDot %127 %129 
					                                Private f32* %132 = OpAccessChain %28 %131 
					                                                      OpStore %132 %130 
					                                       f32_4 %133 = OpLoad %28 
					                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
					                              Uniform f32_3* %136 = OpAccessChain %17 %135 
					                                       f32_3 %137 = OpLoad %136 
					                                       f32_3 %138 = OpFMul %134 %137 
					                                       f32_4 %139 = OpLoad %9 
					                                       f32_4 %140 = OpVectorShuffle %139 %138 4 5 6 3 
					                                                      OpStore %9 %140 
					                                       f32_4 %145 = OpLoad %9 
					                                       f32_3 %146 = OpVectorShuffle %145 %145 0 1 2 
					                                         f32 %147 = OpDot %144 %146 
					                                Private f32* %148 = OpAccessChain %28 %34 
					                                                      OpStore %148 %147 
					                                       f32_4 %153 = OpLoad %9 
					                                       f32_3 %154 = OpVectorShuffle %153 %153 0 1 2 
					                                         f32 %155 = OpDot %152 %154 
					                                Private f32* %156 = OpAccessChain %28 %30 
					                                                      OpStore %156 %155 
					                                       f32_4 %161 = OpLoad %9 
					                                       f32_3 %162 = OpVectorShuffle %161 %161 0 1 2 
					                                         f32 %163 = OpDot %160 %162 
					                                Private f32* %164 = OpAccessChain %28 %131 
					                                                      OpStore %164 %163 
					                                       f32_4 %165 = OpLoad %28 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                              Uniform f32_3* %168 = OpAccessChain %17 %167 
					                                       f32_3 %169 = OpLoad %168 
					                                       f32_3 %170 = OpFMul %166 %169 
					                                       f32_4 %171 = OpLoad %9 
					                                       f32_4 %172 = OpVectorShuffle %171 %170 4 5 6 3 
					                                                      OpStore %9 %172 
					                                       f32_4 %173 = OpLoad %9 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                              Uniform f32_3* %176 = OpAccessChain %17 %175 
					                                       f32_3 %177 = OpLoad %176 
					                                         f32 %178 = OpDot %174 %177 
					                                Private f32* %179 = OpAccessChain %28 %34 
					                                                      OpStore %179 %178 
					                                       f32_4 %180 = OpLoad %9 
					                                       f32_3 %181 = OpVectorShuffle %180 %180 0 1 2 
					                              Uniform f32_3* %183 = OpAccessChain %17 %182 
					                                       f32_3 %184 = OpLoad %183 
					                                         f32 %185 = OpDot %181 %184 
					                                Private f32* %186 = OpAccessChain %28 %30 
					                                                      OpStore %186 %185 
					                                       f32_4 %187 = OpLoad %9 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                              Uniform f32_3* %190 = OpAccessChain %17 %189 
					                                       f32_3 %191 = OpLoad %190 
					                                         f32 %192 = OpDot %188 %191 
					                                Private f32* %193 = OpAccessChain %28 %131 
					                                                      OpStore %193 %192 
					                                       f32_4 %194 = OpLoad %28 
					                                       f32_3 %195 = OpVectorShuffle %194 %194 0 1 2 
					                              Uniform f32_3* %197 = OpAccessChain %17 %196 
					                                       f32_3 %198 = OpLoad %197 
					                                       f32_3 %199 = OpFMul %195 %198 
					                              Uniform f32_3* %201 = OpAccessChain %17 %200 
					                                       f32_3 %202 = OpLoad %201 
					                                       f32_3 %203 = OpFAdd %199 %202 
					                                       f32_4 %204 = OpLoad %9 
					                                       f32_4 %205 = OpVectorShuffle %204 %203 4 5 6 3 
					                                                      OpStore %9 %205 
					                                       f32_4 %206 = OpLoad %9 
					                                       f32_3 %207 = OpVectorShuffle %206 %206 0 1 2 
					                                       f32_3 %208 = OpExtInst %1 4 %207 
					                                       f32_3 %209 = OpExtInst %1 30 %208 
					                                       f32_4 %210 = OpLoad %28 
					                                       f32_4 %211 = OpVectorShuffle %210 %209 4 5 6 3 
					                                                      OpStore %28 %211 
					                                       f32_4 %212 = OpLoad %9 
					                                       f32_3 %213 = OpVectorShuffle %212 %212 0 1 2 
					                                       f32_3 %216 = OpFMul %213 %215 
					                                       f32_3 %219 = OpFAdd %216 %218 
					                                       f32_4 %220 = OpLoad %9 
					                                       f32_4 %221 = OpVectorShuffle %220 %219 4 5 6 3 
					                                                      OpStore %9 %221 
					                                       f32_4 %222 = OpLoad %9 
					                                       f32_3 %223 = OpVectorShuffle %222 %222 0 1 2 
					                                       f32_3 %226 = OpCompositeConstruct %224 %224 %224 
					                                       f32_3 %227 = OpCompositeConstruct %225 %225 %225 
					                                       f32_3 %228 = OpExtInst %1 43 %223 %226 %227 
					                                       f32_4 %229 = OpLoad %9 
					                                       f32_4 %230 = OpVectorShuffle %229 %228 4 5 6 3 
					                                                      OpStore %9 %230 
					                                       f32_4 %231 = OpLoad %9 
					                                       f32_3 %232 = OpVectorShuffle %231 %231 0 1 2 
					                                       f32_3 %235 = OpFMul %232 %234 
					                                       f32_3 %238 = OpFAdd %235 %237 
					                                       f32_4 %239 = OpLoad %9 
					                                       f32_4 %240 = OpVectorShuffle %239 %238 4 5 6 3 
					                                                      OpStore %9 %240 
					                                       f32_4 %241 = OpLoad %28 
					                                       f32_3 %242 = OpVectorShuffle %241 %241 0 1 2 
					                              Uniform f32_3* %244 = OpAccessChain %17 %243 
					                                       f32_3 %245 = OpLoad %244 
					                                       f32_3 %246 = OpFMul %242 %245 
					                                       f32_4 %247 = OpLoad %28 
					                                       f32_4 %248 = OpVectorShuffle %247 %246 4 5 6 3 
					                                                      OpStore %28 %248 
					                                       f32_4 %249 = OpLoad %28 
					                                       f32_3 %250 = OpVectorShuffle %249 %249 0 1 2 
					                                       f32_3 %251 = OpExtInst %1 29 %250 
					                                       f32_4 %252 = OpLoad %28 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 4 5 6 3 
					                                                      OpStore %28 %253 
					                                       f32_4 %254 = OpLoad %9 
					                                       f32_3 %255 = OpVectorShuffle %254 %254 0 1 2 
					                                       f32_4 %256 = OpLoad %28 
					                                       f32_3 %257 = OpVectorShuffle %256 %256 0 1 2 
					                                       f32_3 %258 = OpFMul %255 %257 
					                                       f32_4 %259 = OpLoad %9 
					                                       f32_4 %260 = OpVectorShuffle %259 %258 4 5 6 3 
					                                                      OpStore %9 %260 
					                                       f32_4 %261 = OpLoad %9 
					                                       f32_3 %262 = OpVectorShuffle %261 %261 0 1 2 
					                                       f32_3 %264 = OpExtInst %1 40 %262 %263 
					                                       f32_4 %265 = OpLoad %9 
					                                       f32_4 %266 = OpVectorShuffle %265 %264 4 5 6 3 
					                                                      OpStore %9 %266 
					                                Private f32* %270 = OpAccessChain %9 %30 
					                                         f32 %271 = OpLoad %270 
					                                Private f32* %272 = OpAccessChain %9 %131 
					                                         f32 %273 = OpLoad %272 
					                                        bool %274 = OpFOrdGreaterThanEqual %271 %273 
					                                                      OpStore %269 %274 
					                                        bool %276 = OpLoad %269 
					                                         f32 %277 = OpSelect %276 %225 %224 
					                                                      OpStore %275 %277 
					                                       f32_4 %278 = OpLoad %9 
					                                       f32_2 %279 = OpVectorShuffle %278 %278 2 1 
					                                       f32_4 %280 = OpLoad %28 
					                                       f32_4 %281 = OpVectorShuffle %280 %279 4 5 2 3 
					                                                      OpStore %28 %281 
					                                       f32_4 %283 = OpLoad %9 
					                                       f32_2 %284 = OpVectorShuffle %283 %283 1 2 
					                                       f32_4 %285 = OpLoad %28 
					                                       f32_2 %286 = OpVectorShuffle %285 %285 0 1 
					                                       f32_2 %287 = OpFNegate %286 
					                                       f32_2 %288 = OpFAdd %284 %287 
					                                       f32_4 %289 = OpLoad %282 
					                                       f32_4 %290 = OpVectorShuffle %289 %288 4 5 2 3 
					                                                      OpStore %282 %290 
					                                Private f32* %291 = OpAccessChain %28 %131 
					                                                      OpStore %291 %236 
					                                Private f32* %293 = OpAccessChain %28 %56 
					                                                      OpStore %293 %292 
					                                Private f32* %294 = OpAccessChain %282 %131 
					                                                      OpStore %294 %225 
					                                Private f32* %295 = OpAccessChain %282 %56 
					                                                      OpStore %295 %236 
					                                         f32 %296 = OpLoad %275 
					                                       f32_4 %297 = OpCompositeConstruct %296 %296 %296 %296 
					                                       f32_4 %298 = OpLoad %282 
					                                       f32_4 %299 = OpVectorShuffle %298 %298 0 1 3 2 
					                                       f32_4 %300 = OpFMul %297 %299 
					                                       f32_4 %301 = OpLoad %28 
					                                       f32_4 %302 = OpVectorShuffle %301 %301 0 1 3 2 
					                                       f32_4 %303 = OpFAdd %300 %302 
					                                                      OpStore %28 %303 
					                                Private f32* %304 = OpAccessChain %9 %34 
					                                         f32 %305 = OpLoad %304 
					                                Private f32* %306 = OpAccessChain %28 %34 
					                                         f32 %307 = OpLoad %306 
					                                        bool %308 = OpFOrdGreaterThanEqual %305 %307 
					                                                      OpStore %269 %308 
					                                        bool %309 = OpLoad %269 
					                                         f32 %310 = OpSelect %309 %225 %224 
					                                                      OpStore %275 %310 
					                                Private f32* %311 = OpAccessChain %28 %56 
					                                         f32 %312 = OpLoad %311 
					                                Private f32* %313 = OpAccessChain %282 %131 
					                                                      OpStore %313 %312 
					                                Private f32* %314 = OpAccessChain %9 %34 
					                                         f32 %315 = OpLoad %314 
					                                Private f32* %316 = OpAccessChain %28 %56 
					                                                      OpStore %316 %315 
					                                       f32_4 %318 = OpLoad %9 
					                                       f32_3 %319 = OpVectorShuffle %318 %318 0 1 2 
					                                         f32 %324 = OpDot %319 %323 
					                                Private f32* %325 = OpAccessChain %317 %34 
					                                                      OpStore %325 %324 
					                                       f32_4 %326 = OpLoad %28 
					                                       f32_3 %327 = OpVectorShuffle %326 %326 3 1 0 
					                                       f32_4 %328 = OpLoad %282 
					                                       f32_4 %329 = OpVectorShuffle %328 %327 4 5 2 6 
					                                                      OpStore %282 %329 
					                                       f32_4 %330 = OpLoad %28 
					                                       f32_4 %331 = OpFNegate %330 
					                                       f32_4 %332 = OpLoad %282 
					                                       f32_4 %333 = OpFAdd %331 %332 
					                                                      OpStore %282 %333 
					                                         f32 %334 = OpLoad %275 
					                                       f32_4 %335 = OpCompositeConstruct %334 %334 %334 %334 
					                                       f32_4 %336 = OpLoad %282 
					                                       f32_4 %337 = OpFMul %335 %336 
					                                       f32_4 %338 = OpLoad %28 
					                                       f32_4 %339 = OpFAdd %337 %338 
					                                                      OpStore %9 %339 
					                                Private f32* %340 = OpAccessChain %9 %30 
					                                         f32 %341 = OpLoad %340 
					                                Private f32* %342 = OpAccessChain %9 %56 
					                                         f32 %343 = OpLoad %342 
					                                         f32 %344 = OpExtInst %1 37 %341 %343 
					                                Private f32* %345 = OpAccessChain %28 %34 
					                                                      OpStore %345 %344 
					                                Private f32* %346 = OpAccessChain %9 %34 
					                                         f32 %347 = OpLoad %346 
					                                Private f32* %348 = OpAccessChain %28 %34 
					                                         f32 %349 = OpLoad %348 
					                                         f32 %350 = OpFNegate %349 
					                                         f32 %351 = OpFAdd %347 %350 
					                                Private f32* %352 = OpAccessChain %28 %34 
					                                                      OpStore %352 %351 
					                                Private f32* %355 = OpAccessChain %28 %34 
					                                         f32 %356 = OpLoad %355 
					                                         f32 %358 = OpFMul %356 %357 
					                                         f32 %360 = OpFAdd %358 %359 
					                                Private f32* %361 = OpAccessChain %354 %34 
					                                                      OpStore %361 %360 
					                                Private f32* %364 = OpAccessChain %9 %30 
					                                         f32 %365 = OpLoad %364 
					                                         f32 %366 = OpFNegate %365 
					                                Private f32* %367 = OpAccessChain %9 %56 
					                                         f32 %368 = OpLoad %367 
					                                         f32 %369 = OpFAdd %366 %368 
					                                Private f32* %370 = OpAccessChain %363 %34 
					                                                      OpStore %370 %369 
					                                Private f32* %371 = OpAccessChain %363 %34 
					                                         f32 %372 = OpLoad %371 
					                                Private f32* %373 = OpAccessChain %354 %34 
					                                         f32 %374 = OpLoad %373 
					                                         f32 %375 = OpFDiv %372 %374 
					                                Private f32* %376 = OpAccessChain %363 %34 
					                                                      OpStore %376 %375 
					                                Private f32* %377 = OpAccessChain %363 %34 
					                                         f32 %378 = OpLoad %377 
					                                Private f32* %379 = OpAccessChain %9 %131 
					                                         f32 %380 = OpLoad %379 
					                                         f32 %381 = OpFAdd %378 %380 
					                                Private f32* %382 = OpAccessChain %363 %34 
					                                                      OpStore %382 %381 
					                                Private f32* %383 = OpAccessChain %363 %34 
					                                         f32 %384 = OpLoad %383 
					                                         f32 %385 = OpExtInst %1 4 %384 
					                                Private f32* %386 = OpAccessChain %282 %34 
					                                                      OpStore %386 %385 
					                                Private f32* %388 = OpAccessChain %282 %34 
					                                         f32 %389 = OpLoad %388 
					                                Uniform f32* %390 = OpAccessChain %17 %71 %34 
					                                         f32 %391 = OpLoad %390 
					                                         f32 %392 = OpFAdd %389 %391 
					                                Private f32* %393 = OpAccessChain %387 %34 
					                                                      OpStore %393 %392 
					                                Private f32* %395 = OpAccessChain %317 %30 
					                                                      OpStore %395 %394 
					                                Private f32* %396 = OpAccessChain %387 %30 
					                                                      OpStore %396 %394 
					                         read_only Texture2D %400 = OpLoad %399 
					                                     sampler %404 = OpLoad %403 
					                  read_only Texture2DSampled %406 = OpSampledImage %400 %404 
					                                       f32_2 %407 = OpLoad %387 
					                                       f32_4 %408 = OpImageSampleExplicitLod %406 %407 Lod %7 
					                                         f32 %409 = OpCompositeExtract %408 0 
					                                Private f32* %410 = OpAccessChain %363 %34 
					                                                      OpStore %410 %409 
					                         read_only Texture2D %411 = OpLoad %399 
					                                     sampler %412 = OpLoad %403 
					                  read_only Texture2DSampled %413 = OpSampledImage %411 %412 
					                                       f32_4 %414 = OpLoad %317 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_4 %416 = OpImageSampleExplicitLod %413 %415 Lod %7 
					                                         f32 %417 = OpCompositeExtract %416 3 
					                                Private f32* %418 = OpAccessChain %363 %30 
					                                                      OpStore %418 %417 
					                                       f32_2 %419 = OpLoad %363 
					                                                      OpStore %363 %419 
					                                       f32_2 %420 = OpLoad %363 
					                                       f32_2 %421 = OpCompositeConstruct %224 %224 
					                                       f32_2 %422 = OpCompositeConstruct %225 %225 
					                                       f32_2 %423 = OpExtInst %1 43 %420 %421 %422 
					                                                      OpStore %363 %423 
					                                Private f32* %424 = OpAccessChain %387 %34 
					                                         f32 %425 = OpLoad %424 
					                                Private f32* %426 = OpAccessChain %363 %34 
					                                         f32 %427 = OpLoad %426 
					                                         f32 %428 = OpFAdd %425 %427 
					                                Private f32* %429 = OpAccessChain %363 %34 
					                                                      OpStore %429 %428 
					                                       f32_2 %430 = OpLoad %363 
					                                       f32_3 %431 = OpVectorShuffle %430 %430 0 0 0 
					                                       f32_3 %435 = OpFAdd %431 %434 
					                                                      OpStore %354 %435 
					                                Private f32* %437 = OpAccessChain %354 %34 
					                                         f32 %438 = OpLoad %437 
					                                        bool %439 = OpFOrdLessThan %225 %438 
					                                                      OpStore %436 %439 
					                                        bool %440 = OpLoad %436 
					                                                      OpSelectionMerge %444 None 
					                                                      OpBranchConditional %440 %443 %447 
					                                             %443 = OpLabel 
					                                Private f32* %445 = OpAccessChain %354 %131 
					                                         f32 %446 = OpLoad %445 
					                                                      OpStore %442 %446 
					                                                      OpBranch %444 
					                                             %447 = OpLabel 
					                                Private f32* %448 = OpAccessChain %354 %34 
					                                         f32 %449 = OpLoad %448 
					                                                      OpStore %442 %449 
					                                                      OpBranch %444 
					                                             %444 = OpLabel 
					                                         f32 %450 = OpLoad %442 
					                                Private f32* %451 = OpAccessChain %363 %34 
					                                                      OpStore %451 %450 
					                                Private f32* %452 = OpAccessChain %354 %34 
					                                         f32 %453 = OpLoad %452 
					                                        bool %454 = OpFOrdLessThan %453 %224 
					                                                      OpStore %269 %454 
					                                        bool %455 = OpLoad %269 
					                                                      OpSelectionMerge %458 None 
					                                                      OpBranchConditional %455 %457 %461 
					                                             %457 = OpLabel 
					                                Private f32* %459 = OpAccessChain %354 %30 
					                                         f32 %460 = OpLoad %459 
					                                                      OpStore %456 %460 
					                                                      OpBranch %458 
					                                             %461 = OpLabel 
					                                Private f32* %462 = OpAccessChain %363 %34 
					                                         f32 %463 = OpLoad %462 
					                                                      OpStore %456 %463 
					                                                      OpBranch %458 
					                                             %458 = OpLabel 
					                                         f32 %464 = OpLoad %456 
					                                Private f32* %465 = OpAccessChain %363 %34 
					                                                      OpStore %465 %464 
					                                       f32_2 %466 = OpLoad %363 
					                                       f32_3 %467 = OpVectorShuffle %466 %466 0 0 0 
					                                       f32_3 %470 = OpFAdd %467 %469 
					                                                      OpStore %354 %470 
					                                       f32_3 %471 = OpLoad %354 
					                                       f32_3 %472 = OpExtInst %1 10 %471 
					                                                      OpStore %354 %472 
					                                       f32_3 %473 = OpLoad %354 
					                                       f32_3 %475 = OpFMul %473 %474 
					                                       f32_3 %478 = OpFAdd %475 %477 
					                                                      OpStore %354 %478 
					                                       f32_3 %479 = OpLoad %354 
					                                       f32_3 %480 = OpExtInst %1 4 %479 
					                                       f32_3 %481 = OpFAdd %480 %237 
					                                                      OpStore %354 %481 
					                                       f32_3 %482 = OpLoad %354 
					                                       f32_3 %483 = OpCompositeConstruct %224 %224 %224 
					                                       f32_3 %484 = OpCompositeConstruct %225 %225 %225 
					                                       f32_3 %485 = OpExtInst %1 43 %482 %483 %484 
					                                                      OpStore %354 %485 
					                                       f32_3 %486 = OpLoad %354 
					                                       f32_3 %487 = OpFAdd %486 %237 
					                                                      OpStore %354 %487 
					                                Private f32* %488 = OpAccessChain %9 %34 
					                                         f32 %489 = OpLoad %488 
					                                         f32 %490 = OpFAdd %489 %359 
					                                Private f32* %491 = OpAccessChain %363 %34 
					                                                      OpStore %491 %490 
					                                Private f32* %493 = OpAccessChain %28 %34 
					                                         f32 %494 = OpLoad %493 
					                                Private f32* %495 = OpAccessChain %363 %34 
					                                         f32 %496 = OpLoad %495 
					                                         f32 %497 = OpFDiv %494 %496 
					                                Private f32* %498 = OpAccessChain %492 %34 
					                                                      OpStore %498 %497 
					                                       f32_2 %499 = OpLoad %492 
					                                       f32_3 %500 = OpVectorShuffle %499 %499 0 0 0 
					                                       f32_3 %501 = OpLoad %354 
					                                       f32_3 %502 = OpFMul %500 %501 
					                                       f32_3 %504 = OpFAdd %502 %503 
					                                       f32_4 %505 = OpLoad %28 
					                                       f32_4 %506 = OpVectorShuffle %505 %504 4 5 6 3 
					                                                      OpStore %28 %506 
					                                       f32_4 %507 = OpLoad %9 
					                                       f32_3 %508 = OpVectorShuffle %507 %507 0 0 0 
					                                       f32_4 %509 = OpLoad %28 
					                                       f32_3 %510 = OpVectorShuffle %509 %509 0 1 2 
					                                       f32_3 %511 = OpFMul %508 %510 
					                                       f32_4 %512 = OpLoad %317 
					                                       f32_4 %513 = OpVectorShuffle %512 %511 4 5 6 3 
					                                                      OpStore %317 %513 
					                                       f32_4 %514 = OpLoad %317 
					                                       f32_3 %515 = OpVectorShuffle %514 %514 0 1 2 
					                                         f32 %516 = OpDot %515 %323 
					                                Private f32* %517 = OpAccessChain %363 %34 
					                                                      OpStore %517 %516 
					                                       f32_4 %518 = OpLoad %9 
					                                       f32_3 %519 = OpVectorShuffle %518 %518 0 0 0 
					                                       f32_4 %520 = OpLoad %28 
					                                       f32_3 %521 = OpVectorShuffle %520 %520 0 1 2 
					                                       f32_3 %522 = OpFMul %519 %521 
					                                       f32_2 %523 = OpLoad %363 
					                                       f32_3 %524 = OpVectorShuffle %523 %523 0 0 0 
					                                       f32_3 %525 = OpFNegate %524 
					                                       f32_3 %526 = OpFAdd %522 %525 
					                                       f32_4 %527 = OpLoad %28 
					                                       f32_4 %528 = OpVectorShuffle %527 %526 4 5 6 3 
					                                                      OpStore %28 %528 
					                                Private f32* %529 = OpAccessChain %282 %30 
					                                                      OpStore %529 %394 
					                                Private f32* %530 = OpAccessChain %492 %30 
					                                                      OpStore %530 %394 
					                         read_only Texture2D %531 = OpLoad %399 
					                                     sampler %532 = OpLoad %403 
					                  read_only Texture2DSampled %533 = OpSampledImage %531 %532 
					                                       f32_4 %534 = OpLoad %282 
					                                       f32_2 %535 = OpVectorShuffle %534 %534 0 1 
					                                       f32_4 %536 = OpImageSampleExplicitLod %533 %535 Lod %7 
					                                         f32 %537 = OpCompositeExtract %536 1 
					                                Private f32* %538 = OpAccessChain %9 %34 
					                                                      OpStore %538 %537 
					                         read_only Texture2D %539 = OpLoad %399 
					                                     sampler %540 = OpLoad %403 
					                  read_only Texture2DSampled %541 = OpSampledImage %539 %540 
					                                       f32_2 %542 = OpLoad %492 
					                                       f32_4 %543 = OpImageSampleExplicitLod %541 %542 Lod %7 
					                                         f32 %544 = OpCompositeExtract %543 2 
					                                Private f32* %545 = OpAccessChain %9 %56 
					                                                      OpStore %545 %544 
					                                       f32_4 %546 = OpLoad %9 
					                                       f32_2 %547 = OpVectorShuffle %546 %546 0 3 
					                                       f32_4 %548 = OpLoad %9 
					                                       f32_4 %549 = OpVectorShuffle %548 %547 4 1 2 5 
					                                                      OpStore %9 %549 
					                                       f32_4 %550 = OpLoad %9 
					                                       f32_2 %551 = OpVectorShuffle %550 %550 0 3 
					                                       f32_2 %552 = OpCompositeConstruct %224 %224 
					                                       f32_2 %553 = OpCompositeConstruct %225 %225 
					                                       f32_2 %554 = OpExtInst %1 43 %551 %552 %553 
					                                       f32_4 %555 = OpLoad %9 
					                                       f32_4 %556 = OpVectorShuffle %555 %554 4 1 2 5 
					                                                      OpStore %9 %556 
					                                Private f32* %557 = OpAccessChain %9 %34 
					                                         f32 %558 = OpLoad %557 
					                                Private f32* %559 = OpAccessChain %9 %34 
					                                         f32 %560 = OpLoad %559 
					                                         f32 %561 = OpFAdd %558 %560 
					                                Private f32* %562 = OpAccessChain %9 %34 
					                                                      OpStore %562 %561 
					                                       f32_4 %563 = OpLoad %9 
					                                       f32_2 %564 = OpVectorShuffle %563 %563 3 3 
					                                       f32_4 %565 = OpLoad %9 
					                                       f32_2 %566 = OpVectorShuffle %565 %565 0 0 
					                                         f32 %567 = OpDot %564 %566 
					                                Private f32* %568 = OpAccessChain %9 %34 
					                                                      OpStore %568 %567 
					                                Private f32* %569 = OpAccessChain %9 %34 
					                                         f32 %570 = OpLoad %569 
					                                Private f32* %571 = OpAccessChain %363 %30 
					                                         f32 %572 = OpLoad %571 
					                                         f32 %573 = OpFMul %570 %572 
					                                Private f32* %574 = OpAccessChain %9 %34 
					                                                      OpStore %574 %573 
					                              Uniform f32_3* %575 = OpAccessChain %17 %71 
					                                       f32_3 %576 = OpLoad %575 
					                                       f32_2 %577 = OpVectorShuffle %576 %576 1 1 
					                                       f32_4 %578 = OpLoad %9 
					                                       f32_2 %579 = OpVectorShuffle %578 %578 0 0 
					                                         f32 %580 = OpDot %577 %579 
					                                Private f32* %581 = OpAccessChain %9 %34 
					                                                      OpStore %581 %580 
					                                       f32_4 %582 = OpLoad %9 
					                                       f32_3 %583 = OpVectorShuffle %582 %582 0 0 0 
					                                       f32_4 %584 = OpLoad %28 
					                                       f32_3 %585 = OpVectorShuffle %584 %584 0 1 2 
					                                       f32_3 %586 = OpFMul %583 %585 
					                                       f32_2 %587 = OpLoad %363 
					                                       f32_3 %588 = OpVectorShuffle %587 %587 0 0 0 
					                                       f32_3 %589 = OpFAdd %586 %588 
					                                       f32_4 %590 = OpLoad %9 
					                                       f32_4 %591 = OpVectorShuffle %590 %589 4 5 6 3 
					                                                      OpStore %9 %591 
					                                       f32_4 %592 = OpLoad %9 
					                                       f32_3 %593 = OpVectorShuffle %592 %592 0 1 2 
					                                       f32_3 %594 = OpExtInst %1 40 %593 %263 
					                                       f32_4 %595 = OpLoad %9 
					                                       f32_4 %596 = OpVectorShuffle %595 %594 4 5 6 3 
					                                                      OpStore %9 %596 
					                                       f32_4 %597 = OpLoad %9 
					                                       f32_3 %598 = OpVectorShuffle %597 %597 0 1 2 
					                              Uniform f32_4* %600 = OpAccessChain %17 %599 
					                                       f32_4 %601 = OpLoad %600 
					                                       f32_3 %602 = OpVectorShuffle %601 %601 0 0 0 
					                                       f32_3 %603 = OpFMul %598 %602 
					                                       f32_4 %604 = OpLoad %28 
					                                       f32_4 %605 = OpVectorShuffle %604 %603 4 5 6 3 
					                                                      OpStore %28 %605 
					                                       f32_4 %609 = OpLoad %28 
					                                       f32_4 %610 = OpVectorShuffle %609 %609 2 2 2 2 
					                              Uniform f32_4* %611 = OpAccessChain %17 %599 
					                                       f32_4 %612 = OpLoad %611 
					                                       f32_4 %613 = OpVectorShuffle %612 %612 1 2 1 2 
					                                      bool_4 %615 = OpFOrdLessThan %610 %613 
					                                      bool_2 %616 = OpVectorShuffle %615 %615 0 1 
					                                                      OpStore %608 %616 
					                                       f32_4 %619 = OpLoad %28 
					                                       f32_4 %620 = OpVectorShuffle %619 %619 0 0 1 1 
					                              Uniform f32_4* %621 = OpAccessChain %17 %599 
					                                       f32_4 %622 = OpLoad %621 
					                                       f32_4 %623 = OpVectorShuffle %622 %622 1 2 1 2 
					                                      bool_4 %624 = OpFOrdLessThan %620 %623 
					                                                      OpStore %618 %624 
					                               Private bool* %625 = OpAccessChain %608 %30 
					                                        bool %626 = OpLoad %625 
					                                                      OpSelectionMerge %630 None 
					                                                      OpBranchConditional %626 %629 %634 
					                                             %629 = OpLabel 
					                              Uniform f32_4* %632 = OpAccessChain %17 %631 
					                                       f32_4 %633 = OpLoad %632 
					                                                      OpStore %628 %633 
					                                                      OpBranch %630 
					                                             %634 = OpLabel 
					                              Uniform f32_4* %636 = OpAccessChain %17 %635 
					                                       f32_4 %637 = OpLoad %636 
					                                                      OpStore %628 %637 
					                                                      OpBranch %630 
					                                             %630 = OpLabel 
					                                       f32_4 %638 = OpLoad %628 
					                                                      OpStore %317 %638 
					                               Private bool* %639 = OpAccessChain %608 %34 
					                                        bool %640 = OpLoad %639 
					                                                      OpSelectionMerge %643 None 
					                                                      OpBranchConditional %640 %642 %647 
					                                             %642 = OpLabel 
					                              Uniform f32_4* %645 = OpAccessChain %17 %644 
					                                       f32_4 %646 = OpLoad %645 
					                                                      OpStore %641 %646 
					                                                      OpBranch %643 
					                                             %647 = OpLabel 
					                                       f32_4 %648 = OpLoad %317 
					                                                      OpStore %641 %648 
					                                                      OpBranch %643 
					                                             %643 = OpLabel 
					                                       f32_4 %649 = OpLoad %641 
					                                                      OpStore %317 %649 
					                                Private f32* %651 = OpAccessChain %9 %131 
					                                         f32 %652 = OpLoad %651 
					                                Uniform f32* %653 = OpAccessChain %17 %599 %34 
					                                         f32 %654 = OpLoad %653 
					                                         f32 %655 = OpFMul %652 %654 
					                                Private f32* %656 = OpAccessChain %317 %34 
					                                         f32 %657 = OpLoad %656 
					                                         f32 %658 = OpFNegate %657 
					                                         f32 %659 = OpFAdd %655 %658 
					                                                      OpStore %650 %659 
					                                Private f32* %660 = OpAccessChain %317 %131 
					                                         f32 %661 = OpLoad %660 
					                                         f32 %662 = OpLoad %650 
					                                         f32 %663 = OpFMul %661 %662 
					                                                      OpStore %650 %663 
					                                         f32 %664 = OpLoad %650 
					                                         f32 %665 = OpExtInst %1 30 %664 
					                                                      OpStore %275 %665 
					                                         f32 %667 = OpLoad %650 
					                                        bool %668 = OpFOrdLessThan %224 %667 
					                                                      OpStore %666 %668 
					                               Private bool* %669 = OpAccessChain %608 %30 
					                                        bool %670 = OpLoad %669 
					                                                      OpSelectionMerge %674 None 
					                                                      OpBranchConditional %670 %673 %679 
					                                             %673 = OpLabel 
					                              Uniform f32_4* %676 = OpAccessChain %17 %675 
					                                       f32_4 %677 = OpLoad %676 
					                                       f32_2 %678 = OpVectorShuffle %677 %677 0 1 
					                                                      OpStore %672 %678 
					                                                      OpBranch %674 
					                                             %679 = OpLabel 
					                              Uniform f32_4* %681 = OpAccessChain %17 %680 
					                                       f32_4 %682 = OpLoad %681 
					                                       f32_2 %683 = OpVectorShuffle %682 %682 0 1 
					                                                      OpStore %672 %683 
					                                                      OpBranch %674 
					                                             %674 = OpLabel 
					                                       f32_2 %684 = OpLoad %672 
					                                       f32_4 %685 = OpLoad %28 
					                                       f32_4 %686 = OpVectorShuffle %685 %684 4 5 2 3 
					                                                      OpStore %28 %686 
					                               Private bool* %687 = OpAccessChain %608 %34 
					                                        bool %688 = OpLoad %687 
					                                                      OpSelectionMerge %691 None 
					                                                      OpBranchConditional %688 %690 %696 
					                                             %690 = OpLabel 
					                              Uniform f32_4* %693 = OpAccessChain %17 %692 
					                                       f32_4 %694 = OpLoad %693 
					                                       f32_2 %695 = OpVectorShuffle %694 %694 0 1 
					                                                      OpStore %689 %695 
					                                                      OpBranch %691 
					                                             %696 = OpLabel 
					                                       f32_4 %697 = OpLoad %28 
					                                       f32_2 %698 = OpVectorShuffle %697 %697 0 1 
					                                                      OpStore %689 %698 
					                                                      OpBranch %691 
					                                             %691 = OpLabel 
					                                       f32_2 %699 = OpLoad %689 
					                                       f32_4 %700 = OpLoad %28 
					                                       f32_4 %701 = OpVectorShuffle %700 %699 4 5 2 3 
					                                                      OpStore %28 %701 
					                                         f32 %702 = OpLoad %275 
					                                Private f32* %703 = OpAccessChain %28 %30 
					                                         f32 %704 = OpLoad %703 
					                                         f32 %705 = OpFMul %702 %704 
					                                                      OpStore %275 %705 
					                                         f32 %706 = OpLoad %275 
					                                         f32 %708 = OpFMul %706 %707 
					                                Private f32* %709 = OpAccessChain %28 %34 
					                                         f32 %710 = OpLoad %709 
					                                         f32 %711 = OpFAdd %708 %710 
					                                                      OpStore %275 %711 
					                                         f32 %712 = OpLoad %275 
					                                         f32 %714 = OpFMul %712 %713 
					                                                      OpStore %275 %714 
					                                         f32 %715 = OpLoad %275 
					                                         f32 %716 = OpExtInst %1 29 %715 
					                                                      OpStore %275 %716 
					                                        bool %717 = OpLoad %666 
					                                         f32 %718 = OpLoad %275 
					                                         f32 %719 = OpSelect %717 %718 %224 
					                                                      OpStore %650 %719 
					                                         f32 %720 = OpLoad %650 
					                                Private f32* %721 = OpAccessChain %317 %56 
					                                         f32 %722 = OpLoad %721 
					                                         f32 %723 = OpFMul %720 %722 
					                                Private f32* %724 = OpAccessChain %317 %30 
					                                         f32 %725 = OpLoad %724 
					                                         f32 %726 = OpFAdd %723 %725 
					                                Private f32* %727 = OpAccessChain %28 %131 
					                                                      OpStore %727 %726 
					                               Private bool* %728 = OpAccessChain %618 %30 
					                                        bool %729 = OpLoad %728 
					                                                      OpSelectionMerge %732 None 
					                                                      OpBranchConditional %729 %731 %735 
					                                             %731 = OpLabel 
					                              Uniform f32_4* %733 = OpAccessChain %17 %631 
					                                       f32_4 %734 = OpLoad %733 
					                                                      OpStore %730 %734 
					                                                      OpBranch %732 
					                                             %735 = OpLabel 
					                              Uniform f32_4* %736 = OpAccessChain %17 %635 
					                                       f32_4 %737 = OpLoad %736 
					                                                      OpStore %730 %737 
					                                                      OpBranch %732 
					                                             %732 = OpLabel 
					                                       f32_4 %738 = OpLoad %730 
					                                                      OpStore %317 %738 
					                               Private bool* %739 = OpAccessChain %618 %34 
					                                        bool %740 = OpLoad %739 
					                                                      OpSelectionMerge %743 None 
					                                                      OpBranchConditional %740 %742 %746 
					                                             %742 = OpLabel 
					                              Uniform f32_4* %744 = OpAccessChain %17 %644 
					                                       f32_4 %745 = OpLoad %744 
					                                                      OpStore %741 %745 
					                                                      OpBranch %743 
					                                             %746 = OpLabel 
					                                       f32_4 %747 = OpLoad %317 
					                                                      OpStore %741 %747 
					                                                      OpBranch %743 
					                                             %743 = OpLabel 
					                                       f32_4 %748 = OpLoad %741 
					                                                      OpStore %317 %748 
					                                Private f32* %749 = OpAccessChain %9 %34 
					                                         f32 %750 = OpLoad %749 
					                                Uniform f32* %751 = OpAccessChain %17 %599 %34 
					                                         f32 %752 = OpLoad %751 
					                                         f32 %753 = OpFMul %750 %752 
					                                Private f32* %754 = OpAccessChain %317 %34 
					                                         f32 %755 = OpLoad %754 
					                                         f32 %756 = OpFNegate %755 
					                                         f32 %757 = OpFAdd %753 %756 
					                                Private f32* %758 = OpAccessChain %9 %34 
					                                                      OpStore %758 %757 
					                                Private f32* %759 = OpAccessChain %317 %131 
					                                         f32 %760 = OpLoad %759 
					                                Private f32* %761 = OpAccessChain %9 %34 
					                                         f32 %762 = OpLoad %761 
					                                         f32 %763 = OpFMul %760 %762 
					                                Private f32* %764 = OpAccessChain %9 %34 
					                                                      OpStore %764 %763 
					                                Private f32* %765 = OpAccessChain %9 %34 
					                                         f32 %766 = OpLoad %765 
					                                         f32 %767 = OpExtInst %1 30 %766 
					                                                      OpStore %650 %767 
					                                Private f32* %769 = OpAccessChain %9 %34 
					                                         f32 %770 = OpLoad %769 
					                                        bool %771 = OpFOrdLessThan %224 %770 
					                                                      OpStore %768 %771 
					                               Private bool* %773 = OpAccessChain %618 %30 
					                                        bool %774 = OpLoad %773 
					                                                      OpSelectionMerge %777 None 
					                                                      OpBranchConditional %774 %776 %780 
					                                             %776 = OpLabel 
					                                Uniform f32* %778 = OpAccessChain %17 %675 %34 
					                                         f32 %779 = OpLoad %778 
					                                                      OpStore %775 %779 
					                                                      OpBranch %777 
					                                             %780 = OpLabel 
					                                Uniform f32* %781 = OpAccessChain %17 %680 %34 
					                                         f32 %782 = OpLoad %781 
					                                                      OpStore %775 %782 
					                                                      OpBranch %777 
					                                             %777 = OpLabel 
					                                         f32 %783 = OpLoad %775 
					                                Private f32* %784 = OpAccessChain %772 %34 
					                                                      OpStore %784 %783 
					                               Private bool* %785 = OpAccessChain %618 %30 
					                                        bool %786 = OpLoad %785 
					                                                      OpSelectionMerge %789 None 
					                                                      OpBranchConditional %786 %788 %792 
					                                             %788 = OpLabel 
					                                Uniform f32* %790 = OpAccessChain %17 %675 %30 
					                                         f32 %791 = OpLoad %790 
					                                                      OpStore %787 %791 
					                                                      OpBranch %789 
					                                             %792 = OpLabel 
					                                Uniform f32* %793 = OpAccessChain %17 %680 %30 
					                                         f32 %794 = OpLoad %793 
					                                                      OpStore %787 %794 
					                                                      OpBranch %789 
					                                             %789 = OpLabel 
					                                         f32 %795 = OpLoad %787 
					                                Private f32* %796 = OpAccessChain %772 %30 
					                                                      OpStore %796 %795 
					                               Private bool* %797 = OpAccessChain %618 %56 
					                                        bool %798 = OpLoad %797 
					                                                      OpSelectionMerge %801 None 
					                                                      OpBranchConditional %798 %800 %804 
					                                             %800 = OpLabel 
					                                Uniform f32* %802 = OpAccessChain %17 %675 %34 
					                                         f32 %803 = OpLoad %802 
					                                                      OpStore %799 %803 
					                                                      OpBranch %801 
					                                             %804 = OpLabel 
					                                Uniform f32* %805 = OpAccessChain %17 %680 %34 
					                                         f32 %806 = OpLoad %805 
					                                                      OpStore %799 %806 
					                                                      OpBranch %801 
					                                             %801 = OpLabel 
					                                         f32 %807 = OpLoad %799 
					                                Private f32* %808 = OpAccessChain %772 %131 
					                                                      OpStore %808 %807 
					                               Private bool* %809 = OpAccessChain %618 %56 
					                                        bool %810 = OpLoad %809 
					                                                      OpSelectionMerge %813 None 
					                                                      OpBranchConditional %810 %812 %816 
					                                             %812 = OpLabel 
					                                Uniform f32* %814 = OpAccessChain %17 %675 %30 
					                                         f32 %815 = OpLoad %814 
					                                                      OpStore %811 %815 
					                                                      OpBranch %813 
					                                             %816 = OpLabel 
					                                Uniform f32* %817 = OpAccessChain %17 %680 %30 
					                                         f32 %818 = OpLoad %817 
					                                                      OpStore %811 %818 
					                                                      OpBranch %813 
					                                             %813 = OpLabel 
					                                         f32 %819 = OpLoad %811 
					                                Private f32* %820 = OpAccessChain %772 %56 
					                                                      OpStore %820 %819 
					                                       f32_4 %822 = OpLoad %772 
					                                                      OpStore %821 %822 
					                               Private bool* %823 = OpAccessChain %618 %34 
					                                        bool %824 = OpLoad %823 
					                                                      OpSelectionMerge %827 None 
					                                                      OpBranchConditional %824 %826 %830 
					                                             %826 = OpLabel 
					                                Uniform f32* %828 = OpAccessChain %17 %692 %34 
					                                         f32 %829 = OpLoad %828 
					                                                      OpStore %825 %829 
					                                                      OpBranch %827 
					                                             %830 = OpLabel 
					                                Private f32* %831 = OpAccessChain %772 %34 
					                                         f32 %832 = OpLoad %831 
					                                                      OpStore %825 %832 
					                                                      OpBranch %827 
					                                             %827 = OpLabel 
					                                         f32 %833 = OpLoad %825 
					                               Function f32* %834 = OpAccessChain %821 %34 
					                                                      OpStore %834 %833 
					                               Private bool* %835 = OpAccessChain %618 %34 
					                                        bool %836 = OpLoad %835 
					                                                      OpSelectionMerge %839 None 
					                                                      OpBranchConditional %836 %838 %842 
					                                             %838 = OpLabel 
					                                Uniform f32* %840 = OpAccessChain %17 %692 %30 
					                                         f32 %841 = OpLoad %840 
					                                                      OpStore %837 %841 
					                                                      OpBranch %839 
					                                             %842 = OpLabel 
					                                Private f32* %843 = OpAccessChain %772 %30 
					                                         f32 %844 = OpLoad %843 
					                                                      OpStore %837 %844 
					                                                      OpBranch %839 
					                                             %839 = OpLabel 
					                                         f32 %845 = OpLoad %837 
					                               Function f32* %846 = OpAccessChain %821 %30 
					                                                      OpStore %846 %845 
					                               Private bool* %847 = OpAccessChain %618 %131 
					                                        bool %848 = OpLoad %847 
					                                                      OpSelectionMerge %851 None 
					                                                      OpBranchConditional %848 %850 %854 
					                                             %850 = OpLabel 
					                                Uniform f32* %852 = OpAccessChain %17 %692 %34 
					                                         f32 %853 = OpLoad %852 
					                                                      OpStore %849 %853 
					                                                      OpBranch %851 
					                                             %854 = OpLabel 
					                                Private f32* %855 = OpAccessChain %772 %131 
					                                         f32 %856 = OpLoad %855 
					                                                      OpStore %849 %856 
					                                                      OpBranch %851 
					                                             %851 = OpLabel 
					                                         f32 %857 = OpLoad %849 
					                               Function f32* %858 = OpAccessChain %821 %131 
					                                                      OpStore %858 %857 
					                               Private bool* %859 = OpAccessChain %618 %131 
					                                        bool %860 = OpLoad %859 
					                                                      OpSelectionMerge %863 None 
					                                                      OpBranchConditional %860 %862 %866 
					                                             %862 = OpLabel 
					                                Uniform f32* %864 = OpAccessChain %17 %692 %30 
					                                         f32 %865 = OpLoad %864 
					                                                      OpStore %861 %865 
					                                                      OpBranch %863 
					                                             %866 = OpLabel 
					                                Private f32* %867 = OpAccessChain %772 %56 
					                                         f32 %868 = OpLoad %867 
					                                                      OpStore %861 %868 
					                                                      OpBranch %863 
					                                             %863 = OpLabel 
					                                         f32 %869 = OpLoad %861 
					                               Function f32* %870 = OpAccessChain %821 %56 
					                                                      OpStore %870 %869 
					                                       f32_4 %871 = OpLoad %821 
					                                                      OpStore %772 %871 
					                                         f32 %872 = OpLoad %650 
					                                Private f32* %873 = OpAccessChain %772 %30 
					                                         f32 %874 = OpLoad %873 
					                                         f32 %875 = OpFMul %872 %874 
					                                                      OpStore %650 %875 
					                                         f32 %876 = OpLoad %650 
					                                         f32 %877 = OpFMul %876 %707 
					                                Private f32* %878 = OpAccessChain %772 %34 
					                                         f32 %879 = OpLoad %878 
					                                         f32 %880 = OpFAdd %877 %879 
					                                                      OpStore %650 %880 
					                                         f32 %881 = OpLoad %650 
					                                         f32 %882 = OpFMul %881 %713 
					                                                      OpStore %650 %882 
					                                         f32 %883 = OpLoad %650 
					                                         f32 %884 = OpExtInst %1 29 %883 
					                                                      OpStore %650 %884 
					                                        bool %885 = OpLoad %768 
					                                         f32 %886 = OpLoad %650 
					                                         f32 %887 = OpSelect %885 %886 %224 
					                                Private f32* %888 = OpAccessChain %9 %34 
					                                                      OpStore %888 %887 
					                                Private f32* %889 = OpAccessChain %9 %34 
					                                         f32 %890 = OpLoad %889 
					                                Private f32* %891 = OpAccessChain %317 %56 
					                                         f32 %892 = OpLoad %891 
					                                         f32 %893 = OpFMul %890 %892 
					                                Private f32* %894 = OpAccessChain %317 %30 
					                                         f32 %895 = OpLoad %894 
					                                         f32 %896 = OpFAdd %893 %895 
					                                Private f32* %897 = OpAccessChain %28 %34 
					                                                      OpStore %897 %896 
					                               Private bool* %898 = OpAccessChain %618 %56 
					                                        bool %899 = OpLoad %898 
					                                                      OpSelectionMerge %902 None 
					                                                      OpBranchConditional %899 %901 %905 
					                                             %901 = OpLabel 
					                              Uniform f32_4* %903 = OpAccessChain %17 %631 
					                                       f32_4 %904 = OpLoad %903 
					                                                      OpStore %900 %904 
					                                                      OpBranch %902 
					                                             %905 = OpLabel 
					                              Uniform f32_4* %906 = OpAccessChain %17 %635 
					                                       f32_4 %907 = OpLoad %906 
					                                                      OpStore %900 %907 
					                                                      OpBranch %902 
					                                             %902 = OpLabel 
					                                       f32_4 %908 = OpLoad %900 
					                                                      OpStore %317 %908 
					                               Private bool* %909 = OpAccessChain %618 %131 
					                                        bool %910 = OpLoad %909 
					                                                      OpSelectionMerge %913 None 
					                                                      OpBranchConditional %910 %912 %916 
					                                             %912 = OpLabel 
					                              Uniform f32_4* %914 = OpAccessChain %17 %644 
					                                       f32_4 %915 = OpLoad %914 
					                                                      OpStore %911 %915 
					                                                      OpBranch %913 
					                                             %916 = OpLabel 
					                                       f32_4 %917 = OpLoad %317 
					                                                      OpStore %911 %917 
					                                                      OpBranch %913 
					                                             %913 = OpLabel 
					                                       f32_4 %918 = OpLoad %911 
					                                                      OpStore %282 %918 
					                                Private f32* %919 = OpAccessChain %9 %30 
					                                         f32 %920 = OpLoad %919 
					                                Uniform f32* %921 = OpAccessChain %17 %599 %34 
					                                         f32 %922 = OpLoad %921 
					                                         f32 %923 = OpFMul %920 %922 
					                                Private f32* %924 = OpAccessChain %282 %34 
					                                         f32 %925 = OpLoad %924 
					                                         f32 %926 = OpFNegate %925 
					                                         f32 %927 = OpFAdd %923 %926 
					                                Private f32* %928 = OpAccessChain %9 %34 
					                                                      OpStore %928 %927 
					                                Private f32* %929 = OpAccessChain %282 %131 
					                                         f32 %930 = OpLoad %929 
					                                Private f32* %931 = OpAccessChain %9 %34 
					                                         f32 %932 = OpLoad %931 
					                                         f32 %933 = OpFMul %930 %932 
					                                Private f32* %934 = OpAccessChain %9 %34 
					                                                      OpStore %934 %933 
					                                Private f32* %935 = OpAccessChain %9 %34 
					                                         f32 %936 = OpLoad %935 
					                                         f32 %937 = OpExtInst %1 30 %936 
					                                Private f32* %938 = OpAccessChain %363 %34 
					                                                      OpStore %938 %937 
					                                Private f32* %939 = OpAccessChain %9 %34 
					                                         f32 %940 = OpLoad %939 
					                                        bool %941 = OpFOrdLessThan %224 %940 
					                                                      OpStore %768 %941 
					                                Private f32* %942 = OpAccessChain %363 %34 
					                                         f32 %943 = OpLoad %942 
					                                Private f32* %944 = OpAccessChain %772 %56 
					                                         f32 %945 = OpLoad %944 
					                                         f32 %946 = OpFMul %943 %945 
					                                Private f32* %947 = OpAccessChain %363 %34 
					                                                      OpStore %947 %946 
					                                Private f32* %948 = OpAccessChain %363 %34 
					                                         f32 %949 = OpLoad %948 
					                                         f32 %950 = OpFMul %949 %707 
					                                Private f32* %951 = OpAccessChain %772 %131 
					                                         f32 %952 = OpLoad %951 
					                                         f32 %953 = OpFAdd %950 %952 
					                                Private f32* %954 = OpAccessChain %363 %34 
					                                                      OpStore %954 %953 
					                                Private f32* %955 = OpAccessChain %363 %34 
					                                         f32 %956 = OpLoad %955 
					                                         f32 %957 = OpFMul %956 %713 
					                                Private f32* %958 = OpAccessChain %363 %34 
					                                                      OpStore %958 %957 
					                                Private f32* %959 = OpAccessChain %363 %34 
					                                         f32 %960 = OpLoad %959 
					                                         f32 %961 = OpExtInst %1 29 %960 
					                                Private f32* %962 = OpAccessChain %363 %34 
					                                                      OpStore %962 %961 
					                                        bool %963 = OpLoad %768 
					                                                      OpSelectionMerge %966 None 
					                                                      OpBranchConditional %963 %965 %969 
					                                             %965 = OpLabel 
					                                Private f32* %967 = OpAccessChain %363 %34 
					                                         f32 %968 = OpLoad %967 
					                                                      OpStore %964 %968 
					                                                      OpBranch %966 
					                                             %969 = OpLabel 
					                                                      OpStore %964 %224 
					                                                      OpBranch %966 
					                                             %966 = OpLabel 
					                                         f32 %970 = OpLoad %964 
					                                Private f32* %971 = OpAccessChain %9 %34 
					                                                      OpStore %971 %970 
					                                Private f32* %972 = OpAccessChain %9 %34 
					                                         f32 %973 = OpLoad %972 
					                                Private f32* %974 = OpAccessChain %282 %56 
					                                         f32 %975 = OpLoad %974 
					                                         f32 %976 = OpFMul %973 %975 
					                                Private f32* %977 = OpAccessChain %282 %30 
					                                         f32 %978 = OpLoad %977 
					                                         f32 %979 = OpFAdd %976 %978 
					                                Private f32* %980 = OpAccessChain %28 %30 
					                                                      OpStore %980 %979 
					                                       f32_4 %983 = OpLoad %28 
					                                       f32_3 %984 = OpVectorShuffle %983 %983 0 1 2 
					                                       f32_3 %985 = OpExtInst %1 40 %984 %263 
					                                       f32_4 %986 = OpLoad %982 
					                                       f32_4 %987 = OpVectorShuffle %986 %985 4 5 6 3 
					                                                      OpStore %982 %987 
					                                 Output f32* %989 = OpAccessChain %982 %56 
					                                                      OpStore %989 %225 
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
						vec4 _Lut2D_Params;
						vec4 unused_0_2;
						vec3 _ColorBalance;
						vec3 _ColorFilter;
						vec3 _HueSatCon;
						vec3 _ChannelMixerRed;
						vec3 _ChannelMixerGreen;
						vec3 _ChannelMixerBlue;
						vec3 _Lift;
						vec3 _InvGamma;
						vec3 _Gain;
						vec4 unused_0_12[7];
					};
					uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD0.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www + vec3(-0.413588405, -0.413588405, -0.413588405);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.0275523961, 0.0275523961, 0.0275523961);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(13.6054821, 13.6054821, 13.6054821);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0479959995, -0.0479959995, -0.0479959995);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.179999992, 0.179999992, 0.179999992);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7 = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat15.x + u_xlat4.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7 = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    SV_Target0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
				SubProgram "d3d11 " {
					Keywords { "TONEMAPPING_ACES" }
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
						vec4 _Lut2D_Params;
						vec4 unused_0_2;
						vec3 _ColorBalance;
						vec3 _ColorFilter;
						vec3 _HueSatCon;
						vec3 _ChannelMixerRed;
						vec3 _ChannelMixerGreen;
						vec3 _ChannelMixerBlue;
						vec3 _Lift;
						vec3 _InvGamma;
						vec3 _Gain;
						vec4 unused_0_12[7];
					};
					uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					bvec2 u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					vec3 u_xlat7;
					bool u_xlatb7;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD0.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www + vec3(-0.386036009, -0.386036009, -0.386036009);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(13.6054821, 13.6054821, 13.6054821);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0479959995, -0.0479959995, -0.0479959995);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.179999992, 0.179999992, 0.179999992);
					    u_xlat1.x = dot(vec3(0.439700991, 0.382977992, 0.177334994), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.0897922963, 0.813422978, 0.0967615992), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0175439995, 0.111543998, 0.870703995), u_xlat0.xyz);
					    u_xlat0.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = min(u_xlat0.xyz, vec3(65504.0, 65504.0, 65504.0));
					    u_xlat1.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(1.525878e-05, 1.525878e-05, 1.525878e-05);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz + vec3(9.72000027, 9.72000027, 9.72000027);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.0570776239, 0.0570776239, 0.0570776239);
					    u_xlat2.xyz = log2(u_xlat0.xyz);
					    u_xlatb0.xyz = lessThan(u_xlat0.xyzx, vec4(3.05175708e-05, 3.05175708e-05, 3.05175708e-05, 0.0)).xyz;
					    u_xlat2.xyz = u_xlat2.xyz + vec3(9.72000027, 9.72000027, 9.72000027);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.0570776239, 0.0570776239, 0.0570776239);
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat2.x;
					    u_xlat0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat2.y;
					    u_xlat0.z = (u_xlatb0.z) ? u_xlat1.z : u_xlat2.z;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.413588405, -0.413588405, -0.413588405);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.413588405, 0.413588405, 0.413588405);
					    u_xlatb1 = lessThan(u_xlat0.xxyy, vec4(-0.301369876, 1.46799636, -0.301369876, 1.46799636));
					    u_xlat0.xyw = u_xlat0.xyz * vec3(17.5200005, 17.5200005, 17.5200005) + vec3(-9.72000027, -9.72000027, -9.72000027);
					    u_xlatb2.xy = lessThan(u_xlat0.zzzz, vec4(-0.301369876, 1.46799636, 0.0, 0.0)).xy;
					    u_xlat0.xyz = exp2(u_xlat0.xyw);
					    u_xlat7.x = (u_xlatb1.y) ? u_xlat0.x : float(65504.0);
					    u_xlat7.z = (u_xlatb1.w) ? u_xlat0.y : float(65504.0);
					    u_xlat0.xyw = u_xlat0.xyz + vec3(-1.52587891e-05, -1.52587891e-05, -1.52587891e-05);
					    u_xlat12 = (u_xlatb2.y) ? u_xlat0.z : 65504.0;
					    u_xlat0.xyw = u_xlat0.xyw + u_xlat0.xyw;
					    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat7.x;
					    u_xlat1.y = (u_xlatb1.z) ? u_xlat0.y : u_xlat7.z;
					    u_xlat1.z = (u_xlatb2.x) ? u_xlat0.w : u_xlat12;
					    u_xlat0.x = dot(vec3(1.45143926, -0.236510754, -0.214928567), u_xlat1.xyz);
					    u_xlat0.y = dot(vec3(-0.0765537769, 1.17622972, -0.0996759236), u_xlat1.xyz);
					    u_xlat0.z = dot(vec3(0.00831614807, -0.00603244966, 0.997716308), u_xlat1.xyz);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7.x;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat4.x + -0.5;
					    u_xlat6.x = u_xlat6.x + u_xlat15.x;
					    u_xlatb12 = 1.0<u_xlat6.x;
					    u_xlat7.xy = u_xlat6.xx + vec2(1.0, -1.0);
					    u_xlat12 = (u_xlatb12) ? u_xlat7.y : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat7.x : u_xlat12;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7.x = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7.x;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    u_xlat7.x = dot(vec3(0.695452213, 0.140678704, 0.163869068), u_xlat0.xyz);
					    u_xlat7.y = dot(vec3(0.0447945632, 0.859671116, 0.0955343172), u_xlat0.xyz);
					    u_xlat7.z = dot(vec3(-0.00552588282, 0.00402521016, 1.00150073), u_xlat0.xyz);
					    u_xlat0.xyz = (-u_xlat7.yxz) + u_xlat7.zyx;
					    u_xlat0.xy = u_xlat0.xy * u_xlat7.zy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = u_xlat7.x * u_xlat0.z + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat6.x = u_xlat7.y + u_xlat7.z;
					    u_xlat6.x = u_xlat7.x + u_xlat6.x;
					    u_xlat0.x = u_xlat0.x * 1.75 + u_xlat6.x;
					    u_xlat6.x = u_xlat0.x * 0.333333343;
					    u_xlat6.x = 0.0799999982 / u_xlat6.x;
					    u_xlat12 = min(u_xlat7.y, u_xlat7.x);
					    u_xlat12 = min(u_xlat7.z, u_xlat12);
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat18 = max(u_xlat7.y, u_xlat7.x);
					    u_xlat18 = max(u_xlat7.z, u_xlat18);
					    u_xlat2.xy = max(vec2(u_xlat18), vec2(9.99999975e-05, 0.00999999978));
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat6.y = u_xlat12 / u_xlat2.y;
					    u_xlat6.xz = u_xlat6.xy + vec2(-0.5, -0.400000006);
					    u_xlat1.x = u_xlat6.z * 2.5;
					    u_xlat18 = u_xlat6.z * intBitsToFloat(int(0x7F800000u)) + 0.5;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat18 = u_xlat18 * 2.0 + -1.0;
					    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat18 = u_xlat18 * u_xlat1.x + 1.0;
					    u_xlat18 = u_xlat18 * 0.0250000004;
					    u_xlat6.x = u_xlat6.x * u_xlat18;
					    u_xlatb1.x = u_xlat0.x>=0.479999989;
					    u_xlatb0.x = 0.159999996>=u_xlat0.x;
					    u_xlat6.x = (u_xlatb1.x) ? 0.0 : u_xlat6.x;
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat18 : u_xlat6.x;
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat2.yzw = u_xlat0.xxx * u_xlat7.xyz;
					    u_xlat6.x = (-u_xlat7.x) * u_xlat0.x + 0.0299999993;
					    u_xlat18 = u_xlat7.y * u_xlat0.x + (-u_xlat2.w);
					    u_xlat18 = u_xlat18 * 1.73205078;
					    u_xlat1.x = u_xlat2.y * 2.0 + (-u_xlat2.z);
					    u_xlat0.x = (-u_xlat7.z) * u_xlat0.x + u_xlat1.x;
					    u_xlat1.x = max(abs(u_xlat0.x), abs(u_xlat18));
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat7.x = min(abs(u_xlat0.x), abs(u_xlat18));
					    u_xlat1.x = u_xlat1.x * u_xlat7.x;
					    u_xlat7.x = u_xlat1.x * u_xlat1.x;
					    u_xlat13 = u_xlat7.x * 0.0208350997 + -0.0851330012;
					    u_xlat13 = u_xlat7.x * u_xlat13 + 0.180141002;
					    u_xlat13 = u_xlat7.x * u_xlat13 + -0.330299497;
					    u_xlat7.x = u_xlat7.x * u_xlat13 + 0.999866009;
					    u_xlat13 = u_xlat7.x * u_xlat1.x;
					    u_xlat13 = u_xlat13 * -2.0 + 1.57079637;
					    u_xlatb19 = abs(u_xlat0.x)<abs(u_xlat18);
					    u_xlat13 = u_xlatb19 ? u_xlat13 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat7.x + u_xlat13;
					    u_xlatb7 = u_xlat0.x<(-u_xlat0.x);
					    u_xlat7.x = u_xlatb7 ? -3.14159274 : float(0.0);
					    u_xlat1.x = u_xlat7.x + u_xlat1.x;
					    u_xlat7.x = min(u_xlat0.x, u_xlat18);
					    u_xlat0.x = max(u_xlat0.x, u_xlat18);
					    u_xlatb0.x = u_xlat0.x>=(-u_xlat0.x);
					    u_xlatb18 = u_xlat7.x<(-u_xlat7.x);
					    u_xlatb0.x = u_xlatb0.x && u_xlatb18;
					    u_xlat0.x = (u_xlatb0.x) ? (-u_xlat1.x) : u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 57.2957802;
					    u_xlatb1.xy = equal(u_xlat2.zwzz, u_xlat2.yzyy).xy;
					    u_xlatb18 = u_xlatb1.y && u_xlatb1.x;
					    u_xlat0.x = (u_xlatb18) ? 0.0 : u_xlat0.x;
					    u_xlatb18 = u_xlat0.x<0.0;
					    u_xlat1.x = u_xlat0.x + 360.0;
					    u_xlat0.x = (u_xlatb18) ? u_xlat1.x : u_xlat0.x;
					    u_xlatb18 = 180.0<u_xlat0.x;
					    u_xlat1.xy = u_xlat0.xx + vec2(360.0, -360.0);
					    u_xlat18 = (u_xlatb18) ? u_xlat1.y : u_xlat0.x;
					    u_xlatb0.x = u_xlat0.x<-180.0;
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat18;
					    u_xlat0.x = u_xlat0.x * 0.0148148146;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat18 = u_xlat0.x * -2.0 + 3.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat18;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat6.y * u_xlat0.x;
					    u_xlat0.x = u_xlat6.x * u_xlat0.x;
					    u_xlat2.x = u_xlat0.x * 0.180000007 + u_xlat2.y;
					    u_xlat0.x = dot(vec3(1.45143926, -0.236510754, -0.214928567), u_xlat2.xzw);
					    u_xlat0.y = dot(vec3(-0.0765537769, 1.17622972, -0.0996759236), u_xlat2.xzw);
					    u_xlat0.z = dot(vec3(0.00831614807, -0.00603244966, 0.997716308), u_xlat2.xzw);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat18 = dot(u_xlat0.xyz, vec3(0.272228986, 0.674081981, 0.0536894985));
					    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(u_xlat18);
					    u_xlat1.xyz = u_xlat0.xyz * vec3(278.508514, 278.508514, 278.508514) + vec3(10.7771997, 10.7771997, 10.7771997);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(293.604492, 293.604492, 293.604492) + vec3(88.7121964, 88.7121964, 88.7121964);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(80.6889038, 80.6889038, 80.6889038);
					    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
					    u_xlat1.z = dot(vec3(-0.00557464967, 0.0040607336, 1.01033914), u_xlat0.xyz);
					    u_xlat1.x = dot(vec3(0.662454188, 0.134004205, 0.156187683), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.272228718, 0.674081743, 0.0536895171), u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
					    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
					    u_xlat0.xy = u_xlat1.xy / u_xlat0.xx;
					    u_xlat18 = max(u_xlat1.y, 0.0);
					    u_xlat18 = min(u_xlat18, 65504.0);
					    u_xlat18 = log2(u_xlat18);
					    u_xlat18 = u_xlat18 * 0.981100023;
					    u_xlat1.y = exp2(u_xlat18);
					    u_xlat18 = (-u_xlat0.x) + 1.0;
					    u_xlat0.z = (-u_xlat0.y) + u_xlat18;
					    u_xlat6.x = max(u_xlat0.y, 9.99999975e-05);
					    u_xlat6.x = u_xlat1.y / u_xlat6.x;
					    u_xlat1.xz = u_xlat6.xx * u_xlat0.xz;
					    u_xlat0.x = dot(vec3(1.6410234, -0.324803293, -0.236424699), u_xlat1.xyz);
					    u_xlat0.y = dot(vec3(-0.663662851, 1.61533165, 0.0167563483), u_xlat1.xyz);
					    u_xlat0.z = dot(vec3(0.0117218941, -0.00828444213, 0.988394856), u_xlat1.xyz);
					    u_xlat18 = dot(u_xlat0.xyz, vec3(0.272228986, 0.674081981, 0.0536894985));
					    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.930000007, 0.930000007, 0.930000007) + vec3(u_xlat18);
					    u_xlat1.x = dot(vec3(0.662454188, 0.134004205, 0.156187683), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.272228718, 0.674081743, 0.0536895171), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.00557464967, 0.0040607336, 1.01033914), u_xlat0.xyz);
					    u_xlat0.x = dot(vec3(0.987223983, -0.00611326983, 0.0159533005), u_xlat1.xyz);
					    u_xlat0.y = dot(vec3(-0.00759836007, 1.00186002, 0.00533019984), u_xlat1.xyz);
					    u_xlat0.z = dot(vec3(0.00307257008, -0.00509594986, 1.08168006), u_xlat1.xyz);
					    u_xlat1.x = dot(vec3(3.2409699, -1.5373832, -0.498610765), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.969243646, 1.8759675, 0.0415550582), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0556300804, -0.203976959, 1.05697155), u_xlat0.xyz);
					    SV_Target0.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "glcore " {
					Keywords { "TONEMAPPING_ACES" }
					"!!GL3x"
				}
				SubProgram "vulkan " {
					Keywords { "TONEMAPPING_ACES" }
					"spirv"
				}
				SubProgram "d3d11 " {
					Keywords { "TONEMAPPING_NEUTRAL" }
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
						vec4 _Lut2D_Params;
						vec4 unused_0_2;
						vec3 _ColorBalance;
						vec3 _ColorFilter;
						vec3 _HueSatCon;
						vec3 _ChannelMixerRed;
						vec3 _ChannelMixerGreen;
						vec3 _ChannelMixerBlue;
						vec3 _Lift;
						vec3 _InvGamma;
						vec3 _Gain;
						vec4 unused_0_12[7];
					};
					uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD0.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www + vec3(-0.413588405, -0.413588405, -0.413588405);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.0275523961, 0.0275523961, 0.0275523961);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(13.6054821, 13.6054821, 13.6054821);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0479959995, -0.0479959995, -0.0479959995);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.179999992, 0.179999992, 0.179999992);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7 = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat15.x + u_xlat4.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7 = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = u_xlat0.xyz * vec3(0.262677222, 0.262677222, 0.262677222) + vec3(0.0695999935, 0.0695999935, 0.0695999935);
					    u_xlat2.xyz = u_xlat0.xyz * vec3(1.31338608, 1.31338608, 1.31338608);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.262677222, 0.262677222, 0.262677222) + vec3(0.289999992, 0.289999992, 0.289999992);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + vec3(0.0816000104, 0.0816000104, 0.0816000104);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(0.00543999998, 0.00543999998, 0.00543999998);
					    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0666666627, -0.0666666627, -0.0666666627);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.31338608, 1.31338608, 1.31338608);
					    SV_Target0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "glcore " {
					Keywords { "TONEMAPPING_NEUTRAL" }
					"!!GL3x"
				}
				SubProgram "vulkan " {
					Keywords { "TONEMAPPING_NEUTRAL" }
					"spirv"
				}
				SubProgram "d3d11 " {
					Keywords { "TONEMAPPING_CUSTOM" }
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
						vec4 _Lut2D_Params;
						vec4 unused_0_2;
						vec3 _ColorBalance;
						vec3 _ColorFilter;
						vec3 _HueSatCon;
						vec3 _ChannelMixerRed;
						vec3 _ChannelMixerGreen;
						vec3 _ChannelMixerBlue;
						vec3 _Lift;
						vec3 _InvGamma;
						vec3 _Gain;
						vec4 _CustomToneCurve;
						vec4 _ToeSegmentA;
						vec4 _ToeSegmentB;
						vec4 _MidSegmentA;
						vec4 _MidSegmentB;
						vec4 _ShoSegmentA;
						vec4 _ShoSegmentB;
					};
					uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat12;
					bool u_xlatb12;
					bvec2 u_xlatb13;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD0.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www + vec3(-0.413588405, -0.413588405, -0.413588405);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.0275523961, 0.0275523961, 0.0275523961);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(13.6054821, 13.6054821, 13.6054821);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0479959995, -0.0479959995, -0.0479959995);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.179999992, 0.179999992, 0.179999992);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7 = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat15.x + u_xlat4.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7 = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = u_xlat0.xyz * _CustomToneCurve.xxx;
					    u_xlatb13.xy = lessThan(u_xlat1.zzzz, _CustomToneCurve.yzyz).xy;
					    u_xlatb2 = lessThan(u_xlat1.xxyy, _CustomToneCurve.yzyz);
					    u_xlat3 = (u_xlatb13.y) ? _MidSegmentA : _ShoSegmentA;
					    u_xlat3 = (u_xlatb13.x) ? _ToeSegmentA : u_xlat3;
					    u_xlat12 = u_xlat0.z * _CustomToneCurve.x + (-u_xlat3.x);
					    u_xlat12 = u_xlat3.z * u_xlat12;
					    u_xlat18 = log2(u_xlat12);
					    u_xlatb12 = 0.0<u_xlat12;
					    u_xlat1.xy = (u_xlatb13.y) ? _MidSegmentB.xy : _ShoSegmentB.xy;
					    u_xlat1.xy = (u_xlatb13.x) ? _ToeSegmentB.xy : u_xlat1.xy;
					    u_xlat18 = u_xlat18 * u_xlat1.y;
					    u_xlat18 = u_xlat18 * 0.693147182 + u_xlat1.x;
					    u_xlat18 = u_xlat18 * 1.44269502;
					    u_xlat18 = exp2(u_xlat18);
					    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
					    u_xlat1.z = u_xlat12 * u_xlat3.w + u_xlat3.y;
					    u_xlat3 = (u_xlatb2.y) ? _MidSegmentA : _ShoSegmentA;
					    u_xlat3 = (u_xlatb2.x) ? _ToeSegmentA : u_xlat3;
					    u_xlat0.x = u_xlat0.x * _CustomToneCurve.x + (-u_xlat3.x);
					    u_xlat0.x = u_xlat3.z * u_xlat0.x;
					    u_xlat12 = log2(u_xlat0.x);
					    u_xlatb0 = 0.0<u_xlat0.x;
					    u_xlat4.x = (u_xlatb2.y) ? _MidSegmentB.x : _ShoSegmentB.x;
					    u_xlat4.y = (u_xlatb2.y) ? _MidSegmentB.y : _ShoSegmentB.y;
					    u_xlat4.z = (u_xlatb2.w) ? _MidSegmentB.x : _ShoSegmentB.x;
					    u_xlat4.w = (u_xlatb2.w) ? _MidSegmentB.y : _ShoSegmentB.y;
					    {
					        vec4 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb2.x) ? _ToeSegmentB.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb2.x) ? _ToeSegmentB.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb2.z) ? _ToeSegmentB.x : u_xlat4.z;
					        hlslcc_movcTemp.w = (u_xlatb2.z) ? _ToeSegmentB.y : u_xlat4.w;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat12 = u_xlat12 * u_xlat4.y;
					    u_xlat12 = u_xlat12 * 0.693147182 + u_xlat4.x;
					    u_xlat12 = u_xlat12 * 1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat0.x = u_xlatb0 ? u_xlat12 : float(0.0);
					    u_xlat1.x = u_xlat0.x * u_xlat3.w + u_xlat3.y;
					    u_xlat3 = (u_xlatb2.w) ? _MidSegmentA : _ShoSegmentA;
					    u_xlat2 = (u_xlatb2.z) ? _ToeSegmentA : u_xlat3;
					    u_xlat0.x = u_xlat0.y * _CustomToneCurve.x + (-u_xlat2.x);
					    u_xlat0.x = u_xlat2.z * u_xlat0.x;
					    u_xlat6.x = log2(u_xlat0.x);
					    u_xlatb0 = 0.0<u_xlat0.x;
					    u_xlat6.x = u_xlat6.x * u_xlat4.w;
					    u_xlat6.x = u_xlat6.x * 0.693147182 + u_xlat4.z;
					    u_xlat6.x = u_xlat6.x * 1.44269502;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat0.x = u_xlatb0 ? u_xlat6.x : float(0.0);
					    u_xlat1.y = u_xlat0.x * u_xlat2.w + u_xlat2.y;
					    SV_Target0.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "glcore " {
					Keywords { "TONEMAPPING_CUSTOM" }
					"!!GL3x"
				}
				SubProgram "vulkan " {
					Keywords { "TONEMAPPING_CUSTOM" }
					"spirv"
				}
			}
		}
	}
}