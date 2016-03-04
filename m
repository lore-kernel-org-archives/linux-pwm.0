Return-Path: <aford173@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160304112736.660e4223.drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
	<20160226203100.303fe192.drivshin.allworx@gmail.com>
	<20160304151948.GF26400@ulmo.nvidia.com>
	<20160304112736.660e4223.drivshin.allworx@gmail.com>
Date: Fri, 4 Mar 2016 10:29:07 -0600
Message-ID: <CAHCN7xJYi8VCe8ue_QuYmqTEo-8GPSPiwzM2F_631mMUrwajSA@mail.gmail.com>
Subject: Re: [PATCH 0/4] pwm: omap-dmtimer: fix period/duty_cycle calculation
From: Adam Ford <aford173@gmail.com>
Content-Type: multipart/alternative; boundary=001a114b17ec39fe08052d3b9d02
List-ID: <linux-pwm.vger.kernel.org>
To: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Cc: NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Joachim Eastwood <manabian@gmail.com>, linux-arm-kernel@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, Grant Erickson <marathon96@gmail.com>, linux-pwm@vger.kernel.org

--001a114b17ec39fe08052d3b9d02
Content-Type: text/plain; charset=UTF-8

I am OK with it. 0% vs 1% is not perceivable and neither is 99% vs 100%.

Thanks!

Adam
On Mar 4, 2016 10:27 AM, "David Rivshin (Allworx)" <
drivshin.allworx@gmail.com> wrote:

> On Fri, 4 Mar 2016 16:19:48 +0100
> Thierry Reding <thierry.reding@gmail.com> wrote:
>
> > On Fri, Feb 26, 2016 at 08:31:00PM -0500, David Rivshin (Allworx) wrote:
> > > On Fri, 29 Jan 2016 23:26:50 -0500
> > > "David Rivshin (Allworx)" <drivshin.allworx@gmail.com> wrote:
> > >
> > > > From: David Rivshin <drivshin@allworx.com>
> > > >
> > > > When using a short PWM period (approaching the min of 2/clk_rate),
> > > > pwm-omap-dmtimer does not produce accurate results. In the worst
> case a
> > > > requested period of 2/clk_rate would result in a real period of
> 4/clk_rate
> > > > instead. This is a series includes a fix for that problem, as well as
> > > > other related improvements, and is based on the current
> linux-pwm/for-next
> > > > tip.
> > > >
> > > > I have tested on a Sitara AM335x platform, using a scope to verify
> the
> > > > output with a variety of periods and duty cycles. This includes a PWM
> > > > rate up clk_rate/2 with 50% duty cycle (e.g. generating fclk/2) with
> > > > both 32768Hz and 24MHz fclks. I do not have an OMAP4 board to test
> with,
> > > > although appropriate sections in the the reference manuals appear
> > > > substantially the same, so I believe the changes are equally correct
> > > > there.
> > > >
> > > > Note that the OMAP4 TRMs do effectively state that the maximum PWM
> > > > rate is clk_rate/4, so at very fast PWM rates the behavior may not be
> > > > as reliable as I observed with Sitara. Although I suspect that it's
> > > > the same module and will also work, at least under some
> circumstances.
> > > > If anyone with OMAP4 hardware and a scope is so inclined, I would be
> > > > curious to know the results.
> > > >
> > > > David Rivshin (4):
> > > >   pwm: omap-dmtimer: fix inaccurate period/duty_cycle calculation
> > > >   pwm: omap-dmtimer: add sanity checking for load and match values
> > > >   pwm: omap-dmtimer: round load and match values rather than truncate
> > > >   pwm: omap-dmtimer: add dev_dbg() message for effective period and
> duty
> > > >     cycle
> > > >
> > > >  drivers/pwm/pwm-omap-dmtimer.c | 71
> ++++++++++++++++++++++++++++++++----------
> > > >  1 file changed, 55 insertions(+), 16 deletions(-)
> > > >
> > >
> > > Hi Thierry,
> > >
> > > Gentle ping. It does not look like you've taken this series, and I
> > > wanted to make sure you're not waiting on something from me. It would
> > > be nice to get at least the first patch into 4.5, if possible.
> >
> > I've applied patches 1 and 3, and I'm planning on sending out a pull
> > request for inclusion in v4.5-rc7 later on.
>
> Thanks!
>
> > Patches 2 and 4 didn't seem ready/critical, so let's finish those up
> > for v4.6-rc1.
>
> I know there was a lot of discussion on 4, but I'm not sure what the
> concern is on patch 2. Is there something specific you're thinking of?
>
> FYI, I know that Adam Ford is using this driver as the backend for
> a pwm-backlight control. Without patch 2 this driver will not configure
> the HW in a legal way at 0 or 100% duty cycle. However, I forget what
> the practical effect of that is, and Adam seemed to indicate it was OK
> for his purposes.
>
>

--001a114b17ec39fe08052d3b9d02
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I am OK with it. 0% vs 1% is not perceivable and neither is =
99% vs 100%.</p>
<p dir=3D"ltr">Thanks!</p>
<p dir=3D"ltr">Adam</p>
<div class=3D"gmail_quote">On Mar 4, 2016 10:27 AM, &quot;David Rivshin (Al=
lworx)&quot; &lt;<a href=3D"mailto:drivshin.allworx@gmail.com">drivshin.all=
worx@gmail.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">On Fri, 4 Mar 2016 16:19:48 +0100<br>
Thierry Reding &lt;<a href=3D"mailto:thierry.reding@gmail.com">thierry.redi=
ng@gmail.com</a>&gt; wrote:<br>
<br>
&gt; On Fri, Feb 26, 2016 at 08:31:00PM -0500, David Rivshin (Allworx) wrot=
e:<br>
&gt; &gt; On Fri, 29 Jan 2016 23:26:50 -0500<br>
&gt; &gt; &quot;David Rivshin (Allworx)&quot; &lt;<a href=3D"mailto:drivshi=
n.allworx@gmail.com">drivshin.allworx@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; From: David Rivshin &lt;<a href=3D"mailto:drivshin@allworx.c=
om">drivshin@allworx.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; When using a short PWM period (approaching the min of 2/clk_=
rate),<br>
&gt; &gt; &gt; pwm-omap-dmtimer does not produce accurate results. In the w=
orst case a<br>
&gt; &gt; &gt; requested period of 2/clk_rate would result in a real period=
 of 4/clk_rate<br>
&gt; &gt; &gt; instead. This is a series includes a fix for that problem, a=
s well as<br>
&gt; &gt; &gt; other related improvements, and is based on the current linu=
x-pwm/for-next<br>
&gt; &gt; &gt; tip.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I have tested on a Sitara AM335x platform, using a scope to =
verify the<br>
&gt; &gt; &gt; output with a variety of periods and duty cycles. This inclu=
des a PWM<br>
&gt; &gt; &gt; rate up clk_rate/2 with 50% duty cycle (e.g. generating fclk=
/2) with<br>
&gt; &gt; &gt; both 32768Hz and 24MHz fclks. I do not have an OMAP4 board t=
o test with,<br>
&gt; &gt; &gt; although appropriate sections in the the reference manuals a=
ppear<br>
&gt; &gt; &gt; substantially the same, so I believe the changes are equally=
 correct<br>
&gt; &gt; &gt; there.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Note that the OMAP4 TRMs do effectively state that the maxim=
um PWM<br>
&gt; &gt; &gt; rate is clk_rate/4, so at very fast PWM rates the behavior m=
ay not be<br>
&gt; &gt; &gt; as reliable as I observed with Sitara. Although I suspect th=
at it&#39;s<br>
&gt; &gt; &gt; the same module and will also work, at least under some circ=
umstances.<br>
&gt; &gt; &gt; If anyone with OMAP4 hardware and a scope is so inclined, I =
would be<br>
&gt; &gt; &gt; curious to know the results.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; David Rivshin (4):<br>
&gt; &gt; &gt;=C2=A0 =C2=A0pwm: omap-dmtimer: fix inaccurate period/duty_cy=
cle calculation<br>
&gt; &gt; &gt;=C2=A0 =C2=A0pwm: omap-dmtimer: add sanity checking for load =
and match values<br>
&gt; &gt; &gt;=C2=A0 =C2=A0pwm: omap-dmtimer: round load and match values r=
ather than truncate<br>
&gt; &gt; &gt;=C2=A0 =C2=A0pwm: omap-dmtimer: add dev_dbg() message for eff=
ective period and duty<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0cycle<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 drivers/pwm/pwm-omap-dmtimer.c | 71 ++++++++++++++++++=
++++++++++++++----------<br>
&gt; &gt; &gt;=C2=A0 1 file changed, 55 insertions(+), 16 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Hi Thierry,<br>
&gt; &gt;<br>
&gt; &gt; Gentle ping. It does not look like you&#39;ve taken this series, =
and I<br>
&gt; &gt; wanted to make sure you&#39;re not waiting on something from me. =
It would<br>
&gt; &gt; be nice to get at least the first patch into 4.5, if possible.<br=
>
&gt;<br>
&gt; I&#39;ve applied patches 1 and 3, and I&#39;m planning on sending out =
a pull<br>
&gt; request for inclusion in v4.5-rc7 later on.<br>
<br>
Thanks!<br>
<br>
&gt; Patches 2 and 4 didn&#39;t seem ready/critical, so let&#39;s finish th=
ose up<br>
&gt; for v4.6-rc1.<br>
<br>
I know there was a lot of discussion on 4, but I&#39;m not sure what the<br=
>
concern is on patch 2. Is there something specific you&#39;re thinking of?<=
br>
<br>
FYI, I know that Adam Ford is using this driver as the backend for<br>
a pwm-backlight control. Without patch 2 this driver will not configure<br>
the HW in a legal way at 0 or 100% duty cycle. However, I forget what<br>
the practical effect of that is, and Adam seemed to indicate it was OK<br>
for his purposes.<br>
<br>
</blockquote></div>

--001a114b17ec39fe08052d3b9d02--
