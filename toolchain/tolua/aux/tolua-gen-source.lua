local function gen_include(module, write)
    local INCLUDES = trimlastlf(module.INCLUDES)
    local STATIC_CHUNK= module.STATIC_CHUNK
    write(format_snippet([[
        //
        // generated by tolua
        //
        ${INCLUDES}
    ]]))
    write('')
    if STATIC_CHUNK then
        write(STATIC_CHUNK)
        write('')
    end
end

local function gen_classes(module, write)
    local function do_gen_class(cls)
        gen_class(module, cls, write)
        write('')
    end

    for i, cls in ipairs(module.CLASSES) do
        if #cls > 0 then
            for _, v in ipairs(cls) do
                do_gen_class(v)
            end
        else
            do_gen_class(cls)
        end
    end
end

local function gen_luaopen(module, write)
    local MODULE_NAME = module.NAME
    local REQUIRES = {}

    local function do_gen_open(cls)
        local LUACLS = cls.LUACLS
        local CPPCLS_PATH = class_path(cls.CPPCLS)
        REQUIRES[#REQUIRES + 1] = format_snippet([[
            xlua_require(L, "${LUACLS}", luaopen_${CPPCLS_PATH});
        ]])
    end

    for i, cls in ipairs(module.CLASSES) do
        if #cls > 0 then
            for _, v in ipairs(cls) do
                do_gen_open(v)
            end
        else
            do_gen_open(cls)
        end
    end

    REQUIRES = table.concat(REQUIRES, "\n")
    write(format_snippet([[
        int luaopen_${MODULE_NAME}(lua_State *L)
        {
            ${REQUIRES}
            return 0;
        }
    ]]))
    write('')
end

function gen_source(module)
    local arr = {}
    local function append(value)
        arr[#arr + 1] = value
    end

    gen_include(module, append)
    gen_classes(module, append)
    gen_luaopen(module, append)
    write(PROJECT_ROOT .. module.SOURCE_PATH, table.concat(arr, "\n"))
end