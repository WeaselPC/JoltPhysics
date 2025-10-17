local JOLT_DEFINES = {
  -- precision / determinism
  -- "JPH_DOUBLE_PRECISION",         -- OFF per your config
  -- "JPH_CROSS_PLATFORM_DETERMINISTIC",
  -- allocators / asserts / fp except
  -- "JPH_DISABLE_CUSTOM_ALLOCATOR",
  -- "JPH_DISABLE_TEMP_ALLOCATOR",
  -- no "JPH_ENABLE_ASSERTS"
  -- no "JPH_FLOATING_POINT_EXCEPTIONS_ENABLED"
  -- std::vector switch
  -- no "JPH_USE_STD_VECTOR",
  -- debug renderer always on
  -- "JPH_DEBUG_RENDERER",
  -- object layer bits (if you set it)
  -- "JPH_OBJECT_LAYER_BITS=32",
  -- SIMD feature gates (ONLY add those you enabled for Jolt!)
  -- e.g. "JPH_USE_AVX2", "JPH_USE_SSE4_2"
}

project "Jolt"
    kind "StaticLib"
    language    "C++"
    cppdialect "C++17"
    staticruntime "off"

    targetdir   ("bin/"    .. outputdir .. "/%{prj.name}")
    objdir      ("bin-int/".. outputdir .. "/%{prj.name}")

    files {
        "Jolt/**.h", "Jolt/**.hpp", "Jolt/**.cpp", "Jolt/**.inl"
    }

    includedirs { "./" }

    -- ===== Hardwired feature defines =====
    -- Double precision: OFF
    -- To enable later, uncomment the next line:
    -- defines { "JPH_DOUBLE_PRECISION" }
    -- Floating-point exceptions: OFF (no JPH_FLOATING_POINT_EXCEPTIONS_ENABLED)

    defines { JOLT_DEFINES }
    
    -- Common platform hygiene
    filter "toolset:msc*"
        defines { "_CRT_SECURE_NO_WARNINGS" }
        warnings "High"
    filter "toolset:gcc or toolset:clang"
        warnings "Extra"
    filter {}

    -- Config flags
    filter "configurations:Debug"
        defines { "DEBUG", "_DEBUG" }
        symbols "On"
    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "Speed"
    filter {}