From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: pwm-backlight: 3.13-rc1 regression for old arm machine
Date: Tue, 17 Dec 2013 10:57:00 +0100
Message-ID: <20131217095658.GD13823@ulmo.nvidia.com>
References: <87r49c6bea.fsf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:47277 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab3LQJ60 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Dec 2013 04:58:26 -0500
Received: by mail-bk0-f44.google.com with SMTP id d7so2765434bkh.3
        for <linux-pwm@vger.kernel.org>; Tue, 17 Dec 2013 01:58:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87r49c6bea.fsf@free.fr>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org


--tVmo9FyGdCe4F4YN
Content-Type: multipart/mixed; boundary="+KJYzRxRHjYqLGl5"
Content-Disposition: inline


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2013 at 04:52:45PM +0100, Robert Jarzmik wrote:
> Hi Thierry,

Hi Robert,

Please always Cc the linux-pwm mailing list for PWM related questions.
I've done that now.

> Since recently, and probable since last Linus's merge of PWM tree (Merge =
tag
> 'pwm/for-3.13-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm), =
my
> platform has its backlight broken.
>=20
> The particularity of my platform:
>  - arch/arm/mach-pxa/mioa701.c
>  - no device tree
>  - no power supply regulator for backlight
>  - backlight controlled by a PWM
>  - kernel message :
> [    1.495480] platform pwm-backlight: Driver pwm-backlight requests prob=
e deferral
>=20
> I think other "old" platforms will suffer from this. Do you have a
> recommendation ?

I hadn't anticipated that =3D(. In fact I had been holding this patch back
for a release cycle because I was waiting for a specific regulator patch
to land which provides a dummy regulator if one wasn't specified. It
seems that that patch only works when booting from DT, though.

The correct way to fix this would be to provide a lookup table with the
dummy regulator in the board file. I've attached a patch (compile-tested
only) that might work.

If it does, please let me know and, if nobody else volunteers, I'll see
if I can come up with a set of patches to fix this for any other boards
that have the same issue.

Thierry

--+KJYzRxRHjYqLGl5
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0001-ARM-pxa-Add-dummy-power-supply-for-backlight-for-Mit.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 8c25d9b1465acd2dcd05644f2c984b54ae3dfc53 Mon Sep 17 00:00:00 2001
=46rom: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 17 Dec 2013 10:52:36 +0100
Subject: [PATCH] ARM: pxa: Add dummy power supply for backlight for Mitac M=
io
 A701

Recent changes to the pwm-backlight driver have made the power supply
mandatory. There is code in the regulator core to deal with situations
where no regulator is specified and provide a dummy, but that works on
DT-based boards only.

The situation can be remedied by adding a dummy regulator during board
initialization.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/arm/mach-pxa/mioa701.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index f70583fee59f..5cb3a3b33772 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -38,6 +38,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/reboot.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/max1586.h>
 #include <linux/slab.h>
 #include <linux/i2c/pxa-i2c.h>
@@ -714,6 +715,10 @@ static struct gpio global_gpios[] =3D {
 	{ GPIO56_MT9M111_nOE, GPIOF_OUT_INIT_LOW, "Camera nOE" },
 };
=20
+static struct regulator_consumer_supply fixed_5v0_consumers[] =3D {
+	REGULATOR_SUPPLY("power", "pwm-backlight.0"),
+};
+
 static void __init mioa701_machine_init(void)
 {
 	int rc;
@@ -753,6 +758,10 @@ static void __init mioa701_machine_init(void)
 	pxa_set_i2c_info(&i2c_pdata);
 	pxa27x_set_i2c_power_info(NULL);
 	pxa_set_camera_info(&mioa701_pxacamera_platform_data);
+
+	regulator_register_always_on(0, "fixed-5.0V", fixed_5v0_consumers,
+				     ARRAY_SIZE(fixed_5v0_consumers),
+				     5000000);
 }
=20
 static void mioa701_machine_exit(void)
--=20
1.8.4.2


--+KJYzRxRHjYqLGl5--

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsB/qAAoJEN0jrNd/PrOhpHIP/RMkLMKHG7U9dF+D7vKHe1pZ
2MKc9qMtwYFmSVBbjAdlibV983zmftzoVgblg3eeGlP4heLW2c4xXfEpHE9XBzGQ
spQOgowcq/9pNlnvGFN25HdTtdUJOWsF0NamoYOgD7y/jAnyVhBTLyvg92larARZ
6SbwFVNqyrk88RSWJV92pYjqN62d3CUcPm+F5yJYigjQHOx/xxba9YfyJF8YHWXI
deGrud3uv07sHuq6BCFc7EC0kSNg4djS05vqzLgMMB+ktOSY8Xi4x4HI6E3tURfv
oLfw0Faxr8QRp1NdCLKAYqXfnamGIOaPKM3jHJVwaHWQFhrY5ja5lTXwY0Qz/MXv
TaxkWBUNn0+mgTyH30WYu69I1V+SqUVFcLf9a08py1SihCjEl/adgPWIj74WpD/t
pd5FYwGCDdF6EUNmMZd/DHJVh4yJmtNM1HWkVp/sNd701qEU7BVX+q3YO9pubWMy
Y5ZM+a4Gqr/pnU1M3x+d6QS9syG/VMpWbn9eR4B3Kgqkq1lHwih7UN+Dj9st/jwI
opVni7Rpn+DYiczp12MBbBWmQcwX9kRxc15cKxWazf7WTJtuTEtwKYagThb2Nboa
i27CVBJWtjqCjb2ZRtrYbRiyzsezSSu966nV9uzXyW8+eaiAHF05vMbdJhj8gUb0
Tt/lUnwYFNrWs6t+fKri
=2T5c
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--
