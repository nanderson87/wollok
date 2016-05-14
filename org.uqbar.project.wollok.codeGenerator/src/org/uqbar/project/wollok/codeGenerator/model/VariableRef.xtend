package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class VariableRef implements Expression {

	val String name
	val Expression parent
	
	new(Expression parent, String name) {
		this.parent = parent
		this.name = name
	}
	
	override getType() {
		context.variables.get(name).type
	}
	
	override getContext() {
		parent.context
	}
	
}