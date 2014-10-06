From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v7 03/11] pwm: add support for atmel-hlcdc-pwm device
Date: Mon, 6 Oct 2014 14:28:57 +0200
Message-ID: <20141006122856.GB26833@ulmo>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-4-git-send-email-boris.brezillon@free-electrons.com>
 <20141006104634.GE25202@ulmo> <20141006135009.6cd980a1@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1718947158=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20141006135009.6cd980a1@bbrezillon>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Mark Yao <mark.yao@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org


--===============1718947158==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2014 at 01:50:09PM +0200, Boris Brezillon wrote:
> On Mon, 6 Oct 2014 12:46:35 +0200 Thierry Reding <thierry.reding@gmail.co=
m> wrote:
> > On Wed, Oct 01, 2014 at 04:53:00PM +0200, Boris Brezillon wrote:
[...]
> > > +	if (pres > ATMEL_HLCDC_PWMPS_MAX)
> > > +		return -EINVAL;
> >=20
> > I think the condition above needs to be "pres =3D=3D ATMEL_HLCDC_PWMPS_=
MAX",
> > otherwise this will never be true.
>=20
> Actually the previous loop is:
>=20
> 	for (pres =3D 0; pres *<=3D* ATMEL_HLCDC_PWMPS_MAX; pres++)
>=20
> thus pres will be equal to ATMEL_HLCDC_PWMPS_MAX + 1 when no
> appropriate prescaler is found.

Indeed so.

> > > +		regmap_update_bits(hlcdc->regmap, ATMEL_HLCDC_CFG(0),
> > > +				   ATMEL_HLCDC_CLKPWMSEL, gencfg);
> > > +	}
> > > +
> > > +	do_div(pwmcval, period_ns);
> > > +	if (pwmcval > 255)
> >=20
> > The PWM core already makes sure that duty_ns <=3D period_ns, so pwmcval
> > could be anywhere between 0 and 256 here. Where does the disconnect come
> > from? Why not make pwmcval =3D duty_ns * 255 if that's the maximum?
>=20
> Here is what the datasheet says:
>=20
> "Due to the comparison mechanism, the output pulse has a width between
> zero and 255 PWM counter cycles. Thus by adding a simple passive filter
> outside the chip, an analog voltage between 0 and (255/256) =C3=97 VDD can
> be obtained (for the positive polarity case, or between (1/256) =C3=97 VDD
> and VDD for the negative polarity case). Other voltage values can be
> obtained by adding active external circuitry."
>=20
> Given this explanation we should divide by 256, but 256/256 is a
> forbidden value, hence I just use the maximum available one (255) when
> I'm asked to configure a duty cycle occupying the whole period.

Okay, perhaps you can summarize the above explanation from the datasheet
in a comment to clarify.

> > > +		pwmcval =3D 255;
> > > +
> > > +	pwmcfg |=3D ATMEL_HLCDC_PWMCVAL(pwmcval);
> > > +
> > > +	regmap_update_bits(hlcdc->regmap, ATMEL_HLCDC_CFG(6),
> > > +			   ATMEL_HLCDC_PWMCVAL_MASK | ATMEL_HLCDC_PWMPS_MASK,
> > > +			   pwmcfg);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int atmel_hlcdc_pwm_set_polarity(struct pwm_chip *c,
> > > +					struct pwm_device *pwm,
> > > +					enum pwm_polarity polarity)
> > > +{
> > > +	struct atmel_hlcdc_pwm_chip *chip =3D
> > > +				pwm_chip_to_atmel_hlcdc_pwm_chip(c);
> > > +	struct atmel_hlcdc *hlcdc =3D chip->hlcdc;
> > > +	u32 cfg =3D 0;
> > > +
> > > +	if (polarity =3D=3D PWM_POLARITY_NORMAL)
> > > +		cfg =3D ATMEL_HLCDC_PWMPOL;
> >=20
> > That's strange. Inverse polarity is the default on this hardware?
>=20
> Quote from the datasheet:
>=20
> "
> =E2=80=A2 PWMPOL: LCD Controller PWM Signal Polarity
> This bit defines the polarity of the PWM output signal. If set to one,
> the output pulses are high level (the output will be high when- ever
> the value in the counter is less than the value CVAL) If set to zero,
> the output pulses are low level.
> "
>=20
> My understanding is that ATMEL_HLCDC_PWMPOL should be set when using
> normal polarity (and my tests confirm that it works as expected ;-)).

Yes, sounds good then.

Thierry

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUMosIAAoJEN0jrNd/PrOhipMQALRQNSCSyeBPiLC0t4MxuVqd
QCZFte0SHv0+ubzwx9NgF4VIG/3TmMB5zfqITh+38j/mIzaP/iLrEG6A++nwLUja
qfEGWmHpQJWYLZV/XTkhpFY2R7xiyVtKEJ5X2/ijneBnqPvRgTYH7dixBpgnk0iy
aHTXAFwKTxvSpz+hgk2HfQU+XKy92qwYJAdwq/xpoM1K4D0D4Q+mJqzzrhyMpk3u
8j7aLNfnRlM7vDclxRPuIWqczcIpRsxFlBMMNPtB2X1heoAE+yHhysMHrgYDAaLq
QLjKdWDpC3EOms9s5he6j0r0Yhr7lmG0W+qUPeurs5F1I1TyApBl9hVGZFDBrMkm
mkG/bambm3JVoQCFZ8gQ4dbPxUepvSTDpq94pELNkX5BAsaYJE7Qsl2nUXf3sSrF
dVKYDEOIYMHBumDCG0NjqC7pRYvB2XAD0KwcaSsaGOMZrGmR7rG+ataA+7zkASmN
vuRmP8IMq2Gw//Ty+tFeIiTlDylEqX6LpwliAoGJxSFZ0FJloVK1ObuXJ+9DoqkH
JCh5MP8UkbiYE/aa0Q/u/ce900YUHN5UPOh/gaENFsbZPmnC+Qcwtv5BQqfGCQOQ
eOVLFH+eFVXN2eu69sGETaVPu0M63DJrWeP7ilM8v+rKz337bLHVPrOH5WMdpjGz
xnwlNW8O+FZBWlYYSpL4
=fOLP
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--

--===============1718947158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1718947158==--
