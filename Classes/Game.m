//
//  Game.m
//  AngryGunner
//
//  Created by Troy Cox on 2/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Game.h"
#import "Waves.h"
#import "Joystick.h"
#import "Bullet.h"
#import "CCTouchDispatcher.h"
#import "Plane.h"
#import "Splash.h"
#import "Score.h"
#import "LevelData.h"

@implementation Game

Joystick *jstick;
CCLayer *bgLayer;

Waves *waves;
CCSprite *gun;
CCSprite *leftShield;
CCSprite *rightShield;
CCSprite *crossHair;
CCSprite *pushButton;
float shootTimer;
BOOL isShooting;
CCSprite *flash;
CCSprite *flash2;
CCSprite *healthBar;
CCSprite *healthFrame;
CCSprite *brokenGlass;
CCLayer *blips;

CCSprite* fireBurst;
float planeCountDown;

@synthesize planes;
@synthesize bullets;
@synthesize friendsLayer;
@synthesize gunner;
@synthesize health;
@synthesize x;
@synthesize y;
@synthesize radar;
@synthesize score;

+(id)scene{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Game *layer = [Game node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init
{
	if( (self=[super init])) 
	{
		health = 100;
		
		score = [[LevelData sharedLevelData] score];
		
		CCSprite *bg1 = [CCSprite spriteWithFile:@"backgroundright.png"];
		[bg1 flipY];
		[bg1 setAnchorPoint:ccp(1,0)];
		
	    bg1.position = ccp(1,0);

		CCSprite *bg2 = [CCSprite spriteWithFile:@"backgroundright.png"];
		[bg2 setAnchorPoint:ccp(0,0)];
		
	    bg2.position = ccp(0,0);
		
		bgLayer = [CCLayer node]; 
				
		[bgLayer addChild:bg1];
		[bgLayer addChild:bg2];
		[bgLayer setAnchorPoint:ccp(.5,0)];
		[bgLayer setPosition:ccp(240,0)];
		[self addChild:bgLayer];
		
		waves = [Waves node];
		[waves setAnchorPoint:ccp(.5,0)];
		[bgLayer addChild:waves];
		
		
		friendsLayer = [CCLayer node];
		[friendsLayer setAnchorPoint:ccp(.5,0)];
		[self addChild:friendsLayer];
		
		CCSprite *destroyer2 = [CCSprite spriteWithFile:@"destroyer2.png"];
		[destroyer2 setAnchorPoint:ccp(.5,0)];
		[destroyer2 setPosition:ccp(-440,115)];
		[friendsLayer addChild:destroyer2];

		CCSprite *destroyer1 = [CCSprite spriteWithFile:@"destroyer1.png"];
		[destroyer1 setAnchorPoint:ccp(.5,0)];
		[destroyer1 setPosition:ccp(-240,150)];
		[friendsLayer addChild:destroyer1];

		CCSprite *smallcarrier = [CCSprite spriteWithFile:@"smallcarrier.png"];
		[smallcarrier setAnchorPoint:ccp(.5,0)];
		[smallcarrier setPosition:ccp(890,250)];
		[friendsLayer addChild:smallcarrier];		

		CCSprite *largecarrier = [CCSprite spriteWithFile:@"largecarrier.png"];
		[largecarrier setAnchorPoint:ccp(.5,0)];
		[largecarrier setPosition:ccp(820,200)];
		[friendsLayer addChild:largecarrier];
		
		CCSprite *destroyer3 = [CCSprite spriteWithFile:@"destroyer1.png"];
		[destroyer3 setAnchorPoint:ccp(.5,0)];
		[destroyer3 setPosition:ccp(840,110)];
		[friendsLayer addChild:destroyer3];
			
		
		CCLayer* control = [CCLayer node];
		[control setAnchorPoint:ccp(0,0)];
		[control setPosition:ccp(65,65)];
		
		CCScene* jsBack = [CCSprite spriteWithFile:@"dpad.png"];
		[jsBack setAnchorPoint:ccp(.5,.5)];
		[jsBack setPosition:ccp(0,0)];
				
		CCSprite* jsThumb = [CCSprite spriteWithFile:@"dpadburst.png"];
		[jsThumb setAnchorPoint:ccp(.5,.5)];
		jstick = [Joystick joystickWithThumb: jsThumb andBackdrop: jsBack];
		[jstick setAnchorPoint:ccp(.5,.5)];
		[jstick setContentSize:CGSizeMake(100, 100)];
		jstick.position = ccp(0, 0);
		[control addChild: jstick];	
		
		CCSprite* fireButton = [CCSprite spriteWithFile:@"firebutton.png"];
		[fireButton setAnchorPoint:ccp(.5,.5)];
		[fireButton setPosition:ccp(415,65)];
		[self addChild:fireButton];

		planes = [CCLayer node];
		[planes setAnchorPoint:ccp(.5,0)];
		[self addChild:planes];		
		
		bullets = [CCLayer node];
		[self addChild:bullets];
		
		CGPoint healthPosition = ccp(5,315);
		
		healthBar = [CCSprite spriteWithFile:@"health.png"];
		[healthBar setPosition:ccpAdd(healthPosition,ccp(18,-4))];
		[healthBar setAnchorPoint:ccp(0,1)];
		[self addChild:healthBar];
		
		healthFrame = [CCSprite spriteWithFile:@"healthbar.png"];
		[healthFrame setAnchorPoint:ccp(0,1)];
		[healthFrame setPosition:healthPosition];
		[self addChild:healthFrame];
		
		gunner = [CCLayer node];
		[gunner setAnchorPoint:ccp(.5,0)];
		
		leftShield = [CCSprite spriteWithFile:@"shieldleft.png"];
		[leftShield setAnchorPoint:ccp(0,0)];
		[leftShield setPosition:ccp(10,0)];
		[leftShield setOpacity:45];
		[gunner addChild:leftShield];
		
		rightShield = [CCSprite spriteWithFile:@"shieldleft.png"];
		[rightShield setAnchorPoint:ccp(1,0)];
		[rightShield setPosition:ccp(470,0)];
		[rightShield setOpacity:45];
		[gunner addChild:rightShield];
		
		fireBurst = [CCSprite spriteWithFile:@"firebuttonburst.png"];
		[fireBurst setAnchorPoint:ccp(.5,.5)];
		[fireBurst setPosition:ccp(415,65)];
		[fireBurst setOpacity:0];
		[self addChild:fireBurst];
		
		[self addChild:control];
		
		
		gun = [CCSprite spriteWithFile:@"guns.png"];
		//[gun setVertexZ:100];
		[gun setAnchorPoint:ccp(.5, 0)];
		[gun setPosition:ccp(240,0)];
		[gunner addChild:gun];

		crossHair = [CCSprite spriteWithFile:@"crosshair.png"];
		[crossHair setAnchorPoint:ccp(.5,0)];
		[crossHair setPosition:ccp(240,0)];
		[crossHair setOpacity:45];
		[gunner addChild:crossHair];
		
		shootTimer = 0;
		
		[self addChild:gunner];
		
		brokenGlass = [CCSprite spriteWithFile:@"crackedglass.png"];
		[brokenGlass setAnchorPoint:ccp(.5,.5)];
		[brokenGlass setPosition:ccp(240,160)];
		[brokenGlass setOpacity:0];
		[self addChild:brokenGlass];
				
		planeCountDown = 0;
		
		radar = [CCSprite spriteWithFile:@"radar.png"];
		[radar setOpacity:100];
		[radar setAnchorPoint:ccp(.5,.5)];
		[radar setPosition:ccp(240,10)];
		[self addChild:radar];
		
		blips = [CCLayer node];
		[self addChild:blips];
		
		[self schedule:@selector(step:)];
		x = 0;
		y = 0;
		
		
	}
	
	return self;	
}

-(void)kill
{
	[[LevelData sharedLevelData] setScore:score];

	[self unschedule:@selector(step:)];
	for (Plane *p in [[self planes] children]){
		[p setIsDying:TRUE];
		[p unschedule:@selector(step:)];
		[[self planes] removeAllChildrenWithCleanup:FALSE];
	}
	isShooting=FALSE;
	[[CCDirector sharedDirector] replaceScene:[Score scene]];
	
}


-(void)step:(ccTime)dt{
	
	[healthBar setScaleX:health/100];
	
	if (health<=0) {
		[self kill];
	}

	if (health<30){
		[brokenGlass setOpacity:(int)(255-(health*8.5))];
	}
	float xx = (jstick.velocity.x);
	float yy = (jstick.velocity.y);
	
	if (xx>.7||xx<.7) {
		xx = xx* 1.5;
		if (xx>1.5||xx<-1.5) {
			xx= xx*10;
		}
	}
	if (yy>.7||yy<-.7) {
		yy = yy* 1.5;
		if (yy>1.5||yy<-1.5) {
			yy= yy*10;
		}
	}
	
	if (xx==0){
		if (x<-1024+480)
			x += 400*dt;
		if (x>1024-480)
			x-=400*dt;
	}
	planeCountDown -=100*dt;
	if (planeCountDown<1) {
		planeCountDown = 500;
		Plane *plane = [Plane brownSprite];
		[plane start];
		[planes addChild:plane];
		[plane release];
	}
	
	x = x - xx*dt*10;
	y = y - yy*dt*10;
	float staticX = 0;
	
	if (y>0) {
		y=0;
	}
	if (y<-1024+320) {
		y=-1024+320;
	}
	if (x>1024-480) {
		staticX=1024-480;
	}
	if (x<-1024+480) {
		staticX=-1024+480;
	}

	if (staticX == 0) {
		[gunner setPosition:ccp(0,0)];
		//[waves setPosition:ccp(-x,0)];
		[friendsLayer setPosition:ccp(x,y)];
		[bgLayer setPosition:ccp(x,y)];		
	}else {
		if (x>1024-280) {
			x=1024-280;
		}
		if (x<-1024+280) {
			x=-1024+280;
		}
		
		//[waves setPosition:ccp(-x,0)];
		[friendsLayer setPosition:ccp(staticX,y)];
		[bgLayer setPosition:ccp(staticX,y)];
		[gunner setPosition:ccp(-x+staticX,0)];
	}
	
	if (isShooting) {
		shootTimer += 60*dt;
		if (shootTimer>8) {
			[self fireBullets];
		}
	}else {
		shootTimer=0;
	}

	[fireBurst setOpacity:(isShooting)?255:0];
	[planes setPosition:[friendsLayer position]];
	
	[blips removeAllChildrenWithCleanup:TRUE];
	
	for (Plane *p in [planes children]){
		CCSprite *sb = [CCSprite spriteWithFile:@"radarblip.png"];
		float sbx = (90*(p.position.x+x) /2048)-10;
		float sby = p.zIndex*.25;
		CGPoint sbp = [self getRotatedPoints:(int)sby startPoint:ccp(240,10) Angle:sbx];
		[sb setAnchorPoint:ccp(.5,.5)];
		[sb setPosition:sbp];
		[sb setScale:1-p.position.y/1300];
		[blips addChild:sb];
	}
}


-(void)fireBullets
{
	[bullets setPosition:[gunner position]];
	Bullet *bullet = [Bullet spriteWithFile:@"bullet.png"];
	[bullet setAnchorPoint:ccp(.5,.5)];
	[bullet setRotation:29];
	[bullet startAtPosition:ccp(-x+205,-y+100) finishAtPosition:ccp(-x+238,-y+155)];
	[friendsLayer addChild:bullet];
	
	flash = [CCSprite spriteWithFile:@"flash.png"];
	[flash setAnchorPoint:ccp(.5,0)];
	[flash setRotation:29];
	[flash setPosition:ccp(192,86)];
	[flash runAction:[CCSequence actions:[CCFadeOut actionWithDuration:.02],
					  [CCCallFunc actionWithTarget:self selector:@selector(killFlash:)],nil]];
	[bullets addChild:flash];									  
	
	
	Bullet *bullet2 = [Bullet spriteWithFile:@"bullet.png"];
	[bullet2 setRotation:-29];
	[bullet2 setAnchorPoint:ccp(.5,.5)];
	[bullet2 startAtPosition:ccp(-x+275,-y+100) finishAtPosition:ccp(-x+242,-y+155)];
	[friendsLayer addChild:bullet2];
	shootTimer=0;
	
	flash2 = [CCSprite spriteWithFile:@"flash.png"];
	[flash2 setAnchorPoint:ccp(.5,0)];
	[flash2 setRotation:-29];
	[flash2 setPosition:ccp(285,86)];
	[flash2 runAction:[CCSequence actions:[CCFadeOut actionWithDuration:.02],
					   [CCCallFunc actionWithTarget:self selector:@selector(killFlash:)],nil]];
	[bullets addChild:flash2];									  
	[gun setPosition:ccp(240,-20)];
	[gun runAction:[CCMoveTo actionWithDuration:.04 position:ccp(240,0)]];
	[crossHair setPosition:ccp(240,-10)];
	[crossHair runAction:[CCMoveTo actionWithDuration:.04 position:ccp(240,0)]];
	[flash setPosition:ccpAdd([flash position], ccp(0,-20))];
	[flash2 setPosition:ccpAdd([flash2 position], ccp(0,-20))];
}

-(void)killFlash:(id)sprite
{
	[bullets removeChild:flash cleanup:TRUE];
	[bullets removeChild:flash2 cleanup:TRUE];
}

-(CGPoint)getRotatedPoints:(int)radius startPoint:(CGPoint)start Angle:(float)angle {
	float xx = start.x+radius*sin(angle*3.14159265/180);
	float yy = start.y+radius*cos(angle*3.14159265/180);
	CGPoint newPoint = ccp(xx,yy);
	return newPoint;
}


-(void)enemyPlaneBulletWithPosition:(CGPoint)bpos 
				 withBulletRotation:(int)brot 
						   withScale:(float)planeScale 
								andBulletScale:(float)bscale
{
	
	CCSprite *enemyBullet = [CCSprite spriteWithFile:@"enemyBullet.png"];
	[enemyBullet setOpacity: 50];
	[enemyBullet setScaleY: bscale];
	[enemyBullet setAnchorPoint:ccp(.5,0)];
	[enemyBullet setRotation:brot];
	[enemyBullet setPosition:bpos];
	[[self friendsLayer]addChild:enemyBullet];
	[enemyBullet runAction:[CCSequence actions:[CCDelayTime actionWithDuration:.05],
				   [CCCallFuncN actionWithTarget:self 
										selector:@selector(killEnemyBullet:)],nil]];
	
	CGPoint p = [self getRotatedPoints:enemyBullet.contentSize.height*bscale startPoint:bpos Angle: brot];
		
	if (x+p.x>100&&x+p.x<380) {
		if (y+p.y>60&&y+p.y<260){
			CCSprite *bulletHole = [CCSprite spriteWithFile:@"bullethole.png"];
			[bulletHole setOpacity:150];
			[bulletHole setAnchorPoint:ccp(.5,.5)];
			[bulletHole setPosition:ccp(x+p.x,y+p.y)];
			[[self gunner] addChild:bulletHole];
			[bulletHole runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1],
									[CCCallFuncN actionWithTarget:self 
														 selector:@selector(killBulletHole:)],nil]];
			health -= 2;
		}
	}
}

-(void)killBulletHole:(CCSprite *)sender
{
	[[self gunner] removeChild:sender cleanup:TRUE];
}


-(void)killEnemyBullet:(CCSprite *)sender
{
	[[self friendsLayer] removeChild:sender cleanup:TRUE];
}

-(void) onEnter
{
	
	//[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:TRUE];
	[self setIsTouchEnabled:TRUE];
	//[[CCTouchDispatcher sharedDispatcher] setDispatchEvents:TRUE];
	[jstick registerWithTouchDispatcher];
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
	[super onEnter];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGSize cs = CGSizeMake(150, 150);
	float tx = 400;
	float ty = 80;
	
	for( UITouch *touch in touches ) {		
		CGPoint nodeTouchPoint = [self convertTouchToNodeSpace: touch];		
		
		if (nodeTouchPoint.x<tx+cs.width/2&&nodeTouchPoint.x>tx-cs.width/2) {
			if (nodeTouchPoint.y<ty+cs.height/2&&nodeTouchPoint.y>ty-cs.height/2) {
				[self fireBullets];
				isShooting=TRUE;
			}
		}
	}
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGSize cs = CGSizeMake(150, 150);
	float tx = 400;
	float ty = 80;
	for( UITouch *touch in touches ) {		
		CGPoint nodeTouchPoint = [self convertTouchToNodeSpace: touch];		
		
		if (nodeTouchPoint.x<tx+cs.width/2&&nodeTouchPoint.x>tx-cs.width/2) {
			if (nodeTouchPoint.y<ty+cs.height/2&&nodeTouchPoint.y>ty-cs.height/2) {
				isShooting=FALSE;
			}
		}
	}
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGSize cs = CGSizeMake(150, 150);
	float tx = 400;
	float ty = 80;
	BOOL testShooting = FALSE;

	for( UITouch *touch in touches ) {		
		CGPoint nodeTouchPoint = [self convertTouchToNodeSpace: touch];		
				
		if (nodeTouchPoint.x<tx+cs.width/2&&nodeTouchPoint.x>tx-cs.width/2) {
			if (nodeTouchPoint.y<ty+cs.height/2&&nodeTouchPoint.y>ty-cs.height/2) {
				testShooting=TRUE;
			}
		}		
	}
	isShooting = testShooting;
}

-(void)killSprite:(id)sender
{
	[self removeChild:sender cleanup:FALSE];
}

-(void)startScene:(id)sender
{		
	//[[CCDirector sharedDirector] replaceScene:[StartScene node]];	
}


- (void)release {
	//	NSLog(@"StartLayer retain count = %d", [self retainCount]);
	[super release];
}


-(void)dealloc
{
	//	CCLOG(@"dealloc: %@", self);
	[super dealloc];	
}


@end
