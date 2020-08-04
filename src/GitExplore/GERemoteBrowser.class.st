Class {
	#name : #GERemoteBrowser,
	#superclass : #Object,
	#instVars : [
		'repos'
	],
	#category : #GitExplore
}

{ #category : #browsing }
GERemoteBrowser >> browseRemoteHosts [
	"Create a canvas showing which repos have remotes pointing to which hosts"

	| c eb hostsGroup noHost reposGroup |

	c := RSCanvas new.

	eb := RSEdgeBuilder line
		canvas: c;
		color: Color black;
		moveBehind;
		"allowRepetition;"
			yourself.

	hostsGroup := RSGroup new.

	noHost := RSLabel new
		text: '<none>';
		model: '<none>'.
	hostsGroup add: noHost.
	c add: noHost.

	reposGroup := RSGroup new.
	self repos
		do: [ :repo | 
			| shape hasRemote |
			hasRemote := false.
			shape := RSEllipse new
				model: repo;
				size: 50;
				yourself.
			c add: shape.
			reposGroup add: shape.
			repo init allRemotes
				do: [ :remote | 
					| host |
					hasRemote := true.
					host := remote host.
					(hostsGroup anySatisfy: [ :h | h = host ])
						ifFalse: [ hostsGroup add: host.
							c
								add:
									(RSLabel new
										text: host;
										model: host) ].
					eb connectFrom: repo to: host ].
			hasRemote
				ifFalse: [ eb connectFrom: repo to: '<none>' ] ].
	RSForceBasedLayout new
		charge: -1500;
		on: c nodes.
	reposGroup @ RSPopup.
	c @ RSCanvasController.
	^ c
]

{ #category : #accessing }
GERemoteBrowser >> repos [
	^ repos
]

{ #category : #accessing }
GERemoteBrowser >> repos: anObject [
	repos := anObject
]
