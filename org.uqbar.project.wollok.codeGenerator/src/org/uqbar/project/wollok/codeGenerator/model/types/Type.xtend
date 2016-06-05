package org.uqbar.project.wollok.codeGenerator.model.types

import static extension org.uqbar.project.wollok.codeGenerator.model.types.TypeExtensions.*

abstract class Type {
	def Type combineWith(Type other) {
		if (other.equals(this))
			this
		else {
			if (other.isUnionType) {
				other.combineWith(this)
			} else {
				new UnionType(#{this, other})
			}
		}
	}

	override equals(Object obj) {
		doEquals(obj)
	}

	override hashCode() {
		doHashCode()
	}

	def boolean doEquals(Object obj)

	def int doHashCode()
}

abstract class NativeType extends Type {
	def NativeTypesEnum getNativeType()
}
