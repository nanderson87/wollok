package org.uqbar.project.wollok.codeGenerator.model

import org.uqbar.project.wollok.codeGenerator.model.Expression
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

@Accessors
class Self implements Expression {
	
	val Expression parent
	
	new(Expression parent){
		this.parent = parent
	}
	
	override typeFor(TypeContext tc) {
		tc.selfType
	}
	
}