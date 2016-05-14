package org.uqbar.project.wollok.codeGenerator.model.types;

public enum NativeTypesEnum {
	DOUBLE{
		public NativeTypesEnum max(NativeTypesEnum other) {
			if(other == DOUBLE || other == INT)return this;
			return super.max(other);
		}
	},

	INT {
		public NativeTypesEnum max(NativeTypesEnum other) {
			if(this==other)return this;
			if(other==DOUBLE)return other;
			return super.max(other);
		}
	}
	;

	public NativeTypesEnum max(NativeTypesEnum other) {
		throw new RuntimeException("There is not coercion between " + this.toString() + " and " + other.toString());
	}
}
