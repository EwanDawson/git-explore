Extension { #name : #LGitRemote }

{ #category : #'*GitExplore' }
LGitRemote >> host [
	"Answer with the hostname of the remote repo"

	self isHttp
		ifTrue: [ ^ (ZnUrl fromString: self url) host ].
	self isSsh
		ifTrue: [
			| thisUrl start end |
			thisUrl := self url.
			start := (thisUrl indexOf: $@) + 1.
			end := (thisUrl indexOf: $:) - 1.
			^ thisUrl copyFrom: start to: end ].
	self error: 'Remote url is not of known type'
]

{ #category : #'*GitExplore' }
LGitRemote >> isHttp [
	"Answer true if this remote is accessed via http/https, otherwise answer false"
	
  ^ (self url beginsWith: 'https://') or: [ self url beginsWith: 'http://' ]
]

{ #category : #'*GitExplore' }
LGitRemote >> isSsh [
	"Answer true if this remote is accessed via SSH, otherwise answer false"
	
  ^ self url beginsWith: 'git@'
]
