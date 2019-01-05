From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v9 13/27] pwm: jz4740: Use clocks from TCU driver
Date: Sat, 05 Jan 2019 17:52:46 -0300
Message-ID: <1546721566.29843.0@crapouillou.net>
References: <20181227181319.31095-1-paul@crapouillou.net>
        <20181227181319.31095-14-paul@crapouillou.net>
        <20190105194559.jtwyx7th32saa6qh@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105194559.jtwyx7th32saa6qh@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

On Sat, Jan 5, 2019 at 4:45 PM, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>=20
> On Thu, Dec 27, 2018 at 07:13:05PM +0100, Paul Cercueil wrote:
>>  diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>  index 4ed003bc3d8d..0343f0c1238e 100644
>>  --- a/drivers/pwm/Kconfig
>>  +++ b/drivers/pwm/Kconfig
>>  @@ -202,7 +202,8 @@ config PWM_IMX
>>   config PWM_JZ4740
>>   	tristate "Ingenic JZ47xx PWM support"
>>   	depends on MACH_INGENIC
>>  -	select REGMAP
>>  +	depends on COMMON_CLK
>>  +	select INGENIC_TIMER
>=20
> Did you drop REGMAP on purpose?

INGENIC_TIMER selects it, so it's still a dependency but indirectly.
Should I restore it?

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |
=
