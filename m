From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH] backlight: pwm_bl: disable PWM when 'duty_cycle' is
 zero
Date: Tue, 7 Jun 2016 08:49:07 +0200
Message-ID: <20160607084907.14ffdc03@ipc1.ka-ro>
References: <1465209896-10319-1-git-send-email-LW@KARO-electronics.de>
	<5755664D.5070109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5755664D.5070109@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

On Mon, 6 Jun 2016 15:02:21 +0300 Tomi Valkeinen wrote:
> Hi,
>=20
> On 06/06/16 13:44, Lothar Wa=C3=9Fmann wrote:
> > 'brightness' is usually an index into a table of duty_cycle values,
> > where the value at index 0 may well be non-zero
> > (tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dts are real-l=
ife
> > examples).
> > Thus brightness =3D=3D 0 does not necessarily mean that the PWM out=
put
> > will be inactive.
> > Check for 'duty_cycle =3D=3D 0' rather than 'brightness =3D=3D 0' t=
o decide
> > whether to disable the PWM.
>=20
> The binding doc does say:
>=20
>   - brightness-levels: Array of distinct brightness levels. Typically=
 these
>       are in the range from 0 to 255, but any range starting at 0 wil=
l do.
>       The actual brightness level (PWM duty cycle) will be interpolat=
ed
>       from these values. 0 means a 0% duty cycle (darkest/off), while=
 the
>       last value in the array represents a 100% duty cycle (brightest=
).
>=20
So, what should I do, when I need a range of levels that doesn't start
at 0? E.g. if the brightness is inverse proportional to the PWM duty
cycle.



Lothar Wa=C3=9Fmann
