From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 2/5] pwm: kona: Introduce Kona PWM controller support
Date: Thu, 20 Mar 2014 15:48:38 +0100
Message-ID: <20140320144833.GA25092@ulmo>
References: <1394655346-30048-1-git-send-email-tim.kryger@linaro.org>
 <1394655346-30048-3-git-send-email-tim.kryger@linaro.org>
 <20140318215231.GH5917@mithrandir>
 <CAAYSxhri0evgrbCPew6-MTXVmpzm7Oa6TpmJTSGZpTcV=876HQ@mail.gmail.com>
 <CAAYSxhpW-N7UdpsGE7JHvOJxQcvURRPdAOhiVkK=4EHc7E03gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAYSxhpW-N7UdpsGE7JHvOJxQcvURRPdAOhiVkK=4EHc7E03gQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: Matt Porter <mporter@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Christian Daudt <bcm@fixthebug.org>, Grant Likely <grant.likely@linaro.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, Linux Doc List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Broadcom Kernel Feedback List <bcm-kernel-feedback-list@broadcom.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2014 at 06:06:03PM -0700, Tim Kryger wrote:
> On Tue, Mar 18, 2014 at 4:47 PM, Tim Kryger <tim.kryger@linaro.org> wrote:
> > On Tue, Mar 18, 2014 at 2:52 PM, Thierry Reding <thierry.reding@gmail.c=
om> wrote:
> >> On Wed, Mar 12, 2014 at 01:15:43PM -0700, Tim Kryger wrote:
[...]
> >>> +static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_=
device *pwm,
> >>> +                               enum pwm_polarity polarity)
> >>> +{
> >>> +     /*
> >>> +      * The framework only allows the polarity to be changed when a =
PWM is
> >>> +      * disabled so no immediate action is required here.  When a ch=
annel is
> >>> +      * enabled, the polarity gets handled as part of the re-config =
step.
> >>> +      */
> >>> +
> >>> +     return 0;
> >>> +}
> >>
> >> See above. If you don't want to implement the hardware support for
> >> inversed polarity, then simply don't implement this.
> >
> > I had originally planned to omit polarity support but because it
> > affects the binding (which is treated as ABI), it wouldn't be possible
> > to add it in later without defining a new compatible string.
>=20
> I would like to get this right but it occurred to me that there may be
> a way to defer the implementation of this feature without disrupting
> the binding.
>=20
> Would it be acceptable to continue using #pwm-cells =3D <3> and
> of_pwm_xlate_with_flags but return -EINVAL from kona_pwmc_set_polarity
> if PWM_POLARITY_INVERSED is specified?

This was recently discussed for the pwm-imx driver. And you can easily
support #pwm-cells =3D <2> and #pwm-cells =3D <3> with the same binding. So
you could start with #pwm-cells =3D <2>, leaving out .set_polarity() and
implement it later on, extending the binding in a backwards-compatible
way to support the polarity flag.

Thierry

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKv/BAAoJEN0jrNd/PrOh2vIP+gJbx4xyYb81pWcYDtkeGDnJ
UBWg9M3obFI/gdndUQr2LWe9i19sn/W4FCwOwobLI1IOpE1okMvohlggnF/utzE7
qyPoaHc3W/dV4pAzOxNDbStRA4gEoSnTS4jHHf7a8WgCbau0ywXRDWzpYNt7ZbAo
XTyN3yQBvdj1uOdvGI+DdI1cegAPNF2kWacY5yS40eFw+rkE1HpHOBshAc7M8Xki
MK3RUSrGLGzO6QWdoVzov0QX9YxmiScCwJFxyVGbjCu+Pf0ybfPwiKjgrx7/a1eP
O0Q2N+zY4wU5Lo11pzvihzeNwa9wxYto/4GQdUBpyE5hHpTPZBMLi4jCZDiVM0AZ
vJmt16nWEuVtcEbNptLph4kyQHMldvwiMVxki+y5IupcQRW2YNHY93Ejqeu5t5Io
ia7n6x5izERMTgjVV6rDSDy+YhD1wXI7BYvBkc84Ei6owNseJ9mT5k+CfPmajn6m
+WXiDbXKZeLITjD9kDZuHFqImq6J1xDTcPs8NOu0yfFd8qKgPFpU7EZRD7qBUwwG
CEvf17UHmjnSckGNI5wakuR01hNuytv37/h1kkzYDiK/THv0WO8FQ9G6t3PJ+UVY
evmCApac44yeyEfhtWUPlV3iMh2ydGNoCoMIlYFwlK6/eHqwGnoYscfou/NLZgPj
xZ8BBMXxwb4Qos2daB0U
=FtTx
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
