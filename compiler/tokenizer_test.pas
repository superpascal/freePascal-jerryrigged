{
    FreePascal Tokenizer Test Tool
    
    This program uses FPC's scanner to tokenize a Pascal file
    and output tokens in a parseable format for comparison.
    
    Usage: tokenizer_test input.pas > output.txt
}
program tokenizer_test;

{$mode objfpc}{$H+}

uses
  SysUtils,
  scanner,
  tokens,
  globals,
  verbose,
  finput;

var
  input_file: string;
  scanner_file: tscannerfile;
  token_count: longint;

procedure PrintToken(t: ttoken; const pattern: string);
begin
  case t of
    NOTOKEN: write('NOTOKEN');
    _ID: write('ID:', pattern);
    _INTCONST: write('INTCONST:', pattern);
    _REALNUMBER: write('REALNUMBER:', pattern);
    _CSTRING: write('CSTRING:', pattern);
    _CCHAR: write('CCHAR:', pattern);
    _PLUS: write('PLUS');
    _MINUS: write('MINUS');
    _STAR: write('STAR');
    _SLASH: write('SLASH');
    _EQ: write('EQ');
    _GT: write('GT');
    _LT: write('LT');
    _GTE: write('GTE');
    _LTE: write('LTE');
    _NE: write('NE');
    _ASSIGNMENT: write('ASSIGNMENT');
    _SEMICOLON: write('SEMICOLON');
    _COMMA: write('COMMA');
    _COLON: write('COLON');
    _LKLAMMER: write('LPAREN');
    _RKLAMMER: write('RPAREN');
    _LECKKLAMMER: write('LBRACKET');
    _RECKKLAMMER: write('RBRACKET');
    _POINT: write('POINT');
    _POINTPOINT: write('POINTPOINT');
    _EOF: write('EOF');
    else
      write('TOKEN:', Ord(t));
  end;
  writeln(' [', current_scanner.line_no, ':', current_scanner.inputpointer - current_scanner.inputstart, ']');
end;

begin
  if ParamCount < 1 then
  begin
    writeln('Usage: tokenizer_test <input.pas>');
    halt(1);
  end;
  
  input_file := ParamStr(1);
  
  // Initialize scanner
  InitScanner;
  
  try
    // Create scanner for input file
    scanner_file := tscannerfile.Create(input_file, false);
    set_current_scanner(scanner_file);
    
    if not scanner_file.openinputfile then
    begin
      writeln('Error: Could not open file: ', input_file);
      halt(1);
    end;
    
    token_count := 0;
    
    // Tokenize until EOF
    repeat
      scanner_file.readtoken(true);
      PrintToken(token, pattern);
      Inc(token_count);
    until token = _EOF;
    
    writeln('Total tokens: ', token_count);
    
  finally
    scanner_file.Free;
    DoneScanner;
  end;
end.

