package org.uqbar.project.wollok.tests.codeGenerator

import org.junit.Test
import org.uqbar.project.wollok.codeGenerator.model.types.NativeTypesEnum

class NamedObjectsTypeInfererTest extends AbstractWollokCodeGeneratorTypeInfererTest {
	
	@Test
	def void inferTypeOfKindName() {
		'''
			object xx {
				
			}
			
			program p {
				return xx.kindName()
			}
		'''.parseAndPerformAnalysis

		assertNativeTypeEquals(NativeTypesEnum.STRING, pgm.returnVariable)
	}

}
