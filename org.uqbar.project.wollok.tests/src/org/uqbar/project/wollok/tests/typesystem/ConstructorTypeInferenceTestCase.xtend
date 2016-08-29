package org.uqbar.project.wollok.tests.typesystem

import org.junit.Test
import org.junit.runners.Parameterized.Parameters
import org.uqbar.project.wollok.semantics.XSemanticsTypeSystem
import org.uqbar.project.wollok.typesystem.substitutions.SubstitutionBasedTypeSystem

/**
 * 
 * @author jfernandes
 */
class ConstructorTypeInferenceTestCase extends AbstractWollokTypeSystemTestCase {
	
	@Parameters(name = "{index}: {0}")
	static def Object[] typeSystems() {
		#[
			new SubstitutionBasedTypeSystem
//			,new XSemanticsTypeSystem				// TO DO 
//			new ConstraintBasedTypeSystem			TO BE FIXED
//			new BoundsBasedTypeSystem,    TO BE FIXED
		]
	}
	
	@Test
	def void testConstructorParameterTypeInferredFromInstVarAssignment() {	 '''
			class Direccion {
				var calle = ""
				var numero = 0
				
				constructor(c, n) {
					calle = c
					numero = n
				}
			}
		'''.parseAndInfer.asserting [
			noIssues
			assertConstructorType("Direccion", "(String, Int)")
		]
	}
	
}