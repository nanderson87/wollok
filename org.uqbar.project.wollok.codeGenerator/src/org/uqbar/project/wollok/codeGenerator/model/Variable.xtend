package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.UnknownType
import org.uqbar.project.wollok.codeGenerator.model.types.UnionType

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
		if(assignations.empty)
			return new UnknownType
		
		if(assignations.size == 1){
			return assignations.get(0).type
		}
		
		return new UnionType(assignations.map[type])
	}
	
	override getContext() {
		parent.context
	}
	
}