package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Method extends AbstractCompositeContext {

	val parameters = <Parameter>newArrayList
	val ClassDefinition parent
	var Boolean nativeMethod = false
	
	new(ClassDefinition parent) {
		this.parent = parent
	}
	
	def addParameter(Parameter parameter) {
		parameters.add(parameter)
	}
	
}