program ProgramQueue;

{«адана последовательность, ограниченна€ нулем. Ќапечатать положительные
и отрицательные числа отдельно с сохранением пор€дка}

{$APPTYPE CONSOLE}

uses
  SysUtils, UQueueArray;

var
  el: TElem;
  Q: TQueue;

begin
  Writeln('Input sequence');
  Init(Q);
  read(el);
  while (el<>0) do
  begin
    if (el < 0) then
      Push(Q, el)
    else
      write(el, ' ');
    read(el);
  end;

  while TryPop(Q, el) do
    write (el, ' ');
  Readln;
  Readln;
end.
