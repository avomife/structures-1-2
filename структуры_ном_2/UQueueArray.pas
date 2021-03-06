
unit UQueueArray;

interface

  const
    {������������ ���������� ��������� � �������}
    MaxN = 100;

  type
  {��� �������� �������}
  TElem = integer;
  {������ �� ���������}
  TElems = array [0..MaxN-1] of TElem;
  {������� �� ���������}
  TQueue = record
    Elems : TElems; // ������ �� ���������
    Head, // ������ (������) �������
    Count : integer; // ���������� ��������� � �������
  end;

  {��������� ������������� ������� Q}
  procedure Init (var Q : TQueue);
  {������� �������� ������� Q �� �������.
  ���������� �������� true, ���� ������� ����, false - � ��������� ������.}
  function IsEmpty (var Q : TQueue) : boolean;
  {������� �������� ������� Q �� �������.
  ���������� �������� true, ���� ������� �����, false - � ��������� ������.}
  function IsFull (var Q : TQueue) : boolean;
  {�������, ������� �������� ��������� ������� el � ������� Q.
  ���������� �������� true, ���� ������� ������� ��������� � �������,
  false - � ��������� ������}
  function TryPush (var Q : TQueue; el : TElem) : boolean;
  {��������� ���������� �������� el � ������� Q.}
  procedure Push (var Q : TQueue; el : TElem);
  {�������, ������� �������� ������� ������� el �� ������� Q.
  ���������� �������� true, ���� ������� �������,
  false - � ��������� ������.}
  function TryPop (var Q : TQueue; var el : TElem) : boolean;
  {�������, ������� ��������� ������� el �� ������� Q.
  � ������ ������� ������������ �������������� ��������.}
  function Pop (var Q : TQueue) : TElem;
  {���������, ������� ��������� ������� el �� ������� Q.
  � ������ ������� ������������ �������������� ��������.}
  procedure Pop_P (var Q : TQueue; var el : TElem);

implementation

uses SysUtils;

{��������� ������������� ������� Q}
procedure Init (var Q : TQueue);
begin
  Q.Head:=0;
  Q.Count:=0;
end;

{������� �������� ������� Q �� �������.
���������� �������� true, ���� ������� �����, false - � ��������� ������.}
function IsEmpty (var Q : TQueue) : boolean;
begin
  Result:=Q.Count = 0;
end;

{������� �������� ������� Q �� �������.
���������� �������� true, ���� ������� �����, false - � ��������� ������.}
function IsFull (var Q : TQueue) : boolean;
begin
  Result:=Q.Count = MaxN;
end;

{�������, ������� �������� ��������� ������� el � ������� Q.
���������� �������� true, ���� ������� ������� ��������� � �������,
false - � ��������� ������.}
function TryPush (var Q : TQueue; el : TElem) : boolean;
var
  tail : integer;
begin
  Result:=Q.Count < MaxN;
  if Result then
    with Q do
    begin
      tail:=(Head+Count) mod MaxN;
      Elems[tail]:=el;
      inc(Count)
    end;
end;

{��������� ���������� �������� el � ������� Q}
procedure Push (var Q : TQueue; el : TElem);
begin
  if not TryPush(Q, el) then
    raise Exception.Create('������������ �������');
end;

{�������, ������� �������� ������� ������� el �� ������� Q.
���������� �������� true, ���� ������� �������,
false - � ��������� ������.}
function TryPop (var Q : TQueue; var el : TElem) : boolean;
begin
  Result:=Q.Count > 0;
  if Result then
    with Q do
    begin
      el:=Elems[Head];
      Head:=(Head + 1) mod MaxN;
      dec(Count);
    end;
end;

{�������, ������� ��������� ������� el �� ������� Q.
� ������ ������� ������������ �������������� ��������.}
function Pop (var Q : TQueue) : TElem;
begin
  if not TryPop(Q, Result) then
    raise Exception.Create('������� ������� ������� �� ������ �������');
end;

{���������, ������� ��������� ������� el �� ������� Q.
� ������ ������� ������������ �������������� ��������.}
procedure Pop_P (var Q : TQueue; var el : TElem);
begin
  if not TryPop(Q, el) then
    raise Exception.Create('������� ������� ������� �� ������ �������');
end;

end.
