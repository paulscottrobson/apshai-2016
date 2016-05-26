import re,os,sys

# ***************************************************************************************************************************************************
#															Class which tracks PET Basic tokens
# ***************************************************************************************************************************************************
class DeTokeniser:
	def __init__(self):
		self.tokens = {}																		# Pet BASIC tokens. 
		tokenText = """
			80:end,81:for,82:next,83:data,84:input#,85:input,86:dim,87:read,88:let,89:goto,8a:run,8b:if,8c:restore,8d:gosub,8e:return,8f:rem,
			90:stop,91:on,92:wait,93:load,94:save,95:verify,96:def,97:poke,98:print#,99:print,9a:cont,9b:list,9c:clr,9d:cmd,9e:sys,9f:open,
			a0:close,a1:get,a2:new,a3:tab(,a4:to,a5:fn,a6:spc(,a7:then,a8:not,a9:step,aa:+,ab:-,ac:*,ad:/,ae:^,af:and,b0:or,b1:>,b2:=,
			b3:<,b4:sgn,b5:int,b6:abs,b7:usr,b8:fre,b9:pos,ba:sqr,bb:rnd,bc:log,bd:exp,be:cos,bf:sin,c0:tan,c1:atn,c2:peek,c3:len,
			c4:str$,c5:val,c6:asc,c7:chr$,c8:left$,c9:right$,ca:mid$,cb:go,ff:pi
		""".replace(" ","").replace("\t","").replace("\n","")
		for pair in tokenText.split(","):														# convert to token value => text name.
			parts = pair.split(":")
			self.tokens[int(parts[0],16)] = parts[1].upper()

		self.charCodes = {}																		# Pet character equivalents for non PETSCII
		self.charCodes[192] = "HBar"
		self.charCodes[221] = "VBar"
		self.charCodes[147] = "Clr"
		self.charCodes[17] = "Down"
		self.charCodes[29] = "Right"
		self.charCodes[14]= "Home"

	def isToken(self,code):																		# True if token exists
		return code in self.tokens	
	def getToken(self,code):																	# Get token value
		return self.tokens[code]
	def getCharacterCode(self,code):															# Convert character code to displayable format
		if code in self.charCodes:
			return "{"+self.charCodes[code]+"}"
		else:
			return "{"+str(code)+"}"
	def getREMToken(self):																		# Get token for REM.
		return 0x8F

class BaseRenderer:
	pass

# ***************************************************************************************************************************************************
#														Keyword Object
# ***************************************************************************************************************************************************

class KeywordToken(BaseRenderer):
	def __init__(self,token):
		self.token = token 
	def renderText(self,renderInfo):
		token = self.token[0].upper()+self.token[1:].lower()
		if len(token) > 0:
			token = " "+token+" "
		return token

# ***************************************************************************************************************************************************
#														Character Object
# ***************************************************************************************************************************************************

class CharacterToken(BaseRenderer):
	def __init__(self,character):
		self.character = character 
	def renderText(self,renderInfo):
		return self.character

# ***************************************************************************************************************************************************
#													  Quoted String Object
# ***************************************************************************************************************************************************

class StringToken(BaseRenderer):
	def __init__(self,chars,deTokeniser):
		self.characters = ""
		for c in chars:
			oc = ord(c)			
			if oc == 32:
				c = "~"
			elif oc >= 32 and oc < 127:			
				c = c.lower()
			elif oc >= 65+128 and oc <= 65+25+128:
				c = chr(oc-128)
			else:
				c = deTokeniser.getCharacterCode(oc)
			self.characters = self.characters + c 

	def renderText(self,renderInfo):
		return '"'+self.characters+'"'

# ***************************************************************************************************************************************************
#														Variable Object
# ***************************************************************************************************************************************************

class VariableToken(BaseRenderer):
	def __init__(self,variable):
		self.variable = variable.lower()
	def renderText(self,renderInfo):
		return self.variable.lower()

# ***************************************************************************************************************************************************
#														Linenumber Object
# ***************************************************************************************************************************************************

class LineNumberToken(BaseRenderer):
	def __init__(self,lineNumber):
		self.lineNumber = lineNumber
	def renderText(self,renderInfo):
		return "[{0}]".format(self.lineNumber)

# ***************************************************************************************************************************************************
#														Statement Object
# ***************************************************************************************************************************************************

class Statement(BaseRenderer):
	def __init__(self,statement,deTokeniser):
		self.tokens = [] 																		# all tokens in this statement
		statement = statement.strip()
		while statement != "":																	# more to render.
			if deTokeniser.isToken(ord(statement[0])):											# token
				self.tokens.append(KeywordToken(deTokeniser.getToken(ord(statement[0]))))		# add a keyword token
				isGoKeyword = ord(statement[0]) == 0x89 or ord(statement[0]) == 0x8D			# check if goto/gosub
				statement = statement[1:].strip() 												# remove, and strip.
				if isGoKeyword:
					while statement != "" and statement[0] >= "0" and statement[0] <= "9":		# while there's a line number
						line = re.match("^(\d+)",statement).group(1)							# get line number
						statement = statement[len(line):].strip()								# remove the line number
						self.tokens.append(LineNumberToken(int(line)))							# add the token
						if statement != "" and statement[0] == ",":								# , seperated numbers
							self.tokens.append(CharacterToken(","))
							statement = statement[1:]

			elif statement[0] == '"':															# Quoted string.
				statement = statement[1:]														# remove opening quote
				n = statement.find('"')															# find closing quote
				n = n if n >= 0 else len(statement)												# if not found, whole statement
				self.tokens.append(StringToken(statement[:n],deTokeniser))						# add string token
				statement = statement[n+1:]														# past closing quote

			elif statement[0] >= 'A' and statement[0] <= 'Z':									# Variable
				m = re.match("^([A-Z][A-Z0-9]?\\$?\\%?\\(?)",statement)							# extract variable
				assert m is not None 
				self.tokens.append(VariableToken(m.group(1).lower()))							# add tokenn
				statement = statement[len(m.group(1)):]											# remove variable
			else:																				# render as a character
				self.tokens.append(CharacterToken(statement[0]))
				statement = statement[1:]
			statement = statement.strip()

	def render(self,renderInfo):
		statementRender = ""
		for t in self.tokens:																	# build line
			statementRender = statementRender + t.renderText(renderInfo)
		statementRender = statementRender.strip()												# remove end spaces
		while statementRender.find("  ") >= 0:													# remove superfluous spaces
			statementRender = statementRender.replace("  "," ")						
		statementRender = statementRender.replace(" (","(").replace("( ","(")

		statementRender = statementRender.replace("~"," ")										# convert string spaces to actual spaces
		if statementRender[:4].lower() == "next":												# next unindents
			renderInfo["indent"] -= 1
		indent = "    " * (renderInfo["indent"]+renderInfo["tempIndent"])						# calculate indent
		if statementRender[:3].lower() == "for":												# for/then indent after
			renderInfo["indent"] += 1
		if statementRender[-4:].lower() == "then":
			renderInfo["tempIndent"] += 1
		renderInfo["handle"].write("      {1}{0}\n".format(statementRender,indent))				# write it

# ***************************************************************************************************************************************************
#														Program Line Object
# ***************************************************************************************************************************************************

class ProgramLine(BaseRenderer):
	def __init__(self,lineNumber,lineSource,deTokeniser):
		self.lineNumber = LineNumberToken(lineNumber) 											# save line number token
		inQuotes = False 																		# replace colons not in quotes with chr(1)
		for i in range(0,len(lineSource)):
			if lineSource[i] == '"':
				inQuotes = not inQuotes
			if lineSource[i] == ':' and not inQuotes:
				lineSource = lineSource[:i]+chr(1)+lineSource[i+1:]
			if lineSource[i] == chr(0xA7):
				lineSource = lineSource[:i+1]+chr(1)+lineSource[i+1:]

		lineSource = lineSource.split(chr(1))													# convert into multiple statements
		self.lineParts = [Statement(x,deTokeniser) for x in lineSource]							# convert to list of objects

	def render(self,renderInfo):
		renderInfo["handle"].write(self.lineNumber.renderText(renderInfo)+"\n")
		for p in self.lineParts:
			p.render(renderInfo)
		renderInfo["tempIndent"] = 0		

# ***************************************************************************************************************************************************
#														Program Object
# ***************************************************************************************************************************************************

class Program(BaseRenderer):
	def __init__(self,programDumpName):
		self.tokeniser = DeTokeniser()															# detokenising object
		source = open(programDumpName,"rb").read(-1)											# read and convert to integers
		source = [ord(s) for s in source]	
		source = source[2:]																		# dump the first two characters
		self.lines = [] 																		# array of lines.

		ptr = 0x401 																			# code starts here.
		while ptr != 0:
			nextInstr = source[ptr+0]+source[ptr+1] * 256										# get link to next
			if nextInstr != 0:																	# if non-zero decode and add instruction
				lineNumber = source[ptr+2]+source[ptr+3]*256									# get current line number
				ptr = ptr + 4 																	# Point to the tokenised code.
				if source[ptr] != self.tokeniser.getREMToken() and lineNumber >= 154:			# Do not do comments or machine code dump.
					line = ""																	# create the line
					while source[ptr] != 0:
						line = line+chr(source[ptr])
						ptr = ptr + 1				
					self.lines.append(ProgramLine(lineNumber,line,self.tokeniser))				# Create a line object
			ptr = nextInstr 																	# go to next instruction.

	def render(self,renderInfo):
		for l in self.lines:																	# render every line
			l.render(renderInfo)

dc = Program("apshai.mem")
dc.render({ "handle":sys.stdout,"indent":0,"tempIndent":0 })
