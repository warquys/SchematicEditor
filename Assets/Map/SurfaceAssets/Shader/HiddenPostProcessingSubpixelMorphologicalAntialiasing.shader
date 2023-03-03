Shader "Hidden/PostProcessing/SubpixelMorphologicalAntialiasing" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 63205
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 0.0, -1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD2 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, 0.0, 1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD3 = _MainTex_TexelSize.xyxy * vec4(-2.0, 0.0, 0.0, -2.0) + u_xlat0.xyxy;
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
					uniform 	vec4 _MainTex_TexelSize;
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 0.0, -1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD2 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, 0.0, 1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD3 = _MainTex_TexelSize.xyxy * vec4(-2.0, 0.0, 0.0, -2.0) + u_xlat0.xyxy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 150
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_shader_bit_encoding
					#extension GL_ARB_shader_bit_encoding : enable
					#endif
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec2 u_xlat6;
					float u_xlat12;
					vec2 u_xlat14;
					bvec2 u_xlatb14;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat18 = max(abs(u_xlat2.y), abs(u_xlat2.x));
					    u_xlat2.x = max(abs(u_xlat2.z), u_xlat18);
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.zw);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat2.y = max(abs(u_xlat4.z), u_xlat18);
					    u_xlatb14.xy = greaterThanEqual(u_xlat2.xyxy, vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006)).xy;
					    u_xlat14.x = u_xlatb14.x ? float(1.0) : 0.0;
					    u_xlat14.y = u_xlatb14.y ? float(1.0) : 0.0;
					;
					    u_xlat18 = dot(u_xlat14.xy, vec2(1.0, 1.0));
					    u_xlatb18 = u_xlat18==0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat4.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat4.x = max(abs(u_xlat4.z), u_xlat18);
					    u_xlat5 = texture(_MainTex, vs_TEXCOORD2.zw);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
					    u_xlat0.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.y = max(abs(u_xlat0.z), u_xlat0.x);
					    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.xy);
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat1.y), abs(u_xlat1.x));
					    u_xlat1.x = max(abs(u_xlat1.z), u_xlat12);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.zw);
					    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat3.y), abs(u_xlat3.x));
					    u_xlat1.y = max(abs(u_xlat3.z), u_xlat12);
					    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
					    u_xlatb0.xy = greaterThanEqual(u_xlat6.xyxx, u_xlat0.xxxx).xy;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
					    SV_Target0.xy = u_xlat0.xy;
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
					; Bound: 86
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %45 %47 %61 %70 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD0 Location 45 
					                                             OpDecorate vs_TEXCOORD1 Location 47 
					                                             OpMemberDecorate %48 0 Offset 48 
					                                             OpDecorate %48 Block 
					                                             OpDecorate %50 DescriptorSet 50 
					                                             OpDecorate %50 Binding 50 
					                                             OpDecorate vs_TEXCOORD2 Location 61 
					                                             OpDecorate vs_TEXCOORD3 Location 70 
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
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					              Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                     %48 = OpTypeStruct %7 
					                                     %49 = OpTypePointer Uniform %48 
					            Uniform struct {f32_4;}* %50 = OpVariable Uniform 
					                                     %51 = OpTypePointer Uniform %7 
					                                 f32 %55 = OpConstant 3,674022E-40 
					                               f32_4 %56 = OpConstantComposite %55 %26 %26 %55 
					              Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                               f32_4 %65 = OpConstantComposite %27 %26 %26 %27 
					              Output f32_4* vs_TEXCOORD3 = OpVariable Output 
					                                 f32 %74 = OpConstant 3,674022E-40 
					                               f32_4 %75 = OpConstantComposite %74 %26 %26 %74 
					                                     %80 = OpTypePointer Output %6 
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
					                                             OpStore vs_TEXCOORD0 %46 
					                      Uniform f32_4* %52 = OpAccessChain %50 %15 
					                               f32_4 %53 = OpLoad %52 
					                               f32_4 %54 = OpVectorShuffle %53 %53 0 1 0 1 
					                               f32_4 %57 = OpFMul %54 %56 
					                               f32_2 %58 = OpLoad %33 
					                               f32_4 %59 = OpVectorShuffle %58 %58 0 1 0 1 
					                               f32_4 %60 = OpFAdd %57 %59 
					                                             OpStore vs_TEXCOORD1 %60 
					                      Uniform f32_4* %62 = OpAccessChain %50 %15 
					                               f32_4 %63 = OpLoad %62 
					                               f32_4 %64 = OpVectorShuffle %63 %63 0 1 0 1 
					                               f32_4 %66 = OpFMul %64 %65 
					                               f32_2 %67 = OpLoad %33 
					                               f32_4 %68 = OpVectorShuffle %67 %67 0 1 0 1 
					                               f32_4 %69 = OpFAdd %66 %68 
					                                             OpStore vs_TEXCOORD2 %69 
					                      Uniform f32_4* %71 = OpAccessChain %50 %15 
					                               f32_4 %72 = OpLoad %71 
					                               f32_4 %73 = OpVectorShuffle %72 %72 0 1 0 1 
					                               f32_4 %76 = OpFMul %73 %75 
					                               f32_2 %77 = OpLoad %33 
					                               f32_4 %78 = OpVectorShuffle %77 %77 0 1 0 1 
					                               f32_4 %79 = OpFAdd %76 %78 
					                                             OpStore vs_TEXCOORD3 %79 
					                         Output f32* %81 = OpAccessChain %13 %15 %9 
					                                 f32 %82 = OpLoad %81 
					                                 f32 %83 = OpFNegate %82 
					                         Output f32* %84 = OpAccessChain %13 %15 %9 
					                                             OpStore %84 %83 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 287
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %32 %131 %190 %278 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate vs_TEXCOORD1 Location 32 
					                                             OpDecorate vs_TEXCOORD2 Location 131 
					                                             OpDecorate vs_TEXCOORD3 Location 190 
					                                             OpDecorate %278 Location 278 
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
					                                     %24 = OpTypeVector %6 4 
					                      Private f32_3* %27 = OpVariable Private 
					                                     %31 = OpTypePointer Input %24 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_3* %37 = OpVariable Private 
					                                     %42 = OpTypePointer Private %6 
					                        Private f32* %43 = OpVariable Private 
					                                     %44 = OpTypeInt 32 0 
					                                 u32 %45 = OpConstant 1 
					                                 u32 %49 = OpConstant 0 
					                                 u32 %54 = OpConstant 2 
					                      Private f32_3* %61 = OpVariable Private 
					                      Private f32_3* %69 = OpVariable Private 
					                                     %87 = OpTypeBool 
					                                     %88 = OpTypeVector %87 2 
					                                     %89 = OpTypePointer Private %88 
					                     Private bool_2* %90 = OpVariable Private 
					                                 f32 %93 = OpConstant 3,674022E-40 
					                               f32_4 %94 = OpConstantComposite %93 %93 %93 %93 
					                                     %95 = OpTypeVector %87 4 
					                                     %98 = OpTypePointer Private %20 
					                      Private f32_2* %99 = OpVariable Private 
					                                    %100 = OpTypePointer Private %87 
					                                f32 %103 = OpConstant 3,674022E-40 
					                                f32 %104 = OpConstant 3,674022E-40 
					                              f32_2 %112 = OpConstantComposite %103 %103 
					                      Private bool* %114 = OpVariable Private 
					                                    %118 = OpTypeInt 32 1 
					                                i32 %119 = OpConstant 0 
					                                i32 %120 = OpConstant 1 
					                                i32 %122 = OpConstant -1 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                     Private f32_3* %153 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD3 = OpVariable Input 
					                       Private f32* %199 = OpVariable Private 
					                     Private f32_2* %250 = OpVariable Private 
					                    Private bool_2* %256 = OpVariable Private 
					                                    %277 = OpTypePointer Output %24 
					                      Output f32_4* %278 = OpVariable Output 
					                              f32_2 %283 = OpConstantComposite %104 %104 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
					                                             OpStore %9 %26 
					                 read_only Texture2D %28 = OpLoad %12 
					                             sampler %29 = OpLoad %16 
					          read_only Texture2DSampled %30 = OpSampledImage %28 %29 
					                               f32_4 %33 = OpLoad vs_TEXCOORD1 
					                               f32_2 %34 = OpVectorShuffle %33 %33 0 1 
					                               f32_4 %35 = OpImageSampleImplicitLod %30 %34 
					                               f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
					                                             OpStore %27 %36 
					                               f32_3 %38 = OpLoad %9 
					                               f32_3 %39 = OpLoad %27 
					                               f32_3 %40 = OpFNegate %39 
					                               f32_3 %41 = OpFAdd %38 %40 
					                                             OpStore %37 %41 
					                        Private f32* %46 = OpAccessChain %37 %45 
					                                 f32 %47 = OpLoad %46 
					                                 f32 %48 = OpExtInst %1 4 %47 
					                        Private f32* %50 = OpAccessChain %37 %49 
					                                 f32 %51 = OpLoad %50 
					                                 f32 %52 = OpExtInst %1 4 %51 
					                                 f32 %53 = OpExtInst %1 40 %48 %52 
					                                             OpStore %43 %53 
					                        Private f32* %55 = OpAccessChain %37 %54 
					                                 f32 %56 = OpLoad %55 
					                                 f32 %57 = OpExtInst %1 4 %56 
					                                 f32 %58 = OpLoad %43 
					                                 f32 %59 = OpExtInst %1 40 %57 %58 
					                        Private f32* %60 = OpAccessChain %37 %49 
					                                             OpStore %60 %59 
					                 read_only Texture2D %62 = OpLoad %12 
					                             sampler %63 = OpLoad %16 
					          read_only Texture2DSampled %64 = OpSampledImage %62 %63 
					                               f32_4 %65 = OpLoad vs_TEXCOORD1 
					                               f32_2 %66 = OpVectorShuffle %65 %65 2 3 
					                               f32_4 %67 = OpImageSampleImplicitLod %64 %66 
					                               f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                             OpStore %61 %68 
					                               f32_3 %70 = OpLoad %9 
					                               f32_3 %71 = OpLoad %61 
					                               f32_3 %72 = OpFNegate %71 
					                               f32_3 %73 = OpFAdd %70 %72 
					                                             OpStore %69 %73 
					                        Private f32* %74 = OpAccessChain %69 %45 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpExtInst %1 4 %75 
					                        Private f32* %77 = OpAccessChain %69 %49 
					                                 f32 %78 = OpLoad %77 
					                                 f32 %79 = OpExtInst %1 4 %78 
					                                 f32 %80 = OpExtInst %1 40 %76 %79 
					                                             OpStore %43 %80 
					                        Private f32* %81 = OpAccessChain %69 %54 
					                                 f32 %82 = OpLoad %81 
					                                 f32 %83 = OpExtInst %1 4 %82 
					                                 f32 %84 = OpLoad %43 
					                                 f32 %85 = OpExtInst %1 40 %83 %84 
					                        Private f32* %86 = OpAccessChain %37 %45 
					                                             OpStore %86 %85 
					                               f32_3 %91 = OpLoad %37 
					                               f32_4 %92 = OpVectorShuffle %91 %91 0 1 0 1 
					                              bool_4 %96 = OpFOrdGreaterThanEqual %92 %94 
					                              bool_2 %97 = OpVectorShuffle %96 %96 0 1 
					                                             OpStore %90 %97 
					                      Private bool* %101 = OpAccessChain %90 %49 
					                               bool %102 = OpLoad %101 
					                                f32 %105 = OpSelect %102 %103 %104 
					                       Private f32* %106 = OpAccessChain %99 %49 
					                                             OpStore %106 %105 
					                      Private bool* %107 = OpAccessChain %90 %45 
					                               bool %108 = OpLoad %107 
					                                f32 %109 = OpSelect %108 %103 %104 
					                       Private f32* %110 = OpAccessChain %99 %45 
					                                             OpStore %110 %109 
					                              f32_2 %111 = OpLoad %99 
					                                f32 %113 = OpDot %111 %112 
					                                             OpStore %43 %113 
					                                f32 %115 = OpLoad %43 
					                               bool %116 = OpFOrdEqual %115 %104 
					                                             OpStore %114 %116 
					                               bool %117 = OpLoad %114 
					                                i32 %121 = OpSelect %117 %120 %119 
					                                i32 %123 = OpIMul %121 %122 
					                               bool %124 = OpINotEqual %123 %119 
					                                             OpSelectionMerge %126 None 
					                                             OpBranchConditional %124 %125 %126 
					                                    %125 = OpLabel 
					                                             OpKill
					                                    %126 = OpLabel 
					                read_only Texture2D %128 = OpLoad %12 
					                            sampler %129 = OpLoad %16 
					         read_only Texture2DSampled %130 = OpSampledImage %128 %129 
					                              f32_4 %132 = OpLoad vs_TEXCOORD2 
					                              f32_2 %133 = OpVectorShuffle %132 %132 0 1 
					                              f32_4 %134 = OpImageSampleImplicitLod %130 %133 
					                              f32_3 %135 = OpVectorShuffle %134 %134 0 1 2 
					                                             OpStore %69 %135 
					                              f32_3 %136 = OpLoad %9 
					                              f32_3 %137 = OpLoad %69 
					                              f32_3 %138 = OpFNegate %137 
					                              f32_3 %139 = OpFAdd %136 %138 
					                                             OpStore %69 %139 
					                       Private f32* %140 = OpAccessChain %69 %45 
					                                f32 %141 = OpLoad %140 
					                                f32 %142 = OpExtInst %1 4 %141 
					                       Private f32* %143 = OpAccessChain %69 %49 
					                                f32 %144 = OpLoad %143 
					                                f32 %145 = OpExtInst %1 4 %144 
					                                f32 %146 = OpExtInst %1 40 %142 %145 
					                                             OpStore %43 %146 
					                       Private f32* %147 = OpAccessChain %69 %54 
					                                f32 %148 = OpLoad %147 
					                                f32 %149 = OpExtInst %1 4 %148 
					                                f32 %150 = OpLoad %43 
					                                f32 %151 = OpExtInst %1 40 %149 %150 
					                       Private f32* %152 = OpAccessChain %69 %49 
					                                             OpStore %152 %151 
					                read_only Texture2D %154 = OpLoad %12 
					                            sampler %155 = OpLoad %16 
					         read_only Texture2DSampled %156 = OpSampledImage %154 %155 
					                              f32_4 %157 = OpLoad vs_TEXCOORD2 
					                              f32_2 %158 = OpVectorShuffle %157 %157 2 3 
					                              f32_4 %159 = OpImageSampleImplicitLod %156 %158 
					                              f32_3 %160 = OpVectorShuffle %159 %159 0 1 2 
					                                             OpStore %153 %160 
					                              f32_3 %161 = OpLoad %9 
					                              f32_3 %162 = OpLoad %153 
					                              f32_3 %163 = OpFNegate %162 
					                              f32_3 %164 = OpFAdd %161 %163 
					                                             OpStore %9 %164 
					                       Private f32* %165 = OpAccessChain %9 %45 
					                                f32 %166 = OpLoad %165 
					                                f32 %167 = OpExtInst %1 4 %166 
					                       Private f32* %168 = OpAccessChain %9 %49 
					                                f32 %169 = OpLoad %168 
					                                f32 %170 = OpExtInst %1 4 %169 
					                                f32 %171 = OpExtInst %1 40 %167 %170 
					                       Private f32* %172 = OpAccessChain %9 %49 
					                                             OpStore %172 %171 
					                       Private f32* %173 = OpAccessChain %9 %54 
					                                f32 %174 = OpLoad %173 
					                                f32 %175 = OpExtInst %1 4 %174 
					                       Private f32* %176 = OpAccessChain %9 %49 
					                                f32 %177 = OpLoad %176 
					                                f32 %178 = OpExtInst %1 40 %175 %177 
					                       Private f32* %179 = OpAccessChain %69 %45 
					                                             OpStore %179 %178 
					                              f32_3 %180 = OpLoad %37 
					                              f32_2 %181 = OpVectorShuffle %180 %180 0 1 
					                              f32_3 %182 = OpLoad %69 
					                              f32_2 %183 = OpVectorShuffle %182 %182 0 1 
					                              f32_2 %184 = OpExtInst %1 40 %181 %183 
					                              f32_3 %185 = OpLoad %9 
					                              f32_3 %186 = OpVectorShuffle %185 %184 3 4 2 
					                                             OpStore %9 %186 
					                read_only Texture2D %187 = OpLoad %12 
					                            sampler %188 = OpLoad %16 
					         read_only Texture2DSampled %189 = OpSampledImage %187 %188 
					                              f32_4 %191 = OpLoad vs_TEXCOORD3 
					                              f32_2 %192 = OpVectorShuffle %191 %191 0 1 
					                              f32_4 %193 = OpImageSampleImplicitLod %189 %192 
					                              f32_3 %194 = OpVectorShuffle %193 %193 0 1 2 
					                                             OpStore %69 %194 
					                              f32_3 %195 = OpLoad %27 
					                              f32_3 %196 = OpLoad %69 
					                              f32_3 %197 = OpFNegate %196 
					                              f32_3 %198 = OpFAdd %195 %197 
					                                             OpStore %27 %198 
					                       Private f32* %200 = OpAccessChain %27 %45 
					                                f32 %201 = OpLoad %200 
					                                f32 %202 = OpExtInst %1 4 %201 
					                       Private f32* %203 = OpAccessChain %27 %49 
					                                f32 %204 = OpLoad %203 
					                                f32 %205 = OpExtInst %1 4 %204 
					                                f32 %206 = OpExtInst %1 40 %202 %205 
					                                             OpStore %199 %206 
					                       Private f32* %207 = OpAccessChain %27 %54 
					                                f32 %208 = OpLoad %207 
					                                f32 %209 = OpExtInst %1 4 %208 
					                                f32 %210 = OpLoad %199 
					                                f32 %211 = OpExtInst %1 40 %209 %210 
					                       Private f32* %212 = OpAccessChain %27 %49 
					                                             OpStore %212 %211 
					                read_only Texture2D %213 = OpLoad %12 
					                            sampler %214 = OpLoad %16 
					         read_only Texture2DSampled %215 = OpSampledImage %213 %214 
					                              f32_4 %216 = OpLoad vs_TEXCOORD3 
					                              f32_2 %217 = OpVectorShuffle %216 %216 2 3 
					                              f32_4 %218 = OpImageSampleImplicitLod %215 %217 
					                              f32_3 %219 = OpVectorShuffle %218 %218 0 1 2 
					                                             OpStore %69 %219 
					                              f32_3 %220 = OpLoad %61 
					                              f32_3 %221 = OpLoad %69 
					                              f32_3 %222 = OpFNegate %221 
					                              f32_3 %223 = OpFAdd %220 %222 
					                                             OpStore %61 %223 
					                       Private f32* %224 = OpAccessChain %61 %45 
					                                f32 %225 = OpLoad %224 
					                                f32 %226 = OpExtInst %1 4 %225 
					                       Private f32* %227 = OpAccessChain %61 %49 
					                                f32 %228 = OpLoad %227 
					                                f32 %229 = OpExtInst %1 4 %228 
					                                f32 %230 = OpExtInst %1 40 %226 %229 
					                                             OpStore %199 %230 
					                       Private f32* %231 = OpAccessChain %61 %54 
					                                f32 %232 = OpLoad %231 
					                                f32 %233 = OpExtInst %1 4 %232 
					                                f32 %234 = OpLoad %199 
					                                f32 %235 = OpExtInst %1 40 %233 %234 
					                       Private f32* %236 = OpAccessChain %27 %45 
					                                             OpStore %236 %235 
					                              f32_3 %237 = OpLoad %9 
					                              f32_2 %238 = OpVectorShuffle %237 %237 0 1 
					                              f32_3 %239 = OpLoad %27 
					                              f32_2 %240 = OpVectorShuffle %239 %239 0 1 
					                              f32_2 %241 = OpExtInst %1 40 %238 %240 
					                              f32_3 %242 = OpLoad %9 
					                              f32_3 %243 = OpVectorShuffle %242 %241 3 4 2 
					                                             OpStore %9 %243 
					                       Private f32* %244 = OpAccessChain %9 %45 
					                                f32 %245 = OpLoad %244 
					                       Private f32* %246 = OpAccessChain %9 %49 
					                                f32 %247 = OpLoad %246 
					                                f32 %248 = OpExtInst %1 40 %245 %247 
					                       Private f32* %249 = OpAccessChain %9 %49 
					                                             OpStore %249 %248 
					                              f32_3 %251 = OpLoad %37 
					                              f32_2 %252 = OpVectorShuffle %251 %251 0 1 
					                              f32_3 %253 = OpLoad %37 
					                              f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                              f32_2 %255 = OpFAdd %252 %254 
					                                             OpStore %250 %255 
					                              f32_2 %257 = OpLoad %250 
					                              f32_4 %258 = OpVectorShuffle %257 %257 0 1 0 0 
					                              f32_3 %259 = OpLoad %9 
					                              f32_4 %260 = OpVectorShuffle %259 %259 0 0 0 0 
					                             bool_4 %261 = OpFOrdGreaterThanEqual %258 %260 
					                             bool_2 %262 = OpVectorShuffle %261 %261 0 1 
					                                             OpStore %256 %262 
					                      Private bool* %263 = OpAccessChain %256 %49 
					                               bool %264 = OpLoad %263 
					                                f32 %265 = OpSelect %264 %103 %104 
					                       Private f32* %266 = OpAccessChain %9 %49 
					                                             OpStore %266 %265 
					                      Private bool* %267 = OpAccessChain %256 %45 
					                               bool %268 = OpLoad %267 
					                                f32 %269 = OpSelect %268 %103 %104 
					                       Private f32* %270 = OpAccessChain %9 %45 
					                                             OpStore %270 %269 
					                              f32_3 %271 = OpLoad %9 
					                              f32_2 %272 = OpVectorShuffle %271 %271 0 1 
					                              f32_2 %273 = OpLoad %99 
					                              f32_2 %274 = OpFMul %272 %273 
					                              f32_3 %275 = OpLoad %9 
					                              f32_3 %276 = OpVectorShuffle %275 %274 3 4 2 
					                                             OpStore %9 %276 
					                              f32_3 %279 = OpLoad %9 
					                              f32_2 %280 = OpVectorShuffle %279 %279 0 1 
					                              f32_4 %281 = OpLoad %278 
					                              f32_4 %282 = OpVectorShuffle %281 %280 4 5 2 3 
					                                             OpStore %278 %282 
					                              f32_4 %284 = OpLoad %278 
					                              f32_4 %285 = OpVectorShuffle %284 %283 0 1 4 5 
					                                             OpStore %278 %285 
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
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec2 u_xlat6;
					float u_xlat12;
					vec2 u_xlat14;
					bvec2 u_xlatb14;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat18 = max(abs(u_xlat2.y), abs(u_xlat2.x));
					    u_xlat2.x = max(abs(u_xlat2.z), u_xlat18);
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.zw);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat2.y = max(abs(u_xlat4.z), u_xlat18);
					    u_xlatb14.xy = greaterThanEqual(u_xlat2.xyxy, vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006)).xy;
					    u_xlat14.x = u_xlatb14.x ? float(1.0) : 0.0;
					    u_xlat14.y = u_xlatb14.y ? float(1.0) : 0.0;
					;
					    u_xlat18 = dot(u_xlat14.xy, vec2(1.0, 1.0));
					    u_xlatb18 = u_xlat18==0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat4.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat4.x = max(abs(u_xlat4.z), u_xlat18);
					    u_xlat5 = texture(_MainTex, vs_TEXCOORD2.zw);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
					    u_xlat0.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.y = max(abs(u_xlat0.z), u_xlat0.x);
					    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.xy);
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat1.y), abs(u_xlat1.x));
					    u_xlat1.x = max(abs(u_xlat1.z), u_xlat12);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.zw);
					    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat3.y), abs(u_xlat3.x));
					    u_xlat1.y = max(abs(u_xlat3.z), u_xlat12);
					    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
					    u_xlatb0.xy = greaterThanEqual(u_xlat6.xyxx, u_xlat0.xxxx).xy;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
					    SV_Target0.xy = u_xlat0.xy;
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
			GpuProgramID 73397
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 0.0, -1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD2 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, 0.0, 1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD3 = _MainTex_TexelSize.xyxy * vec4(-2.0, 0.0, 0.0, -2.0) + u_xlat0.xyxy;
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
					uniform 	vec4 _MainTex_TexelSize;
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 0.0, -1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD2 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, 0.0, 1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD3 = _MainTex_TexelSize.xyxy * vec4(-2.0, 0.0, 0.0, -2.0) + u_xlat0.xyxy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 150
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_shader_bit_encoding
					#extension GL_ARB_shader_bit_encoding : enable
					#endif
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec2 u_xlat6;
					float u_xlat12;
					vec2 u_xlat14;
					bvec2 u_xlatb14;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat18 = max(abs(u_xlat2.y), abs(u_xlat2.x));
					    u_xlat2.x = max(abs(u_xlat2.z), u_xlat18);
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.zw);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat2.y = max(abs(u_xlat4.z), u_xlat18);
					    u_xlatb14.xy = greaterThanEqual(u_xlat2.xyxy, vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001)).xy;
					    u_xlat14.x = u_xlatb14.x ? float(1.0) : 0.0;
					    u_xlat14.y = u_xlatb14.y ? float(1.0) : 0.0;
					;
					    u_xlat18 = dot(u_xlat14.xy, vec2(1.0, 1.0));
					    u_xlatb18 = u_xlat18==0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat4.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat4.x = max(abs(u_xlat4.z), u_xlat18);
					    u_xlat5 = texture(_MainTex, vs_TEXCOORD2.zw);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
					    u_xlat0.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.y = max(abs(u_xlat0.z), u_xlat0.x);
					    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.xy);
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat1.y), abs(u_xlat1.x));
					    u_xlat1.x = max(abs(u_xlat1.z), u_xlat12);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.zw);
					    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat3.y), abs(u_xlat3.x));
					    u_xlat1.y = max(abs(u_xlat3.z), u_xlat12);
					    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
					    u_xlatb0.xy = greaterThanEqual(u_xlat6.xyxx, u_xlat0.xxxx).xy;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
					    SV_Target0.xy = u_xlat0.xy;
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
					; Bound: 86
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %45 %47 %61 %70 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD0 Location 45 
					                                             OpDecorate vs_TEXCOORD1 Location 47 
					                                             OpMemberDecorate %48 0 Offset 48 
					                                             OpDecorate %48 Block 
					                                             OpDecorate %50 DescriptorSet 50 
					                                             OpDecorate %50 Binding 50 
					                                             OpDecorate vs_TEXCOORD2 Location 61 
					                                             OpDecorate vs_TEXCOORD3 Location 70 
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
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					              Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                     %48 = OpTypeStruct %7 
					                                     %49 = OpTypePointer Uniform %48 
					            Uniform struct {f32_4;}* %50 = OpVariable Uniform 
					                                     %51 = OpTypePointer Uniform %7 
					                                 f32 %55 = OpConstant 3,674022E-40 
					                               f32_4 %56 = OpConstantComposite %55 %26 %26 %55 
					              Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                               f32_4 %65 = OpConstantComposite %27 %26 %26 %27 
					              Output f32_4* vs_TEXCOORD3 = OpVariable Output 
					                                 f32 %74 = OpConstant 3,674022E-40 
					                               f32_4 %75 = OpConstantComposite %74 %26 %26 %74 
					                                     %80 = OpTypePointer Output %6 
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
					                                             OpStore vs_TEXCOORD0 %46 
					                      Uniform f32_4* %52 = OpAccessChain %50 %15 
					                               f32_4 %53 = OpLoad %52 
					                               f32_4 %54 = OpVectorShuffle %53 %53 0 1 0 1 
					                               f32_4 %57 = OpFMul %54 %56 
					                               f32_2 %58 = OpLoad %33 
					                               f32_4 %59 = OpVectorShuffle %58 %58 0 1 0 1 
					                               f32_4 %60 = OpFAdd %57 %59 
					                                             OpStore vs_TEXCOORD1 %60 
					                      Uniform f32_4* %62 = OpAccessChain %50 %15 
					                               f32_4 %63 = OpLoad %62 
					                               f32_4 %64 = OpVectorShuffle %63 %63 0 1 0 1 
					                               f32_4 %66 = OpFMul %64 %65 
					                               f32_2 %67 = OpLoad %33 
					                               f32_4 %68 = OpVectorShuffle %67 %67 0 1 0 1 
					                               f32_4 %69 = OpFAdd %66 %68 
					                                             OpStore vs_TEXCOORD2 %69 
					                      Uniform f32_4* %71 = OpAccessChain %50 %15 
					                               f32_4 %72 = OpLoad %71 
					                               f32_4 %73 = OpVectorShuffle %72 %72 0 1 0 1 
					                               f32_4 %76 = OpFMul %73 %75 
					                               f32_2 %77 = OpLoad %33 
					                               f32_4 %78 = OpVectorShuffle %77 %77 0 1 0 1 
					                               f32_4 %79 = OpFAdd %76 %78 
					                                             OpStore vs_TEXCOORD3 %79 
					                         Output f32* %81 = OpAccessChain %13 %15 %9 
					                                 f32 %82 = OpLoad %81 
					                                 f32 %83 = OpFNegate %82 
					                         Output f32* %84 = OpAccessChain %13 %15 %9 
					                                             OpStore %84 %83 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 287
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %32 %131 %190 %278 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate vs_TEXCOORD1 Location 32 
					                                             OpDecorate vs_TEXCOORD2 Location 131 
					                                             OpDecorate vs_TEXCOORD3 Location 190 
					                                             OpDecorate %278 Location 278 
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
					                                     %24 = OpTypeVector %6 4 
					                      Private f32_3* %27 = OpVariable Private 
					                                     %31 = OpTypePointer Input %24 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_3* %37 = OpVariable Private 
					                                     %42 = OpTypePointer Private %6 
					                        Private f32* %43 = OpVariable Private 
					                                     %44 = OpTypeInt 32 0 
					                                 u32 %45 = OpConstant 1 
					                                 u32 %49 = OpConstant 0 
					                                 u32 %54 = OpConstant 2 
					                      Private f32_3* %61 = OpVariable Private 
					                      Private f32_3* %69 = OpVariable Private 
					                                     %87 = OpTypeBool 
					                                     %88 = OpTypeVector %87 2 
					                                     %89 = OpTypePointer Private %88 
					                     Private bool_2* %90 = OpVariable Private 
					                                 f32 %93 = OpConstant 3,674022E-40 
					                               f32_4 %94 = OpConstantComposite %93 %93 %93 %93 
					                                     %95 = OpTypeVector %87 4 
					                                     %98 = OpTypePointer Private %20 
					                      Private f32_2* %99 = OpVariable Private 
					                                    %100 = OpTypePointer Private %87 
					                                f32 %103 = OpConstant 3,674022E-40 
					                                f32 %104 = OpConstant 3,674022E-40 
					                              f32_2 %112 = OpConstantComposite %103 %103 
					                      Private bool* %114 = OpVariable Private 
					                                    %118 = OpTypeInt 32 1 
					                                i32 %119 = OpConstant 0 
					                                i32 %120 = OpConstant 1 
					                                i32 %122 = OpConstant -1 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                     Private f32_3* %153 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD3 = OpVariable Input 
					                       Private f32* %199 = OpVariable Private 
					                     Private f32_2* %250 = OpVariable Private 
					                    Private bool_2* %256 = OpVariable Private 
					                                    %277 = OpTypePointer Output %24 
					                      Output f32_4* %278 = OpVariable Output 
					                              f32_2 %283 = OpConstantComposite %104 %104 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
					                                             OpStore %9 %26 
					                 read_only Texture2D %28 = OpLoad %12 
					                             sampler %29 = OpLoad %16 
					          read_only Texture2DSampled %30 = OpSampledImage %28 %29 
					                               f32_4 %33 = OpLoad vs_TEXCOORD1 
					                               f32_2 %34 = OpVectorShuffle %33 %33 0 1 
					                               f32_4 %35 = OpImageSampleImplicitLod %30 %34 
					                               f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
					                                             OpStore %27 %36 
					                               f32_3 %38 = OpLoad %9 
					                               f32_3 %39 = OpLoad %27 
					                               f32_3 %40 = OpFNegate %39 
					                               f32_3 %41 = OpFAdd %38 %40 
					                                             OpStore %37 %41 
					                        Private f32* %46 = OpAccessChain %37 %45 
					                                 f32 %47 = OpLoad %46 
					                                 f32 %48 = OpExtInst %1 4 %47 
					                        Private f32* %50 = OpAccessChain %37 %49 
					                                 f32 %51 = OpLoad %50 
					                                 f32 %52 = OpExtInst %1 4 %51 
					                                 f32 %53 = OpExtInst %1 40 %48 %52 
					                                             OpStore %43 %53 
					                        Private f32* %55 = OpAccessChain %37 %54 
					                                 f32 %56 = OpLoad %55 
					                                 f32 %57 = OpExtInst %1 4 %56 
					                                 f32 %58 = OpLoad %43 
					                                 f32 %59 = OpExtInst %1 40 %57 %58 
					                        Private f32* %60 = OpAccessChain %37 %49 
					                                             OpStore %60 %59 
					                 read_only Texture2D %62 = OpLoad %12 
					                             sampler %63 = OpLoad %16 
					          read_only Texture2DSampled %64 = OpSampledImage %62 %63 
					                               f32_4 %65 = OpLoad vs_TEXCOORD1 
					                               f32_2 %66 = OpVectorShuffle %65 %65 2 3 
					                               f32_4 %67 = OpImageSampleImplicitLod %64 %66 
					                               f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                             OpStore %61 %68 
					                               f32_3 %70 = OpLoad %9 
					                               f32_3 %71 = OpLoad %61 
					                               f32_3 %72 = OpFNegate %71 
					                               f32_3 %73 = OpFAdd %70 %72 
					                                             OpStore %69 %73 
					                        Private f32* %74 = OpAccessChain %69 %45 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpExtInst %1 4 %75 
					                        Private f32* %77 = OpAccessChain %69 %49 
					                                 f32 %78 = OpLoad %77 
					                                 f32 %79 = OpExtInst %1 4 %78 
					                                 f32 %80 = OpExtInst %1 40 %76 %79 
					                                             OpStore %43 %80 
					                        Private f32* %81 = OpAccessChain %69 %54 
					                                 f32 %82 = OpLoad %81 
					                                 f32 %83 = OpExtInst %1 4 %82 
					                                 f32 %84 = OpLoad %43 
					                                 f32 %85 = OpExtInst %1 40 %83 %84 
					                        Private f32* %86 = OpAccessChain %37 %45 
					                                             OpStore %86 %85 
					                               f32_3 %91 = OpLoad %37 
					                               f32_4 %92 = OpVectorShuffle %91 %91 0 1 0 1 
					                              bool_4 %96 = OpFOrdGreaterThanEqual %92 %94 
					                              bool_2 %97 = OpVectorShuffle %96 %96 0 1 
					                                             OpStore %90 %97 
					                      Private bool* %101 = OpAccessChain %90 %49 
					                               bool %102 = OpLoad %101 
					                                f32 %105 = OpSelect %102 %103 %104 
					                       Private f32* %106 = OpAccessChain %99 %49 
					                                             OpStore %106 %105 
					                      Private bool* %107 = OpAccessChain %90 %45 
					                               bool %108 = OpLoad %107 
					                                f32 %109 = OpSelect %108 %103 %104 
					                       Private f32* %110 = OpAccessChain %99 %45 
					                                             OpStore %110 %109 
					                              f32_2 %111 = OpLoad %99 
					                                f32 %113 = OpDot %111 %112 
					                                             OpStore %43 %113 
					                                f32 %115 = OpLoad %43 
					                               bool %116 = OpFOrdEqual %115 %104 
					                                             OpStore %114 %116 
					                               bool %117 = OpLoad %114 
					                                i32 %121 = OpSelect %117 %120 %119 
					                                i32 %123 = OpIMul %121 %122 
					                               bool %124 = OpINotEqual %123 %119 
					                                             OpSelectionMerge %126 None 
					                                             OpBranchConditional %124 %125 %126 
					                                    %125 = OpLabel 
					                                             OpKill
					                                    %126 = OpLabel 
					                read_only Texture2D %128 = OpLoad %12 
					                            sampler %129 = OpLoad %16 
					         read_only Texture2DSampled %130 = OpSampledImage %128 %129 
					                              f32_4 %132 = OpLoad vs_TEXCOORD2 
					                              f32_2 %133 = OpVectorShuffle %132 %132 0 1 
					                              f32_4 %134 = OpImageSampleImplicitLod %130 %133 
					                              f32_3 %135 = OpVectorShuffle %134 %134 0 1 2 
					                                             OpStore %69 %135 
					                              f32_3 %136 = OpLoad %9 
					                              f32_3 %137 = OpLoad %69 
					                              f32_3 %138 = OpFNegate %137 
					                              f32_3 %139 = OpFAdd %136 %138 
					                                             OpStore %69 %139 
					                       Private f32* %140 = OpAccessChain %69 %45 
					                                f32 %141 = OpLoad %140 
					                                f32 %142 = OpExtInst %1 4 %141 
					                       Private f32* %143 = OpAccessChain %69 %49 
					                                f32 %144 = OpLoad %143 
					                                f32 %145 = OpExtInst %1 4 %144 
					                                f32 %146 = OpExtInst %1 40 %142 %145 
					                                             OpStore %43 %146 
					                       Private f32* %147 = OpAccessChain %69 %54 
					                                f32 %148 = OpLoad %147 
					                                f32 %149 = OpExtInst %1 4 %148 
					                                f32 %150 = OpLoad %43 
					                                f32 %151 = OpExtInst %1 40 %149 %150 
					                       Private f32* %152 = OpAccessChain %69 %49 
					                                             OpStore %152 %151 
					                read_only Texture2D %154 = OpLoad %12 
					                            sampler %155 = OpLoad %16 
					         read_only Texture2DSampled %156 = OpSampledImage %154 %155 
					                              f32_4 %157 = OpLoad vs_TEXCOORD2 
					                              f32_2 %158 = OpVectorShuffle %157 %157 2 3 
					                              f32_4 %159 = OpImageSampleImplicitLod %156 %158 
					                              f32_3 %160 = OpVectorShuffle %159 %159 0 1 2 
					                                             OpStore %153 %160 
					                              f32_3 %161 = OpLoad %9 
					                              f32_3 %162 = OpLoad %153 
					                              f32_3 %163 = OpFNegate %162 
					                              f32_3 %164 = OpFAdd %161 %163 
					                                             OpStore %9 %164 
					                       Private f32* %165 = OpAccessChain %9 %45 
					                                f32 %166 = OpLoad %165 
					                                f32 %167 = OpExtInst %1 4 %166 
					                       Private f32* %168 = OpAccessChain %9 %49 
					                                f32 %169 = OpLoad %168 
					                                f32 %170 = OpExtInst %1 4 %169 
					                                f32 %171 = OpExtInst %1 40 %167 %170 
					                       Private f32* %172 = OpAccessChain %9 %49 
					                                             OpStore %172 %171 
					                       Private f32* %173 = OpAccessChain %9 %54 
					                                f32 %174 = OpLoad %173 
					                                f32 %175 = OpExtInst %1 4 %174 
					                       Private f32* %176 = OpAccessChain %9 %49 
					                                f32 %177 = OpLoad %176 
					                                f32 %178 = OpExtInst %1 40 %175 %177 
					                       Private f32* %179 = OpAccessChain %69 %45 
					                                             OpStore %179 %178 
					                              f32_3 %180 = OpLoad %37 
					                              f32_2 %181 = OpVectorShuffle %180 %180 0 1 
					                              f32_3 %182 = OpLoad %69 
					                              f32_2 %183 = OpVectorShuffle %182 %182 0 1 
					                              f32_2 %184 = OpExtInst %1 40 %181 %183 
					                              f32_3 %185 = OpLoad %9 
					                              f32_3 %186 = OpVectorShuffle %185 %184 3 4 2 
					                                             OpStore %9 %186 
					                read_only Texture2D %187 = OpLoad %12 
					                            sampler %188 = OpLoad %16 
					         read_only Texture2DSampled %189 = OpSampledImage %187 %188 
					                              f32_4 %191 = OpLoad vs_TEXCOORD3 
					                              f32_2 %192 = OpVectorShuffle %191 %191 0 1 
					                              f32_4 %193 = OpImageSampleImplicitLod %189 %192 
					                              f32_3 %194 = OpVectorShuffle %193 %193 0 1 2 
					                                             OpStore %69 %194 
					                              f32_3 %195 = OpLoad %27 
					                              f32_3 %196 = OpLoad %69 
					                              f32_3 %197 = OpFNegate %196 
					                              f32_3 %198 = OpFAdd %195 %197 
					                                             OpStore %27 %198 
					                       Private f32* %200 = OpAccessChain %27 %45 
					                                f32 %201 = OpLoad %200 
					                                f32 %202 = OpExtInst %1 4 %201 
					                       Private f32* %203 = OpAccessChain %27 %49 
					                                f32 %204 = OpLoad %203 
					                                f32 %205 = OpExtInst %1 4 %204 
					                                f32 %206 = OpExtInst %1 40 %202 %205 
					                                             OpStore %199 %206 
					                       Private f32* %207 = OpAccessChain %27 %54 
					                                f32 %208 = OpLoad %207 
					                                f32 %209 = OpExtInst %1 4 %208 
					                                f32 %210 = OpLoad %199 
					                                f32 %211 = OpExtInst %1 40 %209 %210 
					                       Private f32* %212 = OpAccessChain %27 %49 
					                                             OpStore %212 %211 
					                read_only Texture2D %213 = OpLoad %12 
					                            sampler %214 = OpLoad %16 
					         read_only Texture2DSampled %215 = OpSampledImage %213 %214 
					                              f32_4 %216 = OpLoad vs_TEXCOORD3 
					                              f32_2 %217 = OpVectorShuffle %216 %216 2 3 
					                              f32_4 %218 = OpImageSampleImplicitLod %215 %217 
					                              f32_3 %219 = OpVectorShuffle %218 %218 0 1 2 
					                                             OpStore %69 %219 
					                              f32_3 %220 = OpLoad %61 
					                              f32_3 %221 = OpLoad %69 
					                              f32_3 %222 = OpFNegate %221 
					                              f32_3 %223 = OpFAdd %220 %222 
					                                             OpStore %61 %223 
					                       Private f32* %224 = OpAccessChain %61 %45 
					                                f32 %225 = OpLoad %224 
					                                f32 %226 = OpExtInst %1 4 %225 
					                       Private f32* %227 = OpAccessChain %61 %49 
					                                f32 %228 = OpLoad %227 
					                                f32 %229 = OpExtInst %1 4 %228 
					                                f32 %230 = OpExtInst %1 40 %226 %229 
					                                             OpStore %199 %230 
					                       Private f32* %231 = OpAccessChain %61 %54 
					                                f32 %232 = OpLoad %231 
					                                f32 %233 = OpExtInst %1 4 %232 
					                                f32 %234 = OpLoad %199 
					                                f32 %235 = OpExtInst %1 40 %233 %234 
					                       Private f32* %236 = OpAccessChain %27 %45 
					                                             OpStore %236 %235 
					                              f32_3 %237 = OpLoad %9 
					                              f32_2 %238 = OpVectorShuffle %237 %237 0 1 
					                              f32_3 %239 = OpLoad %27 
					                              f32_2 %240 = OpVectorShuffle %239 %239 0 1 
					                              f32_2 %241 = OpExtInst %1 40 %238 %240 
					                              f32_3 %242 = OpLoad %9 
					                              f32_3 %243 = OpVectorShuffle %242 %241 3 4 2 
					                                             OpStore %9 %243 
					                       Private f32* %244 = OpAccessChain %9 %45 
					                                f32 %245 = OpLoad %244 
					                       Private f32* %246 = OpAccessChain %9 %49 
					                                f32 %247 = OpLoad %246 
					                                f32 %248 = OpExtInst %1 40 %245 %247 
					                       Private f32* %249 = OpAccessChain %9 %49 
					                                             OpStore %249 %248 
					                              f32_3 %251 = OpLoad %37 
					                              f32_2 %252 = OpVectorShuffle %251 %251 0 1 
					                              f32_3 %253 = OpLoad %37 
					                              f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                              f32_2 %255 = OpFAdd %252 %254 
					                                             OpStore %250 %255 
					                              f32_2 %257 = OpLoad %250 
					                              f32_4 %258 = OpVectorShuffle %257 %257 0 1 0 0 
					                              f32_3 %259 = OpLoad %9 
					                              f32_4 %260 = OpVectorShuffle %259 %259 0 0 0 0 
					                             bool_4 %261 = OpFOrdGreaterThanEqual %258 %260 
					                             bool_2 %262 = OpVectorShuffle %261 %261 0 1 
					                                             OpStore %256 %262 
					                      Private bool* %263 = OpAccessChain %256 %49 
					                               bool %264 = OpLoad %263 
					                                f32 %265 = OpSelect %264 %103 %104 
					                       Private f32* %266 = OpAccessChain %9 %49 
					                                             OpStore %266 %265 
					                      Private bool* %267 = OpAccessChain %256 %45 
					                               bool %268 = OpLoad %267 
					                                f32 %269 = OpSelect %268 %103 %104 
					                       Private f32* %270 = OpAccessChain %9 %45 
					                                             OpStore %270 %269 
					                              f32_3 %271 = OpLoad %9 
					                              f32_2 %272 = OpVectorShuffle %271 %271 0 1 
					                              f32_2 %273 = OpLoad %99 
					                              f32_2 %274 = OpFMul %272 %273 
					                              f32_3 %275 = OpLoad %9 
					                              f32_3 %276 = OpVectorShuffle %275 %274 3 4 2 
					                                             OpStore %9 %276 
					                              f32_3 %279 = OpLoad %9 
					                              f32_2 %280 = OpVectorShuffle %279 %279 0 1 
					                              f32_4 %281 = OpLoad %278 
					                              f32_4 %282 = OpVectorShuffle %281 %280 4 5 2 3 
					                                             OpStore %278 %282 
					                              f32_4 %284 = OpLoad %278 
					                              f32_4 %285 = OpVectorShuffle %284 %283 0 1 4 5 
					                                             OpStore %278 %285 
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
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec2 u_xlat6;
					float u_xlat12;
					vec2 u_xlat14;
					bvec2 u_xlatb14;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat18 = max(abs(u_xlat2.y), abs(u_xlat2.x));
					    u_xlat2.x = max(abs(u_xlat2.z), u_xlat18);
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.zw);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat2.y = max(abs(u_xlat4.z), u_xlat18);
					    u_xlatb14.xy = greaterThanEqual(u_xlat2.xyxy, vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001)).xy;
					    u_xlat14.x = u_xlatb14.x ? float(1.0) : 0.0;
					    u_xlat14.y = u_xlatb14.y ? float(1.0) : 0.0;
					;
					    u_xlat18 = dot(u_xlat14.xy, vec2(1.0, 1.0));
					    u_xlatb18 = u_xlat18==0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat4.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat4.x = max(abs(u_xlat4.z), u_xlat18);
					    u_xlat5 = texture(_MainTex, vs_TEXCOORD2.zw);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
					    u_xlat0.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.y = max(abs(u_xlat0.z), u_xlat0.x);
					    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.xy);
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat1.y), abs(u_xlat1.x));
					    u_xlat1.x = max(abs(u_xlat1.z), u_xlat12);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.zw);
					    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat3.y), abs(u_xlat3.x));
					    u_xlat1.y = max(abs(u_xlat3.z), u_xlat12);
					    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
					    u_xlatb0.xy = greaterThanEqual(u_xlat6.xyxx, u_xlat0.xxxx).xy;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
					    SV_Target0.xy = u_xlat0.xy;
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
			GpuProgramID 181384
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 0.0, -1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD2 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, 0.0, 1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD3 = _MainTex_TexelSize.xyxy * vec4(-2.0, 0.0, 0.0, -2.0) + u_xlat0.xyxy;
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
					uniform 	vec4 _MainTex_TexelSize;
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 0.0, -1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD2 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, 0.0, 1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD3 = _MainTex_TexelSize.xyxy * vec4(-2.0, 0.0, 0.0, -2.0) + u_xlat0.xyxy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 150
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_shader_bit_encoding
					#extension GL_ARB_shader_bit_encoding : enable
					#endif
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec2 u_xlat6;
					float u_xlat12;
					vec2 u_xlat14;
					bvec2 u_xlatb14;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat18 = max(abs(u_xlat2.y), abs(u_xlat2.x));
					    u_xlat2.x = max(abs(u_xlat2.z), u_xlat18);
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.zw);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat2.y = max(abs(u_xlat4.z), u_xlat18);
					    u_xlatb14.xy = greaterThanEqual(u_xlat2.xyxy, vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001)).xy;
					    u_xlat14.x = u_xlatb14.x ? float(1.0) : 0.0;
					    u_xlat14.y = u_xlatb14.y ? float(1.0) : 0.0;
					;
					    u_xlat18 = dot(u_xlat14.xy, vec2(1.0, 1.0));
					    u_xlatb18 = u_xlat18==0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat4.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat4.x = max(abs(u_xlat4.z), u_xlat18);
					    u_xlat5 = texture(_MainTex, vs_TEXCOORD2.zw);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
					    u_xlat0.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.y = max(abs(u_xlat0.z), u_xlat0.x);
					    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.xy);
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat1.y), abs(u_xlat1.x));
					    u_xlat1.x = max(abs(u_xlat1.z), u_xlat12);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.zw);
					    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat3.y), abs(u_xlat3.x));
					    u_xlat1.y = max(abs(u_xlat3.z), u_xlat12);
					    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
					    u_xlatb0.xy = greaterThanEqual(u_xlat6.xyxx, u_xlat0.xxxx).xy;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
					    SV_Target0.xy = u_xlat0.xy;
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
					; Bound: 86
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %45 %47 %61 %70 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD0 Location 45 
					                                             OpDecorate vs_TEXCOORD1 Location 47 
					                                             OpMemberDecorate %48 0 Offset 48 
					                                             OpDecorate %48 Block 
					                                             OpDecorate %50 DescriptorSet 50 
					                                             OpDecorate %50 Binding 50 
					                                             OpDecorate vs_TEXCOORD2 Location 61 
					                                             OpDecorate vs_TEXCOORD3 Location 70 
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
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					              Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                     %48 = OpTypeStruct %7 
					                                     %49 = OpTypePointer Uniform %48 
					            Uniform struct {f32_4;}* %50 = OpVariable Uniform 
					                                     %51 = OpTypePointer Uniform %7 
					                                 f32 %55 = OpConstant 3,674022E-40 
					                               f32_4 %56 = OpConstantComposite %55 %26 %26 %55 
					              Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                               f32_4 %65 = OpConstantComposite %27 %26 %26 %27 
					              Output f32_4* vs_TEXCOORD3 = OpVariable Output 
					                                 f32 %74 = OpConstant 3,674022E-40 
					                               f32_4 %75 = OpConstantComposite %74 %26 %26 %74 
					                                     %80 = OpTypePointer Output %6 
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
					                                             OpStore vs_TEXCOORD0 %46 
					                      Uniform f32_4* %52 = OpAccessChain %50 %15 
					                               f32_4 %53 = OpLoad %52 
					                               f32_4 %54 = OpVectorShuffle %53 %53 0 1 0 1 
					                               f32_4 %57 = OpFMul %54 %56 
					                               f32_2 %58 = OpLoad %33 
					                               f32_4 %59 = OpVectorShuffle %58 %58 0 1 0 1 
					                               f32_4 %60 = OpFAdd %57 %59 
					                                             OpStore vs_TEXCOORD1 %60 
					                      Uniform f32_4* %62 = OpAccessChain %50 %15 
					                               f32_4 %63 = OpLoad %62 
					                               f32_4 %64 = OpVectorShuffle %63 %63 0 1 0 1 
					                               f32_4 %66 = OpFMul %64 %65 
					                               f32_2 %67 = OpLoad %33 
					                               f32_4 %68 = OpVectorShuffle %67 %67 0 1 0 1 
					                               f32_4 %69 = OpFAdd %66 %68 
					                                             OpStore vs_TEXCOORD2 %69 
					                      Uniform f32_4* %71 = OpAccessChain %50 %15 
					                               f32_4 %72 = OpLoad %71 
					                               f32_4 %73 = OpVectorShuffle %72 %72 0 1 0 1 
					                               f32_4 %76 = OpFMul %73 %75 
					                               f32_2 %77 = OpLoad %33 
					                               f32_4 %78 = OpVectorShuffle %77 %77 0 1 0 1 
					                               f32_4 %79 = OpFAdd %76 %78 
					                                             OpStore vs_TEXCOORD3 %79 
					                         Output f32* %81 = OpAccessChain %13 %15 %9 
					                                 f32 %82 = OpLoad %81 
					                                 f32 %83 = OpFNegate %82 
					                         Output f32* %84 = OpAccessChain %13 %15 %9 
					                                             OpStore %84 %83 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 287
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %32 %131 %190 %278 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate vs_TEXCOORD1 Location 32 
					                                             OpDecorate vs_TEXCOORD2 Location 131 
					                                             OpDecorate vs_TEXCOORD3 Location 190 
					                                             OpDecorate %278 Location 278 
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
					                                     %24 = OpTypeVector %6 4 
					                      Private f32_3* %27 = OpVariable Private 
					                                     %31 = OpTypePointer Input %24 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_3* %37 = OpVariable Private 
					                                     %42 = OpTypePointer Private %6 
					                        Private f32* %43 = OpVariable Private 
					                                     %44 = OpTypeInt 32 0 
					                                 u32 %45 = OpConstant 1 
					                                 u32 %49 = OpConstant 0 
					                                 u32 %54 = OpConstant 2 
					                      Private f32_3* %61 = OpVariable Private 
					                      Private f32_3* %69 = OpVariable Private 
					                                     %87 = OpTypeBool 
					                                     %88 = OpTypeVector %87 2 
					                                     %89 = OpTypePointer Private %88 
					                     Private bool_2* %90 = OpVariable Private 
					                                 f32 %93 = OpConstant 3,674022E-40 
					                               f32_4 %94 = OpConstantComposite %93 %93 %93 %93 
					                                     %95 = OpTypeVector %87 4 
					                                     %98 = OpTypePointer Private %20 
					                      Private f32_2* %99 = OpVariable Private 
					                                    %100 = OpTypePointer Private %87 
					                                f32 %103 = OpConstant 3,674022E-40 
					                                f32 %104 = OpConstant 3,674022E-40 
					                              f32_2 %112 = OpConstantComposite %103 %103 
					                      Private bool* %114 = OpVariable Private 
					                                    %118 = OpTypeInt 32 1 
					                                i32 %119 = OpConstant 0 
					                                i32 %120 = OpConstant 1 
					                                i32 %122 = OpConstant -1 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                     Private f32_3* %153 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD3 = OpVariable Input 
					                       Private f32* %199 = OpVariable Private 
					                     Private f32_2* %250 = OpVariable Private 
					                    Private bool_2* %256 = OpVariable Private 
					                                    %277 = OpTypePointer Output %24 
					                      Output f32_4* %278 = OpVariable Output 
					                              f32_2 %283 = OpConstantComposite %104 %104 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
					                                             OpStore %9 %26 
					                 read_only Texture2D %28 = OpLoad %12 
					                             sampler %29 = OpLoad %16 
					          read_only Texture2DSampled %30 = OpSampledImage %28 %29 
					                               f32_4 %33 = OpLoad vs_TEXCOORD1 
					                               f32_2 %34 = OpVectorShuffle %33 %33 0 1 
					                               f32_4 %35 = OpImageSampleImplicitLod %30 %34 
					                               f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
					                                             OpStore %27 %36 
					                               f32_3 %38 = OpLoad %9 
					                               f32_3 %39 = OpLoad %27 
					                               f32_3 %40 = OpFNegate %39 
					                               f32_3 %41 = OpFAdd %38 %40 
					                                             OpStore %37 %41 
					                        Private f32* %46 = OpAccessChain %37 %45 
					                                 f32 %47 = OpLoad %46 
					                                 f32 %48 = OpExtInst %1 4 %47 
					                        Private f32* %50 = OpAccessChain %37 %49 
					                                 f32 %51 = OpLoad %50 
					                                 f32 %52 = OpExtInst %1 4 %51 
					                                 f32 %53 = OpExtInst %1 40 %48 %52 
					                                             OpStore %43 %53 
					                        Private f32* %55 = OpAccessChain %37 %54 
					                                 f32 %56 = OpLoad %55 
					                                 f32 %57 = OpExtInst %1 4 %56 
					                                 f32 %58 = OpLoad %43 
					                                 f32 %59 = OpExtInst %1 40 %57 %58 
					                        Private f32* %60 = OpAccessChain %37 %49 
					                                             OpStore %60 %59 
					                 read_only Texture2D %62 = OpLoad %12 
					                             sampler %63 = OpLoad %16 
					          read_only Texture2DSampled %64 = OpSampledImage %62 %63 
					                               f32_4 %65 = OpLoad vs_TEXCOORD1 
					                               f32_2 %66 = OpVectorShuffle %65 %65 2 3 
					                               f32_4 %67 = OpImageSampleImplicitLod %64 %66 
					                               f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                             OpStore %61 %68 
					                               f32_3 %70 = OpLoad %9 
					                               f32_3 %71 = OpLoad %61 
					                               f32_3 %72 = OpFNegate %71 
					                               f32_3 %73 = OpFAdd %70 %72 
					                                             OpStore %69 %73 
					                        Private f32* %74 = OpAccessChain %69 %45 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpExtInst %1 4 %75 
					                        Private f32* %77 = OpAccessChain %69 %49 
					                                 f32 %78 = OpLoad %77 
					                                 f32 %79 = OpExtInst %1 4 %78 
					                                 f32 %80 = OpExtInst %1 40 %76 %79 
					                                             OpStore %43 %80 
					                        Private f32* %81 = OpAccessChain %69 %54 
					                                 f32 %82 = OpLoad %81 
					                                 f32 %83 = OpExtInst %1 4 %82 
					                                 f32 %84 = OpLoad %43 
					                                 f32 %85 = OpExtInst %1 40 %83 %84 
					                        Private f32* %86 = OpAccessChain %37 %45 
					                                             OpStore %86 %85 
					                               f32_3 %91 = OpLoad %37 
					                               f32_4 %92 = OpVectorShuffle %91 %91 0 1 0 1 
					                              bool_4 %96 = OpFOrdGreaterThanEqual %92 %94 
					                              bool_2 %97 = OpVectorShuffle %96 %96 0 1 
					                                             OpStore %90 %97 
					                      Private bool* %101 = OpAccessChain %90 %49 
					                               bool %102 = OpLoad %101 
					                                f32 %105 = OpSelect %102 %103 %104 
					                       Private f32* %106 = OpAccessChain %99 %49 
					                                             OpStore %106 %105 
					                      Private bool* %107 = OpAccessChain %90 %45 
					                               bool %108 = OpLoad %107 
					                                f32 %109 = OpSelect %108 %103 %104 
					                       Private f32* %110 = OpAccessChain %99 %45 
					                                             OpStore %110 %109 
					                              f32_2 %111 = OpLoad %99 
					                                f32 %113 = OpDot %111 %112 
					                                             OpStore %43 %113 
					                                f32 %115 = OpLoad %43 
					                               bool %116 = OpFOrdEqual %115 %104 
					                                             OpStore %114 %116 
					                               bool %117 = OpLoad %114 
					                                i32 %121 = OpSelect %117 %120 %119 
					                                i32 %123 = OpIMul %121 %122 
					                               bool %124 = OpINotEqual %123 %119 
					                                             OpSelectionMerge %126 None 
					                                             OpBranchConditional %124 %125 %126 
					                                    %125 = OpLabel 
					                                             OpKill
					                                    %126 = OpLabel 
					                read_only Texture2D %128 = OpLoad %12 
					                            sampler %129 = OpLoad %16 
					         read_only Texture2DSampled %130 = OpSampledImage %128 %129 
					                              f32_4 %132 = OpLoad vs_TEXCOORD2 
					                              f32_2 %133 = OpVectorShuffle %132 %132 0 1 
					                              f32_4 %134 = OpImageSampleImplicitLod %130 %133 
					                              f32_3 %135 = OpVectorShuffle %134 %134 0 1 2 
					                                             OpStore %69 %135 
					                              f32_3 %136 = OpLoad %9 
					                              f32_3 %137 = OpLoad %69 
					                              f32_3 %138 = OpFNegate %137 
					                              f32_3 %139 = OpFAdd %136 %138 
					                                             OpStore %69 %139 
					                       Private f32* %140 = OpAccessChain %69 %45 
					                                f32 %141 = OpLoad %140 
					                                f32 %142 = OpExtInst %1 4 %141 
					                       Private f32* %143 = OpAccessChain %69 %49 
					                                f32 %144 = OpLoad %143 
					                                f32 %145 = OpExtInst %1 4 %144 
					                                f32 %146 = OpExtInst %1 40 %142 %145 
					                                             OpStore %43 %146 
					                       Private f32* %147 = OpAccessChain %69 %54 
					                                f32 %148 = OpLoad %147 
					                                f32 %149 = OpExtInst %1 4 %148 
					                                f32 %150 = OpLoad %43 
					                                f32 %151 = OpExtInst %1 40 %149 %150 
					                       Private f32* %152 = OpAccessChain %69 %49 
					                                             OpStore %152 %151 
					                read_only Texture2D %154 = OpLoad %12 
					                            sampler %155 = OpLoad %16 
					         read_only Texture2DSampled %156 = OpSampledImage %154 %155 
					                              f32_4 %157 = OpLoad vs_TEXCOORD2 
					                              f32_2 %158 = OpVectorShuffle %157 %157 2 3 
					                              f32_4 %159 = OpImageSampleImplicitLod %156 %158 
					                              f32_3 %160 = OpVectorShuffle %159 %159 0 1 2 
					                                             OpStore %153 %160 
					                              f32_3 %161 = OpLoad %9 
					                              f32_3 %162 = OpLoad %153 
					                              f32_3 %163 = OpFNegate %162 
					                              f32_3 %164 = OpFAdd %161 %163 
					                                             OpStore %9 %164 
					                       Private f32* %165 = OpAccessChain %9 %45 
					                                f32 %166 = OpLoad %165 
					                                f32 %167 = OpExtInst %1 4 %166 
					                       Private f32* %168 = OpAccessChain %9 %49 
					                                f32 %169 = OpLoad %168 
					                                f32 %170 = OpExtInst %1 4 %169 
					                                f32 %171 = OpExtInst %1 40 %167 %170 
					                       Private f32* %172 = OpAccessChain %9 %49 
					                                             OpStore %172 %171 
					                       Private f32* %173 = OpAccessChain %9 %54 
					                                f32 %174 = OpLoad %173 
					                                f32 %175 = OpExtInst %1 4 %174 
					                       Private f32* %176 = OpAccessChain %9 %49 
					                                f32 %177 = OpLoad %176 
					                                f32 %178 = OpExtInst %1 40 %175 %177 
					                       Private f32* %179 = OpAccessChain %69 %45 
					                                             OpStore %179 %178 
					                              f32_3 %180 = OpLoad %37 
					                              f32_2 %181 = OpVectorShuffle %180 %180 0 1 
					                              f32_3 %182 = OpLoad %69 
					                              f32_2 %183 = OpVectorShuffle %182 %182 0 1 
					                              f32_2 %184 = OpExtInst %1 40 %181 %183 
					                              f32_3 %185 = OpLoad %9 
					                              f32_3 %186 = OpVectorShuffle %185 %184 3 4 2 
					                                             OpStore %9 %186 
					                read_only Texture2D %187 = OpLoad %12 
					                            sampler %188 = OpLoad %16 
					         read_only Texture2DSampled %189 = OpSampledImage %187 %188 
					                              f32_4 %191 = OpLoad vs_TEXCOORD3 
					                              f32_2 %192 = OpVectorShuffle %191 %191 0 1 
					                              f32_4 %193 = OpImageSampleImplicitLod %189 %192 
					                              f32_3 %194 = OpVectorShuffle %193 %193 0 1 2 
					                                             OpStore %69 %194 
					                              f32_3 %195 = OpLoad %27 
					                              f32_3 %196 = OpLoad %69 
					                              f32_3 %197 = OpFNegate %196 
					                              f32_3 %198 = OpFAdd %195 %197 
					                                             OpStore %27 %198 
					                       Private f32* %200 = OpAccessChain %27 %45 
					                                f32 %201 = OpLoad %200 
					                                f32 %202 = OpExtInst %1 4 %201 
					                       Private f32* %203 = OpAccessChain %27 %49 
					                                f32 %204 = OpLoad %203 
					                                f32 %205 = OpExtInst %1 4 %204 
					                                f32 %206 = OpExtInst %1 40 %202 %205 
					                                             OpStore %199 %206 
					                       Private f32* %207 = OpAccessChain %27 %54 
					                                f32 %208 = OpLoad %207 
					                                f32 %209 = OpExtInst %1 4 %208 
					                                f32 %210 = OpLoad %199 
					                                f32 %211 = OpExtInst %1 40 %209 %210 
					                       Private f32* %212 = OpAccessChain %27 %49 
					                                             OpStore %212 %211 
					                read_only Texture2D %213 = OpLoad %12 
					                            sampler %214 = OpLoad %16 
					         read_only Texture2DSampled %215 = OpSampledImage %213 %214 
					                              f32_4 %216 = OpLoad vs_TEXCOORD3 
					                              f32_2 %217 = OpVectorShuffle %216 %216 2 3 
					                              f32_4 %218 = OpImageSampleImplicitLod %215 %217 
					                              f32_3 %219 = OpVectorShuffle %218 %218 0 1 2 
					                                             OpStore %69 %219 
					                              f32_3 %220 = OpLoad %61 
					                              f32_3 %221 = OpLoad %69 
					                              f32_3 %222 = OpFNegate %221 
					                              f32_3 %223 = OpFAdd %220 %222 
					                                             OpStore %61 %223 
					                       Private f32* %224 = OpAccessChain %61 %45 
					                                f32 %225 = OpLoad %224 
					                                f32 %226 = OpExtInst %1 4 %225 
					                       Private f32* %227 = OpAccessChain %61 %49 
					                                f32 %228 = OpLoad %227 
					                                f32 %229 = OpExtInst %1 4 %228 
					                                f32 %230 = OpExtInst %1 40 %226 %229 
					                                             OpStore %199 %230 
					                       Private f32* %231 = OpAccessChain %61 %54 
					                                f32 %232 = OpLoad %231 
					                                f32 %233 = OpExtInst %1 4 %232 
					                                f32 %234 = OpLoad %199 
					                                f32 %235 = OpExtInst %1 40 %233 %234 
					                       Private f32* %236 = OpAccessChain %27 %45 
					                                             OpStore %236 %235 
					                              f32_3 %237 = OpLoad %9 
					                              f32_2 %238 = OpVectorShuffle %237 %237 0 1 
					                              f32_3 %239 = OpLoad %27 
					                              f32_2 %240 = OpVectorShuffle %239 %239 0 1 
					                              f32_2 %241 = OpExtInst %1 40 %238 %240 
					                              f32_3 %242 = OpLoad %9 
					                              f32_3 %243 = OpVectorShuffle %242 %241 3 4 2 
					                                             OpStore %9 %243 
					                       Private f32* %244 = OpAccessChain %9 %45 
					                                f32 %245 = OpLoad %244 
					                       Private f32* %246 = OpAccessChain %9 %49 
					                                f32 %247 = OpLoad %246 
					                                f32 %248 = OpExtInst %1 40 %245 %247 
					                       Private f32* %249 = OpAccessChain %9 %49 
					                                             OpStore %249 %248 
					                              f32_3 %251 = OpLoad %37 
					                              f32_2 %252 = OpVectorShuffle %251 %251 0 1 
					                              f32_3 %253 = OpLoad %37 
					                              f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                              f32_2 %255 = OpFAdd %252 %254 
					                                             OpStore %250 %255 
					                              f32_2 %257 = OpLoad %250 
					                              f32_4 %258 = OpVectorShuffle %257 %257 0 1 0 0 
					                              f32_3 %259 = OpLoad %9 
					                              f32_4 %260 = OpVectorShuffle %259 %259 0 0 0 0 
					                             bool_4 %261 = OpFOrdGreaterThanEqual %258 %260 
					                             bool_2 %262 = OpVectorShuffle %261 %261 0 1 
					                                             OpStore %256 %262 
					                      Private bool* %263 = OpAccessChain %256 %49 
					                               bool %264 = OpLoad %263 
					                                f32 %265 = OpSelect %264 %103 %104 
					                       Private f32* %266 = OpAccessChain %9 %49 
					                                             OpStore %266 %265 
					                      Private bool* %267 = OpAccessChain %256 %45 
					                               bool %268 = OpLoad %267 
					                                f32 %269 = OpSelect %268 %103 %104 
					                       Private f32* %270 = OpAccessChain %9 %45 
					                                             OpStore %270 %269 
					                              f32_3 %271 = OpLoad %9 
					                              f32_2 %272 = OpVectorShuffle %271 %271 0 1 
					                              f32_2 %273 = OpLoad %99 
					                              f32_2 %274 = OpFMul %272 %273 
					                              f32_3 %275 = OpLoad %9 
					                              f32_3 %276 = OpVectorShuffle %275 %274 3 4 2 
					                                             OpStore %9 %276 
					                              f32_3 %279 = OpLoad %9 
					                              f32_2 %280 = OpVectorShuffle %279 %279 0 1 
					                              f32_4 %281 = OpLoad %278 
					                              f32_4 %282 = OpVectorShuffle %281 %280 4 5 2 3 
					                                             OpStore %278 %282 
					                              f32_4 %284 = OpLoad %278 
					                              f32_4 %285 = OpVectorShuffle %284 %283 0 1 4 5 
					                                             OpStore %278 %285 
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
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec2 u_xlat6;
					float u_xlat12;
					vec2 u_xlat14;
					bvec2 u_xlatb14;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat18 = max(abs(u_xlat2.y), abs(u_xlat2.x));
					    u_xlat2.x = max(abs(u_xlat2.z), u_xlat18);
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.zw);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat2.y = max(abs(u_xlat4.z), u_xlat18);
					    u_xlatb14.xy = greaterThanEqual(u_xlat2.xyxy, vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001)).xy;
					    u_xlat14.x = u_xlatb14.x ? float(1.0) : 0.0;
					    u_xlat14.y = u_xlatb14.y ? float(1.0) : 0.0;
					;
					    u_xlat18 = dot(u_xlat14.xy, vec2(1.0, 1.0));
					    u_xlatb18 = u_xlat18==0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat4.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat4.x = max(abs(u_xlat4.z), u_xlat18);
					    u_xlat5 = texture(_MainTex, vs_TEXCOORD2.zw);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
					    u_xlat0.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.y = max(abs(u_xlat0.z), u_xlat0.x);
					    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.xy);
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat1.y), abs(u_xlat1.x));
					    u_xlat1.x = max(abs(u_xlat1.z), u_xlat12);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.zw);
					    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat3.y), abs(u_xlat3.x));
					    u_xlat1.y = max(abs(u_xlat3.z), u_xlat12);
					    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
					    u_xlatb0.xy = greaterThanEqual(u_xlat6.xyxx, u_xlat0.xxxx).xy;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
					    SV_Target0.xy = u_xlat0.xy;
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
			GpuProgramID 249696
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(0.5, -0.5, 0.5, -0.5) + vec4(0.0, 1.0, 0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.zw * _MainTex_TexelSize.zw;
					    u_xlat1 = _MainTex_TexelSize.xxyy * vec4(-0.25, 1.25, -0.125, -0.125) + u_xlat0.zzww;
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.125, -0.25, -0.125, 1.25) + u_xlat0;
					    vs_TEXCOORD2 = u_xlat1.xzyw;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat1.zw = u_xlat0.yw;
					    vs_TEXCOORD4 = _MainTex_TexelSize.xxyy * vec4(-8.0, 8.0, -8.0, 8.0) + u_xlat1;
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
					uniform 	vec4 _MainTex_TexelSize;
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(0.5, 0.5, 0.5, 0.5);
					    vs_TEXCOORD1.xy = u_xlat0.zw * _MainTex_TexelSize.zw;
					    u_xlat1 = _MainTex_TexelSize.xxyy * vec4(-0.25, 1.25, -0.125, -0.125) + u_xlat0.zzww;
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.125, -0.25, -0.125, 1.25) + u_xlat0;
					    vs_TEXCOORD2 = u_xlat1.xzyw;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat1.zw = u_xlat0.yw;
					    vs_TEXCOORD4 = _MainTex_TexelSize.xxyy * vec4(-8.0, 8.0, -8.0, 8.0) + u_xlat1;
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
					UNITY_LOCATION(1) uniform  sampler2D _SearchTex;
					UNITY_LOCATION(2) uniform  sampler2D _AreaTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					bool u_xlatb10;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.yxyy).xy;
					    if(u_xlatb0.x){
					        u_xlat1.xy = vs_TEXCOORD2.xy;
					        u_xlat1.z = 1.0;
					        u_xlat2.x = 0.0;
					        while(true){
					            u_xlatb0.x = vs_TEXCOORD4.x<u_xlat1.x;
					            u_xlatb10 = 0.828100026<u_xlat1.z;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            u_xlatb10 = u_xlat2.x==0.0;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            if(!u_xlatb0.x){break;}
					            u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					            u_xlat1.xy = _MainTex_TexelSize.xy * vec2(-2.0, -0.0) + u_xlat1.xy;
					            u_xlat1.z = u_xlat2.y;
					        }
					        u_xlat2.yz = u_xlat1.xz;
					        u_xlat0.xz = u_xlat2.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat1 = textureLod(_SearchTex, u_xlat0.xz, 0.0);
					        u_xlat0.x = u_xlat1.w * -2.00787401 + 3.25;
					        u_xlat1.x = _MainTex_TexelSize.x * u_xlat0.x + u_xlat2.y;
					        u_xlat1.y = vs_TEXCOORD3.y;
					        u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					        u_xlat3.xy = vs_TEXCOORD2.zw;
					        u_xlat3.z = 1.0;
					        u_xlat4.x = 0.0;
					        while(true){
					            u_xlatb0.x = u_xlat3.x<vs_TEXCOORD4.y;
					            u_xlatb10 = 0.828100026<u_xlat3.z;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            u_xlatb10 = u_xlat4.x==0.0;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            if(!u_xlatb0.x){break;}
					            u_xlat4 = textureLod(_MainTex, u_xlat3.xy, 0.0);
					            u_xlat3.xy = _MainTex_TexelSize.xy * vec2(2.0, 0.0) + u_xlat3.xy;
					            u_xlat3.z = u_xlat4.y;
					        }
					        u_xlat4.yz = u_xlat3.xz;
					        u_xlat0.xz = u_xlat4.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat3 = textureLod(_SearchTex, u_xlat0.xz, 0.0);
					        u_xlat0.x = u_xlat3.w * -2.00787401 + 3.25;
					        u_xlat1.z = (-_MainTex_TexelSize.x) * u_xlat0.x + u_xlat4.y;
					        u_xlat0.xz = _MainTex_TexelSize.zz * u_xlat1.xz + (-vs_TEXCOORD1.xx);
					        u_xlat0.xz = roundEven(u_xlat0.xz);
					        u_xlat0.xz = sqrt(abs(u_xlat0.xz));
					        u_xlat1.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0) + u_xlat1.zy;
					        u_xlat1 = textureLod(_MainTex, u_xlat1.xy, 0.0).yxzw;
					        u_xlat1.x = u_xlat2.x;
					        u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
					        u_xlat1.xy = roundEven(u_xlat1.xy);
					        u_xlat0.xz = u_xlat1.xy * vec2(16.0, 16.0) + u_xlat0.xz;
					        u_xlat0.xz = u_xlat0.xz * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat1 = textureLod(_AreaTex, u_xlat0.xz, 0.0);
					        SV_Target0.xy = u_xlat1.xy;
					    } else {
					        SV_Target0.xy = vec2(0.0, 0.0);
					    }
					    if(u_xlatb0.y){
					        u_xlat0.xy = vs_TEXCOORD3.xy;
					        u_xlat0.z = 1.0;
					        u_xlat1.x = 0.0;
					        while(true){
					            u_xlatb15 = vs_TEXCOORD4.z<u_xlat0.y;
					            u_xlatb2 = 0.828100026<u_xlat0.z;
					            u_xlatb15 = u_xlatb15 && u_xlatb2;
					            u_xlatb2 = u_xlat1.x==0.0;
					            u_xlatb15 = u_xlatb15 && u_xlatb2;
					            if(!u_xlatb15){break;}
					            u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0).yxzw;
					            u_xlat0.xy = _MainTex_TexelSize.xy * vec2(-0.0, -2.0) + u_xlat0.xy;
					            u_xlat0.z = u_xlat1.y;
					        }
					        u_xlat1.yz = u_xlat0.yz;
					        u_xlat0.xy = u_xlat1.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat0 = textureLod(_SearchTex, u_xlat0.xy, 0.0);
					        u_xlat0.x = u_xlat0.w * -2.00787401 + 3.25;
					        u_xlat0.x = _MainTex_TexelSize.y * u_xlat0.x + u_xlat1.y;
					        u_xlat0.y = vs_TEXCOORD2.x;
					        u_xlat1 = textureLod(_MainTex, u_xlat0.yx, 0.0);
					        u_xlat2.xy = vs_TEXCOORD3.zw;
					        u_xlat2.z = 1.0;
					        u_xlat3.x = 0.0;
					        while(true){
					            u_xlatb15 = u_xlat2.y<vs_TEXCOORD4.w;
					            u_xlatb1 = 0.828100026<u_xlat2.z;
					            u_xlatb15 = u_xlatb15 && u_xlatb1;
					            u_xlatb1 = u_xlat3.x==0.0;
					            u_xlatb15 = u_xlatb15 && u_xlatb1;
					            if(!u_xlatb15){break;}
					            u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0).yxzw;
					            u_xlat2.xy = _MainTex_TexelSize.xy * vec2(0.0, 2.0) + u_xlat2.xy;
					            u_xlat2.z = u_xlat3.y;
					        }
					        u_xlat3.yz = u_xlat2.yz;
					        u_xlat1.xz = u_xlat3.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat2 = textureLod(_SearchTex, u_xlat1.xz, 0.0);
					        u_xlat15 = u_xlat2.w * -2.00787401 + 3.25;
					        u_xlat0.z = (-_MainTex_TexelSize.y) * u_xlat15 + u_xlat3.y;
					        u_xlat0.xw = _MainTex_TexelSize.ww * u_xlat0.xz + (-vs_TEXCOORD1.yy);
					        u_xlat0.xw = roundEven(u_xlat0.xw);
					        u_xlat0.xw = sqrt(abs(u_xlat0.xw));
					        u_xlat5.xy = _MainTex_TexelSize.xy * vec2(0.0, 1.0) + u_xlat0.yz;
					        u_xlat2 = textureLod(_MainTex, u_xlat5.xy, 0.0);
					        u_xlat2.x = u_xlat1.y;
					        u_xlat5.xy = u_xlat2.xy * vec2(4.0, 4.0);
					        u_xlat5.xy = roundEven(u_xlat5.xy);
					        u_xlat0.xy = u_xlat5.xy * vec2(16.0, 16.0) + u_xlat0.xw;
					        u_xlat0.xy = u_xlat0.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat0 = textureLod(_AreaTex, u_xlat0.xy, 0.0);
					        SV_Target0.zw = u_xlat0.xy;
					    } else {
					        SV_Target0.zw = vec2(0.0, 0.0);
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
					; Bound: 108
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %33 %53 %83 %86 %92 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                             OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD0 Location 33 
					                                             OpDecorate vs_TEXCOORD1 Location 53 
					                                             OpMemberDecorate %56 0 Offset 56 
					                                             OpDecorate %56 Block 
					                                             OpDecorate %58 DescriptorSet 58 
					                                             OpDecorate %58 Binding 58 
					                                             OpDecorate vs_TEXCOORD2 Location 83 
					                                             OpDecorate vs_TEXCOORD3 Location 86 
					                                             OpDecorate vs_TEXCOORD4 Location 92 
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
					                                     %32 = OpTypePointer Output %19 
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                 f32 %36 = OpConstant 3,674022E-40 
					                                 f32 %37 = OpConstant 3,674022E-40 
					                               f32_2 %38 = OpConstantComposite %36 %37 
					                               f32_2 %40 = OpConstantComposite %36 %36 
					                                     %42 = OpTypePointer Private %7 
					                      Private f32_4* %43 = OpVariable Private 
					                               f32_4 %46 = OpConstantComposite %27 %27 %27 %27 
					                               f32_4 %49 = OpConstantComposite %36 %37 %36 %37 
					                               f32_4 %51 = OpConstantComposite %26 %27 %26 %27 
					              Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                     %56 = OpTypeStruct %7 
					                                     %57 = OpTypePointer Uniform %56 
					            Uniform struct {f32_4;}* %58 = OpVariable Uniform 
					                                     %59 = OpTypePointer Uniform %7 
					                      Private f32_4* %64 = OpVariable Private 
					                                 f32 %68 = OpConstant 3,674022E-40 
					                                 f32 %69 = OpConstant 3,674022E-40 
					                                 f32 %70 = OpConstant 3,674022E-40 
					                               f32_4 %71 = OpConstantComposite %68 %69 %70 %70 
					                               f32_4 %79 = OpConstantComposite %70 %68 %70 %69 
					              Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					              Output f32_4* vs_TEXCOORD3 = OpVariable Output 
					              Output f32_4* vs_TEXCOORD4 = OpVariable Output 
					                                 f32 %96 = OpConstant 3,674022E-40 
					                                 f32 %97 = OpConstant 3,674022E-40 
					                               f32_4 %98 = OpConstantComposite %96 %97 %96 %97 
					                                    %102 = OpTypePointer Output %6 
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
					                                             OpStore vs_TEXCOORD0 %41 
					                               f32_3 %44 = OpLoad %18 
					                               f32_4 %45 = OpVectorShuffle %44 %44 0 1 0 1 
					                               f32_4 %47 = OpFAdd %45 %46 
					                                             OpStore %43 %47 
					                               f32_4 %48 = OpLoad %43 
					                               f32_4 %50 = OpFMul %48 %49 
					                               f32_4 %52 = OpFAdd %50 %51 
					                                             OpStore %43 %52 
					                               f32_4 %54 = OpLoad %43 
					                               f32_2 %55 = OpVectorShuffle %54 %54 2 3 
					                      Uniform f32_4* %60 = OpAccessChain %58 %15 
					                               f32_4 %61 = OpLoad %60 
					                               f32_2 %62 = OpVectorShuffle %61 %61 2 3 
					                               f32_2 %63 = OpFMul %55 %62 
					                                             OpStore vs_TEXCOORD1 %63 
					                      Uniform f32_4* %65 = OpAccessChain %58 %15 
					                               f32_4 %66 = OpLoad %65 
					                               f32_4 %67 = OpVectorShuffle %66 %66 0 0 1 1 
					                               f32_4 %72 = OpFMul %67 %71 
					                               f32_4 %73 = OpLoad %43 
					                               f32_4 %74 = OpVectorShuffle %73 %73 2 2 3 3 
					                               f32_4 %75 = OpFAdd %72 %74 
					                                             OpStore %64 %75 
					                      Uniform f32_4* %76 = OpAccessChain %58 %15 
					                               f32_4 %77 = OpLoad %76 
					                               f32_4 %78 = OpVectorShuffle %77 %77 0 1 0 1 
					                               f32_4 %80 = OpFMul %78 %79 
					                               f32_4 %81 = OpLoad %43 
					                               f32_4 %82 = OpFAdd %80 %81 
					                                             OpStore %43 %82 
					                               f32_4 %84 = OpLoad %64 
					                               f32_4 %85 = OpVectorShuffle %84 %84 0 2 1 3 
					                                             OpStore vs_TEXCOORD2 %85 
					                               f32_4 %87 = OpLoad %43 
					                                             OpStore vs_TEXCOORD3 %87 
					                               f32_4 %88 = OpLoad %43 
					                               f32_2 %89 = OpVectorShuffle %88 %88 1 3 
					                               f32_4 %90 = OpLoad %64 
					                               f32_4 %91 = OpVectorShuffle %90 %89 0 1 4 5 
					                                             OpStore %64 %91 
					                      Uniform f32_4* %93 = OpAccessChain %58 %15 
					                               f32_4 %94 = OpLoad %93 
					                               f32_4 %95 = OpVectorShuffle %94 %94 0 0 1 1 
					                               f32_4 %99 = OpFMul %95 %98 
					                              f32_4 %100 = OpLoad %64 
					                              f32_4 %101 = OpFAdd %99 %100 
					                                             OpStore vs_TEXCOORD4 %101 
					                        Output f32* %103 = OpAccessChain %13 %15 %9 
					                                f32 %104 = OpLoad %103 
					                                f32 %105 = OpFNegate %104 
					                        Output f32* %106 = OpAccessChain %13 %15 %9 
					                                             OpStore %106 %105 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 618
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %22 %48 %67 %172 %281 %355 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                              OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
					                                              OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpDecorate %12 DescriptorSet 12 
					                                              OpDecorate %12 Binding 12 
					                                              OpDecorate %16 DescriptorSet 16 
					                                              OpDecorate %16 Binding 16 
					                                              OpDecorate vs_TEXCOORD0 Location 22 
					                                              OpDecorate vs_TEXCOORD2 Location 48 
					                                              OpDecorate vs_TEXCOORD4 Location 67 
					                                              OpMemberDecorate %108 0 Offset 108 
					                                              OpDecorate %108 Block 
					                                              OpDecorate %110 DescriptorSet 110 
					                                              OpDecorate %110 Binding 110 
					                                              OpDecorate %145 DescriptorSet 145 
					                                              OpDecorate %145 Binding 145 
					                                              OpDecorate vs_TEXCOORD3 Location 172 
					                                              OpDecorate vs_TEXCOORD1 Location 281 
					                                              OpDecorate %344 DescriptorSet 344 
					                                              OpDecorate %344 Binding 344 
					                                              OpDecorate %355 Location 355 
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
					                                      %28 = OpTypeBool 
					                                      %29 = OpTypeVector %28 2 
					                                      %30 = OpTypePointer Private %29 
					                      Private bool_2* %31 = OpVariable Private 
					                                  f32 %32 = OpConstant 3,674022E-40 
					                                f32_4 %33 = OpConstantComposite %32 %32 %32 %32 
					                                      %36 = OpTypeVector %28 4 
					                                      %39 = OpTypeInt 32 0 
					                                  u32 %40 = OpConstant 0 
					                                      %41 = OpTypePointer Private %28 
					                       Private f32_4* %46 = OpVariable Private 
					                                      %47 = OpTypePointer Input %7 
					                Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                  f32 %53 = OpConstant 3,674022E-40 
					                                  u32 %54 = OpConstant 2 
					                                      %55 = OpTypePointer Private %6 
					                                      %57 = OpTypeVector %6 3 
					                                      %58 = OpTypePointer Private %57 
					                       Private f32_3* %59 = OpVariable Private 
					                                 bool %66 = OpConstantTrue 
					                Input f32_4* vs_TEXCOORD4 = OpVariable Input 
					                                      %68 = OpTypePointer Input %6 
					                        Private bool* %75 = OpVariable Private 
					                                  f32 %76 = OpConstant 3,674022E-40 
					                                     %108 = OpTypeStruct %7 
					                                     %109 = OpTypePointer Uniform %108 
					            Uniform struct {f32_4;}* %110 = OpVariable Uniform 
					                                     %111 = OpTypeInt 32 1 
					                                 i32 %112 = OpConstant 0 
					                                     %113 = OpTypePointer Uniform %7 
					                                 f32 %117 = OpConstant 3,674022E-40 
					                                 f32 %118 = OpConstant 3,674022E-40 
					                               f32_2 %119 = OpConstantComposite %117 %118 
					                                 u32 %126 = OpConstant 1 
					                                 f32 %136 = OpConstant 3,674022E-40 
					                               f32_2 %137 = OpConstantComposite %136 %117 
					                                 f32 %139 = OpConstant 3,674022E-40 
					                                 f32 %140 = OpConstant 3,674022E-40 
					                               f32_2 %141 = OpConstantComposite %139 %140 
					UniformConstant read_only Texture2D* %145 = OpVariable UniformConstant 
					                                 u32 %152 = OpConstant 3 
					                                 f32 %157 = OpConstant 3,674022E-40 
					                                 f32 %159 = OpConstant 3,674022E-40 
					                                     %162 = OpTypePointer Uniform %6 
					                Input f32_4* vs_TEXCOORD3 = OpVariable Input 
					                      Private f32_3* %189 = OpVariable Private 
					                       Private bool* %196 = OpVariable Private 
					                       Private bool* %202 = OpVariable Private 
					                                 f32 %232 = OpConstant 3,674022E-40 
					                               f32_2 %233 = OpConstantComposite %232 %32 
					                                 f32 %250 = OpConstant 3,674022E-40 
					                               f32_2 %251 = OpConstantComposite %250 %140 
					                        Private f32* %255 = OpVariable Private 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                     %304 = OpTypeVector %111 2 
					                                 i32 %305 = OpConstant 1 
					                               i32_2 %306 = OpConstantComposite %305 %112 
					                                 f32 %312 = OpConstant 3,674022E-40 
					                               f32_2 %313 = OpConstantComposite %312 %312 
					                                 f32 %324 = OpConstant 3,674022E-40 
					                               f32_2 %325 = OpConstantComposite %324 %324 
					                                 f32 %334 = OpConstant 3,674022E-40 
					                                 f32 %335 = OpConstant 3,674022E-40 
					                               f32_2 %336 = OpConstantComposite %334 %335 
					                                 f32 %338 = OpConstant 3,674022E-40 
					                                 f32 %339 = OpConstant 3,674022E-40 
					                               f32_2 %340 = OpConstantComposite %338 %339 
					UniformConstant read_only Texture2D* %344 = OpVariable UniformConstant 
					                                     %354 = OpTypePointer Output %7 
					                       Output f32_4* %355 = OpVariable Output 
					                               f32_2 %361 = OpConstantComposite %32 %32 
					                               f32_2 %413 = OpConstantComposite %118 %117 
					                       Private bool* %482 = OpVariable Private 
					                               f32_2 %512 = OpConstantComposite %32 %232 
					                                     %526 = OpTypePointer Private %20 
					                      Private f32_2* %527 = OpVariable Private 
					                               i32_2 %578 = OpConstantComposite %112 %305 
					                      Private f32_2* %582 = OpVariable Private 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                  read_only Texture2D %13 = OpLoad %12 
					                              sampler %17 = OpLoad %16 
					           read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                f32_2 %23 = OpLoad vs_TEXCOORD0 
					                                f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                f32_2 %25 = OpVectorShuffle %24 %24 0 1 
					                                f32_4 %26 = OpLoad %9 
					                                f32_4 %27 = OpVectorShuffle %26 %25 4 5 2 3 
					                                              OpStore %9 %27 
					                                f32_4 %34 = OpLoad %9 
					                                f32_4 %35 = OpVectorShuffle %34 %34 1 0 1 1 
					                               bool_4 %37 = OpFOrdLessThan %33 %35 
					                               bool_2 %38 = OpVectorShuffle %37 %37 0 1 
					                                              OpStore %31 %38 
					                        Private bool* %42 = OpAccessChain %31 %40 
					                                 bool %43 = OpLoad %42 
					                                              OpSelectionMerge %45 None 
					                                              OpBranchConditional %43 %44 %360 
					                                      %44 = OpLabel 
					                                f32_4 %49 = OpLoad vs_TEXCOORD2 
					                                f32_2 %50 = OpVectorShuffle %49 %49 0 1 
					                                f32_4 %51 = OpLoad %46 
					                                f32_4 %52 = OpVectorShuffle %51 %50 4 5 2 3 
					                                              OpStore %46 %52 
					                         Private f32* %56 = OpAccessChain %46 %54 
					                                              OpStore %56 %53 
					                         Private f32* %60 = OpAccessChain %59 %40 
					                                              OpStore %60 %32 
					                                              OpBranch %61 
					                                      %61 = OpLabel 
					                                              OpLoopMerge %63 %64 None 
					                                              OpBranch %65 
					                                      %65 = OpLabel 
					                                              OpBranchConditional %66 %62 %63 
					                                      %62 = OpLabel 
					                           Input f32* %69 = OpAccessChain vs_TEXCOORD4 %40 
					                                  f32 %70 = OpLoad %69 
					                         Private f32* %71 = OpAccessChain %46 %40 
					                                  f32 %72 = OpLoad %71 
					                                 bool %73 = OpFOrdLessThan %70 %72 
					                        Private bool* %74 = OpAccessChain %31 %40 
					                                              OpStore %74 %73 
					                         Private f32* %77 = OpAccessChain %46 %54 
					                                  f32 %78 = OpLoad %77 
					                                 bool %79 = OpFOrdLessThan %76 %78 
					                                              OpStore %75 %79 
					                                 bool %80 = OpLoad %75 
					                        Private bool* %81 = OpAccessChain %31 %40 
					                                 bool %82 = OpLoad %81 
					                                 bool %83 = OpLogicalAnd %80 %82 
					                        Private bool* %84 = OpAccessChain %31 %40 
					                                              OpStore %84 %83 
					                         Private f32* %85 = OpAccessChain %59 %40 
					                                  f32 %86 = OpLoad %85 
					                                 bool %87 = OpFOrdEqual %86 %32 
					                                              OpStore %75 %87 
					                                 bool %88 = OpLoad %75 
					                        Private bool* %89 = OpAccessChain %31 %40 
					                                 bool %90 = OpLoad %89 
					                                 bool %91 = OpLogicalAnd %88 %90 
					                        Private bool* %92 = OpAccessChain %31 %40 
					                                              OpStore %92 %91 
					                        Private bool* %93 = OpAccessChain %31 %40 
					                                 bool %94 = OpLoad %93 
					                                 bool %95 = OpLogicalNot %94 
					                                              OpSelectionMerge %97 None 
					                                              OpBranchConditional %95 %96 %97 
					                                      %96 = OpLabel 
					                                              OpBranch %63 
					                                      %97 = OpLabel 
					                  read_only Texture2D %99 = OpLoad %12 
					                             sampler %100 = OpLoad %16 
					          read_only Texture2DSampled %101 = OpSampledImage %99 %100 
					                               f32_4 %102 = OpLoad %46 
					                               f32_2 %103 = OpVectorShuffle %102 %102 0 1 
					                               f32_4 %104 = OpImageSampleExplicitLod %101 %103 Lod %7 
					                               f32_2 %105 = OpVectorShuffle %104 %104 0 1 
					                               f32_3 %106 = OpLoad %59 
					                               f32_3 %107 = OpVectorShuffle %106 %105 3 4 2 
					                                              OpStore %59 %107 
					                      Uniform f32_4* %114 = OpAccessChain %110 %112 
					                               f32_4 %115 = OpLoad %114 
					                               f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                               f32_2 %120 = OpFMul %116 %119 
					                               f32_4 %121 = OpLoad %46 
					                               f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                               f32_2 %123 = OpFAdd %120 %122 
					                               f32_4 %124 = OpLoad %46 
					                               f32_4 %125 = OpVectorShuffle %124 %123 4 5 2 3 
					                                              OpStore %46 %125 
					                        Private f32* %127 = OpAccessChain %59 %126 
					                                 f32 %128 = OpLoad %127 
					                        Private f32* %129 = OpAccessChain %46 %54 
					                                              OpStore %129 %128 
					                                              OpBranch %64 
					                                      %64 = OpLabel 
					                                              OpBranch %61 
					                                      %63 = OpLabel 
					                               f32_4 %130 = OpLoad %46 
					                               f32_2 %131 = OpVectorShuffle %130 %130 0 2 
					                               f32_3 %132 = OpLoad %59 
					                               f32_3 %133 = OpVectorShuffle %132 %131 0 3 4 
					                                              OpStore %59 %133 
					                               f32_3 %134 = OpLoad %59 
					                               f32_2 %135 = OpVectorShuffle %134 %134 0 2 
					                               f32_2 %138 = OpFMul %135 %137 
					                               f32_2 %142 = OpFAdd %138 %141 
					                               f32_4 %143 = OpLoad %9 
					                               f32_4 %144 = OpVectorShuffle %143 %142 4 1 5 3 
					                                              OpStore %9 %144 
					                 read_only Texture2D %146 = OpLoad %145 
					                             sampler %147 = OpLoad %16 
					          read_only Texture2DSampled %148 = OpSampledImage %146 %147 
					                               f32_4 %149 = OpLoad %9 
					                               f32_2 %150 = OpVectorShuffle %149 %149 0 2 
					                               f32_4 %151 = OpImageSampleExplicitLod %148 %150 Lod %7 
					                                 f32 %153 = OpCompositeExtract %151 3 
					                        Private f32* %154 = OpAccessChain %9 %40 
					                                              OpStore %154 %153 
					                        Private f32* %155 = OpAccessChain %9 %40 
					                                 f32 %156 = OpLoad %155 
					                                 f32 %158 = OpFMul %156 %157 
					                                 f32 %160 = OpFAdd %158 %159 
					                        Private f32* %161 = OpAccessChain %9 %40 
					                                              OpStore %161 %160 
					                        Uniform f32* %163 = OpAccessChain %110 %112 %40 
					                                 f32 %164 = OpLoad %163 
					                        Private f32* %165 = OpAccessChain %9 %40 
					                                 f32 %166 = OpLoad %165 
					                                 f32 %167 = OpFMul %164 %166 
					                        Private f32* %168 = OpAccessChain %59 %126 
					                                 f32 %169 = OpLoad %168 
					                                 f32 %170 = OpFAdd %167 %169 
					                        Private f32* %171 = OpAccessChain %46 %40 
					                                              OpStore %171 %170 
					                          Input f32* %173 = OpAccessChain vs_TEXCOORD3 %126 
					                                 f32 %174 = OpLoad %173 
					                        Private f32* %175 = OpAccessChain %46 %126 
					                                              OpStore %175 %174 
					                 read_only Texture2D %176 = OpLoad %12 
					                             sampler %177 = OpLoad %16 
					          read_only Texture2DSampled %178 = OpSampledImage %176 %177 
					                               f32_4 %179 = OpLoad %46 
					                               f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                               f32_4 %181 = OpImageSampleExplicitLod %178 %180 Lod %7 
					                                 f32 %182 = OpCompositeExtract %181 0 
					                        Private f32* %183 = OpAccessChain %9 %40 
					                                              OpStore %183 %182 
					                               f32_4 %184 = OpLoad vs_TEXCOORD2 
					                               f32_2 %185 = OpVectorShuffle %184 %184 2 3 
					                               f32_3 %186 = OpLoad %59 
					                               f32_3 %187 = OpVectorShuffle %186 %185 3 4 2 
					                                              OpStore %59 %187 
					                        Private f32* %188 = OpAccessChain %59 %54 
					                                              OpStore %188 %53 
					                        Private f32* %190 = OpAccessChain %189 %40 
					                                              OpStore %190 %32 
					                                              OpBranch %191 
					                                     %191 = OpLabel 
					                                              OpLoopMerge %193 %194 None 
					                                              OpBranch %195 
					                                     %195 = OpLabel 
					                                              OpBranchConditional %66 %192 %193 
					                                     %192 = OpLabel 
					                        Private f32* %197 = OpAccessChain %59 %40 
					                                 f32 %198 = OpLoad %197 
					                          Input f32* %199 = OpAccessChain vs_TEXCOORD4 %126 
					                                 f32 %200 = OpLoad %199 
					                                bool %201 = OpFOrdLessThan %198 %200 
					                                              OpStore %196 %201 
					                        Private f32* %203 = OpAccessChain %59 %54 
					                                 f32 %204 = OpLoad %203 
					                                bool %205 = OpFOrdLessThan %76 %204 
					                                              OpStore %202 %205 
					                                bool %206 = OpLoad %196 
					                                bool %207 = OpLoad %202 
					                                bool %208 = OpLogicalAnd %206 %207 
					                                              OpStore %196 %208 
					                        Private f32* %209 = OpAccessChain %189 %40 
					                                 f32 %210 = OpLoad %209 
					                                bool %211 = OpFOrdEqual %210 %32 
					                                              OpStore %202 %211 
					                                bool %212 = OpLoad %196 
					                                bool %213 = OpLoad %202 
					                                bool %214 = OpLogicalAnd %212 %213 
					                                              OpStore %196 %214 
					                                bool %215 = OpLoad %196 
					                                bool %216 = OpLogicalNot %215 
					                                              OpSelectionMerge %218 None 
					                                              OpBranchConditional %216 %217 %218 
					                                     %217 = OpLabel 
					                                              OpBranch %193 
					                                     %218 = OpLabel 
					                 read_only Texture2D %220 = OpLoad %12 
					                             sampler %221 = OpLoad %16 
					          read_only Texture2DSampled %222 = OpSampledImage %220 %221 
					                               f32_3 %223 = OpLoad %59 
					                               f32_2 %224 = OpVectorShuffle %223 %223 0 1 
					                               f32_4 %225 = OpImageSampleExplicitLod %222 %224 Lod %7 
					                               f32_2 %226 = OpVectorShuffle %225 %225 0 1 
					                               f32_3 %227 = OpLoad %189 
					                               f32_3 %228 = OpVectorShuffle %227 %226 3 4 2 
					                                              OpStore %189 %228 
					                      Uniform f32_4* %229 = OpAccessChain %110 %112 
					                               f32_4 %230 = OpLoad %229 
					                               f32_2 %231 = OpVectorShuffle %230 %230 0 1 
					                               f32_2 %234 = OpFMul %231 %233 
					                               f32_3 %235 = OpLoad %59 
					                               f32_2 %236 = OpVectorShuffle %235 %235 0 1 
					                               f32_2 %237 = OpFAdd %234 %236 
					                               f32_3 %238 = OpLoad %59 
					                               f32_3 %239 = OpVectorShuffle %238 %237 3 4 2 
					                                              OpStore %59 %239 
					                        Private f32* %240 = OpAccessChain %189 %126 
					                                 f32 %241 = OpLoad %240 
					                        Private f32* %242 = OpAccessChain %59 %54 
					                                              OpStore %242 %241 
					                                              OpBranch %194 
					                                     %194 = OpLabel 
					                                              OpBranch %191 
					                                     %193 = OpLabel 
					                               f32_3 %243 = OpLoad %59 
					                               f32_2 %244 = OpVectorShuffle %243 %243 0 2 
					                               f32_3 %245 = OpLoad %189 
					                               f32_3 %246 = OpVectorShuffle %245 %244 0 3 4 
					                                              OpStore %189 %246 
					                               f32_3 %247 = OpLoad %189 
					                               f32_2 %248 = OpVectorShuffle %247 %247 0 2 
					                               f32_2 %249 = OpFMul %248 %137 
					                               f32_2 %252 = OpFAdd %249 %251 
					                               f32_3 %253 = OpLoad %59 
					                               f32_3 %254 = OpVectorShuffle %253 %252 3 4 2 
					                                              OpStore %59 %254 
					                 read_only Texture2D %256 = OpLoad %145 
					                             sampler %257 = OpLoad %16 
					          read_only Texture2DSampled %258 = OpSampledImage %256 %257 
					                               f32_3 %259 = OpLoad %59 
					                               f32_2 %260 = OpVectorShuffle %259 %259 0 1 
					                               f32_4 %261 = OpImageSampleExplicitLod %258 %260 Lod %7 
					                                 f32 %262 = OpCompositeExtract %261 3 
					                                              OpStore %255 %262 
					                                 f32 %263 = OpLoad %255 
					                                 f32 %264 = OpFMul %263 %157 
					                                 f32 %265 = OpFAdd %264 %159 
					                                              OpStore %255 %265 
					                        Uniform f32* %266 = OpAccessChain %110 %112 %40 
					                                 f32 %267 = OpLoad %266 
					                                 f32 %268 = OpFNegate %267 
					                                 f32 %269 = OpLoad %255 
					                                 f32 %270 = OpFMul %268 %269 
					                        Private f32* %271 = OpAccessChain %189 %126 
					                                 f32 %272 = OpLoad %271 
					                                 f32 %273 = OpFAdd %270 %272 
					                        Private f32* %274 = OpAccessChain %46 %54 
					                                              OpStore %274 %273 
					                      Uniform f32_4* %275 = OpAccessChain %110 %112 
					                               f32_4 %276 = OpLoad %275 
					                               f32_2 %277 = OpVectorShuffle %276 %276 2 2 
					                               f32_4 %278 = OpLoad %46 
					                               f32_2 %279 = OpVectorShuffle %278 %278 0 2 
					                               f32_2 %280 = OpFMul %277 %279 
					                               f32_2 %282 = OpLoad vs_TEXCOORD1 
					                               f32_2 %283 = OpVectorShuffle %282 %282 0 0 
					                               f32_2 %284 = OpFNegate %283 
					                               f32_2 %285 = OpFAdd %280 %284 
					                               f32_4 %286 = OpLoad %46 
					                               f32_4 %287 = OpVectorShuffle %286 %285 4 1 2 5 
					                                              OpStore %46 %287 
					                               f32_4 %288 = OpLoad %46 
					                               f32_2 %289 = OpVectorShuffle %288 %288 0 3 
					                               f32_2 %290 = OpExtInst %1 2 %289 
					                               f32_4 %291 = OpLoad %46 
					                               f32_4 %292 = OpVectorShuffle %291 %290 4 1 2 5 
					                                              OpStore %46 %292 
					                               f32_4 %293 = OpLoad %46 
					                               f32_2 %294 = OpVectorShuffle %293 %293 0 3 
					                               f32_2 %295 = OpExtInst %1 4 %294 
					                               f32_2 %296 = OpExtInst %1 31 %295 
					                               f32_4 %297 = OpLoad %46 
					                               f32_4 %298 = OpVectorShuffle %297 %296 4 1 2 5 
					                                              OpStore %46 %298 
					                 read_only Texture2D %299 = OpLoad %12 
					                             sampler %300 = OpLoad %16 
					          read_only Texture2DSampled %301 = OpSampledImage %299 %300 
					                               f32_4 %302 = OpLoad %46 
					                               f32_2 %303 = OpVectorShuffle %302 %302 2 1 
					                               f32_4 %307 = OpImageSampleExplicitLod %301 %303 Lod %7ConstOffset %307 
					                                 f32 %308 = OpCompositeExtract %307 0 
					                        Private f32* %309 = OpAccessChain %9 %54 
					                                              OpStore %309 %308 
					                               f32_4 %310 = OpLoad %9 
					                               f32_2 %311 = OpVectorShuffle %310 %310 0 2 
					                               f32_2 %314 = OpFMul %311 %313 
					                               f32_4 %315 = OpLoad %9 
					                               f32_4 %316 = OpVectorShuffle %315 %314 4 1 5 3 
					                                              OpStore %9 %316 
					                               f32_4 %317 = OpLoad %9 
					                               f32_2 %318 = OpVectorShuffle %317 %317 0 2 
					                               f32_2 %319 = OpExtInst %1 2 %318 
					                               f32_4 %320 = OpLoad %9 
					                               f32_4 %321 = OpVectorShuffle %320 %319 4 1 5 3 
					                                              OpStore %9 %321 
					                               f32_4 %322 = OpLoad %9 
					                               f32_2 %323 = OpVectorShuffle %322 %322 0 2 
					                               f32_2 %326 = OpFMul %323 %325 
					                               f32_4 %327 = OpLoad %46 
					                               f32_2 %328 = OpVectorShuffle %327 %327 0 3 
					                               f32_2 %329 = OpFAdd %326 %328 
					                               f32_4 %330 = OpLoad %9 
					                               f32_4 %331 = OpVectorShuffle %330 %329 4 1 5 3 
					                                              OpStore %9 %331 
					                               f32_4 %332 = OpLoad %9 
					                               f32_2 %333 = OpVectorShuffle %332 %332 0 2 
					                               f32_2 %337 = OpFMul %333 %336 
					                               f32_2 %341 = OpFAdd %337 %340 
					                               f32_4 %342 = OpLoad %9 
					                               f32_4 %343 = OpVectorShuffle %342 %341 4 1 5 3 
					                                              OpStore %9 %343 
					                 read_only Texture2D %345 = OpLoad %344 
					                             sampler %346 = OpLoad %16 
					          read_only Texture2DSampled %347 = OpSampledImage %345 %346 
					                               f32_4 %348 = OpLoad %9 
					                               f32_2 %349 = OpVectorShuffle %348 %348 0 2 
					                               f32_4 %350 = OpImageSampleExplicitLod %347 %349 Lod %7 
					                               f32_2 %351 = OpVectorShuffle %350 %350 0 1 
					                               f32_4 %352 = OpLoad %9 
					                               f32_4 %353 = OpVectorShuffle %352 %351 4 1 5 3 
					                                              OpStore %9 %353 
					                               f32_4 %356 = OpLoad %9 
					                               f32_2 %357 = OpVectorShuffle %356 %356 0 2 
					                               f32_4 %358 = OpLoad %355 
					                               f32_4 %359 = OpVectorShuffle %358 %357 4 5 2 3 
					                                              OpStore %355 %359 
					                                              OpBranch %45 
					                                     %360 = OpLabel 
					                               f32_4 %362 = OpLoad %355 
					                               f32_4 %363 = OpVectorShuffle %362 %361 4 5 2 3 
					                                              OpStore %355 %363 
					                                              OpBranch %45 
					                                      %45 = OpLabel 
					                       Private bool* %364 = OpAccessChain %31 %126 
					                                bool %365 = OpLoad %364 
					                                              OpSelectionMerge %367 None 
					                                              OpBranchConditional %365 %366 %614 
					                                     %366 = OpLabel 
					                               f32_4 %368 = OpLoad vs_TEXCOORD3 
					                               f32_2 %369 = OpVectorShuffle %368 %368 0 1 
					                               f32_4 %370 = OpLoad %9 
					                               f32_4 %371 = OpVectorShuffle %370 %369 4 5 2 3 
					                                              OpStore %9 %371 
					                        Private f32* %372 = OpAccessChain %9 %54 
					                                              OpStore %372 %53 
					                        Private f32* %373 = OpAccessChain %46 %40 
					                                              OpStore %373 %32 
					                                              OpBranch %374 
					                                     %374 = OpLabel 
					                                              OpLoopMerge %376 %377 None 
					                                              OpBranch %378 
					                                     %378 = OpLabel 
					                                              OpBranchConditional %66 %375 %376 
					                                     %375 = OpLabel 
					                          Input f32* %379 = OpAccessChain vs_TEXCOORD4 %54 
					                                 f32 %380 = OpLoad %379 
					                        Private f32* %381 = OpAccessChain %9 %126 
					                                 f32 %382 = OpLoad %381 
					                                bool %383 = OpFOrdLessThan %380 %382 
					                                              OpStore %196 %383 
					                        Private f32* %384 = OpAccessChain %9 %54 
					                                 f32 %385 = OpLoad %384 
					                                bool %386 = OpFOrdLessThan %76 %385 
					                                              OpStore %202 %386 
					                                bool %387 = OpLoad %196 
					                                bool %388 = OpLoad %202 
					                                bool %389 = OpLogicalAnd %387 %388 
					                                              OpStore %196 %389 
					                        Private f32* %390 = OpAccessChain %46 %40 
					                                 f32 %391 = OpLoad %390 
					                                bool %392 = OpFOrdEqual %391 %32 
					                                              OpStore %202 %392 
					                                bool %393 = OpLoad %196 
					                                bool %394 = OpLoad %202 
					                                bool %395 = OpLogicalAnd %393 %394 
					                                              OpStore %196 %395 
					                                bool %396 = OpLoad %196 
					                                bool %397 = OpLogicalNot %396 
					                                              OpSelectionMerge %399 None 
					                                              OpBranchConditional %397 %398 %399 
					                                     %398 = OpLabel 
					                                              OpBranch %376 
					                                     %399 = OpLabel 
					                 read_only Texture2D %401 = OpLoad %12 
					                             sampler %402 = OpLoad %16 
					          read_only Texture2DSampled %403 = OpSampledImage %401 %402 
					                               f32_4 %404 = OpLoad %9 
					                               f32_2 %405 = OpVectorShuffle %404 %404 0 1 
					                               f32_4 %406 = OpImageSampleExplicitLod %403 %405 Lod %7 
					                               f32_2 %407 = OpVectorShuffle %406 %406 1 0 
					                               f32_4 %408 = OpLoad %46 
					                               f32_4 %409 = OpVectorShuffle %408 %407 4 5 2 3 
					                                              OpStore %46 %409 
					                      Uniform f32_4* %410 = OpAccessChain %110 %112 
					                               f32_4 %411 = OpLoad %410 
					                               f32_2 %412 = OpVectorShuffle %411 %411 0 1 
					                               f32_2 %414 = OpFMul %412 %413 
					                               f32_4 %415 = OpLoad %9 
					                               f32_2 %416 = OpVectorShuffle %415 %415 0 1 
					                               f32_2 %417 = OpFAdd %414 %416 
					                               f32_4 %418 = OpLoad %9 
					                               f32_4 %419 = OpVectorShuffle %418 %417 4 5 2 3 
					                                              OpStore %9 %419 
					                        Private f32* %420 = OpAccessChain %46 %126 
					                                 f32 %421 = OpLoad %420 
					                        Private f32* %422 = OpAccessChain %9 %54 
					                                              OpStore %422 %421 
					                                              OpBranch %377 
					                                     %377 = OpLabel 
					                                              OpBranch %374 
					                                     %376 = OpLabel 
					                               f32_4 %423 = OpLoad %9 
					                               f32_2 %424 = OpVectorShuffle %423 %423 1 2 
					                               f32_4 %425 = OpLoad %46 
					                               f32_4 %426 = OpVectorShuffle %425 %424 0 4 5 3 
					                                              OpStore %46 %426 
					                               f32_4 %427 = OpLoad %46 
					                               f32_2 %428 = OpVectorShuffle %427 %427 0 2 
					                               f32_2 %429 = OpFMul %428 %137 
					                               f32_2 %430 = OpFAdd %429 %141 
					                               f32_4 %431 = OpLoad %9 
					                               f32_4 %432 = OpVectorShuffle %431 %430 4 5 2 3 
					                                              OpStore %9 %432 
					                 read_only Texture2D %433 = OpLoad %145 
					                             sampler %434 = OpLoad %16 
					          read_only Texture2DSampled %435 = OpSampledImage %433 %434 
					                               f32_4 %436 = OpLoad %9 
					                               f32_2 %437 = OpVectorShuffle %436 %436 0 1 
					                               f32_4 %438 = OpImageSampleExplicitLod %435 %437 Lod %7 
					                                 f32 %439 = OpCompositeExtract %438 3 
					                        Private f32* %440 = OpAccessChain %9 %40 
					                                              OpStore %440 %439 
					                        Private f32* %441 = OpAccessChain %9 %40 
					                                 f32 %442 = OpLoad %441 
					                                 f32 %443 = OpFMul %442 %157 
					                                 f32 %444 = OpFAdd %443 %159 
					                        Private f32* %445 = OpAccessChain %9 %40 
					                                              OpStore %445 %444 
					                        Uniform f32* %446 = OpAccessChain %110 %112 %126 
					                                 f32 %447 = OpLoad %446 
					                        Private f32* %448 = OpAccessChain %9 %40 
					                                 f32 %449 = OpLoad %448 
					                                 f32 %450 = OpFMul %447 %449 
					                        Private f32* %451 = OpAccessChain %46 %126 
					                                 f32 %452 = OpLoad %451 
					                                 f32 %453 = OpFAdd %450 %452 
					                        Private f32* %454 = OpAccessChain %9 %40 
					                                              OpStore %454 %453 
					                          Input f32* %455 = OpAccessChain vs_TEXCOORD2 %40 
					                                 f32 %456 = OpLoad %455 
					                        Private f32* %457 = OpAccessChain %9 %126 
					                                              OpStore %457 %456 
					                 read_only Texture2D %458 = OpLoad %12 
					                             sampler %459 = OpLoad %16 
					          read_only Texture2DSampled %460 = OpSampledImage %458 %459 
					                               f32_4 %461 = OpLoad %9 
					                               f32_2 %462 = OpVectorShuffle %461 %461 1 0 
					                               f32_4 %463 = OpImageSampleExplicitLod %460 %462 Lod %7 
					                                 f32 %464 = OpCompositeExtract %463 1 
					                        Private f32* %465 = OpAccessChain %46 %40 
					                                              OpStore %465 %464 
					                               f32_4 %466 = OpLoad vs_TEXCOORD3 
					                               f32_2 %467 = OpVectorShuffle %466 %466 2 3 
					                               f32_3 %468 = OpLoad %59 
					                               f32_3 %469 = OpVectorShuffle %468 %467 3 4 2 
					                                              OpStore %59 %469 
					                        Private f32* %470 = OpAccessChain %59 %54 
					                                              OpStore %470 %53 
					                        Private f32* %471 = OpAccessChain %189 %40 
					                                              OpStore %471 %32 
					                                              OpBranch %472 
					                                     %472 = OpLabel 
					                                              OpLoopMerge %474 %475 None 
					                                              OpBranch %476 
					                                     %476 = OpLabel 
					                                              OpBranchConditional %66 %473 %474 
					                                     %473 = OpLabel 
					                        Private f32* %477 = OpAccessChain %59 %126 
					                                 f32 %478 = OpLoad %477 
					                          Input f32* %479 = OpAccessChain vs_TEXCOORD4 %152 
					                                 f32 %480 = OpLoad %479 
					                                bool %481 = OpFOrdLessThan %478 %480 
					                                              OpStore %196 %481 
					                        Private f32* %483 = OpAccessChain %59 %54 
					                                 f32 %484 = OpLoad %483 
					                                bool %485 = OpFOrdLessThan %76 %484 
					                                              OpStore %482 %485 
					                                bool %486 = OpLoad %196 
					                                bool %487 = OpLoad %482 
					                                bool %488 = OpLogicalAnd %486 %487 
					                                              OpStore %196 %488 
					                        Private f32* %489 = OpAccessChain %189 %40 
					                                 f32 %490 = OpLoad %489 
					                                bool %491 = OpFOrdEqual %490 %32 
					                                              OpStore %482 %491 
					                                bool %492 = OpLoad %196 
					                                bool %493 = OpLoad %482 
					                                bool %494 = OpLogicalAnd %492 %493 
					                                              OpStore %196 %494 
					                                bool %495 = OpLoad %196 
					                                bool %496 = OpLogicalNot %495 
					                                              OpSelectionMerge %498 None 
					                                              OpBranchConditional %496 %497 %498 
					                                     %497 = OpLabel 
					                                              OpBranch %474 
					                                     %498 = OpLabel 
					                 read_only Texture2D %500 = OpLoad %12 
					                             sampler %501 = OpLoad %16 
					          read_only Texture2DSampled %502 = OpSampledImage %500 %501 
					                               f32_3 %503 = OpLoad %59 
					                               f32_2 %504 = OpVectorShuffle %503 %503 0 1 
					                               f32_4 %505 = OpImageSampleExplicitLod %502 %504 Lod %7 
					                               f32_2 %506 = OpVectorShuffle %505 %505 1 0 
					                               f32_3 %507 = OpLoad %189 
					                               f32_3 %508 = OpVectorShuffle %507 %506 3 4 2 
					                                              OpStore %189 %508 
					                      Uniform f32_4* %509 = OpAccessChain %110 %112 
					                               f32_4 %510 = OpLoad %509 
					                               f32_2 %511 = OpVectorShuffle %510 %510 0 1 
					                               f32_2 %513 = OpFMul %511 %512 
					                               f32_3 %514 = OpLoad %59 
					                               f32_2 %515 = OpVectorShuffle %514 %514 0 1 
					                               f32_2 %516 = OpFAdd %513 %515 
					                               f32_3 %517 = OpLoad %59 
					                               f32_3 %518 = OpVectorShuffle %517 %516 3 4 2 
					                                              OpStore %59 %518 
					                        Private f32* %519 = OpAccessChain %189 %126 
					                                 f32 %520 = OpLoad %519 
					                        Private f32* %521 = OpAccessChain %59 %54 
					                                              OpStore %521 %520 
					                                              OpBranch %475 
					                                     %475 = OpLabel 
					                                              OpBranch %472 
					                                     %474 = OpLabel 
					                               f32_3 %522 = OpLoad %59 
					                               f32_2 %523 = OpVectorShuffle %522 %522 1 2 
					                               f32_3 %524 = OpLoad %189 
					                               f32_3 %525 = OpVectorShuffle %524 %523 0 3 4 
					                                              OpStore %189 %525 
					                               f32_3 %528 = OpLoad %189 
					                               f32_2 %529 = OpVectorShuffle %528 %528 0 2 
					                               f32_2 %530 = OpFMul %529 %137 
					                               f32_2 %531 = OpFAdd %530 %251 
					                                              OpStore %527 %531 
					                 read_only Texture2D %532 = OpLoad %145 
					                             sampler %533 = OpLoad %16 
					          read_only Texture2DSampled %534 = OpSampledImage %532 %533 
					                               f32_2 %535 = OpLoad %527 
					                               f32_4 %536 = OpImageSampleExplicitLod %534 %535 Lod %7 
					                                 f32 %537 = OpCompositeExtract %536 3 
					                                              OpStore %255 %537 
					                                 f32 %538 = OpLoad %255 
					                                 f32 %539 = OpFMul %538 %157 
					                                 f32 %540 = OpFAdd %539 %159 
					                                              OpStore %255 %540 
					                        Uniform f32* %541 = OpAccessChain %110 %112 %126 
					                                 f32 %542 = OpLoad %541 
					                                 f32 %543 = OpFNegate %542 
					                                 f32 %544 = OpLoad %255 
					                                 f32 %545 = OpFMul %543 %544 
					                        Private f32* %546 = OpAccessChain %189 %126 
					                                 f32 %547 = OpLoad %546 
					                                 f32 %548 = OpFAdd %545 %547 
					                        Private f32* %549 = OpAccessChain %9 %54 
					                                              OpStore %549 %548 
					                      Uniform f32_4* %550 = OpAccessChain %110 %112 
					                               f32_4 %551 = OpLoad %550 
					                               f32_2 %552 = OpVectorShuffle %551 %551 3 3 
					                               f32_4 %553 = OpLoad %9 
					                               f32_2 %554 = OpVectorShuffle %553 %553 0 2 
					                               f32_2 %555 = OpFMul %552 %554 
					                               f32_2 %556 = OpLoad vs_TEXCOORD1 
					                               f32_2 %557 = OpVectorShuffle %556 %556 1 1 
					                               f32_2 %558 = OpFNegate %557 
					                               f32_2 %559 = OpFAdd %555 %558 
					                               f32_4 %560 = OpLoad %9 
					                               f32_4 %561 = OpVectorShuffle %560 %559 4 1 2 5 
					                                              OpStore %9 %561 
					                               f32_4 %562 = OpLoad %9 
					                               f32_2 %563 = OpVectorShuffle %562 %562 0 3 
					                               f32_2 %564 = OpExtInst %1 2 %563 
					                               f32_4 %565 = OpLoad %9 
					                               f32_4 %566 = OpVectorShuffle %565 %564 4 1 2 5 
					                                              OpStore %9 %566 
					                               f32_4 %567 = OpLoad %9 
					                               f32_2 %568 = OpVectorShuffle %567 %567 0 3 
					                               f32_2 %569 = OpExtInst %1 4 %568 
					                               f32_2 %570 = OpExtInst %1 31 %569 
					                               f32_4 %571 = OpLoad %9 
					                               f32_4 %572 = OpVectorShuffle %571 %570 4 1 2 5 
					                                              OpStore %9 %572 
					                 read_only Texture2D %573 = OpLoad %12 
					                             sampler %574 = OpLoad %16 
					          read_only Texture2DSampled %575 = OpSampledImage %573 %574 
					                               f32_4 %576 = OpLoad %9 
					                               f32_2 %577 = OpVectorShuffle %576 %576 1 2 
					                               f32_4 %579 = OpImageSampleExplicitLod %575 %577 Lod %7ConstOffset %579 
					                                 f32 %580 = OpCompositeExtract %579 1 
					                        Private f32* %581 = OpAccessChain %46 %126 
					                                              OpStore %581 %580 
					                               f32_4 %583 = OpLoad %46 
					                               f32_2 %584 = OpVectorShuffle %583 %583 0 1 
					                               f32_2 %585 = OpFMul %584 %313 
					                                              OpStore %582 %585 
					                               f32_2 %586 = OpLoad %582 
					                               f32_2 %587 = OpExtInst %1 2 %586 
					                                              OpStore %582 %587 
					                               f32_2 %588 = OpLoad %582 
					                               f32_2 %589 = OpFMul %588 %325 
					                               f32_4 %590 = OpLoad %9 
					                               f32_2 %591 = OpVectorShuffle %590 %590 0 3 
					                               f32_2 %592 = OpFAdd %589 %591 
					                               f32_4 %593 = OpLoad %9 
					                               f32_4 %594 = OpVectorShuffle %593 %592 4 5 2 3 
					                                              OpStore %9 %594 
					                               f32_4 %595 = OpLoad %9 
					                               f32_2 %596 = OpVectorShuffle %595 %595 0 1 
					                               f32_2 %597 = OpFMul %596 %336 
					                               f32_2 %598 = OpFAdd %597 %340 
					                               f32_4 %599 = OpLoad %9 
					                               f32_4 %600 = OpVectorShuffle %599 %598 4 5 2 3 
					                                              OpStore %9 %600 
					                 read_only Texture2D %601 = OpLoad %344 
					                             sampler %602 = OpLoad %16 
					          read_only Texture2DSampled %603 = OpSampledImage %601 %602 
					                               f32_4 %604 = OpLoad %9 
					                               f32_2 %605 = OpVectorShuffle %604 %604 0 1 
					                               f32_4 %606 = OpImageSampleExplicitLod %603 %605 Lod %7 
					                               f32_2 %607 = OpVectorShuffle %606 %606 0 1 
					                               f32_4 %608 = OpLoad %9 
					                               f32_4 %609 = OpVectorShuffle %608 %607 4 5 2 3 
					                                              OpStore %9 %609 
					                               f32_4 %610 = OpLoad %9 
					                               f32_2 %611 = OpVectorShuffle %610 %610 0 1 
					                               f32_4 %612 = OpLoad %355 
					                               f32_4 %613 = OpVectorShuffle %612 %611 0 1 4 5 
					                                              OpStore %355 %613 
					                                              OpBranch %367 
					                                     %614 = OpLabel 
					                               f32_4 %615 = OpLoad %355 
					                               f32_4 %616 = OpVectorShuffle %615 %361 0 1 4 5 
					                                              OpStore %355 %616 
					                                              OpBranch %367 
					                                     %367 = OpLabel 
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
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AreaTex;
					uniform  sampler2D _SearchTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					bool u_xlatb10;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.yxyy).xy;
					    if(u_xlatb0.x){
					        u_xlat1.xy = vs_TEXCOORD2.xy;
					        u_xlat1.z = 1.0;
					        u_xlat2.x = 0.0;
					        while(true){
					            u_xlatb0.x = vs_TEXCOORD4.x<u_xlat1.x;
					            u_xlatb10 = 0.828100026<u_xlat1.z;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            u_xlatb10 = u_xlat2.x==0.0;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            if(!u_xlatb0.x){break;}
					            u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					            u_xlat1.xy = _MainTex_TexelSize.xy * vec2(-2.0, -0.0) + u_xlat1.xy;
					            u_xlat1.z = u_xlat2.y;
					        }
					        u_xlat2.yz = u_xlat1.xz;
					        u_xlat0.xz = u_xlat2.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat1 = textureLod(_SearchTex, u_xlat0.xz, 0.0);
					        u_xlat0.x = u_xlat1.w * -2.00787401 + 3.25;
					        u_xlat1.x = _MainTex_TexelSize.x * u_xlat0.x + u_xlat2.y;
					        u_xlat1.y = vs_TEXCOORD3.y;
					        u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					        u_xlat3.xy = vs_TEXCOORD2.zw;
					        u_xlat3.z = 1.0;
					        u_xlat4.x = 0.0;
					        while(true){
					            u_xlatb0.x = u_xlat3.x<vs_TEXCOORD4.y;
					            u_xlatb10 = 0.828100026<u_xlat3.z;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            u_xlatb10 = u_xlat4.x==0.0;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            if(!u_xlatb0.x){break;}
					            u_xlat4 = textureLod(_MainTex, u_xlat3.xy, 0.0);
					            u_xlat3.xy = _MainTex_TexelSize.xy * vec2(2.0, 0.0) + u_xlat3.xy;
					            u_xlat3.z = u_xlat4.y;
					        }
					        u_xlat4.yz = u_xlat3.xz;
					        u_xlat0.xz = u_xlat4.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat3 = textureLod(_SearchTex, u_xlat0.xz, 0.0);
					        u_xlat0.x = u_xlat3.w * -2.00787401 + 3.25;
					        u_xlat1.z = (-_MainTex_TexelSize.x) * u_xlat0.x + u_xlat4.y;
					        u_xlat0.xz = _MainTex_TexelSize.zz * u_xlat1.xz + (-vs_TEXCOORD1.xx);
					        u_xlat0.xz = roundEven(u_xlat0.xz);
					        u_xlat0.xz = sqrt(abs(u_xlat0.xz));
					        u_xlat1 = textureLodOffset(_MainTex, u_xlat1.zy, 0.0, ivec2(1, 0)).yxzw;
					        u_xlat1.x = u_xlat2.x;
					        u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
					        u_xlat1.xy = roundEven(u_xlat1.xy);
					        u_xlat0.xz = u_xlat1.xy * vec2(16.0, 16.0) + u_xlat0.xz;
					        u_xlat0.xz = u_xlat0.xz * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat1 = textureLod(_AreaTex, u_xlat0.xz, 0.0);
					        SV_Target0.xy = u_xlat1.xy;
					    } else {
					        SV_Target0.xy = vec2(0.0, 0.0);
					    }
					    if(u_xlatb0.y){
					        u_xlat0.xy = vs_TEXCOORD3.xy;
					        u_xlat0.z = 1.0;
					        u_xlat1.x = 0.0;
					        while(true){
					            u_xlatb15 = vs_TEXCOORD4.z<u_xlat0.y;
					            u_xlatb2 = 0.828100026<u_xlat0.z;
					            u_xlatb15 = u_xlatb15 && u_xlatb2;
					            u_xlatb2 = u_xlat1.x==0.0;
					            u_xlatb15 = u_xlatb15 && u_xlatb2;
					            if(!u_xlatb15){break;}
					            u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0).yxzw;
					            u_xlat0.xy = _MainTex_TexelSize.xy * vec2(-0.0, -2.0) + u_xlat0.xy;
					            u_xlat0.z = u_xlat1.y;
					        }
					        u_xlat1.yz = u_xlat0.yz;
					        u_xlat0.xy = u_xlat1.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat0 = textureLod(_SearchTex, u_xlat0.xy, 0.0);
					        u_xlat0.x = u_xlat0.w * -2.00787401 + 3.25;
					        u_xlat0.x = _MainTex_TexelSize.y * u_xlat0.x + u_xlat1.y;
					        u_xlat0.y = vs_TEXCOORD2.x;
					        u_xlat1 = textureLod(_MainTex, u_xlat0.yx, 0.0);
					        u_xlat2.xy = vs_TEXCOORD3.zw;
					        u_xlat2.z = 1.0;
					        u_xlat3.x = 0.0;
					        while(true){
					            u_xlatb15 = u_xlat2.y<vs_TEXCOORD4.w;
					            u_xlatb1 = 0.828100026<u_xlat2.z;
					            u_xlatb15 = u_xlatb15 && u_xlatb1;
					            u_xlatb1 = u_xlat3.x==0.0;
					            u_xlatb15 = u_xlatb15 && u_xlatb1;
					            if(!u_xlatb15){break;}
					            u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0).yxzw;
					            u_xlat2.xy = _MainTex_TexelSize.xy * vec2(0.0, 2.0) + u_xlat2.xy;
					            u_xlat2.z = u_xlat3.y;
					        }
					        u_xlat3.yz = u_xlat2.yz;
					        u_xlat1.xz = u_xlat3.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat2 = textureLod(_SearchTex, u_xlat1.xz, 0.0);
					        u_xlat15 = u_xlat2.w * -2.00787401 + 3.25;
					        u_xlat0.z = (-_MainTex_TexelSize.y) * u_xlat15 + u_xlat3.y;
					        u_xlat0.xw = _MainTex_TexelSize.ww * u_xlat0.xz + (-vs_TEXCOORD1.yy);
					        u_xlat0.xw = roundEven(u_xlat0.xw);
					        u_xlat0.xw = sqrt(abs(u_xlat0.xw));
					        u_xlat2 = textureLodOffset(_MainTex, u_xlat0.yz, 0.0, ivec2(0, 1));
					        u_xlat2.x = u_xlat1.y;
					        u_xlat5.xy = u_xlat2.xy * vec2(4.0, 4.0);
					        u_xlat5.xy = roundEven(u_xlat5.xy);
					        u_xlat0.xy = u_xlat5.xy * vec2(16.0, 16.0) + u_xlat0.xw;
					        u_xlat0.xy = u_xlat0.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat0 = textureLod(_AreaTex, u_xlat0.xy, 0.0);
					        SV_Target0.zw = u_xlat0.xy;
					    } else {
					        SV_Target0.zw = vec2(0.0, 0.0);
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
			GpuProgramID 325746
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(0.5, -0.5, 0.5, -0.5) + vec4(0.0, 1.0, 0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.zw * _MainTex_TexelSize.zw;
					    u_xlat1 = _MainTex_TexelSize.xxyy * vec4(-0.25, 1.25, -0.125, -0.125) + u_xlat0.zzww;
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.125, -0.25, -0.125, 1.25) + u_xlat0;
					    vs_TEXCOORD2 = u_xlat1.xzyw;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat1.zw = u_xlat0.yw;
					    vs_TEXCOORD4 = _MainTex_TexelSize.xxyy * vec4(-16.0, 16.0, -16.0, 16.0) + u_xlat1;
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
					uniform 	vec4 _MainTex_TexelSize;
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(0.5, 0.5, 0.5, 0.5);
					    vs_TEXCOORD1.xy = u_xlat0.zw * _MainTex_TexelSize.zw;
					    u_xlat1 = _MainTex_TexelSize.xxyy * vec4(-0.25, 1.25, -0.125, -0.125) + u_xlat0.zzww;
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.125, -0.25, -0.125, 1.25) + u_xlat0;
					    vs_TEXCOORD2 = u_xlat1.xzyw;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat1.zw = u_xlat0.yw;
					    vs_TEXCOORD4 = _MainTex_TexelSize.xxyy * vec4(-16.0, 16.0, -16.0, 16.0) + u_xlat1;
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
					UNITY_LOCATION(1) uniform  sampler2D _SearchTex;
					UNITY_LOCATION(2) uniform  sampler2D _AreaTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					bool u_xlatb10;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.yxyy).xy;
					    if(u_xlatb0.x){
					        u_xlat1.xy = vs_TEXCOORD2.xy;
					        u_xlat1.z = 1.0;
					        u_xlat2.x = 0.0;
					        while(true){
					            u_xlatb0.x = vs_TEXCOORD4.x<u_xlat1.x;
					            u_xlatb10 = 0.828100026<u_xlat1.z;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            u_xlatb10 = u_xlat2.x==0.0;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            if(!u_xlatb0.x){break;}
					            u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					            u_xlat1.xy = _MainTex_TexelSize.xy * vec2(-2.0, -0.0) + u_xlat1.xy;
					            u_xlat1.z = u_xlat2.y;
					        }
					        u_xlat2.yz = u_xlat1.xz;
					        u_xlat0.xz = u_xlat2.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat1 = textureLod(_SearchTex, u_xlat0.xz, 0.0);
					        u_xlat0.x = u_xlat1.w * -2.00787401 + 3.25;
					        u_xlat1.x = _MainTex_TexelSize.x * u_xlat0.x + u_xlat2.y;
					        u_xlat1.y = vs_TEXCOORD3.y;
					        u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					        u_xlat3.xy = vs_TEXCOORD2.zw;
					        u_xlat3.z = 1.0;
					        u_xlat4.x = 0.0;
					        while(true){
					            u_xlatb0.x = u_xlat3.x<vs_TEXCOORD4.y;
					            u_xlatb10 = 0.828100026<u_xlat3.z;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            u_xlatb10 = u_xlat4.x==0.0;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            if(!u_xlatb0.x){break;}
					            u_xlat4 = textureLod(_MainTex, u_xlat3.xy, 0.0);
					            u_xlat3.xy = _MainTex_TexelSize.xy * vec2(2.0, 0.0) + u_xlat3.xy;
					            u_xlat3.z = u_xlat4.y;
					        }
					        u_xlat4.yz = u_xlat3.xz;
					        u_xlat0.xz = u_xlat4.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat3 = textureLod(_SearchTex, u_xlat0.xz, 0.0);
					        u_xlat0.x = u_xlat3.w * -2.00787401 + 3.25;
					        u_xlat1.z = (-_MainTex_TexelSize.x) * u_xlat0.x + u_xlat4.y;
					        u_xlat0.xz = _MainTex_TexelSize.zz * u_xlat1.xz + (-vs_TEXCOORD1.xx);
					        u_xlat0.xz = roundEven(u_xlat0.xz);
					        u_xlat0.xz = sqrt(abs(u_xlat0.xz));
					        u_xlat1.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0) + u_xlat1.zy;
					        u_xlat1 = textureLod(_MainTex, u_xlat1.xy, 0.0).yxzw;
					        u_xlat1.x = u_xlat2.x;
					        u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
					        u_xlat1.xy = roundEven(u_xlat1.xy);
					        u_xlat0.xz = u_xlat1.xy * vec2(16.0, 16.0) + u_xlat0.xz;
					        u_xlat0.xz = u_xlat0.xz * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat1 = textureLod(_AreaTex, u_xlat0.xz, 0.0);
					        SV_Target0.xy = u_xlat1.xy;
					    } else {
					        SV_Target0.xy = vec2(0.0, 0.0);
					    }
					    if(u_xlatb0.y){
					        u_xlat0.xy = vs_TEXCOORD3.xy;
					        u_xlat0.z = 1.0;
					        u_xlat1.x = 0.0;
					        while(true){
					            u_xlatb15 = vs_TEXCOORD4.z<u_xlat0.y;
					            u_xlatb2 = 0.828100026<u_xlat0.z;
					            u_xlatb15 = u_xlatb15 && u_xlatb2;
					            u_xlatb2 = u_xlat1.x==0.0;
					            u_xlatb15 = u_xlatb15 && u_xlatb2;
					            if(!u_xlatb15){break;}
					            u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0).yxzw;
					            u_xlat0.xy = _MainTex_TexelSize.xy * vec2(-0.0, -2.0) + u_xlat0.xy;
					            u_xlat0.z = u_xlat1.y;
					        }
					        u_xlat1.yz = u_xlat0.yz;
					        u_xlat0.xy = u_xlat1.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat0 = textureLod(_SearchTex, u_xlat0.xy, 0.0);
					        u_xlat0.x = u_xlat0.w * -2.00787401 + 3.25;
					        u_xlat0.x = _MainTex_TexelSize.y * u_xlat0.x + u_xlat1.y;
					        u_xlat0.y = vs_TEXCOORD2.x;
					        u_xlat1 = textureLod(_MainTex, u_xlat0.yx, 0.0);
					        u_xlat2.xy = vs_TEXCOORD3.zw;
					        u_xlat2.z = 1.0;
					        u_xlat3.x = 0.0;
					        while(true){
					            u_xlatb15 = u_xlat2.y<vs_TEXCOORD4.w;
					            u_xlatb1 = 0.828100026<u_xlat2.z;
					            u_xlatb15 = u_xlatb15 && u_xlatb1;
					            u_xlatb1 = u_xlat3.x==0.0;
					            u_xlatb15 = u_xlatb15 && u_xlatb1;
					            if(!u_xlatb15){break;}
					            u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0).yxzw;
					            u_xlat2.xy = _MainTex_TexelSize.xy * vec2(0.0, 2.0) + u_xlat2.xy;
					            u_xlat2.z = u_xlat3.y;
					        }
					        u_xlat3.yz = u_xlat2.yz;
					        u_xlat1.xz = u_xlat3.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat2 = textureLod(_SearchTex, u_xlat1.xz, 0.0);
					        u_xlat15 = u_xlat2.w * -2.00787401 + 3.25;
					        u_xlat0.z = (-_MainTex_TexelSize.y) * u_xlat15 + u_xlat3.y;
					        u_xlat0.xw = _MainTex_TexelSize.ww * u_xlat0.xz + (-vs_TEXCOORD1.yy);
					        u_xlat0.xw = roundEven(u_xlat0.xw);
					        u_xlat0.xw = sqrt(abs(u_xlat0.xw));
					        u_xlat5.xy = _MainTex_TexelSize.xy * vec2(0.0, 1.0) + u_xlat0.yz;
					        u_xlat2 = textureLod(_MainTex, u_xlat5.xy, 0.0);
					        u_xlat2.x = u_xlat1.y;
					        u_xlat5.xy = u_xlat2.xy * vec2(4.0, 4.0);
					        u_xlat5.xy = roundEven(u_xlat5.xy);
					        u_xlat0.xy = u_xlat5.xy * vec2(16.0, 16.0) + u_xlat0.xw;
					        u_xlat0.xy = u_xlat0.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat0 = textureLod(_AreaTex, u_xlat0.xy, 0.0);
					        SV_Target0.zw = u_xlat0.xy;
					    } else {
					        SV_Target0.zw = vec2(0.0, 0.0);
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
					; Bound: 108
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %33 %53 %83 %86 %92 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                             OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD0 Location 33 
					                                             OpDecorate vs_TEXCOORD1 Location 53 
					                                             OpMemberDecorate %56 0 Offset 56 
					                                             OpDecorate %56 Block 
					                                             OpDecorate %58 DescriptorSet 58 
					                                             OpDecorate %58 Binding 58 
					                                             OpDecorate vs_TEXCOORD2 Location 83 
					                                             OpDecorate vs_TEXCOORD3 Location 86 
					                                             OpDecorate vs_TEXCOORD4 Location 92 
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
					                                     %32 = OpTypePointer Output %19 
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                 f32 %36 = OpConstant 3,674022E-40 
					                                 f32 %37 = OpConstant 3,674022E-40 
					                               f32_2 %38 = OpConstantComposite %36 %37 
					                               f32_2 %40 = OpConstantComposite %36 %36 
					                                     %42 = OpTypePointer Private %7 
					                      Private f32_4* %43 = OpVariable Private 
					                               f32_4 %46 = OpConstantComposite %27 %27 %27 %27 
					                               f32_4 %49 = OpConstantComposite %36 %37 %36 %37 
					                               f32_4 %51 = OpConstantComposite %26 %27 %26 %27 
					              Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                     %56 = OpTypeStruct %7 
					                                     %57 = OpTypePointer Uniform %56 
					            Uniform struct {f32_4;}* %58 = OpVariable Uniform 
					                                     %59 = OpTypePointer Uniform %7 
					                      Private f32_4* %64 = OpVariable Private 
					                                 f32 %68 = OpConstant 3,674022E-40 
					                                 f32 %69 = OpConstant 3,674022E-40 
					                                 f32 %70 = OpConstant 3,674022E-40 
					                               f32_4 %71 = OpConstantComposite %68 %69 %70 %70 
					                               f32_4 %79 = OpConstantComposite %70 %68 %70 %69 
					              Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					              Output f32_4* vs_TEXCOORD3 = OpVariable Output 
					              Output f32_4* vs_TEXCOORD4 = OpVariable Output 
					                                 f32 %96 = OpConstant 3,674022E-40 
					                                 f32 %97 = OpConstant 3,674022E-40 
					                               f32_4 %98 = OpConstantComposite %96 %97 %96 %97 
					                                    %102 = OpTypePointer Output %6 
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
					                                             OpStore vs_TEXCOORD0 %41 
					                               f32_3 %44 = OpLoad %18 
					                               f32_4 %45 = OpVectorShuffle %44 %44 0 1 0 1 
					                               f32_4 %47 = OpFAdd %45 %46 
					                                             OpStore %43 %47 
					                               f32_4 %48 = OpLoad %43 
					                               f32_4 %50 = OpFMul %48 %49 
					                               f32_4 %52 = OpFAdd %50 %51 
					                                             OpStore %43 %52 
					                               f32_4 %54 = OpLoad %43 
					                               f32_2 %55 = OpVectorShuffle %54 %54 2 3 
					                      Uniform f32_4* %60 = OpAccessChain %58 %15 
					                               f32_4 %61 = OpLoad %60 
					                               f32_2 %62 = OpVectorShuffle %61 %61 2 3 
					                               f32_2 %63 = OpFMul %55 %62 
					                                             OpStore vs_TEXCOORD1 %63 
					                      Uniform f32_4* %65 = OpAccessChain %58 %15 
					                               f32_4 %66 = OpLoad %65 
					                               f32_4 %67 = OpVectorShuffle %66 %66 0 0 1 1 
					                               f32_4 %72 = OpFMul %67 %71 
					                               f32_4 %73 = OpLoad %43 
					                               f32_4 %74 = OpVectorShuffle %73 %73 2 2 3 3 
					                               f32_4 %75 = OpFAdd %72 %74 
					                                             OpStore %64 %75 
					                      Uniform f32_4* %76 = OpAccessChain %58 %15 
					                               f32_4 %77 = OpLoad %76 
					                               f32_4 %78 = OpVectorShuffle %77 %77 0 1 0 1 
					                               f32_4 %80 = OpFMul %78 %79 
					                               f32_4 %81 = OpLoad %43 
					                               f32_4 %82 = OpFAdd %80 %81 
					                                             OpStore %43 %82 
					                               f32_4 %84 = OpLoad %64 
					                               f32_4 %85 = OpVectorShuffle %84 %84 0 2 1 3 
					                                             OpStore vs_TEXCOORD2 %85 
					                               f32_4 %87 = OpLoad %43 
					                                             OpStore vs_TEXCOORD3 %87 
					                               f32_4 %88 = OpLoad %43 
					                               f32_2 %89 = OpVectorShuffle %88 %88 1 3 
					                               f32_4 %90 = OpLoad %64 
					                               f32_4 %91 = OpVectorShuffle %90 %89 0 1 4 5 
					                                             OpStore %64 %91 
					                      Uniform f32_4* %93 = OpAccessChain %58 %15 
					                               f32_4 %94 = OpLoad %93 
					                               f32_4 %95 = OpVectorShuffle %94 %94 0 0 1 1 
					                               f32_4 %99 = OpFMul %95 %98 
					                              f32_4 %100 = OpLoad %64 
					                              f32_4 %101 = OpFAdd %99 %100 
					                                             OpStore vs_TEXCOORD4 %101 
					                        Output f32* %103 = OpAccessChain %13 %15 %9 
					                                f32 %104 = OpLoad %103 
					                                f32 %105 = OpFNegate %104 
					                        Output f32* %106 = OpAccessChain %13 %15 %9 
					                                             OpStore %106 %105 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 618
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %22 %48 %67 %172 %281 %355 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                              OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
					                                              OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpDecorate %12 DescriptorSet 12 
					                                              OpDecorate %12 Binding 12 
					                                              OpDecorate %16 DescriptorSet 16 
					                                              OpDecorate %16 Binding 16 
					                                              OpDecorate vs_TEXCOORD0 Location 22 
					                                              OpDecorate vs_TEXCOORD2 Location 48 
					                                              OpDecorate vs_TEXCOORD4 Location 67 
					                                              OpMemberDecorate %108 0 Offset 108 
					                                              OpDecorate %108 Block 
					                                              OpDecorate %110 DescriptorSet 110 
					                                              OpDecorate %110 Binding 110 
					                                              OpDecorate %145 DescriptorSet 145 
					                                              OpDecorate %145 Binding 145 
					                                              OpDecorate vs_TEXCOORD3 Location 172 
					                                              OpDecorate vs_TEXCOORD1 Location 281 
					                                              OpDecorate %344 DescriptorSet 344 
					                                              OpDecorate %344 Binding 344 
					                                              OpDecorate %355 Location 355 
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
					                                      %28 = OpTypeBool 
					                                      %29 = OpTypeVector %28 2 
					                                      %30 = OpTypePointer Private %29 
					                      Private bool_2* %31 = OpVariable Private 
					                                  f32 %32 = OpConstant 3,674022E-40 
					                                f32_4 %33 = OpConstantComposite %32 %32 %32 %32 
					                                      %36 = OpTypeVector %28 4 
					                                      %39 = OpTypeInt 32 0 
					                                  u32 %40 = OpConstant 0 
					                                      %41 = OpTypePointer Private %28 
					                       Private f32_4* %46 = OpVariable Private 
					                                      %47 = OpTypePointer Input %7 
					                Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                  f32 %53 = OpConstant 3,674022E-40 
					                                  u32 %54 = OpConstant 2 
					                                      %55 = OpTypePointer Private %6 
					                                      %57 = OpTypeVector %6 3 
					                                      %58 = OpTypePointer Private %57 
					                       Private f32_3* %59 = OpVariable Private 
					                                 bool %66 = OpConstantTrue 
					                Input f32_4* vs_TEXCOORD4 = OpVariable Input 
					                                      %68 = OpTypePointer Input %6 
					                        Private bool* %75 = OpVariable Private 
					                                  f32 %76 = OpConstant 3,674022E-40 
					                                     %108 = OpTypeStruct %7 
					                                     %109 = OpTypePointer Uniform %108 
					            Uniform struct {f32_4;}* %110 = OpVariable Uniform 
					                                     %111 = OpTypeInt 32 1 
					                                 i32 %112 = OpConstant 0 
					                                     %113 = OpTypePointer Uniform %7 
					                                 f32 %117 = OpConstant 3,674022E-40 
					                                 f32 %118 = OpConstant 3,674022E-40 
					                               f32_2 %119 = OpConstantComposite %117 %118 
					                                 u32 %126 = OpConstant 1 
					                                 f32 %136 = OpConstant 3,674022E-40 
					                               f32_2 %137 = OpConstantComposite %136 %117 
					                                 f32 %139 = OpConstant 3,674022E-40 
					                                 f32 %140 = OpConstant 3,674022E-40 
					                               f32_2 %141 = OpConstantComposite %139 %140 
					UniformConstant read_only Texture2D* %145 = OpVariable UniformConstant 
					                                 u32 %152 = OpConstant 3 
					                                 f32 %157 = OpConstant 3,674022E-40 
					                                 f32 %159 = OpConstant 3,674022E-40 
					                                     %162 = OpTypePointer Uniform %6 
					                Input f32_4* vs_TEXCOORD3 = OpVariable Input 
					                      Private f32_3* %189 = OpVariable Private 
					                       Private bool* %196 = OpVariable Private 
					                       Private bool* %202 = OpVariable Private 
					                                 f32 %232 = OpConstant 3,674022E-40 
					                               f32_2 %233 = OpConstantComposite %232 %32 
					                                 f32 %250 = OpConstant 3,674022E-40 
					                               f32_2 %251 = OpConstantComposite %250 %140 
					                        Private f32* %255 = OpVariable Private 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                     %304 = OpTypeVector %111 2 
					                                 i32 %305 = OpConstant 1 
					                               i32_2 %306 = OpConstantComposite %305 %112 
					                                 f32 %312 = OpConstant 3,674022E-40 
					                               f32_2 %313 = OpConstantComposite %312 %312 
					                                 f32 %324 = OpConstant 3,674022E-40 
					                               f32_2 %325 = OpConstantComposite %324 %324 
					                                 f32 %334 = OpConstant 3,674022E-40 
					                                 f32 %335 = OpConstant 3,674022E-40 
					                               f32_2 %336 = OpConstantComposite %334 %335 
					                                 f32 %338 = OpConstant 3,674022E-40 
					                                 f32 %339 = OpConstant 3,674022E-40 
					                               f32_2 %340 = OpConstantComposite %338 %339 
					UniformConstant read_only Texture2D* %344 = OpVariable UniformConstant 
					                                     %354 = OpTypePointer Output %7 
					                       Output f32_4* %355 = OpVariable Output 
					                               f32_2 %361 = OpConstantComposite %32 %32 
					                               f32_2 %413 = OpConstantComposite %118 %117 
					                       Private bool* %482 = OpVariable Private 
					                               f32_2 %512 = OpConstantComposite %32 %232 
					                                     %526 = OpTypePointer Private %20 
					                      Private f32_2* %527 = OpVariable Private 
					                               i32_2 %578 = OpConstantComposite %112 %305 
					                      Private f32_2* %582 = OpVariable Private 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                  read_only Texture2D %13 = OpLoad %12 
					                              sampler %17 = OpLoad %16 
					           read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                f32_2 %23 = OpLoad vs_TEXCOORD0 
					                                f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                f32_2 %25 = OpVectorShuffle %24 %24 0 1 
					                                f32_4 %26 = OpLoad %9 
					                                f32_4 %27 = OpVectorShuffle %26 %25 4 5 2 3 
					                                              OpStore %9 %27 
					                                f32_4 %34 = OpLoad %9 
					                                f32_4 %35 = OpVectorShuffle %34 %34 1 0 1 1 
					                               bool_4 %37 = OpFOrdLessThan %33 %35 
					                               bool_2 %38 = OpVectorShuffle %37 %37 0 1 
					                                              OpStore %31 %38 
					                        Private bool* %42 = OpAccessChain %31 %40 
					                                 bool %43 = OpLoad %42 
					                                              OpSelectionMerge %45 None 
					                                              OpBranchConditional %43 %44 %360 
					                                      %44 = OpLabel 
					                                f32_4 %49 = OpLoad vs_TEXCOORD2 
					                                f32_2 %50 = OpVectorShuffle %49 %49 0 1 
					                                f32_4 %51 = OpLoad %46 
					                                f32_4 %52 = OpVectorShuffle %51 %50 4 5 2 3 
					                                              OpStore %46 %52 
					                         Private f32* %56 = OpAccessChain %46 %54 
					                                              OpStore %56 %53 
					                         Private f32* %60 = OpAccessChain %59 %40 
					                                              OpStore %60 %32 
					                                              OpBranch %61 
					                                      %61 = OpLabel 
					                                              OpLoopMerge %63 %64 None 
					                                              OpBranch %65 
					                                      %65 = OpLabel 
					                                              OpBranchConditional %66 %62 %63 
					                                      %62 = OpLabel 
					                           Input f32* %69 = OpAccessChain vs_TEXCOORD4 %40 
					                                  f32 %70 = OpLoad %69 
					                         Private f32* %71 = OpAccessChain %46 %40 
					                                  f32 %72 = OpLoad %71 
					                                 bool %73 = OpFOrdLessThan %70 %72 
					                        Private bool* %74 = OpAccessChain %31 %40 
					                                              OpStore %74 %73 
					                         Private f32* %77 = OpAccessChain %46 %54 
					                                  f32 %78 = OpLoad %77 
					                                 bool %79 = OpFOrdLessThan %76 %78 
					                                              OpStore %75 %79 
					                                 bool %80 = OpLoad %75 
					                        Private bool* %81 = OpAccessChain %31 %40 
					                                 bool %82 = OpLoad %81 
					                                 bool %83 = OpLogicalAnd %80 %82 
					                        Private bool* %84 = OpAccessChain %31 %40 
					                                              OpStore %84 %83 
					                         Private f32* %85 = OpAccessChain %59 %40 
					                                  f32 %86 = OpLoad %85 
					                                 bool %87 = OpFOrdEqual %86 %32 
					                                              OpStore %75 %87 
					                                 bool %88 = OpLoad %75 
					                        Private bool* %89 = OpAccessChain %31 %40 
					                                 bool %90 = OpLoad %89 
					                                 bool %91 = OpLogicalAnd %88 %90 
					                        Private bool* %92 = OpAccessChain %31 %40 
					                                              OpStore %92 %91 
					                        Private bool* %93 = OpAccessChain %31 %40 
					                                 bool %94 = OpLoad %93 
					                                 bool %95 = OpLogicalNot %94 
					                                              OpSelectionMerge %97 None 
					                                              OpBranchConditional %95 %96 %97 
					                                      %96 = OpLabel 
					                                              OpBranch %63 
					                                      %97 = OpLabel 
					                  read_only Texture2D %99 = OpLoad %12 
					                             sampler %100 = OpLoad %16 
					          read_only Texture2DSampled %101 = OpSampledImage %99 %100 
					                               f32_4 %102 = OpLoad %46 
					                               f32_2 %103 = OpVectorShuffle %102 %102 0 1 
					                               f32_4 %104 = OpImageSampleExplicitLod %101 %103 Lod %7 
					                               f32_2 %105 = OpVectorShuffle %104 %104 0 1 
					                               f32_3 %106 = OpLoad %59 
					                               f32_3 %107 = OpVectorShuffle %106 %105 3 4 2 
					                                              OpStore %59 %107 
					                      Uniform f32_4* %114 = OpAccessChain %110 %112 
					                               f32_4 %115 = OpLoad %114 
					                               f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                               f32_2 %120 = OpFMul %116 %119 
					                               f32_4 %121 = OpLoad %46 
					                               f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                               f32_2 %123 = OpFAdd %120 %122 
					                               f32_4 %124 = OpLoad %46 
					                               f32_4 %125 = OpVectorShuffle %124 %123 4 5 2 3 
					                                              OpStore %46 %125 
					                        Private f32* %127 = OpAccessChain %59 %126 
					                                 f32 %128 = OpLoad %127 
					                        Private f32* %129 = OpAccessChain %46 %54 
					                                              OpStore %129 %128 
					                                              OpBranch %64 
					                                      %64 = OpLabel 
					                                              OpBranch %61 
					                                      %63 = OpLabel 
					                               f32_4 %130 = OpLoad %46 
					                               f32_2 %131 = OpVectorShuffle %130 %130 0 2 
					                               f32_3 %132 = OpLoad %59 
					                               f32_3 %133 = OpVectorShuffle %132 %131 0 3 4 
					                                              OpStore %59 %133 
					                               f32_3 %134 = OpLoad %59 
					                               f32_2 %135 = OpVectorShuffle %134 %134 0 2 
					                               f32_2 %138 = OpFMul %135 %137 
					                               f32_2 %142 = OpFAdd %138 %141 
					                               f32_4 %143 = OpLoad %9 
					                               f32_4 %144 = OpVectorShuffle %143 %142 4 1 5 3 
					                                              OpStore %9 %144 
					                 read_only Texture2D %146 = OpLoad %145 
					                             sampler %147 = OpLoad %16 
					          read_only Texture2DSampled %148 = OpSampledImage %146 %147 
					                               f32_4 %149 = OpLoad %9 
					                               f32_2 %150 = OpVectorShuffle %149 %149 0 2 
					                               f32_4 %151 = OpImageSampleExplicitLod %148 %150 Lod %7 
					                                 f32 %153 = OpCompositeExtract %151 3 
					                        Private f32* %154 = OpAccessChain %9 %40 
					                                              OpStore %154 %153 
					                        Private f32* %155 = OpAccessChain %9 %40 
					                                 f32 %156 = OpLoad %155 
					                                 f32 %158 = OpFMul %156 %157 
					                                 f32 %160 = OpFAdd %158 %159 
					                        Private f32* %161 = OpAccessChain %9 %40 
					                                              OpStore %161 %160 
					                        Uniform f32* %163 = OpAccessChain %110 %112 %40 
					                                 f32 %164 = OpLoad %163 
					                        Private f32* %165 = OpAccessChain %9 %40 
					                                 f32 %166 = OpLoad %165 
					                                 f32 %167 = OpFMul %164 %166 
					                        Private f32* %168 = OpAccessChain %59 %126 
					                                 f32 %169 = OpLoad %168 
					                                 f32 %170 = OpFAdd %167 %169 
					                        Private f32* %171 = OpAccessChain %46 %40 
					                                              OpStore %171 %170 
					                          Input f32* %173 = OpAccessChain vs_TEXCOORD3 %126 
					                                 f32 %174 = OpLoad %173 
					                        Private f32* %175 = OpAccessChain %46 %126 
					                                              OpStore %175 %174 
					                 read_only Texture2D %176 = OpLoad %12 
					                             sampler %177 = OpLoad %16 
					          read_only Texture2DSampled %178 = OpSampledImage %176 %177 
					                               f32_4 %179 = OpLoad %46 
					                               f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                               f32_4 %181 = OpImageSampleExplicitLod %178 %180 Lod %7 
					                                 f32 %182 = OpCompositeExtract %181 0 
					                        Private f32* %183 = OpAccessChain %9 %40 
					                                              OpStore %183 %182 
					                               f32_4 %184 = OpLoad vs_TEXCOORD2 
					                               f32_2 %185 = OpVectorShuffle %184 %184 2 3 
					                               f32_3 %186 = OpLoad %59 
					                               f32_3 %187 = OpVectorShuffle %186 %185 3 4 2 
					                                              OpStore %59 %187 
					                        Private f32* %188 = OpAccessChain %59 %54 
					                                              OpStore %188 %53 
					                        Private f32* %190 = OpAccessChain %189 %40 
					                                              OpStore %190 %32 
					                                              OpBranch %191 
					                                     %191 = OpLabel 
					                                              OpLoopMerge %193 %194 None 
					                                              OpBranch %195 
					                                     %195 = OpLabel 
					                                              OpBranchConditional %66 %192 %193 
					                                     %192 = OpLabel 
					                        Private f32* %197 = OpAccessChain %59 %40 
					                                 f32 %198 = OpLoad %197 
					                          Input f32* %199 = OpAccessChain vs_TEXCOORD4 %126 
					                                 f32 %200 = OpLoad %199 
					                                bool %201 = OpFOrdLessThan %198 %200 
					                                              OpStore %196 %201 
					                        Private f32* %203 = OpAccessChain %59 %54 
					                                 f32 %204 = OpLoad %203 
					                                bool %205 = OpFOrdLessThan %76 %204 
					                                              OpStore %202 %205 
					                                bool %206 = OpLoad %196 
					                                bool %207 = OpLoad %202 
					                                bool %208 = OpLogicalAnd %206 %207 
					                                              OpStore %196 %208 
					                        Private f32* %209 = OpAccessChain %189 %40 
					                                 f32 %210 = OpLoad %209 
					                                bool %211 = OpFOrdEqual %210 %32 
					                                              OpStore %202 %211 
					                                bool %212 = OpLoad %196 
					                                bool %213 = OpLoad %202 
					                                bool %214 = OpLogicalAnd %212 %213 
					                                              OpStore %196 %214 
					                                bool %215 = OpLoad %196 
					                                bool %216 = OpLogicalNot %215 
					                                              OpSelectionMerge %218 None 
					                                              OpBranchConditional %216 %217 %218 
					                                     %217 = OpLabel 
					                                              OpBranch %193 
					                                     %218 = OpLabel 
					                 read_only Texture2D %220 = OpLoad %12 
					                             sampler %221 = OpLoad %16 
					          read_only Texture2DSampled %222 = OpSampledImage %220 %221 
					                               f32_3 %223 = OpLoad %59 
					                               f32_2 %224 = OpVectorShuffle %223 %223 0 1 
					                               f32_4 %225 = OpImageSampleExplicitLod %222 %224 Lod %7 
					                               f32_2 %226 = OpVectorShuffle %225 %225 0 1 
					                               f32_3 %227 = OpLoad %189 
					                               f32_3 %228 = OpVectorShuffle %227 %226 3 4 2 
					                                              OpStore %189 %228 
					                      Uniform f32_4* %229 = OpAccessChain %110 %112 
					                               f32_4 %230 = OpLoad %229 
					                               f32_2 %231 = OpVectorShuffle %230 %230 0 1 
					                               f32_2 %234 = OpFMul %231 %233 
					                               f32_3 %235 = OpLoad %59 
					                               f32_2 %236 = OpVectorShuffle %235 %235 0 1 
					                               f32_2 %237 = OpFAdd %234 %236 
					                               f32_3 %238 = OpLoad %59 
					                               f32_3 %239 = OpVectorShuffle %238 %237 3 4 2 
					                                              OpStore %59 %239 
					                        Private f32* %240 = OpAccessChain %189 %126 
					                                 f32 %241 = OpLoad %240 
					                        Private f32* %242 = OpAccessChain %59 %54 
					                                              OpStore %242 %241 
					                                              OpBranch %194 
					                                     %194 = OpLabel 
					                                              OpBranch %191 
					                                     %193 = OpLabel 
					                               f32_3 %243 = OpLoad %59 
					                               f32_2 %244 = OpVectorShuffle %243 %243 0 2 
					                               f32_3 %245 = OpLoad %189 
					                               f32_3 %246 = OpVectorShuffle %245 %244 0 3 4 
					                                              OpStore %189 %246 
					                               f32_3 %247 = OpLoad %189 
					                               f32_2 %248 = OpVectorShuffle %247 %247 0 2 
					                               f32_2 %249 = OpFMul %248 %137 
					                               f32_2 %252 = OpFAdd %249 %251 
					                               f32_3 %253 = OpLoad %59 
					                               f32_3 %254 = OpVectorShuffle %253 %252 3 4 2 
					                                              OpStore %59 %254 
					                 read_only Texture2D %256 = OpLoad %145 
					                             sampler %257 = OpLoad %16 
					          read_only Texture2DSampled %258 = OpSampledImage %256 %257 
					                               f32_3 %259 = OpLoad %59 
					                               f32_2 %260 = OpVectorShuffle %259 %259 0 1 
					                               f32_4 %261 = OpImageSampleExplicitLod %258 %260 Lod %7 
					                                 f32 %262 = OpCompositeExtract %261 3 
					                                              OpStore %255 %262 
					                                 f32 %263 = OpLoad %255 
					                                 f32 %264 = OpFMul %263 %157 
					                                 f32 %265 = OpFAdd %264 %159 
					                                              OpStore %255 %265 
					                        Uniform f32* %266 = OpAccessChain %110 %112 %40 
					                                 f32 %267 = OpLoad %266 
					                                 f32 %268 = OpFNegate %267 
					                                 f32 %269 = OpLoad %255 
					                                 f32 %270 = OpFMul %268 %269 
					                        Private f32* %271 = OpAccessChain %189 %126 
					                                 f32 %272 = OpLoad %271 
					                                 f32 %273 = OpFAdd %270 %272 
					                        Private f32* %274 = OpAccessChain %46 %54 
					                                              OpStore %274 %273 
					                      Uniform f32_4* %275 = OpAccessChain %110 %112 
					                               f32_4 %276 = OpLoad %275 
					                               f32_2 %277 = OpVectorShuffle %276 %276 2 2 
					                               f32_4 %278 = OpLoad %46 
					                               f32_2 %279 = OpVectorShuffle %278 %278 0 2 
					                               f32_2 %280 = OpFMul %277 %279 
					                               f32_2 %282 = OpLoad vs_TEXCOORD1 
					                               f32_2 %283 = OpVectorShuffle %282 %282 0 0 
					                               f32_2 %284 = OpFNegate %283 
					                               f32_2 %285 = OpFAdd %280 %284 
					                               f32_4 %286 = OpLoad %46 
					                               f32_4 %287 = OpVectorShuffle %286 %285 4 1 2 5 
					                                              OpStore %46 %287 
					                               f32_4 %288 = OpLoad %46 
					                               f32_2 %289 = OpVectorShuffle %288 %288 0 3 
					                               f32_2 %290 = OpExtInst %1 2 %289 
					                               f32_4 %291 = OpLoad %46 
					                               f32_4 %292 = OpVectorShuffle %291 %290 4 1 2 5 
					                                              OpStore %46 %292 
					                               f32_4 %293 = OpLoad %46 
					                               f32_2 %294 = OpVectorShuffle %293 %293 0 3 
					                               f32_2 %295 = OpExtInst %1 4 %294 
					                               f32_2 %296 = OpExtInst %1 31 %295 
					                               f32_4 %297 = OpLoad %46 
					                               f32_4 %298 = OpVectorShuffle %297 %296 4 1 2 5 
					                                              OpStore %46 %298 
					                 read_only Texture2D %299 = OpLoad %12 
					                             sampler %300 = OpLoad %16 
					          read_only Texture2DSampled %301 = OpSampledImage %299 %300 
					                               f32_4 %302 = OpLoad %46 
					                               f32_2 %303 = OpVectorShuffle %302 %302 2 1 
					                               f32_4 %307 = OpImageSampleExplicitLod %301 %303 Lod %7ConstOffset %307 
					                                 f32 %308 = OpCompositeExtract %307 0 
					                        Private f32* %309 = OpAccessChain %9 %54 
					                                              OpStore %309 %308 
					                               f32_4 %310 = OpLoad %9 
					                               f32_2 %311 = OpVectorShuffle %310 %310 0 2 
					                               f32_2 %314 = OpFMul %311 %313 
					                               f32_4 %315 = OpLoad %9 
					                               f32_4 %316 = OpVectorShuffle %315 %314 4 1 5 3 
					                                              OpStore %9 %316 
					                               f32_4 %317 = OpLoad %9 
					                               f32_2 %318 = OpVectorShuffle %317 %317 0 2 
					                               f32_2 %319 = OpExtInst %1 2 %318 
					                               f32_4 %320 = OpLoad %9 
					                               f32_4 %321 = OpVectorShuffle %320 %319 4 1 5 3 
					                                              OpStore %9 %321 
					                               f32_4 %322 = OpLoad %9 
					                               f32_2 %323 = OpVectorShuffle %322 %322 0 2 
					                               f32_2 %326 = OpFMul %323 %325 
					                               f32_4 %327 = OpLoad %46 
					                               f32_2 %328 = OpVectorShuffle %327 %327 0 3 
					                               f32_2 %329 = OpFAdd %326 %328 
					                               f32_4 %330 = OpLoad %9 
					                               f32_4 %331 = OpVectorShuffle %330 %329 4 1 5 3 
					                                              OpStore %9 %331 
					                               f32_4 %332 = OpLoad %9 
					                               f32_2 %333 = OpVectorShuffle %332 %332 0 2 
					                               f32_2 %337 = OpFMul %333 %336 
					                               f32_2 %341 = OpFAdd %337 %340 
					                               f32_4 %342 = OpLoad %9 
					                               f32_4 %343 = OpVectorShuffle %342 %341 4 1 5 3 
					                                              OpStore %9 %343 
					                 read_only Texture2D %345 = OpLoad %344 
					                             sampler %346 = OpLoad %16 
					          read_only Texture2DSampled %347 = OpSampledImage %345 %346 
					                               f32_4 %348 = OpLoad %9 
					                               f32_2 %349 = OpVectorShuffle %348 %348 0 2 
					                               f32_4 %350 = OpImageSampleExplicitLod %347 %349 Lod %7 
					                               f32_2 %351 = OpVectorShuffle %350 %350 0 1 
					                               f32_4 %352 = OpLoad %9 
					                               f32_4 %353 = OpVectorShuffle %352 %351 4 1 5 3 
					                                              OpStore %9 %353 
					                               f32_4 %356 = OpLoad %9 
					                               f32_2 %357 = OpVectorShuffle %356 %356 0 2 
					                               f32_4 %358 = OpLoad %355 
					                               f32_4 %359 = OpVectorShuffle %358 %357 4 5 2 3 
					                                              OpStore %355 %359 
					                                              OpBranch %45 
					                                     %360 = OpLabel 
					                               f32_4 %362 = OpLoad %355 
					                               f32_4 %363 = OpVectorShuffle %362 %361 4 5 2 3 
					                                              OpStore %355 %363 
					                                              OpBranch %45 
					                                      %45 = OpLabel 
					                       Private bool* %364 = OpAccessChain %31 %126 
					                                bool %365 = OpLoad %364 
					                                              OpSelectionMerge %367 None 
					                                              OpBranchConditional %365 %366 %614 
					                                     %366 = OpLabel 
					                               f32_4 %368 = OpLoad vs_TEXCOORD3 
					                               f32_2 %369 = OpVectorShuffle %368 %368 0 1 
					                               f32_4 %370 = OpLoad %9 
					                               f32_4 %371 = OpVectorShuffle %370 %369 4 5 2 3 
					                                              OpStore %9 %371 
					                        Private f32* %372 = OpAccessChain %9 %54 
					                                              OpStore %372 %53 
					                        Private f32* %373 = OpAccessChain %46 %40 
					                                              OpStore %373 %32 
					                                              OpBranch %374 
					                                     %374 = OpLabel 
					                                              OpLoopMerge %376 %377 None 
					                                              OpBranch %378 
					                                     %378 = OpLabel 
					                                              OpBranchConditional %66 %375 %376 
					                                     %375 = OpLabel 
					                          Input f32* %379 = OpAccessChain vs_TEXCOORD4 %54 
					                                 f32 %380 = OpLoad %379 
					                        Private f32* %381 = OpAccessChain %9 %126 
					                                 f32 %382 = OpLoad %381 
					                                bool %383 = OpFOrdLessThan %380 %382 
					                                              OpStore %196 %383 
					                        Private f32* %384 = OpAccessChain %9 %54 
					                                 f32 %385 = OpLoad %384 
					                                bool %386 = OpFOrdLessThan %76 %385 
					                                              OpStore %202 %386 
					                                bool %387 = OpLoad %196 
					                                bool %388 = OpLoad %202 
					                                bool %389 = OpLogicalAnd %387 %388 
					                                              OpStore %196 %389 
					                        Private f32* %390 = OpAccessChain %46 %40 
					                                 f32 %391 = OpLoad %390 
					                                bool %392 = OpFOrdEqual %391 %32 
					                                              OpStore %202 %392 
					                                bool %393 = OpLoad %196 
					                                bool %394 = OpLoad %202 
					                                bool %395 = OpLogicalAnd %393 %394 
					                                              OpStore %196 %395 
					                                bool %396 = OpLoad %196 
					                                bool %397 = OpLogicalNot %396 
					                                              OpSelectionMerge %399 None 
					                                              OpBranchConditional %397 %398 %399 
					                                     %398 = OpLabel 
					                                              OpBranch %376 
					                                     %399 = OpLabel 
					                 read_only Texture2D %401 = OpLoad %12 
					                             sampler %402 = OpLoad %16 
					          read_only Texture2DSampled %403 = OpSampledImage %401 %402 
					                               f32_4 %404 = OpLoad %9 
					                               f32_2 %405 = OpVectorShuffle %404 %404 0 1 
					                               f32_4 %406 = OpImageSampleExplicitLod %403 %405 Lod %7 
					                               f32_2 %407 = OpVectorShuffle %406 %406 1 0 
					                               f32_4 %408 = OpLoad %46 
					                               f32_4 %409 = OpVectorShuffle %408 %407 4 5 2 3 
					                                              OpStore %46 %409 
					                      Uniform f32_4* %410 = OpAccessChain %110 %112 
					                               f32_4 %411 = OpLoad %410 
					                               f32_2 %412 = OpVectorShuffle %411 %411 0 1 
					                               f32_2 %414 = OpFMul %412 %413 
					                               f32_4 %415 = OpLoad %9 
					                               f32_2 %416 = OpVectorShuffle %415 %415 0 1 
					                               f32_2 %417 = OpFAdd %414 %416 
					                               f32_4 %418 = OpLoad %9 
					                               f32_4 %419 = OpVectorShuffle %418 %417 4 5 2 3 
					                                              OpStore %9 %419 
					                        Private f32* %420 = OpAccessChain %46 %126 
					                                 f32 %421 = OpLoad %420 
					                        Private f32* %422 = OpAccessChain %9 %54 
					                                              OpStore %422 %421 
					                                              OpBranch %377 
					                                     %377 = OpLabel 
					                                              OpBranch %374 
					                                     %376 = OpLabel 
					                               f32_4 %423 = OpLoad %9 
					                               f32_2 %424 = OpVectorShuffle %423 %423 1 2 
					                               f32_4 %425 = OpLoad %46 
					                               f32_4 %426 = OpVectorShuffle %425 %424 0 4 5 3 
					                                              OpStore %46 %426 
					                               f32_4 %427 = OpLoad %46 
					                               f32_2 %428 = OpVectorShuffle %427 %427 0 2 
					                               f32_2 %429 = OpFMul %428 %137 
					                               f32_2 %430 = OpFAdd %429 %141 
					                               f32_4 %431 = OpLoad %9 
					                               f32_4 %432 = OpVectorShuffle %431 %430 4 5 2 3 
					                                              OpStore %9 %432 
					                 read_only Texture2D %433 = OpLoad %145 
					                             sampler %434 = OpLoad %16 
					          read_only Texture2DSampled %435 = OpSampledImage %433 %434 
					                               f32_4 %436 = OpLoad %9 
					                               f32_2 %437 = OpVectorShuffle %436 %436 0 1 
					                               f32_4 %438 = OpImageSampleExplicitLod %435 %437 Lod %7 
					                                 f32 %439 = OpCompositeExtract %438 3 
					                        Private f32* %440 = OpAccessChain %9 %40 
					                                              OpStore %440 %439 
					                        Private f32* %441 = OpAccessChain %9 %40 
					                                 f32 %442 = OpLoad %441 
					                                 f32 %443 = OpFMul %442 %157 
					                                 f32 %444 = OpFAdd %443 %159 
					                        Private f32* %445 = OpAccessChain %9 %40 
					                                              OpStore %445 %444 
					                        Uniform f32* %446 = OpAccessChain %110 %112 %126 
					                                 f32 %447 = OpLoad %446 
					                        Private f32* %448 = OpAccessChain %9 %40 
					                                 f32 %449 = OpLoad %448 
					                                 f32 %450 = OpFMul %447 %449 
					                        Private f32* %451 = OpAccessChain %46 %126 
					                                 f32 %452 = OpLoad %451 
					                                 f32 %453 = OpFAdd %450 %452 
					                        Private f32* %454 = OpAccessChain %9 %40 
					                                              OpStore %454 %453 
					                          Input f32* %455 = OpAccessChain vs_TEXCOORD2 %40 
					                                 f32 %456 = OpLoad %455 
					                        Private f32* %457 = OpAccessChain %9 %126 
					                                              OpStore %457 %456 
					                 read_only Texture2D %458 = OpLoad %12 
					                             sampler %459 = OpLoad %16 
					          read_only Texture2DSampled %460 = OpSampledImage %458 %459 
					                               f32_4 %461 = OpLoad %9 
					                               f32_2 %462 = OpVectorShuffle %461 %461 1 0 
					                               f32_4 %463 = OpImageSampleExplicitLod %460 %462 Lod %7 
					                                 f32 %464 = OpCompositeExtract %463 1 
					                        Private f32* %465 = OpAccessChain %46 %40 
					                                              OpStore %465 %464 
					                               f32_4 %466 = OpLoad vs_TEXCOORD3 
					                               f32_2 %467 = OpVectorShuffle %466 %466 2 3 
					                               f32_3 %468 = OpLoad %59 
					                               f32_3 %469 = OpVectorShuffle %468 %467 3 4 2 
					                                              OpStore %59 %469 
					                        Private f32* %470 = OpAccessChain %59 %54 
					                                              OpStore %470 %53 
					                        Private f32* %471 = OpAccessChain %189 %40 
					                                              OpStore %471 %32 
					                                              OpBranch %472 
					                                     %472 = OpLabel 
					                                              OpLoopMerge %474 %475 None 
					                                              OpBranch %476 
					                                     %476 = OpLabel 
					                                              OpBranchConditional %66 %473 %474 
					                                     %473 = OpLabel 
					                        Private f32* %477 = OpAccessChain %59 %126 
					                                 f32 %478 = OpLoad %477 
					                          Input f32* %479 = OpAccessChain vs_TEXCOORD4 %152 
					                                 f32 %480 = OpLoad %479 
					                                bool %481 = OpFOrdLessThan %478 %480 
					                                              OpStore %196 %481 
					                        Private f32* %483 = OpAccessChain %59 %54 
					                                 f32 %484 = OpLoad %483 
					                                bool %485 = OpFOrdLessThan %76 %484 
					                                              OpStore %482 %485 
					                                bool %486 = OpLoad %196 
					                                bool %487 = OpLoad %482 
					                                bool %488 = OpLogicalAnd %486 %487 
					                                              OpStore %196 %488 
					                        Private f32* %489 = OpAccessChain %189 %40 
					                                 f32 %490 = OpLoad %489 
					                                bool %491 = OpFOrdEqual %490 %32 
					                                              OpStore %482 %491 
					                                bool %492 = OpLoad %196 
					                                bool %493 = OpLoad %482 
					                                bool %494 = OpLogicalAnd %492 %493 
					                                              OpStore %196 %494 
					                                bool %495 = OpLoad %196 
					                                bool %496 = OpLogicalNot %495 
					                                              OpSelectionMerge %498 None 
					                                              OpBranchConditional %496 %497 %498 
					                                     %497 = OpLabel 
					                                              OpBranch %474 
					                                     %498 = OpLabel 
					                 read_only Texture2D %500 = OpLoad %12 
					                             sampler %501 = OpLoad %16 
					          read_only Texture2DSampled %502 = OpSampledImage %500 %501 
					                               f32_3 %503 = OpLoad %59 
					                               f32_2 %504 = OpVectorShuffle %503 %503 0 1 
					                               f32_4 %505 = OpImageSampleExplicitLod %502 %504 Lod %7 
					                               f32_2 %506 = OpVectorShuffle %505 %505 1 0 
					                               f32_3 %507 = OpLoad %189 
					                               f32_3 %508 = OpVectorShuffle %507 %506 3 4 2 
					                                              OpStore %189 %508 
					                      Uniform f32_4* %509 = OpAccessChain %110 %112 
					                               f32_4 %510 = OpLoad %509 
					                               f32_2 %511 = OpVectorShuffle %510 %510 0 1 
					                               f32_2 %513 = OpFMul %511 %512 
					                               f32_3 %514 = OpLoad %59 
					                               f32_2 %515 = OpVectorShuffle %514 %514 0 1 
					                               f32_2 %516 = OpFAdd %513 %515 
					                               f32_3 %517 = OpLoad %59 
					                               f32_3 %518 = OpVectorShuffle %517 %516 3 4 2 
					                                              OpStore %59 %518 
					                        Private f32* %519 = OpAccessChain %189 %126 
					                                 f32 %520 = OpLoad %519 
					                        Private f32* %521 = OpAccessChain %59 %54 
					                                              OpStore %521 %520 
					                                              OpBranch %475 
					                                     %475 = OpLabel 
					                                              OpBranch %472 
					                                     %474 = OpLabel 
					                               f32_3 %522 = OpLoad %59 
					                               f32_2 %523 = OpVectorShuffle %522 %522 1 2 
					                               f32_3 %524 = OpLoad %189 
					                               f32_3 %525 = OpVectorShuffle %524 %523 0 3 4 
					                                              OpStore %189 %525 
					                               f32_3 %528 = OpLoad %189 
					                               f32_2 %529 = OpVectorShuffle %528 %528 0 2 
					                               f32_2 %530 = OpFMul %529 %137 
					                               f32_2 %531 = OpFAdd %530 %251 
					                                              OpStore %527 %531 
					                 read_only Texture2D %532 = OpLoad %145 
					                             sampler %533 = OpLoad %16 
					          read_only Texture2DSampled %534 = OpSampledImage %532 %533 
					                               f32_2 %535 = OpLoad %527 
					                               f32_4 %536 = OpImageSampleExplicitLod %534 %535 Lod %7 
					                                 f32 %537 = OpCompositeExtract %536 3 
					                                              OpStore %255 %537 
					                                 f32 %538 = OpLoad %255 
					                                 f32 %539 = OpFMul %538 %157 
					                                 f32 %540 = OpFAdd %539 %159 
					                                              OpStore %255 %540 
					                        Uniform f32* %541 = OpAccessChain %110 %112 %126 
					                                 f32 %542 = OpLoad %541 
					                                 f32 %543 = OpFNegate %542 
					                                 f32 %544 = OpLoad %255 
					                                 f32 %545 = OpFMul %543 %544 
					                        Private f32* %546 = OpAccessChain %189 %126 
					                                 f32 %547 = OpLoad %546 
					                                 f32 %548 = OpFAdd %545 %547 
					                        Private f32* %549 = OpAccessChain %9 %54 
					                                              OpStore %549 %548 
					                      Uniform f32_4* %550 = OpAccessChain %110 %112 
					                               f32_4 %551 = OpLoad %550 
					                               f32_2 %552 = OpVectorShuffle %551 %551 3 3 
					                               f32_4 %553 = OpLoad %9 
					                               f32_2 %554 = OpVectorShuffle %553 %553 0 2 
					                               f32_2 %555 = OpFMul %552 %554 
					                               f32_2 %556 = OpLoad vs_TEXCOORD1 
					                               f32_2 %557 = OpVectorShuffle %556 %556 1 1 
					                               f32_2 %558 = OpFNegate %557 
					                               f32_2 %559 = OpFAdd %555 %558 
					                               f32_4 %560 = OpLoad %9 
					                               f32_4 %561 = OpVectorShuffle %560 %559 4 1 2 5 
					                                              OpStore %9 %561 
					                               f32_4 %562 = OpLoad %9 
					                               f32_2 %563 = OpVectorShuffle %562 %562 0 3 
					                               f32_2 %564 = OpExtInst %1 2 %563 
					                               f32_4 %565 = OpLoad %9 
					                               f32_4 %566 = OpVectorShuffle %565 %564 4 1 2 5 
					                                              OpStore %9 %566 
					                               f32_4 %567 = OpLoad %9 
					                               f32_2 %568 = OpVectorShuffle %567 %567 0 3 
					                               f32_2 %569 = OpExtInst %1 4 %568 
					                               f32_2 %570 = OpExtInst %1 31 %569 
					                               f32_4 %571 = OpLoad %9 
					                               f32_4 %572 = OpVectorShuffle %571 %570 4 1 2 5 
					                                              OpStore %9 %572 
					                 read_only Texture2D %573 = OpLoad %12 
					                             sampler %574 = OpLoad %16 
					          read_only Texture2DSampled %575 = OpSampledImage %573 %574 
					                               f32_4 %576 = OpLoad %9 
					                               f32_2 %577 = OpVectorShuffle %576 %576 1 2 
					                               f32_4 %579 = OpImageSampleExplicitLod %575 %577 Lod %7ConstOffset %579 
					                                 f32 %580 = OpCompositeExtract %579 1 
					                        Private f32* %581 = OpAccessChain %46 %126 
					                                              OpStore %581 %580 
					                               f32_4 %583 = OpLoad %46 
					                               f32_2 %584 = OpVectorShuffle %583 %583 0 1 
					                               f32_2 %585 = OpFMul %584 %313 
					                                              OpStore %582 %585 
					                               f32_2 %586 = OpLoad %582 
					                               f32_2 %587 = OpExtInst %1 2 %586 
					                                              OpStore %582 %587 
					                               f32_2 %588 = OpLoad %582 
					                               f32_2 %589 = OpFMul %588 %325 
					                               f32_4 %590 = OpLoad %9 
					                               f32_2 %591 = OpVectorShuffle %590 %590 0 3 
					                               f32_2 %592 = OpFAdd %589 %591 
					                               f32_4 %593 = OpLoad %9 
					                               f32_4 %594 = OpVectorShuffle %593 %592 4 5 2 3 
					                                              OpStore %9 %594 
					                               f32_4 %595 = OpLoad %9 
					                               f32_2 %596 = OpVectorShuffle %595 %595 0 1 
					                               f32_2 %597 = OpFMul %596 %336 
					                               f32_2 %598 = OpFAdd %597 %340 
					                               f32_4 %599 = OpLoad %9 
					                               f32_4 %600 = OpVectorShuffle %599 %598 4 5 2 3 
					                                              OpStore %9 %600 
					                 read_only Texture2D %601 = OpLoad %344 
					                             sampler %602 = OpLoad %16 
					          read_only Texture2DSampled %603 = OpSampledImage %601 %602 
					                               f32_4 %604 = OpLoad %9 
					                               f32_2 %605 = OpVectorShuffle %604 %604 0 1 
					                               f32_4 %606 = OpImageSampleExplicitLod %603 %605 Lod %7 
					                               f32_2 %607 = OpVectorShuffle %606 %606 0 1 
					                               f32_4 %608 = OpLoad %9 
					                               f32_4 %609 = OpVectorShuffle %608 %607 4 5 2 3 
					                                              OpStore %9 %609 
					                               f32_4 %610 = OpLoad %9 
					                               f32_2 %611 = OpVectorShuffle %610 %610 0 1 
					                               f32_4 %612 = OpLoad %355 
					                               f32_4 %613 = OpVectorShuffle %612 %611 0 1 4 5 
					                                              OpStore %355 %613 
					                                              OpBranch %367 
					                                     %614 = OpLabel 
					                               f32_4 %615 = OpLoad %355 
					                               f32_4 %616 = OpVectorShuffle %615 %361 0 1 4 5 
					                                              OpStore %355 %616 
					                                              OpBranch %367 
					                                     %367 = OpLabel 
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
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AreaTex;
					uniform  sampler2D _SearchTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					bool u_xlatb10;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.yxyy).xy;
					    if(u_xlatb0.x){
					        u_xlat1.xy = vs_TEXCOORD2.xy;
					        u_xlat1.z = 1.0;
					        u_xlat2.x = 0.0;
					        while(true){
					            u_xlatb0.x = vs_TEXCOORD4.x<u_xlat1.x;
					            u_xlatb10 = 0.828100026<u_xlat1.z;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            u_xlatb10 = u_xlat2.x==0.0;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            if(!u_xlatb0.x){break;}
					            u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					            u_xlat1.xy = _MainTex_TexelSize.xy * vec2(-2.0, -0.0) + u_xlat1.xy;
					            u_xlat1.z = u_xlat2.y;
					        }
					        u_xlat2.yz = u_xlat1.xz;
					        u_xlat0.xz = u_xlat2.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat1 = textureLod(_SearchTex, u_xlat0.xz, 0.0);
					        u_xlat0.x = u_xlat1.w * -2.00787401 + 3.25;
					        u_xlat1.x = _MainTex_TexelSize.x * u_xlat0.x + u_xlat2.y;
					        u_xlat1.y = vs_TEXCOORD3.y;
					        u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					        u_xlat3.xy = vs_TEXCOORD2.zw;
					        u_xlat3.z = 1.0;
					        u_xlat4.x = 0.0;
					        while(true){
					            u_xlatb0.x = u_xlat3.x<vs_TEXCOORD4.y;
					            u_xlatb10 = 0.828100026<u_xlat3.z;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            u_xlatb10 = u_xlat4.x==0.0;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            if(!u_xlatb0.x){break;}
					            u_xlat4 = textureLod(_MainTex, u_xlat3.xy, 0.0);
					            u_xlat3.xy = _MainTex_TexelSize.xy * vec2(2.0, 0.0) + u_xlat3.xy;
					            u_xlat3.z = u_xlat4.y;
					        }
					        u_xlat4.yz = u_xlat3.xz;
					        u_xlat0.xz = u_xlat4.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat3 = textureLod(_SearchTex, u_xlat0.xz, 0.0);
					        u_xlat0.x = u_xlat3.w * -2.00787401 + 3.25;
					        u_xlat1.z = (-_MainTex_TexelSize.x) * u_xlat0.x + u_xlat4.y;
					        u_xlat0.xz = _MainTex_TexelSize.zz * u_xlat1.xz + (-vs_TEXCOORD1.xx);
					        u_xlat0.xz = roundEven(u_xlat0.xz);
					        u_xlat0.xz = sqrt(abs(u_xlat0.xz));
					        u_xlat1 = textureLodOffset(_MainTex, u_xlat1.zy, 0.0, ivec2(1, 0)).yxzw;
					        u_xlat1.x = u_xlat2.x;
					        u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
					        u_xlat1.xy = roundEven(u_xlat1.xy);
					        u_xlat0.xz = u_xlat1.xy * vec2(16.0, 16.0) + u_xlat0.xz;
					        u_xlat0.xz = u_xlat0.xz * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat1 = textureLod(_AreaTex, u_xlat0.xz, 0.0);
					        SV_Target0.xy = u_xlat1.xy;
					    } else {
					        SV_Target0.xy = vec2(0.0, 0.0);
					    }
					    if(u_xlatb0.y){
					        u_xlat0.xy = vs_TEXCOORD3.xy;
					        u_xlat0.z = 1.0;
					        u_xlat1.x = 0.0;
					        while(true){
					            u_xlatb15 = vs_TEXCOORD4.z<u_xlat0.y;
					            u_xlatb2 = 0.828100026<u_xlat0.z;
					            u_xlatb15 = u_xlatb15 && u_xlatb2;
					            u_xlatb2 = u_xlat1.x==0.0;
					            u_xlatb15 = u_xlatb15 && u_xlatb2;
					            if(!u_xlatb15){break;}
					            u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0).yxzw;
					            u_xlat0.xy = _MainTex_TexelSize.xy * vec2(-0.0, -2.0) + u_xlat0.xy;
					            u_xlat0.z = u_xlat1.y;
					        }
					        u_xlat1.yz = u_xlat0.yz;
					        u_xlat0.xy = u_xlat1.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat0 = textureLod(_SearchTex, u_xlat0.xy, 0.0);
					        u_xlat0.x = u_xlat0.w * -2.00787401 + 3.25;
					        u_xlat0.x = _MainTex_TexelSize.y * u_xlat0.x + u_xlat1.y;
					        u_xlat0.y = vs_TEXCOORD2.x;
					        u_xlat1 = textureLod(_MainTex, u_xlat0.yx, 0.0);
					        u_xlat2.xy = vs_TEXCOORD3.zw;
					        u_xlat2.z = 1.0;
					        u_xlat3.x = 0.0;
					        while(true){
					            u_xlatb15 = u_xlat2.y<vs_TEXCOORD4.w;
					            u_xlatb1 = 0.828100026<u_xlat2.z;
					            u_xlatb15 = u_xlatb15 && u_xlatb1;
					            u_xlatb1 = u_xlat3.x==0.0;
					            u_xlatb15 = u_xlatb15 && u_xlatb1;
					            if(!u_xlatb15){break;}
					            u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0).yxzw;
					            u_xlat2.xy = _MainTex_TexelSize.xy * vec2(0.0, 2.0) + u_xlat2.xy;
					            u_xlat2.z = u_xlat3.y;
					        }
					        u_xlat3.yz = u_xlat2.yz;
					        u_xlat1.xz = u_xlat3.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat2 = textureLod(_SearchTex, u_xlat1.xz, 0.0);
					        u_xlat15 = u_xlat2.w * -2.00787401 + 3.25;
					        u_xlat0.z = (-_MainTex_TexelSize.y) * u_xlat15 + u_xlat3.y;
					        u_xlat0.xw = _MainTex_TexelSize.ww * u_xlat0.xz + (-vs_TEXCOORD1.yy);
					        u_xlat0.xw = roundEven(u_xlat0.xw);
					        u_xlat0.xw = sqrt(abs(u_xlat0.xw));
					        u_xlat2 = textureLodOffset(_MainTex, u_xlat0.yz, 0.0, ivec2(0, 1));
					        u_xlat2.x = u_xlat1.y;
					        u_xlat5.xy = u_xlat2.xy * vec2(4.0, 4.0);
					        u_xlat5.xy = roundEven(u_xlat5.xy);
					        u_xlat0.xy = u_xlat5.xy * vec2(16.0, 16.0) + u_xlat0.xw;
					        u_xlat0.xy = u_xlat0.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat0 = textureLod(_AreaTex, u_xlat0.xy, 0.0);
					        SV_Target0.zw = u_xlat0.xy;
					    } else {
					        SV_Target0.zw = vec2(0.0, 0.0);
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
			GpuProgramID 366722
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(0.5, -0.5, 0.5, -0.5) + vec4(0.0, 1.0, 0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.zw * _MainTex_TexelSize.zw;
					    u_xlat1 = _MainTex_TexelSize.xxyy * vec4(-0.25, 1.25, -0.125, -0.125) + u_xlat0.zzww;
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.125, -0.25, -0.125, 1.25) + u_xlat0;
					    vs_TEXCOORD2 = u_xlat1.xzyw;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat1.zw = u_xlat0.yw;
					    vs_TEXCOORD4 = _MainTex_TexelSize.xxyy * vec4(-32.0, 32.0, -32.0, 32.0) + u_xlat1;
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
					uniform 	vec4 _MainTex_TexelSize;
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(0.5, 0.5, 0.5, 0.5);
					    vs_TEXCOORD1.xy = u_xlat0.zw * _MainTex_TexelSize.zw;
					    u_xlat1 = _MainTex_TexelSize.xxyy * vec4(-0.25, 1.25, -0.125, -0.125) + u_xlat0.zzww;
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.125, -0.25, -0.125, 1.25) + u_xlat0;
					    vs_TEXCOORD2 = u_xlat1.xzyw;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat1.zw = u_xlat0.yw;
					    vs_TEXCOORD4 = _MainTex_TexelSize.xxyy * vec4(-32.0, 32.0, -32.0, 32.0) + u_xlat1;
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
					UNITY_LOCATION(1) uniform  sampler2D _AreaTex;
					UNITY_LOCATION(2) uniform  sampler2D _SearchTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					bvec4 u_xlatb4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bool u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat10;
					bool u_xlatb10;
					vec2 u_xlat14;
					bool u_xlatb14;
					vec2 u_xlat15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb7 = 0.0<u_xlat0.y;
					    if(u_xlatb7){
					        u_xlatb7 = 0.0<u_xlat0.x;
					        if(u_xlatb7){
					            u_xlat1.xy = _MainTex_TexelSize.xy * vec2(-1.0, 1.0);
					            u_xlat1.z = 1.0;
					            u_xlat2.xy = vs_TEXCOORD0.xy;
					            u_xlat3.x = 0.0;
					            u_xlat2.z = -1.0;
					            u_xlat4.x = 1.0;
					            while(true){
					                u_xlatb7 = u_xlat2.z<7.0;
					                u_xlatb14 = 0.899999976<u_xlat4.x;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                if(!u_xlatb7){break;}
					                u_xlat2.xyz = u_xlat1.xyz + u_xlat2.xyz;
					                u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0).yxzw;
					                u_xlat4.x = dot(u_xlat3.yx, vec2(0.5, 0.5));
					            }
					            u_xlatb7 = 0.899999976<u_xlat3.x;
					            u_xlat7.x = u_xlatb7 ? 1.0 : float(0.0);
					            u_xlat1.x = u_xlat7.x + u_xlat2.z;
					        } else {
					            u_xlat1.x = 0.0;
					            u_xlat4.x = 0.0;
					        }
					        u_xlat7.xy = _MainTex_TexelSize.xy * vec2(1.0, -1.0);
					        u_xlat7.z = 1.0;
					        u_xlat2.yz = vs_TEXCOORD0.xy;
					        u_xlat2.x = float(-1.0);
					        u_xlat23 = float(1.0);
					        while(true){
					            u_xlatb3 = u_xlat2.x<7.0;
					            u_xlatb10 = 0.899999976<u_xlat23;
					            u_xlatb3 = u_xlatb10 && u_xlatb3;
					            if(!u_xlatb3){break;}
					            u_xlat2.xyz = u_xlat7.zxy + u_xlat2.xyz;
					            u_xlat3 = textureLod(_MainTex, u_xlat2.yz, 0.0);
					            u_xlat23 = dot(u_xlat3.xy, vec2(0.5, 0.5));
					        }
					        u_xlat4.y = u_xlat23;
					        u_xlat7.x = u_xlat1.x + u_xlat2.x;
					        u_xlatb7 = 2.0<u_xlat7.x;
					        if(u_xlatb7){
					            u_xlat1.y = (-u_xlat1.x) + 0.25;
					            u_xlat1.zw = u_xlat2.xx * vec2(1.0, -1.0) + vec2(0.0, -0.25);
					            u_xlat2 = u_xlat1.yxzw * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
					            u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 1.0, 0.0) + u_xlat2;
					            u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					            u_xlat2 = textureLod(_MainTex, u_xlat2.zw, 0.0);
					            u_xlat3.z = u_xlat2.x;
					            u_xlat7.xy = u_xlat3.xz * vec2(5.0, 5.0) + vec2(-3.75, -3.75);
					            u_xlat7.xy = abs(u_xlat7.xy) * u_xlat3.xz;
					            u_xlat7.xy = roundEven(u_xlat7.xy);
					            u_xlat8.x = roundEven(u_xlat3.y);
					            u_xlat8.z = roundEven(u_xlat2.y);
					            u_xlat7.xy = u_xlat8.xz * vec2(2.0, 2.0) + u_xlat7.xy;
					            u_xlatb8.xz = greaterThanEqual(u_xlat4.xxyy, vec4(0.899999976, 0.0, 0.899999976, 0.899999976)).xz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? float(0.0) : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.z) ? float(0.0) : u_xlat7.y;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat7.xy = u_xlat7.xy * vec2(20.0, 20.0) + u_xlat1.xz;
					            u_xlat7.xy = u_xlat7.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.503125012, 0.000892857148);
					            u_xlat1 = textureLod(_AreaTex, u_xlat7.xy, 0.0);
					        } else {
					            u_xlat1.x = float(0.0);
					            u_xlat1.y = float(0.0);
					        }
					        u_xlat7.x = _MainTex_TexelSize.x * 0.25 + vs_TEXCOORD0.x;
					        u_xlat2.xy = (-_MainTex_TexelSize.xy);
					        u_xlat2.z = 1.0;
					        u_xlat10.x = u_xlat7.x;
					        u_xlat10.y = vs_TEXCOORD0.y;
					        u_xlat3.x = float(1.0);
					        u_xlat10.z = float(-1.0);
					        while(true){
					            u_xlatb14 = u_xlat10.z<7.0;
					            u_xlatb21 = 0.899999976<u_xlat3.x;
					            u_xlatb14 = u_xlatb21 && u_xlatb14;
					            if(!u_xlatb14){break;}
					            u_xlat10.xyz = u_xlat2.xyz + u_xlat10.xyz;
					            u_xlat4 = textureLod(_MainTex, u_xlat10.xy, 0.0);
					            u_xlat14.x = u_xlat4.x * 5.0 + -3.75;
					            u_xlat14.x = abs(u_xlat14.x) * u_xlat4.x;
					            u_xlat5.x = roundEven(u_xlat14.x);
					            u_xlat5.y = roundEven(u_xlat4.y);
					            u_xlat3.x = dot(u_xlat5.xy, vec2(0.5, 0.5));
					        }
					        u_xlat2.x = u_xlat10.z;
					        u_xlat14.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
					        u_xlat4 = textureLod(_MainTex, u_xlat14.xy, 0.0);
					        u_xlatb14 = 0.0<u_xlat4.x;
					        if(u_xlatb14){
					            u_xlat4.xy = _MainTex_TexelSize.xy;
					            u_xlat4.z = 1.0;
					            u_xlat5.x = u_xlat7.x;
					            u_xlat5.y = vs_TEXCOORD0.y;
					            u_xlat14.x = 0.0;
					            u_xlat5.z = -1.0;
					            u_xlat3.y = 1.0;
					            while(true){
					                u_xlatb15.x = u_xlat5.z<7.0;
					                u_xlatb22 = 0.899999976<u_xlat3.y;
					                u_xlatb15.x = u_xlatb22 && u_xlatb15.x;
					                if(!u_xlatb15.x){break;}
					                u_xlat5.xyz = u_xlat4.xyz + u_xlat5.xyz;
					                u_xlat6 = textureLod(_MainTex, u_xlat5.xy, 0.0);
					                u_xlat15.x = u_xlat6.x * 5.0 + -3.75;
					                u_xlat15.x = abs(u_xlat15.x) * u_xlat6.x;
					                u_xlat14.y = roundEven(u_xlat15.x);
					                u_xlat14.x = roundEven(u_xlat6.y);
					                u_xlat3.y = dot(u_xlat14.yx, vec2(0.5, 0.5));
					            }
					            u_xlatb7 = 0.899999976<u_xlat14.x;
					            u_xlat7.x = u_xlatb7 ? 1.0 : float(0.0);
					            u_xlat2.z = u_xlat7.x + u_xlat5.z;
					        } else {
					            u_xlat2.z = 0.0;
					            u_xlat3.y = 0.0;
					        }
					        u_xlat7.x = u_xlat2.z + u_xlat2.x;
					        u_xlatb7 = 2.0<u_xlat7.x;
					        if(u_xlatb7){
					            u_xlat2.y = (-u_xlat2.x);
					            u_xlat4 = u_xlat2.yyzz * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
					            u_xlat5 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 0.0, -1.0) + u_xlat4.xyxy;
					            u_xlat6 = textureLod(_MainTex, u_xlat5.xy, 0.0);
					            u_xlat5 = textureLod(_MainTex, u_xlat5.zw, 0.0).yzxw;
					            u_xlat7.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0) + u_xlat4.zw;
					            u_xlat4 = textureLod(_MainTex, u_xlat7.xy, 0.0);
					            u_xlat5.x = u_xlat6.y;
					            u_xlat5.yw = u_xlat4.yx;
					            u_xlat7.xy = u_xlat5.xy * vec2(2.0, 2.0) + u_xlat5.zw;
					            u_xlatb15.xy = greaterThanEqual(u_xlat3.xyxy, vec4(0.899999976, 0.899999976, 0.899999976, 0.899999976)).xy;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb15.x) ? float(0.0) : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb15.y) ? float(0.0) : u_xlat7.y;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat7.xy = u_xlat7.xy * vec2(20.0, 20.0) + u_xlat2.xz;
					            u_xlat7.xy = u_xlat7.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.503125012, 0.000892857148);
					            u_xlat2 = textureLod(_AreaTex, u_xlat7.xy, 0.0);
					            u_xlat1.xy = u_xlat1.xy + u_xlat2.yx;
					        }
					        u_xlatb7 = (-u_xlat1.y)==u_xlat1.x;
					        if(u_xlatb7){
					            u_xlat2.xy = vs_TEXCOORD2.xy;
					            u_xlat2.z = 1.0;
					            u_xlat3.x = 0.0;
					            while(true){
					                u_xlatb7 = vs_TEXCOORD4.x<u_xlat2.x;
					                u_xlatb14 = 0.828100026<u_xlat2.z;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                u_xlatb14 = u_xlat3.x==0.0;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                if(!u_xlatb7){break;}
					                u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					                u_xlat2.xy = _MainTex_TexelSize.xy * vec2(-2.0, -0.0) + u_xlat2.xy;
					                u_xlat2.z = u_xlat3.y;
					            }
					            u_xlat3.yz = u_xlat2.xz;
					            u_xlat7.xy = u_xlat3.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					            u_xlat2 = textureLod(_SearchTex, u_xlat7.xy, 0.0);
					            u_xlat7.x = u_xlat2.w * -2.00787401 + 3.25;
					            u_xlat2.x = _MainTex_TexelSize.x * u_xlat7.x + u_xlat3.y;
					            u_xlat2.y = vs_TEXCOORD3.y;
					            u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					            u_xlat4.xy = vs_TEXCOORD2.zw;
					            u_xlat4.z = 1.0;
					            u_xlat5.x = 0.0;
					            while(true){
					                u_xlatb7 = u_xlat4.x<vs_TEXCOORD4.y;
					                u_xlatb14 = 0.828100026<u_xlat4.z;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                u_xlatb14 = u_xlat5.x==0.0;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                if(!u_xlatb7){break;}
					                u_xlat5 = textureLod(_MainTex, u_xlat4.xy, 0.0);
					                u_xlat4.xy = _MainTex_TexelSize.xy * vec2(2.0, 0.0) + u_xlat4.xy;
					                u_xlat4.z = u_xlat5.y;
					            }
					            u_xlat5.yz = u_xlat4.xz;
					            u_xlat7.xy = u_xlat5.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					            u_xlat4 = textureLod(_SearchTex, u_xlat7.xy, 0.0);
					            u_xlat7.x = u_xlat4.w * -2.00787401 + 3.25;
					            u_xlat2.z = (-_MainTex_TexelSize.x) * u_xlat7.x + u_xlat5.y;
					            u_xlat4 = _MainTex_TexelSize.zzzz * u_xlat2.zxzx + (-vs_TEXCOORD1.xxxx);
					            u_xlat4 = roundEven(u_xlat4);
					            u_xlat7.xy = sqrt(abs(u_xlat4.wz));
					            u_xlat15.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0) + u_xlat2.zy;
					            u_xlat5 = textureLod(_MainTex, u_xlat15.xy, 0.0).yxzw;
					            u_xlat5.x = u_xlat3.x;
					            u_xlat15.xy = u_xlat5.xy * vec2(4.0, 4.0);
					            u_xlat15.xy = roundEven(u_xlat15.xy);
					            u_xlat7.xy = u_xlat15.xy * vec2(16.0, 16.0) + u_xlat7.xy;
					            u_xlat7.xy = u_xlat7.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					            u_xlat3 = textureLod(_AreaTex, u_xlat7.xy, 0.0);
					            u_xlatb4 = greaterThanEqual(abs(u_xlat4), abs(u_xlat4.wzwz));
					            u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					            u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					            u_xlat4.z = u_xlatb4.z ? float(0.75) : 0.0;
					            u_xlat4.w = u_xlatb4.w ? float(0.75) : 0.0;
					;
					            u_xlat7.x = u_xlat4.y + u_xlat4.x;
					            u_xlat7.xy = u_xlat4.zw / u_xlat7.xx;
					            u_xlat2.w = vs_TEXCOORD0.y;
					            u_xlat15.xy = _MainTex_TexelSize.xy * vec2(0.0, 1.0) + u_xlat2.xw;
					            u_xlat4 = textureLod(_MainTex, u_xlat15.xy, 0.0);
					            u_xlat21 = (-u_xlat7.x) * u_xlat4.x + 1.0;
					            u_xlat15.xy = u_xlat2.zw + _MainTex_TexelSize.xy;
					            u_xlat4 = textureLod(_MainTex, u_xlat15.xy, 0.0);
					            u_xlat4.x = (-u_xlat7.y) * u_xlat4.x + u_xlat21;
					            u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					            u_xlat2 = _MainTex_TexelSize.xyxy * vec4(0.0, -2.0, 1.0, -2.0) + u_xlat2.xwzw;
					            u_xlat5 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					            u_xlat7.x = (-u_xlat7.x) * u_xlat5.x + 1.0;
					            u_xlat2 = textureLod(_MainTex, u_xlat2.zw, 0.0);
					            u_xlat4.y = (-u_xlat7.y) * u_xlat2.x + u_xlat7.x;
					            u_xlat4.y = clamp(u_xlat4.y, 0.0, 1.0);
					            SV_Target0.xy = u_xlat3.xy * u_xlat4.xy;
					        } else {
					            SV_Target0.xy = u_xlat1.xy;
					            u_xlat0.x = 0.0;
					        }
					    } else {
					        SV_Target0.xy = vec2(0.0, 0.0);
					    }
					    u_xlatb0 = 0.0<u_xlat0.x;
					    if(u_xlatb0){
					        u_xlat0.xy = vs_TEXCOORD3.xy;
					        u_xlat0.z = 1.0;
					        u_xlat1.x = 0.0;
					        while(true){
					            u_xlatb21 = vs_TEXCOORD4.z<u_xlat0.y;
					            u_xlatb2.x = 0.828100026<u_xlat0.z;
					            u_xlatb21 = u_xlatb21 && u_xlatb2.x;
					            u_xlatb2.x = u_xlat1.x==0.0;
					            u_xlatb21 = u_xlatb21 && u_xlatb2.x;
					            if(!u_xlatb21){break;}
					            u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0).yxzw;
					            u_xlat0.xy = _MainTex_TexelSize.xy * vec2(-0.0, -2.0) + u_xlat0.xy;
					            u_xlat0.z = u_xlat1.y;
					        }
					        u_xlat1.yz = u_xlat0.yz;
					        u_xlat0.xy = u_xlat1.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat0 = textureLod(_SearchTex, u_xlat0.xy, 0.0);
					        u_xlat0.x = u_xlat0.w * -2.00787401 + 3.25;
					        u_xlat0.x = _MainTex_TexelSize.y * u_xlat0.x + u_xlat1.y;
					        u_xlat0.y = vs_TEXCOORD2.x;
					        u_xlat1 = textureLod(_MainTex, u_xlat0.yx, 0.0);
					        u_xlat2.xy = vs_TEXCOORD3.zw;
					        u_xlat2.z = 1.0;
					        u_xlat3.x = 0.0;
					        while(true){
					            u_xlatb1 = u_xlat2.y<vs_TEXCOORD4.w;
					            u_xlatb15.x = 0.828100026<u_xlat2.z;
					            u_xlatb1 = u_xlatb15.x && u_xlatb1;
					            u_xlatb15.x = u_xlat3.x==0.0;
					            u_xlatb1 = u_xlatb15.x && u_xlatb1;
					            if(!u_xlatb1){break;}
					            u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0).yxzw;
					            u_xlat2.xy = _MainTex_TexelSize.xy * vec2(0.0, 2.0) + u_xlat2.xy;
					            u_xlat2.z = u_xlat3.y;
					        }
					        u_xlat3.yz = u_xlat2.yz;
					        u_xlat1.xz = u_xlat3.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat2 = textureLod(_SearchTex, u_xlat1.xz, 0.0);
					        u_xlat1.x = u_xlat2.w * -2.00787401 + 3.25;
					        u_xlat0.z = (-_MainTex_TexelSize.y) * u_xlat1.x + u_xlat3.y;
					        u_xlat2 = _MainTex_TexelSize.wwww * u_xlat0.zxzx + (-vs_TEXCOORD1.yyyy);
					        u_xlat2 = roundEven(u_xlat2);
					        u_xlat1.xz = sqrt(abs(u_xlat2.wz));
					        u_xlat3.xy = _MainTex_TexelSize.xy * vec2(0.0, 1.0) + u_xlat0.yz;
					        u_xlat3 = textureLod(_MainTex, u_xlat3.xy, 0.0);
					        u_xlat3.x = u_xlat1.y;
					        u_xlat8.xz = u_xlat3.xy * vec2(4.0, 4.0);
					        u_xlat8.xz = roundEven(u_xlat8.xz);
					        u_xlat1.xy = u_xlat8.xz * vec2(16.0, 16.0) + u_xlat1.xz;
					        u_xlat1.xy = u_xlat1.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat1 = textureLod(_AreaTex, u_xlat1.xy, 0.0);
					        u_xlatb2 = greaterThanEqual(abs(u_xlat2), abs(u_xlat2.wzwz));
					        u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					        u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
					        u_xlat2.z = u_xlatb2.z ? float(0.75) : 0.0;
					        u_xlat2.w = u_xlatb2.w ? float(0.75) : 0.0;
					;
					        u_xlat7.x = u_xlat2.y + u_xlat2.x;
					        u_xlat15.xy = u_xlat2.zw / u_xlat7.xx;
					        u_xlat0.w = vs_TEXCOORD0.x;
					        u_xlat2.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0) + u_xlat0.wx;
					        u_xlat2 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					        u_xlat7.x = (-u_xlat15.x) * u_xlat2.y + 1.0;
					        u_xlat2.xy = u_xlat0.wz + _MainTex_TexelSize.xy;
					        u_xlat2 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					        u_xlat16.x = (-u_xlat15.y) * u_xlat2.y + u_xlat7.x;
					        u_xlat16.x = clamp(u_xlat16.x, 0.0, 1.0);
					        u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-2.0, 0.0, -2.0, 1.0) + u_xlat0.wxwz;
					        u_xlat3 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					        u_xlat0.x = (-u_xlat15.x) * u_xlat3.y + 1.0;
					        u_xlat3 = textureLod(_MainTex, u_xlat0.zw, 0.0);
					        u_xlat16.y = (-u_xlat15.y) * u_xlat3.y + u_xlat0.x;
					        u_xlat16.y = clamp(u_xlat16.y, 0.0, 1.0);
					        SV_Target0.zw = u_xlat1.xy * u_xlat16.xy;
					    } else {
					        SV_Target0.zw = vec2(0.0, 0.0);
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
					; Bound: 108
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %33 %53 %83 %86 %92 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                             OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD0 Location 33 
					                                             OpDecorate vs_TEXCOORD1 Location 53 
					                                             OpMemberDecorate %56 0 Offset 56 
					                                             OpDecorate %56 Block 
					                                             OpDecorate %58 DescriptorSet 58 
					                                             OpDecorate %58 Binding 58 
					                                             OpDecorate vs_TEXCOORD2 Location 83 
					                                             OpDecorate vs_TEXCOORD3 Location 86 
					                                             OpDecorate vs_TEXCOORD4 Location 92 
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
					                                     %32 = OpTypePointer Output %19 
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                 f32 %36 = OpConstant 3,674022E-40 
					                                 f32 %37 = OpConstant 3,674022E-40 
					                               f32_2 %38 = OpConstantComposite %36 %37 
					                               f32_2 %40 = OpConstantComposite %36 %36 
					                                     %42 = OpTypePointer Private %7 
					                      Private f32_4* %43 = OpVariable Private 
					                               f32_4 %46 = OpConstantComposite %27 %27 %27 %27 
					                               f32_4 %49 = OpConstantComposite %36 %37 %36 %37 
					                               f32_4 %51 = OpConstantComposite %26 %27 %26 %27 
					              Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                     %56 = OpTypeStruct %7 
					                                     %57 = OpTypePointer Uniform %56 
					            Uniform struct {f32_4;}* %58 = OpVariable Uniform 
					                                     %59 = OpTypePointer Uniform %7 
					                      Private f32_4* %64 = OpVariable Private 
					                                 f32 %68 = OpConstant 3,674022E-40 
					                                 f32 %69 = OpConstant 3,674022E-40 
					                                 f32 %70 = OpConstant 3,674022E-40 
					                               f32_4 %71 = OpConstantComposite %68 %69 %70 %70 
					                               f32_4 %79 = OpConstantComposite %70 %68 %70 %69 
					              Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					              Output f32_4* vs_TEXCOORD3 = OpVariable Output 
					              Output f32_4* vs_TEXCOORD4 = OpVariable Output 
					                                 f32 %96 = OpConstant 3,674022E-40 
					                                 f32 %97 = OpConstant 3,674022E-40 
					                               f32_4 %98 = OpConstantComposite %96 %97 %96 %97 
					                                    %102 = OpTypePointer Output %6 
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
					                                             OpStore vs_TEXCOORD0 %41 
					                               f32_3 %44 = OpLoad %18 
					                               f32_4 %45 = OpVectorShuffle %44 %44 0 1 0 1 
					                               f32_4 %47 = OpFAdd %45 %46 
					                                             OpStore %43 %47 
					                               f32_4 %48 = OpLoad %43 
					                               f32_4 %50 = OpFMul %48 %49 
					                               f32_4 %52 = OpFAdd %50 %51 
					                                             OpStore %43 %52 
					                               f32_4 %54 = OpLoad %43 
					                               f32_2 %55 = OpVectorShuffle %54 %54 2 3 
					                      Uniform f32_4* %60 = OpAccessChain %58 %15 
					                               f32_4 %61 = OpLoad %60 
					                               f32_2 %62 = OpVectorShuffle %61 %61 2 3 
					                               f32_2 %63 = OpFMul %55 %62 
					                                             OpStore vs_TEXCOORD1 %63 
					                      Uniform f32_4* %65 = OpAccessChain %58 %15 
					                               f32_4 %66 = OpLoad %65 
					                               f32_4 %67 = OpVectorShuffle %66 %66 0 0 1 1 
					                               f32_4 %72 = OpFMul %67 %71 
					                               f32_4 %73 = OpLoad %43 
					                               f32_4 %74 = OpVectorShuffle %73 %73 2 2 3 3 
					                               f32_4 %75 = OpFAdd %72 %74 
					                                             OpStore %64 %75 
					                      Uniform f32_4* %76 = OpAccessChain %58 %15 
					                               f32_4 %77 = OpLoad %76 
					                               f32_4 %78 = OpVectorShuffle %77 %77 0 1 0 1 
					                               f32_4 %80 = OpFMul %78 %79 
					                               f32_4 %81 = OpLoad %43 
					                               f32_4 %82 = OpFAdd %80 %81 
					                                             OpStore %43 %82 
					                               f32_4 %84 = OpLoad %64 
					                               f32_4 %85 = OpVectorShuffle %84 %84 0 2 1 3 
					                                             OpStore vs_TEXCOORD2 %85 
					                               f32_4 %87 = OpLoad %43 
					                                             OpStore vs_TEXCOORD3 %87 
					                               f32_4 %88 = OpLoad %43 
					                               f32_2 %89 = OpVectorShuffle %88 %88 1 3 
					                               f32_4 %90 = OpLoad %64 
					                               f32_4 %91 = OpVectorShuffle %90 %89 0 1 4 5 
					                                             OpStore %64 %91 
					                      Uniform f32_4* %93 = OpAccessChain %58 %15 
					                               f32_4 %94 = OpLoad %93 
					                               f32_4 %95 = OpVectorShuffle %94 %94 0 0 1 1 
					                               f32_4 %99 = OpFMul %95 %98 
					                              f32_4 %100 = OpLoad %64 
					                              f32_4 %101 = OpFAdd %99 %100 
					                                             OpStore vs_TEXCOORD4 %101 
					                        Output f32* %103 = OpAccessChain %13 %15 %9 
					                                f32 %104 = OpLoad %103 
					                                f32 %105 = OpFNegate %104 
					                        Output f32* %106 = OpAccessChain %13 %15 %9 
					                                             OpStore %106 %105 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 1427
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %22 %672 %684 %768 %870 %1037 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                              OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
					                                              OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpDecorate %12 DescriptorSet 12 
					                                              OpDecorate %12 Binding 12 
					                                              OpDecorate %16 DescriptorSet 16 
					                                              OpDecorate %16 Binding 16 
					                                              OpDecorate vs_TEXCOORD0 Location 22 
					                                              OpMemberDecorate %49 0 Offset 49 
					                                              OpDecorate %49 Block 
					                                              OpDecorate %51 DescriptorSet 51 
					                                              OpDecorate %51 Binding 51 
					                                              OpDecorate %354 DescriptorSet 354 
					                                              OpDecorate %354 Binding 354 
					                                              OpDecorate vs_TEXCOORD2 Location 672 
					                                              OpDecorate vs_TEXCOORD4 Location 684 
					                                              OpDecorate %746 DescriptorSet 746 
					                                              OpDecorate %746 Binding 746 
					                                              OpDecorate vs_TEXCOORD3 Location 768 
					                                              OpDecorate vs_TEXCOORD1 Location 870 
					                                              OpDecorate %1037 Location 1037 
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
					                                      %28 = OpTypeBool 
					                                      %29 = OpTypePointer Private %28 
					                        Private bool* %30 = OpVariable Private 
					                                  f32 %31 = OpConstant 3,674022E-40 
					                                      %32 = OpTypeInt 32 0 
					                                  u32 %33 = OpConstant 1 
					                                      %34 = OpTypePointer Private %6 
					                                  u32 %41 = OpConstant 0 
					                       Private f32_4* %48 = OpVariable Private 
					                                      %49 = OpTypeStruct %7 
					                                      %50 = OpTypePointer Uniform %49 
					             Uniform struct {f32_4;}* %51 = OpVariable Uniform 
					                                      %52 = OpTypeInt 32 1 
					                                  i32 %53 = OpConstant 0 
					                                      %54 = OpTypePointer Uniform %7 
					                                  f32 %58 = OpConstant 3,674022E-40 
					                                  f32 %59 = OpConstant 3,674022E-40 
					                                f32_2 %60 = OpConstantComposite %58 %59 
					                                  u32 %64 = OpConstant 2 
					                       Private f32_4* %66 = OpVariable Private 
					                                      %70 = OpTypeVector %6 3 
					                                      %71 = OpTypePointer Private %70 
					                       Private f32_3* %72 = OpVariable Private 
					                       Private f32_4* %75 = OpVariable Private 
					                                 bool %82 = OpConstantTrue 
					                        Private bool* %83 = OpVariable Private 
					                                  f32 %86 = OpConstant 3,674022E-40 
					                        Private bool* %88 = OpVariable Private 
					                                  f32 %89 = OpConstant 3,674022E-40 
					                                 f32 %119 = OpConstant 3,674022E-40 
					                               f32_2 %120 = OpConstantComposite %119 %119 
					                               f32_2 %141 = OpConstantComposite %59 %58 
					                        Private f32* %150 = OpVariable Private 
					                       Private bool* %156 = OpVariable Private 
					                       Private bool* %160 = OpVariable Private 
					                                     %178 = OpTypePointer Private %20 
					                      Private f32_2* %179 = OpVariable Private 
					                                 f32 %197 = OpConstant 3,674022E-40 
					                                 f32 %207 = OpConstant 3,674022E-40 
					                                 f32 %213 = OpConstant 3,674022E-40 
					                               f32_2 %214 = OpConstantComposite %31 %213 
					                                     %232 = OpTypeVector %52 2 
					                                 i32 %233 = OpConstant -1 
					                               i32_2 %234 = OpConstantComposite %233 %53 
					                      Private f32_3* %239 = OpVariable Private 
					                                 i32 %245 = OpConstant 1 
					                               i32_2 %246 = OpConstantComposite %245 %53 
					                                 f32 %256 = OpConstant 3,674022E-40 
					                               f32_2 %257 = OpConstantComposite %256 %256 
					                                 f32 %259 = OpConstant 3,674022E-40 
					                               f32_2 %260 = OpConstantComposite %259 %259 
					                      Private f32_3* %277 = OpVariable Private 
					                               f32_2 %288 = OpConstantComposite %197 %197 
					                                     %295 = OpTypeVector %28 3 
					                                     %296 = OpTypePointer Private %295 
					                     Private bool_3* %297 = OpVariable Private 
					                               f32_4 %300 = OpConstantComposite %89 %31 %89 %89 
					                                     %301 = OpTypeVector %28 4 
					                                     %303 = OpTypeVector %28 2 
					                                     %307 = OpTypePointer Function %70 
					                                     %312 = OpTypePointer Function %6 
					                                 f32 %334 = OpConstant 3,674022E-40 
					                               f32_2 %335 = OpConstantComposite %334 %334 
					                                 f32 %344 = OpConstant 3,674022E-40 
					                                 f32 %345 = OpConstant 3,674022E-40 
					                               f32_2 %346 = OpConstantComposite %344 %345 
					                                 f32 %348 = OpConstant 3,674022E-40 
					                                 f32 %349 = OpConstant 3,674022E-40 
					                               f32_2 %350 = OpConstantComposite %348 %349 
					UniformConstant read_only Texture2D* %354 = OpVariable UniformConstant 
					                        Private f32* %367 = OpVariable Private 
					                                     %368 = OpTypePointer Uniform %6 
					                                     %372 = OpTypePointer Input %6 
					                                     %398 = OpTypePointer Private %301 
					                     Private bool_4* %399 = OpVariable Private 
					                        Private f32* %426 = OpVariable Private 
					                      Private f32_4* %436 = OpVariable Private 
					                      Private f32_2* %475 = OpVariable Private 
					                      Private f32_2* %503 = OpVariable Private 
					                               i32_2 %580 = OpConstantComposite %53 %233 
					                     Private bool_4* %601 = OpVariable Private 
					                               f32_4 %604 = OpConstantComposite %89 %89 %31 %31 
					                                     %671 = OpTypePointer Input %7 
					                Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                Input f32_4* vs_TEXCOORD4 = OpVariable Input 
					                                 f32 %690 = OpConstant 3,674022E-40 
					                                 f32 %720 = OpConstant 3,674022E-40 
					                                 f32 %721 = OpConstant 3,674022E-40 
					                               f32_2 %722 = OpConstantComposite %720 %721 
					                               f32_2 %738 = OpConstantComposite %119 %720 
					                                 f32 %740 = OpConstant 3,674022E-40 
					                                 f32 %741 = OpConstant 3,674022E-40 
					                               f32_2 %742 = OpConstantComposite %740 %741 
					UniformConstant read_only Texture2D* %746 = OpVariable UniformConstant 
					                                 u32 %753 = OpConstant 3 
					                                 f32 %756 = OpConstant 3,674022E-40 
					                                 f32 %758 = OpConstant 3,674022E-40 
					                Input f32_4* vs_TEXCOORD3 = OpVariable Input 
					                       Private bool* %796 = OpVariable Private 
					                               f32_2 %826 = OpConstantComposite %197 %31 
					                                 f32 %843 = OpConstant 3,674022E-40 
					                               f32_2 %844 = OpConstantComposite %843 %741 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                 f32 %891 = OpConstant 3,674022E-40 
					                               f32_2 %892 = OpConstantComposite %891 %891 
					                                 f32 %903 = OpConstant 3,674022E-40 
					                               f32_2 %904 = OpConstantComposite %903 %903 
					                                 f32 %913 = OpConstant 3,674022E-40 
					                               f32_2 %914 = OpConstantComposite %913 %349 
					                                 f32 %943 = OpConstant 3,674022E-40 
					                               i32_2 %968 = OpConstantComposite %53 %245 
					                               i32_2 %982 = OpConstantComposite %245 %245 
					                                i32 %1004 = OpConstant -2 
					                              i32_2 %1005 = OpConstantComposite %53 %1004 
					                              i32_2 %1019 = OpConstantComposite %245 %1004 
					                                    %1036 = OpTypePointer Output %7 
					                      Output f32_4* %1037 = OpVariable Output 
					                              f32_2 %1052 = OpConstantComposite %31 %31 
					                      Private bool* %1055 = OpVariable Private 
					                              f32_2 %1107 = OpConstantComposite %721 %720 
					                      Private bool* %1171 = OpVariable Private 
					                              f32_2 %1206 = OpConstantComposite %31 %197 
					                     Private f32_2* %1220 = OpVariable Private 
					                              i32_2 %1382 = OpConstantComposite %1004 %53 
					                              i32_2 %1399 = OpConstantComposite %1004 %245 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                     Function f32_3* %308 = OpVariable Function 
					                       Function f32* %313 = OpVariable Function 
					                       Function f32* %323 = OpVariable Function 
					                     Function f32_3* %609 = OpVariable Function 
					                       Function f32* %613 = OpVariable Function 
					                       Function f32* %623 = OpVariable Function 
					                  read_only Texture2D %13 = OpLoad %12 
					                              sampler %17 = OpLoad %16 
					           read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                f32_2 %23 = OpLoad vs_TEXCOORD0 
					                                f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                f32_2 %25 = OpVectorShuffle %24 %24 0 1 
					                                f32_4 %26 = OpLoad %9 
					                                f32_4 %27 = OpVectorShuffle %26 %25 4 5 2 3 
					                                              OpStore %9 %27 
					                         Private f32* %35 = OpAccessChain %9 %33 
					                                  f32 %36 = OpLoad %35 
					                                 bool %37 = OpFOrdLessThan %31 %36 
					                                              OpStore %30 %37 
					                                 bool %38 = OpLoad %30 
					                                              OpSelectionMerge %40 None 
					                                              OpBranchConditional %38 %39 %1051 
					                                      %39 = OpLabel 
					                         Private f32* %42 = OpAccessChain %9 %41 
					                                  f32 %43 = OpLoad %42 
					                                 bool %44 = OpFOrdLessThan %31 %43 
					                                              OpStore %30 %44 
					                                 bool %45 = OpLoad %30 
					                                              OpSelectionMerge %47 None 
					                                              OpBranchConditional %45 %46 %135 
					                                      %46 = OpLabel 
					                       Uniform f32_4* %55 = OpAccessChain %51 %53 
					                                f32_4 %56 = OpLoad %55 
					                                f32_2 %57 = OpVectorShuffle %56 %56 0 1 
					                                f32_2 %61 = OpFMul %57 %60 
					                                f32_4 %62 = OpLoad %48 
					                                f32_4 %63 = OpVectorShuffle %62 %61 4 5 2 3 
					                                              OpStore %48 %63 
					                         Private f32* %65 = OpAccessChain %48 %64 
					                                              OpStore %65 %59 
					                                f32_2 %67 = OpLoad vs_TEXCOORD0 
					                                f32_4 %68 = OpLoad %66 
					                                f32_4 %69 = OpVectorShuffle %68 %67 4 5 2 3 
					                                              OpStore %66 %69 
					                         Private f32* %73 = OpAccessChain %72 %41 
					                                              OpStore %73 %31 
					                         Private f32* %74 = OpAccessChain %66 %64 
					                                              OpStore %74 %58 
					                         Private f32* %76 = OpAccessChain %75 %41 
					                                              OpStore %76 %59 
					                                              OpBranch %77 
					                                      %77 = OpLabel 
					                                              OpLoopMerge %79 %80 None 
					                                              OpBranch %81 
					                                      %81 = OpLabel 
					                                              OpBranchConditional %82 %78 %79 
					                                      %78 = OpLabel 
					                         Private f32* %84 = OpAccessChain %66 %64 
					                                  f32 %85 = OpLoad %84 
					                                 bool %87 = OpFOrdLessThan %85 %86 
					                                              OpStore %83 %87 
					                         Private f32* %90 = OpAccessChain %75 %41 
					                                  f32 %91 = OpLoad %90 
					                                 bool %92 = OpFOrdLessThan %89 %91 
					                                              OpStore %88 %92 
					                                 bool %93 = OpLoad %83 
					                                 bool %94 = OpLoad %88 
					                                 bool %95 = OpLogicalAnd %93 %94 
					                                              OpStore %83 %95 
					                                 bool %96 = OpLoad %83 
					                                 bool %97 = OpLogicalNot %96 
					                                              OpSelectionMerge %99 None 
					                                              OpBranchConditional %97 %98 %99 
					                                      %98 = OpLabel 
					                                              OpBranch %79 
					                                      %99 = OpLabel 
					                               f32_4 %101 = OpLoad %48 
					                               f32_3 %102 = OpVectorShuffle %101 %101 0 1 2 
					                               f32_4 %103 = OpLoad %66 
					                               f32_3 %104 = OpVectorShuffle %103 %103 0 1 2 
					                               f32_3 %105 = OpFAdd %102 %104 
					                               f32_4 %106 = OpLoad %66 
					                               f32_4 %107 = OpVectorShuffle %106 %105 4 5 6 3 
					                                              OpStore %66 %107 
					                 read_only Texture2D %108 = OpLoad %12 
					                             sampler %109 = OpLoad %16 
					          read_only Texture2DSampled %110 = OpSampledImage %108 %109 
					                               f32_4 %111 = OpLoad %66 
					                               f32_2 %112 = OpVectorShuffle %111 %111 0 1 
					                               f32_4 %113 = OpImageSampleExplicitLod %110 %112 Lod %7 
					                               f32_2 %114 = OpVectorShuffle %113 %113 1 0 
					                               f32_3 %115 = OpLoad %72 
					                               f32_3 %116 = OpVectorShuffle %115 %114 3 4 2 
					                                              OpStore %72 %116 
					                               f32_3 %117 = OpLoad %72 
					                               f32_2 %118 = OpVectorShuffle %117 %117 1 0 
					                                 f32 %121 = OpDot %118 %120 
					                        Private f32* %122 = OpAccessChain %75 %41 
					                                              OpStore %122 %121 
					                                              OpBranch %80 
					                                      %80 = OpLabel 
					                                              OpBranch %77 
					                                      %79 = OpLabel 
					                        Private f32* %123 = OpAccessChain %72 %41 
					                                 f32 %124 = OpLoad %123 
					                                bool %125 = OpFOrdLessThan %89 %124 
					                                              OpStore %30 %125 
					                                bool %126 = OpLoad %30 
					                                 f32 %127 = OpSelect %126 %59 %31 
					                        Private f32* %128 = OpAccessChain %72 %41 
					                                              OpStore %128 %127 
					                        Private f32* %129 = OpAccessChain %72 %41 
					                                 f32 %130 = OpLoad %129 
					                        Private f32* %131 = OpAccessChain %66 %64 
					                                 f32 %132 = OpLoad %131 
					                                 f32 %133 = OpFAdd %130 %132 
					                        Private f32* %134 = OpAccessChain %48 %41 
					                                              OpStore %134 %133 
					                                              OpBranch %47 
					                                     %135 = OpLabel 
					                        Private f32* %136 = OpAccessChain %48 %41 
					                                              OpStore %136 %31 
					                        Private f32* %137 = OpAccessChain %75 %41 
					                                              OpStore %137 %31 
					                                              OpBranch %47 
					                                      %47 = OpLabel 
					                      Uniform f32_4* %138 = OpAccessChain %51 %53 
					                               f32_4 %139 = OpLoad %138 
					                               f32_2 %140 = OpVectorShuffle %139 %139 0 1 
					                               f32_2 %142 = OpFMul %140 %141 
					                               f32_3 %143 = OpLoad %72 
					                               f32_3 %144 = OpVectorShuffle %143 %142 3 4 2 
					                                              OpStore %72 %144 
					                        Private f32* %145 = OpAccessChain %72 %64 
					                                              OpStore %145 %59 
					                               f32_2 %146 = OpLoad vs_TEXCOORD0 
					                               f32_4 %147 = OpLoad %66 
					                               f32_4 %148 = OpVectorShuffle %147 %146 0 4 5 3 
					                                              OpStore %66 %148 
					                        Private f32* %149 = OpAccessChain %66 %41 
					                                              OpStore %149 %58 
					                                              OpStore %150 %59 
					                                              OpBranch %151 
					                                     %151 = OpLabel 
					                                              OpLoopMerge %153 %154 None 
					                                              OpBranch %155 
					                                     %155 = OpLabel 
					                                              OpBranchConditional %82 %152 %153 
					                                     %152 = OpLabel 
					                        Private f32* %157 = OpAccessChain %66 %41 
					                                 f32 %158 = OpLoad %157 
					                                bool %159 = OpFOrdLessThan %158 %86 
					                                              OpStore %156 %159 
					                                 f32 %161 = OpLoad %150 
					                                bool %162 = OpFOrdLessThan %89 %161 
					                                              OpStore %160 %162 
					                                bool %163 = OpLoad %160 
					                                bool %164 = OpLoad %156 
					                                bool %165 = OpLogicalAnd %163 %164 
					                                              OpStore %156 %165 
					                                bool %166 = OpLoad %156 
					                                bool %167 = OpLogicalNot %166 
					                                              OpSelectionMerge %169 None 
					                                              OpBranchConditional %167 %168 %169 
					                                     %168 = OpLabel 
					                                              OpBranch %153 
					                                     %169 = OpLabel 
					                               f32_3 %171 = OpLoad %72 
					                               f32_3 %172 = OpVectorShuffle %171 %171 2 0 1 
					                               f32_4 %173 = OpLoad %66 
					                               f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                               f32_3 %175 = OpFAdd %172 %174 
					                               f32_4 %176 = OpLoad %66 
					                               f32_4 %177 = OpVectorShuffle %176 %175 4 5 6 3 
					                                              OpStore %66 %177 
					                 read_only Texture2D %180 = OpLoad %12 
					                             sampler %181 = OpLoad %16 
					          read_only Texture2DSampled %182 = OpSampledImage %180 %181 
					                               f32_4 %183 = OpLoad %66 
					                               f32_2 %184 = OpVectorShuffle %183 %183 1 2 
					                               f32_4 %185 = OpImageSampleExplicitLod %182 %184 Lod %7 
					                               f32_2 %186 = OpVectorShuffle %185 %185 0 1 
					                                              OpStore %179 %186 
					                               f32_2 %187 = OpLoad %179 
					                                 f32 %188 = OpDot %187 %120 
					                                              OpStore %150 %188 
					                                              OpBranch %154 
					                                     %154 = OpLabel 
					                                              OpBranch %151 
					                                     %153 = OpLabel 
					                                 f32 %189 = OpLoad %150 
					                        Private f32* %190 = OpAccessChain %75 %33 
					                                              OpStore %190 %189 
					                        Private f32* %191 = OpAccessChain %48 %41 
					                                 f32 %192 = OpLoad %191 
					                        Private f32* %193 = OpAccessChain %66 %41 
					                                 f32 %194 = OpLoad %193 
					                                 f32 %195 = OpFAdd %192 %194 
					                        Private f32* %196 = OpAccessChain %72 %41 
					                                              OpStore %196 %195 
					                        Private f32* %198 = OpAccessChain %72 %41 
					                                 f32 %199 = OpLoad %198 
					                                bool %200 = OpFOrdLessThan %197 %199 
					                                              OpStore %30 %200 
					                                bool %201 = OpLoad %30 
					                                              OpSelectionMerge %203 None 
					                                              OpBranchConditional %201 %202 %364 
					                                     %202 = OpLabel 
					                        Private f32* %204 = OpAccessChain %48 %41 
					                                 f32 %205 = OpLoad %204 
					                                 f32 %206 = OpFNegate %205 
					                                 f32 %208 = OpFAdd %206 %207 
					                        Private f32* %209 = OpAccessChain %48 %33 
					                                              OpStore %209 %208 
					                               f32_4 %210 = OpLoad %66 
					                               f32_2 %211 = OpVectorShuffle %210 %210 0 0 
					                               f32_2 %212 = OpFMul %211 %141 
					                               f32_2 %215 = OpFAdd %212 %214 
					                               f32_4 %216 = OpLoad %48 
					                               f32_4 %217 = OpVectorShuffle %216 %215 0 1 4 5 
					                                              OpStore %48 %217 
					                               f32_4 %218 = OpLoad %48 
					                               f32_4 %219 = OpVectorShuffle %218 %218 1 0 2 3 
					                      Uniform f32_4* %220 = OpAccessChain %51 %53 
					                               f32_4 %221 = OpLoad %220 
					                               f32_4 %222 = OpVectorShuffle %221 %221 0 1 0 1 
					                               f32_4 %223 = OpFMul %219 %222 
					                               f32_2 %224 = OpLoad vs_TEXCOORD0 
					                               f32_4 %225 = OpVectorShuffle %224 %224 0 1 0 1 
					                               f32_4 %226 = OpFAdd %223 %225 
					                                              OpStore %66 %226 
					                 read_only Texture2D %227 = OpLoad %12 
					                             sampler %228 = OpLoad %16 
					          read_only Texture2DSampled %229 = OpSampledImage %227 %228 
					                               f32_4 %230 = OpLoad %66 
					                               f32_2 %231 = OpVectorShuffle %230 %230 0 1 
					                               f32_4 %235 = OpImageSampleExplicitLod %229 %231 Lod %7ConstOffset %235 
					                               f32_2 %236 = OpVectorShuffle %235 %235 0 1 
					                               f32_3 %237 = OpLoad %72 
					                               f32_3 %238 = OpVectorShuffle %237 %236 3 4 2 
					                                              OpStore %72 %238 
					                 read_only Texture2D %240 = OpLoad %12 
					                             sampler %241 = OpLoad %16 
					          read_only Texture2DSampled %242 = OpSampledImage %240 %241 
					                               f32_4 %243 = OpLoad %66 
					                               f32_2 %244 = OpVectorShuffle %243 %243 2 3 
					                               f32_4 %247 = OpImageSampleExplicitLod %242 %244 Lod %7ConstOffset %247 
					                               f32_2 %248 = OpVectorShuffle %247 %247 0 1 
					                               f32_3 %249 = OpLoad %239 
					                               f32_3 %250 = OpVectorShuffle %249 %248 3 1 4 
					                                              OpStore %239 %250 
					                        Private f32* %251 = OpAccessChain %239 %41 
					                                 f32 %252 = OpLoad %251 
					                        Private f32* %253 = OpAccessChain %72 %64 
					                                              OpStore %253 %252 
					                               f32_3 %254 = OpLoad %72 
					                               f32_2 %255 = OpVectorShuffle %254 %254 0 2 
					                               f32_2 %258 = OpFMul %255 %257 
					                               f32_2 %261 = OpFAdd %258 %260 
					                               f32_4 %262 = OpLoad %66 
					                               f32_4 %263 = OpVectorShuffle %262 %261 4 5 2 3 
					                                              OpStore %66 %263 
					                               f32_3 %264 = OpLoad %72 
					                               f32_2 %265 = OpVectorShuffle %264 %264 0 2 
					                               f32_4 %266 = OpLoad %66 
					                               f32_2 %267 = OpVectorShuffle %266 %266 0 1 
					                               f32_2 %268 = OpExtInst %1 4 %267 
					                               f32_2 %269 = OpFMul %265 %268 
					                               f32_3 %270 = OpLoad %72 
					                               f32_3 %271 = OpVectorShuffle %270 %269 3 1 4 
					                                              OpStore %72 %271 
					                               f32_3 %272 = OpLoad %72 
					                               f32_2 %273 = OpVectorShuffle %272 %272 0 2 
					                               f32_2 %274 = OpExtInst %1 2 %273 
					                               f32_3 %275 = OpLoad %72 
					                               f32_3 %276 = OpVectorShuffle %275 %274 3 1 4 
					                                              OpStore %72 %276 
					                        Private f32* %278 = OpAccessChain %72 %33 
					                                 f32 %279 = OpLoad %278 
					                                 f32 %280 = OpExtInst %1 2 %279 
					                        Private f32* %281 = OpAccessChain %277 %41 
					                                              OpStore %281 %280 
					                        Private f32* %282 = OpAccessChain %239 %64 
					                                 f32 %283 = OpLoad %282 
					                                 f32 %284 = OpExtInst %1 2 %283 
					                        Private f32* %285 = OpAccessChain %277 %64 
					                                              OpStore %285 %284 
					                               f32_3 %286 = OpLoad %277 
					                               f32_2 %287 = OpVectorShuffle %286 %286 0 2 
					                               f32_2 %289 = OpFMul %287 %288 
					                               f32_3 %290 = OpLoad %72 
					                               f32_2 %291 = OpVectorShuffle %290 %290 0 2 
					                               f32_2 %292 = OpFAdd %289 %291 
					                               f32_3 %293 = OpLoad %72 
					                               f32_3 %294 = OpVectorShuffle %293 %292 3 4 2 
					                                              OpStore %72 %294 
					                               f32_4 %298 = OpLoad %75 
					                               f32_4 %299 = OpVectorShuffle %298 %298 0 0 1 1 
					                              bool_4 %302 = OpFOrdGreaterThanEqual %299 %300 
					                              bool_2 %304 = OpVectorShuffle %302 %302 0 2 
					                              bool_3 %305 = OpLoad %297 
					                              bool_3 %306 = OpVectorShuffle %305 %304 3 1 4 
					                                              OpStore %297 %306 
					                               f32_3 %309 = OpLoad %72 
					                                              OpStore %308 %309 
					                       Private bool* %310 = OpAccessChain %297 %41 
					                                bool %311 = OpLoad %310 
					                                              OpSelectionMerge %315 None 
					                                              OpBranchConditional %311 %314 %316 
					                                     %314 = OpLabel 
					                                              OpStore %313 %31 
					                                              OpBranch %315 
					                                     %316 = OpLabel 
					                        Private f32* %317 = OpAccessChain %72 %41 
					                                 f32 %318 = OpLoad %317 
					                                              OpStore %313 %318 
					                                              OpBranch %315 
					                                     %315 = OpLabel 
					                                 f32 %319 = OpLoad %313 
					                       Function f32* %320 = OpAccessChain %308 %41 
					                                              OpStore %320 %319 
					                       Private bool* %321 = OpAccessChain %297 %64 
					                                bool %322 = OpLoad %321 
					                                              OpSelectionMerge %325 None 
					                                              OpBranchConditional %322 %324 %326 
					                                     %324 = OpLabel 
					                                              OpStore %323 %31 
					                                              OpBranch %325 
					                                     %326 = OpLabel 
					                        Private f32* %327 = OpAccessChain %72 %33 
					                                 f32 %328 = OpLoad %327 
					                                              OpStore %323 %328 
					                                              OpBranch %325 
					                                     %325 = OpLabel 
					                                 f32 %329 = OpLoad %323 
					                       Function f32* %330 = OpAccessChain %308 %33 
					                                              OpStore %330 %329 
					                               f32_3 %331 = OpLoad %308 
					                                              OpStore %72 %331 
					                               f32_3 %332 = OpLoad %72 
					                               f32_2 %333 = OpVectorShuffle %332 %332 0 1 
					                               f32_2 %336 = OpFMul %333 %335 
					                               f32_4 %337 = OpLoad %48 
					                               f32_2 %338 = OpVectorShuffle %337 %337 0 2 
					                               f32_2 %339 = OpFAdd %336 %338 
					                               f32_3 %340 = OpLoad %72 
					                               f32_3 %341 = OpVectorShuffle %340 %339 3 4 2 
					                                              OpStore %72 %341 
					                               f32_3 %342 = OpLoad %72 
					                               f32_2 %343 = OpVectorShuffle %342 %342 0 1 
					                               f32_2 %347 = OpFMul %343 %346 
					                               f32_2 %351 = OpFAdd %347 %350 
					                               f32_3 %352 = OpLoad %72 
					                               f32_3 %353 = OpVectorShuffle %352 %351 3 4 2 
					                                              OpStore %72 %353 
					                 read_only Texture2D %355 = OpLoad %354 
					                             sampler %356 = OpLoad %16 
					          read_only Texture2DSampled %357 = OpSampledImage %355 %356 
					                               f32_3 %358 = OpLoad %72 
					                               f32_2 %359 = OpVectorShuffle %358 %358 0 1 
					                               f32_4 %360 = OpImageSampleExplicitLod %357 %359 Lod %7 
					                               f32_2 %361 = OpVectorShuffle %360 %360 0 1 
					                               f32_3 %362 = OpLoad %72 
					                               f32_3 %363 = OpVectorShuffle %362 %361 3 4 2 
					                                              OpStore %72 %363 
					                                              OpBranch %203 
					                                     %364 = OpLabel 
					                        Private f32* %365 = OpAccessChain %72 %41 
					                                              OpStore %365 %31 
					                        Private f32* %366 = OpAccessChain %72 %33 
					                                              OpStore %366 %31 
					                                              OpBranch %203 
					                                     %203 = OpLabel 
					                        Uniform f32* %369 = OpAccessChain %51 %53 %41 
					                                 f32 %370 = OpLoad %369 
					                                 f32 %371 = OpFMul %370 %207 
					                          Input f32* %373 = OpAccessChain vs_TEXCOORD0 %41 
					                                 f32 %374 = OpLoad %373 
					                                 f32 %375 = OpFAdd %371 %374 
					                                              OpStore %367 %375 
					                      Uniform f32_4* %376 = OpAccessChain %51 %53 
					                               f32_4 %377 = OpLoad %376 
					                               f32_2 %378 = OpVectorShuffle %377 %377 0 1 
					                               f32_2 %379 = OpFNegate %378 
					                               f32_4 %380 = OpLoad %48 
					                               f32_4 %381 = OpVectorShuffle %380 %379 4 5 2 3 
					                                              OpStore %48 %381 
					                        Private f32* %382 = OpAccessChain %48 %64 
					                                              OpStore %382 %59 
					                                 f32 %383 = OpLoad %367 
					                        Private f32* %384 = OpAccessChain %277 %41 
					                                              OpStore %384 %383 
					                          Input f32* %385 = OpAccessChain vs_TEXCOORD0 %33 
					                                 f32 %386 = OpLoad %385 
					                        Private f32* %387 = OpAccessChain %277 %33 
					                                              OpStore %387 %386 
					                        Private f32* %388 = OpAccessChain %66 %41 
					                                              OpStore %388 %59 
					                        Private f32* %389 = OpAccessChain %277 %64 
					                                              OpStore %389 %58 
					                                              OpBranch %390 
					                                     %390 = OpLabel 
					                                              OpLoopMerge %392 %393 None 
					                                              OpBranch %394 
					                                     %394 = OpLabel 
					                                              OpBranchConditional %82 %391 %392 
					                                     %391 = OpLabel 
					                        Private f32* %395 = OpAccessChain %277 %64 
					                                 f32 %396 = OpLoad %395 
					                                bool %397 = OpFOrdLessThan %396 %86 
					                                              OpStore %88 %397 
					                        Private f32* %400 = OpAccessChain %66 %41 
					                                 f32 %401 = OpLoad %400 
					                                bool %402 = OpFOrdLessThan %89 %401 
					                       Private bool* %403 = OpAccessChain %399 %41 
					                                              OpStore %403 %402 
					                                bool %404 = OpLoad %88 
					                       Private bool* %405 = OpAccessChain %399 %41 
					                                bool %406 = OpLoad %405 
					                                bool %407 = OpLogicalAnd %404 %406 
					                                              OpStore %88 %407 
					                                bool %408 = OpLoad %88 
					                                bool %409 = OpLogicalNot %408 
					                                              OpSelectionMerge %411 None 
					                                              OpBranchConditional %409 %410 %411 
					                                     %410 = OpLabel 
					                                              OpBranch %392 
					                                     %411 = OpLabel 
					                               f32_4 %413 = OpLoad %48 
					                               f32_3 %414 = OpVectorShuffle %413 %413 0 1 2 
					                               f32_3 %415 = OpLoad %277 
					                               f32_3 %416 = OpFAdd %414 %415 
					                                              OpStore %277 %416 
					                 read_only Texture2D %417 = OpLoad %12 
					                             sampler %418 = OpLoad %16 
					          read_only Texture2DSampled %419 = OpSampledImage %417 %418 
					                               f32_3 %420 = OpLoad %277 
					                               f32_2 %421 = OpVectorShuffle %420 %420 0 1 
					                               f32_4 %422 = OpImageSampleExplicitLod %419 %421 Lod %7 
					                               f32_2 %423 = OpVectorShuffle %422 %422 0 1 
					                               f32_4 %424 = OpLoad %75 
					                               f32_4 %425 = OpVectorShuffle %424 %423 4 5 2 3 
					                                              OpStore %75 %425 
					                        Private f32* %427 = OpAccessChain %75 %41 
					                                 f32 %428 = OpLoad %427 
					                                 f32 %429 = OpFMul %428 %256 
					                                 f32 %430 = OpFAdd %429 %259 
					                                              OpStore %426 %430 
					                                 f32 %431 = OpLoad %426 
					                                 f32 %432 = OpExtInst %1 4 %431 
					                        Private f32* %433 = OpAccessChain %75 %41 
					                                 f32 %434 = OpLoad %433 
					                                 f32 %435 = OpFMul %432 %434 
					                                              OpStore %426 %435 
					                                 f32 %437 = OpLoad %426 
					                                 f32 %438 = OpExtInst %1 2 %437 
					                        Private f32* %439 = OpAccessChain %436 %41 
					                                              OpStore %439 %438 
					                        Private f32* %440 = OpAccessChain %75 %33 
					                                 f32 %441 = OpLoad %440 
					                                 f32 %442 = OpExtInst %1 2 %441 
					                        Private f32* %443 = OpAccessChain %436 %33 
					                                              OpStore %443 %442 
					                               f32_4 %444 = OpLoad %436 
					                               f32_2 %445 = OpVectorShuffle %444 %444 0 1 
					                                 f32 %446 = OpDot %445 %120 
					                        Private f32* %447 = OpAccessChain %66 %41 
					                                              OpStore %447 %446 
					                                              OpBranch %393 
					                                     %393 = OpLabel 
					                                              OpBranch %390 
					                                     %392 = OpLabel 
					                        Private f32* %448 = OpAccessChain %277 %64 
					                                 f32 %449 = OpLoad %448 
					                        Private f32* %450 = OpAccessChain %48 %41 
					                                              OpStore %450 %449 
					                 read_only Texture2D %451 = OpLoad %12 
					                             sampler %452 = OpLoad %16 
					          read_only Texture2DSampled %453 = OpSampledImage %451 %452 
					                               f32_2 %454 = OpLoad vs_TEXCOORD0 
					                               f32_4 %455 = OpImageSampleExplicitLod %453 %454 Lod %7ConstOffset %455 
					                                 f32 %456 = OpCompositeExtract %455 0 
					                                              OpStore %426 %456 
					                                 f32 %457 = OpLoad %426 
					                                bool %458 = OpFOrdLessThan %31 %457 
					                                              OpStore %88 %458 
					                                bool %459 = OpLoad %88 
					                                              OpSelectionMerge %461 None 
					                                              OpBranchConditional %459 %460 %541 
					                                     %460 = OpLabel 
					                      Uniform f32_4* %462 = OpAccessChain %51 %53 
					                               f32_4 %463 = OpLoad %462 
					                               f32_2 %464 = OpVectorShuffle %463 %463 0 1 
					                               f32_4 %465 = OpLoad %75 
					                               f32_4 %466 = OpVectorShuffle %465 %464 4 5 2 3 
					                                              OpStore %75 %466 
					                        Private f32* %467 = OpAccessChain %75 %64 
					                                              OpStore %467 %59 
					                                 f32 %468 = OpLoad %367 
					                        Private f32* %469 = OpAccessChain %436 %41 
					                                              OpStore %469 %468 
					                          Input f32* %470 = OpAccessChain vs_TEXCOORD0 %33 
					                                 f32 %471 = OpLoad %470 
					                        Private f32* %472 = OpAccessChain %436 %33 
					                                              OpStore %472 %471 
					                        Private f32* %473 = OpAccessChain %436 %64 
					                                              OpStore %473 %58 
					                        Private f32* %474 = OpAccessChain %66 %33 
					                                              OpStore %474 %59 
					                        Private f32* %476 = OpAccessChain %475 %41 
					                                              OpStore %476 %31 
					                                              OpBranch %477 
					                                     %477 = OpLabel 
					                                              OpLoopMerge %479 %480 None 
					                                              OpBranch %481 
					                                     %481 = OpLabel 
					                                              OpBranchConditional %82 %478 %479 
					                                     %478 = OpLabel 
					                        Private f32* %482 = OpAccessChain %436 %64 
					                                 f32 %483 = OpLoad %482 
					                                bool %484 = OpFOrdLessThan %483 %86 
					                                              OpStore %88 %484 
					                        Private f32* %485 = OpAccessChain %66 %33 
					                                 f32 %486 = OpLoad %485 
					                                bool %487 = OpFOrdLessThan %89 %486 
					                                              OpStore %160 %487 
					                                bool %488 = OpLoad %88 
					                                bool %489 = OpLoad %160 
					                                bool %490 = OpLogicalAnd %488 %489 
					                                              OpStore %88 %490 
					                                bool %491 = OpLoad %88 
					                                bool %492 = OpLogicalNot %491 
					                                              OpSelectionMerge %494 None 
					                                              OpBranchConditional %492 %493 %494 
					                                     %493 = OpLabel 
					                                              OpBranch %479 
					                                     %494 = OpLabel 
					                               f32_4 %496 = OpLoad %75 
					                               f32_3 %497 = OpVectorShuffle %496 %496 0 1 2 
					                               f32_4 %498 = OpLoad %436 
					                               f32_3 %499 = OpVectorShuffle %498 %498 0 1 2 
					                               f32_3 %500 = OpFAdd %497 %499 
					                               f32_4 %501 = OpLoad %436 
					                               f32_4 %502 = OpVectorShuffle %501 %500 4 5 6 3 
					                                              OpStore %436 %502 
					                 read_only Texture2D %504 = OpLoad %12 
					                             sampler %505 = OpLoad %16 
					          read_only Texture2DSampled %506 = OpSampledImage %504 %505 
					                               f32_4 %507 = OpLoad %436 
					                               f32_2 %508 = OpVectorShuffle %507 %507 0 1 
					                               f32_4 %509 = OpImageSampleExplicitLod %506 %508 Lod %7 
					                               f32_2 %510 = OpVectorShuffle %509 %509 0 1 
					                                              OpStore %503 %510 
					                        Private f32* %511 = OpAccessChain %503 %41 
					                                 f32 %512 = OpLoad %511 
					                                 f32 %513 = OpFMul %512 %256 
					                                 f32 %514 = OpFAdd %513 %259 
					                                              OpStore %426 %514 
					                                 f32 %515 = OpLoad %426 
					                                 f32 %516 = OpExtInst %1 4 %515 
					                        Private f32* %517 = OpAccessChain %503 %41 
					                                 f32 %518 = OpLoad %517 
					                                 f32 %519 = OpFMul %516 %518 
					                                              OpStore %426 %519 
					                                 f32 %520 = OpLoad %426 
					                                 f32 %521 = OpExtInst %1 2 %520 
					                        Private f32* %522 = OpAccessChain %475 %33 
					                                              OpStore %522 %521 
					                        Private f32* %523 = OpAccessChain %503 %33 
					                                 f32 %524 = OpLoad %523 
					                                 f32 %525 = OpExtInst %1 2 %524 
					                        Private f32* %526 = OpAccessChain %475 %41 
					                                              OpStore %526 %525 
					                               f32_2 %527 = OpLoad %475 
					                               f32_2 %528 = OpVectorShuffle %527 %527 1 0 
					                                 f32 %529 = OpDot %528 %120 
					                        Private f32* %530 = OpAccessChain %66 %33 
					                                              OpStore %530 %529 
					                                              OpBranch %480 
					                                     %480 = OpLabel 
					                                              OpBranch %477 
					                                     %479 = OpLabel 
					                        Private f32* %531 = OpAccessChain %475 %41 
					                                 f32 %532 = OpLoad %531 
					                                bool %533 = OpFOrdLessThan %89 %532 
					                                              OpStore %83 %533 
					                                bool %534 = OpLoad %83 
					                                 f32 %535 = OpSelect %534 %59 %31 
					                                              OpStore %367 %535 
					                                 f32 %536 = OpLoad %367 
					                        Private f32* %537 = OpAccessChain %436 %64 
					                                 f32 %538 = OpLoad %537 
					                                 f32 %539 = OpFAdd %536 %538 
					                        Private f32* %540 = OpAccessChain %48 %64 
					                                              OpStore %540 %539 
					                                              OpBranch %461 
					                                     %541 = OpLabel 
					                        Private f32* %542 = OpAccessChain %48 %64 
					                                              OpStore %542 %31 
					                        Private f32* %543 = OpAccessChain %66 %33 
					                                              OpStore %543 %31 
					                                              OpBranch %461 
					                                     %461 = OpLabel 
					                        Private f32* %544 = OpAccessChain %48 %64 
					                                 f32 %545 = OpLoad %544 
					                        Private f32* %546 = OpAccessChain %48 %41 
					                                 f32 %547 = OpLoad %546 
					                                 f32 %548 = OpFAdd %545 %547 
					                                              OpStore %367 %548 
					                                 f32 %549 = OpLoad %367 
					                                bool %550 = OpFOrdLessThan %197 %549 
					                                              OpStore %83 %550 
					                                bool %551 = OpLoad %83 
					                                              OpSelectionMerge %553 None 
					                                              OpBranchConditional %551 %552 %553 
					                                     %552 = OpLabel 
					                        Private f32* %554 = OpAccessChain %48 %41 
					                                 f32 %555 = OpLoad %554 
					                                 f32 %556 = OpFNegate %555 
					                        Private f32* %557 = OpAccessChain %48 %33 
					                                              OpStore %557 %556 
					                               f32_4 %558 = OpLoad %48 
					                               f32_4 %559 = OpVectorShuffle %558 %558 1 1 2 2 
					                      Uniform f32_4* %560 = OpAccessChain %51 %53 
					                               f32_4 %561 = OpLoad %560 
					                               f32_4 %562 = OpVectorShuffle %561 %561 0 1 0 1 
					                               f32_4 %563 = OpFMul %559 %562 
					                               f32_2 %564 = OpLoad vs_TEXCOORD0 
					                               f32_4 %565 = OpVectorShuffle %564 %564 0 1 0 1 
					                               f32_4 %566 = OpFAdd %563 %565 
					                                              OpStore %75 %566 
					                 read_only Texture2D %567 = OpLoad %12 
					                             sampler %568 = OpLoad %16 
					          read_only Texture2DSampled %569 = OpSampledImage %567 %568 
					                               f32_4 %570 = OpLoad %75 
					                               f32_2 %571 = OpVectorShuffle %570 %570 0 1 
					                               f32_4 %572 = OpImageSampleExplicitLod %569 %571 Lod %7ConstOffset %572 
					                                 f32 %573 = OpCompositeExtract %572 1 
					                        Private f32* %574 = OpAccessChain %436 %41 
					                                              OpStore %574 %573 
					                 read_only Texture2D %575 = OpLoad %12 
					                             sampler %576 = OpLoad %16 
					          read_only Texture2DSampled %577 = OpSampledImage %575 %576 
					                               f32_4 %578 = OpLoad %75 
					                               f32_2 %579 = OpVectorShuffle %578 %578 0 1 
					                               f32_4 %581 = OpImageSampleExplicitLod %577 %579 Lod %7ConstOffset %581 
					                                 f32 %582 = OpCompositeExtract %581 0 
					                        Private f32* %583 = OpAccessChain %436 %64 
					                                              OpStore %583 %582 
					                 read_only Texture2D %584 = OpLoad %12 
					                             sampler %585 = OpLoad %16 
					          read_only Texture2DSampled %586 = OpSampledImage %584 %585 
					                               f32_4 %587 = OpLoad %75 
					                               f32_2 %588 = OpVectorShuffle %587 %587 2 3 
					                               f32_4 %589 = OpImageSampleExplicitLod %586 %588 Lod %7ConstOffset %589 
					                               f32_2 %590 = OpVectorShuffle %589 %589 1 0 
					                               f32_4 %591 = OpLoad %436 
					                               f32_4 %592 = OpVectorShuffle %591 %590 0 4 2 5 
					                                              OpStore %436 %592 
					                               f32_4 %593 = OpLoad %436 
					                               f32_2 %594 = OpVectorShuffle %593 %593 0 1 
					                               f32_2 %595 = OpFMul %594 %288 
					                               f32_4 %596 = OpLoad %436 
					                               f32_2 %597 = OpVectorShuffle %596 %596 2 3 
					                               f32_2 %598 = OpFAdd %595 %597 
					                               f32_3 %599 = OpLoad %239 
					                               f32_3 %600 = OpVectorShuffle %599 %598 3 1 4 
					                                              OpStore %239 %600 
					                               f32_4 %602 = OpLoad %66 
					                               f32_4 %603 = OpVectorShuffle %602 %602 0 1 0 0 
					                              bool_4 %605 = OpFOrdGreaterThanEqual %603 %604 
					                              bool_2 %606 = OpVectorShuffle %605 %605 0 1 
					                              bool_4 %607 = OpLoad %601 
					                              bool_4 %608 = OpVectorShuffle %607 %606 4 5 2 3 
					                                              OpStore %601 %608 
					                               f32_3 %610 = OpLoad %239 
					                                              OpStore %609 %610 
					                       Private bool* %611 = OpAccessChain %601 %41 
					                                bool %612 = OpLoad %611 
					                                              OpSelectionMerge %615 None 
					                                              OpBranchConditional %612 %614 %616 
					                                     %614 = OpLabel 
					                                              OpStore %613 %31 
					                                              OpBranch %615 
					                                     %616 = OpLabel 
					                        Private f32* %617 = OpAccessChain %239 %41 
					                                 f32 %618 = OpLoad %617 
					                                              OpStore %613 %618 
					                                              OpBranch %615 
					                                     %615 = OpLabel 
					                                 f32 %619 = OpLoad %613 
					                       Function f32* %620 = OpAccessChain %609 %41 
					                                              OpStore %620 %619 
					                       Private bool* %621 = OpAccessChain %601 %33 
					                                bool %622 = OpLoad %621 
					                                              OpSelectionMerge %625 None 
					                                              OpBranchConditional %622 %624 %626 
					                                     %624 = OpLabel 
					                                              OpStore %623 %31 
					                                              OpBranch %625 
					                                     %626 = OpLabel 
					                        Private f32* %627 = OpAccessChain %239 %64 
					                                 f32 %628 = OpLoad %627 
					                                              OpStore %623 %628 
					                                              OpBranch %625 
					                                     %625 = OpLabel 
					                                 f32 %629 = OpLoad %623 
					                       Function f32* %630 = OpAccessChain %609 %64 
					                                              OpStore %630 %629 
					                               f32_3 %631 = OpLoad %609 
					                                              OpStore %239 %631 
					                               f32_3 %632 = OpLoad %239 
					                               f32_2 %633 = OpVectorShuffle %632 %632 0 2 
					                               f32_2 %634 = OpFMul %633 %335 
					                               f32_4 %635 = OpLoad %48 
					                               f32_2 %636 = OpVectorShuffle %635 %635 0 2 
					                               f32_2 %637 = OpFAdd %634 %636 
					                               f32_4 %638 = OpLoad %48 
					                               f32_4 %639 = OpVectorShuffle %638 %637 4 5 2 3 
					                                              OpStore %48 %639 
					                               f32_4 %640 = OpLoad %48 
					                               f32_2 %641 = OpVectorShuffle %640 %640 0 1 
					                               f32_2 %642 = OpFMul %641 %346 
					                               f32_2 %643 = OpFAdd %642 %350 
					                               f32_4 %644 = OpLoad %48 
					                               f32_4 %645 = OpVectorShuffle %644 %643 4 5 2 3 
					                                              OpStore %48 %645 
					                 read_only Texture2D %646 = OpLoad %354 
					                             sampler %647 = OpLoad %16 
					          read_only Texture2DSampled %648 = OpSampledImage %646 %647 
					                               f32_4 %649 = OpLoad %48 
					                               f32_2 %650 = OpVectorShuffle %649 %649 0 1 
					                               f32_4 %651 = OpImageSampleExplicitLod %648 %650 Lod %7 
					                               f32_2 %652 = OpVectorShuffle %651 %651 0 1 
					                               f32_4 %653 = OpLoad %48 
					                               f32_4 %654 = OpVectorShuffle %653 %652 4 5 2 3 
					                                              OpStore %48 %654 
					                               f32_3 %655 = OpLoad %72 
					                               f32_2 %656 = OpVectorShuffle %655 %655 0 1 
					                               f32_4 %657 = OpLoad %48 
					                               f32_2 %658 = OpVectorShuffle %657 %657 1 0 
					                               f32_2 %659 = OpFAdd %656 %658 
					                               f32_3 %660 = OpLoad %72 
					                               f32_3 %661 = OpVectorShuffle %660 %659 3 4 2 
					                                              OpStore %72 %661 
					                                              OpBranch %553 
					                                     %553 = OpLabel 
					                        Private f32* %662 = OpAccessChain %72 %33 
					                                 f32 %663 = OpLoad %662 
					                                 f32 %664 = OpFNegate %663 
					                        Private f32* %665 = OpAccessChain %72 %41 
					                                 f32 %666 = OpLoad %665 
					                                bool %667 = OpFOrdEqual %664 %666 
					                                              OpStore %83 %667 
					                                bool %668 = OpLoad %83 
					                                              OpSelectionMerge %670 None 
					                                              OpBranchConditional %668 %669 %1045 
					                                     %669 = OpLabel 
					                               f32_4 %673 = OpLoad vs_TEXCOORD2 
					                               f32_2 %674 = OpVectorShuffle %673 %673 0 1 
					                               f32_4 %675 = OpLoad %48 
					                               f32_4 %676 = OpVectorShuffle %675 %674 4 5 2 3 
					                                              OpStore %48 %676 
					                        Private f32* %677 = OpAccessChain %48 %64 
					                                              OpStore %677 %59 
					                        Private f32* %678 = OpAccessChain %66 %41 
					                                              OpStore %678 %31 
					                                              OpBranch %679 
					                                     %679 = OpLabel 
					                                              OpLoopMerge %681 %682 None 
					                                              OpBranch %683 
					                                     %683 = OpLabel 
					                                              OpBranchConditional %82 %680 %681 
					                                     %680 = OpLabel 
					                          Input f32* %685 = OpAccessChain vs_TEXCOORD4 %41 
					                                 f32 %686 = OpLoad %685 
					                        Private f32* %687 = OpAccessChain %48 %41 
					                                 f32 %688 = OpLoad %687 
					                                bool %689 = OpFOrdLessThan %686 %688 
					                                              OpStore %83 %689 
					                        Private f32* %691 = OpAccessChain %48 %64 
					                                 f32 %692 = OpLoad %691 
					                                bool %693 = OpFOrdLessThan %690 %692 
					                                              OpStore %88 %693 
					                                bool %694 = OpLoad %83 
					                                bool %695 = OpLoad %88 
					                                bool %696 = OpLogicalAnd %694 %695 
					                                              OpStore %83 %696 
					                        Private f32* %697 = OpAccessChain %66 %41 
					                                 f32 %698 = OpLoad %697 
					                                bool %699 = OpFOrdEqual %698 %31 
					                                              OpStore %88 %699 
					                                bool %700 = OpLoad %83 
					                                bool %701 = OpLoad %88 
					                                bool %702 = OpLogicalAnd %700 %701 
					                                              OpStore %83 %702 
					                                bool %703 = OpLoad %83 
					                                bool %704 = OpLogicalNot %703 
					                                              OpSelectionMerge %706 None 
					                                              OpBranchConditional %704 %705 %706 
					                                     %705 = OpLabel 
					                                              OpBranch %681 
					                                     %706 = OpLabel 
					                 read_only Texture2D %708 = OpLoad %12 
					                             sampler %709 = OpLoad %16 
					          read_only Texture2DSampled %710 = OpSampledImage %708 %709 
					                               f32_4 %711 = OpLoad %48 
					                               f32_2 %712 = OpVectorShuffle %711 %711 0 1 
					                               f32_4 %713 = OpImageSampleExplicitLod %710 %712 Lod %7 
					                               f32_2 %714 = OpVectorShuffle %713 %713 0 1 
					                               f32_4 %715 = OpLoad %66 
					                               f32_4 %716 = OpVectorShuffle %715 %714 4 5 2 3 
					                                              OpStore %66 %716 
					                      Uniform f32_4* %717 = OpAccessChain %51 %53 
					                               f32_4 %718 = OpLoad %717 
					                               f32_2 %719 = OpVectorShuffle %718 %718 0 1 
					                               f32_2 %723 = OpFMul %719 %722 
					                               f32_4 %724 = OpLoad %48 
					                               f32_2 %725 = OpVectorShuffle %724 %724 0 1 
					                               f32_2 %726 = OpFAdd %723 %725 
					                               f32_4 %727 = OpLoad %48 
					                               f32_4 %728 = OpVectorShuffle %727 %726 4 5 2 3 
					                                              OpStore %48 %728 
					                        Private f32* %729 = OpAccessChain %66 %33 
					                                 f32 %730 = OpLoad %729 
					                        Private f32* %731 = OpAccessChain %48 %64 
					                                              OpStore %731 %730 
					                                              OpBranch %682 
					                                     %682 = OpLabel 
					                                              OpBranch %679 
					                                     %681 = OpLabel 
					                               f32_4 %732 = OpLoad %48 
					                               f32_2 %733 = OpVectorShuffle %732 %732 0 2 
					                               f32_4 %734 = OpLoad %66 
					                               f32_4 %735 = OpVectorShuffle %734 %733 0 4 5 3 
					                                              OpStore %66 %735 
					                               f32_4 %736 = OpLoad %66 
					                               f32_2 %737 = OpVectorShuffle %736 %736 0 2 
					                               f32_2 %739 = OpFMul %737 %738 
					                               f32_2 %743 = OpFAdd %739 %742 
					                               f32_4 %744 = OpLoad %48 
					                               f32_4 %745 = OpVectorShuffle %744 %743 4 5 2 3 
					                                              OpStore %48 %745 
					                 read_only Texture2D %747 = OpLoad %746 
					                             sampler %748 = OpLoad %16 
					          read_only Texture2DSampled %749 = OpSampledImage %747 %748 
					                               f32_4 %750 = OpLoad %48 
					                               f32_2 %751 = OpVectorShuffle %750 %750 0 1 
					                               f32_4 %752 = OpImageSampleExplicitLod %749 %751 Lod %7 
					                                 f32 %754 = OpCompositeExtract %752 3 
					                                              OpStore %367 %754 
					                                 f32 %755 = OpLoad %367 
					                                 f32 %757 = OpFMul %755 %756 
					                                 f32 %759 = OpFAdd %757 %758 
					                                              OpStore %367 %759 
					                        Uniform f32* %760 = OpAccessChain %51 %53 %41 
					                                 f32 %761 = OpLoad %760 
					                                 f32 %762 = OpLoad %367 
					                                 f32 %763 = OpFMul %761 %762 
					                        Private f32* %764 = OpAccessChain %66 %33 
					                                 f32 %765 = OpLoad %764 
					                                 f32 %766 = OpFAdd %763 %765 
					                        Private f32* %767 = OpAccessChain %48 %41 
					                                              OpStore %767 %766 
					                          Input f32* %769 = OpAccessChain vs_TEXCOORD3 %33 
					                                 f32 %770 = OpLoad %769 
					                        Private f32* %771 = OpAccessChain %48 %33 
					                                              OpStore %771 %770 
					                 read_only Texture2D %772 = OpLoad %12 
					                             sampler %773 = OpLoad %16 
					          read_only Texture2DSampled %774 = OpSampledImage %772 %773 
					                               f32_4 %775 = OpLoad %48 
					                               f32_2 %776 = OpVectorShuffle %775 %775 0 1 
					                               f32_4 %777 = OpImageSampleExplicitLod %774 %776 Lod %7 
					                                 f32 %778 = OpCompositeExtract %777 0 
					                        Private f32* %779 = OpAccessChain %66 %41 
					                                              OpStore %779 %778 
					                               f32_4 %780 = OpLoad vs_TEXCOORD2 
					                               f32_2 %781 = OpVectorShuffle %780 %780 2 3 
					                               f32_4 %782 = OpLoad %75 
					                               f32_4 %783 = OpVectorShuffle %782 %781 4 5 2 3 
					                                              OpStore %75 %783 
					                        Private f32* %784 = OpAccessChain %75 %64 
					                                              OpStore %784 %59 
					                        Private f32* %785 = OpAccessChain %436 %41 
					                                              OpStore %785 %31 
					                                              OpBranch %786 
					                                     %786 = OpLabel 
					                                              OpLoopMerge %788 %789 None 
					                                              OpBranch %790 
					                                     %790 = OpLabel 
					                                              OpBranchConditional %82 %787 %788 
					                                     %787 = OpLabel 
					                        Private f32* %791 = OpAccessChain %75 %41 
					                                 f32 %792 = OpLoad %791 
					                          Input f32* %793 = OpAccessChain vs_TEXCOORD4 %33 
					                                 f32 %794 = OpLoad %793 
					                                bool %795 = OpFOrdLessThan %792 %794 
					                                              OpStore %83 %795 
					                        Private f32* %797 = OpAccessChain %75 %64 
					                                 f32 %798 = OpLoad %797 
					                                bool %799 = OpFOrdLessThan %690 %798 
					                                              OpStore %796 %799 
					                                bool %800 = OpLoad %83 
					                                bool %801 = OpLoad %796 
					                                bool %802 = OpLogicalAnd %800 %801 
					                                              OpStore %83 %802 
					                        Private f32* %803 = OpAccessChain %436 %41 
					                                 f32 %804 = OpLoad %803 
					                                bool %805 = OpFOrdEqual %804 %31 
					                                              OpStore %796 %805 
					                                bool %806 = OpLoad %83 
					                                bool %807 = OpLoad %796 
					                                bool %808 = OpLogicalAnd %806 %807 
					                                              OpStore %83 %808 
					                                bool %809 = OpLoad %83 
					                                bool %810 = OpLogicalNot %809 
					                                              OpSelectionMerge %812 None 
					                                              OpBranchConditional %810 %811 %812 
					                                     %811 = OpLabel 
					                                              OpBranch %788 
					                                     %812 = OpLabel 
					                 read_only Texture2D %814 = OpLoad %12 
					                             sampler %815 = OpLoad %16 
					          read_only Texture2DSampled %816 = OpSampledImage %814 %815 
					                               f32_4 %817 = OpLoad %75 
					                               f32_2 %818 = OpVectorShuffle %817 %817 0 1 
					                               f32_4 %819 = OpImageSampleExplicitLod %816 %818 Lod %7 
					                               f32_2 %820 = OpVectorShuffle %819 %819 0 1 
					                               f32_4 %821 = OpLoad %436 
					                               f32_4 %822 = OpVectorShuffle %821 %820 4 5 2 3 
					                                              OpStore %436 %822 
					                      Uniform f32_4* %823 = OpAccessChain %51 %53 
					                               f32_4 %824 = OpLoad %823 
					                               f32_2 %825 = OpVectorShuffle %824 %824 0 1 
					                               f32_2 %827 = OpFMul %825 %826 
					                               f32_4 %828 = OpLoad %75 
					                               f32_2 %829 = OpVectorShuffle %828 %828 0 1 
					                               f32_2 %830 = OpFAdd %827 %829 
					                               f32_4 %831 = OpLoad %75 
					                               f32_4 %832 = OpVectorShuffle %831 %830 4 5 2 3 
					                                              OpStore %75 %832 
					                        Private f32* %833 = OpAccessChain %436 %33 
					                                 f32 %834 = OpLoad %833 
					                        Private f32* %835 = OpAccessChain %75 %64 
					                                              OpStore %835 %834 
					                                              OpBranch %789 
					                                     %789 = OpLabel 
					                                              OpBranch %786 
					                                     %788 = OpLabel 
					                               f32_4 %836 = OpLoad %75 
					                               f32_2 %837 = OpVectorShuffle %836 %836 0 2 
					                               f32_4 %838 = OpLoad %436 
					                               f32_4 %839 = OpVectorShuffle %838 %837 0 4 5 3 
					                                              OpStore %436 %839 
					                               f32_4 %840 = OpLoad %436 
					                               f32_2 %841 = OpVectorShuffle %840 %840 0 2 
					                               f32_2 %842 = OpFMul %841 %738 
					                               f32_2 %845 = OpFAdd %842 %844 
					                                              OpStore %475 %845 
					                 read_only Texture2D %846 = OpLoad %746 
					                             sampler %847 = OpLoad %16 
					          read_only Texture2DSampled %848 = OpSampledImage %846 %847 
					                               f32_2 %849 = OpLoad %475 
					                               f32_4 %850 = OpImageSampleExplicitLod %848 %849 Lod %7 
					                                 f32 %851 = OpCompositeExtract %850 3 
					                                              OpStore %367 %851 
					                                 f32 %852 = OpLoad %367 
					                                 f32 %853 = OpFMul %852 %756 
					                                 f32 %854 = OpFAdd %853 %758 
					                                              OpStore %367 %854 
					                        Uniform f32* %855 = OpAccessChain %51 %53 %41 
					                                 f32 %856 = OpLoad %855 
					                                 f32 %857 = OpFNegate %856 
					                                 f32 %858 = OpLoad %367 
					                                 f32 %859 = OpFMul %857 %858 
					                        Private f32* %860 = OpAccessChain %436 %33 
					                                 f32 %861 = OpLoad %860 
					                                 f32 %862 = OpFAdd %859 %861 
					                        Private f32* %863 = OpAccessChain %48 %64 
					                                              OpStore %863 %862 
					                      Uniform f32_4* %864 = OpAccessChain %51 %53 
					                               f32_4 %865 = OpLoad %864 
					                               f32_4 %866 = OpVectorShuffle %865 %865 2 2 2 2 
					                               f32_4 %867 = OpLoad %48 
					                               f32_4 %868 = OpVectorShuffle %867 %867 2 0 2 0 
					                               f32_4 %869 = OpFMul %866 %868 
					                               f32_2 %871 = OpLoad vs_TEXCOORD1 
					                               f32_4 %872 = OpVectorShuffle %871 %871 0 0 0 0 
					                               f32_4 %873 = OpFNegate %872 
					                               f32_4 %874 = OpFAdd %869 %873 
					                                              OpStore %75 %874 
					                               f32_4 %875 = OpLoad %75 
					                               f32_4 %876 = OpExtInst %1 2 %875 
					                                              OpStore %75 %876 
					                               f32_4 %877 = OpLoad %75 
					                               f32_2 %878 = OpVectorShuffle %877 %877 3 2 
					                               f32_2 %879 = OpExtInst %1 4 %878 
					                               f32_2 %880 = OpExtInst %1 31 %879 
					                                              OpStore %475 %880 
					                 read_only Texture2D %881 = OpLoad %12 
					                             sampler %882 = OpLoad %16 
					          read_only Texture2DSampled %883 = OpSampledImage %881 %882 
					                               f32_4 %884 = OpLoad %48 
					                               f32_2 %885 = OpVectorShuffle %884 %884 2 1 
					                               f32_4 %886 = OpImageSampleExplicitLod %883 %885 Lod %7ConstOffset %886 
					                                 f32 %887 = OpCompositeExtract %886 0 
					                        Private f32* %888 = OpAccessChain %66 %33 
					                                              OpStore %888 %887 
					                               f32_4 %889 = OpLoad %66 
					                               f32_2 %890 = OpVectorShuffle %889 %889 0 1 
					                               f32_2 %893 = OpFMul %890 %892 
					                               f32_4 %894 = OpLoad %66 
					                               f32_4 %895 = OpVectorShuffle %894 %893 4 5 2 3 
					                                              OpStore %66 %895 
					                               f32_4 %896 = OpLoad %66 
					                               f32_2 %897 = OpVectorShuffle %896 %896 0 1 
					                               f32_2 %898 = OpExtInst %1 2 %897 
					                               f32_4 %899 = OpLoad %66 
					                               f32_4 %900 = OpVectorShuffle %899 %898 4 5 2 3 
					                                              OpStore %66 %900 
					                               f32_4 %901 = OpLoad %66 
					                               f32_2 %902 = OpVectorShuffle %901 %901 0 1 
					                               f32_2 %905 = OpFMul %902 %904 
					                               f32_2 %906 = OpLoad %475 
					                               f32_2 %907 = OpFAdd %905 %906 
					                               f32_4 %908 = OpLoad %66 
					                               f32_4 %909 = OpVectorShuffle %908 %907 4 5 2 3 
					                                              OpStore %66 %909 
					                               f32_4 %910 = OpLoad %66 
					                               f32_2 %911 = OpVectorShuffle %910 %910 0 1 
					                               f32_2 %912 = OpFMul %911 %346 
					                               f32_2 %915 = OpFAdd %912 %914 
					                               f32_4 %916 = OpLoad %66 
					                               f32_4 %917 = OpVectorShuffle %916 %915 4 5 2 3 
					                                              OpStore %66 %917 
					                 read_only Texture2D %918 = OpLoad %354 
					                             sampler %919 = OpLoad %16 
					          read_only Texture2DSampled %920 = OpSampledImage %918 %919 
					                               f32_4 %921 = OpLoad %66 
					                               f32_2 %922 = OpVectorShuffle %921 %921 0 1 
					                               f32_4 %923 = OpImageSampleExplicitLod %920 %922 Lod %7 
					                               f32_2 %924 = OpVectorShuffle %923 %923 0 1 
					                               f32_4 %925 = OpLoad %66 
					                               f32_4 %926 = OpVectorShuffle %925 %924 4 5 2 3 
					                                              OpStore %66 %926 
					                               f32_4 %927 = OpLoad %75 
					                               f32_4 %928 = OpExtInst %1 4 %927 
					                               f32_4 %929 = OpLoad %75 
					                               f32_4 %930 = OpVectorShuffle %929 %929 3 2 3 2 
					                               f32_4 %931 = OpExtInst %1 4 %930 
					                              bool_4 %932 = OpFOrdGreaterThanEqual %928 %931 
					                                              OpStore %399 %932 
					                       Private bool* %933 = OpAccessChain %399 %41 
					                                bool %934 = OpLoad %933 
					                                 f32 %935 = OpSelect %934 %59 %31 
					                        Private f32* %936 = OpAccessChain %75 %41 
					                                              OpStore %936 %935 
					                       Private bool* %937 = OpAccessChain %399 %33 
					                                bool %938 = OpLoad %937 
					                                 f32 %939 = OpSelect %938 %59 %31 
					                        Private f32* %940 = OpAccessChain %75 %33 
					                                              OpStore %940 %939 
					                       Private bool* %941 = OpAccessChain %399 %64 
					                                bool %942 = OpLoad %941 
					                                 f32 %944 = OpSelect %942 %943 %31 
					                        Private f32* %945 = OpAccessChain %75 %64 
					                                              OpStore %945 %944 
					                       Private bool* %946 = OpAccessChain %399 %753 
					                                bool %947 = OpLoad %946 
					                                 f32 %948 = OpSelect %947 %943 %31 
					                        Private f32* %949 = OpAccessChain %75 %753 
					                                              OpStore %949 %948 
					                        Private f32* %950 = OpAccessChain %75 %33 
					                                 f32 %951 = OpLoad %950 
					                        Private f32* %952 = OpAccessChain %75 %41 
					                                 f32 %953 = OpLoad %952 
					                                 f32 %954 = OpFAdd %951 %953 
					                                              OpStore %367 %954 
					                               f32_4 %955 = OpLoad %75 
					                               f32_2 %956 = OpVectorShuffle %955 %955 2 3 
					                                 f32 %957 = OpLoad %367 
					                               f32_2 %958 = OpCompositeConstruct %957 %957 
					                               f32_2 %959 = OpFDiv %956 %958 
					                                              OpStore %475 %959 
					                          Input f32* %960 = OpAccessChain vs_TEXCOORD0 %33 
					                                 f32 %961 = OpLoad %960 
					                        Private f32* %962 = OpAccessChain %48 %753 
					                                              OpStore %962 %961 
					                 read_only Texture2D %963 = OpLoad %12 
					                             sampler %964 = OpLoad %16 
					          read_only Texture2DSampled %965 = OpSampledImage %963 %964 
					                               f32_4 %966 = OpLoad %48 
					                               f32_2 %967 = OpVectorShuffle %966 %966 0 3 
					                               f32_4 %969 = OpImageSampleExplicitLod %965 %967 Lod %7ConstOffset %969 
					                                 f32 %970 = OpCompositeExtract %969 0 
					                                              OpStore %367 %970 
					                        Private f32* %971 = OpAccessChain %475 %41 
					                                 f32 %972 = OpLoad %971 
					                                 f32 %973 = OpFNegate %972 
					                                 f32 %974 = OpLoad %367 
					                                 f32 %975 = OpFMul %973 %974 
					                                 f32 %976 = OpFAdd %975 %59 
					                                              OpStore %367 %976 
					                 read_only Texture2D %977 = OpLoad %12 
					                             sampler %978 = OpLoad %16 
					          read_only Texture2DSampled %979 = OpSampledImage %977 %978 
					                               f32_4 %980 = OpLoad %48 
					                               f32_2 %981 = OpVectorShuffle %980 %980 2 3 
					                               f32_4 %983 = OpImageSampleExplicitLod %979 %981 Lod %7ConstOffset %983 
					                                 f32 %984 = OpCompositeExtract %983 0 
					                        Private f32* %985 = OpAccessChain %239 %41 
					                                              OpStore %985 %984 
					                        Private f32* %986 = OpAccessChain %475 %33 
					                                 f32 %987 = OpLoad %986 
					                                 f32 %988 = OpFNegate %987 
					                        Private f32* %989 = OpAccessChain %239 %41 
					                                 f32 %990 = OpLoad %989 
					                                 f32 %991 = OpFMul %988 %990 
					                                 f32 %992 = OpLoad %367 
					                                 f32 %993 = OpFAdd %991 %992 
					                        Private f32* %994 = OpAccessChain %75 %41 
					                                              OpStore %994 %993 
					                        Private f32* %995 = OpAccessChain %75 %41 
					                                 f32 %996 = OpLoad %995 
					                                 f32 %997 = OpExtInst %1 43 %996 %31 %59 
					                        Private f32* %998 = OpAccessChain %75 %41 
					                                              OpStore %998 %997 
					                 read_only Texture2D %999 = OpLoad %12 
					                            sampler %1000 = OpLoad %16 
					         read_only Texture2DSampled %1001 = OpSampledImage %999 %1000 
					                              f32_4 %1002 = OpLoad %48 
					                              f32_2 %1003 = OpVectorShuffle %1002 %1002 0 3 
					                              f32_4 %1006 = OpImageSampleExplicitLod %1001 %1003 Lod %7ConstOffset %1006 
					                                f32 %1007 = OpCompositeExtract %1006 0 
					                                              OpStore %367 %1007 
					                       Private f32* %1008 = OpAccessChain %475 %41 
					                                f32 %1009 = OpLoad %1008 
					                                f32 %1010 = OpFNegate %1009 
					                                f32 %1011 = OpLoad %367 
					                                f32 %1012 = OpFMul %1010 %1011 
					                                f32 %1013 = OpFAdd %1012 %59 
					                                              OpStore %367 %1013 
					                read_only Texture2D %1014 = OpLoad %12 
					                            sampler %1015 = OpLoad %16 
					         read_only Texture2DSampled %1016 = OpSampledImage %1014 %1015 
					                              f32_4 %1017 = OpLoad %48 
					                              f32_2 %1018 = OpVectorShuffle %1017 %1017 2 3 
					                              f32_4 %1020 = OpImageSampleExplicitLod %1016 %1018 Lod %7ConstOffset %1020 
					                                f32 %1021 = OpCompositeExtract %1020 0 
					                       Private f32* %1022 = OpAccessChain %48 %41 
					                                              OpStore %1022 %1021 
					                       Private f32* %1023 = OpAccessChain %475 %33 
					                                f32 %1024 = OpLoad %1023 
					                                f32 %1025 = OpFNegate %1024 
					                       Private f32* %1026 = OpAccessChain %48 %41 
					                                f32 %1027 = OpLoad %1026 
					                                f32 %1028 = OpFMul %1025 %1027 
					                                f32 %1029 = OpLoad %367 
					                                f32 %1030 = OpFAdd %1028 %1029 
					                       Private f32* %1031 = OpAccessChain %75 %33 
					                                              OpStore %1031 %1030 
					                       Private f32* %1032 = OpAccessChain %75 %33 
					                                f32 %1033 = OpLoad %1032 
					                                f32 %1034 = OpExtInst %1 43 %1033 %31 %59 
					                       Private f32* %1035 = OpAccessChain %75 %33 
					                                              OpStore %1035 %1034 
					                              f32_4 %1038 = OpLoad %66 
					                              f32_2 %1039 = OpVectorShuffle %1038 %1038 0 1 
					                              f32_4 %1040 = OpLoad %75 
					                              f32_2 %1041 = OpVectorShuffle %1040 %1040 0 1 
					                              f32_2 %1042 = OpFMul %1039 %1041 
					                              f32_4 %1043 = OpLoad %1037 
					                              f32_4 %1044 = OpVectorShuffle %1043 %1042 4 5 2 3 
					                                              OpStore %1037 %1044 
					                                              OpBranch %670 
					                                    %1045 = OpLabel 
					                              f32_3 %1046 = OpLoad %72 
					                              f32_2 %1047 = OpVectorShuffle %1046 %1046 0 1 
					                              f32_4 %1048 = OpLoad %1037 
					                              f32_4 %1049 = OpVectorShuffle %1048 %1047 4 5 2 3 
					                                              OpStore %1037 %1049 
					                       Private f32* %1050 = OpAccessChain %9 %41 
					                                              OpStore %1050 %31 
					                                              OpBranch %670 
					                                     %670 = OpLabel 
					                                              OpBranch %40 
					                                    %1051 = OpLabel 
					                              f32_4 %1053 = OpLoad %1037 
					                              f32_4 %1054 = OpVectorShuffle %1053 %1052 4 5 2 3 
					                                              OpStore %1037 %1054 
					                                              OpBranch %40 
					                                      %40 = OpLabel 
					                       Private f32* %1056 = OpAccessChain %9 %41 
					                                f32 %1057 = OpLoad %1056 
					                               bool %1058 = OpFOrdLessThan %31 %1057 
					                                              OpStore %1055 %1058 
					                               bool %1059 = OpLoad %1055 
					                                              OpSelectionMerge %1061 None 
					                                              OpBranchConditional %1059 %1060 %1423 
					                                    %1060 = OpLabel 
					                              f32_4 %1062 = OpLoad vs_TEXCOORD3 
					                              f32_2 %1063 = OpVectorShuffle %1062 %1062 0 1 
					                              f32_4 %1064 = OpLoad %9 
					                              f32_4 %1065 = OpVectorShuffle %1064 %1063 4 5 2 3 
					                                              OpStore %9 %1065 
					                       Private f32* %1066 = OpAccessChain %9 %64 
					                                              OpStore %1066 %59 
					                       Private f32* %1067 = OpAccessChain %48 %41 
					                                              OpStore %1067 %31 
					                                              OpBranch %1068 
					                                    %1068 = OpLabel 
					                                              OpLoopMerge %1070 %1071 None 
					                                              OpBranch %1072 
					                                    %1072 = OpLabel 
					                                              OpBranchConditional %82 %1069 %1070 
					                                    %1069 = OpLabel 
					                         Input f32* %1073 = OpAccessChain vs_TEXCOORD4 %64 
					                                f32 %1074 = OpLoad %1073 
					                       Private f32* %1075 = OpAccessChain %9 %33 
					                                f32 %1076 = OpLoad %1075 
					                               bool %1077 = OpFOrdLessThan %1074 %1076 
					                                              OpStore %83 %1077 
					                       Private f32* %1078 = OpAccessChain %9 %64 
					                                f32 %1079 = OpLoad %1078 
					                               bool %1080 = OpFOrdLessThan %690 %1079 
					                                              OpStore %88 %1080 
					                               bool %1081 = OpLoad %83 
					                               bool %1082 = OpLoad %88 
					                               bool %1083 = OpLogicalAnd %1081 %1082 
					                                              OpStore %83 %1083 
					                       Private f32* %1084 = OpAccessChain %48 %41 
					                                f32 %1085 = OpLoad %1084 
					                               bool %1086 = OpFOrdEqual %1085 %31 
					                                              OpStore %88 %1086 
					                               bool %1087 = OpLoad %83 
					                               bool %1088 = OpLoad %88 
					                               bool %1089 = OpLogicalAnd %1087 %1088 
					                                              OpStore %83 %1089 
					                               bool %1090 = OpLoad %83 
					                               bool %1091 = OpLogicalNot %1090 
					                                              OpSelectionMerge %1093 None 
					                                              OpBranchConditional %1091 %1092 %1093 
					                                    %1092 = OpLabel 
					                                              OpBranch %1070 
					                                    %1093 = OpLabel 
					                read_only Texture2D %1095 = OpLoad %12 
					                            sampler %1096 = OpLoad %16 
					         read_only Texture2DSampled %1097 = OpSampledImage %1095 %1096 
					                              f32_4 %1098 = OpLoad %9 
					                              f32_2 %1099 = OpVectorShuffle %1098 %1098 0 1 
					                              f32_4 %1100 = OpImageSampleExplicitLod %1097 %1099 Lod %7 
					                              f32_2 %1101 = OpVectorShuffle %1100 %1100 1 0 
					                              f32_4 %1102 = OpLoad %48 
					                              f32_4 %1103 = OpVectorShuffle %1102 %1101 4 5 2 3 
					                                              OpStore %48 %1103 
					                     Uniform f32_4* %1104 = OpAccessChain %51 %53 
					                              f32_4 %1105 = OpLoad %1104 
					                              f32_2 %1106 = OpVectorShuffle %1105 %1105 0 1 
					                              f32_2 %1108 = OpFMul %1106 %1107 
					                              f32_4 %1109 = OpLoad %9 
					                              f32_2 %1110 = OpVectorShuffle %1109 %1109 0 1 
					                              f32_2 %1111 = OpFAdd %1108 %1110 
					                              f32_4 %1112 = OpLoad %9 
					                              f32_4 %1113 = OpVectorShuffle %1112 %1111 4 5 2 3 
					                                              OpStore %9 %1113 
					                       Private f32* %1114 = OpAccessChain %48 %33 
					                                f32 %1115 = OpLoad %1114 
					                       Private f32* %1116 = OpAccessChain %9 %64 
					                                              OpStore %1116 %1115 
					                                              OpBranch %1071 
					                                    %1071 = OpLabel 
					                                              OpBranch %1068 
					                                    %1070 = OpLabel 
					                              f32_4 %1117 = OpLoad %9 
					                              f32_2 %1118 = OpVectorShuffle %1117 %1117 1 2 
					                              f32_4 %1119 = OpLoad %48 
					                              f32_4 %1120 = OpVectorShuffle %1119 %1118 0 4 5 3 
					                                              OpStore %48 %1120 
					                              f32_4 %1121 = OpLoad %48 
					                              f32_2 %1122 = OpVectorShuffle %1121 %1121 0 2 
					                              f32_2 %1123 = OpFMul %1122 %738 
					                              f32_2 %1124 = OpFAdd %1123 %742 
					                              f32_4 %1125 = OpLoad %9 
					                              f32_4 %1126 = OpVectorShuffle %1125 %1124 4 5 2 3 
					                                              OpStore %9 %1126 
					                read_only Texture2D %1127 = OpLoad %746 
					                            sampler %1128 = OpLoad %16 
					         read_only Texture2DSampled %1129 = OpSampledImage %1127 %1128 
					                              f32_4 %1130 = OpLoad %9 
					                              f32_2 %1131 = OpVectorShuffle %1130 %1130 0 1 
					                              f32_4 %1132 = OpImageSampleExplicitLod %1129 %1131 Lod %7 
					                                f32 %1133 = OpCompositeExtract %1132 3 
					                       Private f32* %1134 = OpAccessChain %9 %41 
					                                              OpStore %1134 %1133 
					                       Private f32* %1135 = OpAccessChain %9 %41 
					                                f32 %1136 = OpLoad %1135 
					                                f32 %1137 = OpFMul %1136 %756 
					                                f32 %1138 = OpFAdd %1137 %758 
					                       Private f32* %1139 = OpAccessChain %9 %41 
					                                              OpStore %1139 %1138 
					                       Uniform f32* %1140 = OpAccessChain %51 %53 %33 
					                                f32 %1141 = OpLoad %1140 
					                       Private f32* %1142 = OpAccessChain %9 %41 
					                                f32 %1143 = OpLoad %1142 
					                                f32 %1144 = OpFMul %1141 %1143 
					                       Private f32* %1145 = OpAccessChain %48 %33 
					                                f32 %1146 = OpLoad %1145 
					                                f32 %1147 = OpFAdd %1144 %1146 
					                       Private f32* %1148 = OpAccessChain %9 %41 
					                                              OpStore %1148 %1147 
					                         Input f32* %1149 = OpAccessChain vs_TEXCOORD2 %41 
					                                f32 %1150 = OpLoad %1149 
					                       Private f32* %1151 = OpAccessChain %9 %33 
					                                              OpStore %1151 %1150 
					                read_only Texture2D %1152 = OpLoad %12 
					                            sampler %1153 = OpLoad %16 
					         read_only Texture2DSampled %1154 = OpSampledImage %1152 %1153 
					                              f32_4 %1155 = OpLoad %9 
					                              f32_2 %1156 = OpVectorShuffle %1155 %1155 1 0 
					                              f32_4 %1157 = OpImageSampleExplicitLod %1154 %1156 Lod %7 
					                                f32 %1158 = OpCompositeExtract %1157 1 
					                       Private f32* %1159 = OpAccessChain %48 %41 
					                                              OpStore %1159 %1158 
					                              f32_4 %1160 = OpLoad vs_TEXCOORD3 
					                              f32_2 %1161 = OpVectorShuffle %1160 %1160 2 3 
					                              f32_4 %1162 = OpLoad %66 
					                              f32_4 %1163 = OpVectorShuffle %1162 %1161 4 5 2 3 
					                                              OpStore %66 %1163 
					                       Private f32* %1164 = OpAccessChain %66 %64 
					                                              OpStore %1164 %59 
					                       Private f32* %1165 = OpAccessChain %75 %41 
					                                              OpStore %1165 %31 
					                                              OpBranch %1166 
					                                    %1166 = OpLabel 
					                                              OpLoopMerge %1168 %1169 None 
					                                              OpBranch %1170 
					                                    %1170 = OpLabel 
					                                              OpBranchConditional %82 %1167 %1168 
					                                    %1167 = OpLabel 
					                       Private f32* %1172 = OpAccessChain %66 %33 
					                                f32 %1173 = OpLoad %1172 
					                         Input f32* %1174 = OpAccessChain vs_TEXCOORD4 %753 
					                                f32 %1175 = OpLoad %1174 
					                               bool %1176 = OpFOrdLessThan %1173 %1175 
					                                              OpStore %1171 %1176 
					                       Private f32* %1177 = OpAccessChain %66 %64 
					                                f32 %1178 = OpLoad %1177 
					                               bool %1179 = OpFOrdLessThan %690 %1178 
					                                              OpStore %88 %1179 
					                               bool %1180 = OpLoad %88 
					                               bool %1181 = OpLoad %1171 
					                               bool %1182 = OpLogicalAnd %1180 %1181 
					                                              OpStore %1171 %1182 
					                       Private f32* %1183 = OpAccessChain %75 %41 
					                                f32 %1184 = OpLoad %1183 
					                               bool %1185 = OpFOrdEqual %1184 %31 
					                                              OpStore %88 %1185 
					                               bool %1186 = OpLoad %88 
					                               bool %1187 = OpLoad %1171 
					                               bool %1188 = OpLogicalAnd %1186 %1187 
					                                              OpStore %1171 %1188 
					                               bool %1189 = OpLoad %1171 
					                               bool %1190 = OpLogicalNot %1189 
					                                              OpSelectionMerge %1192 None 
					                                              OpBranchConditional %1190 %1191 %1192 
					                                    %1191 = OpLabel 
					                                              OpBranch %1168 
					                                    %1192 = OpLabel 
					                read_only Texture2D %1194 = OpLoad %12 
					                            sampler %1195 = OpLoad %16 
					         read_only Texture2DSampled %1196 = OpSampledImage %1194 %1195 
					                              f32_4 %1197 = OpLoad %66 
					                              f32_2 %1198 = OpVectorShuffle %1197 %1197 0 1 
					                              f32_4 %1199 = OpImageSampleExplicitLod %1196 %1198 Lod %7 
					                              f32_2 %1200 = OpVectorShuffle %1199 %1199 1 0 
					                              f32_4 %1201 = OpLoad %75 
					                              f32_4 %1202 = OpVectorShuffle %1201 %1200 4 5 2 3 
					                                              OpStore %75 %1202 
					                     Uniform f32_4* %1203 = OpAccessChain %51 %53 
					                              f32_4 %1204 = OpLoad %1203 
					                              f32_2 %1205 = OpVectorShuffle %1204 %1204 0 1 
					                              f32_2 %1207 = OpFMul %1205 %1206 
					                              f32_4 %1208 = OpLoad %66 
					                              f32_2 %1209 = OpVectorShuffle %1208 %1208 0 1 
					                              f32_2 %1210 = OpFAdd %1207 %1209 
					                              f32_4 %1211 = OpLoad %66 
					                              f32_4 %1212 = OpVectorShuffle %1211 %1210 4 5 2 3 
					                                              OpStore %66 %1212 
					                       Private f32* %1213 = OpAccessChain %75 %33 
					                                f32 %1214 = OpLoad %1213 
					                       Private f32* %1215 = OpAccessChain %66 %64 
					                                              OpStore %1215 %1214 
					                                              OpBranch %1169 
					                                    %1169 = OpLabel 
					                                              OpBranch %1166 
					                                    %1168 = OpLabel 
					                              f32_4 %1216 = OpLoad %66 
					                              f32_2 %1217 = OpVectorShuffle %1216 %1216 1 2 
					                              f32_4 %1218 = OpLoad %75 
					                              f32_4 %1219 = OpVectorShuffle %1218 %1217 0 4 5 3 
					                                              OpStore %75 %1219 
					                              f32_4 %1221 = OpLoad %75 
					                              f32_2 %1222 = OpVectorShuffle %1221 %1221 0 2 
					                              f32_2 %1223 = OpFMul %1222 %738 
					                              f32_2 %1224 = OpFAdd %1223 %844 
					                                              OpStore %1220 %1224 
					                read_only Texture2D %1225 = OpLoad %746 
					                            sampler %1226 = OpLoad %16 
					         read_only Texture2DSampled %1227 = OpSampledImage %1225 %1226 
					                              f32_2 %1228 = OpLoad %1220 
					                              f32_4 %1229 = OpImageSampleExplicitLod %1227 %1228 Lod %7 
					                                f32 %1230 = OpCompositeExtract %1229 3 
					                       Private f32* %1231 = OpAccessChain %1220 %41 
					                                              OpStore %1231 %1230 
					                       Private f32* %1232 = OpAccessChain %1220 %41 
					                                f32 %1233 = OpLoad %1232 
					                                f32 %1234 = OpFMul %1233 %756 
					                                f32 %1235 = OpFAdd %1234 %758 
					                       Private f32* %1236 = OpAccessChain %1220 %41 
					                                              OpStore %1236 %1235 
					                       Uniform f32* %1237 = OpAccessChain %51 %53 %33 
					                                f32 %1238 = OpLoad %1237 
					                                f32 %1239 = OpFNegate %1238 
					                       Private f32* %1240 = OpAccessChain %1220 %41 
					                                f32 %1241 = OpLoad %1240 
					                                f32 %1242 = OpFMul %1239 %1241 
					                       Private f32* %1243 = OpAccessChain %75 %33 
					                                f32 %1244 = OpLoad %1243 
					                                f32 %1245 = OpFAdd %1242 %1244 
					                       Private f32* %1246 = OpAccessChain %9 %64 
					                                              OpStore %1246 %1245 
					                     Uniform f32_4* %1247 = OpAccessChain %51 %53 
					                              f32_4 %1248 = OpLoad %1247 
					                              f32_4 %1249 = OpVectorShuffle %1248 %1248 3 3 3 3 
					                              f32_4 %1250 = OpLoad %9 
					                              f32_4 %1251 = OpVectorShuffle %1250 %1250 2 0 2 0 
					                              f32_4 %1252 = OpFMul %1249 %1251 
					                              f32_2 %1253 = OpLoad vs_TEXCOORD1 
					                              f32_4 %1254 = OpVectorShuffle %1253 %1253 1 1 1 1 
					                              f32_4 %1255 = OpFNegate %1254 
					                              f32_4 %1256 = OpFAdd %1252 %1255 
					                                              OpStore %66 %1256 
					                              f32_4 %1257 = OpLoad %66 
					                              f32_4 %1258 = OpExtInst %1 2 %1257 
					                                              OpStore %66 %1258 
					                              f32_4 %1259 = OpLoad %66 
					                              f32_2 %1260 = OpVectorShuffle %1259 %1259 3 2 
					                              f32_2 %1261 = OpExtInst %1 4 %1260 
					                              f32_2 %1262 = OpExtInst %1 31 %1261 
					                                              OpStore %1220 %1262 
					                read_only Texture2D %1263 = OpLoad %12 
					                            sampler %1264 = OpLoad %16 
					         read_only Texture2DSampled %1265 = OpSampledImage %1263 %1264 
					                              f32_4 %1266 = OpLoad %9 
					                              f32_2 %1267 = OpVectorShuffle %1266 %1266 1 2 
					                              f32_4 %1268 = OpImageSampleExplicitLod %1265 %1267 Lod %7ConstOffset %1268 
					                                f32 %1269 = OpCompositeExtract %1268 1 
					                       Private f32* %1270 = OpAccessChain %48 %33 
					                                              OpStore %1270 %1269 
					                              f32_4 %1271 = OpLoad %48 
					                              f32_2 %1272 = OpVectorShuffle %1271 %1271 0 1 
					                              f32_2 %1273 = OpFMul %1272 %892 
					                              f32_4 %1274 = OpLoad %48 
					                              f32_4 %1275 = OpVectorShuffle %1274 %1273 4 5 2 3 
					                                              OpStore %48 %1275 
					                              f32_4 %1276 = OpLoad %48 
					                              f32_2 %1277 = OpVectorShuffle %1276 %1276 0 1 
					                              f32_2 %1278 = OpExtInst %1 2 %1277 
					                              f32_4 %1279 = OpLoad %48 
					                              f32_4 %1280 = OpVectorShuffle %1279 %1278 4 5 2 3 
					                                              OpStore %48 %1280 
					                              f32_4 %1281 = OpLoad %48 
					                              f32_2 %1282 = OpVectorShuffle %1281 %1281 0 1 
					                              f32_2 %1283 = OpFMul %1282 %904 
					                              f32_2 %1284 = OpLoad %1220 
					                              f32_2 %1285 = OpFAdd %1283 %1284 
					                              f32_4 %1286 = OpLoad %48 
					                              f32_4 %1287 = OpVectorShuffle %1286 %1285 4 5 2 3 
					                                              OpStore %48 %1287 
					                              f32_4 %1288 = OpLoad %48 
					                              f32_2 %1289 = OpVectorShuffle %1288 %1288 0 1 
					                              f32_2 %1290 = OpFMul %1289 %346 
					                              f32_2 %1291 = OpFAdd %1290 %914 
					                              f32_4 %1292 = OpLoad %48 
					                              f32_4 %1293 = OpVectorShuffle %1292 %1291 4 5 2 3 
					                                              OpStore %48 %1293 
					                read_only Texture2D %1294 = OpLoad %354 
					                            sampler %1295 = OpLoad %16 
					         read_only Texture2DSampled %1296 = OpSampledImage %1294 %1295 
					                              f32_4 %1297 = OpLoad %48 
					                              f32_2 %1298 = OpVectorShuffle %1297 %1297 0 1 
					                              f32_4 %1299 = OpImageSampleExplicitLod %1296 %1298 Lod %7 
					                              f32_2 %1300 = OpVectorShuffle %1299 %1299 0 1 
					                              f32_4 %1301 = OpLoad %48 
					                              f32_4 %1302 = OpVectorShuffle %1301 %1300 4 5 2 3 
					                                              OpStore %48 %1302 
					                              f32_4 %1303 = OpLoad %66 
					                              f32_4 %1304 = OpExtInst %1 4 %1303 
					                              f32_4 %1305 = OpLoad %66 
					                              f32_4 %1306 = OpVectorShuffle %1305 %1305 3 2 3 2 
					                              f32_4 %1307 = OpExtInst %1 4 %1306 
					                             bool_4 %1308 = OpFOrdGreaterThanEqual %1304 %1307 
					                                              OpStore %601 %1308 
					                      Private bool* %1309 = OpAccessChain %601 %41 
					                               bool %1310 = OpLoad %1309 
					                                f32 %1311 = OpSelect %1310 %59 %31 
					                       Private f32* %1312 = OpAccessChain %66 %41 
					                                              OpStore %1312 %1311 
					                      Private bool* %1313 = OpAccessChain %601 %33 
					                               bool %1314 = OpLoad %1313 
					                                f32 %1315 = OpSelect %1314 %59 %31 
					                       Private f32* %1316 = OpAccessChain %66 %33 
					                                              OpStore %1316 %1315 
					                      Private bool* %1317 = OpAccessChain %601 %64 
					                               bool %1318 = OpLoad %1317 
					                                f32 %1319 = OpSelect %1318 %943 %31 
					                       Private f32* %1320 = OpAccessChain %66 %64 
					                                              OpStore %1320 %1319 
					                      Private bool* %1321 = OpAccessChain %601 %753 
					                               bool %1322 = OpLoad %1321 
					                                f32 %1323 = OpSelect %1322 %943 %31 
					                       Private f32* %1324 = OpAccessChain %66 %753 
					                                              OpStore %1324 %1323 
					                       Private f32* %1325 = OpAccessChain %66 %33 
					                                f32 %1326 = OpLoad %1325 
					                       Private f32* %1327 = OpAccessChain %66 %41 
					                                f32 %1328 = OpLoad %1327 
					                                f32 %1329 = OpFAdd %1326 %1328 
					                       Private f32* %1330 = OpAccessChain %72 %41 
					                                              OpStore %1330 %1329 
					                              f32_4 %1331 = OpLoad %66 
					                              f32_2 %1332 = OpVectorShuffle %1331 %1331 2 3 
					                              f32_3 %1333 = OpLoad %72 
					                              f32_2 %1334 = OpVectorShuffle %1333 %1333 0 0 
					                              f32_2 %1335 = OpFDiv %1332 %1334 
					                                              OpStore %1220 %1335 
					                         Input f32* %1336 = OpAccessChain vs_TEXCOORD0 %41 
					                                f32 %1337 = OpLoad %1336 
					                       Private f32* %1338 = OpAccessChain %9 %753 
					                                              OpStore %1338 %1337 
					                read_only Texture2D %1339 = OpLoad %12 
					                            sampler %1340 = OpLoad %16 
					         read_only Texture2DSampled %1341 = OpSampledImage %1339 %1340 
					                              f32_4 %1342 = OpLoad %9 
					                              f32_2 %1343 = OpVectorShuffle %1342 %1342 3 0 
					                              f32_4 %1344 = OpImageSampleExplicitLod %1341 %1343 Lod %7ConstOffset %1344 
					                                f32 %1345 = OpCompositeExtract %1344 1 
					                       Private f32* %1346 = OpAccessChain %72 %41 
					                                              OpStore %1346 %1345 
					                       Private f32* %1347 = OpAccessChain %1220 %41 
					                                f32 %1348 = OpLoad %1347 
					                                f32 %1349 = OpFNegate %1348 
					                       Private f32* %1350 = OpAccessChain %72 %41 
					                                f32 %1351 = OpLoad %1350 
					                                f32 %1352 = OpFMul %1349 %1351 
					                                f32 %1353 = OpFAdd %1352 %59 
					                       Private f32* %1354 = OpAccessChain %72 %41 
					                                              OpStore %1354 %1353 
					                read_only Texture2D %1355 = OpLoad %12 
					                            sampler %1356 = OpLoad %16 
					         read_only Texture2DSampled %1357 = OpSampledImage %1355 %1356 
					                              f32_4 %1358 = OpLoad %9 
					                              f32_2 %1359 = OpVectorShuffle %1358 %1358 3 2 
					                              f32_4 %1360 = OpImageSampleExplicitLod %1357 %1359 Lod %7ConstOffset %1360 
					                                f32 %1361 = OpCompositeExtract %1360 1 
					                       Private f32* %1362 = OpAccessChain %66 %41 
					                                              OpStore %1362 %1361 
					                       Private f32* %1363 = OpAccessChain %1220 %33 
					                                f32 %1364 = OpLoad %1363 
					                                f32 %1365 = OpFNegate %1364 
					                       Private f32* %1366 = OpAccessChain %66 %41 
					                                f32 %1367 = OpLoad %1366 
					                                f32 %1368 = OpFMul %1365 %1367 
					                       Private f32* %1369 = OpAccessChain %72 %41 
					                                f32 %1370 = OpLoad %1369 
					                                f32 %1371 = OpFAdd %1368 %1370 
					                       Private f32* %1372 = OpAccessChain %475 %41 
					                                              OpStore %1372 %1371 
					                       Private f32* %1373 = OpAccessChain %475 %41 
					                                f32 %1374 = OpLoad %1373 
					                                f32 %1375 = OpExtInst %1 43 %1374 %31 %59 
					                       Private f32* %1376 = OpAccessChain %475 %41 
					                                              OpStore %1376 %1375 
					                read_only Texture2D %1377 = OpLoad %12 
					                            sampler %1378 = OpLoad %16 
					         read_only Texture2DSampled %1379 = OpSampledImage %1377 %1378 
					                              f32_4 %1380 = OpLoad %9 
					                              f32_2 %1381 = OpVectorShuffle %1380 %1380 3 0 
					                              f32_4 %1383 = OpImageSampleExplicitLod %1379 %1381 Lod %7ConstOffset %1383 
					                                f32 %1384 = OpCompositeExtract %1383 1 
					                       Private f32* %1385 = OpAccessChain %9 %41 
					                                              OpStore %1385 %1384 
					                       Private f32* %1386 = OpAccessChain %1220 %41 
					                                f32 %1387 = OpLoad %1386 
					                                f32 %1388 = OpFNegate %1387 
					                       Private f32* %1389 = OpAccessChain %9 %41 
					                                f32 %1390 = OpLoad %1389 
					                                f32 %1391 = OpFMul %1388 %1390 
					                                f32 %1392 = OpFAdd %1391 %59 
					                       Private f32* %1393 = OpAccessChain %9 %41 
					                                              OpStore %1393 %1392 
					                read_only Texture2D %1394 = OpLoad %12 
					                            sampler %1395 = OpLoad %16 
					         read_only Texture2DSampled %1396 = OpSampledImage %1394 %1395 
					                              f32_4 %1397 = OpLoad %9 
					                              f32_2 %1398 = OpVectorShuffle %1397 %1397 3 2 
					                              f32_4 %1400 = OpImageSampleExplicitLod %1396 %1398 Lod %7ConstOffset %1400 
					                                f32 %1401 = OpCompositeExtract %1400 1 
					                       Private f32* %1402 = OpAccessChain %72 %41 
					                                              OpStore %1402 %1401 
					                       Private f32* %1403 = OpAccessChain %1220 %33 
					                                f32 %1404 = OpLoad %1403 
					                                f32 %1405 = OpFNegate %1404 
					                       Private f32* %1406 = OpAccessChain %72 %41 
					                                f32 %1407 = OpLoad %1406 
					                                f32 %1408 = OpFMul %1405 %1407 
					                       Private f32* %1409 = OpAccessChain %9 %41 
					                                f32 %1410 = OpLoad %1409 
					                                f32 %1411 = OpFAdd %1408 %1410 
					                       Private f32* %1412 = OpAccessChain %475 %33 
					                                              OpStore %1412 %1411 
					                       Private f32* %1413 = OpAccessChain %475 %33 
					                                f32 %1414 = OpLoad %1413 
					                                f32 %1415 = OpExtInst %1 43 %1414 %31 %59 
					                       Private f32* %1416 = OpAccessChain %475 %33 
					                                              OpStore %1416 %1415 
					                              f32_4 %1417 = OpLoad %48 
					                              f32_2 %1418 = OpVectorShuffle %1417 %1417 0 1 
					                              f32_2 %1419 = OpLoad %475 
					                              f32_2 %1420 = OpFMul %1418 %1419 
					                              f32_4 %1421 = OpLoad %1037 
					                              f32_4 %1422 = OpVectorShuffle %1421 %1420 0 1 4 5 
					                                              OpStore %1037 %1422 
					                                              OpBranch %1061 
					                                    %1423 = OpLabel 
					                              f32_4 %1424 = OpLoad %1037 
					                              f32_4 %1425 = OpVectorShuffle %1424 %1052 0 1 4 5 
					                                              OpStore %1037 %1425 
					                                              OpBranch %1061 
					                                    %1061 = OpLabel 
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
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AreaTex;
					uniform  sampler2D _SearchTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					bvec4 u_xlatb4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bool u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat10;
					bool u_xlatb10;
					vec2 u_xlat14;
					bool u_xlatb14;
					vec2 u_xlat15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb7 = 0.0<u_xlat0.y;
					    if(u_xlatb7){
					        u_xlatb7 = 0.0<u_xlat0.x;
					        if(u_xlatb7){
					            u_xlat1.xy = _MainTex_TexelSize.xy * vec2(-1.0, 1.0);
					            u_xlat1.z = 1.0;
					            u_xlat2.xy = vs_TEXCOORD0.xy;
					            u_xlat3.x = 0.0;
					            u_xlat2.z = -1.0;
					            u_xlat4.x = 1.0;
					            while(true){
					                u_xlatb7 = u_xlat2.z<7.0;
					                u_xlatb14 = 0.899999976<u_xlat4.x;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                if(!u_xlatb7){break;}
					                u_xlat2.xyz = u_xlat1.xyz + u_xlat2.xyz;
					                u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0).yxzw;
					                u_xlat4.x = dot(u_xlat3.yx, vec2(0.5, 0.5));
					            }
					            u_xlatb7 = 0.899999976<u_xlat3.x;
					            u_xlat7.x = u_xlatb7 ? 1.0 : float(0.0);
					            u_xlat1.x = u_xlat7.x + u_xlat2.z;
					        } else {
					            u_xlat1.x = 0.0;
					            u_xlat4.x = 0.0;
					        }
					        u_xlat7.xy = _MainTex_TexelSize.xy * vec2(1.0, -1.0);
					        u_xlat7.z = 1.0;
					        u_xlat2.yz = vs_TEXCOORD0.xy;
					        u_xlat2.x = float(-1.0);
					        u_xlat23 = float(1.0);
					        while(true){
					            u_xlatb3 = u_xlat2.x<7.0;
					            u_xlatb10 = 0.899999976<u_xlat23;
					            u_xlatb3 = u_xlatb10 && u_xlatb3;
					            if(!u_xlatb3){break;}
					            u_xlat2.xyz = u_xlat7.zxy + u_xlat2.xyz;
					            u_xlat3 = textureLod(_MainTex, u_xlat2.yz, 0.0);
					            u_xlat23 = dot(u_xlat3.xy, vec2(0.5, 0.5));
					        }
					        u_xlat4.y = u_xlat23;
					        u_xlat7.x = u_xlat1.x + u_xlat2.x;
					        u_xlatb7 = 2.0<u_xlat7.x;
					        if(u_xlatb7){
					            u_xlat1.y = (-u_xlat1.x) + 0.25;
					            u_xlat1.zw = u_xlat2.xx * vec2(1.0, -1.0) + vec2(0.0, -0.25);
					            u_xlat2 = u_xlat1.yxzw * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
					            u_xlat3 = textureLodOffset(_MainTex, u_xlat2.xy, 0.0, ivec2(-1, 0));
					            u_xlat2 = textureLodOffset(_MainTex, u_xlat2.zw, 0.0, ivec2(1, 0));
					            u_xlat3.z = u_xlat2.x;
					            u_xlat7.xy = u_xlat3.xz * vec2(5.0, 5.0) + vec2(-3.75, -3.75);
					            u_xlat7.xy = abs(u_xlat7.xy) * u_xlat3.xz;
					            u_xlat7.xy = roundEven(u_xlat7.xy);
					            u_xlat8.x = roundEven(u_xlat3.y);
					            u_xlat8.z = roundEven(u_xlat2.y);
					            u_xlat7.xy = u_xlat8.xz * vec2(2.0, 2.0) + u_xlat7.xy;
					            u_xlatb8.xz = greaterThanEqual(u_xlat4.xxyy, vec4(0.899999976, 0.0, 0.899999976, 0.899999976)).xz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? float(0.0) : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.z) ? float(0.0) : u_xlat7.y;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat7.xy = u_xlat7.xy * vec2(20.0, 20.0) + u_xlat1.xz;
					            u_xlat7.xy = u_xlat7.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.503125012, 0.000892857148);
					            u_xlat1 = textureLod(_AreaTex, u_xlat7.xy, 0.0);
					        } else {
					            u_xlat1.x = float(0.0);
					            u_xlat1.y = float(0.0);
					        }
					        u_xlat7.x = _MainTex_TexelSize.x * 0.25 + vs_TEXCOORD0.x;
					        u_xlat2.xy = (-_MainTex_TexelSize.xy);
					        u_xlat2.z = 1.0;
					        u_xlat10.x = u_xlat7.x;
					        u_xlat10.y = vs_TEXCOORD0.y;
					        u_xlat3.x = float(1.0);
					        u_xlat10.z = float(-1.0);
					        while(true){
					            u_xlatb14 = u_xlat10.z<7.0;
					            u_xlatb21 = 0.899999976<u_xlat3.x;
					            u_xlatb14 = u_xlatb21 && u_xlatb14;
					            if(!u_xlatb14){break;}
					            u_xlat10.xyz = u_xlat2.xyz + u_xlat10.xyz;
					            u_xlat4 = textureLod(_MainTex, u_xlat10.xy, 0.0);
					            u_xlat14.x = u_xlat4.x * 5.0 + -3.75;
					            u_xlat14.x = abs(u_xlat14.x) * u_xlat4.x;
					            u_xlat5.x = roundEven(u_xlat14.x);
					            u_xlat5.y = roundEven(u_xlat4.y);
					            u_xlat3.x = dot(u_xlat5.xy, vec2(0.5, 0.5));
					        }
					        u_xlat2.x = u_xlat10.z;
					        u_xlat4 = textureLodOffset(_MainTex, vs_TEXCOORD0.xy, 0.0, ivec2(1, 0));
					        u_xlatb14 = 0.0<u_xlat4.x;
					        if(u_xlatb14){
					            u_xlat4.xy = _MainTex_TexelSize.xy;
					            u_xlat4.z = 1.0;
					            u_xlat5.x = u_xlat7.x;
					            u_xlat5.y = vs_TEXCOORD0.y;
					            u_xlat14.x = 0.0;
					            u_xlat5.z = -1.0;
					            u_xlat3.y = 1.0;
					            while(true){
					                u_xlatb15.x = u_xlat5.z<7.0;
					                u_xlatb22 = 0.899999976<u_xlat3.y;
					                u_xlatb15.x = u_xlatb22 && u_xlatb15.x;
					                if(!u_xlatb15.x){break;}
					                u_xlat5.xyz = u_xlat4.xyz + u_xlat5.xyz;
					                u_xlat6 = textureLod(_MainTex, u_xlat5.xy, 0.0);
					                u_xlat15.x = u_xlat6.x * 5.0 + -3.75;
					                u_xlat15.x = abs(u_xlat15.x) * u_xlat6.x;
					                u_xlat14.y = roundEven(u_xlat15.x);
					                u_xlat14.x = roundEven(u_xlat6.y);
					                u_xlat3.y = dot(u_xlat14.yx, vec2(0.5, 0.5));
					            }
					            u_xlatb7 = 0.899999976<u_xlat14.x;
					            u_xlat7.x = u_xlatb7 ? 1.0 : float(0.0);
					            u_xlat2.z = u_xlat7.x + u_xlat5.z;
					        } else {
					            u_xlat2.z = 0.0;
					            u_xlat3.y = 0.0;
					        }
					        u_xlat7.x = u_xlat2.z + u_xlat2.x;
					        u_xlatb7 = 2.0<u_xlat7.x;
					        if(u_xlatb7){
					            u_xlat2.y = (-u_xlat2.x);
					            u_xlat4 = u_xlat2.yyzz * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
					            u_xlat5 = textureLodOffset(_MainTex, u_xlat4.xy, 0.0, ivec2(-1, 0));
					            u_xlat6 = textureLodOffset(_MainTex, u_xlat4.xy, 0.0, ivec2(0, -1)).yzxw;
					            u_xlat4 = textureLodOffset(_MainTex, u_xlat4.zw, 0.0, ivec2(1, 0));
					            u_xlat6.x = u_xlat5.y;
					            u_xlat6.yw = u_xlat4.yx;
					            u_xlat7.xy = u_xlat6.xy * vec2(2.0, 2.0) + u_xlat6.zw;
					            u_xlatb15.xy = greaterThanEqual(u_xlat3.xyxy, vec4(0.899999976, 0.899999976, 0.899999976, 0.899999976)).xy;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb15.x) ? float(0.0) : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb15.y) ? float(0.0) : u_xlat7.y;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat7.xy = u_xlat7.xy * vec2(20.0, 20.0) + u_xlat2.xz;
					            u_xlat7.xy = u_xlat7.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.503125012, 0.000892857148);
					            u_xlat2 = textureLod(_AreaTex, u_xlat7.xy, 0.0);
					            u_xlat1.xy = u_xlat1.xy + u_xlat2.yx;
					        }
					        u_xlatb7 = (-u_xlat1.y)==u_xlat1.x;
					        if(u_xlatb7){
					            u_xlat2.xy = vs_TEXCOORD2.xy;
					            u_xlat2.z = 1.0;
					            u_xlat3.x = 0.0;
					            while(true){
					                u_xlatb7 = vs_TEXCOORD4.x<u_xlat2.x;
					                u_xlatb14 = 0.828100026<u_xlat2.z;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                u_xlatb14 = u_xlat3.x==0.0;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                if(!u_xlatb7){break;}
					                u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					                u_xlat2.xy = _MainTex_TexelSize.xy * vec2(-2.0, -0.0) + u_xlat2.xy;
					                u_xlat2.z = u_xlat3.y;
					            }
					            u_xlat3.yz = u_xlat2.xz;
					            u_xlat7.xy = u_xlat3.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					            u_xlat2 = textureLod(_SearchTex, u_xlat7.xy, 0.0);
					            u_xlat7.x = u_xlat2.w * -2.00787401 + 3.25;
					            u_xlat2.x = _MainTex_TexelSize.x * u_xlat7.x + u_xlat3.y;
					            u_xlat2.y = vs_TEXCOORD3.y;
					            u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					            u_xlat4.xy = vs_TEXCOORD2.zw;
					            u_xlat4.z = 1.0;
					            u_xlat5.x = 0.0;
					            while(true){
					                u_xlatb7 = u_xlat4.x<vs_TEXCOORD4.y;
					                u_xlatb14 = 0.828100026<u_xlat4.z;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                u_xlatb14 = u_xlat5.x==0.0;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                if(!u_xlatb7){break;}
					                u_xlat5 = textureLod(_MainTex, u_xlat4.xy, 0.0);
					                u_xlat4.xy = _MainTex_TexelSize.xy * vec2(2.0, 0.0) + u_xlat4.xy;
					                u_xlat4.z = u_xlat5.y;
					            }
					            u_xlat5.yz = u_xlat4.xz;
					            u_xlat7.xy = u_xlat5.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					            u_xlat4 = textureLod(_SearchTex, u_xlat7.xy, 0.0);
					            u_xlat7.x = u_xlat4.w * -2.00787401 + 3.25;
					            u_xlat2.z = (-_MainTex_TexelSize.x) * u_xlat7.x + u_xlat5.y;
					            u_xlat4 = _MainTex_TexelSize.zzzz * u_xlat2.zxzx + (-vs_TEXCOORD1.xxxx);
					            u_xlat4 = roundEven(u_xlat4);
					            u_xlat7.xy = sqrt(abs(u_xlat4.wz));
					            u_xlat5 = textureLodOffset(_MainTex, u_xlat2.zy, 0.0, ivec2(1, 0)).yxzw;
					            u_xlat5.x = u_xlat3.x;
					            u_xlat15.xy = u_xlat5.xy * vec2(4.0, 4.0);
					            u_xlat15.xy = roundEven(u_xlat15.xy);
					            u_xlat7.xy = u_xlat15.xy * vec2(16.0, 16.0) + u_xlat7.xy;
					            u_xlat7.xy = u_xlat7.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					            u_xlat3 = textureLod(_AreaTex, u_xlat7.xy, 0.0);
					            u_xlatb4 = greaterThanEqual(abs(u_xlat4), abs(u_xlat4.wzwz));
					            u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					            u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					            u_xlat4.z = u_xlatb4.z ? float(0.75) : 0.0;
					            u_xlat4.w = u_xlatb4.w ? float(0.75) : 0.0;
					;
					            u_xlat7.x = u_xlat4.y + u_xlat4.x;
					            u_xlat7.xy = u_xlat4.zw / u_xlat7.xx;
					            u_xlat2.w = vs_TEXCOORD0.y;
					            u_xlat4 = textureLodOffset(_MainTex, u_xlat2.xw, 0.0, ivec2(0, 1));
					            u_xlat21 = (-u_xlat7.x) * u_xlat4.x + 1.0;
					            u_xlat4 = textureLodOffset(_MainTex, u_xlat2.zw, 0.0, ivec2(1, 1));
					            u_xlat4.x = (-u_xlat7.y) * u_xlat4.x + u_xlat21;
					            u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					            u_xlat5 = textureLodOffset(_MainTex, u_xlat2.xw, 0.0, ivec2(0, -2));
					            u_xlat7.x = (-u_xlat7.x) * u_xlat5.x + 1.0;
					            u_xlat2 = textureLodOffset(_MainTex, u_xlat2.zw, 0.0, ivec2(1, -2));
					            u_xlat4.y = (-u_xlat7.y) * u_xlat2.x + u_xlat7.x;
					            u_xlat4.y = clamp(u_xlat4.y, 0.0, 1.0);
					            SV_Target0.xy = u_xlat3.xy * u_xlat4.xy;
					        } else {
					            SV_Target0.xy = u_xlat1.xy;
					            u_xlat0.x = 0.0;
					        }
					    } else {
					        SV_Target0.xy = vec2(0.0, 0.0);
					    }
					    u_xlatb0 = 0.0<u_xlat0.x;
					    if(u_xlatb0){
					        u_xlat0.xy = vs_TEXCOORD3.xy;
					        u_xlat0.z = 1.0;
					        u_xlat1.x = 0.0;
					        while(true){
					            u_xlatb21 = vs_TEXCOORD4.z<u_xlat0.y;
					            u_xlatb2.x = 0.828100026<u_xlat0.z;
					            u_xlatb21 = u_xlatb21 && u_xlatb2.x;
					            u_xlatb2.x = u_xlat1.x==0.0;
					            u_xlatb21 = u_xlatb21 && u_xlatb2.x;
					            if(!u_xlatb21){break;}
					            u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0).yxzw;
					            u_xlat0.xy = _MainTex_TexelSize.xy * vec2(-0.0, -2.0) + u_xlat0.xy;
					            u_xlat0.z = u_xlat1.y;
					        }
					        u_xlat1.yz = u_xlat0.yz;
					        u_xlat0.xy = u_xlat1.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat0 = textureLod(_SearchTex, u_xlat0.xy, 0.0);
					        u_xlat0.x = u_xlat0.w * -2.00787401 + 3.25;
					        u_xlat0.x = _MainTex_TexelSize.y * u_xlat0.x + u_xlat1.y;
					        u_xlat0.y = vs_TEXCOORD2.x;
					        u_xlat1 = textureLod(_MainTex, u_xlat0.yx, 0.0);
					        u_xlat2.xy = vs_TEXCOORD3.zw;
					        u_xlat2.z = 1.0;
					        u_xlat3.x = 0.0;
					        while(true){
					            u_xlatb1 = u_xlat2.y<vs_TEXCOORD4.w;
					            u_xlatb15.x = 0.828100026<u_xlat2.z;
					            u_xlatb1 = u_xlatb15.x && u_xlatb1;
					            u_xlatb15.x = u_xlat3.x==0.0;
					            u_xlatb1 = u_xlatb15.x && u_xlatb1;
					            if(!u_xlatb1){break;}
					            u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0).yxzw;
					            u_xlat2.xy = _MainTex_TexelSize.xy * vec2(0.0, 2.0) + u_xlat2.xy;
					            u_xlat2.z = u_xlat3.y;
					        }
					        u_xlat3.yz = u_xlat2.yz;
					        u_xlat1.xz = u_xlat3.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat2 = textureLod(_SearchTex, u_xlat1.xz, 0.0);
					        u_xlat1.x = u_xlat2.w * -2.00787401 + 3.25;
					        u_xlat0.z = (-_MainTex_TexelSize.y) * u_xlat1.x + u_xlat3.y;
					        u_xlat2 = _MainTex_TexelSize.wwww * u_xlat0.zxzx + (-vs_TEXCOORD1.yyyy);
					        u_xlat2 = roundEven(u_xlat2);
					        u_xlat1.xz = sqrt(abs(u_xlat2.wz));
					        u_xlat3 = textureLodOffset(_MainTex, u_xlat0.yz, 0.0, ivec2(0, 1));
					        u_xlat3.x = u_xlat1.y;
					        u_xlat8.xz = u_xlat3.xy * vec2(4.0, 4.0);
					        u_xlat8.xz = roundEven(u_xlat8.xz);
					        u_xlat1.xy = u_xlat8.xz * vec2(16.0, 16.0) + u_xlat1.xz;
					        u_xlat1.xy = u_xlat1.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat1 = textureLod(_AreaTex, u_xlat1.xy, 0.0);
					        u_xlatb2 = greaterThanEqual(abs(u_xlat2), abs(u_xlat2.wzwz));
					        u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					        u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
					        u_xlat2.z = u_xlatb2.z ? float(0.75) : 0.0;
					        u_xlat2.w = u_xlatb2.w ? float(0.75) : 0.0;
					;
					        u_xlat7.x = u_xlat2.y + u_xlat2.x;
					        u_xlat15.xy = u_xlat2.zw / u_xlat7.xx;
					        u_xlat0.w = vs_TEXCOORD0.x;
					        u_xlat2 = textureLodOffset(_MainTex, u_xlat0.wx, 0.0, ivec2(1, 0));
					        u_xlat7.x = (-u_xlat15.x) * u_xlat2.y + 1.0;
					        u_xlat2 = textureLodOffset(_MainTex, u_xlat0.wz, 0.0, ivec2(1, 1));
					        u_xlat16.x = (-u_xlat15.y) * u_xlat2.y + u_xlat7.x;
					        u_xlat16.x = clamp(u_xlat16.x, 0.0, 1.0);
					        u_xlat3 = textureLodOffset(_MainTex, u_xlat0.wx, 0.0, ivec2(-2, 0));
					        u_xlat0.x = (-u_xlat15.x) * u_xlat3.y + 1.0;
					        u_xlat3 = textureLodOffset(_MainTex, u_xlat0.wz, 0.0, ivec2(-2, 1));
					        u_xlat16.y = (-u_xlat15.y) * u_xlat3.y + u_xlat0.x;
					        u_xlat16.y = clamp(u_xlat16.y, 0.0, 1.0);
					        SV_Target0.zw = u_xlat1.xy * u_xlat16.xy;
					    } else {
					        SV_Target0.zw = vec2(0.0, 0.0);
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
			GpuProgramID 434867
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, 0.0, 1.0) + u_xlat0.xyxy;
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
					uniform 	vec4 _MainTex_TexelSize;
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, 0.0, 1.0) + u_xlat0.xyxy;
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
					UNITY_LOCATION(0) uniform  sampler2D _BlendTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = texture(_BlendTex, vs_TEXCOORD1.xy);
					    u_xlat1 = texture(_BlendTex, vs_TEXCOORD1.zw);
					    u_xlat2 = texture(_BlendTex, vs_TEXCOORD0.xy).ywzx;
					    u_xlat2.x = u_xlat0.w;
					    u_xlat2.y = u_xlat1.y;
					    u_xlat0.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb0 = u_xlat0.x<9.99999975e-06;
					    if(u_xlatb0){
					        SV_Target0 = textureLod(_MainTex, vs_TEXCOORD0.xy, 0.0);
					    } else {
					        u_xlat0.x = max(u_xlat0.w, u_xlat2.z);
					        u_xlat3 = max(u_xlat2.w, u_xlat2.y);
					        u_xlatb0 = u_xlat3<u_xlat0.x;
					        u_xlat1.x = u_xlatb0 ? u_xlat0.w : float(0.0);
					        u_xlat1.z = u_xlatb0 ? u_xlat2.z : float(0.0);
					        u_xlat1.yw = (bool(u_xlatb0)) ? vec2(0.0, 0.0) : u_xlat2.yw;
					        u_xlat2.x = (u_xlatb0) ? u_xlat0.w : u_xlat2.y;
					        u_xlat2.y = (u_xlatb0) ? u_xlat2.z : u_xlat2.w;
					        u_xlat0.x = dot(u_xlat2.xy, vec2(1.0, 1.0));
					        u_xlat0.xy = u_xlat2.xy / u_xlat0.xx;
					        u_xlat2 = _MainTex_TexelSize.xyxy * vec4(1.0, 1.0, -1.0, -1.0);
					        u_xlat1 = u_xlat1 * u_xlat2 + vs_TEXCOORD0.xyxy;
					        u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					        u_xlat1 = textureLod(_MainTex, u_xlat1.zw, 0.0);
					        u_xlat1 = u_xlat0.yyyy * u_xlat1;
					        SV_Target0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
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
					; Bound: 66
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %45 %47 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD0 Location 45 
					                                             OpDecorate vs_TEXCOORD1 Location 47 
					                                             OpMemberDecorate %48 0 Offset 48 
					                                             OpDecorate %48 Block 
					                                             OpDecorate %50 DescriptorSet 50 
					                                             OpDecorate %50 Binding 50 
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
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					              Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                     %48 = OpTypeStruct %7 
					                                     %49 = OpTypePointer Uniform %48 
					            Uniform struct {f32_4;}* %50 = OpVariable Uniform 
					                                     %51 = OpTypePointer Uniform %7 
					                               f32_4 %55 = OpConstantComposite %27 %26 %26 %27 
					                                     %60 = OpTypePointer Output %6 
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
					                                             OpStore vs_TEXCOORD0 %46 
					                      Uniform f32_4* %52 = OpAccessChain %50 %15 
					                               f32_4 %53 = OpLoad %52 
					                               f32_4 %54 = OpVectorShuffle %53 %53 0 1 0 1 
					                               f32_4 %56 = OpFMul %54 %55 
					                               f32_2 %57 = OpLoad %33 
					                               f32_4 %58 = OpVectorShuffle %57 %57 0 1 0 1 
					                               f32_4 %59 = OpFAdd %56 %58 
					                                             OpStore vs_TEXCOORD1 %59 
					                         Output f32* %61 = OpAccessChain %13 %15 %9 
					                                 f32 %62 = OpLoad %61 
					                                 f32 %63 = OpFNegate %62 
					                         Output f32* %64 = OpAccessChain %13 %15 %9 
					                                             OpStore %64 %63 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 189
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %21 %45 %68 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate vs_TEXCOORD1 Location 21 
					                                             OpDecorate vs_TEXCOORD0 Location 45 
					                                             OpDecorate %68 Location 68 
					                                             OpDecorate %69 DescriptorSet 69 
					                                             OpDecorate %69 Binding 69 
					                                             OpMemberDecorate %148 0 Offset 148 
					                                             OpDecorate %148 Block 
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
					                                     %20 = OpTypePointer Input %7 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                     %22 = OpTypeVector %6 2 
					                                     %26 = OpTypeInt 32 0 
					                                 u32 %27 = OpConstant 3 
					                                 u32 %29 = OpConstant 0 
					                                     %30 = OpTypePointer Private %6 
					                                 u32 %38 = OpConstant 1 
					                                     %44 = OpTypePointer Input %22 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                      Private f32_4* %51 = OpVariable Private 
					                                 f32 %53 = OpConstant 3,674022E-40 
					                               f32_4 %54 = OpConstantComposite %53 %53 %53 %53 
					                                     %57 = OpTypeBool 
					                                     %58 = OpTypePointer Private %57 
					                       Private bool* %59 = OpVariable Private 
					                                 f32 %62 = OpConstant 3,674022E-40 
					                                     %67 = OpTypePointer Output %7 
					                       Output f32_4* %68 = OpVariable Output 
					UniformConstant read_only Texture2D* %69 = OpVariable UniformConstant 
					                                 f32 %74 = OpConstant 3,674022E-40 
					                      Private f32_4* %89 = OpVariable Private 
					                                     %91 = OpTypePointer Function %22 
					                               f32_2 %98 = OpConstantComposite %74 %74 
					                                    %113 = OpTypePointer Function %6 
					                                u32 %128 = OpConstant 2 
					                       Private f32* %136 = OpVariable Private 
					                              f32_2 %139 = OpConstantComposite %53 %53 
					                                    %148 = OpTypeStruct %7 
					                                    %149 = OpTypePointer Uniform %148 
					           Uniform struct {f32_4;}* %150 = OpVariable Uniform 
					                                    %151 = OpTypeInt 32 1 
					                                i32 %152 = OpConstant 0 
					                                    %153 = OpTypePointer Uniform %7 
					                                f32 %157 = OpConstant 3,674022E-40 
					                              f32_4 %158 = OpConstantComposite %53 %53 %157 %157 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                     Function f32_2* %92 = OpVariable Function 
					                    Function f32_2* %103 = OpVariable Function 
					                      Function f32* %114 = OpVariable Function 
					                      Function f32* %125 = OpVariable Function 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_4 %23 = OpLoad vs_TEXCOORD1 
					                               f32_2 %24 = OpVectorShuffle %23 %23 0 1 
					                               f32_4 %25 = OpImageSampleImplicitLod %19 %24 
					                                 f32 %28 = OpCompositeExtract %25 3 
					                        Private f32* %31 = OpAccessChain %9 %29 
					                                             OpStore %31 %28 
					                 read_only Texture2D %32 = OpLoad %12 
					                             sampler %33 = OpLoad %16 
					          read_only Texture2DSampled %34 = OpSampledImage %32 %33 
					                               f32_4 %35 = OpLoad vs_TEXCOORD1 
					                               f32_2 %36 = OpVectorShuffle %35 %35 2 3 
					                               f32_4 %37 = OpImageSampleImplicitLod %34 %36 
					                                 f32 %39 = OpCompositeExtract %37 1 
					                        Private f32* %40 = OpAccessChain %9 %38 
					                                             OpStore %40 %39 
					                 read_only Texture2D %41 = OpLoad %12 
					                             sampler %42 = OpLoad %16 
					          read_only Texture2DSampled %43 = OpSampledImage %41 %42 
					                               f32_2 %46 = OpLoad vs_TEXCOORD0 
					                               f32_4 %47 = OpImageSampleImplicitLod %43 %46 
					                               f32_2 %48 = OpVectorShuffle %47 %47 2 0 
					                               f32_4 %49 = OpLoad %9 
					                               f32_4 %50 = OpVectorShuffle %49 %48 0 1 4 5 
					                                             OpStore %9 %50 
					                               f32_4 %52 = OpLoad %9 
					                                 f32 %55 = OpDot %52 %54 
					                        Private f32* %56 = OpAccessChain %51 %29 
					                                             OpStore %56 %55 
					                        Private f32* %60 = OpAccessChain %51 %29 
					                                 f32 %61 = OpLoad %60 
					                                bool %63 = OpFOrdLessThan %61 %62 
					                                             OpStore %59 %63 
					                                bool %64 = OpLoad %59 
					                                             OpSelectionMerge %66 None 
					                                             OpBranchConditional %64 %65 %76 
					                                     %65 = OpLabel 
					                 read_only Texture2D %70 = OpLoad %69 
					                             sampler %71 = OpLoad %16 
					          read_only Texture2DSampled %72 = OpSampledImage %70 %71 
					                               f32_2 %73 = OpLoad vs_TEXCOORD0 
					                               f32_4 %75 = OpImageSampleExplicitLod %72 %73 Lod %7 
					                                             OpStore %68 %75 
					                                             OpBranch %66 
					                                     %76 = OpLabel 
					                               f32_4 %77 = OpLoad %9 
					                               f32_2 %78 = OpVectorShuffle %77 %77 2 3 
					                               f32_4 %79 = OpLoad %9 
					                               f32_2 %80 = OpVectorShuffle %79 %79 0 1 
					                               f32_2 %81 = OpExtInst %1 40 %78 %80 
					                               f32_4 %82 = OpLoad %51 
					                               f32_4 %83 = OpVectorShuffle %82 %81 4 5 2 3 
					                                             OpStore %51 %83 
					                        Private f32* %84 = OpAccessChain %51 %38 
					                                 f32 %85 = OpLoad %84 
					                        Private f32* %86 = OpAccessChain %51 %29 
					                                 f32 %87 = OpLoad %86 
					                                bool %88 = OpFOrdLessThan %85 %87 
					                                             OpStore %59 %88 
					                                bool %90 = OpLoad %59 
					                                             OpSelectionMerge %94 None 
					                                             OpBranchConditional %90 %93 %97 
					                                     %93 = OpLabel 
					                               f32_4 %95 = OpLoad %9 
					                               f32_2 %96 = OpVectorShuffle %95 %95 0 2 
					                                             OpStore %92 %96 
					                                             OpBranch %94 
					                                     %97 = OpLabel 
					                                             OpStore %92 %98 
					                                             OpBranch %94 
					                                     %94 = OpLabel 
					                               f32_2 %99 = OpLoad %92 
					                              f32_4 %100 = OpLoad %89 
					                              f32_4 %101 = OpVectorShuffle %100 %99 4 1 5 3 
					                                             OpStore %89 %101 
					                               bool %102 = OpLoad %59 
					                                             OpSelectionMerge %105 None 
					                                             OpBranchConditional %102 %104 %106 
					                                    %104 = OpLabel 
					                                             OpStore %103 %98 
					                                             OpBranch %105 
					                                    %106 = OpLabel 
					                              f32_4 %107 = OpLoad %9 
					                              f32_2 %108 = OpVectorShuffle %107 %107 1 3 
					                                             OpStore %103 %108 
					                                             OpBranch %105 
					                                    %105 = OpLabel 
					                              f32_2 %109 = OpLoad %103 
					                              f32_4 %110 = OpLoad %89 
					                              f32_4 %111 = OpVectorShuffle %110 %109 0 4 2 5 
					                                             OpStore %89 %111 
					                               bool %112 = OpLoad %59 
					                                             OpSelectionMerge %116 None 
					                                             OpBranchConditional %112 %115 %119 
					                                    %115 = OpLabel 
					                       Private f32* %117 = OpAccessChain %9 %29 
					                                f32 %118 = OpLoad %117 
					                                             OpStore %114 %118 
					                                             OpBranch %116 
					                                    %119 = OpLabel 
					                       Private f32* %120 = OpAccessChain %9 %38 
					                                f32 %121 = OpLoad %120 
					                                             OpStore %114 %121 
					                                             OpBranch %116 
					                                    %116 = OpLabel 
					                                f32 %122 = OpLoad %114 
					                       Private f32* %123 = OpAccessChain %9 %29 
					                                             OpStore %123 %122 
					                               bool %124 = OpLoad %59 
					                                             OpSelectionMerge %127 None 
					                                             OpBranchConditional %124 %126 %131 
					                                    %126 = OpLabel 
					                       Private f32* %129 = OpAccessChain %9 %128 
					                                f32 %130 = OpLoad %129 
					                                             OpStore %125 %130 
					                                             OpBranch %127 
					                                    %131 = OpLabel 
					                       Private f32* %132 = OpAccessChain %9 %27 
					                                f32 %133 = OpLoad %132 
					                                             OpStore %125 %133 
					                                             OpBranch %127 
					                                    %127 = OpLabel 
					                                f32 %134 = OpLoad %125 
					                       Private f32* %135 = OpAccessChain %9 %38 
					                                             OpStore %135 %134 
					                              f32_4 %137 = OpLoad %9 
					                              f32_2 %138 = OpVectorShuffle %137 %137 0 1 
					                                f32 %140 = OpDot %138 %139 
					                                             OpStore %136 %140 
					                              f32_4 %141 = OpLoad %9 
					                              f32_2 %142 = OpVectorShuffle %141 %141 0 1 
					                                f32 %143 = OpLoad %136 
					                              f32_2 %144 = OpCompositeConstruct %143 %143 
					                              f32_2 %145 = OpFDiv %142 %144 
					                              f32_4 %146 = OpLoad %9 
					                              f32_4 %147 = OpVectorShuffle %146 %145 4 5 2 3 
					                                             OpStore %9 %147 
					                     Uniform f32_4* %154 = OpAccessChain %150 %152 
					                              f32_4 %155 = OpLoad %154 
					                              f32_4 %156 = OpVectorShuffle %155 %155 0 1 0 1 
					                              f32_4 %159 = OpFMul %156 %158 
					                                             OpStore %51 %159 
					                              f32_4 %160 = OpLoad %89 
					                              f32_4 %161 = OpLoad %51 
					                              f32_4 %162 = OpFMul %160 %161 
					                              f32_2 %163 = OpLoad vs_TEXCOORD0 
					                              f32_4 %164 = OpVectorShuffle %163 %163 0 1 0 1 
					                              f32_4 %165 = OpFAdd %162 %164 
					                                             OpStore %51 %165 
					                read_only Texture2D %166 = OpLoad %69 
					                            sampler %167 = OpLoad %16 
					         read_only Texture2DSampled %168 = OpSampledImage %166 %167 
					                              f32_4 %169 = OpLoad %51 
					                              f32_2 %170 = OpVectorShuffle %169 %169 0 1 
					                              f32_4 %171 = OpImageSampleExplicitLod %168 %170 Lod %7 
					                                             OpStore %89 %171 
					                read_only Texture2D %172 = OpLoad %69 
					                            sampler %173 = OpLoad %16 
					         read_only Texture2DSampled %174 = OpSampledImage %172 %173 
					                              f32_4 %175 = OpLoad %51 
					                              f32_2 %176 = OpVectorShuffle %175 %175 2 3 
					                              f32_4 %177 = OpImageSampleExplicitLod %174 %176 Lod %7 
					                                             OpStore %51 %177 
					                              f32_4 %178 = OpLoad %9 
					                              f32_4 %179 = OpVectorShuffle %178 %178 1 1 1 1 
					                              f32_4 %180 = OpLoad %51 
					                              f32_4 %181 = OpFMul %179 %180 
					                                             OpStore %51 %181 
					                              f32_4 %182 = OpLoad %9 
					                              f32_4 %183 = OpVectorShuffle %182 %182 0 0 0 0 
					                              f32_4 %184 = OpLoad %89 
					                              f32_4 %185 = OpFMul %183 %184 
					                              f32_4 %186 = OpLoad %51 
					                              f32_4 %187 = OpFAdd %185 %186 
					                                             OpStore %68 %187 
					                                             OpBranch %66 
					                                     %66 = OpLabel 
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
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _BlendTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = texture(_BlendTex, vs_TEXCOORD1.xy);
					    u_xlat1 = texture(_BlendTex, vs_TEXCOORD1.zw);
					    u_xlat2 = texture(_BlendTex, vs_TEXCOORD0.xy).ywzx;
					    u_xlat2.x = u_xlat0.w;
					    u_xlat2.y = u_xlat1.y;
					    u_xlat0.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb0 = u_xlat0.x<9.99999975e-06;
					    if(u_xlatb0){
					        SV_Target0 = textureLod(_MainTex, vs_TEXCOORD0.xy, 0.0);
					    } else {
					        u_xlat0.x = max(u_xlat0.w, u_xlat2.z);
					        u_xlat3 = max(u_xlat2.w, u_xlat2.y);
					        u_xlatb0 = u_xlat3<u_xlat0.x;
					        u_xlat1.x = u_xlatb0 ? u_xlat0.w : float(0.0);
					        u_xlat1.z = u_xlatb0 ? u_xlat2.z : float(0.0);
					        u_xlat1.yw = (bool(u_xlatb0)) ? vec2(0.0, 0.0) : u_xlat2.yw;
					        u_xlat2.x = (u_xlatb0) ? u_xlat0.w : u_xlat2.y;
					        u_xlat2.y = (u_xlatb0) ? u_xlat2.z : u_xlat2.w;
					        u_xlat0.x = dot(u_xlat2.xy, vec2(1.0, 1.0));
					        u_xlat0.xy = u_xlat2.xy / u_xlat0.xx;
					        u_xlat2 = _MainTex_TexelSize.xyxy * vec4(1.0, 1.0, -1.0, -1.0);
					        u_xlat1 = u_xlat1 * u_xlat2 + vs_TEXCOORD0.xyxy;
					        u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					        u_xlat1 = textureLod(_MainTex, u_xlat1.zw, 0.0);
					        u_xlat1 = u_xlat0.yyyy * u_xlat1;
					        SV_Target0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
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
	}
}