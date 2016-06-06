package org.uqbar.project.wollok.tests.codeGenerator

import org.junit.Test
import org.uqbar.project.wollok.codeGenerator.model.types.NativeType
import org.uqbar.project.wollok.codeGenerator.model.types.NativeTypesEnum
import org.uqbar.project.wollok.codeGenerator.model.types.NullType
import org.uqbar.project.wollok.codeGenerator.model.types.NumericType
import org.uqbar.project.wollok.codeGenerator.model.types.UnionType

class UnionTypeTest extends AbstractWollokCodeGeneratorTypeInfererTest {
	
	@Test
	def void simpleType() {
		'''
			program p {
				var x = 2
				x = 3
				return x
			}
		'''.parseAndPerformAnalysis

		assertTypeIs(NativeType, pgm.returnVariable)
		assertNativeTypeEquals(NativeTypesEnum.INT, pgm.returnVariable)
	}

	@Test
	def void simpleUnionType() {
		'''
			program p {
				var x = 2
				x = "asd"
				return x
			}
		'''.parseAndPerformAnalysis

		assertTypeIs(UnionType, pgm.returnVariable)
		assertUnionTypeNatives(#{NativeTypesEnum.INT, NativeTypesEnum.STRING}, pgm.returnVariable)
	}

	@Test
	def void ifOutputUnionType() {
		'''
			program p {
				const x = 1
				return if (x > 3) 
					4
				else
					"asd"
				
			}
		'''.parseAndPerformAnalysis

		assertTypeIs(UnionType, pgm.returnVariable)
		assertUnionTypeNatives(#{NativeTypesEnum.INT, NativeTypesEnum.STRING}, pgm.returnVariable)
	}

	@Test
	def void ifOutputWithoutElseUnionType() {
		'''
			program p {
				const x = 1
				return if (x > 3){ 
					4
				}
			}
		'''.parseAndPerformAnalysis

		assertTypeIs(UnionType, pgm.returnVariable)
		assertUnionType(#{new NumericType(NativeTypesEnum.INT), new NullType()}, pgm.returnVariable)
	}


	@Test
	def void ifOutputWithBlockUnionType() {
		'''
			program p {
				const x = 1
				return if (x > 3){ 
					4
				}else{
					"asd"
				}
			}
		'''.parseAndPerformAnalysis

		assertTypeIs(UnionType, pgm.returnVariable)
		assertUnionTypeNatives(#{NativeTypesEnum.INT, NativeTypesEnum.STRING}, pgm.returnVariable)
	}
}
