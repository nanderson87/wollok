package org.uqbar.project.wollok.codeGenerator.model.types

import org.uqbar.project.wollok.codeGenerator.model.ClassDefinition
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ClassType extends Type {
	
	val ClassDefinition classDefinition
	
	new(ClassDefinition classDefinition){
		this.classDefinition = classDefinition
	}
	
	dispatch def doEquals(Object obj) {
		false
	}
	
	dispatch def doEquals(ClassType ct){
		ct.classDefinition == this.classDefinition
	}
	
	override doHashCode() {
		this.classDefinition.hashCode
	}
	
}
