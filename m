From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [RFC PATCH 08/10] rtc: New driver for RTC in Netronix embedded
 controller
Date: Sat, 4 Jul 2020 21:23:23 +0200
Message-ID: <20200704192323.GC2578@latitude>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-7-j.neuschaefer@gmx.net>
 <20200621001106.GC131826@piout.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200621001106.GC131826-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko.stuebner-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, allen <allen.chen@i>
List-Id: linux-pwm@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 21, 2020 at 02:11:06AM +0200, Alexandre Belloni wrote:
> On 21/06/2020 00:42:19+0200, Jonathan Neusch=C3=A4fer wrote:
> > With this driver, mainline Linux can keep its time and date in sync with
> > the vendor kernel.
> >=20
> > Advanced functionality like alarm and automatic power-on is not yet
> > supported.
> >=20
>=20
> Please report the results of rtctest (from the kernel tree) [...]

  # ./rtctest
  [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 7 tests from 2 test cases.
  [ RUN      ] rtc.date_read
  ../../tools/testing/selftests/rtc/rtctest.c:49:date_read:Current RTC date=
/time is 11/04/2006 23:11:23.
  [       OK ] rtc.date_read
  [ RUN      ] rtc.uie_read
  [  180.651355] random: crng init done
  uie_read: Test terminated by timeout
  [     FAIL ] rtc.uie_read
  [ RUN      ] rtc.uie_select
  ../../tools/testing/selftests/rtc/rtctest.c:98:uie_select:Expected 0 (0) =
!=3D rc (0)
  uie_select: Test terminated by assertion
  [     FAIL ] rtc.uie_select
  [ RUN      ] rtc.alarm_alm_set
  ../../tools/testing/selftests/rtc/rtctest.c:129:alarm_alm_set:skip alarms=
 are not supported.
  [       OK ] rtc.alarm_alm_set
  [ RUN      ] rtc.alarm_wkalm_set
  ../../tools/testing/selftests/rtc/rtctest.c:185:alarm_wkalm_set:skip alar=
ms are not supported.
  [       OK ] rtc.alarm_wkalm_set
  [ RUN      ] rtc.alarm_alm_set_minute
  ../../tools/testing/selftests/rtc/rtctest.c:231:alarm_alm_set_minute:skip=
 alarms are not supported.
  [       OK ] rtc.alarm_alm_set_minute
  [ RUN      ] rtc.alarm_wkalm_set_minute
  ../../tools/testing/selftests/rtc/rtctest.c:287:alarm_wkalm_set_minute:sk=
ip alarms are not supported.
  [       OK ] rtc.alarm_wkalm_set_minute
  [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 5 / 7 tests passed.
  [  FAILED  ]

> [...] and rtc-range
> (https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/t=
ree/rtc-range.c)

  # ./rtc-range
 =20
  Testing 1970-01-01 00:00:00.
  KO  Read back 2226-01-01 00:01:00.
 =20
  Testing 2000-02-28 23:59:59.
  KO  Read back 2000-02-28 23:28:23.
 =20
  Testing 2020-02-28 23:59:59.
  KO  Read back 2020-02-28 23:28:23.
 =20
  Testing 2038-01-19 03:14:07.
  KO  Read back 2038-01-19 03:19:03.
 =20
  Testing 2069-12-31 23:59:59.
  KO  Read back 2069-12-31 23:31:23.
 =20
  Testing 2079-12-31 23:59:59.
  KO  Read back 2079-12-31 23:31:23.
 =20
  Testing 2099-12-31 23:59:59.
  KO  Read back 2099-12-31 23:31:23.
 =20
  Testing 2255-12-31 23:59:59.
  KO  Read back 2255-12-31 23:31:23.
 =20
  Testing 2100-02-28 23:59:59.
  KO  Read back 2100-02-28 23:28:23.
 =20
  Testing 2106-02-07 06:28:15.
  KO  Read back 2106-02-07 06:07:06.
 =20
  Testing 2262-04-11 23:47:16.
  KO  Read back 2006-04-11 23:11:23.


Something is very wrong here.

I'll try to fix the failures in rtctest and the problems in rtc-range
before version 2 of the patchset.

(The 2255 date was my addition, because I suspect this to be the upper
limit of the RTC's range.)


[...]
> > +config RTC_DRV_NTXEC
> > +	tristate "Netronix embedded controller RTC driver"
> > +	depends on MFD_NTXEC
> > +
>=20
> This should get an help section.

Ok, I'll add one.


[...]
> > +#include <linux/rtc.h>
> > +#include <linux/mfd/ntxec.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/types.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
>=20
> Please sort the includes.

Will do.


[...]
> > +	rtcdev =3D devm_rtc_device_register(&pdev->dev, "ntxec-rtc",
> > +					  &ntxec_rtc_ops, THIS_MODULE);
>=20
> Please use devm_rtc_allocate_device and rtc_register_device. Also, set
> the supported range (->range_min and ->range_max).

Ok, will do.


Thanks for the review and the testing tips.
Jonathan Neusch=C3=A4fer

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl8A1yAACgkQCDBEmo7z
X9tNnA/9H+BT9wwk5LCwgYRQGaCp/1zm7d962UhBAu5F59rAP2Ho8ioQNoJcCc0/
xwAaeJYaRm7iOWjVdlL0wfnv8kJRDjYs4ml0arpTPFW4dmz4+zvFoZfIVIlUHy+1
t/cY1k/KCTXqAXUmyVMMZ6b3Q7/mwjKYLQV2nRgW3sHiBoQI2q6cV69XQZM1JVo0
NV+m7HGvL5AmPZGjLmbSC8PiOMlS35Tm6v0IKrYXHt3ASOF7ukMqTMT3+1aRCrzs
zqtZHJdUfGA3DpkZTiLK+m8t5L4t6qsiyd+QX9jFg1KaSXapVF5nV+wNYgdebcqQ
UqeA5ylgENA6WaYv5N8xl1MO6UZhYiH5Qw/mJZ0rG4pyf0Ad6nZJxd+l8eWseMFX
LCOtTqRIKC6Oa2sKPUI/TN56GafA1cK+ZHljn/FjpI5CUQfHlcAz/QEkACPIs1S8
WtMdsBfP3cjqGPapGbknlBi8KGnyL/qFj42PCOApXdNOczJAXMRfvvXYHfdnVxUx
9pw9oAc06PijFOB72FUMYA3U2aiNz5Qk+zMmmsTFDAnRJmsnFc8hhooewHn4Ha3I
AiJVhLvGrzVlSS8Yq7O2jm1SsRYKAO93YctBIxMfRJvd2a+72++4X7oPc1qKxCkQ
U5YIMEbe4JyTCq0Bj6rbOd1k4+36LVMRT/jyGg7DK66PUgfB2dI=
=jCx0
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
