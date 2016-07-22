package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

@Accessors
class BooleanLiteral implements Expression {
	val Expression parent
	val Boolean value
	
	new(Expression parent, Boolean value){
		this.parent = parent
		this.value = value
	}
	
	override typeFor(TypeContext tc) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}