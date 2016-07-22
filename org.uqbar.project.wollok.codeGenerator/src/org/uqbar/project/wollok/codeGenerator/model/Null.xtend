package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

class Null implements Expression {
	@Accessors 
	val Expression parent
	
	new(Expression parent){
		this.parent = parent
	}
	
	override typeFor(TypeContext tc) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
}