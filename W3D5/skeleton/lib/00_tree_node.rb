class PolyTreeNode
    attr_reader :children,  :value
    attr_accessor :parent
    
    def initialize(value)
        @value = value
        @parent = nil 
        @children = [] 
    end

    def add_child(child)
        if @children.include?(child)
            raise ArgumentError.new "already child"
        end

        if !child.parent=self
            @children << child
            child.parent = self
        end
    end

    def remove_child(child)
        if !@children.include?(child)
            raise ArgumentError.new "not our child"
        end
        @children.delete(child)
        child.parent = nil
    end

    def parent=(instance_of_PolyTreeNode)
    
        if @parent != instance_of_PolyTreeNode && @parent != nil && instance_of_PolyTreeNode != nil 
            @parent.children.delete(self) #delete from old parent
            @parent = instance_of_PolyTreeNode #reassing parent
            @parent.children << self if !@children.include?(self) #add to new parent children

        elsif @parent != instance_of_PolyTreeNode && @parent == nil
            @parent = instance_of_PolyTreeNode #reassing parent
            @parent.children << self if !@children.include?(self)#add to new parent children
        elsif @parent != instance_of_PolyTreeNode && instance_of_PolyTreeNode == nil
            @parent = nil
        end
    end

    def dfs(target)
        #target = node.value
        return self if self.value == target
        return nil if self.children.length == 0
        p self.value
        stack = []
        self.children.each do |el|
            stack.push(el)
        end
        
        node = stack.pop
        
        node.dfs(target)   
    end
end


root = PolyTreeNode.new("root")
child_1 = PolyTreeNode.new("a")
child_2 = PolyTreeNode.new("b")
root.add_child(child_1)
root.add_child(child_2)

p root.dfs("a")
