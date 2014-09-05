Return-Path: <gael.portay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5409C730.3020202@linaro.org>
References: <1409926480-16367-1-git-send-email-gael.portay@gmail.com>
	<1409926480-16367-4-git-send-email-gael.portay@gmail.com>
	<5409C730.3020202@linaro.org>
Date: Fri, 5 Sep 2014 16:47:14 +0200
Message-ID: <CAHs7_BbNQnpbZ3Kt1bO3vBNGFfEcrzC-QZ0jckUyY-XFnE7-Vw@mail.gmail.com>
Subject: Re: [PATCHv3 3/4] ARM: at91/tclib: mask interruptions at shutdown and probe
From: =?ISO-8859-1?Q?Ga=EBl_PORTAY?= <gael.portay@gmail.com>
Content-Type: multipart/alternative; boundary=001a11337eac8290630502528bd3
List-ID: <linux-pwm.vger.kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

--001a11337eac8290630502528bd3
Content-Type: text/plain; charset=ISO-8859-1

On 5 September 2014 16:22, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> + a nit below


Oops, my bad... seems I forgot to run checkpatch...


>  ---
>>   drivers/misc/atmel_tclib.c | 16 ++++++++++++++++
>>   include/linux/atmel_tc.h   |  5 +++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
>> index d505d1e..cc42f39 100644
>> --- a/drivers/misc/atmel_tclib.c
>> +++ b/drivers/misc/atmel_tclib.c
>> @@ -109,6 +109,7 @@ static int __init tc_probe(struct platform_device
>> *pdev)
>>         struct clk      *clk;
>>         int             irq;
>>         struct resource *r;
>> +       unsigned int    i;
>>
>>         irq = platform_get_irq(pdev, 0);
>>         if (irq < 0)
>> @@ -157,18 +158,33 @@ static int __init tc_probe(struct platform_device
>> *pdev)
>>         if (tc->irq[2] < 0)
>>                 tc->irq[2] = irq;
>>
>> +       for (i = 0; i < 3; i++)
>> +               writel(ATMEL_TC_ALL_IRQ, tc->regs + ATMEL_TC_REG(i, IDR));
>> +
>>         spin_lock(&tc_list_lock);
>>         list_add_tail(&tc->node, &tc_list);
>>         spin_unlock(&tc_list_lock);
>>
>> +       platform_set_drvdata(pdev, tc);
>> +
>>         return 0;
>>   }
>>
>> +static void tc_shutdown (struct platform_device *pdev)
>>
>
> Typo : extra space between the function name and the parenthesis.


Fixed. Thanks

--001a11337eac8290630502528bd3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 5=
 September 2014 16:22, Daniel Lezcano <span dir=3D"ltr">&lt;<a href=3D"mail=
to:daniel.lezcano@linaro.org" target=3D"_blank">daniel.lezcano@linaro.org</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb=
"><div class=3D"h5"><br></div></div>
Acked-by: Daniel Lezcano &lt;<a href=3D"mailto:daniel.lezcano@linaro.org" t=
arget=3D"_blank">daniel.lezcano@linaro.org</a>&gt;<br>
<br>
+ a nit below</blockquote><div><br></div><div>Oops, my bad... seems I forgo=
t to run checkpatch...<br></div><div>=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div><div class=3D"h5">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
---<br>
=A0 drivers/misc/atmel_tclib.c | 16 ++++++++++++++++<br>
=A0 include/linux/atmel_tc.h=A0 =A0|=A0 5 +++++<br>
=A0 2 files changed, 21 insertions(+)<br>
<br>
diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c<br>
index d505d1e..cc42f39 100644<br>
--- a/drivers/misc/atmel_tclib.c<br>
+++ b/drivers/misc/atmel_tclib.c<br>
@@ -109,6 +109,7 @@ static int __init tc_probe(struct platform_device *pdev=
)<br>
=A0 =A0 =A0 =A0 struct clk=A0 =A0 =A0 *clk;<br>
=A0 =A0 =A0 =A0 int=A0 =A0 =A0 =A0 =A0 =A0 =A0irq;<br>
=A0 =A0 =A0 =A0 struct resource *r;<br>
+=A0 =A0 =A0 =A0unsigned int=A0 =A0 i;<br>
<br>
=A0 =A0 =A0 =A0 irq =3D platform_get_irq(pdev, 0);<br>
=A0 =A0 =A0 =A0 if (irq &lt; 0)<br>
@@ -157,18 +158,33 @@ static int __init tc_probe(struct platform_device *pd=
ev)<br>
=A0 =A0 =A0 =A0 if (tc-&gt;irq[2] &lt; 0)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tc-&gt;irq[2] =3D irq;<br>
<br>
+=A0 =A0 =A0 =A0for (i =3D 0; i &lt; 3; i++)<br>
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writel(ATMEL_TC_ALL_IRQ, tc-&gt;regs + ATME=
L_TC_REG(i, IDR));<br>
+<br>
=A0 =A0 =A0 =A0 spin_lock(&amp;tc_list_lock);<br>
=A0 =A0 =A0 =A0 list_add_tail(&amp;tc-&gt;node, &amp;tc_list);<br>
=A0 =A0 =A0 =A0 spin_unlock(&amp;tc_list_lock);<br>
<br>
+=A0 =A0 =A0 =A0platform_set_drvdata(pdev, tc);<br>
+<br>
=A0 =A0 =A0 =A0 return 0;<br>
=A0 }<br>
<br>
+static void tc_shutdown (struct platform_device *pdev)<br>
</blockquote>
<br></div></div>
Typo : extra space between the function name and the parenthesis.</blockquo=
te><div><br></div><div>Fixed. Thanks <br></div></div></div></div>

--001a11337eac8290630502528bd3--
