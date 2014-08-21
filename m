Return-Path: <gael.portay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201408210533.00196.arnd@arndb.de>
References: <1408486072-19268-1-git-send-email-gael.portay@gmail.com>
	<1408486072-19268-4-git-send-email-gael.portay@gmail.com>
	<201408210533.00196.arnd@arndb.de>
Date: Thu, 21 Aug 2014 11:43:33 +0200
Message-ID: <CAHs7_BaWaW8R5+XOoekgusr7i9DT2o0GvTTZxTvwS_yRymhD-A@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: at91/tclib: mask interruptions at shutdown and probe
From: =?ISO-8859-1?Q?Ga=EBl_PORTAY?= <gael.portay@gmail.com>
Content-Type: multipart/alternative; boundary=047d7b34313cd7a9020501208d9d
List-ID: <linux-pwm.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Boris Brezillon <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

--047d7b34313cd7a9020501208d9d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21 August 2014 05:32, Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 20 August 2014, Ga=EBl PORTAY wrote:
> > +static void tc_shutdown (struct platform_device *pdev)
> > +{
> > +       int i;
> > +       struct atmel_tc *tc =3D platform_get_drvdata(pdev);
> > +
> > +       for (i =3D 0; i < 3; i++)
> > +               __raw_writel(0xff, tc->regs + ATMEL_TC_REG(i, IDR));
> > +}
>
> In general, __raw_readl/__raw_writel are not meant to be called by device
> drivers.
>
> Just use readl/writel by default, or readl_relaxed/writel_relaxed if the
> code is
> performance critical and you are sure it is safe to use them.
>
>         Arnd
>

Ok, I will thix this.

I used __raw_readl/__raw_writel, because those functions are used in the
tcb_clksrc driver.

By the way... thanks every one for your review :)

--=20
Ga=EBl PORTAY

--047d7b34313cd7a9020501208d9d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 2=
1 August 2014 05:32, Arnd Bergmann <span dir=3D"ltr">&lt;<a href=3D"mailto:=
arnd@arndb.de" target=3D"_blank">arnd@arndb.de</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D"">On Wednesday 20 August 2014, Ga=EBl PORTAY wrote:<br>
&gt; +static void tc_shutdown (struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=A0 =A0 =A0 =A0int i;<br>
&gt; +=A0 =A0 =A0 =A0struct atmel_tc *tc =3D platform_get_drvdata(pdev);<br=
>
&gt; +<br>
&gt; +=A0 =A0 =A0 =A0for (i =3D 0; i &lt; 3; i++)<br>
&gt; +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__raw_writel(0xff, tc-&gt;regs + ATMEL=
_TC_REG(i, IDR));<br>
&gt; +}<br>
<br>
</div>In general, __raw_readl/__raw_writel are not meant to be called by de=
vice drivers.<br>
<br>
Just use readl/writel by default, or readl_relaxed/writel_relaxed if the co=
de is<br>
performance critical and you are sure it is safe to use them.<br>
<span class=3D""><font color=3D"#888888"><br>
=A0 =A0 =A0 =A0 Arnd<br>
</font></span></blockquote></div><br></div><div class=3D"gmail_extra">Ok, I=
 will thix this.<br><br></div><div class=3D"gmail_extra">I used __raw_readl=
/__raw_writel, because those functions are used in the tcb_clksrc driver.<b=
r>
</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">By th=
e way... thanks every one for your review :)<br clear=3D"all"><br>-- <br>Ga=
=EBl PORTAY<br></div></div>

--047d7b34313cd7a9020501208d9d--
