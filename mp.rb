class MaquinaDePilha
  
  def initialize

	@debug = false

    @labels = {}
    @pilha = []
	@count = -1
    @pointer = -1
    @mem = {}
    @instrucoes = []
    i = 0
    File.open(ARGV[0],'r').each_line do |line|
      @labels[line.split(/\s/)[1]] = i if line =~ /^label/
      @instrucoes.push(line.split(/\s/))
      i+=1
    end
	
	@debug = true if ARGV[1] == "-d"
    
    executa
    
  end
  
  def executa
    while(true)
      @pointer+=1
	  @count+=1
      i = @instrucoes[@pointer]
      break if i[0] == "fim"
      eval("#{i[0]} '#{i[1]}'")
	  puts "Instrucao #{@count}: #{i}" if @debug
	  puts "#{@pilha} #{@mem}" if @debug
	  $stdin.gets if @debug
    end
  end

  def read(i)
    @pilha.push($stdin.gets.to_i)
  end
  
  def push(a)
    @pilha.push(a.to_i)
  end
  
  def pop(a)
    @pilha.pop
  end
  
  def add(a)
    @pilha.push(@pilha.pop + @pilha.pop)
  end
  
  def sub(a)
    v1 = @pilha.pop
    v2 = @pilha.pop
  @pilha.push (v1 - v2)
  end

  def store(a)
    @mem[a] = @pilha.pop
  end

  def load(a)
     @pilha.push(@mem[a])
  end
  
  def print(a)
    puts @pilha.last
  end
  
  def goto(a)
    @pointer = @labels[a]
  end
  
  def gotof(a)
    @pointer = @labels[a] unless @pilha.pop    
  end
  
  def gotot(a)
    @pointer = @labels[a] if @pilha.pop    
  end
  
  def eq(a)
	#Verifica se o topo da pilha é igual a zero
    @pilha.push (@pilha.pop == 0)
  end
  
  def eqq(a)
	#Verifica se os dois primeiros elementos da pilha são iguais
	a = @pilha.pop
	b = @pilha.pop
    @pilha.push (a == b)
	puts "[Testando #{a} == #{b} => #{a==b}]" if @debug
  end
  
  def ne(a)
	#Verifica se o topo da pilha é diferente de zero
    @pilha.push (@pilha.pop != 0)
  end
  
  def gt(a)
	#Maior ou igual
	a = @pilha.pop
	b = @pilha.pop
    @pilha.push (a > b)
	puts "[Testando #{a} > #{b} => #{a>b}]" if @debug
  end
  
  def ge(a)
	#Maior ou igual a
	a = @pilha.pop
	b = @pilha.pop
    @pilha.push (a >= b)
	puts "[Testando #{a} >= #{b} => #{a>=b}]" if @debug
  end
  
  def lt(a)
	#Menor que
	a = @pilha.pop
	b = @pilha.pop
    @pilha.push (a < b)
	puts "[Testando #{a} < #{b} => #{a<b}]" if @debug
  end
  
  def le(a)
	#Menor ou igual a
	a = @pilha.pop
	b = @pilha.pop
    @pilha.push (a <= b)
	puts "[Testando #{a} <= #{b} => #{a<=b}]" if @debug
  end
  
  def label(a)
  end
  
end

MaquinaDePilha.new
