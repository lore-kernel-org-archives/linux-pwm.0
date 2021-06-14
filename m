Return-path: <andy.shevchenko@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 Jun 2021 10:25:30 +0300
Message-ID: <CAHp75VdMxns2GJf6WGVY=tsv=dwf_f++q2-Chw0CJLp_R8n09A@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000029634e05c4b4c34e"
Subject: Re: [PATCH 0/7] Prepare EP93xx drivers for Common Clock Framework
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Nikita Shubin <nikita.shubin@maquefel.me>, Vinod Koul <vkoul@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-pwm.vger.kernel.org>

--00000000000029634e05c4b4c34e
Content-Type: text/plain; charset="UTF-8"

On Monday, June 14, 2021, Alexander Sverdlin <alexander.sverdlin@gmail.com>
wrote:

> Nikita posted a patch converting EP93xx to use Common Clock Framework. It
> turns out some cleanup is necessary in the EP93xx drivers to avoid
> "Enabling unprepared" clock warnings.
>
> Patches with stack traces in the commit messages are tested on EP9302.
>
> Link: https://lore.kernel.org/patchwork/patch/1435884/
>
>
For all commit messages: please, reduce the noise in them as much as
possible, i.e. leave only up to ~3-4 most significant lines out of
trackbacks.



> Alexander Sverdlin (7):
>   iio: ep93xx: Prepare clock before using it
>   spi: spi-ep93xx: Prepare clock before using it
>   Input: ep93xx_keypad: Prepare clock before using it
>   video: ep93xx: Prepare clock before using it
>   dmaengine: ep93xx: Prepare clock before using it
>   ASoC: cirrus: i2s: Prepare clock before using it
>   pwm: ep93xx: Prepare clock before using it
>
>  drivers/dma/ep93xx_dma.c               |  6 +++---
>  drivers/iio/adc/ep93xx_adc.c           |  6 +++---
>  drivers/input/keyboard/ep93xx_keypad.c |  4 ++--
>  drivers/pwm/pwm-ep93xx.c               | 12 ++++++------
>  drivers/spi/spi-ep93xx.c               |  4 ++--
>  drivers/video/fbdev/ep93xx-fb.c        |  4 ++--
>  sound/soc/cirrus/ep93xx-i2s.c          | 12 ++++++------
>  7 files changed, 24 insertions(+), 24 deletions(-)
>
> --
> 2.32.0
>
>

-- 
With Best Regards,
Andy Shevchenko

--00000000000029634e05c4b4c34e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, June 14, 2021, Alexander Sverdlin &lt;<a href=3D"mailto:=
alexander.sverdlin@gmail.com">alexander.sverdlin@gmail.com</a>&gt; wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">Nikita posted a patch converting EP93xx to=
 use Common Clock Framework. It<br>
turns out some cleanup is necessary in the EP93xx drivers to avoid<br>
&quot;Enabling unprepared&quot; clock warnings.<br>
<br>
Patches with stack traces in the commit messages are tested on EP9302.<br>
<br>
Link: <a href=3D"https://lore.kernel.org/patchwork/patch/1435884/" target=
=3D"_blank">https://lore.kernel.org/<wbr>patchwork/patch/1435884/</a><br>
<br></blockquote><div><br></div><div>For all commit messages: please, reduc=
e the noise in them as much as possible, i.e. leave only up to ~3-4 most si=
gnificant lines out of trackbacks.</div><div><br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
Alexander Sverdlin (7):<br>
=C2=A0 iio: ep93xx: Prepare clock before using it<br>
=C2=A0 spi: spi-ep93xx: Prepare clock before using it<br>
=C2=A0 Input: ep93xx_keypad: Prepare clock before using it<br>
=C2=A0 video: ep93xx: Prepare clock before using it<br>
=C2=A0 dmaengine: ep93xx: Prepare clock before using it<br>
=C2=A0 ASoC: cirrus: i2s: Prepare clock before using it<br>
=C2=A0 pwm: ep93xx: Prepare clock before using it<br>
<br>
=C2=A0drivers/dma/ep93xx_dma.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 6 +++---<br>
=C2=A0drivers/iio/adc/ep93xx_adc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 6 +++---<br>
=C2=A0drivers/input/keyboard/ep93xx_<wbr>keypad.c |=C2=A0 4 ++--<br>
=C2=A0drivers/pwm/pwm-ep93xx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 12 ++++++------<br>
=C2=A0drivers/spi/spi-ep93xx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 4 ++--<br>
=C2=A0drivers/video/fbdev/ep93xx-fb.<wbr>c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 4 ++--<br>
=C2=A0sound/soc/cirrus/ep93xx-i2s.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 12 =
++++++------<br>
=C2=A07 files changed, 24 insertions(+), 24 deletions(-)<br>
<br>
-- <br>
2.32.0<br>
<br>
</blockquote><br><br>-- <br>With Best Regards,<br>Andy Shevchenko<br><br><b=
r>

--00000000000029634e05c4b4c34e--
