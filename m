From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH -next] pwm: meson: Fix missing spin_lock_init()
Date: Fri, 21 Oct 2016 09:11:28 +0200
Message-ID: <20161021071128.GA2670@ulmo.ba.sec>
References: <1473489518-17981-1-git-send-email-weiyj.lk@gmail.com>
 <57D41083.3060109@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34726 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754831AbcJUHLd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Oct 2016 03:11:33 -0400
Received: by mail-pf0-f193.google.com with SMTP id 128so7826222pfz.1
        for <linux-pwm@vger.kernel.org>; Fri, 21 Oct 2016 00:11:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57D41083.3060109@baylibre.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 10, 2016 at 03:54:11PM +0200, Neil Armstrong wrote:
> Le 10/09/2016 08:38, Wei Yongjun a =C3=A9crit :
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> >=20
> > The driver allocates the spinlock but not initialize it.
> > Use spin_lock_init() on it to initialize it correctly.
> >=20
> > This is detected by Coccinelle semantic patch.
> >=20
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/pwm/pwm-meson.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> > index bfbbe7f..778d088 100644
> > --- a/drivers/pwm/pwm-meson.c
> > +++ b/drivers/pwm/pwm-meson.c
> > @@ -465,6 +465,7 @@ static int meson_pwm_probe(struct platform_device *=
pdev)
> >  	if (IS_ERR(meson->base))
> >  		return PTR_ERR(meson->base);
> > =20
> > +	spin_lock_init(&meson->lock);
> >  	meson->chip.dev =3D &pdev->dev;
> >  	meson->chip.ops =3D &meson_pwm_ops;
> >  	meson->chip.base =3D -1;
> >=20
>=20
> Thanks for the fix, but it was already posted earlier by Axel Lin <axel.l=
in@ingics.com>
>=20
> Thierry will decide which one to merge.
>=20
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

I've applied Axel's patch.

Thanks,
Thierry

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYCb+dAAoJEN0jrNd/PrOhf/wQAJXUqjqcQy+JfqzDdfFkowXB
tgT7m+s6ybpfBjVWxcL8fmdjv+hcZIjjC6P0oBW8orn3VnLcOv5Q4j3qw1y9MCLY
fwbSueSucD8dfLbXUOG2kcbwTTpiTat9PYecOY/3N2ZFZ3sDOQnKKvVn6lIOsmux
7/cjBbMBkCeUB6G2+ZaL99F1mMX4ZjI2/LeJ5x0MjbO5P37SCqSq9i0fhGFswscB
QNHc+742cK5L3AsyAoK+KO42wWCY7FCVqvL8oK22NOgZUzcbZqR2s2k2V7wam1hs
7hJHJhs6/z7WizoJaCrF0nkEVNSBtX706IHr0H08ogK+TpedLaSvntAfr/ebpinO
ARqhrJZuhGcs3AD+sRhoGeD6d4zoM4jURwRa2lgvbGSBOrWuDDt86OpJajg4U9pn
jnU8e61NhOMJEk8Aj//Hrf5I2QC1hu3scOwbTZe0CKsrUykNY2SOo3zUtyWHgktT
/aTerdBTWeV1EPYJaj6lbxJ5YgeXNb7xGuj33V3Qw4GTPx1rvV3VYLljZxiErVog
byVQeAA2IU0YnfKrSLh59o9O7UPF/eFkuiUKN9pHG8cv/NDUhdT8rK6az9PvG55R
PORP22oMYCRZhJOh3LC3J1Wfxsq2akiLKFuHLwhQtdyhtE+7T1rINpMm6LnvnSue
KAMTm7YcuZsUC5R0jzaG
=2lQP
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
