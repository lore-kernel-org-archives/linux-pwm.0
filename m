Return-Path: <guille.rodriguez@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160610082934.GQ2466@piout.net>
References: <1463137777-27103-1-git-send-email-guille.rodriguez@gmail.com>
	<20160610082934.GQ2466@piout.net>
Date: Fri, 10 Jun 2016 11:32:24 +0200
Message-ID: <CABDcavaqkmEsUL=ndWNVsx88yJxrwU2NuUKAuJYcZfJW84fqUQ@mail.gmail.com>
Subject: Re: [PATCH] pwm: atmel: Fix disabling of PWM channels
From: Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Content-Type: multipart/alternative; boundary=001a114e24826685ae0534e9378c
List-ID: <linux-pwm.vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>

--001a114e24826685ae0534e9378c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

El viernes, 10 de junio de 2016, Alexandre Belloni <
alexandre.belloni@free-electrons.com> escribi=C3=B3:

> Hi,
>
> On 13/05/2016 at 13:09:37 +0200, Guillermo Rodriguez wrote :
> > When disabling a PWM channel, the PWM clock was being stopped
> > immediately after writing to PWM_DIS. As a result, the disabling
> > of the PWM channel did not complete properly, and the PWM output
> > might be left at the wrong level.
> >
> > Fix this by waiting for the channel to be effectively disabled
> > (by checking the PWM_SR register) before disabling the clock.
> >
> > Signed-off-by: Guillermo Rodriguez <guille.rodriguez@gmail.com
> <javascript:;>>
> > ---
> >  drivers/pwm/pwm-atmel.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> > index 0e4bd4e..a714434 100644
> > --- a/drivers/pwm/pwm-atmel.c
> > +++ b/drivers/pwm/pwm-atmel.c
> > @@ -271,6 +271,16 @@ static void atmel_pwm_disable(struct pwm_chip
> *chip, struct pwm_device *pwm)
> >       mutex_unlock(&atmel_pwm->isr_lock);
> >       atmel_pwm_writel(atmel_pwm, PWM_DIS, 1 << pwm->hwpwm);
> >
> > +     /*
> > +      * Wait for the PWM channel disable operation to be effective
> before
> > +      * stopping the clock.
> > +      */
> > +     timeout =3D jiffies + 2 * HZ;
> > +     while ((atmel_pwm_readl(atmel_pwm, PWM_SR)& (1 << pwm->hwpwm)) &&
> > +            time_before(jiffies, timeout)) {
> > +             usleep_range(10, 100);
> > +     }
> > +
>
> While this seems good, can you tell on which SoC you observed that? I'd
> like to understand whether this is only on v1 or v2 or both.


I observed it on a sama5d3, however this article from atmel's KB would seem
to suggest that it is not specific to this SoC:

http://atmel.force.com/support/pkb_mobile#/articles/en_US/FAQ/Why-PWM-Chann=
el-Polarity-Inversion

 Guillermo


--=20
Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com

--001a114e24826685ae0534e9378c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>El viernes, 10 de junio de 2016, Alexandre Belloni &lt;<a href=
=3D"mailto:alexandre.belloni@free-electrons.com">alexandre.belloni@free-ele=
ctrons.com</a>&gt; escribi=C3=B3:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On 13/05/2016 at 13:09:37 +0200, Guillermo Rodriguez wrote :<br>
&gt; When disabling a PWM channel, the PWM clock was being stopped<br>
&gt; immediately after writing to PWM_DIS. As a result, the disabling<br>
&gt; of the PWM channel did not complete properly, and the PWM output<br>
&gt; might be left at the wrong level.<br>
&gt;<br>
&gt; Fix this by waiting for the channel to be effectively disabled<br>
&gt; (by checking the PWM_SR register) before disabling the clock.<br>
&gt;<br>
&gt; Signed-off-by: Guillermo Rodriguez &lt;<a href=3D"javascript:;" onclic=
k=3D"_e(event, &#39;cvml&#39;, &#39;guille.rodriguez@gmail.com&#39;)">guill=
e.rodriguez@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/pwm/pwm-atmel.c |=C2=A0 =C2=A010 ++++++++++<br>
&gt;=C2=A0 1 file changed, 10 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c<br>
&gt; index 0e4bd4e..a714434 100644<br>
&gt; --- a/drivers/pwm/pwm-atmel.c<br>
&gt; +++ b/drivers/pwm/pwm-atmel.c<br>
&gt; @@ -271,6 +271,16 @@ static void atmel_pwm_disable(struct pwm_chip *ch=
ip, struct pwm_device *pwm)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;atmel_pwm-&gt;isr_lock);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atmel_pwm_writel(atmel_pwm, PWM_DIS, 1 &lt;&=
lt; pwm-&gt;hwpwm);<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Wait for the PWM channel disable operation to =
be effective before<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * stopping the clock.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0timeout =3D jiffies + 2 * HZ;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while ((atmel_pwm_readl(atmel_pwm, PWM_SR)&amp; (=
1 &lt;&lt; pwm-&gt;hwpwm)) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time_before(jiffies, timeou=
t)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usleep_range(10, 100)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
<br>
While this seems good, can you tell on which SoC you observed that? I&#39;d=
<br>
like to understand whether this is only on v1 or v2 or both.</blockquote><d=
iv><br></div><div>I observed it on a sama5d3, however this article from atm=
el&#39;s KB would seem to suggest that it is not specific to this SoC:</div=
><div><br></div><div><a href=3D"http://atmel.force.com/support/pkb_mobile#/=
articles/en_US/FAQ/Why-PWM-Channel-Polarity-Inversion">http://atmel.force.c=
om/support/pkb_mobile#/articles/en_US/FAQ/Why-PWM-Channel-Polarity-Inversio=
n</a><br></div><div><br></div><div>=C2=A0Guillermo</div><br><br>-- <br>Guil=
lermo Rodriguez Garcia<br><a href=3D"mailto:guille.rodriguez@gmail.com">gui=
lle.rodriguez@gmail.com</a><br>

--001a114e24826685ae0534e9378c--
