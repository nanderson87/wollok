package org.uqbar.project.wollok.codeGenerator.model.types

import java.util.List

class UnionType  implements Type {
	
	val List<Type> types
	
	new(List<Type> types) {
		this.types = types
	}
	
}