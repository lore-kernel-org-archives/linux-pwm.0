From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND v5 1/2] PWM: PXA: add device tree support to PWM
 driver
Date: Wed, 4 Dec 2013 10:21:54 +0100
Message-ID: <20131204092152.GL19943@ulmo.nvidia.com>
References: <1379791174-2369-1-git-send-email-mikedunn@newsguy.com>
 <1379791174-2369-2-git-send-email-mikedunn@newsguy.com>
 <20131203101714.GG21178@ulmo.nvidia.com>
 <529E26C9.30707@newsguy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9/GiYV45wF7IL3Iq"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:50889 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab3LDJWx (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Dec 2013 04:22:53 -0500
Content-Disposition: inline
In-Reply-To: <529E26C9.30707@newsguy.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mike Dunn <mikedunn@newsguy.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>


--9/GiYV45wF7IL3Iq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2013 at 10:45:29AM -0800, Mike Dunn wrote:
> On 12/03/2013 02:17 AM, Thierry Reding wrote:
> > On Sat, Sep 21, 2013 at 12:19:33PM -0700, Mike Dunn wrote:
> >> This patch adds device tree support to the PXA's PWM driver.  Nothing
> >> needs to be extracted from the device tree node by the PWM device.
> >> Client devices need only specify the period; the per-chip index is
> >> implicitly zero because one device node must be present for each PWM
> >> output in use.  This approach is more convenient due to the wide
> >> variability in the number of PWM channels present across the various P=
XA
> >> variants, and is made possible by the fact that the register sets for
> >> each PWM channel are segregated from each other.  An of_xlate() method
> >> is added to parse this single-cell node.  The existing ID table is
> >> reused for the match table data.
> >>
> >> Tested on a Palm Treo 680 (both platform data and DT cases).
> >>
> >> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> >> ---
> >>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 30 +++++++++++++
> >>  drivers/pwm/pwm-pxa.c                             | 52 ++++++++++++++=
++++++++-
> >>  2 files changed, 81 insertions(+), 1 deletion(-)
> >>  create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> >=20
> > Hi Mike,
> >=20
> > It looks like this fell through the cracks. Is this patch still the
> > latest one you have? Should it still be applied?
> >=20
> > Thierry
> >=20
>=20
> Hi Thierry,
>=20
> Funny I should hear from you about this today.... I just turned my attent=
ion
> back to this today and noticed that it never made it into your for-next b=
ranch.
>  Yes, it is the latest.  If the patch still applies cleanly, please feel =
free.
> Otherwise, I'd be glad to rework it against something more recent.

I've applied it to my for-next branch (with some minor whitespace fixups
and some tuning to how the OF match table is defined). I don't consider
any of the changes risky, but it'd be great if you could still test the
version that I pushed.

Thierry

--9/GiYV45wF7IL3Iq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnvQwAAoJEN0jrNd/PrOh1C4P/iWyIL0R/aFwwKsVPO5+X+7z
V2MNOwLaq99/3HEYo6GrUj8tJPJXQkthc1kkGeSYsgDrDB7lxKUENhJtlC69+6wW
0oWSRndY88FeNLakkdqHjjjUqKO56sksNARhjmX8beTUb/G3FYyc7zjvh7szrime
/OMaIaGq2DqfhLTJv0F8i1UGQvGLO0lAtBa73Er2aQvljblo8MY/GvyjCgwWH1+4
juBc5nrX9tUuODN1hJCjZmH8FezNy5PExK0JKyCQIrqEgi2gUf5GFS7RJ1R0kP7+
IhxBt8scV/uBCpkD49pyKvAGXcWYIWsLVwKqKgVHQRltxnSOnymNV721j/JYa0sL
aRSRu1jSOgOfXcbq6VmAtM+/KjpDhEnUj8VRaIIwf7n8TAyegeN5x45Bds01sK9R
Vie2/7gyNnqBQJVBC/fEWZA/Z6ZHCkBW97y1WK/pHsNzpb0mn1jgW5gxYi9rrRdY
5nOMiSMjTQ5VOxArinyPJ5lGUfBf0QwseejDpWNShuzQQRE9CKPaNc0LQDP37CUR
Hg11Ua+ZPobAsVVFPtKB/e79McfMy9OGi7A6+ddiQWe8U0rSx9pFRHaBLGcLLlF6
rGEyIqeXI/U/0hpEWC/MTcYZIfj5ltzZmBmzIoUCeW3r7Wb3+CxIYLGeB5MNNRXE
7xDsNHvy7awGDf0Ot3Sl
=KIVu
-----END PGP SIGNATURE-----

--9/GiYV45wF7IL3Iq--
