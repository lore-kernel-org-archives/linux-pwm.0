From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] pwm: Add different PWM output types support
Date: Tue, 24 Sep 2019 12:46:56 +0200
Message-ID: <20190924104656.GB14924@ulmo>
References: <1568415464-20267-1-git-send-email-gurus@codeaurora.org>
 <20190916140146.GC7488@ulmo>
 <20190924054343.GA12462@codeaurora.org>
 <20190924063926.vb3cxcdybv33owpg@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190924063926.vb3cxcdybv33owpg@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org, kernel-team@android.com, Mark Salyzyn <salyzyn@google.com>, Sandeep Patil <sspatil@google.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Fenglin Wu <fenglinw@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2019 at 08:39:26AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Sep 23, 2019 at 10:43:43PM -0700, Guru Das Srinagesh wrote:
> > On Mon, Sep 16, 2019 at 04:01:46PM +0200, Thierry Reding wrote:
> > > On Fri, Sep 13, 2019 at 03:57:43PM -0700, Guru Das Srinagesh wrote:
> > > > From: Fenglin Wu <fenglinw@codeaurora.org>
> > > >=20
> > > > Normally, PWM channel has fixed output until software request to ch=
ange
> > > > its settings. There are some PWM devices which their outputs could =
be
> > > > changed autonomously according to a predefined pattern programmed in
> > > > hardware. Add pwm_output_type enum type to identify these two diffe=
rent
> > > > PWM types and add relevant helper functions to set and get PWM outp=
ut
> > > > types and pattern.
> > > >=20
> > > > Change-Id: Ia1f914a45ab4f4dd7be037a395eeb89d0e65a80e
> > > > Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
> > > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > > ---
> > > >  drivers/pwm/core.c  | 26 ++++++++++++++++++++
> > > >  drivers/pwm/sysfs.c | 50 ++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/pwm.h | 70 +++++++++++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  3 files changed, 146 insertions(+)
> > >=20
> > > This doesn't seem right to me. Are you describing a PWM pin that's
> > > actually driven in GPIO mode? We usually configure that using pinctrl.
> > >=20
> > > Thierry
> >=20
> > Sorry, let me clarify.
> >=20
> > Some Qualcomm PMICs have a PWM block called the Light Pulse Generator (=
LPG).
> > This block allows for the generation of a HW-controlled PWM "pattern", =
i.e. a
> > sequential altering of duty cycle, in addition to the normal PWM "fixed=
" duty
> > cycle operation, which is what the framework does currently. This patte=
rn is
> > user-configurable in the form of a look-up table in the devicetree. The=
 LPG's
> > registers have to be configured with the data in the look up table in o=
rder to
> > start the generation of the pattern. An example of a pattern is the "br=
eath"
> > pattern, which simply ramps up the duty cycle and then ramps it down.
>=20
> I'll try to describe it in my words to check if I got it right: So the
> mode you want to add needs a sequence of PWM states and the hardware is
> expected to apply them in turn, each for a configurable count of
> periods. If I understand this right, this is expected to be cyclic?
>=20
> > This "pattern" mode is what has been defined as PWM_OUTPUT_MODULATED in=
 this
> > patch. I see that the use of the term "modulated" is misleading - a more
> > accurate term would be PWM_OUTPUT_PATTERN perhaps.
>=20
> Not sure "pattern" is better.=20
>=20
> The PWM on the newer imx SoCs (using the imx27 driver) has a FIFO with
> length 4 that allows to program changing settings. Only the duty cycle
> can be modified and as repeat count only 1, 2, 4 and 8 are available. I
> assume the FIFO can be fed by the dma engine.
>=20
> Note I only know this feature from reading the reference manual and
> never used it.
>=20
> > This patch merely adds framework support to differentiate between the "=
fixed"
> > and "pattern" modes of operation. Actions such as configuring the LPG w=
ith the
> > devicetree pattern and setting it up for generating the pattern are per=
formed
> > in the driver only if the output type is read as "pattern" and not othe=
rwise.
>=20
> Up to now I'm not convinced that this extension is a good one that can
> be supported by several PWM implementations. I'd say we should collect
> first some details about different implementations and what these could
> implement to get a picture what kind of API is sensible.

I agree. This sounds to me like it's stretching the concept of a PWM a
bit too much. Sounds like drivers/leds might be a better fit for this.

Thierry

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2J9CAACgkQ3SOs138+
s6Eh7Q//eMQTkC4yXaBF5mVe51/8l9HRI0/2vJ00dstKKWzwoLDJgd0CQCXDZSud
VheKDqwj9StT/oSNe8FOxWlzi7/MCLCu3hODKRjR/+zUmnqAWxUnwOPLSHInoUyt
eRsaNSpI7NE0hFQ3n2w25lsTI2jM33NP0wuYvgkTfK/baJy63zvX99bPce7YE1r7
YFUrCJwj9bstTOdCSVUQK8ECMXOirLLHtiZ9qTpWmxOEDxXtf18SxwR7mts8P3ns
yQ3FBgALUMF6dg8d7p5rRBBlDTsXyIEhCVInO7NYPoEEgBuosUeHVYpnvgerBqOw
wUu2ndpYoyuDEVQA1qIz9S05oa3oMLQGIDz4KULo13gq02Gpw5HWTF0x031pJKVV
8SJE7HZUaiBWaXdzj1r3+WoRl8gXFWiVyzhEh0VWfstgoERHoDZ+onREnJ5d+eHZ
Oje8vPOCvFwKubhrHXm1ZJydBW41HBu9YjVzfjtV+0tpD8O5HlVrsUH68fCwxcv3
rBE40TO7gXPr3FYeYC45d0fQ7xOw/5TMzqgcvFcRZjZ/FxLPBex+2Lqj2bun1kUJ
54N4bTjVNxQh2gLLeeXvCzdYX7aKdMO7PdN/BHEgYdW14jA4CBICQLwk5Bi+ID3M
Nfa2Uc4AeALaM13d2txvpj4lyFR6sqbLW/gl32v2x2zHVY8BmMY=
=mQA+
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
