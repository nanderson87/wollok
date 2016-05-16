package org.uqbar.project.wollok.codeGenerator.model.types

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.NamedObject

@Accessors
class NamedObjectType implements Type {
	val NamedObject object 
	
	new (NamedObject obj){
		this.object = obj
	}
}