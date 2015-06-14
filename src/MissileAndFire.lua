--
-- Author: alinzai
-- Date: 2015-06-14 09:52:15
--
MissileAndFire = class("MissileAndFire", "")

function MissileAndFire:create(layer)
	local missileandfire = MissileAndFire.new()
	missileandfire:init(layer)
    return missileandfire
end

function MissileAndFire:init(layer)
	self.layer = layer
	local missile = Missile:create(1,'missile.png',2,3)
	layer:addChild(missile, 9,MISSILE_TAG)
	missile:setcommand(self)
	self.missile = missile

	emitter = cc.ParticleSun:create()
	self.emitter = emitter
    -- emitter:retain()
    layer:addChild(emitter, 10)

    emitter:setTexture(cc.Director:getInstance():getTextureCache():addImage("fire.png"))
    emitter:setStartSize(10)
    --emitter:setStartSizeVar(0)
    emitter:setEndSize(6)
    --emitter:setEndSizeVar(0)
    emitter:setLife(0.5)
    emitter:setLifeVar(0.09)
end

function MissileAndFire:destroy()
	self.missile:stopAllActions()
	self.emitter:stopAllActions()
	self.layer:removeChild(self.missile)
	self.layer:removeChild(self.emitter)
end

function MissileAndFire:fire()
	local ship = self.layer.ship
	local pos = cc.p(ship:getPosition())
	local offsetX = 0
	local offsetY = 8
	local p1 = cc.p(pos.x - offsetX, pos.y - offsetY)
	self.missile:setPosition(p1)
	local p2 = cc.p(p1.x-3,p1.y - 10)
	self.emitter:setPosition(p2)
	local useTime = 2.0
	local mv = cc.MoveTo:create(useTime, cc.p(p1.x, WIN_SIZE.height + 10))
    local delay = cc.DelayTime:create(0.5)

    local function callback(sender)
    	print("callback -----------.........>>>>>>>")
    	self:destroy()
	end

    local seq = cc.Sequence:create(delay, mv,cc.CallFunc:create(callback))
    self.missile:runAction(seq)
    local mvac = cc.MoveTo:create(useTime, cc.p(p2.x, WIN_SIZE.height))
    local ac = cc.Sequence:create(delay:clone(), mvac)
    self.emitter:runAction(ac)
end