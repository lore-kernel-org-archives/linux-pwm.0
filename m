From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND v5 1/2] PWM: PXA: add device tree support to PWM
 driver
Date: Wed, 4 Dec 2013 10:03:13 +0100
Message-ID: <20131204090312.GK19943@ulmo.nvidia.com>
References: <1379791174-2369-1-git-send-email-mikedunn@newsguy.com>
 <1379791174-2369-2-git-send-email-mikedunn@newsguy.com>
 <20131203101714.GG21178@ulmo.nvidia.com>
 <529E26C9.30707@newsguy.com>
 <529E8193.1040606@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+RZeZVNR8VILNfK"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:52852 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab3LDJEN (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Dec 2013 04:04:13 -0500
Content-Disposition: inline
In-Reply-To: <529E8193.1040606@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Mike Dunn <mikedunn@newsguy.com>, linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>


--x+RZeZVNR8VILNfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2013 at 09:12:51AM +0800, Haojian Zhuang wrote:
>=20
> On 12/04/2013 02:45 AM, Mike Dunn wrote:
> >On 12/03/2013 02:17 AM, Thierry Reding wrote:
> >>On Sat, Sep 21, 2013 at 12:19:33PM -0700, Mike Dunn wrote:
> >>>This patch adds device tree support to the PXA's PWM driver.  Nothing
> >>>needs to be extracted from the device tree node by the PWM device.
> >>>Client devices need only specify the period; the per-chip index is
> >>>implicitly zero because one device node must be present for each PWM
> >>>output in use.  This approach is more convenient due to the wide
> >>>variability in the number of PWM channels present across the various P=
XA
> >>>variants, and is made possible by the fact that the register sets for
> >>>each PWM channel are segregated from each other.  An of_xlate() method
> >>>is added to parse this single-cell node.  The existing ID table is
> >>>reused for the match table data.
> >>>
> >>>Tested on a Palm Treo 680 (both platform data and DT cases).
> >>>
> >>>Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> >>>---
> >>>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 30 +++++++++++++
> >>>  drivers/pwm/pwm-pxa.c                             | 52 +++++++++++++=
+++++++++-
> >>>  2 files changed, 81 insertions(+), 1 deletion(-)
> >>>  create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> >>Hi Mike,
> >>
> >>It looks like this fell through the cracks. Is this patch still the
> >>latest one you have? Should it still be applied?
> >>
> >>Thierry
> >>
> >Hi Thierry,
> >
> >Funny I should hear from you about this today.... I just turned my atten=
tion
> >back to this today and noticed that it never made it into your for-next =
branch.
> >  Yes, it is the latest.  If the patch still applies cleanly, please fee=
l free.
> >Otherwise, I'd be glad to rework it against something more recent.
> >
> >Also, we never got any ACKs for patch 2/2, which just adds the nodes to
> >arch/arm/boot/dts/pxa27x.dtsi
> >Any advice on whom to nudge?
> >
> >Thanks much!
> >Mike
> >
>=20
> It's fine to me.
>=20
> Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>

I think it's customary to take DTS file updates through the architecture
trees, so I think it'd be better if you took patch 2/2. There aren't any
dependencies between both patches either.

Thierry

--x+RZeZVNR8VILNfK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnu/QAAoJEN0jrNd/PrOhn9IP/1OWV0EGPmN7Y5J5maXDyLan
x15mT02TZDY8yztJ4pqbqUDPJTMhdcBxBqRsyEn+CfpyaoYviEbZThBvaHk/d5rY
Xk0sxEipbYK+E29/esV8kpqYLsMzWedwuoKHots7e25b36SKuWbaLRiarLzvl4/I
MnkD0EMjMU8jrr6G8XPPQqi7XqSK6XKYlr0H2BYDDTPNvh/0v6IRlnAXh11DUQOE
nLir2vpVVPJqWMEp+kbMv8Gsl27jL3LKuOxVZilw06mK3pocjyi34UE01NaPPt5H
KHQhtJCw2ZkgJ5bcwHz9dCCl1GHYYnoiwE8COCyFgSNecn/uIZAyggcDA/y3MrQ0
a3E7EDH37BxiW9N3IGWfpwwCcXLbW03uWn4KAa/2FceFKekGNHMIwaiVVMgpzPFr
NDPfLxLg9BTrD7+U4zh0aeR2SiUq9sbsxx9F35R28wSqrqylWuTP1UZqZ4Y+Un7T
+kd/0xtsC5Zv0R/ZxCgDtggWHzNVibxmBH++UF/BpNKeIBmM2NiXyXZ/h06U7XZN
qXZVcdyhRARrrhRzGpEr6qk69Quy6tM/E430fIhxEbmGiCftp+9oJnvm5ufJXrMF
Hiiv6RQUH1WY3plG96Fqb2PmI/p+jwhgWyshCyyM/+qQtwIXYOwE24x0WSYfW6z5
X7qJNq3js76yoDdpoxLX
=pLQN
-----END PGP SIGNATURE-----

--x+RZeZVNR8VILNfK--
