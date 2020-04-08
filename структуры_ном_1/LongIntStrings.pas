{Модуль для работы с длинными целым числами, которые представлены как строки}
unit LongIntStrings;

interface

uses
  SysUtils;

const
  zero = Ord('0');

type
  TLong = string;

  //Функция для ввода числа.
  function Input_number(txt: string): TLong;
  //Вычитание чисел. Параметры - уменьшаемое, вычитаемое.
  function Sign_Sub(dim, sub: TLong): TLong;
  //Сложение чисел. Параметры - 2 слагаемых.
  function Sign_Sum(t1, t2: TLong): TLong;
  //Умножение. Параметры - 2 множителя
  function Sign_Multi(m1, m2: TLong): TLong;
  //Целочисленное деление. Параметры - делимое, делитель.
  function Sign_Div(dvd, dvr: TLong): TLong;
  //Остаток от целочисленного деления. Параметры - делимое, делитель.
  function Sign_Mod(dvd, dvr: TLong): TLong;


implementation

//Процедура удаления незначащих нулей в начале числа
procedure TrimLeft_Zero(var s: TLong);
var count, i: integer;
begin
  count := 1;
  while (count <= Length(s)) and (s[count] = '0') do  //Находим первую позицию, где ненулевой символ
    Inc(count);
  if count = Length(s) + 1  //Если мы не нашли ненулевых цифр, то оставляем только один ноль
  then s := '0'
  else Delete(s, 1, count - 1);  //Иначе мы удаляем первые count - 1 цифр, так как это - незначащие нули
end;


//Функция проверки корректности введённой строки и приведение ее к стандартному виду
//(отсутствие незначащих нулей, плюса впереди)
function Check_string(var s: TLong): Boolean;
var i: integer;
    sgn: char;
begin
  Trim(s); //Удалим пробелы слева и справа
  result := (s <> '') and (s[1] in ['-', '+', '0'..'9']);
  if result  //Работаем с непустой строкой, которая начинается со знака или цифры.
  then
    if s[1] in ['-', '+']
    then
      begin
        sgn := s[1];
        Delete(s, 1, 1);
        TrimLeft_Zero(s);
        if s = '0'      //Удалив незначащие нули и получив только ноль, делаем вывод,
        then result := False   //что пользователь ввёл 0 со знаком, чего быть не может
        else
          if sgn = '-'
          then s := sgn + s;
      end
    else
        TrimLeft_Zero(s); //Удаляем нули в строке, которая была введена без знака

    //Начиная со 2 символа необходимо проверить строку на наличие символов, которые не являются цифрами:
    i := 2;
    while (i <= Length(s)) and result do
    begin
      result := s[i] in ['0'..'9'];
      inc(i);
    end;

end;

//Функция для ввода числа
function Input_number(txt: string): TLong;
begin
  writeln(txt);
  readln(result);
  while not Check_string(result) do
  begin
    writeln('Ошибка, повторите ввод.');
    Readln(result);
  end;

end;

//Процедура для выравнивания длин двух строк
procedure Equal_length(var s1, s2: TLong);
var zero_st: string;
    dfr: integer;
    i: Integer;
begin
  zero_st:='';
  dfr := Length(s1) - Length(s2); //Разница в длинах
  for i:= 1 to abs(dfr) do        //Создаём строку нулей, чтобы добавить ее к меньшей из двух
        zero_st := zero_st + '0';

  if dfr > 0
  then s2 := zero_st + s2
  else
    if dfr < 0
    then s1 := zero_st + s1;
end;


//Беззнаковое сложение
function Uns_Sum(t1, t2: TLong): TLong;
var i, cur: integer;
    mmr: integer;
begin
  result := '';
  mmr := 0; //Переменная для запоминания старшего разряда
  Equal_length(t1, t2);
  for i:= Length(t1) downto 1 do
  begin
    cur := Ord(t1[i]) + Ord(t2[i]) - 2 * zero + mmr; //Определяем сумму 2 цифр разряда
    result:= chr(Ord((cur mod 10 + zero))) + result;  //Пишем то, что получили в единицах
    mmr := cur div 10;     //Десятки запоминаем на следуюие итерации
  end;

  if mmr <> 0
  then Result := chr(mmr + zero) + result; //Обрабатываем то, что могло остаться в памяти.
end;

//Модуль числа
function SAbs(s: TLong): TLong;
begin
  if s[1] in ['+', '-'] //Если со знаком, то удаляем его, иначе возвращаем само число
  then Result := Copy(s, 2, Length(s) - 1)
  else Result := s;
end;

//Знак числа
function sign(s: TLong): Integer;
begin
  if (s[1] = '+') or (s[1] in ['1'..'9'])
  then result := 1
  else
    if (s[1] = '-')
    then result := -1
    else result := 0;
end;

//Объединение знака и модуля
function Sign_Abs(s: TLong; var sgn: integer): TLong;
begin
  result := SAbs(s);
  sgn := Sign(s);
end;

//Сравнение двух чисел без знака. 1 - первое больше, 0 - равны, -1 - больше второе.
function Compare(s1, s2: TLong): integer;
var sgn1, sgn2: integer;
begin
  s1 := Sign_Abs(s1, sgn1);    //Отделяем знаки от чисел
  s2 := Sign_Abs(s2, sgn2);
  Equal_length(s1, s2); //Для простоты сравнения выравниваем длины чисел, дополняя более короткое незначащими нулями.
  if (sgn1 > sgn2)
  then result := 1
  else
    if (sgn1 < sgn2)
    then result := -1
    else
      begin          //При совпадении знаков двух чисел сравниваем их модули
        if (s1 > s2)
        then result := 1
        else
          if (s1 < s2)
          then result := -1
          else result := 0;

        if (sgn1 = -1)   //Если числа отрицательные, то чем меньше модуль, тем больше число, поэтому результат меняем на противоположный
        then result := -result;
      end;

end;


//Вычитание из большего меньшего
Function Uns_Sub(dim, sub: TLong): TLong;
var i, mmr, cur: integer;
begin
  result := '';
  Equal_length(dim, sub); //Выравниваем длины уменьшаемого и вычитаемого
  mmr := 0;
  for i := Length(dim) downto 1 do
  begin
    cur := ord(dim[i]) - ord(sub[i]) + 10 - mmr;
    result := chr(cur mod 10 + zero) + result;
    mmr := 1 - cur div 10;
  end;
  TrimLeft_Zero(result); //Удаляем незначащие нули, которые могли образоваться в ходе операции.
end;


//Сумма со знаком
function Sign_Sum(t1, t2: TLong): TLong;
var sgn, sgn1, sgn2: Integer;
begin
  t1 := Sign_Abs(t1, sgn1);  //Отделение знаков от модуле
  t2 := Sign_Abs(t2, sgn2);
  if (sgn1 * sgn2 >= 0)
  then
    begin          //Если знаки чисел совпали или одно из них равно нулю
      result := Uns_Sum(t1, t2); //Складываем модули, ставим впереди минус, если одно из них было отрицательным
      if (sgn1 = -1) or (sgn2 = -1)
      then result := '-' + result;
    end
  else
    begin    //Если знаки разные, то из большего по модулю вычитаем меньшее и ставим знак большего
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

//Вычитание со знаком
function Sign_Sub(dim, sub: TLong): TLong;
var sgn, sgn1, sgn2: integer;
begin
  if sub[1] = '-'     //a - b = a + (-b), сводим вычитание к сложению
  then Delete(sub, 1, 1)
  else
    if sub <> '0'
    then sub := '-' + sub;
  result := Sign_Sum(dim, sub);
end;

//Умножение строки на число
function Multi_by_digit(s: TLong; digit: integer): TLong;
var i: integer;
    cur, mmr: Integer;
begin
  result := '';
  mmr := 0; //переменная для запоминания старшего разряда
  for i := Length(s) downto 1 do
  begin
    cur := (Ord(s[i]) - zero) * digit + mmr;
    Result := chr(cur mod 10 + zero) + result;
    mmr := cur div 10;
  end;

  Result := chr(mmr + zero) + result;
  TrimLeft_Zero(result);
end;

//Беззнаковое умножение
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
        cur := Multi_by_digit(m1, Ord(m2[i]) - zero); //Умножаем первый множитель на очередную цифру второго
        if (cur <> '0')
        then
          begin
            cur := cur + zeros;
            result := Uns_Sum(result, cur);
          end;
        zeros := zeros + '0';   //Приписываем нули, как при умножении "в столбик"
      end;
    end;
end;

//Умножение со знаком
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

//Функция проверки возможности деления (на ноль делить нельзя)
function Try_Div(dvr: TLong): Boolean;
begin
  result := dvr <> '0';
end;


//Функция подбора цифры для деления текущего значения
function Select_Digit(dvd, dvr: TLong): char;
var digit: integer;
begin
  digit := 9;
  while (digit > 0) and (Compare(Multi_by_digit(dvr, digit), dvd) = 1) do
    Dec(digit);
  result := chr(digit + zero);
end;

//Целочисленное деление без знака
function Uns_Div(dvd, dvr: TLong): TLong;
var cpy: TLong;  //Переменная, где будет хранится текущее делимое (подстрока s1)
    cur_dgt: char;
begin

  if Compare (dvd, dvr) = -1    //Если делимое меньше делителя, то сразу возвращаем ноль
  then result := '0'
  else
    begin
      cpy := Copy(dvd, 1, Length(dvr) - 1);  //Выбираем левую часть делимого, чтобы полученное число по длинне было меньше делителя на 1
      Delete(dvd, 1, Length(dvr) - 1);  //Удаляем взятую часть из делимого
      result := '';
      while dvd <> '' do
      begin
        cpy := cpy + dvd[1];  //Выбираем очередную цифру из делимого
        Delete(dvd, 1, 1);
        TrimLeft_zero(cpy);   //На случай, когда мы смогли поделить текущее число на делитель без остатка
        cur_dgt := Select_Digit(cpy, dvr);  //Подбираем очередную цифру и добавляем ее в результат
        result := result + cur_dgt;
        cpy :=  Uns_Sub(cpy, Uns_Multi(dvr, cur_dgt)); //Вычисляем, что осталось в рассматриваемой части числа
      end;
      TrimLeft_Zero(result);
    end;

end;

//Целочисленное деление со знаком
function Sign_Div(dvd, dvr: TLong): TLong;
var sgn: integer;
begin
  if dvr = '0'
  then
    begin
      raise Exception.Create('ошибка, деление на 0');
    end
  else
  begin
    sgn := sign(dvd) * sign(dvr); //Работаем со знаками чисел как и при умножении
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


//Остаток от целочисленного деления со знаком
function Sign_Mod(dvd, dvr: TLong): TLong;
begin                                                       //Делимое = делитель * частное + остаток
  result := Sign_Sub(dvd, Sign_Multi(Sign_Div(dvd, dvr), dvr));   //Остаток = делимое - делитель * частное
end;


end.
