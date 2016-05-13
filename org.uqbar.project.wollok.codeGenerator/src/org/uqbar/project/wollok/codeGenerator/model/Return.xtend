package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Return implements Expression {
	
	val Expression parent
	var Expression expression 
	
	new(Expression parent) {
		this.parent = parent
	}
	
	override getType() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getContext() {
		parent.context
	}
}