package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Variable implements Expression{
	
	String name
	val Expression parent
	
	val assignations = <Expression> newArrayList()	
	var Expression initialValue
	
	new(Expression parent, String name) {
		this.name = name
		this.parent = parent
	}
	
	def setInitialValue(Expression e){
		initialValue = e
		assignations.add(e)
	}
	
	override getType() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getContext() {
		parent.context
	}
	
}