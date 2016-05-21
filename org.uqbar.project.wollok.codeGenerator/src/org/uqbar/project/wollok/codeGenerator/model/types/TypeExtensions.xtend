package org.uqbar.project.wollok.codeGenerator.model.types

import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext
import org.uqbar.project.wollok.codeGenerator.model.types.context.ClassTypeContext

class TypeExtensions {
	static def dispatch isNumericType(NumericType t) { true }

	static def dispatch isNumericType(Type t) { false }

	static def dispatch nativeType(NativeType t) { t.nativeType }

	static def dispatch nativeType(Type t) { throw new RuntimeException("There is no native type in " + t.toString) }

	static def dispatch isNamedObject(NamedObjectType t) { true }

	static def dispatch isNamedObject(Type t) { false }

	static def dispatch ClassTypeContext asTypeContext(Type t, TypeContext parentContext) {
		throw new RuntimeException("Should be implemented?? for:" + t?.class.name)
	}

	static def dispatch ClassTypeContext asTypeContext(NamedObjectType t, TypeContext parentContext) {
		new ClassTypeContext(parentContext, t.object.classDefinition)
	}

	static def dispatch ClassTypeContext asTypeContext(NativeType t, TypeContext parentContext) {
		new ClassTypeContext(parentContext, parentContext.resolveClass(t.nativeType.wollokClassName))
	}

	def static NativeType convertJavaType(String javaName) {
		switch (javaName) {
			case "java.lang.String": return new StringType
		}

		throw new UnsupportedOperationException("Not found conversion for " + javaName)
	}

}
