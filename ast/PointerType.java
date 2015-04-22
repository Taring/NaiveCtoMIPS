package compiler.ast;

public class PointerType extends Type {
    public Type baseType;

	public Identifier ID;

    public PointerType() {
        baseType = null;
    }

    public PointerType(Type baseType) {
        this.baseType = baseType;
    }
    
    public Pointer
    
}
