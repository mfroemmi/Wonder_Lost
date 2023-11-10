extends StaticBody3D

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer


func _ready():
	$CollisionArea3D.body_entered.connect(on_body_entered)
	$CollisionArea3D.body_exited.connect(on_body_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_body_entered(other_body: Node3D):
	print("on_body_entered")
	animationPlayer.play("open")
	
	
func on_body_exited(other_body: Node3D):
	print("on_body_exited")
	animationPlayer.play("close")
