From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: sun4i: add NULL check on of_match_device() return
 value
Date: Fri, 7 Jul 2017 11:33:00 +0200
Message-ID: <20170707093300.GD15652@ulmo.fritz.box>
References: <20170707063939.GA20510@embeddedgus>
 <CAGb2v64vwrTX9=MR-pNZP3eSUQUDj9V=oxx8ef-DaxZVue-pHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v64vwrTX9=MR-pNZP3eSUQUDj9V=oxx8ef-DaxZVue-pHg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-pwm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2017 at 03:16:23PM +0800, Chen-Yu Tsai wrote:
> On Fri, Jul 7, 2017 at 2:39 PM, Gustavo A. R. Silva
> <garsilva@embeddedor.com> wrote:
> > Check return value from call to of_match_device()
> > in order to prevent a NULL pointer dereference.
> >
> > In case of NULL print error message and return -ENODEV
> >
> > Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 1284ffa..295ca19 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -321,6 +321,10 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >         const struct of_device_id *match;
> >
> >         match =3D of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
>=20
> AFAIK this simply can not and should not fail with a device tree
> only driver with properly populated of_device_id tables.

Technically this could happen if someone manually created the platform
device. In that case the core will try to match by name if there is no
device node to use for a match against the list of of_device_ids.

In my opinion it's best to let things crash in this situation to make
it really obvious that people have done something wrong.

Thierry

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAllfVUwACgkQ3SOs138+
s6Gc6g/+LdvqJUo+ajApii8vD2L+2EtlY7HJbHYmnwZORSdXeAwJnGpl2yUKqVI4
LmNOgGPbu4c4iUeMqMo9ZRfbAthgHQUi3Z4bD53IWnhJC+cv+OslE3eysGK96Jks
ygoHCc73usGKPr4A2KI/B8fAuPOZ4NhZoOsfD9ifEPh1vAV1GIn+62nGYUzXZAii
l3oxMAcqEn8MBMoWlFWb/bEEDldXnQc20Str27xIvbVpkjjzch2fBrpFoA/6MYGp
CRfMa7kRX8lF109JH95pTeGV20YwozXfXr5iLZR7Q0XcYcjTVxvmx0ESFiwdlU1U
NElKj3vw/TwR+8mVytNK8yVW8EwEXuss2ij2RUoRDo4V809jaqoQT4gR/49bY+Tn
i2RBqT7uAhb6FHgZmphIfaC3u0ACVR8Pegx5ggdXZZyQDTaV01WI/1m9YDySxfOs
qmT2vD2RWJYvcn1MVohj7uZEnPkIe9rZACznPB56N7RQDa6gos/HtcIcHL2Nwxvi
FP12SMZ1qszKBbNDH/As53nKiFnzdj5k+nfjv4aRfm7ASOcpJfG/oneJyHSs9Sle
DRkNsXDa70AKGRT80Q7aVgAV6cM86LNQ2sisZXDq694pe0T8l1Oo5UXghKddwwTx
t/tubn+v+uLBAKCax4jrKhEs3Zy+9HW885RYQxckW/9/6HIzDzc=
=4AuE
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
