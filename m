From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm_bl: Fix overflow condition
Date: Wed, 30 Aug 2017 16:13:09 +0200
Message-ID: <20170830141309.GB1361@ulmo>
References: <20170828200033.40673-1-dbasehore@chromium.org>
 <20170829140534.GA18114@ulmo>
 <CAGAzgsqp+ycY0Oj4OrfT=jq2OG82Efj2oQTuZhnzsZd-ApH8RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGAzgsqp+ycY0Oj4OrfT=jq2OG82Efj2oQTuZhnzsZd-ApH8RQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "dbasehore ." <dbasehore@chromium.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jingoohan1@gmail.com, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2017 at 11:45:43AM -0700, dbasehore . wrote:
> On Tue, Aug 29, 2017 at 7:05 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Mon, Aug 28, 2017 at 01:00:33PM -0700, Derek Basehore wrote:
> >> This fixes and overflow condition that happens with a high value of
> >> brightness-levels-scale by using a 64-bit variable. The issue would
> >> prevent a range of higher brightness levels from being set.
> >>
> >> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> >> ---
> >>  drivers/video/backlight/pwm_bl.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backligh=
t/pwm_bl.c
> >> index 76311ec5e400..e7ffd2108acf 100644
> >> --- a/drivers/video/backlight/pwm_bl.c
> >> +++ b/drivers/video/backlight/pwm_bl.c
> >> @@ -88,14 +88,17 @@ static void pwm_backlight_power_off(struct pwm_bl_=
data *pb)
> >>  static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
> >>  {
> >>       unsigned int lth =3D pb->lth_brightness;
> >> -     int duty_cycle;
> >> +     s64 duty_cycle;
> >>
> >>       if (pb->levels)
> >>               duty_cycle =3D pb->levels[brightness];
> >>       else
> >>               duty_cycle =3D brightness;
> >>
> >> -     return (duty_cycle * (pb->period - lth) / pb->scale) + lth;
> >> +     duty_cycle *=3D pb->period - lth;
> >> +     do_div(duty_cycle, pb->scale);
> >> +
> >> +     return duty_cycle + lth;
> >>  }
> >
> > I don't think your commit message accurately describes the change here.
> > The overflow that you're preventing might happen with a large value of
> > pb->period (or rather, in combination with a large value of duty_cycle)
> > but it's unrelated to pb->scale.
>=20
> I'm referring to the of property brightness-levels-scale.

I don't see a brightness-levels-scale property in either the DT bindings
or the pwm-backlight driver. Do you have any pointers?

Thierry

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmmx/UACgkQ3SOs138+
s6ENsg//WCG4fprFh6jobvOQX96uxzc+gvD9AxNaJVDFAlXuaoVuM33zahuNfhbU
jXERk8YSLQi8qEW/0E1ggt4m112unHzk4lheCwTVO8BnEKkJvd+QwXGn9lIu12xf
aCTtwNPEd8bg9NijY8vlpEz87XTxUlBNqLRnEOtNcg5PeAT8e0VhgPXcWgbz1H0T
xwyJ7aI1nzpr83U+XfCtgbLqoOtp++uKZT9EsI5+Cvl8zeFvGZD4TbfdK9R63KZA
3QM0txJ5kM/fnDysJ1lefCkb5QBiRjgmDqAI5MdrmJTkG3lyttjWE0igYYHFp8Sk
uGNSU0bYQ9PZp3ZEucWg8R4Tt1rSfAD0AevsUIAg6uLVpu4Okw+qLttVZ8RpFzsh
CbwAmwR5UFbNu+Xvj0Zjs+Tp1TEKDvvSG4AE3V2JvsOWnMP/XK/bSNgK0mB6isG6
mjqtz730CFW5RIAi5kmloXLuaH1xHxbdYdk4Ls8pRBMnXPaAK0gOgTa1q/FT6nwO
tucgoSKUQ8Kk1pYD7o7AzHedoJiuKwXH6EUEdK2N+IHESw5BLJUX+15poip/nsaW
O/YEZpxplLqjS3A+RS2U8BW70FKykHK8NR4Gr+QjIl/Zlm9JElNJb9aZB8oA/W5a
UsXrglyR/eGvyvHwDMf5gguefxj60i4KyuoB1jyWf0ctPA7y+hE=
=U5qF
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
