package org.uqbar.project.wollok.codeGenerator.model

import org.uqbar.project.wollok.codeGenerator.model.Expression

class VariableRef implements Expression {

	val String name 
	
	new(String name) {
		this.name = name
	}
	
}