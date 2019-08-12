Return-path: <paul@crapouillou.net>
Date: Tue, 13 Aug 2019 00:16:23 +0200
From: Paul Cercueil <paul@crapouillou.net>
Message-Id: <1565648183.2007.3@crapouillou.net>
In-Reply-To: <20190812214838.e5hyhnlcyykjfvsb@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
	<20190809123031.24219-5-paul@crapouillou.net>
	<20190809170551.u4ybilf5ay2rsvnn@pengutronix.de>
	<1565370885.2091.2@crapouillou.net>
	<20190812061520.lwzk3us4ginwwxov@pengutronix.de>
	<1565642590.2007.1@crapouillou.net>
	<20190812214838.e5hyhnlcyykjfvsb@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-l+1dLmmR80DLSujzZrD6"
Subject: Re: [PATCH 4/7] pwm: jz4740: Improve algorithm of clock calculation
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>, Artur Rojek <contact@artur-rojek.eu>
List-ID: <linux-pwm.vger.kernel.org>

--=-l+1dLmmR80DLSujzZrD6
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable



Le lun. 12 ao=FBt 2019 =E0 23:48, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=
=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello Paul,
>=20
> On Mon, Aug 12, 2019 at 10:43:10PM +0200, Paul Cercueil wrote:
>>  Le lun. 12 ao=FBt 2019 =E0 8:15, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=
=3D
>>  <u.kleine-koenig@pengutronix.de=20
>> <mailto:u.kleine-koenig@pengutronix.de>> a =E9crit :
>>  > On Fri, Aug 09, 2019 at 07:14:45PM +0200, Paul Cercueil wrote:
>>  > >  Le ven. 9 ao=FBt 2019 =E0 19:05, Uwe=20
>> =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D
>>  > >  <u.kleine-koenig@pengutronix.de=20
>> <mailto:u.kleine-koenig@pengutronix.de>> a =E9crit :
>>  > >  > On Fri, Aug 09, 2019 at 02:30:28PM +0200, Paul Cercueil=20
>> wrote:
>>  > >  > > [...]
>>  > >  > >  +	/* Reset the clock to the maximum rate, and we'll=20
>> reduce it if needed */
>>  > >  > >  +	ret =3D clk_set_max_rate(clk, parent_rate);
>>  > >  >
>>  > >  > What is the purpose of this call? IIUC this limits the=20
>> allowed range of
>>  > >  > rates for clk. I assume the idea is to prevent other=20
>> consumers to change
>>  > >  > the rate in a way that makes it unsuitable for this pwm. But=20
>> this only
>>  > >  > makes sense if you had a notifier for clk changes, doesn't=20
>> it? I'm
>>  > >  > confused.
>>  > >
>>  > >  Nothing like that. The second call to clk_set_max_rate() might=20
>> have set
>>  > >  a maximum clock rate that's lower than the parent's rate, and=20
>> we want to
>>  > >  undo that.
>>  >
>>  > I still don't get the purpose of this call. Why do you limit the=20
>> clock
>>  > rate at all?
>>=20
>>  As it says below, we "limit the clock to a maximum rate that still=20
>> gives
>>  us a period value which fits in 16 bits". So that the computed=20
>> hardware
>>  values won't overflow.
>=20
> But why not just using clk_set_rate? You want to have the clock=20
> running
> at a certain rate, not any rate below that certain rate, don't you?

I'll let yourself answer yourself:
https://patchwork.ozlabs.org/patch/1018969/

It's enough to run it below a certain rate, yes. The actual rate doesn't
actually matter that much.

>=20
>>  E.g. if at a rate of 12 MHz your computed hardware value for the=20
>> period
>>  is 0xf000, then at a rate of 24 MHz it won't fit in 16 bits. So the=20
>> clock
>>  rate must be reduced to the highest possible that will still give=20
>> you a
>>  < 16-bit value.
>>=20
>>  We always want the highest possible clock rate that works, for the=20
>> sake of
>>  precision.
>=20
> This is dubious; but ok to keep the driver simple. (Consider a PWM=20
> that
> can run at i MHz for i in [1, .. 30]. If a period of 120 ns and a duty
> cycle of 40 ns is requested you can get an exact match with 25 MHz,=20
> but
> not with 30 MHz.)

The clock rate is actually (parent_rate >> (2 * x) )
for x =3D 0, 1, 2, ...

So if your parent_rate is 30 MHz the next valid one is 7.5 MHz, and the
next one is 1.875 MHz. It'd be very unlikely that you get a better=20
match at a
lower clock.


>>  > >  Basically, we start from the maximum clock rate we can get for=20
>> that PWM
>>  > >  - which is the rate of the parent clk - and from that compute=20
>> the maximum
>>  > >  clock rate that we can support that still gives us < 16-bits=20
>> hardware
>>  > >  values for the period and duty.
>>  > >
>>  > >  We then pass that computed maximum clock rate to=20
>> clk_set_max_rate(), which
>>  > >  may or may not update the current PWM clock's rate to match=20
>> the new limits.
>>  > >  Finally we read back the PWM clock's rate and compute the=20
>> period and duty
>>  > >  from that.
>>  >
>>  > If you change the clk rate, is this externally visible on the PWM
>>  > output? Does this affect other PWM instances?
>>=20
>>  The clock rate doesn't change the PWM output because the hardware=20
>> values for
>>  the period and duty are adapted accordingly to reflect the change.
>=20
> It doesn't change it in the end. But in the (short) time frame between
> the call to change the clock and the update of the PWM registers there
> is a glitch, right?

The PWM is disabled, so the line is in inactive state, and will be in=20
that state
until the PWM is enabled again. No glitch to fear.

>=20
> You didn't answer to the question about other PWM instances. Does that
> mean others are not affected?

Sorry. Yes, they are not affected - all PWM channels are independent.

>=20
> Best regards
> Uwe
>=20
> PS: It would be great if you could fix your mailer to not damage the
> quoted mail. Also it doesn't seem to understand how my name is encoded
> in the From line. I fixed up the quotes in my reply.

I switched Geary to "rich text". Is that better?

>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> <http://www.pengutronix.de/>  |

=

--=-l+1dLmmR80DLSujzZrD6
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<div id=3D"geary-body" dir=3D"auto"><div><br></div></div><div id=3D"geary-q=
uote" dir=3D"auto"><br>Le lun. 12 ao=FBt 2019 =E0 23:48, Uwe =3D?iso-8859-1=
?q?Kleine-K=3DF6nig?=3D &lt;u.kleine-koenig@pengutronix.de&gt; a =E9crit&nb=
sp;:<br><blockquote type=3D"cite"><div class=3D"plaintext" style=3D"white-s=
pace: pre-wrap;">Hello Paul,

On Mon, Aug 12, 2019 at 10:43:10PM +0200, Paul Cercueil wrote:
<blockquote> Le lun. 12 ao=FBt 2019 =E0 8:15, Uwe =3D?iso-8859-1?q?Kleine-K=
=3DF6nig?=3D
 &lt;<a href=3D"mailto:u.kleine-koenig@pengutronix.de">u.kleine-koenig@peng=
utronix.de</a>&gt; a =E9crit :
 &gt; On Fri, Aug 09, 2019 at 07:14:45PM +0200, Paul Cercueil wrote:
 &gt; &gt;  Le ven. 9 ao=FBt 2019 =E0 19:05, Uwe =3D?iso-8859-1?q?Kleine-K=
=3DF6nig?=3D
 &gt; &gt;  &lt;<a href=3D"mailto:u.kleine-koenig@pengutronix.de">u.kleine-=
koenig@pengutronix.de</a>&gt; a =E9crit :
 &gt; &gt;  &gt; On Fri, Aug 09, 2019 at 02:30:28PM +0200, Paul Cercueil wr=
ote:
 &gt; &gt;  &gt; &gt; [...]
 &gt; &gt;  &gt; &gt;  +	/* Reset the clock to the maximum rate, and we'll =
reduce it if needed */
 &gt; &gt;  &gt; &gt;  +	ret =3D clk_set_max_rate(clk, parent_rate);
 &gt; &gt;  &gt;
 &gt; &gt;  &gt; What is the purpose of this call? IIUC this limits the all=
owed range of
 &gt; &gt;  &gt; rates for clk. I assume the idea is to prevent other consu=
mers to change
 &gt; &gt;  &gt; the rate in a way that makes it unsuitable for this pwm. B=
ut this only
 &gt; &gt;  &gt; makes sense if you had a notifier for clk changes, doesn't=
 it? I'm
 &gt; &gt;  &gt; confused.
 &gt; &gt;=20
 &gt; &gt;  Nothing like that. The second call to clk_set_max_rate() might =
have set
 &gt; &gt;  a maximum clock rate that's lower than the parent's rate, and w=
e want to
 &gt; &gt;  undo that.
 &gt;=20
 &gt; I still don't get the purpose of this call. Why do you limit the cloc=
k
 &gt; rate at all?
=20
 As it says below, we "limit the clock to a maximum rate that still gives
 us a period value which fits in 16 bits". So that the computed hardware
 values won't overflow.
</blockquote>
But why not just using clk_set_rate? You want to have the clock running
at a certain rate, not any rate below that certain rate, don't you?</div></=
blockquote><div style=3D"white-space: pre-wrap;"><br></div><div style=3D"wh=
ite-space: pre-wrap;">I'll let yourself answer yourself:</div><div><span st=
yle=3D"white-space: pre-wrap;">https://patchwork.ozlabs.org/patch/1018969/<=
/span></div><div style=3D"white-space: pre-wrap;"><br></div><div style=3D"w=
hite-space: pre-wrap;"><span style=3D"white-space: pre-wrap;">It's enough t=
o run it below a certain rate, yes. The actual rate doesn't</span></div><di=
v style=3D"white-space: pre-wrap;"><span style=3D"white-space: pre-wrap;">a=
ctually matter that much.</span></div><div style=3D"white-space: pre-wrap;"=
><span style=3D"white-space: pre-wrap;"><br></span></div><blockquote type=
=3D"cite"><div class=3D"plaintext" style=3D"white-space: pre-wrap;">=20
<blockquote> E.g. if at a rate of 12 MHz your computed hardware value for t=
he period
 is 0xf000, then at a rate of 24 MHz it won't fit in 16 bits. So the clock
 rate must be reduced to the highest possible that will still give you a
 &lt; 16-bit value.
=20
 We always want the highest possible clock rate that works, for the sake of
 precision.
</blockquote>
This is dubious; but ok to keep the driver simple. (Consider a PWM that
can run at i MHz for i in [1, .. 30]. If a period of 120 ns and a duty
cycle of 40 ns is requested you can get an exact match with 25 MHz, but
not with 30 MHz.)</div></blockquote><span style=3D"white-space: pre-wrap;">=
<div><span style=3D"white-space: pre-wrap;"><br></span></div><div><span sty=
le=3D"white-space: pre-wrap;">The clock rate is actually (parent_rate &gt;&=
gt; (2 * x) )</span></div><div><span style=3D"white-space: pre-wrap;">for x=
 =3D 0, 1, 2, ...</span></div><div><span style=3D"white-space: pre-wrap;"><=
br></span></div><div><span style=3D"white-space: pre-wrap;">So if your pare=
nt_rate is 30 MHz the next valid one is 7.5 MHz, and the</span></div><div><=
span style=3D"white-space: pre-wrap;">next one is 1.875 MHz. It'd b</span>e=
 very unlikely that you get a better match at a</div><div>lower clock.</div=
><div><span style=3D"white-space: pre-wrap;"><br></span></div></span><br><b=
lockquote type=3D"cite"><div class=3D"plaintext" style=3D"white-space: pre-=
wrap;"><blockquote> &gt; &gt;  Basically, we start from the maximum clock r=
ate we can get for that PWM
 &gt; &gt;  - which is the rate of the parent clk - and from that compute t=
he maximum
 &gt; &gt;  clock rate that we can support that still gives us &lt; 16-bits=
 hardware
 &gt; &gt;  values for the period and duty.
 &gt; &gt;=20
 &gt; &gt;  We then pass that computed maximum clock rate to clk_set_max_ra=
te(), which
 &gt; &gt;  may or may not update the current PWM clock's rate to match the=
 new limits.
 &gt; &gt;  Finally we read back the PWM clock's rate and compute the perio=
d and duty
 &gt; &gt;  from that.
 &gt;=20
 &gt; If you change the clk rate, is this externally visible on the PWM
 &gt; output? Does this affect other PWM instances?
=20
 The clock rate doesn't change the PWM output because the hardware values f=
or
 the period and duty are adapted accordingly to reflect the change.
</blockquote>
It doesn't change it in the end. But in the (short) time frame between
the call to change the clock and the update of the PWM registers there
is a glitch, right?</div></blockquote><span style=3D"white-space: pre-wrap;=
"><div><span style=3D"white-space: pre-wrap;"><br></span></div><div><span s=
tyle=3D"white-space: pre-wrap;">The PWM is disabled, so the line is in inac=
tive state, and will be in that state</span></div><div><span style=3D"white=
-space: pre-wrap;">until the PWM is enabled again. No glitch to fear.</span=
></div><br></span><blockquote type=3D"cite"><div class=3D"plaintext" style=
=3D"white-space: pre-wrap;">
You didn't answer to the question about other PWM instances. Does that
mean others are not affected?</div></blockquote><span style=3D"white-space:=
 pre-wrap;"><div><span style=3D"white-space: pre-wrap;"><br></span></div><d=
iv><span style=3D"white-space: pre-wrap;">Sorry. Yes, they are not affected=
 - all PWM channels are independent.</span></div><br></span><blockquote typ=
e=3D"cite"><div class=3D"plaintext" style=3D"white-space: pre-wrap;">
Best regards
Uwe

PS: It would be great if you could fix your mailer to not damage the
quoted mail. Also it doesn't seem to understand how my name is encoded
in the From line. I fixed up the quotes in my reply.</div></blockquote><spa=
n style=3D"white-space: pre-wrap;"><div><span style=3D"white-space: pre-wra=
p;"><br></span></div><div><span style=3D"white-space: pre-wrap;">I switched=
 Geary to "rich text". Is that better?</span></div><br></span><blockquote t=
ype=3D"cite"><div class=3D"plaintext" style=3D"white-space: pre-wrap;">
<div>--=20
</div>Pengutronix e.K.                           | Uwe Kleine-K=F6nig      =
      |
Industrial Linux Solutions                 | <a href=3D"http://www.pengutro=
nix.de/">http://www.pengutronix.de/</a>  |
</div></blockquote></div>=

--=-l+1dLmmR80DLSujzZrD6--
