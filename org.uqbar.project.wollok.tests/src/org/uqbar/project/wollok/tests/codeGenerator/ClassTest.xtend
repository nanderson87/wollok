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

		assertClassType(pgm.resolveWollokClass("MiClase".classNameWithSyntheticPackage), pgm.variables.get("x"))
		assertNativeTypeEquals(NativeTypesEnum.INT, pgm.returnVariable)
	}

	@Test
	def void classWithSubclasses() {
		'''
			class SuperClass {
				method yy(){
					return 32
				}
			}

			class MiClase inherits SuperClass{
				method xx(){
					return self.yy()
				}
			}

			program p {
				var x = new MiClase()
				return x.xx()
			}
		'''.parseAndPerformAnalysis

		assertClassType(pgm.resolveWollokClass("MiClase".classNameWithSyntheticPackage), pgm.variables.get("x"))
		assertNativeTypeEquals(NativeTypesEnum.INT, pgm.returnVariable)
	}

	@Test
	def void methodInSuperclass() {
		'''
			class SuperClass {
				method yy(){
					return 32
				}
				method zz(){
					return "asdad"
				}
			}

			class MiClase inherits SuperClass{
				method xx(){
					return self.yy()
				}
			}

			program p {
				var x = new MiClase()
				return x.zz()
			}
		'''.parseAndPerformAnalysis

		assertClassType(pgm.resolveWollokClass("MiClase".classNameWithSyntheticPackage), pgm.variables.get("x"))
		assertNativeTypeEquals(NativeTypesEnum.STRING, pgm.returnVariable)
	}

}
