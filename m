Return-Path: <john.tobias.ph@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20161021072901.GE2670@ulmo.ba.sec>
References: <CACUGKYNYLnRkWuaMWsc+524C2TscjL2L2AU-eFP-JNKy879AvQ@mail.gmail.com>
 <20161021072901.GE2670@ulmo.ba.sec>
From: John Tobias <john.tobias.ph@gmail.com>
Date: Fri, 21 Oct 2016 06:07:35 -0700
Message-ID: <CACUGKYMgoxZ_7P=g7xtXnW1FKTdF+grLqdMRLLZ_xGGf906FVw@mail.gmail.com>
Subject: Re: PWM on Suspend To Ram
Content-Type: multipart/alternative; boundary=001a11417d66db3e1d053f5fb9a6
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Liu Ying <Ying.Liu@freescale.com>, linux-pwm@vger.kernel.org

--001a11417d66db3e1d053f5fb9a6
Content-Type: text/plain; charset=UTF-8

I had it working.

On Oct 21, 2016 12:29 AM, "Thierry Reding" <thierry.reding@gmail.com> wrote:

> On Tue, Sep 20, 2016 at 08:50:29AM -0700, John Tobias wrote:
> > Hi Guys,
> >
> > I have an iMX6 board and I can put the device in Suspend to RAM mode.
> > While in the said mode, I would like to keep the PWM up and running
> > (The iMX6 PWM support low power mode).
> >
> > During the suspend mode, I set all the registers that I do believe to
> > enable the PWM, but I am not getting the any signals.
> >
> > I would like to know if anyone here have any idea how to tweak it in
> > order to accomplish for what I need?.
>
> Cc'ing Shawn and Liu. Any ideas?
>
> Thierry
>

--001a11417d66db3e1d053f5fb9a6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I had it working. </p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Oct 21, 2016 1=
2:29 AM, &quot;Thierry Reding&quot; &lt;<a href=3D"mailto:thierry.reding@gm=
ail.com">thierry.reding@gmail.com</a>&gt; wrote:<br type=3D"attribution"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">On Tue, Sep 20, 2016 at 08:50:29AM -0700, John=
 Tobias wrote:<br>
&gt; Hi Guys,<br>
&gt;<br>
&gt; I have an iMX6 board and I can put the device in Suspend to RAM mode.<=
br>
&gt; While in the said mode, I would like to keep the PWM up and running<br=
>
&gt; (The iMX6 PWM support low power mode).<br>
&gt;<br>
&gt; During the suspend mode, I set all the registers that I do believe to<=
br>
&gt; enable the PWM, but I am not getting the any signals.<br>
&gt;<br>
&gt; I would like to know if anyone here have any idea how to tweak it in<b=
r>
&gt; order to accomplish for what I need?.<br>
<br>
Cc&#39;ing Shawn and Liu. Any ideas?<br>
<br>
Thierry<br>
</blockquote></div></div>

--001a11417d66db3e1d053f5fb9a6--
