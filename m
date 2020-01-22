From: Jeff LaBundy <jeff@labundy.com>
Subject: Re: [PATCH v4 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Date: Wed, 22 Jan 2020 03:56:14 +0000
Message-ID: <20200122035608.GA1455@labundy.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-5-git-send-email-jeff@labundy.com>
 <20200117073427.ufrduwagvppeasgr@pengutronix.de>
 <20200119233234.GB28865@labundy.com>
 <20200120072739.sixr5e76uckrugvu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20200120072739.sixr5e76uckrugvu@pengutronix.de>
Content-Language: en-US
Content-ID: <6BD2F8EB27C13248B19AE6EAD595CEA2@namprd08.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "lee.jones@linaro.org" <lee.jones@linaro.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

> > However, you bring up a really interesting point about preserving what =
may
> > have been done by the bootloader. The device holds itself in POR until =
its
> > supply reaches a sufficient level, so there isn't necessarily a functio=
nal
> > reason to manually issue a soft reset from the parent MFD driver.
> >=20
> > I could get rid of the manual soft reset, and then simply sync both out=
_en
> > and duty_val in iqs620_pwm_probe which would allow iqs620_pwm_get_state=
 to
> > pick up any changes made by the bootloader prior to the kernel coming u=
p.
>=20
> That sounds good. This way the PWM driver is independent of the MFD
> driver and does the right thing no matter if parent resets the chip or
> not.

Agreed on all counts.

> =20
> > The only problem is that leds-pwm disables the pwm at start-up, so the =
end
> > result is the same anyway. Regardless of the behavior of any one consum=
er,
> > however, I'm slightly inclined to go with the second option as it seems=
 to
> > be less restrictive and more maintainable. Let me know if you disagree.
>=20
> With
>=20
> 	default-state =3D "keep";
>=20
> in your dt the LED shouldn't get disabled.

I see default-state defined as a common LED property, but leds-pwm doesn't
seem to use it unfortunately. Looking through its code, brightness is just
initialized to zero unconditionally.

This doesn't change what is the right thing to do, nor do I imagine it to
be a problem for typical use cases, just noting for completeness (however
if I am mistaken please let me know).

>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Kind regards,
Jeff LaBundy
