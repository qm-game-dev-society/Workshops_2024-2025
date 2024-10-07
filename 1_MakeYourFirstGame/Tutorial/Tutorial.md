# Setting up your project

First download the Godot engine from the official website via this [link](https://godotengine.org/download) and run it on your device.

After doing thatyou should see a screen like this:

![](./godotEngineStartScreen.png)

To create a project you can either press the create button in the top left or in the centre of the page
Then you can enter the project name, where the folder for the project is going to be on your device and other things.
For now keep everything besides the name and the path the same then hit the "create and edit" button.

![](Tutorial_20240924110843021.png)

The editor interface will then open and will look something like this:

![](Tutorial_20240924111635962.png)

If you want to learn more about godots editor interface your can read more about it on this [page](https://docs.godotengine.org/en/stable/getting_started/introduction/first_look_at_the_editor.html) of the documentation.

But for now what we're going to do is create the main [scene](https://docs.godotengine.org/en/stable/getting_started/step_by_step/nodes_and_scenes.html#scenes).

So all your going to do is in the scene panel in the top left and click on the button labelled 2D scene, which will create a 2D node as the root for your new scene.

![](Tutorial_20240924112206360.png)

And then renaming the node to "Game" for clarity sake it by right clicking on the newly created node in the scene panel, selecting the rename option and finally entering the new name "Game" and then pressing enter.

![](Tutorial_20240924112451221.png)

![](Tutorial_20240924112524006.png)

You can then save the scene by either pressing ctrl-s (or the equvilant on your device) or by pressing the scene tab on the top left of the window and then selecting save scene from there.

![](Tutorial_20240924112934635.png)

A window will then come up asking where you want to save the scene, for now just save it in the default location by just clicking save and nothing else.
 
Notice how you can now see the game scene in the filesystem panel in the bottom left of the screen.

![](Tutorial_20240924113113657.png)

Next we're going to set the viewport width and height for the window our games going to run in by navigating to the project settings by clicking on the project tab in the top left then clicking on project settings.

![](Tutorial_20240924112752417.png)

Then go to the window section, listed under display and change the viewport width to 450 and the viewport height to 720. And after that close the project settings window.
![](Tutorial_20240924182703000.png)

Also go to the rendering: textures section and set default texture filter to nearest, without doing this all your sprites will look blurry.

And now your ready to run your (currently empty) game.

Press the play button at the top right of the screen which will cause this notification window to come up, just click the "select current" button.

![](Tutorial_20240924183705505.png)

![](Tutorial_20240924183722555.png)

And after a few seconds, a window running the currently empty project should appear on your screen at the set viewport width and height.

![](Tutorial_20240924183840881.png)


# Making the player scene
- Create a new scene by either pressing the add new scene (plus) button above the scene view or the new scene option under the scene tab on the top left
- Add a Area2D node as the root node and rename it to player
- Drag the bird image file into the scene view, creating a sprite2d node which displays that image
- In the inspector, under the Transform tab, press the undo button next to the position property to centre the sprite in the scene
- Add a CollisionShape2D node as a child to the player node and with that node selected in the inspector click on the shape property selector, click on the new RectangleShape2D and resize it to an appropriate size
- Your screen should now look something like this
![](Tutorial_20241007092534444.png)
- Now finally save this scene the same way you saved the game scene, go back to the game scene tab, and drag the player scene from teh filesystem tab and drag it into the scene viewport to an appropriate position.
![](Tutorial_20241007092821267.png)
- If you want to you can scale up the player scene to a larger size to make it more visible using the scale property under the transform section under the node2d section in the inspector
- And when you click the play button now you will actually have something on the screen.
![](Tutorial_20241007093349993.png)
- This is how most games in godot are structured, which allows for scenes such as enemies to be easily reusable.

# Making the player move
- To get the player bird moving we're going to need to do some scripting
- In godot any node can have a single script assigned to it at anytime, with the script being able to modify that nodes properties, eg a Node2Ds position
- Go back to the player scene tab, select the Player node, right click and then press the option to attach script
- A window will then pop up, but you don't need to change any of those settings for now, so just press the create button and the script you created with the default template will automatically pop up on your screen
![](Tutorial_20241007094917660.png)

- On this page there are 2 functions. Functions are a section of code that is ran everytime the function is called.
- Both of these functions are built in to the engine, meaning that they are automatically called as the game runs
- The _ready function is called when the node enters the scene tree for the first time, for the player this will be when the game starts and _process runs for every frame the node exists in the game, and the delta argument representing the amount of time since the last frame
- For example this script would make the players position.y to increase 10 units per second, moving the player bird down

```
extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 10 * delta
```

- This sort of looks like the player bird being pulled down by gravity, but something is missing, velocity and acceleration. this is because the downwards speed increases
- So what we need is a velocity value which has its downwards velocity increase over time, so something like this
```
extends Area2D

const GRAVITY : float = 10
var velocity : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity += GRAVITY * delta
	position.y += velocity * delta
```

- So now the bird is now falling down in a way that looks more relistic, if you look at the top of the script there is a const (as in consistant, a value that can never be changed while the script is running) float (a decimal number) called GRAVITY and a variable (a value that can be changed during runtime) float called velocity which stores the current speed the player is moving up or down (depends on if the value is currently negative or positive)
- Now lets allow the player to not only fall down but jump by pressing the space button, first navigate back to the project settings but this time, got to the top tab options on the new window and click on input map.
![](Tutorial_20241007101727839.png)
- Click on the add new action text box and enter the word jump and press the add button and it should now appear in the action table
![](Tutorial_20241007101928709.png)
- On that row, press the plus button, a new window will now pop up, as it is currently listing for the input you want to assign to the action just press the space button (or any button you want to assign to the jump action) then pressthe ok option and now you can see the space button assigned to the jump action.
![](Tutorial_20241007102322759.png)
- Now close that window and go back to the player script so we can use this input action to make the player jump
```
extends Area2D

@export var GRAVITY : float = 10
@export var JUMP_VELOCITY : float = -20 
var velocity : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		velocity = JUMP_VELOCITY
	
	velocity += GRAVITY * delta
	
	
	position.y += velocity * delta

```
- Notice how gravity and jump_velocity are now variables and have @export written next to them? What @export does is make those values readable and editable from the inspector, so feel free to change those values to make jumping and falling feel good
![](Tutorial_20241007104003840.png)
- One last thing we should do is to make sure that the player doesnt go to far off screen, for now lets just limit the players y position to a certain range using the built in clamp function, we'll do with gameovers later.
- We'll also not allow the player to jump if there to close the the 'ceiling'

```
extends Area2D

@export var GRAVITY : float = 10
@export var JUMP_VELOCITY : float = -20 
var velocity : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and position.y > 3:
		velocity = JUMP_VELOCITY
	
	velocity += GRAVITY * delta
	
	
	position.y += velocity * delta
	
	position.y = clamp(position.y, 0, 800)

```