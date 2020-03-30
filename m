From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Date: Mon, 30 Mar 2020 15:15:57 +0200
Message-ID: <20200330131557.GD2431644@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
 <20200330130757.GC2431644@ulmo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40942 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbgC3NQB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 09:16:01 -0400
Content-Disposition: inline
In-Reply-To: <20200330130757.GC2431644@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 03:07:57PM +0200, Thierry Reding wrote:
> On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> > The interaction of the ALL_LED PWM channel with the other channels was
> > not well-defined. As the ALL_LED feature does not seem very useful and
> > it was making the code significantly more complex, simply remove it.
> >=20
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------------------
> >  1 file changed, 17 insertions(+), 98 deletions(-)
>=20
> Applied, thanks.

By the way, shouldn't we add something like this:

--- >8 ---
diff --git a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt b/Do=
cumentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
index f21b55c95738..49fff008af09 100644
--- a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
@@ -5,8 +5,6 @@ Required properties:
   - compatible: "nxp,pca9685-pwm"
   - #pwm-cells: Should be 2. See pwm.yaml in this directory for a descript=
ion of
     the cells format.
-    The index 16 is the ALLCALL channel, that sets all PWM channels at the=
 same
-    time.

 Optional properties:
   - invert (bool): boolean to enable inverted logic
--- >8 ---

To make sure we reflect this in the device tree bindings? It doesn't
seem like anyone uses that channel (in fact, it doesn't seem like any
device trees actually exist in-tree that use one of these chips), so it
should be fine to drop that.

Thierry

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6B8Q0ACgkQ3SOs138+
s6Ea9g//RVwRAmIFdSd4kUfxq4mGgzkkP/iR374s8cs3YnXan9xX+Ft2PAvTEgt2
liI+GQ+TSDIqPcq8wmKr/AZZE8SGoCMTwIdPRMiSoiHchQStGJKcqojBekvYA3+q
VfughzQqqWT1xCgYVdRax8ZJXEhX66DHnHbIc+T8FZy8AA1zwYh7HHcrTJYvmHeC
BbC2UyayeTP6IydIjwLt5M0bWmtDGMz4l80wXkcx4EQLdtkMPBcZ3aIXLFxys+5n
Tr9uDiPx1o1WqWwgasK1nHRRnCYxyh9NHB3Q3q62HoGiSSkgCK8lB+Isttkex++R
dmW8zD/yqEEcaecxaCMh/TxVTYM448ylldMSrlEt6mUY9ApE/OoFI3STqhNzRFCz
0R5y5oNqyYAF0Wln9yMVCbiD9gFuBiSa7jhngWsF+UiWSWH0XjhIhKJCkXDec+WO
yUCqFcczz7ybt4WHU0pckdHO12vxApdE8qjRxkLj3kwTTziUpUtu8to6ll+cyh9Z
//hoh4+NGn8cvZDt1uakZb1zd5++AuG/btQ85EF52wG1JZI1SK9J5Mh/ftj4tIPS
6jLknxNzLhDN1oowvzBVBDTGlTl2CHjKWvQ1de4LEiqLwc6RTrdSb+OwlLhpRxen
449o5YfUaY9mAjjL5URkhuFzD0+/yD0uPTYXkTqfjULR/0N42Mc=
=weCG
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
