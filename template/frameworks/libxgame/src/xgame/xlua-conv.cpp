#include "xgame/xlua-conv.h"
#include "xgame/xlua.h"

void xluacv_push_bool(lua_State *L, bool value)
{
    lua_pushboolean(L, value);
}

bool xluacv_to_bool(lua_State *L, int idx)
{
    return lua_toboolean(L, idx);
}

bool xluacv_opt_bool(lua_State *L, int idx, bool default_value)
{
    return xlua_optboolean(L, idx, default_value);
}

void xluacv_push_std_string(lua_State *L, const std::string &value)
{
    lua_pushstring(L, value.c_str());
}

const std::string xluacv_to_std_string(lua_State *L, int idx)
{
    return luaL_checkstring(L, idx);
}

const std::string xluacv_opt_std_string(lua_State *L, int idx, const std::string &default_value)
{
    return luaL_optstring(L, idx, default_value.c_str());
}

void xluacv_push_string(lua_State *L, const char *value)
{
    lua_pushstring(L, value);
}

const char *xluacv_to_string(lua_State *L, int idx)
{
    return luaL_checkstring(L, idx);
}

const char *xluacv_opt_string(lua_State *L, int idx, const char *default_value)
{
    return luaL_optstring(L, idx, default_value);
}

void xluacv_push_number(lua_State *L, lua_Number value)
{
    lua_pushnumber(L, value);
}

lua_Number xluacv_to_number(lua_State *L, int idx)
{
    return luaL_checknumber(L, idx);
}

lua_Number xluacv_opt_number(lua_State *L, int idx, lua_Number default_value)
{
    return luaL_optnumber(L, idx, default_value);
}

void xluacv_push_int(lua_State *L, lua_Integer value)
{
    lua_pushinteger(L, value);
}

lua_Integer xluacv_to_int(lua_State *L, int idx)
{
    return luaL_checkinteger(L, idx);
}

lua_Integer xluacv_opt_int(lua_State *L, int idx, lua_Integer default_value)
{
    return luaL_optinteger(L, idx, default_value);
}

void xluacv_push_uint(lua_State *L, lua_Unsigned value)
{
    xluacv_push_int(L, (lua_Integer)value);
}

lua_Unsigned xluacv_to_uint(lua_State *L, int idx)
{
    return (lua_Unsigned)xluacv_to_int(L, idx);
}

lua_Unsigned xluacv_opt_uint(lua_State *L, int idx, lua_Unsigned default_value)
{
    return (lua_Unsigned)xluacv_opt_int(L, idx, (lua_Integer)default_value);
}
