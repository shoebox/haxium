package haxium.protocol;

typedef Property=
{
	var type:PropertyType;
	var value:Dynamic;
}

enum PropertyType
{
	Element;
	Variable;
}
