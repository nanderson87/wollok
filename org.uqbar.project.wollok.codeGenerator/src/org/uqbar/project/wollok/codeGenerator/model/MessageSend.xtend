package org.uqbar.project.wollok.codeGenerator.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class MessageSend implements Expression {
	
	var Expression receiver
	var String selector
	var List<Expression> parameters
	val Expression parent
	
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