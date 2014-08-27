Return-Path: <gael.portay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20140820073111.GH13793@ulmo>
References: <1408486072-19268-1-git-send-email-gael.portay@gmail.com>
	<1408486072-19268-4-git-send-email-gael.portay@gmail.com>
	<776D4128-09AC-418C-A710-28A2522D1D63@jcrosoft.com>
	<20140820010130.10974326@bbrezillon>
	<20140820073111.GH13793@ulmo>
Date: Wed, 27 Aug 2014 17:27:32 +0200
Message-ID: <CAHs7_Bb2Qu8asq_48Q=G9ZviOqZnVZPAaAgqbrfSHhOAD_QFHQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: at91/tclib: mask interruptions at shutdown and probe
From: =?ISO-8859-1?Q?Ga=EBl_PORTAY?= <gael.portay@gmail.com>
Content-Type: multipart/alternative; boundary=001a11c257aa0c36c405019e0fe3
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas FERRE <nicolas.ferre@atmel.com>, Thomas Gleixner <tglx@linutronix.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>

--001a11c257aa0c36c405019e0fe3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20 August 2014 09:31, Thierry Reding <thierry.reding@gmail.com> wrote:

> Wouldn't a more proper fix be to only enable the IRQ (setup_irq()) once
> everything has properly been set up? That's certainly how all other
> drivers are doing this. Generally I think it's best to assume that an
> interrupt can fire at any point after it's been enabled, so everything
> should be set up prior to enabling it.
>

I think we cannot move the IRQ request after the clock registration...

I did not find any clockevents_DEconfig_and_UNregister function... so if th=
e
IRQ request fails, it will not be possible to unregister from the clock
events.

It would be preferable to leave the IRQ request before the clock
registration, is not it ?


> Also, does anyone know why this driver uses setup_irq() rather than the
> more idiomatic request_irq()?
>

I took care of that...

By the way, if case of request failure, would it be cleaner to process a
clk_disable_unprepare(t2_clk) before returning ?

     clkevt.clkevt.cpumask =3D cpumask_of(0);

     ret =3D request_irq(irq, ch2_irq, IRQF_TIMER, "tc_clkevt", &clkevt);
     if (ret) {
+         clk_disable_unprepare(t2_clk);
         return ret;
     }

    clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);

Ga=EBl

--001a11c257aa0c36c405019e0fe3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 20 August 2014 09:31, Thierry Reding <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:thierry.reding@gmail.com" target=3D"_blank">thierry.reding@gmail.com</=
a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Wouldn&#39;t a more prope=
r fix be to only enable the IRQ (setup_irq()) once<br>
everything has properly been set up? That&#39;s certainly how all other<br>
drivers are doing this. Generally I think it&#39;s best to assume that an<b=
r>
interrupt can fire at any point after it&#39;s been enabled, so everything<=
br>
should be set up prior to enabling it.<br></blockquote><div><br>I think we =
cannot move the IRQ request after the clock registration...<br><br><div cla=
ss=3D"gmail_extra">I did not find any clockevents_DEconfig_and_UNregister f=
unction... so if the<br>
IRQ request fails, it will not be possible to unregister from the clock eve=
nts.<br><br></div>It would be preferable to leave the IRQ request before th=
e clock registration, is not it ?<br>=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">

Also, does anyone know why this driver uses setup_irq() rather than the<br>
more idiomatic request_irq()?<span class=3D""><font color=3D"#888888"><br><=
/font></span></blockquote><div>=A0</div></div>I took care of that...<br><br=
>By the way, if case of request failure, would it be cleaner to process a<b=
r>
clk_disable_unprepare(t2_clk) before returning ?<br><br>=A0=A0=A0=A0 clkevt=
.clkevt.cpumask =3D cpumask_of(0);<br><br>=A0 =A0=A0 ret =3D request_irq(ir=
q, ch2_irq, IRQF_TIMER, &quot;tc_clkevt&quot;, &amp;clkevt);<br>=A0=A0 =A0 =
if (ret) {<br>+ =A0 =A0 =A0=A0=A0 clk_disable_unprepare(t2_clk);<br>
=A0=A0=A0 =A0 =A0=A0 return ret;<br>=A0=A0=A0=A0 }<br><br>=A0=A0=A0 clockev=
ents_config_and_register(&amp;clkevt.clkevt, 32768, 1, 0xffff);<br><br>Ga=
=EBl<br></div></div>

--001a11c257aa0c36c405019e0fe3--
