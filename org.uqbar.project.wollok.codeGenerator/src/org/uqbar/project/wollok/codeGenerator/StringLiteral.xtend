package org.uqbar.project.wollok.codeGenerator

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.Expression
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext
import org.uqbar.project.wollok.codeGenerator.model.types.StringType

@Accessors
class StringLiteral implements Expression {
	val String value
	val Expression parent	
	
	new(String value, Expression parent){
		this.value = value
		this.parent = parent
	}
	
	override typeFor(TypeContext tc) {
		new StringType
	}
	
}