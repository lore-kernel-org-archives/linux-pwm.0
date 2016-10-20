From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a
 GPIO
Date: Thu, 20 Oct 2016 12:45:41 +0200
Message-ID: <20161020104541.GA25598@ulmo.ba.sec>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
 <20161019185638.GP1722@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36416 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756682AbcJTKpq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Oct 2016 06:45:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id r16so5242567pfg.3
        for <linux-pwm@vger.kernel.org>; Thu, 20 Oct 2016 03:45:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161019185638.GP1722@lahna.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2016 at 09:56:38PM +0300, Mika Westerberg wrote:
> On Tue, Sep 20, 2016 at 05:40:56PM +0300, Mika Westerberg wrote:
> > The PCA9685 controller has full on/off bit for each PWM channel. Setting
> > this bit bypasses the PWM control and the line works just as it would b=
e a
> > GPIO. Furthermore in Intel Galileo it is actually used as GPIO output f=
or
> > discreet muxes on the board.
> >=20
> > This patch adds GPIO output only support for the driver so that we can
> > control the muxes on Galileo using standard GPIO interfaces available in
> > the kernel. GPIO and PWM functionality is exclusive so only one can be
> > active at a time on a single PWM channel.
> >=20
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20
> Thierry,
>=20
> Any comments on this?

It seems to me like maybe pinmux would be a better framework to handle
this kind of use case. The full on/off bit sounds like it's a mux that
selects between GPIO and PWM functionality.

Have you thought about supporting pinmux for this?

Thierry

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYCKBRAAoJEN0jrNd/PrOhZS0P/RPIVFzVz+QbrLyGTk5yRISZ
nWjA2awSLfS1Ofk9HFyOZbtKkIStdwiU7cDaDd2O3E2+dGemDYgEjXs1IFIhu7IX
5FKK9MLmByOHlkGilEtXDhXEorqnwqeutZnnYQjkWg82UNvLfJ20pIIU+sZ6FesS
xBgriZREvnzysEn9WkAocl01hpb7vylH5UAMhKZUQoQwFyQh1gS+ow2Es4O3t30H
+JcTkN2TceqTgaTT/ZPwJtGH0j/5loHu25RbDv3QDYHSSy3yfP6jnYl1qSxmRU8W
39AbGIV943oPnnjr9XfuzXCBgUMnJGEf+dKUM+1E/yabj7qqo/rWGxBLMll2qWY9
fe38mEA+Q/6MYj6Vabi9UlW6nycG6eH7fHkg38yEE+U+p5HNHKgwEt8MQpQOVmm4
3rkrLmhUKp0/qAPkv81z9wb44UO/0QPbPgHqIGCwONi4imJCsGwLX35eblihz3ee
GnyrLiRolfot0QB7ZMXGkXjiitF/SZYNzOAd1uagsd694lix8o6WY7GdFzGVrgf8
sXmLK56yn9RC/hbwndU155ardRqVKK9+GoHIm+wi+Hbmboo53UdLm3G4C1e3mNhu
pfNpnBTE8y76/snvaQV2EDiqiCg2WUg7H0iQVHAlg+a/d4bwFJ88Bdg4SgVlOYg6
mZS8DOLVC/FpBUDaSNMQ
=nu29
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
