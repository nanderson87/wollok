package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.NamedObjectType
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

@Accessors
class NamedObject extends AbstractContext {

	val String name
	val Program parent
	val ClassDefinition classDefinition

	new(String name, Program parent){
		this.name = name 
		this.parent = parent
		classDefinition = new ClassDefinition(parent, name + "Meta", parent.resolveWollokClass("wollok.lang.Object"))
	}
	
	override typeFor(TypeContext tc) {
		new NamedObjectType(this)
	}
}
