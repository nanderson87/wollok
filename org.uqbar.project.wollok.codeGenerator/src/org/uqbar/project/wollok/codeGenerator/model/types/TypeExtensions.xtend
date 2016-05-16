package org.uqbar.project.wollok.codeGenerator.model.types

import org.uqbar.project.wollok.codeGenerator.model.types.context.NamedObjectTypeContext
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

class TypeExtensions {
	static def dispatch isNumericType(NumericType t) { true }
	static def dispatch isNumericType(Type t) { false }
	
	static def dispatch nativeType(NativeType t){ t.nativeType }
	static def dispatch nativeType(Type t) { throw new RuntimeException("There is no native type in " + t.toString ) }

	static def dispatch isNamedObject(NamedObjectType t) { true }
	static def dispatch isNamedObject(Type t) { false }

	static def dispatch TypeContext asTypeContext(Type t, TypeContext parentContext){ throw new RuntimeException("Should be implemented?? for:" + t?.class.name)}
	static def dispatch TypeContext asTypeContext(NamedObjectType t, TypeContext parentContext) { new NamedObjectTypeContext(parentContext, t.object) }
	static def dispatch TypeContext asTypeContext(NumericType t, TypeContext parentContext) { parentContext }
}