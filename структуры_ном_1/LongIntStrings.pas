{������ ��� ������ � �������� ����� �������, ������� ������������ ��� ������}
unit LongIntStrings;

interface

uses
  SysUtils;

const
  zero = Ord('0');

type
  TLong = string;

  //������� ��� ����� �����.
  function Input_number(txt: string): TLong;
  //��������� �����. ��������� - �����������, ����������.
  function Sign_Sub(dim, sub: TLong): TLong;
  //�������� �����. ��������� - 2 ���������.
  function Sign_Sum(t1, t2: TLong): TLong;
  //���������. ��������� - 2 ���������
  function Sign_Multi(m1, m2: TLong): TLong;
  //������������� �������. ��������� - �������, ��������.
  function Sign_Div(dvd, dvr: TLong): TLong;
  //������� �� �������������� �������. ��������� - �������, ��������.
  function Sign_Mod(dvd, dvr: TLong): TLong;


implementation

//��������� �������� ���������� ����� � ������ �����
procedure TrimLeft_Zero(var s: TLong);
var count, i: integer;
begin
  count := 1;
  while (count <= Length(s)) and (s[count] = '0') do  //������� ������ �������, ��� ��������� ������
    Inc(count);
  if count = Length(s) + 1  //���� �� �� ����� ��������� ����, �� ��������� ������ ���� ����
  then s := '0'
  else Delete(s, 1, count - 1);  //����� �� ������� ������ count - 1 ����, ��� ��� ��� - ���������� ����
end;


//������� �������� ������������ �������� ������ � ���������� �� � ������������ ����
//(���������� ���������� �����, ����� �������)
function Check_string(var s: TLong): Boolean;
var i: integer;
    sgn: char;
begin
  Trim(s); //������ ������� ����� � ������
  result := (s <> '') and (s[1] in ['-', '+', '0'..'9']);
  if result  //�������� � �������� �������, ������� ���������� �� ����� ��� �����.
  then
    if s[1] in ['-', '+']
    then
      begin
        sgn := s[1];
        Delete(s, 1, 1);
        TrimLeft_Zero(s);
        if s = '0'      //������ ���������� ���� � ������� ������ ����, ������ �����,
        then result := False   //��� ������������ ��� 0 �� ������, ���� ���� �� �����
        else
          if sgn = '-'
          then s := sgn + s;
      end
    else
        TrimLeft_Zero(s); //������� ���� � ������, ������� ���� ������� ��� �����

    //������� �� 2 ������� ���������� ��������� ������ �� ������� ��������, ������� �� �������� �������:
    i := 2;
    while (i <= Length(s)) and result do
    begin
      result := s[i] in ['0'..'9'];
      inc(i);
    end;

end;

//������� ��� ����� �����
function Input_number(txt: string): TLong;
begin
  writeln(txt);
  readln(result);
  while not Check_string(result) do
  begin
    writeln('������, ��������� ����.');
    Readln(result);
  end;

end;

//��������� ��� ������������ ���� ���� �����
procedure Equal_length(var s1, s2: TLong);
var zero_st: string;
    dfr: integer;
    i: Integer;
begin
  zero_st:='';
  dfr := Length(s1) - Length(s2); //������� � ������
  for i:= 1 to abs(dfr) do        //������ ������ �����, ����� �������� �� � ������� �� ����
        zero_st := zero_st + '0';

  if dfr > 0
  then s2 := zero_st + s2
  else
    if dfr < 0
    then s1 := zero_st + s1;
end;


//����������� ��������
function Uns_Sum(t1, t2: TLong): TLong;
var i, cur: integer;
    mmr: integer;
begin
  result := '';
  mmr := 0; //���������� ��� ����������� �������� �������
  Equal_length(t1, t2);
  for i:= Length(t1) downto 1 do
  begin
    cur := Ord(t1[i]) + Ord(t2[i]) - 2 * zero + mmr; //���������� ����� 2 ���� �������
    result:= chr(Ord((cur mod 10 + zero))) + result;  //����� ��, ��� �������� � ��������
    mmr := cur div 10;     //������� ���������� �� �������� ��������
  end;

  if mmr <> 0
  then Result := chr(mmr + zero) + result; //������������ ��, ��� ����� �������� � ������.
end;

//������ �����
function SAbs(s: TLong): TLong;
begin
  if s[1] in ['+', '-'] //���� �� ������, �� ������� ���, ����� ���������� ���� �����
  then Result := Copy(s, 2, Length(s) - 1)
  else Result := s;
end;

//���� �����
function sign(s: TLong): Integer;
begin
  if (s[1] = '+') or (s[1] in ['1'..'9'])
  then result := 1
  else
    if (s[1] = '-')
    then result := -1
    else result := 0;
end;

//����������� ����� � ������
function Sign_Abs(s: TLong; var sgn: integer): TLong;
begin
  result := SAbs(s);
  sgn := Sign(s);
end;

//��������� ���� ����� ��� �����. 1 - ������ ������, 0 - �����, -1 - ������ ������.
function Compare(s1, s2: TLong): integer;
var sgn1, sgn2: integer;
begin
  s1 := Sign_Abs(s1, sgn1);    //�������� ����� �� �����
  s2 := Sign_Abs(s2, sgn2);
  Equal_length(s1, s2); //��� �������� ��������� ����������� ����� �����, �������� ����� �������� ����������� ������.
  if (sgn1 > sgn2)
  then result := 1
  else
    if (sgn1 < sgn2)
    then result := -1
    else
      begin          //��� ���������� ������ ���� ����� ���������� �� ������
        if (s1 > s2)
        then result := 1
        else
          if (s1 < s2)
          then result := -1
          else result := 0;

        if (sgn1 = -1)   //���� ����� �������������, �� ��� ������ ������, ��� ������ �����, ������� ��������� ������ �� ���������������
        then result := -result;
      end;

end;


//��������� �� �������� ��������
Function Uns_Sub(dim, sub: TLong): TLong;
var i, mmr, cur: integer;
begin
  result := '';
  Equal_length(dim, sub); //����������� ����� ������������ � �����������
  mmr := 0;
  for i := Length(dim) downto 1 do
  begin
    cur := ord(dim[i]) - ord(sub[i]) + 10 - mmr;
    result := chr(cur mod 10 + zero) + result;
    mmr := 1 - cur div 10;
  end;
  TrimLeft_Zero(result); //������� ���������� ����, ������� ����� ������������ � ���� ��������.
end;


//����� �� ������
function Sign_Sum(t1, t2: TLong): TLong;
var sgn, sgn1, sgn2: Integer;
begin
  t1 := Sign_Abs(t1, sgn1);  //��������� ������ �� ������
  t2 := Sign_Abs(t2, sgn2);
  if (sgn1 * sgn2 >= 0)
  then
    begin          //���� ����� ����� ������� ��� ���� �� ��� ����� ����
      result := Uns_Sum(t1, t2); //���������� ������, ������ ������� �����, ���� ���� �� ��� ���� �������������
      if (sgn1 = -1) or (sgn2 = -1)
      then result := '-' + result;
    end
  else
    begin    //���� ����� ������, �� �� �������� �� ������ �������� ������� � ������ ���� ��������
      sgn := Compare(t1, t2);
      if sgn = 1
      then
        begin
          result := Uns_Sub(t1, t2);
          if sgn1 = -1
          then result := '-' + result;
        end
      else
        if sgn = -1
        then
          begin
            result := Uns_Sub(t2, t1);
            if sgn2 = -1
            then result := '-' + result;
          end
        else result := '0';
    end;
end;

//��������� �� ������
function Sign_Sub(dim, sub: TLong): TLong;
var sgn, sgn1, sgn2: integer;
begin
  if sub[1] = '-'     //a - b = a + (-b), ������ ��������� � ��������
  then Delete(sub, 1, 1)
  else
    if sub <> '0'
    then sub := '-' + sub;
  result := Sign_Sum(dim, sub);
end;

//��������� ������ �� �����
function Multi_by_digit(s: TLong; digit: integer): TLong;
var i: integer;
    cur, mmr: Integer;
begin
  result := '';
  mmr := 0; //���������� ��� ����������� �������� �������
  for i := Length(s) downto 1 do
  begin
    cur := (Ord(s[i]) - zero) * digit + mmr;
    Result := chr(cur mod 10 + zero) + result;
    mmr := cur div 10;
  end;

  Result := chr(mmr + zero) + result;
  TrimLeft_Zero(result);
end;

//����������� ���������
function Uns_Multi(m1, m2: TLong): TLong;
var cur, zeros: TLong;
    i: integer;
begin
  Result := '0';
  if (m1 <> '0') and (m2 <> '0')
  then
    begin
      zeros := '';
      for i := Length(m2) downto 1 do
      begin
        cur := Multi_by_digit(m1, Ord(m2[i]) - zero); //�������� ������ ��������� �� ��������� ����� �������
        if (cur <> '0')
        then
          begin
            cur := cur + zeros;
            result := Uns_Sum(result, cur);
          end;
        zeros := zeros + '0';   //����������� ����, ��� ��� ��������� "� �������"
      end;
    end;
end;

//��������� �� ������
function Sign_Multi(m1, m2: TLong): TLong;
var sgn: integer;
begin
  sgn := sign(m1) * sign(m2);
  if sgn = 0
  then result := '0'
  else
    if sgn = 1
    then result := Uns_Multi(SAbs(m1), SAbs(m2))
    else result := '-' + Uns_Multi(SAbs(m1), SAbs(m2));

end;

//������� �������� ����������� ������� (�� ���� ������ ������)
function Try_Div(dvr: TLong): Boolean;
begin
  result := dvr <> '0';
end;


//������� ������� ����� ��� ������� �������� ��������
function Select_Digit(dvd, dvr: TLong): char;
var digit: integer;
begin
  digit := 9;
  while (digit > 0) and (Compare(Multi_by_digit(dvr, digit), dvd) = 1) do
    Dec(digit);
  result := chr(digit + zero);
end;

//������������� ������� ��� �����
function Uns_Div(dvd, dvr: TLong): TLong;
var cpy: TLong;  //����������, ��� ����� �������� ������� ������� (��������� s1)
    cur_dgt: char;
begin

  if Compare (dvd, dvr) = -1    //���� ������� ������ ��������, �� ����� ���������� ����
  then result := '0'
  else
    begin
      cpy := Copy(dvd, 1, Length(dvr) - 1);  //�������� ����� ����� ��������, ����� ���������� ����� �� ������ ���� ������ �������� �� 1
      Delete(dvd, 1, Length(dvr) - 1);  //������� ������ ����� �� ��������
      result := '';
      while dvd <> '' do
      begin
        cpy := cpy + dvd[1];  //�������� ��������� ����� �� ��������
        Delete(dvd, 1, 1);
        TrimLeft_zero(cpy);   //�� ������, ����� �� ������ �������� ������� ����� �� �������� ��� �������
        cur_dgt := Select_Digit(cpy, dvr);  //��������� ��������� ����� � ��������� �� � ���������
        result := result + cur_dgt;
        cpy :=  Uns_Sub(cpy, Uns_Multi(dvr, cur_dgt)); //���������, ��� �������� � ��������������� ����� �����
      end;
      TrimLeft_Zero(result);
    end;

end;

//������������� ������� �� ������
function Sign_Div(dvd, dvr: TLong): TLong;
var sgn: integer;
begin
  if dvr = '0'
  then
    begin
      raise Exception.Create('������, ������� �� 0');
    end
  else
  begin
    sgn := sign(dvd) * sign(dvr); //�������� �� ������� ����� ��� � ��� ���������
    dvd := SAbs(dvd);
    dvr := SAbs(dvr);
    if sgn = 0
    then result := '0'
    else
      if sgn = 1
      then result := Uns_Div(dvd, dvr)
      else result := '-' + Uns_Div(dvd, dvr);

  end;


end;


//������� �� �������������� ������� �� ������
function Sign_Mod(dvd, dvr: TLong): TLong;
begin                                                       //������� = �������� * ������� + �������
  result := Sign_Sub(dvd, Sign_Multi(Sign_Div(dvd, dvr), dvr));   //������� = ������� - �������� * �������
end;


end.
