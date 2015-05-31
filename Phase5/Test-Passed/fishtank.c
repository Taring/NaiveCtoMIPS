struct PLAYER {
    int Point,Level,Exp,X,Y,HP,MaxHP,Attack,Speed,Armor;
    int Killed,Dead,Eaten,Ganked,BeGanked,Movdis;
    int Score,ID,Alive;
    int Attacked,Moved;
    char Identifier[256];
} st[11];

int i,j;
int Rank[20];
int map[40][40];
void Levelup(int i){
    if (st[i].Point>5)
        st[i].Attack++;
    else if (st[i].Point>0)
        st[i].Speed++;
    else return;
    st[i].Point--;
}

int main(){

    int answer =0;
    char s = getchar();
    int rounds, t,Now,Rex,Rey;

    for (i=1;i<=10;i++){
        st[i].Point = (i*2+s);
        st[i].Level = 1;    st[i].Exp = 0;
        st[i].HP = st[i].MaxHP = 0;
        st[i].Attack = st[i].Speed = 0;
        st[i].Armor = st[i].Alive = 0;
        st[i].Attacked = st[i].Moved = 0;
    }
    for (rounds = 0;rounds<100;rounds++) {
        for (i=1;i<=10;++i) {
            if (st[i].Alive==0)
                st[i].Exp++,Levelup(i);
                st[i].Attacked = st[i].Moved = 0;
                st[i].Score = st[i].Exp + st[i].Killed*5 - st[i].Dead*st[i].Dead/5;
                Rank[i] = i;
            }
            for (i=1;i<=10;++i) for (j=i;j<=10;++j)
                    if (Rank[i]>Rank[j]) {
                        t = Rank[i];
                        Rank[i] = Rank[j];
                        Rank[j] = t;}
            //3.2.3 AI Playing...
            for (i = 1;i<=10;++i){
                Now = Rank[i];
                if (st[Now].Alive==1){
                    Rex = 0, Rey = 0;
                    st[Now].HP = st[Now].MaxHP/4;
                    st[Now].X = Rex, st[Now].Y = Rey;
                    st[Now].Alive--;
                    map[Rex][Rey] = Now;
                }
                if (st[Now].Alive>1) st[Now].Alive--;
            }
    }

    for (i=1;i<=10;i++)
        answer += st[i].Point*9+st[i].Level*8+st[i].Exp*7+st[i].Attack*6;
    printf("%d",answer);
}
