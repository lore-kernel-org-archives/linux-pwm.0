From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/6] pwm: pwm-lpc18xx-sct: test clock rate to avoid
 division by 0
Date: Wed, 2 Mar 2016 23:58:53 +0100
Message-ID: <20160302225853.GA2303@katana>
References: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
 <1456958018-7849-5-git-send-email-wsa@the-dreams.de>
 <CAGhQ9VzQLfhT4erDam_69-Zf4vp3gzKx+jbanXM8Ky+fmG=6EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGhQ9VzQLfhT4erDam_69-Zf4vp3gzKx+jbanXM8Ky+fmG=6EQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
List-Id: linux-pwm@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2016 at 11:44:02PM +0100, Joachim Eastwood wrote:
> Hi Wolfram,
>=20
> On 2 March 2016 at 23:33, Wolfram Sang <wsa@the-dreams.de> wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > The clk API may return 0 on clk_get_rate, so we should check the result=
 before
> > using it as a divisor.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >
> > Should go individually via subsystem tree.
> >
> >  drivers/pwm/pwm-lpc18xx-sct.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sc=
t.c
> > index 9163085101bc94..6487962c355c03 100644
> > --- a/drivers/pwm/pwm-lpc18xx-sct.c
> > +++ b/drivers/pwm/pwm-lpc18xx-sct.c
> > @@ -360,6 +360,8 @@ static int lpc18xx_pwm_probe(struct platform_device=
 *pdev)
> >         }
> >
> >         lpc18xx_pwm->clk_rate =3D clk_get_rate(lpc18xx_pwm->pwm_clk);
> > +       if (!lpc18xx_pwm->clk_rate)
> > +               return -EINVAL;
>=20
> This needs to be:
> if (!lpc18xx_pwm->clk_rate) {
>     ret =3D -EINVAL;
>     goto disable_pwmclk;
> }

Yes, that slipped through. Thanks!

> I would also prefer an explicit check against 0 here. ie.:

Well, I like the reading "if not rate then error"

Will send V2 now...


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW13AtAAoJEBQN5MwUoCm2muUP/26foO3ZREQHUse/Q19uii2/
XONWVY7l2K88UPuE4nlqQEYwuqBtiai1vBIx3uQTwVEVaF7zIBQ4M76OAcBF7FHF
DWC5tLhhoALRXqszUNiV1vdKYzD3Lvn5U9Bdpskef29NuxWCogYsvWUAfFV5Hc1q
mZVYj+dwyJxiX11axbvMK+uw4w9D6+w7rHIYfI5Xj1MJiWD1SfLrJArpFcCnVzQC
3SBTRlgnMssIdKA/vZK9K+Fzazar7VLZmHEka0NIaWVHS42NKGYbNFQLH5tcfI3m
0f/TArO7cHoXF6YOEMicQpOpn+cu5ma7s+FWezE1qyiQkPIoJGO1OnnwwzT0eOaa
lyRP9yOm4gV0siX7j69qd1oalefE5yt5XGGRrEnutAA6aBqr/YHrXna18dj90Gi3
LmJ3dgXcLV6AoDQfpEJZNZvgTES5YZOQjrp8kW5iXY4swoqf8xu45bV5+2ZdNO/B
tXTiTK1sjW1O+UUd9i0Q2uTPHf2jnHErKDrvzrBfRldMuWuY10GkGqhf8IZsYAe8
2j6tRNMsGuAUmDPVlOQaWkt88VipigiMHLODM/pJ3DZ/ZmYSOAgdPdBarQU4vQaK
FsY5/WBHIG1LJg8UinXWzlky+KPXqEI1jczzepmV1YxEKKNqf4dZDW1t6m4LKVFo
Nw+61SHopFEI9qAKMyFs
=6lho
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
