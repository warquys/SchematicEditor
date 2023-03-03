Shader "Hidden/PostProcessing/ScreenSpaceReflections" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 62015
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_1;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    phase0_Output0_1 = u_xlat0 * vec4(0.5, -0.5, 0.5, -0.5) + vec4(0.0, 1.0, 0.0, 1.0);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!GL4x
					#ifdef VERTEX
					#version 420
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_shading_language_420pack : require
					
					in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_1;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    phase0_Output0_1 = u_xlat0 * vec4(0.5, 0.5, 0.5, 0.5);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
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
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 _Test_TexelSize;
					uniform 	vec4 hlslcc_mtx4x4_ViewMatrix[4];
					uniform 	vec4 hlslcc_mtx4x4_InverseProjectionMatrix[4];
					uniform 	vec4 hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[4];
					uniform 	vec4 _Params;
					uniform 	vec4 _Params2;
					UNITY_LOCATION(0) uniform  sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform  sampler2D _CameraGBufferTexture2;
					UNITY_LOCATION(2) uniform  sampler2D _Noise;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					int u_xlati8;
					bool u_xlatb8;
					float u_xlat9;
					int u_xlati9;
					bool u_xlatb10;
					vec2 u_xlat18;
					float u_xlat27;
					int u_xlati27;
					bool u_xlatb27;
					float u_xlat28;
					void main()
					{
					    u_xlat0 = texture(_CameraGBufferTexture2, vs_TEXCOORD1.xy);
					    u_xlat27 = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb27 = u_xlat27==0.0;
					    if(u_xlatb27){
					        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					        return;
					    }
					    u_xlat27 = textureLod(_CameraDepthTexture, vs_TEXCOORD0.xy, 0.0).x;
					    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_InverseProjectionMatrix[1];
					    u_xlat1 = hlslcc_mtx4x4_InverseProjectionMatrix[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4_InverseProjectionMatrix[2] * vec4(u_xlat27) + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4_InverseProjectionMatrix[3];
					    u_xlat1.xyz = u_xlat1.xyz / u_xlat1.www;
					    u_xlatb27 = u_xlat1.z<(-_Params.z);
					    if(u_xlatb27){
					        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					        return;
					    }
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4_ViewMatrix[1].xyz;
					    u_xlat0.xyw = hlslcc_mtx4x4_ViewMatrix[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4_ViewMatrix[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat1.xyz;
					    u_xlat27 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat27)) + u_xlat2.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlatb27 = 0.0<u_xlat0.z;
					    if(u_xlatb27){
					        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					        return;
					    }
					    u_xlat27 = u_xlat0.z * _Params.z + u_xlat1.z;
					    u_xlatb27 = (-_ProjectionParams.y)<u_xlat27;
					    u_xlat28 = (-u_xlat1.z) + (-_ProjectionParams.y);
					    u_xlat28 = u_xlat28 / u_xlat0.z;
					    u_xlat27 = (u_xlatb27) ? u_xlat28 : _Params.z;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.zzz * hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[2].xyw;
					    u_xlat3.z = hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[0].x * u_xlat1.x + u_xlat2.x;
					    u_xlat3.w = hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[1].y * u_xlat1.y + u_xlat2.y;
					    u_xlat1.xyw = u_xlat0.zzz * hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[2].xyw;
					    u_xlat3.x = hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[0].x * u_xlat0.x + u_xlat1.x;
					    u_xlat3.y = hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[1].y * u_xlat0.y + u_xlat1.y;
					    u_xlat2.zw = vec2(1.0) / vec2(u_xlat2.zz);
					    u_xlat2.xy = vec2(1.0) / vec2(u_xlat1.ww);
					    u_xlat4.w = u_xlat1.z * u_xlat2.w;
					    u_xlat5 = u_xlat2.wzxy * u_xlat3.wzxy;
					    u_xlat0.xy = u_xlat3.zw * u_xlat2.zw + (-u_xlat5.zw);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlatb0 = 9.99999975e-05>=u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat9 = max(_Test_TexelSize.y, _Test_TexelSize.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(u_xlat9) + u_xlat5.wz;
					    u_xlat5.zw = (-u_xlat3.wz) * u_xlat2.wz + u_xlat0.xy;
					    u_xlatb0 = abs(u_xlat5.w)<abs(u_xlat5.z);
					    u_xlat3 = (bool(u_xlatb0)) ? u_xlat5 : u_xlat5.yxwz;
					    u_xlati9 = int((0.0<u_xlat3.z) ? 0xFFFFFFFFu : uint(0));
					    u_xlati27 = int((u_xlat3.z<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati9 = (-u_xlati9) + u_xlati27;
					    u_xlat5.x = float(u_xlati9);
					    u_xlat9 = u_xlat5.x / u_xlat3.z;
					    u_xlat18.x = u_xlat0.z * u_xlat2.y + (-u_xlat4.w);
					    u_xlat5.w = u_xlat9 * u_xlat18.x;
					    u_xlat5.y = u_xlat9 * u_xlat3.w;
					    u_xlat18.x = (-u_xlat2.w) + u_xlat2.y;
					    u_xlat5.z = u_xlat9 * u_xlat18.x;
					    u_xlat9 = u_xlat1.z * -0.00999999978;
					    u_xlat9 = min(u_xlat9, 1.0);
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _Params2.yy;
					    u_xlat1.z = u_xlat1.y * _Params2.x;
					    u_xlat18.xy = u_xlat1.xz + _WorldSpaceCameraPos.xz;
					    u_xlat18.x = textureLod(_Noise, u_xlat18.xy, 0.0).w;
					    u_xlat9 = u_xlat9 * _Params2.z;
					    u_xlat1 = vec4(u_xlat9) * u_xlat5;
					    u_xlat4.xy = u_xlat3.xy;
					    u_xlat4.z = u_xlat2.w;
					    u_xlat2 = u_xlat1 * u_xlat18.xxxx + u_xlat4;
					    u_xlat3.x = intBitsToFloat(int(0xFFFFFFFFu));
					    u_xlat4.x = float(0.0);
					    u_xlat4.y = float(0.0);
					    u_xlat4.z = float(0.0);
					    u_xlat4.w = float(0.0);
					    u_xlat6 = u_xlat2;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    u_xlat7.w = float(0.0);
					    u_xlat18.x = float(0.0);
					    u_xlati27 = int(0);
					    u_xlati8 = 0;
					    while(true){
					        u_xlat1.x = float(u_xlati27);
					        u_xlatb1 = u_xlat1.x>=_Params2.w;
					        u_xlat8.x = 0.0;
					        if(u_xlatb1){break;}
					        u_xlat6 = u_xlat5 * vec4(u_xlat9) + u_xlat6;
					        u_xlat1.xy = u_xlat1.wz * vec2(0.5, 0.5) + u_xlat6.wz;
					        u_xlat1.x = u_xlat1.x / u_xlat1.y;
					        u_xlatb10 = u_xlat18.x<u_xlat1.x;
					        u_xlat18.x = (u_xlatb10) ? u_xlat18.x : u_xlat1.x;
					        u_xlat1.xy = (bool(u_xlatb0)) ? u_xlat6.yx : u_xlat6.xy;
					        u_xlat3.yz = u_xlat1.xy * _Test_TexelSize.xy;
					        u_xlat1.x = textureLod(_CameraDepthTexture, u_xlat3.yz, 0.0).x;
					        u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					        u_xlat1.x = float(1.0) / u_xlat1.x;
					        u_xlatb1 = u_xlat18.x<(-u_xlat1.x);
					        u_xlat3.w = intBitsToFloat(u_xlati27 + 1);
					        u_xlat8 = bool(u_xlatb1) ? u_xlat3 : vec4(0.0, 0.0, 0.0, 0.0);
					        u_xlat4 = u_xlat8;
					        u_xlat7 = u_xlat8;
					        if(u_xlatb1){break;}
					        u_xlatb8 = u_xlatb1;
					        u_xlati27 = u_xlati27 + 1;
					        u_xlat4.x = float(0.0);
					        u_xlat4.y = float(0.0);
					        u_xlat4.z = float(0.0);
					        u_xlat4.w = float(0.0);
					        u_xlat7.x = float(0.0);
					        u_xlat7.y = float(0.0);
					        u_xlat7.z = float(0.0);
					        u_xlat7.w = float(0.0);
					    }
					    u_xlat0 = (floatBitsToInt(u_xlat8.x) != 0) ? u_xlat4 : u_xlat7;
					    u_xlat27 = float(floatBitsToInt(u_xlat0.w));
					    SV_Target0.z = u_xlat27 / _Params2.w;
					    SV_Target0.w = uintBitsToFloat(floatBitsToUint(u_xlat0.x) & 1065353216u);
					    SV_Target0.xy = u_xlat0.yz;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 59
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %47 %50 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD0 Location 47 
					                                             OpDecorate vs_TEXCOORD1 Location 50 
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
					                                     %32 = OpTypePointer Private %7 
					                      Private f32_4* %33 = OpVariable Private 
					                               f32_4 %36 = OpConstantComposite %27 %27 %27 %27 
					                      Private f32_4* %38 = OpVariable Private 
					                                 f32 %40 = OpConstant 3,674022E-40 
					                                 f32 %41 = OpConstant 3,674022E-40 
					                               f32_4 %42 = OpConstantComposite %40 %41 %40 %41 
					                               f32_4 %44 = OpConstantComposite %26 %27 %26 %27 
					                                     %46 = OpTypePointer Output %19 
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					              Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                     %53 = OpTypePointer Output %6 
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
					                               f32_4 %35 = OpVectorShuffle %34 %34 0 1 0 1 
					                               f32_4 %37 = OpFAdd %35 %36 
					                                             OpStore %33 %37 
					                               f32_4 %39 = OpLoad %33 
					                               f32_4 %43 = OpFMul %39 %42 
					                               f32_4 %45 = OpFAdd %43 %44 
					                                             OpStore %38 %45 
					                               f32_4 %48 = OpLoad %38 
					                               f32_2 %49 = OpVectorShuffle %48 %48 0 1 
					                                             OpStore vs_TEXCOORD0 %49 
					                               f32_4 %51 = OpLoad %38 
					                               f32_2 %52 = OpVectorShuffle %51 %51 2 3 
					                                             OpStore vs_TEXCOORD1 %52 
					                         Output f32* %54 = OpAccessChain %13 %15 %9 
					                                 f32 %55 = OpLoad %54 
					                                 f32 %56 = OpFNegate %55 
					                         Output f32* %57 = OpAccessChain %13 %15 %9 
					                                             OpStore %57 %56 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 718
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %22 %41 %49 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %12 DescriptorSet 12 
					                                                      OpDecorate %12 Binding 12 
					                                                      OpDecorate %16 DescriptorSet 16 
					                                                      OpDecorate %16 Binding 16 
					                                                      OpDecorate vs_TEXCOORD1 Location 22 
					                                                      OpDecorate %41 Location 41 
					                                                      OpDecorate %44 DescriptorSet 44 
					                                                      OpDecorate %44 Binding 44 
					                                                      OpDecorate %46 DescriptorSet 46 
					                                                      OpDecorate %46 Binding 46 
					                                                      OpDecorate vs_TEXCOORD0 Location 49 
					                                                      OpDecorate %70 ArrayStride 70 
					                                                      OpDecorate %71 ArrayStride 71 
					                                                      OpDecorate %72 ArrayStride 72 
					                                                      OpMemberDecorate %73 0 Offset 73 
					                                                      OpMemberDecorate %73 1 Offset 73 
					                                                      OpMemberDecorate %73 2 Offset 73 
					                                                      OpMemberDecorate %73 3 Offset 73 
					                                                      OpMemberDecorate %73 4 Offset 73 
					                                                      OpMemberDecorate %73 5 Offset 73 
					                                                      OpMemberDecorate %73 6 Offset 73 
					                                                      OpMemberDecorate %73 7 Offset 73 
					                                                      OpMemberDecorate %73 8 Offset 73 
					                                                      OpDecorate %73 Block 
					                                                      OpDecorate %75 DescriptorSet 75 
					                                                      OpDecorate %75 Binding 75 
					                                                      OpDecorate %507 DescriptorSet 507 
					                                                      OpDecorate %507 Binding 507 
					                                                      OpDecorate %509 DescriptorSet 509 
					                                                      OpDecorate %509 Binding 509 
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
					                                              %25 = OpTypePointer Private %6 
					                                 Private f32* %26 = OpVariable Private 
					                                          f32 %28 = OpConstant 3,674022E-40 
					                                        f32_4 %29 = OpConstantComposite %28 %28 %28 %28 
					                                              %31 = OpTypeBool 
					                                              %32 = OpTypePointer Private %31 
					                                Private bool* %33 = OpVariable Private 
					                                          f32 %35 = OpConstant 3,674022E-40 
					                                              %40 = OpTypePointer Output %7 
					                                Output f32_4* %41 = OpVariable Output 
					                                        f32_4 %42 = OpConstantComposite %35 %35 %35 %35 
					         UniformConstant read_only Texture2D* %44 = OpVariable UniformConstant 
					                     UniformConstant sampler* %46 = OpVariable UniformConstant 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                              %52 = OpTypeInt 32 0 
					                                          u32 %53 = OpConstant 0 
					                               Private f32_4* %55 = OpVariable Private 
					                                          f32 %57 = OpConstant 3,674022E-40 
					                                        f32_2 %58 = OpConstantComposite %57 %57 
					                                          f32 %60 = OpConstant 3,674022E-40 
					                                        f32_2 %61 = OpConstantComposite %60 %60 
					                               Private f32_4* %65 = OpVariable Private 
					                                              %68 = OpTypeVector %6 3 
					                                          u32 %69 = OpConstant 4 
					                                              %70 = OpTypeArray %7 %69 
					                                              %71 = OpTypeArray %7 %69 
					                                              %72 = OpTypeArray %7 %69 
					                                              %73 = OpTypeStruct %68 %7 %7 %7 %70 %71 %72 %7 %7 
					                                              %74 = OpTypePointer Uniform %73 
					Uniform struct {f32_3; f32_4; f32_4; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4;}* %75 = OpVariable Uniform 
					                                              %76 = OpTypeInt 32 1 
					                                          i32 %77 = OpConstant 5 
					                                          i32 %78 = OpConstant 1 
					                                              %79 = OpTypePointer Uniform %7 
					                                          i32 %83 = OpConstant 0 
					                                          i32 %91 = OpConstant 2 
					                                         i32 %100 = OpConstant 3 
					                                         u32 %111 = OpConstant 2 
					                                         i32 %114 = OpConstant 7 
					                                             %115 = OpTypePointer Uniform %6 
					                                       f32_3 %126 = OpConstantComposite %57 %57 %57 
					                                       f32_3 %128 = OpConstantComposite %60 %60 %60 
					                                         i32 %134 = OpConstant 4 
					                                         u32 %225 = OpConstant 1 
					                                Private f32* %231 = OpVariable Private 
					                                             %244 = OpTypePointer Function %6 
					                                         i32 %265 = OpConstant 6 
					                              Private f32_4* %272 = OpVariable Private 
					                                         u32 %290 = OpConstant 3 
					                                       f32_2 %318 = OpConstantComposite %28 %28 
					                              Private f32_4* %335 = OpVariable Private 
					                              Private f32_4* %342 = OpVariable Private 
					                               Private bool* %365 = OpVariable Private 
					                                         f32 %366 = OpConstant 3,674022E-40 
					                                Private f32* %373 = OpVariable Private 
					                                             %408 = OpTypePointer Function %7 
					                                             %417 = OpTypePointer Private %76 
					                                Private i32* %418 = OpVariable Private 
					                                         u32 %422 = OpConstant 4294967295 
					                                Private i32* %425 = OpVariable Private 
					                                             %443 = OpTypePointer Private %20 
					                              Private f32_2* %444 = OpVariable Private 
					                                         f32 %479 = OpConstant 3,674022E-40 
					                                         i32 %487 = OpConstant 8 
					                                             %502 = OpTypePointer Uniform %68 
					        UniformConstant read_only Texture2D* %507 = OpVariable UniformConstant 
					                    UniformConstant sampler* %509 = OpVariable UniformConstant 
					                                         i32 %537 = OpConstant -1 
					                              Private f32_4* %544 = OpVariable Private 
					                              Private f32_4* %546 = OpVariable Private 
					                                Private i32* %552 = OpVariable Private 
					                                        bool %558 = OpConstantTrue 
					                               Private bool* %562 = OpVariable Private 
					                              Private f32_4* %568 = OpVariable Private 
					                                         f32 %582 = OpConstant 3,674022E-40 
					                                       f32_2 %583 = OpConstantComposite %582 %582 
					                               Private bool* %596 = OpVariable Private 
					                                             %614 = OpTypePointer Function %20 
					                                             %667 = OpTypeVector %31 4 
					                               Private bool* %676 = OpVariable Private 
					                                             %704 = OpTypePointer Output %6 
					                                         u32 %709 = OpConstant 1065353216 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                               Function f32* %245 = OpVariable Function 
					                             Function f32_4* %409 = OpVariable Function 
					                               Function f32* %603 = OpVariable Function 
					                             Function f32_2* %615 = OpVariable Function 
					                          read_only Texture2D %13 = OpLoad %12 
					                                      sampler %17 = OpLoad %16 
					                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                        f32_2 %23 = OpLoad vs_TEXCOORD1 
					                                        f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                                      OpStore %9 %24 
					                                        f32_4 %27 = OpLoad %9 
					                                          f32 %30 = OpDot %27 %29 
					                                                      OpStore %26 %30 
					                                          f32 %34 = OpLoad %26 
					                                         bool %36 = OpFOrdEqual %34 %35 
					                                                      OpStore %33 %36 
					                                         bool %37 = OpLoad %33 
					                                                      OpSelectionMerge %39 None 
					                                                      OpBranchConditional %37 %38 %39 
					                                              %38 = OpLabel 
					                                                      OpStore %41 %42 
					                                                      OpReturn
					                                              %39 = OpLabel 
					                          read_only Texture2D %45 = OpLoad %44 
					                                      sampler %47 = OpLoad %46 
					                   read_only Texture2DSampled %48 = OpSampledImage %45 %47 
					                                        f32_2 %50 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %51 = OpImageSampleExplicitLod %48 %50 Lod %7 
					                                          f32 %54 = OpCompositeExtract %51 0 
					                                                      OpStore %26 %54 
					                                        f32_2 %56 = OpLoad vs_TEXCOORD0 
					                                        f32_2 %59 = OpFMul %56 %58 
					                                        f32_2 %62 = OpFAdd %59 %61 
					                                        f32_4 %63 = OpLoad %55 
					                                        f32_4 %64 = OpVectorShuffle %63 %62 4 5 2 3 
					                                                      OpStore %55 %64 
					                                        f32_4 %66 = OpLoad %55 
					                                        f32_4 %67 = OpVectorShuffle %66 %66 1 1 1 1 
					                               Uniform f32_4* %80 = OpAccessChain %75 %77 %78 
					                                        f32_4 %81 = OpLoad %80 
					                                        f32_4 %82 = OpFMul %67 %81 
					                                                      OpStore %65 %82 
					                               Uniform f32_4* %84 = OpAccessChain %75 %77 %83 
					                                        f32_4 %85 = OpLoad %84 
					                                        f32_4 %86 = OpLoad %55 
					                                        f32_4 %87 = OpVectorShuffle %86 %86 0 0 0 0 
					                                        f32_4 %88 = OpFMul %85 %87 
					                                        f32_4 %89 = OpLoad %65 
					                                        f32_4 %90 = OpFAdd %88 %89 
					                                                      OpStore %55 %90 
					                               Uniform f32_4* %92 = OpAccessChain %75 %77 %91 
					                                        f32_4 %93 = OpLoad %92 
					                                          f32 %94 = OpLoad %26 
					                                        f32_4 %95 = OpCompositeConstruct %94 %94 %94 %94 
					                                        f32_4 %96 = OpFMul %93 %95 
					                                        f32_4 %97 = OpLoad %55 
					                                        f32_4 %98 = OpFAdd %96 %97 
					                                                      OpStore %55 %98 
					                                        f32_4 %99 = OpLoad %55 
					                              Uniform f32_4* %101 = OpAccessChain %75 %77 %100 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpFAdd %99 %102 
					                                                      OpStore %55 %103 
					                                       f32_4 %104 = OpLoad %55 
					                                       f32_3 %105 = OpVectorShuffle %104 %104 0 1 2 
					                                       f32_4 %106 = OpLoad %55 
					                                       f32_3 %107 = OpVectorShuffle %106 %106 3 3 3 
					                                       f32_3 %108 = OpFDiv %105 %107 
					                                       f32_4 %109 = OpLoad %55 
					                                       f32_4 %110 = OpVectorShuffle %109 %108 4 5 6 3 
					                                                      OpStore %55 %110 
					                                Private f32* %112 = OpAccessChain %55 %111 
					                                         f32 %113 = OpLoad %112 
					                                Uniform f32* %116 = OpAccessChain %75 %114 %111 
					                                         f32 %117 = OpLoad %116 
					                                         f32 %118 = OpFNegate %117 
					                                        bool %119 = OpFOrdLessThan %113 %118 
					                                                      OpStore %33 %119 
					                                        bool %120 = OpLoad %33 
					                                                      OpSelectionMerge %122 None 
					                                                      OpBranchConditional %120 %121 %122 
					                                             %121 = OpLabel 
					                                                      OpStore %41 %42 
					                                                      OpReturn
					                                             %122 = OpLabel 
					                                       f32_4 %124 = OpLoad %9 
					                                       f32_3 %125 = OpVectorShuffle %124 %124 0 1 2 
					                                       f32_3 %127 = OpFMul %125 %126 
					                                       f32_3 %129 = OpFAdd %127 %128 
					                                       f32_4 %130 = OpLoad %9 
					                                       f32_4 %131 = OpVectorShuffle %130 %129 4 5 6 3 
					                                                      OpStore %9 %131 
					                                       f32_4 %132 = OpLoad %9 
					                                       f32_3 %133 = OpVectorShuffle %132 %132 1 1 1 
					                              Uniform f32_4* %135 = OpAccessChain %75 %134 %78 
					                                       f32_4 %136 = OpLoad %135 
					                                       f32_3 %137 = OpVectorShuffle %136 %136 0 1 2 
					                                       f32_3 %138 = OpFMul %133 %137 
					                                       f32_4 %139 = OpLoad %65 
					                                       f32_4 %140 = OpVectorShuffle %139 %138 4 5 6 3 
					                                                      OpStore %65 %140 
					                              Uniform f32_4* %141 = OpAccessChain %75 %134 %83 
					                                       f32_4 %142 = OpLoad %141 
					                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                                       f32_4 %144 = OpLoad %9 
					                                       f32_3 %145 = OpVectorShuffle %144 %144 0 0 0 
					                                       f32_3 %146 = OpFMul %143 %145 
					                                       f32_4 %147 = OpLoad %65 
					                                       f32_3 %148 = OpVectorShuffle %147 %147 0 1 2 
					                                       f32_3 %149 = OpFAdd %146 %148 
					                                       f32_4 %150 = OpLoad %9 
					                                       f32_4 %151 = OpVectorShuffle %150 %149 4 5 2 6 
					                                                      OpStore %9 %151 
					                              Uniform f32_4* %152 = OpAccessChain %75 %134 %91 
					                                       f32_4 %153 = OpLoad %152 
					                                       f32_3 %154 = OpVectorShuffle %153 %153 0 1 2 
					                                       f32_4 %155 = OpLoad %9 
					                                       f32_3 %156 = OpVectorShuffle %155 %155 2 2 2 
					                                       f32_3 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %9 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 3 
					                                       f32_3 %160 = OpFAdd %157 %159 
					                                       f32_4 %161 = OpLoad %9 
					                                       f32_4 %162 = OpVectorShuffle %161 %160 4 5 6 3 
					                                                      OpStore %9 %162 
					                                       f32_4 %163 = OpLoad %55 
					                                       f32_3 %164 = OpVectorShuffle %163 %163 0 1 2 
					                                       f32_4 %165 = OpLoad %55 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                         f32 %167 = OpDot %164 %166 
					                                                      OpStore %26 %167 
					                                         f32 %168 = OpLoad %26 
					                                         f32 %169 = OpExtInst %1 32 %168 
					                                                      OpStore %26 %169 
					                                         f32 %170 = OpLoad %26 
					                                       f32_3 %171 = OpCompositeConstruct %170 %170 %170 
					                                       f32_4 %172 = OpLoad %55 
					                                       f32_3 %173 = OpVectorShuffle %172 %172 0 1 2 
					                                       f32_3 %174 = OpFMul %171 %173 
					                                       f32_4 %175 = OpLoad %65 
					                                       f32_4 %176 = OpVectorShuffle %175 %174 4 5 6 3 
					                                                      OpStore %65 %176 
					                                       f32_4 %177 = OpLoad %65 
					                                       f32_3 %178 = OpVectorShuffle %177 %177 0 1 2 
					                                       f32_4 %179 = OpLoad %9 
					                                       f32_3 %180 = OpVectorShuffle %179 %179 0 1 2 
					                                         f32 %181 = OpDot %178 %180 
					                                                      OpStore %26 %181 
					                                         f32 %182 = OpLoad %26 
					                                         f32 %183 = OpLoad %26 
					                                         f32 %184 = OpFAdd %182 %183 
					                                                      OpStore %26 %184 
					                                       f32_4 %185 = OpLoad %9 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                                         f32 %187 = OpLoad %26 
					                                       f32_3 %188 = OpCompositeConstruct %187 %187 %187 
					                                       f32_3 %189 = OpFNegate %188 
					                                       f32_3 %190 = OpFMul %186 %189 
					                                       f32_4 %191 = OpLoad %65 
					                                       f32_3 %192 = OpVectorShuffle %191 %191 0 1 2 
					                                       f32_3 %193 = OpFAdd %190 %192 
					                                       f32_4 %194 = OpLoad %9 
					                                       f32_4 %195 = OpVectorShuffle %194 %193 4 5 6 3 
					                                                      OpStore %9 %195 
					                                       f32_4 %196 = OpLoad %9 
					                                       f32_3 %197 = OpVectorShuffle %196 %196 0 1 2 
					                                       f32_4 %198 = OpLoad %9 
					                                       f32_3 %199 = OpVectorShuffle %198 %198 0 1 2 
					                                         f32 %200 = OpDot %197 %199 
					                                                      OpStore %26 %200 
					                                         f32 %201 = OpLoad %26 
					                                         f32 %202 = OpExtInst %1 32 %201 
					                                                      OpStore %26 %202 
					                                         f32 %203 = OpLoad %26 
					                                       f32_3 %204 = OpCompositeConstruct %203 %203 %203 
					                                       f32_4 %205 = OpLoad %9 
					                                       f32_3 %206 = OpVectorShuffle %205 %205 0 1 2 
					                                       f32_3 %207 = OpFMul %204 %206 
					                                       f32_4 %208 = OpLoad %9 
					                                       f32_4 %209 = OpVectorShuffle %208 %207 4 5 6 3 
					                                                      OpStore %9 %209 
					                                Private f32* %210 = OpAccessChain %9 %111 
					                                         f32 %211 = OpLoad %210 
					                                        bool %212 = OpFOrdLessThan %35 %211 
					                                                      OpStore %33 %212 
					                                        bool %213 = OpLoad %33 
					                                                      OpSelectionMerge %215 None 
					                                                      OpBranchConditional %213 %214 %215 
					                                             %214 = OpLabel 
					                                                      OpStore %41 %42 
					                                                      OpReturn
					                                             %215 = OpLabel 
					                                Private f32* %217 = OpAccessChain %9 %111 
					                                         f32 %218 = OpLoad %217 
					                                Uniform f32* %219 = OpAccessChain %75 %114 %111 
					                                         f32 %220 = OpLoad %219 
					                                         f32 %221 = OpFMul %218 %220 
					                                Private f32* %222 = OpAccessChain %55 %111 
					                                         f32 %223 = OpLoad %222 
					                                         f32 %224 = OpFAdd %221 %223 
					                                                      OpStore %26 %224 
					                                Uniform f32* %226 = OpAccessChain %75 %78 %225 
					                                         f32 %227 = OpLoad %226 
					                                         f32 %228 = OpFNegate %227 
					                                         f32 %229 = OpLoad %26 
					                                        bool %230 = OpFOrdLessThan %228 %229 
					                                                      OpStore %33 %230 
					                                Private f32* %232 = OpAccessChain %55 %111 
					                                         f32 %233 = OpLoad %232 
					                                         f32 %234 = OpFNegate %233 
					                                Uniform f32* %235 = OpAccessChain %75 %78 %225 
					                                         f32 %236 = OpLoad %235 
					                                         f32 %237 = OpFNegate %236 
					                                         f32 %238 = OpFAdd %234 %237 
					                                                      OpStore %231 %238 
					                                         f32 %239 = OpLoad %231 
					                                Private f32* %240 = OpAccessChain %9 %111 
					                                         f32 %241 = OpLoad %240 
					                                         f32 %242 = OpFDiv %239 %241 
					                                                      OpStore %231 %242 
					                                        bool %243 = OpLoad %33 
					                                                      OpSelectionMerge %247 None 
					                                                      OpBranchConditional %243 %246 %249 
					                                             %246 = OpLabel 
					                                         f32 %248 = OpLoad %231 
					                                                      OpStore %245 %248 
					                                                      OpBranch %247 
					                                             %249 = OpLabel 
					                                Uniform f32* %250 = OpAccessChain %75 %114 %111 
					                                         f32 %251 = OpLoad %250 
					                                                      OpStore %245 %251 
					                                                      OpBranch %247 
					                                             %247 = OpLabel 
					                                         f32 %252 = OpLoad %245 
					                                                      OpStore %26 %252 
					                                       f32_4 %253 = OpLoad %9 
					                                       f32_3 %254 = OpVectorShuffle %253 %253 0 1 2 
					                                         f32 %255 = OpLoad %26 
					                                       f32_3 %256 = OpCompositeConstruct %255 %255 %255 
					                                       f32_3 %257 = OpFMul %254 %256 
					                                       f32_4 %258 = OpLoad %55 
					                                       f32_3 %259 = OpVectorShuffle %258 %258 0 1 2 
					                                       f32_3 %260 = OpFAdd %257 %259 
					                                       f32_4 %261 = OpLoad %9 
					                                       f32_4 %262 = OpVectorShuffle %261 %260 4 5 6 3 
					                                                      OpStore %9 %262 
					                                       f32_4 %263 = OpLoad %55 
					                                       f32_3 %264 = OpVectorShuffle %263 %263 2 2 2 
					                              Uniform f32_4* %266 = OpAccessChain %75 %265 %91 
					                                       f32_4 %267 = OpLoad %266 
					                                       f32_3 %268 = OpVectorShuffle %267 %267 0 1 3 
					                                       f32_3 %269 = OpFMul %264 %268 
					                                       f32_4 %270 = OpLoad %65 
					                                       f32_4 %271 = OpVectorShuffle %270 %269 4 5 6 3 
					                                                      OpStore %65 %271 
					                                Uniform f32* %273 = OpAccessChain %75 %265 %83 %53 
					                                         f32 %274 = OpLoad %273 
					                                Private f32* %275 = OpAccessChain %55 %53 
					                                         f32 %276 = OpLoad %275 
					                                         f32 %277 = OpFMul %274 %276 
					                                Private f32* %278 = OpAccessChain %65 %53 
					                                         f32 %279 = OpLoad %278 
					                                         f32 %280 = OpFAdd %277 %279 
					                                Private f32* %281 = OpAccessChain %272 %111 
					                                                      OpStore %281 %280 
					                                Uniform f32* %282 = OpAccessChain %75 %265 %78 %225 
					                                         f32 %283 = OpLoad %282 
					                                Private f32* %284 = OpAccessChain %55 %225 
					                                         f32 %285 = OpLoad %284 
					                                         f32 %286 = OpFMul %283 %285 
					                                Private f32* %287 = OpAccessChain %65 %225 
					                                         f32 %288 = OpLoad %287 
					                                         f32 %289 = OpFAdd %286 %288 
					                                Private f32* %291 = OpAccessChain %272 %290 
					                                                      OpStore %291 %289 
					                                       f32_4 %292 = OpLoad %9 
					                                       f32_3 %293 = OpVectorShuffle %292 %292 2 2 2 
					                              Uniform f32_4* %294 = OpAccessChain %75 %265 %91 
					                                       f32_4 %295 = OpLoad %294 
					                                       f32_3 %296 = OpVectorShuffle %295 %295 0 1 3 
					                                       f32_3 %297 = OpFMul %293 %296 
					                                       f32_4 %298 = OpLoad %55 
					                                       f32_4 %299 = OpVectorShuffle %298 %297 4 5 2 6 
					                                                      OpStore %55 %299 
					                                Uniform f32* %300 = OpAccessChain %75 %265 %83 %53 
					                                         f32 %301 = OpLoad %300 
					                                Private f32* %302 = OpAccessChain %9 %53 
					                                         f32 %303 = OpLoad %302 
					                                         f32 %304 = OpFMul %301 %303 
					                                Private f32* %305 = OpAccessChain %55 %53 
					                                         f32 %306 = OpLoad %305 
					                                         f32 %307 = OpFAdd %304 %306 
					                                Private f32* %308 = OpAccessChain %272 %53 
					                                                      OpStore %308 %307 
					                                Uniform f32* %309 = OpAccessChain %75 %265 %78 %225 
					                                         f32 %310 = OpLoad %309 
					                                Private f32* %311 = OpAccessChain %9 %225 
					                                         f32 %312 = OpLoad %311 
					                                         f32 %313 = OpFMul %310 %312 
					                                Private f32* %314 = OpAccessChain %55 %225 
					                                         f32 %315 = OpLoad %314 
					                                         f32 %316 = OpFAdd %313 %315 
					                                Private f32* %317 = OpAccessChain %272 %225 
					                                                      OpStore %317 %316 
					                                       f32_4 %319 = OpLoad %65 
					                                       f32_2 %320 = OpVectorShuffle %319 %319 2 2 
					                                         f32 %321 = OpCompositeExtract %320 0 
					                                         f32 %322 = OpCompositeExtract %320 1 
					                                       f32_2 %323 = OpCompositeConstruct %321 %322 
					                                       f32_2 %324 = OpFDiv %318 %323 
					                                       f32_4 %325 = OpLoad %65 
					                                       f32_4 %326 = OpVectorShuffle %325 %324 0 1 4 5 
					                                                      OpStore %65 %326 
					                                       f32_4 %327 = OpLoad %55 
					                                       f32_2 %328 = OpVectorShuffle %327 %327 3 3 
					                                         f32 %329 = OpCompositeExtract %328 0 
					                                         f32 %330 = OpCompositeExtract %328 1 
					                                       f32_2 %331 = OpCompositeConstruct %329 %330 
					                                       f32_2 %332 = OpFDiv %318 %331 
					                                       f32_4 %333 = OpLoad %65 
					                                       f32_4 %334 = OpVectorShuffle %333 %332 4 5 2 3 
					                                                      OpStore %65 %334 
					                                Private f32* %336 = OpAccessChain %55 %111 
					                                         f32 %337 = OpLoad %336 
					                                Private f32* %338 = OpAccessChain %65 %290 
					                                         f32 %339 = OpLoad %338 
					                                         f32 %340 = OpFMul %337 %339 
					                                Private f32* %341 = OpAccessChain %335 %290 
					                                                      OpStore %341 %340 
					                                       f32_4 %343 = OpLoad %65 
					                                       f32_4 %344 = OpVectorShuffle %343 %343 3 2 0 1 
					                                       f32_4 %345 = OpLoad %272 
					                                       f32_4 %346 = OpVectorShuffle %345 %345 3 2 0 1 
					                                       f32_4 %347 = OpFMul %344 %346 
					                                                      OpStore %342 %347 
					                                       f32_4 %348 = OpLoad %272 
					                                       f32_2 %349 = OpVectorShuffle %348 %348 2 3 
					                                       f32_4 %350 = OpLoad %65 
					                                       f32_2 %351 = OpVectorShuffle %350 %350 2 3 
					                                       f32_2 %352 = OpFMul %349 %351 
					                                       f32_4 %353 = OpLoad %342 
					                                       f32_2 %354 = OpVectorShuffle %353 %353 2 3 
					                                       f32_2 %355 = OpFNegate %354 
					                                       f32_2 %356 = OpFAdd %352 %355 
					                                       f32_4 %357 = OpLoad %9 
					                                       f32_4 %358 = OpVectorShuffle %357 %356 4 5 2 3 
					                                                      OpStore %9 %358 
					                                       f32_4 %359 = OpLoad %9 
					                                       f32_2 %360 = OpVectorShuffle %359 %359 0 1 
					                                       f32_4 %361 = OpLoad %9 
					                                       f32_2 %362 = OpVectorShuffle %361 %361 0 1 
					                                         f32 %363 = OpDot %360 %362 
					                                Private f32* %364 = OpAccessChain %9 %53 
					                                                      OpStore %364 %363 
					                                Private f32* %367 = OpAccessChain %9 %53 
					                                         f32 %368 = OpLoad %367 
					                                        bool %369 = OpFOrdGreaterThanEqual %366 %368 
					                                                      OpStore %365 %369 
					                                        bool %370 = OpLoad %365 
					                                         f32 %371 = OpSelect %370 %28 %35 
					                                Private f32* %372 = OpAccessChain %9 %53 
					                                                      OpStore %372 %371 
					                                Uniform f32* %374 = OpAccessChain %75 %100 %225 
					                                         f32 %375 = OpLoad %374 
					                                Uniform f32* %376 = OpAccessChain %75 %100 %53 
					                                         f32 %377 = OpLoad %376 
					                                         f32 %378 = OpExtInst %1 40 %375 %377 
					                                                      OpStore %373 %378 
					                                       f32_4 %379 = OpLoad %9 
					                                       f32_2 %380 = OpVectorShuffle %379 %379 0 0 
					                                         f32 %381 = OpLoad %373 
					                                       f32_2 %382 = OpCompositeConstruct %381 %381 
					                                       f32_2 %383 = OpFMul %380 %382 
					                                       f32_4 %384 = OpLoad %342 
					                                       f32_2 %385 = OpVectorShuffle %384 %384 3 2 
					                                       f32_2 %386 = OpFAdd %383 %385 
					                                       f32_4 %387 = OpLoad %9 
					                                       f32_4 %388 = OpVectorShuffle %387 %386 4 5 2 3 
					                                                      OpStore %9 %388 
					                                       f32_4 %389 = OpLoad %272 
					                                       f32_2 %390 = OpVectorShuffle %389 %389 3 2 
					                                       f32_2 %391 = OpFNegate %390 
					                                       f32_4 %392 = OpLoad %65 
					                                       f32_2 %393 = OpVectorShuffle %392 %392 3 2 
					                                       f32_2 %394 = OpFMul %391 %393 
					                                       f32_4 %395 = OpLoad %9 
					                                       f32_2 %396 = OpVectorShuffle %395 %395 0 1 
					                                       f32_2 %397 = OpFAdd %394 %396 
					                                       f32_4 %398 = OpLoad %342 
					                                       f32_4 %399 = OpVectorShuffle %398 %397 0 1 4 5 
					                                                      OpStore %342 %399 
					                                Private f32* %400 = OpAccessChain %342 %290 
					                                         f32 %401 = OpLoad %400 
					                                         f32 %402 = OpExtInst %1 4 %401 
					                                Private f32* %403 = OpAccessChain %342 %111 
					                                         f32 %404 = OpLoad %403 
					                                         f32 %405 = OpExtInst %1 4 %404 
					                                        bool %406 = OpFOrdLessThan %402 %405 
					                                                      OpStore %365 %406 
					                                        bool %407 = OpLoad %365 
					                                                      OpSelectionMerge %411 None 
					                                                      OpBranchConditional %407 %410 %413 
					                                             %410 = OpLabel 
					                                       f32_4 %412 = OpLoad %342 
					                                                      OpStore %409 %412 
					                                                      OpBranch %411 
					                                             %413 = OpLabel 
					                                       f32_4 %414 = OpLoad %342 
					                                       f32_4 %415 = OpVectorShuffle %414 %414 1 0 3 2 
					                                                      OpStore %409 %415 
					                                                      OpBranch %411 
					                                             %411 = OpLabel 
					                                       f32_4 %416 = OpLoad %409 
					                                                      OpStore %272 %416 
					                                Private f32* %419 = OpAccessChain %272 %111 
					                                         f32 %420 = OpLoad %419 
					                                        bool %421 = OpFOrdLessThan %35 %420 
					                                         u32 %423 = OpSelect %421 %422 %53 
					                                         i32 %424 = OpBitcast %423 
					                                                      OpStore %418 %424 
					                                Private f32* %426 = OpAccessChain %272 %111 
					                                         f32 %427 = OpLoad %426 
					                                        bool %428 = OpFOrdLessThan %427 %35 
					                                         u32 %429 = OpSelect %428 %422 %53 
					                                         i32 %430 = OpBitcast %429 
					                                                      OpStore %425 %430 
					                                         i32 %431 = OpLoad %418 
					                                         i32 %432 = OpSNegate %431 
					                                         i32 %433 = OpLoad %425 
					                                         i32 %434 = OpIAdd %432 %433 
					                                                      OpStore %418 %434 
					                                         i32 %435 = OpLoad %418 
					                                         f32 %436 = OpConvertSToF %435 
					                                Private f32* %437 = OpAccessChain %342 %53 
					                                                      OpStore %437 %436 
					                                Private f32* %438 = OpAccessChain %342 %53 
					                                         f32 %439 = OpLoad %438 
					                                Private f32* %440 = OpAccessChain %272 %111 
					                                         f32 %441 = OpLoad %440 
					                                         f32 %442 = OpFDiv %439 %441 
					                                                      OpStore %373 %442 
					                                Private f32* %445 = OpAccessChain %9 %111 
					                                         f32 %446 = OpLoad %445 
					                                Private f32* %447 = OpAccessChain %65 %225 
					                                         f32 %448 = OpLoad %447 
					                                         f32 %449 = OpFMul %446 %448 
					                                Private f32* %450 = OpAccessChain %335 %290 
					                                         f32 %451 = OpLoad %450 
					                                         f32 %452 = OpFNegate %451 
					                                         f32 %453 = OpFAdd %449 %452 
					                                Private f32* %454 = OpAccessChain %444 %53 
					                                                      OpStore %454 %453 
					                                         f32 %455 = OpLoad %373 
					                                Private f32* %456 = OpAccessChain %444 %53 
					                                         f32 %457 = OpLoad %456 
					                                         f32 %458 = OpFMul %455 %457 
					                                Private f32* %459 = OpAccessChain %342 %290 
					                                                      OpStore %459 %458 
					                                         f32 %460 = OpLoad %373 
					                                Private f32* %461 = OpAccessChain %272 %290 
					                                         f32 %462 = OpLoad %461 
					                                         f32 %463 = OpFMul %460 %462 
					                                Private f32* %464 = OpAccessChain %342 %225 
					                                                      OpStore %464 %463 
					                                Private f32* %465 = OpAccessChain %65 %290 
					                                         f32 %466 = OpLoad %465 
					                                         f32 %467 = OpFNegate %466 
					                                Private f32* %468 = OpAccessChain %65 %225 
					                                         f32 %469 = OpLoad %468 
					                                         f32 %470 = OpFAdd %467 %469 
					                                Private f32* %471 = OpAccessChain %444 %53 
					                                                      OpStore %471 %470 
					                                         f32 %472 = OpLoad %373 
					                                Private f32* %473 = OpAccessChain %444 %53 
					                                         f32 %474 = OpLoad %473 
					                                         f32 %475 = OpFMul %472 %474 
					                                Private f32* %476 = OpAccessChain %342 %111 
					                                                      OpStore %476 %475 
					                                Private f32* %477 = OpAccessChain %55 %111 
					                                         f32 %478 = OpLoad %477 
					                                         f32 %480 = OpFMul %478 %479 
					                                                      OpStore %373 %480 
					                                         f32 %481 = OpLoad %373 
					                                         f32 %482 = OpExtInst %1 37 %481 %28 
					                                                      OpStore %373 %482 
					                                         f32 %483 = OpLoad %373 
					                                         f32 %484 = OpFNegate %483 
					                                         f32 %485 = OpFAdd %484 %28 
					                                                      OpStore %373 %485 
					                                       f32_2 %486 = OpLoad vs_TEXCOORD0 
					                              Uniform f32_4* %488 = OpAccessChain %75 %487 
					                                       f32_4 %489 = OpLoad %488 
					                                       f32_2 %490 = OpVectorShuffle %489 %489 1 1 
					                                       f32_2 %491 = OpFMul %486 %490 
					                                       f32_4 %492 = OpLoad %55 
					                                       f32_4 %493 = OpVectorShuffle %492 %491 4 5 2 3 
					                                                      OpStore %55 %493 
					                                Private f32* %494 = OpAccessChain %55 %225 
					                                         f32 %495 = OpLoad %494 
					                                Uniform f32* %496 = OpAccessChain %75 %487 %53 
					                                         f32 %497 = OpLoad %496 
					                                         f32 %498 = OpFMul %495 %497 
					                                Private f32* %499 = OpAccessChain %55 %111 
					                                                      OpStore %499 %498 
					                                       f32_4 %500 = OpLoad %55 
					                                       f32_2 %501 = OpVectorShuffle %500 %500 0 2 
					                              Uniform f32_3* %503 = OpAccessChain %75 %83 
					                                       f32_3 %504 = OpLoad %503 
					                                       f32_2 %505 = OpVectorShuffle %504 %504 0 2 
					                                       f32_2 %506 = OpFAdd %501 %505 
					                                                      OpStore %444 %506 
					                         read_only Texture2D %508 = OpLoad %507 
					                                     sampler %510 = OpLoad %509 
					                  read_only Texture2DSampled %511 = OpSampledImage %508 %510 
					                                       f32_2 %512 = OpLoad %444 
					                                       f32_4 %513 = OpImageSampleExplicitLod %511 %512 Lod %7 
					                                         f32 %514 = OpCompositeExtract %513 3 
					                                Private f32* %515 = OpAccessChain %444 %53 
					                                                      OpStore %515 %514 
					                                         f32 %516 = OpLoad %373 
					                                Uniform f32* %517 = OpAccessChain %75 %487 %111 
					                                         f32 %518 = OpLoad %517 
					                                         f32 %519 = OpFMul %516 %518 
					                                                      OpStore %373 %519 
					                                         f32 %520 = OpLoad %373 
					                                       f32_4 %521 = OpCompositeConstruct %520 %520 %520 %520 
					                                       f32_4 %522 = OpLoad %342 
					                                       f32_4 %523 = OpFMul %521 %522 
					                                                      OpStore %55 %523 
					                                       f32_4 %524 = OpLoad %272 
					                                       f32_2 %525 = OpVectorShuffle %524 %524 0 1 
					                                       f32_4 %526 = OpLoad %335 
					                                       f32_4 %527 = OpVectorShuffle %526 %525 4 5 2 3 
					                                                      OpStore %335 %527 
					                                Private f32* %528 = OpAccessChain %65 %290 
					                                         f32 %529 = OpLoad %528 
					                                Private f32* %530 = OpAccessChain %335 %111 
					                                                      OpStore %530 %529 
					                                       f32_4 %531 = OpLoad %55 
					                                       f32_2 %532 = OpLoad %444 
					                                       f32_4 %533 = OpVectorShuffle %532 %532 0 0 0 0 
					                                       f32_4 %534 = OpFMul %531 %533 
					                                       f32_4 %535 = OpLoad %335 
					                                       f32_4 %536 = OpFAdd %534 %535 
					                                                      OpStore %65 %536 
					                                         f32 %538 = OpBitcast %537 
					                                Private f32* %539 = OpAccessChain %272 %53 
					                                                      OpStore %539 %538 
					                                Private f32* %540 = OpAccessChain %335 %53 
					                                                      OpStore %540 %35 
					                                Private f32* %541 = OpAccessChain %335 %225 
					                                                      OpStore %541 %35 
					                                Private f32* %542 = OpAccessChain %335 %111 
					                                                      OpStore %542 %35 
					                                Private f32* %543 = OpAccessChain %335 %290 
					                                                      OpStore %543 %35 
					                                       f32_4 %545 = OpLoad %65 
					                                                      OpStore %544 %545 
					                                Private f32* %547 = OpAccessChain %546 %53 
					                                                      OpStore %547 %35 
					                                Private f32* %548 = OpAccessChain %546 %225 
					                                                      OpStore %548 %35 
					                                Private f32* %549 = OpAccessChain %546 %111 
					                                                      OpStore %549 %35 
					                                Private f32* %550 = OpAccessChain %546 %290 
					                                                      OpStore %550 %35 
					                                Private f32* %551 = OpAccessChain %444 %53 
					                                                      OpStore %551 %35 
					                                                      OpStore %425 %83 
					                                                      OpStore %552 %83 
					                                                      OpBranch %553 
					                                             %553 = OpLabel 
					                                                      OpLoopMerge %555 %556 None 
					                                                      OpBranch %557 
					                                             %557 = OpLabel 
					                                                      OpBranchConditional %558 %554 %555 
					                                             %554 = OpLabel 
					                                         i32 %559 = OpLoad %425 
					                                         f32 %560 = OpConvertSToF %559 
					                                Private f32* %561 = OpAccessChain %55 %53 
					                                                      OpStore %561 %560 
					                                Private f32* %563 = OpAccessChain %55 %53 
					                                         f32 %564 = OpLoad %563 
					                                Uniform f32* %565 = OpAccessChain %75 %487 %290 
					                                         f32 %566 = OpLoad %565 
					                                        bool %567 = OpFOrdGreaterThanEqual %564 %566 
					                                                      OpStore %562 %567 
					                                Private f32* %569 = OpAccessChain %568 %53 
					                                                      OpStore %569 %35 
					                                        bool %570 = OpLoad %562 
					                                                      OpSelectionMerge %572 None 
					                                                      OpBranchConditional %570 %571 %572 
					                                             %571 = OpLabel 
					                                                      OpBranch %555 
					                                             %572 = OpLabel 
					                                       f32_4 %574 = OpLoad %342 
					                                         f32 %575 = OpLoad %373 
					                                       f32_4 %576 = OpCompositeConstruct %575 %575 %575 %575 
					                                       f32_4 %577 = OpFMul %574 %576 
					                                       f32_4 %578 = OpLoad %544 
					                                       f32_4 %579 = OpFAdd %577 %578 
					                                                      OpStore %544 %579 
					                                       f32_4 %580 = OpLoad %55 
					                                       f32_2 %581 = OpVectorShuffle %580 %580 3 2 
					                                       f32_2 %584 = OpFMul %581 %583 
					                                       f32_4 %585 = OpLoad %544 
					                                       f32_2 %586 = OpVectorShuffle %585 %585 3 2 
					                                       f32_2 %587 = OpFAdd %584 %586 
					                                       f32_4 %588 = OpLoad %55 
					                                       f32_4 %589 = OpVectorShuffle %588 %587 4 5 2 3 
					                                                      OpStore %55 %589 
					                                Private f32* %590 = OpAccessChain %55 %53 
					                                         f32 %591 = OpLoad %590 
					                                Private f32* %592 = OpAccessChain %55 %225 
					                                         f32 %593 = OpLoad %592 
					                                         f32 %594 = OpFDiv %591 %593 
					                                Private f32* %595 = OpAccessChain %55 %53 
					                                                      OpStore %595 %594 
					                                Private f32* %597 = OpAccessChain %444 %53 
					                                         f32 %598 = OpLoad %597 
					                                Private f32* %599 = OpAccessChain %55 %53 
					                                         f32 %600 = OpLoad %599 
					                                        bool %601 = OpFOrdLessThan %598 %600 
					                                                      OpStore %596 %601 
					                                        bool %602 = OpLoad %596 
					                                                      OpSelectionMerge %605 None 
					                                                      OpBranchConditional %602 %604 %608 
					                                             %604 = OpLabel 
					                                Private f32* %606 = OpAccessChain %444 %53 
					                                         f32 %607 = OpLoad %606 
					                                                      OpStore %603 %607 
					                                                      OpBranch %605 
					                                             %608 = OpLabel 
					                                Private f32* %609 = OpAccessChain %55 %53 
					                                         f32 %610 = OpLoad %609 
					                                                      OpStore %603 %610 
					                                                      OpBranch %605 
					                                             %605 = OpLabel 
					                                         f32 %611 = OpLoad %603 
					                                Private f32* %612 = OpAccessChain %444 %53 
					                                                      OpStore %612 %611 
					                                        bool %613 = OpLoad %365 
					                                                      OpSelectionMerge %617 None 
					                                                      OpBranchConditional %613 %616 %620 
					                                             %616 = OpLabel 
					                                       f32_4 %618 = OpLoad %544 
					                                       f32_2 %619 = OpVectorShuffle %618 %618 1 0 
					                                                      OpStore %615 %619 
					                                                      OpBranch %617 
					                                             %620 = OpLabel 
					                                       f32_4 %621 = OpLoad %544 
					                                       f32_2 %622 = OpVectorShuffle %621 %621 0 1 
					                                                      OpStore %615 %622 
					                                                      OpBranch %617 
					                                             %617 = OpLabel 
					                                       f32_2 %623 = OpLoad %615 
					                                       f32_4 %624 = OpLoad %55 
					                                       f32_4 %625 = OpVectorShuffle %624 %623 4 5 2 3 
					                                                      OpStore %55 %625 
					                                       f32_4 %626 = OpLoad %55 
					                                       f32_2 %627 = OpVectorShuffle %626 %626 0 1 
					                              Uniform f32_4* %628 = OpAccessChain %75 %100 
					                                       f32_4 %629 = OpLoad %628 
					                                       f32_2 %630 = OpVectorShuffle %629 %629 0 1 
					                                       f32_2 %631 = OpFMul %627 %630 
					                                       f32_4 %632 = OpLoad %272 
					                                       f32_4 %633 = OpVectorShuffle %632 %631 0 4 5 3 
					                                                      OpStore %272 %633 
					                         read_only Texture2D %634 = OpLoad %44 
					                                     sampler %635 = OpLoad %46 
					                  read_only Texture2DSampled %636 = OpSampledImage %634 %635 
					                                       f32_4 %637 = OpLoad %272 
					                                       f32_2 %638 = OpVectorShuffle %637 %637 1 2 
					                                       f32_4 %639 = OpImageSampleExplicitLod %636 %638 Lod %7 
					                                         f32 %640 = OpCompositeExtract %639 0 
					                                Private f32* %641 = OpAccessChain %55 %53 
					                                                      OpStore %641 %640 
					                                Uniform f32* %642 = OpAccessChain %75 %91 %111 
					                                         f32 %643 = OpLoad %642 
					                                Private f32* %644 = OpAccessChain %55 %53 
					                                         f32 %645 = OpLoad %644 
					                                         f32 %646 = OpFMul %643 %645 
					                                Uniform f32* %647 = OpAccessChain %75 %91 %290 
					                                         f32 %648 = OpLoad %647 
					                                         f32 %649 = OpFAdd %646 %648 
					                                Private f32* %650 = OpAccessChain %55 %53 
					                                                      OpStore %650 %649 
					                                Private f32* %651 = OpAccessChain %55 %53 
					                                         f32 %652 = OpLoad %651 
					                                         f32 %653 = OpFDiv %28 %652 
					                                Private f32* %654 = OpAccessChain %55 %53 
					                                                      OpStore %654 %653 
					                                Private f32* %655 = OpAccessChain %444 %53 
					                                         f32 %656 = OpLoad %655 
					                                Private f32* %657 = OpAccessChain %55 %53 
					                                         f32 %658 = OpLoad %657 
					                                         f32 %659 = OpFNegate %658 
					                                        bool %660 = OpFOrdLessThan %656 %659 
					                                                      OpStore %562 %660 
					                                         i32 %661 = OpLoad %425 
					                                         i32 %662 = OpIAdd %661 %78 
					                                         f32 %663 = OpBitcast %662 
					                                Private f32* %664 = OpAccessChain %272 %290 
					                                                      OpStore %664 %663 
					                                        bool %665 = OpLoad %562 
					                                       f32_4 %666 = OpLoad %272 
					                                      bool_4 %668 = OpCompositeConstruct %665 %665 %665 %665 
					                                       f32_4 %669 = OpSelect %668 %666 %42 
					                                                      OpStore %568 %669 
					                                       f32_4 %670 = OpLoad %568 
					                                                      OpStore %335 %670 
					                                       f32_4 %671 = OpLoad %568 
					                                                      OpStore %546 %671 
					                                        bool %672 = OpLoad %562 
					                                                      OpSelectionMerge %674 None 
					                                                      OpBranchConditional %672 %673 %674 
					                                             %673 = OpLabel 
					                                                      OpBranch %555 
					                                             %674 = OpLabel 
					                                        bool %677 = OpLoad %562 
					                                                      OpStore %676 %677 
					                                         i32 %678 = OpLoad %425 
					                                         i32 %679 = OpIAdd %678 %78 
					                                                      OpStore %425 %679 
					                                Private f32* %680 = OpAccessChain %335 %53 
					                                                      OpStore %680 %35 
					                                Private f32* %681 = OpAccessChain %335 %225 
					                                                      OpStore %681 %35 
					                                Private f32* %682 = OpAccessChain %335 %111 
					                                                      OpStore %682 %35 
					                                Private f32* %683 = OpAccessChain %335 %290 
					                                                      OpStore %683 %35 
					                                Private f32* %684 = OpAccessChain %546 %53 
					                                                      OpStore %684 %35 
					                                Private f32* %685 = OpAccessChain %546 %225 
					                                                      OpStore %685 %35 
					                                Private f32* %686 = OpAccessChain %546 %111 
					                                                      OpStore %686 %35 
					                                Private f32* %687 = OpAccessChain %546 %290 
					                                                      OpStore %687 %35 
					                                                      OpBranch %556 
					                                             %556 = OpLabel 
					                                                      OpBranch %553 
					                                             %555 = OpLabel 
					                                Private f32* %688 = OpAccessChain %568 %53 
					                                         f32 %689 = OpLoad %688 
					                                         i32 %690 = OpBitcast %689 
					                                        bool %691 = OpINotEqual %690 %83 
					                                       f32_4 %692 = OpLoad %335 
					                                       f32_4 %693 = OpLoad %546 
					                                      bool_4 %694 = OpCompositeConstruct %691 %691 %691 %691 
					                                       f32_4 %695 = OpSelect %694 %692 %693 
					                                                      OpStore %9 %695 
					                                Private f32* %696 = OpAccessChain %9 %290 
					                                         f32 %697 = OpLoad %696 
					                                         i32 %698 = OpBitcast %697 
					                                         f32 %699 = OpConvertSToF %698 
					                                                      OpStore %26 %699 
					                                         f32 %700 = OpLoad %26 
					                                Uniform f32* %701 = OpAccessChain %75 %487 %290 
					                                         f32 %702 = OpLoad %701 
					                                         f32 %703 = OpFDiv %700 %702 
					                                 Output f32* %705 = OpAccessChain %41 %111 
					                                                      OpStore %705 %703 
					                                Private f32* %706 = OpAccessChain %9 %53 
					                                         f32 %707 = OpLoad %706 
					                                         u32 %708 = OpBitcast %707 
					                                         u32 %710 = OpBitwiseAnd %708 %709 
					                                         f32 %711 = OpBitcast %710 
					                                 Output f32* %712 = OpAccessChain %41 %290 
					                                                      OpStore %712 %711 
					                                       f32_4 %713 = OpLoad %9 
					                                       f32_2 %714 = OpVectorShuffle %713 %713 1 2 
					                                       f32_4 %715 = OpLoad %41 
					                                       f32_4 %716 = OpVectorShuffle %715 %714 4 5 2 3 
					                                                      OpStore %41 %716 
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
						vec4 unused_0_0[5];
						vec4 _Test_TexelSize;
						mat4x4 _ViewMatrix;
						vec4 unused_0_3[4];
						mat4x4 _InverseProjectionMatrix;
						mat4x4 _ScreenSpaceProjectionMatrix;
						vec4 _Params;
						vec4 _Params2;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3;
						vec4 _ZBufferParams;
						vec4 unused_1_5;
					};
					UNITY_LOCATION(0) uniform  sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform  sampler2D _CameraGBufferTexture2;
					UNITY_LOCATION(2) uniform  sampler2D _Noise;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					int u_xlati8;
					bool u_xlatb8;
					float u_xlat9;
					int u_xlati9;
					bool u_xlatb10;
					vec2 u_xlat18;
					float u_xlat27;
					int u_xlati27;
					bool u_xlatb27;
					float u_xlat28;
					void main()
					{
					    u_xlat0 = texture(_CameraGBufferTexture2, vs_TEXCOORD1.xy);
					    u_xlat27 = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb27 = u_xlat27==0.0;
					    if(u_xlatb27){
					        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					        return;
					    }
					    u_xlat27 = textureLod(_CameraDepthTexture, vs_TEXCOORD0.xy, 0.0).x;
					    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2 = u_xlat1.yyyy * _InverseProjectionMatrix[1];
					    u_xlat1 = _InverseProjectionMatrix[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = _InverseProjectionMatrix[2] * vec4(u_xlat27) + u_xlat1;
					    u_xlat1 = u_xlat1 + _InverseProjectionMatrix[3];
					    u_xlat1.xyz = u_xlat1.xyz / u_xlat1.www;
					    u_xlatb27 = u_xlat1.z<(-_Params.z);
					    if(u_xlatb27){
					        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					        return;
					    }
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat2.xyz = u_xlat0.yyy * _ViewMatrix[1].xyz;
					    u_xlat0.xyw = _ViewMatrix[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = _ViewMatrix[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat1.xyz;
					    u_xlat27 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat27)) + u_xlat2.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlatb27 = 0.0<u_xlat0.z;
					    if(u_xlatb27){
					        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					        return;
					    }
					    u_xlat27 = u_xlat0.z * _Params.z + u_xlat1.z;
					    u_xlatb27 = (-_ProjectionParams.y)<u_xlat27;
					    u_xlat28 = (-u_xlat1.z) + (-_ProjectionParams.y);
					    u_xlat28 = u_xlat28 / u_xlat0.z;
					    u_xlat27 = (u_xlatb27) ? u_xlat28 : _Params.z;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.zzz * _ScreenSpaceProjectionMatrix[2].xyw;
					    u_xlat3.z = _ScreenSpaceProjectionMatrix[0].x * u_xlat1.x + u_xlat2.x;
					    u_xlat3.w = _ScreenSpaceProjectionMatrix[1].y * u_xlat1.y + u_xlat2.y;
					    u_xlat1.xyw = u_xlat0.zzz * _ScreenSpaceProjectionMatrix[2].xyw;
					    u_xlat3.x = _ScreenSpaceProjectionMatrix[0].x * u_xlat0.x + u_xlat1.x;
					    u_xlat3.y = _ScreenSpaceProjectionMatrix[1].y * u_xlat0.y + u_xlat1.y;
					    u_xlat2.zw = vec2(1.0) / vec2(u_xlat2.zz);
					    u_xlat2.xy = vec2(1.0) / vec2(u_xlat1.ww);
					    u_xlat4.w = u_xlat1.z * u_xlat2.w;
					    u_xlat5 = u_xlat2.wzxy * u_xlat3.wzxy;
					    u_xlat0.xy = u_xlat3.zw * u_xlat2.zw + (-u_xlat5.zw);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlatb0 = 9.99999975e-05>=u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat9 = max(_Test_TexelSize.y, _Test_TexelSize.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(u_xlat9) + u_xlat5.wz;
					    u_xlat5.zw = (-u_xlat3.wz) * u_xlat2.wz + u_xlat0.xy;
					    u_xlatb0 = abs(u_xlat5.w)<abs(u_xlat5.z);
					    u_xlat3 = (bool(u_xlatb0)) ? u_xlat5 : u_xlat5.yxwz;
					    u_xlati9 = int((0.0<u_xlat3.z) ? 0xFFFFFFFFu : uint(0));
					    u_xlati27 = int((u_xlat3.z<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati9 = (-u_xlati9) + u_xlati27;
					    u_xlat5.x = float(u_xlati9);
					    u_xlat9 = u_xlat5.x / u_xlat3.z;
					    u_xlat18.x = u_xlat0.z * u_xlat2.y + (-u_xlat4.w);
					    u_xlat5.w = u_xlat9 * u_xlat18.x;
					    u_xlat5.y = u_xlat9 * u_xlat3.w;
					    u_xlat18.x = (-u_xlat2.w) + u_xlat2.y;
					    u_xlat5.z = u_xlat9 * u_xlat18.x;
					    u_xlat9 = u_xlat1.z * -0.00999999978;
					    u_xlat9 = min(u_xlat9, 1.0);
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _Params2.yy;
					    u_xlat1.z = u_xlat1.y * _Params2.x;
					    u_xlat18.xy = u_xlat1.xz + _WorldSpaceCameraPos.xz;
					    u_xlat18.x = textureLod(_Noise, u_xlat18.xy, 0.0).w;
					    u_xlat9 = u_xlat9 * _Params2.z;
					    u_xlat1 = vec4(u_xlat9) * u_xlat5;
					    u_xlat4.xy = u_xlat3.xy;
					    u_xlat4.z = u_xlat2.w;
					    u_xlat2 = u_xlat1 * u_xlat18.xxxx + u_xlat4;
					    u_xlat3.x = intBitsToFloat(int(0xFFFFFFFFu));
					    u_xlat4.x = float(0.0);
					    u_xlat4.y = float(0.0);
					    u_xlat4.z = float(0.0);
					    u_xlat4.w = float(0.0);
					    u_xlat6 = u_xlat2;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    u_xlat7.w = float(0.0);
					    u_xlat18.x = float(0.0);
					    u_xlati27 = int(0);
					    u_xlati8 = 0;
					    while(true){
					        u_xlat1.x = float(u_xlati27);
					        u_xlatb1 = u_xlat1.x>=_Params2.w;
					        u_xlat8.x = 0.0;
					        if(u_xlatb1){break;}
					        u_xlat6 = u_xlat5 * vec4(u_xlat9) + u_xlat6;
					        u_xlat1.xy = u_xlat1.wz * vec2(0.5, 0.5) + u_xlat6.wz;
					        u_xlat1.x = u_xlat1.x / u_xlat1.y;
					        u_xlatb10 = u_xlat18.x<u_xlat1.x;
					        u_xlat18.x = (u_xlatb10) ? u_xlat18.x : u_xlat1.x;
					        u_xlat1.xy = (bool(u_xlatb0)) ? u_xlat6.yx : u_xlat6.xy;
					        u_xlat3.yz = u_xlat1.xy * _Test_TexelSize.xy;
					        u_xlat1.x = textureLod(_CameraDepthTexture, u_xlat3.yz, 0.0).x;
					        u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					        u_xlat1.x = float(1.0) / u_xlat1.x;
					        u_xlatb1 = u_xlat18.x<(-u_xlat1.x);
					        u_xlat3.w = intBitsToFloat(u_xlati27 + 1);
					        u_xlat8 = bool(u_xlatb1) ? u_xlat3 : vec4(0.0, 0.0, 0.0, 0.0);
					        u_xlat4 = u_xlat8;
					        u_xlat7 = u_xlat8;
					        if(u_xlatb1){break;}
					        u_xlatb8 = u_xlatb1;
					        u_xlati27 = u_xlati27 + 1;
					        u_xlat4.x = float(0.0);
					        u_xlat4.y = float(0.0);
					        u_xlat4.z = float(0.0);
					        u_xlat4.w = float(0.0);
					        u_xlat7.x = float(0.0);
					        u_xlat7.y = float(0.0);
					        u_xlat7.z = float(0.0);
					        u_xlat7.w = float(0.0);
					    }
					    u_xlat0 = (floatBitsToInt(u_xlat8.x) != 0) ? u_xlat4 : u_xlat7;
					    u_xlat27 = float(floatBitsToInt(u_xlat0.w));
					    SV_Target0.z = u_xlat27 / _Params2.w;
					    SV_Target0.w = uintBitsToFloat(floatBitsToUint(u_xlat0.x) & 1065353216u);
					    SV_Target0.xy = u_xlat0.yz;
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
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 112731
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_1;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    phase0_Output0_1 = u_xlat0 * vec4(0.5, -0.5, 0.5, -0.5) + vec4(0.0, 1.0, 0.0, 1.0);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!GL4x
					#ifdef VERTEX
					#version 420
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_shading_language_420pack : require
					
					in  vec3 in_POSITION0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_1;
					layout(location = 0) out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    phase0_Output0_1 = u_xlat0 * vec4(0.5, 0.5, 0.5, 0.5);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
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
					uniform 	vec4 _MainTex_TexelSize;
					uniform 	vec4 _Params;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _Test;
					layout(location = 0) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					uvec4 u_xlatu0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlatu0.xy = uvec2(ivec2(hlslcc_FragCoord.xy));
					    u_xlatu0.z = uint(0u);
					    u_xlatu0.w = uint(0u);
					    u_xlat0 = texelFetch(_Test, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
					    u_xlatb1 = u_xlat0.w==0.0;
					    if(u_xlatb1){
					        SV_Target0 = texture(_MainTex, vs_TEXCOORD1.xy);
					        return;
					    }
					    u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    u_xlat10 = max(u_xlat0.y, u_xlat0.x);
					    u_xlat10 = (-u_xlat10) + 1.0;
					    u_xlat2.x = min(u_xlat0.y, u_xlat0.x);
					    u_xlat10 = min(u_xlat10, u_xlat2.x);
					    u_xlat10 = u_xlat10 * 2.19178081;
					    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat10 = float(1.0) / u_xlat10;
					    u_xlat9 = u_xlat0.w * u_xlat10;
					    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
					    u_xlat2.yz = abs(u_xlat0.xy) * _Params.xx;
					    u_xlat0.x = _MainTex_TexelSize.z * _MainTex_TexelSize.y;
					    u_xlat2.x = u_xlat0.x * u_xlat2.y;
					    u_xlat0.x = dot(u_xlat2.xz, u_xlat2.xz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat3 = u_xlat0.x * u_xlat0.x;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat0.x = u_xlat3 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.z;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 59
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %47 %50 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD0 Location 47 
					                                             OpDecorate vs_TEXCOORD1 Location 50 
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
					                                     %32 = OpTypePointer Private %7 
					                      Private f32_4* %33 = OpVariable Private 
					                               f32_4 %36 = OpConstantComposite %27 %27 %27 %27 
					                      Private f32_4* %38 = OpVariable Private 
					                                 f32 %40 = OpConstant 3,674022E-40 
					                                 f32 %41 = OpConstant 3,674022E-40 
					                               f32_4 %42 = OpConstantComposite %40 %41 %40 %41 
					                               f32_4 %44 = OpConstantComposite %26 %27 %26 %27 
					                                     %46 = OpTypePointer Output %19 
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					              Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                     %53 = OpTypePointer Output %6 
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
					                               f32_4 %35 = OpVectorShuffle %34 %34 0 1 0 1 
					                               f32_4 %37 = OpFAdd %35 %36 
					                                             OpStore %33 %37 
					                               f32_4 %39 = OpLoad %33 
					                               f32_4 %43 = OpFMul %39 %42 
					                               f32_4 %45 = OpFAdd %43 %44 
					                                             OpStore %38 %45 
					                               f32_4 %48 = OpLoad %38 
					                               f32_2 %49 = OpVectorShuffle %48 %48 0 1 
					                                             OpStore vs_TEXCOORD0 %49 
					                               f32_4 %51 = OpLoad %38 
					                               f32_2 %52 = OpVectorShuffle %51 %51 2 3 
					                                             OpStore vs_TEXCOORD1 %52 
					                         Output f32* %54 = OpAccessChain %13 %15 %9 
					                                 f32 %55 = OpLoad %54 
					                                 f32 %56 = OpFNegate %55 
					                         Output f32* %57 = OpAccessChain %13 %15 %9 
					                                             OpStore %57 %56 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 210
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %11 %76 %82 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpDecorate %11 BuiltIn TessLevelOuter 
					                                             OpDecorate %48 DescriptorSet 48 
					                                             OpDecorate %48 Binding 48 
					                                             OpDecorate %52 DescriptorSet 52 
					                                             OpDecorate %52 Binding 52 
					                                             OpDecorate %76 Location 76 
					                                             OpDecorate %77 DescriptorSet 77 
					                                             OpDecorate %77 Binding 77 
					                                             OpDecorate vs_TEXCOORD1 Location 82 
					                                             OpMemberDecorate %140 0 Offset 140 
					                                             OpMemberDecorate %140 1 Offset 140 
					                                             OpDecorate %140 Block 
					                                             OpDecorate %142 DescriptorSet 142 
					                                             OpDecorate %142 Binding 142 
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
					                                     %26 = OpTypeVector %16 4 
					                                     %27 = OpTypePointer Private %26 
					                      Private u32_4* %28 = OpVariable Private 
					                                     %29 = OpTypeVector %6 2 
					                                     %32 = OpTypeInt 32 1 
					                                     %33 = OpTypeVector %32 2 
					                                     %35 = OpTypeVector %16 2 
					                                 u32 %39 = OpConstant 0 
					                                 u32 %40 = OpConstant 2 
					                                     %41 = OpTypePointer Private %16 
					                                     %44 = OpTypePointer Private %7 
					                      Private f32_4* %45 = OpVariable Private 
					                                     %46 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %47 = OpTypePointer UniformConstant %46 
					UniformConstant read_only Texture2D* %48 = OpVariable UniformConstant 
					                                     %50 = OpTypeSampler 
					                                     %51 = OpTypePointer UniformConstant %50 
					            UniformConstant sampler* %52 = OpVariable UniformConstant 
					                                     %54 = OpTypeSampledImage %46 
					                                     %64 = OpTypeBool 
					                                     %65 = OpTypePointer Private %64 
					                       Private bool* %66 = OpVariable Private 
					                                     %67 = OpTypePointer Private %6 
					                                 f32 %70 = OpConstant 3,674022E-40 
					                                     %75 = OpTypePointer Output %7 
					                       Output f32_4* %76 = OpVariable Output 
					UniformConstant read_only Texture2D* %77 = OpVariable UniformConstant 
					                                     %81 = OpTypePointer Input %29 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                     %86 = OpTypePointer Private %12 
					                      Private f32_3* %87 = OpVariable Private 
					                        Private f32* %95 = OpVariable Private 
					                                 u32 %96 = OpConstant 1 
					                     Private f32_3* %105 = OpVariable Private 
					                                f32 %117 = OpConstant 3,674022E-40 
					                       Private f32* %125 = OpVariable Private 
					                                f32 %132 = OpConstant 3,674022E-40 
					                              f32_2 %133 = OpConstantComposite %132 %132 
					                                    %140 = OpTypeStruct %7 %7 
					                                    %141 = OpTypePointer Uniform %140 
					    Uniform struct {f32_4; f32_4;}* %142 = OpVariable Uniform 
					                                i32 %143 = OpConstant 1 
					                                    %144 = OpTypePointer Uniform %7 
					                                i32 %151 = OpConstant 0 
					                                    %152 = OpTypePointer Uniform %6 
					                       Private f32* %180 = OpVariable Private 
					                                    %207 = OpTypePointer Output %6 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                      Function f32_4* %9 = OpVariable Function 
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
					                               f32_4 %30 = OpLoad %9 
					                               f32_2 %31 = OpVectorShuffle %30 %30 0 1 
					                               i32_2 %34 = OpConvertFToS %31 
					                               u32_2 %36 = OpBitcast %34 
					                               u32_4 %37 = OpLoad %28 
					                               u32_4 %38 = OpVectorShuffle %37 %36 4 5 2 3 
					                                             OpStore %28 %38 
					                        Private u32* %42 = OpAccessChain %28 %40 
					                                             OpStore %42 %39 
					                        Private u32* %43 = OpAccessChain %28 %17 
					                                             OpStore %43 %39 
					                 read_only Texture2D %49 = OpLoad %48 
					                             sampler %53 = OpLoad %52 
					          read_only Texture2DSampled %55 = OpSampledImage %49 %53 
					                               u32_4 %56 = OpLoad %28 
					                               u32_2 %57 = OpVectorShuffle %56 %56 0 1 
					                               i32_2 %58 = OpBitcast %57 
					                        Private u32* %59 = OpAccessChain %28 %17 
					                                 u32 %60 = OpLoad %59 
					                                 i32 %61 = OpBitcast %60 
					                 read_only Texture2D %62 = OpImage %55 
					                               f32_4 %63 = OpImageFetch %62 %58 Lod %7 
					                                             OpStore %45 %63 
					                        Private f32* %68 = OpAccessChain %45 %17 
					                                 f32 %69 = OpLoad %68 
					                                bool %71 = OpFOrdEqual %69 %70 
					                                             OpStore %66 %71 
					                                bool %72 = OpLoad %66 
					                                             OpSelectionMerge %74 None 
					                                             OpBranchConditional %72 %73 %74 
					                                     %73 = OpLabel 
					                 read_only Texture2D %78 = OpLoad %77 
					                             sampler %79 = OpLoad %52 
					          read_only Texture2DSampled %80 = OpSampledImage %78 %79 
					                               f32_2 %83 = OpLoad vs_TEXCOORD1 
					                               f32_4 %84 = OpImageSampleImplicitLod %80 %83 
					                                             OpStore %76 %84 
					                                             OpReturn
					                                     %74 = OpLabel 
					                 read_only Texture2D %88 = OpLoad %77 
					                             sampler %89 = OpLoad %52 
					          read_only Texture2DSampled %90 = OpSampledImage %88 %89 
					                               f32_4 %91 = OpLoad %45 
					                               f32_2 %92 = OpVectorShuffle %91 %91 0 1 
					                               f32_4 %93 = OpImageSampleExplicitLod %90 %92 Lod %7 
					                               f32_3 %94 = OpVectorShuffle %93 %93 0 1 2 
					                                             OpStore %87 %94 
					                        Private f32* %97 = OpAccessChain %45 %96 
					                                 f32 %98 = OpLoad %97 
					                        Private f32* %99 = OpAccessChain %45 %39 
					                                f32 %100 = OpLoad %99 
					                                f32 %101 = OpExtInst %1 40 %98 %100 
					                                             OpStore %95 %101 
					                                f32 %102 = OpLoad %95 
					                                f32 %103 = OpFNegate %102 
					                                f32 %104 = OpFAdd %103 %15 
					                                             OpStore %95 %104 
					                       Private f32* %106 = OpAccessChain %45 %96 
					                                f32 %107 = OpLoad %106 
					                       Private f32* %108 = OpAccessChain %45 %39 
					                                f32 %109 = OpLoad %108 
					                                f32 %110 = OpExtInst %1 37 %107 %109 
					                       Private f32* %111 = OpAccessChain %105 %39 
					                                             OpStore %111 %110 
					                                f32 %112 = OpLoad %95 
					                       Private f32* %113 = OpAccessChain %105 %39 
					                                f32 %114 = OpLoad %113 
					                                f32 %115 = OpExtInst %1 37 %112 %114 
					                                             OpStore %95 %115 
					                                f32 %116 = OpLoad %95 
					                                f32 %118 = OpFMul %116 %117 
					                                             OpStore %95 %118 
					                                f32 %119 = OpLoad %95 
					                                f32 %120 = OpExtInst %1 43 %119 %70 %15 
					                                             OpStore %95 %120 
					                                f32 %121 = OpLoad %95 
					                                f32 %122 = OpExtInst %1 32 %121 
					                                             OpStore %95 %122 
					                                f32 %123 = OpLoad %95 
					                                f32 %124 = OpFDiv %15 %123 
					                                             OpStore %95 %124 
					                       Private f32* %126 = OpAccessChain %45 %17 
					                                f32 %127 = OpLoad %126 
					                                f32 %128 = OpLoad %95 
					                                f32 %129 = OpFMul %127 %128 
					                                             OpStore %125 %129 
					                              f32_4 %130 = OpLoad %45 
					                              f32_2 %131 = OpVectorShuffle %130 %130 0 1 
					                              f32_2 %134 = OpFAdd %131 %133 
					                              f32_4 %135 = OpLoad %45 
					                              f32_4 %136 = OpVectorShuffle %135 %134 4 5 2 3 
					                                             OpStore %45 %136 
					                              f32_4 %137 = OpLoad %45 
					                              f32_2 %138 = OpVectorShuffle %137 %137 0 1 
					                              f32_2 %139 = OpExtInst %1 4 %138 
					                     Uniform f32_4* %145 = OpAccessChain %142 %143 
					                              f32_4 %146 = OpLoad %145 
					                              f32_2 %147 = OpVectorShuffle %146 %146 0 0 
					                              f32_2 %148 = OpFMul %139 %147 
					                              f32_3 %149 = OpLoad %105 
					                              f32_3 %150 = OpVectorShuffle %149 %148 0 3 4 
					                                             OpStore %105 %150 
					                       Uniform f32* %153 = OpAccessChain %142 %151 %40 
					                                f32 %154 = OpLoad %153 
					                       Uniform f32* %155 = OpAccessChain %142 %151 %96 
					                                f32 %156 = OpLoad %155 
					                                f32 %157 = OpFMul %154 %156 
					                       Private f32* %158 = OpAccessChain %45 %39 
					                                             OpStore %158 %157 
					                       Private f32* %159 = OpAccessChain %45 %39 
					                                f32 %160 = OpLoad %159 
					                       Private f32* %161 = OpAccessChain %105 %96 
					                                f32 %162 = OpLoad %161 
					                                f32 %163 = OpFMul %160 %162 
					                       Private f32* %164 = OpAccessChain %105 %39 
					                                             OpStore %164 %163 
					                              f32_3 %165 = OpLoad %105 
					                              f32_2 %166 = OpVectorShuffle %165 %165 0 2 
					                              f32_3 %167 = OpLoad %105 
					                              f32_2 %168 = OpVectorShuffle %167 %167 0 2 
					                                f32 %169 = OpDot %166 %168 
					                       Private f32* %170 = OpAccessChain %45 %39 
					                                             OpStore %170 %169 
					                       Private f32* %171 = OpAccessChain %45 %39 
					                                f32 %172 = OpLoad %171 
					                                f32 %173 = OpFNegate %172 
					                                f32 %174 = OpFAdd %173 %15 
					                       Private f32* %175 = OpAccessChain %45 %39 
					                                             OpStore %175 %174 
					                       Private f32* %176 = OpAccessChain %45 %39 
					                                f32 %177 = OpLoad %176 
					                                f32 %178 = OpExtInst %1 40 %177 %70 
					                       Private f32* %179 = OpAccessChain %45 %39 
					                                             OpStore %179 %178 
					                       Private f32* %181 = OpAccessChain %45 %39 
					                                f32 %182 = OpLoad %181 
					                       Private f32* %183 = OpAccessChain %45 %39 
					                                f32 %184 = OpLoad %183 
					                                f32 %185 = OpFMul %182 %184 
					                                             OpStore %180 %185 
					                                f32 %186 = OpLoad %180 
					                                f32 %187 = OpLoad %180 
					                                f32 %188 = OpFMul %186 %187 
					                                             OpStore %180 %188 
					                                f32 %189 = OpLoad %180 
					                       Private f32* %190 = OpAccessChain %45 %39 
					                                f32 %191 = OpLoad %190 
					                                f32 %192 = OpFMul %189 %191 
					                       Private f32* %193 = OpAccessChain %45 %39 
					                                             OpStore %193 %192 
					                       Private f32* %194 = OpAccessChain %45 %39 
					                                f32 %195 = OpLoad %194 
					                                f32 %196 = OpLoad %125 
					                                f32 %197 = OpFMul %195 %196 
					                       Private f32* %198 = OpAccessChain %45 %39 
					                                             OpStore %198 %197 
					                              f32_4 %199 = OpLoad %45 
					                              f32_3 %200 = OpVectorShuffle %199 %199 0 0 0 
					                              f32_3 %201 = OpLoad %87 
					                              f32_3 %202 = OpFMul %200 %201 
					                              f32_4 %203 = OpLoad %76 
					                              f32_4 %204 = OpVectorShuffle %203 %202 4 5 6 3 
					                                             OpStore %76 %204 
					                       Private f32* %205 = OpAccessChain %45 %40 
					                                f32 %206 = OpLoad %205 
					                        Output f32* %208 = OpAccessChain %76 %17 
					                                             OpStore %208 %206 
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
						vec4 unused_0_0[4];
						vec4 _MainTex_TexelSize;
						vec4 unused_0_2[17];
						vec4 _Params;
						vec4 unused_0_4;
					};
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _Test;
					layout(location = 0) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					uvec4 u_xlatu0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlatu0.xy =  uvec2(ivec2(hlslcc_FragCoord.xy));
					    u_xlatu0.z = uint(0u);
					    u_xlatu0.w = uint(0u);
					    u_xlat0 = texelFetch(_Test, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
					    u_xlatb1 = u_xlat0.w==0.0;
					    if(u_xlatb1){
					        SV_Target0 = texture(_MainTex, vs_TEXCOORD1.xy);
					        return;
					    }
					    u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    u_xlat10 = max(u_xlat0.y, u_xlat0.x);
					    u_xlat10 = (-u_xlat10) + 1.0;
					    u_xlat2.x = min(u_xlat0.y, u_xlat0.x);
					    u_xlat10 = min(u_xlat10, u_xlat2.x);
					    u_xlat10 = u_xlat10 * 2.19178081;
					    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat10 = float(1.0) / u_xlat10;
					    u_xlat9 = u_xlat0.w * u_xlat10;
					    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
					    u_xlat2.yz = abs(u_xlat0.xy) * _Params.xx;
					    u_xlat0.x = _MainTex_TexelSize.z * _MainTex_TexelSize.y;
					    u_xlat2.x = u_xlat0.x * u_xlat2.y;
					    u_xlat0.x = dot(u_xlat2.xz, u_xlat2.xz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat3 = u_xlat0.x * u_xlat0.x;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat0.x = u_xlat3 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.z;
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
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 140441
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_1;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    phase0_Output0_1 = u_xlat0 * vec4(0.5, -0.5, 0.5, -0.5) + vec4(0.0, 1.0, 0.0, 1.0);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!GL4x
					#ifdef VERTEX
					#version 420
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_shading_language_420pack : require
					
					in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_1;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    phase0_Output0_1 = u_xlat0 * vec4(0.5, 0.5, 0.5, 0.5);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
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
					uniform 	vec4 _MainTex_TexelSize;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _History;
					UNITY_LOCATION(2) uniform  sampler2D _CameraMotionVectorsTexture;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat6;
					vec2 u_xlat13;
					void main()
					{
					    u_xlat0.z = 0.0;
					    u_xlat0.xyw = (-_MainTex_TexelSize.xyy);
					    u_xlat0 = u_xlat0 + vs_TEXCOORD0.xyxy;
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_MainTex, u_xlat0.zw, 0.0);
					    u_xlat2 = min(u_xlat0, u_xlat1);
					    u_xlat0 = max(u_xlat0, u_xlat1);
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(1.0, -1.0, -1.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat3 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					    u_xlat1 = textureLod(_MainTex, u_xlat1.zw, 0.0);
					    u_xlat2 = min(u_xlat2, u_xlat3);
					    u_xlat0 = max(u_xlat0, u_xlat3);
					    u_xlat3.x = (-_MainTex_TexelSize.x);
					    u_xlat3.y = float(0.0);
					    u_xlat13.y = float(0.0);
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
					    u_xlat4 = textureLod(_MainTex, u_xlat3.xy, 0.0);
					    u_xlat2 = min(u_xlat2, u_xlat4);
					    u_xlat0 = max(u_xlat0, u_xlat4);
					    u_xlat13.x = _MainTex_TexelSize.x;
					    u_xlat3.xy = u_xlat13.xy + vs_TEXCOORD0.xy;
					    u_xlat3 = textureLod(_MainTex, u_xlat3.xy, 0.0);
					    u_xlat2 = min(u_xlat2, u_xlat3);
					    u_xlat0 = max(u_xlat0, u_xlat3);
					    u_xlat0 = max(u_xlat1, u_xlat0);
					    u_xlat1 = min(u_xlat1, u_xlat2);
					    u_xlat2.x = 0.0;
					    u_xlat2.y = _MainTex_TexelSize.y;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					    u_xlat1 = min(u_xlat1, u_xlat2);
					    u_xlat0 = max(u_xlat0, u_xlat2);
					    u_xlat2.xy = vs_TEXCOORD0.xy + _MainTex_TexelSize.xy;
					    u_xlat2 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					    u_xlat1 = min(u_xlat1, u_xlat2);
					    u_xlat0 = max(u_xlat0, u_xlat2);
					    u_xlat2 = textureLod(_MainTex, vs_TEXCOORD1.xy, 0.0);
					    u_xlat1 = min(u_xlat1, u_xlat2);
					    u_xlat3.xy = textureLod(_CameraMotionVectorsTexture, vs_TEXCOORD1.xy, 0.0).xy;
					    u_xlat13.xy = (-u_xlat3.xy) + vs_TEXCOORD0.xy;
					    u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlat3.x = (-_MainTex_TexelSize.z) * 0.00200000009 + u_xlat3.x;
					    u_xlat4 = textureLod(_History, u_xlat13.xy, 0.0);
					    u_xlat1 = max(u_xlat1, u_xlat4);
					    u_xlat0 = max(u_xlat0, u_xlat2);
					    u_xlat0 = min(u_xlat0, u_xlat1);
					    u_xlat1.x = _MainTex_TexelSize.z * 0.00150000001;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat3.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat6 = u_xlat1.x * -2.0 + 3.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat6;
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat2.w = u_xlat1.x * 0.850000024;
					    u_xlat1 = u_xlat0 + (-u_xlat2);
					    u_xlat0.x = u_xlat0.w * -25.0 + 0.949999988;
					    u_xlat0.x = max(u_xlat0.x, 0.699999988);
					    u_xlat0.x = min(u_xlat0.x, 0.949999988);
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
					; Bound: 59
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %47 %50 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD0 Location 47 
					                                             OpDecorate vs_TEXCOORD1 Location 50 
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
					                                     %32 = OpTypePointer Private %7 
					                      Private f32_4* %33 = OpVariable Private 
					                               f32_4 %36 = OpConstantComposite %27 %27 %27 %27 
					                      Private f32_4* %38 = OpVariable Private 
					                                 f32 %40 = OpConstant 3,674022E-40 
					                                 f32 %41 = OpConstant 3,674022E-40 
					                               f32_4 %42 = OpConstantComposite %40 %41 %40 %41 
					                               f32_4 %44 = OpConstantComposite %26 %27 %26 %27 
					                                     %46 = OpTypePointer Output %19 
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					              Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                     %53 = OpTypePointer Output %6 
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
					                               f32_4 %35 = OpVectorShuffle %34 %34 0 1 0 1 
					                               f32_4 %37 = OpFAdd %35 %36 
					                                             OpStore %33 %37 
					                               f32_4 %39 = OpLoad %33 
					                               f32_4 %43 = OpFMul %39 %42 
					                               f32_4 %45 = OpFAdd %43 %44 
					                                             OpStore %38 %45 
					                               f32_4 %48 = OpLoad %38 
					                               f32_2 %49 = OpVectorShuffle %48 %48 0 1 
					                                             OpStore vs_TEXCOORD0 %49 
					                               f32_4 %51 = OpLoad %38 
					                               f32_2 %52 = OpVectorShuffle %51 %51 2 3 
					                                             OpStore vs_TEXCOORD1 %52 
					                         Output f32* %54 = OpAccessChain %13 %15 %9 
					                                 f32 %55 = OpLoad %54 
					                                 f32 %56 = OpFNegate %55 
					                         Output f32* %57 = OpAccessChain %13 %15 %9 
					                                             OpStore %57 %56 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 323
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %31 %191 %315 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpMemberDecorate %15 0 Offset 15 
					                                              OpDecorate %15 Block 
					                                              OpDecorate %17 DescriptorSet 17 
					                                              OpDecorate %17 Binding 17 
					                                              OpDecorate vs_TEXCOORD0 Location 31 
					                                              OpDecorate %38 DescriptorSet 38 
					                                              OpDecorate %38 Binding 38 
					                                              OpDecorate %42 DescriptorSet 42 
					                                              OpDecorate %42 Binding 42 
					                                              OpDecorate vs_TEXCOORD1 Location 191 
					                                              OpDecorate %197 DescriptorSet 197 
					                                              OpDecorate %197 Binding 197 
					                                              OpDecorate %199 DescriptorSet 199 
					                                              OpDecorate %199 Binding 199 
					                                              OpDecorate %231 DescriptorSet 231 
					                                              OpDecorate %231 Binding 231 
					                                              OpDecorate %233 DescriptorSet 233 
					                                              OpDecorate %233 Binding 233 
					                                              OpDecorate %315 Location 315 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 4 
					                                       %8 = OpTypePointer Private %7 
					                        Private f32_4* %9 = OpVariable Private 
					                                  f32 %10 = OpConstant 3,674022E-40 
					                                      %11 = OpTypeInt 32 0 
					                                  u32 %12 = OpConstant 2 
					                                      %13 = OpTypePointer Private %6 
					                                      %15 = OpTypeStruct %7 
					                                      %16 = OpTypePointer Uniform %15 
					             Uniform struct {f32_4;}* %17 = OpVariable Uniform 
					                                      %18 = OpTypeInt 32 1 
					                                  i32 %19 = OpConstant 0 
					                                      %20 = OpTypeVector %6 3 
					                                      %21 = OpTypePointer Uniform %7 
					                                      %29 = OpTypeVector %6 2 
					                                      %30 = OpTypePointer Input %29 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                       Private f32_4* %35 = OpVariable Private 
					                                      %36 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                      %37 = OpTypePointer UniformConstant %36 
					 UniformConstant read_only Texture2D* %38 = OpVariable UniformConstant 
					                                      %40 = OpTypeSampler 
					                                      %41 = OpTypePointer UniformConstant %40 
					             UniformConstant sampler* %42 = OpVariable UniformConstant 
					                                      %44 = OpTypeSampledImage %36 
					                       Private f32_4* %55 = OpVariable Private 
					                                  f32 %65 = OpConstant 3,674022E-40 
					                                  f32 %66 = OpConstant 3,674022E-40 
					                                f32_4 %67 = OpConstantComposite %65 %66 %66 %65 
					                       Private f32_4* %72 = OpVariable Private 
					                                  u32 %91 = OpConstant 0 
					                                      %92 = OpTypePointer Uniform %6 
					                                  u32 %97 = OpConstant 1 
					                                      %99 = OpTypePointer Private %29 
					                      Private f32_2* %100 = OpVariable Private 
					                      Private f32_4* %108 = OpVariable Private 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					UniformConstant read_only Texture2D* %197 = OpVariable UniformConstant 
					            UniformConstant sampler* %199 = OpVariable UniformConstant 
					                                 f32 %225 = OpConstant 3,674022E-40 
					UniformConstant read_only Texture2D* %231 = OpVariable UniformConstant 
					            UniformConstant sampler* %233 = OpVariable UniformConstant 
					                                 f32 %249 = OpConstant 3,674022E-40 
					                        Private f32* %266 = OpVariable Private 
					                                 f32 %269 = OpConstant 3,674022E-40 
					                                 f32 %271 = OpConstant 3,674022E-40 
					                                 f32 %290 = OpConstant 3,674022E-40 
					                                 u32 %292 = OpConstant 3 
					                                 f32 %300 = OpConstant 3,674022E-40 
					                                 f32 %302 = OpConstant 3,674022E-40 
					                                 f32 %307 = OpConstant 3,674022E-40 
					                                     %314 = OpTypePointer Output %7 
					                       Output f32_4* %315 = OpVariable Output 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                         Private f32* %14 = OpAccessChain %9 %12 
					                                              OpStore %14 %10 
					                       Uniform f32_4* %22 = OpAccessChain %17 %19 
					                                f32_4 %23 = OpLoad %22 
					                                f32_3 %24 = OpVectorShuffle %23 %23 0 1 1 
					                                f32_3 %25 = OpFNegate %24 
					                                f32_4 %26 = OpLoad %9 
					                                f32_4 %27 = OpVectorShuffle %26 %25 4 5 2 6 
					                                              OpStore %9 %27 
					                                f32_4 %28 = OpLoad %9 
					                                f32_2 %32 = OpLoad vs_TEXCOORD0 
					                                f32_4 %33 = OpVectorShuffle %32 %32 0 1 0 1 
					                                f32_4 %34 = OpFAdd %28 %33 
					                                              OpStore %9 %34 
					                  read_only Texture2D %39 = OpLoad %38 
					                              sampler %43 = OpLoad %42 
					           read_only Texture2DSampled %45 = OpSampledImage %39 %43 
					                                f32_4 %46 = OpLoad %9 
					                                f32_2 %47 = OpVectorShuffle %46 %46 0 1 
					                                f32_4 %48 = OpImageSampleExplicitLod %45 %47 Lod %7 
					                                              OpStore %35 %48 
					                  read_only Texture2D %49 = OpLoad %38 
					                              sampler %50 = OpLoad %42 
					           read_only Texture2DSampled %51 = OpSampledImage %49 %50 
					                                f32_4 %52 = OpLoad %9 
					                                f32_2 %53 = OpVectorShuffle %52 %52 2 3 
					                                f32_4 %54 = OpImageSampleExplicitLod %51 %53 Lod %7 
					                                              OpStore %9 %54 
					                                f32_4 %56 = OpLoad %9 
					                                f32_4 %57 = OpLoad %35 
					                                f32_4 %58 = OpExtInst %1 37 %56 %57 
					                                              OpStore %55 %58 
					                                f32_4 %59 = OpLoad %9 
					                                f32_4 %60 = OpLoad %35 
					                                f32_4 %61 = OpExtInst %1 40 %59 %60 
					                                              OpStore %9 %61 
					                       Uniform f32_4* %62 = OpAccessChain %17 %19 
					                                f32_4 %63 = OpLoad %62 
					                                f32_4 %64 = OpVectorShuffle %63 %63 0 1 0 1 
					                                f32_4 %68 = OpFMul %64 %67 
					                                f32_2 %69 = OpLoad vs_TEXCOORD0 
					                                f32_4 %70 = OpVectorShuffle %69 %69 0 1 0 1 
					                                f32_4 %71 = OpFAdd %68 %70 
					                                              OpStore %35 %71 
					                  read_only Texture2D %73 = OpLoad %38 
					                              sampler %74 = OpLoad %42 
					           read_only Texture2DSampled %75 = OpSampledImage %73 %74 
					                                f32_4 %76 = OpLoad %35 
					                                f32_2 %77 = OpVectorShuffle %76 %76 0 1 
					                                f32_4 %78 = OpImageSampleExplicitLod %75 %77 Lod %7 
					                                              OpStore %72 %78 
					                  read_only Texture2D %79 = OpLoad %38 
					                              sampler %80 = OpLoad %42 
					           read_only Texture2DSampled %81 = OpSampledImage %79 %80 
					                                f32_4 %82 = OpLoad %35 
					                                f32_2 %83 = OpVectorShuffle %82 %82 2 3 
					                                f32_4 %84 = OpImageSampleExplicitLod %81 %83 Lod %7 
					                                              OpStore %35 %84 
					                                f32_4 %85 = OpLoad %55 
					                                f32_4 %86 = OpLoad %72 
					                                f32_4 %87 = OpExtInst %1 37 %85 %86 
					                                              OpStore %55 %87 
					                                f32_4 %88 = OpLoad %9 
					                                f32_4 %89 = OpLoad %72 
					                                f32_4 %90 = OpExtInst %1 40 %88 %89 
					                                              OpStore %9 %90 
					                         Uniform f32* %93 = OpAccessChain %17 %19 %91 
					                                  f32 %94 = OpLoad %93 
					                                  f32 %95 = OpFNegate %94 
					                         Private f32* %96 = OpAccessChain %72 %91 
					                                              OpStore %96 %95 
					                         Private f32* %98 = OpAccessChain %72 %97 
					                                              OpStore %98 %10 
					                        Private f32* %101 = OpAccessChain %100 %97 
					                                              OpStore %101 %10 
					                               f32_4 %102 = OpLoad %72 
					                               f32_2 %103 = OpVectorShuffle %102 %102 0 1 
					                               f32_2 %104 = OpLoad vs_TEXCOORD0 
					                               f32_2 %105 = OpFAdd %103 %104 
					                               f32_4 %106 = OpLoad %72 
					                               f32_4 %107 = OpVectorShuffle %106 %105 4 5 2 3 
					                                              OpStore %72 %107 
					                 read_only Texture2D %109 = OpLoad %38 
					                             sampler %110 = OpLoad %42 
					          read_only Texture2DSampled %111 = OpSampledImage %109 %110 
					                               f32_4 %112 = OpLoad %72 
					                               f32_2 %113 = OpVectorShuffle %112 %112 0 1 
					                               f32_4 %114 = OpImageSampleExplicitLod %111 %113 Lod %7 
					                                              OpStore %108 %114 
					                               f32_4 %115 = OpLoad %55 
					                               f32_4 %116 = OpLoad %108 
					                               f32_4 %117 = OpExtInst %1 37 %115 %116 
					                                              OpStore %55 %117 
					                               f32_4 %118 = OpLoad %9 
					                               f32_4 %119 = OpLoad %108 
					                               f32_4 %120 = OpExtInst %1 40 %118 %119 
					                                              OpStore %9 %120 
					                        Uniform f32* %121 = OpAccessChain %17 %19 %91 
					                                 f32 %122 = OpLoad %121 
					                        Private f32* %123 = OpAccessChain %100 %91 
					                                              OpStore %123 %122 
					                               f32_2 %124 = OpLoad %100 
					                               f32_2 %125 = OpLoad vs_TEXCOORD0 
					                               f32_2 %126 = OpFAdd %124 %125 
					                               f32_4 %127 = OpLoad %72 
					                               f32_4 %128 = OpVectorShuffle %127 %126 4 5 2 3 
					                                              OpStore %72 %128 
					                 read_only Texture2D %129 = OpLoad %38 
					                             sampler %130 = OpLoad %42 
					          read_only Texture2DSampled %131 = OpSampledImage %129 %130 
					                               f32_4 %132 = OpLoad %72 
					                               f32_2 %133 = OpVectorShuffle %132 %132 0 1 
					                               f32_4 %134 = OpImageSampleExplicitLod %131 %133 Lod %7 
					                                              OpStore %72 %134 
					                               f32_4 %135 = OpLoad %55 
					                               f32_4 %136 = OpLoad %72 
					                               f32_4 %137 = OpExtInst %1 37 %135 %136 
					                                              OpStore %55 %137 
					                               f32_4 %138 = OpLoad %9 
					                               f32_4 %139 = OpLoad %72 
					                               f32_4 %140 = OpExtInst %1 40 %138 %139 
					                                              OpStore %9 %140 
					                               f32_4 %141 = OpLoad %35 
					                               f32_4 %142 = OpLoad %9 
					                               f32_4 %143 = OpExtInst %1 40 %141 %142 
					                                              OpStore %9 %143 
					                               f32_4 %144 = OpLoad %35 
					                               f32_4 %145 = OpLoad %55 
					                               f32_4 %146 = OpExtInst %1 37 %144 %145 
					                                              OpStore %35 %146 
					                        Private f32* %147 = OpAccessChain %55 %91 
					                                              OpStore %147 %10 
					                        Uniform f32* %148 = OpAccessChain %17 %19 %97 
					                                 f32 %149 = OpLoad %148 
					                        Private f32* %150 = OpAccessChain %55 %97 
					                                              OpStore %150 %149 
					                               f32_4 %151 = OpLoad %55 
					                               f32_2 %152 = OpVectorShuffle %151 %151 0 1 
					                               f32_2 %153 = OpLoad vs_TEXCOORD0 
					                               f32_2 %154 = OpFAdd %152 %153 
					                               f32_4 %155 = OpLoad %55 
					                               f32_4 %156 = OpVectorShuffle %155 %154 4 5 2 3 
					                                              OpStore %55 %156 
					                 read_only Texture2D %157 = OpLoad %38 
					                             sampler %158 = OpLoad %42 
					          read_only Texture2DSampled %159 = OpSampledImage %157 %158 
					                               f32_4 %160 = OpLoad %55 
					                               f32_2 %161 = OpVectorShuffle %160 %160 0 1 
					                               f32_4 %162 = OpImageSampleExplicitLod %159 %161 Lod %7 
					                                              OpStore %55 %162 
					                               f32_4 %163 = OpLoad %35 
					                               f32_4 %164 = OpLoad %55 
					                               f32_4 %165 = OpExtInst %1 37 %163 %164 
					                                              OpStore %35 %165 
					                               f32_4 %166 = OpLoad %9 
					                               f32_4 %167 = OpLoad %55 
					                               f32_4 %168 = OpExtInst %1 40 %166 %167 
					                                              OpStore %9 %168 
					                               f32_2 %169 = OpLoad vs_TEXCOORD0 
					                      Uniform f32_4* %170 = OpAccessChain %17 %19 
					                               f32_4 %171 = OpLoad %170 
					                               f32_2 %172 = OpVectorShuffle %171 %171 0 1 
					                               f32_2 %173 = OpFAdd %169 %172 
					                               f32_4 %174 = OpLoad %55 
					                               f32_4 %175 = OpVectorShuffle %174 %173 4 5 2 3 
					                                              OpStore %55 %175 
					                 read_only Texture2D %176 = OpLoad %38 
					                             sampler %177 = OpLoad %42 
					          read_only Texture2DSampled %178 = OpSampledImage %176 %177 
					                               f32_4 %179 = OpLoad %55 
					                               f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                               f32_4 %181 = OpImageSampleExplicitLod %178 %180 Lod %7 
					                                              OpStore %55 %181 
					                               f32_4 %182 = OpLoad %35 
					                               f32_4 %183 = OpLoad %55 
					                               f32_4 %184 = OpExtInst %1 37 %182 %183 
					                                              OpStore %35 %184 
					                               f32_4 %185 = OpLoad %9 
					                               f32_4 %186 = OpLoad %55 
					                               f32_4 %187 = OpExtInst %1 40 %185 %186 
					                                              OpStore %9 %187 
					                 read_only Texture2D %188 = OpLoad %38 
					                             sampler %189 = OpLoad %42 
					          read_only Texture2DSampled %190 = OpSampledImage %188 %189 
					                               f32_2 %192 = OpLoad vs_TEXCOORD1 
					                               f32_4 %193 = OpImageSampleExplicitLod %190 %192 Lod %7 
					                                              OpStore %55 %193 
					                               f32_4 %194 = OpLoad %35 
					                               f32_4 %195 = OpLoad %55 
					                               f32_4 %196 = OpExtInst %1 37 %194 %195 
					                                              OpStore %35 %196 
					                 read_only Texture2D %198 = OpLoad %197 
					                             sampler %200 = OpLoad %199 
					          read_only Texture2DSampled %201 = OpSampledImage %198 %200 
					                               f32_2 %202 = OpLoad vs_TEXCOORD1 
					                               f32_4 %203 = OpImageSampleExplicitLod %201 %202 Lod %7 
					                               f32_2 %204 = OpVectorShuffle %203 %203 0 1 
					                               f32_4 %205 = OpLoad %72 
					                               f32_4 %206 = OpVectorShuffle %205 %204 4 5 2 3 
					                                              OpStore %72 %206 
					                               f32_4 %207 = OpLoad %72 
					                               f32_2 %208 = OpVectorShuffle %207 %207 0 1 
					                               f32_2 %209 = OpFNegate %208 
					                               f32_2 %210 = OpLoad vs_TEXCOORD0 
					                               f32_2 %211 = OpFAdd %209 %210 
					                                              OpStore %100 %211 
					                               f32_4 %212 = OpLoad %72 
					                               f32_2 %213 = OpVectorShuffle %212 %212 0 1 
					                               f32_4 %214 = OpLoad %72 
					                               f32_2 %215 = OpVectorShuffle %214 %214 0 1 
					                                 f32 %216 = OpDot %213 %215 
					                        Private f32* %217 = OpAccessChain %72 %91 
					                                              OpStore %217 %216 
					                        Private f32* %218 = OpAccessChain %72 %91 
					                                 f32 %219 = OpLoad %218 
					                                 f32 %220 = OpExtInst %1 31 %219 
					                        Private f32* %221 = OpAccessChain %72 %91 
					                                              OpStore %221 %220 
					                        Uniform f32* %222 = OpAccessChain %17 %19 %12 
					                                 f32 %223 = OpLoad %222 
					                                 f32 %224 = OpFNegate %223 
					                                 f32 %226 = OpFMul %224 %225 
					                        Private f32* %227 = OpAccessChain %72 %91 
					                                 f32 %228 = OpLoad %227 
					                                 f32 %229 = OpFAdd %226 %228 
					                        Private f32* %230 = OpAccessChain %72 %91 
					                                              OpStore %230 %229 
					                 read_only Texture2D %232 = OpLoad %231 
					                             sampler %234 = OpLoad %233 
					          read_only Texture2DSampled %235 = OpSampledImage %232 %234 
					                               f32_2 %236 = OpLoad %100 
					                               f32_4 %237 = OpImageSampleExplicitLod %235 %236 Lod %7 
					                                              OpStore %108 %237 
					                               f32_4 %238 = OpLoad %35 
					                               f32_4 %239 = OpLoad %108 
					                               f32_4 %240 = OpExtInst %1 40 %238 %239 
					                                              OpStore %35 %240 
					                               f32_4 %241 = OpLoad %9 
					                               f32_4 %242 = OpLoad %55 
					                               f32_4 %243 = OpExtInst %1 40 %241 %242 
					                                              OpStore %9 %243 
					                               f32_4 %244 = OpLoad %9 
					                               f32_4 %245 = OpLoad %35 
					                               f32_4 %246 = OpExtInst %1 37 %244 %245 
					                                              OpStore %9 %246 
					                        Uniform f32* %247 = OpAccessChain %17 %19 %12 
					                                 f32 %248 = OpLoad %247 
					                                 f32 %250 = OpFMul %248 %249 
					                        Private f32* %251 = OpAccessChain %35 %91 
					                                              OpStore %251 %250 
					                        Private f32* %252 = OpAccessChain %35 %91 
					                                 f32 %253 = OpLoad %252 
					                                 f32 %254 = OpFDiv %65 %253 
					                        Private f32* %255 = OpAccessChain %35 %91 
					                                              OpStore %255 %254 
					                        Private f32* %256 = OpAccessChain %35 %91 
					                                 f32 %257 = OpLoad %256 
					                        Private f32* %258 = OpAccessChain %72 %91 
					                                 f32 %259 = OpLoad %258 
					                                 f32 %260 = OpFMul %257 %259 
					                        Private f32* %261 = OpAccessChain %35 %91 
					                                              OpStore %261 %260 
					                        Private f32* %262 = OpAccessChain %35 %91 
					                                 f32 %263 = OpLoad %262 
					                                 f32 %264 = OpExtInst %1 43 %263 %10 %65 
					                        Private f32* %265 = OpAccessChain %35 %91 
					                                              OpStore %265 %264 
					                        Private f32* %267 = OpAccessChain %35 %91 
					                                 f32 %268 = OpLoad %267 
					                                 f32 %270 = OpFMul %268 %269 
					                                 f32 %272 = OpFAdd %270 %271 
					                                              OpStore %266 %272 
					                        Private f32* %273 = OpAccessChain %35 %91 
					                                 f32 %274 = OpLoad %273 
					                        Private f32* %275 = OpAccessChain %35 %91 
					                                 f32 %276 = OpLoad %275 
					                                 f32 %277 = OpFMul %274 %276 
					                        Private f32* %278 = OpAccessChain %35 %91 
					                                              OpStore %278 %277 
					                        Private f32* %279 = OpAccessChain %35 %91 
					                                 f32 %280 = OpLoad %279 
					                                 f32 %281 = OpLoad %266 
					                                 f32 %282 = OpFMul %280 %281 
					                        Private f32* %283 = OpAccessChain %35 %91 
					                                              OpStore %283 %282 
					                        Private f32* %284 = OpAccessChain %35 %91 
					                                 f32 %285 = OpLoad %284 
					                                 f32 %286 = OpExtInst %1 37 %285 %65 
					                        Private f32* %287 = OpAccessChain %35 %91 
					                                              OpStore %287 %286 
					                        Private f32* %288 = OpAccessChain %35 %91 
					                                 f32 %289 = OpLoad %288 
					                                 f32 %291 = OpFMul %289 %290 
					                        Private f32* %293 = OpAccessChain %55 %292 
					                                              OpStore %293 %291 
					                               f32_4 %294 = OpLoad %9 
					                               f32_4 %295 = OpLoad %55 
					                               f32_4 %296 = OpFNegate %295 
					                               f32_4 %297 = OpFAdd %294 %296 
					                                              OpStore %35 %297 
					                        Private f32* %298 = OpAccessChain %9 %292 
					                                 f32 %299 = OpLoad %298 
					                                 f32 %301 = OpFMul %299 %300 
					                                 f32 %303 = OpFAdd %301 %302 
					                        Private f32* %304 = OpAccessChain %9 %91 
					                                              OpStore %304 %303 
					                        Private f32* %305 = OpAccessChain %9 %91 
					                                 f32 %306 = OpLoad %305 
					                                 f32 %308 = OpExtInst %1 40 %306 %307 
					                        Private f32* %309 = OpAccessChain %9 %91 
					                                              OpStore %309 %308 
					                        Private f32* %310 = OpAccessChain %9 %91 
					                                 f32 %311 = OpLoad %310 
					                                 f32 %312 = OpExtInst %1 37 %311 %302 
					                        Private f32* %313 = OpAccessChain %9 %91 
					                                              OpStore %313 %312 
					                               f32_4 %316 = OpLoad %9 
					                               f32_4 %317 = OpVectorShuffle %316 %316 0 0 0 0 
					                               f32_4 %318 = OpLoad %35 
					                               f32_4 %319 = OpFMul %317 %318 
					                               f32_4 %320 = OpLoad %55 
					                               f32_4 %321 = OpFAdd %319 %320 
					                                              OpStore %315 %321 
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
						vec4 unused_0_0[4];
						vec4 _MainTex_TexelSize;
						vec4 unused_0_2[19];
					};
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _History;
					UNITY_LOCATION(2) uniform  sampler2D _CameraMotionVectorsTexture;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat6;
					vec2 u_xlat13;
					void main()
					{
					    u_xlat0.z = 0.0;
					    u_xlat0.xyw = (-_MainTex_TexelSize.xyy);
					    u_xlat0 = u_xlat0 + vs_TEXCOORD0.xyxy;
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_MainTex, u_xlat0.zw, 0.0);
					    u_xlat2 = min(u_xlat0, u_xlat1);
					    u_xlat0 = max(u_xlat0, u_xlat1);
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(1.0, -1.0, -1.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat3 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					    u_xlat1 = textureLod(_MainTex, u_xlat1.zw, 0.0);
					    u_xlat2 = min(u_xlat2, u_xlat3);
					    u_xlat0 = max(u_xlat0, u_xlat3);
					    u_xlat3.x = (-_MainTex_TexelSize.x);
					    u_xlat3.y = float(0.0);
					    u_xlat13.y = float(0.0);
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
					    u_xlat4 = textureLod(_MainTex, u_xlat3.xy, 0.0);
					    u_xlat2 = min(u_xlat2, u_xlat4);
					    u_xlat0 = max(u_xlat0, u_xlat4);
					    u_xlat13.x = _MainTex_TexelSize.x;
					    u_xlat3.xy = u_xlat13.xy + vs_TEXCOORD0.xy;
					    u_xlat3 = textureLod(_MainTex, u_xlat3.xy, 0.0);
					    u_xlat2 = min(u_xlat2, u_xlat3);
					    u_xlat0 = max(u_xlat0, u_xlat3);
					    u_xlat0 = max(u_xlat1, u_xlat0);
					    u_xlat1 = min(u_xlat1, u_xlat2);
					    u_xlat2.x = 0.0;
					    u_xlat2.y = _MainTex_TexelSize.y;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					    u_xlat1 = min(u_xlat1, u_xlat2);
					    u_xlat0 = max(u_xlat0, u_xlat2);
					    u_xlat2.xy = vs_TEXCOORD0.xy + _MainTex_TexelSize.xy;
					    u_xlat2 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					    u_xlat1 = min(u_xlat1, u_xlat2);
					    u_xlat0 = max(u_xlat0, u_xlat2);
					    u_xlat2 = textureLod(_MainTex, vs_TEXCOORD1.xy, 0.0);
					    u_xlat1 = min(u_xlat1, u_xlat2);
					    u_xlat3.xy = textureLod(_CameraMotionVectorsTexture, vs_TEXCOORD1.xy, 0.0).xy;
					    u_xlat13.xy = (-u_xlat3.xy) + vs_TEXCOORD0.xy;
					    u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlat3.x = (-_MainTex_TexelSize.z) * 0.00200000009 + u_xlat3.x;
					    u_xlat4 = textureLod(_History, u_xlat13.xy, 0.0);
					    u_xlat1 = max(u_xlat1, u_xlat4);
					    u_xlat0 = max(u_xlat0, u_xlat2);
					    u_xlat0 = min(u_xlat0, u_xlat1);
					    u_xlat1.x = _MainTex_TexelSize.z * 0.00150000001;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat3.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat6 = u_xlat1.x * -2.0 + 3.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat6;
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat2.w = u_xlat1.x * 0.850000024;
					    u_xlat1 = u_xlat0 + (-u_xlat2);
					    u_xlat0.x = u_xlat0.w * -25.0 + 0.949999988;
					    u_xlat0.x = max(u_xlat0.x, 0.699999988);
					    u_xlat0.x = min(u_xlat0.x, 0.949999988);
					    SV_Target0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
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
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 227410
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_1;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    phase0_Output0_1 = u_xlat0 * vec4(0.5, -0.5, 0.5, -0.5) + vec4(0.0, 1.0, 0.0, 1.0);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!GL4x
					#ifdef VERTEX
					#version 420
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_shading_language_420pack : require
					
					in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_1;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    phase0_Output0_1 = u_xlat0 * vec4(0.5, 0.5, 0.5, 0.5);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
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
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 hlslcc_mtx4x4_InverseViewMatrix[4];
					uniform 	vec4 hlslcc_mtx4x4_InverseProjectionMatrix[4];
					uniform 	vec4 _Params;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CameraDepthTexture;
					UNITY_LOCATION(2) uniform  sampler2D _CameraReflectionsTexture;
					UNITY_LOCATION(3) uniform  sampler2D _CameraGBufferTexture0;
					UNITY_LOCATION(4) uniform  sampler2D _CameraGBufferTexture1;
					UNITY_LOCATION(5) uniform  sampler2D _CameraGBufferTexture2;
					UNITY_LOCATION(6) uniform  sampler2D _Resolve;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					uvec4 u_xlatu0;
					bool u_xlatb0;
					float u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat8;
					float u_xlat9;
					float u_xlat10;
					vec2 u_xlat11;
					float u_xlat13;
					float u_xlat15;
					float u_xlat17;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.x = textureLod(_CameraDepthTexture, vs_TEXCOORD1.xy, 0.0).x;
					    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlatb0 = 0.999000013<u_xlat0.x;
					    if(u_xlatb0){
					        SV_Target0 = texture(_MainTex, vs_TEXCOORD1.xy);
					        return;
					    }
					    u_xlatu0.xy = uvec2(ivec2(hlslcc_FragCoord.xy));
					    u_xlatu0.z = uint(0u);
					    u_xlatu0.w = uint(0u);
					    u_xlat1 = texelFetch(_CameraGBufferTexture0, ivec2(u_xlatu0.xy), int(u_xlatu0.w)).w;
					    u_xlat2 = texelFetch(_CameraGBufferTexture1, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
					    u_xlat0.xyz = texelFetch(_CameraGBufferTexture2, ivec2(u_xlatu0.xy), int(u_xlatu0.w)).xyz;
					    u_xlat15 = max(u_xlat2.y, u_xlat2.x);
					    u_xlat15 = max(u_xlat2.z, u_xlat15);
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.x = textureLod(_CameraDepthTexture, vs_TEXCOORD0.xy, 0.0).x;
					    u_xlat11.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3 = u_xlat11.yyyy * hlslcc_mtx4x4_InverseProjectionMatrix[1];
					    u_xlat3 = hlslcc_mtx4x4_InverseProjectionMatrix[0] * u_xlat11.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4_InverseProjectionMatrix[2] * u_xlat6.xxxx + u_xlat3;
					    u_xlat3 = u_xlat3 + hlslcc_mtx4x4_InverseProjectionMatrix[3];
					    u_xlat6.xyz = u_xlat3.xyz / u_xlat3.www;
					    u_xlat3.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat6.xyz = u_xlat6.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat6.yyy * hlslcc_mtx4x4_InverseViewMatrix[1].xyz;
					    u_xlat3.xyz = hlslcc_mtx4x4_InverseViewMatrix[0].xyz * u_xlat6.xxx + u_xlat3.xyz;
					    u_xlat6.xyz = hlslcc_mtx4x4_InverseViewMatrix[2].xyz * u_xlat6.zzz + u_xlat3.xyz;
					    u_xlat3.x = (-u_xlat2.w) + 1.0;
					    u_xlat3.x = u_xlat3.x * u_xlat3.x;
					    u_xlat8 = _Params.w + -1.0;
					    u_xlat8 = u_xlat3.x * u_xlat8 + 1.0;
					    u_xlat4 = textureLod(_Resolve, vs_TEXCOORD1.xy, u_xlat8);
					    u_xlat8 = dot((-u_xlat6.xyz), u_xlat0.xyz);
					    u_xlat13 = u_xlat8 + u_xlat8;
					    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat13)) + (-u_xlat6.xyz);
					    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
					    u_xlat0.x = dot((-u_xlat6.xyz), u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = max(u_xlat3.x, 0.00200000009);
					    u_xlat5.x = u_xlat5.x * u_xlat5.x + 1.0;
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat10 = (-u_xlat15) + u_xlat2.w;
					    u_xlat10 = u_xlat10 + 1.0;
					    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat4.xyz * u_xlat5.xxx;
					    u_xlat5.x = -abs(u_xlat8) + 1.0;
					    u_xlat15 = u_xlat5.x * u_xlat5.x;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat5.x = u_xlat5.x * u_xlat15;
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(u_xlat10);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = texture(_CameraReflectionsTexture, vs_TEXCOORD1.xy).xyz;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat17 = u_xlat4.w * u_xlat4.w;
					    u_xlat4.x = u_xlat17 * 3.0;
					    u_xlat17 = u_xlat17 * 3.0 + -0.5;
					    u_xlat17 = u_xlat17 + u_xlat17;
					    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
					    u_xlat9 = u_xlat17 * -2.0 + 3.0;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat17 = u_xlat17 * u_xlat9;
					    u_xlat17 = u_xlat17 * u_xlat4.x;
					    u_xlat17 = u_xlat17 * _Params.y;
					    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
					    u_xlat17 = (-u_xlat17) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat17;
					    u_xlat5.xyz = u_xlat6.xyz * u_xlat5.xyz + (-u_xlat2.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat1) + u_xlat3.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 59
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Vertex %4 "main" %13 %18 %47 %50 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpMemberDecorate %11 0 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 1 BuiltIn TessLevelOuter 
					                                             OpMemberDecorate %11 2 BuiltIn TessLevelOuter 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %18 Location 18 
					                                             OpDecorate vs_TEXCOORD0 Location 47 
					                                             OpDecorate vs_TEXCOORD1 Location 50 
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
					                                     %32 = OpTypePointer Private %7 
					                      Private f32_4* %33 = OpVariable Private 
					                               f32_4 %36 = OpConstantComposite %27 %27 %27 %27 
					                      Private f32_4* %38 = OpVariable Private 
					                                 f32 %40 = OpConstant 3,674022E-40 
					                                 f32 %41 = OpConstant 3,674022E-40 
					                               f32_4 %42 = OpConstantComposite %40 %41 %40 %41 
					                               f32_4 %44 = OpConstantComposite %26 %27 %26 %27 
					                                     %46 = OpTypePointer Output %19 
					              Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					              Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                     %53 = OpTypePointer Output %6 
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
					                               f32_4 %35 = OpVectorShuffle %34 %34 0 1 0 1 
					                               f32_4 %37 = OpFAdd %35 %36 
					                                             OpStore %33 %37 
					                               f32_4 %39 = OpLoad %33 
					                               f32_4 %43 = OpFMul %39 %42 
					                               f32_4 %45 = OpFAdd %43 %44 
					                                             OpStore %38 %45 
					                               f32_4 %48 = OpLoad %38 
					                               f32_2 %49 = OpVectorShuffle %48 %48 0 1 
					                                             OpStore vs_TEXCOORD0 %49 
					                               f32_4 %51 = OpLoad %38 
					                               f32_2 %52 = OpVectorShuffle %51 %51 2 3 
					                                             OpStore vs_TEXCOORD1 %52 
					                         Output f32* %54 = OpAccessChain %13 %15 %9 
					                                 f32 %55 = OpLoad %54 
					                                 f32 %56 = OpFNegate %55 
					                         Output f32* %57 = OpAccessChain %13 %15 %9 
					                                             OpStore %57 %56 
					                                             OpReturn
					                                             OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 496
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %11 %40 %82 %171 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %11 BuiltIn TessLevelOuter 
					                                                      OpDecorate %30 DescriptorSet 30 
					                                                      OpDecorate %30 Binding 30 
					                                                      OpDecorate %34 DescriptorSet 34 
					                                                      OpDecorate %34 Binding 34 
					                                                      OpDecorate vs_TEXCOORD1 Location 40 
					                                                      OpDecorate %49 ArrayStride 49 
					                                                      OpDecorate %50 ArrayStride 50 
					                                                      OpMemberDecorate %51 0 Offset 51 
					                                                      OpMemberDecorate %51 1 Offset 51 
					                                                      OpMemberDecorate %51 2 Offset 51 
					                                                      OpMemberDecorate %51 3 Offset 51 
					                                                      OpDecorate %51 Block 
					                                                      OpDecorate %53 DescriptorSet 53 
					                                                      OpDecorate %53 Binding 53 
					                                                      OpDecorate %82 Location 82 
					                                                      OpDecorate %83 DescriptorSet 83 
					                                                      OpDecorate %83 Binding 83 
					                                                      OpDecorate %85 DescriptorSet 85 
					                                                      OpDecorate %85 Binding 85 
					                                                      OpDecorate %107 DescriptorSet 107 
					                                                      OpDecorate %107 Binding 107 
					                                                      OpDecorate %122 DescriptorSet 122 
					                                                      OpDecorate %122 Binding 122 
					                                                      OpDecorate %134 DescriptorSet 134 
					                                                      OpDecorate %134 Binding 134 
					                                                      OpDecorate vs_TEXCOORD0 Location 171 
					                                                      OpDecorate %277 DescriptorSet 277 
					                                                      OpDecorate %277 Binding 277 
					                                                      OpDecorate %279 DescriptorSet 279 
					                                                      OpDecorate %279 Binding 279 
					                                                      OpDecorate %391 DescriptorSet 391 
					                                                      OpDecorate %391 Binding 391 
					                                                      OpDecorate %393 DescriptorSet 393 
					                                                      OpDecorate %393 Binding 393 
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
					                                              %26 = OpTypePointer Private %12 
					                               Private f32_3* %27 = OpVariable Private 
					                                              %28 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %29 = OpTypePointer UniformConstant %28 
					         UniformConstant read_only Texture2D* %30 = OpVariable UniformConstant 
					                                              %32 = OpTypeSampler 
					                                              %33 = OpTypePointer UniformConstant %32 
					                     UniformConstant sampler* %34 = OpVariable UniformConstant 
					                                              %36 = OpTypeSampledImage %28 
					                                              %38 = OpTypeVector %6 2 
					                                              %39 = OpTypePointer Input %38 
					                        Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                          f32 %42 = OpConstant 3,674022E-40 
					                                          u32 %44 = OpConstant 0 
					                                              %46 = OpTypePointer Private %6 
					                                          u32 %48 = OpConstant 4 
					                                              %49 = OpTypeArray %7 %48 
					                                              %50 = OpTypeArray %7 %48 
					                                              %51 = OpTypeStruct %7 %49 %50 %7 
					                                              %52 = OpTypePointer Uniform %51 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4;}* %53 = OpVariable Uniform 
					                                              %54 = OpTypeInt 32 1 
					                                          i32 %55 = OpConstant 0 
					                                              %56 = OpTypePointer Uniform %6 
					                                          u32 %62 = OpConstant 1 
					                                              %71 = OpTypeBool 
					                                              %72 = OpTypePointer Private %71 
					                                Private bool* %73 = OpVariable Private 
					                                          f32 %74 = OpConstant 3,674022E-40 
					                                              %81 = OpTypePointer Output %7 
					                                Output f32_4* %82 = OpVariable Output 
					         UniformConstant read_only Texture2D* %83 = OpVariable UniformConstant 
					                     UniformConstant sampler* %85 = OpVariable UniformConstant 
					                                              %91 = OpTypeVector %16 4 
					                                              %92 = OpTypePointer Private %91 
					                               Private u32_4* %93 = OpVariable Private 
					                                              %96 = OpTypeVector %54 2 
					                                              %98 = OpTypeVector %16 2 
					                                         u32 %102 = OpConstant 2 
					                                             %103 = OpTypePointer Private %16 
					                                Private f32* %106 = OpVariable Private 
					        UniformConstant read_only Texture2D* %107 = OpVariable UniformConstant 
					                                             %120 = OpTypePointer Private %7 
					                              Private f32_4* %121 = OpVariable Private 
					        UniformConstant read_only Texture2D* %122 = OpVariable UniformConstant 
					        UniformConstant read_only Texture2D* %134 = OpVariable UniformConstant 
					                                Private f32* %147 = OpVariable Private 
					                                         f32 %161 = OpConstant 3,674022E-40 
					                                       f32_3 %162 = OpConstantComposite %161 %161 %161 
					                                         f32 %164 = OpConstant 3,674022E-40 
					                                       f32_3 %165 = OpConstantComposite %164 %164 %164 
					                              Private f32_3* %167 = OpVariable Private 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                             %176 = OpTypePointer Private %38 
					                              Private f32_2* %177 = OpVariable Private 
					                                       f32_2 %179 = OpConstantComposite %161 %161 
					                                       f32_2 %181 = OpConstantComposite %164 %164 
					                              Private f32_4* %183 = OpVariable Private 
					                                         i32 %186 = OpConstant 2 
					                                         i32 %187 = OpConstant 1 
					                                             %188 = OpTypePointer Uniform %7 
					                                         i32 %207 = OpConstant 3 
					                                Private f32* %267 = OpVariable Private 
					                              Private f32_4* %276 = OpVariable Private 
					        UniformConstant read_only Texture2D* %277 = OpVariable UniformConstant 
					                    UniformConstant sampler* %279 = OpVariable UniformConstant 
					                                Private f32* %289 = OpVariable Private 
					                              Private f32_3* %325 = OpVariable Private 
					                                         f32 %328 = OpConstant 3,674022E-40 
					                                Private f32* %342 = OpVariable Private 
					        UniformConstant read_only Texture2D* %391 = OpVariable UniformConstant 
					                    UniformConstant sampler* %393 = OpVariable UniformConstant 
					                                       f32_3 %416 = OpConstantComposite %42 %42 %42 
					                                Private f32* %420 = OpVariable Private 
					                                         f32 %427 = OpConstant 3,674022E-40 
					                                         f32 %432 = OpConstant 3,674022E-40 
					                                Private f32* %439 = OpVariable Private 
					                                         f32 %441 = OpConstant 3,674022E-40 
					                                             %493 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                               Function f32_4* %9 = OpVariable Function 
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
					                          read_only Texture2D %31 = OpLoad %30 
					                                      sampler %35 = OpLoad %34 
					                   read_only Texture2DSampled %37 = OpSampledImage %31 %35 
					                                        f32_2 %41 = OpLoad vs_TEXCOORD1 
					                                        f32_4 %43 = OpImageSampleExplicitLod %37 %41 Lod %7 
					                                          f32 %45 = OpCompositeExtract %43 0 
					                                 Private f32* %47 = OpAccessChain %27 %44 
					                                                      OpStore %47 %45 
					                                 Uniform f32* %57 = OpAccessChain %53 %55 %44 
					                                          f32 %58 = OpLoad %57 
					                                 Private f32* %59 = OpAccessChain %27 %44 
					                                          f32 %60 = OpLoad %59 
					                                          f32 %61 = OpFMul %58 %60 
					                                 Uniform f32* %63 = OpAccessChain %53 %55 %62 
					                                          f32 %64 = OpLoad %63 
					                                          f32 %65 = OpFAdd %61 %64 
					                                 Private f32* %66 = OpAccessChain %27 %44 
					                                                      OpStore %66 %65 
					                                 Private f32* %67 = OpAccessChain %27 %44 
					                                          f32 %68 = OpLoad %67 
					                                          f32 %69 = OpFDiv %15 %68 
					                                 Private f32* %70 = OpAccessChain %27 %44 
					                                                      OpStore %70 %69 
					                                 Private f32* %75 = OpAccessChain %27 %44 
					                                          f32 %76 = OpLoad %75 
					                                         bool %77 = OpFOrdLessThan %74 %76 
					                                                      OpStore %73 %77 
					                                         bool %78 = OpLoad %73 
					                                                      OpSelectionMerge %80 None 
					                                                      OpBranchConditional %78 %79 %80 
					                                              %79 = OpLabel 
					                          read_only Texture2D %84 = OpLoad %83 
					                                      sampler %86 = OpLoad %85 
					                   read_only Texture2DSampled %87 = OpSampledImage %84 %86 
					                                        f32_2 %88 = OpLoad vs_TEXCOORD1 
					                                        f32_4 %89 = OpImageSampleImplicitLod %87 %88 
					                                                      OpStore %82 %89 
					                                                      OpReturn
					                                              %80 = OpLabel 
					                                        f32_4 %94 = OpLoad %9 
					                                        f32_2 %95 = OpVectorShuffle %94 %94 0 1 
					                                        i32_2 %97 = OpConvertFToS %95 
					                                        u32_2 %99 = OpBitcast %97 
					                                       u32_4 %100 = OpLoad %93 
					                                       u32_4 %101 = OpVectorShuffle %100 %99 4 5 2 3 
					                                                      OpStore %93 %101 
					                                Private u32* %104 = OpAccessChain %93 %102 
					                                                      OpStore %104 %44 
					                                Private u32* %105 = OpAccessChain %93 %17 
					                                                      OpStore %105 %44 
					                         read_only Texture2D %108 = OpLoad %107 
					                                     sampler %109 = OpLoad %85 
					                  read_only Texture2DSampled %110 = OpSampledImage %108 %109 
					                                       u32_4 %111 = OpLoad %93 
					                                       u32_2 %112 = OpVectorShuffle %111 %111 0 1 
					                                       i32_2 %113 = OpBitcast %112 
					                                Private u32* %114 = OpAccessChain %93 %17 
					                                         u32 %115 = OpLoad %114 
					                                         i32 %116 = OpBitcast %115 
					                         read_only Texture2D %117 = OpImage %110 
					                                       f32_4 %118 = OpImageFetch %117 %113 Lod %7 
					                                         f32 %119 = OpCompositeExtract %118 3 
					                                                      OpStore %106 %119 
					                         read_only Texture2D %123 = OpLoad %122 
					                                     sampler %124 = OpLoad %85 
					                  read_only Texture2DSampled %125 = OpSampledImage %123 %124 
					                                       u32_4 %126 = OpLoad %93 
					                                       u32_2 %127 = OpVectorShuffle %126 %126 0 1 
					                                       i32_2 %128 = OpBitcast %127 
					                                Private u32* %129 = OpAccessChain %93 %17 
					                                         u32 %130 = OpLoad %129 
					                                         i32 %131 = OpBitcast %130 
					                         read_only Texture2D %132 = OpImage %125 
					                                       f32_4 %133 = OpImageFetch %132 %128 Lod %7 
					                                                      OpStore %121 %133 
					                         read_only Texture2D %135 = OpLoad %134 
					                                     sampler %136 = OpLoad %85 
					                  read_only Texture2DSampled %137 = OpSampledImage %135 %136 
					                                       u32_4 %138 = OpLoad %93 
					                                       u32_2 %139 = OpVectorShuffle %138 %138 0 1 
					                                       i32_2 %140 = OpBitcast %139 
					                                Private u32* %141 = OpAccessChain %93 %17 
					                                         u32 %142 = OpLoad %141 
					                                         i32 %143 = OpBitcast %142 
					                         read_only Texture2D %144 = OpImage %137 
					                                       f32_4 %145 = OpImageFetch %144 %140 Lod %7 
					                                       f32_3 %146 = OpVectorShuffle %145 %145 0 1 2 
					                                                      OpStore %27 %146 
					                                Private f32* %148 = OpAccessChain %121 %62 
					                                         f32 %149 = OpLoad %148 
					                                Private f32* %150 = OpAccessChain %121 %44 
					                                         f32 %151 = OpLoad %150 
					                                         f32 %152 = OpExtInst %1 40 %149 %151 
					                                                      OpStore %147 %152 
					                                Private f32* %153 = OpAccessChain %121 %102 
					                                         f32 %154 = OpLoad %153 
					                                         f32 %155 = OpLoad %147 
					                                         f32 %156 = OpExtInst %1 40 %154 %155 
					                                                      OpStore %147 %156 
					                                         f32 %157 = OpLoad %147 
					                                         f32 %158 = OpFNegate %157 
					                                         f32 %159 = OpFAdd %158 %15 
					                                                      OpStore %147 %159 
					                                       f32_3 %160 = OpLoad %27 
					                                       f32_3 %163 = OpFMul %160 %162 
					                                       f32_3 %166 = OpFAdd %163 %165 
					                                                      OpStore %27 %166 
					                         read_only Texture2D %168 = OpLoad %30 
					                                     sampler %169 = OpLoad %34 
					                  read_only Texture2DSampled %170 = OpSampledImage %168 %169 
					                                       f32_2 %172 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %173 = OpImageSampleExplicitLod %170 %172 Lod %7 
					                                         f32 %174 = OpCompositeExtract %173 0 
					                                Private f32* %175 = OpAccessChain %167 %44 
					                                                      OpStore %175 %174 
					                                       f32_2 %178 = OpLoad vs_TEXCOORD0 
					                                       f32_2 %180 = OpFMul %178 %179 
					                                       f32_2 %182 = OpFAdd %180 %181 
					                                                      OpStore %177 %182 
					                                       f32_2 %184 = OpLoad %177 
					                                       f32_4 %185 = OpVectorShuffle %184 %184 1 1 1 1 
					                              Uniform f32_4* %189 = OpAccessChain %53 %186 %187 
					                                       f32_4 %190 = OpLoad %189 
					                                       f32_4 %191 = OpFMul %185 %190 
					                                                      OpStore %183 %191 
					                              Uniform f32_4* %192 = OpAccessChain %53 %186 %55 
					                                       f32_4 %193 = OpLoad %192 
					                                       f32_2 %194 = OpLoad %177 
					                                       f32_4 %195 = OpVectorShuffle %194 %194 0 0 0 0 
					                                       f32_4 %196 = OpFMul %193 %195 
					                                       f32_4 %197 = OpLoad %183 
					                                       f32_4 %198 = OpFAdd %196 %197 
					                                                      OpStore %183 %198 
					                              Uniform f32_4* %199 = OpAccessChain %53 %186 %186 
					                                       f32_4 %200 = OpLoad %199 
					                                       f32_3 %201 = OpLoad %167 
					                                       f32_4 %202 = OpVectorShuffle %201 %201 0 0 0 0 
					                                       f32_4 %203 = OpFMul %200 %202 
					                                       f32_4 %204 = OpLoad %183 
					                                       f32_4 %205 = OpFAdd %203 %204 
					                                                      OpStore %183 %205 
					                                       f32_4 %206 = OpLoad %183 
					                              Uniform f32_4* %208 = OpAccessChain %53 %186 %207 
					                                       f32_4 %209 = OpLoad %208 
					                                       f32_4 %210 = OpFAdd %206 %209 
					                                                      OpStore %183 %210 
					                                       f32_4 %211 = OpLoad %183 
					                                       f32_3 %212 = OpVectorShuffle %211 %211 0 1 2 
					                                       f32_4 %213 = OpLoad %183 
					                                       f32_3 %214 = OpVectorShuffle %213 %213 3 3 3 
					                                       f32_3 %215 = OpFDiv %212 %214 
					                                                      OpStore %167 %215 
					                                       f32_3 %216 = OpLoad %167 
					                                       f32_3 %217 = OpLoad %167 
					                                         f32 %218 = OpDot %216 %217 
					                                Private f32* %219 = OpAccessChain %183 %44 
					                                                      OpStore %219 %218 
					                                Private f32* %220 = OpAccessChain %183 %44 
					                                         f32 %221 = OpLoad %220 
					                                         f32 %222 = OpExtInst %1 32 %221 
					                                Private f32* %223 = OpAccessChain %183 %44 
					                                                      OpStore %223 %222 
					                                       f32_3 %224 = OpLoad %167 
					                                       f32_4 %225 = OpLoad %183 
					                                       f32_3 %226 = OpVectorShuffle %225 %225 0 0 0 
					                                       f32_3 %227 = OpFMul %224 %226 
					                                                      OpStore %167 %227 
					                                       f32_3 %228 = OpLoad %167 
					                                       f32_3 %229 = OpVectorShuffle %228 %228 1 1 1 
					                              Uniform f32_4* %230 = OpAccessChain %53 %187 %187 
					                                       f32_4 %231 = OpLoad %230 
					                                       f32_3 %232 = OpVectorShuffle %231 %231 0 1 2 
					                                       f32_3 %233 = OpFMul %229 %232 
					                                       f32_4 %234 = OpLoad %183 
					                                       f32_4 %235 = OpVectorShuffle %234 %233 4 5 6 3 
					                                                      OpStore %183 %235 
					                              Uniform f32_4* %236 = OpAccessChain %53 %187 %55 
					                                       f32_4 %237 = OpLoad %236 
					                                       f32_3 %238 = OpVectorShuffle %237 %237 0 1 2 
					                                       f32_3 %239 = OpLoad %167 
					                                       f32_3 %240 = OpVectorShuffle %239 %239 0 0 0 
					                                       f32_3 %241 = OpFMul %238 %240 
					                                       f32_4 %242 = OpLoad %183 
					                                       f32_3 %243 = OpVectorShuffle %242 %242 0 1 2 
					                                       f32_3 %244 = OpFAdd %241 %243 
					                                       f32_4 %245 = OpLoad %183 
					                                       f32_4 %246 = OpVectorShuffle %245 %244 4 5 6 3 
					                                                      OpStore %183 %246 
					                              Uniform f32_4* %247 = OpAccessChain %53 %187 %186 
					                                       f32_4 %248 = OpLoad %247 
					                                       f32_3 %249 = OpVectorShuffle %248 %248 0 1 2 
					                                       f32_3 %250 = OpLoad %167 
					                                       f32_3 %251 = OpVectorShuffle %250 %250 2 2 2 
					                                       f32_3 %252 = OpFMul %249 %251 
					                                       f32_4 %253 = OpLoad %183 
					                                       f32_3 %254 = OpVectorShuffle %253 %253 0 1 2 
					                                       f32_3 %255 = OpFAdd %252 %254 
					                                                      OpStore %167 %255 
					                                Private f32* %256 = OpAccessChain %121 %17 
					                                         f32 %257 = OpLoad %256 
					                                         f32 %258 = OpFNegate %257 
					                                         f32 %259 = OpFAdd %258 %15 
					                                Private f32* %260 = OpAccessChain %183 %44 
					                                                      OpStore %260 %259 
					                                Private f32* %261 = OpAccessChain %183 %44 
					                                         f32 %262 = OpLoad %261 
					                                Private f32* %263 = OpAccessChain %183 %44 
					                                         f32 %264 = OpLoad %263 
					                                         f32 %265 = OpFMul %262 %264 
					                                Private f32* %266 = OpAccessChain %183 %44 
					                                                      OpStore %266 %265 
					                                Uniform f32* %268 = OpAccessChain %53 %207 %17 
					                                         f32 %269 = OpLoad %268 
					                                         f32 %270 = OpFAdd %269 %164 
					                                                      OpStore %267 %270 
					                                Private f32* %271 = OpAccessChain %183 %44 
					                                         f32 %272 = OpLoad %271 
					                                         f32 %273 = OpLoad %267 
					                                         f32 %274 = OpFMul %272 %273 
					                                         f32 %275 = OpFAdd %274 %15 
					                                                      OpStore %267 %275 
					                         read_only Texture2D %278 = OpLoad %277 
					                                     sampler %280 = OpLoad %279 
					                  read_only Texture2DSampled %281 = OpSampledImage %278 %280 
					                                       f32_2 %282 = OpLoad vs_TEXCOORD1 
					                                         f32 %283 = OpLoad %267 
					                                       f32_4 %284 = OpImageSampleExplicitLod %281 %282 Lod %7 
					                                                      OpStore %276 %284 
					                                       f32_3 %285 = OpLoad %167 
					                                       f32_3 %286 = OpFNegate %285 
					                                       f32_3 %287 = OpLoad %27 
					                                         f32 %288 = OpDot %286 %287 
					                                                      OpStore %267 %288 
					                                         f32 %290 = OpLoad %267 
					                                         f32 %291 = OpLoad %267 
					                                         f32 %292 = OpFAdd %290 %291 
					                                                      OpStore %289 %292 
					                                       f32_3 %293 = OpLoad %27 
					                                         f32 %294 = OpLoad %289 
					                                       f32_3 %295 = OpCompositeConstruct %294 %294 %294 
					                                       f32_3 %296 = OpFNegate %295 
					                                       f32_3 %297 = OpFMul %293 %296 
					                                       f32_3 %298 = OpLoad %167 
					                                       f32_3 %299 = OpFNegate %298 
					                                       f32_3 %300 = OpFAdd %297 %299 
					                                                      OpStore %27 %300 
					                                       f32_3 %301 = OpLoad %27 
					                                       f32_3 %302 = OpLoad %27 
					                                         f32 %303 = OpDot %301 %302 
					                                                      OpStore %289 %303 
					                                         f32 %304 = OpLoad %289 
					                                         f32 %305 = OpExtInst %1 32 %304 
					                                                      OpStore %289 %305 
					                                       f32_3 %306 = OpLoad %27 
					                                         f32 %307 = OpLoad %289 
					                                       f32_3 %308 = OpCompositeConstruct %307 %307 %307 
					                                       f32_3 %309 = OpFMul %306 %308 
					                                                      OpStore %27 %309 
					                                       f32_3 %310 = OpLoad %167 
					                                       f32_3 %311 = OpFNegate %310 
					                                       f32_3 %312 = OpLoad %27 
					                                         f32 %313 = OpDot %311 %312 
					                                Private f32* %314 = OpAccessChain %27 %44 
					                                                      OpStore %314 %313 
					                                Private f32* %315 = OpAccessChain %27 %44 
					                                         f32 %316 = OpLoad %315 
					                                Private f32* %317 = OpAccessChain %27 %44 
					                                         f32 %318 = OpLoad %317 
					                                         f32 %319 = OpFAdd %316 %318 
					                                Private f32* %320 = OpAccessChain %27 %44 
					                                                      OpStore %320 %319 
					                                Private f32* %321 = OpAccessChain %27 %44 
					                                         f32 %322 = OpLoad %321 
					                                         f32 %323 = OpExtInst %1 43 %322 %42 %15 
					                                Private f32* %324 = OpAccessChain %27 %44 
					                                                      OpStore %324 %323 
					                                Private f32* %326 = OpAccessChain %183 %44 
					                                         f32 %327 = OpLoad %326 
					                                         f32 %329 = OpExtInst %1 40 %327 %328 
					                                Private f32* %330 = OpAccessChain %325 %44 
					                                                      OpStore %330 %329 
					                                Private f32* %331 = OpAccessChain %325 %44 
					                                         f32 %332 = OpLoad %331 
					                                Private f32* %333 = OpAccessChain %325 %44 
					                                         f32 %334 = OpLoad %333 
					                                         f32 %335 = OpFMul %332 %334 
					                                         f32 %336 = OpFAdd %335 %15 
					                                Private f32* %337 = OpAccessChain %325 %44 
					                                                      OpStore %337 %336 
					                                Private f32* %338 = OpAccessChain %325 %44 
					                                         f32 %339 = OpLoad %338 
					                                         f32 %340 = OpFDiv %15 %339 
					                                Private f32* %341 = OpAccessChain %325 %44 
					                                                      OpStore %341 %340 
					                                         f32 %343 = OpLoad %147 
					                                         f32 %344 = OpFNegate %343 
					                                Private f32* %345 = OpAccessChain %121 %17 
					                                         f32 %346 = OpLoad %345 
					                                         f32 %347 = OpFAdd %344 %346 
					                                                      OpStore %342 %347 
					                                         f32 %348 = OpLoad %342 
					                                         f32 %349 = OpFAdd %348 %15 
					                                                      OpStore %342 %349 
					                                         f32 %350 = OpLoad %342 
					                                         f32 %351 = OpExtInst %1 43 %350 %42 %15 
					                                                      OpStore %342 %351 
					                                       f32_4 %352 = OpLoad %276 
					                                       f32_3 %353 = OpVectorShuffle %352 %352 0 1 2 
					                                       f32_3 %354 = OpLoad %325 
					                                       f32_3 %355 = OpVectorShuffle %354 %354 0 0 0 
					                                       f32_3 %356 = OpFMul %353 %355 
					                                                      OpStore %167 %356 
					                                         f32 %357 = OpLoad %267 
					                                         f32 %358 = OpExtInst %1 4 %357 
					                                         f32 %359 = OpFNegate %358 
					                                         f32 %360 = OpFAdd %359 %15 
					                                Private f32* %361 = OpAccessChain %325 %44 
					                                                      OpStore %361 %360 
					                                Private f32* %362 = OpAccessChain %325 %44 
					                                         f32 %363 = OpLoad %362 
					                                Private f32* %364 = OpAccessChain %325 %44 
					                                         f32 %365 = OpLoad %364 
					                                         f32 %366 = OpFMul %363 %365 
					                                                      OpStore %147 %366 
					                                         f32 %367 = OpLoad %147 
					                                         f32 %368 = OpLoad %147 
					                                         f32 %369 = OpFMul %367 %368 
					                                                      OpStore %147 %369 
					                                Private f32* %370 = OpAccessChain %325 %44 
					                                         f32 %371 = OpLoad %370 
					                                         f32 %372 = OpLoad %147 
					                                         f32 %373 = OpFMul %371 %372 
					                                Private f32* %374 = OpAccessChain %325 %44 
					                                                      OpStore %374 %373 
					                                       f32_4 %375 = OpLoad %121 
					                                       f32_3 %376 = OpVectorShuffle %375 %375 0 1 2 
					                                       f32_3 %377 = OpFNegate %376 
					                                         f32 %378 = OpLoad %342 
					                                       f32_3 %379 = OpCompositeConstruct %378 %378 %378 
					                                       f32_3 %380 = OpFAdd %377 %379 
					                                       f32_4 %381 = OpLoad %183 
					                                       f32_4 %382 = OpVectorShuffle %381 %380 4 5 6 3 
					                                                      OpStore %183 %382 
					                                       f32_3 %383 = OpLoad %325 
					                                       f32_3 %384 = OpVectorShuffle %383 %383 0 0 0 
					                                       f32_4 %385 = OpLoad %183 
					                                       f32_3 %386 = OpVectorShuffle %385 %385 0 1 2 
					                                       f32_3 %387 = OpFMul %384 %386 
					                                       f32_4 %388 = OpLoad %121 
					                                       f32_3 %389 = OpVectorShuffle %388 %388 0 1 2 
					                                       f32_3 %390 = OpFAdd %387 %389 
					                                                      OpStore %325 %390 
					                         read_only Texture2D %392 = OpLoad %391 
					                                     sampler %394 = OpLoad %393 
					                  read_only Texture2DSampled %395 = OpSampledImage %392 %394 
					                                       f32_2 %396 = OpLoad vs_TEXCOORD1 
					                                       f32_4 %397 = OpImageSampleImplicitLod %395 %396 
					                                       f32_3 %398 = OpVectorShuffle %397 %397 0 1 2 
					                                       f32_4 %399 = OpLoad %121 
					                                       f32_4 %400 = OpVectorShuffle %399 %398 4 5 6 3 
					                                                      OpStore %121 %400 
					                         read_only Texture2D %401 = OpLoad %83 
					                                     sampler %402 = OpLoad %85 
					                  read_only Texture2DSampled %403 = OpSampledImage %401 %402 
					                                       f32_2 %404 = OpLoad vs_TEXCOORD1 
					                                       f32_4 %405 = OpImageSampleImplicitLod %403 %404 
					                                                      OpStore %183 %405 
					                                       f32_4 %406 = OpLoad %121 
					                                       f32_3 %407 = OpVectorShuffle %406 %406 0 1 2 
					                                       f32_3 %408 = OpFNegate %407 
					                                       f32_4 %409 = OpLoad %183 
					                                       f32_3 %410 = OpVectorShuffle %409 %409 0 1 2 
					                                       f32_3 %411 = OpFAdd %408 %410 
					                                       f32_4 %412 = OpLoad %183 
					                                       f32_4 %413 = OpVectorShuffle %412 %411 4 5 6 3 
					                                                      OpStore %183 %413 
					                                       f32_4 %414 = OpLoad %183 
					                                       f32_3 %415 = OpVectorShuffle %414 %414 0 1 2 
					                                       f32_3 %417 = OpExtInst %1 40 %415 %416 
					                                       f32_4 %418 = OpLoad %183 
					                                       f32_4 %419 = OpVectorShuffle %418 %417 4 5 6 3 
					                                                      OpStore %183 %419 
					                                Private f32* %421 = OpAccessChain %276 %17 
					                                         f32 %422 = OpLoad %421 
					                                Private f32* %423 = OpAccessChain %276 %17 
					                                         f32 %424 = OpLoad %423 
					                                         f32 %425 = OpFMul %422 %424 
					                                                      OpStore %420 %425 
					                                         f32 %426 = OpLoad %420 
					                                         f32 %428 = OpFMul %426 %427 
					                                Private f32* %429 = OpAccessChain %276 %44 
					                                                      OpStore %429 %428 
					                                         f32 %430 = OpLoad %420 
					                                         f32 %431 = OpFMul %430 %427 
					                                         f32 %433 = OpFAdd %431 %432 
					                                                      OpStore %420 %433 
					                                         f32 %434 = OpLoad %420 
					                                         f32 %435 = OpLoad %420 
					                                         f32 %436 = OpFAdd %434 %435 
					                                                      OpStore %420 %436 
					                                         f32 %437 = OpLoad %420 
					                                         f32 %438 = OpExtInst %1 43 %437 %42 %15 
					                                                      OpStore %420 %438 
					                                         f32 %440 = OpLoad %420 
					                                         f32 %442 = OpFMul %440 %441 
					                                         f32 %443 = OpFAdd %442 %427 
					                                                      OpStore %439 %443 
					                                         f32 %444 = OpLoad %420 
					                                         f32 %445 = OpLoad %420 
					                                         f32 %446 = OpFMul %444 %445 
					                                                      OpStore %420 %446 
					                                         f32 %447 = OpLoad %420 
					                                         f32 %448 = OpLoad %439 
					                                         f32 %449 = OpFMul %447 %448 
					                                                      OpStore %420 %449 
					                                         f32 %450 = OpLoad %420 
					                                Private f32* %451 = OpAccessChain %276 %44 
					                                         f32 %452 = OpLoad %451 
					                                         f32 %453 = OpFMul %450 %452 
					                                                      OpStore %420 %453 
					                                         f32 %454 = OpLoad %420 
					                                Uniform f32* %455 = OpAccessChain %53 %207 %62 
					                                         f32 %456 = OpLoad %455 
					                                         f32 %457 = OpFMul %454 %456 
					                                                      OpStore %420 %457 
					                                         f32 %458 = OpLoad %420 
					                                         f32 %459 = OpExtInst %1 43 %458 %42 %15 
					                                                      OpStore %420 %459 
					                                         f32 %460 = OpLoad %420 
					                                         f32 %461 = OpFNegate %460 
					                                         f32 %462 = OpFAdd %461 %15 
					                                                      OpStore %420 %462 
					                                Private f32* %463 = OpAccessChain %27 %44 
					                                         f32 %464 = OpLoad %463 
					                                         f32 %465 = OpLoad %420 
					                                         f32 %466 = OpFMul %464 %465 
					                                Private f32* %467 = OpAccessChain %27 %44 
					                                                      OpStore %467 %466 
					                                       f32_3 %468 = OpLoad %167 
					                                       f32_3 %469 = OpLoad %325 
					                                       f32_3 %470 = OpFMul %468 %469 
					                                       f32_4 %471 = OpLoad %121 
					                                       f32_3 %472 = OpVectorShuffle %471 %471 0 1 2 
					                                       f32_3 %473 = OpFNegate %472 
					                                       f32_3 %474 = OpFAdd %470 %473 
					                                                      OpStore %325 %474 
					                                       f32_3 %475 = OpLoad %27 
					                                       f32_3 %476 = OpVectorShuffle %475 %475 0 0 0 
					                                       f32_3 %477 = OpLoad %325 
					                                       f32_3 %478 = OpFMul %476 %477 
					                                       f32_4 %479 = OpLoad %121 
					                                       f32_3 %480 = OpVectorShuffle %479 %479 0 1 2 
					                                       f32_3 %481 = OpFAdd %478 %480 
					                                                      OpStore %27 %481 
					                                       f32_3 %482 = OpLoad %27 
					                                         f32 %483 = OpLoad %106 
					                                       f32_3 %484 = OpCompositeConstruct %483 %483 %483 
					                                       f32_3 %485 = OpFMul %482 %484 
					                                       f32_4 %486 = OpLoad %183 
					                                       f32_3 %487 = OpVectorShuffle %486 %486 0 1 2 
					                                       f32_3 %488 = OpFAdd %485 %487 
					                                       f32_4 %489 = OpLoad %82 
					                                       f32_4 %490 = OpVectorShuffle %489 %488 4 5 6 3 
					                                                      OpStore %82 %490 
					                                Private f32* %491 = OpAccessChain %183 %17 
					                                         f32 %492 = OpLoad %491 
					                                 Output f32* %494 = OpAccessChain %82 %17 
					                                                      OpStore %494 %492 
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
						vec4 unused_0_0[10];
						mat4x4 _InverseViewMatrix;
						mat4x4 _InverseProjectionMatrix;
						vec4 unused_0_3[4];
						vec4 _Params;
						vec4 unused_0_5;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[7];
						vec4 _ZBufferParams;
						vec4 unused_1_2;
					};
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CameraDepthTexture;
					UNITY_LOCATION(2) uniform  sampler2D _CameraReflectionsTexture;
					UNITY_LOCATION(3) uniform  sampler2D _CameraGBufferTexture0;
					UNITY_LOCATION(4) uniform  sampler2D _CameraGBufferTexture1;
					UNITY_LOCATION(5) uniform  sampler2D _CameraGBufferTexture2;
					UNITY_LOCATION(6) uniform  sampler2D _Resolve;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					uvec4 u_xlatu0;
					bool u_xlatb0;
					float u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat8;
					float u_xlat9;
					float u_xlat10;
					vec2 u_xlat11;
					float u_xlat13;
					float u_xlat15;
					float u_xlat17;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.x = textureLod(_CameraDepthTexture, vs_TEXCOORD1.xy, 0.0).x;
					    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlatb0 = 0.999000013<u_xlat0.x;
					    if(u_xlatb0){
					        SV_Target0 = texture(_MainTex, vs_TEXCOORD1.xy);
					        return;
					    }
					    u_xlatu0.xy =  uvec2(ivec2(hlslcc_FragCoord.xy));
					    u_xlatu0.z = uint(0u);
					    u_xlatu0.w = uint(0u);
					    u_xlat1 = texelFetch(_CameraGBufferTexture0, ivec2(u_xlatu0.xy), int(u_xlatu0.w)).w;
					    u_xlat2 = texelFetch(_CameraGBufferTexture1, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
					    u_xlat0.xyz = texelFetch(_CameraGBufferTexture2, ivec2(u_xlatu0.xy), int(u_xlatu0.w)).xyz;
					    u_xlat15 = max(u_xlat2.y, u_xlat2.x);
					    u_xlat15 = max(u_xlat2.z, u_xlat15);
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.x = textureLod(_CameraDepthTexture, vs_TEXCOORD0.xy, 0.0).x;
					    u_xlat11.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3 = u_xlat11.yyyy * _InverseProjectionMatrix[1];
					    u_xlat3 = _InverseProjectionMatrix[0] * u_xlat11.xxxx + u_xlat3;
					    u_xlat3 = _InverseProjectionMatrix[2] * u_xlat6.xxxx + u_xlat3;
					    u_xlat3 = u_xlat3 + _InverseProjectionMatrix[3];
					    u_xlat6.xyz = u_xlat3.xyz / u_xlat3.www;
					    u_xlat3.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat6.xyz = u_xlat6.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat6.yyy * _InverseViewMatrix[1].xyz;
					    u_xlat3.xyz = _InverseViewMatrix[0].xyz * u_xlat6.xxx + u_xlat3.xyz;
					    u_xlat6.xyz = _InverseViewMatrix[2].xyz * u_xlat6.zzz + u_xlat3.xyz;
					    u_xlat3.x = (-u_xlat2.w) + 1.0;
					    u_xlat3.x = u_xlat3.x * u_xlat3.x;
					    u_xlat8 = _Params.w + -1.0;
					    u_xlat8 = u_xlat3.x * u_xlat8 + 1.0;
					    u_xlat4 = textureLod(_Resolve, vs_TEXCOORD1.xy, u_xlat8);
					    u_xlat8 = dot((-u_xlat6.xyz), u_xlat0.xyz);
					    u_xlat13 = u_xlat8 + u_xlat8;
					    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat13)) + (-u_xlat6.xyz);
					    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
					    u_xlat0.x = dot((-u_xlat6.xyz), u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = max(u_xlat3.x, 0.00200000009);
					    u_xlat5.x = u_xlat5.x * u_xlat5.x + 1.0;
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat10 = (-u_xlat15) + u_xlat2.w;
					    u_xlat10 = u_xlat10 + 1.0;
					    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat4.xyz * u_xlat5.xxx;
					    u_xlat5.x = -abs(u_xlat8) + 1.0;
					    u_xlat15 = u_xlat5.x * u_xlat5.x;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat5.x = u_xlat5.x * u_xlat15;
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(u_xlat10);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = texture(_CameraReflectionsTexture, vs_TEXCOORD1.xy).xyz;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat17 = u_xlat4.w * u_xlat4.w;
					    u_xlat4.x = u_xlat17 * 3.0;
					    u_xlat17 = u_xlat17 * 3.0 + -0.5;
					    u_xlat17 = u_xlat17 + u_xlat17;
					    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
					    u_xlat9 = u_xlat17 * -2.0 + 3.0;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat17 = u_xlat17 * u_xlat9;
					    u_xlat17 = u_xlat17 * u_xlat4.x;
					    u_xlat17 = u_xlat17 * _Params.y;
					    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
					    u_xlat17 = (-u_xlat17) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat17;
					    u_xlat5.xyz = u_xlat6.xyz * u_xlat5.xyz + (-u_xlat2.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat1) + u_xlat3.xyz;
					    SV_Target0.w = u_xlat3.w;
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
	}
}