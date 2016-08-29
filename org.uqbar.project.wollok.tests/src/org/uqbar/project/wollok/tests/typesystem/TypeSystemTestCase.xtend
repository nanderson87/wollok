package org.uqbar.project.wollok.tests.typesystem

import org.junit.Test
import org.junit.runners.Parameterized.Parameters
import org.uqbar.project.wollok.typesystem.substitutions.SubstitutionBasedTypeSystem

import static org.uqbar.project.wollok.typesystem.WollokType.*

import static org.uqbar.project.wollok.sdk.WollokDSK.*

/**
 * Tests type system inference and checks
 * 
 * @author jfernandes
 */
class TypeSystemTestCase extends AbstractWollokTypeSystemTestCase {

	@Parameters(name = "{index}: {0}")
	static def Object[] typeSystems() {
		#[
			new SubstitutionBasedTypeSystem
			// TODO: fix !
//			new XSemanticsTypeSystem,		 
//			new ConstraintBasedTypeSystem,
//			new BoundsBasedTypeSystem
		]
	}

	@Test
	def void testInferSimpleVariableAssignment() {
		''' program p {
			const number = 23
		}'''.parseAndInfer.asserting [
			assertTypeOf(classType(INTEGER), 'number')
		]
	}

	@Test
	def void testInferIndirectVar() {
		''' program p {
			const number
			number = 23
		}'''.parseAndInfer.asserting [
			assertTypeOf(classType(INTEGER), 'number')
		]
	}

	@Test
	def void testInferIndirectAssignedToBinaryExpression() {
		''' program p {
			const number
			const a = 2
			const b = 3
			number = a + b
		}'''.parseAndInfer.asserting [
			assertTypeOf(classType(INTEGER), 'number')
		]
	}

	@Test
	def void testIncompatibleTypesInAssignment() {
		''' program p {
			var a = 2
			const b = "aString"
			a = b
		}'''.parseAndInfer.asserting [
			assertIssues("a = b", "Expecting super type of <<Int>> but found <<String>> which is not")
		]
	}
	
	@Test
	def void testClassType() {
		'''
			class Pato {
				method cuack() { 'cuack!' }
		 	program p {
				const pato = new Pato()
				pato.cuack()
			}'''.parseAndInfer.asserting [
			noIssues
			assertTypeOf(classType("Pato"), 'pato')
		]
	}

}
