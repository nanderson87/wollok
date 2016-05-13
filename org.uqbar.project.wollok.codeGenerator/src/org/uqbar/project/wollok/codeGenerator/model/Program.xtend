package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Program implements Expression, Context {	
	val variables = <String, Variable>newLinkedHashMap()
	val operations = <Expression>newArrayList();
	val returnVariable = new Variable("_return", null);
	
	override getType() {
		returnVariable.type
	}
	
	override getParent() {
		null
	}
	
	override getContext() {
		this
	}
		
}