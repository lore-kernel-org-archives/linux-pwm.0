Return-Path: <johannes.pointner@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20140627061231.GD9258@ulmo>
References: <CAJKbBDD1SANFaXqKnxEAOdLH=s+Jo1b2bXKeebCfV--PhZUScQ@mail.gmail.com>
	<20140627061231.GD9258@ulmo>
Date: Fri, 27 Jun 2014 08:58:21 +0200
Message-ID: <CAJKbBDDS1Dfpsv8C4W_2uBEgYpO2FmYyMHrZ9vAy_k_jTdV5MA@mail.gmail.com>
Subject: Re: [PATCH] Added possibility to use pwm_bl.c with percentage instead
 of levels
From: Johannes Pointner <johannes.pointner@gmail.com>
Content-Type: multipart/alternative; boundary=001a11c126fcb9f46004fccbd52b
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>

--001a11c126fcb9f46004fccbd52b
Content-Type: text/plain; charset=UTF-8

I know what you mean because I have here for example a panel that only
supports a duty cycle between 20 and 100 percent. But wouldn't I be a
possibility to add optional nodes with minimal/maximal brightness or
something like that?

Hannes


2014-06-27 8:12 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:

> On Fri, Jun 27, 2014 at 07:32:20AM +0200, Johannes Pointner wrote:
> > Hello,
> >
> > I'm new working on the linux device drivers, so if I made something wrong
> > please point me into the right direction.
> >
> > I'd like to use the pwm_bl driver for a sitara based terminal and for
> this
> > I would need the possibility to set the backlight within a percentage
> > range. The following patch should add this possibility to the pwm_bl
> > driver. The idea is to keep backward compatibility by moving the required
> > option brightness levels to optional. Therefore if there is no node with
> > brightness levels the percentage levels are used.
> >
> > Signed-off-by: Johannes Pointner <johannes.pointner@gmail.com>
> > ---
> >  .../bindings/video/backlight/
> > pwm-backlight.txt     | 11 +++---
> >  drivers/video/backlight/pwm_bl.c                   | 46
> > ++++++++++++----------
> >  2 files changed, 31 insertions(+), 26 deletions(-)
>
> Also adding the backlight maintainers on Cc.
>
> This has been discussed a few times before. In fact the original device
> tree binding had support for a continuous range of levels but that was
> rejected during review. The reason was, as far as I remember, that the
> number of levels and the corresponding duty cycle values is something
> that's usually determined at system design time. Often backlights can't
> properly light the whole surface of the panel at every level.
>
> That said, there's always the possibility to fake this by adding a DT
> property with a continuous range, such as this:
>
>         brightness-levels = <0 1 2 ... 100>;
>
> Thierry
>

--001a11c126fcb9f46004fccbd52b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I know what you mean because I have here for example =
a panel that only supports a duty cycle between 20 and 100 percent. But wou=
ldn&#39;t I be a possibility to add optional nodes with minimal/maximal bri=
ghtness or something like that?<br>
</div><div><br></div>Hannes<br></div><div class=3D"gmail_extra"><br><br><di=
v class=3D"gmail_quote">2014-06-27 8:12 GMT+02:00 Thierry Reding <span dir=
=3D"ltr">&lt;<a href=3D"mailto:thierry.reding@gmail.com" target=3D"_blank">=
thierry.reding@gmail.com</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On Fri, Jun 27, 2014 at 07:3=
2:20AM +0200, Johannes Pointner wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I&#39;m new working on the linux device drivers, so if I made somethin=
g wrong<br>
&gt; please point me into the right direction.<br>
&gt;<br>
&gt; I&#39;d like to use the pwm_bl driver for a sitara based terminal and =
for this<br>
&gt; I would need the possibility to set the backlight within a percentage<=
br>
&gt; range. The following patch should add this possibility to the pwm_bl<b=
r>
&gt; driver. The idea is to keep backward compatibility by moving the requi=
red<br>
&gt; option brightness levels to optional. Therefore if there is no node wi=
th<br>
&gt; brightness levels the percentage levels are used.<br>
&gt;<br>
&gt; Signed-off-by: Johannes Pointner &lt;<a href=3D"mailto:johannes.pointn=
er@gmail.com">johannes.pointner@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0.../bindings/video/backlight/<br>
&gt; pwm-backlight.txt =C2=A0 =C2=A0 | 11 +++---<br>
&gt; =C2=A0drivers/video/backlight/pwm_bl.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 46<br>
&gt; ++++++++++++----------<br>
&gt; =C2=A02 files changed, 31 insertions(+), 26 deletions(-)<br>
<br>
</div>Also adding the backlight maintainers on Cc.<br>
<br>
This has been discussed a few times before. In fact the original device<br>
tree binding had support for a continuous range of levels but that was<br>
rejected during review. The reason was, as far as I remember, that the<br>
number of levels and the corresponding duty cycle values is something<br>
that&#39;s usually determined at system design time. Often backlights can&#=
39;t<br>
properly light the whole surface of the panel at every level.<br>
<br>
That said, there&#39;s always the possibility to fake this by adding a DT<b=
r>
property with a continuous range, such as this:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 brightness-levels =3D &lt;0 1 2 ... 100&gt;;<br=
>
<br>
Thierry<br>
</blockquote></div><br></div>

--001a11c126fcb9f46004fccbd52b--
