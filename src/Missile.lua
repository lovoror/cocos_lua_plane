--
-- Author: alinzai
-- Date: 2015-06-13 11:14:46
-- 导弹
Missile = class("Missile", function()
	return cc.Sprite:create()
end)

function Missile:ctor()
	self.command = nil
end

function Missile:create(speed, weapon, attackMode, type)
    local missile = Missile.new()
    missile:init(speed, weapon, attackMode, type)
    return missile
end

function Missile:init(speed, weapon, attackMode, type )
	local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(weapon)
    self:setSpriteFrame(frame)
    -- 太大了
    self:setScale(0.25/4,0.25/4)

    -- 混合模式
    self:setBlendFunc(GL_SRC_ALPHA, GL_ONE)

    self:setPhysicsBody(cc.PhysicsBody:createCircle(5, cc.PhysicsMaterial(0.1, 1, 0), cc.p(0, 26)))

    self:getPhysicsBody():setCategoryBitmask(MISSILE_CATEGORY_MASK)
    self:getPhysicsBody():setCollisionBitmask(MISSILE_COLLISION_MASK)
    self:getPhysicsBody():setContactTestBitmask(MISSILE_CONTACTTEST_MASK)
     
end    

function Missile:setcommand(com)
	self.command = com
end
function Missile:destory()
	self.command:destroy()
end