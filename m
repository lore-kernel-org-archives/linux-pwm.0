From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight
 toggle
Date: Thu, 17 Oct 2019 15:05:19 +0200
Message-ID: <20191017130519.GC3768303@ulmo>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <20191017114727.fy5tg2kgi6mr2sei@holly.lan>
 <20191017121945.cmcvaffmbd7zydrm@pengutronix.de>
 <CAHCN7xKogdqoLmbbTatPdtLzqz+MKh-jgrHkkCh+YA-bwwOkDA@mail.gmail.com>
 <CAHCN7xJFDrsqzR2H2mNYhKB8iF7xYWb9kM+HdzukjDix461gsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0131821442=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAHCN7xJFDrsqzR2H2mNYhKB8iF7xYWb9kM+HdzukjDix461gsg@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Adam Ford <aford173@gmail.com>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Sascha Hauer <kernel@pengutronix.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org


--===============0131821442==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 07:40:47AM -0500, Adam Ford wrote:
> On Thu, Oct 17, 2019 at 7:34 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > On Thu, Oct 17, 2019 at 7:19 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Thu, Oct 17, 2019 at 12:47:27PM +0100, Daniel Thompson wrote:
> > > > On Thu, Oct 17, 2019 at 10:10:59AM +0200, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> > > > > pwm_get_state() return the last implemented state")) changed the
> > > > > semantic of pwm_get_state() and disclosed an (as it seems) common
> > > > > problem in lowlevel PWM drivers. By not relying on the period and=
 duty
> > > > > cycle being retrievable from a disabled PWM this type of problem =
is
> > > > > worked around.
> > > > >
> > > > > Apart from this issue only calling the pwm_get_state/pwm_apply_st=
ate
> > > > > combo once is also more effective.
> > > >
> > > > I'm only interested in the second paragraph here.
> > > >
> > > > There seems to be a reasonable consensus that the i.MX27 and cros-ec
> > > > PWM drivers should be fixed for the benefit of other PWM clients.
> > > > So we make this change because it makes the pwm-bl better... not to
> > > > work around bugs ;-).
> > >
> > > That's fine, still I think it's fair to explain the motivation of
> > > creating this patch.
> > >
> > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/bac=
klight/pwm_bl.c
> > > > > index 746eebc411df..ddebd62b3978 100644
> > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > @@ -67,40 +62,27 @@ static void pwm_backlight_power_on(struct pwm=
_bl_data *pb)
> > > > >
> > > > >  static void pwm_backlight_power_off(struct pwm_bl_data *pb)
> > > > >  {
> > > > > -   struct pwm_state state;
> > > > > -
> > > > > -   pwm_get_state(pb->pwm, &state);
> > > > > -   if (!pb->enabled)
> > > > > -           return;
> > > > > -
> > > >
> > > > Why remove the pb->enabled check? I thought that was there to ensur=
e we
> > > > don't mess up the regular reference counts.
> > >
> > > I havn't looked yet, but I guess I have to respin. Expect a v2 later
> > > today.
> >
> > I would agree that a high-level fix is better than a series of low
> > level driver fixes.  For what its worth, your V1 patch worked fine on
> > my i.MX6Q.  I can test the V2 patch when its ready.
>=20
> I may have spoken too soon.  The patch fixes the display in that it
> comes on when it previously did not, but changes to brightness do not
> appear to do anything anymore.  I don't have an oscilloscope where I
> am now, so I cannot verify whether or not the PWM duty cycle changes.
>=20
> To my eye, the following do not appear to change the brightness of the sc=
reen:
>      echo 7 > /sys/devices/soc0/backlight-lvds/backlight/backlight-lvds/b=
rightness
>      echo 2 > /sys/devices/soc0/backlight-lvds/backlight/backlight-lvds/b=
rightness
>      echo 5 > /sys/devices/soc0/backlight-lvds/backlight/backlight-lvds/b=
rightness

Hi Adam,

can you try the i.MX PWM patch that I posted earlier instead? I really
think we need to fix this in the PWM drivers because they are broken.
pwm-backlight is not. -rc3 is really not a time to work around breakage
in consumers.

If my patch doesn't help, can you try reverting the offending patch? If
we can't come up with a good fix for the drivers, reverting is the next
best option.

Thierry

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2oZw4ACgkQ3SOs138+
s6HfMg/9Gy8G3OY/oPo9PBR5G7SaUJbK+owhtVcIxCqSYaRZTEqv9QjDiMDtTsIr
DkoX3twloAdvTifihh1M3iFq88U/t5hT0NA9E+xhigZsmml/ZWCW/uf74kILIQ8d
MUm3e0mnzlaI3mUoTof7JpO2fk01ib6Dh55RdKzVenwTaFtJaQjijvKCkwysIzuU
dGB+1zsHKRxhGcjyLEb4nYSPitz/ffre6TyLiQOpt7B6ARmmjYgZoGtOllb2hfej
QwMOcKo/2fX/7e30sfkYVNJPP2C7R8RAQcohZQiVB5K0QlexG9CJ33XRChgb+l/D
XOwwb7AK63Ndf79dEYwLL4RgnIJZO3PPiEf3gx8W2czFNpZ5tBXv+1RJyVGoGKrH
2A1oiA5aE4N0CI8G8XnG9GMX4m4hA+u+aOXBpLuZXySXnSFhgcz7E0F/ACqW+/lz
ok2Yy9Iq8JLZtdP8bIW6JuBTRKSjOr46xoviZLbfbfjbLPc7UbmClGRQTSvImlxH
rOZ7cQQ8rbOUPLC3tBmleL9ZdEAXrgvYJM9oD1NPOf5WWXjiPyvEmPWTP/wZecyK
r+Y25gbFle42SOLoaNwe5q2qpmLGuzx6H2FKMij2ddjV5vQV4LPUkuaY7wpOasOO
TZqlGpLHlDeMgPIdSsfoTGT8WoaKCg5xjGsmqtoMSdX6+uJ23ZU=
=QRHa
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--

--===============0131821442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0131821442==--
