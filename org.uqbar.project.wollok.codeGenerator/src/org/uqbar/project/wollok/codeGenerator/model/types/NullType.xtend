package org.uqbar.project.wollok.codeGenerator.model.types

import org.uqbar.project.wollok.codeGenerator.model.types.Type

class NullType extends Type {
	
	override doEquals(Object obj) {
		this.class == obj.class
	}
	
	override doHashCode() {
		this.class.hashCode
	}
	
}