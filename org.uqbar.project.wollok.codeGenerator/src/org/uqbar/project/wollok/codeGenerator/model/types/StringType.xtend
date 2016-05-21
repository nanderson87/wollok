package org.uqbar.project.wollok.codeGenerator.model.types

import org.uqbar.project.wollok.codeGenerator.model.types.NativeType

class StringType implements NativeType {
	override getNativeType() {
		NativeTypesEnum.STRING
	}
}