package org.uqbar.project.wollok.codeGenerator

import org.uqbar.project.wollok.codeGenerator.model.Context
import org.uqbar.project.wollok.codeGenerator.model.Expression

class ModelExtensions {
	static def dispatch Context findContext(Expression expression){
		expression.parent.findContext
	}
	
	static def dispatch Context findContext(Context context){
		context
	}
	
}