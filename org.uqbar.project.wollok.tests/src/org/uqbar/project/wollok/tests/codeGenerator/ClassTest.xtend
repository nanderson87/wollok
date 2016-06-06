package org.uqbar.project.wollok.tests.codeGenerator

import org.junit.Test
import org.uqbar.project.wollok.codeGenerator.model.types.NativeTypesEnum

class ClassTest extends AbstractWollokCodeGeneratorTypeInfererTest {
	
	@Test
	def void simpleClass() {
		'''
			class MiClase {
				method xx(){
					return 32
				}
			}

			program p {
				var x = new MiClase()
				return x.xx()
			}
		'''.parseAndPerformAnalysis

		assertClassType(pgm.resolveWollokClass("__synthetic0.MiClase"), pgm.variables.get("x"))
		assertNativeTypeEquals(NativeTypesEnum.INT, pgm.returnVariable)
	}

}
