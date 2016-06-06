package org.uqbar.project.wollok.codeGenerator.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.ClassType
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

@Accessors
class ConstructorCall implements Expression {
	val Expression parent
	val String className
	var List<Expression> arguments
	
	new(Expression parent, String className){
		this.parent = parent
		this.className = className
	}
	
	override typeFor(TypeContext tc) {
		new ClassType(tc.resolveClass(className))
	}
	
}