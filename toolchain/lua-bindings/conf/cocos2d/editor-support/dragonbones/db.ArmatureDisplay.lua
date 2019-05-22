local M = {}

local cls = class(M)
cls.CPPCLS = "dragonBones::CCArmatureDisplay"
cls.LUACLS = "db.ArmatureDisplay"
cls.SUPERCLS = "cc.Node"
cls.funcs [[
    static CCArmatureDisplay* create()
    void dbInit(Armature* armature)
    void dbClear()
    void dbUpdate()
    void dispose(bool disposeProxy = true)
    bool hasDBEventListener(const std::string& type)
    void dispatchDBEvent(const std::string& type, EventObject* value)
    Armature* getArmature()
    Animation* getAnimation()
]]

cls.props [[
    armature
    animation
]]

cls.vars [[
    bool debugDraw
]]

cls.callback(
    'void addDBEventListener(const std::string& type, const std::function<void(@stack EventObject*)>& listener)',
    {
        CALLBACK_MAKER = 'olua_makecallbacktag(#1)',
        CALLBACK_REPLACE = false,
    }
)

cls.callback(
    'void removeDBEventListener(const std::string& type, @nullable const std::function<void(EventObject*)>& listener)',
    {
        CALLBACK_MAKER = 'olua_makecallbacktag(#1)',
        CALLBACK_MODE = "OLUA_CALLBACK_TAG_ENDWITH",
        CALLBACK_REMOVE = true,
    }
)

return M