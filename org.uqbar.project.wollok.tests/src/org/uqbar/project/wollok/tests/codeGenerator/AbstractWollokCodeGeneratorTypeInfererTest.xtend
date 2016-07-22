package org.uqbar.project.wollok.tests.codeGenerator

import java.util.HashSet

import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Before
import org.uqbar.project.wollok.codeGenerator.CodeAnalyzer
import org.uqbar.project.wollok.codeGenerator.model.ClassDefinition
import org.uqbar.project.wollok.codeGenerator.model.Expression
import org.uqbar.project.wollok.codeGenerator.model.Program
import org.uqbar.project.wollok.codeGenerator.model.types.ClassType
import org.uqbar.project.wollok.codeGenerator.model.types.NativeTypesEnum
import org.uqbar.project.wollok.codeGenerator.model.types.Type
import org.uqbar.project.wollok.codeGenerator.model.types.UnionType
import org.uqbar.project.wollok.codeGenerator.model.types.context.RootTypeContext
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext
import org.uqbar.project.wollok.tests.interpreter.AbstractWollokInterpreterTestCase
import org.uqbar.project.wollok.wollokDsl.WFile

import static extension org.uqbar.project.wollok.codeGenerator.model.types.TypeExtensions.*
import static extension org.uqbar.project.wollok.model.WollokModelExtensions.*

@Accessors
abstract class AbstractWollokCodeGeneratorTypeInfererTest extends AbstractWollokInterpreterTestCase {
	var CodeAnalyzer analyzer
	var Program pgm
	var TypeContext typeContext
	var WFile model

	@Before
	override void setUp() {
		super.setUp()
		analyzer = new CodeAnalyzer
	}

	def parseAndPerformAnalysis(CharSequence text) {
		model = text.parse
		model.assertNoErrors()

		pgm = analyzer.performAnalysis(model)
		typeContext = new RootTypeContext(pgm)
	}

	def type(Expression e) {
		e.typeFor(typeContext)
	}

	def nativeType(Expression e) {
		e.typeFor(typeContext).nativeType
	}

	def assertNativeTypeEquals(NativeTypesEnum expected, Expression e) {
		assertEquals(expected, e.nativeType)
	}

	def assertTypeIs(Class<? extends Type> tipo, Expression e) {
		if (!tipo.isInstance(e.type)) {
			assertEquals(tipo, e.type.class)
		}
	}

	def assertUnionType(Set<Type> types, Expression e){
		assertTypeIs(UnionType, e)
		assertEquals(types, (e.type as UnionType).types)
	}

	def assertUnionTypeNatives(Set<NativeTypesEnum> types, Expression e) {
		assertTypeIs(UnionType, e)
		val r = new HashSet()
		(e.type as UnionType).types.map[nativeType].forEach[r.add(it)]
		assertEquals(new HashSet(types), r)
	}

	def assertClassType(ClassDefinition classDefinition, Expression e){
		assertTypeIs(ClassType, e)
		assertEquals(classDefinition, (e.type as ClassType).classDefinition)
	}
	
	def classNameWithSyntheticPackage(String className){
		model.implicitPackage + "." + className
	}
}
