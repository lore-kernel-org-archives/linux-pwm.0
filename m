Return-path: <martin.botka1@gmail.com>
MIME-Version: 1.0
References: <20200724213659.273599-1-martin.botka1@gmail.com> <20200724220516.GA21965@amd>
In-Reply-To: <20200724220516.GA21965@amd>
From: Martin Botka <martin.botka1@gmail.com>
Date: Sat, 25 Jul 2020 00:20:17 +0200
Message-ID: <CADQ2G_HbysJbiQKSRmA6HDRfjPYPiDjbZfeuUjM1mNV-BBBC-A@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000cf89a005ab376228"
Subject: Re: [PATCH RFC 0/6] Add QCOM pwm-lpg and tri-led drivers
To: Pavel Machek <pavel@ucw.cz>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>

--000000000000cf89a005ab376228
Content-Type: text/plain; charset="UTF-8"

Hi,

> Dalsi cech co hackuje LEDky?

Nie. Slovak.

> Bindings should go first, they may need to be converted to yml
> (devicetree people will know).

OK

> Can generic pwm driver be used here?

I have not tried to do that. But considering it's custom chip from Qualcomm
then it's unlikely.

>This is for RGB modules, right? It will need to use multicolor
>framework.

This is for RGB LEDs in phones that are connected via pmic.

> Is this for phone, btw? If so, which one?

Yes it is. And it's for many many phones actually. I have done this mainly
for SONY phones (Xperia 10, 10 Plus, XA2, XA2 Plus, XA2 Ultra).
All of them use these drivers for generating the PWM and controlling the
LEDs.

Best Regards,
Martin

--000000000000cf89a005ab376228
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi,</div><div><br></div><div>&gt; Da=
lsi cech co hackuje LEDky?</div><div><br></div><div>Nie. Slovak.<br></div><=
div><br></div><div>&gt; Bindings should go first, they may need to be conve=
rted to yml<br>
&gt; (devicetree people will know).</div><div><br></div><div>OK</div><div><=
br></div><div>&gt; Can generic pwm driver be used here?</div><div><br></div=
><div>I have not tried to do that. But considering it&#39;s custom chip fro=
m Qualcomm then it&#39;s unlikely.</div><div><br></div><div>&gt;This is for=
 RGB modules, right? It will need to use multicolor<br>
&gt;framework.</div><div><br></div><div>This is for RGB LEDs in phones that=
 are connected via pmic.</div><div><br></div><div>&gt; Is this for phone, b=
tw? If so, which one?</div><div><br></div><div>Yes it is. And it&#39;s for =
many many phones actually. I have done this mainly for SONY phones (Xperia =
10, 10 Plus, XA2, XA2 Plus, XA2 Ultra).</div><div>All of them use these dri=
vers for generating the PWM and controlling the LEDs.</div><div><br></div><=
div>Best Regards,</div><div>Martin<br></div></div></div>

--000000000000cf89a005ab376228--
