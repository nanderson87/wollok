package org.uqbar.project.wollok.tests.codeGenerator

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Before
import org.uqbar.project.wollok.codeGenerator.CodeAnalyzer
import org.uqbar.project.wollok.codeGenerator.model.Expression
import org.uqbar.project.wollok.codeGenerator.model.Program
import org.uqbar.project.wollok.codeGenerator.model.types.NativeTypesEnum
import org.uqbar.project.wollok.codeGenerator.model.types.context.RootTypeContext
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext
import org.uqbar.project.wollok.tests.interpreter.AbstractWollokInterpreterTestCase
import org.uqbar.project.wollok.wollokDsl.WFile

import static extension org.uqbar.project.wollok.codeGenerator.model.types.TypeExtensions.*

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

}
