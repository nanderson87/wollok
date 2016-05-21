package org.uqbar.project.wollok.codeGenerator

import org.uqbar.project.wollok.codeGenerator.model.Expression
import org.uqbar.project.wollok.codeGenerator.model.MethodContext

class ModelExtensions {
	static def dispatch MethodContext findContext(Expression expression){
		expression.parent.findContext
	}
	
	static def dispatch MethodContext findContext(MethodContext context){
		context
	}
}