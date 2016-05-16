package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Method extends AbstractMethodContext {

	val Expression parent
	
	new(Expression parent) {
		this.parent = parent
	}
}