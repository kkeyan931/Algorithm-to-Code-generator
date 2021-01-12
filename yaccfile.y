%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>


int yylex();
FILE *cfp;
int i=0,j,g;
char sym[100][100];
char str[100];
char* align(char str);
void yyerror(const char *s);
void print();
char ints[]={'%','d','\0'};
char floats[]={'%','f','\0'};
char chars[]={'%','c','\0'};
char doubles[]={'%','l','d','\0'};
char name[100];


void print()
{
  char temp[100];
  FILE *rfp;
  rfp=fopen("code.c","r");
  while(fgets(temp,sizeof(temp),rfp)!=NULL)
  {
    printf("%s",temp);
  }

  fclose(rfp);
}

void update(char s[20])
{
  strcpy(sym[i],s);
  i++;
}


int check(char s[20])
{
  int flag=0;
  for(j=0;j<i;j++)
  {
  if(!strcmp(sym[j],s))
    flag=1;
  }
    return flag;
}
void getspec(char s[20])
{
  //char str1[100];
  if(!strcmp(s,"int"))
    strcpy(str,ints);
  else if(!strcmp(s,"float"))
    strcpy(str,floats);
  else if(!strcmp(s,"char"))
    strcpy(str,chars);
  else if(!strcmp(s,"double"))
    strcpy(str,doubles);
}
%}
%union{
char code[100];
}
%token BEG END ASSIGN TO PRINT SCAN COMMA OPEN CLOSE IF ENDIF THEN ELSE WHILE ENDWHILE DO RETURN ENDELSE
%token START_PROCEDURE END_FUNCTION ENDDOWHILE FOR REPEAT ENDFOR FROM READ QUOTE
%token<code> VAR NUM
%token<code> DATATYPE
%token<code> RELOP LOGOP BOOL
%token<code> MD AS Q
%token<code> NAME_PROCEDURE

%%
START :  BEG {fprintf(cfp,"#include<stdio.h>\nint main()\n{\n");} CODE END {fprintf(cfp,"\n}\n");} CODE
      ;      
CODE : STMT  {fprintf(cfp,";\n");}
     | CODE STMT {fprintf(cfp,";\n");}
     | ST
     | CODE ST
     |
     ;


STMT : EXPR
     | DEC		
     | INIT	
     ;

ST   : IF {fprintf(cfp,"if(");} CON THEN{fprintf(cfp,"\n{");} CODE ENDIF {fprintf(cfp,"\n}");}
     | ST ELSE {fprintf(cfp,"else {\n");} CODE ENDELSE {fprintf(cfp,"\n}\n");}
     //| IF { fprintf(cfp,"if(");} CON THEN{fprintf(cfp,")\n{");} STMT ELSE { fprintf(cfp,"}\nelse\n{");} STMT ENDIF {fprintf(cfp,"\n}");}
     | WHILE{fprintf(cfp,"while(");} EXPR THEN{fprintf(cfp,"){\n");} CODE ENDWHILE {fprintf(cfp,"}\n");}
    // | DO{fprintf(cfp,"do\n{");} CODE WHILE{fprintf(cfp,"\n}while(");} EXPR ENDDOWHILE {fprintf(cfp,");");}
     | START_PROCEDURE NAME_PROCEDURE OPEN{fprintf(cfp,"void %s(",$2); } parameter_list CLOSE{fprintf(cfp,")\n{\n");} CODE END_FUNCTION {fprintf(cfp,"}\n");}
     | FOR{fprintf(cfp,"for(");} INIT REPEAT{fprintf(cfp,"\n{\n");} CODE ENDFOR {fprintf(cfp,"}\n");}  
     | PR
     | SC
     ;	

parameter_list: VAR DATATYPE{fprintf(cfp,"%s %s",$2,$1);}
               | parameter_list COMMA VAR DATATYPE{fprintf(cfp,",%s %s",$4,$3);}

EXPR : E RELOP{fprintf(cfp,"%s",$2); } E
     | E LOGOP{fprintf(cfp,"%s",$2); } E  
     | E		
     ;

E : E AS{fprintf(cfp,"%s",$2);} T  
  | T	
  ;

T : T MD{fprintf(cfp,"%s",$2);} F    
  | F 
  ;

F : VAR {fprintf(cfp,"%s",$1);} 
  | NUM	{fprintf(cfp,"%s",$1);} 
  | OPEN E CLOSE
  ;

N : VAR{fprintf(cfp,"%s ",$1);} N
  |
  ;

DEC : ASSIGN OPEN VAR DATATYPE CLOSE { update($3); fprintf(cfp,"%s %s",$4,$3); };
  
INIT : ASSIGN VAR TO NUM {g=check($2); if(g==1)fprintf(cfp,"%s = %s",$2,$4); else exit(0);}
     | ASSIGN VAR TO VAR { fprintf(cfp,"%s = %s",$2,$4); }
     | VAR FROM NUM TO NUM {if($3<$5){fprintf(cfp,"%s = %s ; %s <= %s ; %s ++)",$1,$3,$1,$5,$1);}else{fprintf(cfp,"%s = %s ; %s >= %s ; %s --)",$1,$3,$1,$5,$1);}}
     | VAR Q{fprintf(cfp,"%s %s",$1,$2);} E 
     ;

DATA : DATATYPE COMMA VAR{g=check($3); getspec($1); if(g==1){fprintf(cfp,"%s ",str); strcat(name,$3);} else exit(0); } DATA
     |
     ;

PR : PRINT DATATYPE COMMA VAR {g=check($4); getspec($2); if(g==1)fprintf(cfp,"printf(\"%s \",%s);\n",str,$4); else exit(0); }
   | PRINT{fprintf(cfp,"printf(\"");} QUOTE N DATA N QUOTE{fprintf(cfp,"\"%s);\n",name); strcpy(name,"");}
   //| PRINT{fprintf(cfp,"fprintf(cfp,\"");} QUOTE N QUOTE{fprintf(cfp,"\");");} 
   ;

SC : READ DATATYPE COMMA VAR {g=check($4); getspec($2); if(g==1)fprintf(cfp,"scanf(\"%s\",&%s);\n",str,$4); else exit(0); }
   ;

CON : VAR RELOP VAR { fprintf(cfp,"%s %s %s)",$1,$2,$3); } 
    | VAR RELOP NUM { fprintf(cfp,"%s %s %s)",$1,$2,$3); }
    | VAR LOGOP VAR { fprintf(cfp,"%s %s %s)",$1,$2,$3); }
    | BOOL { fprintf(cfp,"%s",$1); }
    ;


 

%%


int yywrap()
{
  return 1;
}
void yyerror(const char* arg)
{
	fprintf(cfp,"%s\n",arg);
}

//#include"lex.yy.c"

int main()
{

  extern FILE *yyin;
  
  
  yyin=fopen("inputnew1.txt","r");

  print();

  cfp=fopen("code.c","w");

  yyparse();

  fclose(cfp);

  int option;

  printf("\n\nTo run the program enter 1 : else 2\n");

  scanf("%d",&option);

  if(option==1)
  {
    system("gcc -o code code.c");
    system("./code");
  }
  else
    exit(0);
  return 0;

}








