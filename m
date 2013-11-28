From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/3] pwm: Add mc13xxx pwm driver.
Date: Thu, 28 Nov 2013 16:56:07 +0100
Message-ID: <20131128155606.GC23201@ulmo.nvidia.com>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
 <529616A9.2090909@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:54402 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781Ab3K1P4y (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Nov 2013 10:56:54 -0500
Content-Disposition: inline
In-Reply-To: <529616A9.2090909@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Philippe =?utf-8?B?UsOpdG9ybmF6?= <philippe.retornaz@gmail.com>
Cc: Denis Carikli <denis@eukrea.com>, linux-pwm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2013 at 04:58:33PM +0100, Philippe R=C3=A9tornaz wrote:
> Hi
>=20
> >+struct mc13xxx *get_mc13xxx(void)
> >+{
> >+	return mc13xxx_data;
> >+}
> >+EXPORT_SYMBOL_GPL(get_mc13xxx);
> >+
> >  int mc13xxx_common_init(struct mc13xxx *mc13xxx,
> >  		struct mc13xxx_platform_data *pdata, int irq)
> >  {
> >@@ -706,6 +714,9 @@ err_revision:
> >  		mc13xxx_add_subdevice(mc13xxx, "%s-pwrbutton");
> >  	}
> >
> >+	/* Linux will not have to handle more than one mc13xxx pmic. */
> >+	mc13xxx_data =3D mc13xxx;
> >+
>=20
> Why using a such hack instead of an MFD subdevice ?

I agree, let's not do this please.

Thierry

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSl2eWAAoJEN0jrNd/PrOh1xwQAI5XIUPegUuk5AevXnw405Y1
dPI8cWkI5ymjuqz887T36k/hWzs6AVqRy6+HbQn09RzWVXuLNfvxZHavgn/dpF8z
RNWweqbjvuEhuakjPBlvfQdDc9JqkakUsIiT37AWmCXfkdnD2D6KLHxfphO1WY0m
M2PhcmymNfjPf3Jej958PpUhz/7s3fefiklnIasNEIXs3TmF1LeD7On07GZ7pJPh
BHf+Bo3FYRCmzvwVdM5h30LYkUHKvdz29F13oi8oJC7w7ejO1bIpSPkA1eJgzFO0
5rdv0RsJzl7G0zg3+uRg98lAkHwVmQeO9fKcG6OXI4NCwjOJpGzhslE2NI6q2Rxy
i27+H38GfKrfgfMMFSQUvBbrbFo5sJuNxVB3Bcjjt/xATRc0oSALT0cZbwZ1Dnrq
Yy3O4Ooqolyq+7CKt+JUJdSjkKeZ0NnsPRLfg4Zz9xgMEgiGKiyl51HoI9F3Qo8C
JqyVWgeeMDrchXuYDwTfLpPDOESdU7qY3IDIsw7sqWOw0xquTUqow+XIEliwhIuH
uhRaVrLEROKm5jzz5WRR6kN0hamoYZI+UQe6oyHv66TTnIuwtQlzup/9St5zK7tW
6Yw6SQ+8gUHWXcOTj4P+yyS9h81uIdJC+RFHSTpAiXI/obTE2KFm/U5qz9vUsIZr
MGA9y6MX1i2hU2iJDHyX
=L0bO
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
